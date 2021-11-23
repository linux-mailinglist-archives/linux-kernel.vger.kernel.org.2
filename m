Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9A545A744
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 17:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238780AbhKWQOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 11:14:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51576 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238779AbhKWQOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637683857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zKa8ZUFo4xy2ejTxRVJ7dQpSqytToaSdfIyOgQL0cDw=;
        b=NdqYx2rGFC09jmlSaSlq6YsPWqpYpBQ9jaMYQDZKvV1UPhIldQp9YycsFLnpaIGGaJpgk3
        4xyUKvRcBAVNkeiToiLFksn1CxpuJEZo/oL8XPdgddhiACaiXP0ouu7bYg/VuJJwpqrpTr
        u8xzbbG51CgwPIuq9nJhK3j87e6jF10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-2AxzFmK1MsusrrIldq5tzQ-1; Tue, 23 Nov 2021 11:10:54 -0500
X-MC-Unique: 2AxzFmK1MsusrrIldq5tzQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93C4E8799EB;
        Tue, 23 Nov 2021 16:10:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 500D760843;
        Tue, 23 Nov 2021 16:10:50 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        iommu@lists.linux-foundation.org (open list:AMD IOMMU (AMD-VI)),
        Will Deacon <will@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 3/5] iommu/amd: x2apic mode: setup the INTX registers on mask/unmask
Date:   Tue, 23 Nov 2021 18:10:36 +0200
Message-Id: <20211123161038.48009-4-mlevitsk@redhat.com>
In-Reply-To: <20211123161038.48009-1-mlevitsk@redhat.com>
References: <20211123161038.48009-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is more logically correct and will also allow us to
to use mask/unmask logic to restore INTX setttings after
the resume from s3/s4.

Fixes: 66929812955bb ("iommu/amd: Add support for X2APIC IOMMU interrupts")

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 drivers/iommu/amd/init.c | 65 ++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index b905604f434e1..9e895bb8086a6 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2015,48 +2015,18 @@ union intcapxt {
 	};
 } __attribute__ ((packed));
 
-/*
- * There isn't really any need to mask/unmask at the irqchip level because
- * the 64-bit INTCAPXT registers can be updated atomically without tearing
- * when the affinity is being updated.
- */
-static void intcapxt_unmask_irq(struct irq_data *data)
-{
-}
-
-static void intcapxt_mask_irq(struct irq_data *data)
-{
-}
 
 static struct irq_chip intcapxt_controller;
 
 static int intcapxt_irqdomain_activate(struct irq_domain *domain,
 				       struct irq_data *irqd, bool reserve)
 {
-	struct amd_iommu *iommu = irqd->chip_data;
-	struct irq_cfg *cfg = irqd_cfg(irqd);
-	union intcapxt xt;
-
-	xt.capxt = 0ULL;
-	xt.dest_mode_logical = apic->dest_mode_logical;
-	xt.vector = cfg->vector;
-	xt.destid_0_23 = cfg->dest_apicid & GENMASK(23, 0);
-	xt.destid_24_31 = cfg->dest_apicid >> 24;
-
-	/**
-	 * Current IOMMU implemtation uses the same IRQ for all
-	 * 3 IOMMU interrupts.
-	 */
-	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_EVT_OFFSET);
-	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_PPR_OFFSET);
-	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_GALOG_OFFSET);
 	return 0;
 }
 
 static void intcapxt_irqdomain_deactivate(struct irq_domain *domain,
 					  struct irq_data *irqd)
 {
-	intcapxt_mask_irq(irqd);
 }
 
 
@@ -2090,6 +2060,38 @@ static void intcapxt_irqdomain_free(struct irq_domain *domain, unsigned int virq
 	irq_domain_free_irqs_top(domain, virq, nr_irqs);
 }
 
+
+static void intcapxt_unmask_irq(struct irq_data *irqd)
+{
+	struct amd_iommu *iommu = irqd->chip_data;
+	struct irq_cfg *cfg = irqd_cfg(irqd);
+	union intcapxt xt;
+
+	xt.capxt = 0ULL;
+	xt.dest_mode_logical = apic->dest_mode_logical;
+	xt.vector = cfg->vector;
+	xt.destid_0_23 = cfg->dest_apicid & GENMASK(23, 0);
+	xt.destid_24_31 = cfg->dest_apicid >> 24;
+
+	/**
+	 * Current IOMMU implementation uses the same IRQ for all
+	 * 3 IOMMU interrupts.
+	 */
+	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_EVT_OFFSET);
+	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_PPR_OFFSET);
+	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_GALOG_OFFSET);
+}
+
+static void intcapxt_mask_irq(struct irq_data *irqd)
+{
+	struct amd_iommu *iommu = irqd->chip_data;
+
+	writeq(0, iommu->mmio_base + MMIO_INTCAPXT_EVT_OFFSET);
+	writeq(0, iommu->mmio_base + MMIO_INTCAPXT_PPR_OFFSET);
+	writeq(0, iommu->mmio_base + MMIO_INTCAPXT_GALOG_OFFSET);
+}
+
+
 static int intcapxt_set_affinity(struct irq_data *irqd,
 				 const struct cpumask *mask, bool force)
 {
@@ -2099,8 +2101,7 @@ static int intcapxt_set_affinity(struct irq_data *irqd,
 	ret = parent->chip->irq_set_affinity(parent, mask, force);
 	if (ret < 0 || ret == IRQ_SET_MASK_OK_DONE)
 		return ret;
-
-	return intcapxt_irqdomain_activate(irqd->domain, irqd, false);
+	return 0;
 }
 
 static struct irq_chip intcapxt_controller = {
-- 
2.26.3

