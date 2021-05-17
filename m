Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A303827ED
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbhEQJNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235941AbhEQJLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:11:21 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2F5C06138A
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:56 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id w1so1843339pfu.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C2fycWAtojMb4cJvF94dgMAozvP4f9vp+JE0pPkMcZ4=;
        b=04G8RP/3c2xmAyS2XnhGYHj5cW+GMl6CWRQQkL08AHQyI4PjwCEQRt/8M1C/EhQ/Zr
         nOIXYXqlq1IIhPbJfi5ofS7+RPesdhZ8wtXEORT9zEb9cs966UIL99sayQMoNtOI8QDX
         xhKGE6PG/cxilzIukqJsPcstO4ReeqeUeOPQ7QF12RIgTZjm7OkxSGZDxKu8Zj/YTFFG
         11WbFOivp5lFPGK/N/1YncQpPKft5WtzwByYgjuJmgiwdaKPMt5CQzvwGPKTRRmWTJUR
         86ix/hWlk1xIYnEmBpfpbtUIYYe7oPSpFaZDp753M3GxHQXA2CfqIVw/Z08yQT11t/Z6
         JNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C2fycWAtojMb4cJvF94dgMAozvP4f9vp+JE0pPkMcZ4=;
        b=OprwKqRzYZfOjXk9xmLbwgyAYLePpGLueG+jDXa/D5oVogyv23L3q7FsTkj4n0BOo/
         TgmdZeSa6+HvkA5lGRj51OS9jxjbwX4pTc5xvtR/oMSiPWAeXr0evuwoY95d7ql267hd
         76SdDvOTKBGCJ3YP+SOmku0xyo/8wf1Df/AulJLmwTVUc5vJjRQmb4D6GVcTNX3tc6yV
         pGpgqz1IWlJF4o8k0krglOnmYIqiSVpY6NsWLTpHsaUxTJKATl298KQHl010t7yLsc0Y
         4iJBIETF5cbprVdF4yoAB56TAVoqhC2aopk4DlQ50yD39ZsfBXUTX4oFWr7lLiFKanSU
         /03g==
X-Gm-Message-State: AOAM530MjBwNGll9oWl6Vh2w8JqlCuyO92vwXKTduJqEGZX1IVv5m/Vh
        jSKlAymeWP3dHpxnkpIuaByd
X-Google-Smtp-Source: ABdhPJx0eH/lrQ3oUDCqaYUfV8uy2uZCUv76num90yk+NR0ShRcSDKm+DHiYQmKOoaA4xHBnqFcI2A==
X-Received: by 2002:aa7:808d:0:b029:2bf:bf00:c6f6 with SMTP id v13-20020aa7808d0000b02902bfbf00c6f6mr38995062pff.64.1621242595837;
        Mon, 17 May 2021 02:09:55 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id l67sm10350988pgl.18.2021.05.17.02.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:09:55 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, dan.j.williams@intel.com,
        johannes@sipsolutions.net, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 15/17] virtiofs: Remove unused used length
Date:   Mon, 17 May 2021 17:08:34 +0800
Message-Id: <20210517090836.533-16-xieyongji@bytedance.com>
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
 fs/fuse/virtio_fs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 4ee6f734ba83..e61c94eaa20f 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -322,12 +322,11 @@ static void virtio_fs_hiprio_done_work(struct work_struct *work)
 	/* Free completed FUSE_FORGET requests */
 	spin_lock(&fsvq->lock);
 	do {
-		unsigned int len;
 		void *req;
 
 		virtqueue_disable_cb(vq);
 
-		while ((req = virtqueue_get_buf(vq, &len)) != NULL) {
+		while ((req = virtqueue_get_buf(vq, NULL)) != NULL) {
 			kfree(req);
 			dec_in_flight_req(fsvq);
 		}
@@ -600,7 +599,6 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 	struct virtqueue *vq = fsvq->vq;
 	struct fuse_req *req;
 	struct fuse_req *next;
-	unsigned int len;
 	LIST_HEAD(reqs);
 
 	/* Collect completed requests off the virtqueue */
@@ -608,7 +606,7 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 	do {
 		virtqueue_disable_cb(vq);
 
-		while ((req = virtqueue_get_buf(vq, &len)) != NULL) {
+		while ((req = virtqueue_get_buf(vq, NULL)) != NULL) {
 			spin_lock(&fpq->lock);
 			list_move_tail(&req->list, &reqs);
 			spin_unlock(&fpq->lock);
-- 
2.11.0

