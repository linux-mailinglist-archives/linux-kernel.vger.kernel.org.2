Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F9E39CF22
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhFFMqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:46:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35032 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhFFMpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:45:44 -0400
Date:   Sun, 06 Jun 2021 12:43:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622983434;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=NBwP1yqUdmI0CvmxGPG6G43pIoyDgTdTbzFxVB5DOB4=;
        b=WdFrOz+LwDhceG41n98MY2sC1v4skqxpKO8vTuC9WHD4kOoQi9+ZDQFgzbjbwjF8RdZYrr
        qMuHNTtSC9ziuV8pov/QXEAC6vmldVUV3m1+/CuxKDRs7ohb69RbX+aFm6/pQGlUzqgrqO
        fBlwIYQPyAhgZc76O2/e0Pb+Qdg2tkU0I93qyVe4W3skh2EcZ6bDMAN59hOq/aMtzLnUWa
        eGJVvk4RbP4XDG1bsieCUe6STscvD4H2sHZ2Uqyr5ahT8hesSby5BpC/IDTNTD9vdxAdA9
        Ir2D4qIA6nbwTRjqxqKLxTPA456RMFCd9yHWy4FjeT69CSpO9rSZNLpryGg3ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622983434;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=NBwP1yqUdmI0CvmxGPG6G43pIoyDgTdTbzFxVB5DOB4=;
        b=IvqYiVPfrGv4UZwcO2fqe9iUwDh20AkYntv6nn8jmO95QFVe90E1eqZQ1k3PAMUdcXsD0U
        BuqOxY8k6R23rYCw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] MIPS: Add missing linux/irqdomain.h includes
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162298343353.29796.3452553110838117331.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     6e77c9ab5e18135da8efce8668e08b3213bf54f6
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/6e77c9ab5e18135da8efce8668e08b3213bf54f6
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 19 May 2021 09:01:06 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 02 Jun 2021 14:34:47 +01:00

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
