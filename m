Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8D83563C4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 08:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345453AbhDGGLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 02:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhDGGLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 02:11:10 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79170C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 23:11:01 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id a12so12142153pfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 23:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qN2XxlGY2OIXErKZ6g1JabWGOxHjV2Xn6BdTpqiouq0=;
        b=G2GpSwgGO0eLsKs0J8GJlvP7VcKTBZSKUpFvXd8GUazuGyTV4n+urYTL3bZ7Cijpqz
         jQ4dvtIbrp0bqvgmlR+QHZ+9CgYwSXQkY6/DxR2NNw2gqz/KtISUvgvdmM8mMv+GhQK6
         36iDiXNBtv/6UKkzRWqVBh08uTXZmoPDa1tH5Y87jmzISCKXu9tz4HkESOAjD9pp3vpK
         xGOrLTz02Kkfl6eyEPcWABQLqwr54yOn0CrjiKkRBqMj9a+4Z4aPLTxlD3uoAQm9G7Fa
         9OwQts5drrKREYrViwHLMEFP4/Z26mwPew4SkZSXm2YLW2L9UDccVpA6XKQpQ61vUibO
         LYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qN2XxlGY2OIXErKZ6g1JabWGOxHjV2Xn6BdTpqiouq0=;
        b=sQ4wglp4Ru/8IZJBkMkuviq10QjSEyO+XmncogMJsm+cFuhrQB8xOpLuZ16pcnN2Ny
         vrQsd/6HbbuMAiwRZNZ9+62y7gblYKLbwefLHUMiQ0isShfhrdB7xggd19WC62GVZL9c
         Ci1JAbx/b+rOt2FlRyIjCTkXrXUyRoqUIQVWDAl4nIhSxauop2XP5qj7jn0S1p7qL1Xd
         20z2GYQrF/rfDaOZ20B4DdswxnvSErCBlB+9MVcmr6l6UO8/sjWvg/LBGtpzaqmRaeDE
         eTUquNxoX+RXmcpbj38/bbw6tS9FpxZLo4uSiQ0RY7/wddY//Lsj3AC4KvCAawRyr6g6
         vmUg==
X-Gm-Message-State: AOAM532UYuP60o90KAO79+J7RD71TxANbLJFjnlUyVUy0nSkMlDwkWfC
        MAiFYL/JyUwDTZgPVztsYs+k
X-Google-Smtp-Source: ABdhPJxby9uKxxSgM9DQBkqitzAxtSbeTb+1IHwCItJj3cxPfhl6hy6fUqj3VxBF4RBmsGDQtYY/Qg==
X-Received: by 2002:a05:6a00:24c2:b029:23d:9cba:5491 with SMTP id d2-20020a056a0024c2b029023d9cba5491mr1665681pfv.54.1617775860839;
        Tue, 06 Apr 2021 23:11:00 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.180])
        by smtp.gmail.com with ESMTPSA id q13sm3648700pfc.86.2021.04.06.23.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:11:00 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     corbet@lwn.net
Cc:     gregkh@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2] docs: driver-model: Update the documentation for device class
Date:   Wed,  7 Apr 2021 11:40:53 +0530
Message-Id: <20210407061053.81940-1-manivannan.sadhasivam@linaro.org>
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

Changes in v2:

* Fixed CLASS_ATTR_RW as spotted by Greg

 .../driver-api/driver-model/class.rst         | 144 ++++++++----------
 1 file changed, 66 insertions(+), 78 deletions(-)

diff --git a/Documentation/driver-api/driver-model/class.rst b/Documentation/driver-api/driver-model/class.rst
index fff55b80e86a..87441f4ac4ac 100644
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
+  static CLASS_ATTR_RW(debug);
 
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

