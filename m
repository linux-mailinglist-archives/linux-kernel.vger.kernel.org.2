Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C85A394A2C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 05:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhE2Dv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 23:51:59 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2086 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhE2Dv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 23:51:56 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FsSBZ1n8LzWpLq;
        Sat, 29 May 2021 11:45:42 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 11:50:19 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 29 May
 2021 11:50:19 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <zbr@ioremap.net>, <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] w1: ds1wm: Remove set but not used variable 'inten'
Date:   Sat, 29 May 2021 11:59:45 +0800
Message-ID: <20210529035945.2754099-1-libaokun1@huawei.com>
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

drivers/w1/masters/ds1wm.c: In function 'ds1wm_probe':
drivers/w1/masters/ds1wm.c:512:5: warning:
 variable ‘inten’ set but not used [-Wunused-but-set-variable]

It never used since introduction.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 drivers/w1/masters/ds1wm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/w1/masters/ds1wm.c b/drivers/w1/masters/ds1wm.c
index f661695fb589..f59d92865ecb 100644
--- a/drivers/w1/masters/ds1wm.c
+++ b/drivers/w1/masters/ds1wm.c
@@ -509,7 +509,6 @@ static int ds1wm_probe(struct platform_device *pdev)
 	struct ds1wm_driver_data *plat;
 	struct resource *res;
 	int ret;
-	u8 inten;
 
 	if (!pdev)
 		return -ENODEV;
@@ -564,7 +563,7 @@ static int ds1wm_probe(struct platform_device *pdev)
 	ds1wm_data->reset_recover_delay = plat->reset_recover_delay;
 
 	/* Mask interrupts, set IAS before claiming interrupt */
-	inten = ds1wm_read_register(ds1wm_data, DS1WM_INT_EN);
+	ds1wm_read_register(ds1wm_data, DS1WM_INT_EN);
 	ds1wm_write_register(ds1wm_data,
 		DS1WM_INT_EN, ds1wm_data->int_en_reg_none);
 
-- 
2.25.4

