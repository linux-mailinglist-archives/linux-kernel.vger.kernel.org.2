Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BBF41B909
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 23:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242910AbhI1VM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 17:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242867AbhI1VMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 17:12:19 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC45C061746
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:10:39 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t8so644609wrq.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=txrAIBvpCXZ1iuooBuJc6Z8viJhLKOLZBl7FhoSuzw0=;
        b=DOHFStVFq1T8mtaWbf08Y27w9p7/zHpW9l0ksVKx27RWWLmsHtRKN9s0sTDtSYlgEL
         MKoMv1xrCHXAFuATyXEScLZuUFzJpOVJb7RwbDSqQA4vhaJK3a+1Hv7990sdh15DvdE2
         dUepn2kVQX5C7kgGFgNIksB8bZUKUBF3S9/UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=txrAIBvpCXZ1iuooBuJc6Z8viJhLKOLZBl7FhoSuzw0=;
        b=RLo/Zrp30j5gpwJKU9jA3nFrM4IyvBIVHzY/yzia16cSyrF9sMz8i8Od2FwyrIdYCC
         9Gz/GIRpefCv1iVAQGOex0VgYo1155wRr6Vqn07S2fEaPU8UJ6Iz/mkpLELAFedSUoLn
         JJUYWkmMkeDxeTbSgZVIgJCr9gemtxJ2fg5/b0ZfClBWiYi1KwzUJTQAty8+jSsy2pn5
         alJA07KaHvyCp3YRwvPW2uaKiLSVlOG9tkXEeooCSlf3PhmsF++A8hrhkrP8har2qljo
         VEcoHpaZzVRCjS68Pwqo3Q2JTgkSGejmFdlQCT2HZU/fsome3EGJ/ju3CYhhly7uJJQv
         K2ng==
X-Gm-Message-State: AOAM5338GtnYuUyfAdlNZD9NyhELF6mRHqAN985i3L6CoGS6vjH8/JlX
        Gx8kqOKfe0gKBjIuPwXbQsNfcA==
X-Google-Smtp-Source: ABdhPJwJmyMLBt6im1bZIJQQ4MCTiMcCul9tpTCz4yKivfnMOcHUeBVT0bS2Bw0aH1ogicgDDAJvHQ==
X-Received: by 2002:a5d:69ce:: with SMTP id s14mr2729398wrw.236.1632863438195;
        Tue, 28 Sep 2021 14:10:38 -0700 (PDT)
Received: from beni.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id n68sm3885773wmn.13.2021.09.28.14.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 14:10:37 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 5/7] media: dw9714: Add implementation for events
Date:   Tue, 28 Sep 2021 21:10:31 +0000
Message-Id: <20210928211033.2415162-6-ribalda@chromium.org>
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
 drivers/media/i2c/dw9714.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/dw9714.c b/drivers/media/i2c/dw9714.c
index c8b4292512dca..3863dfeb82934 100644
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
2.33.0.685.g46640cef36-goog

