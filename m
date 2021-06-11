Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0763A438D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhFKN5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbhFKN4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEF2C0617AF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 06:54:44 -0700 (PDT)
Date:   Fri, 11 Jun 2021 13:54:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623419683;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kYM1KcOLZZc/k8yDJYpXpYvBZcB02v0Ek25miGAVK1Y=;
        b=FcRmFpf1mgwyc/oVoIDVQOYjZ99IV2uHxOh4plFnSSciPh5BnfOesJLDq9OgWKZEUe1O2O
        VAnR9ZaeCFoSgk6yOXcbdEE4bo4cNo/hPRaR63yXHbFRZZsBP94tpPaUTk2zpQiiJeql/o
        EMLE4wChh/Y0B0SeJjTR2yNS0bIdNJesdamz8vGcnDaLuB/xNEI89UMHAR/iKLN4GcsNdX
        N48dnb5OEhk/MjmVEsz/oZjmRYacR+oT2z41FC9lz63EUHxErIDszm7tgJxFnfEdu3ubME
        dNc2FnOHHIw+qzCNRdZg5NsrN8pp1W1Y66fGNigZntEGSOTQ7FeONns5aSRtvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623419683;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kYM1KcOLZZc/k8yDJYpXpYvBZcB02v0Ek25miGAVK1Y=;
        b=S73WI1uAIYZf0lkGmUEXspobrZo2mVz/wlqQ2BlOTy6N/AbIzMstCFvjg+bo2mOq/TCQeO
        Ofab+GirNuN9OMDQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] MIPS: Add missing linux/irqdomain.h includes
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162341968281.19906.7741044785060691295.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     18ca45f5ba1e31704bcca038b8b612e9b1f52b4f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/18ca45f5ba1e31704bcca038b8b612e9b1f52b4f
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 19 May 2021 09:01:06 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 10 Jun 2021 13:09:16 +01:00

MIPS: Add missing linux/irqdomain.h includes

A number of MIPS platforms are failing to directly include
irqdomain.h. Fix this so that we can drop unnecessary dependencies

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/mips/pci/pci-rt3883.c       | 1 +
 arch/mips/pci/pci-xtalk-bridge.c | 1 +
 arch/mips/sgi-ip27/ip27-irq.c    | 1 +
 arch/mips/sgi-ip30/ip30-irq.c    | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/mips/pci/pci-rt3883.c b/arch/mips/pci/pci-rt3883.c
index aebd496..c48e23c 100644
--- a/arch/mips/pci/pci-rt3883.c
+++ b/arch/mips/pci/pci-rt3883.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
diff --git a/arch/mips/pci/pci-xtalk-bridge.c b/arch/mips/pci/pci-xtalk-bridge.c
index d221694..ab9bedb 100644
--- a/arch/mips/pci/pci-xtalk-bridge.c
+++ b/arch/mips/pci/pci-xtalk-bridge.c
@@ -13,6 +13,7 @@
 #include <linux/platform_data/xtalk-bridge.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/crc16.h>
+#include <linux/irqdomain.h>
 
 #include <asm/pci/bridge.h>
 #include <asm/paccess.h>
diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
index 42df9fa..95c1bff 100644
--- a/arch/mips/sgi-ip27/ip27-irq.c
+++ b/arch/mips/sgi-ip27/ip27-irq.c
@@ -9,6 +9,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/bitops.h>
diff --git a/arch/mips/sgi-ip30/ip30-irq.c b/arch/mips/sgi-ip30/ip30-irq.c
index e8374e4..ba87704 100644
--- a/arch/mips/sgi-ip30/ip30-irq.c
+++ b/arch/mips/sgi-ip30/ip30-irq.c
@@ -6,6 +6,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/percpu.h>
 #include <linux/spinlock.h>
 #include <linux/tick.h>
