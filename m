Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AEE398881
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhFBLpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:45:54 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:4285 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhFBLpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:45:41 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Fw6W60lwZz19S6K;
        Wed,  2 Jun 2021 19:39:14 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 19:43:56 +0800
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
Subject: [PATCH 4/9] mfd: sm501: use DEVICE_ATTR_RO macro
Date:   Wed, 2 Jun 2021 19:43:34 +0800
Message-ID: <20210602114339.11223-5-thunder.leizhen@huawei.com>
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

Use DEVICE_ATTR_RO macro helper instead of plain DEVICE_ATTR, which makes
the code a bit shorter and easier to read.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/mfd/sm501.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index 6d2f4a0a901dc08..bc0a2c38653e51c 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1190,13 +1190,13 @@ static int sm501_register_gpio_i2c(struct sm501_devdata *sm,
 	return 0;
 }
 
-/* sm501_dbg_regs
+/* dbg_regs_show
  *
  * Debug attribute to attach to parent device to show core registers
 */
 
-static ssize_t sm501_dbg_regs(struct device *dev,
-			      struct device_attribute *attr, char *buff)
+static ssize_t dbg_regs_show(struct device *dev,
+			     struct device_attribute *attr, char *buff)
 {
 	struct sm501_devdata *sm = dev_get_drvdata(dev)	;
 	unsigned int reg;
@@ -1213,7 +1213,7 @@ static ssize_t sm501_dbg_regs(struct device *dev,
 }
 
 
-static DEVICE_ATTR(dbg_regs, 0444, sm501_dbg_regs, NULL);
+static DEVICE_ATTR_RO(dbg_regs);
 
 /* sm501_init_reg
  *
-- 
2.26.0.106.g9fadedd


