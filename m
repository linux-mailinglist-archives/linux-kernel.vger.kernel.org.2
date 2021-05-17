Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3F63827D6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbhEQJKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbhEQJKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:10:32 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5C1C061756
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:09 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id c17so4501436pfn.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=533Tv/3qZAVceJ3+hZ7LAdLhXyODElEgCY13Ks4GR1A=;
        b=ATMQIDoC+fS9uzhpLngnmDLKRJiKZhG6SXtqzVZ1Gp1N3kcbgc68ooGxvjc0vEz0Ub
         kiNa4h2PDmP/4TmeK0Kii6toA3UUJAl6e1Vj3quxDzc81TjtE6OZ4op4rtRoQdWHL23p
         eu2fbzvd5pBQYfKzSGiD37s4AsACl4WbmHPbydSAXq1x/e9YMVkgn4z0vjW9QydYXst7
         0yQjXpRrlhqKAuPtFBmXLbU6j7l6odqyDw76pueueHj3xifVBjyYWTKxKQzxuwDn6tgw
         fxXq/4Oze9FTriDJdBCLxb7gMdOmeINXVwtGkw93ZPTSk5AjzTJ5xIZhuVYVXnESAgUu
         cTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=533Tv/3qZAVceJ3+hZ7LAdLhXyODElEgCY13Ks4GR1A=;
        b=QV0benOvHl/1YkHD3behKMVkMfwpDglfSXMzKyLK5U72QUbiW5j9ZAo4eIcYlHdcP1
         eqwG9CXie8OplopaAXvSo9Mo9GOEpD6cu+ShygnmDgZnO4uGZJC7XYhPnzHQtfd2PC7G
         sH03Y0xsXSbD7+qB+RfRqrCkciyCF+320Tb/8roiGxPCkzkC9bQHnJq+MXMFosbmqf2U
         0M2gx2lIwzom2U6kEoZrsAXou3vf25K+CCMORCHqiglEbp6KJ6YYXUx3CfbmpQ+mLtCP
         Fqby6aYOXIOGQf2NYj7+pOOj6NQfECKfj/uHz2V6JgFcTKTZ6N4n2C/Ivv2oND3Jh2d1
         +fSA==
X-Gm-Message-State: AOAM531vzyh5PVp5ayXetooNBA0OewcMua1zdomFsXskUKx8+OXe9UFi
        ClRqWfARPA7SYt8Y+sTcedoY
X-Google-Smtp-Source: ABdhPJxy56tlzeFdZOV5rTIFt2Z5ctad0u0HLGSAyPPLlpCwjOeTqU5SAPx2ZO405AGl+C/MhA3+8A==
X-Received: by 2002:a63:185c:: with SMTP id 28mr9053638pgy.158.1621242549012;
        Mon, 17 May 2021 02:09:09 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id t25sm6703431pfl.68.2021.05.17.02.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:09:08 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, dan.j.williams@intel.com,
        johannes@sipsolutions.net, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 02/17] virtio-blk: Remove unused used length
Date:   Mon, 17 May 2021 17:08:21 +0800
Message-Id: <20210517090836.533-3-xieyongji@bytedance.com>
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
 drivers/block/virtio_blk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 425bae618131..255adb7a768c 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -178,12 +178,11 @@ static void virtblk_done(struct virtqueue *vq)
 	int qid = vq->index;
 	struct virtblk_req *vbr;
 	unsigned long flags;
-	unsigned int len;
 
 	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
 	do {
 		virtqueue_disable_cb(vq);
-		while ((vbr = virtqueue_get_buf(vblk->vqs[qid].vq, &len)) != NULL) {
+		while ((vbr = virtqueue_get_buf(vblk->vqs[qid].vq, NULL)) != NULL) {
 			struct request *req = blk_mq_rq_from_pdu(vbr);
 
 			if (likely(!blk_should_fake_timeout(req->q)))
-- 
2.11.0

