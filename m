Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167C6323A95
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 11:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbhBXKcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 05:32:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:32982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234701AbhBXKck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 05:32:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 421E2B03A;
        Wed, 24 Feb 2021 10:31:58 +0000 (UTC)
Date:   Wed, 24 Feb 2021 11:31:55 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Aili Yao <yaoaili@kingsoft.com>
Cc:     naoya.horiguchi@nec.com, akpm@linux-foundation.org,
        tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        inux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, yangfeng1@kingsoft.com
Subject: Re: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Message-ID: <20210224103105.GA16368@linux>
References: <20210224151619.67c29731@alex-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224151619.67c29731@alex-virtual-machine>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 03:16:19PM +0800, Aili Yao wrote:
> When the page is already poisoned, another memory_failure() call in the
> same page now return 0, meaning OK. For nested memory mce handling, this
> behavior may lead real serious problem, Example:

I have some questions:

> 1.When LCME is enabled, and there are two processes A && B running on
> different core X && Y separately, which will access one same page, then
> the page corrupted when process A access it, a MCE will be rasied to
> core X and the error process is just underway.

When !LMCE, that is not a problem because new MCE needs to wait for the ongoing MCE?

> 2.Then B access the page and trigger another MCE to core Y, it will also
> do error process, it will see TestSetPageHWPoison be true, and 0 is
> returned.

For non-nested calls, that is no problem because the page will be taken out
of business(unmapped from the processes), right? So no more MCE are possible.

> 
> 3.The kill_me_maybe will check the return:
> 
> 1244 static void kill_me_maybe(struct callback_head *cb)
> 1245 {
> 
> 1254         if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags) &&
> 1255             !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
> 1256                 set_mce_nospec(p->mce_addr >> PAGE_SHIFT,

So, IIUC, in case of a LMCE nested call, the second MCE will reach here.
set_mce_nospec() will either mark the underlying page as not mapped/cached.

Should not have memory_failure()->hwpoison_user_mappings() unmapped the page
from both process A and B? Or this is in case the ongoing MCE(process A) has
not still unmapped anything, so process B can still access this page.

So with your change, process B will be sent a SIGBUG, while process A is still
handling the MCE, right?

> p->mce_whole_page);
> 1257                 sync_core();
> 1258                 return;
> 1259         }
> 
> 1267 }
> 
> 4. The error process for B will end, and may nothing happened if
> kill-early is not set, We may let the wrong data go into effect.
> 
> For other cases which care the return value of memory_failure() should
> check why they want to process a memory error which have already been
> processed. This behavior seems reasonable.
> 
> In kill_me_maybe, log the fact about the memory may not recovered, and
> we will kill the related process.
> 
> Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 2 ++
>  mm/memory-failure.c            | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index e133ce1e562b..db4afc5bf15a 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1259,6 +1259,8 @@ static void kill_me_maybe(struct callback_head *cb)
>  	}
>  
>  	if (p->mce_vaddr != (void __user *)-1l) {
> +		pr_err("Memory error may not recovered: %#lx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
> +			p->mce_addr >> PAGE_SHIFT, p->comm, p->pid);
>  		force_sig_mceerr(BUS_MCEERR_AR, p->mce_vaddr, PAGE_SHIFT);
>  	} else {
>  		pr_err("Memory error not recovered");
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index e9481632fcd1..06f006174b8c 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1224,7 +1224,7 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>  	if (TestSetPageHWPoison(head)) {
>  		pr_err("Memory failure: %#lx: already hardware poisoned\n",
>  		       pfn);
> -		return 0;
> +		return -EBUSY;

As David said, madvise_inject_error() will start returning -EBUSY now in case
we madvise(MADV_HWPOISON) on an already hwpoisoned page.

AFAICS, memory_failure() can return 0, -Eerrors, and MF_XXX.
Would it make sense to unify that? That way we could declare error codes that
make somse sense (like MF_ALREADY_HWPOISONED).

-- 
Oscar Salvador
SUSE L3
