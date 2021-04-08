Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD95A358412
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhDHNDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:03:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16411 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhDHNDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:03:17 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FGLx90fmpzkjg5;
        Thu,  8 Apr 2021 21:01:17 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 21:02:55 +0800
From:   Chen Huang <chenhuang5@huawei.com>
To:     Evgeniy Polyakov <zbr@ioremap.net>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Chen Huang" <chenhuang5@huawei.com>
Subject: [PATCH -next 2/2] w1: ds28e17: Use module_w1_family to simplify the code
Date:   Thu, 8 Apr 2021 13:09:54 +0000
Message-ID: <20210408130954.1158963-2-chenhuang5@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408130954.1158963-1-chenhuang5@huawei.com>
References: <20210408130954.1158963-1-chenhuang5@huawei.com>
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
 drivers/w1/slaves/w1_ds28e17.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds28e17.c b/drivers/w1/slaves/w1_ds28e17.c
index 6b00db7169ab..aed10b72fc99 100644
--- a/drivers/w1/slaves/w1_ds28e17.c
+++ b/drivers/w1/slaves/w1_ds28e17.c
@@ -752,18 +752,4 @@ static struct w1_family w1_family_19 = {
 	.fops = &w1_f19_fops,
 };
 
-
-/* Module init and remove functions. */
-static int __init w1_f19_init(void)
-{
-	return w1_register_family(&w1_family_19);
-}
-
-static void __exit w1_f19_fini(void)
-{
-	w1_unregister_family(&w1_family_19);
-}
-
-module_init(w1_f19_init);
-module_exit(w1_f19_fini);
-
+module_w1_family(w1_family_19);
-- 
2.17.1

