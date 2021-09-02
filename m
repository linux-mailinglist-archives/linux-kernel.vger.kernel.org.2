Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7923FF3C7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 21:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347285AbhIBTG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 15:06:27 -0400
Received: from pbmsgap02.intersil.com ([192.157.179.202]:54572 "EHLO
        pbmsgap02.intersil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347090AbhIBTG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 15:06:26 -0400
X-Greylist: delayed 1139 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Sep 2021 15:06:26 EDT
Received: from pps.filterd (pbmsgap02.intersil.com [127.0.0.1])
        by pbmsgap02.intersil.com (8.16.0.42/8.16.0.42) with SMTP id 182Ih335014591;
        Thu, 2 Sep 2021 14:46:24 -0400
Received: from pbmxdp01.intersil.corp (pbmxdp01.pb.intersil.com [132.158.200.222])
        by pbmsgap02.intersil.com with ESMTP id 3asy34gwu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 02 Sep 2021 14:46:24 -0400
Received: from pbmxdp02.intersil.corp (132.158.200.223) by
 pbmxdp01.intersil.corp (132.158.200.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.2242.4; Thu, 2 Sep 2021 14:46:22 -0400
Received: from localhost (132.158.202.109) by pbmxdp02.intersil.corp
 (132.158.200.223) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 2 Sep 2021 14:46:22 -0400
From:   <min.li.xe@renesas.com>
To:     <derek.kiernan@xilinx.com>, <dragan.cvetic@xilinx.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, Min Li <min.li.xe@renesas.com>
Subject: [PATCH misc] misc: Add Renesas Synchronization Management Unit (SMU) support
Date:   Thu, 2 Sep 2021 14:45:53 -0400
Message-ID: <1630608353-7606-1-git-send-email-min.li.xe@renesas.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-MML: disable
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: GRgv0hbjAnohdfqdGb33zWoeGZNn6pra
X-Proofpoint-ORIG-GUID: GRgv0hbjAnohdfqdGb33zWoeGZNn6pra
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-02_04:2021-09-02,2021-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=junk_notspam policy=junk score=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109020104
X-Proofpoint-Spam-Reason: mlx
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Min Li <min.li.xe@renesas.com>

This driver is developed for the IDT ClockMatrix(TM) and 82P33xxx families
of timing and synchronization devices.It will be used by Renesas PTP Clock
Manager for Linux (pcm4l) software to provide support to GNSS assisted
partial timing support (APTS) and other networking timing functions.

Current version provides kernel API's to support the following functions
-set combomode to enable SYNCE clock support
-read dpll's state to determine if the dpll is locked to the GNSS channel
-read dpll's ffo (fractional frequency offset) in ppqt

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
 drivers/misc/Kconfig      |   9 ++
 drivers/misc/Makefile     |   2 +
 drivers/misc/rsmu_cdev.c  | 239 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/misc/rsmu_cdev.h  |  77 +++++++++++++++
 drivers/misc/rsmu_cm.c    | 164 +++++++++++++++++++++++++++++++
 drivers/misc/rsmu_sabre.c | 133 ++++++++++++++++++++++++++
 include/uapi/linux/rsmu.h |  66 +++++++++++++
 7 files changed, 690 insertions(+)
 create mode 100644 drivers/misc/rsmu_cdev.c
 create mode 100644 drivers/misc/rsmu_cdev.h
 create mode 100644 drivers/misc/rsmu_cm.c
 create mode 100644 drivers/misc/rsmu_sabre.c
 create mode 100644 include/uapi/linux/rsmu.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 85ba901..6ed5a18 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -469,6 +469,15 @@ config HISI_HIKEY_USB
 	  switching between the dual-role USB-C port and the USB-A host ports
 	  using only one USB controller.
 
+config RSMU
+	tristate "Renesas Synchronization Management Unit (SMU)"
+	help
+	  This option enables support for the IDT ClockMatrix(TM) and 82P33xxx
+	  families of timing and synchronization devices. It will be used by
+	  Renesas PTP Clock Manager for Linux (pcm4l) software to provide support
+	  for GNSS assisted partial timing support (APTS) and other networking
+	  timing functions.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index a086197..bde748d 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -59,3 +59,5 @@ obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
 obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
 obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
+rsmu-objs			:= rsmu_cdev.o rsmu_cm.o rsmu_sabre.o
+obj-$(CONFIG_RSMU)		+= rsmu.o
diff --git a/drivers/misc/rsmu_cdev.c b/drivers/misc/rsmu_cdev.c
new file mode 100644
index 0000000..8e856a6
--- /dev/null
+++ b/drivers/misc/rsmu_cdev.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * This driver is developed for the IDT ClockMatrix(TM) and 82P33xxx families
+ * of timing and synchronization devices. It will be used by Renesas PTP Clock
+ * Manager for Linux (pcm4l) software to provide support to GNSS assisted
+ * partial timing support (APTS) and other networking timing functions.
+ *
+ * Please note it must work with Renesas MFD driver to access device through
+ * I2C/SPI.
+ *
+ * Copyright (C) 2019 Integrated Device Technology, Inc., a Renesas Company.
+ */
+
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/mfd/rsmu.h>
+#include <uapi/linux/rsmu.h>
+#include "rsmu_cdev.h"
+
+static DEFINE_IDA(rsmu_cdev_map);
+
+static struct rsmu_ops *ops_array[] = {
+	[0] = &cm_ops,
+	[1] = &sabre_ops,
+};
+
+static int
+rsmu_set_combomode(struct rsmu_cdev *rsmu, void __user *arg)
+{
+	struct rsmu_ops *ops = rsmu->ops;
+	struct rsmu_combomode mode;
+	int err;
+
+	if (copy_from_user(&mode, arg, sizeof(mode)))
+		return -EFAULT;
+
+	if (ops->set_combomode == NULL)
+		return -EOPNOTSUPP;
+
+	mutex_lock(rsmu->lock);
+	err = ops->set_combomode(rsmu, mode.dpll, mode.mode);
+	mutex_unlock(rsmu->lock);
+
+	return err;
+}
+
+static int
+rsmu_get_dpll_state(struct rsmu_cdev *rsmu, void __user *arg)
+{
+	struct rsmu_ops *ops = rsmu->ops;
+	struct rsmu_get_state state_request;
+	u8 state;
+	int err;
+
+	if (copy_from_user(&state_request, arg, sizeof(state_request)))
+		return -EFAULT;
+
+	if (ops->get_dpll_state == NULL)
+		return -EOPNOTSUPP;
+
+	mutex_lock(rsmu->lock);
+	err = ops->get_dpll_state(rsmu, state_request.dpll, &state);
+	mutex_unlock(rsmu->lock);
+
+	state_request.state = state;
+	if (copy_to_user(arg, &state_request, sizeof(state_request)))
+		return -EFAULT;
+
+	return err;
+}
+
+static int
+rsmu_get_dpll_ffo(struct rsmu_cdev *rsmu, void __user *arg)
+{
+	struct rsmu_ops *ops = rsmu->ops;
+	struct rsmu_get_ffo ffo_request;
+	int err;
+
+	if (copy_from_user(&ffo_request, arg, sizeof(ffo_request)))
+		return -EFAULT;
+
+	if (ops->get_dpll_ffo == NULL)
+		return -EOPNOTSUPP;
+
+	mutex_lock(rsmu->lock);
+	err = ops->get_dpll_ffo(rsmu, ffo_request.dpll, &ffo_request);
+	mutex_unlock(rsmu->lock);
+
+	if (copy_to_user(arg, &ffo_request, sizeof(ffo_request)))
+		return -EFAULT;
+
+	return err;
+}
+
+static struct rsmu_cdev *file2rsmu(struct file *file)
+{
+	return container_of(file->private_data, struct rsmu_cdev, miscdev);
+}
+
+static long
+rsmu_ioctl(struct file *fptr, unsigned int cmd, unsigned long data)
+{
+	struct rsmu_cdev *rsmu = file2rsmu(fptr);
+	void __user *arg = (void __user *)data;
+	int err = 0;
+
+	switch (cmd) {
+	case RSMU_SET_COMBOMODE:
+		err = rsmu_set_combomode(rsmu, arg);
+		break;
+	case RSMU_GET_STATE:
+		err = rsmu_get_dpll_state(rsmu, arg);
+		break;
+	case RSMU_GET_FFO:
+		err = rsmu_get_dpll_ffo(rsmu, arg);
+		break;
+	default:
+		/* Should not get here */
+		dev_err(rsmu->dev, "Undefined RSMU IOCTL");
+		err = -EINVAL;
+		break;
+	}
+
+	return err;
+}
+
+static long rsmu_compat_ioctl(struct file *fptr, unsigned int cmd,
+			      unsigned long data)
+{
+	return rsmu_ioctl(fptr, cmd, data);
+}
+
+static const struct file_operations rsmu_fops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = rsmu_ioctl,
+	.compat_ioctl =	rsmu_compat_ioctl,
+};
+
+static int rsmu_init_ops(struct rsmu_cdev *rsmu)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ops_array); i++)
+		if (ops_array[i]->type == rsmu->type)
+			break;
+
+	if (i == ARRAY_SIZE(ops_array))
+		return -EINVAL;
+
+	rsmu->ops = ops_array[i];
+	return 0;
+}
+
+static int
+rsmu_probe(struct platform_device *pdev)
+{
+	struct rsmu_ddata *ddata = dev_get_drvdata(pdev->dev.parent);
+	struct rsmu_cdev *rsmu;
+	int err;
+
+	rsmu = devm_kzalloc(&pdev->dev, sizeof(*rsmu), GFP_KERNEL);
+	if (!rsmu)
+		return -ENOMEM;
+
+	/* Save driver private data */
+	platform_set_drvdata(pdev, rsmu);
+
+	rsmu->dev = &pdev->dev;
+	rsmu->mfd = pdev->dev.parent;
+	rsmu->type = ddata->type;
+	rsmu->lock = &ddata->lock;
+	rsmu->regmap = ddata->regmap;
+	rsmu->index = ida_simple_get(&rsmu_cdev_map, 0, MINORMASK + 1, GFP_KERNEL);
+	if (rsmu->index < 0) {
+		dev_err(rsmu->dev, "Unable to get index %d\n", rsmu->index);
+		return rsmu->index;
+	}
+	snprintf(rsmu->name, sizeof(rsmu->name), "rsmu%d", rsmu->index);
+
+	err = rsmu_init_ops(rsmu);
+	if (err) {
+		dev_err(rsmu->dev, "Unknown SMU type %d", rsmu->type);
+		ida_simple_remove(&rsmu_cdev_map, rsmu->index);
+		return err;
+	}
+
+	/* Initialize and register the miscdev */
+	rsmu->miscdev.minor = MISC_DYNAMIC_MINOR;
+	rsmu->miscdev.fops = &rsmu_fops;
+	rsmu->miscdev.name = rsmu->name;
+	err = misc_register(&rsmu->miscdev);
+	if (err) {
+		dev_err(rsmu->dev, "Unable to register device\n");
+		ida_simple_remove(&rsmu_cdev_map, rsmu->index);
+		return -ENODEV;
+	}
+
+	dev_info(rsmu->dev, "Probe %s successful\n", rsmu->name);
+	return 0;
+}
+
+static int
+rsmu_remove(struct platform_device *pdev)
+{
+	struct rsmu_cdev *rsmu = platform_get_drvdata(pdev);
+
+	misc_deregister(&rsmu->miscdev);
+	ida_simple_remove(&rsmu_cdev_map, rsmu->index);
+
+	return 0;
+}
+
+static const struct platform_device_id rsmu_id_table[] = {
+	{ "8a3400x-cdev", RSMU_CM},
+	{ "82p33x1x-cdev", RSMU_SABRE},
+	{}
+};
+MODULE_DEVICE_TABLE(platform, rsmu_id_table);
+
+static struct platform_driver rsmu_driver = {
+	.driver = {
+		.name = "rsmu-cdev",
+	},
+	.probe = rsmu_probe,
+	.remove =  rsmu_remove,
+	.id_table = rsmu_id_table,
+};
+
+module_platform_driver(rsmu_driver);
+
+MODULE_DESCRIPTION("Renesas SMU character device driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/misc/rsmu_cdev.h b/drivers/misc/rsmu_cdev.h
new file mode 100644
index 0000000..d67f71a
--- /dev/null
+++ b/drivers/misc/rsmu_cdev.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * This driver is developed for the IDT ClockMatrix(TM) of
+ * timing and synchronization devices.
+ *
+ * Copyright (C) 2019 Integrated Device Technology, Inc., a Renesas Company.
+ */
+#ifndef __LINUX_RSMU_CDEV_H
+#define __LINUX_RSMU_CDEV_H
+
+#include <linux/miscdevice.h>
+#include <linux/regmap.h>
+
+struct rsmu_ops;
+
+/**
+ * struct rsmu_cdev - Driver data for RSMU character device
+ * @name: rsmu device name as rsmu[index]
+ * @dev: pointer to device
+ * @mfd: pointer to MFD device
+ * @miscdev: character device handle
+ * @regmap: I2C/SPI regmap handle
+ * @lock: mutex to protect operations from being interrupted
+ * @type: rsmu device type, passed through platform data
+ * @ops: rsmu device methods
+ * @index: rsmu device index
+ */
+struct rsmu_cdev {
+	char name[16];
+	struct device *dev;
+	struct device *mfd;
+	struct miscdevice miscdev;
+	struct regmap *regmap;
+	struct mutex *lock;
+	enum rsmu_type type;
+	struct rsmu_ops *ops;
+	int index;
+};
+
+extern struct rsmu_ops cm_ops;
+extern struct rsmu_ops sabre_ops;
+
+struct rsmu_ops {
+	enum rsmu_type type;
+	int (*set_combomode)(struct rsmu_cdev *rsmu, u8 dpll, u8 mode);
+	int (*get_dpll_state)(struct rsmu_cdev *rsmu, u8 dpll, u8 *state);
+	int (*get_dpll_ffo)(struct rsmu_cdev *rsmu, u8 dpll,
+			    struct rsmu_get_ffo *ffo);
+};
+
+/**
+ * Enumerated type listing DPLL combination modes
+ */
+enum rsmu_dpll_combomode {
+	E_COMBOMODE_CURRENT = 0,
+	E_COMBOMODE_FASTAVG,
+	E_COMBOMODE_SLOWAVG,
+	E_COMBOMODE_HOLDOVER,
+	E_COMBOMODE_MAX
+};
+
+/**
+ * An id used to identify the respective child class states.
+ */
+enum rsmu_class_state {
+	E_SRVLOINITIALSTATE = 0,
+	E_SRVLOUNQUALIFIEDSTATE = 1,
+	E_SRVLOLOCKACQSTATE = 2,
+	E_SRVLOFREQUENCYLOCKEDSTATE = 3,
+	E_SRVLOTIMELOCKEDSTATE = 4,
+	E_SRVLOHOLDOVERINSPECSTATE = 5,
+	E_SRVLOHOLDOVEROUTOFSPECSTATE = 6,
+	E_SRVLOFREERUNSTATE = 7,
+	E_SRVNUMBERLOSTATES = 8,
+	E_SRVLOSTATEINVALID = 9,
+};
+#endif
diff --git a/drivers/misc/rsmu_cm.c b/drivers/misc/rsmu_cm.c
new file mode 100644
index 0000000..d1f2d7a
--- /dev/null
+++ b/drivers/misc/rsmu_cm.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * This driver is developed for the IDT ClockMatrix(TM) of
+ * timing and synchronization devices.
+ *
+ * Copyright (C) 2019 Integrated Device Technology, Inc., a Renesas Company.
+ */
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/device.h>
+#include <linux/mfd/idt8a340_reg.h>
+#include <linux/mfd/rsmu.h>
+#include <uapi/linux/rsmu.h>
+#include <asm/unaligned.h>
+
+#include "rsmu_cdev.h"
+
+static int rsmu_cm_set_combomode(struct rsmu_cdev *rsmu, u8 dpll, u8 mode)
+{
+	u16 dpll_ctrl_n;
+	u8 cfg;
+	int err;
+
+	switch (dpll) {
+	case 0:
+		dpll_ctrl_n = DPLL_CTRL_0;
+		break;
+	case 1:
+		dpll_ctrl_n = DPLL_CTRL_1;
+		break;
+	case 2:
+		dpll_ctrl_n = DPLL_CTRL_2;
+		break;
+	case 3:
+		dpll_ctrl_n = DPLL_CTRL_3;
+		break;
+	case 4:
+		dpll_ctrl_n = DPLL_CTRL_4;
+		break;
+	case 5:
+		dpll_ctrl_n = DPLL_CTRL_5;
+		break;
+	case 6:
+		dpll_ctrl_n = DPLL_CTRL_6;
+		break;
+	case 7:
+		dpll_ctrl_n = DPLL_CTRL_7;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (mode >= E_COMBOMODE_MAX)
+		return -EINVAL;
+
+	err = regmap_bulk_read(rsmu->regmap, dpll_ctrl_n + DPLL_CTRL_COMBO_MASTER_CFG,
+			       &cfg, sizeof(cfg));
+	if (err)
+		return err;
+
+	/* Only need to enable/disable COMBO_MODE_HOLD. */
+	if (mode)
+		cfg |= COMBO_MASTER_HOLD;
+	else
+		cfg &= ~COMBO_MASTER_HOLD;
+
+	return regmap_bulk_write(rsmu->regmap, dpll_ctrl_n + DPLL_CTRL_COMBO_MASTER_CFG,
+				 &cfg, sizeof(cfg));
+}
+
+static int rsmu_cm_get_dpll_state(struct rsmu_cdev *rsmu, u8 dpll, u8 *state)
+{
+	u8 cfg;
+	int err;
+
+	/* 8 is sys dpll */
+	if (dpll > 8)
+		return -EINVAL;
+
+	err = regmap_bulk_read(rsmu->regmap, STATUS + DPLL0_STATUS + dpll, &cfg, sizeof(cfg));
+	if (err)
+		return err;
+
+	switch (cfg & DPLL_STATE_MASK) {
+	case DPLL_STATE_FREERUN:
+		*state = E_SRVLOUNQUALIFIEDSTATE;
+		break;
+	case DPLL_STATE_LOCKACQ:
+	case DPLL_STATE_LOCKREC:
+		*state = E_SRVLOLOCKACQSTATE;
+		break;
+	case DPLL_STATE_LOCKED:
+		*state = E_SRVLOTIMELOCKEDSTATE;
+		break;
+	case DPLL_STATE_HOLDOVER:
+		*state = E_SRVLOHOLDOVERINSPECSTATE;
+		break;
+	default:
+		*state = E_SRVLOSTATEINVALID;
+		break;
+	}
+
+	return 0;
+}
+
+static int rsmu_cm_get_dpll_ffo(struct rsmu_cdev *rsmu, u8 dpll,
+				struct rsmu_get_ffo *ffo)
+{
+	u8 buf[8] = {0};
+	s64 fcw = 0;
+	u16 dpll_filter_status;
+	int err;
+
+	switch (dpll) {
+	case 0:
+		dpll_filter_status = DPLL0_FILTER_STATUS;
+		break;
+	case 1:
+		dpll_filter_status = DPLL1_FILTER_STATUS;
+		break;
+	case 2:
+		dpll_filter_status = DPLL2_FILTER_STATUS;
+		break;
+	case 3:
+		dpll_filter_status = DPLL3_FILTER_STATUS;
+		break;
+	case 4:
+		dpll_filter_status = DPLL4_FILTER_STATUS;
+		break;
+	case 5:
+		dpll_filter_status = DPLL5_FILTER_STATUS;
+		break;
+	case 6:
+		dpll_filter_status = DPLL6_FILTER_STATUS;
+		break;
+	case 7:
+		dpll_filter_status = DPLL7_FILTER_STATUS;
+		break;
+	case 8:
+		dpll_filter_status = DPLLSYS_FILTER_STATUS;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	err = regmap_bulk_read(rsmu->regmap, STATUS + dpll_filter_status, buf, 6);
+	if (err)
+		return err;
+
+	/* Convert to frequency control word */
+	fcw = sign_extend64(get_unaligned_le64(buf), 47);
+
+	/* FCW unit is 2 ^ -53 = 1.1102230246251565404236316680908e-16 */
+	ffo->ffo = fcw * 111;
+
+	return 0;
+}
+
+struct rsmu_ops cm_ops = {
+	.type = RSMU_CM,
+	.set_combomode = rsmu_cm_set_combomode,
+	.get_dpll_state = rsmu_cm_get_dpll_state,
+	.get_dpll_ffo = rsmu_cm_get_dpll_ffo,
+};
diff --git a/drivers/misc/rsmu_sabre.c b/drivers/misc/rsmu_sabre.c
new file mode 100644
index 0000000..1646d6b
--- /dev/null
+++ b/drivers/misc/rsmu_sabre.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * This driver is developed for the IDT 82P33XXX series of
+ * timing and synchronization devices.
+ *
+ * Copyright (C) 2019 Integrated Device Technology, Inc., a Renesas Company.
+ */
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/device.h>
+#include <linux/mfd/idt82p33_reg.h>
+#include <linux/mfd/rsmu.h>
+#include <uapi/linux/rsmu.h>
+#include <asm/unaligned.h>
+
+#include "rsmu_cdev.h"
+
+static int rsmu_sabre_set_combomode(struct rsmu_cdev *rsmu, u8 dpll, u8 mode)
+{
+	u16 dpll_ctrl_n;
+	u8 cfg;
+	int err;
+
+	switch (dpll) {
+	case 0:
+		dpll_ctrl_n = DPLL1_OPERATING_MODE_CNFG;
+		break;
+	case 1:
+		dpll_ctrl_n = DPLL2_OPERATING_MODE_CNFG;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (mode >= E_COMBOMODE_MAX)
+		return -EINVAL;
+
+	err = regmap_bulk_read(rsmu->regmap, dpll_ctrl_n, &cfg, sizeof(cfg));
+	if (err)
+		return err;
+
+	cfg &= ~(COMBO_MODE_MASK << COMBO_MODE_SHIFT);
+	cfg |= mode << COMBO_MODE_SHIFT;
+
+	return regmap_bulk_write(rsmu->regmap, dpll_ctrl_n, &cfg, sizeof(cfg));
+}
+
+static int rsmu_sabre_get_dpll_state(struct rsmu_cdev *rsmu, u8 dpll, u8 *state)
+{
+	u16 dpll_sts_n;
+	u8 cfg;
+	int err;
+
+	switch (dpll) {
+	case 0:
+		dpll_sts_n = DPLL1_OPERATING_STS;
+		break;
+	case 1:
+		dpll_sts_n = DPLL2_OPERATING_STS;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	err = regmap_bulk_read(rsmu->regmap, dpll_sts_n, &cfg, sizeof(cfg));
+	if (err)
+		return err;
+
+	switch (cfg & OPERATING_STS_MASK) {
+	case DPLL_STATE_FREERUN:
+		*state = E_SRVLOUNQUALIFIEDSTATE;
+		break;
+	case DPLL_STATE_PRELOCKED2:
+	case DPLL_STATE_PRELOCKED:
+		*state = E_SRVLOLOCKACQSTATE;
+		break;
+	case DPLL_STATE_LOCKED:
+		*state = E_SRVLOTIMELOCKEDSTATE;
+		break;
+	case DPLL_STATE_HOLDOVER:
+		*state = E_SRVLOHOLDOVERINSPECSTATE;
+		break;
+	default:
+		*state = E_SRVLOSTATEINVALID;
+		break;
+	}
+
+	return 0;
+}
+
+static int rsmu_sabre_get_dpll_ffo(struct rsmu_cdev *rsmu, u8 dpll,
+				   struct rsmu_get_ffo *ffo)
+{
+	u8 buf[8] = {0};
+	s64 fcw = 0;
+	u16 dpll_freq_n;
+	int err;
+
+	/*
+	 * IDTDpll_GetCurrentDpllFreqOffset retrieves the FFO integrator only.
+	 * In order to get Proportional + Integrator, use the holdover FFO with
+	 * the filter bandwidth 0.5 Hz set by TCS file.
+	 */
+	switch (dpll) {
+	case 0:
+		dpll_freq_n = DPLL1_HOLDOVER_FREQ_CNFG;
+		break;
+	case 1:
+		dpll_freq_n = DPLL2_HOLDOVER_FREQ_CNFG;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	err = regmap_bulk_read(rsmu->regmap, dpll_freq_n, buf, 5);
+	if (err)
+		return err;
+
+	/* Convert to frequency control word */
+	fcw = sign_extend64(get_unaligned_le64(buf), 39);
+
+	/* FCW unit is 77760 / ( 1638400 * 2^48) = 1.68615121864946 * 10^-16 */
+	ffo->ffo = div_s64(fcw * 2107689, 12500);
+
+	return 0;
+}
+
+struct rsmu_ops sabre_ops = {
+	.type = RSMU_SABRE,
+	.set_combomode = rsmu_sabre_set_combomode,
+	.get_dpll_state = rsmu_sabre_get_dpll_state,
+	.get_dpll_ffo = rsmu_sabre_get_dpll_ffo,
+};
diff --git a/include/uapi/linux/rsmu.h b/include/uapi/linux/rsmu.h
new file mode 100644
index 0000000..85a208b
--- /dev/null
+++ b/include/uapi/linux/rsmu.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/*
+ * Driver for the IDT ClockMatrix(TM) and 82p33xxx families of
+ * timing and synchronization devices.
+ *
+ * Copyright (C) 2019 Integrated Device Technology, Inc., a Renesas Company.
+ */
+
+#ifndef __UAPI_LINUX_RSMU_CDEV_H
+#define __UAPI_LINUX_RSMU_CDEV_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+/* Set dpll combomode */
+struct rsmu_combomode {
+	__u8 dpll;
+	__u8 mode;
+};
+
+/* Get dpll state */
+struct rsmu_get_state {
+	__u8 dpll;
+	__u8 state;
+};
+
+/* Get dpll ffo (fractional frequency offset) in ppqt*/
+struct rsmu_get_ffo {
+	__u8 dpll;
+	__s64 ffo;
+};
+
+/*
+ * RSMU IOCTL List
+ */
+#define RSMU_MAGIC '?'
+
+/**
+ * @Description
+ * ioctl to set SMU combo mode.Combo mode provides physical layer frequency
+ * support from the Ethernet Equipment Clock to the PTP clock
+ *
+ * @Parameters
+ * pointer to struct rsmu_combomode that contains dpll combomode setting
+ */
+#define RSMU_SET_COMBOMODE  _IOW(RSMU_MAGIC, 1, struct rsmu_combomode)
+
+/**
+ * @Description
+ * ioctl to get SMU dpll state. Application can call this API to tell if
+ * SMU is locked to the GNSS signal
+ *
+ * @Parameters
+ * pointer to struct rsmu_get_state that contains dpll state
+ */
+#define RSMU_GET_STATE  _IOR(RSMU_MAGIC, 2, struct rsmu_get_state)
+
+/**
+ * @Description
+ * ioctl to get SMU dpll ffo (fractional frequency offset).
+ *
+ * @Parameters
+ * pointer to struct rsmu_get_ffo that contains dpll ffo in ppqt
+ */
+#define RSMU_GET_FFO  _IOR(RSMU_MAGIC, 3, struct rsmu_get_ffo)
+#endif /* __UAPI_LINUX_RSMU_CDEV_H */
-- 
2.7.4

