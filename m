Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F83B3D9EBE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 09:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbhG2HhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 03:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbhG2HhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 03:37:07 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09925C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 00:37:01 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id k4-20020a17090a5144b02901731c776526so14235237pjm.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 00:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SgHbu3tMTHOy7IChbgoZTQ5vjXNI+mK0lFYbbm8GCdE=;
        b=Oy6yWlXHMrfy3zBPXQxVHL9srAcL5tb4tX355YCZNy2nPMWaqC8BrzwuasIAFFH9S7
         watwGhDzLGa+Ky5sNJTYR8whncuLuG1IGgEMkcThhqBb81rgf+uDiUFszllkGOToE8y+
         0mtw0y+hdo6MP5u4vemUhKcEvflNJhX2Ltm2KgYrzQux0QVPiojF3k0TmIK1pg1I3Mnh
         AjNys8KGzkZHkrUW0wn4uoAwsatkZS0uAaoOicZpGVigHx1r5Xf7HpibHAsjusxiCsaz
         cNo+QnJeXBtRJEhc2WjG38Ks8ZAGvjb7jp0B4EjzymMXmPC2lIwLzh/wRDaboLC8nwz9
         vLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SgHbu3tMTHOy7IChbgoZTQ5vjXNI+mK0lFYbbm8GCdE=;
        b=jNbuXWyH5ADjbPh3dRWKQP8BKIyxvhIwftpD2nShYeHUotZ2zLtwnfXz8nr98To3QV
         XCU1GHRJ4q370uLhkUrEfABozqSaNzc7Dk1ewrIKXlhrrL7hQb1pSniWmZIoKOeOrtpa
         c9krC3+buXuXGBJM4TUdrE19PvWP0nl1RNKY5TAQwL4mPQavWrGXAJoWWfpVazOnXQW8
         IvnPgB6SEPJMWFswaI1UEr07ZdEcw2eVRh02aRzOmywYzgTJPqSVQEWKwUBgU3Yk2xD6
         caOsBGUcOx3y09dTjX7nhWmOgVT/isEpPFNoWYvL9JGR9f1sjoWjPEY1LeTivSS4GP9J
         cpAQ==
X-Gm-Message-State: AOAM532WqeAD0A7dgp+pO796BvbgBjSkzWk33rZ+VHMWZ2/MU6Qly30S
        BQR2JlUlM3tBDBugUE8BNE7x
X-Google-Smtp-Source: ABdhPJwsbXQpND6LONTrHoODVkB9mQ3Qv1rrgGR9uQhoSpZ92b6jL4Lx0KtyGG9DB/Bt0yNIEdaluA==
X-Received: by 2002:aa7:810b:0:b029:2fe:decd:c044 with SMTP id b11-20020aa7810b0000b02902fedecdc044mr3798233pfi.15.1627544220584;
        Thu, 29 Jul 2021 00:37:00 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id a4sm2465107pfk.5.2021.07.29.00.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 00:37:00 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com, joe@perches.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 12/17] vdpa: Add an opaque pointer for vdpa_config_ops.dma_map()
Date:   Thu, 29 Jul 2021 15:34:58 +0800
Message-Id: <20210729073503.187-13-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729073503.187-1-xieyongji@bytedance.com>
References: <20210729073503.187-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an opaque pointer for DMA mapping.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 6 +++---
 drivers/vhost/vdpa.c             | 2 +-
 include/linux/vdpa.h             | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 72167963421b..f456f4baf86d 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -542,14 +542,14 @@ static int vdpasim_set_map(struct vdpa_device *vdpa,
 }
 
 static int vdpasim_dma_map(struct vdpa_device *vdpa, u64 iova, u64 size,
-			   u64 pa, u32 perm)
+			   u64 pa, u32 perm, void *opaque)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 	int ret;
 
 	spin_lock(&vdpasim->iommu_lock);
-	ret = vhost_iotlb_add_range(vdpasim->iommu, iova, iova + size - 1, pa,
-				    perm);
+	ret = vhost_iotlb_add_range_ctx(vdpasim->iommu, iova, iova + size - 1,
+					pa, perm, opaque);
 	spin_unlock(&vdpasim->iommu_lock);
 
 	return ret;
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 9a00b560abad..05536ada6d93 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -578,7 +578,7 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
 		return r;
 
 	if (ops->dma_map) {
-		r = ops->dma_map(vdpa, iova, size, pa, perm);
+		r = ops->dma_map(vdpa, iova, size, pa, perm, NULL);
 	} else if (ops->set_map) {
 		if (!v->in_batch)
 			r = ops->set_map(vdpa, dev->iotlb);
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index d1a80ef05089..4655afc1359b 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -268,7 +268,7 @@ struct vdpa_config_ops {
 	/* DMA ops */
 	int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb *iotlb);
 	int (*dma_map)(struct vdpa_device *vdev, u64 iova, u64 size,
-		       u64 pa, u32 perm);
+		       u64 pa, u32 perm, void *opaque);
 	int (*dma_unmap)(struct vdpa_device *vdev, u64 iova, u64 size);
 
 	/* Free device resources */
-- 
2.11.0

