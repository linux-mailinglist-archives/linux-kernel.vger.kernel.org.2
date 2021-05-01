Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1530C37065E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 10:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhEAIVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 04:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbhEAIVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 04:21:04 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A72C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 01:20:14 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id d10so223153pgf.12
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 01:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oQxgXbJ1dnrWy/sF8jzljIADGkpBbS6PQOX1pY2bYYo=;
        b=VURGzM4OPnfrdmIm//RVnKQL79RLkBI0T8BgdQBowgY0j5tVNn/+Hq5Py34gS/Smvg
         kGBDeRlUZYd1QDPXLTW6+a5FC5mPKJB1vbd9n6z4BxO3hUntkv8fm6LjZIRNd2n0i3do
         hMAt+TwerUTkos/kLxHqQM5tyybQb9w98VR/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oQxgXbJ1dnrWy/sF8jzljIADGkpBbS6PQOX1pY2bYYo=;
        b=WfcWcIH2Bf8BgqwVesKjuA/N5Pvv4TqnN9tJ2fBHxWWGktraflB17R1tpIYPVtaD5m
         DOiMGbcx24BAj0FKxUER/xVHeXW8aJezL7YocD8O6UtDGCGErKJwUzcJ6u15mHUHnio4
         GYRZiKQjAD9fpz+BD2D8Snwnf1Ps5WPreH8aiiDwnXxhgFHnMqorID5WoqGlewETFRVl
         dUVCbHqmRQpWptm3YFrflTAiO1qN3M+99zgCsniAHy5kNPeN9yttMIpiGVo93ziIS5Rl
         NmTBdc5GGE148RnmQfq+yV2mAsKQnKAxxiuFzvABNnd2an+ip+F4NfFa6MiXVDxUd7dT
         Xtig==
X-Gm-Message-State: AOAM533b8vl+dDYJNQv6lQrtSc7atShZFXOiNvEPgICa2ex8yqpzR2eZ
        N6M+cIPnK6VXEXDYI7q7/atlQQ==
X-Google-Smtp-Source: ABdhPJwSRfoW6Pm2vHysB79ZLPzTk5PqgOCbrbYBiLdUsztTASGUah0iW4Ly6W7zWsthXpAG7lSCDw==
X-Received: by 2002:a63:fc10:: with SMTP id j16mr8592123pgi.152.1619857213836;
        Sat, 01 May 2021 01:20:13 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:8be7:e987:d00a:1442])
        by smtp.gmail.com with ESMTPSA id b7sm3763003pjq.36.2021.05.01.01.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 01:20:13 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ricardo Ribalda <ribalda@chromium.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 2/5] media: v4l UAPI: document ROI selection targets
Date:   Sat,  1 May 2021 17:19:58 +0900
Message-Id: <20210501082001.100533-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
In-Reply-To: <20210501082001.100533-1-senozhatsky@chromium.org>
References: <20210501082001.100533-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document V4L2 selection targets that will be used to ROI
implementation.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 .../media/v4l/selection-api-configuration.rst | 22 +++++++++++++++
 .../media/v4l/selection-api-examples.rst      | 27 +++++++++++++++++++
 .../media/v4l/v4l2-selection-targets.rst      | 24 +++++++++++++++++
 3 files changed, 73 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/selection-api-configuration.rst b/Documentation/userspace-api/media/v4l/selection-api-configuration.rst
index fee49bf1a1c0..b5fdd765e2db 100644
--- a/Documentation/userspace-api/media/v4l/selection-api-configuration.rst
+++ b/Documentation/userspace-api/media/v4l/selection-api-configuration.rst
@@ -135,3 +135,25 @@ and the height of rectangles obtained using ``V4L2_SEL_TGT_CROP`` and
 ``V4L2_SEL_TGT_COMPOSE`` targets. If these are not equal then the
 scaling is applied. The application can compute the scaling ratios using
 these values.
