Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7340B3422F6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 18:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhCSRJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 13:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhCSRJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:09:15 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EB7C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:09:14 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z1so11648810edb.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u3RrB5yMnIIEoq7jfEuwhsCMgc7+RIV/M4RImdGKBho=;
        b=AWRzBKY/3/+eP8Kjx6xHDUHbGFRl3vOeS1RngRF1sONcUk0MLKC+thk84sGxkP9tV4
         u2KB/wYgLo01ATifLj4Kpl+zaCjIkjBYLk6AdesyD3Uf1DAhpb28841Sfe4wVHYx/qcJ
         yCrcdh+5WRg2tp4F9vH2P8PJAHpORtVBkorc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u3RrB5yMnIIEoq7jfEuwhsCMgc7+RIV/M4RImdGKBho=;
        b=Vq9mF1kE4KBAwoI+3fJA3FMUGicd4HzILKub2hK8HqLwKi++O5YOg+JJNLUwkcMdL9
         DclsJXmGfJ0V0MT4B5VDvRey63byO62gjP09nPogZO6AdMIO4g5KU+Dqr/MgbZvc2vQJ
         8v7aR95XhBpnmbnDfkti/df1zaKu7XQCF5S+yy7W3AY8/GcKBxC/bHeHuNjSUgbaLw5p
         3GN0+S3FOEY+rK4ZNBJGj4+Qf0Xg80YS3m5FOQMy2mt0w63/xtj8boc4/LLcgQ4KcdOc
         wbwgL91tRNcEI+sFpmxu/tZpPr3dCsFT5s0Fh8HwQQgjdSO17LyQOFHCVZuwhlO71IF4
         Ds8Q==
X-Gm-Message-State: AOAM532tRjnKgXN/YWrqf6DIkwbJrMVn8bdDMUtPylvcK1RNJrryNxzF
        UEnY704hpEqfobYUDQ2XS/4U3d5yovEfzaQaKVk=
X-Google-Smtp-Source: ABdhPJxJODHkZIzQSUXeS0OOccgP1VAclAEXc/COEDFN5ZyF+a+4FTTRqe9iXcEUubKCZZfjO603pA==
X-Received: by 2002:a05:6402:22f6:: with SMTP id dn22mr10544010edb.214.1616173753540;
        Fri, 19 Mar 2021 10:09:13 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id be27sm4506050edb.47.2021.03.19.10.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 10:09:13 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v8 06/19] media: uvcvideo: Set capability in s_param
Date:   Fri, 19 Mar 2021 18:08:53 +0100
Message-Id: <20210319170906.278238-7-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210319170906.278238-1-ribalda@chromium.org>
References: <20210319170906.278238-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes v4l2-compliance:

Format ioctls (Input 0):
                warn: v4l2-test-formats.cpp(1339): S_PARM is supported but doesn't report V4L2_CAP_TIMEPERFRAME
                fail: v4l2-test-formats.cpp(1241): node->has_frmintervals && !cap->capability

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index ac98869d5a05..1eeeb00280e4 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -472,10 +472,13 @@ static int uvc_v4l2_set_streamparm(struct uvc_streaming *stream,
 	uvc_simplify_fraction(&timeperframe.numerator,
 		&timeperframe.denominator, 8, 333);
 
-	if (parm->type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
+	if (parm->type == V4L2_BUF_TYPE_VIDEO_CAPTURE) {
 		parm->parm.capture.timeperframe = timeperframe;
-	else
+		parm->parm.capture.capability = V4L2_CAP_TIMEPERFRAME;
+	} else {
 		parm->parm.output.timeperframe = timeperframe;
+		parm->parm.output.capability = V4L2_CAP_TIMEPERFRAME;
+	}
 
 	return 0;
 }
-- 
2.31.0.rc2.261.g7f71774620-goog

