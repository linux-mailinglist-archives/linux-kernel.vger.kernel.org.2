Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B5340D160
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 03:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbhIPBsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 21:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbhIPBsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 21:48:18 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DB2C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 18:46:59 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n2so203697plk.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 18:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B5bHui6kRHhxVzD9UTLyVFqHuGAj8kifzoni+rjsgcA=;
        b=Bb8RuoUIcGF+PmzvKzsWqah2eoHj2JCFr5u8jqUQb62Q/8q5jwAijFuItshKfTtp3z
         sJXBpLg7Zer4K5SJ0egvH6gKEZndhJt+E+2UV4r/2z2piJWqo8aS5PH/rbqSv+Cq/Q/v
         +T1rm0Ah1IsN4uwjRuKo48p1PLqgjPrHfj4zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B5bHui6kRHhxVzD9UTLyVFqHuGAj8kifzoni+rjsgcA=;
        b=oJx2Nj89E2vZ0m7R9keNahHzkV3kOUyuINEoVRw1nC3z5qCDYqFoTzGSNPIQOXjrCa
         HW/4EpMa+wpkQUuQGvN/9Gg6Hyp8F7d7slcfNvEQsYC8+8LQZjeNSRStuAMQlZYD6BJK
         gPJI3EyG0J2HLcpVVt9NQ8i0Npv+m6FRcmyuZjeSWgg4NLkyConarB6E236LTcNZD7JP
         rmfIxdtfAXARL8P6VATXWW5XPg2WLNzxSI6Q2nqjWVl2deJ42mWRIFgauzU5yM59+tzg
         41p4jQ30TPXxzcocc+nMrWFxByVqRIX82o04uS9N88cnkXxr7b3pAT0iz1Xu9Kvl2wIh
         T5Hg==
X-Gm-Message-State: AOAM532OkUQuON9UtbGpVIO/AyXDiw5uP2roGfCmVdFDDuHjmO3mXSMx
        MxyiM3g45H+l7PTahu1kaa19i680iAGBBg==
X-Google-Smtp-Source: ABdhPJyTqq/sLzhH8+TUbLZyHOYCOstANkB68AIE9vuBjIi2m0iqHAKXRnOg+4wTnTg210bstLE2JQ==
X-Received: by 2002:a17:90b:384a:: with SMTP id nl10mr11814258pjb.65.1631756818310;
        Wed, 15 Sep 2021 18:46:58 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:6b70:cd1e:def4:efaa])
        by smtp.gmail.com with ESMTPSA id x16sm1091766pgc.49.2021.09.15.18.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 18:46:57 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH] platform/chrome: cros_ec_proto: Fix check_features ret val
Date:   Wed, 15 Sep 2021 18:46:27 -0700
Message-Id: <20210916014632.2662612-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kerneldoc for cros_ec_check_features() states that it returns 1 or 0
depedending on whether a feature is supported or not, but it instead
returns a negative error number in one case, and a non-1 bitmask in
other cases.

Since all call-sites only check for a 1 or 0 return value, update
the function to return boolean values.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_proto.c     | 12 +++++++-----
 include/linux/platform_data/cros_ec_proto.h |  2 +-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index a7404d69b2d3..a34cf58c5ef7 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -808,9 +808,9 @@ EXPORT_SYMBOL(cros_ec_get_host_event);
  *
  * Call this function to test whether the ChromeOS EC supports a feature.
  *
- * Return: 1 if supported, 0 if not
+ * Return: true if supported, false if not (or if an error was encountered).
  */
-int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
+bool cros_ec_check_features(struct cros_ec_dev *ec, int feature)
 {
 	struct cros_ec_command *msg;
 	int ret;
@@ -818,8 +818,10 @@ int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
 	if (ec->features[0] == -1U && ec->features[1] == -1U) {
 		/* features bitmap not read yet */
 		msg = kzalloc(sizeof(*msg) + sizeof(ec->features), GFP_KERNEL);
-		if (!msg)
-			return -ENOMEM;
+		if (!msg) {
+			dev_err(ec->dev, "failed to allocate memory to get EC features\n");
+			return false;
+		}
 
 		msg->command = EC_CMD_GET_FEATURES + ec->cmd_offset;
 		msg->insize = sizeof(ec->features);
@@ -839,7 +841,7 @@ int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
 		kfree(msg);
 	}
 
-	return ec->features[feature / 32] & EC_FEATURE_MASK_0(feature);
+	return !!(ec->features[feature / 32] & EC_FEATURE_MASK_0(feature));
 }
 EXPORT_SYMBOL_GPL(cros_ec_check_features);
 
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 02599687770c..55844ece0b32 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -227,7 +227,7 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev,
 
 u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
 
-int cros_ec_check_features(struct cros_ec_dev *ec, int feature);
+bool cros_ec_check_features(struct cros_ec_dev *ec, int feature);
 
 int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
 
-- 
2.33.0.309.g3052b89438-goog

