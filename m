Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E8941EBCD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 13:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353844AbhJAL1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 07:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353645AbhJAL1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 07:27:10 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BDFC06177D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 04:25:26 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id t16-20020a1c7710000000b003049690d882so10939846wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 04:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tcQmVSrI7OejMP059qa+UggNTXs47BJZTPvAsqru6K4=;
        b=kxEmcp38i2Zwrx2Y/ZDQXaeMbeRJ+t1lH5XmKz2J+JrGtkIvbq+sh/0qJKz6+tbKDu
         AmAGA4Ig1Q/ZwFqedhf0qO64zNOEF+jxQ3IKuazABzsWXgf24E1L0g24WX2+0hGY5oC2
         exHMzWvERhGa4MZsdzcBNCgF3QI6aVQu1OMKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tcQmVSrI7OejMP059qa+UggNTXs47BJZTPvAsqru6K4=;
        b=1c04XuUHgVBbp3c4KPFsZZxTKKuHRBQuXmBdxC7G9GXmr3HqIG7/ytPHglkn1kXX3L
         YkqgfwbjkliA15BYs381cjVVcc/Ecxw2HYvwL9Tqn+MRrJsXQTV3mjs1DWdSDuXIrzAj
         6a54jCvryGcOQW/61MqblkET5uHQOYGn6QCoVox0EIazOWiVjUvUZlXSyaInDBCWanPN
         kMV/VIXfipbCGDjKv2zy44HzOGTST0tXv6yqKZB+ivMud0L51P1rCTewwqr0uWShEbYc
         LnEKABOCrfNQP+jvhssNwZLA8mq8QY8SD8v6U14EU5ArjEkWfFN5cl/bszeS2oqJefd1
         a0Wg==
X-Gm-Message-State: AOAM531qfnVWVFKoew7/fS3g1Ey2aj+MJUAs1jndWJswYo7LMX4+kQyX
        rO0rTAwaKSpash0eQoO2VTEXjQ==
X-Google-Smtp-Source: ABdhPJxFFSdqYaT34QsUzUV4aO+hqTEvapgasOeqx8dhRNM+mrPE+kM+gPRAj3JHwZZS5GoHLuyoHw==
X-Received: by 2002:a1c:f609:: with SMTP id w9mr3935009wmc.24.1633087525430;
        Fri, 01 Oct 2021 04:25:25 -0700 (PDT)
Received: from beni.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id x17sm5530958wrc.51.2021.10.01.04.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 04:25:25 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 1/8] media: ipu3-cio2 Check num_planes and sizes in queue_setup
Date:   Fri,  1 Oct 2021 11:25:15 +0000
Message-Id: <20211001112522.2839602-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20211001112522.2839602-1-ribalda@chromium.org>
References: <20211001112522.2839602-1-ribalda@chromium.org>
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

Reviewed-by: Bingbu Cao <bingbu.cao@intel.com>
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
2.33.0.800.g4c38ced690-goog

