Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933D539016E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 14:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbhEYM6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 08:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbhEYM6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 08:58:14 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607A6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 05:56:45 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 22so23147138pfv.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 05:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3KMWASV3SLVte0q8oaiYluVtXUMGN78e0vPRzRZn/jI=;
        b=gRmb+qBH9tAj4o4Iv37i76bpuAs/zUuSewvC/qC32T0l6zy6+aL2T9PGVKGkuNfCF6
         0JKzMF0tCvWO9Kybgpv69rURJEQuGGLzf72a6bSOHnjDkv6xC090bH0t5LCWa3aUGyIn
         X0wM7DQARQeArwMe2qnKO1FN36mDONDCpj/V9U+dK9R8/aHpFs2gw3uwe4qLyusRHR8e
         yWF48KJLeXGZwt2xPLFQ6Grgl1tzPcumHEzSvmzvweHpw4lG/+UAvjKRxd6G8VVDwyeu
         Vl5eku01IhhclJYIV9iMcd/5EEAW9DYIvX+E5aOKXKszQObQ1rTPB1GiygCvvCplB/dO
         BO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3KMWASV3SLVte0q8oaiYluVtXUMGN78e0vPRzRZn/jI=;
        b=iPYORiuSeXT4yVxfd9hBLGJJN/LIJtwpzXK0VNsh53dYt0qNgLxSLMQRbUqj6Ma+b9
         SBZKcG174r6BeVawsoJFze+A3WlGTcaM68nz/A7w7VLMPGwyRvscsMphbRkLtJQG83JR
         0GD+mtNnmrAMU1l6Behzqvcq9M4CjYaRot7KznMQ+IuIyH1D2xH+CAwBnr7ht17bRq6h
         2CkgQ0rfZHaCGZi1ZLD46I4G5vXirMPPI7NMKucD+gB5XtFkKTGsK1AThuXK2gVC1fQZ
         dn5bRHjdYq4hVCv4Pm31iH86Kiys+HxGRaRottzFLOnQbcg4k4St7UPzbza+YW8w1KBf
         7YMg==
X-Gm-Message-State: AOAM530XHD6kxzNkXE/4mtfyogmkaT+LkhEdNUvlKJ1Zvi8qqtguMrrz
        kwv7tYoJ8/nCDNt7wCd9+05K
X-Google-Smtp-Source: ABdhPJwyNPw10Tu3LhQ4tUa/J8js8vuykwvC8Ok6YQ2h4fYjIhwjGc1POiAmsDifFHH17ICJ/oE5gA==
X-Received: by 2002:a65:640f:: with SMTP id a15mr18758801pgv.251.1621947404885;
        Tue, 25 May 2021 05:56:44 -0700 (PDT)
Received: from localhost ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id 85sm14033871pge.92.2021.05.25.05.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 05:56:44 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     amit@kernel.org, mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] virtio_console: Assure used length from device is limited
Date:   Tue, 25 May 2021 20:56:22 +0800
Message-Id: <20210525125622.1203-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buf->len might come from an untrusted device. This
ensures the value would not exceed the size of the buffer
to avoid data corruption or loss.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/char/virtio_console.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 1c40ca6d76ba..972b0cd15b87 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -475,7 +475,7 @@ static struct port_buffer *get_inbuf(struct port *port)
 
 	buf = virtqueue_get_buf(port->in_vq, &len);
 	if (buf) {
-		buf->len = len;
+		buf->len = min_t(size_t, len, buf->size);
 		buf->offset = 0;
 		port->stats.bytes_received += len;
 	}
@@ -1709,7 +1709,7 @@ static void control_work_handler(struct work_struct *work)
 	while ((buf = virtqueue_get_buf(vq, &len))) {
 		spin_unlock(&portdev->c_ivq_lock);
 
-		buf->len = len;
+		buf->len = min_t(size_t, len, buf->size);
 		buf->offset = 0;
 
 		handle_control_message(vq->vdev, portdev, buf);
-- 
2.11.0

