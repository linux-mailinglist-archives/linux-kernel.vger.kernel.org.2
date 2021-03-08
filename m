Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C046B330D6B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 13:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhCHMXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 07:23:32 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13073 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbhCHMXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 07:23:09 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DvHVq6PV9zMkVJ;
        Mon,  8 Mar 2021 20:20:51 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Mon, 8 Mar 2021 20:22:57 +0800
From:   'Wei Yongjun <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>, Lee Jones <lee.jones@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Hulk Robot" <hulkci@huawei.com>
Subject: [PATCH -next RESEND] mfd: ene-kb3930: Make symbol 'kb3930_power_off' static
Date:   Mon, 8 Mar 2021 12:31:47 +0000
Message-ID: <20210308123147.2340998-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

The sparse tool complains as follows:

drivers/mfd/ene-kb3930.c:36:15: warning:
 symbol 'kb3930_power_off' was not declared. Should it be static?

This symbol is not used outside of ene-kb3930.c, so this
commit marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/mfd/ene-kb3930.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ene-kb3930.c b/drivers/mfd/ene-kb3930.c
index 83243e668e3f..1b73318d1f1f 100644
--- a/drivers/mfd/ene-kb3930.c
+++ b/drivers/mfd/ene-kb3930.c
@@ -33,7 +33,7 @@ struct kb3930 {
 	struct gpio_descs *off_gpios;
 };
 
-struct kb3930 *kb3930_power_off;
+static struct kb3930 *kb3930_power_off;
 
 #define EC_GPIO_WAVE		0
 #define EC_GPIO_OFF_MODE	1

