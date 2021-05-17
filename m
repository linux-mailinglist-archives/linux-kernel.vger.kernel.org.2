Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C328F3827DC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbhEQJLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235862AbhEQJKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:10:45 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ADFC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:27 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id f22so3260472pgb.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ujgMyYTwMwUN/o6mAiJv4W5fY92kMur+Aiz+IapCxa4=;
        b=1xRlV1Im+ewkUOEZLbLvfzJj4t2xSh5FEDkg0/eE70rdxFCxdjYfbptOfTzJ7OHuLN
         FmXUp402M/J51Zo12buHAapDjgwlrLl0Lz42gaKjkfHqLBoRSIsjAmpTFrtXoSYjhdwT
         ZxVXXIUlZUytHhFAzJU9y5N+yobsOb6G+bjSKjgDfYDJ3Xa4z782DyaiJyg4AxYaBv/W
         LW0ZwEzYJGCy/vPyOexuRxqEvMVKtB8MvnUrPf/GwJo/fvIxmoV/xCda/kXza922buTK
         ehcJKRFA6WuEzSYyam9zKhLLOo3WpMPd/zoQT0vi6jUvfasmeaRnK9IwTsru+9LNRxmx
         fHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ujgMyYTwMwUN/o6mAiJv4W5fY92kMur+Aiz+IapCxa4=;
        b=qI0ZJBN1Zt+X5tCnu3vNm7gfETdHngHiAV9m6aBugwZjg5ozkmvhpTedk1dZgTMSJs
         JO4LtyEGxAXejSd3ejhjR7bjdVlGwZ7mr9gVMdBxoMAd/MZD+59bdD/PUo3pG9oMKAE6
         2qEgG5rZrJPDhACCEeyVwi1JbgF2cFlpkse/2LH+x/SpIuazAZuQIksAHKruUEKU66Bs
         sF7jidCV/MZC6VZ9gvlD7dH/237/laZFY+7yIbAiSYSgGkNFhJeTA7npj3fY4krtmm/Q
         EVJ7doJePdUdV19CtEtLA6RcqdGGKugcjV2J3+NHy/7w5k1FI2u7Dj6oMJkKsFzEiuAP
         CtZA==
X-Gm-Message-State: AOAM531tyKEfgFbAuJ3ERjVvXTuVyOLGQa0ZvyBj7plIGiEBskB/mv7U
        cCfCpAGx0+/5BGBS9rLP8nVI
X-Google-Smtp-Source: ABdhPJxhBk6BcBcG2bFJDJJoYsk8qcfThQigkyVHIXS7UtAx2gXdqi4xdTFoF/OL0oD6hfd5HFLbXg==
X-Received: by 2002:a65:4b8c:: with SMTP id t12mr61445986pgq.257.1621242567014;
        Mon, 17 May 2021 02:09:27 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id g13sm10053816pfi.18.2021.05.17.02.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:09:26 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, dan.j.williams@intel.com,
        johannes@sipsolutions.net, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 07/17] virtio_net: Remove unused used length
Date:   Mon, 17 May 2021 17:08:26 +0800
Message-Id: <20210517090836.533-8-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517090836.533-1-xieyongji@bytedance.com>
References: <20210517090836.533-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The used length is not used in some cases. Let's drop it
and pass NULL to virtqueue_get_buf() instead.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/net/virtio_net.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 5ca7d6780add..01e54e99cae6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -500,7 +500,6 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 	struct receive_queue *rq = vi->rq;
 	struct bpf_prog *xdp_prog;
 	struct send_queue *sq;
-	unsigned int len;
 	int packets = 0;
 	int bytes = 0;
 	int drops = 0;
@@ -525,7 +524,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 	}
 
 	/* Free up any pending old buffers before queueing new ones. */
-	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
+	while ((ptr = virtqueue_get_buf(sq->vq, NULL)) != NULL) {
 		if (likely(is_xdp_frame(ptr))) {
 			struct xdp_frame *frame = ptr_to_xdp(ptr);
 
@@ -1378,12 +1377,11 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 
 static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
 {
-	unsigned int len;
 	unsigned int packets = 0;
 	unsigned int bytes = 0;
 	void *ptr;
 
-	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
+	while ((ptr = virtqueue_get_buf(sq->vq, NULL)) != NULL) {
 		if (likely(!is_xdp_frame(ptr))) {
 			struct sk_buff *skb = ptr;
 
@@ -1681,7 +1679,7 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 				 struct scatterlist *out)
 {
 	struct scatterlist *sgs[4], hdr, stat;
-	unsigned out_num = 0, tmp;
+	unsigned out_num = 0;
 
 	/* Caller should know better */
 	BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
@@ -1709,7 +1707,7 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 	/* Spin for a response, the kick causes an ioport write, trapping
 	 * into the hypervisor, so the request should be handled immediately.
 	 */
-	while (!virtqueue_get_buf(vi->cvq, &tmp) &&
+	while (!virtqueue_get_buf(vi->cvq, NULL) &&
 	       !virtqueue_is_broken(vi->cvq))
 		cpu_relax();
 
-- 
2.11.0

