Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DF030EE26
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 09:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbhBDIP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 03:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbhBDIPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 03:15:12 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C20CC061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 00:14:32 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id g15so1344218pjd.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 00:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x5CYaMWQw/4Wx6VXz67FQpkoWBucz0YJ72zvXGes1Ck=;
        b=QZvelL5k11SF4Dg/A6++a6KsE/vSckTzOkNENbQWJCmUC4yyMS/Mb6rz/WKA32rxjc
         cGnd7sDUuvE+F/qbVYvFQqoRzxsWNQeagz56NbQnnFecUqBdKwcIRfBzgtOn9bz35R3z
         +AosgC/5C0oTMMyk052i2IqSqShkwb4b6Q+JM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x5CYaMWQw/4Wx6VXz67FQpkoWBucz0YJ72zvXGes1Ck=;
        b=eEj/RZIIPY13Sp9K4niqGBzDkMaWVk1fK4W/zIEOLcNtJoUMXol1l8lIxMO+ZSBzZO
         eCkYQqY4lNfCYe4xNpxrSctZyWWNN28JuxgwLvLAiLdBgU2cJjB7Hpc6moGkPaBPDn0M
         XjLF7tzkv+s1OaOYnSCBBPWGYNRRF8+5xqk9jUENnuIWgNTYz1hroTAoxVyX/G+jC5Tu
         93Ui2nJqEPjn3Vz2G4wd4Yqef4HnyzzIyEfuhEPumFnER0w6xX3kgm/7lHd0NxP6twDK
         AzSJD4UXgNOn3peib4+yHKNCU6/Y/VSw9bGWhGSjx0lcLbwt/JhFGjgpgPQl1r+FtcV8
         rxcw==
X-Gm-Message-State: AOAM533kprsc5/7N4RMF9omG/ItYBzdWxKqRpGgDrIaI7/4WzYAJYLwV
        UD4yAOwELMBTasSICHnT5KZckQ==
X-Google-Smtp-Source: ABdhPJztsSY/dpx9ZsIbkOQnPw+LFxN23y4ugBHxtV0o8MUFdQB7zo18NhIUL+2TBYQXmxc2b2kyXQ==
X-Received: by 2002:a17:902:d2c1:b029:de:7c38:f86a with SMTP id n1-20020a170902d2c1b02900de7c38f86amr7102021plc.83.1612426471523;
        Thu, 04 Feb 2021 00:14:31 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:ed70:6d43:9c6a:2e22])
        by smtp.gmail.com with ESMTPSA id e3sm5091258pgs.60.2021.02.04.00.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 00:14:31 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v6 1/3] OPP: Add function to look up required OPP's for a given OPP
Date:   Thu,  4 Feb 2021 16:14:22 +0800
Message-Id: <20210204081424.2219311-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210204081424.2219311-1-hsinyi@chromium.org>
References: <20210204081424.2219311-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saravana Kannan <saravanak@google.com>

Add a function that allows looking up required OPPs given a source OPP
table, destination OPP table and the source OPP.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/opp/core.c     | 59 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  7 +++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index dc95d29e94c1b..fba67ae40aefc 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2398,6 +2398,65 @@ devm_pm_opp_attach_genpd(struct device *dev, const char **names,
 }
 EXPORT_SYMBOL_GPL(devm_pm_opp_attach_genpd);
 
+/**
+ * dev_pm_opp_xlate_required_opp() - Find required OPP for @src_table OPP.
+ * @src_table: OPP table which has @dst_table as one of its required OPP table.
+ * @dst_table: Required OPP table of the @src_table.
+ *
+ * This function returns the OPP (present in @dst_table) pointed out by the
+ * "required-opps" property of the OPP (present in @src_table).
+ *
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
+ *
+ * Return: destination table OPP on success, otherwise -EINVAL or -ENODEV based
+ * on errors.
+ */
+struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table,
+						 struct opp_table *dst_table,
+						 struct dev_pm_opp *src_opp)
+{
+	struct dev_pm_opp *opp, *dest_opp = ERR_PTR(-EINVAL);
+	int i;
+
+	if (!src_table || !dst_table || !src_opp ||
+	    !src_table->required_opp_tables)
+		return ERR_PTR(-EINVAL);
+
+	/* required-opps not fully initialized yet */
+	if (lazy_linking_pending(src_table))
+		return ERR_PTR(-EINVAL);
+
+	for (i = 0; i < src_table->required_opp_count; i++) {
+		if (src_table->required_opp_tables[i] == dst_table)
+			break;
+	}
+
+	if (unlikely(i == src_table->required_opp_count)) {
+		pr_err("%s: Couldn't find matching OPP table (%p: %p)\n",
+		       __func__, src_table, dst_table);
+		return ERR_PTR(-ENODEV);
+	}
+
+	mutex_lock(&src_table->lock);
+
+	list_for_each_entry(opp, &src_table->opp_list, node) {
+		if (opp == src_opp) {
+			dest_opp = opp->required_opps[i];
+			dev_pm_opp_get(dest_opp);
+			goto unlock;
+		}
+	}
+
+	pr_err("%s: Couldn't find matching OPP (%p: %p)\n", __func__, src_table,
+	       dst_table);
+
+unlock:
+	mutex_unlock(&src_table->lock);
+
+	return dest_opp;
+}
+
 /**
  * dev_pm_opp_xlate_performance_state() - Find required OPP's pstate for src_table.
  * @src_table: OPP table which has dst_table as one of its required OPP table.
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index ab1d15ce559db..c0371efa4a0f2 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -156,6 +156,7 @@ struct opp_table *devm_pm_opp_register_set_opp_helper(struct device *dev, int (*
 struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs);
 void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
 struct opp_table *devm_pm_opp_attach_genpd(struct device *dev, const char **names, struct device ***virt_devs);
+struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table, struct opp_table *dst_table, struct dev_pm_opp *src_opp);
 int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
 int dev_pm_opp_set_opp(struct device *dev, struct dev_pm_opp *opp);
@@ -367,6 +368,12 @@ static inline struct opp_table *devm_pm_opp_attach_genpd(struct device *dev,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table,
+				struct opp_table *dst_table, struct dev_pm_opp *src_opp)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate)
 {
 	return -EOPNOTSUPP;
-- 
2.30.0.365.g02bc693789-goog

