Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C5838D414
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 08:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhEVG4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 02:56:20 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:50322 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230001AbhEVG4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 02:56:19 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d71 with ME
        id 7iut2500C21Fzsu03iutd4; Sat, 22 May 2021 08:54:54 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 22 May 2021 08:54:54 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     arnd@arndb.de, gregkh@linuxfoundation.org,
        mihai.carabas@oracle.com, andriy.shevchenko@linux.intel.com,
        pizhenwei@bytedance.com, pbonzini@redhat.com,
        bobo.shaobowang@huawei.com, linqiheng@huawei.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 2/5] misc/pvpanic-pci: Use GFP_KERNEL instead of GFP_ATOMIC
Date:   Sat, 22 May 2021 08:54:52 +0200
Message-Id: <5ea4fb9802f7b780cc3e5ae768561a0372a39ebb.1621665058.git.christophe.jaillet@wanadoo.fr>
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
v2: add -pci in the description of the commit
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

