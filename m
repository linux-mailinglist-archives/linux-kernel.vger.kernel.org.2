Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F33394EF6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 04:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhE3CHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 22:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhE3CHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 22:07:32 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B999C061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 19:05:55 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id gb21-20020a17090b0615b029015d1a863a91so6672389pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 19:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VvRIbkdKKRfyv8TyaR9XYNxUzVFAknm9OcCKNPz2J5c=;
        b=dLLw97tJT6+rXtnYh3c8fcxtqGU1v2OfLLIOGkyDava8z/NoXS1im6Sga6XR8PLkkc
         Wr13RfJkxGwxFukD/a59KPvU3hP/ohJ7Cqnoe6BvXCGmNIo/NDzX/IhROlpriMBhmHMs
         C35HNPC22uptCTV3wpCplqY4zu8W4aKfVVogxejMaTVbm/2hpyiuXfdR/zpVnFFe3LQa
         biU+c9xtI3gL1VV8E2z1RriR62ft/MQQaiaNX4tpn8S8DFkf3BvvBktiT92Zqdo9Dvru
         vVsKGKAjlbHVBLBnDHmvCHvyuuYqhwu4n3E0tg6lGhQGZVnw2rNLvy25QVNVLBXBoPla
         fOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VvRIbkdKKRfyv8TyaR9XYNxUzVFAknm9OcCKNPz2J5c=;
        b=CXzWa2XDwScVlLU0tfx8+65sqH1sgLKAXLmW6VX8tKZ++FIvjqfWU/ZCnJMOmxcEej
         zNvPsAST6T97zO0oQQRR9EaWZ41xYC4wMyQLen8xQO1YWm0WFX6hBwEEAOHGpb16XADL
         P6HU5zYIcTlaiatnGQW9Gfiy9DiORvoQXCMaNFjhA4/moy/zxkLxAfqZy5hlVekcXINB
         EEzyppKB8Kt9ifww1iTO5BK7lbQkO2sLAjuVar2tLo5w4xdv1dgiY9RbMS2xoThDuqnB
         vuiW4UpCq8Ofd2cqQcvRSAZ90dy4lxL8WhZMfuh5e+oxyPmhBzL3MRjsCSIlMbAwcG2N
         wzZQ==
X-Gm-Message-State: AOAM533O/SgZWkhQxZKncxV6/b6rEHm01EBla4vt2yeyMJuorongL60t
        yAuBskWtIZtxai/Hjl5DvexT2mdDXrBrKZwy
X-Google-Smtp-Source: ABdhPJykxmWWIXb37wwJxjHNO6d1OIlqx0nmHlmfPiO2gbofNAZF6X5JK1QBvSDm1JaaUyDAh+RX1A==
X-Received: by 2002:a17:902:da8f:b029:f4:11e0:48f with SMTP id j15-20020a170902da8fb02900f411e0048fmr14412345plx.56.1622340353898;
        Sat, 29 May 2021 19:05:53 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id 18sm43126pfx.71.2021.05.29.19.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 19:05:53 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: mt6315: Don't ignore devm_regulator_register failure
Date:   Sun, 30 May 2021 10:05:43 +0800
Message-Id: <20210530020543.418634-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also use dev_err instead of dev_notice for messages in error conditions.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mt6315-regulator.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/mt6315-regulator.c b/drivers/regulator/mt6315-regulator.c
index 9edc34981ee0..8c5d72869c2b 100644
--- a/drivers/regulator/mt6315-regulator.c
+++ b/drivers/regulator/mt6315-regulator.c
@@ -84,7 +84,7 @@ static unsigned int mt6315_regulator_get_mode(struct regulator_dev *rdev)
 	modeset_mask = init->modeset_mask[rdev_get_id(rdev)];
 	ret = regmap_read(rdev->regmap, MT6315_BUCK_TOP_4PHASE_ANA_CON42, &regval);
 	if (ret != 0) {
-		dev_notice(&rdev->dev, "Failed to get mode: %d\n", ret);
+		dev_err(&rdev->dev, "Failed to get mode: %d\n", ret);
 		return ret;
 	}
 
@@ -93,7 +93,7 @@ static unsigned int mt6315_regulator_get_mode(struct regulator_dev *rdev)
 
 	ret = regmap_read(rdev->regmap, MT6315_BUCK_TOP_CON1, &regval);
 	if (ret != 0) {
-		dev_notice(&rdev->dev, "Failed to get lp mode: %d\n", ret);
+		dev_err(&rdev->dev, "Failed to get lp mode: %d\n", ret);
 		return ret;
 	}
 
@@ -147,12 +147,12 @@ static int mt6315_regulator_set_mode(struct regulator_dev *rdev,
 		break;
 	default:
 		ret = -EINVAL;
-		dev_notice(&rdev->dev, "Unsupported mode: %d\n", mode);
+		dev_err(&rdev->dev, "Unsupported mode: %d\n", mode);
 		break;
 	}
 
 	if (ret != 0) {
-		dev_notice(&rdev->dev, "Failed to set mode: %d\n", ret);
+		dev_err(&rdev->dev, "Failed to set mode: %d\n", ret);
 		return ret;
 	}
 
@@ -168,7 +168,7 @@ static int mt6315_get_status(struct regulator_dev *rdev)
 	info = container_of(rdev->desc, struct mt6315_regulator_info, desc);
 	ret = regmap_read(rdev->regmap, info->status_reg, &regval);
 	if (ret < 0) {
-		dev_notice(&rdev->dev, "Failed to get enable reg: %d\n", ret);
+		dev_err(&rdev->dev, "Failed to get enable reg: %d\n", ret);
 		return ret;
 	}
 
@@ -260,8 +260,9 @@ static int mt6315_regulator_probe(struct spmi_device *pdev)
 		config.driver_data = init_data;
 		rdev = devm_regulator_register(dev, &mt6315_regulators[i].desc, &config);
 		if (IS_ERR(rdev)) {
-			dev_notice(dev, "Failed to register %s\n", mt6315_regulators[i].desc.name);
-			continue;
+			dev_err(dev, "Failed to register %s\n",
+				mt6315_regulators[i].desc.name);
+			return PTR_ERR(rdev);
 		}
 	}
 
@@ -279,7 +280,7 @@ static void mt6315_regulator_shutdown(struct spmi_device *pdev)
 	ret |= regmap_write(chip->regmap, MT6315_TOP_TMA_KEY, 0);
 	ret |= regmap_write(chip->regmap, MT6315_TOP_TMA_KEY_H, 0);
 	if (ret < 0)
-		dev_notice(&pdev->dev, "[%#x] Failed to enable power off sequence. %d\n",
+		dev_err(&pdev->dev, "[%#x] Failed to enable power off sequence. %d\n",
 			   pdev->usid, ret);
 }
 
-- 
2.25.1

