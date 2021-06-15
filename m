Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C78A3A827E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 16:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhFOOTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 10:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbhFOOSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:18:03 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91433C061158
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 07:14:12 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ei4so11862326pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 07:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WWAi/i4+n9XG5D57vjCca2tNocYxaQJOYj5KH2bJ384=;
        b=0kIA76yEil4BDyN3USnHD3/M8FrPXcpFiBtM5SrfGm4D/hRLIWWQevjzMrmXkvkdwU
         /I8AKMWCkHdw2qTuchBfN/PK2PZZLJMcsPq6LBQFkREk6RWRwnzts6osF//EZXIafzq0
         annTM6mRM+CObk1LmodpcuGI18iPMdrO+f07wL2i7sL4hExnopN7djnuXypf9qHNytXJ
         GbZ58bvDW/a2OGejh65bmDZlKAV+279i3TTA8RA+It3vMuXrP07HIIzP9P/tUf0O5Ghx
         ygd5K2GEyaRP+PSFqmHdZRFnbeBqy6jOJ+pho5sg6ufX4iyz0SatX81p0eMgUcrnXIGv
         ohrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WWAi/i4+n9XG5D57vjCca2tNocYxaQJOYj5KH2bJ384=;
        b=IDl4KXdQIk8O+MjikIXne+qGiSfiX6C9TJhSlQDPz3xcJHwKyOqhG8u2w+83Lf6a8s
         4AYvpcPdm3T2bkIkM3Fm6kbycu1ACir/AKQ5m3+mMqmnamoK1ogWMCu9QmftFfA3Pn9q
         VI8NA9EUHQg9xdxPnh2kzl6KrrXzQKKvOcgfFfdY3n657ZESz2bighdXc+LjtEo9vOEe
         WfgbosZJZUvuRDekr2yeLuXQVZl/+O9M1OK1Vte3DN3up35Vn0TdfQ4lqh7QDApdH+lE
         XclGQNMUVc4gwwV8yldiKZrm5IHAMuhHoc/cn87B9MlGNC8YPkbV3BgIWQLB/9Wg5VBA
         a1xA==
X-Gm-Message-State: AOAM533rOsOilBuGb0f8qTHf98J6hD9XwrU0TuQ82tzqVHR9/RoSpaXC
        RiAksIXagz+MAwbngoC+HqDp
X-Google-Smtp-Source: ABdhPJwW+q5dHWJSz6MNIvxr3iew20vYFe9rQ1otKyLj3TsWzRln7lNFm51HBugcs9X5HKNDyYkcuA==
X-Received: by 2002:a17:90a:6482:: with SMTP id h2mr5018877pjj.188.1623766451749;
        Tue, 15 Jun 2021 07:14:11 -0700 (PDT)
Received: from localhost ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id f18sm2692741pjq.48.2021.06.15.07.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 07:14:11 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 04/10] vhost-iotlb: Add an opaque pointer for vhost IOTLB
Date:   Tue, 15 Jun 2021 22:13:25 +0800
Message-Id: <20210615141331.407-5-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210615141331.407-1-xieyongji@bytedance.com>
References: <20210615141331.407-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an opaque pointer for vhost IOTLB. And introduce
vhost_iotlb_add_range_ctx() to accept it.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/iotlb.c       | 20 ++++++++++++++++----
 include/linux/vhost_iotlb.h |  3 +++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/iotlb.c b/drivers/vhost/iotlb.c
index 0fd3f87e913c..5c99e1112cbb 100644
--- a/drivers/vhost/iotlb.c
+++ b/drivers/vhost/iotlb.c
@@ -36,19 +36,21 @@ void vhost_iotlb_map_free(struct vhost_iotlb *iotlb,
 EXPORT_SYMBOL_GPL(vhost_iotlb_map_free);
 
 /**
- * vhost_iotlb_add_range - add a new range to vhost IOTLB
+ * vhost_iotlb_add_range_ctx - add a new range to vhost IOTLB
  * @iotlb: the IOTLB
  * @start: start of the IOVA range
  * @last: last of IOVA range
  * @addr: the address that is mapped to @start
  * @perm: access permission of this range
+ * @opaque: the opaque pointer for the new mapping
  *
  * Returns an error last is smaller than start or memory allocation
  * fails
  */
-int vhost_iotlb_add_range(struct vhost_iotlb *iotlb,
-			  u64 start, u64 last,
-			  u64 addr, unsigned int perm)
+int vhost_iotlb_add_range_ctx(struct vhost_iotlb *iotlb,
+			      u64 start, u64 last,
+			      u64 addr, unsigned int perm,
+			      void *opaque)
 {
 	struct vhost_iotlb_map *map;
 
@@ -71,6 +73,7 @@ int vhost_iotlb_add_range(struct vhost_iotlb *iotlb,
 	map->last = last;
 	map->addr = addr;
 	map->perm = perm;
+	map->opaque = opaque;
 
 	iotlb->nmaps++;
 	vhost_iotlb_itree_insert(map, &iotlb->root);
@@ -80,6 +83,15 @@ int vhost_iotlb_add_range(struct vhost_iotlb *iotlb,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(vhost_iotlb_add_range_ctx);
+
+int vhost_iotlb_add_range(struct vhost_iotlb *iotlb,
+			  u64 start, u64 last,
+			  u64 addr, unsigned int perm)
+{
+	return vhost_iotlb_add_range_ctx(iotlb, start, last,
+					 addr, perm, NULL);
+}
 EXPORT_SYMBOL_GPL(vhost_iotlb_add_range);
 
 /**
diff --git a/include/linux/vhost_iotlb.h b/include/linux/vhost_iotlb.h
index 6b09b786a762..2d0e2f52f938 100644
--- a/include/linux/vhost_iotlb.h
+++ b/include/linux/vhost_iotlb.h
@@ -17,6 +17,7 @@ struct vhost_iotlb_map {
 	u32 perm;
 	u32 flags_padding;
 	u64 __subtree_last;
+	void *opaque;
 };
 
 #define VHOST_IOTLB_FLAG_RETIRE 0x1
@@ -29,6 +30,8 @@ struct vhost_iotlb {
 	unsigned int flags;
 };
 
+int vhost_iotlb_add_range_ctx(struct vhost_iotlb *iotlb, u64 start, u64 last,
+			      u64 addr, unsigned int perm, void *opaque);
 int vhost_iotlb_add_range(struct vhost_iotlb *iotlb, u64 start, u64 last,
 			  u64 addr, unsigned int perm);
 void vhost_iotlb_del_range(struct vhost_iotlb *iotlb, u64 start, u64 last);
-- 
2.11.0

