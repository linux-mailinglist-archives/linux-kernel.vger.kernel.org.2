Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDF844B920
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 23:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbhKIXAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 18:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238350AbhKIXAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 18:00:35 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946DDC053740
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 14:54:10 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id z2-20020a254c02000000b005b68ef4fe24so983404yba.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 14:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iO4x7NFyrLG2fuGsk/BQ7GrZY0sUEjPF799SsFw6K+0=;
        b=MXZk/E8hSDW/qboNC5IWgJVo35t6PgQTM1qDmTOKKCTkrmWRxyyvfXoE+xejQqPtcs
         PE90uj4QNuzrpmq1gvXb/mTxzzflV5xI0vHvG4Uvl1Kmvev7Q47EpVcOWhTVe8ehoT5H
         fd5j5+XmzsFYM2HThb2+ZpFa1/caqVGIlju8+mqayY6XCsXqC2YOON3aAhR66JqYzbP7
         GKyAGSDK4rFDaQMIddDXeuOpcf3+u1dJ2jyPkjnuVxhmSaxeDiltl669pLw89B3ls279
         Dyqzi8q6Oz5NglpUAmwdEvvL/zTjKWrelO68aW3AHoovD6EwVsNSJXVvi+PHj6t4Ckj4
         bNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iO4x7NFyrLG2fuGsk/BQ7GrZY0sUEjPF799SsFw6K+0=;
        b=Si0ZOrXU+FOpPkM8kGwRbxzrhbDvhLw8fnj6TT6Wbn4qU4eYd7COGFB2zc4jZ3lusu
         PfzgBqKVkNECV+NNiM0nd1AGnon1SDCz/Qe8xSxZxZh6x0wpnFIWyKsZsgBiY5fmw+Wb
         1zxb6XLU+xkT9oVEAxCPGoxJikyNmwRSgE348chJi2k7Vrrxhphorzwb80dpO2bSA9Nk
         AVAK90HopWI4hWDcZ3YFn/LdOAixruXYIR7z0zZKG68gJ1KnEmsv9ZEi6hkVlwSfcDEI
         OQ+yuFaopemen8NgJwrl1n63td+W1E+BgC1yELvC8ty/eg8w2vK3JEC6ZgiFdNPmsE6r
         ChIw==
X-Gm-Message-State: AOAM531s5zqt+pDaqZ874gXfAkrkxZFoa3uSLS+xeeMlXHx2KfovgWVB
        AsBmRozY5b7KYdTaZKBSXx+hBMNPn///2+HloOEzSE6/xn95EyTeuKZLIwcf322TY7c6fhXUHdm
        YXGVd0slyeKDw4/+Z/2kNdCYU/MnWTghVK7E6XuqSkMrXTDVQu43onsFU5RQ3DuiZ/he6pCMI
X-Google-Smtp-Source: ABdhPJxcUcn2yC2mcNyfZfpSgJbtRJdGVFlqXbZ4L+qNZWFOTb7G8L8dcEuYqUGMdqR9xRSt3XkaHcnZZZt9
X-Received: from suichen.svl.corp.google.com ([2620:15c:2c5:13:7559:12f5:de29:c918])
 (user=suichen job=sendgmr) by 2002:a25:d655:: with SMTP id
 n82mr11800474ybg.451.1636498449766; Tue, 09 Nov 2021 14:54:09 -0800 (PST)
Date:   Tue,  9 Nov 2021 14:53:20 -0800
In-Reply-To: <20211109225321.618688-1-suichen@google.com>
Message-Id: <20211109225321.618688-2-suichen@google.com>
Mime-Version: 1.0
References: <20211109225321.618688-1-suichen@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [RFC Patch Resend 1/2] i2c debug counters as sysfs attributes
From:   Sui Chen <suichen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sui Chen <suichen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds a few example I2C debug counters as sysfs attributes:
- ber_cnt (bus error count)
- nack_cnt (NACK count)
- rec_fail_cnt, rec_succ_cnt (recovery failure/success count)
- timeout_cnt (timeout count)
- i2c_speed (bus frequency)

