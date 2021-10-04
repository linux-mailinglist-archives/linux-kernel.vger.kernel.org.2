Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD684214D5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 19:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbhJDRJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 13:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbhJDRJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 13:09:20 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E528EC061749
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 10:07:30 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so4421159pjw.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 10:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TXIY9Zx4nHd1YdoJ9mY5LE/CxY9S0C+Uj3Ep1a0mhNk=;
        b=QgbmjthINKVxOT9Iu0LfyL4+v9AuEVg8OGXfGhLJjRiPmnJJUlVMgwsTK8pdNL6auY
         gqjX05g1ziv/YZ9HTVXDVQpPjZd6BXM6Sr9Nskoq4vXPnZuXVJyAL5kb2Tw3GoGMt7UU
         FX8ldGzAwbi+bId752eDwrC3f8ibqYNiYqRz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TXIY9Zx4nHd1YdoJ9mY5LE/CxY9S0C+Uj3Ep1a0mhNk=;
        b=rKwYcu7IjkVLCf5KUuXGC1qnZc1EVZYxBoCtZhcu8NJRtVyXRHcYFQNIm8Vo05L0lY
         SRqniDNOHw9SAs6FjYANlZUI7Fcfgl3VCLvVPPIgTjGreRlUhhzMezuMJJ6HETZpzZlq
         cga0T190+/g/JOSQ/lfW+BJeEQBXnPaLRGAsXerymHwsVGyCuD9/CgIa9xRfEXvnZ0GK
         k5Yp6c9NM6X2D/1tinUKI4ag6AiVeC0lTrusmW4Y2BuL5wF8/jDlzrV86m8KXmATQnLg
         vZTdGhowTaU5Jr8eKVs66ZgqbTaDHsVUOarM0P6p75dHi9sfelLylChpP8gERofT6t4d
         l1jQ==
X-Gm-Message-State: AOAM533HfG+B/sSXych1PwBusqnf4uTr5Qj3hTjVwT+fLk5PLWDjd/AR
        ErOgMI3hs5jm6WoOWxYYZ2jDZ1mKNDXAhw==
X-Google-Smtp-Source: ABdhPJyxwS4plNhguhzLa5UfYgyOauD+eqVwfujKdj3SFnzzxr1NaWFjgAdNdih3yZXY1pnv2yJGag==
X-Received: by 2002:a17:90b:4b85:: with SMTP id lr5mr16109537pjb.66.1633367250225;
        Mon, 04 Oct 2021 10:07:30 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:6ec:eb98:83f9:f5b4])
        by smtp.gmail.com with ESMTPSA id x10sm14472027pfq.0.2021.10.04.10.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 10:07:29 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/2] platform/chrome: cros_ec_proto: Use EC struct for features
Date:   Mon,  4 Oct 2021 10:07:09 -0700
Message-Id: <20211004170716.86601-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Chrome EC's features are returned through an
ec_response_get_features struct, but they are stored in an independent
array. Although the two are effectively the same at present (2 unsigned
32 bit ints), there is the possibility that they could go out of sync.
Avoid this by only using the EC struct to store the features.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/mfd/cros_ec_dev.c                   |  4 ++--
 drivers/platform/chrome/cros_ec_proto.c     | 15 ++++++++-------
 include/linux/platform_data/cros_ec_proto.h |  2 +-
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 8c08d1c55726..6ee1f410eb53 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -146,8 +146,8 @@ static int ec_device_probe(struct platform_device *pdev)
 	ec->ec_dev = dev_get_drvdata(dev->parent);
 	ec->dev = dev;
 	ec->cmd_offset = ec_platform->cmd_offset;
-	ec->features[0] = -1U; /* Not cached yet */
-	ec->features[1] = -1U; /* Not cached yet */
+	ec->features.flags[0] = -1U; /* Not cached yet */
+	ec->features.flags[1] = -1U; /* Not cached yet */
 	device_initialize(&ec->class_dev);
 
 	for (i = 0; i < ARRAY_SIZE(cros_mcu_devices); i++) {
diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index a9f1867e5d8f..b908cdd680e3 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -812,36 +812,37 @@ EXPORT_SYMBOL(cros_ec_get_host_event);
  */
 bool cros_ec_check_features(struct cros_ec_dev *ec, int feature)
 {
+	struct ec_response_get_features *features = &ec->features;
 	struct cros_ec_command *msg;
 	int ret;
 
-	if (ec->features[0] == -1U && ec->features[1] == -1U) {
+	if (features->flags[0] == -1U && features->flags[1] == -1U) {
 		/* features bitmap not read yet */
-		msg = kzalloc(sizeof(*msg) + sizeof(ec->features), GFP_KERNEL);
+		msg = kzalloc(sizeof(*msg) + sizeof(*features), GFP_KERNEL);
 		if (!msg) {
 			dev_err(ec->dev, "failed to allocate memory to get EC features\n");
 			return false;
 		}
 
 		msg->command = EC_CMD_GET_FEATURES + ec->cmd_offset;
-		msg->insize = sizeof(ec->features);
+		msg->insize = sizeof(*features);
 
 		ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
 		if (ret < 0) {
 			dev_warn(ec->dev, "cannot get EC features: %d/%d\n",
 				 ret, msg->result);
-			memset(ec->features, 0, sizeof(ec->features));
+			memset(features, 0, sizeof(*features));
 		} else {
-			memcpy(ec->features, msg->data, sizeof(ec->features));
+			memcpy(features, msg->data, sizeof(*features));
 		}
 
 		dev_dbg(ec->dev, "EC features %08x %08x\n",
-			ec->features[0], ec->features[1]);
+			features->flags[0], features->flags[1]);
 
 		kfree(msg);
 	}
 
-	return !!(ec->features[feature / 32] & EC_FEATURE_MASK_0(feature));
+	return !!(features->flags[feature / 32] & EC_FEATURE_MASK_0(feature));
 }
 EXPORT_SYMBOL_GPL(cros_ec_check_features);
 
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 9d370816a419..df3c78c92ca2 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -205,7 +205,7 @@ struct cros_ec_dev {
 	struct cros_ec_debugfs *debug_info;
 	bool has_kb_wake_angle;
 	u16 cmd_offset;
-	u32 features[2];
+	struct ec_response_get_features features;
 };
 
 #define to_cros_ec_dev(dev)  container_of(dev, struct cros_ec_dev, class_dev)
-- 
2.33.0.800.g4c38ced690-goog

