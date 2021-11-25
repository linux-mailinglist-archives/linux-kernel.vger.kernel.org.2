Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3D045DF57
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 18:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbhKYRIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 12:08:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53226 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241469AbhKYRGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 12:06:53 -0500
Date:   Thu, 25 Nov 2021 17:03:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637859820;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D7qkJZFsmt9YLRE2CDmOJOenCsg6PPtll6M53RU2OnQ=;
        b=hPe7hhchqPziPCbQKUCHH2/Yevc8IH4WDVezkze7iVKuRcFUls8nPmT1Z9EceiIq6nQPyG
        ON9XCV097J7ThRBH+gUKz8hGa78zl0e+aYA9HYAGkgoLyfRGUchG9Jrvai3c4hitKBBbuj
        xNz5Fu9J8apQp7zsXdKqQ2+MwPr9YD2+vu8N1yc35b+a6CN/ohoROAEXIurwKI1eyjxOU3
        9IcTfNTUs4d9/GBhFd8W3Sgd0rZfeZ76CiZMa9YLj7fPi8jqe8DRQrTxVhSjE8HqO1t+CK
        igYCruIlSlunJwJDrwvOvNELF0y0H2k6xTdqS9AwuXnxAnLvBtBQ5XUZbGLUeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637859820;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D7qkJZFsmt9YLRE2CDmOJOenCsg6PPtll6M53RU2OnQ=;
        b=iQOjsGV0/4KXojkkmnBS9eBOaLmT9RTc5vVJAHK+drH93wLb/PzvCtGvm5Q5gCA1GreLFF
        +5F7HhXnG+26e2BA==
From:   "irqchip-bot for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/mips-gic: Use bitfield helpers
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: =?utf-8?q?=3C74f9d126961a90d3e311b92a54870eaac5b3ae57=2E16375?=
 =?utf-8?q?93297=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3C74f9d126961a90d3e311b92a54870eaac5b3ae57=2E163759?=
 =?utf-8?q?3297=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
MIME-Version: 1.0
Message-ID: <163785981944.11128.15688304790396374000.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     357a9c4b79f4c8bbceb77c64ea09d8da3a6a870d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/357a9c4b79f4c8bbceb77c64ea09d8da3a6a870d
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Mon, 22 Nov 2021 16:54:07 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 25 Nov 2021 16:55:40 

irqchip/mips-gic: Use bitfield helpers

Use the FIELD_GET() helper, instead of open-coding the same operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/all/74f9d126961a90d3e311b92a54870eaac5b3ae57.1637593297.git.geert+renesas@glider.be
---
 drivers/irqchip/irq-mips-gic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index d02b05a..ff89b36 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -9,6 +9,7 @@
 
 #define pr_fmt(fmt) "irq-mips-gic: " fmt
 
+#include <linux/bitfield.h>
 #include <linux/bitmap.h>
 #include <linux/clocksource.h>
 #include <linux/cpuhotplug.h>
@@ -735,8 +736,7 @@ static int __init gic_of_init(struct device_node *node,
 	mips_gic_base = ioremap(gic_base, gic_len);
 
 	gicconfig = read_gic_config();
-	gic_shared_intrs = gicconfig & GIC_CONFIG_NUMINTERRUPTS;
-	gic_shared_intrs >>= __ffs(GIC_CONFIG_NUMINTERRUPTS);
+	gic_shared_intrs = FIELD_GET(GIC_CONFIG_NUMINTERRUPTS, gicconfig);
 	gic_shared_intrs = (gic_shared_intrs + 1) * 8;
 
 	if (cpu_has_veic) {
