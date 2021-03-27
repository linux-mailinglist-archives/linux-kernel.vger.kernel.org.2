Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AA834B5CA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 10:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhC0JxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 05:53:10 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15008 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbhC0Jwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 05:52:49 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F6vG61mvszPvLw;
        Sat, 27 Mar 2021 17:50:06 +0800 (CST)
Received: from huawei.com (10.67.174.78) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Sat, 27 Mar 2021
 17:52:32 +0800
From:   Chen Lifu <chenlifu@huawei.com>
To:     <chenlifu@huawei.com>, Russell King <linux@armlinux.org.uk>
CC:     <heying24@huawei.com>, <yuehaibing@huawei.com>,
        <weiyongjun1@huawei.com>, <johnny.chenyi@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] i2c: gpio: use DEFINE_SPINLOCK() for spinlock
Date:   Sat, 27 Mar 2021 17:52:28 +0800
Message-ID: <20210327095228.105123-1-chenlifu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.174.78]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lifu Chen <chenlifu@huawei.com>

spinlock can be initialized automatically with DEFINE_SPINLOCK()
rather than explicitly calling spin_lock_init().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Lifu Chen <chenlifu@huawei.com>
---
 arch/arm/mach-sa1100/simpad.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index c7fb9a73e4c5..c183432880d3 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -45,7 +45,7 @@
  */
 
 static long cs3_shadow;
-static spinlock_t cs3_lock;
+static DEFINE_SPINLOCK(cs3_lock);
 static struct gpio_chip cs3_gpio;
 
 long simpad_get_cs3_ro(void)
@@ -379,8 +379,6 @@ static int __init simpad_init(void)
 {
 	int ret;
 
-	spin_lock_init(&cs3_lock);
-
 	cs3_gpio.label = "simpad_cs3";
 	cs3_gpio.base = SIMPAD_CS3_GPIO_BASE;
 	cs3_gpio.ngpio = 24;

