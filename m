Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DA43F6C0E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 01:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbhHXXH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 19:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbhHXXH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 19:07:27 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883F4C061757;
        Tue, 24 Aug 2021 16:06:42 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id f5so33516973wrm.13;
        Tue, 24 Aug 2021 16:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OoN9j7V42I1ib2rD7x6CdjLS7PodaYT54taKk3BzX5Y=;
        b=rnX9gRPOU/6hmcIDVFhSxv5iJhqOBnXvlZ69RXFrcx/X5YTbwm7+f60VRSizP4zs1V
         WJJpaicKA8JpZ3pXNfcFlzSaPLP3D+0Iv6WB1JDdOSwUXi1F8q79j8WDVvyTtRMXMlat
         X4j62MU1mzNYJ7iAP3MTv1oQGkyXjobgQm0jL2jlmgYtt4WFoN/5rwbzww1CPFDRJtIP
         DuOIBCY2StjULS4OyQzxlpxzQ8MZGb/RBK8QkpsMd2t1SryZ+BkbyEltFbBDUNuAoXbm
         QY/P/iQZdLXdc4gnKGg+LeBwocfwXGgDTKAWC3B2Nrn0a/oNucV65wh48PBDEbc6IVAz
         P5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OoN9j7V42I1ib2rD7x6CdjLS7PodaYT54taKk3BzX5Y=;
        b=Z88hPVTX+Sq/pxDNYn/0P1Xi3TSSU5HG5sYQe6T7r/cpto5D70GuiwOHtcokcFdUIt
         UZTNCPGr9QjN8WIBmqPF283BDWMt6Ykw30R15or21siSYyMcw81HoDL/nK+aobYPyeeJ
         ydy7a1FVtzzNKnd+gx7Y/AnMgyFFjceT/a2LA6odSMag12nMSemo4nCAoJsa0aoqN0rF
         OtPhYnTAfEtSDpjxcJ4IylJL7YjqsQcV9JZINjgCQdr+6vSlS9X0QkPzYaY4GhBOrghj
         RUYvk2zmvjAD7vw+nFeDHCtIkEmS7EY5Iq7s3e/UFb0GA8+yAXYfZLu4/px19QLQAhRE
         SrVg==
X-Gm-Message-State: AOAM533bLoV6G+IFuDV+MXXJS+SJSa6FPwRxGQP5auasox3GPUl9IJeu
        06+rH+IW/tZMfRDFOncPFPaF6pUYYQM=
X-Google-Smtp-Source: ABdhPJxvat4MW/z0z+eNhao1qXJeiBWsmljhvv7oV0sVQyscDs3YYr+6cxWS0EcD8WR0ymaLl3ZK+g==
X-Received: by 2002:a5d:6107:: with SMTP id v7mr21893655wrt.408.1629846401151;
        Tue, 24 Aug 2021 16:06:41 -0700 (PDT)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id q10sm3477868wmq.12.2021.08.24.16.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 16:06:40 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [RFC PATCH v2 1/3] regulator: core: Add regulator_lookup_list
Date:   Wed, 25 Aug 2021 00:06:18 +0100
Message-Id: <20210824230620.1003828-2-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824230620.1003828-1-djrscally@gmail.com>
References: <20210824230620.1003828-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some situations regulator devices can be enumerated via either
devicetree or ACPI and bound to regulator drivers but without any
init data being provided in firmware. This leaves their consumers
unable to acquire them via regulator_get().

To fix the issue, add the ability to register a lookup table to a
list within regulator core, which will allow board files to provide
init data via matching against the regulator name and device name in
the same fashion as the gpiod lookup table.

Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v2:
	- Patch introduced

 drivers/regulator/core.c          | 119 +++++++++++++++++++++++++++++-
 include/linux/regulator/machine.h |  23 ++++++
 2 files changed, 141 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index ca6caba8a191..6a6c1f34d9d6 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -36,6 +36,8 @@
 static DEFINE_WW_CLASS(regulator_ww_class);
 static DEFINE_MUTEX(regulator_nesting_mutex);
 static DEFINE_MUTEX(regulator_list_mutex);
+static DEFINE_MUTEX(regulator_lookup_mutex);
+static LIST_HEAD(regulator_lookup_list);
 static LIST_HEAD(regulator_map_list);
 static LIST_HEAD(regulator_ena_gpio_list);
 static LIST_HEAD(regulator_supply_alias_list);
