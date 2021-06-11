Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD06E3A3D98
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 09:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhFKH4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 03:56:45 -0400
Received: from m12-14.163.com ([220.181.12.14]:43088 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229733AbhFKH4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 03:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=PAQZt
        YbOUKIUtGF0tVsvHsRvw4/iH/MayKKZuzkWlLI=; b=VGNo25daxYDACzdMh2Xq6
        HX9fvEuMhEk/H3wy6sYTCESy4UeX0JAu679inFT8SDZYGv+m9rCi0rJB2T+JGNML
        25WcJ63QFFsTZ95kYK/TEEwZeqwSjH71dLe9TV/+Lw/Tm0vU6n5STG+1LIGGlPDg
        hHonWlv2eGNIXq3Nua+WsE=
Received: from COOL-20201222LC.ccdomain.com (unknown [218.94.48.178])
        by smtp10 (Coremail) with SMTP id DsCowAB3L21zFsNgwfyzOA--.22392S2;
        Fri, 11 Jun 2021 15:53:26 +0800 (CST)
From:   dingsenjie@163.com
To:     jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        dingsenjie <dingsenjie@yulong.com>
Subject: [PATCH] fsi: fsi-scom: Use module_fsi_driver to simplify the code
Date:   Fri, 11 Jun 2021 15:52:36 +0800
Message-Id: <20210611075236.59788-1-dingsenjie@163.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowAB3L21zFsNgwfyzOA--.22392S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw47Ar1xKw13CF1xtw47Arb_yoW3AFX_Ca
        48Z3ZrGr4UWFy7C34Dtw4YvryF9Fy5WFs3ZF4jqFZxKwnrZw1rAr1q9FW7XF4UWr4UAFWk
        A34xZF1ftr18JjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0m9aDUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5glqw25hqmxvi6rwjhhfrp/1tbiZRauyF8ZPFl4iQAAsH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dingsenjie <dingsenjie@yulong.com>

Simplify the code by using module_fsi_driver macro.

Signed-off-by: dingsenjie <dingsenjie@yulong.com>
---
 drivers/fsi/fsi-scom.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
index b45bfab..91bb413 100644
--- a/drivers/fsi/fsi-scom.c
+++ b/drivers/fsi/fsi-scom.c
@@ -645,16 +645,5 @@ static int scom_remove(struct device *dev)
 	}
 };
 
-static int scom_init(void)
-{
-	return fsi_driver_register(&scom_drv);
-}
-
-static void scom_exit(void)
-{
-	fsi_driver_unregister(&scom_drv);
-}
-
-module_init(scom_init);
-module_exit(scom_exit);
+module_fsi_driver(scom_drv);
 MODULE_LICENSE("GPL");
-- 
1.9.1

