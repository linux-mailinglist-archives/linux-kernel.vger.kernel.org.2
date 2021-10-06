Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE044249A9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 00:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239922AbhJFW2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 18:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239833AbhJFW2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 18:28:25 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA5BC061753
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 15:26:32 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id dj4so15408975edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 15:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=71b5+tSmONsNnxtpvXX730u62KW8gDT5QZHMAZ5UN7k=;
        b=PKi4nBVu51r0QLGdx2OUJeJF9EOzJFH5HkcHqEg4sX0sqoiJX6gZ0pffqoxJxWfrBM
         ToR4x6rA2huik5+nbVsAxqcUFPWUNpa/6LcEo8P0X7TDoi2XxLFivX+RTtQZbj7UvB37
         XQ4S/XjNQJnHbBzs6qbTUz/cHh8PTDbjAIRaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=71b5+tSmONsNnxtpvXX730u62KW8gDT5QZHMAZ5UN7k=;
        b=RW3cRgHyDwt/EqbnGDhtDDM5EZRyVkQDIJCiuJ+9RaeD0tkKxixChY3nQ6YYPN6Zlg
         Ji0aSbcRQlDB+mjwHVd5wZEP5a+RgqLt3699UVPy0zpbkVObg19dayqbpsqNSkNUNKbb
         EJOzJ5Qqb3edi2xNtuu3kjX+paOxFx2kp/R1YgaTrGiZhFDNbfMwvZV0juiFbL7TvMEB
         wm3JPJFbgcTlpIrRXu9h+8foQBgBQEdBi6lUfx5ty7Q4Tw65WXih8rSofllx/Vy+5NOh
         ebVCshG4EOZ6C+1dO9AkH9YwKntnltg7SYrgi8uvvhhHM/5EFESF6PK3Ed834YaTSUuu
         wAqA==
X-Gm-Message-State: AOAM531jNABLKY7Zu7A35wUb5a2fygWpZVOtvIiyszAH/PGh8O35/HqG
        EkWyWopIxO8OArp84QdwVkqyOA==
X-Google-Smtp-Source: ABdhPJyHWG93li3gu5d7cfdRVk8vCilDYryc2KrgC9Z1a1tmbeefbIAnGMyeogfmJF+GQLwO6Xg/vw==
X-Received: by 2002:a17:906:53c8:: with SMTP id p8mr1063064ejo.422.1633559191228;
        Wed, 06 Oct 2021 15:26:31 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id h7sm10557906edt.37.2021.10.06.15.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 15:26:31 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 7/8] media: ov13858: Add implementation for events
Date:   Thu,  7 Oct 2021 00:26:24 +0200
Message-Id: <20211006222625.401122-8-ribalda@chromium.org>
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
 drivers/media/i2c/ov13858.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov13858.c b/drivers/media/i2c/ov13858.c
index 7fc70af53e45..b4d22f5d9933 100644
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
2.33.0.800.g4c38ced690-goog

