Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49E33422F2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 18:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhCSRJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 13:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhCSRJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:09:14 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA70C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:09:13 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id e7so11587372edu.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pNpKPYKhqYWQcwk8nAlLqOQJ2RG6X0m+XUJIPj/sXUs=;
        b=KtBwtIbzTIJyT6+OdVb/AyxBOly4BERSPTivBZeBVlApp4CddeihRdsgSGhu2xCLPP
         VQn+770AnwzSJf8JKVd0yCizoCo8kyATeW2R8c+fJmKyDsQzxzj4SsL5QkxY8PuNjVt6
         eNj2qtlGcCDGK4lOFaU1UKoFjUwludjdLsVFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pNpKPYKhqYWQcwk8nAlLqOQJ2RG6X0m+XUJIPj/sXUs=;
        b=nQC1IGfyeXiDd5mS+LC6lPZT5D9xySNTq9XM4jif5YPA8KTYCJG5D/NumwX5pt3M22
         2eTNRvNi80XnryzkLu7Q+VsVKjKAEBmOaQ6DMM13WMmJxXVC26bJcgmZocWBGczeiFx5
         HTWoUD4B2jjCU0BsJLts7PByNGjO9TtTCVKWTA9nyAaWSe1jr1r91/mUF7v4tyv3WkuI
         +aHxYFbB+xoxkH1CyZ95gLOtnMcqYk1GdrNY3pLb/UCgBDleCa6Volh4V6h7I3ih1ODj
         RJE+pIqiPGLwYTw13T6amz47gc0c6Lbm8x7WTw+l3ZtUQX7ECZv7DmzKU6hOMd8j/OJ0
         0pkg==
X-Gm-Message-State: AOAM532qRurd7xCrXylp4lMUKAV9JUbmYw9quBZxaCX1rjQNs1FXfEz7
        Zn7+pEcwerhJtIMT3XeKWheimw==
X-Google-Smtp-Source: ABdhPJyul9mTyS/jxpBE/5JWSkO6J5YDRb1DIi0nB6xIYpnzyudLtPCyCgb44xzXzL/oQ/4/Vsc2sA==
X-Received: by 2002:aa7:c815:: with SMTP id a21mr10847723edt.38.1616173752727;
        Fri, 19 Mar 2021 10:09:12 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id be27sm4506050edb.47.2021.03.19.10.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 10:09:12 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v8 05/19] media: uvcvideo: Remove s_ctrl and g_ctrl
Date:   Fri, 19 Mar 2021 18:08:52 +0100
Message-Id: <20210319170906.278238-6-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210319170906.278238-1-ribalda@chromium.org>
References: <20210319170906.278238-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we do not implement these callback the framework will call the ext_ctrl
callbaks instead, which are a superset of this functions.

Suggested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
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
2.31.0.rc2.261.g7f71774620-goog

