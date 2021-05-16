Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A484D381F4A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 16:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbhEPOi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 10:38:29 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:42604 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbhEPOi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 10:38:27 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d20 with ME
        id 5SdB2500N21Fzsu03SdBWp; Sun, 16 May 2021 16:37:12 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 16 May 2021 16:37:12 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     arnd@arndb.de, gregkh@linuxfoundation.org,
        mihai.carabas@oracle.com, andriy.shevchenko@linux.intel.com,
        pizhenwei@bytedance.com, pbonzini@redhat.com, linqiheng@huawei.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] misc/pvpanic: Use GFP_KERNEL instead of GFP_ATOMIC
Date:   Sun, 16 May 2021 16:37:09 +0200
Message-Id: <492077a2f193c9ae8e2d066681d426fba44a372e.1621175108.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <7efa7b4b9867ac44f398783b89f3a21deac4ce8b.1621175108.git.christophe.jaillet@wanadoo.fr>
References: <7efa7b4b9867ac44f398783b89f3a21deac4ce8b.1621175108.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to use GFP_ATOMIC in a probe function. Use GFP_KERNEL
instead.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/misc/pvpanic/pvpanic-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
index 046ce4ecc195..3d7f9efb3dd4 100644
--- a/drivers/misc/pvpanic/pvpanic-pci.c
+++ b/drivers/misc/pvpanic/pvpanic-pci.c
@@ -86,7 +86,7 @@ static int pvpanic_pci_probe(struct pci_dev *pdev,
 	if (!base)
 		return -ENOMEM;
 
-	pi = devm_kmalloc(&pdev->dev, sizeof(*pi), GFP_ATOMIC);
+	pi = devm_kmalloc(&pdev->dev, sizeof(*pi), GFP_KERNEL);
 	if (!pi)
 		return -ENOMEM;
 
-- 
2.30.2

