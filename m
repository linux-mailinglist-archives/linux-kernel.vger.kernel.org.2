Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1652942E2DB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 22:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhJNUmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 16:42:11 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:43705 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbhJNUmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 16:42:10 -0400
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 2C74656;
        Thu, 14 Oct 2021 13:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1634244004;
        bh=4iQHDwm01Ka+yRVl8YzQ6q3/Kv6R+IAV1avi97RanDU=;
        h=From:To:Cc:Subject:Date:From;
        b=WI5LvAuDp5iyE+NOq0cm48NL+KnfRIP4Sv+l6LOhjevq5e9w0xzYx5/Uq1ilsXQlk
         Nka2LYG+Lcj6hO8vKpuWdLJizvAma5LAUP+tyL8KIau7oGYIJT1Qum9PzIAXhshHUn
         LbkHHoTmfBeYL/rxQXrn023fKz7DlXG0Hu/cVBCg=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     linux-mtd@lists.infradead.org
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        Jon Hunter <jonathanh@nvidia.com>, Petr Malat <oss@malat.biz>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Mario Rugiero <mrugiero@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: core: don't remove debugfs directory if device is in use
Date:   Thu, 14 Oct 2021 13:39:52 -0700
Message-Id: <20211014203953.5424-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, if del_mtd_device() failed with -EBUSY due to a non-zero
usecount, a subsequent call to attempt the deletion again would try to
remove a debugfs directory that had already been removed and panic.
With this change the second call can instead proceed safely.

Fixes: e8e3edb95ce6 ("mtd: create per-device and module-scope debugfs entries")
Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/mtd/mtdcore.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index e22266f63ae9..0a0fca737d43 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -724,8 +724,6 @@ int del_mtd_device(struct mtd_info *mtd)
 
 	mutex_lock(&mtd_table_mutex);
 
-	debugfs_remove_recursive(mtd->dbg.dfs_dir);
-
 	if (idr_find(&mtd_idr, mtd->index) != mtd) {
 		ret = -ENODEV;
 		goto out_error;
@@ -741,6 +739,8 @@ int del_mtd_device(struct mtd_info *mtd)
 		       mtd->index, mtd->name, mtd->usecount);
 		ret = -EBUSY;
 	} else {
+		debugfs_remove_recursive(mtd->dbg.dfs_dir);
+
 		/* Try to remove the NVMEM provider */
 		if (mtd->nvmem)
 			nvmem_unregister(mtd->nvmem);
-- 
2.33.0

