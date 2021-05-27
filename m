Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEFE392BDD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 12:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbhE0KdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 06:33:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34652 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235950AbhE0Kcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 06:32:55 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8A6281FD2E;
        Thu, 27 May 2021 10:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622111473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C82jpS4xeIsTohgovEHKIBb+iUuB9iet2QIyD905s9M=;
        b=lbTIH8PFcitdLfrIyQmpvwuA1MEik1ELoMwHYtZuvuzBVrsa1a6LEUO7lSoV1QHKUo4aUN
        xG3y1uCraCGHQguUnCiXX+0G8UBwl978NG8QOvE6IgI/aeshFHMB53l65aL1i/xavsLQd+
        AHTjvmZ308HTvqr3HlWAF8iQuuVWzZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622111473;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C82jpS4xeIsTohgovEHKIBb+iUuB9iet2QIyD905s9M=;
        b=2v4yU8LOLH2+56XgJZzjd1eCvgmPmccI5gTgwLF1kbm4UkN853ECec8v5eXu4sRao/mplA
        HpPfcPVcsw5Q06CQ==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id 6DBCE11A98;
        Thu, 27 May 2021 10:31:13 +0000 (UTC)
Date:   Thu, 27 May 2021 12:31:02 +0200
From:   Borislav Petkov <bp@suse.de>
To:     James Feeney <james@nurealm.net>
Cc:     linux-smp@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        lkml <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        x86-ml <x86@kernel.org>
Subject: [PATCH] x86/thermal: Fix LVT thermal setup for SMI delivery mode
Message-ID: <YK905sC/2cVOYo6I@zn.tnic>
References: <YKWAt1zLM2vfv4Sp@zn.tnic>
 <e7701de5-35f3-da9d-7339-df2de6d8b3cf@nurealm.net>
 <YKYqABhSTTUG8cgV@zn.tnic>
 <a264eaef-1c94-77e1-dfbf-e436a41588be@nurealm.net>
 <YKjJfu4kRDflQS5e@zn.tnic>
 <373464e3-b8a0-0fe0-b890-41df0eecf090@nurealm.net>
 <YKqLSqIM7Gi5x+IA@zn.tnic>
 <b550a241-2097-cf4b-cc41-e4d0a45cda72@nurealm.net>
 <YKtbBXZGpVZS1M4R@zn.tnic>
 <1f6c70f4-6680-d6ea-465a-548dc7698317@nurealm.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f6c70f4-6680-d6ea-465a-548dc7698317@nurealm.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok,

it took me a while to find a box like yours to reproduce on. Anyway,
here's what looks like the final fix, you could give it a run.

Thx.

---
From: Borislav Petkov <bp@suse.de>
Date: Thu, 27 May 2021 11:02:26 +0200

There are machines out there with added value crap^WBIOS which provide an
SMI handler for the local APIC thermal sensor interrupt. Out of reset,
the BSP on those machines has something like 0x200 in that APIC register
(timestamps left in because this whole issue is timing sensitive):

  [    0.033858] read lvtthmr: 0x330, val: 0x200

which means:

 - bit 16 - the interrupt mask bit is clear and thus that interrupt is enabled
 - bits [10:8] have 010b which means SMI delivery mode.

Now, later during boot, when the kernel programs the local APIC, it
soft-disables it temporarily through the spurious vector register:

  setup_local_APIC:

  	...

	/*
	 * If this comes from kexec/kcrash the APIC might be enabled in
	 * SPIV. Soft disable it before doing further initialization.
	 */
	value = apic_read(APIC_SPIV);
	value &= ~APIC_SPIV_APIC_ENABLED;
	apic_write(APIC_SPIV, value);

which means (from the SDM):

"10.4.7.2 Local APIC State After It Has Been Software Disabled

...

* The mask bits for all the LVT entries are set. Attempts to reset these
bits will be ignored."

And this happens too:

  [    0.124111] APIC: Switch to symmetric I/O mode setup
  [    0.124117] lvtthmr 0x200 before write 0xf to APIC 0xf0
  [    0.124118] lvtthmr 0x10200 after write 0xf to APIC 0xf0

