Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE4F306E01
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 08:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhA1HBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 02:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhA1HBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:01:03 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3BCC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 23:00:22 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id i63so3394338pfg.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 23:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ahYJzfuIo0e0JMYan7FcQvKFG+Ou8KUaBl9Hz3G4Bjc=;
        b=Jj183wChBfgZwye6P7NOZdByRSO/k/ZcMKjILrw2i4XOkpzoKon5D4OOzkfQjWVvKC
         pQxQYIbfGCkW1AiNxOKp+rix65EBzSWrDHRURncr7pPc/6FjLavepL/8x/ApoFT50heP
         by5LU73od8m75JVLXVBbKv2Ic+SSZ0v+UEqSgYrCdugV+9Hu7wParFrjV6XrSKZsLFeE
         LfO5wKINZo1p9+Kj34vrs4RoIsq9MGAn5v8gV0gEuDDORvzatn/znGK+dqrP+a1Y3hBl
         TSvDBMhQEBKJUMFeNrvTAX42vnHchyaqKUixcIbAulsC/5bL1GSD4aDFQrGFReinPZSw
         9toQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ahYJzfuIo0e0JMYan7FcQvKFG+Ou8KUaBl9Hz3G4Bjc=;
        b=XAHfWDb/8H39HAzb2TqE+HgVdu4+0IelKjV7150N5Wce3F35YxHqIBcTRhZyvTEC+q
         LxcHfpBnLVIul/u2S4Uf/MsZLw+/bhFd66bwmBW3ctXAL0zQ44Aw11hotQGDa4PAAy+P
         kcQXnTXg2Wp9nR30K1KoHBNmu4g4W/KWZNwWJx/7ecJIFJe9Hqg3QPx8YUY40MKZiyf3
         8pnMUwy2SvvoCXA0a1aaA7Hn97EgW4ns1AYVMQhk1/HFX37jsgOlkAmIm5pVgDujYk5K
         n5alD8krGAQmA50UZ/9mDnPfPi4r5Q6B0RyW/VVznQs/VjGg/GkGR+8JCbbhbD908Ofg
         kZtQ==
X-Gm-Message-State: AOAM532ISEWawmGvGAnScE8EmVz8cO/y7aON+ScAsVUSGG/6JCHEq5Ms
        yZdgP8XINEr6Llc/ZK47dkNM0g==
X-Google-Smtp-Source: ABdhPJxu41jKMxIek9VkDvEcr1Bb5NeOAEbJ7/yByWpWl65d7YpqOIHuMcX7JBPfyvJbLeM4AzbpQA==
X-Received: by 2002:a62:8c85:0:b029:1bd:5441:6cb8 with SMTP id m127-20020a628c850000b02901bd54416cb8mr14580564pfd.29.1611817222050;
        Wed, 27 Jan 2021 23:00:22 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id gd9sm3965466pjb.10.2021.01.27.23.00.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 23:00:21 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/3] opp: Defer acquiring the clk until OPPs are added
Date:   Thu, 28 Jan 2021 12:30:08 +0530
Message-Id: <0c9026f0f4934d1106758284fb1583a7a6758219.1611817096.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <1b58a72fa4d6aadc9542a66f8150150534752d81.1611817096.git.viresh.kumar@linaro.org>
References: <1b58a72fa4d6aadc9542a66f8150150534752d81.1611817096.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We acquire the clk at the time the OPP table is allocated, though it
works fine, it is not the best place to do so. One of the main reason
being we may need to acquire it again from dev_pm_opp_set_clkname() if
the platform wants another clock to be acquired instead.

There is also requirement from some of the platforms where they do not
want the OPP core to manage the clock at all.

