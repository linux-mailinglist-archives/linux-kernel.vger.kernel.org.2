Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440BC38277D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 10:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbhEQIvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 04:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235735AbhEQIvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 04:51:24 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E513EC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 01:50:07 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id a11so2750847plh.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 01:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bKA9Lq7F5k724FAHbuDMO4AjJLs4UEoXSobW6uS3iN8=;
        b=t2YMHiXTujCsZzZ8ubpqjFkuTQysgBWBBbLhoSrdwjnroxul6X35V35aXuIXOIcSdS
         IMqDXOrsh/eM84/TjcZ81i8IKsjAqYFa+twqx0XxPp9N8URQvYnohJfblZ+4ChWUZz7o
         WAmwRXdmqsFJosZd7rfLxa2F3dABRIIFAre8KxtjLtELvkru1C85pi5ZLMlGqzdJNE5m
         57qblPqAsS19l6V9B7+U2qpcYB50z0+MguM796YAo8RnMqf6OABWndw9XCT1c9sRyVCF
         9jVhA1tUhWPTV/kdFD1wuWn/93b3g/50fzzUEqpaGJu526tH/ftT//7wo21kw1KvV/9V
         vPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bKA9Lq7F5k724FAHbuDMO4AjJLs4UEoXSobW6uS3iN8=;
        b=c97cQluOc9FkjoZjCQy/4gnglWyWOKf0bX+W0fFG+YArQGzYSfmJ6tOgM6L1xBtcA/
         1Ja5V5SeNy1nc7cDOTI767UCT/hNe8FfjhHoSDZIgRp0/M/+l2mGKT9XqM8IegJwoWTK
         LpDVZ7ITtSXk5OtysvLnNqcNs4AK/c9LuqKnq8m07Dt3C0JruibQKE78z5xwnk8FewUh
         Ff0grjt6wGPRosum4i2r32l/QthMTanuYTWcCxXQoclHNyo5wMArq63osIVnph0FPDwZ
         u2JC7Dyg6ZNPsRX+gP7a/lFSYIB+dxRd6emKpmwRclSiwcDsvx1pqMIWLb9dXnWFlvaw
         EcRw==
X-Gm-Message-State: AOAM5338iMU3T+jYzFSfzybeeFpOybfaYbNNPG2TGVUFzjZ6oFEV6BWc
        PAFhbz5j3xUrWAzRNBL0UWfa
X-Google-Smtp-Source: ABdhPJzeZ+PN803ZZZF5ioiXzY50WxszAcrlC3DSBeSR4UbUcdaLrWdgYVpLRaul7Pq1NpT4WfcOYQ==
X-Received: by 2002:a17:902:724a:b029:ec:e4bd:fac2 with SMTP id c10-20020a170902724ab02900ece4bdfac2mr59369624pll.73.1621241407554;
        Mon, 17 May 2021 01:50:07 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id 202sm10337428pgg.59.2021.05.17.01.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 01:50:07 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     airlied@linux.ie, kraxel@redhat.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drm/virtio: Fix double free on probe failure
Date:   Mon, 17 May 2021 16:49:12 +0800
Message-Id: <20210517084913.403-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517084913.403-1-xieyongji@bytedance.com>
References: <20210517084913.403-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The virtio_gpu_init() will free vgdev and vgdev->vbufs on failure.
But such failure will be caught by virtio_gpu_probe() and then
virtio_gpu_release() will be called to do some cleanup which
will free vgdev and vgdev->vbufs again. So let's set dev->dev_private
to NULL to avoid double free.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/gpu/drm/virtio/virtgpu_kms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index aa532ad31a23..f3379059f324 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -234,6 +234,7 @@ int virtio_gpu_init(struct drm_device *dev)
 err_vbufs:
 	vgdev->vdev->config->del_vqs(vgdev->vdev);
 err_vqs:
+	dev->dev_private = NULL;
 	kfree(vgdev);
 	return ret;
 }
-- 
2.11.0

