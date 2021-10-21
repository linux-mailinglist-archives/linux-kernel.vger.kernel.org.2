Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494D3435BED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 09:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhJUHmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 03:42:20 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:42703 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbhJUHmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 03:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1634801998; x=1666337998;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=nQ1B/2pXcJg/+FgZI2xto8t+wrsmMgekSvc1/gqERXo=;
  b=XLbAQO1vUbRoW6WpkXbuw9gzkWfNHoDc1Iv6OhORskbjUyEkZNHWFDur
   4zC+O5ERnr8C8372CCsDJH6pPYngJmRJbw2y2/2epOVCcv+54z6HQJ1yl
   jHZyl18yzTAaygRiGM2mzhXKv1f7UJRAUlwJ1DGDRgL2WfyLfqtAWxf41
   8=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 21 Oct 2021 00:39:58 -0700
X-QCInternal: smtphost
Received: from nalasex01c.na.qualcomm.com ([10.47.97.35])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 00:39:58 -0700
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Thu, 21 Oct 2021 00:39:54 -0700
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
Subject: [PATCH 06/10] Coresight: Enable and add interface for TPDM TC subunit
Date:   Thu, 21 Oct 2021 15:38:52 +0800
Message-ID: <1634801936-15080-7-git-send-email-quic_taozha@quicinc.com>
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

Enable dataset type Tenure Counts(TC) for TPDM. The TC interface
has RW, WO and RO fields for controlling BC dataset elements
transmitted on ATB flush.
The TC data set subunit supports from 1-4 tenure counter instances
where each tenure counter instance is charged with collecting or
computing elements of an STVn data set(MIN, MAX, TAT and GP
Counter 0-7). Computation of data set elements MIN, MAX, and TAT
is performed by the TC subunit by monitoring a pool of 1 to 1024
tenure scratchpad counters. Computation/decoding of increment
enables for GP Counters 0-7 is accomplished via monitoring the
state (TC subunit outputs) of the tenure scratchpad registers.
This computation/decoding must be performed by the core
instancing the TPDM to which the TC subunit belongs.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tpdm.c | 1066 +++++++++++++++++-
 1 file changed, 1029 insertions(+), 37 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 0970c69ac8e2..635382be5de6 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -298,6 +298,17 @@ static void __tpdm_config_bc_msr(struct tpdm_drvdata *drvdata)
 		tpdm_writel(drvdata, drvdata->bc->msr[i], TPDM_BC_MSR(i));
 }
 
+static void __tpdm_config_tc_msr(struct tpdm_drvdata *drvdata)
+{
+	int i;
+
+	if (!drvdata->msr_support)
+		return;
+
+	for (i = 0; i < TPDM_TC_MAX_MSR; i++)
+		tpdm_writel(drvdata, drvdata->tc->msr[i], TPDM_TC_MSR(i));
+}
+
 static void __tpdm_enable_bc(struct tpdm_drvdata *drvdata)
 {
 	int i;
@@ -363,6 +374,66 @@ static void __tpdm_enable_bc(struct tpdm_drvdata *drvdata)
 	tpdm_writel(drvdata, val, TPDM_BC_CR);
 }
 