This patch hence defers acquiring the clk until the time we are certain
about which clk we need to acquire and if we really need to acquire one.
With this commit, the clk will get acquired either from
dev_pm_opp_set_clkname() or while we initialize the OPPs within the
table.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2:
- Split the earlier patch into two
- Instead of skipping the clk-acquiring in _allocate_opp_table() based
  on getclk flag, defer it until later and get it only if we need to.

 drivers/opp/core.c | 73 ++++++++++++++++++++++++++++------------------
 drivers/opp/of.c   |  8 ++---
 drivers/opp/opp.h  |  2 +-
 3 files changed, 50 insertions(+), 33 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index bf7cdab0ba64..52f4a64926e6 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1158,21 +1158,11 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 
 	_of_init_opp_table(opp_table, dev, index);
 
-	/* Find clk for the device */
-	opp_table->clk = clk_get(dev, NULL);
-	if (IS_ERR(opp_table->clk)) {
-		ret = PTR_ERR(opp_table->clk);
-		if (ret == -EPROBE_DEFER)
-			goto remove_opp_dev;
-
-		dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__, ret);
-	}
-
 	/* Find interconnect path(s) for the device */
 	ret = dev_pm_opp_of_find_icc_paths(dev, opp_table);
 	if (ret) {
 		if (ret == -EPROBE_DEFER)
-			goto put_clk;
+			goto remove_opp_dev;
 
 		dev_warn(dev, "%s: Error finding interconnect paths: %d\n",
 			 __func__, ret);
@@ -1184,9 +1174,6 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 
 	return opp_table;
 
-put_clk:
-	if (!IS_ERR(opp_table->clk))
-		clk_put(opp_table->clk);
 remove_opp_dev:
 	_remove_opp_dev(opp_dev, opp_table);
 err:
@@ -1199,6 +1186,33 @@ void _get_opp_table_kref(struct opp_table *opp_table)
 	kref_get(&opp_table->kref);
 }
 
+static struct opp_table *_update_opp_table_clk(struct device *dev,
+					       struct opp_table *opp_table,
+					       bool getclk)
+{
+	/*
+	 * Return early if we don't need to get clk or we have already tried it
+	 * earlier.
+	 */
+	if (!getclk || IS_ERR(opp_table) || opp_table->clk)
+		return opp_table;
+
+	/* Find clk for the device */
+	opp_table->clk = clk_get(dev, NULL);
+	if (IS_ERR(opp_table->clk)) {
+		int ret = PTR_ERR(opp_table->clk);
+
+		if (ret == -EPROBE_DEFER) {
+			dev_pm_opp_put_opp_table(opp_table);
+			return ERR_PTR(ret);
+		}
+
+		dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__, ret);
+	}
+
+	return opp_table;
+}
+
 /*
  * We need to make sure that the OPP table for a device doesn't get added twice,
  * if this routine gets called in parallel with the same device pointer.
@@ -1214,7 +1228,8 @@ void _get_opp_table_kref(struct opp_table *opp_table)
  * uses the opp_tables_busy flag to indicate if another creator is in the middle
  * of adding an OPP table and others should wait for it to finish.
  */
-struct opp_table *_add_opp_table_indexed(struct device *dev, int index)
+struct opp_table *_add_opp_table_indexed(struct device *dev, int index,
+					 bool getclk)
 {
 	struct opp_table *opp_table;
 
@@ -1261,12 +1276,12 @@ struct opp_table *_add_opp_table_indexed(struct device *dev, int index)
 unlock:
 	mutex_unlock(&opp_table_lock);
 
-	return opp_table;
+	return _update_opp_table_clk(dev, opp_table, getclk);
 }
 
-static struct opp_table *_add_opp_table(struct device *dev)
+static struct opp_table *_add_opp_table(struct device *dev, bool getclk)
 {
-	return _add_opp_table_indexed(dev, 0);
+	return _add_opp_table_indexed(dev, 0, getclk);
 }
 
 struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
