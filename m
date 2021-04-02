Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D602352508
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 03:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbhDBBS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 21:18:26 -0400
Received: from mail.kingsoft.com ([114.255.44.146]:52018 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231179AbhDBBSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 21:18:25 -0400
X-AuditID: 0a580157-2cfff7000006b36a-d1-606670dd680d
Received: from mail.kingsoft.com (localhost [10.88.1.79])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id 6E.F5.45930.DD076606; Fri,  2 Apr 2021 09:18:21 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL4.kingsoft.cn
 (10.88.1.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 2 Apr 2021
 09:18:21 +0800
Date:   Fri, 2 Apr 2021 09:18:20 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     "HORIGUCHI =?UTF-8?B?TkFPWUE=?=(=?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=)" 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        <sunhao2@kingsoft.com>, <yaoaili@kingsoft.com>
Subject: Re: [PATCH v3] mm,hwpoison: return -EHWPOISON when page already
 poisoned
Message-ID: <20210402091820.04d7c3e0@alex-virtual-machine>
In-Reply-To: <20210401153320.GA426964@agluck-desk2.amr.corp.intel.com>
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
        <20210401153320.GA426964@agluck-desk2.amr.corp.intel.com>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL4.kingsoft.cn
 (10.88.1.79)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsXCFcHor3u3IC3B4NtcaYs569ewWXxd/4vZ
        4vKuOWwW99b8Z7W42HiA0eLMtCKLNxfusTiweyze85LJY9OnSeweJ2b8ZvF4cXUji8f7fVfZ
        PDafrvb4vEkugD2KyyYlNSezLLVI3y6BK+PbtbMsBRuFKx49eMPewLiSr4uRk0NCwESi/UM7
        excjF4eQwHQmiautz1ggnJeMEvsPNTGDVLEIqEgc/rSfHcRmE1CV2HVvFiuILSKgJnFp8QNm
        kAZmgb3MEv8b7wIVcXAICwRLrJ6vD1LDK2AlcX/RZrB6TgE3iZNvHkAtuMIisbLzEhNIgl9A
        TKL3yn8miJPsJdq2LGKEaBaUODnzCQuIzSygI3Fi1TFmCFteYvvbOWC2kICixOElv9ghepUk
        jnTPYIOwYyWaDtxim8AoPAvJqFlIRs1CMmoBI/MqRpbi3HTDTYyQ+AjfwTiv6aPeIUYmDsZD
        jBIczEoivDe2pCYI8aYkVlalFuXHF5XmpBYfYpTmYFES581sAUoJpCeWpGanphakFsFkmTg4
        pRqYtB6ZpFU+uL9aoaY1z2zTM5mVi/dLLGV4W5xausjEjZNhBnPBpfvpu7kWdx5Vd0/iqbZS
        SxJKbSpPv8u19mtER8Vp1v5fcc/51j49d+q81bINlxfFuHgnCy/dcueEmY+cZ9s1s1dBZgV9
        nooXInL+7nx1NmCFprd44Ib/hotWTnJSeBbOaNP8anrh73k+269s1uM+LBDQt0xqb8L7s5fC
        NaT4gwKuna1hMw4Qu3BDdda7N8s4eeY6hHw9nugsOJtjxZWNqtot36csX/Nyu92+xXd/aL13
        2Swn47pc2cB8hVzo/Nq6g78O3Li82KiuRNGM6YhK+HHWdwtOJyW/mzWNkY/ndMf5nefO3nx4
        81iPuRJLcUaioRZzUXEiADeXvd/+AgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2021 08:33:20 -0700
"Luck, Tony" <tony.luck@intel.com> wrote:

> On Wed, Mar 31, 2021 at 07:25:40PM +0800, Aili Yao wrote:
> > When the page is already poisoned, another memory_failure() call in the
> > same page now return 0, meaning OK. For nested memory mce handling, this
> > behavior may lead to one mce looping, Example:
> > 
> > 1.When LCME is enabled, and there are two processes A && B running on
> > different core X && Y separately, which will access one same page, then
> > the page corrupted when process A access it, a MCE will be rasied to
> > core X and the error process is just underway.
> > 
> > 2.Then B access the page and trigger another MCE to core Y, it will also
> > do error process, it will see TestSetPageHWPoison be true, and 0 is
> > returned.
> > 
> > 3.The kill_me_maybe will check the return:
> > 
> > 1244 static void kill_me_maybe(struct callback_head *cb)
> > 1245 {
> > 
> > 1254         if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags) &&
> > 1255             !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
> > 1256                 set_mce_nospec(p->mce_addr >> PAGE_SHIFT,
> > p->mce_whole_page);
> > 1257                 sync_core();
> > 1258                 return;
> > 1259         }
> > 
> > 1267 }
> 
> With your change memory_failure() will return -EHWPOISON for the
> second task that consumes poison ... so that "if" statement won't
> be true and so we fall into the following code:
> 
> 1273         if (p->mce_vaddr != (void __user *)-1l) {
> 1274                 force_sig_mceerr(BUS_MCEERR_AR, p->mce_vaddr, PAGE_SHIFT);
> 1275         } else {
> 1276                 pr_err("Memory error not recovered");
> 1277                 kill_me_now(cb);
> 1278         }
> 
> If this was a copy_from_user() machine check, p->mce_vaddr is set and
> the task gets a BUS_MCEERR_AR SIGBUS, otherwise we print that
> 
> 	"Memory error not recovered"
> 
> message and send a generic SIGBUS.  I don't think either of those options
> is right.
> 
> Combined with my "mutex" patch (to get rid of races where 2nd process returns
> early, but first process is still looking for mappings to unmap and tasks
> to signal) this patch moves forward a bit. But I think it needs an
> additional change here in kill_me_maybe() to just "return" if there is a
> EHWPOISON return from memory_failure()
> 
Got this, Thanks for your reply!
I will dig into this!

-- 
Thanks!
Aili Yao
