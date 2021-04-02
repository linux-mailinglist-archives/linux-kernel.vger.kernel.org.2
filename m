Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE623525EE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 06:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhDBEEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 00:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhDBEEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 00:04:10 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74087C061788
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 21:04:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x22so8065280ybi.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 21:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bQUEFr5rjiykloK72ryUNlMyNvc1gykEq+SpiAVOKbI=;
        b=BPWaV7E/Qgh+TtxH5uLr3h5mLsB8kCAm8QzF6/OLYUBqkDB2StpTD4/B2+2p7GKjfO
         O5u2B9KBrUflejQJTSERMNivn8Mag99f+eWJFRz8ZgZ8Tb+ADiqd+cx4nDJVqOMRQOJT
         ZbAa4SI8Ww2Q+ZY0SUeP6AWUfxS2mzhSUl5jwLtcgxubHj4d86K9f5zsWAr8Lq25dQxe
         tC3JwkQttq75BqmcfddJ1HIgYyjWwDBHRT6jnbghygVjXOjCiWQ2SvjcRNmy89AFQY0/
         JnsZtrMy1j2xW5Y5b/J3KH7GdWLdu52VFhRVk+/KEt+bPvLIomkDnaI2DPDdJCucN63Z
         +YKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bQUEFr5rjiykloK72ryUNlMyNvc1gykEq+SpiAVOKbI=;
        b=lXPqwNRtOLF6tFozTUsPIuheMiux31IsKcltpiDXSd5w3pIJqTK1E6FEQuGbmnfhGZ
         Q+jAKTneFCncQL2/TH+ffKI331UvabJZguI7T3cExs7slGVoyJAggainRt4kpf1O+e4X
         8yZM84PVDitFYW99M0bzyB4a08PAhDT9zPxL9xRwbd+/gDxyNbfnKd9wkY3ZHIASlm19
         MdC7yvLNnc/eNm+lfybiFIjWEuZq0GcUjcd33jQBQc7I8QzSXlEq5DI83T6Ui+Rtze9r
         oIskepdtu3LgBitroPdmhJM2THPeP7MfElIUU8m9d3s1t/U3oTvI+vPfFIsMwcEOhsAB
         GS5w==
X-Gm-Message-State: AOAM531zErk0DTCIcjGcQcFGJktQqbwP+MpAqvYoq1IL25biFYqQOpe9
        BzNDRQw5Si51TOXb6VoVt0J4Zk2cNdc0ps0=
X-Google-Smtp-Source: ABdhPJxQDkerVzb0LsPKvv7C1ci4++IVbYtP0NJMXbO04t/aOY9xaR4VGYxMbHRKXw7q0GvFEJjwDDj0wa59Gi0=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:4867:55c5:8fbb:da39])
 (user=saravanak job=sendgmr) by 2002:a25:b906:: with SMTP id
 x6mr15521751ybj.504.1617336249675; Thu, 01 Apr 2021 21:04:09 -0700 (PDT)
Date:   Thu,  1 Apr 2021 21:03:41 -0700
In-Reply-To: <20210402040342.2944858-1-saravanak@google.com>
Message-Id: <20210402040342.2944858-3-saravanak@google.com>
Mime-Version: 1.0
References: <20210402040342.2944858-1-saravanak@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v1 2/2] driver core: Improve fw_devlink & deferred_probe_timeout
 interaction
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

deferred_probe_timeout kernel commandline parameter allows probing of
consumer devices if the supplier devices don't have any drivers.

fw_devlink=on will indefintely block probe() calls on a device if all
its suppliers haven't probed successfully. This completely skips calls
to driver_deferred_probe_check_state() since that's only called when a
.probe() function calls framework APIs. So fw_devlink=on breaks
deferred_probe_timeout.

deferred_probe_timeout in its current state also ignores a lot of
information that's now available to the kernel. It assumes all suppliers
that haven't probed when the timer expires (or when initcalls are done
on a static kernel) will never probe and fails any calls to acquire
resources from these unprobed suppliers.

However, this assumption by deferred_probe_timeout isn't true under many
conditions. For example:
- If the consumer happens to be before the supplier in the deferred
  probe list.
- If the supplier itself is waiting on its supplier to probe.

This patch fixes both these issues by relaxing device links between
devices only if the supplier doesn't have any driver that could match
with (NOT bound to) the supplier device. This way, we only fail attempts
to acquire resources from suppliers that truly don't have any driver vs
suppliers that just happen to not have probed yet.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/base.h |  1 +
 drivers/base/core.c | 64 ++++++++++++++++++++++++++++++++++++++++-----
 drivers/base/dd.c   |  5 ++++
 3 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 1b44ed588f66..e5f9b7e656c3 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -191,6 +191,7 @@ extern void device_links_driver_cleanup(struct device *dev);
 extern void device_links_no_driver(struct device *dev);
 extern bool device_links_busy(struct device *dev);
 extern void device_links_unbind_consumers(struct device *dev);
