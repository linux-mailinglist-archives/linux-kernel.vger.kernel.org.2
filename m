Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9899534A1ED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 07:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhCZGfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 02:35:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14558 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhCZGfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 02:35:02 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F6BwW2znDzNmtC;
        Fri, 26 Mar 2021 14:32:27 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Fri, 26 Mar 2021 14:34:51 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <zhengyongjun3@huawei.com>, Karol Gugala <kgugala@antmicro.com>,
        "Mateusz Holenko" <mholenko@antmicro.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Hulk Robot" <hulkci@huawei.com>
Subject: [PATCH -next] drivers/soc/litex: remove duplicated include from litex_soc_ctrl.c
Date:   Fri, 26 Mar 2021 14:48:44 +0800
Message-ID: <20210326064844.3263103-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.104.82]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicated include.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/soc/litex/litex_soc_ctrl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/litex/litex_soc_ctrl.c b/drivers/soc/litex/litex_soc_ctrl.c
index 6268bfa7f0d6..c3e379a990f2 100644
--- a/drivers/soc/litex/litex_soc_ctrl.c
+++ b/drivers/soc/litex/litex_soc_ctrl.c
@@ -13,7 +13,6 @@
 #include <linux/platform_device.h>
 #include <linux/printk.h>
 #include <linux/module.h>
-#include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/reboot.h>
 