This results in CPU 0 soft lockups depending on the placement in time
when the APIC soft-disable happens. Those soft lockups are not 100%
reproducible and the reason for that can only be speculated as no one
tells you what SMM does. Likely, it confuses the SMM code that the APIC
is disabled and the thermal interrupt doesn't doesn't fire at all,
leading to CPU 0 stuck in SMM forever...

Now, before

  4f432e8bb15b ("x86/mce: Get rid of mcheck_intel_therm_init()")

due to how the APIC_LVTTHMR was read before APIC initialization in
mcheck_intel_therm_init(), it would read the value with the mask bit 16
clear and then intel_init_thermal() would replicate it onto the APs and
all would be peachy - the thermal interrupt would remain enabled.

But that commit moved that reading to a later moment in
intel_init_thermal(), resulting in reading APIC_LVTTHMR on the BSP too
late and with its interrupt mask bit set.

Thus, revert back to the old behavior of reading the thermal LVT
register before the APIC gets initialized.

Fixes: 4f432e8bb15b ("x86/mce: Get rid of mcheck_intel_therm_init()")
Reported-by: James Feeney <james@nurealm.net>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://lkml.kernel.org/r/YKIqDdFNaXYd39wz@zn.tnic
---
 arch/x86/include/asm/thermal.h      |  4 +++-
 arch/x86/kernel/setup.c             |  9 +++++++++
 drivers/thermal/intel/therm_throt.c | 15 +++++++++++----
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/thermal.h b/arch/x86/include/asm/thermal.h
index ddbdefd5b94f..91a7b6687c3b 100644
--- a/arch/x86/include/asm/thermal.h
+++ b/arch/x86/include/asm/thermal.h
@@ -3,11 +3,13 @@
 #define _ASM_X86_THERMAL_H
 
 #ifdef CONFIG_X86_THERMAL_VECTOR
+void therm_lvt_init(void);
 void intel_init_thermal(struct cpuinfo_x86 *c);
 bool x86_thermal_enabled(void);
 void intel_thermal_interrupt(void);
 #else
-static inline void intel_init_thermal(struct cpuinfo_x86 *c) { }
+static inline void therm_lvt_init(void)				{ }
+static inline void intel_init_thermal(struct cpuinfo_x86 *c)	{ }
 #endif
 
 #endif /* _ASM_X86_THERMAL_H */
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 72920af0b3c0..ff653d608d5f 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -44,6 +44,7 @@
 #include <asm/pci-direct.h>
 #include <asm/prom.h>
 #include <asm/proto.h>
+#include <asm/thermal.h>
 #include <asm/unwind.h>
 #include <asm/vsyscall.h>
 #include <linux/vmalloc.h>
@@ -1226,6 +1227,14 @@ void __init setup_arch(char **cmdline_p)
 
 	x86_init.timers.wallclock_init();
 
+	/*
+	 * This needs to run before setup_local_APIC() which soft-disables the
+	 * local APIC temporarily and that masks the thermal LVT interrupt,
+	 * leading to softlockups on machines which have configured SMI
+	 * interrupt delivery.
+	 */
+	therm_lvt_init();
+
 	mcheck_init();
 
 	register_refined_jiffies(CLOCK_TICK_RATE);
diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index f8e882592ba5..99abdc03c44c 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -621,6 +621,17 @@ bool x86_thermal_enabled(void)
 	return atomic_read(&therm_throt_en);
 }
 
+void __init therm_lvt_init(void)
+{
+	/*
+	 * This function is only called on boot CPU. Save the init thermal
+	 * LVT value on BSP and use that value to restore APs' thermal LVT
+	 * entry BIOS programmed later
+	 */
+	if (intel_thermal_supported(&boot_cpu_data))
+		lvtthmr_init = apic_read(APIC_LVTTHMR);
+}
+
 void intel_init_thermal(struct cpuinfo_x86 *c)
 {
 	unsigned int cpu = smp_processor_id();
@@ -630,10 +641,6 @@ void intel_init_thermal(struct cpuinfo_x86 *c)
 	if (!intel_thermal_supported(c))
 		return;
 
-	/* On the BSP? */
-	if (c == &boot_cpu_data)
-		lvtthmr_init = apic_read(APIC_LVTTHMR);
-
 	/*
 	 * First check if its enabled already, in which case there might
 	 * be some SMM goo which handles it, so we can't even put a handler
-- 
2.29.2


-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
