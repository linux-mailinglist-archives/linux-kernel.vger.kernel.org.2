Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A66435BF6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 09:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhJUHmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 03:42:36 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:17635 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbhJUHmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 03:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1634802006; x=1666338006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=1ZZXbQ+FWiwA09Fn9nqRYPRoqHEHvoOpaFwGxLMJ7nY=;
  b=knaB5FQUOaYBM3dMx8ML8OeDQPP2m0sb86Ws6fFjSs8v3WM0uhojwm4l
   L1vyHBvGSsWyZ95KzdOqXc80KGqQgCico2ZwHt/dBVSoJIuSPA8kjQxDm
   zbb+bRFnHP2m+4Nsl6BReYaMMfBcbTtarAKyM0n7y79O04ugUU3Y11OLR
   o=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 21 Oct 2021 00:40:05 -0700
X-QCInternal: smtphost
Received: from nalasex01c.na.qualcomm.com ([10.47.97.35])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 00:40:06 -0700
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Thu, 21 Oct 2021 00:40:02 -0700
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
Subject: [PATCH 08/10] Coresight: Enable CMB subunit for TPDM
Date:   Thu, 21 Oct 2021 15:38:54 +0800
Message-ID: <1634801936-15080-9-git-send-email-quic_taozha@quicinc.com>
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

Enable CMB subunit for TPDM. The CMB dataset elements flow out ATB
while the BC/TC dataset elements are sent only on ATB flush
requests from the TPDA.
The CMB data set subunit is responsible for collection of CMB data
sets. The CMB subunit data set interface must be a legal ATB width
less than or equal to 64 bits.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tpdm.c | 931 +++++++++++++++++--
 1 file changed, 861 insertions(+), 70 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 5f07363e4650..3e7f5b48150b 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -320,6 +320,17 @@ static void __tpdm_config_dsb_msr(struct tpdm_drvdata *drvdata)
 		tpdm_writel(drvdata, drvdata->dsb->msr[i], TPDM_DSB_MSR(i));
 }
 
+static void __tpdm_config_cmb_msr(struct tpdm_drvdata *drvdata)
+{
+	int i;
+
+	if (!drvdata->msr_support)
+		return;
+
+	for (i = 0; i < TPDM_CMB_MAX_MSR; i++)
+		tpdm_writel(drvdata, drvdata->cmb->msr[i], TPDM_CMB_MSR(i));
+}
+
 static void __tpdm_enable_bc(struct tpdm_drvdata *drvdata)
 {
 	int i;
@@ -525,6 +536,112 @@ static void __tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 		__tpdm_config_dsb_msr(drvdata);
 }
 
