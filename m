Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E8B33F5FA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbhCQQqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbhCQQpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:45:25 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89E9C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:45:24 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r17so3648611ejy.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I6IuDlFZqIF7OdGY1GHnUMpp2sHuK6tNXCSbhL6sTtU=;
        b=EfnAtShwVZzTXJG1oN2W36jCsLnjr8VV9G0YxIiczvadTVonm/dCTixZl1zSoUDNin
         vFqOLpIWik5FBzjN2Jw8X8lSZzOmZHS1EQAaGFzNFrv6PXsJGM9jsR3QYpZWJC0EzeFj
         KK4vJu8OzSgI7x6tqlPnQ49Nt3yYPoaBIvZQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I6IuDlFZqIF7OdGY1GHnUMpp2sHuK6tNXCSbhL6sTtU=;
        b=UForJR8Ns/QV9/F6YfNrAAgdUzVemOs7NTn1ksZAAoKnEgnbbpJMtshqsQGw8gdwrh
         zjiKv03oVJCMNhhKP9DyEZOMTPrKZHFeykSAxEJeIXgkpNz5dz4O2J2juP14hNxdxf3G
         /2naPpKhpEfamCkUYJnyfpY8VPB1JItq6TZPH+uD6d4vbJsRKb+/aq8lhHki6rBE/sTQ
         UB6EGSFyzJQnysT9LZmVL9fShYUOgqq9495KCgwLDXI1pRio2PRCx2s7eonATMFRzt80
         s+RPzhf5ychzqopuyqY8GIkVPMM5UjVYrkvaNROFxOUGEJ7bryCzYugd5EBflPxUXEeK
         qy+Q==
X-Gm-Message-State: AOAM5303wYfAa3HJWHdiQ+0GHqrBRbAzqc3x713mSRi85nGcV5EoSmrD
        87FhrbrRfCunVCJvy+SGUot0vw==
X-Google-Smtp-Source: ABdhPJzJVQGw+/t8qtsQCjckiUI0Zoh6FuxxGbykHNdNFwip293A0RlkXvVyAAnd3S4ywrkdgrl1ZQ==
X-Received: by 2002:a17:906:25c4:: with SMTP id n4mr36710570ejb.359.1615999523668;
        Wed, 17 Mar 2021 09:45:23 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id hy25sm12088128ejc.119.2021.03.17.09.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 09:45:23 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH v6 16/17] media: uvcvideo: Return -EACCES to inactive controls
Date:   Wed, 17 Mar 2021 17:45:10 +0100
Message-Id: <20210317164511.39967-17-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210317164511.39967-1-ribalda@chromium.org>
References: <20210317164511.39967-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a control is inactive return -EACCES to let the userspace know that
the value will not be applied automatically when the control is active
again.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Suggested-by: Hans Verkuil <hverkuil@xs4all.nl>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 73 +++++++++++++++++++++++++-------
 drivers/media/usb/uvc/uvc_v4l2.c | 11 ++++-
 drivers/media/usb/uvc/uvcvideo.h |  3 +-
 3 files changed, 69 insertions(+), 18 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index af1d4d9b8afb..26d3494b401b 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1046,10 +1046,62 @@ static int uvc_query_v4l2_class(struct uvc_video_chain *chain, u32 req_id,
 	return 0;
 }
 
-int uvc_ctrl_is_accesible(struct uvc_video_chain *chain, u32 v4l2_id, bool read)
+static bool uvc_ctrl_is_inactive(struct uvc_video_chain *chain,
+				 struct uvc_control *ctrl,
+				 struct uvc_control_mapping *mapping)
+{
+	struct uvc_control_mapping *master_map = NULL;
+	struct uvc_control *master_ctrl = NULL;
+	s32 val;
+	int ret;
+
+	if (!mapping->master_id)
+		return false;
+
+	__uvc_find_control(ctrl->entity, mapping->master_id, &master_map,
+			   &master_ctrl, 0);
+
+	if (!master_ctrl || !(master_ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR))
+		return false;
+
+	ret = __uvc_ctrl_get(chain, master_ctrl, master_map, &val);
+	if (ret < 0 || val == mapping->master_manual)
+		return false;
+
+	return true;
+}
+
+int uvc_ctrl_is_accesible(struct uvc_video_chain *chain, u32 v4l2_id,
+			  unsigned long ioctl)
 {
 	struct uvc_control_mapping *mapping;
 	struct uvc_control *ctrl;
+	bool read, try;
+
+	switch (ioctl) {
+	case VIDIOC_G_EXT_CTRLS:
+		read = true;
+		try = false;
+		break;
+	case VIDIOC_S_EXT_CTRLS:
+		read = false;
+		try = false;
+		break;
+	case VIDIOC_TRY_EXT_CTRLS:
+		read = false;
+		try = true;
+		break;
+	case VIDIOC_G_CTRL:
+		read = true;
+		try = false;
+		break;
+	case VIDIOC_S_CTRL:
+		read = false;
+		try = false;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	if (__uvc_query_v4l2_class(chain, v4l2_id, 0) >= 0)
 		return -EACCES;
@@ -1064,6 +1116,9 @@ int uvc_ctrl_is_accesible(struct uvc_video_chain *chain, u32 v4l2_id, bool read)
 	if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR) && !read)
 		return -EACCES;
 
