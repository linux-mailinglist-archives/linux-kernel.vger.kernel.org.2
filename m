Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E931398882
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhFBLp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:45:56 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2963 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhFBLpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:45:41 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fw6Y73Bl5z68nS;
        Wed,  2 Jun 2021 19:40:59 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 19:43:57 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 19:43:56 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Lee Jones <lee.jones@linaro.org>,
        patches <patches@opensource.cirrus.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 5/9] mfd: pcf50633: use DEVICE_ATTR_ADMIN_RO macro
Date:   Wed, 2 Jun 2021 19:43:35 +0800
Message-ID: <20210602114339.11223-6-thunder.leizhen@huawei.com>
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

Use DEVICE_ATTR_ADMIN_RO macro helper instead of plain DEVICE_ATTR, which
makes the code a bit shorter and easier to read.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/mfd/pcf50633-core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/pcf50633-core.c b/drivers/mfd/pcf50633-core.c
index 148bcd6120f45a3..e9c565cf0f54f29 100644
--- a/drivers/mfd/pcf50633-core.c
+++ b/drivers/mfd/pcf50633-core.c
@@ -77,8 +77,8 @@ int pcf50633_reg_clear_bits(struct pcf50633 *pcf, u8 reg, u8 val)
 EXPORT_SYMBOL_GPL(pcf50633_reg_clear_bits);
 
 /* sysfs attributes */
-static ssize_t show_dump_regs(struct device *dev, struct device_attribute *attr,
-			    char *buf)
+static ssize_t dump_regs_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
 {
 	struct pcf50633 *pcf = dev_get_drvdata(dev);
 	u8 dump[16];
@@ -106,10 +106,10 @@ static ssize_t show_dump_regs(struct device *dev, struct device_attribute *attr,
 
 	return buf1 - buf;
 }
-static DEVICE_ATTR(dump_regs, 0400, show_dump_regs, NULL);
+static DEVICE_ATTR_ADMIN_RO(dump_regs);
 
-static ssize_t show_resume_reason(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t resume_reason_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
 {
 	struct pcf50633 *pcf = dev_get_drvdata(dev);
 	int n;
@@ -123,7 +123,7 @@ static ssize_t show_resume_reason(struct device *dev,
 
 	return n;
 }
-static DEVICE_ATTR(resume_reason, 0400, show_resume_reason, NULL);
+static DEVICE_ATTR_ADMIN_RO(resume_reason);
 
 static struct attribute *pcf_sysfs_entries[] = {
 	&dev_attr_dump_regs.attr,
-- 
2.26.0.106.g9fadedd


