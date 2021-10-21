Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79AF0435BF1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 09:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhJUHmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 03:42:24 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:48995 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbhJUHmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 03:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1634802002; x=1666338002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=fGltqvKqGu4UMrUXclGB4ik6xX8IF8Fhe3wtc6ntjaY=;
  b=JgBG7ECa89E0NQJGs0m+E+g1D8vvm51j2354c31NIT1S8j09CDAVO59S
   hsDORqiCx7ELxwNVM6rccfpghHTccIG9eqToNxVG5LPRo+R31XSl4B1D6
   MfimZ3t2/iYF4cIhvHGDxEoyuE7Q2k2fL7OmuefF5ps2Bxa0bICTwYoFu
   4=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 21 Oct 2021 00:40:02 -0700
X-QCInternal: smtphost
Received: from nalasex01c.na.qualcomm.com ([10.47.97.35])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 00:40:02 -0700
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Thu, 21 Oct 2021 00:39:58 -0700
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
Subject: [PATCH 07/10] Coresight: Enable DSB subunit for TPDM
Date:   Thu, 21 Oct 2021 15:38:53 +0800
Message-ID: <1634801936-15080-8-git-send-email-quic_taozha@quicinc.com>
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

Enable Discrete Single Bit(DSB) subunit for TPDM. The DSB dataset
elements flow out ATB while the BC/TC dataset elements are sent
only on ATB flush requests from the TPDA.
The DSB data set subunit is responsible for collection of DSB data
sets. The width of the DSB subunit interface must be between 8 and
256 bits. A monitor may support either a 32 or 64 bit DSB data set
element size (e.g. via a hardware parameter).

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tpdm.c | 680 +++++++++++++++++++
 1 file changed, 680 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 635382be5de6..5f07363e4650 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -309,6 +309,17 @@ static void __tpdm_config_tc_msr(struct tpdm_drvdata *drvdata)
 		tpdm_writel(drvdata, drvdata->tc->msr[i], TPDM_TC_MSR(i));
 }
 
+static void __tpdm_config_dsb_msr(struct tpdm_drvdata *drvdata)
+{
+	int i;
+
+	if (!drvdata->msr_support)
+		return;
+
+	for (i = 0; i < TPDM_DSB_MAX_MSR; i++)
+		tpdm_writel(drvdata, drvdata->dsb->msr[i], TPDM_DSB_MSR(i));
+}
+
 static void __tpdm_enable_bc(struct tpdm_drvdata *drvdata)
 {
 	int i;
@@ -434,6 +445,86 @@ static void __tpdm_enable_tc(struct tpdm_drvdata *drvdata)
 	tpdm_writel(drvdata, val, TPDM_TC_CR);
 }
 