+static void __tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
+{
+	uint32_t val;
+	int i;
+
+	for (i = 0; i < TPDM_CMB_PATT_CMP; i++) {
+		tpdm_writel(drvdata, drvdata->cmb->patt_val[i],
+			    TPDM_CMB_TPR(i));
+		tpdm_writel(drvdata, drvdata->cmb->patt_mask[i],
+			    TPDM_CMB_TPMR(i));
+		tpdm_writel(drvdata, drvdata->cmb->trig_patt_val[i],
+			    TPDM_CMB_XPR(i));
+		tpdm_writel(drvdata, drvdata->cmb->trig_patt_mask[i],
+			    TPDM_CMB_XPMR(i));
+	}
+
+	val = tpdm_readl(drvdata, TPDM_CMB_TIER);
+	if (drvdata->cmb->patt_ts)
+		val = val | BIT(0);
+	else
+		val = val & ~BIT(0);
+	if (drvdata->cmb->trig_ts)
+		val = val | BIT(1);
+	else
+		val = val & ~BIT(1);
+	if (drvdata->cmb->ts_all)
+		val = val | BIT(2);
+	else
+		val = val & ~BIT(2);
+
+	tpdm_writel(drvdata, val, TPDM_CMB_TIER);
+
+	if (!drvdata->cmb_msr_skip)
+		__tpdm_config_cmb_msr(drvdata);
+
+	val = tpdm_readl(drvdata, TPDM_CMB_CR);
+	/* Set the flow control bit */
+	val = val & ~BIT(2);
+	if (drvdata->cmb->trace_mode)
+		val = val | BIT(1);
+	else
+		val = val & ~BIT(1);
+
+	val = val & ~GENMASK(9, 8);
+	val = val | BMVAL(drvdata->cmb->cycle_acc, 0, 1) << 8;
+	tpdm_writel(drvdata, val, TPDM_CMB_CR);
+	/* Set the enable bit */
+	val = val | BIT(0);
+	tpdm_writel(drvdata, val, TPDM_CMB_CR);
+}
+
+static void __tpdm_enable_mcmb(struct tpdm_drvdata *drvdata)
+{
+	uint32_t val;
+	struct mcmb_dataset *mcmb = drvdata->cmb->mcmb;
+	int i;
+
+	for (i = 0; i < TPDM_CMB_PATT_CMP; i++) {
+		tpdm_writel(drvdata, drvdata->cmb->patt_val[i],
+			    TPDM_CMB_TPR(i));
+		tpdm_writel(drvdata, drvdata->cmb->patt_mask[i],
+			    TPDM_CMB_TPMR(i));
+		tpdm_writel(drvdata, drvdata->cmb->trig_patt_val[i],
+			    TPDM_CMB_XPR(i));
+		tpdm_writel(drvdata, drvdata->cmb->trig_patt_mask[i],
+			    TPDM_CMB_XPMR(i));
+	}
+
+	val = tpdm_readl(drvdata, TPDM_CMB_TIER);
+	if (drvdata->cmb->patt_ts)
+		val = val | BIT(0);
+	else
+		val = val & ~BIT(0);
+	if (drvdata->cmb->trig_ts)
+		val = val | BIT(1);
+	else
+		val = val & ~BIT(1);
+	if (drvdata->cmb->ts_all)
+		val = val | BIT(2);
+	else
+		val = val & ~BIT(2);
+	tpdm_writel(drvdata, val, TPDM_CMB_TIER);
+
+	__tpdm_config_cmb_msr(drvdata);
+
+	val = tpdm_readl(drvdata, TPDM_CMB_CR);
+	/* Set the flow control bit */
+	val = val & ~BIT(2);
+	if (drvdata->cmb->trace_mode)
+		val = val | BIT(1);
+	else
+		val = val & ~BIT(1);
+
+	val = val & ~GENMASK(9, 8);
+	val = val | BMVAL(drvdata->cmb->cycle_acc, 0, 1) << 8;
+	val = val & ~GENMASK(20, 18);
+	val = val | (BMVAL(mcmb->mcmb_trig_lane, 0, 2) << 18);
+	val = val & ~GENMASK(17, 10);
+	val = val | (BMVAL(mcmb->mcmb_lane_select, 0, 7) << 10);
+
+	tpdm_writel(drvdata, val, TPDM_CMB_CR);
+	/* Set the enable bit */
+	val = val | BIT(0);
+	tpdm_writel(drvdata, val, TPDM_CMB_CR);
+}
+
 static void __tpdm_enable(struct tpdm_drvdata *drvdata)
 {
 	TPDM_UNLOCK(drvdata);
@@ -544,6 +661,11 @@ static void __tpdm_enable(struct tpdm_drvdata *drvdata)
 	if (test_bit(TPDM_DS_DSB, drvdata->enable_ds))
 		__tpdm_enable_dsb(drvdata);
 
+	if (test_bit(TPDM_DS_CMB, drvdata->enable_ds))
+		__tpdm_enable_cmb(drvdata);
+	else if (test_bit(TPDM_DS_MCMB, drvdata->enable_ds))
+		__tpdm_enable_mcmb(drvdata);
+
 	TPDM_LOCK(drvdata);
 }
 
