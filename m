Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814433ACAE3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbhFRMb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbhFRMbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:31:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9800BC0617AD
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:29:30 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gb32so7480871ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6wRX4HPCaGutJw3bYLjBLXUq3zLRyE1+eOW0JgncFJc=;
        b=CEd97yYbtvV0v1LmO+q2bTBw7Qtl3xJMwvhd9t4Lil4+Fbw07BwVwoR9PLbsPWRjwd
         18GAV1G219qqm8dsZ07IWcV9HUpy7chDMtm93N0Za8LJySolpyMELZqqbAaS6XFWD/53
         OHnb7HV/yE38Q2nYFMEzRkLeddnSTu0QgPPG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6wRX4HPCaGutJw3bYLjBLXUq3zLRyE1+eOW0JgncFJc=;
        b=ZSzPxlInWQRNfPdnKp5Zm+28M3SCeNFv2xk5yMnsATWMOojO0K+wEE8S90mrEKlPhY
         PJ/yqTRv6zgN1Mz8LuOBiAwo4jZt29Z0F8c01xZnFTZ6AgjG7JxIRY0xbnTEKx7vIYTl
         GpM5Y46cML2ttBENzIoZ17++dLCA7e5KzWnQfAwaJNlsBlp5yVcVlJz+21B7rgk0OrLQ
         Lyld+0idQFNDYXXaoHXgjCSirAd1friZdWPHM8dyrBamn2YrP+EmxUeEBT2I2gaLzv5k
         a2oxNFffqUa7uiH2l5T4HTWxbfnOegI4F9pcETsw6lM4UNtvrUHZnCnU1lOZoyyz5r67
         NDpg==
X-Gm-Message-State: AOAM533MDV8YNfGxv/LDjziOLR9+eA6efmpELM5u5w4/4v9zflyxGvr1
        vVPW6eYxWMMGEZM9eqNEaKhNBQ==
X-Google-Smtp-Source: ABdhPJzrSsLi4kK+p6sqOp0tWVQ2vgYcQmlx1l4mb/fEscINwlr4sslX/08TI/2aryQgIh8CKZ2yxw==
X-Received: by 2002:a17:906:670c:: with SMTP id a12mr10565252ejp.249.1624019369226;
        Fri, 18 Jun 2021 05:29:29 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id o26sm4336403edt.62.2021.06.18.05.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 05:29:28 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v10 05/21] media: uvcvideo: Remove s_ctrl and g_ctrl
Date:   Fri, 18 Jun 2021 14:29:07 +0200
Message-Id: <20210618122923.385938-6-ribalda@chromium.org>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210618122923.385938-1-ribalda@chromium.org>
References: <20210618122923.385938-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we do not implement these callbacks the framework will call the
ext_ctrl callbaks instead, which are a superset of this functions.

Suggested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 56 --------------------------------
 1 file changed, 56 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 47b0e3224205..ac98869d5a05 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -983,60 +983,6 @@ static int uvc_ioctl_query_ext_ctrl(struct file *file, void *fh,
 	return 0;
 }
 
-static int uvc_ioctl_g_ctrl(struct file *file, void *fh,
-			    struct v4l2_control *ctrl)
-{
-	struct uvc_fh *handle = fh;
-	struct uvc_video_chain *chain = handle->chain;
-	struct v4l2_ext_control xctrl;
-	int ret;
-
-	memset(&xctrl, 0, sizeof(xctrl));
-	xctrl.id = ctrl->id;
-
-	ret = uvc_ctrl_begin(chain);
-	if (ret < 0)
-		return ret;
-
-	ret = uvc_ctrl_get(chain, &xctrl);
-	uvc_ctrl_rollback(handle);
-	if (ret < 0)
-		return ret;
-
-	ctrl->value = xctrl.value;
-	return 0;
-}
-
-static int uvc_ioctl_s_ctrl(struct file *file, void *fh,
-			    struct v4l2_control *ctrl)
-{
-	struct uvc_fh *handle = fh;
-	struct uvc_video_chain *chain = handle->chain;
-	struct v4l2_ext_control xctrl;
-	int ret;
-
-	memset(&xctrl, 0, sizeof(xctrl));
-	xctrl.id = ctrl->id;
-	xctrl.value = ctrl->value;
-
-	ret = uvc_ctrl_begin(chain);
-	if (ret < 0)
-		return ret;
-
-	ret = uvc_ctrl_set(handle, &xctrl);
-	if (ret < 0) {
-		uvc_ctrl_rollback(handle);
-		return ret;
-	}
-
-	ret = uvc_ctrl_commit(handle, &xctrl, 1);
-	if (ret < 0)
-		return ret;
-
-	ctrl->value = xctrl.value;
-	return 0;
-}
-
 static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
 				 struct v4l2_ext_controls *ctrls)
 {
@@ -1522,8 +1468,6 @@ const struct v4l2_ioctl_ops uvc_ioctl_ops = {
 	.vidioc_s_input = uvc_ioctl_s_input,
 	.vidioc_queryctrl = uvc_ioctl_queryctrl,
 	.vidioc_query_ext_ctrl = uvc_ioctl_query_ext_ctrl,
-	.vidioc_g_ctrl = uvc_ioctl_g_ctrl,
-	.vidioc_s_ctrl = uvc_ioctl_s_ctrl,
 	.vidioc_g_ext_ctrls = uvc_ioctl_g_ext_ctrls,
 	.vidioc_s_ext_ctrls = uvc_ioctl_s_ext_ctrls,
 	.vidioc_try_ext_ctrls = uvc_ioctl_try_ext_ctrls,
-- 
2.32.0.288.g62a8d224e6-goog

