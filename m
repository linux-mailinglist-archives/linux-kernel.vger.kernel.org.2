Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0009E357DF2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhDHIUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhDHIUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:20:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5BFC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 01:20:00 -0700 (PDT)
Date:   Thu, 08 Apr 2021 08:19:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617869998;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=alfA4ypXUfBInobLUZVYh+K8tOo4KTlYKum0gvgYAzE=;
        b=Jf4/4VXwOu5TB+iiXeA3Uz9xC04RfCWG/fGII8nmY21bSkfjUS6LwgRpjrVTmS6et+AwF3
        pz8+9SzUQPQkLraA1lz8IYmgZc+M7rX4DJj80s66/AjeayEpnZ88xnzo74f0yu3v2xTPND
        ncWsQXjdbgQRwlV99UWNWvjxXuw4Ru0/EVEkM/YOL+9+jj5DGqrCFgnS5G/E5Uz1GHihz2
        LLK3h6JpMpQrvGyxxEJpP2z30WN/P6BV+iKICU5HwYuvJ8FAj3bEJBaEBw2MNSTNhW295i
        CARW6yOC7VHVsk5HhN3EcUG5BKGMx3/Y5WcDFkY8/0Qx5eGJ+EdWBJhdVMkh6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617869998;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=alfA4ypXUfBInobLUZVYh+K8tOo4KTlYKum0gvgYAzE=;
        b=ZvwtftH3GmnRVi/hiUzJjdLa47KBQg5tgzR/lGMxZEAnRxUugzN+nzENZU+9vnwTsTzqSv
        5KBVpfDbB36q6gBQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/wpcm450: Drop COMPILE_TEST
Cc:     j.neuschaefer@gmx.net, Stephen Rothwell <sfr@canb.auug.org.au>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <161786999788.29796.11651304556354814065.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqc=
hip:

Commit-ID:     384cf046e474b40db4773e9358241a5de11ed8a7
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platfo=
rms/384cf046e474b40db4773e9358241a5de11ed8a7
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 08 Apr 2021 08:56:27 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 08 Apr 2021 08:56:27 +01:00

irqchip/wpcm450: Drop COMPILE_TEST

This driver is (for now) ARM specific, and currently doesn't
build with a variety of architectures (ia64, RISC-V, x86_64
at the very least).

Drop COMPILE_TEST from Kconfig until it gets sorted out.

Cc: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
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
