Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AAC32DA99
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 20:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbhCDTvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 14:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbhCDTvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 14:51:46 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FD5C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 11:51:05 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id dz17so12507010qvb.14
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 11:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=cDwF47+CXZG/BeGFEdiM1MVDEMvZftbfggUlRiE6ZRs=;
        b=tbj7xYX5Q3KTjMaMU8lymiptn8nSd+4rk66QPu3xY7LwHk5TzfB5vfUoMyQxs68Wln
         JJeKdMWNhBGVoowYC3KjUID2dSQG57qFWqjhe52fS34epZ99iXyCxGa67v+Tg9QA1h5G
         3iFfglU0HZbd8ni+QKpzldyKW1HfWSaK8tME06yjqDI/ov3fU9QVrsvQ3QeHzaM2ENM+
         iWKgB99gBqgIqIqXLpo628h0yScL/ro0Sdy7qnLDLZgFiM/AYJUMswPIRQ+GX2lnj9CH
         qV3hJYqLAB+E1sEEy2nFqohBZUF7WxXBcPE7aDzbqQWg1D/FM3t1yj2eZIeX6/Vuheee
         SHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=cDwF47+CXZG/BeGFEdiM1MVDEMvZftbfggUlRiE6ZRs=;
        b=Yo3Tvr9MJ2nWo0crtTSu9LGVln81H9wpHlq95fHQTV3qkAscYJN+aoxGTMBn+Rhwa7
         qocCJv2cahTDlSWSyC9vM50Sl3IIvEcgQRrZjUPWYeYltiwuFEk8l9e9Z7vzeDBYalYp
         0bf5YNa95XayEa63FwOPIKY2QcEjHClPoq/LAUrJxb+A5ogdd2I9j2+70mi43cWWmhdA
         HKfhOA2t6qG2eInoDNfCZC0gNlSE/rIoaBQ4N2Z0475h0b0TtmCpK44fATscGnY0CZHU
         0mr0ip1n3VmsqyeivaAg9c8oYrT62IGYTjJebRvZQ7Qfm89DEv0tPUsROSZ45As7ZpYv
         rO8Q==
X-Gm-Message-State: AOAM533cYFav4JE0QkS44JKRFcWYafVw4o2J7UxatGwUAx1IAoYXSSGJ
        +rcC31IE0gx7AEgWtV8Osd0dAXQatA6iLJw=
X-Google-Smtp-Source: ABdhPJwQCHDd3mGlTww6XV950kPfpc/LnXqH8/S21c8t5LjWP5mmDXHLBPxPa4BQwOIR4Cg1qpipIhTJ+5stWRk=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:289e:1d4c:5286:a8cc])
 (user=saravanak job=sendgmr) by 2002:ad4:4ae9:: with SMTP id
 cp9mr5776168qvb.20.1614887464921; Thu, 04 Mar 2021 11:51:04 -0800 (PST)
Date:   Thu,  4 Mar 2021 11:51:01 -0800
Message-Id: <20210304195101.3843496-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3] amba: Remove deferred device addition
From:   Saravana Kannan <saravanak@google.com>
To:     Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uevents generated for an amba device need PID and CID information
that's available only when the amba device is powered on, clocked and
out of reset. So, if those resources aren't available, the information
can't be read to generate the uevents. To workaround this requirement,
if the resources weren't available, the device addition was deferred and
retried periodically.

However, this deferred addition retry isn't based on resources becoming
available. Instead, it's retried every 5 seconds and causes arbitrary
probe delays for amba devices and their consumers.

Also, maintaining a separate deferred-probe like mechanism is
maintenance headache.

With this commit, instead of deferring the device addition, we simply
defer the generation of uevents for the device and probing of the device
(because drivers needs PID and CID to match) until the PID and CID
information can be read. This allows us to delete all the amba specific
deferring code and also avoid the arbitrary probing delays.

Cc: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---

v1 -> v2:
- Dropped RFC tag
- Complete rewrite to not use stub devices.
v2 -> v3:
- Flipped the if() condition for hard-coded periphids.
- Added a stub driver to handle the case where all amba drivers are
  modules loaded by uevents.
- Cc Marek after I realized I forgot to add him.

Marek,

