Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6216241CBDE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 20:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346202AbhI2SdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 14:33:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:61107 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346190AbhI2SdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 14:33:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="212267247"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="212267247"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 11:31:29 -0700
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="563481249"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 11:31:28 -0700
Date:   Wed, 29 Sep 2021 11:31:27 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
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
Message-ID: <YVSw/6BAFvh9C+ct@agluck-desk2.amr.corp.intel.com>
References: <87o88jfajo.ffs@tglx>
 <87k0j6dsdn.ffs@tglx>
 <YU3414QT0J7EN4w9@agluck-desk2.amr.corp.intel.com>
 <a77ee33c-6fa7-468c-8fc0-a0a2ce725e75@www.fastmail.com>
 <YVQ3wc/XjeOHpGCX@hirez.programming.kicks-ass.net>
 <87r1d78t2e.ffs@tglx>
 <75e95acc-6730-ddcf-d722-66e575076256@kernel.org>
 <877dez8fqu.ffs@tglx>
 <YVSlVv/j+WKftUU5@agluck-desk2.amr.corp.intel.com>
 <YVSrWouhMo2JxRCC@otcwcpicx3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVSrWouhMo2JxRCC@otcwcpicx3.sc.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 06:07:22PM +0000, Fenghua Yu wrote:
> Add
> +#ifdef CONFIG_IOMMU_SUPPORT
> because mm->pasid and current-pasid_activated are defined only if
> CONFIG_IOMMU_SUPPORT is defined.
> 
> > +	if (user_mode(regs) && current->mm->pasid && !current->pasid_activated) {
> 
> Maybe need to add "&& cpu_feature_enabled(X86_FEATURE_ENQCMD)" because
> the IA32_PASID MSR is only used when ENQCMD is enabled?
> 
> > +		current->pasid_activated = 1;
> > +		wrmsrl(MSR_IA32_PASID, current->mm->pasid | MSR_IA32_PASID_VALID);
> > +		return;
> > +	}
> > +
> 
> +endif

New version that addresses those issues.  Has ugly #ifdef in C
code :-(  If that's unacceptable, then could create some stub
functions, or add a call to __try_fixup_pasid() that's in a
file in the iommu code that is only built when CONFIG_IOMMU_SUPPORT
is set.  But either of those move the details far away from the
#GP handler so make extra work for anyone trying to follow along
with what is happening here.

-Tony

---

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index a58800973aed..5a3c87fd65de 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -528,6 +528,32 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 
 #define GPFSTR "general protection fault"
 
+/*
+ * When a user executes the ENQCMD instruction it will #GP
+ * fault if the IA32_PASID MSR has not been set up with a
+ * valid PASID.
+ * So if the process has been allocated a PASID (mm->pasid)
+ * AND the IA32_PASID MSR has not been initialized, try to
+ * fix this #GP by initializing the IA32_PASID MSR.
+ * If the #GP was for some other reason, it will trigger
+ * again, but this routine will return false and the #GP
+ * will be processed.
+ */
+static void try_fixup_pasid(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
+		return false;
+
+#ifdef CONFIG_IOMMU_SUPPORT
+	if (current->mm->pasid && !current->pasid_activated) {
+		current->pasid_activated = 1;
+		wrmsrl(MSR_IA32_PASID, current->mm->pasid);
+		return true;
+	}
+#endif
+	return false;
+}
+
 DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 {
 	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
@@ -536,6 +562,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 	unsigned long gp_addr;
 	int ret;
 
+	if (user_mode(regs) && try_fixup_pasid())
+		return;
+
 	cond_local_irq_enable(regs);
 
 	if (static_cpu_has(X86_FEATURE_UMIP)) {
