Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF70F3827D9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbhEQJLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbhEQJKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:10:36 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EB4C061756
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:20 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n3so2775462plf.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k5LiPB9q7xaBW+KGuI5cLu1TfDUV6Yx5wm0u9ndqYC0=;
        b=TooF72bFASBbEvKajGXXGsK6IKoZ88dIgt+Yh/ep7ySu0ApwXvTE2jAxTmXRHqta6r
         RepG8LcbahMWIl1JfQE/tGQaIAXE90XZMIyGOq9K75kCy1DYtCD3eG5zxblKEi8LgoTR
         MaYen0RVEez1r0Y8RNdIVVAzPKM30h88pJlSdUGI/rx+sN1t5oYD3NUYe7CkEa6yDk2+
         Pnfyq/AAnv9dzKrxFCR8Pl5KaJddykbARfOafikdzY5WHc69wEBdBSkSkXldUB7mDfCI
         lJhrCySWM/P8zbaOFyoxzC5SCBfRAmRdJlaam0tC30tiOCzFmCyrRk8Ooi0Gmnfvm1Jb
         S/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k5LiPB9q7xaBW+KGuI5cLu1TfDUV6Yx5wm0u9ndqYC0=;
        b=s+4DFWKE5pusof92s8io/sqjFI0gYt6J/2B4owCDkEdbYN5QdTJCL+dYjVTJPRBQe8
         wcVE5MmFb6Kw8MAGV8wcK+rahCo7SGCAi7JqN8DJzEo3OuvbUu+IoZ8XNch2BugURw+2
         KPu5YTF/NFz9DCq68YwDerSMtk5k+irUfooejFnAj2QD8gQ8nmId37WArAmztL5lQj61
         g6c78dPGAV3e2Zlc60F1YMqqN5zdBz/jZItMqRA+NgiWaJqB4s6doOUVzUjYK0evSkNe
         FWxEBR9H1YhtT0YbJ1Vzg7zKFQ0r7B6VnyBuvzyWOkGDiY25FuzYlufZa2+jWXUQSYbp
         en8Q==
X-Gm-Message-State: AOAM531MnxGJNvbcp64oR2QSH354WkgYGtZpjeWFtCir5MOt3TIRvX7d
        afQhQy7UA+L1GPF3XXRiM3Qw
X-Google-Smtp-Source: ABdhPJwccSvE2dsPUnRdYMuRmIU5M5+QvCqttrIbWrSu+57REa2WO+REfPGQCS/eNyLBDt3j5mlQ+w==
X-Received: by 2002:a17:902:8211:b029:ef:64c8:5bb2 with SMTP id x17-20020a1709028211b02900ef64c85bb2mr32604471pln.64.1621242559804;
        Mon, 17 May 2021 02:09:19 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id 63sm1227877pfz.26.2021.05.17.02.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:09:19 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, dan.j.williams@intel.com,
        johannes@sipsolutions.net, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 05/17] drm/virtio: Remove unused used length
Date:   Mon, 17 May 2021 17:08:24 +0800
Message-Id: <20210517090836.533-6-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517090836.533-1-xieyongji@bytedance.com>
References: <20210517090836.533-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The used length is not used. Let's drop it and
pass NULL to virtqueue_get_buf() instead.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index cf84d382dd41..4b164bacc68e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -186,10 +186,9 @@ static void free_vbuf(struct virtio_gpu_device *vgdev,
 static void reclaim_vbufs(struct virtqueue *vq, struct list_head *reclaim_list)
 {
 	struct virtio_gpu_vbuffer *vbuf;
-	unsigned int len;
 	int freed = 0;
 
-	while ((vbuf = virtqueue_get_buf(vq, &len))) {
+	while ((vbuf = virtqueue_get_buf(vq, NULL))) {
 		list_add_tail(&vbuf->list, reclaim_list);
 		freed++;
 	}
-- 
2.11.0

