Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C243E9F4F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 09:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbhHLHOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 03:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbhHLHOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 03:14:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF06C061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 00:13:56 -0700 (PDT)
Date:   Thu, 12 Aug 2021 07:13:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628752434;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wSU10qT3DMgVSNGe799XJTHSBdCa03pVioh4XAXxAkg=;
        b=heJv2+boZqbvn1nFwB4+ZBSaaM5Vy80L8bIEM+rsb1HGW3WxxeOkt0pjdJdFPqY98JA5vD
        oG2xoL7mm+cn+UVnDmi8bORvsOkWGoEHFyyOW6ImxXA6a5zVxt7Ij2J44FYYoSTfP6rZFr
        qspTeGho1333ijOshtbsRVNvmxXKsek4Sl/avdrm2I+KaKUQRkwhAolKQ+Hg1zhLJsP6wh
        pxSTR2MR5MYuVrkiznoOcBtYK9mQNt2+L1v08CRPkFxKrse1VYRD79KUbPob/aDTPrIAHu
        9eUeWfsAfrkJHJY3RFPF5sQQxLDBlUe7i9VW2dMBfZugr/Y+EwZycGoBkzRRLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628752434;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wSU10qT3DMgVSNGe799XJTHSBdCa03pVioh4XAXxAkg=;
        b=74b/qbFksF3HxlcxcxR1Rl7z4QShSx581P6rCsIHoqfE3dRF3Lmc0kPadFI8OWipJ1gDAL
        aTDS115DJKVWyXCA==
From:   "irqchip-bot for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v3: Add __gic_get_ppi_index()
 to find the PPI number from hwirq
Cc:     James Morse <james.morse@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210729172748.28841-2-james.morse@arm.com>
References: <20210729172748.28841-2-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <162875243344.395.15450411113319650076.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     bfa80ee9ce6e2f18da76459c3dd7b0ad57fb2c20
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/bfa80ee9ce6e2f18da76459c3dd7b0ad57fb2c20
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Thu, 29 Jul 2021 17:27:47 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 12 Aug 2021 08:11:03 +01:00

irqchip/gic-v3: Add __gic_get_ppi_index() to find the PPI number from hwirq

gic_get_ppi_index() is a useful concept for ppi partitions, as the GIC
has two PPI ranges but needs mapping to a single range when used as an
index in the gic_data.ppi_descs[] array.

Add a double-underscore version which takes just the intid. This will
be used in the partition domain select and translate helpers to enable
partition support for the EPPI range.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210729172748.28841-2-james.morse@arm.com
---
 drivers/irqchip/irq-gic-v3.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index e0f4deb..b24f0a9 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -446,18 +446,23 @@ static void gic_irq_set_prio(struct irq_data *d, u8 prio)
 	writeb_relaxed(prio, base + offset + index);
 }
 
-static u32 gic_get_ppi_index(struct irq_data *d)
+static u32 __gic_get_ppi_index(irq_hw_number_t hwirq)
 {
-	switch (get_intid_range(d)) {
+	switch (__get_intid_range(hwirq)) {
 	case PPI_RANGE:
-		return d->hwirq - 16;
+		return hwirq - 16;
 	case EPPI_RANGE:
-		return d->hwirq - EPPI_BASE_INTID + 16;
+		return hwirq - EPPI_BASE_INTID + 16;
 	default:
 		unreachable();
 	}
 }
 
+static u32 gic_get_ppi_index(struct irq_data *d)
+{
+	return __gic_get_ppi_index(d->hwirq);
+}
+
 static int gic_irq_nmi_setup(struct irq_data *d)
 {
 	struct irq_desc *desc = irq_to_desc(d->irq);
