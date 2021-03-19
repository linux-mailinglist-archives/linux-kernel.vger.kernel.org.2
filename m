Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F53342303
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 18:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhCSRKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 13:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhCSRJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:09:23 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEC1C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:09:22 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id k10so10892775ejg.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d2ao3XLmmt/D2986Jeu7tVcMUKwvKwTpzqsditCLfoQ=;
        b=QLyRRdN5eqUYoVXkXc6rjkGll8bcW3YLX0pAdu89oERxLmMOKJFCtwH5apNxHHFzzL
         UOEo2x+BrIzRTa3d7JEdSPBq9p2yX7VsFQWhlGTl7CS5Agodhj2DkI+f4dW0jP1QzRJ3
         lJap5si7EUdosRLSwIQeUVex8Mwy6yr6Bxxls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d2ao3XLmmt/D2986Jeu7tVcMUKwvKwTpzqsditCLfoQ=;
        b=XFiOE4XcuArPuV9cGfnY6jZldBrJx0qjI9JLy2lXRJ4EL4jFSTOxLBAnKmGnN6N4xB
         w8Bn3r9wuhemWLWWb74IiH+6Pjech4nD6K8/4oTjJWvTHiy0lj83T+04rGRqQo8nVZaW
         EEyMPyq1A2saGeX4wT2y9+yNFkYyQxAqI2XSZurOmldYKbwEsG9FOemZw2Zsj49VllMZ
         2OMNGgMwLEpwIxvhhCeFUzA1GMxjCc+lNAVGxf6xt3AlkKEgRFJa5srR3VHxSRuySlrg
         1QmBDgu/6rzQtNm0wEnAsiNf1OBJ5Wdp196ThUcn2QTXKylS9msaDmtK5H11iyHGOPY+
         TMxA==
X-Gm-Message-State: AOAM5331jnvrH1+w6SNCr96beEJdqR37mdwaN8NbkdU8CswsrEpgnpE/
        NtWYH53VHGLRLqUtFf3K1RMtbswG41R+Xr/Qfm8=
X-Google-Smtp-Source: ABdhPJyd0wngx7F7lMWAKTe68oU3y87xOHQw/jTMe4pbGxKkj6ecbjHGz6I+0tyRzz6iGqSHpoNnGA==
X-Received: by 2002:a17:906:1494:: with SMTP id x20mr5511578ejc.101.1616173761415;
        Fri, 19 Mar 2021 10:09:21 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id be27sm4506050edb.47.2021.03.19.10.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 10:09:20 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v8 16/19] media: uvcvideo: Return -EACCES to inactive controls
Date:   Fri, 19 Mar 2021 18:09:03 +0100
Message-Id: <20210319170906.278238-17-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210319170906.278238-1-ribalda@chromium.org>
References: <20210319170906.278238-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a control is inactive return -EACCES to let the userspace know that
the value will not be applied automatically when the control is active
again.

Suggested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 71 +++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 23 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index bcebf9d1a46f..d9d4add1e813 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1082,13 +1082,36 @@ static const char *uvc_map_get_name(const struct uvc_control_mapping *map)
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
 
@@ -1104,18 +1127,8 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
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
@@ -1638,25 +1651,37 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 	return 0;
 }
 
-static int uvc_ctrl_find_ctrlidx(struct uvc_entity *entity,
+static int uvc_ctrl_commit_error(struct uvc_video_chain *chain,
+				 struct uvc_entity *entity,
 				 struct v4l2_ext_controls *ctrls,
-				 struct uvc_control *uvc_control)
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
 
-	return ctrls->count;
+	if (uvc_ctrl_is_inactive(chain, err_control, mapping))
+		return -EACCES;
+
+	return ret;
 }
 
 int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
@@ -1679,8 +1704,8 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 		uvc_ctrl_send_events(handle, ctrls->controls, ctrls->count);
 done:
 	if (ret < 0 && ctrls)
-		ctrls->error_idx = uvc_ctrl_find_ctrlidx(entity, ctrls,
-							 err_ctrl);
+		ret = uvc_ctrl_commit_error(chain, entity, ctrls, err_ctrl,
+					    ret);
 	mutex_unlock(&chain->ctrl_mutex);
 	return ret;
 }
-- 
2.31.0.rc2.261.g7f71774620-goog

