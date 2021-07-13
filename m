Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4119A3C6E0E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 11:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbhGMJ67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 05:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235684AbhGMJ65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 05:58:57 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867D3C0613EE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 02:56:07 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id h1so10826785plf.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 02:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EmK9PBBZm27px4+TQvTc+ITdi0A77m08kRzVEcaDoek=;
        b=KSYePS7AqCIh6CTacy8i+2I8sKpsyzPU/hYta21A1pWxmMtnKvp8IK2Tsp9kRuPOXx
         c69jMlkZFZApxFtJ7AVbeJIfC/bnmqHLSgkWTNEvp2pT/gpsf8Mozs4X+liuBpVevzPZ
         syS0M7RSd44GqNEAT3+jRAJp8nP4fRrRugGk5yO/vQFgExxIRHsQ1tYmDfMRCbbpP+uF
         2DBTQuklegchn1jAnhhZkT0gQQvTdR77MMww0p7dt9+Lx9wu0Y7Bft072QkAoKf/eaWD
         6qBuvCVDoBSOBZTeGkGW/rXPRU9vnvLihpOhpO4wbkYLUAbLMAxvTpu0/mko38Ik+a2P
         MqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EmK9PBBZm27px4+TQvTc+ITdi0A77m08kRzVEcaDoek=;
        b=miXgUqAP6PESiMrnvTlBgeWmwIQzhwOgRU0ZjJ5ptNufUPmvBVTDJQiMlD0Ux75X7e
         nTnmQ/3vsH9d7G+ZukHOUj0eqh7C25CgnIMQw8I1vqcQRRwEcSdSafx1t3WQPeTX5ETE
         1RW1M6aSYeHDKTw29ySQbKBJuLcOhO8kS87y0OVR6X5O+N7uySVswAZh6hmcFp3JMG91
         xD3+QOUnfyHGHVjKB2QQ+S49xlSpp5mfsHPQroShUlS7Cc+yQ1lVQwLOINLEJjBSEsCC
         mZ8/4yfVmBc8oTfFGjKCYrffmk89YxeH8jt7z0KIghx7J6wFj+NeXZw/D7aXQGC8Mgy2
         mGPw==
X-Gm-Message-State: AOAM531pYX9qiRvxV7vx3tgNzL9P9s6uJH/Ck9BsG71h2b9xPYJ9wF1b
        IerKywnJ5cLB1bFt/n7jIfDlYQ==
X-Google-Smtp-Source: ABdhPJwbbH02eJRKhfqiniDFu1JoI7NqedZe50yDy1/qYd4UnALxOiIFCymtmtYDK9PeFL2NOCT/UA==
X-Received: by 2002:a17:90a:520e:: with SMTP id v14mr18228984pjh.163.1626170166988;
        Tue, 13 Jul 2021 02:56:06 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id d15sm5650092pfl.82.2021.07.13.02.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 02:56:06 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] uapi: virtio_ids: Add VIRTIO_ID_GPIO from OASIS spec
Date:   Tue, 13 Jul 2021 15:25:55 +0530
Message-Id: <7c716c2eb7ace5b5a560d8502af93101dbb53d24.1626170146.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GPIO's device type ID from the OASIS virtio spec.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/uapi/linux/virtio_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index 99aa27b100bc..477a0927e329 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -57,6 +57,7 @@
 #define VIRTIO_ID_MAC80211_HWSIM	29 /* virtio mac80211-hwsim */
 #define VIRTIO_ID_I2C_ADAPTER		34 /* virtio i2c adapter */
 #define VIRTIO_ID_BT			40 /* virtio bluetooth */
+#define VIRTIO_ID_GPIO			41 /* virtio GPIO */
 
 /*
  * Virtio Transitional IDs
-- 
2.31.1.272.g89b43f80a514

