Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AB543AFDE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbhJZKTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:19:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60784 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbhJZKSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:18:34 -0400
Date:   Tue, 26 Oct 2021 10:16:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635243370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=eJbh6IV3PgVUXdzD49u7TF4XQ7/FjQdaes/fT6XL4Pc=;
        b=oVR9lK8q85QrmmpJ+GKHS9soGUuHCMQMr/seO3YDBD7u2Qa1vi+Vhq7YVSkXYURZ2J225i
        vsgtlLB9nhZhR1T8OAwt05FoAVxuDGwGhLL5EuxHrsJ6TwbV/DpM5WOE6mToSKOg11ja1w
        We9ahPmBd3cduhXPl8qOG04++ajWVr0Z8JIDDj7LeptVotp0ufl8Uj85BR98ISo+KuE4dr
        am7lALHDawhLzmM0Tiz3Wt1SiQ2U6XMvDcGam0qb89vjCst5dK5NdipsIlQzdMg53gLU0c
        b9wP9TRpWJJYTL7E9GdnjVxWO8Wk1IomsvyDxvbf4e9XvknGEKXvhH9pYaFiAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635243370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=eJbh6IV3PgVUXdzD49u7TF4XQ7/FjQdaes/fT6XL4Pc=;
        b=X65yRI0GG46aZeFBZVTYkFW2TWB6vsjDZjhv3DURT4KfdxcvZp4ETn+7PBpahc2ZhDD+Np
        rS0l39XJvNv0/iCw==
From:   "irqchip-bot for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irq: mips: stop (ab)using handle_domain_irq()
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>
MIME-Version: 1.0
Message-ID: <163524336908.626.17843388932862493707.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     bab4ff1edccd5853c956ac72e5152b073a237b50
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/bab4ff1edccd5853c956ac72e5152b073a237b50
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 20 Oct 2021 15:24:40 +01:00
Committer:     Mark Rutland <mark.rutland@arm.com>
CommitterDate: Mon, 25 Oct 2021 10:05:07 +01:00

irq: mips: stop (ab)using handle_domain_irq()

On MIPS, the only user of handle_domain_irq() is octeon_irq_ciu3_ip2(),
which is called from the platform-specific plat_irq_dispatch() function
invoked from the early assembly code.

No other irqchip relevant to arch/mips uses handle_domain_irq():

* No other plat_irq_dispatch() function transitively calls
  handle_domain_irq().

* No other vectored IRQ dispatch function registered with
  set_vi_handler() calls handle_domain_irq().

* No chained irqchip handlers call handle_domain_irq(), which makes
  sense as this is meant to only be used by root irqchip handlers.

Currently octeon_irq_ciu3_ip2() passes NULL as the `regs` argument to
handle_domain_irq(), and as handle_domain_irq() will pass this to
set_irq_regs(), any invoked IRQ handlers will erroneously see a NULL
pt_regs if they call get_pt_regs().

Fix this by calling generic_handle_domain_irq() directly, and performing
the necessary irq_{enter,exit}() logic directly in
octeon_irq_ciu3_ip2(). At the same time, deselect HANDLE_DOMAIN_IRQ,
which subsequent patches will remove.

Other than the corrected behaviour of get_pt_regs(), there should be no
functional change as a result of this patch.

Fixes: ce210d35bb93c2c5 ("MIPS: OCTEON: Add support for OCTEON III interrupt controller.")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/Kconfig                    | 1 -
 arch/mips/cavium-octeon/octeon-irq.c | 5 ++++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 771ca53..7b004c5 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -47,7 +47,6 @@ config MIPS
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GUP_GET_PTE_LOW_HIGH if CPU_MIPS32 && PHYS_ADDR_T_64BIT
-	select HANDLE_DOMAIN_IRQ
 	select HAVE_ARCH_COMPILER_H
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KGDB if MIPS_FP_SUPPORT
diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index be5d4af..844f882 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -2609,7 +2609,10 @@ static void octeon_irq_ciu3_ip2(void)
 		else
 			hw = intsn;
 
-		ret = handle_domain_irq(domain, hw, NULL);
+		irq_enter();
+		ret = generic_handle_domain_irq(domain, hw);
+		irq_exit();
+
 		if (ret < 0) {
 			union cvmx_ciu3_iscx_w1c isc_w1c;
 			u64 isc_w1c_addr = ciu3_addr + CIU3_ISC_W1C(intsn);
