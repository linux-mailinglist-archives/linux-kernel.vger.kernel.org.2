Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543AC3FE8B0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 07:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhIBFZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 01:25:55 -0400
Received: from mx21.baidu.com ([220.181.3.85]:58652 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230317AbhIBFZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 01:25:54 -0400
Received: from BC-Mail-EX04.internal.baidu.com (unknown [172.31.51.44])
        by Forcepoint Email with ESMTPS id 4590556D924F8741AF07;
        Thu,  2 Sep 2021 13:24:52 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-EX04.internal.baidu.com (172.31.51.44) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 2 Sep 2021 13:24:51 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 2 Sep 2021 13:24:51 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] driver core: platform: Fix the line-break indentation
Date:   Thu, 2 Sep 2021 13:24:45 +0800
Message-ID: <20210902052446.31839-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex12.internal.baidu.com (10.127.64.35) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the line-break indentation for the helper function
devm_platform_get_and_ioremap_resource()

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/base/platform.c         | 2 +-
 include/linux/platform_device.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 652531f67135..52a1b94428c8 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -95,7 +95,7 @@ EXPORT_SYMBOL_GPL(platform_get_mem_or_io);
  */
 void __iomem *
 devm_platform_get_and_ioremap_resource(struct platform_device *pdev,
-				unsigned int index, struct resource **res)
+				       unsigned int index, struct resource **res)
 {
 	struct resource *r;
 
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 7c96f169d274..07e1bba45243 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -61,7 +61,7 @@ platform_find_device_by_driver(struct device *start,
 			       const struct device_driver *drv);
 extern void __iomem *
 devm_platform_get_and_ioremap_resource(struct platform_device *pdev,
-				unsigned int index, struct resource **res);
+				       unsigned int index, struct resource **res);
 extern void __iomem *
 devm_platform_ioremap_resource(struct platform_device *pdev,
 			       unsigned int index);
-- 
2.25.1

