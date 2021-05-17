Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873BF382884
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbhEQJii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbhEQJiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:38:08 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF46C061763
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:35:45 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t4so2811996plc.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qlPPr1c8p5lb5cz+wSdhaEOvkw1DgdLjvTfH4lPZjHw=;
        b=tDInCqE+6rymXiowfA9PCVryCkufUL5JTjpfKBpwrkvb3bdqEhwx53NsUSz/kYAohY
         QjGsTqYG0ZiBChN7siMUXE5Q5hV34PnLmtdvvSxT7zjZhbJTeIlFmojfodFFFd0d1tdd
         LEI4PKZV1jlcYFhmhse2YDQdOGjA3xYSfseRXd9srv6mAUH4gxvqUtypTUgEnw/B76xJ
         l/QevPrltZGZkMkwLrALWPsR3d7xBaZPBJqultxEaC8k6jgjl0yq53qiYDcJB9H3agig
         fobHxQnEhF/GsOgeBPIvpkNAon6ThqxMXwTRUId0ED0KOF4LiW9qL35ZHoC6kgi9Ky5M
         nPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qlPPr1c8p5lb5cz+wSdhaEOvkw1DgdLjvTfH4lPZjHw=;
        b=WaBiXrEqdxyE8o3o2h5Q0j5vWxaXQd3YznKoh5p10+VVbaKAIu1XfSvIppX0cn67Px
         AatRclpYrQZAmuei7EiLzMVmH96rt/aSN6XtvQpd5p3a3Xo9WnTBKbv3D9du0hsSW/MR
         t2i3uhQmEMhmSJSo/AFKxgezUVSO4SOZ9wo5BXYDsX8ZUI84mJVSpPcJcVfTRRDjB3hI
         KU4y6u4UN2DXiXTd3w7lTPafzmf5X6NLlKMcQWiKj+JkaA6mvbYcN/GJ5Awde9OKwY0e
         zbCmV+Z2TFg+rskjQdvU7vZ449Iptt6H7Bn1+qvldd6R5NPyB+srIqBliQT0wlE6j3GX
         TQLA==
X-Gm-Message-State: AOAM530ghRxDPu2MjmPFlxocEtr3aoOzIa3DMH/YCXl5FdZLVlYbq8KX
        HIsm/qhp5/YxOCVl0VH4jvY/
X-Google-Smtp-Source: ABdhPJwGG2/mZzei9m8vyJE9izO8HnSNZtyo8eSy2snywGLNg4RRZbsHi/cSCZ5FcsRZPI8pwwvzjg==
X-Received: by 2002:a17:902:ba8a:b029:ec:b04c:451d with SMTP id k10-20020a170902ba8ab02900ecb04c451dmr59363317pls.67.1621244145484;
        Mon, 17 May 2021 02:35:45 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id j21sm15434405pjl.27.2021.05.17.02.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:35:45 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, jean-philippe@linaro.org, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, lucho@ionkov.net, asmadeus@codewreck.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 13/15] virtio-mem: Handle virtio_device_ready() failure
Date:   Mon, 17 May 2021 17:34:26 +0800
Message-Id: <20210517093428.670-14-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517093428.670-1-xieyongji@bytedance.com>
References: <20210517093428.670-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now virtio_device_ready() will return error if we get
invalid status. Let's handle this case on probe.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/virtio/virtio_mem.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 32a8e359a5c3..1148c392ff94 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2602,13 +2602,17 @@ static int virtio_mem_probe(struct virtio_device *vdev)
 	if (rc)
 		goto out_unreg_mem;
 
-	virtio_device_ready(vdev);
+	rc = virtio_device_ready(vdev);
+	if (rc)
+		goto out_unreg_device;
 
 	/* trigger a config update to start processing the requested_size */
 	atomic_set(&vm->config_changed, 1);
 	queue_work(system_freezable_wq, &vm->wq);
 
 	return 0;
+out_unreg_device:
+	unregister_virtio_mem_device(vm);
 out_unreg_mem:
 	unregister_memory_notifier(&vm->memory_notifier);
 out_del_resource:
-- 
2.11.0

