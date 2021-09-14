Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207F540A582
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 06:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbhINElQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 00:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239378AbhINElG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 00:41:06 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C601AC061768
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 21:39:48 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id o7-20020a05622a138700b002a0e807258bso58618150qtk.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 21:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=H+rC59RayigOxvpZNoaFgRLZoDhDE0BNr88WtfiKSKY=;
        b=X18KRIXHh/WDtH6DS5CBEvLPUqw/CDDj8C+BJAVgJKiD4EI5DE/FTtsWeA4t8N89qq
         7QouL4AcCXpqM8iemGYqDPTKiCjwBC5Ngyt8UnhMYX6FnZWUVfdXKACFhyN55qozYhTa
         FfrzaAoiSzpQ+r8ytsUSdE+p4Sd4M4Iu7DckWV9Dsumuikx2BorcACkHn0J86fiTReYo
         jgB5lmcWq03B45ZGupbGPAb57+0GBheGaLEC/E3lTdbENp6Ur0Teu81JjAruad/bky4g
         m3q5d3pgqnHwtTNvnNg/9h/JrVA2dKg07ikcmJL2+QpK2VgVpeMrIh3ALpPC6HrV6WwI
         EczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=H+rC59RayigOxvpZNoaFgRLZoDhDE0BNr88WtfiKSKY=;
        b=3d3Hu8kNGokvQlZyD/o8G7STD9kcuGzYeI0YCZjo4CI+EWxedL/qXMenFosXxofHbe
         iJa5UhMmDFM4igEcVx5agBCMNGBBnlM46VCIL4G24bY66SjdJTRhI3hhiGpr9QpB72VJ
         EuY9lTrW5GY2VBJ3dg068ebWts+ypFyHMxHn5EgysB8P7nEHUzIO8eSWwmg/6khcsPpQ
         YjxnRFbzkE4aphla8vFryhdexGsVgE/giDSI2gyR11KhhKyo5grYh3dLk6cbJjeHUKiU
         R0heofuPlMyMj+gn/ljw1/YSXLc31iDqchSNq6lxo+QpyVLJgEZIA8KvYmA0sDElGWsB
         8/9w==
X-Gm-Message-State: AOAM531dx+BjkTX7Y9ZHJ0Hjr/VblMdRyjXjaLe0kVJ3UGsg920yBTsk
        Qn104ANpY9ej3P3E2gMWUORd4wjAtildXhs=
X-Google-Smtp-Source: ABdhPJx+KhlTNu8PP1aLks29+Y0QTXiGB9CS4k985iHJeYfhmi2vx9K57hbFX1VI2HbssQHA+9gXCmLLN3qfzgg=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:48b:108c:f6a1:56f3])
 (user=saravanak job=sendgmr) by 2002:a05:6214:13e9:: with SMTP id
 ch9mr3415080qvb.45.1631594388038; Mon, 13 Sep 2021 21:39:48 -0700 (PDT)
Date:   Mon, 13 Sep 2021 21:39:27 -0700
In-Reply-To: <20210914043928.4066136-1-saravanak@google.com>
Message-Id: <20210914043928.4066136-6-saravanak@google.com>
Mime-Version: 1.0
References: <20210914043928.4066136-1-saravanak@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v1 5/5] driver core: Add fw_devlink.debug command line boolean parameter
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the parameter is set, it enables all the debug logs that would be
useful for debugging fw_devlink issues.

I'll add the documentation if we agree that we should add this param.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/base.h |  9 +++++++++
 drivers/base/core.c | 34 ++++++++++++++++++++++++++--------
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 2882af26392a..e0744c08ccbe 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -191,6 +191,15 @@ extern void device_links_no_driver(struct device *dev);
 extern bool device_links_busy(struct device *dev);
 extern void device_links_unbind_consumers(struct device *dev);
 extern void fw_devlink_drivers_done(void);
