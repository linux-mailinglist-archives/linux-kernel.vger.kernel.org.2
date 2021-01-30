Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9B030932A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 10:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhA3JTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 04:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbhA3ELp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 23:11:45 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB71BC0612F2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 20:03:54 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id o20so7495037qtx.22
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 20:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=4iKxcFBXBkWGs5c3P81HiiCFsaWkBZUMGabcbl/Zmwk=;
        b=bFVJ0OrMqrzYYHzGIWowtuZrCS08F+jYOlByI4LGMbxbYb63rHliIR9SQK2V58GWin
         tBPYL7uIXAxR1gF+IW2Be33oGEQe7yfM9U5nonOPof/dPMp3Scg8/5qPu8pyM9R5jS5t
         KNeqocAUp5GtllDg+HiHd4ViWtIO6ZhuYxQ+iOvfhoOqeiy0zpn+Oz22QdhFRIC449Sb
         AD7nEw6+PZ1yivOgwgEtbz4MSKZwdJuPgzH37BD3NEZGoXTFsqEuzDriNZ0HB+VG7El+
         kP3bKppWyoLwqVmpxOATa6wo2M3AB4ghLzt672i8lkLHzIwx3U0ibYpdHHDlDolpW54q
         i/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4iKxcFBXBkWGs5c3P81HiiCFsaWkBZUMGabcbl/Zmwk=;
        b=gltoCUzIWkoECrio8WqPAIdmhSJFyDmByMj8lppLTSA6e0xQ1ZCfVcOvCNIJ8SRVn0
         oScmra2lBQNYSGgCHPvbxZ+9bBrJcqv74Z9u7atHMU+p0bjq3XHeQNgojmmSmnQZFJr4
         gR+pLiqNHAnRMfJrFonlwKAPm44bxABJWONULn5U5jzrHDViOm2jxgnKAJo3BmxlyZrB
         FoXf2U28QzTEzPC52IlNGQJTxz5DYwwZetutk5FsJh2XlYng0X4QKUqmc3bobfs8Qqjz
         bI9yQTH9P4gik9ERUxy30GL5iRrWCV7hvRQHLRCFPgQwH/sBNG8FWiGmd1PK9I81G2eM
         4OjQ==
X-Gm-Message-State: AOAM533253bbJKfciTFD2z/JF1DTP6RHUBwJClUBzvJ9ID5tlChZG8B3
        RwvkpkzlRxy1dUBdMAO30vdTS44p2yD+sFQ=
X-Google-Smtp-Source: ABdhPJy5i8p4LxdcfVWKufKZU9ouVxbhv9934vTZetjLn3/OsjQu77BLr7TLIRswcCHbbW3SFBPvrBxF3mLHpCE=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a0c:c687:: with SMTP id
 d7mr6778790qvj.17.1611979434051; Fri, 29 Jan 2021 20:03:54 -0800 (PST)
Date:   Fri, 29 Jan 2021 20:03:44 -0800
In-Reply-To: <20210130040344.2807439-1-saravanak@google.com>
Message-Id: <20210130040344.2807439-3-saravanak@google.com>
Mime-Version: 1.0
References: <20210130040344.2807439-1-saravanak@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v1 2/2] driver core: fw_devlink: Handle missing drivers for
 optional suppliers
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <maz@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a deferred probe attempt has exhaused all the devices that can be
bound, any device that remains unbound has one/both of these conditions
true:

(1) It is waiting on its supplier to bind
(2) It does not have a matching driver

So, to make fw_devlink=on more forgiving of missing drivers for optional
suppliers, after we've done a full deferred probe attempt, this patch
deletes all device links created by fw_devlink where the supplier hasn't
probed yet and the supplier itself is not waiting on any of its
suppliers. This allows consumers to probe during another deferred probe
attempt if they were waiting on optional suppliers.

When modules are enabled, we can't differentiate between a driver
that'll never be registered vs a driver that'll be registered soon by
loading a module. So, this patch doesn't do anything for the case where
modules are enabled.

Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/base.h |   2 +
 drivers/base/core.c | 104 ++++++++++++++++++++++++++++++++++++--------
 drivers/base/dd.c   |   5 +++
 3 files changed, 94 insertions(+), 17 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index f5600a83124f..34befe9475cb 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -186,6 +186,8 @@ extern void device_links_no_driver(struct device *dev);
 extern bool device_links_busy(struct device *dev);
 extern void device_links_unbind_consumers(struct device *dev);
 
+bool fw_devlink_deferred_probe_retry(void);
+
 /* device pm support */
 void device_pm_move_to_tail(struct device *dev);
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index f380133df63b..512771dd71df 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -50,6 +50,7 @@ static LIST_HEAD(deferred_sync);
 static unsigned int defer_sync_state_count = 1;
 static DEFINE_MUTEX(fwnode_link_lock);
 static bool fw_devlink_is_permissive(void);
