Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE3438277E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 10:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbhEQIvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 04:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235735AbhEQIva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 04:51:30 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B25CC061756
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 01:50:11 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id b13so731873pfv.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 01:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BrsrtZWINyNEWd4mAoksuRRQpNEE2ig59BXqlO+EufY=;
        b=Odzi/NnRfgtD3LhwnV11o3/h/Ek7y92D8seZwfXtScqBKLDMTlS1bYfcBYHoEIvBcx
         xOlVxzY4vLjdOjchbliWRi0QkelkHCi/sMHs2L7jJYHUt8EIWYODqY9PcpwIPtrLZBa6
         oiItcg0vyWX5r7L54o9lvGdjOrqd6qqiazTeYJ2RhOoeOK7/yvn7Kj4OhPRJxPJJqCCp
         P3353vtQXAcDaYXujWn4UJFiJmJOrzXtPMicGKYW+LGKoYkn3V+NtV/aTj7380o70rxX
         0W/o/Rm/zufPMBa8805P8Td5gaVHbOpNSquh4ygZdtgMkCwYouT/9aoiBRbE+swDB41B
         iTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BrsrtZWINyNEWd4mAoksuRRQpNEE2ig59BXqlO+EufY=;
        b=AAG+MTJJrnxSLk5J1FBlnMGzalomAa6Wsu+tBCtrRgU0JLxsc41CJvMcETJY7WQXD4
         1NWMQNmNnXx0rueWW04/+W6NRsnfZkqAgmw/d7n1YG+5zkW9YC7usKxMEd0wY4vc6RCm
         rrH2zFKreaalTMRItTp7qitMM/w71XD0CqiH+3qmDVxVZyIjfdSrBWviXcpakbEpVO6p
         pWWsiw5PfN0lHEqlXlozBxETFK9ja9iWdKQlr3nvlqDH3rJL/d3meFie4fL8KW5sksaU
         7tieNBg2IiqChFU6lHFkkEKg+toW7jnUH3uKLNVYoY9GOADTvead3qlg4SCZLB/XcxH+
         5uRg==
X-Gm-Message-State: AOAM531sU+q9MgU8XCYnG/28wEIMJ6FTmGlaRBNfPWoywcZpFtHdjEk7
        6y9ci7vbDMVtgZUrefgdq3NDZfhKnvdu
X-Google-Smtp-Source: ABdhPJw1BTT8Od/byB0Qv/xIJsHlL0d8ohgo/1PNrXviuUL12D/cfXZH2EievWNGsFGK52kYS8KpRw==
X-Received: by 2002:a63:5c5e:: with SMTP id n30mr26151298pgm.87.1621241411197;
        Mon, 17 May 2021 01:50:11 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id a18sm9691463pfn.147.2021.05.17.01.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 01:50:10 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     airlied@linux.ie, kraxel@redhat.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drm/virtio: free virtqueues on probe failure
Date:   Mon, 17 May 2021 16:49:13 +0800
Message-Id: <20210517084913.403-3-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517084913.403-1-xieyongji@bytedance.com>
References: <20210517084913.403-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should call virtio_gpu_deinit() to free virtqueues when
drm_dev_register() failed.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index a21dc3ad6f88..31ba4f344ab9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -121,11 +121,13 @@ static int virtio_gpu_probe(struct virtio_device *vdev)
 
 	ret = drm_dev_register(dev, 0);
 	if (ret)
-		goto err_free;
+		goto err_deinit;
 
 	drm_fbdev_generic_setup(vdev->priv, 32);
 	return 0;
 
+err_deinit:
+	virtio_gpu_deinit(dev);
 err_free:
 	drm_dev_put(dev);
 	return ret;
-- 
2.11.0

