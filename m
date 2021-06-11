Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0403A4394
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhFKN6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:58:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40016 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbhFKN4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:44 -0400
Date:   Fri, 11 Jun 2021 13:54:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623419686;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BDoG3SppAxwk3pfG1Dx/fhHnTiP2XbAwIr0crBNoBZc=;
        b=uZl86RTNazhjqMfNbbi1E9gSiI2pzYYsd3lLlDwbFjnxR6DWC+fn9inVA/ucUFJORwgF4R
        X8vPxP9oBfCr47Q2adFCBcR66+h2OZxrWWwY/eiarN++iWV9JjbRw0lz4GpLSKB+D2GgNK
        AYD4BXS3cycOuvmqO0PhdKRI7M1DMt8hSfiWbr+9zEtyALjECfbifPUdz9q1f9zLD6mDQY
        LJOx9qGYApnV9N6/SJ+e8ino+l5zVk6CQeGqrpVqCe08EHV/hm0oVYVCp7OB/ajz9yuUAp
        xlCNkCZGPR2ccvDZG1GIibgOl6glf5oUv2D5T8MxgEV/N+Ugk3NSum0O3z8FPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623419686;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BDoG3SppAxwk3pfG1Dx/fhHnTiP2XbAwIr0crBNoBZc=;
        b=dzOSBkOuz5Os0tFw7YbYQdisbf5mA3DFzr8S4b6KbYMtF08gxYdshHe94C+h+KgY9wUT21
        AIOFwotLT49UgGCA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] nios2: Do not include linux/irqdomain.h
 from asm/irq.h
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162341968567.19906.7436153754318652121.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     9bd1cc4148cbea44ca7d8254b50edb6cb660957a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/9bd1cc4148cbea44ca7d8254b50edb6cb660957a
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 13 Sep 2018 10:59:03 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 10 Jun 2021 13:09:15 +01:00

nios2: Do not include linux/irqdomain.h from asm/irq.h

Including linux/irqdomain.h from asm/irq.h is going to break
as soon as linux/irqdomain.h will include linux/irq.h, so
let's fix this. Code relying on linux/irqomain.h should include
it directly.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/nios2/include/asm/irq.h | 1 -
 arch/nios2/kernel/irq.c      | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/nios2/include/asm/irq.h b/arch/nios2/include/asm/irq.h
index 13ce372..c52c948 100644
--- a/arch/nios2/include/asm/irq.h
+++ b/arch/nios2/include/asm/irq.h
@@ -10,6 +10,5 @@
 #define NIOS2_CPU_NR_IRQS	32
 
 #include <asm-generic/irq.h>
-#include <linux/irqdomain.h>
 
 #endif
diff --git a/arch/nios2/kernel/irq.c b/arch/nios2/kernel/irq.c
index 5f3555c..c6a1a9f 100644
--- a/arch/nios2/kernel/irq.c
+++ b/arch/nios2/kernel/irq.c
@@ -11,6 +11,7 @@
 
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/of.h>
 
 static u32 ienable;
