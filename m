Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FEC392A10
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 10:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbhE0Ivc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 04:51:32 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5109 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbhE0IvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 04:51:11 -0400
Received: from dggeml712-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FrLz45GX3zYn4g;
        Thu, 27 May 2021 16:46:56 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggeml712-chm.china.huawei.com (10.3.17.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 27 May 2021 16:49:36 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 27 May
 2021 16:49:35 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <mbroemme@libmpq.org>, <linux-fbdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] video: fbdev: intelfb: Remove set but not used variable 'val'
Date:   Thu, 27 May 2021 16:59:04 +0800
Message-ID: <20210527085904.3861173-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/video/fbdev/intelfb/intelfb_i2c.c: In function 'intelfb_gpio_setscl':
drivers/video/fbdev/intelfb/intelfb_i2c.c:58:6: warning:
 variable ‘val’ set but not used [-Wunused-but-set-variable]
drivers/video/fbdev/intelfb/intelfb_i2c.c: In function 'intelfb_gpio_setsda':
drivers/video/fbdev/intelfb/intelfb_i2c.c:69:6: warning:
 variable ‘val’ set but not used [-Wunused-but-set-variable]

It never used since introduction.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 drivers/video/fbdev/intelfb/intelfb_i2c.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/intelfb/intelfb_i2c.c b/drivers/video/fbdev/intelfb/intelfb_i2c.c
index 3300bd31d9d7..4df2f1f8a18e 100644
--- a/drivers/video/fbdev/intelfb/intelfb_i2c.c
+++ b/drivers/video/fbdev/intelfb/intelfb_i2c.c
@@ -55,22 +55,20 @@ static void intelfb_gpio_setscl(void *data, int state)
 {
 	struct intelfb_i2c_chan *chan = data;
 	struct intelfb_info *dinfo = chan->dinfo;
-	u32 val;
 
 	OUTREG(chan->reg, (state ? SCL_VAL_OUT : 0) |
 	       SCL_DIR | SCL_DIR_MASK | SCL_VAL_MASK);
-	val = INREG(chan->reg);
+	INREG(chan->reg);
 }
 
 static void intelfb_gpio_setsda(void *data, int state)
 {
 	struct intelfb_i2c_chan *chan = data;
 	struct intelfb_info *dinfo = chan->dinfo;
-	u32 val;
 
 	OUTREG(chan->reg, (state ? SDA_VAL_OUT : 0) |
 	       SDA_DIR | SDA_DIR_MASK | SDA_VAL_MASK);
-	val = INREG(chan->reg);
+	INREG(chan->reg);
 }
 
 static int intelfb_gpio_getscl(void *data)
-- 
2.25.4

