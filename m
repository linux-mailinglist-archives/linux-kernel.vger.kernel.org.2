Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6553638277B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 10:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbhEQIvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 04:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbhEQIvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 04:51:20 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B932C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 01:50:04 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d78so3606799pfd.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 01:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d+8KyNMS3UthpalbMaLNFWd7rsxivR4hVqKsroFzDcg=;
        b=I2vVFxhA/ATWt2N/IbXFrPqogS3dn7PJKuOhKTE9wb6Y27GzC6XH0PNcvDhiFwtqoG
         YXaTEeoWR57cr1amPtOREU6IqcjKRjX7ILkdjUzKl6zF4VmWPWoAYVMH8cfbOb4/Nrjl
         pDr+i536viDbi3M1/qgku3ixXyGHzoZmzC+P8PrdtFzOHLFZjoB3jsremhb9gKPBcSoe
         dU6x2rRw6J0YjRW3O41UoB7NpgnZXP9RjEAgHxAq2gT/0RzOQWxYvfgXTEZuQc8QtHWv
         EvivxnjN+4Klsi8fZjBzKB6nge9z2xKXCltLdifKAfrEcf7/PRAPbcSEFZrZjGYhXGvn
         qY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d+8KyNMS3UthpalbMaLNFWd7rsxivR4hVqKsroFzDcg=;
        b=al8KQp+I7G8Cw5Oheip1XT38nUVhHK77xsrW6ZvLe90IvE16xwTe6smz+FV325ewhb
         3y4VVstXR6bRQmJXfCHR+lkUfvhEO3onB6mL8FzhhMzJUWDd5lVueYWqULZoK1Q5Bty7
         JNgmf76cwYI8372fCETC+MQK3UPSSk9mdayap00JAnkHLbLYcnxWqitFMs6333K5vSGv
         tfDTEoFUngUNJumCXoeD3rcEt9HaALnBMQJKuz1YP0Q3o646+kNRb7+DdGNsmW9QEZOz
         UCFXaFQacYAk6hCsgglmLUnh2bqzu6AGa8mJ2d1EWD9LO4Nl/Seq1DhhZxLzDycdcHYG
         q+3Q==
X-Gm-Message-State: AOAM531+V9TlYXLhLv2UEnbASJuK/72knc55ISLkQX9cHjiCajHMZObq
        Y2y/QE1Syvh8qrIfaiwhcnbI6z2MlPfK
X-Google-Smtp-Source: ABdhPJw2RVR5C9qLDvNyBYxDUPNmHMatdeABhT67H0qozX74M91VbOZGu4vh0ni1shh7ISITfh1NIg==
X-Received: by 2002:aa7:9ede:0:b029:2d9:ed92:3fad with SMTP id r30-20020aa79ede0000b02902d9ed923fadmr8823581pfq.10.1621241404015;
        Mon, 17 May 2021 01:50:04 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id i2sm14381206pjj.25.2021.05.17.01.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 01:50:03 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     airlied@linux.ie, kraxel@redhat.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm/virtio: Fixes a potential NULL pointer dereference on probe failure
Date:   Mon, 17 May 2021 16:49:11 +0800
Message-Id: <20210517084913.403-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dev->dev_private might not be allocated if virtio_gpu_pci_quirk()
or virtio_gpu_init() failed. In this case, we should avoid the cleanup
in virtio_gpu_release().

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/gpu/drm/virtio/virtgpu_kms.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index b375394193be..aa532ad31a23 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -264,6 +264,9 @@ void virtio_gpu_release(struct drm_device *dev)
 {
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 
+	if (!vgdev)
+		return;
+
 	virtio_gpu_modeset_fini(vgdev);
 	virtio_gpu_free_vbufs(vgdev);
 	virtio_gpu_cleanup_cap_cache(vgdev);
-- 
2.11.0

