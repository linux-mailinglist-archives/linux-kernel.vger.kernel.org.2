Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E253B433A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 14:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhFYMcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 08:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhFYMce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 08:32:34 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49D7C061767
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 05:30:13 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c7so13150794edn.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 05:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FxxfENGrIFXRma0NvkVm5/BU+63/LeldJyuBInY+fuk=;
        b=WceRuFB5RWCKYavAIfb8iC8WDX612leSU7MckzCcDSRgwJTlxBfQkOxBXGVbiAwQWg
         yZPBdEC0O4CxwDc4AaJjvYivh++10FTgVUYnAFonBbG3E8pocA5mQBWzm4lB+hBrlBrG
         YGqWDtubsqgPKbzbibsUpuASlxzs0XJIXyNqT1d6Zi7mUbftyZ3kDkTcCc4LSU5pnBpG
         fcnAf0GHiXETfpPwVKeto0eCqvJWAk0TAqOe08KY3p7qam2mLh36SwW6eIeox7y4JnXk
         iFAS4Qdm7wlR6lq20HsHeNSWXLOB0ZNbmTyi4fl5PCCZuBpNABoswRBtI2YsWQIJk80L
         yfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FxxfENGrIFXRma0NvkVm5/BU+63/LeldJyuBInY+fuk=;
        b=LmP+NSLP0noxLKH5gYsS9zV3Ed5bc3XQERmdlXOC8HfIackg5V+JMSM8f8fl+Qjsdn
         9A5reoleVMgjEpS1/kvgkgBovsczs3TVqvIG+meVi/Fajc6Gdfx0uFqrCQaVAqbqoveL
         SWJxMTld3SM7owKpMmwxNXTe+jjaswZmD2bcQEIQeCRwMMmpzgMoXuwrUhgFoCdXWhZw
         yAQozZV26XBZam1t9mM6GIhmI9+rVbI5G3lWxy+7uD1uN4M7i7WUpcFFMEjuC5rl+/c4
         48y0M95j+8yFjFquTgiYyNSl58a//ZvvNbu0yWuNhTojn0QtfjPzKDOOfI/olM8ZcNXZ
         U+bw==
X-Gm-Message-State: AOAM531XdPtVTCNH9ATb/2pD59DdbPQiod8tJU7E321HYkLiYg+YSizG
        v5Q7MQ0DcGYRZLAaqAzpi/NiJzIEVuuU8/VmqHA=
X-Google-Smtp-Source: ABdhPJytN39IQj4wy/NtLjViCVEsEZWMVYcaWb9yJp0Uyx5vpEpVMXPkzFE0EbuchwCdTPZUQP7Fog==
X-Received: by 2002:a05:6402:1a:: with SMTP id d26mr14368798edu.105.1624624212166;
        Fri, 25 Jun 2021 05:30:12 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id c15sm3884351edu.19.2021.06.25.05.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 05:30:11 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-kernel@vger.kernel.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 2/4] regulator: devres: remove devm_regulator_unregister() function
Date:   Fri, 25 Jun 2021 15:23:22 +0300
Message-Id: <20210625122324.327585-3-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625122324.327585-1-aardelean@deviqon.com>
References: <20210625122324.327585-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This API hook isn't used anywhere and most-likely exists because of the
general principle of C APIs, where if an API function does an
allocation/registration, it must also have an equivalent
deallocation/deregistration counterpart.

For devm_ functions this isn't all that true (for all cases), as the idea
of these function is to provide an auto-cleanup logic on drivers/system
de-init.

Removing this also discourages any weird logic that could be created with
such an API function.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/regulator/devres.c       | 29 -----------------------------
 include/linux/regulator/driver.h |  1 -
 2 files changed, 30 deletions(-)

diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index 8895f0f5ad1d..bf0d19a7fb69 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -205,35 +205,6 @@ struct regulator_dev *devm_regulator_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_regulator_register);
 
-static int devm_rdev_match(struct device *dev, void *res, void *data)
-{
-	struct regulator_dev **r = res;
-	if (!r || !*r) {
-		WARN_ON(!r || !*r);
-		return 0;
-	}
-	return *r == data;
-}
-
-/**
- * devm_regulator_unregister - Resource managed regulator_unregister()
- * @dev:  device to supply
- * @rdev: regulator to free
- *
- * Unregister a regulator registered with devm_regulator_register().
- * Normally this function will not need to be called and the resource
- * management code will ensure that the resource is freed.
- */
-void devm_regulator_unregister(struct device *dev, struct regulator_dev *rdev)
-{
-	int rc;
-
-	rc = devres_release(dev, devm_rdev_release, devm_rdev_match, rdev);
-	if (rc != 0)
-		WARN_ON(rc);
-}
-EXPORT_SYMBOL_GPL(devm_regulator_unregister);
-
 struct regulator_supply_alias_match {
 	struct device *dev;
 	const char *id;
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 4aec20387857..5447a6b33fa0 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -645,7 +645,6 @@ devm_regulator_register(struct device *dev,
 			const struct regulator_desc *regulator_desc,
 			const struct regulator_config *config);
 void regulator_unregister(struct regulator_dev *rdev);
-void devm_regulator_unregister(struct device *dev, struct regulator_dev *rdev);
 
 int regulator_notifier_call_chain(struct regulator_dev *rdev,
 				  unsigned long event, void *data);
-- 
2.31.1

