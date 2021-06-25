Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07363B433B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 14:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhFYMcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 08:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbhFYMcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 08:32:35 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A56C061766
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 05:30:12 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id yy20so7090593ejb.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 05:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5KjMNiHkyE5Tuii6YaHY460vPZnUOZsmFbV7N9+wxw4=;
        b=V+iGIX8TyxCeNKk+/D263cE7EwsWZ1kFW47KNtoGGVnuaoKqfLnfBiYaETcEi5nAoa
         kC0h3zPNBV5dKFMcA53Rl1pr3xvkEqAjsWkVsf6uPd1Ok8ZbUeE/dK5pMeIHUhXz8UQJ
         Gw2az3PacTfoniy5/3lfUtytI99hwWxq70sERrJUkIQruL6cyuX8s/VgaAt6Yq1+pxF/
         TVCM9GyzSlU61w0TVzoxfowq/RN4ug9bv8KBC36+Tj2nzdZsBCdZDNwCvBwIeVXAe69a
         KZg09RMzmQ+Dxefcs1mADAJmd4cdttE3M4I44Pl3EDrm2vcbTQA83KS2QCaLIHjGoLNQ
         3Odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5KjMNiHkyE5Tuii6YaHY460vPZnUOZsmFbV7N9+wxw4=;
        b=Kf5tQkil8afHaD0NsUJFQWgTUO384/j+W/53ULk1/RglWApp6sDlQaIMi7bdaGTNP+
         IR4+DPVJnNquVCT4X7JYrp0ypKcY7YJOdYuooJxvq+pvC2Nyy2F+i0+sZjbl1D57Ddrz
         +BgwwHKwE9QtLcII/nvD/JsKa7d7gIK9JNVegThCNgjAX6s6CvIqMggHPczLWbZxR8eH
         FFNGSM03SCplW3sJrGCKT007jCrMpenQZKUqpabXYTcB5NWOfDz0USqiYeeJKOsGbecb
         Y/BZ6ptUhC7v9xv0KCNOzRNedCKX7ET/Kq1uHBkf3zhbpf4k/S3y+CSgT5PyQTE2zOrZ
         1+8w==
X-Gm-Message-State: AOAM531l5OuePpUK8pVvwzpt7bGJvmDi4Sr/K6AGbGNaWfVwDl/Fzi9Q
        zHl88arbQTzGda/XeWFn16BsYvpblohWImiK2yk=
X-Google-Smtp-Source: ABdhPJzMuLTFz1UV1pLqeOgKhxM/fZQiWHPQdlupcj644ougfeEQBvs+xB8EqnlAXMxA3N9Z4lEDgw==
X-Received: by 2002:a17:906:c2ca:: with SMTP id ch10mr10649432ejb.305.1624624211252;
        Fri, 25 Jun 2021 05:30:11 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id c15sm3884351edu.19.2021.06.25.05.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 05:30:10 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-kernel@vger.kernel.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 1/4] regulator: devres: remove devm_regulator_unregister_notifier() function
Date:   Fri, 25 Jun 2021 15:23:21 +0300
Message-Id: <20210625122324.327585-2-aardelean@deviqon.com>
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
 drivers/regulator/devres.c         | 36 ------------------------------
 include/linux/regulator/consumer.h |  8 -------
 2 files changed, 44 deletions(-)

diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index a8de0aa88bad..8895f0f5ad1d 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -402,15 +402,6 @@ struct regulator_notifier_match {
 	struct notifier_block *nb;
 };
 
-static int devm_regulator_match_notifier(struct device *dev, void *res,
-					 void *data)
-{
-	struct regulator_notifier_match *match = res;
-	struct regulator_notifier_match *target = data;
-
-	return match->regulator == target->regulator && match->nb == target->nb;
-}
-
 static void devm_regulator_destroy_notifier(struct device *dev, void *res)
 {
 	struct regulator_notifier_match *match = res;
@@ -455,33 +446,6 @@ int devm_regulator_register_notifier(struct regulator *regulator,
 }
 EXPORT_SYMBOL_GPL(devm_regulator_register_notifier);
 
-/**
- * devm_regulator_unregister_notifier - Resource managed
- * regulator_unregister_notifier()
- *
- * @regulator: regulator source
- * @nb:        notifier block
- *
- * Unregister a notifier registered with devm_regulator_register_notifier().
- * Normally this function will not need to be called and the resource
- * management code will ensure that the resource is freed.
- */
-void devm_regulator_unregister_notifier(struct regulator *regulator,
-					struct notifier_block *nb)
-{
-	struct regulator_notifier_match match;
-	int rc;
-
-	match.regulator = regulator;
-	match.nb = nb;
-
-	rc = devres_release(regulator->dev, devm_regulator_destroy_notifier,
-			    devm_regulator_match_notifier, &match);
-	if (rc != 0)
-		WARN_ON(rc);
-}
-EXPORT_SYMBOL_GPL(devm_regulator_unregister_notifier);
-
 static void regulator_irq_helper_drop(void *res)
 {
 	regulator_irq_helper_cancel(&res);
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index f72ca73631be..fb653d2a11f0 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -290,8 +290,6 @@ int devm_regulator_register_notifier(struct regulator *regulator,
 				     struct notifier_block *nb);
 int regulator_unregister_notifier(struct regulator *regulator,
 				struct notifier_block *nb);
-void devm_regulator_unregister_notifier(struct regulator *regulator,
-					struct notifier_block *nb);
 
 /* regulator suspend */
 int regulator_suspend_enable(struct regulator_dev *rdev,
@@ -597,12 +595,6 @@ static inline int regulator_unregister_notifier(struct regulator *regulator,
 	return 0;
 }
 
-static inline int devm_regulator_unregister_notifier(struct regulator *regulator,
-						     struct notifier_block *nb)
-{
-	return 0;
-}
-
 static inline int regulator_suspend_enable(struct regulator_dev *rdev,
 					   suspend_state_t state)
 {
-- 
2.31.1

