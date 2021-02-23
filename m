Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD13322EFC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 17:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbhBWQnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 11:43:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:24406 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232166AbhBWQnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 11:43:42 -0500
IronPort-SDR: kZYLmZszEFwK+TDzMwcU3586NpQGdlov4isstL5yJo/5HCZp/Oo3s/NXeN058Dtb/ZlvNOROh2
 NLo/jcoFyTeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9904"; a="164713401"
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="164713401"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 08:43:00 -0800
IronPort-SDR: LxxGQSXmOxBMVzabOGayCwNZzUooN3yUDHOZITiY+35PA9YN96upVylt9k/b/6RHe9ImCsDbjw
 pyIbzKxZHg6Q==
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="364569260"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 08:43:00 -0800
Date:   Tue, 23 Feb 2021 08:42:59 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Aili Yao <yaoaili@kingsoft.com>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        yangfeng1@kingsoft.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86/fault: Send a SIGBUS to user process always for
 hwpoison page access.
Message-ID: <20210223164259.GA166727@agluck-desk2.amr.corp.intel.com>
References: <20210223204436.1df73153@alex-virtual-machine>
 <788DFBA0-903F-4548-9C2F-B1A1543EE770@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <788DFBA0-903F-4548-9C2F-B1A1543EE770@amacapital.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 07:33:46AM -0800, Andy Lutomirski wrote:
> 
> > On Feb 23, 2021, at 4:44 AM, Aili Yao <yaoaili@kingsoft.com> wrote:
> > 
> > ﻿On Fri, 5 Feb 2021 17:01:35 +0800
> > Aili Yao <yaoaili@kingsoft.com> wrote:
> > 
> >> When one page is already hwpoisoned by MCE AO action, processes may not
> >> be killed, processes mapping this page may make a syscall include this
> >> page and result to trigger a VM_FAULT_HWPOISON fault, as it's in kernel
> >> mode it may be fixed by fixup_exception, current code will just return
> >> error code to user code.
> >> 
> >> This is not sufficient, we should send a SIGBUS to the process and log
> >> the info to console, as we can't trust the process will handle the error
> >> correctly.
> >> 
> >> Suggested-by: Feng Yang <yangfeng1@kingsoft.com>
> >> Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
> >> ---
> >> arch/x86/mm/fault.c | 62 +++++++++++++++++++++++++++++----------------
> >> 1 file changed, 40 insertions(+), 22 deletions(-)
> >> 
> > Hi luto;
> >  Is there any feedback?
> 
> At the very least, this needs a clear explanation of why your proposed behavior is better than the existing behavior.

The explanation is buried in that "can't trust the process" line.

E.g. user space isn't good about checking for failed write(2) syscalls.
So if the poison was in a user buffer passed to write(fd, buffer, count)
sending a SIGBUS would be the action if they read the poison directly,
so it seems reasonable to send the same signal if the kernel read their
poison for them.

It would avoid users that didn't check the return value merrily proceeding
as if everything was ok.

-Tony
