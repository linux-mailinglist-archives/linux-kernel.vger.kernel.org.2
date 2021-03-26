Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DCB34A52D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 11:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhCZJ7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhCZJ6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:58:55 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134B7C0613B2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:58:55 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z1so5617496edb.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UdKbcPL+qZ541Aq+8xy8G+4FUKyoooUhHHCi0e55XOM=;
        b=i6wzuJjbON/1aOWWRc47QAYMRZLyM6FDguvLfnuRNLk7Xlw4PyihscPUsEEYS/SwYp
         PrnoLwL9oNv8LmIGCJgjXqMNCLE0b8JsFTIDNKhocCS4PP49TDaA7EDkZKqIj/pMddcO
         vSs2kE/2V7+9b+/MR6K1iS5zRrItn2oQvLsuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UdKbcPL+qZ541Aq+8xy8G+4FUKyoooUhHHCi0e55XOM=;
        b=WN4rYXJYjMh+XXhgsAioT6KSg9YTO+a8as0TWS3tstgIeN02TJ0jQJSYPq6aHMiV+W
         e8QpR6s4vhdbAJU2llVZ5Y5OgeKMof18Se4OouC/RiqJW7bVjOr8hnYFOQNx9V3Eyqbu
         y3oPPL7e2nib2rbdWxn9oq+TRMdZbKTvRq1fVWkSXdZyvDhvtH3D5rqmgoOQhhIc+Y2g
         P0YT+S71IQR1snfuKf9Gu/4NuGdPgbSHxeHiM7wnXhwtGiT2ZHd0LsYfC3Of9mPc5hTQ
         wkLqQdVocqcamlf8GNu7iVle1rjiMgM2qYyvvLvuaIJQTT9Q7cQ/OICJOphJRwslDxe5
         PFyw==
X-Gm-Message-State: AOAM533RmopY9QOMaemrOF1NACz4d4y0Qf00Vify0p4B48yf5x7iT3zU
        JRZf8QLIkkQ4p06XhNfV6FXZlA==
X-Google-Smtp-Source: ABdhPJwetFNumiw38PnM33J5Tqc0EDjcEZnSuImGKrPPAaEjdWug5aNmgremseSSJb2qSyiPGaoAGQ==
X-Received: by 2002:aa7:da04:: with SMTP id r4mr13995386eds.343.1616752733859;
        Fri, 26 Mar 2021 02:58:53 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id h13sm4036658edz.71.2021.03.26.02.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:58:53 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v9 14/22] media: uvcvideo: Check controls flags before accessing them
Date:   Fri, 26 Mar 2021 10:58:32 +0100
Message-Id: <20210326095840.364424-15-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210326095840.364424-1-ribalda@chromium.org>
References: <20210326095840.364424-1-ribalda@chromium.org>
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

Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 22 ++++++++++++++++++
 drivers/media/usb/uvc/uvc_v4l2.c | 39 ++++++++++++++++++++++++++++----
 drivers/media/usb/uvc/uvcvideo.h |  2 ++
 3 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 929e70dff11a..24fd5afc4e4f 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1046,6 +1046,28 @@ static int uvc_query_v4l2_class(struct uvc_video_chain *chain, u32 req_id,
 	return 0;
 }
 
