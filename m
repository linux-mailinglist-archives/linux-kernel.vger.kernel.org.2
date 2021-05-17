Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419B83827D2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbhEQJKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbhEQJKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:10:31 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA62C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:13 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so3335561pjv.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DAn0CgcoI2NG4vxeqAsu+ULbN8/MhavJx2PkNTe55po=;
        b=wNRwSmSSBlMtM03I6qj4JwFLAJlJ+MGVuD3A/cFy2QQHqAX5RCRZdyixLZLNx/jYg/
         a6eAWSbAh4Ub4EKonXzl/Himi7ZcCI+EGlk78vzdJAKHD8xKEBixPj0klvzLZUuFzWLt
         cGfx95ZYYSz0AqN+yqV3WKvGhCx4K1v30784u/68ctb4bNHzqU4jP1FINpYJvPxtMwQ7
         ejowaRyiT1AkCWi23z6EN5h6gy0utQVt4rHwqs5mp8exPzTqX92bgW5HmouG6l8C0Gto
         k2rPEX4JT9LFs8DJ/rUJ3ZYfwO+jEakLzZn49UInhw5empJ4SNzVVL02siO8gpfX1Ev+
         F77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DAn0CgcoI2NG4vxeqAsu+ULbN8/MhavJx2PkNTe55po=;
        b=D/d7uvnasE/boy0/WsFK38sZDl+WDsYQ2STqygQQcjBNlkR0j8e77MFJlF26ziJn68
         +ZQWhXmFdlXLQ+jWmNyD9RobVzgo+761O/xPw02wSrIp2E5j8jSbLgiAojJciIvraIC9
         8rjXduE2JdZ7fbuKqLzNH5wyf351N9RXgkNcFY+LE2x331nRnl9R+9SALKDrICsBUgog
         FiQtWOoIHsiQ8sqjMWlwgWgH0azdx8nE3yW9tGFrM2bUjQQmF38oJASmW6LZfDMzKbyk
         BLg0CelsOOZUuuO4A9QH5HEN9UtgFdClCRvIf0dYP/xZeiZhaEzOhbchKc2hB2EuMhOe
         YrEQ==
X-Gm-Message-State: AOAM530UJeYRcCNaV9GfZ54huxB1vzuz47iNPz6ZQRImQNyjGUdKRM3z
        aimohWQdmK+ovXmczLS6WEg/
X-Google-Smtp-Source: ABdhPJw16ajaqLobtFJ1/L+vT35qz6nCFJpH1iSBzafC4tXo1TjqLGoMASpYrH+uwSfrTinCssOu8g==
X-Received: by 2002:a17:90b:11cd:: with SMTP id gv13mr3828770pjb.60.1621242552695;
        Mon, 17 May 2021 02:09:12 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id s23sm14847996pjg.15.2021.05.17.02.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:09:12 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, dan.j.williams@intel.com,
        johannes@sipsolutions.net, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 03/17] virtio_console: Remove unused used length
Date:   Mon, 17 May 2021 17:08:22 +0800
Message-Id: <20210517090836.533-4-xieyongji@bytedance.com>
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
 drivers/char/virtio_console.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 1836cc56e357..b85abe1eb2d1 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -549,7 +549,6 @@ static ssize_t __send_control_msg(struct ports_device *portdev, u32 port_id,
 {
 	struct scatterlist sg[1];
 	struct virtqueue *vq;
-	unsigned int len;
 
 	if (!use_multiport(portdev))
 		return 0;
@@ -566,7 +565,7 @@ static ssize_t __send_control_msg(struct ports_device *portdev, u32 port_id,
 
 	if (virtqueue_add_outbuf(vq, sg, 1, &portdev->cpkt, GFP_ATOMIC) == 0) {
 		virtqueue_kick(vq);
-		while (!virtqueue_get_buf(vq, &len)
+		while (!virtqueue_get_buf(vq, NULL)
 			&& !virtqueue_is_broken(vq))
 			cpu_relax();
 	}
@@ -589,13 +588,12 @@ static ssize_t send_control_msg(struct port *port, unsigned int event,
 static void reclaim_consumed_buffers(struct port *port)
 {
 	struct port_buffer *buf;
-	unsigned int len;
 
 	if (!port->portdev) {
 		/* Device has been unplugged.  vqs are already gone. */
 		return;
 	}
-	while ((buf = virtqueue_get_buf(port->out_vq, &len))) {
+	while ((buf = virtqueue_get_buf(port->out_vq, NULL))) {
 		free_buf(buf, false);
 		port->outvq_full = false;
 	}
@@ -608,7 +606,6 @@ static ssize_t __send_to_port(struct port *port, struct scatterlist *sg,
 	struct virtqueue *out_vq;
 	int err;
 	unsigned long flags;
-	unsigned int len;
 
 	out_vq = port->out_vq;
 
@@ -641,7 +638,7 @@ static ssize_t __send_to_port(struct port *port, struct scatterlist *sg,
 	 * we need to kmalloc a GFP_ATOMIC buffer each time the
 	 * console driver writes something out.
 	 */
-	while (!virtqueue_get_buf(out_vq, &len)
+	while (!virtqueue_get_buf(out_vq, NULL)
 		&& !virtqueue_is_broken(out_vq))
 		cpu_relax();
 done:
@@ -1730,9 +1727,8 @@ static void control_work_handler(struct work_struct *work)
 static void flush_bufs(struct virtqueue *vq, bool can_sleep)
 {
 	struct port_buffer *buf;
-	unsigned int len;
 
-	while ((buf = virtqueue_get_buf(vq, &len)))
+	while ((buf = virtqueue_get_buf(vq, NULL)))
 		free_buf(buf, can_sleep);
 }
 
-- 
2.11.0

