Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CF632F416
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhCETjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhCETjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:39:05 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32C0C061761
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 11:39:04 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id n9so1097828pgi.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 11:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d22/NX2WJVNWaugIIvFc1iulMy5mDfZwNj3BJTpj9kg=;
        b=Wha36ec/RNsTlDIzgjTbSY51T3BzZZLp8/eQ8WwVRNvX/Ua0efayOMAH1HoNsiQALv
         /HMESy9vymLLhFsp+shhfZ2J00KiwvgKVbbeuxeXSLszI8BDyeYomdq0ibOhOIzT8TsN
         k5+9lO+cNGR75YI/s2Ukvm0H7OTGO2SL1ZINQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d22/NX2WJVNWaugIIvFc1iulMy5mDfZwNj3BJTpj9kg=;
        b=kkLL0JR0Eiq+Zq44AoxmfBQCxLk/oJf6pkei/f9I1HVRtsijSuF4bHXDtowo8mLrUB
         /84l0ZxugxG5nEDIDBru39SAjbE72gv25ePzoMPCzUjDx0cPvB/IxihWh+8OvDITrgo4
         uAeqsKI49IFY4eQXZ7ELbaLijRLB5yuXCqa2n43zik70px9qq6TKXou41hON3v20CBY3
         7PvkC3C0RuZCPKltmDGzn7heGGfYLjZUcX6tOX1Ua3qhwtXLkr7Sx+e/5k2aBul15D/W
         l0dvkaW5nQVYOq6gxCbcJdTz6gkIGLllZ2LXqRIw2BdrU9d+xCLWYO5u4yr4VbcdgJov
         f8wA==
X-Gm-Message-State: AOAM531EZzTPF4BjGiGCY2ecBqmf1pKKXvi11ema9ROd9JKpKZ4yoDRb
        UlGzP7FFnwz0qtXUu/ZjiKU3bg==
X-Google-Smtp-Source: ABdhPJz4NAaplRA+NODj4zdGD5ZSgyQAdew4IKxe3Y2SarDkMZxX7ECHOd/JEMO9Fd/aDWQqpbp9fA==
X-Received: by 2002:a05:6a00:8d4:b029:1b7:7ad9:4864 with SMTP id s20-20020a056a0008d4b02901b77ad94864mr10136068pfu.34.1614973144216;
        Fri, 05 Mar 2021 11:39:04 -0800 (PST)
Received: from localhost ([2620:15c:202:1:2878:25d1:94cb:a547])
        by smtp.gmail.com with UTF8SMTPSA id n184sm3438167pfd.205.2021.03.05.11.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 11:39:03 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Peter Chen <peter.chen@nxp.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        linux-usb@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Al Cooper <alcooperx@gmail.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v6 2/5] USB: misc: Add onboard_usb_hub driver
Date:   Fri,  5 Mar 2021 11:38:50 -0800
Message-Id: <20210305113832.v6.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210305193853.2040456-1-mka@chromium.org>
References: <20210305193853.2040456-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main issue this driver addresses is that a USB hub needs to be
powered before it can be discovered. For discrete onboard hubs (an
example for such a hub is the Realtek RTS5411) this is often solved
by supplying the hub with an 'always-on' regulator, which is kind
of a hack. Some onboard hubs may require further initialization
steps, like changing the state of a GPIO or enabling a clock, which
requires even more hacks. This driver creates a platform device
representing the hub which performs the necessary initialization.
Currently it only supports switching on a single regulator, support
for multiple regulators or other actions can be added as needed.
Different initialization sequences can be supported based on the
compatible string.

Besides performing the initialization the driver can be configured
to power the hub off during system suspend. This can help to extend
battery life on battery powered devices which have no requirements
to keep the hub powered during suspend. The driver can also be
configured to leave the hub powered when a wakeup capable USB device
is connected when suspending, and power it off otherwise.

