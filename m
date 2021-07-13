Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3791D3C6C58
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 10:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbhGMIua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 04:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbhGMIuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 04:50:25 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73418C0613EF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 01:47:34 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 17so18943752pfz.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 01:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fyDF3ItsKMeO1MjqIrqgJilMt7mYKDPvv5TK6RowgtE=;
        b=p1KNnydZcTiuyWle/nJtM7wFkNnRwelSBfv+CpsCxOYkJn5kWph/w1ljqkJz9zrEg5
         L2pkcNggfl3Q9RjS5qhSOgAu/suoOWBFYsfmw4VoJ3cVZCGQWXC/t3LZ5InMM8XR5LRl
         xHGxHb49eUsoBIewF2f127m9Zr6vQ1nNrE7ANg6C6KNKlJI6o8pJl/1YyAaWFPkOV3/r
         EsJv5vTsWLrxteRhSjRM/MuUUYUEpmJLfFEjWeF53QSvgsRiNQPzhkLCqrfes/TWccji
         zCW/mpIwd16XGKv0iCcj7quuKncnXS6vKRI09sMPi97p5ey6v9LWBy67FlYZ5GtM1LSk
         RZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fyDF3ItsKMeO1MjqIrqgJilMt7mYKDPvv5TK6RowgtE=;
        b=K2/xLPQv0WNBsWfopkMSbg9O1yjKhG5aagATY/anoPNThOEQivmOho9SDc7HVPuQ7z
         hwBCWOH//L+M0faMoxo6NbL8Y5kjbzakceGe15cTZzSmodnB9t6bKFLyZcbmqS6KB5Ht
         o7Y2dG5t+LyLXlbrZJWsP7epqz3ba2yzeatAmSgiRxWzyXMDn5p/ktRW28qqYUyXRo56
         g1tEzkvxc6HpyIr9Ig0jkn/FK/o8xfeEvM3ucPAalIHv45CbMcjFxmlDdO7DoqiVKCdV
         cdpIZXoCn9hMBIu1i/ILE6ip4SZxZWDnx244iQiWf2Kh1r2I/M9KW33kEJVNFn66eq6m
         mMew==
X-Gm-Message-State: AOAM532lgHLP9BAPPSmHxobelwxrnXD5v+BB95xlXkpN6Bf+xIgbJUKD
        R9clZ/703zTsOG+E9XHbBTqP
X-Google-Smtp-Source: ABdhPJx6Qc5AYiRax5JttuV19B9UsF3u1wzbj3hvEI32kFSkxmH/vgaDI62s1sThuuzVSR58tJkLXA==
X-Received: by 2002:a62:f947:0:b029:2e9:c502:7939 with SMTP id g7-20020a62f9470000b02902e9c5027939mr3616720pfm.34.1626166053934;
        Tue, 13 Jul 2021 01:47:33 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id n6sm12746734pgb.60.2021.07.13.01.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 01:47:33 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 03/17] vdpa: Fix code indentation
Date:   Tue, 13 Jul 2021 16:46:42 +0800
Message-Id: <20210713084656.232-4-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713084656.232-1-xieyongji@bytedance.com>
References: <20210713084656.232-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use tabs to indent the code instead of spaces.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 include/linux/vdpa.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 7c49bc5a2b71..f822490db584 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -342,25 +342,25 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
 
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
 
 
 static inline void vdpa_get_config(struct vdpa_device *vdev, unsigned offset,
 				   void *buf, unsigned int len)
 {
-        const struct vdpa_config_ops *ops = vdev->config;
+	const struct vdpa_config_ops *ops = vdev->config;
 
 	/*
 	 * Config accesses aren't supposed to trigger before features are set.
-- 
2.11.0

