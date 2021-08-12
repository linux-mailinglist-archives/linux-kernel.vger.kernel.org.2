Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5E23EA73C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238418AbhHLPNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237853AbhHLPN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:13:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D106BC0617A8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 08:13:02 -0700 (PDT)
Date:   Thu, 12 Aug 2021 15:12:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628781180;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mojkBfzBwz+vPbSA3TWx+c/44r/ez3loYFfSHD7KkQw=;
        b=bsJMzuBHib/dDHcIcTGxJINwsJJ6QoRNxLJXnA+ygoEjOVGpug9Ujvd1VpTwcV89Fy4N3+
        x4QdLO22PHxkkBliBGYCKI5JwsMVxQ+et+dl5mEYjOq/yRegOc7cNr4x68h/Qua2jjzPBm
        BfNFAE6ccZ5G92BM2lamIkA+pCgJQmADTmIIUn8dz9ryTOgh89wdkdH8MLzj604fpE4XwV
        33KfAMAQTbpg9k/TRrnlRVgeiRB5h+jJz3FgDvunAGFPh9wLPHjJEQ/6D5gcXVSp2zkUy+
        m2p7XQIIVuOVJkcmTzm0Zrh6mstZu4+pz/po3RWzROOF4AsR2oyR6Hb3CxvHMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628781180;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mojkBfzBwz+vPbSA3TWx+c/44r/ez3loYFfSHD7KkQw=;
        b=9wHwH/1uAf44yfjN4HycejyX/q7VhppYYvRHinS8barvfmMUIgcGznWQfiZoYuZPQzxZTX
        veLAxADWtDtUGRAw==
From:   "irqchip-bot for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic: Rely on MSI default .irq_eoi()
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210629125010.458872-10-valentin.schneider@arm.com>
References: <20210629125010.458872-10-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <162878117996.395.16906498509019036322.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     5a06c146b3af41e54add239cfda57e7d20f83026
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/5a06c146b3af41e54add239cfda57e7d20f83026
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Tue, 29 Jun 2021 13:50:06 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 12 Aug 2021 15:48:21 +01:00

irqchip/gic: Rely on MSI default .irq_eoi()

Previously, only platform-MSI irqchips would get a default .irq_eoi().
GIC-based platform-MSI irqchip's rely on this default callback, while
PCI-MSI ones are initialized explicitly.

As all MSI domains now get a default .irq_eoi(), drop the explicit
.irq_eoi() initialization for PCI-MSI chips.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210629125010.458872-10-valentin.schneider@arm.com
---
 drivers/irqchip/irq-gic-v2m.c               | 1 -
 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c | 1 -
 drivers/irqchip/irq-gic-v3-its-pci-msi.c    | 1 -
 drivers/irqchip/irq-gic-v3-mbi.c            | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index be9ea6f..27a97c7 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -87,7 +87,6 @@ static struct irq_chip gicv2m_msi_irq_chip = {
 	.name			= "MSI",
 	.irq_mask		= gicv2m_mask_msi_irq,
 	.irq_unmask		= gicv2m_unmask_msi_irq,
-	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_write_msi_msg	= pci_msi_domain_write_msg,
 };
 
diff --git a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
index 634263d..105ee64 100644
--- a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
@@ -21,7 +21,6 @@ static struct irq_chip its_msi_irq_chip = {
 	.name = "ITS-fMSI",
 	.irq_mask = irq_chip_mask_parent,
 	.irq_unmask = irq_chip_unmask_parent,
-	.irq_eoi = irq_chip_eoi_parent,
 	.irq_set_affinity = msi_domain_set_affinity
 };
 
diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index ad2810c..14f6e63 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -27,7 +27,6 @@ static struct irq_chip its_msi_irq_chip = {
 	.name			= "ITS-MSI",
 	.irq_unmask		= its_unmask_msi_irq,
 	.irq_mask		= its_mask_msi_irq,
-	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_write_msi_msg	= pci_msi_domain_write_msg,
 };
 
diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index e81e89a..a69ac29 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -169,7 +169,6 @@ static struct irq_chip mbi_msi_irq_chip = {
 	.name			= "MSI",
 	.irq_mask		= mbi_mask_msi_irq,
 	.irq_unmask		= mbi_unmask_msi_irq,
-	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_compose_msi_msg	= mbi_compose_msi_msg,
 	.irq_write_msi_msg	= pci_msi_domain_write_msg,
 };