+	if (!read && !try && uvc_ctrl_is_inactive(chain, ctrl, mapping))
+		return -EACCES;
+
 	return 0;
 }
 
@@ -1086,8 +1141,6 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 	struct uvc_control_mapping *mapping,
 	struct v4l2_queryctrl *v4l2_ctrl)
 {
-	struct uvc_control_mapping *master_map = NULL;
-	struct uvc_control *master_ctrl = NULL;
 	const struct uvc_menu_info *menu;
 	unsigned int i;
 
@@ -1103,18 +1156,8 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 	if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
 		v4l2_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
 
-	if (mapping->master_id)
-		__uvc_find_control(ctrl->entity, mapping->master_id,
-				   &master_map, &master_ctrl, 0);
-	if (master_ctrl && (master_ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR)) {
-		s32 val;
-		int ret = __uvc_ctrl_get(chain, master_ctrl, master_map, &val);
-		if (ret < 0)
-			return ret;
-
-		if (val != mapping->master_manual)
-				v4l2_ctrl->flags |= V4L2_CTRL_FLAG_INACTIVE;
-	}
+	if (uvc_ctrl_is_inactive(chain, ctrl, mapping))
+		v4l2_ctrl->flags |= V4L2_CTRL_FLAG_INACTIVE;
 
 	if (!ctrl->cached) {
 		int ret = uvc_ctrl_populate_cache(chain, ctrl);
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index ce55b4bff687..8e9051a245c7 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -999,6 +999,10 @@ static int uvc_ioctl_g_ctrl(struct file *file, void *fh,
 	struct v4l2_ext_control xctrl;
 	int ret;
 
+	ret = uvc_ctrl_is_accesible(chain, ctrl->id, VIDIOC_G_CTRL);
+	if (ret)
+		return ret;
+
 	memset(&xctrl, 0, sizeof(xctrl));
 	xctrl.id = ctrl->id;
 
@@ -1023,6 +1027,10 @@ static int uvc_ioctl_s_ctrl(struct file *file, void *fh,
 	struct v4l2_ext_control xctrl;
 	int ret;
 
+	ret = uvc_ctrl_is_accesible(chain, ctrl->id, VIDIOC_S_CTRL);
+	if (ret)
+		return ret;
+
 	memset(&xctrl, 0, sizeof(xctrl));
 	xctrl.id = ctrl->id;
 	xctrl.value = ctrl->value;
@@ -1054,8 +1062,7 @@ static int uvc_ctrl_check_access(struct uvc_video_chain *chain,
 	int ret = 0;
 
 	for (i = 0; i < ctrls->count; ++ctrl, ++i) {
-		ret = uvc_ctrl_is_accesible(chain, ctrl->id,
-					    ioctl == VIDIOC_G_EXT_CTRLS);
+		ret = uvc_ctrl_is_accesible(chain, ctrl->id, ioctl);
 		if (ret)
 			break;
 	}
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 3288b118264e..4e86d0983d58 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -902,7 +902,8 @@ static inline int uvc_ctrl_rollback(struct uvc_fh *handle)
 
 int uvc_ctrl_get(struct uvc_video_chain *chain, struct v4l2_ext_control *xctrl);
 int uvc_ctrl_set(struct uvc_fh *handle, struct v4l2_ext_control *xctrl);
-int uvc_ctrl_is_accesible(struct uvc_video_chain *chain, u32 v4l2_id, bool read);
+int uvc_ctrl_is_accesible(struct uvc_video_chain *chain, u32 v4l2_id,
+			  unsigned long ioctl);
 
 int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
 		      struct uvc_xu_control_query *xqry);
-- 
2.31.0.rc2.261.g7f71774620-goog

