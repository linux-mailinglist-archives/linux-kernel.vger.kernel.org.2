Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED98B316055
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 08:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbhBJHuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 02:50:07 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12505 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbhBJHsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 02:48:47 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DbBfS045bzjLJl;
        Wed, 10 Feb 2021 15:46:40 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Wed, 10 Feb 2021 15:47:53 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>, Lee Jones <lee.jones@linaro.org>,
        "Hans de Goede" <hdegoede@redhat.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] mfd: arizona: Make some symbols static
Date:   Wed, 10 Feb 2021 07:56:26 +0000
Message-ID: <20210210075626.1096193-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

drivers/mfd/arizona-spi.c:28:31: warning:
 symbol 'reset_gpios' was not declared. Should it be static?
drivers/mfd/arizona-spi.c:29:31: warning:
 symbol 'ldoena_gpios' was not declared. Should it be static?

Those symbols are not used outside of arizona-spi.c, so this
commit marks them static.

Fixes: e933836744a2 ("mfd: arizona: Add support for ACPI enumeration of WM5102 connected over SPI")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/mfd/arizona-spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
index 24a2c75d691a..aa1d6f94ae53 100644
--- a/drivers/mfd/arizona-spi.c
+++ b/drivers/mfd/arizona-spi.c
@@ -25,8 +25,8 @@
 #include "arizona.h"
 
 #ifdef CONFIG_ACPI
-const struct acpi_gpio_params reset_gpios = { 1, 0, false };
-const struct acpi_gpio_params ldoena_gpios = { 2, 0, false };
+static const struct acpi_gpio_params reset_gpios = { 1, 0, false };
+static const struct acpi_gpio_params ldoena_gpios = { 2, 0, false };
 
 static const struct acpi_gpio_mapping arizona_acpi_gpios[] = {
 	{ "reset-gpios", &reset_gpios, 1, },

