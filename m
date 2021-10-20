Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211B643550F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 23:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhJTVOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 17:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhJTVOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:14:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701B3C061753
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 14:12:19 -0700 (PDT)
Date:   Wed, 20 Oct 2021 21:12:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634764338;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H6caVkuqwwWciHfOl9DpRZO+wuNUkLX0w8VBeH6x4rk=;
        b=0LJOhhxAIoy1RYW3/U2rE5WTPbv+782d1llBqjFz/pnw+lNgvTjFVVEpHn/MSMVE883awj
        2VjUaxqHIo7A62o468jzYNGJu0skXJ0qoFbum+8FAZAP7GPYdcNBZ5EPU5wDP0S+cKAFfx
        YfEVXbhr+Ufhie4mkzOyBzNfaG0NHQVjcoU42lH+dmT/2WMc3AfHu7UWZX35hSks/AOTew
        Ufhi+GjaGLNJrOFFzSx+xUo1NR0g9bYKOVEUoUKZNB4IYhDHmhSvsb528rnp3lldGX4VmW
        MlA9Cg8mzpc20Zc8oikoYla19DrvB27ROG3x23i50UxTn5ndKEXLOpOwH/O3fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634764338;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H6caVkuqwwWciHfOl9DpRZO+wuNUkLX0w8VBeH6x4rk=;
        b=tarHcMBkrWzUdSgnLIH6Zo2oGHUpaCIzmyqm0cQ7SCxKB6e8rlKfJBdKTBPAos3gFX7V25
        M6urd3OQXKclT6Cw==
From:   "irqchip-bot for Florian Fainelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] MIPS: BMIPS: Remove use of irq_cpu_offline
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Marc Zyngier <maz@kernel.org>
In-Reply-To: <20211020184859.2705451-2-f.fainelli@gmail.com>
References: <20211020184859.2705451-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Message-ID: <163476433725.25758.5984730935614392477.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     bf8bde41d296849fd5f9db8becd71ad4e84bc521
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/bf8bde41d296849fd5f9db8becd71ad4e84bc521
Author:        Florian Fainelli <f.fainelli@gmail.com>
AuthorDate:    Wed, 20 Oct 2021 11:48:47 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 20 Oct 2021 20:06:32 +01:00

MIPS: BMIPS: Remove use of irq_cpu_offline

irq_cpu_offline() is only used by MIPS and we should instead use
irq_migrate_all_off_this_cpu(). This will be helpful in order to remove
drivers/irqchip/irq-bcm7038-l1.c irq_cpu_offline callback which would
have got in the way of making this driver modular.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211020184859.2705451-2-f.fainelli@gmail.com
---
 arch/mips/Kconfig            | 1 +
 arch/mips/kernel/smp-bmips.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 771ca53..2c03b27 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1782,6 +1782,7 @@ config CPU_BMIPS
 	select CPU_HAS_PREFETCH
 	select CPU_SUPPORTS_CPUFREQ
 	select MIPS_EXTERNAL_TIMER
+	select GENERIC_IRQ_MIGRATION if HOTPLUG_CPU
 	help
 	  Support for BMIPS32/3300/4350/4380 and BMIPS5000 processors.
 
diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index b6ef5f7..f5d7bfa 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -26,6 +26,7 @@
 #include <linux/bug.h>
 #include <linux/kernel.h>
 #include <linux/kexec.h>
+#include <linux/irq.h>
 
 #include <asm/time.h>
 #include <asm/processor.h>
@@ -373,7 +374,7 @@ static int bmips_cpu_disable(void)
 
 	set_cpu_online(cpu, false);
 	calculate_cpu_foreign_map();
-	irq_cpu_offline();
+	irq_migrate_all_off_this_cpu();
 	clear_c0_status(IE_IRQ5);
 
 	local_flush_tlb_all();
