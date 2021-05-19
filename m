Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDC7388650
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 07:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbhESFET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 01:04:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3029 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbhESFES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 01:04:18 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FlLKk25WHzmXBc;
        Wed, 19 May 2021 13:00:42 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 13:02:58 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 19 May
 2021 13:02:57 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <maz@kernel.org>
Subject: [PATCH -next] irqchip/mbigen: fix compile warning when CONFIG_ACPI is disabled
Date:   Wed, 19 May 2021 13:04:55 +0800
Message-ID: <20210519050455.1693953-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following compile warning:

  drivers/irqchip/irq-mbigen.c:372:36: warning: ‘mbigen_acpi_match’ defined but not used [-Wunused-const-variable=]
   static const struct acpi_device_id mbigen_acpi_match[] = {

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/irqchip/irq-mbigen.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 2cb45c6b8501..f565317a3da3 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -273,6 +273,12 @@ static int mbigen_of_create_domain(struct platform_device *pdev,
 }
 
 #ifdef CONFIG_ACPI
+static const struct acpi_device_id mbigen_acpi_match[] = {
+	{ "HISI0152", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, mbigen_acpi_match);
+
 static int mbigen_acpi_create_domain(struct platform_device *pdev,
 				     struct mbigen_device *mgn_chip)
 {
@@ -369,12 +375,6 @@ static const struct of_device_id mbigen_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mbigen_of_match);
 
-static const struct acpi_device_id mbigen_acpi_match[] = {
-	{ "HISI0152", 0 },
-	{}
-};
-MODULE_DEVICE_TABLE(acpi, mbigen_acpi_match);
-
 static struct platform_driver mbigen_platform_driver = {
 	.driver = {
 		.name		= "Hisilicon MBIGEN-V2",
-- 
2.25.1