@@ -1868,6 +1870,7 @@ static struct regulator_dev *regulator_lookup_by_name(const char *name)
 static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 						  const char *supply)
 {
+	struct regulator_lookup *lookup;
 	struct regulator_dev *r = NULL;
 	struct device_node *node;
 	struct regulator_map *map;
@@ -1917,7 +1920,34 @@ static struct regulator_dev *regulator_dev_lookup(struct device *dev,
 	if (r)
 		return r;
 
-	return ERR_PTR(-ENODEV);
+	/*
+	 * The regulator might still exist and be called out in a lookup table,
+	 * but simply not yet have probed. Check to see if the consumer device
+	 * is referenced in any init data in the lookups.
+	 */
+
+	mutex_lock(&regulator_lookup_mutex);
+	list_for_each_entry(lookup, &regulator_lookup_list, list) {
+		struct regulator_init_data *init_data = &lookup->init_data;
+		unsigned int i;
+
+		if (!devname)
+			break;
+
+		for (i = 0; i < init_data->num_consumer_supplies; i++) {
+			if (strcmp(init_data->consumer_supplies[i].dev_name, devname))
+				continue;
+
+			r = ERR_PTR(-EPROBE_DEFER);
+			goto out;
+		}
+	}
+
+	r = ERR_PTR(-ENODEV);
+
+out:
+	mutex_unlock(&regulator_lookup_mutex);
+	return r;
 }
 
 static int regulator_resolve_supply(struct regulator_dev *rdev)
@@ -5302,6 +5332,54 @@ static struct regulator_coupler generic_regulator_coupler = {
 	.attach_regulator = generic_coupler_attach,
 };
 
+/**
+ * regulator_lookup_init_data - Check regulator_lookup_list for matching entries
+ * @desc:	Regulator desc containing name of the regulator
+ * @cfg:	Regulator config containing pointer to the registering device
+ *
+ * Calling this function scans the regulator_lookup_list and checks each entry
+ * to see if the .device_name and .regulator_name fields match the device name
+ * and regulator name contained in @cfg and @desc. If so, a pointer to the
+ * embedded &struct regulator_init_data is returned. No matches returns NULL.
+ */
+struct regulator_init_data *
+regulator_lookup_init_data(const struct regulator_desc *desc,
+			   const struct regulator_config *cfg)
+{
+	struct regulator_lookup *lookup;
+
+	if (!desc || !cfg || !cfg->dev)
+		return NULL;
+
+	mutex_lock(&regulator_lookup_mutex);
+
+	list_for_each_entry(lookup, &regulator_lookup_list, list) {
+		/*
+		 * We need the lookup to have at least a device_name or there's
+		 * no guarantee of a match, and regulator_register() checks to
+		 * make sure that desc->name is not null, so any entry with
+		 * either field null is invalid.
+		 */
+		if (!lookup->device_name || !lookup->regulator_name)
+			continue;
+
+		if (strcmp(lookup->device_name, dev_name(cfg->dev)))
+			continue;
+
+		if (strcmp(lookup->regulator_name, desc->name))
+			continue;
+
+		goto found;
+	}
+
+	lookup = NULL;
+
+found:
+	mutex_unlock(&regulator_lookup_mutex);
+
+	return lookup ? &lookup->init_data : NULL;
+}
+
 /**
  * regulator_register - register regulator
  * @regulator_desc: regulator to register
@@ -5386,6 +5464,9 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	init_data = regulator_of_get_init_data(dev, regulator_desc, config,
 					       &rdev->dev.of_node);
 
+	if (!init_data)
+		init_data = regulator_lookup_init_data(regulator_desc, config);
+
 	/*
 	 * Sometimes not all resources are probed already so we need to take
 	 * that into account. This happens most the time if the ena_gpiod comes
@@ -5740,6 +5821,42 @@ void *regulator_get_init_drvdata(struct regulator_init_data *reg_init_data)
 }
 EXPORT_SYMBOL_GPL(regulator_get_init_drvdata);
 
+/**
+ * regulator_add_lookup - Add an entry to regulator_lookup_list
+ * @lookup:	Pointer to the &struct regulator_lookup to add to the list
+ *
+ * This function can be used in board files to add an entry to the
+ * regulator_lookup_list. During regulator_register(), entries will be checked
+ * for matching device name and regulator name and when matching, the associated
+ * &struct regulator_init_data will be used.
+ */
+void regulator_add_lookup(struct regulator_lookup *lookup)
+{
+	mutex_lock(&regulator_lookup_mutex);
+
+	list_add_tail(&lookup->list, &regulator_lookup_list);
+
+	mutex_unlock(&regulator_lookup_mutex);
+}
+EXPORT_SYMBOL_GPL(regulator_add_lookup);
+
+/**
+ * regulator_remove_lookup - Remove an entry from regulator_lookup_list
+ * @lookup:	Pointer to the &struct regulator_lookup to remove from the list
+ *
+ * Calling this function will remove the passed regulator_lookup from the list,
+ * intended for error handling paths in board files.
+ */
+void regulator_remove_lookup(struct regulator_lookup *lookup)
+{
+	mutex_lock(&regulator_lookup_mutex);
+
+	list_del(&lookup->list);
+
+	mutex_unlock(&regulator_lookup_mutex);
+}
+EXPORT_SYMBOL_GPL(regulator_remove_lookup);
+
 #ifdef CONFIG_DEBUG_FS
 static int supply_map_show(struct seq_file *sf, void *data)
 {
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index 68b4a514a410..d1b62a3962d8 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -12,6 +12,7 @@
 #ifndef __LINUX_REGULATOR_MACHINE_H_
 #define __LINUX_REGULATOR_MACHINE_H_
 
+#include <linux/list.h>
 #include <linux/regulator/consumer.h>
 #include <linux/suspend.h>
 
@@ -272,12 +273,34 @@ struct regulator_init_data {
 	void *driver_data;	/* core does not touch this */
 };
 
+/**
+ * struct regulator_lookup - lookup table entry for regulator_init_data
+ *
+ * @device_name:	The name of the device from regulator_config.dev
+ * @regulator_name:	The name of the regulator from the &struct regulator_desc
+ *			to match to during regulator_register()
+ * @init_data:		An instance of &struct regulator_init_data that you
+ *			wish to pass to the regulator during regulator_register()
+ */
+struct regulator_lookup {
+	const char *device_name;
+	const char *regulator_name;
+
+	struct regulator_init_data init_data;
+
+	struct list_head list;
+};
+
 #ifdef CONFIG_REGULATOR
 void regulator_has_full_constraints(void);
+void regulator_add_lookup(struct regulator_lookup *lookup);
+void regulator_remove_lookup(struct regulator_lookup *lookup);
 #else
 static inline void regulator_has_full_constraints(void)
 {
 }
+static inline void regulator_add_lookup(struct regulator_lookup *lookup) { }
+static inline void regulator_remove_lookup(struct regulator_lookup *lookup) { }
 #endif
 
 static inline int regulator_suspend_prepare(suspend_state_t state)
-- 
2.25.1

