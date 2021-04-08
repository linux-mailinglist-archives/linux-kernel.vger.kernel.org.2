Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B68E358413
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhDHNDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:03:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16410 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhDHNDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:03:17 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FGLx90tJWzkjgD;
        Thu,  8 Apr 2021 21:01:17 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 21:02:54 +0800
From:   Chen Huang <chenhuang5@huawei.com>
To:     Evgeniy Polyakov <zbr@ioremap.net>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Chen Huang" <chenhuang5@huawei.com>
Subject: [PATCH -next 1/2] w1: ds2805: Use module_w1_family to simplify the code
Date:   Thu, 8 Apr 2021 13:09:53 +0000
Message-ID: <20210408130954.1158963-1-chenhuang5@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

module_w1_family() makes the code simpler by eliminating
boilerplate code.

Signed-off-by: Chen Huang <chenhuang5@huawei.com>
---
 drivers/w1/slaves/w1_ds2805.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2805.c b/drivers/w1/slaves/w1_ds2805.c
index 206186db727d..6b5d12ba1b65 100644
--- a/drivers/w1/slaves/w1_ds2805.c
+++ b/drivers/w1/slaves/w1_ds2805.c
@@ -291,20 +291,7 @@ static struct w1_family w1_family_0d = {
 	.fops = &w1_f0d_fops,
 };
 
-static int __init w1_f0d_init(void)
-{
-	pr_info("%s()\n", __func__);
-	return w1_register_family(&w1_family_0d);
-}
-
-static void __exit w1_f0d_fini(void)
-{
-	pr_info("%s()\n", __func__);
-	w1_unregister_family(&w1_family_0d);
-}
-
-module_init(w1_f0d_init);
-module_exit(w1_f0d_fini);
+module_w1_family(w1_family_0d);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Andrew Worsley amworsley@gmail.com");
-- 
2.17.1

