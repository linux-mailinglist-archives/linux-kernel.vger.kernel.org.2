Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE72141B90A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 23:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242923AbhI1VM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 17:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242872AbhI1VMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 17:12:20 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA39C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:10:40 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d26so627127wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cpcqu0FkNTnMhJYqoU4g7szXMeK3djvSORY3n20CFi0=;
        b=HePQXKj1+2kXp82Ph9zNesBpPyBovgyVZJMe7rB1go/cq4Bp9NCDAYJPsNSYy0O8VQ
         P5lO+Zddns/7Qnqq4BnjAlQXbUW9MgFtrgiOef88uZPqqafLaCROIauPwnYC9ZosGRrH
         cWgYXoSJHhPF6u6EeLHj0DegyYhB863/Zx/F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cpcqu0FkNTnMhJYqoU4g7szXMeK3djvSORY3n20CFi0=;
        b=3VsDa5vfaKzh0pfRxGbCrqPPU5GvR4V2ahtlQzKQrmHzYylJY7g+ccrB3vWE9meMdD
         lSHZ/bwldPvDjhpS29DxV+xFXLFqFIT/jdBJGJTvgaCjMYMxbvrgJf5/LCr9OOGdqbRg
         bHZZxB11hZW5CXMhWGkMRemPGW7Vs006p5s/mGwHUvRCamWKpZCqqUH6nyCppydrKQ8K
         6zu4+LlJdCUX3C5G4l2a89vOhUiE3ci+8Qqj4nvmi20vHlzzRZLY3hShcwU/YR0GSP3U
         N+IMCBgrcWIWgRiHyUJbWF7Jiqho8ipMhUbHpSRvn4i1zuP3JsbHt4eEkUEb690jNwy7
         kgBw==
X-Gm-Message-State: AOAM532rFSvpqXy2IMekKNF4tK5sQ0eH+FsXEy+vlUZQQkcL3NHjO66j
        LSh/7gYRXqneyX3y4y/Qay2HaA==
X-Google-Smtp-Source: ABdhPJyXOGhKoQaZpY5XHcybETMLriDRNljwHciQ1EPMr2BtUHML5ZmEYAQfyk6cdAAdAfFRt+1jSQ==
X-Received: by 2002:a05:6000:1569:: with SMTP id 9mr2624681wrz.337.1632863438884;
        Tue, 28 Sep 2021 14:10:38 -0700 (PDT)
Received: from beni.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id n68sm3885773wmn.13.2021.09.28.14.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 14:10:38 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 6/7] media: ov13858: Add implementation for events
Date:   Tue, 28 Sep 2021 21:10:32 +0000
Message-Id: <20210928211033.2415162-7-ribalda@chromium.org>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210928211033.2415162-1-ribalda@chromium.org>
References: <20210928211033.2415162-1-ribalda@chromium.org>
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
 drivers/media/i2c/ov13858.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov13858.c b/drivers/media/i2c/ov13858.c
index 7fc70af53e45d..b4d22f5d99337 100644
--- a/drivers/media/i2c/ov13858.c
+++ b/drivers/media/i2c/ov13858.c
@@ -7,6 +7,7 @@
 #include <linux/pm_runtime.h>
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
+#include <media/v4l2-event.h>
 #include <media/v4l2-fwnode.h>
 
 #define OV13858_REG_VALUE_08BIT		1
@@ -1553,6 +1554,12 @@ static int ov13858_identify_module(struct ov13858 *ov13858)
 	return 0;
 }
 
+static const struct v4l2_subdev_core_ops ov13858_core_ops = {
+	.log_status = v4l2_ctrl_subdev_log_status,
+	.subscribe_event = v4l2_ctrl_subdev_subscribe_event,
+	.unsubscribe_event = v4l2_event_subdev_unsubscribe,
+};
+
 static const struct v4l2_subdev_video_ops ov13858_video_ops = {
 	.s_stream = ov13858_set_stream,
 };
@@ -1569,6 +1576,7 @@ static const struct v4l2_subdev_sensor_ops ov13858_sensor_ops = {
 };
 
 static const struct v4l2_subdev_ops ov13858_subdev_ops = {
+	.core = &ov13858_core_ops,
 	.video = &ov13858_video_ops,
 	.pad = &ov13858_pad_ops,
 	.sensor = &ov13858_sensor_ops,
@@ -1724,7 +1732,8 @@ static int ov13858_probe(struct i2c_client *client,
 
 	/* Initialize subdev */
 	ov13858->sd.internal_ops = &ov13858_internal_ops;
-	ov13858->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	ov13858->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE |
+			     V4L2_SUBDEV_FL_HAS_EVENTS;
 	ov13858->sd.entity.ops = &ov13858_subdev_entity_ops;
 	ov13858->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
 
-- 
2.33.0.685.g46640cef36-goog

