Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D23239CF13
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhFFMpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhFFMpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:45:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF29FC06178B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 05:43:48 -0700 (PDT)
Date:   Sun, 06 Jun 2021 12:43:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622983427;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=L9RHXmPmDGUYaO5BsntfGu+1Cj5FG7/QsoRoPMxuwB4=;
        b=JWH4iQDv7y5hlMuJNSG30C859HfkDNdH5ZHOPOJJ7tBlA/7V8YT9u3YD47qHnnW3ZXaaP5
        Q5Ikuw53hgsdSpmjMcm20AnP3opgp7f7M+roZPtNmBR/yKYvcgOujNUFuBGhv2hcFJTNMu
        4wibzlkAGByBMrRry6Fzuxpm2RCtEYDXv6DASWr//gxd8bDCNmfq1NBFiqe30pSQZviTgr
        75bLRfTUx1gKlgiTOCZqZTNo5Vsgv6hf7H+u1AP2Ec4Kgzph2TbMIrKlYl4DQAlGZEUK4r
        2HounhRXM5AH40hvbDNZ1e0tP8DykXhm6DM1ZYxibfTc/thY7OH25OUQ8N/bXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622983427;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=L9RHXmPmDGUYaO5BsntfGu+1Cj5FG7/QsoRoPMxuwB4=;
        b=/p6ffuitymQWHAhTqAGCeNgaNnXOYQq3G70XiTS2mF8qPmVktBrKce1LwEAPhLGtOJDuBx
        2zwkYG5r5wkgkyAA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdesc: Fix __handle_domain_irq() comment
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162298342642.29796.5918210341843438078.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     43b3f855c757ffd95d3f5463a3d78ab528b5f77c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/43b3f855c757ffd95d3f5463a3d78ab528b5f77c
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 04 May 2021 14:33:24 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 02 Jun 2021 17:35:36 +01:00

irqdesc: Fix __handle_domain_irq() comment

It appears that the comment about a NULL domain meaning anything
has always been wrong. Fix it.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqdesc.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index cdd1cf8..2971eb7 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -165,8 +165,7 @@ int generic_handle_irq(unsigned int irq);
 /*
  * Convert a HW interrupt number to a logical one using a IRQ domain,
  * and handle the result interrupt number. Return -EINVAL if
- * conversion failed. Providing a NULL domain indicates that the
- * conversion has already been done.
+ * conversion failed.
  */
 int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
 			bool lookup, struct pt_regs *regs);
