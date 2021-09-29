Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D029541CB82
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 20:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345658AbhI2SJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 14:09:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:38075 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344304AbhI2SJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 14:09:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="223118728"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="223118728"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 11:07:30 -0700
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="708463491"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 11:07:30 -0700
Date:   Wed, 29 Sep 2021 18:07:22 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
Message-ID: <YVSrWouhMo2JxRCC@otcwcpicx3.sc.intel.com>
References: <YUyuEjlrcOeCp4qQ@agluck-desk2.amr.corp.intel.com>
 <87o88jfajo.ffs@tglx>
 <87k0j6dsdn.ffs@tglx>
 <YU3414QT0J7EN4w9@agluck-desk2.amr.corp.intel.com>
 <a77ee33c-6fa7-468c-8fc0-a0a2ce725e75@www.fastmail.com>
 <YVQ3wc/XjeOHpGCX@hirez.programming.kicks-ass.net>
 <87r1d78t2e.ffs@tglx>
 <75e95acc-6730-ddcf-d722-66e575076256@kernel.org>
 <877dez8fqu.ffs@tglx>
 <YVSlVv/j+WKftUU5@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVSlVv/j+WKftUU5@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tony,

On Wed, Sep 29, 2021 at 10:41:42AM -0700, Luck, Tony wrote:
> On Wed, Sep 29, 2021 at 07:15:53PM +0200, Thomas Gleixner wrote:
> > On Wed, Sep 29 2021 at 09:59, Andy Lutomirski wrote:
> > > On 9/29/21 05:28, Thomas Gleixner wrote:
> > >> Looking at that patch again, none of this muck in fpu__pasid_write() is
> > >> required at all. The whole exception fixup is:
> > >> 
> > >>      if (!user_mode(regs))
> > >>               return false;
> > >> 
> > >>      if (!current->mm->pasid)
> > >>               return false;
> > >> 
> > >>      if (current->pasid_activated)
> > >>      	     return false;
> > >
> > > <-- preemption or BH here: kaboom.
> > 
> > Sigh, this had obviously to run in the early portion of #GP, i.e. before
> > enabling interrupts.
> 
> Like this? Obviously with some comment about why this is being done.
> 
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index a58800973aed..a848a59291e7 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -536,6 +536,12 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>  	unsigned long gp_addr;
>  	int ret;
>  

Add
+#ifdef CONFIG_IOMMU_SUPPORT
because mm->pasid and current-pasid_activated are defined only if
CONFIG_IOMMU_SUPPORT is defined.

> +	if (user_mode(regs) && current->mm->pasid && !current->pasid_activated) {

Maybe need to add "&& cpu_feature_enabled(X86_FEATURE_ENQCMD)" because
the IA32_PASID MSR is only used when ENQCMD is enabled?

> +		current->pasid_activated = 1;
> +		wrmsrl(MSR_IA32_PASID, current->mm->pasid | MSR_IA32_PASID_VALID);
> +		return;
> +	}
> +

+endif

>  	cond_local_irq_enable(regs);
>  
>  	if (static_cpu_has(X86_FEATURE_UMIP)) {

Thanks.

-Fenghua
