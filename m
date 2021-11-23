Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C413545A745
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 17:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238792AbhKWQOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 11:14:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33069 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238773AbhKWQOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:14:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637683859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9jPW+WKBoU8cMQJCk9QAE8DV8VVxJ4t74Xc1vlfEknk=;
        b=Qidt40gbZJKVaLq8zE+2YgUdJDlBxWy67WNE5rkNGp5DWubTXrMqzZuDZX7sE5DhYYlFzb
        N8ERQLI4cniG2hlEFoho5aZ6w9UX25YWPyk+Y8dEiV1MfQASES2MPjplbjaXWb5pRm763x
        y5ED0LCG7ga3jE+fbbeOYfhGB0AJWVY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-o45FhOIrOW6NTahcy1bRKQ-1; Tue, 23 Nov 2021 11:10:56 -0500
X-MC-Unique: o45FhOIrOW6NTahcy1bRKQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E99419200C0;
        Tue, 23 Nov 2021 16:10:55 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A11D60843;
        Tue, 23 Nov 2021 16:10:52 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        iommu@lists.linux-foundation.org (open list:AMD IOMMU (AMD-VI)),
        Will Deacon <will@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 4/5] iommu/amd: x2apic mode: mask/unmask interrupts on suspend/resume
Date:   Tue, 23 Nov 2021 18:10:37 +0200
Message-Id: <20211123161038.48009-5-mlevitsk@redhat.com>
In-Reply-To: <20211123161038.48009-1-mlevitsk@redhat.com>
References: <20211123161038.48009-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use IRQCHIP_MASK_ON_SUSPEND to make the core irq code to
mask the iommu interrupt on suspend and unmask it on the resume.

Since now the unmask function updates the INTX settings,
that will restore them on resume from s3/s4.

Since IRQCHIP_MASK_ON_SUSPEND is only effective for interrupts
which are not wakeup sources, remove IRQCHIP_SKIP_SET_WAKE flag
and instead implement a dummy .irq_set_wake which doesn't allow
the interrupt to become a wakeup source.

Fixes: 66929812955bb ("iommu/amd: Add support for X2APIC IOMMU interrupts")

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 drivers/iommu/amd/init.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 9e895bb8086a6..b94822fc2c9f7 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2104,6 +2104,11 @@ static int intcapxt_set_affinity(struct irq_data *irqd,
 	return 0;
 }
 
+static int intcapxt_set_wake(struct irq_data *irqd, unsigned int on)
+{
+	return on ? -EOPNOTSUPP : 0;
+}
+
 static struct irq_chip intcapxt_controller = {
 	.name			= "IOMMU-MSI",
 	.irq_unmask		= intcapxt_unmask_irq,
@@ -2111,7 +2116,8 @@ static struct irq_chip intcapxt_controller = {
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_affinity       = intcapxt_set_affinity,
-	.flags			= IRQCHIP_SKIP_SET_WAKE,
+	.irq_set_wake		= intcapxt_set_wake,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND,
 };
 
 static const struct irq_domain_ops intcapxt_domain_ops = {
-- 
2.26.3

