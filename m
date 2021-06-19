Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA863ADA06
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 14:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbhFSMni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 08:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbhFSMnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 08:43:35 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3A5C061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 05:41:24 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x24so21540915lfr.10
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 05:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VzMgQHjfusaLz0w3EEXQDR2vRTEXPFNK87P0CltMp18=;
        b=oQsc/JYDuBVaIcCZOgHqvIQFLMXgg8tgyBDBWd4MEUK6c76m7clPCl1VbjyNG71wgX
         YWFTbt8fVYncgnjHG8f7ubegjhWosj3Z7NhyGCydbHyMXTIea6dJjEejjuBYkQp1xGbC
         4EScvml9zYi/P3c8K2XhwxYZgdWWoPnsN9PCWwMIMQRpuoGOZ7CxZkkp1BXD+C9W1dKL
         +0K8eSL58083by6KN1kE7Y1SJ4De3BYLHS60GyxTCmbym4hywBKbMb3mtFx/hAUKbUDI
         bjV1mhg2AxWx4OeFmRTAwzBKVrBGVMekKacdnVnLzFkqt3oupgKuH31EiNbTY7uEfV42
         q8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VzMgQHjfusaLz0w3EEXQDR2vRTEXPFNK87P0CltMp18=;
        b=g5xtByxtzPz4+/+ScVVq89/3zqFy4fgo+NiULhDWUZH8CvOPot63pxXLtrrlyKbLuY
         Ma4oEIKI2wNEM3IrqO8Tzcjv8bdDkGPtbPnWPryzIszXev1YLRw02Eif1j0n5VA2LbcL
         wW17KLI6WHUaXWHCZj/fKAbP4ZsAIK00pDp1wGwF9I7IL10wmvH4yY/0KO5W4AmKWf62
         RHPqOzEDLtL3qpr1R71trseb5ySY/LdM3g1mx+9sCxvKUJWwskdbEkUDcID1rpKXOhWf
         kpy5b4UJNaO99ijVHrVmrN894tv8Y6rMzPCTHpnUAu6umIHa/tR21bOiSNlVg3RXf4Q5
         AQ5w==
X-Gm-Message-State: AOAM532XQ/qb+MjYPwKqt6hCt47h8Nfmddc274tcn4PYHRBc/2mePTWD
        KZZnkkoP9vpmn7VjG8mv0tooK9vC508=
X-Google-Smtp-Source: ABdhPJyM+scD266IoTMLigg5cjEJ4qHae7B0W7cqW2LrryQxGYULK2SJbTulbPaVE9L2KvmRyNeOFg==
X-Received: by 2002:a19:c141:: with SMTP id r62mr3296332lff.23.1624106482525;
        Sat, 19 Jun 2021 05:41:22 -0700 (PDT)
Received: from localhost.localdomain (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.gmail.com with ESMTPSA id q17sm1400373ljp.3.2021.06.19.05.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 05:41:22 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v1] regulator: core: Add stubs for driver API
Date:   Sat, 19 Jun 2021 15:40:52 +0300
Message-Id: <20210619124052.1354-1-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add stubs for regulator driver API in order to fix compile-test build
errors of kernel configurations where regulator framework is disabled.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/regulator/driver.h | 237 +++++++++++++++++++++++++++++++
 1 file changed, 237 insertions(+)

diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 35e5a611db81..1dbc7fc22090 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -479,6 +479,8 @@ struct regulator_dev {
 	ktime_t last_off;
 };
 
+#if defined(CONFIG_REGULATOR)
+
 struct regulator_dev *
 regulator_register(const struct regulator_desc *regulator_desc,
 		   const struct regulator_config *config);
