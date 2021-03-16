Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF72D33DBF3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239686AbhCPSCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239560AbhCPSAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:00:14 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C058C061764
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:00:11 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id bf3so22601681edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PRQWIs8SwlFubdR0GDu4cziiH/M5A56w2Gy/W7zRWOw=;
        b=hkxI7ox6352NkCPGTPb8LhcToWUGzymYf9k1XOa+roXwivP8QYFNpVmWPyw951bBJx
         ATBDYcHL/X2fibi5vtW3Nci5O3Qo7cPiA8hyMpnHAcNjSP6WjccViWQ1kIxVz2gihC+s
         IX1OdjHQ18HaPW/lBgpk2JZTbmr4Xh4kHW38U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PRQWIs8SwlFubdR0GDu4cziiH/M5A56w2Gy/W7zRWOw=;
        b=uLM4+6zp5JMvmO4WqRcaHfQ3TqOyYFqeQKd1qP8u7rOtBLbKzNygqINB9q2bLLojKC
         NQoqE/pWIBjUt47IXs9MEImEem+CmfdMeVxPaZ7Vo9KcdpbWJBrD02STScr+BaeCbUg+
         yQrF9lFJXg7h6zgwfuzWxK+IJJEMoSrvOGz7zO1KW3DrCApSTzTH5DX6f4xQYOGknoWL
         cjBiES2Bw1QPIb1rIcCge3+8kw+88aW7olQCA2x1Z2LRPXjtu6Klxb1BUyaJzbYkf92O
         K92qagoXtOjGofC8Q4sqEMKvb/Pcuq4cEW5JkWKVfjXaqFr9RRXVPk2Z0EN/O+bp+ila
         JHhQ==
X-Gm-Message-State: AOAM532KFX9Gr2P0mwqMxj0P1FPM1e+RmR5N4cgnrtHzUbAKX+6kb7vW
        bNgN8+/6TAZIYkqzT3dKp53b3IKNDWmX2MRgkBc=
X-Google-Smtp-Source: ABdhPJyWBu0RaBqt9JZpztitrtCSI/CNxgojGhDDr0Xnn7dN1Gn5njaybArhFci3CfhqcVokxO/LgQ==
X-Received: by 2002:a05:6402:1613:: with SMTP id f19mr38099777edv.222.1615917610177;
        Tue, 16 Mar 2021 11:00:10 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id c19sm10953182edu.20.2021.03.16.11.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 11:00:09 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v5 04/13] media: uvcvideo: Check controls flags before accessing them
Date:   Tue, 16 Mar 2021 18:59:54 +0100
Message-Id: <20210316180004.1605727-5-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210316180004.1605727-1-ribalda@chromium.org>
References: <20210316180004.1605727-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can figure out if reading/writing a set of controls can fail without
accessing them by checking their flags.

This way we can honor the API closer:

If an error is found when validating the list of controls passed with
VIDIOC_G_EXT_CTRLS, then error_idx shall be set to ctrls->count to
indicate to userspace that no actual hardware was touched.

Fixes v4l2-compliance:
Control ioctls (Input 0):
		warn: v4l2-test-controls.cpp(765): g_ext_ctrls(0) invalid error_idx 0
                fail: v4l2-test-controls.cpp(645): invalid error index write only control
        test VIDIOC_G/S/TRY_EXT_CTRLS: FAIL

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 69 +++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 18 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 157310c0ca87..e956d833ed84 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -1040,31 +1040,54 @@ static int uvc_ioctl_s_ctrl(struct file *file, void *fh,
 	return 0;
 }
 
-static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
-				 struct v4l2_ext_controls *ctrls)
+static int uvc_ctrl_check_access(struct uvc_video_chain *chain,
+				 struct v4l2_ext_controls *ctrls, bool read)
 {
-	struct uvc_fh *handle = fh;
-	struct uvc_video_chain *chain = handle->chain;
 	struct v4l2_ext_control *ctrl = ctrls->controls;
 	unsigned int i;
-	int ret;
+	int ret = 0;
 
-	if (ctrls->which == V4L2_CTRL_WHICH_DEF_VAL) {
-		for (i = 0; i < ctrls->count; ++ctrl, ++i) {
-			struct v4l2_queryctrl qc = { .id = ctrl->id };
+	for (i = 0; i < ctrls->count; ++ctrl, ++i) {
+		struct v4l2_queryctrl qc = { .id = ctrl->id };
 
-			ret = uvc_query_v4l2_ctrl(chain, &qc);
-			if (ret < 0) {
-				ctrls->error_idx = i;
-				return ret;
-			}
+		ret = uvc_query_v4l2_ctrl(chain, &qc);
+		if (ret < 0)
+			break;
 
+		if (ctrls->which == V4L2_CTRL_WHICH_DEF_VAL) {
 			ctrl->value = qc.default_value;
+			continue;
 		}
 
-		return 0;
+		if (qc.flags & V4L2_CTRL_FLAG_WRITE_ONLY && read) {
+			ret = -EACCES;
+			break;
+		}
+
+		if (qc.flags & V4L2_CTRL_FLAG_READ_ONLY && !read) {
+			ret = -EACCES;
+			break;
+		}
 	}
 
+	ctrls->error_idx = ctrls->count;
+
+	return ret;
+}
+
+static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
+				 struct v4l2_ext_controls *ctrls)
+{
+	struct uvc_fh *handle = fh;
+	struct uvc_video_chain *chain = handle->chain;
+	struct v4l2_ext_control *ctrl = ctrls->controls;
+	unsigned int i;
+	int ret;
+
+	ret = uvc_ctrl_check_access(chain, ctrls, true);
+	if (ret < 0 || ctrls->which == V4L2_CTRL_WHICH_DEF_VAL)
+		return ret;
+
 	ret = uvc_ctrl_begin(chain);
 	if (ret < 0)
 		return ret;
@@ -1092,10 +1115,6 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
 	unsigned int i;
 	int ret;
 
-	/* Default value cannot be changed */
-	if (ctrls->which == V4L2_CTRL_WHICH_DEF_VAL)
-		return -EINVAL;
-
 	ret = uvc_ctrl_begin(chain);
 	if (ret < 0)
 		return ret;
@@ -1121,6 +1140,16 @@ static int uvc_ioctl_s_ext_ctrls(struct file *file, void *fh,
 				 struct v4l2_ext_controls *ctrls)
 {
 	struct uvc_fh *handle = fh;
+	struct uvc_video_chain *chain = handle->chain;
+	int ret;
+
+	/* Default value cannot be changed */
+	if (ctrls->which == V4L2_CTRL_WHICH_DEF_VAL)
+		return -EINVAL;
+
+	ret = uvc_ctrl_check_access(chain, ctrls, false);
+	if (ret < 0)
+		return ret;
 
 	return uvc_ioctl_s_try_ext_ctrls(handle, ctrls, true);
 }
@@ -1130,6 +1159,10 @@ static int uvc_ioctl_try_ext_ctrls(struct file *file, void *fh,
 {
 	struct uvc_fh *handle = fh;
 
+	/* Default value cannot be changed */
+	if (ctrls->which == V4L2_CTRL_WHICH_DEF_VAL)
+		return -EINVAL;
+
 	return uvc_ioctl_s_try_ext_ctrls(handle, ctrls, false);
 }
 
-- 
2.31.0.rc2.261.g7f71774620-goog

