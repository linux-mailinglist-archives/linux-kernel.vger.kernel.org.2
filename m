Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D704C3EA313
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 12:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbhHLKrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 06:47:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57664 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbhHLKrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 06:47:25 -0400
Date:   Thu, 12 Aug 2021 10:46:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628765219;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8B+Ge5Ld5cd02prqR7S9xrPC29drrmXFiWNHqxUV1yE=;
        b=0fWzsx3wlJY22/rJLcAUmx+6bn6M/SKxwlHPyEF9affQB8pO4V4wYuQT7QrVFN2KQbRBZD
        GbTuT6TnA/QLH8Cn48aM6Y5Jh9Zf5kVFQN3kqmszb5SmquMgonEKs61BBOeyWV6FgLnWPr
        82XSPa0EN3CyJK5YPLSXCbs/XPmWkq/XC5TZqRQW4w+FAg1QtocVIlwC/iShRLKfphcX0C
        9vFDo8Dq8mQ1IKuxvlDJLAeuN1Is52DGSBUWByIhzsVFmZxfteyGkgUmeI8GeCMwkxNHDS
        dqZOFwl0woKU3utYaLX9gBTFyYPBm8yMnOUxesXjA/opKSbCaQlo2HrMF3Zmfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628765219;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8B+Ge5Ld5cd02prqR7S9xrPC29drrmXFiWNHqxUV1yE=;
        b=G9hZrDIB7AKzgThtSXQo62TbK1JUUsMTAUck3+m0Lq9v7awEY2Fhb0tgC6hvmPGl4lzOrO
        R+uFhPbOiuMisAAw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] nios2: Bulk conversion to
 generic_handle_domain_irq()
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162876521838.395.12288518529893871945.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     153517d4e7d1c3f5d6174db6177ff3f3f56a9b5c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/153517d4e7d1c3f5d6174db6177ff3f3f56a9b5c
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 04 May 2021 17:42:18 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 12 Aug 2021 11:39:41 +01:00

nios2: Bulk conversion to generic_handle_domain_irq()

Wherever possible, replace constructs that match either
generic_handle_irq(irq_find_mapping()) or
generic_handle_irq(irq_linear_revmap()) to a single call to
generic_handle_domain_irq().

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/nios2/kernel/irq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/nios2/kernel/irq.c b/arch/nios2/kernel/irq.c
index c6a1a9f..6b7890e 100644
--- a/arch/nios2/kernel/irq.c
+++ b/arch/nios2/kernel/irq.c
@@ -19,11 +19,9 @@ static u32 ienable;
 asmlinkage void do_IRQ(int hwirq, struct pt_regs *regs)
 {
 	struct pt_regs *oldregs = set_irq_regs(regs);
-	int irq;
 
 	irq_enter();
-	irq = irq_find_mapping(NULL, hwirq);
-	generic_handle_irq(irq);
+	generic_handle_domain_irq(NULL, hwirq);
 	irq_exit();
 
 	set_irq_regs(oldregs);