Technically the driver consists of two drivers, the platform driver
described above and a very thin USB driver that subclasses the
generic driver. The purpose of this driver is to provide the platform
driver with the USB devices corresponding to the hub(s) (a hub
controller may provide multiple 'logical' hubs, e.g. one to support
USB 2.0 and another for USB 3.x).

Note: the driver currently only works with hubs connected directly
to a root hub, but it could be extended to support other
configurations if needed.

Co-developed-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Open questions:
- limit to USB hubs or extend to other USB devices (usb_pwrseq?) as
  suggested by Krzysztof in the v5 review? I'm open to explore the
  latter option, but would want maintainer buy-in before spending
  time on this.

- it seems to me there should be more options to configure the behavior
  during system suspend. Currently we have 'keep the hub always powered'
  and 'power the hub down unless a wakeup capable device is connected'.
  The configuration is done through the boolean sysfs attribute
  'always_powered_in_suspend'. Maybe this should be changed to

    powered_in_suspend: yes/no/wakeup

  or similar, with some flexibility when writing boolean values.

Changes in v6:
- use 'companion-hub' to locate the platform device, instead of
  scanning through the nodes of the parent
- added ABI documentation for 'always_powered_in_suspend'
- sysfs_emit() instead of sprintf() in always_powered_in_suspend_show()
- register sysfs attribute through driver.dev_groups
- evaluate return value of driver_attach() in _probe()
- use dev_warn() instead of WARN_ON() in _probe()
- include 'onboard_hub.h'

Changes in v5:
- the platform device is now instantiated from the same DT node
  as the 'primary' USB hub device
  - use the USB compatible strings for the platform device
  - refactored _find_onboard_hub() to search the parents child
    nodes for a platform device with a matching compatible string
  - added exported function of_is_onboard_usb_hub() to allow other
    drivers (like xhci_plat) to check if one of their child DT nodes
    is a supported hub
- use late suspend to make sure info about wakeup enabled descendants
  is updated
- call driver_attach() for the USB driver in onboard_hub_probe() to
  make sure the driver is re-attached after the device_release_driver()
  calls in onboard_hub_remove()
- renamed sysfs attribute 'power_off_in_suspend' to
  'always_powered_in_suspend'
- added sysfs symlinks between platform device and USB devices
- marked 'onboard_hub_pm_ops' as __maybe_unused
- removed 'realtek' compatible string which is not needed at this
  point
- fix log for regulator_disable() failure

Changes in v4:
- updated Kconfig documentation
- changed the loop in onboard_hub_remove() to release the hub lock
  before unbinding the USB device and make self deadlock prevention
  less clunky
- fixed return value in onboard_hub_usbdev_probe()
- added entry to MAINTAINERS file

Changes in v3:
- updated the commit message
- updated description in Kconfig
- remove include of 'core/usb.h'
- use 'is_powered_on' flag instead of 'has_wakeup_capable_descendants'
- added 'going_away' flag to struct onboard_hub
  - don't allow adding new USB devices when the platform device is going away
  - don't bother with deleting the list item in onboard_hub_remove_usbdev()
    when the platform device is going away
- don't assume in onboard_hub_suspend() that all USB hub devices are
  connected to the same controller
- removed unnecessary devm_kfree() from onboard_hub_remove_usbdev()
- fixed error handling in onboard_hub_remove_usbdev()
- use kstrtobool() instead of strtobool() in power_off_in_suspend_store()
- unbind USB devices in onboard_hub_remove() to avoid dangling references
  to the platform device
- moved put_device() for platform device to _find_onboard_hub()
- changed return value of onboard_hub_remove_usbdev() to void
- evaluate return value of onboard_hub_add_usbdev()
- register 'power_off_in_suspend' as managed device attribute
- use USB_DEVICE macro instead manual initialization
- add unwinding to onboard_hub_init()
- updated MODULE_DESCRIPTION
- use module_init() instead of device_initcall()

Changes in v2:
- check wakeup enabled state of the USB controller instead of
  using 'wakeup-source' property
- use sysfs attribute instead of DT property to determine if
  the hub should be powered off at all during system suspend
