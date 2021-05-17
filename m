Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3E3382867
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbhEQJgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbhEQJgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:36:14 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BCAC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:34:58 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t11so3365473pjm.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=18zXCsU3oeLipvDiu0VVcoADO0s+4YT939hRLaNN764=;
        b=EUA6wWDfpavcMZzfIntlzC7BHlXgF2+6uiQ+Lld4FnQF4+Bm41DqEb8hs8C6bH1klM
         J3IlW6Ix0QFKcdE0/Un8zN+0TQQ715ht9rAUmNuS2Vk6v4YsklpgL16hMfgy7rwNoFAe
         3k0T0uS41d1u3gplm+OFAqaI6vR4rZQQMpAKsBiqyfMPQT0VKl8ECJwqmeHEBAAbyFAN
         ROy2K0VwLc9M5huDXQ9fv0PU3sfiTztVOkdwqym6wx0pYateC9kavYbyHK4NOcvgFBl3
         M6o4RrnnnNK5eSKdgwHqkV/x/XmNGaW/CbEQSghHv4pfqY6hfg2vQxBznU/axTEKhDl5
         uf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=18zXCsU3oeLipvDiu0VVcoADO0s+4YT939hRLaNN764=;
        b=caY2rmKwEuXjvJyUo63UDSbehQ8O2S9tlOk1U+7l+5uxZ4mvLKIbVt7CoyFN3ILBgR
         i7o6lErQXgAKLktQ9EWs9SSa12SqIXFYc1KpSnWymDXhXXasbLShGofLFVjo3g8Wko7Q
         MDtQIQYzMBCaGuG+SvczK7BaXNGrtvWtoK0ZCAT8ua8qFtLJeJhQwZTKZEh4D4BzLWww
         +uMCQRjH2FDWsk/8KUNTP7qlyB6mMgDCZN9q+3xn/xBUhIQjXJrmIp+TVIGNIpNrP4GZ
         0JmNKBlk4rTvl8u273c01l1Gd0KZ53/5vAkIbJgEF5I6BZGrWD3AQUL+bsEQYX/3SS2M
         cFwA==
X-Gm-Message-State: AOAM5302w9+/8dmz5b0XX/WIyyD7vHgvgDUVyqpZdQYvcQuBlGWAQhq1
        pFD1vN5Gg4JNv9XcqbHoTSD5
X-Google-Smtp-Source: ABdhPJxql8Ei+Ak9Jt3jKkMkxJ/GV92K6duIjFzrHte/KVtjDGpj2y1XTRqxJfdhbB6SGYDCed46rQ==
X-Received: by 2002:a17:90a:b78d:: with SMTP id m13mr26371432pjr.177.1621244098485;
        Mon, 17 May 2021 02:34:58 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id x23sm14734519pje.52.2021.05.17.02.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:34:58 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, jean-philippe@linaro.org, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, lucho@ionkov.net, asmadeus@codewreck.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 01/15] virtio_config: Add return value to virtio_device_ready()
Date:   Mon, 17 May 2021 17:34:14 +0800
Message-Id: <20210517093428.670-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517093428.670-1-xieyongji@bytedance.com>
References: <20210517093428.670-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We might get invalid status from untrusted device. Let's remove
BUG_ON and add return value to virtio_device_ready() to handle
this case gracefully.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 include/linux/virtio_config.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 8519b3ae5d52..0e61cd89ac1d 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -225,12 +225,16 @@ int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
  * Note: vqs are enabled automatically after probe returns.
  */
 static inline
-void virtio_device_ready(struct virtio_device *dev)
+int virtio_device_ready(struct virtio_device *dev)
 {
 	unsigned status = dev->config->get_status(dev);
 
-	BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
+	if (status & VIRTIO_CONFIG_S_DRIVER_OK)
+		return -EINVAL;
+
 	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
+
+	return 0;
 }
 
 static inline
-- 
2.11.0