+static void __tpdm_enable_tc(struct tpdm_drvdata *drvdata)
+{
+	int i;
+	uint32_t val;
+
+	if (drvdata->tc->enable_counters) {
+		tpdm_writel(drvdata, 0xF, TPDM_TC_CNTENCLR);
+		tpdm_writel(drvdata, drvdata->tc->enable_counters,
+			    TPDM_TC_CNTENSET);
+	}
+	if (drvdata->tc->clear_counters)
+		tpdm_writel(drvdata, drvdata->tc->clear_counters,
+			    TPDM_TC_CNTENCLR);
+
+	if (drvdata->tc->enable_irq) {
+		tpdm_writel(drvdata, 0xF, TPDM_TC_INTENCLR);
+		tpdm_writel(drvdata, drvdata->tc->enable_irq,
+			    TPDM_TC_INTENSET);
+	}
+	if (drvdata->tc->clear_irq)
+		tpdm_writel(drvdata, drvdata->tc->clear_irq,
+			    TPDM_TC_INTENCLR);
+
+	if (drvdata->tc_trig_type == TPDM_SUPPORT_TYPE_FULL) {
+		for (i = 0; i < TPDM_TC_MAX_TRIG; i++) {
+			tpdm_writel(drvdata, drvdata->tc->trig_sel[i],
+				    TPDM_TC_TRIG_SEL(i));
+			tpdm_writel(drvdata, drvdata->tc->trig_val_lo[i],
+				    TPDM_TC_TRIG_LO(i));
+			tpdm_writel(drvdata, drvdata->tc->trig_val_hi[i],
+				    TPDM_TC_TRIG_HI(i));
+		}
+	} else if (drvdata->tc_trig_type == TPDM_SUPPORT_TYPE_PARTIAL) {
+		tpdm_writel(drvdata, drvdata->tc->trig_sel[0],
+			    TPDM_TC_TRIG_SEL(0));
+		tpdm_writel(drvdata, drvdata->tc->trig_val_lo[0],
+			    TPDM_TC_TRIG_LO(0));
+		tpdm_writel(drvdata, drvdata->tc->trig_val_hi[0],
+			    TPDM_TC_TRIG_HI(0));
+	}
+
+	__tpdm_config_tc_msr(drvdata);
+
+	val = tpdm_readl(drvdata, TPDM_TC_CR);
+	if (drvdata->tc->sat_mode)
+		val = val | BIT(4);
+	else
+		val = val & ~BIT(4);
+	if (drvdata->tc->retrieval_mode == TPDM_MODE_APB)
+		val = val | BIT(2);
+	else
+		val = val & ~BIT(2);
+	tpdm_writel(drvdata, val, TPDM_TC_CR);
+
+	val = tpdm_readl(drvdata, TPDM_TC_CR);
+	/* Set the enable bit */
+	val = val | BIT(0);
+	tpdm_writel(drvdata, val, TPDM_TC_CR);
+}
+
 static void __tpdm_enable(struct tpdm_drvdata *drvdata)
 {
 	TPDM_UNLOCK(drvdata);
@@ -376,6 +447,9 @@ static void __tpdm_enable(struct tpdm_drvdata *drvdata)
 	if (test_bit(TPDM_DS_BC, drvdata->enable_ds))
 		__tpdm_enable_bc(drvdata);
 
+	if (test_bit(TPDM_DS_TC, drvdata->enable_ds))
+		__tpdm_enable_tc(drvdata);
+
 	TPDM_LOCK(drvdata);
 }
 
@@ -409,6 +483,15 @@ static void __tpdm_disable_bc(struct tpdm_drvdata *drvdata)
 	tpdm_writel(drvdata, config, TPDM_BC_CR);
 }
 
