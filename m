Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9B1324C9B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 10:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbhBYJP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 04:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbhBYJML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 04:12:11 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8224C06178C
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 01:11:30 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:bd01:18f7:df2b:b765])
        by andre.telenet-ops.be with bizsmtp
        id ZMBS2400Z3wXKmD01MBTUz; Thu, 25 Feb 2021 10:11:27 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lFCgA-001asd-Hp; Thu, 25 Feb 2021 10:11:26 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lFCgA-002sUX-0P; Thu, 25 Feb 2021 10:11:26 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] docs: driver-model: Remove obsolete device class documentation
Date:   Thu, 25 Feb 2021 10:11:24 +0100
Message-Id: <20210225091124.686078-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of this is valid since v2.5.69.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
I started updating the document, until I realized that all of the
typedefs, structures, functions, defines, and sysfs layout have been
renamed, changed, or removed.  So I think it's better (for an expert in
the field) to start from scratch.
---
 .../driver-api/driver-model/class.rst         | 149 ------------------
 .../driver-api/driver-model/index.rst         |   1 -
 2 files changed, 150 deletions(-)
 delete mode 100644 Documentation/driver-api/driver-model/class.rst

diff --git a/Documentation/driver-api/driver-model/class.rst b/Documentation/driver-api/driver-model/class.rst
deleted file mode 100644
index fff55b80e86a54a4..0000000000000000
--- a/Documentation/driver-api/driver-model/class.rst
+++ /dev/null
@@ -1,149 +0,0 @@
-==============
-Device Classes
-==============
-
-Introduction
-~~~~~~~~~~~~
-A device class describes a type of device, like an audio or network
-device. The following device classes have been identified:
-
-<Insert List of Device Classes Here>
-
-
-Each device class defines a set of semantics and a programming interface
-that devices of that class adhere to. Device drivers are the
-implementation of that programming interface for a particular device on
-a particular bus.
-
-Device classes are agnostic with respect to what bus a device resides
-on.
-
-
-Programming Interface
-~~~~~~~~~~~~~~~~~~~~~
-The device class structure looks like::
-
-
-  typedef int (*devclass_add)(struct device *);
-  typedef void (*devclass_remove)(struct device *);
-
-See the kerneldoc for the struct class.
-
-A typical device class definition would look like::
-
-  struct device_class input_devclass = {
-        .name		= "input",
-        .add_device	= input_add_device,
-	.remove_device	= input_remove_device,
-  };
-
-Each device class structure should be exported in a header file so it
-can be used by drivers, extensions and interfaces.
-
-Device classes are registered and unregistered with the core using::
-
-  int devclass_register(struct device_class * cls);
-  void devclass_unregister(struct device_class * cls);
-
-
-Devices
-~~~~~~~
-As devices are bound to drivers, they are added to the device class
-that the driver belongs to. Before the driver model core, this would
-typically happen during the driver's probe() callback, once the device
-has been initialized. It now happens after the probe() callback
-finishes from the core.
-
-The device is enumerated in the class. Each time a device is added to
-the class, the class's devnum field is incremented and assigned to the
-device. The field is never decremented, so if the device is removed
-from the class and re-added, it will receive a different enumerated
-value.
-
-The class is allowed to create a class-specific structure for the
-device and store it in the device's class_data pointer.
-
-There is no list of devices in the device class. Each driver has a
-list of devices that it supports. The device class has a list of
-drivers of that particular class. To access all of the devices in the
-class, iterate over the device lists of each driver in the class.
-
-
-Device Drivers
-~~~~~~~~~~~~~~
-Device drivers are added to device classes when they are registered
-with the core. A driver specifies the class it belongs to by setting
-the struct device_driver::devclass field.
-
-
-sysfs directory structure
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-There is a top-level sysfs directory named 'class'.
-
-Each class gets a directory in the class directory, along with two
-default subdirectories::
-
-        class/
-        `-- input
-            |-- devices
-            `-- drivers
-
-
-Drivers registered with the class get a symlink in the drivers/ directory
-that points to the driver's directory (under its bus directory)::
-
-   class/
-   `-- input
-       |-- devices
-       `-- drivers
-           `-- usb:usb_mouse -> ../../../bus/drivers/usb_mouse/
-
-
-Each device gets a symlink in the devices/ directory that points to the
-device's directory in the physical hierarchy::
-
-   class/
-   `-- input
-       |-- devices
-       |   `-- 1 -> ../../../root/pci0/00:1f.0/usb_bus/00:1f.2-1:0/
-       `-- drivers
-
-
-Exporting Attributes
-~~~~~~~~~~~~~~~~~~~~
-
-::
-
-  struct devclass_attribute {
-        struct attribute        attr;
-        ssize_t (*show)(struct device_class *, char * buf, size_t count, loff_t off);
-        ssize_t (*store)(struct device_class *, const char * buf, size_t count, loff_t off);
-  };
-
-Class drivers can export attributes using the DEVCLASS_ATTR macro that works
-similarly to the DEVICE_ATTR macro for devices. For example, a definition
-like this::
-
-  static DEVCLASS_ATTR(debug,0644,show_debug,store_debug);
-
-is equivalent to declaring::
-
-  static devclass_attribute devclass_attr_debug;
-
-The bus driver can add and remove the attribute from the class's
-sysfs directory using::
-
-  int devclass_create_file(struct device_class *, struct devclass_attribute *);
-  void devclass_remove_file(struct device_class *, struct devclass_attribute *);
-
-In the example above, the file will be named 'debug' in placed in the
-class's directory in sysfs.
-
-
-Interfaces
-~~~~~~~~~~
-There may exist multiple mechanisms for accessing the same device of a
-particular class type. Device interfaces describe these mechanisms.
-
-When a device is added to a device class, the core attempts to add it
-to every interface that is registered with the device class.
diff --git a/Documentation/driver-api/driver-model/index.rst b/Documentation/driver-api/driver-model/index.rst
index 755016422269fb6e..4831bdd92e5cd42a 100644
--- a/Documentation/driver-api/driver-model/index.rst
+++ b/Documentation/driver-api/driver-model/index.rst
@@ -7,7 +7,6 @@ Driver Model
 
    binding
    bus
-   class
    design-patterns
    device
    devres
-- 
2.25.1