@@ -595,6 +717,15 @@ static void __tpdm_disable_dsb(struct tpdm_drvdata *drvdata)
 	tpdm_writel(drvdata, config, TPDM_DSB_CR);
 }
 
+static void __tpdm_disable_cmb(struct tpdm_drvdata *drvdata)
+{
+	uint32_t config;
+
+	config = tpdm_readl(drvdata, TPDM_CMB_CR);
+	config = config & ~BIT(0);
+	tpdm_writel(drvdata, config, TPDM_CMB_CR);
+}
+
 static void __tpdm_disable(struct tpdm_drvdata *drvdata)
 {
 	TPDM_UNLOCK(drvdata);
@@ -608,6 +739,10 @@ static void __tpdm_disable(struct tpdm_drvdata *drvdata)
 	if (test_bit(TPDM_DS_DSB, drvdata->enable_ds))
 		__tpdm_disable_dsb(drvdata);
 
+	if (test_bit(TPDM_DS_CMB, drvdata->enable_ds) ||
+		test_bit(TPDM_DS_MCMB, drvdata->enable_ds))
+		__tpdm_disable_cmb(drvdata);
+
 	if (drvdata->clk_enable)
 		tpdm_writel(drvdata, 0x0, TPDM_CLK_CTRL);
 
@@ -3132,81 +3267,736 @@ static ssize_t dsb_msr_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(dsb_msr);
 
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
+static ssize_t cmb_available_modes_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%s\n", "continuous trace_on_change");
+}
+static DEVICE_ATTR_RO(cmb_available_modes);
 
-static struct attribute *tpdm_tc_attrs[] = {
-	&dev_attr_tc_capture_mode.attr,
-	&dev_attr_tc_retrieval_mode.attr,
-	&dev_attr_tc_reset_counters.attr,
-	&dev_attr_tc_sat_mode.attr,
-	&dev_attr_tc_enable_counters.attr,
-	&dev_attr_tc_clear_counters.attr,
-	&dev_attr_tc_enable_irq.attr,
-	&dev_attr_tc_clear_irq.attr,
-	&dev_attr_tc_trig_sel.attr,
-	&dev_attr_tc_trig_val_lo.attr,
-	&dev_attr_tc_trig_val_hi.attr,
-	&dev_attr_tc_ovsr_gp.attr,
-	&dev_attr_tc_ovsr_impl.attr,
-	&dev_attr_tc_counter_sel.attr,
-	&dev_attr_tc_count_val_lo.attr,
-	&dev_attr_tc_count_val_hi.attr,
-	&dev_attr_tc_shadow_val_lo.attr,
-	&dev_attr_tc_shadow_val_hi.attr,
-	&dev_attr_tc_sw_inc.attr,
-	&dev_attr_tc_msr.attr,
-	NULL,
-};
+static ssize_t cmb_mode_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
-static struct attribute *tpdm_dsb_attrs[] = {
-	&dev_attr_dsb_mode.attr,
-	&dev_attr_dsb_edge_ctrl.attr,
-	&dev_attr_dsb_edge_ctrl_mask.attr,
-	&dev_attr_dsb_patt_val.attr,
-	&dev_attr_dsb_patt_mask.attr,
-	&dev_attr_dsb_patt_ts.attr,
-	&dev_attr_dsb_patt_type.attr,
-	&dev_attr_dsb_trig_patt_val.attr,
-	&dev_attr_dsb_trig_patt_mask.attr,
-	&dev_attr_dsb_trig_ts.attr,
-	&dev_attr_dsb_trig_type.attr,
-	&dev_attr_dsb_select_val.attr,
-	&dev_attr_dsb_msr.attr,
-	NULL,
-};
+	if (!(test_bit(TPDM_DS_CMB, drvdata->datasets) ||
+	      test_bit(TPDM_DS_MCMB, drvdata->datasets)))
+		return -EPERM;
 