@@ -551,4 +553,239 @@ int regulator_desc_list_voltage_linear_range(const struct regulator_desc *desc,
 
 int regulator_desc_list_voltage_linear(const struct regulator_desc *desc,
 				       unsigned int selector);
+
+#else
+
+static inline struct regulator_dev *
+regulator_register(const struct regulator_desc *regulator_desc,
+		   const struct regulator_config *config)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline struct regulator_dev *
+devm_regulator_register(struct device *dev,
+			const struct regulator_desc *regulator_desc,
+			const struct regulator_config *config)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline void regulator_unregister(struct regulator_dev *rdev)
+{
+}
+
+static inline void
+devm_regulator_unregister(struct device *dev, struct regulator_dev *rdev)
+{
+}
+
+static inline int regulator_notifier_call_chain(struct regulator_dev *rdev,
+						unsigned long event, void *data)
+{
+	return 0;
+}
+
+static inline void *rdev_get_drvdata(struct regulator_dev *rdev)
+{
+	return NULL;
+}
+
+static inline struct device *rdev_get_dev(struct regulator_dev *rdev)
+{
+	return 0;
+}
+
+static inline struct regmap *rdev_get_regmap(struct regulator_dev *rdev)
+{
+	return 0;
+}
+
+static inline int rdev_get_id(struct regulator_dev *rdev)
+{
+	return 0;
+}
+
+static inline int regulator_mode_to_status(unsigned int mode)
+{
+	return 0;
+}
+
+static inline int regulator_list_voltage_linear(struct regulator_dev *rdev,
+						unsigned int selector)
+{
+	return 0;
+}
+
+static inline int
+regulator_list_voltage_pickable_linear_range(struct regulator_dev *rdev,
+					     unsigned int selector)
+{
+	return 0;
+}
+
+static inline int
+regulator_list_voltage_linear_range(struct regulator_dev *rdev,
+				    unsigned int selector)
+{
+	return 0;
+}
+
+static inline int regulator_list_voltage_table(struct regulator_dev *rdev,
+					       unsigned int selector)
+{
+	return 0;
+}
+
+static inline int regulator_map_voltage_linear(struct regulator_dev *rdev,
+					       int min_uV, int max_uV)
+{
+	return 0;
+}
+
+static inline int
+regulator_map_voltage_pickable_linear_range(struct regulator_dev *rdev,
+					    int min_uV, int max_uV)
+{
+	return 0;
+}
+
+static inline int regulator_map_voltage_linear_range(struct regulator_dev *rdev,
+						     int min_uV, int max_uV)
+{
+	return 0;
+}
+
+static inline int regulator_map_voltage_iterate(struct regulator_dev *rdev,
+						int min_uV, int max_uV)
+{
+	return 0;
+}
+
+static inline int regulator_map_voltage_ascend(struct regulator_dev *rdev,
+					       int min_uV, int max_uV)
+{
+	return 0;
+}
+
+static inline int
+regulator_get_voltage_sel_pickable_regmap(struct regulator_dev *rdev)
+{
+	return 0;
+}
+
+static inline int
+regulator_set_voltage_sel_pickable_regmap(struct regulator_dev *rdev,
+					  unsigned int sel)
+{
+	return 0;
+}
+
+static inline int regulator_get_voltage_sel_regmap(struct regulator_dev *rdev)
+{
+	return 0;
+}
+
+static inline int regulator_set_voltage_sel_regmap(struct regulator_dev *rdev,
+						   unsigned sel)
+{
+	return 0;
+}
+
+static inline int regulator_is_enabled_regmap(struct regulator_dev *rdev)
+{
+	return 0;
+}
+
+static inline int regulator_enable_regmap(struct regulator_dev *rdev)
+{
+	return 0;
+}
+
+static inline int regulator_disable_regmap(struct regulator_dev *rdev)
+{
+	return 0;
+}
+
+static inline int
+regulator_set_voltage_time_sel(struct regulator_dev *rdev,
+			       unsigned int old_selector,
+			       unsigned int new_selector)
+{
+	return 0;
+}
+
+static inline int regulator_set_bypass_regmap(struct regulator_dev *rdev,
+					      bool enable)
+{
+	return 0;
+}
+
+static inline int regulator_get_bypass_regmap(struct regulator_dev *rdev,
+					      bool *enable)
+{
+	return 0;
+}
+
+static inline int regulator_set_soft_start_regmap(struct regulator_dev *rdev)
+{
+	return 0;
+}
+
+static inline int regulator_set_pull_down_regmap(struct regulator_dev *rdev)
+{
+	return 0;
+}
+
+static inline int
+regulator_set_active_discharge_regmap(struct regulator_dev *rdev,
+				      bool enable)
+{
+	return 0;
+}
+
+static inline int
+regulator_set_current_limit_regmap(struct regulator_dev *rdev,
+				   int min_uA, int max_uA)
+{
+	return 0;
+}
+
+static inline int regulator_get_current_limit_regmap(struct regulator_dev *rdev)
+{
+	return 0;
+}
+
+static inline void *
+regulator_get_init_drvdata(struct regulator_init_data *reg_init_data)
+{
+	return NULL;
+}
+
+static inline int regulator_set_ramp_delay_regmap(struct regulator_dev *rdev,
+						  int ramp_delay)
+{
+	return 0;
+}
+
+static inline int regulator_sync_voltage_rdev(struct regulator_dev *rdev)
+{
+	return 0;
+}
+
+static inline int
+regulator_desc_list_voltage_linear_range(const struct regulator_desc *desc,
+					 unsigned int selector)
+{
+	return 0;
+}
+
+static inline int
+regulator_desc_list_voltage_linear(const struct regulator_desc *desc,
+				   unsigned int selector)
+{
+	return 0;
+}
+#endif
+
 #endif
-- 
2.30.2

