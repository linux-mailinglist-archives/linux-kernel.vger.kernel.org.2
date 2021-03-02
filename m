Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1CB32AE18
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360515AbhCBWV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383594AbhCBVRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 16:17:00 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2FBC061797
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 13:11:44 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a63so24065262yba.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 13:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=bb06rucpely5yW30WUY4CrrQt38vQ0aV0zDKkwTD8/8=;
        b=ta3vio6vckCy8usZMNP/oSCED7HFMRKu14VEnPuJzFZx10YFZuqHyQbfx/DTNqGepJ
         lBoKtjyyIu8hs3LfsddcQhQPZOmit+Bb5swEMxhdquY8EH/oFHjNM3a3spdlquDwGMbs
         qJCh8CPv7CWEYc+1kQSlTukAnVMcR6Jqf88BLQqiO0dHzJIdngAhn2ZD91z6KpA8n023
         v+raqioOa0bcDX2coeZ1YxKIYgqpyEha10s6q2G1tfu5ZgABSlgD6vuWV1SNKCMEuu5+
         68FDbclPQZkyUGW0Pc7e9RkxlFhwG2rzdbjfYX5GgkePe9UBLj66QGnqGoPYQibvcUMu
         +5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bb06rucpely5yW30WUY4CrrQt38vQ0aV0zDKkwTD8/8=;
        b=Fd1BzB41Ga9vK7KQhsfGRsJ0Jrgoohj/Mf+0VvIzTrhkdM4Ro6CU4Yj783VuTIN+VJ
         VoEtCxfR256CgF8xoVeJPJ8LLCly+3qT4BS2BuD1vfVP9JQrGBPqJjX36zd2jMJ+JlE/
         55O2bpOibawlSljuoQaDPkaFhRMgRuKv3gXIgiH5NioGJimpxc+ZzIGkJ9A/lWDuvagP
         veRftq3TU9nlQuanRk9igb5d/DVYg5DYM8Bf2z9RGX3ebB6Kh5Tw3H72rFQvN9uGlFk9
         S/I3YB0i1QC+ZFPKqj0tDxnPcfYnfe27ikoxZaXcz2Wmrhdefe/W9wH4egCIuzeyXfmF
         NFeQ==
X-Gm-Message-State: AOAM533+HQom77VWAhVpayZMwgGWJFerCAZrQbQUf4hRvHAisfdgv70X
        rZ+ve/VFsHY58B0JwV1f1iRYXgQ4h1pVVTs=
X-Google-Smtp-Source: ABdhPJwy8Cvxbp0Pt1ShiBQOEjv9X37hC4QysFyc+CjEQ8Ydl8Jq+SSVnO/g29jKzcF1aESQNUnIsBe3LEDIzj8=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:a1ad:fce1:8a40:59b6])
 (user=saravanak job=sendgmr) by 2002:a25:1043:: with SMTP id
 64mr33913158ybq.141.1614719503619; Tue, 02 Mar 2021 13:11:43 -0800 (PST)
Date:   Tue,  2 Mar 2021 13:11:31 -0800
In-Reply-To: <20210302211133.2244281-1-saravanak@google.com>
Message-Id: <20210302211133.2244281-3-saravanak@google.com>
Mime-Version: 1.0
References: <20210302211133.2244281-1-saravanak@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v1 2/3] driver core: Update device link status properly for device_bind_driver()
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Michael Walle <michael@walle.cc>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device link status was not getting updated correctly when
device_bind_driver() is called on a device. This causes a warning[1].
Fix this by updating device links that can be updated and dropping
device links that can't be updated to a sensible state.

[1] - https://lore.kernel.org/lkml/56f7d032-ba5a-a8c7-23de-2969d98c527e@nvidia.com/
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/base.h |  1 +
 drivers/base/core.c | 35 +++++++++++++++++++++++++++++++++++
 drivers/base/dd.c   |  4 +++-
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 52b3d7b75c27..1b44ed588f66 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -185,6 +185,7 @@ extern int device_links_read_lock(void);
 extern void device_links_read_unlock(int idx);
 extern int device_links_read_lock_held(void);
 extern int device_links_check_suppliers(struct device *dev);
+extern void device_links_force_bind(struct device *dev);
 extern void device_links_driver_bound(struct device *dev);
 extern void device_links_driver_cleanup(struct device *dev);
 extern void device_links_no_driver(struct device *dev);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index f29839382f81..45c75cc96fdc 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1153,6 +1153,41 @@ static ssize_t waiting_for_supplier_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(waiting_for_supplier);
 
+/**
+ * device_links_force_bind - Prepares device to be force bound
+ * @dev: Consumer device.
+ *
+ * device_bind_driver() force binds a device to a driver without calling any
+ * driver probe functions. So the consumer really isn't going to wait for any
+ * supplier before it's bound to the driver. We still want the device link
+ * states to be sensible when this happens.
+ *
+ * In preparation for device_bind_driver(), this function goes through each
+ * supplier device links and checks if the supplier is bound. If it is, then
+ * the device link status is set to CONSUMER_PROBE. Otherwise, the device link
+ * is dropped. Links without the DL_FLAG_MANAGED flag set are ignored.
+ */
+void device_links_force_bind(struct device *dev)
+{
+	struct device_link *link, *ln;
+
+	device_links_write_lock();
+
+	list_for_each_entry_safe(link, ln, &dev->links.suppliers, c_node) {
+		if (!(link->flags & DL_FLAG_MANAGED))
+			continue;
+
+		if (link->status != DL_STATE_AVAILABLE) {
+			device_link_drop_managed(link);
+			continue;
+		}
+		WRITE_ONCE(link->status, DL_STATE_CONSUMER_PROBE);
+	}
+	dev->links.status = DL_DEV_PROBING;
+
+	device_links_write_unlock();
+}
+
 /**
  * device_links_driver_bound - Update device links after probing its driver.
  * @dev: Device to update the links for.
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f18963f42e21..eb201c6d5a6a 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -460,8 +460,10 @@ int device_bind_driver(struct device *dev)
 	int ret;
 
 	ret = driver_sysfs_add(dev);
-	if (!ret)
+	if (!ret) {
+		device_links_force_bind(dev);
 		driver_bound(dev);
+	}
 	else if (dev->bus)
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
-- 
2.30.1.766.gb4fecdf3b7-goog

