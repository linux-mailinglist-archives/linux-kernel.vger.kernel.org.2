Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113EC3DDF8B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 20:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhHBSrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 14:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhHBSrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 14:47:46 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CEBC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 11:47:36 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id u2so12428727plg.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 11:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BUv3od7LS/Jy/0Xao4I5aiQeJrHCxJSTSuZdIJzFNVU=;
        b=TUoqeOOtqaz7AdnsneR/odnvQgaY886xUNv/C7fBPpMBl74sz9GfFkbAOZw2z/gfu/
         wP7tQs++9wEBwjHpQ2fHIA6Ie+bvncprgSfGwh5b/HQWnMG3xiiBOK9DrgjIdmDHwTf+
         hOx4q1l19uVvnnv2IR+sBN3vHaWfYeGk6d5gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BUv3od7LS/Jy/0Xao4I5aiQeJrHCxJSTSuZdIJzFNVU=;
        b=cq7XFF6EpDA7f8lpLLpBt6BAAtPdkozuUJMNe+rKFwPJuEg9T3DbcxQFQ767brcK5D
         WJYwBpJ1NT7E9AL7iCSCG8+8Zgc3MxJb/QB8XPAg6EX+mC2zU+Rd/iOfXqBHQaZ8MS3b
         rZCEJHau3erAG1qSrU9GKDEZ4tsQ4X3rt1XVvA6skoZqXoinjGWydedwFdW4IRst3xJV
         dtvhUHmX3K962c77aHUFhRwravl4bk0KmiuBC0aeHbSyTAMGz0cWQG6o4GYwQOLvQux6
         cXJO3He60CZmhsfzl2Qx8kwv06JVXjm+uiNKQ+VqNRE3jcJnnIfU3FQt1olqpOdedntN
         92Ew==
X-Gm-Message-State: AOAM532IWnUlpOcplwWxZwvPar/ukgKDGMf73EZJiLfhILS0R7Y5nowg
        lRIDRzzQaE3jStBOn3n51YxVUIPLVTR/Rg==
X-Google-Smtp-Source: ABdhPJz/SSs+t6+8HbYU6xgUG6aF5zbVEM9qiBkoDTXtb9La8+BUeirFKBe1Va4OSYg6jGWJULL4Sg==
X-Received: by 2002:a17:90a:fef:: with SMTP id 102mr281942pjz.148.1627930056029;
        Mon, 02 Aug 2021 11:47:36 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:8875:fb28:686e:1c31])
        by smtp.gmail.com with ESMTPSA id l11sm13356483pfd.187.2021.08.02.11.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 11:47:35 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 2/2] platform/chrome: cros_ec_typec: Use existing feature check
Date:   Mon,  2 Aug 2021 11:47:12 -0700
Message-Id: <20210802184711.3872372-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
In-Reply-To: <20210802184711.3872372-1-pmalani@chromium.org>
References: <20210802184711.3872372-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the cros_typec_feature_supported() function with the
pre-existing cros_ec_check_features() function which does the same
thing.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 33 +++++++++----------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 27c068c4c38d..f96af8aa31b5 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -1054,24 +1054,6 @@ static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
 	return 0;
 }
 
-/* Check the EC feature flags to see if TYPEC_* features are supported. */
-static int cros_typec_feature_supported(struct cros_typec_data *typec, enum ec_feature_code feature)
-{
-	struct ec_response_get_features resp = {};
-	int ret;
-
-	ret = cros_typec_ec_command(typec, 0, EC_CMD_GET_FEATURES, NULL, 0,
-				    &resp, sizeof(resp));
-	if (ret < 0) {
-		dev_warn(typec->dev,
-			 "Failed to get features, assuming typec feature=%d unsupported.\n",
-			 feature);
-		return 0;
-	}
-
-	return resp.flags[feature / 32] & EC_FEATURE_MASK_1(feature);
-}
-
 static void cros_typec_port_work(struct work_struct *work)
 {
 	struct cros_typec_data *typec = container_of(work, struct cros_typec_data, port_work);
@@ -1113,6 +1095,7 @@ MODULE_DEVICE_TABLE(of, cros_typec_of_match);
 
 static int cros_typec_probe(struct platform_device *pdev)
 {
+	struct cros_ec_dev *ec_dev = NULL;
 	struct device *dev = &pdev->dev;
 	struct cros_typec_data *typec;
 	struct ec_response_usb_pd_ports resp;
@@ -1132,10 +1115,16 @@ static int cros_typec_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	typec->typec_cmd_supported = !!cros_typec_feature_supported(typec,
-					EC_FEATURE_TYPEC_CMD);
-	typec->needs_mux_ack = !!cros_typec_feature_supported(typec,
-					EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK);
+	if (typec->ec->ec)
+		ec_dev = dev_get_drvdata(&typec->ec->ec->dev);
+
+	if (ec_dev) {
+		typec->typec_cmd_supported = !!cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_CMD);
+		typec->needs_mux_ack = !!cros_ec_check_features(ec_dev,
+							EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK);
+	} else {
+		dev_warn(dev, "Invalid cros_ec_dev pointer; feature flags not checked.\n");
+	}
 
 	ret = cros_typec_ec_command(typec, 0, EC_CMD_USB_PD_PORTS, NULL, 0,
 				    &resp, sizeof(resp));
-- 
2.32.0.554.ge1b32706d8-goog

