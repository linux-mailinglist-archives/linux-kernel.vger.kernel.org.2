Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD883ACAFF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbhFRMcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbhFRMb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:31:56 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31365C0613A3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:29:40 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id nb6so15543328ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m+hFJNCbeJLA3oJ6JwV/uvjXUtfmTb5JQKee7MXWqMM=;
        b=Pn2iNfaLXTvxTLKr7AgjS7DzOztYnzoQ+qw+vz1cObxUaUpcqHcnBdYrV1Ghs0mQiU
         EOO1QrWNNG27I2Dc17mWwrtI2QJpM3iCqN9fvzVXWwczWatGYFga0O/Js1ia6VW/Kl+s
         RAjSK1h08kwyZADbgcxDlqROI+ZnT6Lv/yJw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m+hFJNCbeJLA3oJ6JwV/uvjXUtfmTb5JQKee7MXWqMM=;
        b=lTWMJ2I3YiPw/guW7XwHve6D0ICWNdd19GXh9UofIDsDrD5GXV8mQjked+pTUx+tCa
         rYB86hQvbtcmSgNcnkXy750Q/UlgJuhoCyrHOBn/TJl1j5/S5Ugw9d05FV3qmBlI7vSQ
         Ooy5EKxzTrTfNDU3/UelOTaV4DsomPPou23Vs9Tt03DLJlI55I3Ke580XaumLmAkrEWM
         U5OnAW8s70kOIxFm7OhVwbZ1d7iCNcPXDoRWWSWAidkBnFZm6F6cTmsCemC4fyTCGM7R
         D86k0NJ38LA4/YnfccH6Ihc84DVYU8C/nrzx6JTQCnCVafgKodKqo1qUPeEs/qFKRypA
         lbdA==
X-Gm-Message-State: AOAM532Zuf88Erzz+8qUv8csblHnsdr0Jz6jbbp5oQOZxvhACsiH5peH
        f/cZQLL8+HUmz/brXlPD/59rM9KexHDR0Q==
X-Google-Smtp-Source: ABdhPJzLu0wAxu7yCNVgFKEy3ChdRdylbBM9W+1dVY78xPgjWS3AiWqgYkOM1M6l3M7odUGMig3p/w==
X-Received: by 2002:a17:906:5289:: with SMTP id c9mr10823084ejm.342.1624019378767;
        Fri, 18 Jun 2021 05:29:38 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id o26sm4336403edt.62.2021.06.18.05.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 05:29:38 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v10 21/21] media: uvcvideo: Return -EACCES to inactive controls
Date:   Fri, 18 Jun 2021 14:29:23 +0200
Message-Id: <20210618122923.385938-22-ribalda@chromium.org>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210618122923.385938-1-ribalda@chromium.org>
References: <20210618122923.385938-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a control is inactive return -EACCES to let the userspace know that
the value will not be applied automatically when the control is active
again.

Also make sure that query_v4l2_ctrl doesn't return an error.

Suggested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 73 +++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 24 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index da44d5c0b9ad..4f80c06d3c43 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1104,13 +1104,36 @@ static const char *uvc_map_get_name(const struct uvc_control_mapping *map)
 	return "Unknown Control";
 }
 
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
 static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 	struct uvc_control *ctrl,
 	struct uvc_control_mapping *mapping,
 	struct v4l2_queryctrl *v4l2_ctrl)
 {
-	struct uvc_control_mapping *master_map = NULL;
-	struct uvc_control *master_ctrl = NULL;
 	const struct uvc_menu_info *menu;
 	unsigned int i;
 
@@ -1126,18 +1149,8 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
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
@@ -1660,25 +1673,37 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 	return 0;
 }
 
-static int uvc_ctrl_find_ctrl_idx(struct uvc_entity *entity,
-				  struct v4l2_ext_controls *ctrls,
-				  struct uvc_control *uvc_control)
+static int uvc_ctrl_commit_error(struct uvc_video_chain *chain,
+				 struct uvc_entity *entity,
+				 struct v4l2_ext_controls *ctrls,
+				 struct uvc_control *err_control,
+				 int ret)
 {
 	struct uvc_control_mapping *mapping;
 	struct uvc_control *ctrl_found;
 	unsigned int i;
 
-	if (!entity)
-		return ctrls->count;
+	if (!entity) {
+		ctrls->error_idx = ctrls->count;
+		return ret;
+	}
 
 	for (i = 0; i < ctrls->count; i++) {
 		__uvc_find_control(entity, ctrls->controls[i].id, &mapping,
 				   &ctrl_found, 0);
-		if (uvc_control == ctrl_found)
-			return i;
+		if (err_control == ctrl_found)
+			break;
 	}
+	ctrls->error_idx = i;
+
+	/* We could not find the control that failed. */
+	if (i == ctrls->count)
+		return ret;
+
+	if (uvc_ctrl_is_inactive(chain, err_control, mapping))
+		return -EACCES;
 
-	return ctrls->count;
+	return ret;
 }
 
 int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
@@ -1701,8 +1726,8 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 		uvc_ctrl_send_events(handle, ctrls->controls, ctrls->count);
 done:
 	if (ret < 0 && ctrls)
-		ctrls->error_idx = uvc_ctrl_find_ctrl_idx(entity, ctrls,
-							  err_ctrl);
+		ret = uvc_ctrl_commit_error(chain, entity, ctrls, err_ctrl,
+					    ret);
 	mutex_unlock(&chain->ctrl_mutex);
 	return ret;
 }
-- 
2.32.0.288.g62a8d224e6-goog