+int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
+			   bool read)
+{
+	struct uvc_control_mapping *mapping;
+	struct uvc_control *ctrl;
+
+	if (__uvc_query_v4l2_class(chain, v4l2_id, 0) >= 0)
+		return -EACCES;
+
+	ctrl = uvc_find_control(chain, v4l2_id, &mapping);
+	if (!ctrl)
+		return -EINVAL;
+
+	if (!(ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR) && read)
+		return -EACCES;
+
+	if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR) && !read)
+		return -EACCES;
+
+	return 0;
+}
+
 static const char *uvc_map_get_name(const struct uvc_control_mapping *map)
 {
 	const char *name;
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 28ccaa8b9e42..a3ee1dc003fc 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -991,6 +991,26 @@ static int uvc_ioctl_query_ext_ctrl(struct file *file, void *fh,
 	return 0;
 }
 
+static int uvc_ctrl_check_access(struct uvc_video_chain *chain,
+				 struct v4l2_ext_controls *ctrls,
+				 unsigned long ioctl)
+{
+	struct v4l2_ext_control *ctrl = ctrls->controls;
+	unsigned int i;
+	int ret = 0;
+
+	for (i = 0; i < ctrls->count; ++ctrl, ++i) {
+		ret = uvc_ctrl_is_accessible(chain, ctrl->id,
+					    ioctl == VIDIOC_G_EXT_CTRLS);
+		if (ret)
+			break;
+	}
+
+	ctrls->error_idx = ioctl == VIDIOC_TRY_EXT_CTRLS ? i : ctrls->count;
+
+	return ret;
+}
+
 static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
 				 struct v4l2_ext_controls *ctrls)
 {
@@ -1000,6 +1020,10 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
 	unsigned int i;
 	int ret;
 
+	ret = uvc_ctrl_check_access(chain, ctrls, VIDIOC_G_EXT_CTRLS);
+	if (ret < 0)
+		return ret;
+
 	if (ctrls->which == V4L2_CTRL_WHICH_DEF_VAL) {
 		for (i = 0; i < ctrls->count; ++ctrl, ++i) {
 			struct v4l2_queryctrl qc = { .id = ctrl->id };
@@ -1036,13 +1060,17 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
 
 static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
 				     struct v4l2_ext_controls *ctrls,
-				     bool commit)
+				     unsigned long ioctl)
 {
 	struct v4l2_ext_control *ctrl = ctrls->controls;
 	struct uvc_video_chain *chain = handle->chain;
 	unsigned int i;
 	int ret;
 
+	ret = uvc_ctrl_check_access(chain, ctrls, ioctl);
+	if (ret < 0)
+		return ret;
+
 	ret = uvc_ctrl_begin(chain);
 	if (ret < 0)
 		return ret;
@@ -1051,14 +1079,15 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
 		ret = uvc_ctrl_set(handle, ctrl);
 		if (ret < 0) {
 			uvc_ctrl_rollback(handle);
-			ctrls->error_idx = commit ? ctrls->count : i;
+			ctrls->error_idx = ioctl == VIDIOC_S_EXT_CTRLS ?
+						    ctrls->count : i;
 			return ret;
 		}
 	}
 
 	ctrls->error_idx = 0;
 
-	if (commit)
+	if (ioctl == VIDIOC_S_EXT_CTRLS)
 		return uvc_ctrl_commit(handle, ctrls->controls, ctrls->count);
 	else
 		return uvc_ctrl_rollback(handle);
@@ -1069,7 +1098,7 @@ static int uvc_ioctl_s_ext_ctrls(struct file *file, void *fh,
 {
 	struct uvc_fh *handle = fh;
 
-	return uvc_ioctl_s_try_ext_ctrls(handle, ctrls, true);
+	return uvc_ioctl_s_try_ext_ctrls(handle, ctrls, VIDIOC_S_EXT_CTRLS);
 }
 
 static int uvc_ioctl_try_ext_ctrls(struct file *file, void *fh,
@@ -1077,7 +1106,7 @@ static int uvc_ioctl_try_ext_ctrls(struct file *file, void *fh,
 {
 	struct uvc_fh *handle = fh;
 
-	return uvc_ioctl_s_try_ext_ctrls(handle, ctrls, false);
+	return uvc_ioctl_s_try_ext_ctrls(handle, ctrls, VIDIOC_TRY_EXT_CTRLS);
 }
 
 static int uvc_ioctl_querymenu(struct file *file, void *fh,
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index dc20021f7ee0..9471c342a310 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -902,6 +902,8 @@ static inline int uvc_ctrl_rollback(struct uvc_fh *handle)
 
 int uvc_ctrl_get(struct uvc_video_chain *chain, struct v4l2_ext_control *xctrl);
 int uvc_ctrl_set(struct uvc_fh *handle, struct v4l2_ext_control *xctrl);
+int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
+			   bool read);
 
 int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
 		      struct uvc_xu_control_query *xqry);
-- 
2.31.0.291.g576ba9dcdaf-goog

