Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA547325552
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 19:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhBYSQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 13:16:28 -0500
Received: from mga03.intel.com ([134.134.136.65]:47032 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231815AbhBYSQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 13:16:25 -0500
IronPort-SDR: vaR2MD5tRjobEOYmr+SWMjpx3gihEQ9Dpi+7NXqOBSiM4rEN0vLYI8xPivZLkakNQkNXMuzhmh
 H8dEdcCUBjYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9906"; a="185680038"
X-IronPort-AV: E=Sophos;i="5.81,206,1610438400"; 
   d="scan'208";a="185680038"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 10:15:44 -0800
IronPort-SDR: GJe7yVhlPe7FBTSgrG9tXgXSbINNu74eYEPcTT8wV+r69AQaNF+dCezhDsRSQ7c8GZIcNlWQg8
 D7/I0Jgm847A==
X-IronPort-AV: E=Sophos;i="5.81,206,1610438400"; 
   d="scan'208";a="404492041"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 10:15:43 -0800
Date:   Thu, 25 Feb 2021 10:15:42 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Aili Yao <yaoaili@kingsoft.com>,
        "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "inux-edac@vger.kernel.org" <inux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>
Subject: Re: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Message-ID: <20210225181542.GA178925@agluck-desk2.amr.corp.intel.com>
References: <20210224151619.67c29731@alex-virtual-machine>
 <20210224103105.GA16368@linux>
 <20210225114329.4e1a41c6@alex-virtual-machine>
 <20210225112818.GA10141@hori.linux.bs1.fc.nec.co.jp>
 <20210225113930.GA7227@localhost.localdomain>
 <20210225123806.GA15006@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210225123806.GA15006@hori.linux.bs1.fc.nec.co.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 12:38:06PM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
> Thank you for shedding light on this, this race looks worrisome to me.
> We call try_to_unmap() inside memory_failure(), where we find affected
> ptes by page_vma_mapped_walk() and convert into hwpoison entires in
> try_to_unmap_one().  So there seems two racy cases:
> 
>   1)
>      CPU 0                          CPU 1
>      page_vma_mapped_walk
>                                     clear _PAGE_PRESENT bit
>        // skipped the entry
> 
>   2)
>      CPU 0                          CPU 1
>      page_vma_mapped_walk
>        try_to_unmap_one
>                                     clear _PAGE_PRESENT bit
>          convert the entry
>          set_pte_at
> 
> In case 1, the affected processes get signals on later access,
> so although the info in SIGBUS could be different, that's OK.
> And we have no impact in case 2.

I've been debugging a similar issue for a few days and finally
got enough traces to partially understand what happened.

The test case is a multi-threaded pointer chasing micro-benchmark
running on all logical CPUs. We then inject poison into the address
space of the process.

All works fine if one thread consumes poison and completes all
Linux machine check processing before any other threads read the
poison. The page is unmapped, a SIGBUS is sent (which kills all
threads).

But in the problem case I see:

CPU1 reads poison, takes a machine check. Gets to the
kill_me_maybe() task work, which calls memory_failure()
this CPU sets the page poison flag, but is still executing the
rest of the flow to hunt down tasks/mappings to invalidate pages
and send SIGBUS if required.

CPU2 reads the poison. When it gets to memory_failure()
there's an early return because the poison flag is already
set. So in current code it returns and takes the machine
check again.

CPU3 reads the poison and starts along same path that CPU2
did.

Meanwhile CPU1 gets far enough along in memory failure and hits
a problem. It prints:

[ 1867.409837] Memory failure: 0x42a9ff6: reserved kernel page still referenced by 1 users
[ 1867.409850] Memory failure: 0x42a9ff6: recovery action for reserved kernel page: Failed

and doesn't complete unmapping the page that CPU2 and CPU3 are touching.

Other CPUs gradually reach the poison and join in the fun of repeatedly
taking machine checks.

I have not yet tracked why this user access is reporting as a "reserved kernel page".
Some traces showed that futex(2) syscall was in use from this benchmark,
so maybe the kernel locked a user page that was a contended futex???


Idea for what we should do next ... Now that x86 is calling memory_failure()
from user context ... maybe parallel calls for the same page should
be blocked until the first caller completes so we can:
a) know that pages are unmapped (if that happens)
b) all get the same success/fail status

-Tony