+static void __tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
+{
+	uint32_t val, mode, i;
+
+	for (i = 0; i < TPDM_DSB_MAX_EDCR; i++)
+		tpdm_writel(drvdata, drvdata->dsb->edge_ctrl[i],
+			    TPDM_DSB_EDCR(i));
+	for (i = 0; i < TPDM_DSB_MAX_EDCR / 2; i++)
+		tpdm_writel(drvdata, drvdata->dsb->edge_ctrl_mask[i],
+			    TPDM_DSB_EDCMR(i));
+
+	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
+		tpdm_writel(drvdata, drvdata->dsb->patt_val[i],
+			    TPDM_DSB_TPR(i));
+		tpdm_writel(drvdata, drvdata->dsb->patt_mask[i],
+			    TPDM_DSB_TPMR(i));
+	}
+
+	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
+		tpdm_writel(drvdata, drvdata->dsb->trig_patt_val[i],
+			    TPDM_DSB_XPR(i));
+		tpdm_writel(drvdata, drvdata->dsb->trig_patt_mask[i],
+			    TPDM_DSB_XPMR(i));
+	}
+
+	for (i = 0; i < TPDM_DSB_MAX_SELECT; i++)
+		tpdm_writel(drvdata, drvdata->dsb->select_val[i],
+			    TPDM_DSB_CA_SELECT(i));
+
+	val = tpdm_readl(drvdata, TPDM_DSB_TIER);
+	if (drvdata->dsb->patt_ts) {
+		val = val | BIT(0);
+		if (drvdata->dsb->patt_type)
+			val = val | BIT(2);
+		else
+			val = val & ~BIT(2);
+	} else {
+		val = val & ~BIT(0);
+	}
+	if (drvdata->dsb->trig_ts)
+		val = val | BIT(1);
+	else
+		val = val & ~BIT(1);
+	tpdm_writel(drvdata, val, TPDM_DSB_TIER);
+
+	if (!drvdata->msr_fix_req)
+		__tpdm_config_dsb_msr(drvdata);
+
+	val = tpdm_readl(drvdata, TPDM_DSB_CR);
+	/* Set the cycle accurate mode */
+	mode = TPDM_DSB_MODE_CYCACC(drvdata->dsb->mode);
+	val = val & ~(0x7 << 9);
+	val = val | (mode << 9);
+	/* Set the byte lane for high-performance mode */
+	mode = TPDM_DSB_MODE_HPBYTESEL(drvdata->dsb->mode);
+	val = val & ~(0x1F << 2);
+	val = val | (mode << 2);
+	/* Set the performance mode */
+	if (drvdata->dsb->mode & TPDM_DSB_MODE_PERF)
+		val = val | BIT(1);
+	else
+		val = val & ~BIT(1);
+
+	/* Set trigger type */
+	if (drvdata->dsb->trig_type)
+		val = val | BIT(12);
+	else
+		val = val & ~BIT(12);
+
+	tpdm_writel(drvdata, val, TPDM_DSB_CR);
+
+	val = tpdm_readl(drvdata, TPDM_DSB_CR);
+	/* Set the enable bit */
+	val = val | BIT(0);
+	tpdm_writel(drvdata, val, TPDM_DSB_CR);
+
+	if (drvdata->msr_fix_req)
+		__tpdm_config_dsb_msr(drvdata);
+}
+
 static void __tpdm_enable(struct tpdm_drvdata *drvdata)
 {
 	TPDM_UNLOCK(drvdata);
@@ -450,6 +541,9 @@ static void __tpdm_enable(struct tpdm_drvdata *drvdata)
 	if (test_bit(TPDM_DS_TC, drvdata->enable_ds))
 		__tpdm_enable_tc(drvdata);
 
+	if (test_bit(TPDM_DS_DSB, drvdata->enable_ds))
+		__tpdm_enable_dsb(drvdata);
+
 	TPDM_LOCK(drvdata);
 }
 
@@ -492,6 +586,15 @@ static void __tpdm_disable_tc(struct tpdm_drvdata *drvdata)
 	tpdm_writel(drvdata, config, TPDM_TC_CR);
 }
 
