Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A357B435BFC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 09:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhJUHmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 03:42:49 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:48995 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhJUHmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 03:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1634802010; x=1666338010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=XlHS7RkDidcejvawrIoMJMo619oA9BA/quUzgDc2BKw=;
  b=jS6rtBcfMhn6/rhzBvYmKnsHA3H4yB/2me5oU9tOUzFGFTXY4BIcx91n
   jethIiUfucpfkFGO5eazTEVtQ62jmZ3FKHZPzOYaLtTgqllBknEq9CyF4
   nr/GZJ2XuAk9UkavY66oEni5lB7i1+O/nEmo8IcMTWdcFwkzdQFf9xGNT
   A=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 21 Oct 2021 00:40:10 -0700
X-QCInternal: smtphost
Received: from nalasex01c.na.qualcomm.com ([10.47.97.35])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 00:40:10 -0700
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Thu, 21 Oct 2021 00:40:06 -0700
From:   Tao Zhang <quic_taozha@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     Tao Zhang <quic_taozha@quicinc.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>
Subject: [PATCH 09/10] coresight: Add driver to support Coresight device TPDA
Date:   Thu, 21 Oct 2021 15:38:55 +0800
Message-ID: <1634801936-15080-10-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634801936-15080-1-git-send-email-quic_taozha@quicinc.com>
References: <1634801936-15080-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver to support Coresight device TPDA. This driver provides
support for configuring aggregator. This is primarily useful for
pulling the data sets from one or more attached monitors and
pushing the resultant data out. Multiple monitors are connected on
different input ports of TPDA.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 .../bindings/arm/coresight-tpda.yaml          | 169 ++++
 MAINTAINERS                                   |   3 +-
 drivers/hwtracing/coresight/Kconfig           |   9 +
 drivers/hwtracing/coresight/Makefile          |   1 +
 drivers/hwtracing/coresight/coresight-tpda.c  | 828 ++++++++++++++++++
 5 files changed, 1009 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/coresight-tpda.yaml
 create mode 100644 drivers/hwtracing/coresight/coresight-tpda.c

diff --git a/Documentation/devicetree/bindings/arm/coresight-tpda.yaml b/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
new file mode 100644
index 000000000000..860e86d460b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
@@ -0,0 +1,169 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/coresigh-tpda.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: "Trace, Profiling and Diagnostics Aggregator - TPDA"
+
+maintainers:
+  - Tao Zhang <quic_taozha@quicinc.com>
+
+description:
+  TPDAs are responsible for:
+    Packetization and timestamping of data sets utilizing the MIPI STPv2 packet protocol
+    Pulling data sets from one or more attached TPDM and pushing the resultant (packetized) data out a master ATB interface
+    Performing an arbitrated ATB interleaving (funneling) task for free-flowing data from TPDM (i.e. CMB and DSB data set flows)
+
+properties:
+  $nodename:
+    pattern: "^tpda(@[0-9a-f]+)$"
+
+  compatible:
+    items:
+      const: arm,primecell
+
+  reg:
+    maxItems: 1
+
+  reg-names:
+    items:
+      const: tpda-base
+
+  qcom,tpda-atid:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    maxItems: 1
+    description:
+      Use the ATID field for trace source identification. This allows multiple TPDMs to be interleaved
+      and formatted via the Coresight trace formatter framing protocol and de-formatted/parsed on a host or debugger.
+
+  qcom,bc-elem-size:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    description:
+      Specifies the BC element size supported by each monitor connected to the aggregator on each port.
+
+  qcom,tc-elem-size:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    description:
+      Specifies the TC element size supported by each monitor connected to the aggregator on each port.
+
+  qcom,dsb-elem-size:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    description:
+      Specifies the DSB element size supported by each monitor connected to the aggregator on each port.
+
+  qcom,cmb-elem-size:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    description:
+      Specifies the CMB element size supported by each monitor connected to the aggregator on each port.
+
+  clocks:
+    description:
+      The clock node that QDSS components need to use.
+
+  clock-names:
+    items:
+      const: apb_pclk
+
+  in-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    description:
+      Input connections from TPDM to TPDA
+  
+    properties:
+      "#size-cells":
+        const: 0
+
+      "#address-cells":
+        const: 1
+
+    patternProperties:
+      '^port@([0-9]+)$':
+      type: object
+      description:
+        Input connections from TPDM to TPDA
+
+      properties:
+        reg:
+          maxItems: 1
+
+      required:
+        reg
+
+
+  out-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    description:
+      Output connections from the TPDA to legacy CoreSight trace bus.
+   
+    properties:
+     $ref: /schemas/graph.yaml#/properties/port
+     port:
+       description: 
+         Output connection from the TPDA to legacy CoreSight Trace bus.
+       
+
+required:
+    - compatible
+    - reg
+    - reg-names
+    - qcom,tpda-atid:
+    - clocks
+    - clock-names
+    - in-ports
+    - out-ports
+
+additionalProperties: false
+  
+examples:
+  # minimum tpda definition.
+  - |
+    tpda@10004000 {
+       compatible = "arm,primecell";
+    
+       reg = <0x10004000 0x1000>;
+       reg-names = "tpda-base";
+    
+       qcom,tpda-atid = <65>;
+    
+       clocks = <&aoss_qmp>;
+       clock-names = "apb_pclk";
+    
+       in-ports {
+    
+         #address-cells = <1>;
+         #size-cells = <0>;
+    
+         port@1 {
+           reg = <1>;
+           tpda_qdss_1_in_tpdm_spdm: endpoint {
+                 remote-endpoint =
+                    <&tpdm_spdm_out_tpda_qdss_1>;
+            };
+         };
+    
+         port@0 {
+                 reg = <0>;
+                 tpda_qdss_0_in_tpdm_dcc: endpoint {
+                    remote-endpoint =
+                    <&tpdm_dcc_out_tpda_qdss_0>;
+                 };
+              };
+        };
+    
+       out-ports {
+         port {
+                 tpda_qdss_out_funnel_in0: endpoint {
+                    remote-endpoint =
+                    <&funnel_in0_in_tpda_qdss>;
+                  };
+          };
+       };
+    };
+
+...
\ No newline at end of file
diff --git a/MAINTAINERS b/MAINTAINERS
index cabecf760488..71dd4178d4f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15303,9 +15303,10 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ipa/
 
