Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEB0340F38
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 21:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbhCRUa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 16:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbhCRU3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 16:29:41 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702CAC061760
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 13:29:41 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id j3so8258454edp.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 13:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aNL9aTZAWpHRm1Fir5uhPIEleZU2J7LM2Yy06YcsX6E=;
        b=K09uPFuuFlr0QWJJm+gwkDkK7/aRXvjfO3VKqlbeLmAXXXmZIaFbQBSk0IFHvw4QY8
         bOplWffz/y9IvSoSPbQMHAEHYMIHCw5MeEkO0KAcdulhFAk9c+lae1PslzN08CdOQ45+
         TnM+nNMqZYMl0W/a68RNs3u8BF2P3+L8vTPiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aNL9aTZAWpHRm1Fir5uhPIEleZU2J7LM2Yy06YcsX6E=;
        b=f/9bM7AThY5nXtrYBsv8Sq2klh1fcUswFdQZiuTG3RPYFQSlnVZQmKfsdQCg+Yx/+4
         3xIvfwTApYYnXhgfQ3VogHOwqvTs+6Qa5u95MS9+0mMVxSqtlLGGkQB3EA5+tI7lEV+z
         7DIz7TKNj7goq13tiKkVH42B3hR4QUzQgxUU5wQewTk6GVwSrLJctbaY4zZsO77kZJRv
         xFXVZCip9aYI7p7IAZ7/Lh+t4jl4tYjewxnG3GxyqPL5zApClvYaC7CNl04XJ5xlJ+qE
         C/e7rRxCb6YOjXSotL00UnUAC1ZsQuZElro4DZCEGasQxurZJ9lKnwRjdQw0ri4QZso+
         4FuQ==
X-Gm-Message-State: AOAM5307DUaB5sRn8mo4/+zwBXsVL0nZ8bbn5/v/7/G1PBPfokW4U9Cu
        /sk1FGOSTOzyQyuznHilSHLDaw==
X-Google-Smtp-Source: ABdhPJwNut/OOX2onLfC3A9PcJuUZ4aFar6Iyv4UukcmvaoBBKdQJ6cUsezJ43yvYuofAc4Wc4TpDA==
X-Received: by 2002:aa7:c1d5:: with SMTP id d21mr5730350edp.167.1616099380283;
        Thu, 18 Mar 2021 13:29:40 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id a22sm2533767ejr.89.2021.03.18.13.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 13:29:40 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v7 16/17] media: uvcvideo: Set error_idx during ctrl_commit errors
Date:   Thu, 18 Mar 2021 21:29:27 +0100
Message-Id: <20210318202928.166955-17-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210318202928.166955-1-ribalda@chromium.org>
References: <20210318202928.166955-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we have an error setting a control, return the affected control in
the error_idx field.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 37 ++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index fb8155ca0c0d..a5dc49e14aea 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1614,7 +1614,7 @@ int uvc_ctrl_begin(struct uvc_video_chain *chain)
 }
 
 static int uvc_ctrl_commit_entity(struct uvc_device *dev,
-	struct uvc_entity *entity, int rollback)
+	struct uvc_entity *entity, int rollback, struct uvc_control **err_ctrl)
 {
 	struct uvc_control *ctrl;
 	unsigned int i;
@@ -1656,23 +1656,49 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 
 		ctrl->dirty = 0;
 
-		if (ret < 0)
+		if (ret < 0) {
+			if (err_ctrl)
+				*err_ctrl = ctrl;
 			return ret;
+		}
 	}
 
 	return 0;
 }
 
+static int uvc_ctrl_find_ctrlidx(struct uvc_entity *entity,
+				 struct v4l2_ext_controls *ctrls,
+				 struct uvc_control *uvc_control)
+{
+	struct uvc_control_mapping *mapping;
+	struct uvc_control *ctrl_found;
+	unsigned int i;
+
+	if (!entity)
+		return ctrls->count;
+
+	for (i = 0; i < ctrls->count; i++) {
+		__uvc_find_control(entity, ctrls->controls[i].id, &mapping,
+				   &ctrl_found, 0);
+		if (uvc_control == ctrl_found)
+			return i;
+	}
+
+	return ctrls->count;
+}
+
 int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 		      struct v4l2_ext_controls *ctrls)
 {
 	struct uvc_video_chain *chain = handle->chain;
+	struct uvc_control *err_ctrl;
 	struct uvc_entity *entity;
 	int ret = 0;
 
 	/* Find the control. */
 	list_for_each_entry(entity, &chain->entities, chain) {
-		ret = uvc_ctrl_commit_entity(chain->dev, entity, rollback);
+		ret = uvc_ctrl_commit_entity(chain->dev, entity, rollback,
+					     &err_ctrl);
 		if (ret < 0)
 			goto done;
 	}
@@ -1680,6 +1706,9 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 	if (!rollback)
 		uvc_ctrl_send_events(handle, ctrls->controls, ctrls->count);
 done:
+	if (ret < 0 && ctrls)
+		ctrls->error_idx = uvc_ctrl_find_ctrlidx(entity, ctrls,
+							 err_ctrl);
 	mutex_unlock(&chain->ctrl_mutex);
 	return ret;
 }
@@ -2137,7 +2166,7 @@ int uvc_ctrl_restore_values(struct uvc_device *dev)
 			ctrl->dirty = 1;
 		}
 
-		ret = uvc_ctrl_commit_entity(dev, entity, 0);
+		ret = uvc_ctrl_commit_entity(dev, entity, 0, NULL);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.31.0.rc2.261.g7f71774620-goog

