Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273CF398886
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhFBLqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:46:08 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2966 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhFBLpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:45:44 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fw6Y95rBmz693t;
        Wed,  2 Jun 2021 19:41:01 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 19:43:59 +0800
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
Subject: [PATCH 9/9] mfd: ab8500-core: use DEVICE_ATTR_RO/RW macro
Date:   Wed, 2 Jun 2021 19:43:39 +0800
Message-ID: <20210602114339.11223-10-thunder.leizhen@huawei.com>
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

Use DEVICE_ATTR_RO/RW macro helper instead of plain DEVICE_ATTR, which
makes the code a bit shorter and easier to read.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/mfd/ab8500-core.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index c2ba498ad302dcd..30489670ea528ce 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -827,8 +827,8 @@ static const struct mfd_cell ab8540_cut2_devs[] = {
 	},
 };
 
-static ssize_t show_chip_id(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t chip_id_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
 {
 	struct ab8500 *ab8500;
 
@@ -848,8 +848,8 @@ static ssize_t show_chip_id(struct device *dev,
  * 0x40 Power on key 1 pressed longer than 10 seconds
  * 0x80 DB8500 thermal shutdown
  */
-static ssize_t show_switch_off_status(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t switch_off_status_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
 {
 	int ret;
 	u8 value;
@@ -883,8 +883,8 @@ void ab8500_override_turn_on_stat(u8 mask, u8 set)
  * 0x40 UsbIDDetect
  * 0x80 Reserved
  */
-static ssize_t show_turn_on_status(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t turn_on_status_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
 {
 	int ret;
 	u8 value;
@@ -912,8 +912,8 @@ static ssize_t show_turn_on_status(struct device *dev,
 	return sprintf(buf, "%#x\n", value);
 }
 
-static ssize_t show_turn_on_status_2(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t turn_on_status_2_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
 {
 	int ret;
 	u8 value;
@@ -927,8 +927,8 @@ static ssize_t show_turn_on_status_2(struct device *dev,
 	return sprintf(buf, "%#x\n", (value & 0x1));
 }
 
-static ssize_t show_ab9540_dbbrstn(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t dbbrstn_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
 {
 	struct ab8500 *ab8500;
 	int ret;
@@ -945,7 +945,7 @@ static ssize_t show_ab9540_dbbrstn(struct device *dev,
 			(value & AB9540_MODEM_CTRL2_SWDBBRSTN_BIT) ? 1 : 0);
 }
 
-static ssize_t store_ab9540_dbbrstn(struct device *dev,
+static ssize_t dbbrstn_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct ab8500 *ab8500;
@@ -980,12 +980,11 @@ static ssize_t store_ab9540_dbbrstn(struct device *dev,
 	return ret;
 }
 
-static DEVICE_ATTR(chip_id, S_IRUGO, show_chip_id, NULL);
-static DEVICE_ATTR(switch_off_status, S_IRUGO, show_switch_off_status, NULL);
-static DEVICE_ATTR(turn_on_status, S_IRUGO, show_turn_on_status, NULL);
-static DEVICE_ATTR(turn_on_status_2, S_IRUGO, show_turn_on_status_2, NULL);
-static DEVICE_ATTR(dbbrstn, S_IRUGO | S_IWUSR,
-			show_ab9540_dbbrstn, store_ab9540_dbbrstn);
+static DEVICE_ATTR_RO(chip_id);
+static DEVICE_ATTR_RO(switch_off_status);
+static DEVICE_ATTR_RO(turn_on_status);
+static DEVICE_ATTR_RO(turn_on_status_2);
+static DEVICE_ATTR_RW(dbbrstn);
 
 static struct attribute *ab8500_sysfs_entries[] = {
 	&dev_attr_chip_id.attr,
-- 
2.26.0.106.g9fadedd


