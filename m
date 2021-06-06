Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAC739CF2C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhFFMrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:47:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35070 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhFFMpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:45:46 -0400
Date:   Sun, 06 Jun 2021 12:43:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622983436;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/jd96Su0XmJ+c5ce1/0zNAR+bADa1De5WSFUeCk/xG4=;
        b=AnHn/cp/wbQVbyQGnJuEsT+k3d5NjQJ1CIOzTwGA/nexEuxPJEhq/mDaLMfsGn7NlX+yiZ
        SMtmFV7LoaSJmsTcRpzDnA2pUc8XPws2ESPf6CQ95r7PlrfjkjYUNgrn+AysA2vuJuAJQK
        6DA734HFtibO3yZZuN62FOBa3Wh3YH4tuUVPdesOK6rugdIDYmfBpIMV8vJaTtnAtnssXU
        ELOBbaYcxPpEORW0UfwKLLoKrf5OGcNFU374+JxeF580p8tZOCHp39xnOBSSva2syoFsGf
        JS/brYm9iCGdETkLEaYUwVfgaZGUvqHsO13oTd03e/rCnoKRup3hHY9c0mOlrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622983436;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/jd96Su0XmJ+c5ce1/0zNAR+bADa1De5WSFUeCk/xG4=;
        b=ZkJZkqUkQUr0Jt+48oh4cmQNhgel8JX/WOHjHm+DZ4YwCScPlOP5mD8/VUvLe63TGwzaFg
        Zsutd3h4xpThZTDA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] staging: octeon-hcd: Directly include linux/of.h
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162298343573.29796.13129265386937739547.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     6cd461a7a422d0c5968d706ea1acda11ea20c96e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/6cd461a7a422d0c5968d706ea1acda11ea20c96e
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 13 Sep 2018 09:31:09 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 02 Jun 2021 14:34:47 +01:00

staging: octeon-hcd: Directly include linux/of.h

This drivers currently obtains linux/of.h by luck and a chain of
bizarre inclusions, which we're about to fix.

Let's include the required file directly.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/staging/octeon-usb/octeon-hcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.c b/drivers/staging/octeon-usb/octeon-hcd.c
index f27f20a..a079bd0 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.c
+++ b/drivers/staging/octeon-usb/octeon-hcd.c
@@ -52,6 +52,7 @@
 #include <linux/prefetch.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 
 #include <asm/octeon/octeon.h>
 