@@ -1711,7 +1726,7 @@ struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev,
 {
 	struct opp_table *opp_table;
 
-	opp_table = _add_opp_table(dev);
+	opp_table = _add_opp_table(dev, false);
 	if (IS_ERR(opp_table))
 		return opp_table;
 
@@ -1773,7 +1788,7 @@ struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name)
 {
 	struct opp_table *opp_table;
 
-	opp_table = _add_opp_table(dev);
+	opp_table = _add_opp_table(dev, false);
 	if (IS_ERR(opp_table))
 		return opp_table;
 
@@ -1869,7 +1884,7 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 	struct regulator *reg;
 	int ret, i;
 
-	opp_table = _add_opp_table(dev);
+	opp_table = _add_opp_table(dev, false);
 	if (IS_ERR(opp_table))
 		return opp_table;
 
@@ -1980,7 +1995,7 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
 	struct opp_table *opp_table;
 	int ret;
 
-	opp_table = _add_opp_table(dev);
+	opp_table = _add_opp_table(dev, false);
 	if (IS_ERR(opp_table))
 		return opp_table;
 
@@ -1990,9 +2005,11 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
 		goto err;
 	}
 
-	/* Already have default clk set, free it */
-	if (!IS_ERR(opp_table->clk))
-		clk_put(opp_table->clk);
+	/* clk shouldn't be initialized at this point */
+	if (WARN_ON(opp_table->clk)) {
+		ret = -EBUSY;
+		goto err;
+	}
 
 	/* Find clk for the device */
 	opp_table->clk = clk_get(dev, name);
@@ -2051,7 +2068,7 @@ struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev,
 	if (!set_opp)
 		return ERR_PTR(-EINVAL);
 
-	opp_table = _add_opp_table(dev);
+	opp_table = _add_opp_table(dev, false);
 	if (IS_ERR(opp_table))
 		return opp_table;
 
@@ -2138,7 +2155,7 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
 	int index = 0, ret = -EINVAL;
 	const char **name = names;
 
-	opp_table = _add_opp_table(dev);
+	opp_table = _add_opp_table(dev, false);
 	if (IS_ERR(opp_table))
 		return opp_table;
 
@@ -2306,7 +2323,7 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 	struct opp_table *opp_table;
 	int ret;
 
-	opp_table = _add_opp_table(dev);
+	opp_table = _add_opp_table(dev, true);
 	if (IS_ERR(opp_table))
 		return PTR_ERR(opp_table);
 
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index c6856dcf4c34..d4b51b2e384f 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -956,7 +956,7 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
 	return ret;
 }
 
-static int _of_add_table_indexed(struct device *dev, int index)
+static int _of_add_table_indexed(struct device *dev, int index, bool getclk)
 {
 	struct opp_table *opp_table;
 	int ret, count;
@@ -972,7 +972,7 @@ static int _of_add_table_indexed(struct device *dev, int index)
 			index = 0;
 	}
 
-	opp_table = _add_opp_table_indexed(dev, index);
+	opp_table = _add_opp_table_indexed(dev, index, getclk);
 	if (IS_ERR(opp_table))
 		return PTR_ERR(opp_table);
 
@@ -1010,7 +1010,7 @@ static int _of_add_table_indexed(struct device *dev, int index)
  */
 int dev_pm_opp_of_add_table(struct device *dev)
 {
-	return _of_add_table_indexed(dev, 0);
+	return _of_add_table_indexed(dev, 0, true);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table);
 
@@ -1026,7 +1026,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table);
  */
 int dev_pm_opp_of_add_table_indexed(struct device *dev, int index)
 {
-	return _of_add_table_indexed(dev, index);
+	return _of_add_table_indexed(dev, index, true);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table_indexed);
 
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index ee2593afae0c..6e83855ade1f 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -223,7 +223,7 @@ int _opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2);
 int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *opp_table, bool rate_not_available);
 int _opp_add_v1(struct opp_table *opp_table, struct device *dev, unsigned long freq, long u_volt, bool dynamic);
 void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, int last_cpu);
-struct opp_table *_add_opp_table_indexed(struct device *dev, int index);
+struct opp_table *_add_opp_table_indexed(struct device *dev, int index, bool getclk);
 void _put_opp_list_kref(struct opp_table *opp_table);
 
 #ifdef CONFIG_OF
-- 
2.25.0.rc1.19.g042ed3e048af

