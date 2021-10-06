Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00DC4249A7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 00:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239868AbhJFW2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 18:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239828AbhJFW2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 18:28:24 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20277C061766
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 15:26:32 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id l7so15644638edq.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 15:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+GAqRrRgfCmg5VJFrf6IVD13H9dq3bTFFa5kv2zrRe4=;
        b=bvlPI2gRvkjvwcwkL4bBmOrmjqdd8qAo3ovF5i67qPbB47pt3ICCDKk8dOdIen30t3
         ly+9PndPZiU8pn0oKdJ6t1CoudZISEW6+90v2U3FtwInDWpl1nCX67H4WlFUC1kx26CC
         BMxJPuy4Gh2K+W2TdE6I8jSIPF4DYtDj/8lPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+GAqRrRgfCmg5VJFrf6IVD13H9dq3bTFFa5kv2zrRe4=;
        b=njVIUmWDKdo7ZbtbZwZsl1yIERLi0tw8Ud0NbDkUlZu0nkB9CS7R8xv58SGzl4j33w
         ByGNjXM+SSn2+F6o6t5gBYA+zalxA5br5oPGlBu2xmDiMvqoR9/l9C3JpWVaruALhXD0
         WjIToNiuOCLykQ5TZTx8y5PGyF8T+iFMY0Yh2mlCsnL7M/s6To9aoCRjMTsGlq0APx5p
         UwSJKoJ4q71Xk1/HZspFVhkY81fMgHElchRQ8kik/5TEEJQfKxvYFVUn2BfO0X2eCr9D
         COOG/TsvwnXkUI7L1hb9ES8BZK4xnHaqBzSPEyZnAJ0jAan1W9zmIuv6fBq7OgOGTLTm
         bB+g==
X-Gm-Message-State: AOAM533gk+Uv+lqWkh8cYMEKRQRWTSrI6zfPHb3DAqDQCTP3X0SJWuIa
        YVZZn3Ivuu8uk24Rprry4ukgeA==
X-Google-Smtp-Source: ABdhPJwMiZ7ZORFcNXWynQ/N6RV2MAifgotN06ZLaRdR0mY0QicbiqvkvSYOghbnWTMMI1+J+pgCBw==
X-Received: by 2002:a17:906:ecf6:: with SMTP id qt22mr1083272ejb.292.1633559190777;
        Wed, 06 Oct 2021 15:26:30 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id h7sm10557906edt.37.2021.10.06.15.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 15:26:30 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 6/8] media: dw9714: Add implementation for events
Date:   Thu,  7 Oct 2021 00:26:23 +0200
Message-Id: <20211006222625.401122-7-ribalda@chromium.org>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20211006222625.401122-1-ribalda@chromium.org>
References: <20211006222625.401122-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use v4l2 control API helpers to support the events.

Fixes v4l2-compliance:

test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: FAIL

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/dw9714.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/dw9714.c b/drivers/media/i2c/dw9714.c
index c8b4292512dc..3863dfeb8293 100644
--- a/drivers/media/i2c/dw9714.c
+++ b/drivers/media/i2c/dw9714.c
@@ -7,6 +7,7 @@
 #include <linux/pm_runtime.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
+#include <media/v4l2-event.h>
 
 #define DW9714_NAME		"dw9714"
 #define DW9714_MAX_FOCUS_POS	1023
@@ -100,7 +101,15 @@ static const struct v4l2_subdev_internal_ops dw9714_int_ops = {
 	.close = dw9714_close,
 };
 
-static const struct v4l2_subdev_ops dw9714_ops = { };
+static const struct v4l2_subdev_core_ops dw9714_core_ops = {
+	.log_status = v4l2_ctrl_subdev_log_status,
+	.subscribe_event = v4l2_ctrl_subdev_subscribe_event,
+	.unsubscribe_event = v4l2_event_subdev_unsubscribe,
+};
+
+static const struct v4l2_subdev_ops dw9714_ops = {
+	.core = &dw9714_core_ops,
+};
 
 static void dw9714_subdev_cleanup(struct dw9714_device *dw9714_dev)
 {
@@ -137,7 +146,8 @@ static int dw9714_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	v4l2_i2c_subdev_init(&dw9714_dev->sd, client, &dw9714_ops);
-	dw9714_dev->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	dw9714_dev->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE |
+				V4L2_SUBDEV_FL_HAS_EVENTS;
 	dw9714_dev->sd.internal_ops = &dw9714_int_ops;
 
 	rval = dw9714_init_controls(dw9714_dev);
-- 
2.33.0.800.g4c38ced690-goog

