Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FD545A746
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 17:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238806AbhKWQON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 11:14:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20349 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238801AbhKWQOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:14:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637683862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E71mUjFY3RjWM0HIP3/hcl3zs2J0xxW42+7wzc1Wnwo=;
        b=DWNsLGrjLYa4HWuneRMXuE/Vx69TyI4p9uL/9D81i98mAYfTrbr6//NHp2ip2wRNc9MRtc
        ludLvZTQ9+gM6KpdPoY/p6n6Y1uFAGmkRYOc+dUakEVhSnPq0os87qrqw+1AQRKBvJrfBw
        Yvb9ADxvFzfhjozNNPUi38E7l4Oj6PY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-jDM9JcWvOpS_pGRmvPtOxA-1; Tue, 23 Nov 2021 11:10:59 -0500
X-MC-Unique: jDM9JcWvOpS_pGRmvPtOxA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 081808799EB;
        Tue, 23 Nov 2021 16:10:58 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8C5560843;
        Tue, 23 Nov 2021 16:10:55 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        iommu@lists.linux-foundation.org (open list:AMD IOMMU (AMD-VI)),
        Will Deacon <will@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 5/5] iommu/amd: remove useless irq affinity notifier
Date:   Tue, 23 Nov 2021 18:10:38 +0200
Message-Id: <20211123161038.48009-6-mlevitsk@redhat.com>
In-Reply-To: <20211123161038.48009-1-mlevitsk@redhat.com>
References: <20211123161038.48009-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iommu->intcapxt_notify field is no longer used
after a switch to a separate domain was done

Fixes: d1adcfbb520c ("iommu/amd: Fix IOMMU interrupt generation in X2APIC mode")
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 867535eb0ce97..ffc89c4fb1205 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -645,8 +645,6 @@ struct amd_iommu {
 	/* DebugFS Info */
 	struct dentry *debugfs;
 #endif
-	/* IRQ notifier for IntCapXT interrupt */
-	struct irq_affinity_notify intcapxt_notify;
 };
 
 static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
-- 
2.26.3

