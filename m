Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1EE42FB75
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 20:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241943AbhJOSxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 14:53:55 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:57903 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241925AbhJOSxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 14:53:54 -0400
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 096282B1;
        Fri, 15 Oct 2021 11:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1634323907;
        bh=AezE/UqyGxsDzy1We/7x0OMj8tS2QaSlROEBATVr1F0=;
        h=From:To:Cc:Subject:Date:From;
        b=OAwP3QFC8t9LdMSjKT+4DWtey+rZZv1PR6BpuxdwVeMh4h8gNGKqgTywyyvFYgZ0p
         p9LHbYylGnBdGMJCdVLQxfRmULUziwdH/ripZUncjMWZB/oST3zbwOhmLAihzOT1sQ
         1CQP8/GLE9bH4gMBLnc9lWy9AbnWfnhOBDo5Qvao=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     linux-mtd@lists.infradead.org
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Tian Tao <tiantao6@hisilicon.com>, Petr Malat <oss@malat.biz>,
        Jon Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: core: clear out unregistered devices a bit more
Date:   Fri, 15 Oct 2021 11:50:48 -0700
Message-Id: <20211015185049.3318-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows an MTD device that has been unregistered to be easily
re-registered later without triggering spurious "already registered"
warnings in mtd_device_parse_register() and add_mtd_device().

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/mtd/mtdcore.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 153229198947..0a0fca737d43 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -747,6 +747,9 @@ int del_mtd_device(struct mtd_info *mtd)
 
 		device_unregister(&mtd->dev);
 
+		/* Clear dev so mtd can be safely re-registered later if desired */
+		memset(&mtd->dev, 0, sizeof(mtd->dev));
+
 		idr_remove(&mtd_idr, mtd->index);
 		of_node_put(mtd_get_of_node(mtd));
 
@@ -1018,8 +1021,10 @@ int mtd_device_unregister(struct mtd_info *master)
 {
 	int err;
 
-	if (master->_reboot)
+	if (master->_reboot) {
 		unregister_reboot_notifier(&master->reboot_notifier);
+		memset(&master->reboot_notifier, 0, sizeof(master->reboot_notifier));
+	}
 
 	if (master->otp_user_nvmem)
 		nvmem_unregister(master->otp_user_nvmem);
-- 
2.33.0

