Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD5636A03B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 10:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbhDXI4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 04:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbhDXI4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 04:56:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90C0C061574
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 01:56:10 -0700 (PDT)
Date:   Sat, 24 Apr 2021 08:56:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619254568;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IYVEJwxKGqkViTmDYpS19L6H7ueeVl96nMBvgMY867c=;
        b=kuSvn0kY0WU5GlT3IIdiboarCrbRH2LuaLquVakzB1vCcTlAzbtTciIHbhxpzPxc+wrpFo
        wSMW2C3rwakmaw+f8V+oXiV0Il2WyHAIKTeMoOoG7bXK78aR3Nkj9TDOMJr5RY2bUZ3q1b
        Gs6m8w60Ul53TMacq154Nk0Bn6heSprlKjrQuBHaXRM5DpbjwFmaToekI4UuFkx5S6TSWW
        pBbburL4X5MA7z0QOd02dE6dRjThcLvSrNfzTbuqmLyTEFlbiOPhlHTF6xkUrnaxLPaFtv
        r/upglBv7EHdpyv3BD6syZh1wjoTDjBNzTjY5Ciw2YqxF6VH+wajePfCWgZ+vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619254568;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IYVEJwxKGqkViTmDYpS19L6H7ueeVl96nMBvgMY867c=;
        b=Il65sGO4b6xCAjDNk7+jvXg2pJe0y8TCt11r8t3ybZVzsFAKp3FOEQTRW4XmYdssCKjdKO
        WyKi7w/bQ1LRHhDw==
From:   "irqchip-bot for Robert Hancock" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/xilinx: Expose Kconfig option for
 Zynq/ZynqMP
Cc:     Robert Hancock <robert.hancock@calian.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210423185853.2556087-1-robert.hancock@calian.com>
References: <20210423185853.2556087-1-robert.hancock@calian.com>
MIME-Version: 1.0
Message-ID: <161925456752.29796.14092989139855194753.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     debf69cfd4c618c7036a13cc4edd1faf87ce7d53
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/debf69cfd4c618c7036a13cc4edd1faf87ce7d53
Author:        Robert Hancock <robert.hancock@calian.com>
AuthorDate:    Fri, 23 Apr 2021 12:58:53 -06:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 24 Apr 2021 09:50:03 +01:00

irqchip/xilinx: Expose Kconfig option for Zynq/ZynqMP

Previously the XILINX_INTC config option was hidden and only
auto-selected on the MicroBlaze platform. However, this IP can also be
used on the Zynq and ZynqMP platforms as a secondary cascaded
controller. Allow this option to be user-enabled on those platforms.

Signed-off-by: Robert Hancock <robert.hancock@calian.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210423185853.2556087-1-robert.hancock@calian.com
---
 drivers/irqchip/Kconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 18b0d0b..c8f57e3 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -279,8 +279,13 @@ config XTENSA_MX
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
 
 config XILINX_INTC
-	bool
+	bool "Xilinx Interrupt Controller IP"
+	depends on MICROBLAZE || ARCH_ZYNQ || ARCH_ZYNQMP
 	select IRQ_DOMAIN
+	help
+	  Support for the Xilinx Interrupt Controller IP core.
+	  This is used as a primary controller with MicroBlaze and can also
+	  be used as a secondary chained controller on other platforms.
 
 config IRQ_CROSSBAR
 	bool
