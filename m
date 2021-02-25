Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333FA324990
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 04:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbhBYDoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 22:44:20 -0500
Received: from mail.kingsoft.com ([114.255.44.146]:45394 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229466AbhBYDoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 22:44:17 -0500
X-AuditID: 0a580157-f39ff7000005df43-2f-6037169b23e1
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id 0A.5F.57155.B9617306; Thu, 25 Feb 2021 11:16:43 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 25 Feb
 2021 11:43:30 +0800
Date:   Thu, 25 Feb 2021 11:43:29 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Oscar Salvador <osalvador@suse.de>, <naoya.horiguchi@nec.com>,
        <tony.luck@intel.com>, <david@redhat.com>
CC:     <akpm@linux-foundation.org>, <bp@alien8.de>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <hpa@zytor.com>, <x86@kernel.org>,
        <inux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <yangfeng1@kingsoft.com>,
        <yaoaili@kingsoft.com>
Subject: Re: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Message-ID: <20210225114329.4e1a41c6@alex-virtual-machine>
In-Reply-To: <20210224103105.GA16368@linux>
References: <20210224151619.67c29731@alex-virtual-machine>
        <20210224103105.GA16368@linux>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsXCFcGooDtbzDzBYNdLQYs569ewWXze8I/N
        4uv6X8wW0zaKW9w+sIbR4vKuOWwW99b8Z7W4dGABk8XFxgOMFmemFVls3jSV2eLNhXssFj82
        PGZ14PX43trH4rF4z0smj02rOtk8Nn2axO7x7tw5do8TM36zeLy4upHF4/2+q2wem09Xe3ze
        JOdxouULawB3FJdNSmpOZllqkb5dAldG17OD7AVbdCtmblrE2MC4TrmLkYNDQsBE4ts1uS5G
        Tg4hgelMEkf6bboYuYDsV4wSM1bMYQJJsAioShw48pwRxGYDsnfdm8UKYosI5Els71rKDGIz
        C7QzSTy8XARiCwt4SXy5vxasnlfASmLjq2VsIDangLbEo95GVohl0RL7jrSB1fALiEn0XvkP
        tktCwF6ibcsiqF5BiZMzn7BAzNeROLHqGNQueYntb+cwQ8xRlDi85Bc7RK+SxJHuGWwQdqzE
        snmvWCcwCs9CMmoWklGzkIxawMi8ipGlODfdcBMjJPbCdzDOa/qod4iRiYPxEKMEB7OSCO/m
        f6YJQrwpiZVVqUX58UWlOanFhxilOViUxHml2MwThATSE0tSs1NTC1KLYLJMHJxSDUzsd7qt
        TjkKzY3feOB7oMaMRLfez+Upxh/3t/GeaPifaOhQ1C/S9S5Peseu/gUPQ6o7H5QeC7k4cdvu
        pHRt/WDegpUqz7ZfeSzwsD33XsZcKz27snPiBSpSVqc1PuhmZXfbTxFfVnHk7dGLvorVm0qu
        Lbr7ZVVmqvbxCbGb+vMC/Nc9PClfeMA5bG3ogQ5pQ16x3bnWkrluqpPav39le7dgwwnJ5ruH
        z1f6R1jXHE//6vu28Sa/9/vXZUlJd3JeP/7y9MD9y5x2GTsfqNow/k/eOW9/ivxDruiVf9uc
        LGLmrFY3Pf5G957YN7G3qhe/WLSudjPoe8WndaVHXLdRl3m++NQ19oI25fFn/qYH+CuxFGck
        GmoxFxUnAgAQST0bLAMAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Feb 2021 11:31:55 +0100
Oscar Salvador <osalvador@suse.de> wrote:


> I have some questions:
> 
> > 1.When LCME is enabled, and there are two processes A && B running on
> > different core X && Y separately, which will access one same page, then
> > the page corrupted when process A access it, a MCE will be rasied to
> > core X and the error process is just underway.  
> 
> When !LMCE, that is not a problem because new MCE needs to wait for the ongoing MCE?

I am not sure whether this case will happen when !LMCE, when I realized this place may be an issue
I tried to reproduce it and my configuration is LMCE enabled.

> > 2.Then B access the page and trigger another MCE to core Y, it will also
> > do error process, it will see TestSetPageHWPoison be true, and 0 is
> > returned.  
> 
> For non-nested calls, that is no problem because the page will be taken out
> of business(unmapped from the processes), right? So no more MCE are possible.

Yes, I think after the recovery jod is finished, other processes still access the page
will meet a page fault and error will be returned;
 
> > 
> > 3.The kill_me_maybe will check the return:
> > 
> > 1244 static void kill_me_maybe(struct callback_head *cb)
> > 1245 {
> > 
> > 1254         if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags) &&
> > 1255             !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
> > 1256                 set_mce_nospec(p->mce_addr >> PAGE_SHIFT,  
> 
> So, IIUC, in case of a LMCE nested call, the second MCE will reach here.
> set_mce_nospec() will either mark the underlying page as not mapped/cached.
>
This set_mce_nospec() is not proper when the recovery job is on the fly. In my test
this function failed.
 
> Should not have memory_failure()->hwpoison_user_mappings() unmapped the page
> from both process A and B? Or this is in case the ongoing MCE(process A) has
> not still unmapped anything, so process B can still access this page.
> 
What I care is the process B triggered the error again after process A,
I don't know how it return and proceed.

> So with your change, process B will be sent a SIGBUG, while process A is still
> handling the MCE, right?

Right!

> > p->mce_whole_page);
> > 1257                 sync_core();
> > 1258                 return;
> > 1259         }
> > 
> > 1267 }
> > 
> > 4. The error process for B will end, and may nothing happened if
> > kill-early is not set, We may let the wrong data go into effect.
> > 
> > For other cases which care the return value of memory_failure() should
> > check why they want to process a memory error which have already been
> > processed. This behavior seems reasonable.
> > 
> > In kill_me_maybe, log the fact about the memory may not recovered, and
> > we will kill the related process.
> > 
> > Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
> > ---
> >  arch/x86/kernel/cpu/mce/core.c | 2 ++
> >  mm/memory-failure.c            | 4 ++--
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> > index e133ce1e562b..db4afc5bf15a 100644
> > --- a/arch/x86/kernel/cpu/mce/core.c
> > +++ b/arch/x86/kernel/cpu/mce/core.c
> > @@ -1259,6 +1259,8 @@ static void kill_me_maybe(struct callback_head *cb)
> >  	}
> >  
> >  	if (p->mce_vaddr != (void __user *)-1l) {
> > +		pr_err("Memory error may not recovered: %#lx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
> > +			p->mce_addr >> PAGE_SHIFT, p->comm, p->pid);
> >  		force_sig_mceerr(BUS_MCEERR_AR, p->mce_vaddr, PAGE_SHIFT);
> >  	} else {
> >  		pr_err("Memory error not recovered");
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index e9481632fcd1..06f006174b8c 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -1224,7 +1224,7 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
> >  	if (TestSetPageHWPoison(head)) {
> >  		pr_err("Memory failure: %#lx: already hardware poisoned\n",
> >  		       pfn);
> > -		return 0;
> > +		return -EBUSY;  
> 
> As David said, madvise_inject_error() will start returning -EBUSY now in case
> we madvise(MADV_HWPOISON) on an already hwpoisoned page.
> 
> AFAICS, memory_failure() can return 0, -Eerrors, and MF_XXX.
> Would it make sense to unify that? That way we could declare error codes that
> make somse sense (like MF_ALREADY_HWPOISONED).
> 

@David:

I checked the code again, and find a few places will care the exact return value, like:

1: drivers/base/memory.c:483:      ret = memory_failure(pfn, 0);
This is for hard page offline, I see the code in mcelog:
static void offline_action(struct mempage *mp, u64 addr)
{
	if (offline <= OFFLINE_ACCOUNT)
		return;
	Lprintf("Offlining page %llx\n", addr);
	if (memory_offline(addr) < 0) {
		Lprintf("Offlining page %llx failed: %s\n", addr, strerror(errno));
		mp->offlined = PAGE_OFFLINE_FAILED;
	} else
		mp->offlined = PAGE_OFFLINE;
}
I think return an negative value will be more proper? As the related killing function may not be performed, and we can't say
it's a success operation?

2:mm/hwpoison-inject.c:51:        return memory_failure(pfn, 0);
mm/madvise.c:910:               ret = memory_failure(pfn, MF_COUNT_INCREASED);

These two cases are mainly for error injections, I checked the test codes, mostly it only care if the value is 0 or < 0;
I do the related test, normally it work well, but for stress test, sometimes in some case, I do meet some fail cases along with the -EBUSY return.
I will dig more.

Other place will only care if the return value is 0. or just ignore it.

Hi naoya, what's your opnion for this possible issue, I need your inputs!

Thanks
Aili Yao