Would you mind testing this? It looks okay with my limited testing.

-Saravana

 drivers/amba/bus.c | 329 +++++++++++++++++++++------------------------
 1 file changed, 151 insertions(+), 178 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 939ca220bf78..836d6d23bba3 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -149,11 +149,101 @@ static struct attribute *amba_dev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(amba_dev);
 
+static int amba_read_periphid(struct amba_device *dev)
+{
+	u32 size;
+	void __iomem *tmp;
+	u32 pid, cid;
+	struct reset_control *rstc;
+	int i, ret;
+
+	/*
+	 * Dynamically calculate the size of the resource
+	 * and use this for iomap
+	 */
+	size = resource_size(&dev->res);
+	tmp = ioremap(dev->res.start, size);
+	if (!tmp)
+		return -ENOMEM;
+
+	ret = dev_pm_domain_attach(&dev->dev, true);
+	if (ret)
+		goto err_pm;
+
+	ret = amba_get_enable_pclk(dev);
+	if (ret)
+		goto err_clk;
+
+	/*
+	 * Find reset control(s) of the amba bus and de-assert them.
+	 */
+	rstc = of_reset_control_array_get_optional_shared(dev->dev.of_node);
+	if (IS_ERR(rstc)) {
+		ret = PTR_ERR(rstc);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&dev->dev, "can't get reset: %d\n",
+				ret);
+		goto err_reset;
+	}
+	reset_control_deassert(rstc);
+	reset_control_put(rstc);
+
+	/*
+	 * Read pid and cid based on size of resource
+	 * they are located at end of region
+	 */
+	for (pid = 0, i = 0; i < 4; i++)
+		pid |= (readl(tmp + size - 0x20 + 4 * i) & 255) <<
+			(i * 8);
+	for (cid = 0, i = 0; i < 4; i++)
+		cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) <<
+			(i * 8);
+
+	if (cid == CORESIGHT_CID) {
+		/* set the base to the start of the last 4k block */
+		void __iomem *csbase = tmp + size - 4096;
+
+		dev->uci.devarch =
+			readl(csbase + UCI_REG_DEVARCH_OFFSET);
+		dev->uci.devtype =
+			readl(csbase + UCI_REG_DEVTYPE_OFFSET) & 0xff;
+	}
+
+	amba_put_disable_pclk(dev);
+
+	if (cid == AMBA_CID || cid == CORESIGHT_CID) {
+		dev->periphid = pid;
+		dev->cid = cid;
+	}
+
+	if (!dev->periphid)
+		ret = -ENODEV;
+
+	return ret;
+
+err_reset:
+	amba_put_disable_pclk(dev);
+err_clk:
+	dev_pm_domain_detach(&dev->dev, true);
+err_pm:
+	iounmap(tmp);
+	return ret;
+}
+
 static int amba_match(struct device *dev, struct device_driver *drv)
 {
 	struct amba_device *pcdev = to_amba_device(dev);
 	struct amba_driver *pcdrv = to_amba_driver(drv);
 
+	if (!pcdev->periphid) {
+		int ret = amba_read_periphid(pcdev);
+
+		if (ret)
+			return ret;
+		dev_set_uevent_suppress(dev, false);
+		kobject_uevent(&dev->kobj, KOBJ_ADD);
+	}
+
 	/* When driver_override is set, only bind to the matching driver */
 	if (pcdev->driver_override)
 		return !strcmp(pcdev->driver_override, drv->name);
@@ -332,6 +422,42 @@ static int __init amba_init(void)
 
 postcore_initcall(amba_init);
 
+static int amba_proxy_probe(struct amba_device *adev,
+			    const struct amba_id *id)
+{
+	WARN(1, "Stub driver should never match any device.\n");
+	return -ENODEV;
+}
+
+static const struct amba_id amba_stub_drv_ids[] = {
+	{ 0, 0 },
+};
+
+static struct amba_driver amba_proxy_drv = {
+	.drv = {
+		.name = "amba-proxy",
+	},
+	.probe = amba_proxy_probe,
+	.id_table = amba_stub_drv_ids,
+};
+
+static int __init amba_stub_drv_init(void)
+{
+	if (!IS_ENABLED(CONFIG_MODULES))
+		return 0;
+
+	/*
+	 * The amba_match() function will get called only if there is at least
+	 * one amba driver registered. If all amba drivers are modules and are
+	 * only loaded based on uevents, then we'll hit a chicken-and-egg
+	 * situation where amba_match() is waiting on drivers and drivers are
+	 * waiting on amba_match(). So, register a stub driver to make sure
+	 * amba_match() is called even if no amba driver has been registered.
+	 */
+	return amba_driver_register(&amba_proxy_drv);
+}
+late_initcall_sync(amba_stub_drv_init);
+
 /**
  *	amba_driver_register - register an AMBA device driver
  *	@drv: amba device driver structure
@@ -373,98 +499,43 @@ static void amba_device_release(struct device *dev)
 	kfree(d);
 }
 
-static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
+/**
+ *	amba_device_add - add a previously allocated AMBA device structure
+ *	@dev: AMBA device allocated by amba_device_alloc
+ *	@parent: resource parent for this devices resources
+ *
+ *	Claim the resource, and read the device cell ID if not already
+ *	initialized.  Register the AMBA device with the Linux device
+ *	manager.
+ */
+int amba_device_add(struct amba_device *dev, struct resource *parent)
 {
-	u32 size;
-	void __iomem *tmp;
-	int i, ret;
+	int ret;
 
 	WARN_ON(dev->irq[0] == (unsigned int)-1);
 	WARN_ON(dev->irq[1] == (unsigned int)-1);
 
 	ret = request_resource(parent, &dev->res);
 	if (ret)
-		goto err_out;
-
-	/* Hard-coded primecell ID instead of plug-n-play */
-	if (dev->periphid != 0)
-		goto skip_probe;
-
-	/*
-	 * Dynamically calculate the size of the resource
-	 * and use this for iomap
-	 */
-	size = resource_size(&dev->res);
-	tmp = ioremap(dev->res.start, size);
-	if (!tmp) {
-		ret = -ENOMEM;
-		goto err_release;
-	}
-
-	ret = dev_pm_domain_attach(&dev->dev, true);
-	if (ret) {
-		iounmap(tmp);
-		goto err_release;
-	}
-
-	ret = amba_get_enable_pclk(dev);
-	if (ret == 0) {
-		u32 pid, cid;
-		struct reset_control *rstc;
-
-		/*
-		 * Find reset control(s) of the amba bus and de-assert them.
-		 */
-		rstc = of_reset_control_array_get_optional_shared(dev->dev.of_node);
-		if (IS_ERR(rstc)) {
-			ret = PTR_ERR(rstc);
-			if (ret != -EPROBE_DEFER)
-				dev_err(&dev->dev, "can't get reset: %d\n",
-					ret);
-			goto err_reset;
-		}
-		reset_control_deassert(rstc);
-		reset_control_put(rstc);
+		return ret;
 
+	/* If primecell ID isn't hard-coded, figure it out */
+	if (!dev->periphid) {
+		ret = amba_read_periphid(dev);
+		if (ret && ret != -EPROBE_DEFER)
+			goto err_release;
 		/*
-		 * Read pid and cid based on size of resource
-		 * they are located at end of region
+		 * AMBA device uevents require reading its pid and cid
+		 * registers.  To do this, the device must be on, clocked and
+		 * out of reset.  However in some cases those resources might
+		 * not yet be available.  If that's the case, we suppress the
+		 * generation of uevents until we can read the pid and cid
+		 * registers.  See also amba_match().
 		 */
-		for (pid = 0, i = 0; i < 4; i++)
-			pid |= (readl(tmp + size - 0x20 + 4 * i) & 255) <<
-				(i * 8);
-		for (cid = 0, i = 0; i < 4; i++)
-			cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) <<
-				(i * 8);
-
-		if (cid == CORESIGHT_CID) {
-			/* set the base to the start of the last 4k block */
-			void __iomem *csbase = tmp + size - 4096;
-
-			dev->uci.devarch =
-				readl(csbase + UCI_REG_DEVARCH_OFFSET);
-			dev->uci.devtype =
-				readl(csbase + UCI_REG_DEVTYPE_OFFSET) & 0xff;
-		}
-
-		amba_put_disable_pclk(dev);
-
-		if (cid == AMBA_CID || cid == CORESIGHT_CID) {
-			dev->periphid = pid;
-			dev->cid = cid;
-		}
-
-		if (!dev->periphid)
-			ret = -ENODEV;
+		if (ret)
+			dev_set_uevent_suppress(&dev->dev, true);
 	}
 
-	iounmap(tmp);
-	dev_pm_domain_detach(&dev->dev, true);
-
-	if (ret)
-		goto err_release;
-
- skip_probe:
 	ret = device_add(&dev->dev);
 	if (ret)
 		goto err_release;
@@ -477,106 +548,8 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
 		return ret;
 
 	device_unregister(&dev->dev);
-
  err_release:
 	release_resource(&dev->res);
- err_out:
-	return ret;
-
- err_reset:
-	amba_put_disable_pclk(dev);
-	iounmap(tmp);
-	dev_pm_domain_detach(&dev->dev, true);
-	goto err_release;
-}
-
-/*
- * Registration of AMBA device require reading its pid and cid registers.
- * To do this, the device must be turned on (if it is a part of power domain)
- * and have clocks enabled. However in some cases those resources might not be
- * yet available. Returning EPROBE_DEFER is not a solution in such case,
- * because callers don't handle this special error code. Instead such devices
- * are added to the special list and their registration is retried from
- * periodic worker, until all resources are available and registration succeeds.
- */
-struct deferred_device {
-	struct amba_device *dev;
-	struct resource *parent;
-	struct list_head node;
-};
-
-static LIST_HEAD(deferred_devices);
-static DEFINE_MUTEX(deferred_devices_lock);
-
-static void amba_deferred_retry_func(struct work_struct *dummy);
-static DECLARE_DELAYED_WORK(deferred_retry_work, amba_deferred_retry_func);
-
-#define DEFERRED_DEVICE_TIMEOUT (msecs_to_jiffies(5 * 1000))
-
-static int amba_deferred_retry(void)
-{
-	struct deferred_device *ddev, *tmp;
-
-	mutex_lock(&deferred_devices_lock);
-
-	list_for_each_entry_safe(ddev, tmp, &deferred_devices, node) {
-		int ret = amba_device_try_add(ddev->dev, ddev->parent);
-
-		if (ret == -EPROBE_DEFER)
-			continue;
-
-		list_del_init(&ddev->node);
-		kfree(ddev);
-	}
-
-	mutex_unlock(&deferred_devices_lock);
-
-	return 0;
-}
-late_initcall(amba_deferred_retry);
-
-static void amba_deferred_retry_func(struct work_struct *dummy)
-{
-	amba_deferred_retry();
-
-	if (!list_empty(&deferred_devices))
-		schedule_delayed_work(&deferred_retry_work,
-				      DEFERRED_DEVICE_TIMEOUT);
-}
-
-/**
- *	amba_device_add - add a previously allocated AMBA device structure
- *	@dev: AMBA device allocated by amba_device_alloc
- *	@parent: resource parent for this devices resources
- *
- *	Claim the resource, and read the device cell ID if not already
- *	initialized.  Register the AMBA device with the Linux device
- *	manager.
- */
-int amba_device_add(struct amba_device *dev, struct resource *parent)
-{
-	int ret = amba_device_try_add(dev, parent);
-
-	if (ret == -EPROBE_DEFER) {
-		struct deferred_device *ddev;
-
-		ddev = kmalloc(sizeof(*ddev), GFP_KERNEL);
-		if (!ddev)
-			return -ENOMEM;
-
-		ddev->dev = dev;
-		ddev->parent = parent;
-		ret = 0;
-
-		mutex_lock(&deferred_devices_lock);
-
-		if (list_empty(&deferred_devices))
-			schedule_delayed_work(&deferred_retry_work,
-					      DEFERRED_DEVICE_TIMEOUT);
-		list_add_tail(&ddev->node, &deferred_devices);
-
-		mutex_unlock(&deferred_devices_lock);
-	}
 	return ret;
 }
 EXPORT_SYMBOL_GPL(amba_device_add);
-- 
2.30.1.766.gb4fecdf3b7-goog

