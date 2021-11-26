Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE7845E457
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 03:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357573AbhKZCYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 21:24:32 -0500
Received: from mx24.baidu.com ([111.206.215.185]:52540 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1357552AbhKZCW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 21:22:28 -0500
Received: from BC-Mail-Ex03.internal.baidu.com (unknown [172.31.51.43])
        by Forcepoint Email with ESMTPS id F2561E7F954122BBF7A7;
        Fri, 26 Nov 2021 10:19:13 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex03.internal.baidu.com (172.31.51.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Fri, 26 Nov 2021 10:19:13 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Fri, 26 Nov 2021 10:19:12 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-staging@lists.linux.dev>
Subject: [PATCH v3 1/3] staging: zynpu: Add driver support for ARM(China) ZHOUYI AI accelerator
Date:   Fri, 26 Nov 2021 10:18:59 +0800
Message-ID: <20211126021904.32325-2-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211126021904.32325-1-caihuoqing@baidu.com>
References: <20211126021904.32325-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex10.internal.baidu.com (172.31.51.50) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZHOUYI NPU is an AI accelerator chip which is integrated into ARM SOC,
such as Allwinner R329 SOC.
Add driver support for this AI accelerator here.

This driver is not standard linux style, there are some clean up works,
fixing code style, refactorring.
And it only works with a closed source usermode driver, so need to
reverse the libraries, and impelement it, then open source
the usermode driver.
So add this driver to linux-staging

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
v1->v2:
        *Add TODO file.
        *Update changelog to explain why this code is added to staging.
v2->v3:
        *Fix typo in changelog, 'tandard'->'standard'.

 drivers/staging/Kconfig                   |   2 +
 drivers/staging/Makefile                  |   1 +
 drivers/staging/zynpu/Kconfig             |  34 +
 drivers/staging/zynpu/Makefile            |   7 +
 drivers/staging/zynpu/TODO                |  13 +
 drivers/staging/zynpu/z1.c                | 233 ++++++
 drivers/staging/zynpu/z2.c                | 297 ++++++++
 drivers/staging/zynpu/zhouyi.h            |  70 ++
 drivers/staging/zynpu/zhouyi_base.c       |  71 ++
 drivers/staging/zynpu/zynpu.h             | 252 +++++++
 drivers/staging/zynpu/zynpu_core.c        | 254 +++++++
 drivers/staging/zynpu/zynpu_drv.c         | 349 +++++++++
 drivers/staging/zynpu/zynpu_fops.c        | 245 +++++++
 drivers/staging/zynpu/zynpu_io.c          | 133 ++++
 drivers/staging/zynpu/zynpu_io.h          | 119 ++++
 drivers/staging/zynpu/zynpu_irq.c         | 123 ++++
 drivers/staging/zynpu/zynpu_irq.h         |  85 +++
 drivers/staging/zynpu/zynpu_job_manager.c | 467 +++++++++++++
 drivers/staging/zynpu/zynpu_job_manager.h | 200 ++++++
 drivers/staging/zynpu/zynpu_mm.c          | 704 +++++++++++++++++++
 drivers/staging/zynpu/zynpu_mm.h          | 142 ++++
 drivers/staging/zynpu/zynpu_session.c     | 817 ++++++++++++++++++++++
 drivers/staging/zynpu/zynpu_session.h     | 283 ++++++++
 drivers/staging/zynpu/zynpu_sysfs.c       | 205 ++++++
 24 files changed, 5106 insertions(+)
 create mode 100644 drivers/staging/zynpu/Kconfig
 create mode 100644 drivers/staging/zynpu/Makefile
 create mode 100644 drivers/staging/zynpu/TODO
 create mode 100644 drivers/staging/zynpu/z1.c
 create mode 100644 drivers/staging/zynpu/z2.c
 create mode 100644 drivers/staging/zynpu/zhouyi.h
 create mode 100644 drivers/staging/zynpu/zhouyi_base.c
 create mode 100644 drivers/staging/zynpu/zynpu.h
 create mode 100644 drivers/staging/zynpu/zynpu_core.c
 create mode 100644 drivers/staging/zynpu/zynpu_drv.c
 create mode 100644 drivers/staging/zynpu/zynpu_fops.c
 create mode 100644 drivers/staging/zynpu/zynpu_io.c
 create mode 100644 drivers/staging/zynpu/zynpu_io.h
 create mode 100644 drivers/staging/zynpu/zynpu_irq.c
 create mode 100644 drivers/staging/zynpu/zynpu_irq.h
 create mode 100644 drivers/staging/zynpu/zynpu_job_manager.c
 create mode 100644 drivers/staging/zynpu/zynpu_job_manager.h
 create mode 100644 drivers/staging/zynpu/zynpu_mm.c
 create mode 100644 drivers/staging/zynpu/zynpu_mm.h
 create mode 100644 drivers/staging/zynpu/zynpu_session.c
 create mode 100644 drivers/staging/zynpu/zynpu_session.h
 create mode 100644 drivers/staging/zynpu/zynpu_sysfs.c

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 8d41fdd40657..107e2c88d5d9 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -94,4 +94,6 @@ source "drivers/staging/qlge/Kconfig"
 
 source "drivers/staging/wfx/Kconfig"
 
+source "drivers/staging/zynpu/Kconfig"
+
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 02b01949b94e..022444b13ec5 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -37,3 +37,4 @@ obj-$(CONFIG_XIL_AXIS_FIFO)	+= axis-fifo/
 obj-$(CONFIG_FIELDBUS_DEV)     += fieldbus/
 obj-$(CONFIG_QLGE)		+= qlge/
 obj-$(CONFIG_WFX)		+= wfx/
+obj-$(CONFIG_ZYNPU)		+= zynpu/
diff --git a/drivers/staging/zynpu/Kconfig b/drivers/staging/zynpu/Kconfig
new file mode 100644
index 000000000000..dc1b79acd30b
--- /dev/null
+++ b/drivers/staging/zynpu/Kconfig
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# ARM (China) ZHOUYI AI accelerator drivers configuration.
+#
+
+config ZYNPU
+	tristate "ARM (China) ZHOUYI AI accelerator support"
+	depends on OF && HAS_IOMEM
+	select CMA
+	select DMA_CMA
+	help
+	  Say yes here to build support for ZHOUYI AI accelerator.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called zhouyi_npu.
+
+choice
+	prompt "ZHOUYI NPU version"
+	depends on ZYNPU
+	default ZHOUYI_V1
+	help
+	  Select the chip version of ZHOUYI NPU.
+
+	config ZHOUYI_V1
+		bool "ZHOUYI V1"
+		help
+		  select ZHOUYI Z1 support
+
+	config ZHOUYI_V2
+		bool "ZHOUYI V2"
+		help
+		  select ZHOUYI Z2 support
+
+endchoice
diff --git a/drivers/staging/zynpu/Makefile b/drivers/staging/zynpu/Makefile
new file mode 100644
index 000000000000..f9fdb976b0e9
--- /dev/null
+++ b/drivers/staging/zynpu/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+zhouyi_npu-y := zynpu_core.o zynpu_io.o zynpu_drv.o \
+	zynpu_irq.o zynpu_session.o zynpu_job_manager.o \
+	zynpu_mm.o zynpu_sysfs.o zynpu_fops.o zhouyi_base.o z1.o z2.o
+
+obj-$(CONFIG_ZYNPU) +=	zhouyi_npu.o
diff --git a/drivers/staging/zynpu/TODO b/drivers/staging/zynpu/TODO
new file mode 100644
index 000000000000..79610b8475b1
--- /dev/null
+++ b/drivers/staging/zynpu/TODO
@@ -0,0 +1,13 @@
+TODO:
+* there are some clean up works, fixing code style, refactorring.
+  - remove "static struct zynpu_priv" in zynpu_sysfs
+  - use kernel coding style
+  - checkpatch.pl fixes
+  - sparse fixes
+  - integrate with drivers/misc
+
+* this driver only works with closed source usermode driver,
+  so need to reverse the lib, and impelement it, then open source UMD.
+
+Please send any patches to Greg Kroah-Hartman <greg@kroah.com>
+and Cai Huoqing <caihuoqing@baidu.com>.
diff --git a/drivers/staging/zynpu/z1.c b/drivers/staging/zynpu/z1.c
new file mode 100644
index 000000000000..22f8947377a2
--- /dev/null
+++ b/drivers/staging/zynpu/z1.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+*
+* Zhouyi AI Accelerator driver
+*
+* Copyright (C) 2020 Arm (China) Ltd.
+* Copyright (C) 2021 Cai Huoqing
+*/
+
+/**
+ * @file z1.c
+ * Implementation of the zhouyi v1 ZYNPU hardware cntrol interfaces
+ */
+
+#include "zynpu.h"
+#include "zynpu_io.h"
+#include "zhouyi.h"
+
+/**
+ * Zhouyi V1 ZYNPU Interrupts
+ */
+#define ZHOUYIV1_IRQ	      (ZHOUYI_IRQ)
+#define ZHOUYIV1_IRQ_ENABLE_FLAG  (ZHOUYIV1_IRQ)
+#define ZHOUYIV1_IRQ_DISABLE_FLAG (ZHOUYI_IRQ_NONE)
+
+/**
+ * Zhouyi V1 ZYNPU Specific Host Control Register Map
+ */
+#define ZHOUYI_INTR_CAUSE_REG_OFFSET	  0x20
+#define ZHOUYI_L2_CACHE_FEATURE_REG_OFFSET    0x6C
+
+static void zhouyi_v1_enable_interrupt(struct zynpu_core *core)
+{
+	if (core)
+		zynpu_write32(core->base0, ZHOUYI_CTRL_REG_OFFSET,
+                              ZHOUYIV1_IRQ_ENABLE_FLAG);
+}
+
+static void zhouyi_v1_disable_interrupt(struct zynpu_core *core)
+{
+	if (core)
+		zynpu_write32(core->base0, ZHOUYI_CTRL_REG_OFFSET,
+                              ZHOUYIV1_IRQ_DISABLE_FLAG);
+}
+
+static void zhouyi_v1_clear_qempty_interrupt(struct zynpu_core *core)
+{
+	if (core)
+		zhouyi_clear_qempty_interrupt(core->base0);
+}
+
+static void zhouyi_v1_clear_done_interrupt(struct zynpu_core *core)
+{
+	if (core)
+		zhouyi_clear_done_interrupt(core->base0);
+}
+
+static void zhouyi_v1_clear_excep_interrupt(struct zynpu_core *core)
+{
+	if (core)
+		zhouyi_clear_excep_interrupt(core->base0);
+}
+
+static int zhouyi_v1_trigger(struct zynpu_core *core,
+			     struct user_job_desc *udesc, int tid)
+{
+	int ret = 0;
+	unsigned int phys_addr = 0;
+	unsigned int phys_addr0 = 0;
+	unsigned int phys_addr1 = 0;
+	unsigned int start_pc = 0;
+
+	if (!core) {
+		ret = -EINVAL;
+		goto finish;
+	}
+
+	/* Load data addr 0 register */
+	phys_addr0 = (unsigned int)udesc->data_0_addr;
+	zynpu_write32(core->base0, ZHOUYI_DATA_ADDR_0_REG_OFFSET, phys_addr0);
+
+	/* Load data addr 1 register */
+	phys_addr1 = (unsigned int)udesc->data_1_addr;
+	zynpu_write32(core->base0, ZHOUYI_DATA_ADDR_1_REG_OFFSET, phys_addr1);
+
+	/* Load interrupt PC */
+	zynpu_write32(core->base0, ZHOUYI_INTR_PC_REG_OFFSET,
+                      (unsigned int)udesc->intr_handler_addr);
+
+	/* Load start PC register */
+	/* use write back and invalidate DCache*/
+        /* because HW does not implement invalidate option in Zhouyi-z1 */
+	phys_addr = (unsigned int)udesc->start_pc_addr;
+	start_pc = phys_addr | 0xD;
+	zynpu_write32(core->base0, ZHOUYI_START_PC_REG_OFFSET, start_pc);
+
+	if (tid)
+		dev_info(core->dev,
+                         "[%u] trigger Job 0x%x done: start pc = 0x%x, dreg0 = 0x%x, dreg1 = 0x%x",
+		         tid, udesc->job_id, start_pc, phys_addr0, phys_addr1);
+	else
+		dev_info(core->dev,
+                         "[IRQ] trigger Job 0x%x done: start pc = 0x%x, dreg0 = 0x%x, dreg1 = 0x%x",
+		         udesc->job_id, start_pc, phys_addr0, phys_addr1);
+
+finish:
+	return ret;
+}
+
+static bool zhouyi_v1_is_idle(struct zynpu_core *core)
+{
+	if (!core) {
+		pr_err("invalid input args core to be NULL!");
+		return 0;
+	}
+	return ZYNPU_BIT(zynpu_read32(core->base0, ZHOUYI_STAT_REG_OFFSET), 16) &&
+	       ZYNPU_BIT(zynpu_read32(core->base0, ZHOUYI_STAT_REG_OFFSET), 17) &&
+	       ZYNPU_BIT(zynpu_read32(core->base0, ZHOUYI_STAT_REG_OFFSET), 18);
+}
+
+static int zhouyi_v1_read_status_reg(struct zynpu_core *core)
+{
+	return zhouyi_read_status_reg(core->base0);
+}
+
+static void zhouyi_v1_print_hw_id_info(struct zynpu_core *core)
+{
+	int ret = 0;
+
+	if (!core) {
+		pr_err("invalid input args io to be NULL!");
+		return;
+	}
+
+	ret = zynpu_read32(core->base0, ZHOUYI_STAT_REG_OFFSET);
+	dev_info(core->dev, "ZYNPU Initial Status: 0x%x.", ret);
+
+	dev_info(core->dev, "###### ZHOUYI V1 HARDWARE INFORMATION #######");
+	dev_info(core->dev, "# ISA Version Register: 0x%x",
+		 zynpu_read32(core->base0, ZHOUYI_ISA_VERSION_REG_OFFSET));
+	dev_info(core->dev, "# TPC Feature Register: 0x%x",
+		 zynpu_read32(core->base0, ZHOUYI_TPC_FEATURE_REG_OFFSET));
+	dev_info(core->dev, "# SPU Feature Register: 0x%x",
+		 zynpu_read32(core->base0, ZHOUYI_SPU_FEATURE_REG_OFFSET));
+	dev_info(core->dev, "# HWA Feature Register: 0x%x",
+		 zynpu_read32(core->base0, ZHOUYI_HWA_FEATURE_REG_OFFSET));
+	dev_info(core->dev, "# Revision ID Register: 0x%x",
+		 zynpu_read32(core->base0, ZHOUYI_REVISION_ID_REG_OFFSET));
+	dev_info(core->dev, "# Memory Hierarchy Feature Register: 0x%x",
+		 zynpu_read32(core->base0, ZHOUYI_MEM_FEATURE_REG_OFFSET));
+	dev_info(core->dev, "# Instruction RAM Feature Register:  0x%x",
+		 zynpu_read32(core->base0, ZHOUYI_INST_RAM_FEATURE_REG_OFFSET));
+	dev_info(core->dev, "# TEC Local SRAM Feature Register:   0x%x",
+		 zynpu_read32(core->base0, ZHOUYI_LOCAL_SRAM_FEATURE_REG_OFFSET));
+	dev_info(core->dev, "# Global SRAM Feature Register:      0x%x",
+		 zynpu_read32(core->base0, ZHOUYI_GLOBAL_SRAM_FEATURE_REG_OFFSET));
+	dev_info(core->dev, "# Instruction Cache Feature Register:0x%x",
+		 zynpu_read32(core->base0, ZHOUYI_INST_CACHE_FEATURE_REG_OFFSET));
+	dev_info(core->dev, "# Data Cache Feature Register:       0x%x",
+		 zynpu_read32(core->base0, ZHOUYI_DATA_CACHE_FEATURE_REG_OFFSET));
+	dev_info(core->dev, "# L2 Cache Feature Register:	 0x%x",
+		 zynpu_read32(core->base0, ZHOUYI_L2_CACHE_FEATURE_REG_OFFSET));
+	dev_info(core->dev, "#############################################");
+}
+
+static int zhouyi_v1_query_cap(struct zynpu_core *core, struct zynpu_cap *cap)
+{
+	if (!core)
+		return 0;
+	return zhouyi_query_cap(core->base0, cap);
+}
+
+static void zhouyi_v1_io_rw(struct zynpu_core *core, struct zynpu_io_req *io_req)
+{
+	zhouyi_io_rw(core->base0, io_req);
+}
+
+static int zhouyi_v1_upper_half(void *data)
+{
+	int ret = 0;
+	struct zynpu_priv *zynpu = (struct zynpu_priv*)data;
+	struct zynpu_core *core = zynpu->core0;
+
+	if (!core) {
+		ret = ZYNPU_ERRCODE_INTERNAL_NULLPTR;
+		goto finish;
+	}
+
+	zhouyi_v1_disable_interrupt(core);
+	ret = zhouyi_v1_read_status_reg(core);
+	if (ret & ZHOUYI_IRQ_QEMPTY) {
+		zhouyi_v1_clear_qempty_interrupt(core);
+	}
+
+	if (ret & ZHOUYI_IRQ_DONE) {
+		zhouyi_v1_clear_done_interrupt(core);
+		zynpu_job_manager_update_job_state_irq(zynpu, 0);
+		zynpu_irq_schedulework(core->irq_obj);
+	}
+
+	if (ret & ZHOUYI_IRQ_EXCEP) {
+		zhouyi_v1_clear_excep_interrupt(core);
+		zynpu_job_manager_update_job_state_irq(zynpu,
+                        zynpu_read32(core->base0, ZHOUYI_INTR_CAUSE_REG_OFFSET));
+		zynpu_irq_schedulework(core->irq_obj);
+	}
+	zhouyi_v1_enable_interrupt(core);
+
+	/* success */
+	ret = 0;
+
+finish:
+	return ret;
+}
+
+static void zhouyi_v1_bottom_half(void *data)
+{
+	struct zynpu_priv* zynpu = (struct zynpu_priv*)data;
+	zynpu_job_manager_update_job_queue_done_irq(&zynpu->job_manager);
+}
+
+struct zynpu_io_operation zhouyi_v1_ops = {
+	.enable_interrupt = zhouyi_v1_enable_interrupt,
+	.disable_interrupt = zhouyi_v1_disable_interrupt,
+	.trigger = zhouyi_v1_trigger,
+	.is_idle = zhouyi_v1_is_idle,
+	.read_status_reg = zhouyi_v1_read_status_reg,
+	.print_hw_id_info = zhouyi_v1_print_hw_id_info,
+	.query_capability = zhouyi_v1_query_cap,
+	.io_rw = zhouyi_v1_io_rw,
+	.upper_half = zhouyi_v1_upper_half,
+	.bottom_half = zhouyi_v1_bottom_half,
+};
diff --git a/drivers/staging/zynpu/z2.c b/drivers/staging/zynpu/z2.c
new file mode 100644
index 000000000000..77f437d74595
--- /dev/null
+++ b/drivers/staging/zynpu/z2.c
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+*
+* Zhouyi AI Accelerator driver
+*
+* Copyright (C) 2020 Arm (China) Ltd.
+* Copyright (C) 2021 Cai Huoqing
+*/
+
+/**
+ * @file z2.c
+ * Implementation of the zhouyi v1 ZYNPU hardware cntrol interfaces
+ */
+
+#include "zynpu.h"
+#include "zynpu_io.h"
+#include "zhouyi.h"
+
+/**
+ * Zhouyi v2 ZYNPU Specific Interrupts
+ */
+#define ZHOUYI_IRQ_FAULT  0x8
+
+#define ZHOUYIV2_IRQ  (ZHOUYI_IRQ | ZHOUYI_IRQ_FAULT)
+#define ZHOUYIV2_IRQ_ENABLE_FLAG  (ZHOUYIV2_IRQ)
+#define ZHOUYIV2_IRQ_DISABLE_FLAG (ZHOUYI_IRQ_NONE)
+
+#define ZHOUYI_V2_ASE_READ_ENABLE	   (1<<31)
+#define ZHOUYI_V2_ASE_RW_ENABLE	     (3<<30)
+#define ZHOUYI_V2_ASE_CTRL_SIZE(value) \
+	(ilog2((max((u64)4096, (u64)roundup_pow_of_two(value))>>12)) + 1)
+
+/**
+ * Zhouyi v2 ZYNPU Specific Host Control Register Map
+ */
+#define ZYNPU_ADDR_EXT0_CTRL_REG_OFFSET      0xC0
+#define ZYNPU_ADDR_EXT0_HIGH_BASE_REG_OFFSET 0xC4
+#define ZYNPU_ADDR_EXT0_LOW_BASE_REG_OFFSET  0xC8
+#define ZYNPU_ADDR_EXT1_CTRL_REG_OFFSET      0xCC
+#define ZYNPU_ADDR_EXT1_HIGH_BASE_REG_OFFSET 0xD0
+#define ZYNPU_ADDR_EXT1_LOW_BASE_REG_OFFSET  0xD4
+#define ZYNPU_ADDR_EXT2_CTRL_REG_OFFSET      0xD8
+#define ZYNPU_ADDR_EXT2_HIGH_BASE_REG_OFFSET 0xDC
+#define ZYNPU_ADDR_EXT2_LOW_BASE_REG_OFFSET  0xE0
+
+static void zhouyi_v2_enable_interrupt(struct zynpu_core *core)
+{
+	if (core)
+		zynpu_write32(core->base0, ZHOUYI_CTRL_REG_OFFSET,
+			      ZHOUYIV2_IRQ_ENABLE_FLAG);
+}
+
+static void zhouyi_v2_disable_interrupt(struct zynpu_core *core)
+{
+	if (core)
+		zynpu_write32(core->base0, ZHOUYI_CTRL_REG_OFFSET,
+			      ZHOUYIV2_IRQ_DISABLE_FLAG);
+}
+
+static void zhouyi_v2_clear_qempty_interrupt(struct zynpu_core *core)
+{
+	if (core)
+		zhouyi_clear_qempty_interrupt(core->base0);
+}
+
+static void zhouyi_v2_clear_done_interrupt(struct zynpu_core *core)
+{
+	if (core)
+		zhouyi_clear_done_interrupt(core->base0);
+}
+
+static void zhouyi_v2_clear_excep_interrupt(struct zynpu_core *core)
+{
+	if (core)
+		zhouyi_clear_excep_interrupt(core->base0);
+}
+
+static void zhouyi_v2_clear_fault_interrupt(struct zynpu_core *core)
+{
+	if (core)
+		zynpu_write32(core->base0, ZHOUYI_STAT_REG_OFFSET, ZHOUYI_IRQ_FAULT);
+}
+
+static int zhouyi_v2_trigger(struct zynpu_core *core, struct user_job_desc *udesc, int tid)
+{
+	int ret = 0;
+	u32 start_pc = 0;
+	u32 intr_pc = 0;
+	u32 data_0_pa = 0;
+	u32 data_1_pa = 0;
+	u64 ase0_start = min3(udesc->start_pc_addr,
+			      udesc->data_0_addr, udesc->data_1_addr);
+	u64 ase0_end = max3(udesc->start_pc_addr + udesc->code_size,
+			    udesc->data_0_addr + udesc->rodata_size,
+			    udesc->data_1_addr + udesc->stack_size);
+
+	/* Used when ASID is disabled */
+	u32 ase0_base_high = udesc->start_pc_addr >> 32;
+
+	if (!core) {
+		ret = -EINVAL;
+		goto finish;
+	}
+
+	if (udesc->enable_asid) {
+		start_pc = (u32)(udesc->start_pc_addr - ase0_start);
+		intr_pc = (u32)(udesc->intr_handler_addr - ase0_start);
+		data_0_pa = (u32)(udesc->data_0_addr - ase0_start);
+		data_1_pa = (u32)(udesc->data_1_addr - ase0_start);
+	} else {
+		start_pc = (u32)udesc->start_pc_addr;
+		intr_pc = (u32)udesc->intr_handler_addr;
+		data_0_pa = (u32)udesc->data_0_addr;
+		data_1_pa = (u32)udesc->data_1_addr;
+	}
+
+	/* Load data addr 0 register */
+	zynpu_write32(core->base0, ZHOUYI_DATA_ADDR_0_REG_OFFSET, data_0_pa);
+
+	/* Load data addr 1 register */
+	zynpu_write32(core->base0, ZHOUYI_DATA_ADDR_1_REG_OFFSET, data_1_pa);
+
+	/* Load interrupt PC */
+	zynpu_write32(core->base0, ZHOUYI_INTR_PC_REG_OFFSET, intr_pc);
+
+	/* Load ASE registers */
+	if (udesc->enable_asid) {
+		/* ASE 0 */
+		zynpu_write32(core->base0, ZYNPU_ADDR_EXT0_CTRL_REG_OFFSET,
+			ZHOUYI_V2_ASE_RW_ENABLE | ZHOUYI_V2_ASE_CTRL_SIZE(ase0_end - ase0_start));
+		zynpu_write32(core->base0, ZYNPU_ADDR_EXT0_HIGH_BASE_REG_OFFSET, ase0_start >> 32);
+		zynpu_write32(core->base0, ZYNPU_ADDR_EXT0_LOW_BASE_REG_OFFSET, 0);
+		dev_dbg(core->dev, "ASE 0 Ctrl 0x%x, ASE 0 PA 0x%llx",
+			zynpu_read32(core->base0, ZYNPU_ADDR_EXT0_CTRL_REG_OFFSET),
+			((u64)zynpu_read32(core->base0, ZYNPU_ADDR_EXT0_HIGH_BASE_REG_OFFSET) << 32) +
+			zynpu_read32(core->base0, ZYNPU_ADDR_EXT0_LOW_BASE_REG_OFFSET));
+		/* ASE 1 */
+		zynpu_write32(core->base0, ZYNPU_ADDR_EXT1_CTRL_REG_OFFSET,
+			ZHOUYI_V2_ASE_READ_ENABLE | ZHOUYI_V2_ASE_CTRL_SIZE(udesc->static_size));
+		zynpu_write32(core->base0, ZYNPU_ADDR_EXT1_HIGH_BASE_REG_OFFSET, udesc->static_addr >> 32);
+		zynpu_write32(core->base0, ZYNPU_ADDR_EXT1_LOW_BASE_REG_OFFSET, (u32)udesc->static_addr);
+		dev_dbg(core->dev, "ASE 1 Ctrl 0x%x, ASE 1 PA 0x%llx",
+			zynpu_read32(core->base0, ZYNPU_ADDR_EXT1_CTRL_REG_OFFSET),
+			((u64)zynpu_read32(core->base0, ZYNPU_ADDR_EXT1_HIGH_BASE_REG_OFFSET) << 32) +
+			zynpu_read32(core->base0, ZYNPU_ADDR_EXT1_LOW_BASE_REG_OFFSET));
+		/* ASE 2 */
+		zynpu_write32(core->base0, ZYNPU_ADDR_EXT2_CTRL_REG_OFFSET,
+			ZHOUYI_V2_ASE_RW_ENABLE | ZHOUYI_V2_ASE_CTRL_SIZE(udesc->reuse_size));
+		zynpu_write32(core->base0, ZYNPU_ADDR_EXT2_HIGH_BASE_REG_OFFSET, udesc->reuse_addr >> 32);
+		zynpu_write32(core->base0, ZYNPU_ADDR_EXT2_LOW_BASE_REG_OFFSET, (u32)udesc->reuse_addr);
+		dev_dbg(core->dev, "ASE 2 Ctrl 0x%x, ASE 2 PA 0x%llx",
+			zynpu_read32(core->base0, ZYNPU_ADDR_EXT2_CTRL_REG_OFFSET),
+			((u64)zynpu_read32(core->base0, ZYNPU_ADDR_EXT2_HIGH_BASE_REG_OFFSET) << 32) +
+			zynpu_read32(core->base0, ZYNPU_ADDR_EXT2_LOW_BASE_REG_OFFSET));
+	} else {
+		/* default: ASE 0 */
+		zynpu_write32(core->base0, ZYNPU_ADDR_EXT0_CTRL_REG_OFFSET,
+			      ZHOUYI_V2_ASE_RW_ENABLE);
+		zynpu_write32(core->base0, ZYNPU_ADDR_EXT0_HIGH_BASE_REG_OFFSET, ase0_base_high);
+		zynpu_write32(core->base0, ZYNPU_ADDR_EXT0_LOW_BASE_REG_OFFSET, 0);
+		dev_dbg(core->dev, "ASE 0 Ctrl 0x%x, ASE 0 PA 0x%llx",
+			zynpu_read32(core->base0, ZYNPU_ADDR_EXT0_CTRL_REG_OFFSET),
+			((u64)zynpu_read32(core->base0, ZYNPU_ADDR_EXT0_HIGH_BASE_REG_OFFSET) << 32) +
+			zynpu_read32(core->base0, ZYNPU_ADDR_EXT0_LOW_BASE_REG_OFFSET));
+	}
+
+	/* Load start PC register */
+	start_pc |= 0xD;
+	zynpu_write32(core->base0, ZHOUYI_START_PC_REG_OFFSET, start_pc);
+
+	if (tid)
+		dev_info(core->dev, "[%u] trigger Job 0x%x done: start pc = 0x%x, dreg0 = 0x%x, dreg1 = 0x%x",
+			 tid, udesc->job_id, start_pc, data_0_pa, data_1_pa);
+	else
+		dev_info(core->dev, "[IRQ] trigger Job 0x%x done: start pc = 0x%x, dreg0 = 0x%x, dreg1 = 0x%x",
+			 udesc->job_id, start_pc, data_0_pa, data_1_pa);
+
+finish:
+	return ret;
+}
+
+static bool zhouyi_v2_is_idle(struct zynpu_core *core)
+{
+	if (!core) {
+		pr_err("invalid input args core to be NULL!");
+		return 0;
+	}
+	return ZYNPU_BIT(zynpu_read32(core->base0, ZHOUYI_STAT_REG_OFFSET), 16) &&
+	       ZYNPU_BIT(zynpu_read32(core->base0, ZHOUYI_STAT_REG_OFFSET), 17) &&
+	       ZYNPU_BIT(zynpu_read32(core->base0, ZHOUYI_STAT_REG_OFFSET), 18);
+}
+
+static int zhouyi_v2_read_status_reg(struct zynpu_core *core)
+{
+	if (!core)
+		return 0;
+	return zhouyi_read_status_reg(core->base0);
+}
+
+static void zhouyi_v2_print_hw_id_info(struct zynpu_core *core)
+{
+	int ret = 0;
+
+	if (!core) {
+		pr_err("invalid input args core to be NULL!");
+		return;
+	}
+
+	ret = zynpu_read32(core->base0, ZHOUYI_STAT_REG_OFFSET);
+	dev_info(core->dev, "ZYNPU Initial Status: 0x%x.", ret);
+
+	dev_info(core->dev, "###### ZHOUYI V2 HARDWARE INFORMATION #######");
+	dev_info(core->dev, "# ISA Version Register: 0x%x", zynpu_read32(core->base0, ZHOUYI_ISA_VERSION_REG_OFFSET));
+	dev_info(core->dev, "# TPC Feature Register: 0x%x", zynpu_read32(core->base0, ZHOUYI_TPC_FEATURE_REG_OFFSET));
+	dev_info(core->dev, "# SPU Feature Register: 0x%x", zynpu_read32(core->base0, ZHOUYI_SPU_FEATURE_REG_OFFSET));
+	dev_info(core->dev, "# HWA Feature Register: 0x%x", zynpu_read32(core->base0, ZHOUYI_HWA_FEATURE_REG_OFFSET));
+	dev_info(core->dev, "# Revision ID Register: 0x%x", zynpu_read32(core->base0, ZHOUYI_REVISION_ID_REG_OFFSET));
+	dev_info(core->dev, "# Memory Hierarchy Feature Register: 0x%x", zynpu_read32(core->base0, ZHOUYI_MEM_FEATURE_REG_OFFSET));
+	dev_info(core->dev, "# Instruction RAM Feature Register:  0x%x", zynpu_read32(core->base0, ZHOUYI_INST_RAM_FEATURE_REG_OFFSET));
+	dev_info(core->dev, "# TEC Local SRAM Feature Register:   0x%x", zynpu_read32(core->base0, ZHOUYI_LOCAL_SRAM_FEATURE_REG_OFFSET));
+	dev_info(core->dev, "# Global SRAM Feature Register:      0x%x", zynpu_read32(core->base0, ZHOUYI_GLOBAL_SRAM_FEATURE_REG_OFFSET));
+	dev_info(core->dev, "# Instruction Cache Feature Register:0x%x", zynpu_read32(core->base0, ZHOUYI_INST_CACHE_FEATURE_REG_OFFSET));
+	dev_info(core->dev, "# Data Cache Feature Register:       0x%x", zynpu_read32(core->base0, ZHOUYI_DATA_CACHE_FEATURE_REG_OFFSET));
+	dev_info(core->dev, "#############################################");
+}
+
+static int zhouyi_v2_query_cap(struct zynpu_core *core, struct zynpu_cap *cap)
+{
+	if (!core)
+		return 0;
+	return zhouyi_query_cap(core->base0, cap);
+}
+
+static void zhouyi_v2_io_rw(struct zynpu_core *core, struct zynpu_io_req *io_req)
+{
+	if (core)
+		zhouyi_io_rw(core->base0, io_req);
+}
+
+static int zhouyi_v2_upper_half(void *data)
+{
+	int ret = 0;
+	struct zynpu_priv* zynpu = (struct zynpu_priv*)data;
+	struct zynpu_core* core = zynpu->core0;
+
+	if (!core) {
+		ret = ZYNPU_ERRCODE_INTERNAL_NULLPTR;
+		goto finish;
+	}
+
+	zhouyi_v2_disable_interrupt(core);
+	ret = zhouyi_v2_read_status_reg(core);
+	if (ret & ZHOUYI_IRQ_QEMPTY) {
+		zhouyi_v2_clear_qempty_interrupt(core);
+	}
+
+	if (ret & ZHOUYI_IRQ_DONE) {
+		zhouyi_v2_clear_done_interrupt(core);
+		zynpu_job_manager_update_job_state_irq(zynpu, 0);
+		zynpu_irq_schedulework(core->irq_obj);
+	}
+
+	if (ret & ZHOUYI_IRQ_EXCEP) {
+		zhouyi_v2_clear_excep_interrupt(core);
+		zynpu_job_manager_update_job_state_irq(zynpu, 1);
+		zynpu_irq_schedulework(core->irq_obj);
+	}
+
+	if (ret & ZHOUYI_IRQ_FAULT)
+		zhouyi_v2_clear_fault_interrupt(core);
+	zhouyi_v2_enable_interrupt(core);
+
+	/* success */
+	ret = 0;
+
+finish:
+	return ret;
+}
+
+static void zhouyi_v2_bottom_half(void *data)
+{
+	struct zynpu_priv *zynpu = (struct zynpu_priv*)data;
+	zynpu_job_manager_update_job_queue_done_irq(&zynpu->job_manager);
+}
+
+struct zynpu_io_operation zhouyi_v2_ops = {
+	.enable_interrupt = zhouyi_v2_enable_interrupt,
+	.disable_interrupt = zhouyi_v2_disable_interrupt,
+	.trigger = zhouyi_v2_trigger,
+	.is_idle = zhouyi_v2_is_idle,
+	.read_status_reg = zhouyi_v2_read_status_reg,
+	.print_hw_id_info = zhouyi_v2_print_hw_id_info,
+	.query_capability = zhouyi_v2_query_cap,
+	.io_rw = zhouyi_v2_io_rw,
+	.upper_half = zhouyi_v2_upper_half,
+	.bottom_half = zhouyi_v2_bottom_half,
+};
\ No newline at end of file
diff --git a/drivers/staging/zynpu/zhouyi.h b/drivers/staging/zynpu/zhouyi.h
new file mode 100644
index 000000000000..9a63fce4ffcd
--- /dev/null
+++ b/drivers/staging/zynpu/zhouyi.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+*
+* Zhouyi AI Accelerator driver
+*
+* Copyright (C) 2020 Arm (China) Ltd.
+* Copyright (C) 2021 Cai Huoqing
+*/
+
+/**
+ * @file zhouyi.h
+ * Header of the zhouyi ZYNPU hardware control and interrupt handle operations
+ */
+
+#ifndef _ZYNPU_ZHOUYI_H_
+#define _ZYNPU_ZHOUYI_H_
+
+#include <linux/device.h>
+#include "zynpu_io.h"
+
+/**
+ * Zhouyi ZYNPU Common Interrupts
+ */
+#define ZHOUYI_IRQ_NONE   0x0
+#define ZHOUYI_IRQ_QEMPTY 0x1
+#define ZHOUYI_IRQ_DONE   0x2
+#define ZHOUYI_IRQ_EXCEP  0x4
+
+#define ZHOUYI_IRQ  (ZHOUYI_IRQ_QEMPTY | ZHOUYI_IRQ_DONE | ZHOUYI_IRQ_EXCEP)
+
+#define ZHOUYI_ZYNPU_IDLE_STATUS   0x70000
+
+/**
+ * Zhouyi ZYNPU Common Host Control Register Map
+ */
+#define ZHOUYI_CTRL_REG_OFFSET		0x0
+#define ZHOUYI_STAT_REG_OFFSET		0x4
+#define ZHOUYI_START_PC_REG_OFFSET	    0x8
+#define ZHOUYI_INTR_PC_REG_OFFSET	     0xC
+#define ZHOUYI_IPI_CTRL_REG_OFFSET	    0x10
+#define ZHOUYI_DATA_ADDR_0_REG_OFFSET	 0x14
+#define ZHOUYI_DATA_ADDR_1_REG_OFFSET	 0x18
+#define ZHOUYI_CLK_CTRL_REG_OFFSET	    0x3C
+#define ZHOUYI_ISA_VERSION_REG_OFFSET	 0x40
+#define ZHOUYI_TPC_FEATURE_REG_OFFSET	 0x44
+#define ZHOUYI_SPU_FEATURE_REG_OFFSET	 0x48
+#define ZHOUYI_HWA_FEATURE_REG_OFFSET	 0x4C
+#define ZHOUYI_REVISION_ID_REG_OFFSET	 0x50
+#define ZHOUYI_MEM_FEATURE_REG_OFFSET	 0x54
+#define ZHOUYI_INST_RAM_FEATURE_REG_OFFSET    0x58
+#define ZHOUYI_LOCAL_SRAM_FEATURE_REG_OFFSET  0x5C
+#define ZHOUYI_GLOBAL_SRAM_FEATURE_REG_OFFSET 0x60
+#define ZHOUYI_INST_CACHE_FEATURE_REG_OFFSET  0x64
+#define ZHOUYI_DATA_CACHE_FEATURE_REG_OFFSET  0x68
+
+struct zynpu_cap {
+	__u32 isa_version;
+	__u32 tpc_feature;
+	__u32 aiff_feature;
+	__u32 errcode;
+};
+
+int zhouyi_read_status_reg(struct io_region* io);
+void zhouyi_clear_qempty_interrupt(struct io_region* io);
+void zhouyi_clear_done_interrupt(struct io_region* io);
+void zhouyi_clear_excep_interrupt(struct io_region* io);
+int zhouyi_query_cap(struct io_region* io, struct zynpu_cap* cap);
+void zhouyi_io_rw(struct io_region* io, struct zynpu_io_req* io_req);
+
+#endif /* _ZYNPU_ZHOUYI_H_ */
\ No newline at end of file
diff --git a/drivers/staging/zynpu/zhouyi_base.c b/drivers/staging/zynpu/zhouyi_base.c
new file mode 100644
index 000000000000..1a01b5fabc50
--- /dev/null
+++ b/drivers/staging/zynpu/zhouyi_base.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+*
+* Zhouyi AI Accelerator driver
+*
+* Copyright (C) 2020 Arm (China) Ltd.
+* Copyright (C) 2021 Cai Huoqing
+*/
+
+/**
+ * @file zhouyi.c
+ * Implementations of the zhouyi ZYNPU hardware control and interrupt handle operations
+ */
+
+#include "zhouyi.h"
+
+int zhouyi_read_status_reg(struct io_region *io)
+{
+	return zynpu_read32(io, ZHOUYI_STAT_REG_OFFSET);
+}
+
+void zhouyi_clear_qempty_interrupt(struct io_region *io)
+{
+	zynpu_write32(io, ZHOUYI_STAT_REG_OFFSET, ZHOUYI_IRQ_QEMPTY);
+}
+
+void zhouyi_clear_done_interrupt(struct io_region *io)
+{
+	zynpu_write32(io, ZHOUYI_STAT_REG_OFFSET, ZHOUYI_IRQ_DONE);
+}
+
+void zhouyi_clear_excep_interrupt(struct io_region *io)
+{
+	zynpu_write32(io, ZHOUYI_STAT_REG_OFFSET, ZHOUYI_IRQ_EXCEP);
+}
+
+int zhouyi_query_cap(struct io_region *io, struct zynpu_cap *cap)
+{
+	int ret = 0;
+
+	if ((!io) || (!cap)) {
+		ret = -EINVAL;
+		goto finish;
+	}
+
+	cap->isa_version = zynpu_read32(io, ZHOUYI_ISA_VERSION_REG_OFFSET);
+	cap->tpc_feature = zynpu_read32(io, ZHOUYI_TPC_FEATURE_REG_OFFSET);
+	cap->aiff_feature = zynpu_read32(io, ZHOUYI_HWA_FEATURE_REG_OFFSET);
+
+	/* success */
+	cap->errcode = 0;
+
+finish:
+	return ret;
+}
+
+void zhouyi_io_rw(struct io_region *io, struct zynpu_io_req *io_req)
+{
+	if ((!io) || (!io_req)) {
+		pr_err("invalid input args io/io_req to be NULL!");
+		return;
+	}
+
+	/* TBD: offset r/w permission should be checked */
+
+	if (io_req->rw == ZYNPU_IO_READ)
+	    io_req->value = zynpu_read32(io, io_req->offset);
+	else if (io_req->rw == ZYNPU_IO_WRITE)
+	    zynpu_write32(io, io_req->offset, io_req->value);
+	io_req->errcode = 0;
+}
diff --git a/drivers/staging/zynpu/zynpu.h b/drivers/staging/zynpu/zynpu.h
new file mode 100644
index 000000000000..95abb71c0eb8
--- /dev/null
+++ b/drivers/staging/zynpu/zynpu.h
@@ -0,0 +1,252 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+*
+* Zhouyi AI Accelerator driver
+*
+* Copyright (C) 2020 Arm (China) Ltd.
+* Copyright (C) 2021 Cai Huoqing
+*/
+
+/**
+ * @file zynpu.h
+ * Header of the zynpu device struct
+ */
+
+#ifndef _ZYNPU_H_
+#define _ZYNPU_H_
+
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+#include "zynpu_irq.h"
+#include "zynpu_io.h"
+#include "zynpu_job_manager.h"
+#include "zynpu_mm.h"
+#include "zhouyi.h"
+
+#define ZYNPU_ERRCODE_NO_ERROR	   0
+#define ZYNPU_ERRCODE_NO_MEMORY	  1
+#define ZYNPU_ERRCODE_INTERNAL_NULLPTR   2
+#define ZYNPU_ERRCODE_INVALID_ARGS       3
+#define ZYNPU_ERRCODE_CREATE_KOBJ_ERR    4
+#define ZYNPU_ERRCODE_ITEM_NOT_FOUND     5
+
+#define IPUIOC_MAGIC 'A'
+
+#define IPUIOC_QUERYCAP	  _IOR(IPUIOC_MAGIC,  0, struct zynpu_cap)
+#define IPUIOC_REQBUF	    _IOWR(IPUIOC_MAGIC, 1, struct buf_request)
+#define IPUIOC_RUNJOB	    _IOWR(IPUIOC_MAGIC, 2, struct user_job)
+#define IPUIOC_FREEBUF	   _IOW(IPUIOC_MAGIC,  3, struct buf_desc)
+#define IPUIOC_REQSHMMAP	 _IOR(IPUIOC_MAGIC,  4, __u64)
+#define IPUIOC_REQIO	     _IOWR(IPUIOC_MAGIC, 5, struct zynpu_io_req)
+#define IPUIOC_QUERYSTATUS       _IOWR(IPUIOC_MAGIC, 6, struct job_status_query)
+#define IPUIOC_KILL_TIMEOUT_JOB  _IOW(IPUIOC_MAGIC,  7, __u32)
+
+enum zynpu_version {
+	ZYNPU_VERSION_ZHOUYI_V1 = 1,
+	ZYNPU_VERSION_ZHOUYI_V2
+};
+
+/**
+ * struct zynpu_core - a general struct describe a hardware ZYNPU core
+ *
+ * @version: ZYNPU hardware version
+ * @freq_in_MHz: ZYNPU core working frequency
+ * @max_sched_num: maximum number of jobs can be scheduled in pipeline
+ * @base0: IO region of this ZYNPU core
+ * @irq_obj: interrupt object of this core
+ */
+struct zynpu_core {
+	int version;
+	int freq_in_MHz;
+	int max_sched_num;
+	struct io_region *base0;
+	struct zynpu_irq_object *irq_obj;
+	struct device *dev;
+};
+
+/**
+ * struct zynpu_io_operation - a struct contains ZYNPU hardware operation methods
+ *
+ * @enable_interrupt: Enable all ZYNPU interrupts
+ * @disable_interrupt: Disable all ZYNPU interrupts
+ * @trigger: trigger ZYNPU to run a job
+ * @is_idle: Is ZYNPU hardware idle or not
+ * @read_status_reg: Read status register value
+ * @print_hw_id_info: Print ZYNPU version ID registers information
+ * @query_capability: Query ZYNPU hardware capability information
+ * @io_rw: Direct IO read/write operations
+ */
+struct zynpu_io_operation {
+	void (*enable_interrupt)(struct zynpu_core* core);
+	void (*disable_interrupt)(struct zynpu_core* core);
+	int  (*trigger)(struct zynpu_core* core, struct user_job_desc* udesc, int tid);
+	bool (*is_idle)(struct zynpu_core* core);
+	int  (*read_status_reg)(struct zynpu_core* core);
+	void (*print_hw_id_info)(struct zynpu_core* core);
+	int  (*query_capability)(struct zynpu_core* core, struct zynpu_cap* cap);
+	void (*io_rw)(struct zynpu_core* core, struct zynpu_io_req* io_req);
+	int  (*upper_half)(void* data);
+	void (*bottom_half)(void* data);
+};
+
+struct zynpu_priv {
+	int board;
+	int version;
+	struct zynpu_core *core0;
+	struct zynpu_io_operation* core_ctrl;
+	int   open_num;
+	struct device *dev;
+	struct file_operations zynpu_fops;
+	struct miscdevice *misc;
+	struct mutex lock;
+	struct zynpu_job_manager job_manager;
+	struct zynpu_memory_manager mm;
+	struct kobject *sys_kobj;
+	int is_suspend;
+};
+
+/*
+ * @brief register ZYNPU fops operations into fops struct
+ *
+ * @param fops: file_operations struct pointer
+ *
+ * @return ZYNPU_ERRCODE_NO_ERROR if successful; others if failed.
+ */
+int zynpu_fops_register(struct file_operations *fops);
+/*
+ * @brief initialize sysfs debug interfaces in probe
+ *
+ * @param zynpu_priv: zynpu_priv struct pointer
+ *
+ * @return 0 if successful; others if failed.
+ */
+int zynpu_create_sysfs(void *zynpu_priv);
+/*
+ * @brief de-initialize sysfs debug interfaces in remove
+ *
+ * @param zynpu_priv: zynpu_priv struct pointer
+ */
+void zynpu_destroy_sysfs(void *zynpu_priv);
+/**
+ * @brief initialize an input ZYNPU private data struct
+ *
+ * @param zynpu: pointer to ZYNPU private data struct
+ * @param dev: device struct pointer
+ *
+ * @return 0 if successful; others if failed;
+ */
+int init_zynpu_priv(struct zynpu_priv *zynpu, struct device *dev);
+/**
+ * @brief initialize ZYNPU core info in the ZYNPU private data struct
+ *
+ * @param zynpu: pointer to ZYNPU private data struct
+ * @param irqnum: ZYNPU interrupt number
+ * @param base: ZYNPU external registers phsical base address
+ * @param size: ZYNPU external registers address remap size
+ *
+ * @return 0 if successful; others if failed;
+ */
+int zynpu_priv_init_core(struct zynpu_priv *zynpu, int irqnum, u64 base, u64 size);
+/**
+ * @brief initialize the SoC info in the ZYNPU private data struct
+ *
+ * @param zynpu: pointer to ZYNPU private data struct
+ * @param base: SoC registers phsical base address
+ * @param size: SoC external registers address remap size
+ *
+ * @return 0 if successful; others if failed;
+ */
+int zynpu_priv_init_soc(struct zynpu_priv *zynpu, u64 base, u64 size);
+/**
+ * @brief add a reserved memory region into the ZYNPU private data struct
+ *
+ * @param zynpu: pointer to ZYNPU private data struct
+ * @param base: memory region start physical address
+ * @param size: memory region length size
+ * @param type: ZYNPU memory type
+ *
+ * @return 0 if successful; others if failed;
+ */
+int zynpu_priv_add_mem_region(struct zynpu_priv *zynpu, u64 base, u64 size,
+	enum zynpu_mem_type type);
+/**
+ * @brief get ZYNPU hardware version number wrapper
+ *
+ * @param zynpu: pointer to ZYNPU private data struct
+ *
+ * @return version
+ */
+int zynpu_priv_get_version(struct zynpu_priv *zynpu);
+/**
+ * @brief enable interrupt wrapper
+ *
+ * @param zynpu: pointer to ZYNPU private data struct
+ *
+ * @return void
+ */
+void zynpu_priv_enable_interrupt(struct zynpu_priv *zynpu);
+/**
+ * @brief disable interrupt wrapper
+ *
+ * @param zynpu: pointer to ZYNPU private data struct
+ *
+ * @return void
+ */
+void zynpu_priv_disable_interrupt(struct zynpu_priv *zynpu);
+/**
+ * @brief disable interrupt wrapper
+ *
+ * @param zynpu:  pointer to ZYNPU private data struct
+ * @param udesc: descriptor of a job to be triggered on ZYNPU
+ * @param tid:   user thread ID
+ *
+ * @return 0 if successful; others if failed;
+ */
+int zynpu_priv_trigger(struct zynpu_priv *zynpu, struct user_job_desc *udesc, int tid);
+/**
+ * @brief check if ZYNPU is idle wrapper
+ *
+ * @param zynpu: pointer to ZYNPU private data struct
+ *
+ * @return 1 if ZYNPU is in IDLE state
+ */
+bool zynpu_priv_is_idle(struct zynpu_priv *zynpu);
+/**
+ * @brief query ZYNPU capability wrapper
+ *
+ * @param zynpu: pointer to ZYNPU private data struct
+ * @param cap:  pointer to the capability struct
+ *
+ * @return 0 if successful; others if failed;
+ */
+int zynpu_priv_query_capability(struct zynpu_priv *zynpu, struct zynpu_cap *cap);
+/**
+ * @brief ZYNPU external register read/write wrapper
+ *
+ * @param zynpu: pointer to ZYNPU private data struct
+ * @param io_req:  pointer to the io_req struct
+ *
+ * @return void
+ */
+void zynpu_priv_io_rw(struct zynpu_priv *zynpu, struct zynpu_io_req *io_req);
+/**
+ * @brief print ZYNPU hardware ID information wrapper
+ *
+ * @param zynpu: pointer to ZYNPU private data struct
+ *
+ * @return void
+ */
+void zynpu_priv_print_hw_id_info(struct zynpu_priv *zynpu);
+/**
+ * @brief deinit an ZYNPU private data struct
+ *
+ * @param zynpu: pointer to ZYNPU private data struct
+ *
+ * @return 0 if successful; others if failed;
+ */
+int deinit_zynpu_priv(struct zynpu_priv *zynpu);
+
+#endif /* _ZYNPU_H_ */
\ No newline at end of file
diff --git a/drivers/staging/zynpu/zynpu_core.c b/drivers/staging/zynpu/zynpu_core.c
new file mode 100644
index 000000000000..d0ab97747a88
--- /dev/null
+++ b/drivers/staging/zynpu/zynpu_core.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+*
+* Zhouyi AI Accelerator driver
+*
+* Copyright (C) 2020 Arm (China) Ltd.
+* Copyright (C) 2021 Cai Huoqing
+*/
+
+/**
+ * @file zynpu.c
+ * Implementation of the zynpu device struct creation & destroy
+ */
+
+#include <linux/of.h>
+#include "zynpu.h"
+
+extern struct zynpu_io_operation zhouyi_v1_ops;
+
+struct zynpu_priv z1_platform_priv = {
+	.version = ZYNPU_VERSION_ZHOUYI_V1,
+	.core_ctrl = &zhouyi_v1_ops,
+};
+
+static int init_misc_dev(struct zynpu_priv *zynpu)
+{
+	int ret = 0;
+
+	if (!zynpu)
+		return -EINVAL;
+
+	zynpu_fops_register(&zynpu->zynpu_fops);
+
+	zynpu->misc = devm_kzalloc(zynpu->dev, sizeof(struct miscdevice), GFP_KERNEL);
+	if (!zynpu->misc) {
+		dev_err(zynpu->dev, "no memory in allocating misc struct\n");
+		return -ENOMEM;
+	}
+
+	/* misc init */
+	zynpu->misc->minor = MISC_DYNAMIC_MINOR;
+	zynpu->misc->name = "zynpu";
+	zynpu->misc->fops = &zynpu->zynpu_fops;
+	zynpu->misc->mode = 0666;
+	ret = misc_register(zynpu->misc);
+	if (ret)
+		dev_err(zynpu->dev, "ZYNPU misc register failed");
+
+	return ret;
+}
+
+static void deinit_misc_dev(struct zynpu_priv *zynpu)
+{
+	if (zynpu)
+		misc_deregister(zynpu->misc);
+}
+
+int init_zynpu_priv(struct zynpu_priv *zynpu, struct device *dev)
+{
+	int ret = 0;
+
+	if ((!dev) || (!zynpu)) {
+		dev_err(dev, "invalid input args dts/zynpu to be NULL\n");
+		return -EINVAL;
+	}
+
+	zynpu->dev = dev;
+	mutex_init(&zynpu->lock);
+	zynpu->core0 = NULL;
+	zynpu->misc = NULL;
+	zynpu->is_suspend = 0;
+
+	/* init memory manager */
+	ret = zynpu_init_mm(&zynpu->mm, dev, zynpu->version);
+	if (ret)
+		goto err_handle;
+
+	/* init misc device and fops */
+	ret = init_misc_dev(zynpu);
+	if (ret)
+		goto err_handle;
+
+	ret = zynpu_create_sysfs(zynpu);
+	if (ret)
+		goto err_handle;
+
+	goto finish;
+
+err_handle:
+	deinit_zynpu_priv(zynpu);
+
+finish:
+	return ret;
+}
+
+static int
+create_zynpu_core(int version, int irqnum, u64 zynpu_base0, u64 base0_size,
+	u32 freq, zynpu_irq_uhandler_t uhandler, zynpu_irq_bhandler_t bhandler,
+	void *zynpu_priv, struct device *dev, struct zynpu_core **p_core)
+{
+	int ret = 0;
+	struct zynpu_core *core = NULL;
+
+	if ((!base0_size) || (!zynpu_priv) || (!dev) || (!p_core)) {
+		if (dev)
+			dev_err(dev, "invalid input args base0_size/zynpu_priv/p_core to be NULL\n");
+		return -EINVAL;
+	}
+
+	core = devm_kzalloc(dev, sizeof(struct zynpu_core), GFP_KERNEL);
+	if (!core) {
+		dev_err(dev, "no memory in allocating zynpu_core struct\n");
+		return -ENOMEM;
+	}
+
+	core->base0 = NULL;
+	core->irq_obj = NULL;
+
+	/* init core */
+	core->max_sched_num = 1;
+	core->version = version;
+
+	core->base0 = zynpu_create_ioregion(dev, zynpu_base0, base0_size);
+	if (!core->base0) {
+		dev_err(dev, "create IO region for core0 failed: base 0x%llx, size 0x%llx\n",
+			zynpu_base0, base0_size);
+		return -EFAULT;
+	}
+
+	core->irq_obj = zynpu_create_irq_object(irqnum, uhandler, bhandler,
+		zynpu_priv, dev, "zynpu");
+	if (!core->irq_obj) {
+		dev_err(dev, "create IRQ object for core0 failed: IRQ 0x%x\n", irqnum);
+		return -EFAULT;
+	}
+
+	core->freq_in_MHz = freq;
+	core->dev = dev;
+
+	/* success */
+	*p_core = core;
+	return ret;
+}
+
+static void destroy_zynpu_core(struct zynpu_core *core)
+{
+	if (core) {
+		if (core->base0)
+			zynpu_destroy_ioregion(core->base0);
+		if (core->irq_obj)
+			zynpu_destroy_irq_object(core->irq_obj);
+	}
+}
+
+int zynpu_priv_init_core(struct zynpu_priv *zynpu, int irqnum, u64 base, u64 size)
+{
+	int ret = 0;
+
+	if (!zynpu)
+		return -EINVAL;
+
+	ret = create_zynpu_core(zynpu->version, irqnum, base,
+				size, 0, zynpu->core_ctrl->upper_half,
+				zynpu->core_ctrl->bottom_half, zynpu,
+				zynpu->dev, &zynpu->core0);
+	if (ret)
+		return ret;
+
+	ret = zynpu_init_job_manager(&zynpu->job_manager, zynpu->dev,
+				     zynpu->core0->max_sched_num);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+int zynpu_priv_add_mem_region(struct zynpu_priv *zynpu, u64 base, u64 size,
+	enum zynpu_mem_type type)
+{
+	if (!zynpu)
+		return -EINVAL;
+
+	return zynpu_mm_add_region(&zynpu->mm, base, size, type);
+}
+
+int zynpu_priv_get_version(struct zynpu_priv *zynpu)
+{
+	if (zynpu)
+		return zynpu->core0->version;
+	return 0;
+}
+
+void zynpu_priv_enable_interrupt(struct zynpu_priv *zynpu)
+{
+	if (zynpu)
+	       zynpu->core_ctrl->enable_interrupt(zynpu->core0);
+}
+
+void zynpu_priv_disable_interrupt(struct zynpu_priv *zynpu)
+{
+	if (zynpu)
+	       zynpu->core_ctrl->disable_interrupt(zynpu->core0);
+}
+
+int zynpu_priv_trigger(struct zynpu_priv *zynpu, struct user_job_desc *udesc, int tid)
+{
+	if (zynpu)
+		return zynpu->core_ctrl->trigger(zynpu->core0, udesc, tid);
+	return -EINVAL;
+}
+
+bool zynpu_priv_is_idle(struct zynpu_priv *zynpu)
+{
+	if (zynpu)
+		return zynpu->core_ctrl->is_idle(zynpu->core0);
+	return 0;
+}
+
+int zynpu_priv_query_capability(struct zynpu_priv *zynpu, struct zynpu_cap *cap)
+{
+	if (zynpu)
+		return zynpu->core_ctrl->query_capability(zynpu->core0, cap);
+	return -EINVAL;
+}
+
+void zynpu_priv_io_rw(struct zynpu_priv *zynpu, struct zynpu_io_req *io_req)
+{
+	if (zynpu)
+		zynpu->core_ctrl->io_rw(zynpu->core0, io_req);
+}
+
+void zynpu_priv_print_hw_id_info(struct zynpu_priv *zynpu)
+{
+	if (zynpu)
+	       zynpu->core_ctrl->print_hw_id_info(zynpu->core0);
+}
+
+int deinit_zynpu_priv(struct zynpu_priv *zynpu)
+{
+	if (!zynpu)
+		return 0;
+
+	zynpu_destroy_sysfs(zynpu);
+
+	zynpu_deinit_mm(&zynpu->mm);
+	if (zynpu->misc)
+		deinit_misc_dev(zynpu);
+	if (zynpu->core0) {
+		destroy_zynpu_core(zynpu->core0);
+		zynpu_deinit_job_manager(&zynpu->job_manager);
+	}
+
+	return 0;
+}
\ No newline at end of file
diff --git a/drivers/staging/zynpu/zynpu_drv.c b/drivers/staging/zynpu/zynpu_drv.c
new file mode 100644
index 000000000000..5a1967f9981b
--- /dev/null
+++ b/drivers/staging/zynpu/zynpu_drv.c
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+*
+* Zhouyi AI Accelerator driver
+*
+* Copyright (C) 2020 Arm (China) Ltd.
+* Copyright (C) 2021 Cai Huoqing
+*/
+
+/**
+ * @file zynpu_platform_driver.c
+ * Implementations of the ZYNPU platform driver probe/remove func
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/clk.h>
+#include "zynpu.h"
+
+extern struct zynpu_priv z1_platform_priv;
+extern struct zynpu_priv z2_platform_priv;
+
+static const struct of_device_id zynpu_of_match[] = {
+#ifdef CONFIG_ZHOUYI_V1
+	{
+		.compatible = "armchina,zhouyi-v1",
+		.data = (void*)&z1_platform_priv,
+	},
+#elif CONFIG_ZHOUYI_V2
+	{
+		.compatible = "armchina,zhouyi-v2",
+		.data = (void*)&z2_platform_priv,
+	},
+#endif
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, zynpu_of_match);
+
+struct clk *clk_pll_zynpu;
+struct clk *clk_zynpu;
+struct clk *clk_zynpu_slv;
+
+/**
+ * @brief remove operation registered to platfom_driver struct
+ *	This function will be called while the module is unloading.
+ * @param p_dev: platform devide struct pointer
+ * @return 0 if successful; others if failed.
+ */
+static int zynpu_remove(struct platform_device *p_dev)
+{
+	int ret = 0;
+	struct device *dev = &p_dev->dev;
+	struct zynpu_priv *zynpu = platform_get_drvdata(p_dev);
+
+	if (!IS_ERR_OR_NULL(clk_zynpu_slv))
+	{
+	    clk_disable_unprepare(clk_zynpu_slv);
+	    dev_info(dev, "clk_zynpu_slv disable ok ");
+	}
+
+	if (!IS_ERR_OR_NULL(clk_zynpu))
+	{
+	    clk_disable_unprepare(clk_zynpu);
+	    dev_info(dev, "clk_zynpu disable ok");
+	}
+	clk_zynpu     = NULL;
+	clk_zynpu_slv = NULL;
+	clk_pll_zynpu = NULL;
+
+	zynpu_priv_disable_interrupt(zynpu);
+
+	ret = deinit_zynpu_priv(zynpu);
+	if (ret)
+		return ret;
+
+	/* success */
+	dev_info(dev, "ZYNPU KMD remove done");
+	return 0;
+}
+
+/**
+ * @brief probe operation registered to platfom_driver struct
+ *	This function will be called while the module is loading.
+ *
+ * @param p_dev: platform devide struct pointer
+ * @return 0 if successful; others if failed.
+ */
+static int zynpu_probe(struct platform_device *p_dev)
+{
+	int ret = 0;
+	struct device *dev = &p_dev->dev;
+	struct device_node *dev_node = dev->of_node;
+	const struct of_device_id *of_id;
+	struct resource *res;
+	struct resource res_mem;
+	struct zynpu_priv *zynpu;
+	struct device_node *np;
+	int irqnum = 0;
+	int cma_reserve_size = 0;
+	u64 base = 0;
+	u64 base_size = 0;
+
+	dev_info(dev, "ZYNPU KMD probe start...\n");
+
+	/* match */
+	of_id = of_match_node(zynpu_of_match, dev_node);
+	if (!of_id) {
+		dev_err(dev, "[Probe 0/3] match node failed\n");
+		return -EINVAL;
+	}
+	zynpu = (struct zynpu_priv *)of_id->data;
+
+	if (zynpu->version == ZYNPU_VERSION_ZHOUYI_V1)
+		dev_info(dev, "[Probe 0/3] ZYNPU version: zhouyi-v1\n");
+	else if (zynpu->version == ZYNPU_VERSION_ZHOUYI_V2)
+		dev_info(dev, "[Probe 0/3] ZYNPU version: zhouyi-v2\n");
+	else
+		dev_err(dev, "[Probe 0/3] Unrecognized ZYNPU version: 0x%x\n", zynpu->version);
+
+	ret = init_zynpu_priv(zynpu, dev);
+	if (ret)
+		return ret;
+
+	/* get ZYNPU IO */
+	res = platform_get_resource(p_dev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "[Probe 1/3] get platform io region failed\n");
+		ret = -EINVAL;
+		goto probe_fail;
+	}
+	base = res->start;
+	base_size = res->end - res->start + 1;
+	dev_dbg(dev, "[Probe 1/3] get ZYNPU IO region: [0x%llx, 0x%llx]\n",
+		base, res->end);
+
+	/* get interrupt number */
+	res = platform_get_resource(p_dev, IORESOURCE_IRQ, 0);
+	if (!res) {
+		dev_err(dev, "[Probe 1/3] get irqnum failed\n");
+		ret = -EINVAL;
+		goto probe_fail;
+	}
+	irqnum = res->start;
+	dev_dbg(dev, "[Probe 1/3] get IRQ number: 0x%x\n", irqnum);
+
+	ret = zynpu_priv_init_core(zynpu, irqnum, base, base_size);
+	if (ret) {
+		goto probe_fail;
+	}
+	dev_info(dev, "[Probe 1/3] Probe stage 1/3 done: create core\n");
+
+	/* get CMA reserved buffer info */
+	np = of_parse_phandle(dev->of_node, "memory-region", 0);
+	if (np) {
+		if (of_address_to_resource(np, 0, &res_mem))
+			goto probe_fail;
+		dev_dbg(dev, "[Probe 2/3] get CMA region: [0x%llx, 0x%llx]\n",
+		res_mem.start, res_mem.end);
+		ret = zynpu_priv_add_mem_region(zynpu, res_mem.start,
+					       res_mem.end - res_mem.start + 1,
+					       ZYNPU_MEM_TYPE_CMA);
+		if (ret) {
+			dev_err(dev, "[Probe 2/3] add new region failed\n");
+			goto probe_fail;
+		}
+		of_node_put(np);
+
+		ret = of_property_read_u32(dev->of_node, "cma-reserved-bytes", &cma_reserve_size);
+		if (ret) {
+			dev_err(dev, "get cma reserved size property failed!");
+			goto probe_fail;
+		}
+
+		ret = zynpu_priv_add_mem_region(zynpu, res_mem.start, cma_reserve_size, ZYNPU_MEM_TYPE_CMA);
+		if (ret) {
+			dev_err(dev, "[Probe 2/3] add new region failed\n");
+			goto probe_fail;
+		}
+		dev_info(dev, "[Probe 2/3] get CMA size 0x%x\n", cma_reserve_size);
+	} else {
+		dev_info(dev, "[Probe 2/3] No %s specified\n", "memory-region");
+	}
+
+
+	/* get SRAM reserved buffer info, optional */
+	np = of_parse_phandle(dev->of_node, "sram-region", 0);
+	if (np) {
+		if (of_address_to_resource(np, 0, &res_mem))
+			goto probe_fail;
+		dev_dbg(dev, "[Probe 2/3] get SRAM region: [0x%llx, 0x%llx]\n",
+			res_mem.start, res_mem.end);
+		ret = zynpu_priv_add_mem_region(zynpu, res_mem.start,
+			res_mem.end - res_mem.start + 1, ZYNPU_MEM_TYPE_SRAM);
+		if (ret) {
+			dev_err(dev, "[Probe 2/3] add new region failed\n");
+			goto probe_fail;
+		}
+		of_node_put(np);
+		dev_info(dev, "[Probe 2/3] Stage 2/3 done: add memory region(s)\n");
+	} else {
+		dev_dbg(dev, "[Probe 2/3] No %s specified\n", "sram-region");
+	}
+
+	/* set clock enable */
+	clk_zynpu = of_clk_get(dev_node, 0);
+	if (IS_ERR_OR_NULL(clk_zynpu)) {
+	    dev_err(dev, "clk_zynpu get failed\n");
+	    ret = PTR_ERR(clk_zynpu);
+	    goto probe_fail;
+	}
+
+	clk_pll_zynpu = of_clk_get(dev_node, 1);
+	if (IS_ERR_OR_NULL(clk_pll_zynpu)) {
+	    dev_err(dev, "clk_pll_zynpu get failed\n");
+	    ret = PTR_ERR(clk_pll_zynpu);
+	    goto probe_fail;
+	}
+
+	clk_zynpu_slv = of_clk_get(dev_node, 2);
+	if (IS_ERR_OR_NULL(clk_zynpu_slv)) {
+	    dev_err(dev, "clk_zynpu_slv get failed\n");
+	    ret = PTR_ERR(clk_zynpu_slv);
+	    goto probe_fail;
+	}
+
+	if (clk_set_rate(clk_zynpu, 600 * 1000000)) {
+	    dev_err(dev, "set clk_zynpu rate fail\n");
+	    ret = -EBUSY;
+	    goto probe_fail;
+	}
+
+	if (clk_prepare_enable(clk_zynpu)) {
+	    dev_err(dev, "clk_zynpu enable failed\n");
+	    ret = -EBUSY;
+	    goto probe_fail;
+	}
+
+	if (clk_prepare_enable(clk_pll_zynpu)) {
+	    dev_err(dev, "clk_zynpu_slv enable failed\n");
+	    ret = -EBUSY;
+	    goto probe_fail;
+	}
+	if (clk_prepare_enable(clk_zynpu_slv)) {
+	    dev_err(dev, "clk_zynpu_slv enable failed\n");
+	    ret = -EBUSY;
+	    goto probe_fail;
+	}
+	dev_info(dev, "set zynpu clock ok!");
+
+	zynpu_priv_enable_interrupt(zynpu);
+	zynpu_priv_print_hw_id_info(zynpu);
+	dev_info(dev, "[Probe 3/3] Stage 3/3 done: IO read/write\n");
+
+	/* success */
+	platform_set_drvdata(p_dev, zynpu);
+	dev_info(dev, "ZYNPU KMD probe done");
+	goto finish;
+
+	/* failed */
+probe_fail:
+
+	if(!IS_ERR_OR_NULL(clk_zynpu_slv)) {
+	    clk_disable_unprepare(clk_zynpu_slv);
+	}
+	if(!IS_ERR_OR_NULL(clk_zynpu)) {
+	    clk_disable_unprepare(clk_zynpu);
+	}
+	clk_zynpu = NULL;
+	clk_zynpu_slv = NULL;
+	clk_pll_zynpu = NULL;
+
+	deinit_zynpu_priv(zynpu);
+
+finish:
+	return ret;
+}
+
+static int zynpu_suspend(struct platform_device *p_dev,pm_message_t state)
+{
+    struct device *dev = &p_dev->dev;
+    struct zynpu_priv *zynpu = platform_get_drvdata(p_dev);
+
+	if (zynpu && zynpu_priv_is_idle(zynpu)) {
+		dev_info(dev, "zynpu in idle status !");
+	} else {
+		dev_err(dev,"zynpu in busy status !");
+		return -1;
+	}
+
+	if (!IS_ERR_OR_NULL(clk_zynpu_slv)) {
+		clk_disable_unprepare(clk_zynpu_slv);
+		dev_info(dev, "disable clk_zynpu_slv ok");
+	}
+	if (!IS_ERR_OR_NULL(clk_zynpu)) {
+		clk_disable_unprepare(clk_zynpu);
+		dev_info(dev, "disable clk_zynpu ok");
+	}
+	dev_info(dev, "zynpu_suspend ok");
+
+	return 0;
+}
+
+static int zynpu_resume(struct platform_device *p_dev)
+{
+    struct device *dev = &p_dev->dev;
+    struct zynpu_priv *zynpu = platform_get_drvdata(p_dev);
+
+	if(NULL == zynpu) {
+		dev_err(dev, "zynpu is null ,resume fail...!");
+		return -1;
+	}
+
+	if (clk_set_parent(clk_zynpu, clk_pll_zynpu)) {
+		dev_err(dev, "set clk_zynpu parent fail\n");
+	}
+	if (clk_set_rate(clk_zynpu, 600 * 1000000)) {
+		dev_err(dev, "set clk_zynpu rate fail\n");
+	}
+	if (clk_prepare_enable(clk_zynpu_slv)) {
+		dev_err(dev, "clk_zynpu_slv enable failed\n");
+	}
+	if (clk_prepare_enable(clk_zynpu)) {
+		dev_err(dev, "clk_zynpu enable failed\n");
+	}
+
+    zynpu_priv_enable_interrupt(zynpu);
+    zynpu_priv_print_hw_id_info(zynpu);
+	dev_info(dev, "zynpu_resume ok.");
+
+	return 0;
+}
+
+static struct platform_driver zynpu_platform_driver = {
+	.probe = zynpu_probe,
+	.remove = zynpu_remove,
+	.suspend = zynpu_suspend,
+	.resume  = zynpu_resume,
+	.driver = {
+		.name = "armchina-zynpu",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(zynpu_of_match),
+	},
+};
+
+module_platform_driver(zynpu_platform_driver);
+MODULE_LICENSE("GPL");
diff --git a/drivers/staging/zynpu/zynpu_fops.c b/drivers/staging/zynpu/zynpu_fops.c
new file mode 100644
index 000000000000..ad22c0969ca5
--- /dev/null
+++ b/drivers/staging/zynpu/zynpu_fops.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+*
+* Zhouyi AI Accelerator driver
+*
+* Copyright (C) 2020 Arm (China) Ltd.
+* Copyright (C) 2021 Cai Huoqing
+*/
+
+/**
+ * @file zynpu_fops.c
+ * Implementations of KMD file operation API
+ */
+
+#include <linux/fs.h>
+#include <linux/mm_types.h>
+#include <linux/sched.h>
+#include <linux/uaccess.h>
+#include <linux/poll.h>
+#include "zynpu_mm.h"
+#include "zynpu_job_manager.h"
+#include "zynpu_session.h"
+#include "zynpu.h"
+
+static int zynpu_open(struct inode *inode, struct file *filp)
+{
+	int ret = 0;
+	struct zynpu_priv *zynpu = NULL;
+	struct zynpu_session *session  = NULL;
+	int pid = task_pid_nr(current);
+
+	zynpu = container_of(filp->f_op, struct zynpu_priv, zynpu_fops);
+
+	ret = zynpu_create_session(pid, zynpu, &session);
+	if (ret) {
+		return ret;
+	} else {
+		filp->private_data = session;
+		filp->f_pos = 0;
+	}
+
+	/* success */
+	return ret;
+}
+
+static int zynpu_release(struct inode *inode, struct file *filp)
+{
+	struct zynpu_priv *zynpu = NULL;
+	struct zynpu_session *session = filp->private_data;
+
+	if (!session)
+		return -EINVAL;
+
+	zynpu = container_of(filp->f_op, struct zynpu_priv, zynpu_fops);
+
+	/* jobs should be cleared prior to buffer free */
+	zynpu_job_manager_cancel_session_jobs(&zynpu->job_manager, session);
+
+	zynpu_mm_free_session_buffers(&zynpu->mm, session);
+
+	zynpu_destroy_session(session);
+
+	return 0;
+}
+
+static long zynpu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	int ret = 0;
+	int cp_ret = 0;
+	struct zynpu_session *session = filp->private_data;
+	struct zynpu_priv *zynpu = NULL;
+
+	struct zynpu_cap cap;
+	struct buf_request buf_req;
+	struct zynpu_buffer buf;
+	struct user_job user_job;
+	struct session_job *kern_job = NULL;
+	struct buf_desc desc;
+	struct zynpu_io_req io_req;
+	struct job_status_query job;
+	u32 job_id;
+
+	if (!session)
+		return -EINVAL;
+
+	zynpu = container_of(filp->f_op, struct zynpu_priv, zynpu_fops);
+
+	switch (cmd)
+	{
+	case IPUIOC_QUERYCAP:
+		ret = copy_from_user(&cap, (struct zynpu_cap __user*)arg, sizeof(struct zynpu_cap));
+		if (ret)
+			dev_err(zynpu->dev, "KMD ioctl: QUERYCAP copy from user failed!");
+		else {
+			zynpu_priv_query_capability(zynpu, &cap);
+			/* copy cap info/errcode to user for reference */
+			cp_ret = copy_to_user((struct zynpu_cap __user*)arg, &cap, sizeof(struct zynpu_cap));
+			if ((ZYNPU_ERRCODE_NO_ERROR == ret) && (cp_ret))
+				ret = cp_ret;
+		}
+		break;
+	case IPUIOC_REQBUF:
+		ret = copy_from_user(&buf_req, (struct buf_request __user*)arg, sizeof(struct buf_request));
+		if (ret)
+			dev_err(zynpu->dev, "KMD ioctl: REQBUF copy from user failed!");
+		else {
+			ret = zynpu_mm_alloc(&zynpu->mm, &buf_req, &buf);
+			if (ZYNPU_ERRCODE_NO_ERROR == ret) {
+				ret = zynpu_session_add_buf(session, &buf_req, &buf);
+				if (ret)
+					dev_err(zynpu->dev, "KMD ioctl: add buf failed!");
+			}
+
+			/* copy buf info/errcode to user for reference */
+			cp_ret = copy_to_user((struct buf_request __user*)arg, &buf_req, sizeof(struct buf_request));
+			if ((ZYNPU_ERRCODE_NO_ERROR == ret) && (cp_ret))
+				ret = cp_ret;
+		}
+		break;
+	case IPUIOC_RUNJOB:
+		ret = copy_from_user(&user_job, (struct user_job __user*)arg, sizeof(struct user_job));
+		if (ret)
+			dev_err(zynpu->dev, "KMD ioctl: RUNJOB copy from user failed!");
+		else {
+			kern_job = zynpu_session_add_job(session, &user_job);
+			if (NULL == kern_job)
+				dev_err(zynpu->dev, "KMD ioctl: RUNJOB add failed!");
+			else {
+				ret = zynpu_job_manager_schedule_new_job(&zynpu->job_manager, &user_job, kern_job,
+					session);
+				if (ret)
+					dev_err(zynpu->dev, "KMD ioctl: RUNJOB run failed!");
+			}
+
+			/* copy job errcode to user for reference */
+			cp_ret = copy_to_user((struct user_job __user*)arg, &user_job, sizeof(struct user_job));
+			if ((ZYNPU_ERRCODE_NO_ERROR == ret) && (cp_ret))
+				ret = cp_ret;
+		}
+		break;
+	case IPUIOC_KILL_TIMEOUT_JOB:
+		ret = copy_from_user(&job_id, (u32 __user*)arg, sizeof(__u32));
+		if (ret)
+			dev_err(zynpu->dev, "KMD ioctl: KILL_TIMEOUT_JOB copy from user failed!");
+		else
+			ret = zynpu_invalidate_timeout_job(&zynpu->job_manager, job_id);
+		break;
+	case IPUIOC_FREEBUF:
+		ret = copy_from_user(&desc, (struct buf_desc __user*)arg, sizeof(struct buf_desc));
+		if (ret)
+			dev_err(zynpu->dev, "KMD ioctl: FREEBUF copy from user failed!");
+		else {
+			/* detach first to validate the free buf request */
+			ret = zynpu_session_detach_buf(session, &desc);
+			if (ret)
+				dev_err(zynpu->dev, "KMD ioctl: detach session buffer failed!");
+			else {
+				/* do free operation */
+				ret = zynpu_mm_free(&zynpu->mm, &desc);
+				if (ret)
+					dev_err(zynpu->dev, "KMD ioctl: free buf failed!");
+			}
+		}
+		break;
+	case IPUIOC_REQIO:
+		ret = copy_from_user(&io_req, (struct zynpu_io_req __user *)arg, sizeof(struct zynpu_io_req));
+		if (ret)
+			dev_err(zynpu->dev, "KMD ioctl: REQIO copy from user failed!");
+		else {
+			zynpu_priv_io_rw(zynpu, &io_req);
+			ret = copy_to_user((struct zynpu_io_req __user *)arg, &io_req, sizeof(struct zynpu_io_req));
+		}
+		break;
+	case IPUIOC_QUERYSTATUS:
+		ret = copy_from_user(&job, (struct job_status_query __user *)arg,
+		    sizeof(struct job_status_query));
+		if (ret)
+			dev_err(zynpu->dev, "KMD ioctl: QUERYSTATUS copy from user failed!");
+		else {
+			ret = zynpu_session_get_job_status(session, &job);
+			if (ZYNPU_ERRCODE_NO_ERROR == ret)
+				ret = copy_to_user((struct job_status_query __user *)arg, &job,
+				    sizeof(struct job_status_query));
+		}
+		break;
+	default:
+		dev_err(zynpu->dev, "no matching ioctl call (cmd = 0x%lx)!", (unsigned long)cmd);
+		ret = -ENOTTY;
+		break;
+	}
+
+	return ret;
+}
+
+static int zynpu_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	int ret = 0;
+	struct zynpu_priv *zynpu = NULL;
+	struct zynpu_session *session = filp->private_data;
+
+	if (!session)
+		return -EINVAL;
+
+	zynpu = container_of(filp->f_op, struct zynpu_priv, zynpu_fops);
+	ret = zynpu_session_mmap_buf(session, vma, zynpu->dev);
+	if (ret)
+		dev_err(zynpu->dev, "mmap to userspace failed!");
+
+	return ret;
+}
+
+static unsigned int zynpu_poll(struct file *filp, struct poll_table_struct *wait)
+{
+	unsigned int mask = 0;
+	struct zynpu_session *session = filp->private_data;
+	int tid = task_pid_nr(current);
+
+	if (!session)
+		return 0;
+
+	zynpu_session_add_poll_wait_queue(session, filp, wait, tid);
+
+	if (zynpu_session_thread_has_end_job(session, tid))
+		mask |= POLLIN | POLLRDNORM;
+
+	return mask;
+}
+
+int zynpu_fops_register(struct file_operations *fops)
+{
+	if (!fops)
+		return -EINVAL;
+
+	fops->owner = THIS_MODULE;
+	fops->open = zynpu_open;
+	fops->poll = zynpu_poll;
+	fops->unlocked_ioctl = zynpu_ioctl;
+#ifdef CONFIG_COMPAT
+	fops->compat_ioctl = zynpu_ioctl;
+#endif
+	fops->mmap = zynpu_mmap;
+	fops->release = zynpu_release;
+
+	return 0;
+}
diff --git a/drivers/staging/zynpu/zynpu_io.c b/drivers/staging/zynpu/zynpu_io.c
new file mode 100644
index 000000000000..5ea395ae8aa9
--- /dev/null
+++ b/drivers/staging/zynpu/zynpu_io.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+*
+* Zhouyi AI Accelerator driver
+*
+* Copyright (C) 2020 Arm (China) Ltd.
+* Copyright (C) 2021 Cai Huoqing
+*/
+
+/**
+ * @file zynpu_io.c
+ * Implementations of ZYNPU IO R/W API
+ */
+
+#include <asm/io.h>
+#include "zynpu_io.h"
+
+struct io_region *zynpu_create_ioregion(struct device *dev, u64 phys_base, u32 size)
+{
+	struct io_region *region = NULL;
+
+	if ((!size) || (!dev)) {
+		dev_dbg(dev, "invalid input args size/dev!");
+		goto fail;
+	}
+
+	region = devm_kzalloc(dev, sizeof(struct io_region), GFP_KERNEL);
+	if (!region)
+		goto fail;
+
+	if (!request_mem_region(phys_base, size, "zynpu")) {
+		dev_err(dev, "request IO region failed");
+		goto fail;
+	}
+
+	region->kern = ioremap(phys_base, size);
+	if (!region->kern) {
+		dev_err(dev, "ioremap failed");
+		goto fail;
+	}
+
+	region->phys = phys_base;
+	region->size = size;
+
+	/* success */
+	goto finish;
+
+fail:
+	dev_err(dev, "creating IO region [0x%llx, 0x%llx] failed",
+		phys_base, phys_base + size - 1);
+
+finish:
+	return region;
+}
+
+void zynpu_destroy_ioregion(struct io_region *region)
+{
+	if (region && region->kern) {
+		iounmap(region->kern);
+		release_mem_region(region->phys, region->size);
+		region->kern = NULL;
+		region->phys = 0;
+		region->size = 0;
+	}
+}
+
+u8 zynpu_read8(struct io_region *region, __IO offset)
+{
+	if (region && region->kern && (offset < region->size))
+		return readb((void __iomem *)((__IO)(region->kern) + offset));
+	else {
+		pr_err("KMD io error: read8 invalid operation or args!");
+		return 0;
+	}
+}
+
+u16 zynpu_read16(struct io_region *region, __IO offset)
+{
+	if (region && region->kern && (offset < region->size))
+		return readw((void __iomem *)((__IO)(region->kern) + offset));
+	else {
+		pr_err("KMD io error: read16 invalid operation or args!");
+		return 0;
+	}
+}
+
+u32 zynpu_read32(struct io_region *region, __IO offset)
+{
+	if (region && region->kern && (offset < region->size))
+		return readl((void __iomem *)((__IO)(region->kern) + offset));
+	else {
+		if (region) {
+			pr_err("KMD io error: read32 invalid operation or args! \
+			    (offset 0x%lx, region_max 0x%lx)",
+			    (unsigned long)offset, (unsigned long)region->size);
+		} else {
+			pr_err("KMD io error: read32 invalid args to be NULL!");
+		}
+		return 0;
+	}
+}
+
+void zynpu_write8(struct io_region *region, __IO offset, unsigned int data)
+{
+	data = data & 0xFF;
+	if (region && region->kern && (offset < region->size))
+		return writeb((u8)data, (void __iomem *)((__IO)(region->kern) + offset));
+	else
+		pr_err("KMD io error: write8 invalid operation or args!");
+}
+
+void zynpu_write16(struct io_region *region, __IO offset, unsigned int data)
+{
+	data = data & 0xFFFF;
+	if (region && region->kern && (offset < region->size))
+		return writew((u16)data, (void __iomem *)((__IO)(region->kern) + offset));
+	else
+		pr_err("KMD io error: write16 invalid operation or args!");
+}
+
+void zynpu_write32(struct io_region *region, __IO offset, unsigned int data)
+{
+	if (region && region->kern && (offset < region->size))
+		return writel((u32)data, (void __iomem *)((__IO)(region->kern) + offset));
+	else {
+		if (region)
+			pr_err("KMD io error: write32 invalid operation or args! \
+			(offset 0x%lx, region_max 0x%lx)",
+			(unsigned long)offset, (unsigned long)region->size);
+		else
+			pr_err("KMD io error: write32 invalid args to be NULL!");
+	}
+}
\ No newline at end of file
diff --git a/drivers/staging/zynpu/zynpu_io.h b/drivers/staging/zynpu/zynpu_io.h
new file mode 100644
index 000000000000..b9be82f9f5c1
--- /dev/null
+++ b/drivers/staging/zynpu/zynpu_io.h
@@ -0,0 +1,119 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+*
+* Zhouyi AI Accelerator driver
+*
+* Copyright (C) 2020 Arm (China) Ltd.
+* Copyright (C) 2021 Cai Huoqing
+*/
+
+/**
+ * @file zynpu_io.h
+ * ZYNPU IO R/W API header file
+ */
+
+#ifndef _ZYNPU_IO_H_
+#define _ZYNPU_IO_H_
+
+#include <linux/device.h>
+#include <asm/io.h>
+#include <asm/types.h>
+
+typedef volatile unsigned long __IO;
+
+enum zynpu_rw_attr {
+	ZYNPU_IO_READ,
+	ZYNPU_IO_WRITE
+};
+
+struct zynpu_io_req {
+	__u32 offset;
+	enum zynpu_rw_attr rw;
+	__u32 value;
+	__u32 errcode;
+};
+
+/**
+ * struct io_region - a general struct describe IO region
+ *
+ * @phys: physical address base of an IO region
+ * @kern: kernel virtual address base remapped from phys
+ * @size: size of of an IO region in byte
+ */
+struct io_region {
+	u64  phys;
+	void *kern;
+	u32  size;
+};
+
+/**
+ * @brief create ZYNPU IO region using physical base address
+ *
+ * @param dev: device pointer
+ * @param phys_base: base address
+ * @param size: region size
+ *
+ * @return io_region pointer if successful; NULL if failed;
+ */
+struct io_region *zynpu_create_ioregion(struct device *dev, u64 phys_base, u32 size);
+/**
+ * @brief destroy an ZYNPU IO region
+ *
+ * @param region: region pointer created by zynpu_create_ioregion
+ */
+void zynpu_destroy_ioregion(struct io_region *region);
+/*
+ * @brief read ZYNPU register in byte (with memory barrier)
+ *
+ * @param region: IO region providing the base address
+ * @param offset: ZYNPU register offset
+ * @return register value
+ */
+u8 zynpu_read8(struct io_region *region, __IO offset);
+/*
+ * @brief read ZYNPU register in half-word (with memory barrier)
+ *
+ * @param region: IO region providing the base address
+ * @param offset: ZYNPU register offset
+ * @return register value
+ */
+u16 zynpu_read16(struct io_region *region, __IO offset);
+/*
+ * @brief read ZYNPU register in word (with memory barrier)
+ *
+ * @param region: IO region providing the base address
+ * @param offset: ZYNPU register offset
+ * @return register value
+ */
+u32 zynpu_read32(struct io_region *region, __IO offset);
+/*
+ * @brief write ZYNPU register in byte (with memory barrier)
+ *
+ * @param region: IO region providing the base address
+ * @param offset: ZYNPU register offset
+ * @param data:   data to be writen
+ * @return void
+ */
+void zynpu_write8(struct io_region *region, __IO offset, unsigned int data);
+/*
+ * @brief write ZYNPU register in half-word (with memory barrier)
+ *
+ * @param region: IO region providing the base address
+ * @param offset: ZYNPU register offset
+ * @param data:   data to be writen
+ * @return void
+ */
+void zynpu_write16(struct io_region *region, __IO offset, unsigned int data);
+/*
+ * @brief write ZYNPU register in word (with memory barrier)
+ *
+ * @param region: IO region providing the base address
+ * @param offset: ZYNPU register offset
+ * @param data:   data to be writen
+ * @return void
+ */
+void zynpu_write32(struct io_region *region, __IO offset, unsigned int data);
+
+#define ZYNPU_BIT(data, n) (((data)>>(n))&0x1)
+
+#endif /* _ZYNPU_IO_H_ */
diff --git a/drivers/staging/zynpu/zynpu_irq.c b/drivers/staging/zynpu/zynpu_irq.c
new file mode 100644
index 000000000000..00a85e2159ca
--- /dev/null
+++ b/drivers/staging/zynpu/zynpu_irq.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+*
+* Zhouyi AI Accelerator driver
+*
+* Copyright (C) 2020 Arm (China) Ltd.
+* Copyright (C) 2021 Cai Huoqing
+*/
+
+/**
+ * @file zynpu_irq.c
+ * Implementation of the interrupt request and handlers' abstraction
+ */
+
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/irqreturn.h>
+#include "zynpu_irq.h"
+#include "zynpu.h"
+
+static irqreturn_t zynpu_irq_handler_upper_half(int irq, void *dev_id)
+{
+	int ret = 0;
+	struct zynpu_irq_object *irq_obj = NULL;
+	struct zynpu_priv *zynpu = NULL;
+
+	if (!dev_id)
+		return IRQ_NONE;
+
+	zynpu = (struct zynpu_priv *)(((struct device *)dev_id)->driver_data);
+	irq_obj = zynpu->core0->irq_obj;
+	ret = irq_obj->uhandler(zynpu);
+	if (ret)
+		return IRQ_NONE;
+
+
+	return IRQ_HANDLED;
+}
+
+static void zynpu_irq_handler_bottom_half(struct work_struct *work)
+{
+	struct zynpu_irq_object *irq_obj = NULL;
+
+	if (work) {
+		irq_obj = container_of(work, struct zynpu_irq_object, work);
+		irq_obj->bhandler(irq_obj->zynpu_priv);
+	}
+}
+
+struct zynpu_irq_object *zynpu_create_irq_object(u32 irqnum, zynpu_irq_uhandler_t uhandler,
+	zynpu_irq_bhandler_t bhandler, void *zynpu_priv, struct device *dev, char *description)
+{
+	int ret = 0;
+	struct zynpu_irq_object *irq_obj = NULL;
+
+	if ((!zynpu_priv) || (!dev) || (!description)) {
+		ret = ZYNPU_ERRCODE_INTERNAL_NULLPTR;
+		goto finish;
+	}
+
+	irq_obj = kzalloc(sizeof(struct zynpu_irq_object), GFP_KERNEL);
+	if (!irq_obj)
+		goto finish;
+
+	irq_obj->zynpu_wq = NULL;
+	irq_obj->irqnum = 0;
+	irq_obj->dev = dev;
+
+	irq_obj->zynpu_wq = create_singlethread_workqueue("zynpu");
+	if (!irq_obj->zynpu_wq)
+		goto err_handle;
+
+	INIT_WORK(&irq_obj->work, zynpu_irq_handler_bottom_half);
+
+	ret = request_irq(irqnum, zynpu_irq_handler_upper_half,
+			  IRQF_SHARED | IRQF_TRIGGER_RISING, description, dev);
+	if (ret) {
+		dev_err(dev, "request IRQ (num %u) failed! (errno = %d)", irqnum, ret);
+		goto err_handle;
+	}
+
+	irq_obj->irqnum = irqnum;
+	irq_obj->uhandler = uhandler;
+	irq_obj->bhandler = bhandler;
+	irq_obj->zynpu_priv = zynpu_priv;
+
+	/* success */
+	goto finish;
+
+err_handle:
+	zynpu_destroy_irq_object(irq_obj);
+	irq_obj = NULL;
+
+finish:
+	return irq_obj;
+}
+
+void zynpu_irq_schedulework(struct zynpu_irq_object *irq_obj)
+{
+	if (irq_obj)
+		queue_work(irq_obj->zynpu_wq, &irq_obj->work);
+}
+
+void zynpu_irq_flush_workqueue(struct zynpu_irq_object *irq_obj)
+{
+	/* only one workqueue currently */
+	flush_workqueue(irq_obj->zynpu_wq);
+}
+
+void zynpu_destroy_irq_object(struct zynpu_irq_object *irq_obj)
+{
+	if (irq_obj) {
+		if (irq_obj->zynpu_wq) {
+			flush_workqueue(irq_obj->zynpu_wq);
+			destroy_workqueue(irq_obj->zynpu_wq);
+			irq_obj->zynpu_wq = NULL;
+		}
+		if (irq_obj->irqnum)
+			free_irq(irq_obj->irqnum, irq_obj->dev);
+		kfree(irq_obj);
+		flush_scheduled_work();
+	}
+}
\ No newline at end of file
diff --git a/drivers/staging/zynpu/zynpu_irq.h b/drivers/staging/zynpu/zynpu_irq.h
new file mode 100644
index 000000000000..97b2fc0cd634
--- /dev/null
+++ b/drivers/staging/zynpu/zynpu_irq.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+*
+* Zhouyi AI Accelerator driver
+*
+* Copyright (C) 2020 Arm (China) Ltd.
+* Copyright (C) 2021 Cai Huoqing
+*/
+
+/**
+ * @file zynpu_irq.h
+ * Header of the interrupt request and handlers' abstraction
+ */
+
+#ifndef _ZYNPU_IRQ_H_
+#define _ZYNPU_IRQ_H_
+
+#include <linux/device.h>
+#include <linux/workqueue.h>
+
+typedef int  (*zynpu_irq_uhandler_t) (void *arg);
+typedef void (*zynpu_irq_bhandler_t) (void *arg);
+typedef void (*zynpu_irq_trigger_t) (void *arg);
+typedef void (*zynpu_irq_ack_t) (void *arg);
+
+/**
+ * struct zynpu_irq_object - IRQ instance for each hw module in ZYNPU with interrupt function
+ *
+ * @irqnum: interrupt number used to request IRQ
+ * @zynpu_priv: zynpu_priv struct pointer
+ * @uhandler: real upper-half handler
+ * @bhandler: real bottom-half handler
+ * @work: work struct
+ * @dev: device pointer
+ * @zynpu_wq: workqueue struct pointer
+ */
+struct zynpu_irq_object {
+	u32 irqnum;
+	void *zynpu_priv;
+	zynpu_irq_uhandler_t uhandler;
+	zynpu_irq_bhandler_t bhandler;
+	struct work_struct  work;
+	struct device *dev;
+	struct workqueue_struct *zynpu_wq;
+};
+
+/**
+ * @brief initialize an ZYNPU IRQ object for a HW module with interrupt function
+ *
+ * @param irqnum: interrupt number
+ * @param uhandler: upper-half handler
+ * @param bhandler: bottom-half handler
+ * @zynpu_priv: zynpu_priv struct pointer
+ * @param description: irq object description string
+ *
+ * @return irq_object pointer if successful; NULL if failed;
+ */
+struct zynpu_irq_object *zynpu_create_irq_object(u32 irqnum, zynpu_irq_uhandler_t uhandler,
+	zynpu_irq_bhandler_t bhandler, void *zynpu_priv, struct device *dev, char *description);
+/**
+ * @brief workqueue schedule API
+ *
+ * @param irq_obj: interrupt object
+ *
+ * @return void
+ */
+void zynpu_irq_schedulework(struct zynpu_irq_object *irq_obj);
+/**
+ * @brief workqueue flush API
+ *
+ * @param irq_obj: interrupt object
+ *
+ * @return void
+ */
+void zynpu_irq_flush_workqueue(struct zynpu_irq_object *irq_obj);
+/**
+ * @brief workqueue terminate API
+ *
+ * @param irq_obj: interrupt object
+ *
+ * @return void
+ */
+void zynpu_destroy_irq_object(struct zynpu_irq_object *irq_obj);
+
+#endif //_ZYNPU_IRQ_H_
\ No newline at end of file
diff --git a/drivers/staging/zynpu/zynpu_job_manager.c b/drivers/staging/zynpu/zynpu_job_manager.c
new file mode 100644
index 000000000000..8105fe0aba8a
--- /dev/null
+++ b/drivers/staging/zynpu/zynpu_job_manager.c
@@ -0,0 +1,467 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+*
+* Zhouyi AI Accelerator driver
+*
+* Copyright (C) 2020 Arm (China) Ltd.
+* Copyright (C) 2021 Cai Huoqing
+*/
+
+/**
+ * @file zynpu_job_manager.c
+ * Job manager module implementation file
+ */
+
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/time.h>
+#include "zynpu_job_manager.h"
+#include "zynpu.h"
+
+static int init_zynpu_job(struct zynpu_job *zynpu_job, struct user_job_desc *desc,
+	struct session_job *kern_job, struct zynpu_session *session)
+{
+	int ret = 0;
+
+	if (!zynpu_job) {
+		ret = -EINVAL;
+		goto finish;
+	}
+
+	if (kern_job)
+		zynpu_job->uthread_id = kern_job->uthread_id;
+
+	if (!desc)
+		memset(&zynpu_job->desc, 0, sizeof(struct user_job_desc));
+	else
+		zynpu_job->desc = *desc;
+	zynpu_job->session = (struct zynpu_session *)session;
+	zynpu_job->session_job = (struct session_job *)kern_job;
+	zynpu_job->state = ZYNPU_JOB_STATE_IDLE;
+	zynpu_job->exception_flag = ZYNPU_EXCEP_NO_EXCEPTION;
+	zynpu_job->valid_flag = ZYNPU_JOB_FLAG_VALID;
+	INIT_LIST_HEAD(&zynpu_job->node);
+
+finish:
+	return ret;
+}
+
+static void destroy_zynpu_job(struct zynpu_job *job)
+{
+	if (job)
+		kfree(job);
+}
+
+static void remove_zynpu_job(struct zynpu_job *job)
+{
+	if (job) {
+		list_del(&job->node);
+		destroy_zynpu_job(job);
+	}
+
+}
+
+static struct zynpu_job *create_zynpu_job(struct user_job_desc *desc,
+	struct session_job *kern_job, struct zynpu_session *session)
+{
+	struct zynpu_job *new_zynpu_job = NULL;
+
+	new_zynpu_job = kzalloc(sizeof(struct zynpu_job), GFP_KERNEL);
+	if (init_zynpu_job(new_zynpu_job, desc, kern_job, session) != 0) {
+		destroy_zynpu_job(new_zynpu_job);
+		new_zynpu_job = NULL;
+	}
+
+	return new_zynpu_job;
+}
+
+static void zynpu_job_manager_trigger_job_sched(struct zynpu_priv *zynpu, struct zynpu_job *zynpu_job)
+{
+	if (zynpu && zynpu_job) {
+		zynpu_priv_trigger(zynpu, &zynpu_job->desc, zynpu_job->uthread_id);
+		if (is_session_job_prof_enabled(zynpu_job->session_job))
+			session_job_mark_sched(zynpu_job->session_job);
+	}
+}
+
+
+int zynpu_init_job_manager(struct zynpu_job_manager *job_manager, struct device *p_dev, int max_sched_num)
+{
+	int ret = 0;
+
+	if ((!job_manager) || (!p_dev))
+		return -EINVAL;
+
+	if (job_manager->init_done)
+		return 0;
+
+	job_manager->scheduled_queue_head = create_zynpu_job(NULL, NULL, NULL);
+	job_manager->pending_queue_head = create_zynpu_job(NULL, NULL, NULL);
+	if ((!job_manager->pending_queue_head) || (!job_manager->scheduled_queue_head))
+		return -ENOMEM;
+
+	job_manager->sched_num = 0;
+	job_manager->max_sched_num = max_sched_num;
+	spin_lock_init(&job_manager->lock);
+	job_manager->dev = p_dev;
+	job_manager->init_done = 1;
+
+	return ret;
+}
+
+static void delete_queue(struct zynpu_job *head)
+{
+	struct zynpu_job *cursor = head;
+	struct zynpu_job *next = NULL;
+
+	if (head) {
+		list_for_each_entry_safe(cursor, next, &head->node, node) {
+			remove_zynpu_job(cursor);
+		}
+	}
+}
+
+void zynpu_deinit_job_manager(struct zynpu_job_manager *job_manager)
+{
+	if (job_manager) {
+		delete_queue(job_manager->scheduled_queue_head);
+		delete_queue(job_manager->pending_queue_head);
+		job_manager->sched_num = 0;
+	}
+}
+
+static void zynpu_schedule_pending_job_no_lock(struct zynpu_job_manager *job_manager)
+{
+	struct zynpu_job *curr = NULL;
+	struct zynpu_priv *zynpu = container_of(job_manager, struct zynpu_priv, job_manager);
+
+	if (!job_manager) {
+		dev_err(job_manager->dev, "invalid input args user_job or kern_job or session to be NULL!");
+		return;
+	}
+
+	/* 1st pending job should be scheduled if any */
+	if ((!list_empty(&job_manager->pending_queue_head->node)) &&
+	    (job_manager->sched_num < job_manager->max_sched_num) &&
+	    (zynpu_priv_is_idle(zynpu))) {
+		/*
+		  detach head of pending queue and add it to the tail of scheduled job queue
+
+				      |--->>------->>---|
+				      |(real head)      |(tail)
+		  --------------------------------    ----------------------------------
+		  | j <=> j <=> j <=> j <=> head |    | [empty to fill] <=> j <=> head |
+		  --------------------------------    ----------------------------------
+			  pending job queue		   scheduled job queue
+		*/
+		curr = list_next_entry(job_manager->pending_queue_head, node);
+
+		zynpu_job_manager_trigger_job_sched(zynpu, curr);
+		curr->state = ZYNPU_JOB_STATE_SCHED;
+		list_move_tail(&curr->node, &job_manager->scheduled_queue_head->node);
+		job_manager->sched_num++;
+	} else {
+		/**
+		 * do nothing because no pending job needs to be scheduled
+		 * or ZYNPU is not available to accept more jobs
+		 */
+		if (list_empty(&job_manager->pending_queue_head->node)) {
+			if (!task_pid_nr(current))
+				dev_dbg(job_manager->dev, "[IRQ] no pending job to trigger");
+			else
+				dev_dbg(job_manager->dev, "[%u] no pending job to trigger", task_pid_nr(current));
+		}
+
+		if (job_manager->sched_num >= job_manager->max_sched_num) {
+			if (!task_pid_nr(current))
+				dev_dbg(job_manager->dev, "[IRQ] ZYNPU busy and do not trigger");
+			else
+				dev_dbg(job_manager->dev, "[%u] ZYNPU busy and do not trigger", task_pid_nr(current));
+		}
+
+	}
+}
+
+int zynpu_job_manager_schedule_new_job(struct zynpu_job_manager *job_manager, struct user_job *user_job,
+	struct session_job *session_job, struct zynpu_session *session)
+{
+	int ret = 0;
+	struct zynpu_job *zynpu_job = NULL;
+
+	if ((!job_manager) || (!user_job) || (!session_job) || (!session)) {
+		if (user_job)
+			user_job->errcode = ZYNPU_ERRCODE_INTERNAL_NULLPTR;
+		ret = -EINVAL;
+		goto finish;
+	}
+
+	zynpu_job = create_zynpu_job(&user_job->desc, session_job, session);
+	if (!zynpu_job) {
+		user_job->errcode = ZYNPU_ERRCODE_CREATE_KOBJ_ERR;
+		ret = -EFAULT;
+		goto finish;
+	}
+
+	/* LOCK */
+	spin_lock_irq(&job_manager->lock);
+
+	/* pending the flushed job from userland and try to schedule it */
+	zynpu_job->state = ZYNPU_JOB_STATE_PENDING;
+	list_add_tail(&zynpu_job->node, &job_manager->pending_queue_head->node);
+	zynpu_schedule_pending_job_no_lock(job_manager);
+
+	spin_unlock_irq(&job_manager->lock);
+	/* UNLOCK */
+
+	/* success */
+	user_job->errcode = 0;
+
+finish:
+	return ret;
+}
+
+static int zynpu_invalidate_job_no_lock(struct zynpu_job_manager *job_manager,
+	struct zynpu_job *job)
+{
+	//struct zynpu_priv *zynpu = container_of(job_manager, struct zynpu_priv, job_manager);
+
+	if ((!job_manager) || (!job))
+		return -EINVAL;
+
+	if (job->state == ZYNPU_JOB_STATE_SCHED) {
+			job->valid_flag = 0;
+	} else if (job->state == ZYNPU_JOB_STATE_PENDING) {
+		remove_zynpu_job(job);
+	} else
+		return -EINVAL;
+
+	return 0;
+}
+
+static void zynpu_invalidate_canceled_jobs_no_lock(struct zynpu_job_manager *job_manager,
+	struct zynpu_job *head, struct zynpu_session *session)
+{
+	struct zynpu_job *cursor = NULL;
+	struct zynpu_job *next = NULL;
+
+	if ((!job_manager) || (!head) || (!session))
+		return;
+
+	list_for_each_entry_safe(cursor, next, &head->node, node) {
+		if (zynpu_get_session_pid(cursor->session) == zynpu_get_session_pid(session))
+			zynpu_invalidate_job_no_lock(job_manager, cursor);
+	}
+}
+
+int zynpu_job_manager_cancel_session_jobs(struct zynpu_job_manager *job_manager,
+	struct zynpu_session *session)
+{
+	int ret = 0;
+
+	if (!session) {
+		ret = -EINVAL;
+		goto finish;
+	}
+
+	/* LOCK */
+	spin_lock_irq(&job_manager->lock);
+
+	/**
+	 * invalidate all active jobs of this session in job manager
+	 */
+	zynpu_invalidate_canceled_jobs_no_lock(job_manager, job_manager->pending_queue_head, session);
+	zynpu_invalidate_canceled_jobs_no_lock(job_manager, job_manager->scheduled_queue_head, session);
+
+	spin_unlock_irq(&job_manager->lock);
+	/* UNLOCK */
+
+	/* delete all session_job */
+	zynpu_session_delete_jobs(session);
+
+finish:
+	return ret;
+}
+
+static int zynpu_invalidate_timeout_job_no_lock(struct zynpu_job_manager *job_manager,
+	struct zynpu_job *head, int job_id)
+{
+	int ret = -EINVAL;
+	struct zynpu_job *cursor = NULL;
+	struct zynpu_job *next = NULL;
+
+	if ((!job_manager) || (!head))
+		return -EINVAL;
+
+	list_for_each_entry_safe(cursor, next, &head->node, node) {
+		if ((cursor->uthread_id == task_pid_nr(current)) &&
+			(cursor->desc.job_id == job_id)) {
+			ret = zynpu_invalidate_job_no_lock(job_manager, cursor);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+int zynpu_invalidate_timeout_job(struct zynpu_job_manager *job_manager, int job_id)
+{
+	int ret = 0;
+
+	if (!job_manager)
+		return -EINVAL;
+
+	/* LOCK */
+	spin_lock_irq(&job_manager->lock);
+	ret = zynpu_invalidate_timeout_job_no_lock(job_manager, job_manager->pending_queue_head, job_id);
+	if (ret) {
+		ret = zynpu_invalidate_timeout_job_no_lock(job_manager, job_manager->scheduled_queue_head, job_id);
+		pr_debug("Timeout job invalidated from sched queue.");
+	} else {
+		pr_debug("Timeout job invalidated from pending queue.");
+	}
+
+	spin_unlock_irq(&job_manager->lock);
+	/* UNLOCK */
+
+	return ret;
+}
+
+void zynpu_job_manager_update_job_state_irq(void *zynpu_priv, int exception_flag)
+{
+	struct zynpu_job *curr = NULL;
+	struct zynpu_priv *zynpu = (struct zynpu_priv *)zynpu_priv;
+	struct zynpu_job_manager *job_manager = &zynpu->job_manager;
+
+	/* LOCK */
+	spin_lock(&job_manager->lock);
+	list_for_each_entry(curr, &job_manager->scheduled_queue_head->node, node) {
+		if (curr->state == ZYNPU_JOB_STATE_SCHED) {
+			curr->state = ZYNPU_JOB_STATE_END;
+			curr->exception_flag = exception_flag;
+
+			if (curr->exception_flag)
+				pr_debug("[IRQ] job 0x%x of thread %u EXCEPTION",
+					curr->desc.job_id, curr->uthread_id);
+			else
+				pr_debug("[IRQ] job 0x%x of thread %u DONE",
+					curr->desc.job_id, curr->uthread_id);
+
+
+			if (is_session_job_prof_enabled(curr->session_job))
+				session_job_mark_done(curr->session_job);
+
+			if (job_manager->sched_num)
+				job_manager->sched_num--;
+			break;
+		}
+	}
+
+	/* schedule a new pending job */
+	zynpu_schedule_pending_job_no_lock(job_manager);
+	spin_unlock(&job_manager->lock);
+	/* UNLOCK */
+}
+
+void zynpu_job_manager_update_job_queue_done_irq(struct zynpu_job_manager *job_manager)
+{
+	struct zynpu_job *curr = NULL;
+	struct zynpu_job *next = NULL;
+
+	/* LOCK */
+	spin_lock(&job_manager->lock);
+	list_for_each_entry_safe(curr, next, &job_manager->scheduled_queue_head->node, node) {
+		if (ZYNPU_JOB_STATE_END != curr->state)
+			continue;
+
+		/*
+		   DO NOT call session API for invalid job because
+		   session struct probably not exist on this occasion
+		*/
+		if (ZYNPU_JOB_FLAG_VALID == curr->valid_flag) {
+			pr_debug("[BH] handling job 0x%x of thread %u...",
+				curr->desc.job_id, curr->uthread_id);
+			zynpu_session_job_done(curr->session, curr->session_job,
+			    curr->exception_flag);
+		} else {
+			pr_debug("[BH] this done job has been cancelled by user.");
+		}
+
+		list_del(&curr->node);
+		destroy_zynpu_job(curr);
+		curr = NULL;
+		/* DO NOT minus sched_num here because upper half has done that */
+	}
+	spin_unlock(&job_manager->lock);
+	/* UNLOCK */
+}
+
+static int print_job_info(char *buf, int buf_size, struct zynpu_job *job)
+{
+	int ret = 0;
+	char state_str[20];
+	char excep_str[10];
+
+	if ((!buf) || (!job))
+		return ret;
+
+	if (job->state == ZYNPU_JOB_STATE_PENDING)
+		snprintf(state_str, 20, "Pending");
+	else if (job->state == ZYNPU_JOB_STATE_SCHED)
+		snprintf(state_str, 20, "Executing");
+	else if (job->state == ZYNPU_JOB_STATE_END)
+		snprintf(state_str, 20, "Done");
+
+	if (job->exception_flag)
+		snprintf(excep_str, 10, "Y");
+	else
+		snprintf(excep_str, 10, "N");
+
+	return snprintf(buf, buf_size, "%-*d0x%-*x%-*s%-*s\n", 12, job->uthread_id, 10,
+		job->desc.job_id, 10, state_str, 5, excep_str);
+}
+
+int zynpu_job_manager_sysfs_job_show(struct zynpu_job_manager *job_manager, char *buf)
+{
+	int ret = 0;
+	int tmp_size = 1024;
+	char tmp[1024];
+	struct zynpu_job *curr = NULL;
+	int number = 0;
+
+	if (!buf)
+		return ret;
+
+	ret += snprintf(tmp, 1024, "-------------------------------------------\n");
+	strcat(buf, tmp);
+	ret += snprintf(tmp, 1024, "%-*s%-*s%-*s%-*s\n", 12, "Thread ID", 12, "Job ID",
+		10, "State", 5, "Exception");
+	strcat(buf, tmp);
+	ret += snprintf(tmp, 1024, "-------------------------------------------\n");
+	strcat(buf, tmp);
+
+	/* LOCK */
+	spin_lock_irq(&job_manager->lock);
+	list_for_each_entry(curr, &job_manager->pending_queue_head->node, node) {
+		ret += print_job_info(tmp, tmp_size, curr);
+		strcat(buf, tmp);
+		number++;
+	}
+	curr = NULL;
+	list_for_each_entry(curr, &job_manager->scheduled_queue_head->node, node) {
+		ret += print_job_info(tmp, tmp_size, curr);
+		strcat(buf, tmp);
+		number++;
+	}
+	spin_unlock_irq(&job_manager->lock);
+	/* UNLOCK */
+
+	if (!number) {
+		ret += snprintf(tmp, tmp_size, "No job.\n");
+		strcat(buf, tmp);
+	}
+
+	ret += snprintf(tmp, 1024, "-------------------------------------------\n");
+	strcat(buf, tmp);
+
+	return ret;
+}
\ No newline at end of file
diff --git a/drivers/staging/zynpu/zynpu_job_manager.h b/drivers/staging/zynpu/zynpu_job_manager.h
new file mode 100644
index 000000000000..e71f29126c68
--- /dev/null
+++ b/drivers/staging/zynpu/zynpu_job_manager.h
@@ -0,0 +1,200 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+*
+* Zhouyi AI Accelerator driver
+*
+* Copyright (C) 2020 Arm (China) Ltd.
+* Copyright (C) 2021 Cai Huoqing
+*/
+
+/**
+ * @file zynpu_job_manager.h
+ * Job manager module header file
+ */
+
+#ifndef _ZYNPU_JOB_MANAGER_H_
+#define _ZYNPU_JOB_MANAGER_H_
+
+#include <linux/list.h>
+#include <linux/spinlock.h>
+
+#define ZYNPU_EXCEP_NO_EXCEPTION   0
+#ifdef __KERNEL__
+
+#define ZYNPU_JOB_STATE_IDLE      0
+#define ZYNPU_JOB_STATE_PENDING   1
+#define ZYNPU_JOB_STATE_SCHED     2
+#define ZYNPU_JOB_STATE_END       3
+
+#define ZYNPU_JOB_FLAG_INVALID    0
+#define ZYNPU_JOB_FLAG_VALID      1
+#endif
+
+#define ZYNPU_JOB_STATE_DONE      0x1
+#define ZYNPU_JOB_STATE_EXCEPTION 0x2
+
+struct profiling_data {
+	ktime_t sched_kt;
+	ktime_t done_kt;
+};
+
+struct job_status_desc {
+	__u32 job_id;
+	__u32 thread_id;
+	__u32 state;
+	struct profiling_data pdata;
+};
+
+struct job_status_query {
+	__u32 max_cnt;
+	__u32 get_single_job;
+	__u32 job_id;
+	struct job_status_desc *status;
+	__u32 poll_cnt;
+	__u32 errcode;
+};
+
+struct user_job_desc {
+	__u64 start_pc_addr;
+	__u64 intr_handler_addr;
+	__u64 data_0_addr;
+	__u64 data_1_addr;
+	__u64 static_addr;
+	__u64 reuse_addr;
+	__u32 job_id;
+	__u32 code_size;
+	__u32 rodata_size;
+	__u32 stack_size;
+	__u32 static_size;
+	__u32 reuse_size;
+	__u32 enable_prof;
+	__u32 enable_asid;
+};
+
+struct user_job {
+	struct user_job_desc desc;
+	__u32 errcode;
+};
+
+/**
+ * struct zynpu_job - job element struct describing a job under scheduling in job manager
+ *	Job status will be tracked as soon as interrupt or user evenets come in.
+ *
+ * @uthread_id: ID of user thread scheduled this job
+ * @desc: job desctiptor from userland
+ * @session: session pointer refernece of this job
+ * @session_job: corresponding job object in session
+ * @state: job state
+ * @exception_flag: exception flag
+ * @valid_flag: valid flag, indicating this job canceled by user or not
+ * @node: list head struct
+ */
+ struct zynpu_job {
+	int uthread_id;
+	struct user_job_desc desc;
+	struct zynpu_session *session;
+	struct session_job *session_job;
+	int state;
+	int exception_flag;
+	int valid_flag;
+	struct list_head node;
+};
+
+/**
+ * struct zynpu_job_manager - job manager
+ *	Maintain all jobs and update their status
+ *
+ * @scheduled_queue_head: scheduled job queue head
+ * @pending_queue_head: pending job queue head
+ * @sched_num: number of jobs have been scheduled
+ * @max_sched_num: maximum allowed scheduled job number
+ * @lock: spinlock
+ * @dev: device struct pointer
+ */
+struct zynpu_job_manager {
+	struct zynpu_job *scheduled_queue_head;
+	struct zynpu_job *pending_queue_head;
+	int sched_num;
+	int max_sched_num;
+	int init_done;
+	spinlock_t lock;
+	struct device *dev;
+};
+
+/**
+ * @brief initialize an existing job manager struct during driver probe phase
+ *
+ * @param job_manager: job_manager struct pointer allocated from user;
+ * @param p_dev: zynpu device struct pointer
+ * @param max_sched_num: maximum allowed scheduled job number;
+ *
+ * @return 0 if successful; others if failed;
+ */
+int zynpu_init_job_manager(struct zynpu_job_manager *job_manager, struct device *p_dev, int max_sched_num);
+/**
+ * @brief de-init job manager
+ *
+ * @param job_manager: job_manager struct pointer allocated from user;
+ *
+ * @return void
+ */
+void zynpu_deinit_job_manager(struct zynpu_job_manager *job_manager);
+/**
+ * @brief schedule new job flushed from userland
+ *
+ * @param job_manager: job_manager struct pointer;
+ * @param user_job: user_job struct;
+ * @param kern_job: session job;
+ * @param session: session pointer refernece of this job;
+ *
+ * @return 0 if successful; others if failed;
+ */
+int zynpu_job_manager_schedule_new_job(struct zynpu_job_manager *job_manager, struct user_job *user_job,
+    struct session_job *kern_job, struct zynpu_session *session);
+/**
+ * @brief update job state and indicating if exception happens
+ *
+ * @param zynpu_priv: zynpu private struct
+ * @param exception_flag: exception flag
+ *
+ * @return void
+ */
+void zynpu_job_manager_update_job_state_irq(void *zynpu_priv, int exception_flag);
+/**
+ * @brief done interrupt handler for job manager
+ *
+ * @param job_manager: job_manager struct pointer;
+ *
+ * @return void
+ */
+void zynpu_job_manager_update_job_queue_done_irq(struct zynpu_job_manager *job_manager);
+/**
+ * @brief cancel all jobs flushed by a user thread
+ *
+ * @param job_manager: job_manager struct pointer allocated from user;
+ * @param session: session serviced for that user thread
+ *
+ * @return 0 if successful; others if failed;
+ */
+int zynpu_job_manager_cancel_session_jobs(struct zynpu_job_manager *job_manager,
+	struct zynpu_session *session);
+/**
+ * @brief invalidate/kill a timeout job
+ *
+ * @param job_manager: job_manager struct pointer allocated from user;
+ * @param job_id: job ID
+ *
+ * @return 0 if successful; others if failed;
+ */
+int zynpu_invalidate_timeout_job(struct zynpu_job_manager *job_manager, int job_id);
+/**
+ * @brief show KMD job info via sysfs
+ *
+ * @param job_manager: job_manager struct pointer allocated from user;
+ * @param buf: userspace buffer for KMD to fill the job info
+ *
+ * @return buf written bytes number;
+ */
+int zynpu_job_manager_sysfs_job_show(struct zynpu_job_manager *job_manager, char *buf);
+
+#endif /* _ZYNPU_JOB_MANAGER_H_ */
\ No newline at end of file
diff --git a/drivers/staging/zynpu/zynpu_mm.c b/drivers/staging/zynpu/zynpu_mm.c
new file mode 100644
index 000000000000..a1d71cdedb4c
--- /dev/null
+++ b/drivers/staging/zynpu/zynpu_mm.c
@@ -0,0 +1,704 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+*
+* Zhouyi AI Accelerator driver
+*
+* Copyright (C) 2020 Arm (China) Ltd.
+* Copyright (C) 2021 Cai Huoqing
+*/
+
+/**
+ * @file zynpu_mm.c
+ * Implementations of the ZYNPU memory management supports Address Space Extension (ASE)
+ */
+
+#include <linux/io.h>
+#include <linux/dma-mapping.h>
+#include <linux/slab.h>
+#include <asm/div64.h>
+#include "zynpu.h"
+#include "zynpu_mm.h"
+
+#define ZYNPU_CONFIG_SRAM_DATA_ASID ZYNPU_MM_DATA_TYPE_REUSE
+
+static inline int get_asid(struct zynpu_memory_manager *mm, enum zynpu_mm_data_type type)
+{
+	int asid = ZYNPU_ASE_ID_NONE;
+
+	if (!mm)
+		return asid;
+
+	switch (type) {
+	case ZYNPU_MM_DATA_TYPE_TEXT:
+	case ZYNPU_MM_DATA_TYPE_RO_STACK:
+		return ZYNPU_ASE_ID_0;
+	case ZYNPU_MM_DATA_TYPE_STATIC:
+		return ZYNPU_ASE_ID_1;
+	case ZYNPU_MM_DATA_TYPE_REUSE:
+		return ZYNPU_ASE_ID_2;
+	case ZYNPU_MM_DATA_TYPE_NONE:
+		return ZYNPU_ASE_ID_ALL;
+	default:
+		return asid;
+	}
+}
+
+static inline void *zynpu_remap_region_nocache(struct zynpu_memory_manager *mm, u64 base, u64 bytes)
+{
+	if ((!mm) || (!bytes))
+		return NULL;
+
+	return memremap(base, bytes, MEMREMAP_WT);
+}
+
+static inline void zynpu_unmap_region_nocache(void *va)
+{
+	if (va)
+		memunmap(va);
+}
+
+static void *zynpu_alloc_cma_region_nocache(struct zynpu_memory_manager *mm, u64 *base, u64 bytes)
+{
+	int ret = 0;
+	void *va = NULL;
+
+	if ((!mm) || (!bytes))
+		return va;
+
+	ret = dma_set_mask(mm->dev, DMA_BIT_MASK(32));
+	if (ret) {
+		dev_err(mm->dev, "DMA set mask failed!\n");
+		goto finish;
+	}
+
+	ret = dma_set_coherent_mask(mm->dev, DMA_BIT_MASK(32));
+	if (ret) {
+		dev_err(mm->dev, "DMA set coherent mask failed!\n");
+		goto finish;
+	}
+
+	va = dma_alloc_coherent(mm->dev, bytes, (dma_addr_t *)base, GFP_KERNEL);
+	if (!va) {
+		dev_err(mm->dev, "DMA alloc coherent failed: pa 0x%llx, bytes = 0x%llx\n",
+			*base, bytes);
+	} else {
+		dev_info(mm->dev, "DMA alloc coherent failed: pa 0x%llx, bytes = 0x%llx\n",
+			 *base, bytes);
+	}
+
+finish:
+	return va;
+}
+
+static void zynpu_free_cma_region_nocache(struct zynpu_memory_manager *mm, struct zynpu_mem_region *region)
+{
+	if ((!mm) || (!region))
+		return;
+
+	dma_free_coherent(mm->dev, region->tot_bytes, region->va, region->pa);
+}
+
+static struct zynpu_block *create_block(u64 base, u64 bytes, int tid, enum zynpu_mm_data_type type,
+	enum zynpu_blk_state state)
+{
+	struct zynpu_block *blk = NULL;
+
+	blk = kzalloc(sizeof(struct zynpu_block), GFP_KERNEL);
+	if (!blk)
+		return blk;
+
+	blk->pa = base;
+	blk->bytes = bytes;
+	blk->tid = tid;
+	blk->type = type;
+	blk->state = state;
+	INIT_LIST_HEAD(&blk->list);
+
+	return blk;
+}
+
+static inline struct zynpu_block *create_block_list_head(u64 base, u64 bytes)
+{
+	return create_block(base, bytes, 0, ZYNPU_MM_DATA_TYPE_NONE, ZYNPU_BLOCK_STATE_FREE);
+}
+
+static int zynpu_mm_find_block_candidate_no_lock(struct zynpu_block *head, u64 bytes, u64 alignment,
+	int data_type, struct zynpu_block **found, u64 *pa)
+{
+	struct zynpu_block *blk_cand = NULL;
+	u64 start = 0;
+	u64 end = 0;
+	int ret = -ENOMEM;
+	u64 result = 0;
+
+	if (!found)
+		return -EINVAL;
+
+	if ((!head) || (!bytes) || (!alignment) || (alignment % PAGE_SIZE)) {
+		ret = -EINVAL;
+		goto failed;
+	}
+
+	/**
+	 * allocate for text/ro/stack togetherly in non-reverse direction because
+	 * for the same job, they must be allocated in the same ASE0 region and
+	 * we wish to make them as closer as possible to make RW access control
+	 * in ASE.
+	 */
+	if ((data_type == ZYNPU_MM_DATA_TYPE_TEXT) ||
+	    (data_type == ZYNPU_MM_DATA_TYPE_RO_STACK)) {
+		list_for_each_entry(blk_cand, &head->list, list) {
+			if (blk_cand->state != ZYNPU_BLOCK_STATE_ALLOCATED) {
+				start = ALIGN(blk_cand->pa, alignment);
+				end = start + bytes;
+				if (end <= (blk_cand->pa + blk_cand->bytes))
+					goto success;
+			}
+		}
+	} else {
+		list_for_each_entry_reverse(blk_cand, &head->list, list) {
+			if (blk_cand->state != ZYNPU_BLOCK_STATE_ALLOCATED) {
+				result = blk_cand->pa + blk_cand->bytes - bytes;
+				do_div(result, alignment);
+				start = result * alignment;
+				end = start + bytes;
+				if ((start >= blk_cand->pa) &&
+				    (end <= (blk_cand->pa + blk_cand->bytes)))
+					goto success;
+			}
+		}
+	}
+
+failed:
+	*found = NULL;
+	*pa = 0;
+	return ret;
+
+success:
+	*found = blk_cand;
+	*pa = start;
+	return 0;
+}
+
+static int zynpu_mm_split_block_no_lock(struct zynpu_block *target, u64 alloc_base, u64 alloc_bytes,
+	enum zynpu_mm_data_type type)
+{
+	u64 alloc_start = alloc_base;
+	u64 alloc_end = alloc_start + alloc_bytes - 1;
+	u64 target_start = target->pa;
+	u64 target_end = target->pa + target->bytes - 1;
+	struct zynpu_block *alloc_blk = NULL;
+	struct zynpu_block *remaining_blk = target;
+
+	if ((!target) || (!alloc_bytes) || (alloc_end < target_start) ||
+	    (alloc_end > target_end))
+		return -EINVAL;
+
+	if ((alloc_start == target_start) && (alloc_end == target_end)) {
+		/*
+		  alloc block:	      |<-----------alloc------------>|
+		  equals to
+		  target block to be split: |<----------target------------>|
+		*/
+		alloc_blk = target;
+		alloc_blk->tid = task_pid_nr(current);
+		alloc_blk->type = type;
+		alloc_blk->state = ZYNPU_BLOCK_STATE_ALLOCATED;
+	} else {
+		alloc_blk = create_block(alloc_start, alloc_bytes, task_pid_nr(current),
+			type, ZYNPU_BLOCK_STATE_ALLOCATED);
+		if (!alloc_blk)
+			return -ENOMEM;
+		if ((alloc_start == target_start) && (alloc_end < target_end)) {
+			/*
+			  alloc block:	      |<---alloc--->|<--remaining-->|
+			  smaller than and start from base of
+			  target block to be split: |<----------target----------->|
+			*/
+			remaining_blk->pa += alloc_blk->bytes;
+			remaining_blk->bytes -= alloc_blk->bytes;
+			list_add_tail(&alloc_blk->list, &remaining_blk->list);
+		} else if ((alloc_start > target_start) && (alloc_end == target_end)) {
+			/*
+			  alloc block:	      |<--remaining-->|<---alloc--->|
+			  smaller than and end at end of
+			  target block to be split: |<----------target----------->|
+			*/
+			remaining_blk->bytes -= alloc_blk->bytes;
+			list_add(&alloc_blk->list, &remaining_blk->list);
+		} else {
+			/*
+			  alloc block:	      |<-fr_remaining->|<--alloc-->|<-bk_remaining->|
+			  insides of
+			  target block to be split: |<-------------------target------------------>|
+			*/
+			/* front remaining */
+			remaining_blk->bytes = alloc_start - remaining_blk->pa;
+			list_add(&alloc_blk->list, &remaining_blk->list);
+			/* back remaining */
+			remaining_blk = create_block(alloc_end + 1, target_end - alloc_end,
+				task_pid_nr(current), type, ZYNPU_BLOCK_STATE_FREE);
+			list_add(&remaining_blk->list, &alloc_blk->list);
+		}
+	}
+
+	return 0;
+}
+
+static int zynpu_mm_alloc_in_region_compact_no_lock(struct zynpu_memory_manager *mm,
+	struct zynpu_mem_region *region, struct buf_request *buf_req, struct zynpu_buffer *buf)
+{
+	int ret = 0;
+	u64 compact_bytes = 0;
+	u64 alignment = 0;
+	u64 alloc_pa = 0;
+	struct zynpu_block *blk_cand = NULL;
+
+	if ((!region) || (!buf_req) || (!buf))
+		return -EINVAL;
+
+	/**
+	 * Compact allocation means that the buffer size is round up as page size
+	 * therefore the buffer size allocated is less than the region specified
+	 * in ASE therefore memory is saved compared with strict allocation but
+	 * the RW control is less strict
+	 */
+
+	/**
+	 * Compact alloc:
+	 * roundup block size = roundup_pow_of_two(requested size)
+	 * alloc block size = roundup_page_size(requested size)
+	 * For example:
+	 *	      |<-------------requested (9KB)----------->|
+	 *	      |<--------------------------roundup (16KB)--------------------------->|
+	 *	      |<----------------alloc (12KB)----------------->|<--remaining (4KB)-->|
+	 *	 0x10_0000_4000						     0x10_0000_8000
+	 *
+	 * Buffer returned to UMD: alloc block
+	 *     PA: 0x10_0000_4000
+	 *     Size: 0x3000
+	 *
+	 * ASE Registers:
+	 *     ASE_X_Control[7:0]: 3 (16KB)
+	 *     ASE_X_High_Base[31:0]: 0x10
+	 *     ASE_X_Low_Base[31:0]: 0x4000
+	 *
+	 * Base address used to calculate absolute address of buffer(s) inside alloc block: 0x0
+	 *
+	 * The 4KB remaining block is free to be allocated later.
+	 */
+	compact_bytes = ALIGN(buf_req->bytes, PAGE_SIZE);
+	alignment = buf_req->align_in_page * 4 * 1024;
+	ret = zynpu_mm_find_block_candidate_no_lock(region->blk_head,
+		compact_bytes, alignment, buf_req->data_type, &blk_cand, &alloc_pa);
+	if (ret)
+		goto finish;
+
+	/* found matching block candidate: update block list */
+	if (zynpu_mm_split_block_no_lock(blk_cand, alloc_pa, compact_bytes,
+	    (enum zynpu_mm_data_type)buf_req->data_type)) {
+		ret = -ENOMEM;
+		goto finish;
+	}
+
+	/* success */
+	buf->pa = alloc_pa;
+	buf->va = (void *)((unsigned long)region->va + alloc_pa - region->pa);
+	buf->bytes = compact_bytes;
+	buf_req->errcode = 0;
+
+finish:
+	return ret;
+}
+
+static int zynpu_init_region(int id, struct zynpu_memory_manager *mm, u64 base, u64 bytes,
+	enum zynpu_mem_type type, struct zynpu_mem_region *region)
+{
+	struct zynpu_block *new_blk = NULL;
+
+	if ((!mm) || (!bytes) || (!region))
+		return -EINVAL;
+
+	region->id = id;
+
+	region->blk_head = create_block_list_head(0, 0);
+	new_blk = create_block_list_head(base, bytes);
+	list_add(&new_blk->list, &region->blk_head->list);
+
+	mutex_init(&region->lock);
+	region->pa = base;
+	region->tot_bytes = bytes;
+	region->tot_free_bytes = bytes;
+	region->type = type;
+
+	region->alloc_in_region = zynpu_mm_alloc_in_region_compact_no_lock;
+
+	INIT_LIST_HEAD(&region->list);
+
+	return 0;
+}
+
+static int zynpu_update_mm_regions(struct zynpu_memory_manager *mm, struct zynpu_mem_region *head,
+	int *region_cnt, struct zynpu_mem_region *new_region)
+{
+	if ((!head) || (!region_cnt) || (!new_region))
+		return -EINVAL;
+
+	list_add(&new_region->list, &head->list);
+	(*region_cnt)++;
+
+	return 0;
+}
+
+static struct zynpu_mem_region *create_region_list_head(void)
+{
+	struct zynpu_mem_region *region = NULL;
+
+	region = kzalloc(sizeof(struct zynpu_mem_region), GFP_KERNEL);
+	if (!region)
+		return region;
+
+	mutex_init(&region->lock);
+	INIT_LIST_HEAD(&region->list);
+	return region;
+}
+
+static int zynpu_mm_try_alloc_in_region(struct zynpu_memory_manager *mm, struct zynpu_mem_region *region,
+	struct buf_request *buf_req, struct zynpu_buffer *buf)
+{
+	int ret = 0;
+
+	if ((!region) || (!buf_req) || (!buf))
+		return -EINVAL;
+
+	mutex_lock(&region->lock);
+	ret = region->alloc_in_region(mm, region, buf_req, buf);
+	if (!ret) {
+		region->tot_free_bytes -= buf->bytes;
+		buf->region_id = region->id;
+		buf->type = region->type;
+		pr_debug("[zynpu_mm_try_alloc_in_region] alloc done: PA 0x%llx, size 0x%llx",
+			buf->pa, buf->bytes);
+	}
+	mutex_unlock(&region->lock);
+
+	return ret;
+}
+
+static int zynpu_mm_free_in_region(struct zynpu_mem_region *region, struct buf_desc *buf)
+{
+	int ret = 0;
+	int found = 0;
+	struct zynpu_block *target = NULL;
+	struct zynpu_block *prev = NULL;
+	struct zynpu_block *next = NULL;
+
+	if ((!region) || (!buf))
+		return -EINVAL;
+
+	mutex_lock(&region->lock);
+
+	list_for_each_entry(target, &region->blk_head->list, list) {
+		if ((target->pa == buf->pa) && (target->bytes == buf->bytes)) {
+			found = 1;
+			break;
+		}
+	}
+
+	if (!found) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	/* update target block to be free state */
+	target->tid = 0;
+	target->type = ZYNPU_MM_DATA_TYPE_NONE;
+	target->state = ZYNPU_BLOCK_STATE_FREE;
+
+	/*
+	    merge prev block and next block if they are free/aligned
+
+	    block list: ... <=> |<--prev-->| <=> |<--target-->| <=> |<--next-->| <=> ...
+				    free	      free	   free/aligned
+
+	    block list: ... <=> |<------------merged new block--------------->| <=> ...
+						    free
+	*/
+	prev = list_prev_entry(target, list);
+	next = list_next_entry(target, list);
+
+	if ((prev->bytes != 0) && (prev->state == ZYNPU_BLOCK_STATE_FREE)) {
+		prev->bytes += target->bytes;
+		list_del(&target->list);
+		kfree(target);
+		target = prev;
+	}
+
+	if ((next->bytes != 0) && (next->state != ZYNPU_BLOCK_STATE_ALLOCATED)) {
+		target->bytes += next->bytes;
+		list_del(&next->list);
+		kfree(next);
+		next = NULL;
+	}
+
+	region->tot_free_bytes += buf->bytes;
+
+unlock:
+	mutex_unlock(&region->lock);
+	return ret;
+}
+
+static int zynpu_mm_scan_regions_alloc(struct zynpu_memory_manager *mm, struct zynpu_mem_region *head,
+	struct buf_request *buf_req, struct zynpu_buffer *buf)
+{
+	int ret = -ENOMEM;
+	struct zynpu_mem_region *region = NULL;
+
+	if ((!mm) || (!head) || (!buf_req) || (!buf))
+		return -EINVAL;
+
+	/**
+	 * Z2:
+	 * Find target region for ro/stack directly by matching region ID because
+	 * they must be allocated in the same region as text region allocated before.
+	 * Note: text should be requested to allocate first!
+	 */
+	if ((mm->version == ZYNPU_VERSION_ZHOUYI_V2) &&
+	    (buf_req->data_type == ZYNPU_MM_DATA_TYPE_RO_STACK)) {
+		list_for_each_entry(region, &head->list, list) {
+			if (buf_req->region_id == region->id) {
+				ret = zynpu_mm_try_alloc_in_region(mm, region, buf_req, buf);
+				if (!ret)
+					break;
+			}
+		}
+	} else {
+		list_for_each_entry(region, &head->list, list) {
+			if (region->tot_free_bytes >= ALIGN(buf_req->bytes, PAGE_SIZE)) {
+				ret = zynpu_mm_try_alloc_in_region(mm, region, buf_req, buf);
+				if (!ret)
+					break;
+			}
+		}
+	}
+
+	return ret;
+}
+
+static struct zynpu_mem_region *zynpu_mm_find_region(struct zynpu_mem_region *head, u64 pa, u64 bytes)
+{
+	struct zynpu_mem_region *region = NULL;
+
+	if ((!head) || (!bytes))
+		return region;
+
+	list_for_each_entry(region, &head->list, list) {
+		if ((pa >= region->pa) &&
+		    ((pa + bytes) <= (region->pa + region->tot_bytes)))
+			return region;
+	}
+
+	return NULL;
+}
+
+static int zynpu_mm_deinit_region(struct zynpu_memory_manager *mm, struct zynpu_mem_region *region)
+{
+	struct zynpu_block *prev = NULL;
+	struct zynpu_block *next = NULL;
+
+	if (!region)
+		return -EINVAL;
+
+	mutex_lock(&region->lock);
+
+	list_for_each_entry_safe(prev, next, &region->blk_head->list, list) {
+		kfree(prev);
+		prev = NULL;
+	}
+	kfree(region->blk_head);
+	region->blk_head = NULL;
+
+	if (region->type == ZYNPU_MEM_TYPE_SRAM)
+		zynpu_unmap_region_nocache(region->va);
+	else if (region->type == ZYNPU_MEM_TYPE_CMA)
+		zynpu_free_cma_region_nocache(mm, region);
+	else if (region->type == ZYNPU_MEM_TYPE_RESERVED)
+		zynpu_unmap_region_nocache(region->va);
+
+	region->pa = 0;
+	region->va = NULL;
+	region->tot_bytes = 0;
+	region->tot_free_bytes = 0;
+
+	mutex_unlock(&region->lock);
+	//mutex_destroy(&region->lock);
+
+	return 0;
+}
+
+int zynpu_init_mm(struct zynpu_memory_manager *mm, struct device *dev, int version)
+{
+	if ((!mm) || (!dev))
+		return -EINVAL;
+
+	mm->sram_head = create_region_list_head();
+	mm->sram_cnt = 0;
+	mm->ddr_head = create_region_list_head();
+	mm->ddr_cnt = 0;
+	mm->sram_global = get_asid(mm, ZYNPU_CONFIG_SRAM_DATA_ASID);
+	mm->dev = dev;
+	mm->version = version;
+
+	/* success */
+	return 0;
+}
+
+void zynpu_deinit_mm(struct zynpu_memory_manager *mm)
+{
+	struct zynpu_mem_region *region = NULL;
+
+	if (!mm)
+	       return;
+
+	if (mm->sram_head) {
+		list_for_each_entry(region, &mm->sram_head->list, list) {
+			zynpu_mm_deinit_region(mm, region);
+		}
+	}
+
+	if (mm->ddr_head) {
+		list_for_each_entry(region, &mm->ddr_head->list, list) {
+			zynpu_mm_deinit_region(mm, region);
+		}
+	}
+	memset(mm, 0, sizeof(struct zynpu_memory_manager));
+}
+
+int zynpu_mm_add_region(struct zynpu_memory_manager *mm, u64 base, u64 bytes,
+	enum zynpu_mem_type type)
+{
+	int ret = 0;
+	int region_id = 0;
+	struct zynpu_mem_region *region = NULL;
+
+	if ((!mm) || (!bytes))
+		return -EINVAL;
+
+	region = devm_kzalloc(mm->dev, sizeof(struct zynpu_mem_region), GFP_KERNEL);
+	if (!region)
+		return -ENOMEM;
+
+	if (type == ZYNPU_MEM_TYPE_SRAM)
+		region->va = zynpu_remap_region_nocache(mm, base, bytes);
+	else if (type == ZYNPU_MEM_TYPE_CMA)
+		region->va = zynpu_alloc_cma_region_nocache(mm, &base, bytes);
+	else if (type == ZYNPU_MEM_TYPE_RESERVED)
+		region->va = zynpu_remap_region_nocache(mm, base, bytes);
+
+	if (!region->va)
+		return -ENOMEM;
+
+	region_id = mm->sram_cnt + mm->ddr_cnt;
+	ret = zynpu_init_region(region_id, mm, base, bytes, type, region);
+	if (ret)
+		return ret;
+
+	if (type == ZYNPU_MEM_TYPE_SRAM)
+		ret = zynpu_update_mm_regions(mm, mm->sram_head, &mm->sram_cnt, region);
+	else
+		ret = zynpu_update_mm_regions(mm, mm->ddr_head, &mm->ddr_cnt, region);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+int zynpu_mm_alloc(struct zynpu_memory_manager *mm, struct buf_request *buf_req,
+	struct zynpu_buffer *buf)
+{
+	int ret = 0;
+	int asid = ZYNPU_ASE_ID_NONE;
+
+	if ((!mm) || (!buf_req) || (!buf))
+		return -EINVAL;
+
+	if ((!buf_req->bytes) || (!buf_req->align_in_page))
+		return -EINVAL;
+
+	memset(buf, 0, sizeof(struct zynpu_buffer));
+	asid = get_asid(mm, buf_req->data_type);
+
+	if ((!mm->sram_cnt) && (!mm->ddr_cnt))
+		return -ENOMEM;
+
+	/**
+	 * Try to alloc from SRAM first if the ASID is compatible; if failed then
+	 * fall back to alloc from DDR.
+	 */
+	if (mm->sram_global & asid) {
+		ret = zynpu_mm_scan_regions_alloc(mm, mm->sram_head, buf_req, buf);
+		if (!ret)
+			goto finish;
+	}
+
+	ret = zynpu_mm_scan_regions_alloc(mm, mm->ddr_head, buf_req, buf);
+	if (ret) {
+		buf_req->errcode = ZYNPU_ERRCODE_NO_MEMORY;
+		dev_err(mm->dev, "[MM] buffer allocation failed for: bytes 0x%llx, page align %d\n",
+			buf_req->bytes, buf_req->align_in_page);
+	}
+
+finish:
+	return ret;
+}
+
+int zynpu_mm_free(struct zynpu_memory_manager *mm, struct buf_desc *buf)
+{
+	int ret = 0;
+	struct zynpu_mem_region *region = NULL;
+
+	if ((!mm) || (!buf))
+		return -EINVAL;
+
+	region = zynpu_mm_find_region(mm->sram_head, buf->pa, buf->bytes);
+	if (!region) {
+		region = zynpu_mm_find_region(mm->ddr_head, buf->pa, buf->bytes);
+		if (!region) {
+			dev_err(mm->dev, "[MM] buffer to free not exists in any region: \
+				pa 0x%llx, bytes 0x%llx\n",
+				buf->pa, buf->bytes);
+			return -EINVAL;
+		}
+	}
+
+	ret = zynpu_mm_free_in_region(region, buf);
+	if (ret) {
+		dev_err(mm->dev, "[MM] buffer to free not exists in target region: \
+			pa 0x%llx, bytes 0x%llx\n",
+			buf->pa, buf->bytes);
+	}
+
+	return ret;
+}
+
+int zynpu_mm_free_session_buffers(struct zynpu_memory_manager *mm,
+	struct zynpu_session *session)
+{
+	int ret = 0;
+	struct zynpu_buffer *buf = NULL;
+	struct buf_desc desc;
+
+	while (NULL != (buf = zynpu_get_session_sbuf_head(session))) {
+		desc.pa = buf->pa;
+		desc.bytes = buf->bytes;
+		ret = zynpu_mm_free(mm, &desc);
+		if (ret)
+			goto finish;
+		ret = zynpu_session_detach_buf(session, &desc);
+		if (ret)
+			goto finish;
+	}
+
+finish:
+	return ret;
+}
\ No newline at end of file
diff --git a/drivers/staging/zynpu/zynpu_mm.h b/drivers/staging/zynpu/zynpu_mm.h
new file mode 100644
index 000000000000..d165f1434e02
--- /dev/null
+++ b/drivers/staging/zynpu/zynpu_mm.h
@@ -0,0 +1,142 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+*
+* Zhouyi AI Accelerator driver
+*
+* Copyright (C) 2020 Arm (China) Ltd.
+* Copyright (C) 2021 Cai Huoqing
+*/
+
+/**
+ * @file zynpu_mm.h
+ * Header of the ZYNPU memory management supports Address Space Extension (ASE)
+ */
+
+#ifndef _ZYNPU_MM_H_
+#define _ZYNPU_MM_H_
+
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/device.h>
+#include "zynpu_session.h"
+
+struct zynpu_mem_region;
+struct zynpu_memory_manager;
+typedef int (*alloc_in_region_t)(struct zynpu_memory_manager *mm, struct zynpu_mem_region *region,
+	struct buf_request *buf_req, struct zynpu_buffer *buf);
+
+enum zynpu_blk_state {
+	ZYNPU_BLOCK_STATE_FREE,
+	ZYNPU_BLOCK_STATE_ALLOCATED,
+};
+
+enum zynpu_asid {
+	ZYNPU_ASE_ID_NONE = 0x0,
+	ZYNPU_ASE_ID_0 = 0x1,
+	ZYNPU_ASE_ID_1 = 0x2,
+	ZYNPU_ASE_ID_2 = 0x4,
+	ZYNPU_ASE_ID_3 = 0x8,
+	ZYNPU_ASE_ID_ALL = 0xF,
+};
+
+enum zynpu_mem_type {
+	ZYNPU_MEM_TYPE_SRAM,
+	ZYNPU_MEM_TYPE_CMA,
+	ZYNPU_MEM_TYPE_RESERVED,
+};
+
+struct zynpu_block {
+	u64 pa;
+	u64 bytes;
+	int tid;
+	enum zynpu_mm_data_type type;
+	enum zynpu_blk_state state;
+	struct list_head list;
+};
+
+struct zynpu_mem_region {
+	int id;
+	struct zynpu_block *blk_head;
+	struct mutex lock;
+	u64 pa;
+	void *va;
+	u64 tot_bytes;
+	u64 tot_free_bytes;
+	//int flag;
+	enum zynpu_mem_type type;
+	alloc_in_region_t alloc_in_region;
+	struct list_head list;
+};
+
+struct zynpu_memory_manager {
+	struct zynpu_mem_region *sram_head;
+	int sram_cnt;
+	struct zynpu_mem_region *ddr_head;
+	int ddr_cnt;
+	enum zynpu_asid sram_global;
+	struct device *dev;
+	int version;
+};
+
+/*
+ * @brief initialize mm module during driver probe phase
+ *
+ * @param mm: memory manager struct allocated by user
+ * @param dev: device struct pointer
+ * @param zynpu_version: ZYNPU version
+ *
+ * @return 0 if successful; others if failed.
+ */
+int zynpu_init_mm(struct zynpu_memory_manager *mm, struct device *dev, int version);
+/*
+ * @brief initialize mm module during driver probe phase
+ *
+ * @param mm: memory manager struct allocated by user
+ * @param base: base physical address of this region
+ * @param bytes: size of this region (in bytes)
+ * @param type: ZYNPU memory type
+ *
+ * @return 0 if successful; others if failed.
+ */
+int zynpu_mm_add_region(struct zynpu_memory_manager *mm, u64 base, u64 bytes,
+	enum zynpu_mem_type type);
+/*
+ * @brief alloc memory buffer for user request
+ *
+ * @param mm: memory manager struct allocated by user
+ * @param buf_req:  buffer request struct from userland
+ * @param buf: successfully allocated buffer descriptor
+ *
+ * @return 0 if successful; others if failed.
+ */
+int zynpu_mm_alloc(struct zynpu_memory_manager *mm, struct buf_request *buf_req,
+	struct zynpu_buffer *buf);
+/*
+ * @brief free buffer allocated by zynpu_mm_alloc
+ *
+ * @param mm: memory manager struct allocated by user
+ * @param buf: buffer descriptor to be released
+ *
+ * @return 0 if successful; others if failed.
+ */
+int zynpu_mm_free(struct zynpu_memory_manager *mm, struct buf_desc *buf);
+/*
+ * @brief free all the allocated buffers of a session
+ *
+ * @param mm: mm struct pointer
+ * @param session: session struct pointer
+ *
+ * @return 0 if successful; others if failed.
+ */
+int zynpu_mm_free_session_buffers(struct zynpu_memory_manager *mm,
+	struct zynpu_session *session);
+/*
+ * @brief de-initialize mm module while kernel module unloading
+ *
+ * @param mm: memory manager struct allocated by user
+ *
+ * @return void
+ */
+void zynpu_deinit_mm(struct zynpu_memory_manager *mm);
+
+#endif /* _ZYNPU_MM_H_ */
\ No newline at end of file
diff --git a/drivers/staging/zynpu/zynpu_session.c b/drivers/staging/zynpu/zynpu_session.c
new file mode 100644
index 000000000000..c6707c6aa5ef
--- /dev/null
+++ b/drivers/staging/zynpu/zynpu_session.c
@@ -0,0 +1,817 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+*
+* Zhouyi AI Accelerator driver
+*
+* Copyright (C) 2020 Arm (China) Ltd.
+* Copyright (C) 2021 Cai Huoqing
+*/
+
+/**
+ * @file zynpu_session.c
+ * Implementation of session module
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/poll.h>
+#include <linux/string.h>
+#include "zynpu_session.h"
+#include "zynpu_mm.h"
+#include "zynpu.h"
+
+static void init_session_buf(struct session_buf *buf,
+	struct zynpu_buffer *desc, u64 dev_offset)
+{
+	if (buf) {
+		if (!desc)
+			memset(&buf->desc, 0, sizeof(struct zynpu_buffer));
+		else {
+			buf->desc = *desc;
+			buf->type = desc->type;
+		}
+		buf->dev_offset = dev_offset;
+		buf->map_num = 0;
+		INIT_LIST_HEAD(&buf->head);
+	}
+}
+
+static struct session_buf *create_session_buf(struct zynpu_buffer *desc,
+	u64 dev_offset)
+{
+	struct session_buf *sbuf = NULL;
+
+	if (!desc) {
+		pr_err("descriptor is needed while creating new session buf!");
+		goto finish;
+	}
+
+	sbuf = kzalloc(sizeof(struct session_buf), GFP_KERNEL);
+	init_session_buf(sbuf, desc, dev_offset);
+
+finish:
+	return sbuf;
+}
+
+static int destroy_session_buffer(struct session_buf *buf)
+{
+	int ret = 0;
+
+	if (buf)
+		kfree(buf);
+	else {
+		pr_err("invalid null buf args or list not empty!");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static void init_session_job(struct session_job *job, struct user_job_desc *desc)
+{
+    if (job) {
+	    /* init job->desc to be all 0 if desc == NULL */
+	    job->uthread_id = task_pid_nr(current);
+	    if (!desc)
+		    memset(&job->desc, 0, sizeof(struct user_job_desc));
+	    else
+		    job->desc = *desc;
+	    job->state = 0;
+	    job->exception_type = ZYNPU_EXCEP_NO_EXCEPTION;
+	    INIT_LIST_HEAD(&job->head);
+    }
+}
+
+static struct session_job *create_session_job(struct user_job_desc *desc)
+{
+	struct session_job *new_job = NULL;
+
+	if (!desc) {
+		pr_err("descriptor is needed while creating new session job!");
+		goto finish;
+	}
+
+	new_job = kzalloc(sizeof(struct session_job), GFP_KERNEL);
+	init_session_job(new_job, desc);
+
+finish:
+	return new_job;
+}
+
+static int destroy_session_job(struct session_job *job)
+{
+	int ret = 0;
+
+	if (job)
+		kfree(job);
+	else {
+		pr_err("invalid null job args or list not empty!");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int is_session_all_jobs_end(struct zynpu_session *session)
+{
+	return (!session) ? 1 : list_empty(&session->job_list.head);
+}
+
+static int is_session_all_buffers_freed(struct zynpu_session *session)
+{
+	return (!session) ? 1 : list_empty(&session->sbuf_list.head);
+}
+
+static struct session_buf *find_buffer_bydesc_no_lock(struct zynpu_session *session,
+	struct buf_desc *buf_desc)
+{
+	struct session_buf *target_buf  = NULL;
+	struct session_buf *session_buf = NULL;
+	struct list_head *node = NULL;
+
+	if ((!session) || (!buf_desc)) {
+		pr_err("invalid input session or buf_desc args to be null!");
+		goto finish;
+	}
+
+	list_for_each(node, &session->sbuf_list.head) {
+		session_buf = list_entry(node, struct session_buf, head);
+
+		if (session_buf &&
+		    (session_buf->desc.pa == buf_desc->pa) &&
+		    (session_buf->desc.bytes == buf_desc->bytes)) {
+			target_buf = session_buf;
+			pr_info("found matching buffer to be deleted.");
+			goto finish;
+		}
+	}
+
+finish:
+	return target_buf;
+}
+
+static struct session_buf *find_buffer_byoffset_no_lock(struct zynpu_session *session,
+    u64 offset, int len)
+{
+	struct session_buf *target_buf = NULL;
+	struct session_buf *session_buf = NULL;
+	struct list_head *node = NULL;
+
+	if (!session) {
+		pr_err("invalid input session args to be null!");
+		goto finish;
+	}
+
+	list_for_each(node, &session->sbuf_list.head) {
+		session_buf = list_entry(node, struct session_buf, head);
+		if (session_buf &&
+		    (session_buf->dev_offset == offset) &&
+		    (len <= session_buf->desc.bytes)) {
+			target_buf = session_buf;
+			goto finish;
+		}
+	}
+
+finish:
+	return target_buf;
+}
+
+/*
+ * @brief get requested waitqueue for a user thread
+ *
+ * @param head: wait queue head
+ * @uthread_id: user thread ID
+ *
+ * @return waitqueue pointer; NULL if not found;
+ */
+static struct zynpu_thread_wait_queue*
+get_thread_wait_queue_no_lock(struct zynpu_thread_wait_queue *head, int uthread_id)
+{
+	struct zynpu_thread_wait_queue *curr = NULL;
+
+	if (!head)
+		return NULL;
+
+	list_for_each_entry(curr, &head->node, node) {
+		if (curr->uthread_id == uthread_id)
+			return curr;
+	}
+	return NULL;
+}
+
+/*
+ * @brief create a new waitqueue for a user thread if there is no existing one
+ *
+ * @param head: wait queue head
+ * @uthread_id: user thread ID
+ *
+ * @return waitqueue pointer if not existing one; NULL if there has been an existing one;
+ */
+static struct zynpu_thread_wait_queue *
+create_thread_wait_queue_no_lock(struct zynpu_thread_wait_queue *head, int uthread_id)
+{
+	struct zynpu_thread_wait_queue *ret = NULL;
+	struct zynpu_thread_wait_queue *queue = get_thread_wait_queue_no_lock(head, uthread_id);
+
+	/* new thread wait queue */
+	if (!queue) {
+		queue = kzalloc(sizeof(struct zynpu_thread_wait_queue), GFP_KERNEL);
+		queue->uthread_id = uthread_id;
+		init_waitqueue_head(&queue->p_wait);
+		INIT_LIST_HEAD(&queue->node);
+
+		if (queue && head) {
+			list_add_tail(&queue->node, &head->node);
+		}
+		ret = queue;
+	}
+
+	queue->ref_cnt++;
+	return ret;
+}
+
+/********************************************************************************
+ *  The following APIs are called in thread context for session obj management  *
+ *  and member query service						    *
+ *  -- zynpu_create_session						      *
+ *  -- zynpu_destroy_session						     *
+ *  -- zynpu_get_session_pid						     *
+ ********************************************************************************/
+int zynpu_create_session(int pid, void *zynpu_priv,
+	struct zynpu_session **p_session)
+{
+	int ret = 0;
+	struct zynpu_session *session = NULL;
+	struct device *dev = NULL;
+
+	if ((!zynpu_priv) || (!p_session)) {
+		pr_err("invalid input session or common args to be null!");
+		goto finish;
+	}
+
+	dev = ((struct zynpu_priv *)zynpu_priv)->dev;
+
+	session = kzalloc(sizeof(struct zynpu_session), GFP_KERNEL);
+	if (!session)
+		return -ENOMEM;
+
+	session->user_pid = pid;
+	init_session_buf(&session->sbuf_list, NULL, 0);
+	mutex_init(&session->sbuf_lock);
+	init_session_job(&session->job_list, NULL);
+	spin_lock_init(&session->job_lock);
+	session->zynpu_priv = zynpu_priv;
+	session->wait_queue_head = create_thread_wait_queue_no_lock(NULL, 0);
+	init_waitqueue_head(&session->com_wait);
+	session->single_thread_poll = 0;
+
+	*p_session = session;
+	dev_dbg(dev, "[%d] new session created\n", pid);
+
+finish:
+	return ret;
+}
+
+/*
+ * @brief delete a waitqueue list
+ *
+ * @param head: wait queue head
+ *
+ */
+static void delete_wait_queue(struct zynpu_thread_wait_queue *wait_queue_head)
+{
+	struct zynpu_thread_wait_queue *cursor = NULL;
+	struct zynpu_thread_wait_queue *next = NULL;
+
+	if (wait_queue_head) {
+		list_for_each_entry_safe(cursor, next, &wait_queue_head->node, node) {
+			list_del(&cursor->node);
+			kfree(cursor);
+		}
+	}
+}
+
+int zynpu_destroy_session(struct zynpu_session *session)
+{
+	int ret = 0;
+	struct device *dev = NULL;
+	int pid = 0;
+
+	if (session &&
+	    is_session_all_jobs_end(session) &&
+	    is_session_all_buffers_freed(session)) {
+		dev = ((struct zynpu_priv *)session->zynpu_priv)->dev;
+		pid = session->user_pid;
+		delete_wait_queue(session->wait_queue_head);
+		kfree(session->wait_queue_head);
+		kfree(session);
+		dev_dbg(dev, "[%d] session destroyed\n", pid);
+	} else {
+		pr_warn("invalid input session args to be null or invalid operation!");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+int zynpu_get_session_pid(struct zynpu_session *session)
+{
+	if (session)
+		return session->user_pid;
+	else {
+		pr_warn("invalid input session args to be null!");
+		return -EINVAL;
+	}
+}
+
+/********************************************************************************
+ *  The following APIs are called in thread context for servicing user space    *
+ *  request in resource allocation/free and job scheduling via fops	     *
+ *  -- zynpu_session_add_buf						     *
+ *  -- zynpu_session_detach_buf						  *
+ *  -- zynpu_get_session_sbuf_head					       *
+ *  -- zynpu_session_mmap_buf						    *
+ *  -- zynpu_session_add_job						     *
+ *  -- zynpu_session_delete_jobs						 *
+ ********************************************************************************/
+int zynpu_session_add_buf(struct zynpu_session *session,
+	struct buf_request *buf_req, struct zynpu_buffer *buf)
+{
+	int ret = 0;
+	struct session_buf *new_sbuf = NULL;
+
+	if ((!session) || (!buf_req) || (!buf)) {
+		pr_err("invalid input session or buf_req or buf args to be null!");
+		if (buf_req)
+			buf_req->errcode = ZYNPU_ERRCODE_INTERNAL_NULLPTR;
+		ret = -EINVAL;
+		goto finish;
+	}
+
+	new_sbuf = create_session_buf(buf, buf->pa);
+	if (!new_sbuf) {
+		pr_err("create session buf failed!");
+		buf_req->errcode = ZYNPU_ERRCODE_CREATE_KOBJ_ERR;
+		ret = -EFAULT;
+	} else {
+		mutex_lock(&session->sbuf_lock);
+		list_add(&new_sbuf->head, &session->sbuf_list.head);
+
+		/* success */
+		/* copy buffer descriptor to userland */
+		buf_req->desc.pa = buf->pa;
+		buf_req->desc.dev_offset = buf->pa;
+		buf_req->desc.bytes = buf->bytes;
+		buf_req->desc.region_id = buf->region_id;
+		buf_req->errcode = 0;
+		mutex_unlock(&session->sbuf_lock);
+	}
+
+finish:
+	return ret;
+}
+
+int zynpu_session_detach_buf(struct zynpu_session *session, struct buf_desc *buf_desc)
+{
+	int ret = 0;
+	struct session_buf *target_buf = NULL;
+
+	if ((!session) || (!buf_desc)) {
+		pr_err("invalid input session or buf args to be null!");
+		ret = -EINVAL;
+		goto finish;
+	}
+
+	/* LOCK */
+	mutex_lock(&session->sbuf_lock);
+	target_buf = find_buffer_bydesc_no_lock(session, buf_desc);
+	if (!target_buf) {
+		pr_err("no corresponding buffer found in this session!");
+		ret = -ENOENT;
+	} else {
+		list_del(&target_buf->head);
+		ret = destroy_session_buffer(target_buf);
+		if (ret)
+			pr_err("destroy session failed!");
+		else
+			target_buf = NULL;
+	}
+	mutex_unlock(&session->sbuf_lock);
+	/* UNLOCK */
+
+finish:
+	return ret;
+}
+
+int zynpu_session_mmap_buf(struct zynpu_session *session, struct vm_area_struct *vma, struct device *dev)
+{
+	int ret = 0;
+	u64 offset = 0;
+	int len = 0;
+	unsigned long vm_pgoff = 0;
+	struct session_buf *buf = NULL;
+
+	if ((!session) || (!vma)) {
+		pr_err("invalid input session or vma args to be null!");
+		ret = -EINVAL;
+		goto finish;
+	}
+
+	offset = vma->vm_pgoff * PAGE_SIZE;
+	len = vma->vm_end - vma->vm_start;
+
+	/* LOCK */
+	mutex_lock(&session->sbuf_lock);
+	/* to find an allocated buffer with matching dev offset and length */
+	buf = find_buffer_byoffset_no_lock(session, offset, len);
+	if (!buf) {
+		pr_err("invalid operation or args: no corresponding buffer found in this session!");
+		ret = -ENOENT;
+	} else {
+		if (buf->map_num) {
+			pr_err("duplicated mmap operations on identical buffer!");
+			ret = -ENOTTY;
+		} else {
+			vm_pgoff = vma->vm_pgoff;
+			vma->vm_pgoff = 0;
+			vma->vm_flags |= VM_IO;
+			vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+			if (buf->type == ZYNPU_MEM_TYPE_CMA) {
+				ret = dma_mmap_coherent(dev, vma, buf->desc.va,
+					(dma_addr_t)buf->desc.pa, buf->desc.bytes);
+				if (ret)
+					pr_err("CMA mmap to userspace failed!");
+			} else if ((buf->type == ZYNPU_MEM_TYPE_SRAM) ||
+				   (buf->type == ZYNPU_MEM_TYPE_RESERVED)) {
+				ret = remap_pfn_range(vma, vma->vm_start, buf->desc.pa >> PAGE_SHIFT,
+					vma->vm_end - vma->vm_start, vma->vm_page_prot);
+				if (ret)
+					pr_err("SRAM mmap to userspace failed!");
+			}
+
+			vma->vm_pgoff = vm_pgoff;
+			if (!ret)
+				buf->map_num++;
+		}
+	}
+	mutex_unlock(&session->sbuf_lock);
+	/* UNLOCK */
+
+finish:
+    return ret;
+}
+
+struct zynpu_buffer *zynpu_get_session_sbuf_head(struct zynpu_session *session)
+{
+	struct session_buf *session_buf = NULL;
+	struct zynpu_buffer *buf_desc = NULL;
+	struct list_head *node = NULL;
+
+	if (!session) {
+		pr_err("invalid input session or buf_req or buf args to be null!");
+		goto finish;
+	}
+
+	list_for_each(node, &session->sbuf_list.head) {
+		if (!list_empty(node)) {
+			session_buf = list_entry(node, struct session_buf, head);
+			buf_desc = &session_buf->desc;
+			goto finish;
+		}
+	}
+
+finish:
+	return buf_desc;
+}
+
+struct session_job *zynpu_session_add_job(struct zynpu_session *session, struct user_job *user_job)
+{
+	struct session_job *kern_job = NULL;
+
+	if ((!session) || (!user_job)) {
+		pr_err("invalid input session or user_job args to be null!");
+		if (NULL != user_job)
+			user_job->errcode = ZYNPU_ERRCODE_INTERNAL_NULLPTR;
+		goto finish;
+	}
+
+	kern_job = create_session_job(&user_job->desc);
+	if (!kern_job) {
+		pr_err("invalid input session or job args to be null!");
+		user_job->errcode = ZYNPU_ERRCODE_CREATE_KOBJ_ERR;
+	} else {
+		/* THREAD LOCK */
+		spin_lock_bh(&session->job_lock);
+		list_add(&kern_job->head, &session->job_list.head);
+		create_thread_wait_queue_no_lock(session->wait_queue_head, kern_job->uthread_id);
+		spin_unlock_bh(&session->job_lock);
+		/* THREAD UNLOCK */
+
+		/* success */
+		user_job->errcode = 0;
+	}
+
+finish:
+	return kern_job;
+}
+
+int zynpu_session_delete_jobs(struct zynpu_session *session)
+{
+	int ret = 0;
+	struct session_job *cursor = NULL;
+	struct session_job *next = NULL;
+
+	if (!session) {
+		pr_err("invalid input session to be null!");
+		ret = -EINVAL;
+		goto finish;
+	}
+
+	/* THREAD LOCK */
+	spin_lock_bh(&session->job_lock);
+	list_for_each_entry_safe(cursor, next, &session->job_list.head, head) {
+		list_del(&cursor->head);
+		destroy_session_job(cursor);
+	}
+	spin_unlock_bh(&session->job_lock);
+	/* THREAD UNLOCK */
+
+finish:
+	return ret;
+}
+
+/********************************************************************************
+ *  The following APIs are called in interrupt context to update end job status *
+ *  They will be called by IRQ handlers in job manager module		   *
+ *  Note that param session and session_job passed by job manager is assumed    *
+ *  to be valid and active (not cancelled by userland)			  *
+ *  -- zynpu_session_job_done						    *
+ *  -- zynpu_session_job_excep						   *
+ *  -- zynpu_session_job_update_pdata					    *
+ ********************************************************************************/
+void zynpu_session_job_done(struct zynpu_session *session, struct session_job *job,
+	int excep_flag)
+{
+	struct zynpu_thread_wait_queue *queue = NULL;
+	wait_queue_head_t *thread_queue = NULL;
+
+	if ((!session) || (!job)) {
+		pr_err("invalid input session or job args to be null!");
+		return;
+	}
+
+	if (ZYNPU_EXCEP_NO_EXCEPTION == excep_flag)
+		pr_debug("Done interrupt received...");
+	else
+		pr_debug("Exception interrupt received...");
+
+	/* IRQ LOCK */
+	spin_lock(&session->job_lock);
+	job->state = ZYNPU_JOB_STATE_END;
+	job->exception_type = ZYNPU_EXCEP_NO_EXCEPTION;
+
+	if (session->single_thread_poll) {
+		queue = get_thread_wait_queue_no_lock(session->wait_queue_head,
+			job->uthread_id);
+		if (queue)
+			thread_queue = &queue->p_wait;
+		else {
+			pr_err("job waitqueue not found!");
+			spin_unlock(&session->job_lock);
+			return;
+		}
+	} else {
+		thread_queue = &session->com_wait;
+	}
+
+	if (thread_queue)
+		wake_up_interruptible(thread_queue);
+	else
+		pr_err("[%d] thread wait queue not found!", job->uthread_id);
+
+	spin_unlock(&session->job_lock);
+	/* IRQ UNLOCK */
+}
+/*
+void zynpu_session_job_update_pdata(struct zynpu_session *session, struct session_job *job)
+{
+	struct zynpu_priv *zynpu = NULL;
+	if ((!session) || (!job)) {
+		pr_err("invalid input session or desc or scc args to be null!");
+		return;
+	}
+
+	zynpu = (struct zynpu_priv *)session->zynpu_priv;
+
+	if (zynpu && job->desc.enable_prof)
+		zynpu_priv_read_profiling_reg(zynpu, &job->pdata);
+
+	pr_info("TOT WDATA LSB: 0x%x\n", job->pdata.wdata_tot_lsb);
+	pr_info("TOT WDATA MSB: 0x%x\n", job->pdata.wdata_tot_msb);
+	pr_info("TOT RDATA LSB: 0x%x\n", job->pdata.rdata_tot_lsb);
+	pr_info("TOT RDATA MSB: 0x%x\n", job->pdata.rdata_tot_msb);
+	pr_info("TOT CYCLE LSB: 0x%x\n", job->pdata.tot_cycle_lsb);
+	pr_info("TOT CYCLE MSB: 0x%x\n", job->pdata.tot_cycle_msb);
+}
+*/
+
+/********************************************************************************
+ *  The following APIs are called in thread context for user query service      *
+ *  after job end							       *
+ *  -- zynpu_session_query_pdata						 *
+ *  -- zynpu_session_thread_has_end_job					  *
+ *  -- zynpu_session_get_job_status					      *
+ ********************************************************************************/
+int zynpu_session_thread_has_end_job(struct zynpu_session *session, int uthread_id)
+{
+	int ret = 0;
+	struct session_job *session_job = NULL;
+	struct list_head *node = NULL;
+	int wake_up_single = 0;
+
+	if (!session) {
+		pr_err("invalid input session or excep args to be null!");
+		goto finish;
+	}
+
+	/**
+	 * If uthread_id found in job_list, then the condition returns is specific to
+	 * the status of jobs of this thread (thread-specific); otherwise, the condition
+	 * is specific to the status of jobs of this session (fd-specific).
+	 */
+	spin_lock(&session->job_lock);
+	list_for_each(node, &session->job_list.head) {
+		session_job = list_entry(node, struct session_job, head);
+		if (session_job && (session_job->uthread_id == uthread_id)) {
+			wake_up_single = 1;
+			break;
+		}
+	}
+
+	list_for_each(node, &session->job_list.head) {
+		session_job = list_entry(node, struct session_job, head);
+		if (session_job && (session_job->state == ZYNPU_JOB_STATE_END)) {
+			if (wake_up_single) {
+				if (session_job->uthread_id == uthread_id) {
+					ret = 1;
+					break;
+				}
+			} else {
+				ret = 1;
+				break;
+			}
+		}
+	}
+	spin_unlock(&session->job_lock);
+
+finish:
+	return ret;
+}
+
+int zynpu_session_get_job_status(struct zynpu_session *session, struct job_status_query *job_status)
+{
+	int ret = 0;
+	int query_cnt;
+	struct job_status_desc *status = NULL;
+	struct session_job *cursor = NULL;
+	struct session_job *next = NULL;
+	int poll_iter = 0;
+
+	if ((!session) || (!job_status)) {
+		pr_err("invalid input session or excep args to be null!");
+		goto finish;
+	}
+
+	if (job_status->max_cnt < 1) {
+		job_status->errcode = ZYNPU_ERRCODE_INVALID_ARGS;
+		ret = -EINVAL;
+		goto finish;
+	}
+
+	if (job_status->get_single_job)
+		query_cnt = 1;
+	else
+		query_cnt = job_status->max_cnt;
+
+	status = kzalloc(query_cnt * sizeof(struct job_status_desc), GFP_KERNEL);
+	if (!status) {
+		job_status->errcode = ZYNPU_ERRCODE_NO_MEMORY;
+		ret = -ENOMEM;
+		goto finish;
+	}
+
+	job_status->poll_cnt = 0;
+	spin_lock(&session->job_lock);
+	list_for_each_entry_safe(cursor, next, &session->job_list.head, head) {
+		if (job_status->poll_cnt == job_status->max_cnt)
+			break;
+
+		if ((((cursor->desc.job_id == job_status->job_id) && (job_status->get_single_job)) ||
+		    (!job_status->get_single_job)) &&
+		    (cursor->state == ZYNPU_JOB_STATE_END)) {
+			status[poll_iter].job_id = cursor->desc.job_id;
+			status[poll_iter].thread_id = session->user_pid;
+			status[0].state = (cursor->exception_type == ZYNPU_EXCEP_NO_EXCEPTION) ?
+				ZYNPU_JOB_STATE_DONE : ZYNPU_JOB_STATE_EXCEPTION;
+			status[poll_iter].pdata = cursor->pdata;
+			job_status->poll_cnt++;
+			list_del(&cursor->head);
+			destroy_session_job(cursor);
+			cursor = NULL;
+			if (job_status->get_single_job)
+				break;
+		}
+	}
+	spin_unlock(&session->job_lock);
+
+	if (!job_status->poll_cnt) {
+		job_status->errcode = ZYNPU_ERRCODE_ITEM_NOT_FOUND;
+		ret = -ENOENT;
+		goto clean;
+	}
+
+	ret = copy_to_user((struct job_status_desc __user *)job_status->status, status,
+			   job_status->poll_cnt * sizeof(struct job_status_desc));
+	if (ZYNPU_ERRCODE_NO_ERROR == ret)
+		job_status->errcode = 0;
+
+clean:
+	kfree(status);
+
+finish:
+	return ret;
+}
+
+wait_queue_head_t *zynpu_session_get_wait_queue(struct zynpu_session *session, int uthread_id)
+{
+    struct zynpu_thread_wait_queue *queue = NULL;
+
+	if (!session) {
+		pr_err("invalid input session to be null!");
+		return NULL;
+	}
+
+	/* LOCK */
+	spin_lock(&session->job_lock);
+	queue = get_thread_wait_queue_no_lock(session->wait_queue_head, uthread_id);
+	spin_unlock(&session->job_lock);
+	/* UNLOCK */
+
+	if (queue)
+		return &queue->p_wait;
+
+	return NULL;
+}
+
+void zynpu_session_add_poll_wait_queue(struct zynpu_session *session,
+    struct file *filp, struct poll_table_struct *wait, int uthread_id)
+{
+	struct zynpu_thread_wait_queue *wait_queue = NULL;
+	struct session_job *curr = NULL;
+
+	if ((!session) || (!filp) || (!wait)) {
+		pr_err("invalid input session to be null!");
+		return;
+	}
+
+	spin_lock_bh(&session->job_lock);
+	list_for_each_entry(curr, &session->job_list.head, head) {
+		if (curr->uthread_id == uthread_id) {
+			wait_queue = get_thread_wait_queue_no_lock(session->wait_queue_head,
+				uthread_id);
+			if (wait_queue) {
+				poll_wait(filp, &wait_queue->p_wait, wait);
+				session->single_thread_poll = 1;
+			} else {
+				pr_err("thread wait_queue not found!");
+			}
+			break;
+		}
+	}
+
+	if (!session->single_thread_poll)
+		poll_wait(filp, &session->com_wait, wait);
+	spin_unlock_bh(&session->job_lock);
+}
+
+void session_job_mark_sched(struct session_job *job)
+{
+	if (job)
+		job->pdata.sched_kt = ktime_get();
+}
+
+void session_job_mark_done(struct session_job *job)
+{
+	if (job)
+		job->pdata.done_kt = ktime_get();
+}
+
+int is_session_job_prof_enabled(struct session_job *job)
+{
+	int ret = 0;
+	if (job)
+		ret = job->desc.enable_prof;
+	return ret;
+}
diff --git a/drivers/staging/zynpu/zynpu_session.h b/drivers/staging/zynpu/zynpu_session.h
new file mode 100644
index 000000000000..3ab2b98b9da4
--- /dev/null
+++ b/drivers/staging/zynpu/zynpu_session.h
@@ -0,0 +1,283 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+*
+* Zhouyi AI Accelerator driver
+*
+* Copyright (C) 2020 Arm (China) Ltd.
+* Copyright (C) 2021 Cai Huoqing
+*/
+
+/**
+ * @file zynpu_session.h
+ * session module header file
+ */
+
+#ifndef _ZYNPU_SESSION_H_
+#define _ZYNPU_SESSION_H_
+
+#include <linux/list.h>
+#include <linux/mm_types.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+#include <linux/poll.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/wait.h>
+#include "zynpu_job_manager.h"
+
+enum zynpu_mm_data_type {
+	ZYNPU_MM_DATA_TYPE_NONE,
+	ZYNPU_MM_DATA_TYPE_TEXT,
+	ZYNPU_MM_DATA_TYPE_RO_STACK,
+	ZYNPU_MM_DATA_TYPE_STATIC,
+	ZYNPU_MM_DATA_TYPE_REUSE,
+};
+
+struct buf_desc {
+	__u64 pa;
+	__u64 dev_offset; /* user space access this area via mapping this offset from the dev file start */
+	__u64 bytes;
+	__u32 region_id;
+};
+
+struct buf_request {
+	__u64 bytes;	  /* bytes requested to allocate */
+	__u32 align_in_page;  /* alignment requirements (in 4KB) */
+	__u32 data_type;      /* type of data in the buffer to allocate */
+	__u32 region_id;      /* region ID specified (if applicable) */
+	__u32 alloc_flag;     /* Allocation flag: default, strict or compact */
+	struct buf_desc desc; /* info of buffer successfully allocated */
+	__u32 errcode;
+};
+
+struct zynpu_buffer {
+	u64 pa;
+	void *va;
+	u64 bytes;
+	u32 region_id;
+	u32 type;
+};
+
+/**
+ * struct waitqueue: maintain the waitqueue for a user thread
+ *
+ * @uthread_id: user thread owns this waitqueue
+ * @ref_cnt: strucr reference count
+ * @p_wait: wait queue head for polling
+ * @node: list head struct
+ */
+struct zynpu_thread_wait_queue {
+	int uthread_id;
+	int ref_cnt;
+	wait_queue_head_t p_wait;
+	struct list_head node;
+};
+
+/**
+ * struct session_buf: session private buffer list
+ * @desc: buffer descriptor struct
+ * @dev_offset: offset of this buffer in device file
+ * @type: buffer type: CMA/SRAM/RESERVED
+ * @map_num: memory mmapped number
+ * @head: list head struct
+ */
+struct session_buf {
+	struct zynpu_buffer desc;
+	u64 dev_offset;
+	u32 type;
+	int map_num;
+	struct list_head head;
+};
+
+/**
+ * struct session_job: session private job list
+ * @uthread_id: ID of user thread scheduled this job
+ * @desc: job descriptor struct
+ * @state: job state
+ * @exception_type: type of exception if any
+ * @pdata: profiling data struct
+ * @head: list head struct
+ */
+struct session_job {
+	int uthread_id;
+	struct user_job_desc desc;
+	int state;
+	int exception_type;
+	struct profiling_data pdata;
+	struct list_head head;
+};
+
+/**
+ * struct zynpu_session: private data struct for every file open operation
+ * @user_pid: ID of the user thread doing the open operation
+ * @sbuf_list: successfully allocated shared buffer of this session
+ * @sbuf_lock: mutex lock for sbuf list
+ * @job_list: job list of this session
+ * @job_lock: spinlock for job list
+ * @zynpu_priv: zynpu_priv struct pointer
+ * @wait_queue_head: thread waitqueue list head of this session
+ * @com_wait: session common waitqueue head
+ * @single_thread_poll: flag to indicate the polling method, thread vs. fd
+ */
+struct zynpu_session {
+	int user_pid;
+	struct session_buf sbuf_list;
+	struct mutex sbuf_lock;
+	struct session_job job_list;
+	spinlock_t job_lock;
+	void *zynpu_priv;
+	struct zynpu_thread_wait_queue *wait_queue_head;
+	wait_queue_head_t com_wait;
+	int single_thread_poll;
+};
+
+/*
+ * @brief create unique session DS for an open request
+ *
+ * @param pid: user mode thread pid
+ * @param zynpu: zynpu_priv struct pointer
+ * @param p_session: session struct pointer
+ *
+ * @return 0 if successful; others if failed.
+ */
+int zynpu_create_session(int pid, void *zynpu_priv,
+	struct zynpu_session **p_session);
+/*
+ * @brief destroy an existing session
+ *
+ * @param session: session pointer
+ *
+ * @return ZYNPU_KMD_ERR_OK if successful; others if failed.
+ */
+int zynpu_destroy_session(struct zynpu_session *session);
+/*
+ * @brief get pid of this session
+ *
+ * @param session: session pointer
+ *
+ * @return id if successful; 0 if failed.
+ */
+int zynpu_get_session_pid(struct zynpu_session *session);
+/*
+ * @brief add an allocated buffer of this session
+ *
+ * @param session: session pointer
+ * @param buf_req: request buffer struct pointer
+ * @param buf: buffer allocated
+ *
+ * @return ZYNPU_KMD_ERR_OK if successful; others if failed.
+ */
+int zynpu_session_add_buf(struct zynpu_session *session, struct buf_request *buf_req,
+	struct zynpu_buffer *buf);
+/*
+ * @brief remove an allocated buffer of this session
+ *
+ * @param session: session pointer
+ * @param buf: buffer to be removed
+ *
+ * @return ZYNPU_KMD_ERR_OK if successful; others if failed.
+ */
+int zynpu_session_detach_buf(struct zynpu_session *session, struct buf_desc *buf);
+/*
+ * @brief mmap an allocated buffer of this session
+ *
+ * @param session: session pointer
+ * @param vma: vm_area_struct
+ * @param dev: device struct
+ *
+ * @return ZYNPU_KMD_ERR_OK if successful; others if failed.
+ */
+int zynpu_session_mmap_buf(struct zynpu_session *session, struct vm_area_struct *vma, struct device *dev);
+/*
+ * @brief get first valid buffer descriptor of this session
+ *
+ * @param session: session pointer
+ *
+ * @return buffer if successful; NULL if failed.
+ */
+struct zynpu_buffer * zynpu_get_session_sbuf_head(struct zynpu_session *session);
+/*
+ * @brief add a job descriptor of this session
+ *
+ * @param session: session pointer
+ * @param user_job: userspace job descriptor pointer
+ *
+ * @return non-NULL kernel job ptr if successful; NULL if failed.
+ */
+struct session_job * zynpu_session_add_job(struct zynpu_session *session, struct user_job *user_job);
+/*
+ * @brief delete all jobs of a session
+ *
+ * @param session: session pointer
+ *
+ * @return ZYNPU_KMD_ERR_OK if successful; others if failed.
+ */
+int zynpu_session_delete_jobs(struct zynpu_session *session);
+/*
+ * @brief job done interrupt bottom half handler
+ *
+ * @param session: session pointer
+ * @param job: session job pointer
+ * @param excep_flag: exception flag
+ *
+ */
+void zynpu_session_job_done(struct zynpu_session *session, struct session_job *job,
+	int excep_flag);
+/*
+ * @brief update bandwidth profiling data after job done
+ *
+ * @param session: session pointer
+ * @param job: session job pointer
+ *
+ */
+//void zynpu_session_job_update_pdata(struct zynpu_session *session, struct session_job *job);
+/*
+ * @brief check if any scheduled job of the specified thread is done/exception
+ *
+ * @param session: session pointer
+ * @param uthread_id: user thread ID
+ *
+ * @return 1 if has don job(s); 0 if no.
+ */
+int zynpu_session_thread_has_end_job(struct zynpu_session *session, int uthread_id);
+/*
+ * @brief get one or multiple end jobs' status
+ *
+ * @param session: session pointer
+ * @param job_status: job status query struct
+ *
+ * @return 1 if has don job(s); 0 if no.
+ */
+int zynpu_session_get_job_status(struct zynpu_session *session, struct job_status_query *job_status);
+/*
+ * @brief add waitqueue into session thread waitqueue list
+ *
+ * @param session: session pointer
+ * @param filp: file struct from file operation API
+ * @param wait: wait struct from poll file operation API
+ * @param uthread_id: user thread ID
+ *
+ */
+void zynpu_session_add_poll_wait_queue(struct zynpu_session *session,
+    struct file *filp, struct poll_table_struct *wait, int uthread_id);
+/*
+ * @brief mark the scheduled time of a job
+ *
+ * @param job: session job pointer
+ */
+void session_job_mark_sched(struct session_job *job);
+/*
+ * @brief mark the done time of a job
+ *
+ * @param job: session job pointer
+ */
+void session_job_mark_done(struct session_job *job);
+/*
+ * @brief check if a job is enabled to do profiling
+ *
+ * @param job: session job pointer
+ */
+int is_session_job_prof_enabled(struct session_job *job);
+
+#endif //_ZYNPU_SESSION_H_
\ No newline at end of file
diff --git a/drivers/staging/zynpu/zynpu_sysfs.c b/drivers/staging/zynpu/zynpu_sysfs.c
new file mode 100644
index 000000000000..faed1800d7ed
--- /dev/null
+++ b/drivers/staging/zynpu/zynpu_sysfs.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+*
+* Zhouyi AI Accelerator driver
+*
+* Copyright (C) 2020 Arm (China) Ltd.
+* Copyright (C) 2021 Cai Huoqing
+*/
+
+/**
+ * @file zynpu_sysfs.h
+ * sysfs interface implementation file
+ */
+
+#include <linux/device.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include "zynpu.h"
+
+static struct zynpu_priv *zynpu = NULL;
+
+static int print_reg_info(char *buf, const char *name, int offset)
+{
+	struct zynpu_io_req io_req;
+
+	if (!zynpu)
+		return 0;
+
+	io_req.rw = ZYNPU_IO_READ;
+	io_req.offset = offset;
+	zynpu_priv_io_rw(zynpu, &io_req);
+	return snprintf(buf, 1024, "0x%-*x%-*s0x%08x\n", 6, offset, 22, name, io_req.value);
+}
+
+static ssize_t sysfs_zynpu_ext_register_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	int ret = 0;
+	char tmp[1024];
+
+	if (!zynpu)
+		return 0;
+
+	ret += snprintf(tmp, 1024, "   ZYNPU External Register Values\n");
+	strcat(buf, tmp);
+	ret += snprintf(tmp, 1024, "----------------------------------------\n");
+	strcat(buf, tmp);
+	ret += snprintf(tmp, 1024, "%-*s%-*s%-*s\n", 8, "Offset", 22, "Name", 10, "Value");
+	strcat(buf, tmp);
+	ret += snprintf(tmp, 1024, "----------------------------------------\n");
+	strcat(buf, tmp);
+
+	ret += print_reg_info(tmp, "Ctrl Reg", 0x0);
+	strcat(buf, tmp);
+	ret += print_reg_info(tmp, "Status Reg", 0x4);
+	strcat(buf, tmp);
+	ret += print_reg_info(tmp, "Start PC Reg", 0x8);
+	strcat(buf, tmp);
+	ret += print_reg_info(tmp, "Intr PC Reg", 0xC);
+	strcat(buf, tmp);
+	ret += print_reg_info(tmp, "IPI Ctrl Reg", 0x10);
+	strcat(buf, tmp);
+	ret += print_reg_info(tmp, "Data Addr 0 Reg", 0x14);
+	strcat(buf, tmp);
+	ret += print_reg_info(tmp, "Data Addr 1 Reg", 0x18);
+	strcat(buf, tmp);
+	if (zynpu_priv_get_version(zynpu) == ZYNPU_VERSION_ZHOUYI_V1) {
+		ret += print_reg_info(tmp, "Intr Cause Reg", 0x1C);
+		strcat(buf, tmp);
+		ret += print_reg_info(tmp, "Intr Status Reg", 0x20);
+		strcat(buf, tmp);
+	} else if (zynpu_priv_get_version(zynpu) == ZYNPU_VERSION_ZHOUYI_V2) {
+		ret += print_reg_info(tmp, "Data Addr 2 Reg", 0x1C);
+		strcat(buf, tmp);
+		ret += print_reg_info(tmp, "Data Addr 3 Reg", 0x20);
+		strcat(buf, tmp);
+		ret += print_reg_info(tmp, "ASE0 Ctrl Reg", 0xc0);
+		strcat(buf, tmp);
+		ret += print_reg_info(tmp, "ASE0 High Base Reg", 0xc4);
+		strcat(buf, tmp);
+		ret += print_reg_info(tmp, "ASE0 Low Base Reg", 0xc8);
+		strcat(buf, tmp);
+		ret += print_reg_info(tmp, "ASE1 Ctrl Reg", 0xcc);
+		strcat(buf, tmp);
+		ret += print_reg_info(tmp, "ASE1 High Base Reg", 0xd0);
+		strcat(buf, tmp);
+		ret += print_reg_info(tmp, "ASE1 Low Base Reg", 0xd4);
+		strcat(buf, tmp);
+		ret += print_reg_info(tmp, "ASE2 Ctrl Reg", 0xd8);
+		strcat(buf, tmp);
+		ret += print_reg_info(tmp, "ASE2 High Base Reg", 0xdc);
+		strcat(buf, tmp);
+		ret += print_reg_info(tmp, "ASE2 Low Base Reg", 0xe0);
+		strcat(buf, tmp);
+		ret += print_reg_info(tmp, "ASE3 Ctrl Reg", 0xe4);
+		strcat(buf, tmp);
+		ret += print_reg_info(tmp, "ASE3 High Base Reg", 0xe8);
+		strcat(buf, tmp);
+		ret += print_reg_info(tmp, "ASE3 Low Base Reg", 0xec);
+		strcat(buf, tmp);
+	}
+	ret += snprintf(tmp, 1024, "----------------------------------------\n");
+	strcat(buf, tmp);
+	return ret;
+}
+
+static ssize_t sysfs_zynpu_ext_register_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	int i = 0;
+	int ret = 0;
+	char *token = NULL;
+	char *buf_dup = NULL;
+	int value[3] = { 0 };
+	int max_offset = 0;
+	struct zynpu_io_req io_req;
+	zynpu_priv_io_rw(zynpu, &io_req);
+
+	if (!zynpu)
+		return 0;
+
+	if (zynpu->is_suspend)
+		return 0;
+
+	buf_dup = (char *)kzalloc(1024, GFP_KERNEL);
+	snprintf(buf_dup, 1024, buf);
+
+	dev_dbg(dev, "[SYSFS] user input str: %s", buf_dup);
+
+	for (i = 0; i < 3; i++) {
+		token = strsep(&buf_dup, "-");
+		if (token == NULL) {
+			dev_err(dev, "[SYSFS] please echo as this format: <reg_offset>-<write time>-<write value>");
+			goto finish;
+		}
+
+		dev_dbg(dev, "[SYSFS] to convert str: %s", token);
+
+		ret = kstrtouint(token, 0, &value[i]);
+		if (ret) {
+			dev_err(dev, "[SYSFS] convert str to int failed (%d): %s", ret, token);
+			goto finish;
+		}
+	}
+
+	if (zynpu_priv_get_version(zynpu) == ZYNPU_VERSION_ZHOUYI_V1)
+		max_offset = 0x20;
+	else if (zynpu_priv_get_version(zynpu) == ZYNPU_VERSION_ZHOUYI_V2)
+		max_offset = 0xec;
+
+	if (value[0] > max_offset) {
+		dev_err(dev, "[SYSFS] register offset too large which cannot be write: 0x%x", value[0]);
+		goto finish;
+	}
+
+	dev_info(dev, "[SYSFS] offset 0x%x, time 0x%x, value 0x%x",
+	       value[0], value[1], value[2]);
+
+	io_req.rw = ZYNPU_IO_WRITE;
+	io_req.offset = value[0];
+	io_req.value = value[2];
+	for (i = 0; i < value[1]; i++) {
+		dev_info(dev, "[SYSFS] writing register 0x%x with value 0x%x", value[0], value[2]);
+		zynpu_priv_io_rw(zynpu, &io_req);
+	}
+
+finish:
+	return count;
+}
+
+static ssize_t sysfs_zynpu_job_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	if (!zynpu)
+		return 0;
+
+	return zynpu_job_manager_sysfs_job_show(&zynpu->job_manager, buf);
+}
+
+static DEVICE_ATTR(ext_register, 0644, sysfs_zynpu_ext_register_show, sysfs_zynpu_ext_register_store);
+static DEVICE_ATTR(job, 0444, sysfs_zynpu_job_show, NULL);
+
+int zynpu_create_sysfs(void *zynpu_priv)
+{
+	int ret = 0;
+
+	if (!zynpu_priv)
+		return -EINVAL;
+	zynpu = (struct zynpu_priv *)zynpu_priv;
+
+	device_create_file(zynpu->dev, &dev_attr_ext_register);
+	device_create_file(zynpu->dev, &dev_attr_job);
+
+	return ret;
+}
+
+void zynpu_destroy_sysfs(void *zynpu_priv)
+{
+	if (!zynpu_priv)
+		return;
+
+	device_remove_file(zynpu->dev, &dev_attr_ext_register);
+	device_remove_file(zynpu->dev, &dev_attr_job);
+
+	zynpu = NULL;
+}
-- 
2.25.1

