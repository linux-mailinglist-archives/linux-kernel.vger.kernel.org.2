Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062F33533F8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 14:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbhDCMBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 08:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbhDCMBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 08:01:04 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8808C0613E6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 05:01:01 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id h8so3599135plt.7
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 05:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iroyHTNJPayrVAXpDAXqHoA24HMKA1INuB3nlq5+avQ=;
        b=tNA62n/S6nZ9yI7AVZl8bjuaNN51gzR+f8rhJXMIaBeH4/m4cb8yWFmAzt7+z+mCL3
         3dDBZaLtDDIgNamKEQsK2iNUSIg7iEhaP/nIcUWomBF9i/WqftG2eZm2C4tVsYH5JrpZ
         gNstMWlMNiFZSceJkHS1XLbjKabFsO4RhZ18uoJW4R+cJNgmu3oCDvVQsZtvCzvFuiXu
         /r0qIsyQ85w6216OpT1KuepVd6U5/4pgo6mNjvCra6bSn7EMZVf58s0m5sXGMrhmscWL
         2qeZL23BO6h8CJNjxt6864Jy6inkvucOP+maplwpYOKoEbU1dqPzsgdupeyUY9s+0I5F
         N88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iroyHTNJPayrVAXpDAXqHoA24HMKA1INuB3nlq5+avQ=;
        b=OvgBdSY0cvlz77xRZ4vRR1CSoa3KUY/W6T+wfJ+YDRb/Na+IwPBvBHLhal44bedjGd
         c3nesTH3mAfJ2FwEgvI2CjZaP3eAzUdBnPrXQr1qBbBqHx+yFY0YNwA3GzliE3YSSK8B
         i/cuHMjSYCSzzhMLZG23S9q8dt6DXxeHKJLuCunW6GcjS6t+Ir6cPeQPniX5fGJs73wi
         QQjX0N+pg3YZozzIXNGmj7t6MuwKyr3M5QhKqKcqfAwQzjJh6ds25cIwqlFUzl0SdB8D
         hNvrSE27vV1U7wHXNHeNwKyG5wK3OcuVuElF7+gOhuTo6uFBWgMjVjKt/gkahGgEficv
         mFaw==
X-Gm-Message-State: AOAM530Ag5IlHoKF1TyI+oln0ZbApvw1yq/gJCk8yJSz0AkfNeYTtLui
        LYSuBiDZfWI94BZiimVITklt
X-Google-Smtp-Source: ABdhPJz0ZhLVxWaznlUl2dz406DyrC4TCJr11aOvL5vAKcoPhqK1b66ZlJKWpMX+zjl89j+2zbqyoQ==
X-Received: by 2002:a17:90a:3d01:: with SMTP id h1mr18476605pjc.124.1617451260894;
        Sat, 03 Apr 2021 05:01:00 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.190])
        by smtp.gmail.com with ESMTPSA id g21sm10748187pjl.28.2021.04.03.05.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 05:01:00 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     corbet@lwn.net
Cc:     gregkh@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] docs: driver-model: Update the documentation for device class
Date:   Sat,  3 Apr 2021 17:30:50 +0530
Message-Id: <20210403120050.4756-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current documentation about the device class is out of date such
that it refers to non-existent APIs and structures. This commit updates
them to the current device class APIs and structures, removes wordings
that no longer valid while trying to keep the original content intact.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../driver-api/driver-model/class.rst         | 144 ++++++++----------
 1 file changed, 66 insertions(+), 78 deletions(-)

diff --git a/Documentation/driver-api/driver-model/class.rst b/Documentation/driver-api/driver-model/class.rst
index fff55b80e86a..4e1779a37939 100644
--- a/Documentation/driver-api/driver-model/class.rst
+++ b/Documentation/driver-api/driver-model/class.rst
@@ -5,12 +5,7 @@ Device Classes
 Introduction
 ~~~~~~~~~~~~
 A device class describes a type of device, like an audio or network
-device. The following device classes have been identified:
-
-<Insert List of Device Classes Here>
-
-
-Each device class defines a set of semantics and a programming interface
+device. It defines a set of semantics and a programming interface
 that devices of that class adhere to. Device drivers are the
 implementation of that programming interface for a particular device on
 a particular bus.
@@ -18,23 +13,27 @@ a particular bus.
 Device classes are agnostic with respect to what bus a device resides
 on.
 
-
 Programming Interface
 ~~~~~~~~~~~~~~~~~~~~~
 The device class structure looks like::
 
+  struct class {
+        const char              *name;
+        struct module           *owner;
 
-  typedef int (*devclass_add)(struct device *);
-  typedef void (*devclass_remove)(struct device *);
+        const struct attribute_group    **class_groups;
+        const struct attribute_group    **dev_groups;
+        struct kobject                  *dev_kobj;
+        ...
+  };
 
 See the kerneldoc for the struct class.
 
 A typical device class definition would look like::
 
