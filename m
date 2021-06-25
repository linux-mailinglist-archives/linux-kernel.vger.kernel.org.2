Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212E53B433C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 14:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhFYMct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 08:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbhFYMcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 08:32:36 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C320BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 05:30:14 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gn32so14898862ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 05:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7uTpeNDt6hPhfzIpRWDgXze0mbsew40+reH6QWRRbt8=;
        b=QzHH10/Zg6e5jKltX9Y2D8emidFs4HE9iZT6Kd3VfcTAayU/MHVhTfYr3ML3S3cMp3
         nvTUXxYfGCDHtfQQwMyLyUAGJI1N6s3UxVL61F7ZeBR62BIitESp8Ub9bhkwAJmBseeZ
         s3LcPNmmVFce24ANxn3HUe/So26xNQAF2v51AaB/qp6d7jnHwparaX9uHhjZiL5egSBI
         Nql/m8nN/ZSmORaPbB92OmMyZGkQKMRjHkD2ZNR0kB/LfdFhsD1PbzIVUU9WGzL+eOJ8
         Ysx3M5joZTj+pXi2c6hPRUOh4Ras0KKDVMRjIDWeBkC/HFkImz0dHhZRjXOuV05aNMbT
         93gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7uTpeNDt6hPhfzIpRWDgXze0mbsew40+reH6QWRRbt8=;
        b=P//j4yVYzw6lloNVkZVzG2PjBGuAhIelf9pRBy9XFBSNZRyv1hzunsCnGnMimbQ2R2
         01ybhvCdI/BMdq7DY8SkDhCScRFUpJvu0uJdDUHp1dm+3AKj7CiDH4nRUBj18QtliqI5
         U3yEUbliJp07yXJBDxZbi8FCHkoOlTgJVbFb9zjaYS/3DRlgRGd1LWP+kS4SFh0f2PrD
         x2R+61bs8ip6hC7RPHrjLmZFPwbQKVinwZj5NKEdl9lQO52baheQs9vlu5uvw4jWf8Ab
         JiA3k/vX8VsSn19YOAdauQZnwLmJn07mNNEZVGbV1lV/bbX4MiA2Xhx96kI7WYNYiIGb
         xwCQ==
X-Gm-Message-State: AOAM532MkgasDbALK0aiDue4cMuyZg4HB0u7RSCVwb4/1NptQxdQdQrG
        pgJ91yn8SDacGCoHOeGPo1I3MQ3EhJD5eOmWYLE=
X-Google-Smtp-Source: ABdhPJz2q2qG0uT0wEgORGxYjILWC6gVBtcHcrq49gRg4va3hTDxWJWaJ9lklJpSJKSEWO+MiJmMjA==
X-Received: by 2002:a17:907:2622:: with SMTP id aq2mr10761449ejc.48.1624624213109;
        Fri, 25 Jun 2021 05:30:13 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id c15sm3884351edu.19.2021.06.25.05.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 05:30:12 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-kernel@vger.kernel.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 3/4] regulator: devres: remove devm_regulator_bulk_unregister_supply_alias()
Date:   Fri, 25 Jun 2021 15:23:23 +0300
Message-Id: <20210625122324.327585-4-aardelean@deviqon.com>
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
 drivers/regulator/devres.c         | 24 ------------------------
 include/linux/regulator/consumer.h |  8 --------
 2 files changed, 32 deletions(-)

diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index bf0d19a7fb69..007855ae165b 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -344,30 +344,6 @@ int devm_regulator_bulk_register_supply_alias(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_regulator_bulk_register_supply_alias);
 
-/**
- * devm_regulator_bulk_unregister_supply_alias - Managed unregister
- * multiple aliases
- *
- * @dev:    device to supply
- * @id:     list of supply names or regulator IDs
- * @num_id: number of aliases to unregister
- *
- * Unregister aliases registered with
- * devm_regulator_bulk_register_supply_alias(). Normally this function
- * will not need to be called and the resource management code
- * will ensure that the resource is freed.
- */
-void devm_regulator_bulk_unregister_supply_alias(struct device *dev,
-						 const char *const *id,
-						 int num_id)
-{
-	int i;
-
-	for (i = 0; i < num_id; ++i)
-		devm_regulator_unregister_supply_alias(dev, id[i]);
-}
-EXPORT_SYMBOL_GPL(devm_regulator_bulk_unregister_supply_alias);
-
 struct regulator_notifier_match {
 	struct regulator *regulator;
 	struct notifier_block *nb;
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index fb653d2a11f0..10ff6b66ca9e 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -230,9 +230,6 @@ int devm_regulator_bulk_register_supply_alias(struct device *dev,
 					      struct device *alias_dev,
 					      const char *const *alias_id,
 					      int num_id);
-void devm_regulator_bulk_unregister_supply_alias(struct device *dev,
-						 const char *const *id,
-						 int num_id);
 
 /* regulator output control and status */
 int __must_check regulator_enable(struct regulator *regulator);
@@ -420,11 +417,6 @@ static inline int devm_regulator_bulk_register_supply_alias(struct device *dev,
 	return 0;
 }
 
-static inline void devm_regulator_bulk_unregister_supply_alias(
-	struct device *dev, const char *const *id, int num_id)
-{
-}
-
 static inline int regulator_enable(struct regulator *regulator)
 {
 	return 0;
-- 
2.31.1

