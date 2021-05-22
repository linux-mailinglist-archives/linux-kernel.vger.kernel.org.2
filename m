Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE4038D418
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 08:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhEVG4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 02:56:41 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:20781 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230117AbhEVG4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 02:56:38 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d71 with ME
        id 7ivD2500721Fzsu03ivDem; Sat, 22 May 2021 08:55:13 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 22 May 2021 08:55:13 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     arnd@arndb.de, gregkh@linuxfoundation.org,
        mihai.carabas@oracle.com, andriy.shevchenko@linux.intel.com,
        pizhenwei@bytedance.com, pbonzini@redhat.com,
        bobo.shaobowang@huawei.com, linqiheng@huawei.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 4/5] misc/pvpanic-mmio: Use GFP_KERNEL instead of GFP_ATOMIC
Date:   Sat, 22 May 2021 08:55:12 +0200
Message-Id: <58cc7f12535a796a0ef1a699bcba61e45ab8a2ad.1621665058.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1621665058.git.christophe.jaillet@wanadoo.fr>
References: <cover.1621665058.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to use GFP_ATOMIC in a probe function. Use GFP_KERNEL
instead.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: add -mmio in the description of the commit
---
 drivers/misc/pvpanic/pvpanic-mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/pvpanic/pvpanic-mmio.c b/drivers/misc/pvpanic/pvpanic-mmio.c
index 69b31f7adf4f..d4a407956c07 100644
--- a/drivers/misc/pvpanic/pvpanic-mmio.c
+++ b/drivers/misc/pvpanic/pvpanic-mmio.c
@@ -93,7 +93,7 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	pi = devm_kmalloc(dev, sizeof(*pi), GFP_ATOMIC);
+	pi = devm_kmalloc(dev, sizeof(*pi), GFP_KERNEL);
 	if (!pi)
 		return -ENOMEM;
 
-- 
2.30.2

