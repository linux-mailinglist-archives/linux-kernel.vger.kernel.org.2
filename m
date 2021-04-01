Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2917D351EF8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240859AbhDASvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:51:48 -0400
Received: from mga17.intel.com ([192.55.52.151]:21439 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239256AbhDASfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:35:39 -0400
IronPort-SDR: Gf3Fn9b7pipnaxsjEv1Ah6uRe5TX1AYqGmxCFhydoJPIm0CPoesTCtBGWFLX9ZnaE8WDfHCCla
 zW6XbFAC9cng==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="172299659"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="172299659"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 08:33:22 -0700
IronPort-SDR: EBPvS0zSWy2R1Xo9zIwtnmV8WneC4HY6sYw3cj6KTRVy6BNNiiIrGT6wSo3+56dBjtCXBklc7h
 zYcD1f4Y9sLg==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="419247613"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 08:33:22 -0700
Date:   Thu, 1 Apr 2021 08:33:20 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Aili Yao <yaoaili@kingsoft.com>
Cc:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        sunhao2@kingsoft.com
Subject: Re: [PATCH v3] mm,hwpoison: return -EHWPOISON when page already
 poisoned
Message-ID: <20210401153320.GA426964@agluck-desk2.amr.corp.intel.com>
References: <20210305093656.6c262b19@alex-virtual-machine>
 <20210305221143.GA220893@agluck-desk2.amr.corp.intel.com>
 <20210308064558.GA3617@hori.linux.bs1.fc.nec.co.jp>
 <3690ece2101d428fb9067fcd2a423ff8@intel.com>
 <20210308223839.GA21886@hori.linux.bs1.fc.nec.co.jp>
 <20210308225504.GA233893@agluck-desk2.amr.corp.intel.com>
 <20210309100421.3d09b6b1@alex-virtual-machine>
 <20210309060440.GA29668@hori.linux.bs1.fc.nec.co.jp>
 <20210309143534.6c1a8ec5@alex-virtual-machine>
 <20210331192540.2141052f@alex-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331192540.2141052f@alex-virtual-machine>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 07:25:40PM +0800, Aili Yao wrote:
> When the page is already poisoned, another memory_failure() call in the
> same page now return 0, meaning OK. For nested memory mce handling, this
> behavior may lead to one mce looping, Example:
> 
> 1.When LCME is enabled, and there are two processes A && B running on
> different core X && Y separately, which will access one same page, then
> the page corrupted when process A access it, a MCE will be rasied to
> core X and the error process is just underway.
> 
> 2.Then B access the page and trigger another MCE to core Y, it will also
> do error process, it will see TestSetPageHWPoison be true, and 0 is
> returned.
> 
> 3.The kill_me_maybe will check the return:
> 
> 1244 static void kill_me_maybe(struct callback_head *cb)
> 1245 {
> 
> 1254         if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags) &&
> 1255             !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
> 1256                 set_mce_nospec(p->mce_addr >> PAGE_SHIFT,
> p->mce_whole_page);
> 1257                 sync_core();
> 1258                 return;
> 1259         }
> 
> 1267 }

With your change memory_failure() will return -EHWPOISON for the
second task that consumes poison ... so that "if" statement won't
be true and so we fall into the following code:

1273         if (p->mce_vaddr != (void __user *)-1l) {
1274                 force_sig_mceerr(BUS_MCEERR_AR, p->mce_vaddr, PAGE_SHIFT);
1275         } else {
1276                 pr_err("Memory error not recovered");
1277                 kill_me_now(cb);
1278         }

If this was a copy_from_user() machine check, p->mce_vaddr is set and
the task gets a BUS_MCEERR_AR SIGBUS, otherwise we print that

	"Memory error not recovered"

message and send a generic SIGBUS.  I don't think either of those options
is right.

Combined with my "mutex" patch (to get rid of races where 2nd process returns
early, but first process is still looking for mappings to unmap and tasks
to signal) this patch moves forward a bit. But I think it needs an
additional change here in kill_me_maybe() to just "return" if there is a
EHWPOISON return from memory_failure()

-Tony
