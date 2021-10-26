Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AECA43B493
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbhJZOp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:45:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:13756 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234908AbhJZOpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:45:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="253467444"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="253467444"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 07:34:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="635200360"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Oct 2021 07:34:06 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@google.com>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        "Gopal, Saranya" <saranya.gopal@intel.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/4] usb: typec: Character device for USB Power Delivery devices
Date:   Tue, 26 Oct 2021 17:33:50 +0300
Message-Id: <20211026143352.78387-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211026143352.78387-1-heikki.krogerus@linux.intel.com>
References: <20211026143352.78387-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interim.

TODO/ideas:
- Figure out a proper magic value for the ioctl and check if
  the ioctl range is OK.
- Register separate PD device for the cdev, and register it
  only if the device (port, plug or partner) actually
  supports USB PD (or come up with some other solution?).
- Introduce something like

	struct pd_request {
		struct pd_message request;
		struct pd_message __user *response;
	};

  and use it instead of only single struct pd_messages everywhere.

- Add compat support.
- What do we do with Alerts and Attentions?

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 drivers/usb/typec/Makefile                    |   2 +-
 drivers/usb/typec/class.c                     |  42 ++++
 drivers/usb/typec/class.h                     |   4 +
 drivers/usb/typec/pd-dev.c                    | 210 ++++++++++++++++++
 drivers/usb/typec/pd-dev.h                    |  15 ++
 include/linux/usb/pd_dev.h                    |  22 ++
 include/linux/usb/typec.h                     |   8 +
 include/uapi/linux/usb/pd_dev.h               |  55 +++++
 9 files changed, 358 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/typec/pd-dev.c
 create mode 100644 drivers/usb/typec/pd-dev.h
 create mode 100644 include/linux/usb/pd_dev.h
 create mode 100644 include/uapi/linux/usb/pd_dev.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 0ba463be6c588..fd443fd21f62a 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -175,6 +175,7 @@ Code  Seq#    Include File                                           Comments
 'P'   60-6F  sound/sscape_ioctl.h                                    conflict!
 'P'   00-0F  drivers/usb/class/usblp.c                               conflict!
 'P'   01-09  drivers/misc/pci_endpoint_test.c                        conflict!
+'P'   70-7F  uapi/linux/usb/pd_dev.h                                 <mailto:linux-usb@vger.kernel.org>
 'Q'   all    linux/soundcard.h
 'R'   00-1F  linux/random.h                                          conflict!
 'R'   01     linux/rfkill.h                                          conflict!
diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
index a0adb8947a301..be44528168013 100644
--- a/drivers/usb/typec/Makefile
+++ b/drivers/usb/typec/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_TYPEC)		+= typec.o
-typec-y				:= class.o mux.o bus.o port-mapper.o
+typec-y				:= class.o mux.o bus.o port-mapper.o pd-dev.o
 obj-$(CONFIG_TYPEC)		+= altmodes/
 obj-$(CONFIG_TYPEC_TCPM)	+= tcpm/
 obj-$(CONFIG_TYPEC_UCSI)	+= ucsi/
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index aeef453aa6585..19fcc5da175d7 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -15,6 +15,7 @@
 
 #include "bus.h"
 #include "class.h"
+#include "pd-dev.h"
 
 static DEFINE_IDA(typec_index_ida);
 
@@ -665,6 +666,11 @@ static const struct attribute_group *typec_partner_groups[] = {
 	NULL
 };
 