The function i2c_adapter_create_stats_folder creates a stats directory
in the device's sysfs directory to hold the debug counters. The platform
drivers will instantiate the counters in the stats directory if
available.

Signed-off-by: Sui Chen <suichen@google.com>
---
 drivers/i2c/i2c-core-base.c |  2 +
 drivers/i2c/i2c-dev.c       | 98 +++++++++++++++++++++++++++++++++++++
 include/linux/i2c.h         | 26 ++++++++++
 3 files changed, 126 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 84f12bf90644a..c42113daf32a7 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1610,6 +1610,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	bus_for_each_drv(&i2c_bus_type, NULL, adap, __process_new_adapter);
 	mutex_unlock(&core_lock);
 
+	i2c_adapter_create_stats_folder(adap);
+
 	return 0;
 
 out_reg:
diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 77f576e516522..fbec54519bc04 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -767,6 +767,104 @@ static void __exit i2c_dev_exit(void)
 	unregister_chrdev_region(MKDEV(I2C_MAJOR, 0), I2C_MINORS);
 }
 
+
+static struct i2c_adapter* kobj_to_adapter(struct device* pdev) {
+	struct kobject* dev_kobj = ((struct kobject*)pdev)->parent;
+	struct device* dev = container_of(dev_kobj, struct device, kobj);
+	return to_i2c_adapter(dev);
+}
+
+static ssize_t ber_cnt_show(struct device* pdev,
+	struct device_attribute* attr, char* buf) {
+	u64* ber_cnt = kobj_to_adapter(pdev)->stats->ber_cnt;
+	if (ber_cnt == NULL) return 0;
+	ssize_t ret = sprintf(buf, "%llu\n", *ber_cnt);
+	return ret;
+}
+DEVICE_ATTR_RO(ber_cnt);
+
+ssize_t nack_cnt_show(struct device* pdev,
+	struct device_attribute* attr, char* buf) {
+	u64* nack_cnt = kobj_to_adapter(pdev)->stats->nack_cnt;
+	if (nack_cnt == NULL) return 0;
+	ssize_t ret = sprintf(buf, "%llu\n", *nack_cnt);
+	return ret;
+}
+DEVICE_ATTR_RO(nack_cnt);
+
+ssize_t rec_succ_cnt_show(struct device* pdev,
+	struct device_attribute* attr, char* buf) {
+	u64* rec_succ_cnt = kobj_to_adapter(pdev)->stats->rec_succ_cnt;
+	if (rec_succ_cnt == NULL) return 0;
+	ssize_t ret = sprintf(buf, "%llu\n", *rec_succ_cnt);
+	return ret;
+}
+DEVICE_ATTR_RO(rec_succ_cnt);
+
+ssize_t rec_fail_cnt_show(struct device* pdev,
+	struct device_attribute* attr, char* buf) {
+	u64* rec_fail_cnt = kobj_to_adapter(pdev)->stats->rec_fail_cnt;
+	if (rec_fail_cnt == NULL) return 0;
+	ssize_t ret = sprintf(buf, "%llu\n", *rec_fail_cnt);
+	return ret;
+}
+DEVICE_ATTR_RO(rec_fail_cnt);
+
+ssize_t timeout_cnt_show(struct device* pdev,
+	struct device_attribute* attr, char* buf) {
+	u64* timeout_cnt = kobj_to_adapter(pdev)->stats->timeout_cnt;
+	if (timeout_cnt == NULL) return 0;
+	ssize_t ret = sprintf(buf, "%llu\n", *timeout_cnt);
+	return ret;
+}
+DEVICE_ATTR_RO(timeout_cnt);
+
+ssize_t i2c_speed_show(struct device* pdev,
+	struct device_attribute* attr, char* buf) {
+	u64* i2c_speed = kobj_to_adapter(pdev)->stats->i2c_speed;
+	if (i2c_speed == NULL) return 0;
+	ssize_t ret = sprintf(buf, "%llu\n", *i2c_speed);
+	return ret;
+}
+DEVICE_ATTR_RO(i2c_speed);
+
+void i2c_adapter_create_stats_folder(struct i2c_adapter* adapter) {
+	adapter->stats = kzalloc(sizeof(struct i2c_adapter_stats), GFP_KERNEL);
+	adapter->stats->kobj = kobject_create_and_add("stats", &adapter->dev.kobj);;
+}
+
+void i2c_adapter_stats_register_counter(struct i2c_adapter* adapter,
+	const char* counter_name, void* data_source) {
+	int ret;
+	if (adapter->stats == NULL) {
+		i2c_adapter_create_stats_folder(adapter);
+	}
+
+	if (!strcmp(counter_name, "ber_cnt")) {
+		adapter->stats->ber_cnt = data_source;
+		ret = sysfs_create_file(adapter->stats->kobj, &dev_attr_ber_cnt.attr);
+	} else if (!strcmp(counter_name, "nack_cnt")) {
+		adapter->stats->nack_cnt = data_source;
+		ret = sysfs_create_file(adapter->stats->kobj, &dev_attr_nack_cnt.attr);
+	} else if (!strcmp(counter_name, "rec_succ_cnt")) {
+		adapter->stats->rec_succ_cnt = data_source;
+		ret = sysfs_create_file(adapter->stats->kobj, &dev_attr_rec_succ_cnt.attr);
+	} else if (!strcmp(counter_name, "rec_fail_cnt")) {
+		adapter->stats->rec_fail_cnt = data_source;
+		ret = sysfs_create_file(adapter->stats->kobj, &dev_attr_rec_fail_cnt.attr);
+	} else if (!strcmp(counter_name, "timeout_cnt")) {
+		adapter->stats->timeout_cnt = data_source;
+		ret = sysfs_create_file(adapter->stats->kobj, &dev_attr_timeout_cnt.attr);
+	} else if (!strcmp(counter_name, "i2c_speed")) {
+		adapter->stats->i2c_speed = data_source;
+		ret = sysfs_create_file(adapter->stats->kobj, &dev_attr_i2c_speed.attr);
+	}
+
+	if (ret) {
+		printk("Failed to create sysfs file for %s", counter_name);
+	}
+}
+
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C /dev entries driver");
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 3eb60a2e9e618..b5c84297c60d9 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -21,6 +21,7 @@
 #include <linux/of.h>		/* for struct device_node */
 #include <linux/swab.h>		/* for swab16 */
 #include <uapi/linux/i2c.h>