+static void __tpdm_disable_dsb(struct tpdm_drvdata *drvdata)
+{
+	uint32_t config;
+
+	config = tpdm_readl(drvdata, TPDM_DSB_CR);
+	config = config & ~BIT(0);
+	tpdm_writel(drvdata, config, TPDM_DSB_CR);
+}
+
 static void __tpdm_disable(struct tpdm_drvdata *drvdata)
 {
 	TPDM_UNLOCK(drvdata);
@@ -502,6 +605,9 @@ static void __tpdm_disable(struct tpdm_drvdata *drvdata)
 	if (test_bit(TPDM_DS_TC, drvdata->enable_ds))
 		__tpdm_disable_tc(drvdata);
 
+	if (test_bit(TPDM_DS_DSB, drvdata->enable_ds))
+		__tpdm_disable_dsb(drvdata);
+
 	if (drvdata->clk_enable)
 		tpdm_writel(drvdata, 0x0, TPDM_CLK_CTRL);
 
@@ -2474,6 +2580,558 @@ static ssize_t tc_msr_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(tc_msr);
 
+static ssize_t dsb_mode_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	if (!test_bit(TPDM_DS_DSB, drvdata->datasets))
+		return -EPERM;
+
+	return scnprintf(buf, PAGE_SIZE, "%lx\n",
+			 (unsigned long)drvdata->dsb->mode);
+}
+
+static ssize_t dsb_mode_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf,
+				   size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_DSB, drvdata->datasets))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	drvdata->dsb->mode = val & TPDM_MODE_ALL;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_mode);
+
+static ssize_t dsb_edge_ctrl_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+	int i;
+
+	if (!test_bit(TPDM_DS_DSB, drvdata->datasets))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	for (i = 0; i < TPDM_DSB_MAX_EDCR; i++) {
+		size += scnprintf(buf + size, PAGE_SIZE - size,
+				  "Index:0x%x Val:0x%x\n", i,
+				  drvdata->dsb->edge_ctrl[i]);
+	}
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+
+static ssize_t dsb_edge_ctrl_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long start, end, edge_ctrl;
+	uint32_t val;
+	int i, bit, reg;
+
+	if (sscanf(buf, "%lx %lx %lx", &start, &end, &edge_ctrl) != 3)
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_DSB, drvdata->datasets) ||
+	    (start >= TPDM_DSB_MAX_LINES) || (end >= TPDM_DSB_MAX_LINES) ||
+	    edge_ctrl > 0x2)
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	for (i = start; i <= end; i++) {
+		reg = i / (NUM_OF_BITS / 2);
+		bit = i % (NUM_OF_BITS / 2);
+		bit = bit * 2;
+
+		val = drvdata->dsb->edge_ctrl[reg];
+		val = val & ~GENMASK((bit + 1), bit);
+		val = val | (edge_ctrl << bit);
+		drvdata->dsb->edge_ctrl[reg] = val;
+	}
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_edge_ctrl);
+
+static ssize_t dsb_edge_ctrl_mask_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+	int i;
+
+	if (!test_bit(TPDM_DS_DSB, drvdata->datasets))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	for (i = 0; i < TPDM_DSB_MAX_EDCR / 2; i++) {
+		size += scnprintf(buf + size, PAGE_SIZE - size,
+				  "Index:0x%x Val:0x%x\n", i,
+				  drvdata->dsb->edge_ctrl_mask[i]);
+	}
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+
+static ssize_t dsb_edge_ctrl_mask_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf,
+					     size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long start, end, val;
+	uint32_t set;
+	int i, bit, reg;
+
+	if (sscanf(buf, "%lx %lx %lx", &start, &end, &val) != 3)
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_DSB, drvdata->datasets) ||
+	    (start >= TPDM_DSB_MAX_LINES) || (end >= TPDM_DSB_MAX_LINES))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	for (i = start; i <= end; i++) {
+		reg = i / NUM_OF_BITS;
+		bit = (i % NUM_OF_BITS);
+
+		set = drvdata->dsb->edge_ctrl_mask[reg];
+		if (val)
+			set = set | BIT(bit);
+		else
+			set = set & ~BIT(bit);
+		drvdata->dsb->edge_ctrl_mask[reg] = set;
+	}
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_edge_ctrl_mask);
+
+static ssize_t dsb_patt_val_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+	int i = 0;
+
+	if (!test_bit(TPDM_DS_DSB, drvdata->datasets))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
+		size += scnprintf(buf + size, PAGE_SIZE - size,
+				  "Index: 0x%x Value: 0x%x\n", i,
+				  drvdata->dsb->patt_val[i]);
+	}
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+
+static ssize_t dsb_patt_val_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf,
+				       size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long index, val;
+
+	if (sscanf(buf, "%lx %lx", &index, &val) != 2)
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_DSB, drvdata->datasets) ||
+	    index >= TPDM_DSB_MAX_PATT)
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	drvdata->dsb->patt_val[index] = val;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_patt_val);
+
+static ssize_t dsb_patt_mask_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+	int i = 0;
+
+	if (!test_bit(TPDM_DS_DSB, drvdata->datasets))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
+		size += scnprintf(buf + size, PAGE_SIZE - size,
+				  "Index: 0x%x Value: 0x%x\n", i,
+				  drvdata->dsb->patt_mask[i]);
+	}
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+
+static ssize_t dsb_patt_mask_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long index, val;
+
+	if (sscanf(buf, "%lx %lx", &index, &val) != 2)
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_DSB, drvdata->datasets) ||
+	    index >= TPDM_DSB_MAX_PATT)
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	drvdata->dsb->patt_mask[index] = val;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_patt_mask);
+
+static ssize_t dsb_patt_ts_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	if (!test_bit(TPDM_DS_DSB, drvdata->datasets))
+		return -EPERM;
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 (unsigned int)drvdata->dsb->patt_ts);
+}
+
+static ssize_t dsb_patt_ts_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf,
+				      size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_DSB, drvdata->datasets))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	if (val)
+		drvdata->dsb->patt_ts = true;
+	else
+		drvdata->dsb->patt_ts = false;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_patt_ts);
+
+static ssize_t dsb_patt_type_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	if (!test_bit(TPDM_DS_DSB, drvdata->datasets))
+		return -EPERM;
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 (unsigned int)drvdata->dsb->patt_type);
+}
+
+static ssize_t dsb_patt_type_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_DSB, drvdata->datasets))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	if (val)
+		drvdata->dsb->patt_type = true;
+	else
+		drvdata->dsb->patt_type = false;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_patt_type);
+
+static ssize_t dsb_trig_patt_val_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+	int i = 0;
+
+	if (!test_bit(TPDM_DS_DSB, drvdata->datasets))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
+		size += scnprintf(buf + size, PAGE_SIZE - size,
+				  "Index: 0x%x Value: 0x%x\n", i,
+				  drvdata->dsb->trig_patt_val[i]);
+	}
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+
+static ssize_t dsb_trig_patt_val_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf,
+					    size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long index, val;
+
+	if (sscanf(buf, "%lx %lx", &index, &val) != 2)
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_DSB, drvdata->datasets) ||
+	    index >= TPDM_DSB_MAX_PATT)
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	drvdata->dsb->trig_patt_val[index] = val;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_trig_patt_val);
+
+static ssize_t dsb_trig_patt_mask_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+	int i = 0;
+
+	if (!test_bit(TPDM_DS_DSB, drvdata->datasets))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
+		size += scnprintf(buf + size, PAGE_SIZE - size,
+				  "Index: 0x%x Value: 0x%x\n", i,
+				  drvdata->dsb->trig_patt_mask[i]);
+	}
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+
+static ssize_t dsb_trig_patt_mask_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf,
+					     size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long index, val;
+
+	if (sscanf(buf, "%lx %lx", &index, &val) != 2)
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_DSB, drvdata->datasets) ||
+	    index >= TPDM_DSB_MAX_PATT)
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	drvdata->dsb->trig_patt_mask[index] = val;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_trig_patt_mask);
+
+static ssize_t dsb_trig_type_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	if (!test_bit(TPDM_DS_DSB, drvdata->datasets))
+		return -EPERM;
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 (unsigned int)drvdata->dsb->trig_type);
+}
+
+static ssize_t dsb_trig_type_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf,
+				      size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_DSB, drvdata->datasets))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	if (val)
+		drvdata->dsb->trig_type = true;
+	else
+		drvdata->dsb->trig_type = false;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_trig_type);
+
+static ssize_t dsb_trig_ts_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	if (!test_bit(TPDM_DS_DSB, drvdata->datasets))
+		return -EPERM;
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 (unsigned int)drvdata->dsb->trig_ts);
+}
+
+static ssize_t dsb_trig_ts_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf,
+				      size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_DSB, drvdata->datasets))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	if (val)
+		drvdata->dsb->trig_ts = true;
+	else
+		drvdata->dsb->trig_ts = false;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_trig_ts);
+
+static ssize_t dsb_select_val_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+	int i;
+
+	if (!test_bit(TPDM_DS_DSB, drvdata->datasets))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	for (i = 0; i < TPDM_DSB_MAX_SELECT; i++) {
+		size += scnprintf(buf + size, PAGE_SIZE - size,
+				  "Index:0x%x Val:0x%x\n", i,
+				  drvdata->dsb->select_val[i]);
+	}
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+
+static ssize_t dsb_select_val_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf,
+					 size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long start, end;
+	uint32_t val;
+	int i, bit, reg;
+
+	if (sscanf(buf, "%lx %lx", &start, &end) != 2)
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_DSB, drvdata->datasets) ||
+	    (start >= TPDM_DSB_MAX_LINES) || (end >= TPDM_DSB_MAX_LINES))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	for (i = start; i <= end; i++) {
+		reg = i / NUM_OF_BITS;
+		bit = (i % NUM_OF_BITS);
+
+		val = drvdata->dsb->select_val[reg];
+		val = val | BIT(bit);
+		drvdata->dsb->select_val[reg] = val;
+	}
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_select_val);
+
+static ssize_t dsb_msr_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned int i;
+	ssize_t len = 0;
+
+	if (!drvdata->msr_support)
+		return -EINVAL;
+
+	if (!test_bit(TPDM_DS_DSB, drvdata->datasets))
+		return -EPERM;
+
+	for (i = 0; i < TPDM_DSB_MAX_MSR; i++)
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%u 0x%x\n",
+				 i, drvdata->dsb->msr[i]);
+
+	return len;
+}
+
+static ssize_t dsb_msr_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf,
+				  size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned int num, val;
+	int nval;
+
+	if (!drvdata->msr_support)
+		return -EINVAL;
+
+	if (!test_bit(TPDM_DS_DSB, drvdata->datasets))
+		return -EPERM;
+
+	nval = sscanf(buf, "%u %x", &num, &val);
+	if (nval != 2)
+		return -EINVAL;
+
+	if (num >= TPDM_DSB_MAX_MSR)
+		return -EINVAL;
+
+	mutex_lock(&drvdata->lock);
+	drvdata->dsb->msr[num] = val;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_msr);
+
 static struct attribute *tpdm_bc_attrs[] = {
 	&dev_attr_bc_capture_mode.attr,
 	&dev_attr_bc_retrieval_mode.attr,
@@ -2522,6 +3180,23 @@ static struct attribute *tpdm_tc_attrs[] = {
 	NULL,
 };
 
+static struct attribute *tpdm_dsb_attrs[] = {
+	&dev_attr_dsb_mode.attr,
+	&dev_attr_dsb_edge_ctrl.attr,
+	&dev_attr_dsb_edge_ctrl_mask.attr,
+	&dev_attr_dsb_patt_val.attr,
+	&dev_attr_dsb_patt_mask.attr,
+	&dev_attr_dsb_patt_ts.attr,
+	&dev_attr_dsb_patt_type.attr,
+	&dev_attr_dsb_trig_patt_val.attr,
+	&dev_attr_dsb_trig_patt_mask.attr,
+	&dev_attr_dsb_trig_ts.attr,
+	&dev_attr_dsb_trig_type.attr,
+	&dev_attr_dsb_select_val.attr,
+	&dev_attr_dsb_msr.attr,
+	NULL,
+};
+
 static struct attribute_group tpdm_bc_attr_grp = {
 	.attrs = tpdm_bc_attrs,
 };
@@ -2530,6 +3205,10 @@ static struct attribute_group tpdm_tc_attr_grp = {
 	.attrs = tpdm_tc_attrs,
 };
 
+static struct attribute_group tpdm_dsb_attr_grp = {
+	.attrs = tpdm_dsb_attrs,
+};
+
 static struct attribute *tpdm_attrs[] = {
 	&dev_attr_available_datasets.attr,
 	&dev_attr_enable_datasets.attr,
@@ -2547,6 +3226,7 @@ static const struct attribute_group *tpdm_attr_grps[] = {
 	&tpdm_attr_grp,
 	&tpdm_bc_attr_grp,
 	&tpdm_tc_attr_grp,
+	&tpdm_dsb_attr_grp,
 	NULL,
 };
 
-- 
2.17.1

