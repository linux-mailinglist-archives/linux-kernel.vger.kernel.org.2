Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D921938287C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbhEQJi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236082AbhEQJiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:38:07 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D24FC061761
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:35:42 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g24so3334687pji.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qs/6MWizLDRTsHBDlMB0lVbYwFZNUVJyQTAL5c/FQ9Y=;
        b=OKJMQZ1/3HMckxs7sIQHyj9Dg+oW3EUD3lyyq9eKvhk6OSYPrbTczkLNQlib26uwqq
         btTRveshAEa3BiaK0kzns75V5R37Zt/GZHeF1Vk7XFLTN8ctXIBdYeQ4wlouJazP1g1R
         MRFoJX8uyo1jK8ANDhP+ynIyMhzYD53Agyywh+Lfi52uLZVGpvBe4t8eMlJYhc0Upl0N
         RY/x+UOoUkyXGkgNpyAu+9QgJ/YR+85Kb6CDNvA5fgEakOMVLIKFdfxFkDF33x3eW7ao
         f5xqvnlw5EDEhVPDlkbY7S2go2ZADw/obcNAGLJPQ0l6kKRbo/P4n2QiP5ntbkRBZfBO
         ZFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qs/6MWizLDRTsHBDlMB0lVbYwFZNUVJyQTAL5c/FQ9Y=;
        b=isirJRGIy6PPopOR07uAnI2pa8LpLGDp9xHNGilH9LwlYGaiUXVWpVmitWeT6vsQMg
         rHL05FzhQiva6bPNJP5njBybd8NUaCOjM9oNzdP2QV+1bNep06MnmBkSW1eg10DL8R8x
         RXP50HG0LxozGuhH0GPV/SBxQTGFGjq/xZ7Yhvq/2oxFYPEvskoqSEIXwHaIKWDOclPv
         QwMBvgZ02IIMHN5mydQQsKqA2r5DI1LwtAHuIDgdGg2qCBMsn4ECg+iRMsssKmfm9fri
         MeX7FfJuZczsZMx5WwyGVznh+mn9XK2rbVu8lkCMh1TLK7pLoYLD+LW/SKLuEWrbCIog
         BZCg==
X-Gm-Message-State: AOAM5322womJ/pyo0Jw0tSdDigDt8uQphrqXR2wRD9DPQu5Ub1xM67Gu
        So1B5HhEpjQaxtOJz+xm3QGx
X-Google-Smtp-Source: ABdhPJyLh304K+nbSTqdrmrdFXTzRQ8RPQoQ49KiWrqHOVO8Vpo6TZjXsHTl9LwMv9ZT5Xh/952Q6w==
X-Received: by 2002:a17:90a:c68f:: with SMTP id n15mr391945pjt.112.1621244141705;
        Mon, 17 May 2021 02:35:41 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id w11sm1092482pfc.79.2021.05.17.02.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:35:41 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, jean-philippe@linaro.org, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, lucho@ionkov.net, asmadeus@codewreck.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 12/15] virtio-input: Handle virtio_device_ready() failure
Date:   Mon, 17 May 2021 17:34:25 +0800
Message-Id: <20210517093428.670-13-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517093428.670-1-xieyongji@bytedance.com>
References: <20210517093428.670-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now virtio_device_ready() will return error if we get
invalid status. Let's handle this case in both probe
and resume paths.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/virtio/virtio_input.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index f83f8e556fba..a94940efad7a 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -312,7 +312,10 @@ static int virtinput_probe(struct virtio_device *vdev)
 		}
 	}
 
-	virtio_device_ready(vdev);
+	err = virtio_device_ready(vdev);
+	if (err)
+		goto err_mt_init_slots;
+
 	vi->ready = true;
 	err = input_register_device(vi->idev);
 	if (err)
@@ -375,7 +378,11 @@ static int virtinput_restore(struct virtio_device *vdev)
 	if (err)
 		return err;
 
-	virtio_device_ready(vdev);
+	err = virtio_device_ready(vdev);
+	if (err) {
+		vdev->config->del_vqs(vdev);
+		return err;
+	}
 	vi->ready = true;
 	virtinput_fill_evt(vi);
 	return 0;
-- 
2.11.0

