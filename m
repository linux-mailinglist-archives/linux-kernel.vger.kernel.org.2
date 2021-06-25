Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CCC3B4340
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 14:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhFYMdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 08:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhFYMch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 08:32:37 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1C5C061767
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 05:30:15 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bg14so14808320ejb.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 05:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zx2VQiuemlM24atJlUp3h+zNH3qnN4TbRV6QwzIEu5A=;
        b=qDF+zXSrFpc94AlMRxXwj1tkj4BsB0FdTZKxeQKzDIUGGdoB1/G8hG1/PdwX0/V5Ru
         fqtV/VmP/QGipVpC2SixmK83NaOuBI8cde49wZy0DK2TXEVdpihsKiDaFmHI34apSY2q
         rxlRK8xwLr6HudxGBNzJg1JGyNOLORr326lMbA9Fe9wUYT+OUGSyl8ncZ2bu+8fGCmfx
         a0tBJcLyg3dl90qkMzJ+WYrUYXeWWaziMIZRWWdaEnsCAZGBG4qLGPYXv79yrvhAnyiC
         LLkifdR/sNOE6wePE5L4/PHifTmCRK1pUE4mSa/6LhCDBV1XSFJKuZTpqJz9tjt3w6WQ
         Ls7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zx2VQiuemlM24atJlUp3h+zNH3qnN4TbRV6QwzIEu5A=;
        b=C6QUEnIK9imp91vhEd54prFfEvhRZFSxvCJJ+Xt5nDr1IyO/ZOoGu14ilBA0CyGee+
         WULYk7O5y5qhpf43RgfIbUkQOldsWD8ehQsW+ZsZs6SRyKurZO4LHSGgDYTz+u8GcAMo
         WwK3KES3Bm6GW1rDMMSRDo/B9oRK6jRIy2q0khR9smUBDFGp4itXq6HVcINWmCYYj354
         JWC0iR9xjGWXcLi/+H0U8xqprX51EJzjnKV/H80p4ENB7pvwUXT8+qfedjnGSlLsjAnS
         LMDMLrpSNZE8Qs9jwQbc2flXk3F5GcRoQ+3OCppTiHlyYi4UoLxkTMsyMZtSg9HfITrh
         GK1Q==
X-Gm-Message-State: AOAM530iJW5qa8AV9j941i1j4I092m1rRwR5YlPrcNFhB+LzLEqN2n0/
        yyLnmOb2H3mThU/MoBXbqRsUBB08LJstgDOaAUY=
X-Google-Smtp-Source: ABdhPJyi0keXsIN+5KoBJGcPMLyduCCoc6wlWBo1xZULvRQwf5188RcDG2rR8KKk7/OMLjpCfYoc6w==
X-Received: by 2002:a17:906:3a8e:: with SMTP id y14mr10698296ejd.153.1624624214004;
        Fri, 25 Jun 2021 05:30:14 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id c15sm3884351edu.19.2021.06.25.05.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 05:30:13 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-kernel@vger.kernel.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 4/4] regulator: devres: unexport devm_regulator_unregister_supply_alias()
Date:   Fri, 25 Jun 2021 15:23:24 +0300
Message-Id: <20210625122324.327585-5-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625122324.327585-1-aardelean@deviqon.com>
References: <20210625122324.327585-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This API hook isn't used anywhere outside of the regulator devres code.
This function is needed for the devm_regulator_bulk_register_supply_alias()
function on the error path, to cleanup any previously registered supply
aliases.

This change makes the devm_regulator_unregister_supply_alias() local to the
regulator core framework, to avoid it being used in any weird logic.
It's also removing the doc-string for
devm_regulator_unregister_supply_alias(), since it doesn't need to be
documented anymore, as no other external consumer should use it.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/regulator/devres.c         | 16 ++--------------
 include/linux/regulator/consumer.h |  7 -------
 2 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index 007855ae165b..826c29499d69 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -267,19 +267,8 @@ int devm_regulator_register_supply_alias(struct device *dev, const char *id,
 }
 EXPORT_SYMBOL_GPL(devm_regulator_register_supply_alias);
 
-/**
- * devm_regulator_unregister_supply_alias - Resource managed
- * regulator_unregister_supply_alias()
- *
- * @dev: device to supply
- * @id:  supply name or regulator ID
- *
- * Unregister an alias registered with
- * devm_regulator_register_supply_alias(). Normally this function
- * will not need to be called and the resource management code
- * will ensure that the resource is freed.
- */
-void devm_regulator_unregister_supply_alias(struct device *dev, const char *id)
+static void devm_regulator_unregister_supply_alias(struct device *dev,
+						   const char *id)
 {
 	struct regulator_supply_alias_match match;
 	int rc;
@@ -292,7 +281,6 @@ void devm_regulator_unregister_supply_alias(struct device *dev, const char *id)
 	if (rc != 0)
 		WARN_ON(rc);
 }
-EXPORT_SYMBOL_GPL(devm_regulator_unregister_supply_alias);
 
 /**
  * devm_regulator_bulk_register_supply_alias - Managed register
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 10ff6b66ca9e..d5441345d024 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -222,8 +222,6 @@ void regulator_bulk_unregister_supply_alias(struct device *dev,
 int devm_regulator_register_supply_alias(struct device *dev, const char *id,
 					 struct device *alias_dev,
 					 const char *alias_id);
-void devm_regulator_unregister_supply_alias(struct device *dev,
-					    const char *id);
 
 int devm_regulator_bulk_register_supply_alias(struct device *dev,
 					      const char *const *id,
@@ -403,11 +401,6 @@ static inline int devm_regulator_register_supply_alias(struct device *dev,
 	return 0;
 }
 
-static inline void devm_regulator_unregister_supply_alias(struct device *dev,
-							  const char *id)
-{
-}
-
 static inline int devm_regulator_bulk_register_supply_alias(struct device *dev,
 						const char *const *id,
 						struct device *alias_dev,
-- 
2.31.1

