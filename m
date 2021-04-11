Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E4F35B3DC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 13:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbhDKLta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 07:49:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32364 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235655AbhDKLtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 07:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618141745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eoPbERNhESa9Dxlr9x/plm56UnWJAHrsP8faBnbYRQI=;
        b=dmyIr7EAMtsjGwvdYImH5brVlw860KSjOnruaaoNXSjc+nTTGPujPIdqxoBktTvn3sLEE7
        +hXsN/+/tiW04nMyYbT4onwIz+7UxdD9/Vj4YCZ5Q197neVOuLwfjekqvTLBCkoNpD+Wpm
        SCEYXS1J70molmfyjapXxG9pFy7V7uM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-zFb_Em98MCyB1VWU0-3lvQ-1; Sun, 11 Apr 2021 07:49:00 -0400
X-MC-Unique: zFb_Em98MCyB1VWU0-3lvQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E5DC81744F;
        Sun, 11 Apr 2021 11:48:58 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-112-22.ams2.redhat.com [10.36.112.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E44C5C266;
        Sun, 11 Apr 2021 11:48:50 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, will@kernel.org,
        maz@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        alex.williamson@redhat.com, tn@semihalf.com, zhukeqian1@huawei.com
Cc:     jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        wangxingang5@huawei.com, jean-philippe@linaro.org,
        zhangfei.gao@linaro.org, zhangfei.gao@gmail.com,
        vivek.gautam@arm.com, shameerali.kolothum.thodi@huawei.com,
        yuzenghui@huawei.com, nicoleotsuka@gmail.com,
        lushenming@huawei.com, vsethi@nvidia.com,
        chenxiang66@hisilicon.com, vdumpa@nvidia.com,
        jiangkunkun@huawei.com
Subject: [PATCH v13 09/13] vfio: Add new IRQ for DMA fault reporting
Date:   Sun, 11 Apr 2021 13:46:55 +0200
Message-Id: <20210411114659.15051-10-eric.auger@redhat.com>
In-Reply-To: <20210411114659.15051-1-eric.auger@redhat.com>
References: <20210411114659.15051-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new IRQ type/subtype to get notification on nested
stage DMA faults.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/uapi/linux/vfio.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 0728b6f3f348..ad7c275b4074 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -729,6 +729,9 @@ struct vfio_irq_info_cap_type {
 	__u32 subtype;  /* type specific */
 };
 
+#define VFIO_IRQ_TYPE_NESTED				(1)
+#define VFIO_IRQ_SUBTYPE_DMA_FAULT			(1)
+
 /**
  * VFIO_DEVICE_SET_IRQS - _IOW(VFIO_TYPE, VFIO_BASE + 10, struct vfio_irq_set)
  *
-- 
2.26.3