+static void __tpdm_disable_tc(struct tpdm_drvdata *drvdata)
+{
+	uint32_t config;
+
+	config = tpdm_readl(drvdata, TPDM_TC_CR);
+	config = config & ~BIT(0);
+	tpdm_writel(drvdata, config, TPDM_TC_CR);
+}
+
 static void __tpdm_disable(struct tpdm_drvdata *drvdata)
 {
 	TPDM_UNLOCK(drvdata);
@@ -416,6 +499,9 @@ static void __tpdm_disable(struct tpdm_drvdata *drvdata)
 	if (test_bit(TPDM_DS_BC, drvdata->enable_ds))
 		__tpdm_disable_bc(drvdata);
 
+	if (test_bit(TPDM_DS_TC, drvdata->enable_ds))
+		__tpdm_disable_tc(drvdata);
+
 	if (drvdata->clk_enable)
 		tpdm_writel(drvdata, 0x0, TPDM_CLK_CTRL);
 
@@ -1512,49 +1598,955 @@ static ssize_t bc_msr_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(bc_msr);
 
-static struct attribute *tpdm_bc_attrs[] = {
-	&dev_attr_bc_capture_mode.attr,
-	&dev_attr_bc_retrieval_mode.attr,
-	&dev_attr_bc_reset_counters.attr,
-	&dev_attr_bc_sat_mode.attr,
-	&dev_attr_bc_enable_counters.attr,
-	&dev_attr_bc_clear_counters.attr,
-	&dev_attr_bc_enable_irq.attr,
-	&dev_attr_bc_clear_irq.attr,
-	&dev_attr_bc_trig_val_lo.attr,
-	&dev_attr_bc_trig_val_hi.attr,
-	&dev_attr_bc_enable_ganging.attr,
-	&dev_attr_bc_overflow_val.attr,
-	&dev_attr_bc_ovsr.attr,
-	&dev_attr_bc_counter_sel.attr,
-	&dev_attr_bc_count_val_lo.attr,
-	&dev_attr_bc_count_val_hi.attr,
-	&dev_attr_bc_shadow_val_lo.attr,
-	&dev_attr_bc_shadow_val_hi.attr,
-	&dev_attr_bc_sw_inc.attr,
-	&dev_attr_bc_msr.attr,
-	NULL,
-};
+static ssize_t tc_capture_mode_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
-static struct attribute_group tpdm_bc_attr_grp = {
-	.attrs = tpdm_bc_attrs,
-};
+	if (!test_bit(TPDM_DS_TC, drvdata->datasets))
+		return -EPERM;
 
-static struct attribute *tpdm_attrs[] = {
-	&dev_attr_available_datasets.attr,
-	&dev_attr_enable_datasets.attr,
-	&dev_attr_reset.attr,
-	&dev_attr_integration_test.attr,
-	&dev_attr_gp_regs.attr,
-	NULL,
-};
+	return scnprintf(buf, PAGE_SIZE, "%s\n",
+			 drvdata->tc->capture_mode == TPDM_MODE_ATB ?
+			 "ATB" : "APB");
+}
+
+static ssize_t tc_capture_mode_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf,
+					  size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	char str[20] = "";
+	uint32_t val;
+
+	if (size >= 20)
+		return -EINVAL;
+	if (sscanf(buf, "%s", str) != 1)
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_TC, drvdata->enable_ds))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	if (!drvdata->enable) {
+		mutex_unlock(&drvdata->lock);
+		return -EPERM;
+	}
+
+	if (!strcmp(str, "ATB")) {
+		drvdata->tc->capture_mode = TPDM_MODE_ATB;
+	} else if (!strcmp(str, "APB") &&
+		   drvdata->tc->retrieval_mode == TPDM_MODE_APB) {
+
+		TPDM_UNLOCK(drvdata);
+		val = tpdm_readl(drvdata, TPDM_TC_CR);
+		val = val | BIT(3);
+		tpdm_writel(drvdata, val, TPDM_TC_CR);
+		TPDM_LOCK(drvdata);
+
+		drvdata->tc->capture_mode = TPDM_MODE_APB;
+	} else {
+		mutex_unlock(&drvdata->lock);
+		return -EINVAL;
+	}
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(tc_capture_mode);
+
+static ssize_t tc_retrieval_mode_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	if (!test_bit(TPDM_DS_TC, drvdata->datasets))
+		return -EPERM;
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n",
+			 drvdata->tc->retrieval_mode == TPDM_MODE_ATB ?
+			 "ATB" : "APB");
+}
+
+static ssize_t tc_retrieval_mode_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf,
+					    size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	char str[20] = "";
+
+	if (size >= 20)
+		return -EINVAL;
+	if (sscanf(buf, "%s", str) != 1)
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_TC, drvdata->datasets))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	if (drvdata->enable) {
+		mutex_unlock(&drvdata->lock);
+		return -EPERM;
+	}
+
+	if (!strcmp(str, "ATB")) {
+		drvdata->tc->retrieval_mode = TPDM_MODE_ATB;
+	} else if (!strcmp(str, "APB")) {
+		drvdata->tc->retrieval_mode = TPDM_MODE_APB;
+	} else {
+		mutex_unlock(&drvdata->lock);
+		return -EINVAL;
+	}
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(tc_retrieval_mode);
+
+static ssize_t tc_reset_counters_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf,
+					    size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_TC, drvdata->datasets))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	if (!drvdata->enable) {
+		mutex_unlock(&drvdata->lock);
+		return -EPERM;
+	}
+
+	if (val) {
+		TPDM_UNLOCK(drvdata);
+		val = tpdm_readl(drvdata, TPDM_TC_CR);
+		val = val | BIT(1);
+		tpdm_writel(drvdata, val, TPDM_TC_CR);
+		TPDM_LOCK(drvdata);
+	}
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_WO(tc_reset_counters);
+
+static ssize_t tc_sat_mode_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	if (!test_bit(TPDM_DS_TC, drvdata->datasets))
+		return -EPERM;
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 (unsigned int)drvdata->tc->sat_mode);
+}
+
+static ssize_t tc_sat_mode_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf,
+				      size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_TC, drvdata->datasets))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	if (val)
+		drvdata->tc->sat_mode = true;
+	else
+		drvdata->tc->sat_mode = false;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(tc_sat_mode);
+
+static ssize_t tc_enable_counters_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	if (!test_bit(TPDM_DS_TC, drvdata->datasets))
+		return -EPERM;
+
+	return scnprintf(buf, PAGE_SIZE, "%lx\n",
+			 (unsigned long)drvdata->tc->enable_counters);
+}
+
+static ssize_t tc_enable_counters_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf,
+					     size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_TC, drvdata->datasets))
+		return -EPERM;
+	if (val >> drvdata->tc_counters_avail)
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	drvdata->tc->enable_counters = val;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(tc_enable_counters);
+
+static ssize_t tc_clear_counters_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	if (!test_bit(TPDM_DS_TC, drvdata->datasets))
+		return -EPERM;
+
+	return scnprintf(buf, PAGE_SIZE, "%lx\n",
+			 (unsigned long)drvdata->tc->clear_counters);
+}
+
+static ssize_t tc_clear_counters_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf,
+					    size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_TC, drvdata->datasets))
+		return -EPERM;
+	if (val >> drvdata->tc_counters_avail)
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	drvdata->tc->clear_counters = val;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(tc_clear_counters);
+
+static ssize_t tc_enable_irq_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	if (!test_bit(TPDM_DS_TC, drvdata->datasets))
+		return -EPERM;
+
+	return scnprintf(buf, PAGE_SIZE, "%lx\n",
+			 (unsigned long)drvdata->tc->enable_irq);
+}
+
+static ssize_t tc_enable_irq_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_TC, drvdata->datasets))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	drvdata->tc->enable_irq = val;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(tc_enable_irq);
+
+static ssize_t tc_clear_irq_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	if (!test_bit(TPDM_DS_TC, drvdata->datasets))
+		return -EPERM;
+
+	return scnprintf(buf, PAGE_SIZE, "%lx\n",
+			 (unsigned long)drvdata->tc->clear_irq);
+}
+
+static ssize_t tc_clear_irq_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf,
+				       size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_TC, drvdata->datasets))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	drvdata->tc->clear_irq = val;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(tc_clear_irq);
+
+static ssize_t tc_trig_sel_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+	int i = 0;
+
+	if (!test_bit(TPDM_DS_TC, drvdata->datasets))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	for (i = 0; i < TPDM_TC_MAX_TRIG; i++) {
+		size += scnprintf(buf + size, PAGE_SIZE - size,
+				  "Index: 0x%x Value: 0x%x\n", i,
+				  drvdata->tc->trig_sel[i]);
+	}
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+
+static ssize_t tc_trig_sel_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf,
+				      size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long index, val;
+
+	if (sscanf(buf, "%lx %lx", &index, &val) != 2)
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_TC, drvdata->datasets) ||
+	    index >= TPDM_TC_MAX_TRIG ||
+	    drvdata->tc_trig_type == TPDM_SUPPORT_TYPE_NO ||
+	    (drvdata->tc_trig_type == TPDM_SUPPORT_TYPE_PARTIAL && index > 0))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	drvdata->tc->trig_sel[index] = val;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(tc_trig_sel);
+
+static ssize_t tc_trig_val_lo_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+	int i = 0;
+
+	if (!test_bit(TPDM_DS_TC, drvdata->datasets))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	for (i = 0; i < TPDM_TC_MAX_TRIG; i++) {
+		size += scnprintf(buf + size, PAGE_SIZE - size,
+				  "Index: 0x%x Value: 0x%x\n", i,
+				  drvdata->tc->trig_val_lo[i]);
+	}
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+
+static ssize_t tc_trig_val_lo_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf,
+					 size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long index, val;
+
+	if (sscanf(buf, "%lx %lx", &index, &val) != 2)
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_TC, drvdata->datasets) ||
+	    index >= TPDM_TC_MAX_TRIG ||
+	    drvdata->tc_trig_type == TPDM_SUPPORT_TYPE_NO ||
+	    (drvdata->tc_trig_type == TPDM_SUPPORT_TYPE_PARTIAL && index > 0))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	drvdata->tc->trig_val_lo[index] = val;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(tc_trig_val_lo);
+
+static ssize_t tc_trig_val_hi_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+	int i = 0;
+
+	if (!test_bit(TPDM_DS_TC, drvdata->datasets))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	for (i = 0; i < TPDM_TC_MAX_TRIG; i++) {
+		size += scnprintf(buf + size, PAGE_SIZE - size,
+				  "Index: 0x%x Value: 0x%x\n", i,
+				  drvdata->tc->trig_val_hi[i]);
+	}
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+
+static ssize_t tc_trig_val_hi_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf,
+					 size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long index, val;
+
+	if (sscanf(buf, "%lx %lx", &index, &val) != 2)
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_TC, drvdata->datasets) ||
+	    index >= TPDM_TC_MAX_TRIG ||
+	    drvdata->tc_trig_type == TPDM_SUPPORT_TYPE_NO ||
+	    (drvdata->tc_trig_type == TPDM_SUPPORT_TYPE_PARTIAL && index > 0))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	drvdata->tc->trig_val_hi[index] = val;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(tc_trig_val_hi);
+
+static ssize_t tc_ovsr_gp_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (!test_bit(TPDM_DS_TC, drvdata->datasets))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	if (!drvdata->enable) {
+		mutex_unlock(&drvdata->lock);
+		return -EPERM;
+	}
+
+	TPDM_UNLOCK(drvdata);
+	val = tpdm_readl(drvdata, TPDM_TC_OVSR_GP);
+	TPDM_LOCK(drvdata);
+	mutex_unlock(&drvdata->lock);
+	return scnprintf(buf, PAGE_SIZE, "%lx\n", val);
+}
+
+static ssize_t tc_ovsr_gp_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf,
+				     size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_TC, drvdata->enable_ds))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	if (!drvdata->enable) {
+		mutex_unlock(&drvdata->lock);
+		return -EPERM;
+	}
+
+	if (val) {
+		TPDM_UNLOCK(drvdata);
+		tpdm_writel(drvdata, val, TPDM_TC_OVSR_GP);
+		TPDM_LOCK(drvdata);
+	}
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(tc_ovsr_gp);
+
+static ssize_t tc_ovsr_impl_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (!test_bit(TPDM_DS_TC, drvdata->enable_ds))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	if (!drvdata->enable) {
+		mutex_unlock(&drvdata->lock);
+		return -EPERM;
+	}
+
+	TPDM_UNLOCK(drvdata);
+	val = tpdm_readl(drvdata, TPDM_TC_OVSR_IMPL);
+	TPDM_LOCK(drvdata);
+	mutex_unlock(&drvdata->lock);
+	return scnprintf(buf, PAGE_SIZE, "%lx\n", val);
+}
+
+static ssize_t tc_ovsr_impl_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf,
+				       size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_TC, drvdata->enable_ds))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	if (!drvdata->enable) {
+		mutex_unlock(&drvdata->lock);
+		return -EPERM;
+	}
+
+	if (val) {
+		TPDM_UNLOCK(drvdata);
+		tpdm_writel(drvdata, val, TPDM_TC_OVSR_IMPL);
+		TPDM_LOCK(drvdata);
+	}
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(tc_ovsr_impl);
+
+static ssize_t tc_counter_sel_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (!test_bit(TPDM_DS_TC, drvdata->enable_ds))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	if (!drvdata->enable) {
+		mutex_unlock(&drvdata->lock);
+		return -EPERM;
+	}
+
+	TPDM_UNLOCK(drvdata);
+	val = tpdm_readl(drvdata, TPDM_TC_SELR);
+	TPDM_LOCK(drvdata);
+	mutex_unlock(&drvdata->lock);
+	return scnprintf(buf, PAGE_SIZE, "%lx\n", val);
+}
+
+static ssize_t tc_counter_sel_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf,
+					 size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_TC, drvdata->enable_ds))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	if (!drvdata->enable) {
+		mutex_unlock(&drvdata->lock);
+		return -EPERM;
+	}
+
+	TPDM_UNLOCK(drvdata);
+	tpdm_writel(drvdata, val, TPDM_TC_SELR);
+	TPDM_LOCK(drvdata);
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(tc_counter_sel);
+
+static ssize_t tc_count_val_lo_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (!test_bit(TPDM_DS_TC, drvdata->enable_ds))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	if (!drvdata->enable) {
+		mutex_unlock(&drvdata->lock);
+		return -EPERM;
+	}
+
+	TPDM_UNLOCK(drvdata);
+	val = tpdm_readl(drvdata, TPDM_TC_CNTR_LO);
+	TPDM_LOCK(drvdata);
+	mutex_unlock(&drvdata->lock);
+	return scnprintf(buf, PAGE_SIZE, "%lx\n", val);
+}
+
+static ssize_t tc_count_val_lo_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf,
+					  size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val, select;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_TC, drvdata->enable_ds))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	if (!drvdata->enable) {
+		mutex_unlock(&drvdata->lock);
+		return -EPERM;
+	}
+
+	if (val) {
+		TPDM_UNLOCK(drvdata);
+		select = tpdm_readl(drvdata, TPDM_TC_SELR);
+		select = (select >> 11) & 0x3;
+
+		/* Check if selected counter is disabled */
+		if (BMVAL(tpdm_readl(drvdata, TPDM_TC_CNTENSET), select, select)) {
+			mutex_unlock(&drvdata->lock);
+			return -EPERM;
+		}
+
+		tpdm_writel(drvdata, val, TPDM_TC_CNTR_LO);
+		TPDM_LOCK(drvdata);
+	}
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(tc_count_val_lo);
+
+static ssize_t tc_count_val_hi_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (!test_bit(TPDM_DS_TC, drvdata->enable_ds))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	if (!drvdata->enable) {
+		mutex_unlock(&drvdata->lock);
+		return -EPERM;
+	}
+
+	TPDM_UNLOCK(drvdata);
+	val = tpdm_readl(drvdata, TPDM_TC_CNTR_HI);
+	TPDM_LOCK(drvdata);
+	mutex_unlock(&drvdata->lock);
+	return scnprintf(buf, PAGE_SIZE, "%lx\n", val);
+}
+
+static ssize_t tc_count_val_hi_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf,
+					  size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val, select;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_TC, drvdata->enable_ds))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	if (!drvdata->enable) {
+		mutex_unlock(&drvdata->lock);
+		return -EPERM;
+	}
+
+	if (val) {
+		TPDM_UNLOCK(drvdata);
+		select = tpdm_readl(drvdata, TPDM_TC_SELR);
+		select = (select >> 11) & 0x3;
+
+		/* Check if selected counter is disabled */
+		if (BMVAL(tpdm_readl(drvdata, TPDM_TC_CNTENSET), select, select)) {
+			mutex_unlock(&drvdata->lock);
+			return -EPERM;
+		}
+
+		tpdm_writel(drvdata, val, TPDM_TC_CNTR_HI);
+		TPDM_LOCK(drvdata);
+	}
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(tc_count_val_hi);
+
+static ssize_t tc_shadow_val_lo_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+	int i = 0;
+
+	if (!test_bit(TPDM_DS_TC, drvdata->enable_ds))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	if (!drvdata->enable) {
+		mutex_unlock(&drvdata->lock);
+		return -EPERM;
+	}
+
+	TPDM_UNLOCK(drvdata);
+	for (i = 0; i < TPDM_TC_MAX_COUNTERS; i++) {
+		size += scnprintf(buf + size, PAGE_SIZE - size,
+				  "Index: 0x%x Value: 0x%x\n", i,
+				  tpdm_readl(drvdata, TPDM_TC_SHADOW_LO(i)));
+	}
+	TPDM_LOCK(drvdata);
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RO(tc_shadow_val_lo);
+
+static ssize_t tc_shadow_val_hi_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+	int i = 0;
+
+	if (!test_bit(TPDM_DS_TC, drvdata->enable_ds))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	if (!drvdata->enable) {
+		mutex_unlock(&drvdata->lock);
+		return -EPERM;
+	}
+
+	TPDM_UNLOCK(drvdata);
+	for (i = 0; i < TPDM_TC_MAX_COUNTERS; i++) {
+		size += scnprintf(buf + size, PAGE_SIZE - size,
+				  "Index: 0x%x Value: 0x%x\n", i,
+				  tpdm_readl(drvdata, TPDM_TC_SHADOW_HI(i)));
+	}
+	TPDM_LOCK(drvdata);
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RO(tc_shadow_val_hi);
+
+static ssize_t tc_sw_inc_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (!test_bit(TPDM_DS_TC, drvdata->enable_ds))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	if (!drvdata->enable) {
+		mutex_unlock(&drvdata->lock);
+		return -EPERM;
+	}
+
+	TPDM_UNLOCK(drvdata);
+	val = tpdm_readl(drvdata, TPDM_TC_SWINC);
+	TPDM_LOCK(drvdata);
+	mutex_unlock(&drvdata->lock);
+	return scnprintf(buf, PAGE_SIZE, "%lx\n", val);
+}
+
+static ssize_t tc_sw_inc_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf,
+				    size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_TC, drvdata->enable_ds))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	if (!drvdata->enable) {
+		mutex_unlock(&drvdata->lock);
+		return -EPERM;
+	}
+
+	if (val) {
+		TPDM_UNLOCK(drvdata);
+		tpdm_writel(drvdata, val, TPDM_TC_SWINC);
+		TPDM_LOCK(drvdata);
+	}
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(tc_sw_inc);
+
+static ssize_t tc_msr_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned int i;
+	ssize_t len = 0;
+
+	if (!drvdata->msr_support)
+		return -EINVAL;
+
+	if (!test_bit(TPDM_DS_TC, drvdata->datasets))
+		return -EPERM;
+
+	for (i = 0; i < TPDM_TC_MAX_MSR; i++)
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%u 0x%x\n",
+				 i, drvdata->tc->msr[i]);
+
+	return len;
+}
+
+static ssize_t tc_msr_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf,
+				 size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned int num, val;
+	int nval;
+
+	if (!drvdata->msr_support)
+		return -EINVAL;
+
+	if (!test_bit(TPDM_DS_TC, drvdata->datasets))
+		return -EPERM;
+
+	nval = sscanf(buf, "%u %x", &num, &val);
+	if (nval != 2)
+		return -EINVAL;
+
+	if (num >= TPDM_TC_MAX_MSR)
+		return -EINVAL;
+
+	mutex_lock(&drvdata->lock);
+	drvdata->tc->msr[num] = val;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(tc_msr);
+
+static struct attribute *tpdm_bc_attrs[] = {
+	&dev_attr_bc_capture_mode.attr,
+	&dev_attr_bc_retrieval_mode.attr,
+	&dev_attr_bc_reset_counters.attr,
+	&dev_attr_bc_sat_mode.attr,
+	&dev_attr_bc_enable_counters.attr,
+	&dev_attr_bc_clear_counters.attr,
+	&dev_attr_bc_enable_irq.attr,
+	&dev_attr_bc_clear_irq.attr,
+	&dev_attr_bc_trig_val_lo.attr,
+	&dev_attr_bc_trig_val_hi.attr,
+	&dev_attr_bc_enable_ganging.attr,
+	&dev_attr_bc_overflow_val.attr,
+	&dev_attr_bc_ovsr.attr,
+	&dev_attr_bc_counter_sel.attr,
+	&dev_attr_bc_count_val_lo.attr,
+	&dev_attr_bc_count_val_hi.attr,
+	&dev_attr_bc_shadow_val_lo.attr,
+	&dev_attr_bc_shadow_val_hi.attr,
+	&dev_attr_bc_sw_inc.attr,
+	&dev_attr_bc_msr.attr,
+	NULL,
+};
+
+static struct attribute *tpdm_tc_attrs[] = {
+	&dev_attr_tc_capture_mode.attr,
+	&dev_attr_tc_retrieval_mode.attr,
+	&dev_attr_tc_reset_counters.attr,
+	&dev_attr_tc_sat_mode.attr,
+	&dev_attr_tc_enable_counters.attr,
+	&dev_attr_tc_clear_counters.attr,
+	&dev_attr_tc_enable_irq.attr,
+	&dev_attr_tc_clear_irq.attr,
+	&dev_attr_tc_trig_sel.attr,
+	&dev_attr_tc_trig_val_lo.attr,
+	&dev_attr_tc_trig_val_hi.attr,
+	&dev_attr_tc_ovsr_gp.attr,
+	&dev_attr_tc_ovsr_impl.attr,
+	&dev_attr_tc_counter_sel.attr,
+	&dev_attr_tc_count_val_lo.attr,
+	&dev_attr_tc_count_val_hi.attr,
+	&dev_attr_tc_shadow_val_lo.attr,
+	&dev_attr_tc_shadow_val_hi.attr,
+	&dev_attr_tc_sw_inc.attr,
+	&dev_attr_tc_msr.attr,
+	NULL,
+};
+
+static struct attribute_group tpdm_bc_attr_grp = {
+	.attrs = tpdm_bc_attrs,
+};
+
+static struct attribute_group tpdm_tc_attr_grp = {
+	.attrs = tpdm_tc_attrs,
+};
+
+static struct attribute *tpdm_attrs[] = {
+	&dev_attr_available_datasets.attr,
+	&dev_attr_enable_datasets.attr,
+	&dev_attr_reset.attr,
+	&dev_attr_integration_test.attr,
+	&dev_attr_gp_regs.attr,
+	NULL,
+};
+
+static struct attribute_group tpdm_attr_grp = {
+	.attrs = tpdm_attrs,
+};
 
-static struct attribute_group tpdm_attr_grp = {
-	.attrs = tpdm_attrs,
-};
 static const struct attribute_group *tpdm_attr_grps[] = {
 	&tpdm_attr_grp,
 	&tpdm_bc_attr_grp,
+	&tpdm_tc_attr_grp,
 	NULL,
 };
 
-- 
2.17.1