-  struct device_class input_devclass = {
-        .name		= "input",
-        .add_device	= input_add_device,
-	.remove_device	= input_remove_device,
+  struct class input_class = {
+        .name           = "input",
+        .dev_release    = input_dev_release,
   };
 
 Each device class structure should be exported in a header file so it
@@ -42,101 +41,84 @@ can be used by drivers, extensions and interfaces.
 
 Device classes are registered and unregistered with the core using::
 
-  int devclass_register(struct device_class * cls);
-  void devclass_unregister(struct device_class * cls);
-
+  int class_register(struct class *class);
+  void class_unregister(struct class *class);
 
 Devices
 ~~~~~~~
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
+When a device is added, it is also added to the 'klist_devices' inside
+the 'subsys_private' struct of the class. Later, the devices belonging
+to the class are accessed using::
 
+  class_dev_iter_next()
+  class_find_device()
+  class_find_device_by_name()
 
-Device Drivers
-~~~~~~~~~~~~~~
-Device drivers are added to device classes when they are registered
-with the core. A driver specifies the class it belongs to by setting
-the struct device_driver::devclass field.
+It is also possible to access the devices of a class in a platform
+dependent way using::
 
+  class_find_device_by_of_node()
+  class_find_device_by_acpi_dev()
 
 sysfs directory structure
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 There is a top-level sysfs directory named 'class'.
 
-Each class gets a directory in the class directory, along with two
-default subdirectories::
+Each class gets a directory in the top-level class directory::
 
-        class/
-        `-- input
-            |-- devices
-            `-- drivers
+  class/
+      |-- input
+      |-- block
+      |-- drm
+      |-- nvme
 
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
+Each device gets a symlink in the class directory that points to the
 device's directory in the physical hierarchy::
 
-   class/
-   `-- input
-       |-- devices
-       |   `-- 1 -> ../../../root/pci0/00:1f.0/usb_bus/00:1f.2-1:0/
-       `-- drivers
-
+  class/
+  |-- input
+           |-- input0 -> ../../devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
+           |-- input1 -> ../../devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input1
+           |-- event0 -> ../../devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0/event0
+           `-- event1 -> ../../devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input1/event1
 
 Exporting Attributes
 ~~~~~~~~~~~~~~~~~~~~
 
 ::
 
-  struct devclass_attribute {
-        struct attribute        attr;
-        ssize_t (*show)(struct device_class *, char * buf, size_t count, loff_t off);
-        ssize_t (*store)(struct device_class *, const char * buf, size_t count, loff_t off);
+  struct class_attribute {
+        struct attribute attr;
+        ssize_t (*show)(struct class *class, struct class_attribute *attr,
+                        char *buf);
+        ssize_t (*store)(struct class *class, struct class_attribute *attr,
+                        const char *buf, size_t count);
   };
 
-Class drivers can export attributes using the DEVCLASS_ATTR macro that works
-similarly to the DEVICE_ATTR macro for devices. For example, a definition
+Class drivers can export attributes using the CLASS_ATTR_* macros that works
+similarly to the DEVICE_ATTR_* macros for devices. For example, a definition
 like this::
 
-  static DEVCLASS_ATTR(debug,0644,show_debug,store_debug);
+  static CLASS_ATTR_RW(debug, 0644, show_debug, store_debug);
 
 is equivalent to declaring::
 
-  static devclass_attribute devclass_attr_debug;
+  static struct class_attribute class_attr_debug = {
+        .attr = {
+              .name = debug,
+              .mode = 0644,
+        },
+        .show = show_debug,
+        .store = store_debug,
+  };
 
-The bus driver can add and remove the attribute from the class's
-sysfs directory using::
+The drivers can add and remove the attribute from the class's sysfs
+directory using::
 
-  int devclass_create_file(struct device_class *, struct devclass_attribute *);
-  void devclass_remove_file(struct device_class *, struct devclass_attribute *);
+  int class_create_file(struct class *, struct class_attribute *);
+  void class_remove_file(struct class *, struct class_attribute *);
 
-In the example above, the file will be named 'debug' in placed in the
+In the example above, a file named 'debug' will be placed in the
 class's directory in sysfs.
 
 
@@ -146,4 +128,10 @@ There may exist multiple mechanisms for accessing the same device of a
 particular class type. Device interfaces describe these mechanisms.
 
 When a device is added to a device class, the core attempts to add it
-to every interface that is registered with the device class.
+to every interface that is registered with the device class. The
+interfaces can be added and removed from the class using::
+
+  int class_interface_register(struct class_interface *);
+  void class_interface_unregister(struct class_interface *);
+
+For further information, see <linux/device/class.h>.
-- 
2.25.1

