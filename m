Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE5F358102
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 12:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhDHKm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 06:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhDHKm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 06:42:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8B5C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 03:42:44 -0700 (PDT)
Date:   Thu, 08 Apr 2021 10:42:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617878562;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=REIpuV6gYx6eS5DpYJVoIv6/6yBIWsiP/f+DDQHXLTM=;
        b=OJDS02IeLbavHNctW0NfdEATNzXmXKLHoW6S7ZJPYpph194hGfw7MYaTH2+DKdXXeZIwH0
        eMfuavVHQRk5ihXdgnDzAJhdEWq4ZW6wijPMY1fr7GpAgTeSOkqhe/uAYv9u6PRJu2y/42
        ItIo3dOnBqa8K3pTd4QvIdg199sg7JMYQ2ENMhP81639hNazUr2BUMEYIosvG2D/tKYuaV
        yDj9flW383ohZgKRcVeFaEe9ctzxYtsyQHZGDHrfl7f8w32Ul+gdp6CkG6LPE3Hk/+4Knj
        IaXG2ubmiz4cbKT9ik5TaHaZoMjb5sbRCIVfoEiTz8D2da5p86BDOBmSW94AMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617878562;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=REIpuV6gYx6eS5DpYJVoIv6/6yBIWsiP/f+DDQHXLTM=;
        b=4hVcNFqluQIO/kS6+duYH+Ni1xqX2IpkrGO2rlETZOrN508OC1zpl4ysH38HJJ9SY2vWWw
        oROiZ/ZeLPYoEVCw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/wpcm450: Drop COMPILE_TEST
Cc:     j.neuschaefer@gmx.net, Stephen Rothwell <sfr@canb.auug.org.au>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <161787856134.29796.13790161224686442471.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqc=
hip:

Commit-ID:     94bc94209a66f05532c065279f4a719058d447e4
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platfo=
rms/94bc94209a66f05532c065279f4a719058d447e4
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 08 Apr 2021 08:56:27 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 08 Apr 2021 11:37:14 +01:00

irqchip/wpcm450: Drop COMPILE_TEST

This driver is (for now) ARM specific, and currently doesn't
build with a variety of architectures (ia64, RISC-V, x86_64
at the very least).

Drop COMPILE_TEST from Kconfig until it gets sorted out.

Reviewed-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 38ad9dc..715eb43 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -579,7 +579,7 @@ config MST_IRQ
=20
 config WPCM450_AIC
 	bool "Nuvoton WPCM450 Advanced Interrupt Controller"
-	depends on ARCH_WPCM450 || COMPILE_TEST
+	depends on ARCH_WPCM450
 	help
 	  Support for the interrupt controller in the Nuvoton WPCM450 BMC SoC.
=20
