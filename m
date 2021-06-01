Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795FC396DBE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 09:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhFAHIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 03:08:24 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3311 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhFAHIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 03:08:22 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FvNPf0Lwfz19VQp;
        Tue,  1 Jun 2021 15:01:58 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 15:06:38 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 15:06:37 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Lee Jones <lee.jones@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] mfd: 88pm800: Use DEFINE_RES_IRQ_NAMED() to simplify code
Date:   Tue, 1 Jun 2021 15:06:30 +0800
Message-ID: <20210601070630.10204-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/mfd/88pm800.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
index c7f964996a91717..eaf9845633b4d60 100644
--- a/drivers/mfd/88pm800.c
+++ b/drivers/mfd/88pm800.c
@@ -122,12 +122,7 @@ static const struct i2c_device_id pm80x_id_table[] = {
 MODULE_DEVICE_TABLE(i2c, pm80x_id_table);
 
 static const struct resource rtc_resources[] = {
-	{
-	 .name = "88pm80x-rtc",
-	 .start = PM800_IRQ_RTC,
-	 .end = PM800_IRQ_RTC,
-	 .flags = IORESOURCE_IRQ,
-	 },
+	DEFINE_RES_IRQ_NAMED(PM800_IRQ_RTC, "88pm80x-rtc"),
 };
 
 static struct mfd_cell rtc_devs[] = {
@@ -140,12 +135,7 @@ static struct mfd_cell rtc_devs[] = {
 };
 
 static struct resource onkey_resources[] = {
-	{
-	 .name = "88pm80x-onkey",
-	 .start = PM800_IRQ_ONKEY,
-	 .end = PM800_IRQ_ONKEY,
-	 .flags = IORESOURCE_IRQ,
-	 },
+	DEFINE_RES_IRQ_NAMED(PM800_IRQ_ONKEY, "88pm80x-onkey"),
 };
 
 static const struct mfd_cell onkey_devs[] = {
-- 
2.26.0.106.g9fadedd


