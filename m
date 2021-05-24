Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BE438E1F7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 09:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhEXHxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 03:53:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:46526 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232099AbhEXHxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 03:53:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1621842701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6dCJdprvUL9ZK9iZ9SQbxS/E/+yI5EPbo/8nloApozw=;
        b=yygXyE77NlT0vNBVfLetr38yjZ6xdg3L3m0q04PDF7Ujipn5NJrRMsHwIPqCMAaGcZwtlu
        oH2+fL0mBvqLcFICQIvpkxhZWaYokFrRG7DXo+gjfXPQ6MgNcOV0hOaXHsKixEVn/a0hN2
        WUQ0USzIU725X90YNEaMvttqb55QVns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1621842701;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6dCJdprvUL9ZK9iZ9SQbxS/E/+yI5EPbo/8nloApozw=;
        b=WAFdtjS8O4heKbNrs3BOzdA2MC7XbJ5F8iu73Lh+tI/RElwHMMuT2rvfNrcNQ7gaEuFUWB
        w15qQgOpQh3LwXAA==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 02578ABC1;
        Mon, 24 May 2021 07:51:41 +0000 (UTC)
Date:   Mon, 24 May 2021 09:51:33 +0200
From:   Borislav Petkov <bp@suse.de>
To:     James Feeney <james@nurealm.net>
Cc:     linux-smp@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: linux 5.12 - fails to boot - soft lockup - CPU#0 stuck for 23s!
 - RIP smp_call_function_single
Message-ID: <YKtbBXZGpVZS1M4R@zn.tnic>
References: <YKTygvN0QNlExEQP@zn.tnic>
 <984ee4ab-6e6b-cb0e-a4f1-ce2951994b1d@nurealm.net>
 <YKWAt1zLM2vfv4Sp@zn.tnic>
 <e7701de5-35f3-da9d-7339-df2de6d8b3cf@nurealm.net>
 <YKYqABhSTTUG8cgV@zn.tnic>
 <a264eaef-1c94-77e1-dfbf-e436a41588be@nurealm.net>
 <YKjJfu4kRDflQS5e@zn.tnic>
 <373464e3-b8a0-0fe0-b890-41df0eecf090@nurealm.net>
 <YKqLSqIM7Gi5x+IA@zn.tnic>
 <b550a241-2097-cf4b-cc41-e4d0a45cda72@nurealm.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b550a241-2097-cf4b-cc41-e4d0a45cda72@nurealm.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2021 at 05:02:01PM -0600, James Feeney wrote:
> Ha! Yes, your patch *is* the culprit. You don't trust git bisect?

Well, git-bisect can very easily veer off into the fields if the
bisector makes a mistake. I'm not saying you have made a mistake but I
have done that mistake a bunch of times and have seen others do it too
so it is very easy to get lost.

And with my patch simply moving the LVT THMR read back in the boot
order, I was very sceptical how can that even be?!

But...

> "lvtthmr_init: 0x200" != "lvtthmr_init: 0x10200" != "lvtthmr_init: 0x10000"

... *this* is a good catch, I *think* I know what happens and the next
patch will confirm my theory, see the end of the mail. Remove all diffs
you have ontop of your 5.12 kernel, apply the one below, do the exact
same exercise with it and send me one full dmesg pls.

> System Management is *hard*, because it must build upon someone else's
> undocumented buggy software. Thank Intel.

No, SMM is shit. Complain to the OEMs about it.

However, this time I think it is *we* who are not doing stuff as
correctly as we should but let's see your results first.

Thx.

---

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index ddfb3cad8dff..5ac8b827bc12 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -296,6 +296,12 @@ struct cper_sec_mem_err;
 extern void apei_mce_report_mem_error(int corrected,
 				      struct cper_sec_mem_err *mem_err);
 
+#ifdef CONFIG_X86_THERMAL_VECTOR
+extern void mcheck_intel_therm_init(void);
+#else
+static inline void mcheck_intel_therm_init(void) { }
+#endif
+
 /*
  * Enumerate new IP types and HWID values in AMD processors which support
  * Scalable MCA.
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 4a39fb429f15..f21009786877 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1162,6 +1162,10 @@ void clear_local_APIC(void)
 #ifdef CONFIG_X86_THERMAL_VECTOR
 	if (maxlvt >= 5) {
 		v = apic_read(APIC_LVTTHMR);
+
+		pr_info("%s: CPU%d, maxlvt: %d, APIC_LVTTHMR: 0x%x, masking LVT\n",
+			__func__, smp_processor_id(), maxlvt, v);
+
 		apic_write(APIC_LVTTHMR, v | APIC_LVT_MASKED);
 	}
 #endif
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index bf7fe87a7e88..ded20b8612fe 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2190,6 +2190,7 @@ __setup("mce", mcheck_enable);
 
 int __init mcheck_init(void)
 {
+	mcheck_intel_therm_init();
 	mce_register_decode_chain(&early_nb);
 	mce_register_decode_chain(&mce_uc_nb);
 	mce_register_decode_chain(&mce_default_nb);
diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index f8e882592ba5..0ebd2386839f 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -621,19 +621,30 @@ bool x86_thermal_enabled(void)
 	return atomic_read(&therm_throt_en);
 }
 
+void __init mcheck_intel_therm_init(void)
+{
+	/*
+	 * This function is only called on boot CPU. Save the init thermal
+	 * LVT value on BSP and use that value to restore APs' thermal LVT
+	 * entry BIOS programmed later
+	 */
+	if (intel_thermal_supported(&boot_cpu_data)) {
+		lvtthmr_init = apic_read(APIC_LVTTHMR);
+	pr_info("%s: lvtthmr_init: 0x%x\n", __func__, lvtthmr_init);
+	} else {
+		pr_info("%s: !intel_thermal_supported\n", __func__);
+	}
+}
+
 void intel_init_thermal(struct cpuinfo_x86 *c)
 {
 	unsigned int cpu = smp_processor_id();
 	int tm2 = 0;
-	u32 l, h;
+	u32 l, h, tmp = -1;
 
 	if (!intel_thermal_supported(c))
 		return;
 
-	/* On the BSP? */
-	if (c == &boot_cpu_data)
-		lvtthmr_init = apic_read(APIC_LVTTHMR);
-
 	/*
 	 * First check if its enabled already, in which case there might
 	 * be some SMM goo which handles it, so we can't even put a handler
@@ -652,13 +663,17 @@ void intel_init_thermal(struct cpuinfo_x86 *c)
 	 * BIOS has programmed on AP based on BSP's info we saved since BIOS
 	 * is always setting the same value for all threads/cores.
 	 */
-	if ((h & APIC_DM_FIXED_MASK) != APIC_DM_FIXED)
+	if ((h & APIC_DM_FIXED_MASK) != APIC_DM_FIXED) {
 		apic_write(APIC_LVTTHMR, lvtthmr_init);
+		tmp = apic_read(APIC_LVTTHMR);
+	}
 
+	pr_info("%s: CPU%d, lvtthmr_init: 0x%x, read: 0x%x, misc_enable (low): 0x%x\n",
+		__func__, cpu, lvtthmr_init, tmp, l);
 
 	if ((l & MSR_IA32_MISC_ENABLE_TM1) && (h & APIC_DM_SMI)) {
 		if (system_state == SYSTEM_BOOTING)
-			pr_debug("CPU%d: Thermal monitoring handled by SMI\n", cpu);
+			pr_info("CPU%d: Thermal monitoring handled by SMI\n", cpu);
 		return;
 	}
 

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
