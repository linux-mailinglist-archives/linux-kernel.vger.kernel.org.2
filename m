Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3FC538D416
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 08:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhEVG4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 02:56:32 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:38783 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230001AbhEVG43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 02:56:29 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d71 with ME
        id 7iv42500921Fzsu03iv4dv; Sat, 22 May 2021 08:55:04 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 22 May 2021 08:55:04 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     arnd@arndb.de, gregkh@linuxfoundation.org,
        mihai.carabas@oracle.com, andriy.shevchenko@linux.intel.com,
        pizhenwei@bytedance.com, pbonzini@redhat.com,
        bobo.shaobowang@huawei.com, linqiheng@huawei.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 3/5] misc/pvpanic-mmio: Fix error handling in 'pvpanic_mmio_probe()'
Date:   Sat, 22 May 2021 08:55:03 +0200
Message-Id: <2a5dab18f10db783b27e0579ba66cc38d610734a.1621665058.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1621665058.git.christophe.jaillet@wanadoo.fr>
References: <cover.1621665058.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no error handling path in the probe function.
Switch to managed resource so that errors in the probe are handled easily
and simplify the remove function accordingly.

Fixes: b3c0f8774668 ("misc/pvpanic: probe multiple instances")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: add -mmio in the description of the commit
---
 drivers/misc/pvpanic/pvpanic-mmio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/pvpanic/pvpanic-mmio.c b/drivers/misc/pvpanic/pvpanic-mmio.c
index 4c0841776087..69b31f7adf4f 100644
--- a/drivers/misc/pvpanic/pvpanic-mmio.c
+++ b/drivers/misc/pvpanic/pvpanic-mmio.c
@@ -93,7 +93,7 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	pi = kmalloc(sizeof(*pi), GFP_ATOMIC);
+	pi = devm_kmalloc(dev, sizeof(*pi), GFP_ATOMIC);
 	if (!pi)
 		return -ENOMEM;
 
@@ -114,7 +114,6 @@ static int pvpanic_mmio_remove(struct platform_device *pdev)
 	struct pvpanic_instance *pi = dev_get_drvdata(&pdev->dev);
 
 	pvpanic_remove(pi);
-	kfree(pi);
 
 	return 0;
 }
-- 
2.30.2

