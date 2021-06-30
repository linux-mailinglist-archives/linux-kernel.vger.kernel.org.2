Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E093B826C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 14:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbhF3MwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 08:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbhF3MwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 08:52:08 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4D7C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 05:49:39 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x12so3079834eds.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 05:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PlVarbd8E2QdPXydXe0d8Q43F5oKr/22Cwjo50BSBtM=;
        b=j9cLBBsf/xdIwNLC/kxrvJWX48WB1WUAx2N74fJcXlinBMjZczhfkLB8NC8rxaKjYI
         CJ0CPfQ4QCDV60mfPakxgEmyxOyNtxA+6ZRanIkdUpAxPFL26CN6dV5iCxJpgjy/MEit
         NSGK9tc5A+pRDMUqdGSLy3CgDcKeiM2wNIafNaGicIvE5c20JgvMufjL+Ee5LbZrTHml
         RyMcGdrbQ0OT0OgPkc29g5bXYU5TSKB7RRK3lulOha7oITQvQA1GbZq5WLs9zaZ9zN4U
         RVo0M3cwnlxPCRRwhXqlVWnPK5k/PldkeD5DX1BjejEwGyUWuTrzVIaYC31bMiO//5vf
         mt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PlVarbd8E2QdPXydXe0d8Q43F5oKr/22Cwjo50BSBtM=;
        b=bFR5p+a+i0wAU+rSTPhzoYZ9MWTK4e87a1jKSXbhJa04lzV1UGbA1gkNA0rdhSV8W/
         wlD5/4ausMtvg/xU+Jgndpgmanl67USDb0azBHiue0GBHn4csW4dqYxp340bX7roCaJr
         AE6XI42W8G38nkZAFPmKi8RwGZA64gPJBvJjDtErm8KVF71+Vek6NTQW6ClDrTpLDj4N
         O5jFVbaiBLyDm7BBatVLFS/Jmk+NBYEnwKQrNi1oB2DloVOjwYUUBJ8wsXAXEMoHGBvu
         EHpnjN/qm+q33fwk68JwFXzI3z+9mZEA+Rj6N5oM/rTdPVeSr2JRAXyCh0/ImKoCwnS5
         MvFQ==
X-Gm-Message-State: AOAM531rnqmzGkUC1wlB+g4UfcNJlPYSZ5H04L7MSV3s+L+lYTmMR3bq
        Q7Z16Nv/b3Rp8YBp8j0elbbKlnWM/YAcZbZb
X-Google-Smtp-Source: ABdhPJwIID0hSYx4UgtjNVmXHa/O3StHI/ZVuqHPwdi/poh3DnJFw9JsFKEj0S0JPjH3G1PvTP3c3w==
X-Received: by 2002:a05:6402:c9a:: with SMTP id cm26mr46767939edb.57.1625057378139;
        Wed, 30 Jun 2021 05:49:38 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id w21sm3303565edc.95.2021.06.30.05.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 05:49:37 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-kernel@vger.kernel.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH v2] regulator: devres: add devm_regulator_enable() as short-hand
Date:   Wed, 30 Jun 2021 15:49:31 +0300
Message-Id: <20210630124931.1226658-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625125307.330831-1-aardelean@deviqon.com>
References: <20210625125307.330831-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Evidently, this came about after doing a few of these types of constructs:

    static void reg_disable(void *reg)
    {
        regulator_disable(reg)
    }
    ...
    ret = regulator_enable(reg);
    if (ret)
        return ret;

    ret = devm_add_action_or_reset(dev, reg_disable, reg);
    ...

A previous proposal was done via [1], to automatically decrease the enable
refcount in devm_regulator_release() if it's 1.
A point was made that this [indeed] can cause issues with
reviewing/tracking enable refcount.

I'm not sure [at this point in time] whether a devm_regulator_enable()
function is still something that would be a good idea, given that this can
cause issues with consumers potentially mixing regulator_enable() and
devm_regulator_enable() calls. This concern was mentioned in [2].

But, there are now a number of simple drivers that are implementing the above
construct already, so it may be an idea to propose this short-hand in the
regulator framework.

References:
 [1] https://lore.kernel.org/lkml/20210625125307.330831-1-aardelean@deviqon.com/
 [2] https://lore.kernel.org/lkml/20170213023249.GA27688@dtor-ws/
 [3] https://lkml.org/lkml/2014/2/4/940

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 .../driver-api/driver-model/devres.rst        |  1 +
 drivers/regulator/devres.c                    | 20 +++++++++++++++++++
 include/linux/regulator/consumer.h            |  8 ++++++++
 3 files changed, 29 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index e0814d214048..8a92e0888cb8 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -408,6 +408,7 @@ REGULATOR
   devm_regulator_get()
   devm_regulator_put()
   devm_regulator_register()
+  devm_regulator_enable()
 
 RESET
   devm_reset_control_get()
diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index a8de0aa88bad..dfb23ac178a0 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -533,3 +533,23 @@ void *devm_regulator_irq_helper(struct device *dev,
 	return ptr;
 }
 EXPORT_SYMBOL_GPL(devm_regulator_irq_helper);
+
+static void devm_regulator_disable(void *regulator)
+{
+	regulator_disable(regulator);
+}
+
+/**
+ * devm_regulator_enable - device-managed regulator_enable
+ * @dev: device for regulator "consumer"
+ * @regulator: regulator source
+ *
+ * This will register an action handler for disabling the regulator
+ * by reistering a regulator_disable() call via devm_add_action_or_reset().
+ * It's meant to be a short-hand for all the drivers using this construct.
+ */
+int devm_regulator_enable(struct device *dev, struct regulator *regulator)
+{
+	return devm_add_action_or_reset(dev, devm_regulator_disable, regulator);
+}
+EXPORT_SYMBOL_GPL(devm_regulator_enable);
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index f72ca73631be..01f17205c567 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -236,6 +236,8 @@ void devm_regulator_bulk_unregister_supply_alias(struct device *dev,
 
 /* regulator output control and status */
 int __must_check regulator_enable(struct regulator *regulator);
+int __must_check devm_regulator_enable(struct device *dev,
+                                       struct regulator *regulator);
 int regulator_disable(struct regulator *regulator);
 int regulator_force_disable(struct regulator *regulator);
 int regulator_is_enabled(struct regulator *regulator);
@@ -432,6 +434,12 @@ static inline int regulator_enable(struct regulator *regulator)
 	return 0;
 }
 
+static inline int devm_regulator_enable(struct device *dev,
+                                        struct regulator *regulator)
+{
+	return 0;
+}
+
 static inline int regulator_disable(struct regulator *regulator)
 {
 	return 0;
-- 
2.31.1

