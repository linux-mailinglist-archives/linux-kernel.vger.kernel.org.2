Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C78435BE3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 09:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhJUHmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 03:42:08 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:14235 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhJUHmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 03:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1634801991; x=1666337991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=sgRhiQWRN83ZnKrmG4BjOIzZJYwLfliEuyEKMZT6jaE=;
  b=hpFOM+lfkI5LO+ugpklJEzHOPbNjHPTUj3H4dWRXaWHa5g+eNd8syxiB
   9KgoI0onZuCf794COBzVbt9oKF9DDff9JsmovNRiGVjrYwsk0vWijKscB
   QdXQ4coZjQCyPNSbs/f7SBZuIjkHofLdIIuWIaWOzAPneDB/Mz3PSmf55
   Q=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 21 Oct 2021 00:39:51 -0700
X-QCInternal: smtphost
Received: from nalasex01c.na.qualcomm.com ([10.47.97.35])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 00:39:51 -0700
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Thu, 21 Oct 2021 00:39:47 -0700
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
Subject: [PATCH 04/10] Coresight: Enable BC and GPR for TPDM driver
Date:   Thu, 21 Oct 2021 15:38:50 +0800
Message-ID: <1634801936-15080-5-git-send-email-quic_taozha@quicinc.com>
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

Enable GPR and Basic Counts(BC) for TPDM. Add GPR interface and
basic control sysFS interface for TPDM. The GPR interface has RW
and RO fields for controlling external logic and mapping core
signals to an APB accessible address in the TPDM address map.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tpdm.c | 334 +++++++++++++++++++
 1 file changed, 334 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 906776c859d6..c0a01979e42f 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -276,6 +276,93 @@ struct tpdm_drvdata {
 
 static void tpdm_init_default_data(struct tpdm_drvdata *drvdata);
 
+static void __tpdm_enable_gpr(struct tpdm_drvdata *drvdata)
+{
+	int i;
+
+	for (i = 0; i < TPDM_GPR_REGS_MAX; i++) {
+		if (!test_bit(i, drvdata->gpr->gpr_dirty))
+			continue;
+		tpdm_writel(drvdata, drvdata->gpr->gp_regs[i], TPDM_GPR_CR(i));
+	}
+}
+
+static void __tpdm_config_bc_msr(struct tpdm_drvdata *drvdata)
+{
+	int i;
+
+	if (!drvdata->msr_support)
+		return;
+
+	for (i = 0; i < TPDM_BC_MAX_MSR; i++)
+		tpdm_writel(drvdata, drvdata->bc->msr[i], TPDM_BC_MSR(i));
+}
+
+static void __tpdm_enable_bc(struct tpdm_drvdata *drvdata)
+{
+	int i;
+	uint32_t val;
+
+	if (drvdata->bc->sat_mode)
+		tpdm_writel(drvdata, drvdata->bc->sat_mode,
+			    TPDM_BC_SATROLL);
+	else
+		tpdm_writel(drvdata, 0x0, TPDM_BC_SATROLL);
+
+	if (drvdata->bc->enable_counters) {
+		tpdm_writel(drvdata, 0xFFFFFFFF, TPDM_BC_CNTENCLR);
+		tpdm_writel(drvdata, drvdata->bc->enable_counters,
+			    TPDM_BC_CNTENSET);
+	}
+	if (drvdata->bc->clear_counters)
+		tpdm_writel(drvdata, drvdata->bc->clear_counters,
+			    TPDM_BC_CNTENCLR);
+
+	if (drvdata->bc->enable_irq) {
+		tpdm_writel(drvdata, 0xFFFFFFFF, TPDM_BC_INTENCLR);
+		tpdm_writel(drvdata, drvdata->bc->enable_irq,
+			    TPDM_BC_INTENSET);
+	}
+	if (drvdata->bc->clear_irq)
+		tpdm_writel(drvdata, drvdata->bc->clear_irq,
+			    TPDM_BC_INTENCLR);
+
+	if (drvdata->bc_trig_type == TPDM_SUPPORT_TYPE_FULL) {
+		for (i = 0; i < drvdata->bc_counters_avail; i++) {
+			tpdm_writel(drvdata, drvdata->bc->trig_val_lo[i],
+				    TPDM_BC_TRIG_LO(i));
+			tpdm_writel(drvdata, drvdata->bc->trig_val_hi[i],
+				    TPDM_BC_TRIG_HI(i));
+		}
+	} else if (drvdata->bc_trig_type == TPDM_SUPPORT_TYPE_PARTIAL) {
+		tpdm_writel(drvdata, drvdata->bc->trig_val_lo[0],
+			    TPDM_BC_TRIG_LO(0));
+		tpdm_writel(drvdata, drvdata->bc->trig_val_hi[0],
+			    TPDM_BC_TRIG_HI(0));
+	}
+
+	if (drvdata->bc->enable_ganging)
+		tpdm_writel(drvdata, drvdata->bc->enable_ganging, TPDM_BC_GANG);
+
+	for (i = 0; i < TPDM_BC_MAX_OVERFLOW; i++)
+		tpdm_writel(drvdata, drvdata->bc->overflow_val[i],
+			    TPDM_BC_OVERFLOW(i));
+
+	__tpdm_config_bc_msr(drvdata);
+
+	val = tpdm_readl(drvdata, TPDM_BC_CR);
+	if (drvdata->bc->retrieval_mode == TPDM_MODE_APB)
+		val = val | BIT(2);
+	else
+		val = val & ~BIT(2);
+	tpdm_writel(drvdata, val, TPDM_BC_CR);
+
+	val = tpdm_readl(drvdata, TPDM_BC_CR);
+	/* Set the enable bit */
+	val = val | BIT(0);
+	tpdm_writel(drvdata, val, TPDM_BC_CR);
+}
+
 static void __tpdm_enable(struct tpdm_drvdata *drvdata)
 {
 	TPDM_UNLOCK(drvdata);
@@ -283,6 +370,12 @@ static void __tpdm_enable(struct tpdm_drvdata *drvdata)
 	if (drvdata->clk_enable)
 		tpdm_writel(drvdata, 0x1, TPDM_CLK_CTRL);
 
+	if (test_bit(TPDM_DS_GPR, drvdata->enable_ds))
+		__tpdm_enable_gpr(drvdata);
+
+	if (test_bit(TPDM_DS_BC, drvdata->enable_ds))
+		__tpdm_enable_bc(drvdata);
+
 	TPDM_LOCK(drvdata);
 }
 
@@ -307,10 +400,22 @@ static int tpdm_enable(struct coresight_device *csdev,
 	return 0;
 }
 
+static void __tpdm_disable_bc(struct tpdm_drvdata *drvdata)
+{
+	uint32_t config;
+
+	config = tpdm_readl(drvdata, TPDM_BC_CR);
+	config = config & ~BIT(0);
+	tpdm_writel(drvdata, config, TPDM_BC_CR);
+}
+
 static void __tpdm_disable(struct tpdm_drvdata *drvdata)
 {
 	TPDM_UNLOCK(drvdata);
 
+	if (test_bit(TPDM_DS_BC, drvdata->enable_ds))
+		__tpdm_disable_bc(drvdata);
+
 	if (drvdata->clk_enable)
 		tpdm_writel(drvdata, 0x0, TPDM_CLK_CTRL);
 
@@ -352,6 +457,234 @@ static const struct coresight_ops tpdm_cs_ops = {
 	.source_ops	= &tpdm_source_ops,
 };
 
+static ssize_t available_datasets_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+
+	if (test_bit(TPDM_DS_IMPLDEF, drvdata->datasets))
+		size += scnprintf(buf + size, PAGE_SIZE - size, "%-8s",
+				  "IMPLDEF");
+
+	if (test_bit(TPDM_DS_DSB, drvdata->datasets))
+		size += scnprintf(buf + size, PAGE_SIZE - size, "%-8s", "DSB");
+
+	if (test_bit(TPDM_DS_CMB, drvdata->datasets))
+		size += scnprintf(buf + size, PAGE_SIZE - size, "%-8s", "CMB");
+
+	if (test_bit(TPDM_DS_TC, drvdata->datasets))
+		size += scnprintf(buf + size, PAGE_SIZE - size, "%-8s", "TC");
+
+	if (test_bit(TPDM_DS_BC, drvdata->datasets))
+		size += scnprintf(buf + size, PAGE_SIZE - size, "%-8s", "BC");
+
+	if (test_bit(TPDM_DS_GPR, drvdata->datasets))
+		size += scnprintf(buf + size, PAGE_SIZE - size, "%-8s", "GPR");
+
+	if (test_bit(TPDM_DS_MCMB, drvdata->datasets))
+		size += scnprintf(buf + size, PAGE_SIZE - size, "%-8s", "MCMB");
+
+	size += scnprintf(buf + size, PAGE_SIZE - size, "\n");
+	return size;
+}
+static DEVICE_ATTR_RO(available_datasets);
+
+static ssize_t enable_datasets_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size;
+
+	size = scnprintf(buf, PAGE_SIZE, "%*pb\n", TPDM_DATASETS,
+			 drvdata->enable_ds);
+
+	if (PAGE_SIZE - size < 2)
+		size = -EINVAL;
+	else
+		size += scnprintf(buf + size, 2, "\n");
+	return size;
+}
+
+static ssize_t enable_datasets_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf,
+					  size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+	int i;
+
+	if (kstrtoul(buf, 16, &val))
+		return -EINVAL;
+
+	mutex_lock(&drvdata->lock);
+	if (drvdata->enable) {
+		mutex_unlock(&drvdata->lock);
+		return -EPERM;
+	}
+
+	for (i = 0; i < TPDM_DATASETS; i++) {
+		if (test_bit(i, drvdata->datasets) && (val & BIT(i)))
+			__set_bit(i, drvdata->enable_ds);
+		else
+			__clear_bit(i, drvdata->enable_ds);
+	}
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(enable_datasets);
+
+static ssize_t reset_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf,
+					  size_t size)
+{
+	int ret = 0;
+	unsigned long val;
+	struct mcmb_dataset *mcmb_temp = NULL;
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	mutex_lock(&drvdata->lock);
+	/* Reset all datasets to ZERO */
+	if (drvdata->gpr != NULL)
+		memset(drvdata->gpr, 0, sizeof(struct gpr_dataset));
+
+	if (drvdata->bc != NULL)
+		memset(drvdata->bc, 0, sizeof(struct bc_dataset));
+
+	if (drvdata->tc != NULL)
+		memset(drvdata->tc, 0, sizeof(struct tc_dataset));
+
+	if (drvdata->dsb != NULL)
+		memset(drvdata->dsb, 0, sizeof(struct dsb_dataset));
+
+	if (drvdata->cmb != NULL) {
+		if (drvdata->cmb->mcmb != NULL) {
+			mcmb_temp = drvdata->cmb->mcmb;
+			memset(drvdata->cmb->mcmb, 0,
+				sizeof(struct mcmb_dataset));
+			}
+
+		memset(drvdata->cmb, 0, sizeof(struct cmb_dataset));
+		drvdata->cmb->mcmb = mcmb_temp;
+	}
+	/* Init the default data */
+	tpdm_init_default_data(drvdata);
+
+	mutex_unlock(&drvdata->lock);
+
+	/* Disable tpdm if enabled */
+	if (drvdata->enable)
+		coresight_disable(drvdata->csdev);
+
+	return size;
+}
+static DEVICE_ATTR_WO(reset);
+
+static ssize_t integration_test_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf,
+					  size_t size)
+{
+	int i, ret = 0;
+	unsigned long val;
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val != 1 && val != 2)
+		return -EINVAL;
+
+	if (!drvdata->enable)
+		return -EINVAL;
+
+	if (val == 1)
+		val = ATBCNTRL_VAL_64;
+	else
+		val = ATBCNTRL_VAL_32;
+	TPDM_UNLOCK(drvdata);
+	tpdm_writel(drvdata, 0x1, TPDM_ITCNTRL);
+
+	for (i = 1; i < 5; i++)
+		tpdm_writel(drvdata, val, TPDM_ITATBCNTRL);
+
+	tpdm_writel(drvdata, 0, TPDM_ITCNTRL);
+	TPDM_LOCK(drvdata);
+	return size;
+}
+static DEVICE_ATTR_WO(integration_test);
+
+static ssize_t gp_regs_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+	int i = 0;
+
+	if (!test_bit(TPDM_DS_GPR, drvdata->datasets))
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	for (i = 0; i < TPDM_GPR_REGS_MAX; i++) {
+		if (!test_bit(i, drvdata->gpr->gpr_dirty))
+			continue;
+		size += scnprintf(buf + size, PAGE_SIZE - size,
+				  "Index: 0x%x Value: 0x%x\n", i,
+				  drvdata->gpr->gp_regs[i]);
+	}
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+
+static ssize_t gp_regs_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf,
+				  size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long index, val;
+
+	if (sscanf(buf, "%lx %lx", &index, &val) != 2)
+		return -EINVAL;
+	if (!test_bit(TPDM_DS_GPR, drvdata->datasets) ||
+	    index >= TPDM_GPR_REGS_MAX)
+		return -EPERM;
+
+	mutex_lock(&drvdata->lock);
+	drvdata->gpr->gp_regs[index] = val;
+	__set_bit(index, drvdata->gpr->gpr_dirty);
+	mutex_unlock(&drvdata->lock);
+	return size;
+}
+static DEVICE_ATTR_RW(gp_regs);
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
+static const struct attribute_group *tpdm_attr_grps[] = {
+	&tpdm_attr_grp,
+	NULL,
+};
+
 static int tpdm_datasets_alloc(struct tpdm_drvdata *drvdata)
 {
 	if (test_bit(TPDM_DS_GPR, drvdata->datasets)) {
@@ -513,6 +846,7 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.ops = &tpdm_cs_ops;
 	desc.pdata = adev->dev.platform_data;
 	desc.dev = &adev->dev;
+	desc.groups = tpdm_attr_grps;
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev))
 		return PTR_ERR(drvdata->csdev);
-- 
2.17.1