-QCOM CORESIGHT TPDM DRIVER
+QCOM CORESIGHT COMPONENTS DRIVER
 M:	Tao Zhang <quic_taozha@quicinc.com>
 S:	Maintained
+F:	drivers/hwtracing/coresight/coresight-tpda.c
 F:	drivers/hwtracing/coresight/coresight-tpdm.c
 
 QEMU MACHINE EMULATOR AND VIRTUALIZER SUPPORT
diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index abe244a968f6..206a27325bd3 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -197,4 +197,13 @@ config CORESIGHT_TPDM
 	  primarily responsible for data set collection and support the
 	  ability to collect any permutation of data set types. Monitors are
 	  also responsible for interaction with system cross triggering.
+
+config CORESIGHT_TPDA
+	tristate "CoreSight Trace, Profiling & Diagnostics Aggregator driver"
+	select CORESIGHT_LINKS_AND_SINKS
+	help
+	  This driver provides support for configuring aggregator. This is
+	  primarily useful for pulling the data sets from one or more
+	  attached monitors and pushing the resultant data out. Multiple
+	  monitors are connected on different input ports of TPDA.
 endif
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index e7392a0dddeb..cd8079ec276d 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -26,5 +26,6 @@ obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
 obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o
 obj-$(CONFIG_CORESIGHT_TRBE) += coresight-trbe.o
 obj-$(CONFIG_CORESIGHT_TPDM) += coresight-tpdm.o
+obj-$(CONFIG_CORESIGHT_TPDA) += coresight-tpda.o
 coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
 		   coresight-cti-sysfs.o
diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
new file mode 100644
index 000000000000..3dc46e173be4
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -0,0 +1,828 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/amba/bus.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/bitmap.h>
+#include <linux/of.h>
+#include <linux/coresight.h>
+
+#include "coresight-priv.h"
+
+#define tpda_writel(drvdata, val, off)	__raw_writel((val), drvdata->base + off)
+#define tpda_readl(drvdata, off)	__raw_readl(drvdata->base + off)
+
+#define TPDA_LOCK(drvdata)						\
+do {									\
+	mb(); /* ensure configuration take effect before we lock it */	\
+	tpda_writel(drvdata, 0x0, CORESIGHT_LAR);			\
+} while (0)
+#define TPDA_UNLOCK(drvdata)						\
+do {									\
+	tpda_writel(drvdata, CORESIGHT_UNLOCK, CORESIGHT_LAR);		\
+	mb(); /* ensure unlock take effect before we configure */	\
+} while (0)
+
+#define TPDA_CR			(0x000)
+#define TPDA_Pn_CR(n)		(0x004 + (n * 4))
+#define TPDA_FPID_CR		(0x084)
+#define TPDA_FREQREQ_VAL	(0x088)
+#define TPDA_SYNCR		(0x08C)
+#define TPDA_FLUSH_CR		(0x090)
+#define TPDA_FLUSH_SR		(0x094)
+#define TPDA_FLUSH_ERR		(0x098)
+
+#define TPDA_MAX_INPORTS	32
+
+DEFINE_CORESIGHT_DEVLIST(tpda_devs, "tpda");
+
+struct tpda_drvdata {
+	void __iomem		*base;
+	struct device		*dev;
+	struct coresight_device	*csdev;
+	struct mutex		lock;
+	bool			enable;
+	uint32_t		atid;
+	uint32_t		bc_esize[TPDA_MAX_INPORTS];
+	uint32_t		tc_esize[TPDA_MAX_INPORTS];
+	uint32_t		dsb_esize[TPDA_MAX_INPORTS];
+	uint32_t		cmb_esize[TPDA_MAX_INPORTS];
+	bool			trig_async;
+	bool			trig_flag_ts;
+	bool			trig_freq;
+	bool			freq_ts;
+	uint32_t		freq_req_val;
+	bool			freq_req;
+	bool			cmbchan_mode;
+};
+
+static void __tpda_enable_pre_port(struct tpda_drvdata *drvdata)
+{
+	uint32_t val;
+
+	val = tpda_readl(drvdata, TPDA_CR);
+	/* Set the master id */
+	val = val & ~(0x7F << 13);
+	val = val & ~(0x7F << 6);
+	val |= (drvdata->atid << 6);
+	if (drvdata->trig_async)
+		val = val | BIT(5);
+	else
+		val = val & ~BIT(5);
+	if (drvdata->trig_flag_ts)
+		val = val | BIT(4);
+	else
+		val = val & ~BIT(4);
+	if (drvdata->trig_freq)
+		val = val | BIT(3);
+	else
+		val = val & ~BIT(3);
+	if (drvdata->freq_ts)
+		val = val | BIT(2);
+	else
+		val = val & ~BIT(2);
+	if (drvdata->cmbchan_mode)
+		val = val | BIT(20);
+	else
+		val = val & ~BIT(20);
+	tpda_writel(drvdata, val, TPDA_CR);
+
+	/*
+	 * If FLRIE bit is set, set the master and channel
+	 * id as zero
+	 */
+	if (BMVAL(tpda_readl(drvdata, TPDA_CR), 4, 4))
+		tpda_writel(drvdata, 0x0, TPDA_FPID_CR);
+}
+
+static void __tpda_enable_port(struct tpda_drvdata *drvdata, int port)
+{
+	uint32_t val;
+
+	val = tpda_readl(drvdata, TPDA_Pn_CR(port));
+	if (drvdata->bc_esize[port] == 32)
+		val = val & ~BIT(4);
+	else if (drvdata->bc_esize[port] == 64)
+		val = val | BIT(4);
+
+	if (drvdata->tc_esize[port] == 32)
+		val = val & ~BIT(5);
+	else if (drvdata->tc_esize[port] == 64)
+		val = val | BIT(5);
+
+	if (drvdata->dsb_esize[port] == 32)
+		val = val & ~BIT(8);
+	else if (drvdata->dsb_esize[port] == 64)
+		val = val | BIT(8);
+
+	val = val & ~(0x3 << 6);
+	if (drvdata->cmb_esize[port] == 8)
+		val &= ~(0x3 << 6);
+	else if (drvdata->cmb_esize[port] == 32)
+		val |= (0x1 << 6);
+	else if (drvdata->cmb_esize[port] == 64)
+		val |= (0x2 << 6);
+
+	/* Set the hold time */
+	val = val & ~(0x7 << 1);
+	val |= (0x5 << 1);
+	tpda_writel(drvdata, val, TPDA_Pn_CR(port));
+	/* Enable the port */
+	val = val | BIT(0);
+	tpda_writel(drvdata, val, TPDA_Pn_CR(port));
+}
+
+static void __tpda_enable_post_port(struct tpda_drvdata *drvdata)
+{
+	uint32_t val;
+
+	val = tpda_readl(drvdata, TPDA_SYNCR);
+	/* Clear the mode */
+	val = val & ~BIT(12);
+	/* Program the counter value */
+	val = val | 0xFFF;
+	tpda_writel(drvdata, val, TPDA_SYNCR);
+
+	if (drvdata->freq_req_val)
+		tpda_writel(drvdata, drvdata->freq_req_val, TPDA_FREQREQ_VAL);
+	else
+		tpda_writel(drvdata, 0x0, TPDA_FREQREQ_VAL);
+
+	val = tpda_readl(drvdata, TPDA_CR);
+	if (drvdata->freq_req)
+		val = val | BIT(1);
+	else
+		val = val & ~BIT(1);
+	tpda_writel(drvdata, val, TPDA_CR);
+}
+
+static void __tpda_enable(struct tpda_drvdata *drvdata, int port)
+{
+	TPDA_UNLOCK(drvdata);
+
+	if (!drvdata->enable)
+		__tpda_enable_pre_port(drvdata);
+
+	__tpda_enable_port(drvdata, port);
+
+	if (!drvdata->enable)
+		__tpda_enable_post_port(drvdata);
+
+	TPDA_LOCK(drvdata);
+}
+
+static int tpda_enable(struct coresight_device *csdev, int inport, int outport)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	mutex_lock(&drvdata->lock);
+	__tpda_enable(drvdata, inport);
+	drvdata->enable = true;
+	mutex_unlock(&drvdata->lock);
+
+	dev_info(drvdata->dev, "TPDA inport %d enabled\n", inport);
+	return 0;
+}
+
+static void __tpda_disable(struct tpda_drvdata *drvdata, int port)
+{
+	uint32_t val;
+
+	TPDA_UNLOCK(drvdata);
+
+	val = tpda_readl(drvdata, TPDA_Pn_CR(port));
+	val = val & ~BIT(0);
+	tpda_writel(drvdata, val, TPDA_Pn_CR(port));
+
+	TPDA_LOCK(drvdata);
+}
+
+static void tpda_disable(struct coresight_device *csdev, int inport,
+			   int outport)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	mutex_lock(&drvdata->lock);
+	__tpda_disable(drvdata, inport);
+	drvdata->enable = false;
+	mutex_unlock(&drvdata->lock);
+
+	dev_info(drvdata->dev, "TPDA inport %d disabled\n", inport);
+}
+
+static const struct coresight_ops_link tpda_link_ops = {
+	.enable		= tpda_enable,
+	.disable	= tpda_disable,
+};
+
+static const struct coresight_ops tpda_cs_ops = {
+	.link_ops	= &tpda_link_ops,
+};
+
+static ssize_t trig_async_enable_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 (unsigned int)drvdata->trig_async);
+}
+
+static ssize_t trig_async_enable_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf,
+					    size_t size)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+
+	mutex_lock(&drvdata->lock);
+	if (val)
+		drvdata->trig_async = true;
+	else
+		drvdata->trig_async = false;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(trig_async_enable);
+
+static ssize_t trig_flag_ts_enable_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 (unsigned int)drvdata->trig_flag_ts);
+}
+
+static ssize_t trig_flag_ts_enable_store(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf,
+					      size_t size)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+
+	mutex_lock(&drvdata->lock);
+	if (val)
+		drvdata->trig_flag_ts = true;
+	else
+		drvdata->trig_flag_ts = false;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(trig_flag_ts_enable);
+
+static ssize_t trig_freq_enable_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 (unsigned int)drvdata->trig_freq);
+}
+
+static ssize_t trig_freq_enable_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf,
+					   size_t size)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+
+	mutex_lock(&drvdata->lock);
+	if (val)
+		drvdata->trig_freq = true;
+	else
+		drvdata->trig_freq = false;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(trig_freq_enable);
+
+static ssize_t freq_ts_enable_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 (unsigned int)drvdata->freq_ts);
+}
+
+static ssize_t freq_ts_enable_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf,
+					 size_t size)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+
+	mutex_lock(&drvdata->lock);
+	if (val)
+		drvdata->freq_ts = true;
+	else
+		drvdata->freq_ts = false;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(freq_ts_enable);
+
+static ssize_t freq_req_val_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val = drvdata->freq_req_val;
+
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t freq_req_val_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf,
+				       size_t size)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+
+	mutex_lock(&drvdata->lock);
+	drvdata->freq_req_val = val;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(freq_req_val);
+
+static ssize_t freq_req_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 (unsigned int)drvdata->freq_req);
+}
+
+static ssize_t freq_req_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf,
+				   size_t size)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+
+	mutex_lock(&drvdata->lock);
+	if (val)
+		drvdata->freq_req = true;
+	else
+		drvdata->freq_req = false;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(freq_req);
+
+static ssize_t global_flush_req_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	mutex_lock(&drvdata->lock);
+
+	if (!drvdata->enable) {
+		mutex_unlock(&drvdata->lock);
+		return -EPERM;
+	}
+
+	TPDA_UNLOCK(drvdata);
+	val = tpda_readl(drvdata, TPDA_CR);
+	TPDA_LOCK(drvdata);
+
+	mutex_unlock(&drvdata->lock);
+	return scnprintf(buf, PAGE_SIZE, "%lx\n", val);
+}
+
+static ssize_t global_flush_req_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf,
+					   size_t size)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+
+	mutex_lock(&drvdata->lock);
+
+	if (!drvdata->enable) {
+		mutex_unlock(&drvdata->lock);
+		return -EPERM;
+	}
+
+	if (val) {
+		TPDA_UNLOCK(drvdata);
+		val = tpda_readl(drvdata, TPDA_CR);
+		val = val | BIT(0);
+		tpda_writel(drvdata, val, TPDA_CR);
+		TPDA_LOCK(drvdata);
+	}
+
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(global_flush_req);
+
+static ssize_t port_flush_req_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	mutex_lock(&drvdata->lock);
+
+	if (!drvdata->enable) {
+		mutex_unlock(&drvdata->lock);
+		return -EPERM;
+	}
+
+	TPDA_UNLOCK(drvdata);
+	val = tpda_readl(drvdata, TPDA_FLUSH_CR);
+	TPDA_LOCK(drvdata);
+
+	mutex_unlock(&drvdata->lock);
+	return scnprintf(buf, PAGE_SIZE, "%lx\n", val);
+}
+
+static ssize_t port_flush_req_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf,
+					 size_t size)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+
+	mutex_lock(&drvdata->lock);
+
+	if (!drvdata->enable) {
+		mutex_unlock(&drvdata->lock);
+		return -EPERM;
+	}
+
+	if (val) {
+		TPDA_UNLOCK(drvdata);
+		tpda_writel(drvdata, val, TPDA_FLUSH_CR);
+		TPDA_LOCK(drvdata);
+	}
+
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(port_flush_req);
+
+static ssize_t cmbchan_mode_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 (unsigned int)drvdata->cmbchan_mode);
+}
+
+static ssize_t cmbchan_mode_store(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf,
+					      size_t size)
+{
+	struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	bool val;
+
+	if (kstrtobool(buf, &val))
+		return -EINVAL;
+
+	mutex_lock(&drvdata->lock);
+	if (val)
+		drvdata->cmbchan_mode = true;
+	else
+		drvdata->cmbchan_mode = false;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(cmbchan_mode);
+
+static struct attribute *tpda_attrs[] = {
+	&dev_attr_trig_async_enable.attr,
+	&dev_attr_trig_flag_ts_enable.attr,
+	&dev_attr_trig_freq_enable.attr,
+	&dev_attr_freq_ts_enable.attr,
+	&dev_attr_freq_req_val.attr,
+	&dev_attr_freq_req.attr,
+	&dev_attr_global_flush_req.attr,
+	&dev_attr_port_flush_req.attr,
+	&dev_attr_cmbchan_mode.attr,
+	NULL,
+};
+
+static struct attribute_group tpda_attr_grp = {
+	.attrs = tpda_attrs,
+};
+
+static const struct attribute_group *tpda_attr_grps[] = {
+	&tpda_attr_grp,
+	NULL,
+};
+
+static int tpda_parse_tc(struct tpda_drvdata *drvdata)
+{
+	int len, port, i;
+	const __be32 *prop;
+	struct device_node *node = drvdata->dev->of_node;
+
+	prop = of_get_property(node, "qcom,tc-elem-size", &len);
+	if (prop) {
+		len /= sizeof(__be32);
+		if (len < 2 || len > 63 || len % 2 != 0) {
+			dev_err(drvdata->dev,
+				"Dataset TC width entries are wrong\n");
+			return -EINVAL;
+		}
+
+		for (i = 0; i < len; i++) {
+			port = be32_to_cpu(prop[i++]);
+			if (port >= TPDA_MAX_INPORTS) {
+				dev_err(drvdata->dev,
+					"Wrong port specified for TC\n");
+				return -EINVAL;
+			}
+			drvdata->tc_esize[port] = be32_to_cpu(prop[i]);
+		}
+	}
+
+	return 0;
+}
+
+static int tpda_parse_bc(struct tpda_drvdata *drvdata)
+{
+	int len, port, i;
+	const __be32 *prop;
+	struct device_node *node = drvdata->dev->of_node;
+
+	prop = of_get_property(node, "qcom,bc-elem-size", &len);
+	if (prop) {
+		len /= sizeof(__be32);
+		if (len < 2 || len > 63 || len % 2 != 0) {
+			dev_err(drvdata->dev,
+				"Dataset BC width entries are wrong\n");
+			return -EINVAL;
+		}
+
+		for (i = 0; i < len; i++) {
+			port = be32_to_cpu(prop[i++]);
+			if (port >= TPDA_MAX_INPORTS) {
+				dev_err(drvdata->dev,
+					"Wrong port specified for BC\n");
+				return -EINVAL;
+			}
+			drvdata->bc_esize[port] = be32_to_cpu(prop[i]);
+		}
+	}
+
+	return 0;
+}
+
+static int tpda_parse_dsb(struct tpda_drvdata *drvdata)
+{
+	int len, port, i;
+	const __be32 *prop;
+	struct device_node *node = drvdata->dev->of_node;
+
+	prop = of_get_property(node, "qcom,dsb-elem-size", &len);
+	if (prop) {
+		len /= sizeof(__be32);
+		if (len < 2 || len > 63 || len % 2 != 0) {
+			dev_err(drvdata->dev,
+				"Dataset DSB width entries are wrong\n");
+			return -EINVAL;
+		}
+
+		for (i = 0; i < len; i++) {
+			port = be32_to_cpu(prop[i++]);
+			if (port >= TPDA_MAX_INPORTS) {
+				dev_err(drvdata->dev,
+					"Wrong port specified for DSB\n");
+				return -EINVAL;
+			}
+			drvdata->dsb_esize[port] = be32_to_cpu(prop[i]);
+		}
+	}
+
+	return 0;
+}
+
+static int tpda_parse_cmb(struct tpda_drvdata *drvdata)
+{
+	int len, port, i;
+	const __be32 *prop;
+	struct device_node *node = drvdata->dev->of_node;
+
+	prop = of_get_property(node, "qcom,cmb-elem-size", &len);
+	if (prop) {
+		len /= sizeof(__be32);
+		if (len < 2 || len > 63 || len % 2 != 0) {
+			dev_err(drvdata->dev,
+				"Dataset CMB width entries are wrong\n");
+			return -EINVAL;
+		}
+
+		for (i = 0; i < len; i++) {
+			port = be32_to_cpu(prop[i++]);
+			if (port >= TPDA_MAX_INPORTS) {
+				dev_err(drvdata->dev,
+					"Wrong port specified for CMB\n");
+				return -EINVAL;
+			}
+			drvdata->cmb_esize[port] = be32_to_cpu(prop[i]);
+		}
+	}
+
+	return 0;
+}
+
+static int tpda_parse_of_data(struct tpda_drvdata *drvdata)
+{
+	int ret;
+	struct device_node *node = drvdata->dev->of_node;
+
+	ret = of_property_read_u32(node, "qcom,tpda-atid", &drvdata->atid);
+	if (ret) {
+		dev_err(drvdata->dev, "TPDA ATID is not specified\n");
+		return -EINVAL;
+	}
+
+	ret = tpda_parse_tc(drvdata);
+	if (ret) {
+		dev_err(drvdata->dev, "Dataset TC width entries are wrong\n");
+		return -EINVAL;
+	}
+
+	ret = tpda_parse_bc(drvdata);
+	if (ret) {
+		dev_err(drvdata->dev, "Dataset BC width entries are wrong\n");
+		return -EINVAL;
+	}
+
+	ret = tpda_parse_dsb(drvdata);
+	if (ret) {
+		dev_err(drvdata->dev, "Dataset DSB width entries are wrong\n");
+		return -EINVAL;
+	}
+
+	ret = tpda_parse_cmb(drvdata);
+	if (ret) {
+		dev_err(drvdata->dev, "Dataset CMB width entries are wrong\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void tpda_init_default_data(struct tpda_drvdata *drvdata)
+{
+	drvdata->freq_ts = true;
+}
+
+static bool coresight_authstatus_enabled(void __iomem *addr)
+{
+	int ret;
+	unsigned int auth_val;
+
+	if (!addr)
+		return false;
+
+	auth_val = readl_relaxed(addr + CORESIGHT_AUTHSTATUS);
+
+	if ((BMVAL(auth_val, 0, 1) == 0x2) ||
+		(BMVAL(auth_val, 2, 3) == 0x2) ||
+		(BMVAL(auth_val, 4, 5) == 0x2) ||
+		(BMVAL(auth_val, 6, 7) == 0x2))
+		ret = false;
+	else
+		ret = true;
+
+	return ret;
+}
+
+static int tpda_probe(struct amba_device *adev, const struct amba_id *id)
+{
+	int ret;
+	struct device *dev = &adev->dev;
+	struct coresight_platform_data *pdata;
+	struct tpda_drvdata *drvdata;
+	struct coresight_desc desc = { 0 };
+
+	desc.name = coresight_alloc_device_name(&tpda_devs, dev);
+	if (!desc.name)
+		return -ENOMEM;
+	pdata = coresight_get_platform_data(dev);
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
+	adev->dev.platform_data = pdata;
+
+	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	drvdata->dev = &adev->dev;
+	dev_set_drvdata(dev, drvdata);
+
+	drvdata->base = devm_ioremap_resource(dev, &adev->res);
+	if (!drvdata->base)
+		return -ENOMEM;
+
+	mutex_init(&drvdata->lock);
+
+	ret = tpda_parse_of_data(drvdata);
+	if (ret)
+		return ret;
+
+	if (!coresight_authstatus_enabled(drvdata->base))
+		goto err;
+
+	tpda_init_default_data(drvdata);
+
+	desc.type = CORESIGHT_DEV_TYPE_LINK;
+	desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_MERG;
+	desc.ops = &tpda_cs_ops;
+	desc.pdata = adev->dev.platform_data;
+	desc.dev = &adev->dev;
+	desc.groups = tpda_attr_grps;
+	drvdata->csdev = coresight_register(&desc);
+	if (IS_ERR(drvdata->csdev))
+		return PTR_ERR(drvdata->csdev);
+
+	pm_runtime_put(&adev->dev);
+
+	dev_dbg(drvdata->dev, "TPDA initialized\n");
+	return 0;
+err:
+	return -EPERM;
+}
+
+static struct amba_id tpda_ids[] = {
+	{
+		.id     = 0x000f0f00,
+		.mask   = 0x000fff00,
+		.data	= "TPDA",
+	},
+	{ 0, 0},
+};
+
+static struct amba_driver tpda_driver = {
+	.drv = {
+		.name   = "coresight-tpda",
+		.owner	= THIS_MODULE,
+		.suppress_bind_attrs = true,
+	},
+	.probe          = tpda_probe,
+	.id_table	= tpda_ids,
+};
+
+module_amba_driver(tpda_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Trace, Profiling & Diagnostic Aggregator driver");
-- 
2.17.1