- added missing brace in onboard_hub_suspend()
- updated commit message
- use pm_ptr for pm_ops as suggested by Alan

Changes in v1:
- renamed the driver to 'onboard_usb_hub'
- single file for platform and USB driver
- USB hub devices register with the platform device
  - the DT includes a phandle of the platform device
- the platform device now controls when power is turned off
- the USB driver became a very thin subclass of the generic USB
  driver
- enabled autosuspend support

 .../sysfs-bus-platform-onboard-usb-hub        |   8 +
 MAINTAINERS                                   |   7 +
 drivers/usb/misc/Kconfig                      |  17 +
 drivers/usb/misc/Makefile                     |   1 +
 drivers/usb/misc/onboard_usb_hub.c            | 415 ++++++++++++++++++
 include/linux/usb/onboard_hub.h               |  15 +
 6 files changed, 463 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-hub
 create mode 100644 drivers/usb/misc/onboard_usb_hub.c
 create mode 100644 include/linux/usb/onboard_hub.h

diff --git a/Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-hub b/Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-hub
new file mode 100644
index 000000000000..e981d83648e6
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-hub
@@ -0,0 +1,8 @@
+What:		/sys/bus/platform/devices/<dev>/always_powered_in_suspend
+Date:		March 2021
+KernelVersion:	5.13
+Contact:	Matthias Kaehlcke <matthias@kaehlcke.net>
+		linux-usb@vger.kernel.org
+Description:
+		(RW) Controls whether the USB hub remains always powered
+		during system suspend or not.
\ No newline at end of file
diff --git a/MAINTAINERS b/MAINTAINERS
index d92f85ca831d..882ae6e378c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13297,6 +13297,13 @@ S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/i2c/ov9734.c
 
+ONBOARD USB HUB DRIVER
+M:	Matthias Kaehlcke <mka@chromium.org>
+L:	linux-usb@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/usb/onboard_usb_hub.yaml
+F:	drivers/usb/misc/onboard_usb_hub.c
+
 ONENAND FLASH DRIVER
 M:	Kyungmin Park <kyungmin.park@samsung.com>
 L:	linux-mtd@lists.infradead.org
diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index 8f1144359012..f534269fbb20 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -284,3 +284,20 @@ config BRCM_USB_PINMAP
 	  This option enables support for remapping some USB external
 	  signals, which are typically on dedicated pins on the chip,
 	  to any gpio.
+
+config USB_ONBOARD_HUB
+	tristate "Onboard USB hub support"
+	depends on OF || COMPILE_TEST
+	help
+	  Say Y here if you want to support discrete onboard USB hubs that
+	  don't require an additional control bus for initialization, but
+	  need some nontrivial form of initialization, such as enabling a
+	  power regulator. An example for such a hub is the Realtek
+	  RTS5411.
+
+	  The driver can be configured to turn off the power of the hub
+	  during system suspend. This may reduce power consumption while
+	  the system is suspended.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called onboard_usb_hub.
diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
index 5f4e598573ab..2c5aec6f1b26 100644
--- a/drivers/usb/misc/Makefile
+++ b/drivers/usb/misc/Makefile
@@ -32,3 +32,4 @@ obj-$(CONFIG_USB_CHAOSKEY)		+= chaoskey.o
 obj-$(CONFIG_USB_SISUSBVGA)		+= sisusbvga/
 obj-$(CONFIG_USB_LINK_LAYER_TEST)	+= lvstest.o
 obj-$(CONFIG_BRCM_USB_PINMAP)		+= brcmstb-usb-pinmap.o
