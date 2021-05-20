Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1700F38AE0E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbhETMXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbhETMX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:23:27 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6B6C04345D
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 04:18:22 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id j12so11618557pgh.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 04:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BLVKuMIXJ2gND8RIlsuvY/P+yTOturpR4FTHR45Kpq8=;
        b=zHghMiT7fq6wZictdezKZnMAuKFEr+EmJbRT8fIpW3kJI/qa/JDyhcUBj74Gin01XD
         MkA42SLyoYv3xlE7YuH49FO4YJ5Lvl6Mt969Ig5LslCWyLcbILq4shhB26uMIgAkyXWo
         uEpcRc59rS+BRZOb7ZB1NMtG8hajwtOxDduN8qc1i9IOcVo5N/4pBZhoU4IDD9Z9XOg1
         lByQ/LmL+M5UyfltBbC+MdxHUlKe1eBi+yRBr8Lr9mw/k229oFBhLWEbXGIJac7LUJem
         TNmeUNehoBMulYUZUwu3O20ASCJ75/HTJgE8zAyThEJmCYHQyXdbE6pDO8+WOZgRgGea
         BKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BLVKuMIXJ2gND8RIlsuvY/P+yTOturpR4FTHR45Kpq8=;
        b=cLzdPl+H2u+6w+19+nk4Q6lFvJ07U4tzcTsWiHEhgMFy2Hrab7G6MOqwd3/YiXbFmI
         ci9e35V6BYFjb7kjC0z+W9prWmy+rnwTpze0zqb6pFA52vjPHx0j3O8F1APUoUq9W450
         dyvnMxDgBVkAgSCCzEpquNoVvWkTQ+ZopD/NDMXQ0vjwrnoU7ouoM3QajCV63nlVJiKG
         TFaCz4rv9VWj/96lcYITgZ3qlb/8VJO3DGPC6Sx6O7QkpM5Qz2r+R/IY50LHCpQ5AoP1
         WBAGBKyDs8mvs1+aqlQTyRmnMjRVzNQcYu2NmiNAOeEt15uFTVcQeU60/sqsieOkaY+E
         cUnA==
X-Gm-Message-State: AOAM531VDATCpoqcgwGMsY3kNCvQd7f5V2fjMxyBOc2u55pJzkJhZYVr
        mwxKqECtaJCUHvqMqppGMxzcWw==
X-Google-Smtp-Source: ABdhPJzFpofmKhNutLKtnCexYms7wGxcHiK2jBTLl3VVr3he2gU8QCA5alFj9egRTiv5JhitAO9zHw==
X-Received: by 2002:a63:5511:: with SMTP id j17mr4150590pgb.191.1621509501800;
        Thu, 20 May 2021 04:18:21 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id f2sm1824727pgl.67.2021.05.20.04.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 04:18:21 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: fixed: Ensure enable_counter is correct if reg_domain_disable fails
Date:   Thu, 20 May 2021 19:18:11 +0800
Message-Id: <20210520111811.1806293-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_pm_genpd_set_performance_state() may fail, so had better to check it's
return value before decreasing priv->enable_counter.

Fixes: bf3a28cf4241 ("regulator: fixed: support using power domain for enable/disable")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/fixed.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index 02ad83153e19..34e255c235d4 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -88,10 +88,15 @@ static int reg_domain_disable(struct regulator_dev *rdev)
 {
 	struct fixed_voltage_data *priv = rdev_get_drvdata(rdev);
 	struct device *dev = rdev->dev.parent;
+	int ret;
+
+	ret = dev_pm_genpd_set_performance_state(dev, 0);
+	if (ret)
+		return ret;
 
 	priv->enable_counter--;
 
-	return dev_pm_genpd_set_performance_state(dev, 0);
+	return 0;
 }
 
 static int reg_is_enabled(struct regulator_dev *rdev)
-- 
2.25.1

