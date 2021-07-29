Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6763D9E8F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 09:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbhG2HgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 03:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbhG2HgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 03:36:16 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF08C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 00:36:13 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n10so5959716plf.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 00:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ezTwUwcHdLzbLJ6Qex8t9bSwQh5nV4gM1nW+onIqamc=;
        b=aJeeKmO1iUSf5ulfQYOmU/f6LrJOJ/xpojaG8sp5MHHhsHcHMnmIPAHKBLhJjNXk9I
         SdMsytyS3rpG7e6wxN4paTE8aVeoxADQ2Qq2VajHXG4r7NSce8dZXAAfl9JaBWANBaRx
         62S32j4gMEjGzd6F2uS/UK4OCyD90ujkUW/g8osNQTriob7uuqrBY8QD40XGCDT+tN2r
         S96uxeNvFTeXzWXlZhJR4HK9PQRPgGSR4ZaMIRepsa9zFFjt3FCL/aHCfKqU1O86lhtV
         BKjZynlYbYg8IdfiD8WOoifTvfmhUBkRhWKiO7j2lB54h5a/mglAbeZ0WzkX2aAkZUz9
         Nm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ezTwUwcHdLzbLJ6Qex8t9bSwQh5nV4gM1nW+onIqamc=;
        b=nfa4IPX4i+te7H5xwUWE9Rs76eNceHCiGXRuTHPeMLqAYVdTL4IdRFDmnBf6M006VY
         0TyvOi1MQ0LCv4+YrJFdn+dJdEoPk2rnHPpBqjFJE/vDfQ0lUpxiLqIyU7zKO7SGsm2e
         +BgUJp7+30Fdx6Ryk8D5S9Gv9pXiQ4+kv1zR8N06r05ObHyF8fZ61cQuMZBagRNLXdjx
         MINAy+UlvxIHCezuPMtKWzejNRMnzQFv3a5o8gZCse1TaYNdi0sf4Eaj2vRLccS3goTa
         yEqfv8VlGmx3R8PjLIqvkyQpNHZ6FoQRw8vkQvaczaoEijcE+VHeMlgxt13VBTKFrUgF
         bWwQ==
X-Gm-Message-State: AOAM533xuDAWW3wIQlrJgmTVeUXO1gQ8fkuBHDRTkli/q1mmx8fY3qcO
        hMwCveEv80apcyuG6bscaJur
X-Google-Smtp-Source: ABdhPJy5HgYXGcMdvwyyUChEjHwAKCF6yZJqkhXxctPNS68GNGc1IbWVQnCkOAkuA+3j2foct0eGxg==
X-Received: by 2002:a17:902:a9c6:b029:129:8fdb:698f with SMTP id b6-20020a170902a9c6b02901298fdb698fmr3526952plr.15.1627544173432;
        Thu, 29 Jul 2021 00:36:13 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id y10sm2148879pjy.18.2021.07.29.00.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 00:36:12 -0700 (PDT)
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
Subject: [PATCH v10 03/17] vdpa: Fix code indentation
Date:   Thu, 29 Jul 2021 15:34:49 +0800
Message-Id: <20210729073503.187-4-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729073503.187-1-xieyongji@bytedance.com>
References: <20210729073503.187-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use tabs to indent the code instead of spaces.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 include/linux/vdpa.h | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 7c49bc5a2b71..406d53a606ac 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -43,17 +43,17 @@ struct vdpa_vq_state_split {
  * @last_used_idx: used index
  */
 struct vdpa_vq_state_packed {
-        u16	last_avail_counter:1;
-        u16	last_avail_idx:15;
-        u16	last_used_counter:1;
-        u16	last_used_idx:15;
+	u16	last_avail_counter:1;
+	u16	last_avail_idx:15;
+	u16	last_used_counter:1;
+	u16	last_used_idx:15;
 };
 
 struct vdpa_vq_state {
-     union {
-          struct vdpa_vq_state_split split;
-          struct vdpa_vq_state_packed packed;
-     };
+	union {
+		struct vdpa_vq_state_split split;
+		struct vdpa_vq_state_packed packed;
+	};
 };
 
 struct vdpa_mgmt_dev;
@@ -131,7 +131,7 @@ struct vdpa_iova_range {
  *				@vdev: vdpa device
  *				@idx: virtqueue index
  *				@state: pointer to returned state (last_avail_idx)
- * @get_vq_notification: 	Get the notification area for a virtqueue
+ * @get_vq_notification:	Get the notification area for a virtqueue
  *				@vdev: vdpa device
  *				@idx: virtqueue index
  *				Returns the notifcation area
@@ -342,25 +342,24 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
 
 static inline void vdpa_reset(struct vdpa_device *vdev)
 {
-        const struct vdpa_config_ops *ops = vdev->config;
+	const struct vdpa_config_ops *ops = vdev->config;
 
 	vdev->features_valid = false;
-        ops->set_status(vdev, 0);
+	ops->set_status(vdev, 0);
 }
 
 static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
 {
-        const struct vdpa_config_ops *ops = vdev->config;
+	const struct vdpa_config_ops *ops = vdev->config;
 
 	vdev->features_valid = true;
-        return ops->set_features(vdev, features);
+	return ops->set_features(vdev, features);
 }
 
-
 static inline void vdpa_get_config(struct vdpa_device *vdev, unsigned offset,
 				   void *buf, unsigned int len)
 {
-        const struct vdpa_config_ops *ops = vdev->config;
+	const struct vdpa_config_ops *ops = vdev->config;
 
 	/*
 	 * Config accesses aren't supposed to trigger before features are set.
-- 
2.11.0

