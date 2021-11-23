Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04EFA45A743
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 17:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238765AbhKWQOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 11:14:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38261 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238775AbhKWQOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637683856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=txTlQZvzIrKPm17i5RnWel/dSSPMw6smr9+ZvSbE898=;
        b=Otu/dZezIaq+AcjdaeS7G41V+obSzWdA5WZDstJO+HND8pCJgGs0ucLWxbk+wVVZzcumZP
        gU4tittAb4CsDU1uyby28rjUoEOoALlQ5LPatEUAluGanlcFtFFtXaSwEbQThw9jZPJuBY
        8W0i5drg+jofNlVStjOW+TAeYymKjho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-sl-B8eFPNbai0BSRUMJHTA-1; Tue, 23 Nov 2021 11:10:51 -0500
X-MC-Unique: sl-B8eFPNbai0BSRUMJHTA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D84399F92A;
        Tue, 23 Nov 2021 16:10:49 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93AB360843;
        Tue, 23 Nov 2021 16:10:47 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        iommu@lists.linux-foundation.org (open list:AMD IOMMU (AMD-VI)),
        Will Deacon <will@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 2/5] iommu/amd: x2apic mode: re-enable after resume
Date:   Tue, 23 Nov 2021 18:10:35 +0200
Message-Id: <20211123161038.48009-3-mlevitsk@redhat.com>
In-Reply-To: <20211123161038.48009-1-mlevitsk@redhat.com>
References: <20211123161038.48009-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise it is guaranteed to not work after the resume...

Fixes: 66929812955bb ("iommu/amd: Add support for X2APIC IOMMU interrupts")

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 drivers/iommu/amd/init.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 8dae85fcfc2eb..b905604f434e1 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2172,7 +2172,6 @@ static int iommu_setup_intcapxt(struct amd_iommu *iommu)
 		return ret;
 	}
 
-	iommu_feature_enable(iommu, CONTROL_INTCAPXT_EN);
 	return 0;
 }
 
@@ -2195,6 +2194,10 @@ static int iommu_init_irq(struct amd_iommu *iommu)
 
 	iommu->int_enabled = true;
 enable_faults:
+
+	if (amd_iommu_xt_mode == IRQ_REMAP_X2APIC_MODE)
+		iommu_feature_enable(iommu, CONTROL_INTCAPXT_EN);
+
 	iommu_feature_enable(iommu, CONTROL_EVT_INT_EN);
 
 	if (iommu->ppr_log != NULL)
-- 
2.26.3

