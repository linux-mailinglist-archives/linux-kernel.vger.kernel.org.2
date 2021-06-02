Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4703983A2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 09:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhFBHy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 03:54:28 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2951 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbhFBHyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 03:54:20 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fw1Q94xTbz690V;
        Wed,  2 Jun 2021 15:49:37 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 15:52:34 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 15:52:34 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] rapidio: use DEVICE_ATTR_RO macro
Date:   Wed, 2 Jun 2021 15:52:29 +0800
Message-ID: <20210602075229.11064-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR_RO macro helper instead of plain DEVICE_ATTR, which makes
the code a bit shorter and easier to read.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/rapidio/switches/idt_gen2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rapidio/switches/idt_gen2.c b/drivers/rapidio/switches/idt_gen2.c
index 8a89bba17d39900..0fb91e6c691f456 100644
--- a/drivers/rapidio/switches/idt_gen2.c
+++ b/drivers/rapidio/switches/idt_gen2.c
@@ -366,7 +366,7 @@ idtg2_em_handler(struct rio_dev *rdev, u8 portnum)
 }
 
 static ssize_t
-idtg2_show_errlog(struct device *dev, struct device_attribute *attr, char *buf)
+errlog_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct rio_dev *rdev = to_rio_dev(dev);
 	ssize_t len = 0;
@@ -384,7 +384,7 @@ idtg2_show_errlog(struct device *dev, struct device_attribute *attr, char *buf)
 	return len;
 }
 
-static DEVICE_ATTR(errlog, S_IRUGO, idtg2_show_errlog, NULL);
+static DEVICE_ATTR_RO(errlog);
 
 static int idtg2_sysfs(struct rio_dev *rdev, bool create)
 {
-- 
2.26.0.106.g9fadedd


