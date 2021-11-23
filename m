Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BA345A6EF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 16:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbhKWP7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 10:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhKWP7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 10:59:48 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2BAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 07:56:39 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id a18so3211731wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 07:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rh/v7U68tKyXyQ6b3jj07z0WH7Y+IG2IvCQMWCW7whk=;
        b=OWJhcdUegx2avyXwMP3MIkRdjcVNtiP8PgBrguw2/NCr+VtjzKfv7g8GAav9ZgRhE6
         hKKpKPhMfuaY4lk61j/OGm5E5n6zlvFjdoGnSjr1CC14jxukFm3U71ud9uVSM9cdYljo
         5mtxVVa0KxYQp4NMVLG9dq6AeM8FaNUVc/bOiPa2IXSsGLXyE7dtXdK13gUl75Y+Ojqf
         Yv21GwUjp36Ed7ZzaQySv2nBH1vBvKFJeW5+87GB4eiAneJTk4t3H9EayQ0d/ymqtC3B
         wramIJtFvEBI92p2bdZP+xXzJwh0qLSgjuWs4oJJKOu/LSGFkpyzl1eKygpkuyVY2bbw
         2kkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rh/v7U68tKyXyQ6b3jj07z0WH7Y+IG2IvCQMWCW7whk=;
        b=wqRij4i5niZDjLwlG1ideYQYuTh3XCc9ALa2IR+7utvuwwUr608WZRj6S/c8qxShJz
         cprjoEo1wnaZguvuL6wO01cqEV7h9zLZc3qc7rkUCgAktnidEMXYWKD0dOrVGk2jIpgh
         PFycJMLlUPQ9VQjK5Zj0UipNtlna5+FwMlcey4lBKka+3yDmphW4xwL5igr/QwC+wwHU
         i1HYp/y/NTgS+WnVnLnrkju+77eFbmveJhYSRCkFk8rtaPsbmJyVA9+C2HZ+RprK1GFv
         Gc6poDEP5muNqVZBSl0DwYd9mbmcpLNo7TWXAqZFpGIKXF+Hw9WkUrV8JerzxylA/AGd
         a7Gw==
X-Gm-Message-State: AOAM533W/TaMi0cIsKm/CS+1JYdPFvtziDRQNhWEQJzHMHJQBiPtC0ud
        MOEndEUnV5U5t0DlAW3XXkdUUw==
X-Google-Smtp-Source: ABdhPJyt669Qyl5fKNeC+DkjJd6fHbpPgxmbo2SgviMWvuorCu2JK0a7+FItJ+LvEAVdNOREgKXjZQ==
X-Received: by 2002:adf:f990:: with SMTP id f16mr8473053wrr.128.1637682998253;
        Tue, 23 Nov 2021 07:56:38 -0800 (PST)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id r15sm1532572wmh.13.2021.11.23.07.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 07:56:37 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     joro@8bytes.org, will@kernel.org, mst@redhat.com,
        jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        eric.auger@redhat.com, sebastien.boeuf@intel.com,
        kevin.tian@intel.com, pasic@linux.ibm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 1/5] iommu/virtio: Add definitions for VIRTIO_IOMMU_F_BYPASS_CONFIG
Date:   Tue, 23 Nov 2021 15:52:58 +0000
Message-Id: <20211123155301.1047943-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211123155301.1047943-1-jean-philippe@linaro.org>
References: <20211123155301.1047943-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add definitions for the VIRTIO_IOMMU_F_BYPASS_CONFIG, which supersedes
VIRTIO_IOMMU_F_BYPASS.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/uapi/linux/virtio_iommu.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index 237e36a280cb..cafd8cf7febf 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -16,6 +16,7 @@
 #define VIRTIO_IOMMU_F_BYPASS			3
 #define VIRTIO_IOMMU_F_PROBE			4
 #define VIRTIO_IOMMU_F_MMIO			5
+#define VIRTIO_IOMMU_F_BYPASS_CONFIG		6
 
 struct virtio_iommu_range_64 {
 	__le64					start;
@@ -36,6 +37,8 @@ struct virtio_iommu_config {
 	struct virtio_iommu_range_32		domain_range;
 	/* Probe buffer size */
 	__le32					probe_size;
+	__u8					bypass;
+	__u8					reserved[7];
 };
 
 /* Request types */
@@ -66,11 +69,14 @@ struct virtio_iommu_req_tail {
 	__u8					reserved[3];
 };
 
+#define VIRTIO_IOMMU_ATTACH_F_BYPASS		(1 << 0)
+
 struct virtio_iommu_req_attach {
 	struct virtio_iommu_req_head		head;
 	__le32					domain;
 	__le32					endpoint;
-	__u8					reserved[8];
+	__le32					flags;
+	__u8					reserved[4];
 	struct virtio_iommu_req_tail		tail;
 };
 
-- 
2.33.1

