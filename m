Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5839341EBD8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 13:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353900AbhJAL1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 07:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353831AbhJAL1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 07:27:13 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333FCC06177E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 04:25:29 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k7so14825121wrd.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 04:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tmEJ9vFpZDT8h8HObohmRstQUsecSrrPbxIcYXjIt14=;
        b=mlg6xJ+z/3D7g/FEIfOjSYDGmoYGEGbs98RXwl4s5paFKGPmigUvG/2nYEGgD9thTj
         I2tDZ1k2GTp9CLR1RqsUqrxzo/cqp8PeYQpAffEBC3gRdS6Lczgb4epuL/xwZ074SiEN
         OT3eTRdSrHMpGtSvUhsgQtm8TJwCPtipKqBgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tmEJ9vFpZDT8h8HObohmRstQUsecSrrPbxIcYXjIt14=;
        b=5CPKWTljRuK7y5pVR3UH2qI9o4iaBDnLxxV1zAAk7k+eVPnD3JJRLtVS/0CDrRi8Sw
         5lYdqYG7kAPdkCrB3OajpitvcSUrOpp1N2GcEA4BQoGXDYwPU31TwLRwjRdzP9tC8bbN
         0Uv/A5xcyFzMGgAwZJtiNj1158dl4TfEdrCKBhVaTvAqmAkuZuxMR582laeZLIvMjR/i
         6gcbb/hnL/tYodQ9hb7JZ6udzwiIni9mKXcdYHTqudQp2SzrwzCu4sFbJorTTYwWgZ4+
         bP6XJVfwm4LYbFKrxF4Hh7qdRH7H6nVw4/VoHT1j+2Wxv4q/lRbaJ76xaDihDpiOZwU+
         HjDg==
X-Gm-Message-State: AOAM5306VKDyJM3DH7Muk7GwyM1QrFCvbJTeyVeMlOGkuWOvVPAUnX3y
        xd43FHNKnI5VzphdzSZ5qi+G7Q==
X-Google-Smtp-Source: ABdhPJyVdC2NJRWi5/UJGa4RdI2Y7in5qLDFCkrNEpR3UXiq/NHEZJoZrxDysLDhtEHVdn019GeKAA==
X-Received: by 2002:a5d:6b03:: with SMTP id v3mr11779105wrw.226.1633087527757;
        Fri, 01 Oct 2021 04:25:27 -0700 (PDT)
Received: from beni.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id x17sm5530958wrc.51.2021.10.01.04.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 04:25:27 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 6/8] media: dw9714: Add implementation for events
Date:   Fri,  1 Oct 2021 11:25:20 +0000
Message-Id: <20211001112522.2839602-7-ribalda@chromium.org>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20211001112522.2839602-1-ribalda@chromium.org>
References: <20211001112522.2839602-1-ribalda@chromium.org>
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
2.33.0.800.g4c38ced690-goog

