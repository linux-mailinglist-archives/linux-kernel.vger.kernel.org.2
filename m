Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01BF732CB31
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 05:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbhCDEBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 23:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbhCDEAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 23:00:43 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888C5C061756
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 20:00:03 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a63so29389958yba.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 20:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Z6CJyKx3f1aVLfkRlNvMWUJE0cr2cLDltraZAc71u5Y=;
        b=CSG3fSwXyvJC0K5xKs7Q4VjAMQfq9C15YbYYGWqjs1MZM15wtOZecuVtOwO73QeQDS
         62ntPkPmO3jLHxJu9xOJBJjEKAgdSonZkq9oH+VAjhTwPfnd1S2esBh93R40MeJOzgQR
         LooZ6S+eElHP8TKu+PYzGUZJW3W8JilnCrh5Du6FTC00pi/chAtdRA4eI7IhMKXBdedk
         /XBHZPcfTDbJVpj3FEBedfJ9GNwAZTuZaG4zFRrHAmqfHpdcRDqAnvSP0FemxjOMLVr8
         39RZPFHEhjaWUOUuAzN90bi2eWesLH4WTmWJN98yX7r/OEuneRJUeI/yQchgN4NBhAeC
         axHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Z6CJyKx3f1aVLfkRlNvMWUJE0cr2cLDltraZAc71u5Y=;
        b=sKsefN6FUiXqn+HYnWtyU4se/qbKWldJURMsyzzu5fkO0XwI85BtgY8hH+qT5iu9i7
         ZHF3QUdLs5dyh5ri1Lk/bOfQhNCmozBsFRQ5ofAxQUUgPEKmUeAucxBM2e8nV9ZBCVU3
         xsf2zodjbl2z/paXc57fPX7ilHb6A8xNsAV+65heNXqeg0Od7Ub57EyubXPh0+r6F1x7
         xJaxEqBGiPLMq169n+8RRHobU2fMp01roy/Y0dlWFejQfpVZOLgxQemieU71IDe3kalq
         l/wS8iVcwBLV16aU0+pYyh9fiKxGwf7B4rx+wkMsl8fs5fyFCHM8R3wfxV4cvZN/NApd
         r4fA==
X-Gm-Message-State: AOAM533w3z5dyI/CF/M+igA7yzy0i6+9hhJDliirNIJdIIqtToLeRtjL
        7bRsZfPhiAzLM5fm3jDMhl34PQZWlWwoHqc=
X-Google-Smtp-Source: ABdhPJyVxSfZGmgOwcb+RvIB6R73WAFwy8khZoYx5RknE2+JmQ77NXahjQRonvxmCUPyvqEwmsFjwZCnE09LZeM=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:71d0:e842:de76:b9be])
 (user=saravanak job=sendgmr) by 2002:a5b:851:: with SMTP id
 v17mr3971926ybq.55.1614830402836; Wed, 03 Mar 2021 20:00:02 -0800 (PST)
Date:   Wed,  3 Mar 2021 19:59:58 -0800
Message-Id: <20210304035958.3657121-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v2] amba: Remove deferred device addition
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
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/amba/bus.c | 293 ++++++++++++++++++---------------------------
 1 file changed, 115 insertions(+), 178 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 939ca220bf78..fac4110b2f58 100644
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
@@ -373,98 +463,43 @@ static void amba_device_release(struct device *dev)
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
+	if (dev->periphid) {
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
@@ -477,106 +512,8 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
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