+
+Configuration of Region of Interest (ROI)
+=========================================
+
+The range of auto-controls values and of coordinates of the top left
+corner, width and height of areas that can be ROI is given by the
+``V4L2_SEL_TGT_ROI_BOUNDS_MIN`` and ``V4L2_SEL_TGT_ROI_BOUNDS_MAX``
+targets. It is recommended for the driver developers to put the top/left
+corner at position ``(0,0)``.
+
+The top left corner, width and height of the Region of Interest area
+and auto-controls currently being employed by the device are given by
+the ``V4L2_SEL_TGT_ROI`` target. It uses the same coordinate system
+as ``V4L2_SEL_TGT_ROI_BOUNDS_MIN`` and ``V4L2_SEL_TGT_ROI_BOUNDS_MAX``.
+
+In order to change active ROI top left, width and height coordinates
+and ROI auto-controls use ``V4L2_SEL_TGT_ROI`` target.
+
+Each capture device has a default ROI rectangle and auto-controls
+value given by the ``V4L2_SEL_TGT_ROI_DEFAULT`` target. Drivers shall
+set the ROI rectangle to the default when the driver is first loaded,
+but not later.
diff --git a/Documentation/userspace-api/media/v4l/selection-api-examples.rst b/Documentation/userspace-api/media/v4l/selection-api-examples.rst
index 5f8e8a1f59d7..39aba98d55f1 100644
--- a/Documentation/userspace-api/media/v4l/selection-api-examples.rst
+++ b/Documentation/userspace-api/media/v4l/selection-api-examples.rst
@@ -82,3 +82,30 @@ Example: Querying for scaling factors
 	/* computing scaling factors */
 	hscale = (double)compose.r.width / crop.r.width;
 	vscale = (double)compose.r.height / crop.r.height;
+
+Setting Region Of Interest area to half of the default value
+
+Example: Simple ROI
+===========================
+
+.. code-block:: c
+
+	struct v4l2_selection roi = {
+	    .type = V4L2_BUF_TYPE_VIDEO_CAPTURE,
+	    .target = V4L2_SEL_TGT_ROI_DEFAULT,
+	};
+	struct v4l2_rect r;
+
+	ret = ioctl(fd, VIDIOC_G_SELECTION, &roi);
+	if (ret)
+	    exit(-1);
+	/* setting smaller ROI rectangle */
+	r.width = roi.r.width / 2;
+	r.height = roi.r.height / 2;
+	r.left = roi.r.width / 4;
+	r.top = roi.r.height / 4;
+	roi.r = r;
+	roi.target = V4L2_SEL_TGT_ROI;
+	ret = ioctl(fd, VIDIOC_S_SELECTION, &roi);
+	if (ret)
+	    exit(-1);
diff --git a/Documentation/userspace-api/media/v4l/v4l2-selection-targets.rst b/Documentation/userspace-api/media/v4l/v4l2-selection-targets.rst
index b46bae984f35..d1dc9c50eb05 100644
--- a/Documentation/userspace-api/media/v4l/v4l2-selection-targets.rst
+++ b/Documentation/userspace-api/media/v4l/v4l2-selection-targets.rst
@@ -75,6 +75,30 @@ of the two interfaces they are used.
 	modified by hardware.
       - Yes
       - No
+    * - ``V4L2_SEL_TGT_ROI``
+      - 0x0200
+      - Current Region of Interest rectangle and auto-controls value.
+      - Yes
+      - No
+    * - ``V4L2_SEL_TGT_ROI_DEFAULT``
+      - 0x0201
+      - Suggested Region of Interest rectangle and auto-controls value.
+      - Yes
+      - No
+    * - ``V4L2_SEL_TGT_ROI_BOUNDS_MIN``
+      - 0x0202
+      - Minimum bounds of the Region of Interest rectangle and minimum
+	auto-controls value. All valid ROI rectangles and auto-controls
+	should be within minimum-maximum range.
+      - Yes
+      - No
+    * - ``V4L2_SEL_TGT_ROI_BOUNDS_MAX``
+      - 0x0203
+      - Maximum bounds of the Region of Interest rectangle and maximum
+	auto-controls value. All valid ROI rectangles and auto-controls
+	should be within minimum-maximum range.
+      - Yes
+      - No
 
 .. raw:: latex
 
-- 
2.31.1.527.g47e6f16901-goog