+obj-$(CONFIG_USB_ONBOARD_HUB)		+= onboard_usb_hub.o
diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
new file mode 100644
index 000000000000..db926699a5ec
--- /dev/null
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -0,0 +1,415 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Driver for onboard USB hubs
+ *
+ * Copyright (c) 2020, Google LLC
+ */
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/suspend.h>
+#include <linux/sysfs.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+#include <linux/usb/onboard_hub.h>
+
+static struct usb_device_driver onboard_hub_usbdev_driver;
+
+/************************** Platform driver **************************/
+
+struct udev_node {
+	struct usb_device *udev;
+	struct list_head list;
+};
+
+struct onboard_hub {
+	struct regulator *vdd;
+	struct device *dev;
+	bool always_powered_in_suspend;
+	bool is_powered_on;
+	bool going_away;
+	struct list_head udev_list;
+	struct mutex lock;
+};
+
+static int onboard_hub_power_on(struct onboard_hub *hub)
+{
+	int err;
+
+	err = regulator_enable(hub->vdd);
+	if (err) {
+		dev_err(hub->dev, "failed to enable regulator: %d\n", err);
+		return err;
+	}
+
+	hub->is_powered_on = true;
+
+	return 0;
+}
+
+static int onboard_hub_power_off(struct onboard_hub *hub)
+{
+	int err;
+
+	err = regulator_disable(hub->vdd);
+	if (err) {
+		dev_err(hub->dev, "failed to disable regulator: %d\n", err);
+		return err;
+	}
+
+	hub->is_powered_on = false;
+
+	return 0;
+}
+
+static int __maybe_unused onboard_hub_suspend(struct device *dev)
+{
+	struct onboard_hub *hub = dev_get_drvdata(dev);
+	struct udev_node *node;
+	bool power_off;
+	int rc = 0;
+
+	if (hub->always_powered_in_suspend)
+		return 0;
+
+	power_off = true;
+
+	mutex_lock(&hub->lock);
+
+	list_for_each_entry(node, &hub->udev_list, list) {
+		if (!device_may_wakeup(node->udev->bus->controller))
+			continue;
+
+		if (usb_wakeup_enabled_descendants(node->udev)) {
+			power_off = false;
+			break;
+		}
+	}
+
+	mutex_unlock(&hub->lock);
+
+	if (power_off)
+		rc = onboard_hub_power_off(hub);
+
+	return rc;
+}
+
+static int __maybe_unused onboard_hub_resume(struct device *dev)
+{
+	struct onboard_hub *hub = dev_get_drvdata(dev);
+	int rc = 0;
+
+	if (!hub->is_powered_on)
+		rc = onboard_hub_power_on(hub);
+
+	return rc;
+}
+
+static int onboard_hub_add_usbdev(struct onboard_hub *hub, struct usb_device *udev)
+{
+	struct udev_node *node;
+	char link_name[64];
+	int ret = 0;
+
+	mutex_lock(&hub->lock);
+
+	if (hub->going_away) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	node = devm_kzalloc(hub->dev, sizeof(*node), GFP_KERNEL);
+	if (!node) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	node->udev = udev;
+
+	list_add(&node->list, &hub->udev_list);
+
+	snprintf(link_name, sizeof(link_name), "usb_dev.%s", dev_name(&udev->dev));
+	WARN_ON(sysfs_create_link(&hub->dev->kobj, &udev->dev.kobj, link_name));
+
+unlock:
+	mutex_unlock(&hub->lock);
+
+	return ret;
+}
+
+static void onboard_hub_remove_usbdev(struct onboard_hub *hub, struct usb_device *udev)
+{
+	struct udev_node *node;
+	char link_name[64];
+
+	snprintf(link_name, sizeof(link_name), "usb_dev.%s", dev_name(&udev->dev));
+	sysfs_remove_link(&hub->dev->kobj, link_name);
+
+	mutex_lock(&hub->lock);
+
+	list_for_each_entry(node, &hub->udev_list, list) {
+		if (node->udev == udev) {
+			list_del(&node->list);
+			break;
+		}
+	}
+
+	mutex_unlock(&hub->lock);
+}
+
+static ssize_t always_powered_in_suspend_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct onboard_hub *hub = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", hub->always_powered_in_suspend);
+}
+
+static ssize_t always_powered_in_suspend_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct onboard_hub *hub = dev_get_drvdata(dev);
+	bool val;
+	int ret;
+
+	ret = kstrtobool(buf, &val);
+	if (ret < 0)
+		return ret;
+
+	hub->always_powered_in_suspend = val;
+
+	return count;
+}
+static DEVICE_ATTR_RW(always_powered_in_suspend);
+
+static struct attribute *onboard_hub_attrs[] = {
+	&dev_attr_always_powered_in_suspend.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(onboard_hub);
+
+static int onboard_hub_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct onboard_hub *hub;
+	int err;
+
+	hub = devm_kzalloc(dev, sizeof(*hub), GFP_KERNEL);
+	if (!hub)
+		return -ENOMEM;
+
+	hub->vdd = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(hub->vdd))
+		return PTR_ERR(hub->vdd);
+
+	hub->dev = dev;
+	mutex_init(&hub->lock);
+	INIT_LIST_HEAD(&hub->udev_list);
+
+	dev_set_drvdata(dev, hub);
+
+	err = onboard_hub_power_on(hub);
+	if (err)
+		return err;
+
+	/*
+	 * The USB driver might have been detached from the USB devices by
+	 * onboard_hub_remove(), make sure to re-attach it if needed.
+	 */
+	err = driver_attach(&onboard_hub_usbdev_driver.drvwrap.driver);
+	if (err) {
+		onboard_hub_power_off(hub);
+		return err;
+	}
+
+	return 0;
+}
+
+static int onboard_hub_remove(struct platform_device *pdev)
+{
+	struct onboard_hub *hub = dev_get_drvdata(&pdev->dev);
+	struct udev_node *node;
+	struct usb_device *udev;
+
+	hub->going_away = true;
+
+	mutex_lock(&hub->lock);
+
+	/* unbind the USB devices to avoid dangling references to this device */
+	while (!list_empty(&hub->udev_list)) {
+		node = list_first_entry(&hub->udev_list, struct udev_node, list);
+		udev = node->udev;
+
+		/*
+		 * Unbinding the driver will call onboard_hub_remove_usbdev(),
+		 * which acquires hub->lock.  We must release the lock first.
+		 */
+		get_device(&udev->dev);
+		mutex_unlock(&hub->lock);
+		device_release_driver(&udev->dev);
+		put_device(&udev->dev);
+		mutex_lock(&hub->lock);
+	}
+
+	mutex_unlock(&hub->lock);
+
+	return onboard_hub_power_off(hub);
+}
+
+static const struct of_device_id onboard_hub_match[] = {
+	{ .compatible = "usbbda,411" },
+	{ .compatible = "usbbda,5411" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, onboard_hub_match);
+
+bool of_is_onboard_usb_hub(const struct device_node *np)
+{
+	return !!of_match_node(onboard_hub_match, np);
+}
+EXPORT_SYMBOL_GPL(of_is_onboard_usb_hub);
+
+static const struct dev_pm_ops __maybe_unused onboard_hub_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(onboard_hub_suspend, onboard_hub_resume)
+};
+
+static struct platform_driver onboard_hub_driver = {
+	.probe = onboard_hub_probe,
+	.remove = onboard_hub_remove,
+
+	.driver = {
+		.name = "onboard-usb-hub",
+		.of_match_table = onboard_hub_match,
+		.pm = pm_ptr(&onboard_hub_pm_ops),
+		.dev_groups = onboard_hub_groups,
+	},
+};
+
+/************************** USB driver **************************/
+
+#define VENDOR_ID_REALTEK	0x0bda
+
+/*
+ * Returns the onboard_hub platform device that is associated with the USB
+ * device passed as parameter.
+ */
+static struct onboard_hub *_find_onboard_hub(struct device *dev)
+{
+	struct platform_device *pdev;
+	struct device_node *np;
+	phandle ph;
+
+	pdev = of_find_device_by_node(dev->of_node);
+	if (!pdev) {
+		if (of_property_read_u32(dev->of_node, "companion-hub", &ph)) {
+			dev_err(dev, "failed to read 'companion-hub' property\n");
+			return ERR_PTR(-EINVAL);
+		}
+
+		np = of_find_node_by_phandle(ph);
+		if (!np) {
+			dev_err(dev, "failed to find device node for companion hub\n");
+			return ERR_PTR(-EINVAL);
+		}
+
+		pdev = of_find_device_by_node(np);
+		of_node_put(np);
+
+		if (!pdev)
+			return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	put_device(&pdev->dev);
+
+	return dev_get_drvdata(&pdev->dev);
+}
+
+static int onboard_hub_usbdev_probe(struct usb_device *udev)
+{
+	struct device *dev = &udev->dev;
+	struct onboard_hub *hub;
+	int err;
+
+	/* ignore supported hubs without device tree node */
+	if (!dev->of_node)
+		return -ENODEV;
+
+	hub = _find_onboard_hub(dev);
+	if (IS_ERR(hub))
+		return PTR_ERR(hub);
+
+	dev_set_drvdata(dev, hub);
+
+	err = onboard_hub_add_usbdev(hub, udev);
+	if (err)
+		return err;
+
+	err = sysfs_create_link(&udev->dev.kobj, &hub->dev->kobj, "onboard_hub_dev");
+	if (err)
+		dev_warn(&udev->dev, "failed to create symlink to platform device: %d\n", err);
+
+	return 0;
+}
+
+static void onboard_hub_usbdev_disconnect(struct usb_device *udev)
+{
+	struct onboard_hub *hub = dev_get_drvdata(&udev->dev);
+
+	sysfs_remove_link(&udev->dev.kobj, "onboard_hub_dev");
+
+	onboard_hub_remove_usbdev(hub, udev);
+}
+
+static const struct usb_device_id onboard_hub_id_table[] = {
+	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0411) }, /* RTS5411 USB 3.0 */
+	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5411) }, /* RTS5411 USB 2.0 */
+	{},
+};
+
+MODULE_DEVICE_TABLE(usb, onboard_hub_id_table);
+
+static struct usb_device_driver onboard_hub_usbdev_driver = {
+
+	.name = "onboard-usb-hub",
+	.probe = onboard_hub_usbdev_probe,
+	.disconnect = onboard_hub_usbdev_disconnect,
+	.generic_subclass = 1,
+	.supports_autosuspend =	1,
+	.id_table = onboard_hub_id_table,
+};
+
+/************************** Driver (de)registration **************************/
+
+static int __init onboard_hub_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&onboard_hub_driver);
+	if (ret)
+		return ret;
+
+	ret = usb_register_device_driver(&onboard_hub_usbdev_driver, THIS_MODULE);
+	if (ret)
+		platform_driver_unregister(&onboard_hub_driver);
+
+	return ret;
+}
+module_init(onboard_hub_init);
+
+static void __exit onboard_hub_exit(void)
+{
+	usb_deregister_device_driver(&onboard_hub_usbdev_driver);
+	platform_driver_unregister(&onboard_hub_driver);
+}
+module_exit(onboard_hub_exit);
+
+MODULE_AUTHOR("Matthias Kaehlcke <mka@chromium.org>");
+MODULE_DESCRIPTION("Driver for discrete onboard USB hubs");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/usb/onboard_hub.h b/include/linux/usb/onboard_hub.h
new file mode 100644
index 000000000000..9be52dfae653
--- /dev/null
+++ b/include/linux/usb/onboard_hub.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __LINUX_USB_ONBOARD_HUB_H
+#define __LINUX_USB_ONBOARD_HUB_H
+
+#ifdef CONFIG_USB_ONBOARD_HUB
+bool of_is_onboard_usb_hub(const struct device_node *np);
+#else
+static inline bool of_is_onboard_usb_hub(const struct device_node *np)
+{
+	return false;
+}
+#endif
+
+#endif /* __LINUX_USB_ONBOARD_HUB_H */
-- 
2.30.1.766.gb4fecdf3b7-goog