+char *typec_partner_devnode(struct device *dev, umode_t *mode, kuid_t *uid, kgid_t *gid)
+{
+	return kasprintf(GFP_KERNEL, "pd%u/partner", to_typec_port(dev->parent)->id);
+}
+
 static void typec_partner_release(struct device *dev)
 {
 	struct typec_partner *partner = to_typec_partner(dev);
@@ -676,6 +682,7 @@ static void typec_partner_release(struct device *dev)
 const struct device_type typec_partner_dev_type = {
 	.name = "typec_partner",
 	.groups = typec_partner_groups,
+	.devnode = typec_partner_devnode,
 	.release = typec_partner_release,
 };
 
@@ -807,6 +814,7 @@ struct typec_partner *typec_register_partner(struct typec_port *port,
 
 	ida_init(&partner->mode_ids);
 	partner->usb_pd = desc->usb_pd;
+	partner->pd_dev = desc->pd_dev;
 	partner->accessory = desc->accessory;
 	partner->num_altmodes = -1;
 	partner->pd_revision = desc->pd_revision;
@@ -826,6 +834,9 @@ struct typec_partner *typec_register_partner(struct typec_port *port,
 	partner->dev.type = &typec_partner_dev_type;
 	dev_set_name(&partner->dev, "%s-partner", dev_name(&port->dev));
 
+	if (partner->pd_dev)
+		partner->dev.devt = MKDEV(PD_DEV_MAJOR, port->id * 4 + 3);
+
 	ret = device_register(&partner->dev);
 	if (ret) {
 		dev_err(&port->dev, "failed to register partner (%d)\n", ret);
@@ -853,6 +864,13 @@ EXPORT_SYMBOL_GPL(typec_unregister_partner);
 /* ------------------------------------------------------------------------- */
 /* Type-C Cable Plugs */
 
+char *typec_plug_devnode(struct device *dev, umode_t *mode, kuid_t *uid, kgid_t *gid)
+{
+	return kasprintf(GFP_KERNEL, "pd%u/plug%d",
+			 to_typec_port(dev->parent->parent)->id,
+			 to_typec_plug(dev)->index);
+}
+
 static void typec_plug_release(struct device *dev)
 {
 	struct typec_plug *plug = to_typec_plug(dev);
@@ -891,6 +909,7 @@ static const struct attribute_group *typec_plug_groups[] = {
 const struct device_type typec_plug_dev_type = {
 	.name = "typec_plug",
 	.groups = typec_plug_groups,
+	.devnode = typec_plug_devnode,
 	.release = typec_plug_release,
 };
 
@@ -973,11 +992,16 @@ struct typec_plug *typec_register_plug(struct typec_cable *cable,
 	ida_init(&plug->mode_ids);
 	plug->num_altmodes = -1;
 	plug->index = desc->index;
+	plug->pd_dev = desc->pd_dev;
 	plug->dev.class = &typec_class;
 	plug->dev.parent = &cable->dev;
 	plug->dev.type = &typec_plug_dev_type;
 	dev_set_name(&plug->dev, "%s-%s", dev_name(cable->dev.parent), name);
 
+	if (plug->pd_dev)
+		plug->dev.devt = MKDEV(PD_DEV_MAJOR,
+				       to_typec_port(cable->dev.parent)->id * 4 + 1 + plug->index);
+
 	ret = device_register(&plug->dev);
 	if (ret) {
 		dev_err(&cable->dev, "failed to register plug (%d)\n", ret);
@@ -1595,6 +1619,11 @@ static int typec_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return ret;
 }
 
+char *typec_devnode(struct device *dev, umode_t *mode, kuid_t *uid, kgid_t *gid)
+{
+	return kasprintf(GFP_KERNEL, "pd%u/port", to_typec_port(dev)->id);
+}
+
 static void typec_release(struct device *dev)
 {
 	struct typec_port *port = to_typec_port(dev);
@@ -1611,6 +1640,7 @@ const struct device_type typec_port_dev_type = {
 	.name = "typec_port",
 	.groups = typec_groups,
 	.uevent = typec_uevent,
+	.devnode = typec_devnode,
 	.release = typec_release,
 };
 
@@ -2044,6 +2074,7 @@ struct typec_port *typec_register_port(struct device *parent,
 
 	port->id = id;
 	port->ops = cap->ops;
+	port->pd_dev = cap->pd_dev;
 	port->port_type = cap->type;
 	port->prefer_role = cap->prefer_role;
 
@@ -2055,6 +2086,9 @@ struct typec_port *typec_register_port(struct device *parent,
 	dev_set_name(&port->dev, "port%d", id);
 	dev_set_drvdata(&port->dev, cap->driver_data);
 
+	if (port->pd_dev)
+		port->dev.devt = MKDEV(PD_DEV_MAJOR, id * 4);
+
 	port->cap = kmemdup(cap, sizeof(*cap), GFP_KERNEL);
 	if (!port->cap) {
 		put_device(&port->dev);
@@ -2121,8 +2155,15 @@ static int __init typec_init(void)
 	if (ret)
 		goto err_unregister_mux_class;
 
+	ret = usbpd_dev_init();
+	if (ret)
+		goto err_unregister_class;
+
 	return 0;
 
+err_unregister_class:
+	class_unregister(&typec_class);
+
 err_unregister_mux_class:
 	class_unregister(&typec_mux_class);
 
@@ -2135,6 +2176,7 @@ subsys_initcall(typec_init);
 
 static void __exit typec_exit(void)
 {
+	usbpd_dev_exit();
 	class_unregister(&typec_class);
 	ida_destroy(&typec_index_ida);
 	bus_unregister(&typec_bus);
diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
index aef03eb7e1523..87c072f2ad753 100644
--- a/drivers/usb/typec/class.h
+++ b/drivers/usb/typec/class.h
@@ -14,6 +14,7 @@ struct typec_plug {
 	enum typec_plug_index		index;
 	struct ida			mode_ids;
 	int				num_altmodes;
+	const struct pd_dev		*pd_dev;
 };
 
 struct typec_cable {
@@ -33,6 +34,7 @@ struct typec_partner {
 	int				num_altmodes;
 	u16				pd_revision; /* 0300H = "3.0" */
 	enum usb_pd_svdm_ver		svdm_version;
+	const struct pd_dev		*pd_dev;
 };
 
 struct typec_port {
@@ -59,6 +61,8 @@ struct typec_port {
 	struct mutex			port_list_lock; /* Port list lock */
 
 	void				*pld;
+
+	const struct pd_dev		*pd_dev;
 };
 
 #define to_typec_port(_dev_) container_of(_dev_, struct typec_port, dev)
diff --git a/drivers/usb/typec/pd-dev.c b/drivers/usb/typec/pd-dev.c
new file mode 100644
index 0000000000000..436853e046ce4
--- /dev/null
+++ b/drivers/usb/typec/pd-dev.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USB Power Delivery /dev entries
+ *
+ * Copyright (C) 2021 Intel Corporation
+ * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
+ */
+
+#include <linux/cdev.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/usb/pd_dev.h>
+
+#include "class.h"
+
+#define PD_DEV_MAX (MINORMASK + 1)
+
+dev_t usbpd_devt;
+static struct cdev usb_pd_cdev;
+
+struct pddev {
+	struct device *dev;
+	struct typec_port *port;
+	const struct pd_dev *pd_dev;
+};
+
+static ssize_t usbpd_read(struct file *file, char __user *buf, size_t count, loff_t *offset)
+{
+	/* FIXME TODO XXX */
+
+	/* Alert and Attention handling here (with poll) ? */
+
+	return 0;
+}
+
+static long usbpd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct pddev *pd = file->private_data;
+	void __user *p = (void __user *)arg;
+	unsigned int pwr_role;
+	struct pd_message msg;
+	u32 configuration;
+	int ret = 0;
+
+	switch (cmd) {
+	case USBPDDEV_INFO:
+		if (copy_to_user(p, pd->pd_dev->info, sizeof(*pd->pd_dev->info)))
+			return -EFAULT;
+		break;
+	case USBPDDEV_CONFIGURE:
+		if (!pd->pd_dev->ops->configure)
+			return -ENOTTY;
+
+		if (copy_from_user(&configuration, p, sizeof(configuration)))
+			return -EFAULT;
+
+		ret = pd->pd_dev->ops->configure(pd->pd_dev, configuration);
+		if (ret)
+			return ret;
+		break;
+	case USBPDDEV_PWR_ROLE:
+		if (is_typec_plug(pd->dev))
+			return -ENOTTY;
+
+		if (is_typec_partner(pd->dev)) {
+			if (pd->port->pwr_role == TYPEC_SINK)
+				pwr_role = TYPEC_SOURCE;
+			else
+				pwr_role = TYPEC_SINK;
+		} else {
+			pwr_role = pd->port->pwr_role;
+		}
+
+		if (copy_to_user(p, &pwr_role, sizeof(unsigned int)))
+			return -EFAULT;
+		break;
+	case USBPDDEV_GET_MESSAGE:
+		if (!pd->pd_dev->ops->get_message)
+			return -ENOTTY;
+
+		if (copy_from_user(&msg, p, sizeof(msg)))
+			return -EFAULT;
+
+		ret = pd->pd_dev->ops->get_message(pd->pd_dev, &msg);
+		if (ret)
+			return ret;
+
+		if (copy_to_user(p, &msg, sizeof(msg)))
+			return -EFAULT;
+		break;
+	case USBPDDEV_SET_MESSAGE:
+		if (!pd->pd_dev->ops->set_message)
+			return -ENOTTY;
+
+		ret = pd->pd_dev->ops->set_message(pd->pd_dev, &msg);
+		if (ret)
+			return ret;
+
+		if (copy_to_user(p, &msg, sizeof(msg)))
+			return -EFAULT;
+		break;
+	case USBPDDEV_SUBMIT_MESSAGE:
+		if (!pd->pd_dev->ops->submit)
+			return -ENOTTY;
+
+		if (copy_from_user(&msg, p, sizeof(msg)))
+			return -EFAULT;
+
+		ret = pd->pd_dev->ops->submit(pd->pd_dev, &msg);
+		if (ret)
+			return ret;
+
+		if (copy_to_user(p, &msg, sizeof(msg)))
+			return -EFAULT;
+		break;
+	default:
+		return -ENOTTY;
+	}
+
+	return 0;
+}
+
+static int usbpd_open(struct inode *inode, struct file *file)
+{
+	struct device *dev;
+	struct pddev *pd;
+
+	dev = class_find_device_by_devt(&typec_class, inode->i_rdev);
+	if (!dev)
+		return -ENODEV;
+
+	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
+	if (!pd) {
+		put_device(dev);
+		return -ENOMEM;
+	}
+
+	if (is_typec_partner(dev)) {
+		if (!to_typec_partner(dev)->usb_pd) {
+			put_device(dev);
+			kfree(pd);
+			return -ENODEV;
+		}
+		pd->port = to_typec_port(dev->parent);
+		pd->pd_dev = to_typec_partner(dev)->pd_dev;
+	} else if (is_typec_plug(dev)) {
+		pd->port = to_typec_port(dev->parent->parent);
+		pd->pd_dev = to_typec_plug(dev)->pd_dev;
+	} else {
+		pd->port = to_typec_port(dev);
+		pd->pd_dev = to_typec_port(dev)->pd_dev;
+	}
+
+	pd->dev = dev;
+	file->private_data = pd;
+
+	return 0;
+}
+
+static int usbpd_release(struct inode *inode, struct file *file)
+{
+	struct pddev *pd = file->private_data;
+
+	put_device(pd->dev);
+	kfree(pd);
+
+	return 0;
+}
+
+const struct file_operations usbpd_file_operations = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= usbpd_read,
+	.unlocked_ioctl = usbpd_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
+	.open		= usbpd_open,
+	.release	= usbpd_release,
+};
+
+int __init usbpd_dev_init(void)
+{
+	int ret;
+
+	ret = alloc_chrdev_region(&usbpd_devt, 0, PD_DEV_MAX, "usb_pd");
+	if (ret)
+		return ret;
+
+	/*
+	 * FIXME!
+	 *
+	 * Now the cdev is always created, even when the device does not support
+	 * USB PD.
+	 */
+
+	cdev_init(&usb_pd_cdev, &usbpd_file_operations);
+
+	ret = cdev_add(&usb_pd_cdev, usbpd_devt, PD_DEV_MAX);
+	if (ret) {
+		unregister_chrdev_region(usbpd_devt, PD_DEV_MAX);
+		return ret;
+	}
+
+	return 0;
+}
+
+void __exit usbpd_dev_exit(void)
+{
+	cdev_del(&usb_pd_cdev);
+	unregister_chrdev_region(usbpd_devt, PD_DEV_MAX);
+}
diff --git a/drivers/usb/typec/pd-dev.h b/drivers/usb/typec/pd-dev.h
new file mode 100644
index 0000000000000..2d817167c4042
--- /dev/null
+++ b/drivers/usb/typec/pd-dev.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __USB_TYPEC_PDDEV__
+#define __USB_TYPEC_PDDEV__
+
+#include <linux/kdev_t.h>
+
+#define PD_DEV_MAJOR	MAJOR(usbpd_devt)
+
+extern dev_t usbpd_devt;
+
+int usbpd_dev_init(void);
+void usbpd_dev_exit(void);
+
+#endif /* __USB_TYPEC_PDDEV__ */
diff --git a/include/linux/usb/pd_dev.h b/include/linux/usb/pd_dev.h
new file mode 100644
index 0000000000000..d451928f94e78
--- /dev/null
+++ b/include/linux/usb/pd_dev.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __LINUX_USB_PDDEV_H
+#define __LINUX_USB_PDDEV_H
+
+#include <uapi/linux/usb/pd_dev.h>
+
+struct pd_dev;
+
+struct pd_ops {
+	int (*configure)(const struct pd_dev *dev, u32 flags);
+	int (*get_message)(const struct pd_dev *dev, struct pd_message *msg);
+	int (*set_message)(const struct pd_dev *dev, struct pd_message *msg);
+	int (*submit)(const struct pd_dev *dev, struct pd_message *msg);
+};
+
+struct pd_dev {
+	const struct pd_info *info;
+	const struct pd_ops *ops;
+};
+
+#endif /* __LINUX_USB_PDDEV_H */
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index e2e44bb1dad85..6df7b096f769c 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -20,6 +20,7 @@ struct typec_port;
 struct typec_altmode_ops;
 
 struct fwnode_handle;
+struct pd_dev;
 struct device;
 
 enum typec_port_type {
@@ -159,11 +160,13 @@ enum typec_plug_index {
  * struct typec_plug_desc - USB Type-C Cable Plug Descriptor
  * @index: SOP Prime for the plug connected to DFP and SOP Double Prime for the
  *         plug connected to UFP
+ * @pd_dev: USB Power Delivery Character Device
  *
  * Represents USB Type-C Cable Plug.
  */
 struct typec_plug_desc {
 	enum typec_plug_index	index;
+	const struct pd_dev	*pd_dev;
 };
 
 /*
@@ -189,6 +192,7 @@ struct typec_cable_desc {
  * @accessory: Audio, Debug or none.
  * @identity: Discover Identity command data
  * @pd_revision: USB Power Delivery Specification Revision if supported
+ * @pd_dev: USB Power Delivery Character Device
  *
  * Details about a partner that is attached to USB Type-C port. If @identity
  * member exists when partner is registered, a directory named "identity" is
@@ -204,6 +208,7 @@ struct typec_partner_desc {
 	enum typec_accessory	accessory;
 	struct usb_pd_identity	*identity;
 	u16			pd_revision; /* 0300H = "3.0" */
+	const struct pd_dev	*pd_dev;
 };
 
 /**
@@ -241,6 +246,7 @@ enum usb_pd_svdm_ver {
  * @fwnode: Optional fwnode of the port
  * @driver_data: Private pointer for driver specific info
  * @ops: Port operations vector
+ * @pd_dev: USB Power Delivery Character Device
  *
  * Static capabilities of a single USB Type-C port.
  */
@@ -258,6 +264,8 @@ struct typec_capability {
 	void			*driver_data;
 
 	const struct typec_operations	*ops;
+
+	const struct pd_dev	*pd_dev;
 };
 
 /* Specific to try_role(). Indicates the user want's to clear the preference. */
diff --git a/include/uapi/linux/usb/pd_dev.h b/include/uapi/linux/usb/pd_dev.h
new file mode 100644
index 0000000000000..44027bc6b6339
--- /dev/null
+++ b/include/uapi/linux/usb/pd_dev.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _UAPI__LINUX_USB_PDDEV_H
+#define _UAPI__LINUX_USB_PDDEV_H
+
+#include <linux/types.h>
+#include <linux/usb/pd.h>
+
+/*
+ * struct pd_info - USB Power Delivery Device Information
+ * @specification_revision: USB Power Delivery Specification Revision
+ * @supported_ctrl_msgs: Supported Control Messages
+ * @supported_data_msgs: Supported Data Messages
+ * @supported_ext_msgs: Supported Extended Messages
+ *
+ * @specification_revision is in the same format as the Specification Revision
+ * Field in the Message Header. @supported_ctrl_msgs, @supported_data_msgs and
+ * @supported_ext_msgs list the messages, a bit for each, that can be used with
+ * USBPDDEV_SUBMIT_MESSAGE ioctl.
+ */
+struct pd_info {
+	__u8 specification_revision; /* XXX I don't know if this is useful? */
+	__u32 ctrl_msgs_supported;
+	__u32 data_msgs_supported;
+	__u32 ext_msgs_supported;
+} __attribute__ ((packed));
+
+/* Example configuration flags for ports. */
+#define USBPDDEV_CFPORT_ENTER_MODES	BIT(0) /* Automatic alt mode entry. */
+
+/*
+ * For basic communication use USBPDDEV_SUBMIT_MESSAGE ioctl. GoodCRC is not
+ * supported. Response will also never be GoodCRC.
+ *
+ * To check cached objects (if they are cached) use USBPDDEV_GET_MESSAGE ioctl.
+ * Useful most likely with RDO and EUDO, but also with Identity etc.
+ * USBPDDEV_SET_MESSAGE is primarily meant to be used with ports. If supported,
+ * it can be used to assign the values for objects like EUDO that the port should
+ * use in future communication.
+ *
+ * The idea with USBPDDEV_CONFIGURE is that you could modify the behaviour of
+ * the underlying TCPM (or what ever interface you have) with some things. So
+ * for example, you could disable automatic alternate mode entry with it with
+ * that USBPDDEV_CFPORT_ENTER_MODES - It's just an example! - so basically, you
+ * could take over some things from TCPM with it.
+ */
+
+#define USBPDDEV_INFO		_IOR('P', 0x70, struct pd_info)
+#define USBPDDEV_CONFIGURE	_IOW('P', 0x71, __u32)
+#define USBPDDEV_PWR_ROLE	_IOR('P', 0x72, int) /* The *current* role! */
+#define USBPDDEV_GET_MESSAGE	_IOWR('P', 0x73, struct pd_message)
+#define USBPDDEV_SET_MESSAGE	_IOW('P', 0x74, struct pd_message)
+#define USBPDDEV_SUBMIT_MESSAGE	_IOWR('P', 0x75, struct pd_message)
+
+#endif /* _UAPI__LINUX_USB_PDDEV_H */
-- 
2.33.0

