Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B043DF3FF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 19:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238310AbhHCRhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 13:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238204AbhHCRhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 13:37:05 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFF7C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 10:36:54 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id q2so24579108plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 10:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kVHFkbYxov8P54Gvz7uidbv1qRggx9Wu8jBqilyaQew=;
        b=gLHsqVrry/WfOnFBPp7woMWg9Y+G4sSHtKMhAfeO17rEYG/GbjE08YXyhbNqqWCTdu
         AVA1F++imAM9WBrMmulU7wIRwMiGhviaW6aJtCo6zqPoOxAzr6ukIC8gcIu+v9roFXK8
         SwhBmf2eATOpwGClE5CkXASGlEyEsVTAUvg9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kVHFkbYxov8P54Gvz7uidbv1qRggx9Wu8jBqilyaQew=;
        b=Kt9pL9Uy/e7VfJCQTGBAegy+vIwPdaBm3aPU6AdNE1+XwqFuICBgE4w7VX/odTuqGN
         G4NCJMofu264Fojg52Vy3sJyyALWUouQKTW2Ac8tZMqND2PRrRlyBEussJn/lRph38O8
         HKXkIJ9AeiNQD+s+VoWv67xdb8jLgrK/0w9svT4B4okucgdL9ttlByQThoGV6HU/RjRv
         H1524hkX58DG2mIhEBplBwm1R+MRVBAwcMf811lVLLGsLcCXBaXdJ/FKt1IsWNb7OehX
         BQ+P6DnUtbfZn0SGrt/5y4pFJpSiPZ2RiouketmfwrznRglclSAfWmrfEkXm92TgCVd3
         3IlQ==
X-Gm-Message-State: AOAM530S8bvrrSO8F37pKp8+Kuf4aUywTkHfxXhfB8KIXBBmVtVPXLPH
        Hz71Bv+xJ/eHHKGmwWetkAEk/oiX3mz/Ew==
X-Google-Smtp-Source: ABdhPJzjcvb04ZJoN0in9XsWkxRu0pDzHz+htd/iyOod1O8dMKh/v3ycnaqdMGV+Eso4862bNpnF7w==
X-Received: by 2002:a62:dd42:0:b029:330:6bf8:b02c with SMTP id w63-20020a62dd420000b02903306bf8b02cmr22992582pff.67.1628012213807;
        Tue, 03 Aug 2021 10:36:53 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:8875:fb28:686e:1c31])
        by smtp.gmail.com with ESMTPSA id g202sm2026748pfb.125.2021.08.03.10.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 10:36:53 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Use existing feature check
Date:   Tue,  3 Aug 2021 10:36:21 -0700
Message-Id: <20210803173619.91539-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
In-Reply-To: <20210803173619.91539-1-pmalani@chromium.org>
References: <20210803173619.91539-1-pmalani@chromium.org>
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
Changes in v2:
- Dropped unnecessary NULL checks, per review comments.

 drivers/platform/chrome/cros_ec_typec.c | 27 +++++--------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 27c068c4c38d..262a891eded3 100644
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
@@ -1132,10 +1115,10 @@ static int cros_typec_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	typec->typec_cmd_supported = !!cros_typec_feature_supported(typec,
-					EC_FEATURE_TYPEC_CMD);
-	typec->needs_mux_ack = !!cros_typec_feature_supported(typec,
-					EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK);
+	ec_dev = dev_get_drvdata(&typec->ec->ec->dev);
+	typec->typec_cmd_supported = !!cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_CMD);
+	typec->needs_mux_ack = !!cros_ec_check_features(ec_dev,
+							EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK);
 
 	ret = cros_typec_ec_command(typec, 0, EC_CMD_USB_PD_PORTS, NULL, 0,
 				    &resp, sizeof(resp));
-- 
2.32.0.554.ge1b32706d8-goog