+extern void fw_devlink_drivers_done(void);
 
 /* device pm support */
 void device_pm_move_to_tail(struct device *dev);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index de518178ac36..c05dae75b696 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -51,6 +51,7 @@ static LIST_HEAD(deferred_sync);
 static unsigned int defer_sync_state_count = 1;
 static DEFINE_MUTEX(fwnode_link_lock);
 static bool fw_devlink_is_permissive(void);
+static bool fw_devlink_drv_reg_done;
 
 /**
  * fwnode_link_add - Create a link between two fwnode_handles.
@@ -1598,6 +1599,52 @@ static void fw_devlink_parse_fwtree(struct fwnode_handle *fwnode)
 		fw_devlink_parse_fwtree(child);
 }
 
+static void fw_devlink_relax_link(struct device_link *link)
+{
+	if (!(link->flags & DL_FLAG_INFERRED))
+		return;
+
+	if (link->flags == (DL_FLAG_MANAGED | FW_DEVLINK_FLAGS_PERMISSIVE))
+		return;
+
+	pm_runtime_drop_link(link);
+	link->flags = DL_FLAG_MANAGED | FW_DEVLINK_FLAGS_PERMISSIVE;
+	dev_dbg(link->consumer, "Relaxing link with %s\n",
+		dev_name(link->supplier));
+}
+
+static int fw_devlink_no_driver(struct device *dev, void *data)
+{
+	struct device_link *link = to_devlink(dev);
+
+	if (!link->supplier->can_match)
+		fw_devlink_relax_link(link);
+
+	return 0;
+}
+
+void fw_devlink_drivers_done(void)
+{
+	fw_devlink_drv_reg_done = true;
+	device_links_write_lock();
+	class_for_each_device(&devlink_class, NULL, NULL,
+			      fw_devlink_no_driver);
+	device_links_write_unlock();
+}
+
+static void fw_devlink_unblock_consumers(struct device *dev)
+{
+	struct device_link *link;
+
+	if (!fw_devlink_flags || fw_devlink_is_permissive())
+		return;
+
+	device_links_write_lock();
+	list_for_each_entry(link, &dev->links.consumers, s_node)
+		fw_devlink_relax_link(link);
+	device_links_write_unlock();
+}
+
 /**
  * fw_devlink_relax_cycle - Convert cyclic links to SYNC_STATE_ONLY links
  * @con: Device to check dependencies for.
@@ -1634,13 +1681,7 @@ static int fw_devlink_relax_cycle(struct device *con, void *sup)
 
 		ret = 1;
 
-		if (!(link->flags & DL_FLAG_INFERRED))
-			continue;
-
-		pm_runtime_drop_link(link);
-		link->flags = DL_FLAG_MANAGED | FW_DEVLINK_FLAGS_PERMISSIVE;
-		dev_dbg(link->consumer, "Relaxing link with %s\n",
-			dev_name(link->supplier));
+		fw_devlink_relax_link(link);
 	}
 	return ret;
 }
@@ -3275,6 +3316,15 @@ int device_add(struct device *dev)
 	}
 
 	bus_probe_device(dev);
+
+	/*
+	 * If all driver registration is done and a newly added device doesn't
+	 * match with any driver, don't block its consumers from probing in
+	 * case the consumer device is able to operate without this supplier.
+	 */
+	if (dev->fwnode && fw_devlink_drv_reg_done && !dev->can_match)
+		fw_devlink_unblock_consumers(dev);
+
 	if (parent)
 		klist_add_tail(&dev->p->knode_parent,
 			       &parent->p->klist_children);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 28ad8afd87bc..ef988e04a287 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -293,6 +293,8 @@ static void deferred_probe_timeout_work_func(struct work_struct *work)
 {
 	struct device_private *p;
 
+	fw_devlink_drivers_done();
+
 	driver_deferred_probe_timeout = 0;
 	driver_deferred_probe_trigger();
 	flush_work(&deferred_probe_work);
@@ -323,6 +325,9 @@ static int deferred_probe_initcall(void)
 	flush_work(&deferred_probe_work);
 	initcalls_done = true;
 
+	if (!IS_ENABLED(CONFIG_MODULES))
+		fw_devlink_drivers_done();
+
 	/*
 	 * Trigger deferred probe again, this time we won't defer anything
 	 * that is optional
-- 
2.31.0.208.g409f899ff0-goog