+static bool fw_devlink_def_probe_retry;
 
 /**
  * fwnode_link_add - Create a link between two fwnode_handles.
@@ -880,6 +881,13 @@ static void device_link_put_kref(struct device_link *link)
 		WARN(1, "Unable to drop a managed device link reference\n");
 }
 
+static void device_link_drop_managed(struct device_link *link)
+{
+	link->flags &= ~DL_FLAG_MANAGED;
+	WRITE_ONCE(link->status, DL_STATE_NONE);
+	kref_put(&link->kref, __device_link_del);
+}
+
 /**
  * device_link_del - Delete a stateless link between two devices.
  * @link: Device link to delete.
@@ -942,6 +950,29 @@ static void device_links_missing_supplier(struct device *dev)
 	}
 }
 
+/**
+ * device_links_probe_blocked_by - Return first supplier blocking probe
+ * @dev: Consumer device.
+ *
+ * Checks if the probe of @dev is blocked by a supplier without a driver. If
+ * yes, return that supplier dev. Otherwise, return NULL.
+ */
+static struct device *device_links_probe_blocked_by(struct device *dev)
+{
+	struct device_link *link;
+
+	list_for_each_entry(link, &dev->links.suppliers, c_node) {
+		if (!(link->flags & DL_FLAG_MANAGED) ||
+		    link->flags & DL_FLAG_SYNC_STATE_ONLY)
+			continue;
+
+		if (link->status != DL_STATE_AVAILABLE)
+			return link->supplier;
+	}
+
+	return NULL;
+}
+
 /**
  * device_links_check_suppliers - Check presence of supplier drivers.
  * @dev: Consumer device.
@@ -960,7 +991,7 @@ static void device_links_missing_supplier(struct device *dev)
  */
 int device_links_check_suppliers(struct device *dev)
 {
-	struct device_link *link;
+	struct device_link *link, *tmp;
 	int ret = 0;
 
 	/*
@@ -981,19 +1012,47 @@ int device_links_check_suppliers(struct device *dev)
 
 	device_links_write_lock();
 
-	list_for_each_entry(link, &dev->links.suppliers, c_node) {
+	list_for_each_entry_safe(link, tmp, &dev->links.suppliers, c_node) {
 		if (!(link->flags & DL_FLAG_MANAGED))
 			continue;
 
-		if (link->status != DL_STATE_AVAILABLE &&
-		    !(link->flags & DL_FLAG_SYNC_STATE_ONLY)) {
-			device_links_missing_supplier(dev);
-			dev_dbg(dev, "probe deferral - supplier %s not ready\n",
-				dev_name(link->supplier));
-			ret = -EPROBE_DEFER;
-			break;
+
+		if (link->status == DL_STATE_AVAILABLE ||
+		    link->flags & DL_FLAG_SYNC_STATE_ONLY) {
+			WRITE_ONCE(link->status, DL_STATE_CONSUMER_PROBE);
+			continue;
+		}
+
+		/*
+		 * After a deferred probe attempt has exhaused all the devices
+		 * that can be bound, any device that remains unbound has
+		 * one/both of these conditions true:
+		 *
+		 * (1) It is waiting on its supplier to bind
+		 * (2) It does not have a matching driver
+		 *
+		 * If this device is waiting on a supplier to bind to a driver,
+		 * we make sure condition (1) above is not true for the
+		 * supplier. In which case, condition (2) has to be true for
+		 * the supplier. That is, the supplier doesn't have a matching
+		 * driver.
+		 *
+		 * When we find such a supplier, we delete the device link if
+		 * it was created by fw_devlink. This it to allow the consumer
+		 * to probe in case the supplier is an optional.
+		 */
+		if (fw_devlink_def_probe_retry &&
+		    link->flags & DL_FLAG_INFERRED &&
+		    !device_links_probe_blocked_by(link->supplier)) {
+			device_link_drop_managed(link);
+			continue;
 		}
-		WRITE_ONCE(link->status, DL_STATE_CONSUMER_PROBE);
+
+		device_links_missing_supplier(dev);
+		dev_dbg(dev, "probe deferral - supplier %s not ready\n",
+			dev_name(link->supplier));
+		ret = -EPROBE_DEFER;
+		break;
 	}
 	dev->links.status = DL_DEV_PROBING;
 
@@ -1131,13 +1190,6 @@ static void __device_links_supplier_defer_sync(struct device *sup)
 		list_add_tail(&sup->links.defer_sync, &deferred_sync);
 }
 
-static void device_link_drop_managed(struct device_link *link)
-{
-	link->flags &= ~DL_FLAG_MANAGED;
-	WRITE_ONCE(link->status, DL_STATE_NONE);
-	kref_put(&link->kref, __device_link_del);
-}
-
 static ssize_t waiting_for_supplier_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
@@ -1596,6 +1648,24 @@ static int fw_devlink_relax_cycle(struct device *con, void *sup)
 	return ret;
 }
 
+/** fw_devlink_deferred_probe_retry - Set up fw_devlink for probe retries
+ *
+ * This function requests fw_devlink to set itself up for a deferred probe
+ * retry. This allows fw_devlink to ignore device links it created to
+ * suppliers that'll never probe. This is necessary in case some of the
+ * suppliers are optional and their consumers can probe without them.
+ *
+ * Returns true if deferred probe retry is likely to make any difference.
+ */
+bool fw_devlink_deferred_probe_retry(void)
+{
+	if (IS_ENABLED(CONFIG_MODULES))
+		return false;
+
+	fw_devlink_def_probe_retry = true;
+	return fw_devlink_get_flags() && !fw_devlink_is_permissive();
+}
+
 /**
  * fw_devlink_create_devlink - Create a device link from a consumer to fwnode
  * @con - Consumer device for the device link
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9179825ff646..11325df2327f 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -317,6 +317,11 @@ static int deferred_probe_initcall(void)
 	driver_deferred_probe_trigger();
 	/* Sort as many dependencies as possible before exiting initcalls */
 	flush_work(&deferred_probe_work);
+
+	if (fw_devlink_deferred_probe_retry()) {
+		driver_deferred_probe_trigger();
+		flush_work(&deferred_probe_work);
+	}
 	initcalls_done = true;
 
 	/*
-- 
2.30.0.365.g02bc693789-goog

