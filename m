Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C40398884
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhFBLqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:46:04 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2851 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhFBLpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:45:43 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fw6W75b3xzWp49;
        Wed,  2 Jun 2021 19:39:15 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 19:43:58 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 19:43:58 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Lee Jones <lee.jones@linaro.org>,
        patches <patches@opensource.cirrus.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 8/9] mfd: intel_soc_pmic_bxtwc: use DEVICE_ATTR_ADMIN_RW macro
Date:   Wed, 2 Jun 2021 19:43:38 +0800
Message-ID: <20210602114339.11223-9-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210602114339.11223-1-thunder.leizhen@huawei.com>
References: <20210602114339.11223-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR_ADMIN_RW macro helper instead of plain DEVICE_ATTR, which
makes the code a bit shorter and easier to read.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 47d0d3a69a58a37..bc069c4daa60393 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -330,14 +330,14 @@ static int regmap_ipc_byte_reg_write(void *context, unsigned int reg,
 
 /* sysfs interfaces to r/w PMIC registers, required by initial script */
 static unsigned long bxtwc_reg_addr;
-static ssize_t bxtwc_reg_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static ssize_t addr_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "0x%lx\n", bxtwc_reg_addr);
 }
 
-static ssize_t bxtwc_reg_store(struct device *dev,
-	struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t addr_store(struct device *dev,
+			  struct device_attribute *attr, const char *buf, size_t count)
 {
 	if (kstrtoul(buf, 0, &bxtwc_reg_addr)) {
 		dev_err(dev, "Invalid register address\n");
@@ -346,8 +346,8 @@ static ssize_t bxtwc_reg_store(struct device *dev,
 	return (ssize_t)count;
 }
 
-static ssize_t bxtwc_val_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static ssize_t val_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
 {
 	int ret;
 	unsigned int val;
@@ -362,8 +362,8 @@ static ssize_t bxtwc_val_show(struct device *dev,
 	return sprintf(buf, "0x%02x\n", val);
 }
 
-static ssize_t bxtwc_val_store(struct device *dev,
-	struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t val_store(struct device *dev,
+			 struct device_attribute *attr, const char *buf, size_t count)
 {
 	int ret;
 	unsigned int val;
@@ -382,8 +382,8 @@ static ssize_t bxtwc_val_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(addr, S_IWUSR | S_IRUSR, bxtwc_reg_show, bxtwc_reg_store);
-static DEVICE_ATTR(val, S_IWUSR | S_IRUSR, bxtwc_val_show, bxtwc_val_store);
+static DEVICE_ATTR_ADMIN_RW(addr);
+static DEVICE_ATTR_ADMIN_RW(val);
 static struct attribute *bxtwc_attrs[] = {
 	&dev_attr_addr.attr,
 	&dev_attr_val.attr,
-- 
2.26.0.106.g9fadedd


