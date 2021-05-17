Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB21A38286B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbhEQJgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbhEQJga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:36:30 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B66FC061756
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:35:14 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id lj11-20020a17090b344bb029015bc3073608so3365247pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qlybO4Xq6N9gbBjREoECeQ7jzQnOslXC7pwQ0VFu09s=;
        b=JR49DwIRHkmh2nvbi4TPMJz3LL/aBzh2lV7qpRgLEMLc0MkKuWW2WgkEhX2iX2jDlU
         9AR196bdYKKNMxBp1WmhEXinUHwIvdHVbNFuwGEbG0K9nIcyNlLMv95cfKkC7az0N+ac
         HHk8SAni9bAq6ytDwnSbIMIkdjMBjjLTspxUYBpYz6hArpMN1UKxqZ3tJkw/Ddx4ToAG
         gIFRZ8Pg/xmiIeAnStdMEEsi9yE2CG6ufRexGT2uL46I4JxLTVq8fPiinGBTjmOZVr+W
         IGSDavlzp1lCiTOiRJA2apcnVUpjrdJB4bPea3e2xF6Za6XF+724jZUf95mmTkDpLf2N
         nWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qlybO4Xq6N9gbBjREoECeQ7jzQnOslXC7pwQ0VFu09s=;
        b=aytkNSPsNPCGWtUODYVtsYBlT6XeubPNJpeq0wGgOVb2ZgFUh6oxra0TtMMOqmU6sd
         Y+AqgpIccAEljzQge1s4o9ZU6JYosHCIzqLZY5jk5K/rYjSYYrUyzbfZ3BZyJC3y6crx
         fgeB2rZ66WWpQz3Vqd6kwz7BNGVAplQoZWemdM1tcAjknNL4+ibO2UoKWAj7iGI8NWg0
         39JMPUy+IF7cc1UszVWhRxLtZfnjIeYRCtPxEH2mWxsBdhjZey8tckqpDsYSSRlx4l6A
         sezIle3EDXVSbgutLQYZ0N6ztmXc/WvGLqRrxuRVtCFaKvY7/DNRchSiaUUVxy9fUdpq
         XYIA==
X-Gm-Message-State: AOAM533rDRVHhGR2pf7QWAkZtSW7nRAJaFkDrtbhGgV9mwQ3Hq4UrpWw
        YJGZEVE4Z9CfZtQNQkJ8HOIg
X-Google-Smtp-Source: ABdhPJyyEEFZAYkt//8pRazIlhY14+7Rofj7bKtnnVCjqZRTt2UnMszDs3KZyZ1mCcM80A+S+cPHqg==
X-Received: by 2002:a17:90b:70c:: with SMTP id s12mr22994106pjz.98.1621244114216;
        Mon, 17 May 2021 02:35:14 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id x37sm1059016pfu.33.2021.05.17.02.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:35:13 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, jean-philippe@linaro.org, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, lucho@ionkov.net, asmadeus@codewreck.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 05/15] drm/virtio: Handle virtio_device_ready() failure
Date:   Mon, 17 May 2021 17:34:18 +0800
Message-Id: <20210517093428.670-6-xieyongji@bytedance.com>
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
 drivers/gpu/drm/virtio/virtgpu_kms.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index f3379059f324..eedbb4684db5 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -217,7 +217,11 @@ int virtio_gpu_init(struct drm_device *dev)
 		goto err_scanouts;
 	}
 
-	virtio_device_ready(vgdev->vdev);
+	ret = virtio_device_ready(vgdev->vdev);
+	if (ret) {
+		DRM_ERROR("failed to enable virtio device\n");
+		goto err_device_ready;
+	}
 
 	if (num_capsets)
 		virtio_gpu_get_capsets(vgdev, num_capsets);
@@ -229,6 +233,8 @@ int virtio_gpu_init(struct drm_device *dev)
 			   5 * HZ);
 	return 0;
 
+err_device_ready:
+	virtio_gpu_modeset_fini(vgdev);
 err_scanouts:
 	virtio_gpu_free_vbufs(vgdev);
 err_vbufs:
-- 
2.11.0