+#include <linux/slab.h> /* for kzalloc */
 
 extern struct bus_type i2c_bus_type;
 extern struct device_type i2c_adapter_type;
@@ -684,6 +685,26 @@ struct i2c_adapter_quirks {
 	u16 max_comb_2nd_msg_len;
 };
 
+/**
+ * I2C statistics
+ * The list of statistics are currently copied from npcm7xx.
+ * Perhaps a more universal set of statistics can be used.
+ *
+ * The stats are currently modeled as pointers to members in the bus drivers.
+ * A null pointer indicates the counter is not supported by the bus driver.
+ */
+struct i2c_adapter_stats {
+	struct kobject* kobj;
+
+	// For the counters a NULL value means the counter is not available.
+	u64* ber_cnt;
+	u64* nack_cnt;
+	u64* rec_succ_cnt;
+	u64* rec_fail_cnt;
+	u64* timeout_cnt;
+	u64* i2c_speed;
+};
+
 /* enforce max_num_msgs = 2 and use max_comb_*_len for length checks */
 #define I2C_AQ_COMB			BIT(0)
 /* first combined message must be write */
@@ -735,12 +756,17 @@ struct i2c_adapter {
 
 	struct i2c_bus_recovery_info *bus_recovery_info;
 	const struct i2c_adapter_quirks *quirks;
+	struct i2c_adapter_stats* stats;
 
 	struct irq_domain *host_notify_domain;
 	struct regulator *bus_regulator;
 };
 #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
 
+void i2c_adapter_create_stats_folder(struct i2c_adapter* adapter);
+void i2c_adapter_stats_register_counter(struct i2c_adapter* adapter,
+	const char* counter_name, void* data_source);
+
 static inline void *i2c_get_adapdata(const struct i2c_adapter *adap)
 {
 	return dev_get_drvdata(&adap->dev);
-- 
2.34.0.rc0.344.g81b53c2807-goog