-static struct attribute_group tpdm_bc_attr_grp = {
-	.attrs = tpdm_bc_attrs,
-};
+	return scnprintf(buf, PAGE_SIZE, "trace_mode: %s cycle_acc: %d\n",
+			 drvdata->cmb->trace_mode ?
+			 "trace_on_change" : "continuous",
+			 drvdata->cmb->cycle_acc);
+}
 
-static struct attribute_group tpdm_tc_attr_grp = {
-	.attrs = tpdm_tc_attrs,
-};
+static ssize_t cmb_mode_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf,
+				   size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned int trace_mode, cycle_acc;
+	int nval;
 
-static struct attribute_group tpdm_dsb_attr_grp = {
-	.attrs = tpdm_dsb_attrs,
+	nval = sscanf(buf, "%u %u", &trace_mode, &cycle_acc);
+	if (nval != 2)
+		return -EINVAL;
+
+	if (!(test_bit(TPDM_DS_CMB, drvdata->datasets) ||
+	      test_bit(TPDM_DS_MCMB, drvdata->datasets)))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	drvdata->cmb->trace_mode = trace_mode;
+	drvdata->cmb->cycle_acc = cycle_acc;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(cmb_mode);
+
+static ssize_t cmb_patt_val_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+	int i;
+
+	if (!(test_bit(TPDM_DS_CMB, drvdata->datasets) ||
+	      test_bit(TPDM_DS_MCMB, drvdata->datasets)))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	for (i = 0; i < TPDM_CMB_PATT_CMP; i++) {
+		size += scnprintf(buf + size, PAGE_SIZE - size,
+				  "Index: 0x%x Value: 0x%x\n", i,
+				  drvdata->cmb->patt_val[i]);
+	}
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+
+static ssize_t cmb_patt_val_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long index, val;
+
+	if (sscanf(buf, "%lx %lx", &index, &val) != 2)
+		return -EINVAL;
+	if (index >= TPDM_CMB_PATT_CMP)
+		return -EINVAL;
+	if (!(test_bit(TPDM_DS_CMB, drvdata->datasets) ||
+	      test_bit(TPDM_DS_MCMB, drvdata->datasets)))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	drvdata->cmb->patt_val[index] = val;
+	mutex_unlock(&drvdata->lock);
+
+	return size;
+}
+static DEVICE_ATTR_RW(cmb_patt_val);
+
+static ssize_t cmb_patt_mask_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+	int i;
+
+	if (!(test_bit(TPDM_DS_CMB, drvdata->datasets) ||
+	      test_bit(TPDM_DS_MCMB, drvdata->datasets)))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	for (i = 0; i < TPDM_CMB_PATT_CMP; i++) {
+		size += scnprintf(buf + size, PAGE_SIZE - size,
+				  "Index: 0x%x Value: 0x%x\n", i,
+				  drvdata->cmb->patt_mask[i]);
+	}
+	mutex_unlock(&drvdata->lock);
+	return size;
+
+}
+
+static ssize_t cmb_patt_mask_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long index, val;
+
+	if (sscanf(buf, "%lx %lx", &index, &val) != 2)
+		return -EINVAL;
+	if (index >= TPDM_CMB_PATT_CMP)
+		return -EINVAL;
+	if (!(test_bit(TPDM_DS_CMB, drvdata->datasets) ||
+	      test_bit(TPDM_DS_MCMB, drvdata->datasets)))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	drvdata->cmb->patt_mask[index] = val;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(cmb_patt_mask);
+
+static ssize_t cmb_patt_ts_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	if (!(test_bit(TPDM_DS_CMB, drvdata->datasets) ||
+	      test_bit(TPDM_DS_MCMB, drvdata->datasets)))
+		return -EPERM;
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 (unsigned int)drvdata->cmb->patt_ts);
+}
+
+static ssize_t cmb_patt_ts_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf,
+				      size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+	if (!(test_bit(TPDM_DS_CMB, drvdata->datasets) ||
+	      test_bit(TPDM_DS_MCMB, drvdata->datasets)))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	if (val)
+		drvdata->cmb->patt_ts = true;
+	else
+		drvdata->cmb->patt_ts = false;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(cmb_patt_ts);
+
+static ssize_t cmb_ts_all_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	if (!(test_bit(TPDM_DS_CMB, drvdata->datasets) ||
+	      test_bit(TPDM_DS_MCMB, drvdata->datasets)))
+		return -EPERM;
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 (unsigned int)drvdata->cmb->ts_all);
+}
+
+static ssize_t cmb_ts_all_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf,
+				      size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+	if (!(test_bit(TPDM_DS_CMB, drvdata->datasets) ||
+	      test_bit(TPDM_DS_MCMB, drvdata->datasets)))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	if (val)
+		drvdata->cmb->ts_all = true;
+	else
+		drvdata->cmb->ts_all = false;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(cmb_ts_all);
+
+static ssize_t cmb_trig_patt_val_lsb_show(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (!(test_bit(TPDM_DS_CMB, drvdata->datasets) ||
+	      test_bit(TPDM_DS_MCMB, drvdata->datasets)))
+		return -EPERM;
+
+	val = drvdata->cmb->trig_patt_val[TPDM_CMB_LSB];
+
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t cmb_trig_patt_val_lsb_store(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf, size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+	if (!(test_bit(TPDM_DS_CMB, drvdata->datasets) ||
+	      test_bit(TPDM_DS_MCMB, drvdata->datasets)))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	drvdata->cmb->trig_patt_val[TPDM_CMB_LSB] = val;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(cmb_trig_patt_val_lsb);
+
+static ssize_t cmb_trig_patt_mask_lsb_show(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (!(test_bit(TPDM_DS_CMB, drvdata->datasets) ||
+	      test_bit(TPDM_DS_MCMB, drvdata->datasets)))
+		return -EPERM;
+
+	val = drvdata->cmb->trig_patt_mask[TPDM_CMB_LSB];
+
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t cmb_trig_patt_mask_lsb_store(struct device *dev,
+						 struct device_attribute *attr,
+						 const char *buf, size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+	if (!(test_bit(TPDM_DS_CMB, drvdata->datasets) ||
+	      test_bit(TPDM_DS_MCMB, drvdata->datasets)))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	drvdata->cmb->trig_patt_mask[TPDM_CMB_LSB] = val;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(cmb_trig_patt_mask_lsb);
+
+static ssize_t cmb_trig_patt_val_msb_show(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (!(test_bit(TPDM_DS_CMB, drvdata->datasets) ||
+	      test_bit(TPDM_DS_MCMB, drvdata->datasets)))
+		return -EPERM;
+
+	val = drvdata->cmb->trig_patt_val[TPDM_CMB_MSB];
+
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t cmb_trig_patt_val_msb_store(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf, size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+	if (!(test_bit(TPDM_DS_CMB, drvdata->datasets) ||
+	      test_bit(TPDM_DS_MCMB, drvdata->datasets)))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	drvdata->cmb->trig_patt_val[TPDM_CMB_MSB] = val;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(cmb_trig_patt_val_msb);
+
+static ssize_t cmb_trig_patt_mask_msb_show(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (!(test_bit(TPDM_DS_CMB, drvdata->datasets) ||
+	      test_bit(TPDM_DS_MCMB, drvdata->datasets)))
+		return -EPERM;
+
+	val = drvdata->cmb->trig_patt_mask[TPDM_CMB_MSB];
+
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t cmb_trig_patt_mask_msb_store(struct device *dev,
+						 struct device_attribute *attr,
+						 const char *buf, size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+	if (!(test_bit(TPDM_DS_CMB, drvdata->datasets) ||
+	      test_bit(TPDM_DS_MCMB, drvdata->datasets)))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	drvdata->cmb->trig_patt_mask[TPDM_CMB_MSB] = val;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(cmb_trig_patt_mask_msb);
+
+static ssize_t cmb_trig_ts_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	if (!(test_bit(TPDM_DS_CMB, drvdata->datasets) ||
+	      test_bit(TPDM_DS_MCMB, drvdata->datasets)))
+		return -EPERM;
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 (unsigned int)drvdata->cmb->trig_ts);
+}
+
+static ssize_t cmb_trig_ts_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf,
+				      size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+	if (!(test_bit(TPDM_DS_CMB, drvdata->datasets) ||
+	      test_bit(TPDM_DS_MCMB, drvdata->datasets)))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	if (val)
+		drvdata->cmb->trig_ts = true;
+	else
+		drvdata->cmb->trig_ts = false;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(cmb_trig_ts);
+
+static ssize_t cmb_msr_show(struct device *dev,
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
+	if (!(test_bit(TPDM_DS_CMB, drvdata->datasets) ||
+	      test_bit(TPDM_DS_MCMB, drvdata->datasets)))
+		return -EPERM;
+
+	for (i = 0; i < TPDM_CMB_MAX_MSR; i++)
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%u 0x%x\n",
+				 i, drvdata->cmb->msr[i]);
+
+	return len;
+}
+
+static ssize_t cmb_msr_store(struct device *dev,
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
+	if (!(test_bit(TPDM_DS_CMB, drvdata->datasets) ||
+	      test_bit(TPDM_DS_MCMB, drvdata->datasets)))
+		return -EPERM;
+
+	nval = sscanf(buf, "%u %x", &num, &val);
+	if (nval != 2)
+		return -EINVAL;
+
+	if (num >= TPDM_CMB_MAX_MSR)
+		return -EINVAL;
+
+	mutex_lock(&drvdata->lock);
+	drvdata->cmb->msr[num] = val;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(cmb_msr);
+
+static ssize_t cmb_read_interface_state_show(struct device *dev,
+						  struct device_attribute *attr,
+						  char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (!(test_bit(TPDM_DS_CMB, drvdata->datasets) ||
+	      test_bit(TPDM_DS_MCMB, drvdata->datasets)))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	if (!drvdata->enable) {
+		mutex_unlock(&drvdata->lock);
+		return -EPERM;
+	}
+	TPDM_UNLOCK(drvdata);
+	val = tpdm_readl(drvdata, TPDM_CMB_READVAL);
+	TPDM_LOCK(drvdata);
+	mutex_unlock(&drvdata->lock);
+
+	return scnprintf(buf, PAGE_SIZE, "%lx\n", val);
+}
+static DEVICE_ATTR_RO(cmb_read_interface_state);
+
+static ssize_t cmb_read_ctl_reg_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (!(test_bit(TPDM_DS_CMB, drvdata->datasets) ||
+	      test_bit(TPDM_DS_MCMB, drvdata->datasets)))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	if (!drvdata->enable) {
+		mutex_unlock(&drvdata->lock);
+		return -EPERM;
+	}
+	TPDM_UNLOCK(drvdata);
+	val = tpdm_readl(drvdata, TPDM_CMB_READCTL);
+	TPDM_LOCK(drvdata);
+	mutex_unlock(&drvdata->lock);
+
+	if (test_bit(TPDM_DS_CMB, drvdata->datasets))
+		return scnprintf(buf, PAGE_SIZE, "SEL: %lx\n", val);
+	else
+		return scnprintf(buf, PAGE_SIZE, "Lane %u SEL: %lx\n",
+				 (unsigned int)BMVAL(val, 1, 3), val & 0x1);
+}
+
+static ssize_t cmb_read_ctl_reg_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf,
+					   size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+
+	if (!(test_bit(TPDM_DS_CMB, drvdata->datasets) ||
+	      test_bit(TPDM_DS_MCMB, drvdata->datasets)))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	if (!drvdata->enable) {
+		mutex_unlock(&drvdata->lock);
+		return -EPERM;
+	}
+	TPDM_UNLOCK(drvdata);
+	tpdm_writel(drvdata, val, TPDM_CMB_READCTL);
+	TPDM_LOCK(drvdata);
+	mutex_unlock(&drvdata->lock);
+
+	return size;
+}
+static DEVICE_ATTR_RW(cmb_read_ctl_reg);
+
+static ssize_t mcmb_trig_lane_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	if (!test_bit(TPDM_DS_MCMB, drvdata->datasets))
+		return -EPERM;
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 (unsigned int)drvdata->cmb->mcmb->mcmb_trig_lane);
+}
+
+static ssize_t mcmb_trig_lane_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf,
+					 size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+	if (val >= TPDM_MCMB_MAX_LANES)
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_MCMB, drvdata->datasets))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	drvdata->cmb->mcmb->mcmb_trig_lane = val;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(mcmb_trig_lane);
+
+static ssize_t mcmb_lanes_select_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	if (!test_bit(TPDM_DS_MCMB, drvdata->datasets))
+		return -EPERM;
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 (unsigned int)drvdata->cmb->mcmb->mcmb_lane_select);
+}
+
+static ssize_t mcmb_lanes_select_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf,
+					    size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_MCMB, drvdata->datasets))
+		return -EPERM;
+
+	val = BMVAL(val, 0, TPDM_MCMB_MAX_LANES - 1);
+
+	mutex_lock(&drvdata->lock);
+	drvdata->cmb->mcmb->mcmb_lane_select = val;
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(mcmb_lanes_select);
+
+static ssize_t cmb_markr_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf,
+				    size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+
+	if (!(test_bit(TPDM_DS_CMB, drvdata->datasets) ||
+	      test_bit(TPDM_DS_MCMB, drvdata->datasets)))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	if (!drvdata->enable) {
+		mutex_unlock(&drvdata->lock);
+		return -EPERM;
+	}
+	TPDM_UNLOCK(drvdata);
+	tpdm_writel(drvdata, val, TPDM_CMB_MARKR);
+	TPDM_LOCK(drvdata);
+	mutex_unlock(&drvdata->lock);
+
+	return size;
+}
+static DEVICE_ATTR_WO(cmb_markr);
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
+static struct attribute *tpdm_cmb_attrs[] = {
+	&dev_attr_cmb_available_modes.attr,
+	&dev_attr_cmb_mode.attr,
+	&dev_attr_cmb_patt_val.attr,
+	&dev_attr_cmb_patt_mask.attr,
+	&dev_attr_cmb_patt_ts.attr,
+	&dev_attr_cmb_ts_all.attr,
+	&dev_attr_cmb_trig_patt_val_lsb.attr,
+	&dev_attr_cmb_trig_patt_mask_lsb.attr,
+	&dev_attr_cmb_trig_patt_val_msb.attr,
+	&dev_attr_cmb_trig_patt_mask_msb.attr,
+	&dev_attr_cmb_trig_ts.attr,
+	&dev_attr_cmb_msr.attr,
+	&dev_attr_cmb_read_interface_state.attr,
+	&dev_attr_cmb_read_ctl_reg.attr,
+	&dev_attr_cmb_markr.attr,
+	&dev_attr_mcmb_trig_lane.attr,
+	&dev_attr_mcmb_lanes_select.attr,
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
+static struct attribute_group tpdm_dsb_attr_grp = {
+	.attrs = tpdm_dsb_attrs,
+};
+
+static struct attribute_group tpdm_cmb_attr_grp = {
+	.attrs = tpdm_cmb_attrs,
 };
 
 static struct attribute *tpdm_attrs[] = {
@@ -3227,6 +4017,7 @@ static const struct attribute_group *tpdm_attr_grps[] = {
 	&tpdm_bc_attr_grp,
 	&tpdm_tc_attr_grp,
 	&tpdm_dsb_attr_grp,
+	&tpdm_cmb_attr_grp,
 	NULL,
 };
 
-- 
2.17.1

