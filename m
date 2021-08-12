Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7652F3EA73D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238437AbhHLPNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237870AbhHLPN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:13:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CC0C0613D9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 08:13:02 -0700 (PDT)
Date:   Thu, 12 Aug 2021 15:12:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628781179;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QsvYt24PDkSjkCqMAIAFauZzmrqQaFhV6WKi/7VXeU=;
        b=Rk+j8FLvGiHaDY3kPPRHB0mdwWPsOL17D3uIdfptrPcW+z161I5/4s1VntRchbMuKOUItv
        YxnHTX17YCGXdVPXt2q7VcOKBeqdd8Ik1HweJMMedKkL/9pv/3yjxEv4iE6jDOXB8mPQEP
        SOKSyzT2q4bSFWjZDv+D3wmUh1DwUVAwLfiv8zpMaf6WeVnb3v8T3Yw3ZMpDGG4qss634T
        SeNjIqPt4AZq1H7C9pd8UBSr0e/hn1S8b0V87XYkO3Eh0XxVTqW+qHK6qcX9bfgz9LxDuE
        HGv7Q1ocXHrUPrvZys2WRLLzwjHKxI5VeGEwkx5YvdCvxTrS2y093JfRc/iIpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628781179;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QsvYt24PDkSjkCqMAIAFauZzmrqQaFhV6WKi/7VXeU=;
        b=qzEE5KgKkGqxKb0QmUvMznGrXow416kmZF2EkNrzwrXdti9ltAjF7dz8iKBGoop6a8q3M+
        56Y00NQN/mgitOCQ==
From:   "irqchip-bot for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic: Add .irq_ack() to GIC-based irqchips
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210629125010.458872-12-valentin.schneider@arm.com>
References: <20210629125010.458872-12-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <162878117885.395.6124047796117034466.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     ff41d1016e84102a4363f9e85945a7404cf11cb7
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/ff41d1016e84102a4363f9e85945a7404cf11cb7
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Tue, 29 Jun 2021 13:50:08 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 12 Aug 2021 15:48:21 +01:00

irqchip/gic: Add .irq_ack() to GIC-based irqchips

Subsequent patches will make the GIC IRQs use a flow handler that issues an
irq_ack(), thus irqchips of child domains need to have an .irq_ack() of
their own.

Most cases are covered by the default MSI callbacks, but nexus domains and
other non-MSI domains still need tending do.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210629125010.458872-12-valentin.schneider@arm.com
---
 drivers/irqchip/irq-gic-v2m.c    | 1 +
 drivers/irqchip/irq-gic-v3-its.c | 3 +++
 drivers/irqchip/irq-gic-v3-mbi.c | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 27a97c7..b8cf3ff 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -126,6 +126,7 @@ static struct irq_chip gicv2m_irq_chip = {
 	.name			= "GICv2m",
 	.irq_mask		= irq_chip_mask_parent,
 	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_ack		= irq_chip_ack_parent,
 	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 	.irq_compose_msi_msg	= gicv2m_compose_msi_msg,
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index ba39668..8a372ac 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1976,6 +1976,7 @@ static struct irq_chip its_irq_chip = {
 	.name			= "ITS",
 	.irq_mask		= its_mask_irq,
 	.irq_unmask		= its_unmask_irq,
+	.irq_ack		= irq_chip_ack_parent,
 	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_set_affinity	= its_set_affinity,
 	.irq_compose_msi_msg	= its_irq_compose_msi_msg,
@@ -3997,6 +3998,7 @@ static struct irq_chip its_vpe_irq_chip = {
 	.name			= "GICv4-vpe",
 	.irq_mask		= its_vpe_mask_irq,
 	.irq_unmask		= its_vpe_unmask_irq,
+	.irq_ack		= irq_chip_ack_parent,
 	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_set_affinity	= its_vpe_set_affinity,
 	.irq_retrigger		= its_vpe_retrigger,
@@ -4152,6 +4154,7 @@ static struct irq_chip its_vpe_4_1_irq_chip = {
 	.name			= "GICv4.1-vpe",
 	.irq_mask		= its_vpe_4_1_mask_irq,
 	.irq_unmask		= its_vpe_4_1_unmask_irq,
+	.irq_ack		= irq_chip_ack_parent,
 	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_set_affinity	= its_vpe_set_affinity,
 	.irq_set_vcpu_affinity	= its_vpe_4_1_set_vcpu_affinity,
diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index a69ac29..b0e919f 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -33,6 +33,7 @@ static struct irq_chip mbi_irq_chip = {
 	.name			= "MBI",
 	.irq_mask		= irq_chip_mask_parent,
 	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_ack		= irq_chip_ack_parent,
 	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_set_type		= irq_chip_set_type_parent,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
