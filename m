Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4208338D4AF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 11:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhEVJHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 05:07:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:41022 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230095AbhEVJHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 05:07:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1621674373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I5euWpHsqD5uqHgzmIm2FOxnorONDCOCw3Mlq8gYpiY=;
        b=ejjSrACZUNBYhvghBmwFzAOEY1olueGD54jTRHL67GSamBjkM6o11Kskv5NH5TpqLu6saf
        9RJ7mYP7u18vM4rzk+nGZZyH3IW1KF0q/twoRZtKgcWujpu6ftXHJIYcEaX4v5THOHNTp7
        cRHVialjBpsuMmxRzMjvRpoRqnI9DGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1621674373;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I5euWpHsqD5uqHgzmIm2FOxnorONDCOCw3Mlq8gYpiY=;
        b=AiZZ50PjgBYr9ZwmXJi8BAGJVJYVaX99mF58KSLz73iPGnCpNk+72D7xDLpGvbma8h85l6
        2Qhty2DssxtMYaAA==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C1866AC86;
        Sat, 22 May 2021 09:06:13 +0000 (UTC)
Date:   Sat, 22 May 2021 11:06:06 +0200
From:   Borislav Petkov <bp@suse.de>
To:     James Feeney <james@nurealm.net>
Cc:     linux-smp@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: linux 5.12 - fails to boot - soft lockup - CPU#0 stuck for 23s!
 - RIP smp_call_function_single
Message-ID: <YKjJfu4kRDflQS5e@zn.tnic>
References: <8a9599b2-f4fe-af9b-90f5-af39c315ec2f@nurealm.net>
 <YKIqDdFNaXYd39wz@zn.tnic>
 <1876afbe-a167-2be5-3690-846700eeb76c@nurealm.net>
 <YKTygvN0QNlExEQP@zn.tnic>
 <984ee4ab-6e6b-cb0e-a4f1-ce2951994b1d@nurealm.net>
 <YKWAt1zLM2vfv4Sp@zn.tnic>
 <e7701de5-35f3-da9d-7339-df2de6d8b3cf@nurealm.net>
 <YKYqABhSTTUG8cgV@zn.tnic>
 <a264eaef-1c94-77e1-dfbf-e436a41588be@nurealm.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a264eaef-1c94-77e1-dfbf-e436a41588be@nurealm.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 04:11:22PM -0600, James Feeney wrote:
> Of note, *none* of these 10 boot events generated the "soft lockup"
> Stack Trace events. Also of note, even though boot number 4 is a full
> boot, there is a 73 second mystery delay. The delay occurs right after
> adding swap, and just before "Bluetooth: BNEP". Boot 4 has other unique
> characteristics, mentioned below.
>
> $ grep lvtth dmesglog.5.12.lvtthmr.*
> dmesglog.5.12.lvtthmr.1:[    1.246282] intel_init_thermal: CPU0, lvtthmr_init: 0x10200
> dmesglog.5.12.lvtthmr.1:[    0.933178] intel_init_thermal: CPU1, lvtthmr_init: 0x10000

Aaaha, ok, your thermal interrupt is an SMI. No wonder with HP. So this
is becoming weirder by the minute...

Ok, let's look at what it does at init time. Please remove the previous
diff, apply the below one on 5.12, make sure you have

CONFIG_X86_THERMAL_VECTOR=y

in the .config, boot with the aforementioned cmdline params, catch dmesg
and send it again.

Thx.

---
diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index f8e882592ba5..853d4d4b4270 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -625,7 +625,7 @@ void intel_init_thermal(struct cpuinfo_x86 *c)
 {
 	unsigned int cpu = smp_processor_id();
 	int tm2 = 0;
-	u32 l, h;
+	u32 l, h, tmp = -1;
 
 	if (!intel_thermal_supported(c))
 		return;
@@ -652,13 +652,17 @@ void intel_init_thermal(struct cpuinfo_x86 *c)
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
