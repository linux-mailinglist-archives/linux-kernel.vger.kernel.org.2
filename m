Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12C83A3DBB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhFKIGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:06:52 -0400
Received: from m12-14.163.com ([220.181.12.14]:51158 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230034AbhFKIGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=vGBxM
        T1PNez76gx44N0IB18IfZDeVXPhMCJ7xA7RwuE=; b=WHROsHUqpy9+9VaGkygWh
        0rZ8BLHPfSdDvJxVTYvdfG53LlxunCCyf7hzxnsu+MqpXrPGw8Wu1KyeoxepIGo2
        rkLKyzk9CftKwdjvPlXphUl11GKieE46AZdZx75n3NhY0umHI/zVW42RT+E1lKo6
        pe7ZwxqAIobIiLChNmkUlY=
Received: from COOL-20201222LC.ccdomain.com (unknown [218.94.48.178])
        by smtp10 (Coremail) with SMTP id DsCowABXWlL1GMNgulm1OA--.30888S2;
        Fri, 11 Jun 2021 16:04:06 +0800 (CST)
From:   dingsenjie@163.com
To:     jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        dingsenjie <dingsenjie@yulong.com>
Subject: [PATCH] fsi: fsi-sbefifo: Use module_fsi_driver to simplify the code
Date:   Fri, 11 Jun 2021 16:03:24 +0800
Message-Id: <20210611080324.60008-1-dingsenjie@163.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowABXWlL1GMNgulm1OA--.30888S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw47Ar1xKw13CF13WF1fCrg_yoWDJrgEka
        sYv3Z7GrW7WFy7G39Iqw4fZr92qFy8uFs3XF1Sqa98Kw17Zw4rAa4jgrW3tw4UWr4rAa9r
        ArsxCF1Fyr1xZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0hmRUUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5glqw25hqmxvi6rwjhhfrp/xtbBRRauyFPAMYa0BQAAsg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dingsenjie <dingsenjie@yulong.com>

Simplify the code by using module_fsi_driver macro.

Signed-off-by: dingsenjie <dingsenjie@yulong.com>
---
 drivers/fsi/fsi-sbefifo.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index bfd5e5d..4ada65aa 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -1046,18 +1046,7 @@ static int sbefifo_remove(struct device *dev)
 	}
 };
 
-static int sbefifo_init(void)
-{
-	return fsi_driver_register(&sbefifo_drv);
-}
-
-static void sbefifo_exit(void)
-{
-	fsi_driver_unregister(&sbefifo_drv);
-}
-
-module_init(sbefifo_init);
-module_exit(sbefifo_exit);
+module_fsi_driver(sbefifo_drv);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Brad Bishop <bradleyb@fuzziesquirrel.com>");
 MODULE_AUTHOR("Eddie James <eajames@linux.vnet.ibm.com>");
-- 
1.9.1

