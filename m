Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B56741B902
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 23:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242865AbhI1VMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 17:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242832AbhI1VMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 17:12:16 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AA2C061746
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:10:36 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d21so579548wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lD4niKDilEMX7zDJBRMemePBtPvpzw+b4kObqWv/wwI=;
        b=iDiopEYMMlpsS0rQBirA/XVu0VHIZ0Kz+YwqkutRSKikCselS2KRuqwVffVU48lQgN
         lUz7PuLU0itnNb9Zc7AsSXv9bv0tMsCsr/6F+0j8uP7YCr47RL8bbSSC49ydQE5drjid
         kvS8x6iXAi9pChsvr1Mr1u4xiIwkovnpXOccQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lD4niKDilEMX7zDJBRMemePBtPvpzw+b4kObqWv/wwI=;
        b=e2lWj1K9g6J4398tV2A1gRNDw6fB5fyeqckNKILbb7ItfcjxQLGbd1I4o2uRrwpwCC
         /wrduBR05ijfij3ZDHnAhiLGLhmC8Td28tdUyD3oXvTbzfiM0OJL/XbA+KrvHb0+uqQ5
         hQHNXjMtbVEjhZbPRkKlKp5KlwkkU5FbOvUEfikh1D+unPR7kOjw0HNzxyUe1cCCY81n
         GbJsrweFeFSZheYaQuc4pYbBMlfRiaSy8UMsRlqGiwhe5yZVhlzEWVHBJlc9Dxm7/JVh
         LWia7+x3J4HdpKl4KYJQ60oDB83sHlZPEiUpwQWQtTpCDydwTgtwSJfT6I8l8ErnL/6b
         7JFw==
X-Gm-Message-State: AOAM532g8oGIEc5jfCAsNk0ttPrIESVaWYb1bj3hGPDaeDvw9CCOQauQ
        3xbM/bv3VJu/6cnsj77W0S3GaA==
X-Google-Smtp-Source: ABdhPJwNGRCcjdCkbOYnbPHI+rp5HDlskU2wxIF/pgf8kIyW2GkLUf5iI5Q8Ykd+OZ82Sn4WuaIofw==
X-Received: by 2002:adf:f890:: with SMTP id u16mr2597000wrp.388.1632863435363;
        Tue, 28 Sep 2021 14:10:35 -0700 (PDT)
Received: from beni.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id n68sm3885773wmn.13.2021.09.28.14.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 14:10:34 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 1/7] media: ipu3-cio2: Check num_planes and sizes in queue_setup
Date:   Tue, 28 Sep 2021 21:10:27 +0000
Message-Id: <20210928211033.2415162-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210928211033.2415162-1-ribalda@chromium.org>
References: <20210928211033.2415162-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If num_planes is different than zero num_planes and sizes must be
checked to support the format.

Fix the following v4l2-compliance error:

Buffer ioctls (Input 0):
    fail: v4l2-test-buffers.cpp(717): q.create_bufs(node, 1, &fmt) != EINVAL
  test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: FAIL

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/intel/ipu3/ipu3-cio2-main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
index 47db0ee0fcbfa..36099e95d29f2 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
@@ -798,13 +798,17 @@ static int cio2_vb2_queue_setup(struct vb2_queue *vq,
 	struct cio2_queue *q = vb2q_to_cio2_queue(vq);
 	unsigned int i;
 
-	*num_planes = q->format.num_planes;
+	if (*num_planes && *num_planes < q->format.num_planes)
+		return -EINVAL;
 
-	for (i = 0; i < *num_planes; ++i) {
+	for (i = 0; i < q->format.num_planes; ++i) {
+		if (*num_planes && sizes[i] < q->format.plane_fmt[i].sizeimage)
+			return -EINVAL;
 		sizes[i] = q->format.plane_fmt[i].sizeimage;
 		alloc_devs[i] = &cio2->pci_dev->dev;
 	}
 
+	*num_planes = q->format.num_planes;
 	*num_buffers = clamp_val(*num_buffers, 1, CIO2_MAX_BUFFERS);
 
 	/* Initialize buffer queue */
-- 
2.33.0.685.g46640cef36-goog