+extern bool fw_devlink_debug;
+
+#define fw_devlink_dbg(dev, fmt, ...)				\
+do {								\
+	if (fw_devlink_debug)					\
+		dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__);	\
+	else							\
+		dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__);	\
+} while (0)
 
 /* device pm support */
 void device_pm_move_to_tail(struct device *dev);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index b10c425f4b89..d3be785820ca 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -95,8 +95,12 @@ int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)
 
 	list_add(&link->s_hook, &sup->consumers);
 	list_add(&link->c_hook, &con->suppliers);
-	pr_debug("%pfwP Linked as a fwnode consumer to %pfwP\n",
-		 con, sup);
+	if (fw_devlink_debug)
+		pr_info("%pfwP Linked as a fwnode consumer to %pfwP\n",
+			con, sup);
+	else
+		pr_debug("%pfwP Linked as a fwnode consumer to %pfwP\n",
+			 con, sup);
 out:
 	mutex_unlock(&fwnode_link_lock);
 
@@ -111,8 +115,12 @@ int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)
  */
 static void __fwnode_link_del(struct fwnode_link *link)
 {
-	pr_debug("%pfwP Dropping the fwnode link to %pfwP\n",
-		 link->consumer, link->supplier);
+	if (fw_devlink_debug)
+		pr_info("%pfwP Dropping the fwnode link to %pfwP\n",
+			link->consumer, link->supplier);
+	else
+		pr_debug("%pfwP Dropping the fwnode link to %pfwP\n",
+			 link->consumer, link->supplier);
 	list_del(&link->s_hook);
 	list_del(&link->c_hook);
 	kfree(link);
@@ -852,7 +860,7 @@ struct device_link *device_link_add(struct device *consumer,
 	list_add_tail_rcu(&link->c_node, &consumer->links.suppliers);
 
 	if (flags & DL_FLAG_SYNC_STATE_ONLY) {
-		dev_dbg(consumer,
+		fw_devlink_dbg(consumer,
 			"Linked as a sync state only consumer to %s\n",
 			dev_name(supplier));
 		goto out;
@@ -868,7 +876,8 @@ struct device_link *device_link_add(struct device *consumer,
 	 */
 	device_reorder_to_tail(consumer, NULL);
 
-	dev_dbg(consumer, "Linked as a consumer to %s\n", dev_name(supplier));
+	fw_devlink_dbg(consumer, "Linked as a consumer to %s\n",
+		       dev_name(supplier));
 
 out:
 	device_pm_unlock();
@@ -1021,7 +1030,8 @@ int device_links_check_suppliers(struct device *dev)
 		sup_fw = list_first_entry(&dev->fwnode->suppliers,
 					  struct fwnode_link,
 					  c_hook)->supplier;
-		dev_dbg(dev, "probe deferral - wait for supplier %pfwP\n",
+		fw_devlink_dbg(dev,
+			"probe deferral - wait for supplier %pfwP\n",
 			sup_fw);
 		dev_set_def_probe_reason(dev,
 			"wait for supplier %pfwP\n", sup_fw);
@@ -1039,7 +1049,8 @@ int device_links_check_suppliers(struct device *dev)
 		if (link->status != DL_STATE_AVAILABLE &&
 		    !(link->flags & DL_FLAG_SYNC_STATE_ONLY)) {
 			device_links_missing_supplier(dev);
-			dev_dbg(dev, "probe deferral - supplier %s not ready\n",
+			fw_devlink_dbg(dev,
+				"probe deferral - supplier %s not ready\n",
 				dev_name(link->supplier));
 			dev_set_def_probe_reason(dev,
 				"supplier %s not ready\n",
@@ -1616,6 +1627,13 @@ static int __init fw_devlink_strict_setup(char *arg)
 }
 early_param("fw_devlink.strict", fw_devlink_strict_setup);
 
+bool fw_devlink_debug;
+static int __init fw_devlink_debug_setup(char *arg)
+{
+	return strtobool(arg, &fw_devlink_debug);
+}
+early_param("fw_devlink.debug", fw_devlink_debug_setup);
+
 u32 fw_devlink_get_flags(void)
 {
 	return fw_devlink_flags;
-- 
2.33.0.309.g3052b89438-goog

