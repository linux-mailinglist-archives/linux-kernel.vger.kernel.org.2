Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1603F440981
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 16:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhJ3OYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 10:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhJ3OYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 10:24:46 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F13C061570
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 07:22:16 -0700 (PDT)
Received: from tabernacle.localnet (unknown [IPv6:2001:9e8:95:d100:d350:2f3d:dcb2:9d8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5F1111EC0328;
        Sat, 30 Oct 2021 16:22:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635603733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=BAIMRAiKktEDRKNO7KJKIe/lu2Jdwwrdh0cyDNnBrMI=;
        b=a+ZHTt3cL19cIK98tbZwmJQHIUEF8IrTHthJwZqxZGfQituqPjZ+bbQsbnIetkRuxzBb87
        zUdoWx2MfAf1i9aHl9Es67mLncLDvFOrzgGTE+QP+AxPSW3OKF8Mj44JCpWTjhPzj88iA7
        2GCPArw281cb7yGW0qB2tCBqIjHxC74=
From:   Julian Stecklina <js@alien8.de>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, hpa@zytor.com,
        Julian Stecklina <julian.stecklina@cyberus-technology.de>,
        Markus Napierkowski <markus.napierkowski@cyberus-technology.de>
Subject: [PATCH] x86/apic: fix frequency in apic=verbose log output
Date:   Sat, 30 Oct 2021 16:21:48 +0200
Message-Id: <20211030142148.143261-1-js@alien8.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Stecklina <julian.stecklina@cyberus-technology.de>

When apic=verbose is specified, the LAPIC timer calibration prints its
results to the console. While debugging virtualization code, we
noticed that the CPU and bus frequencies are printed incorrectly.

Specifically, for a 1.7 GHz CPU with 1 GHz bus frequency and HZ=1000,
the log includes a superfluous 0 after the period:

..... calibration result: 999978
..... CPU clock speed is 1696.0783 MHz.
..... host bus clock speed is 999.0978 MHz.

Looking at the code, this only worked as intended for HZ=100. After
the fix, we now see the correct frequency in the log:

..... calibration result: 999828
..... CPU clock speed is 1696.507 MHz.
..... host bus clock speed is 999.828 MHz.

There is no functional change to the LAPIC calibration here, beyond
the printf changes.

Suggested-by: Markus Napierkowski <markus.napierkowski@cyberus-technology.de>
Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
---
 arch/x86/kernel/apic/apic.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index b70344bf6600..925becaac12a 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -198,6 +198,7 @@ static struct resource lapic_resource = {
 	.flags = IORESOURCE_MEM | IORESOURCE_BUSY,
 };
 
+/* Measured in ticks per HZ. */
 unsigned int lapic_timer_period = 0;
 
 static void apic_pm_activate(void);
@@ -835,6 +836,7 @@ static int __init calibrate_APIC_clock(void)
 	unsigned long jif_start;
 	unsigned long deltaj;
 	long delta, deltatsc;
+	long tsc_khz, bus_khz;
 	int pm_referenced = 0;
 
 	if (boot_cpu_has(X86_FEATURE_TSC_DEADLINE_TIMER))
@@ -937,16 +939,16 @@ static int __init calibrate_APIC_clock(void)
 		    lapic_timer_period);
 
 	if (boot_cpu_has(X86_FEATURE_TSC)) {
+		tsc_khz = (deltatsc * HZ) / (1000 * LAPIC_CAL_LOOPS);
 		apic_printk(APIC_VERBOSE, "..... CPU clock speed is "
-			    "%ld.%04ld MHz.\n",
-			    (deltatsc / LAPIC_CAL_LOOPS) / (1000000 / HZ),
-			    (deltatsc / LAPIC_CAL_LOOPS) % (1000000 / HZ));
+			    "%ld.%03ld MHz.\n",
+			    tsc_khz / 1000, tsc_khz % 1000);
 	}
 
+	bus_khz = (long)lapic_timer_period * HZ / 1000;
 	apic_printk(APIC_VERBOSE, "..... host bus clock speed is "
-		    "%u.%04u MHz.\n",
-		    lapic_timer_period / (1000000 / HZ),
-		    lapic_timer_period % (1000000 / HZ));
+		    "%ld.%03ld MHz.\n",
+		    bus_khz / 1000, bus_khz % 1000);
 
 	/*
 	 * Do a sanity check on the APIC calibration result
-- 
2.31.1

