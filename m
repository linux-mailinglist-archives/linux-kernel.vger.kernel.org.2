Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67F1381F67
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 17:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbhEPPBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 11:01:49 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:36010 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhEPPBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 11:01:45 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d20 with ME
        id 5T0U2500D21Fzsu03T0VBA; Sun, 16 May 2021 17:00:29 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 16 May 2021 17:00:29 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     arnd@arndb.de, gregkh@linuxfoundation.org,
        mihai.carabas@oracle.com, andriy.shevchenko@linux.intel.com,
        pizhenwei@bytedance.com, pbonzini@redhat.com,
        bobo.shaobowang@huawei.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] misc/pvpanic: Fix error handling in 'pvpanic_mmio_probe()'
Date:   Sun, 16 May 2021 17:00:27 +0200
Message-Id: <d6e7bf6eb6e482c387124e815edc0e0edaebafe8.1621177126.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
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

