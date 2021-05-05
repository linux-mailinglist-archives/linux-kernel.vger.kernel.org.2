Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE59D3748C7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 21:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbhEETj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 15:39:58 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:54914 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhEETjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 15:39:54 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d16 with ME
        id 17es2500B21Fzsu037eswd; Wed, 05 May 2021 21:38:55 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 05 May 2021 21:38:55 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     fbarrat@linux.ibm.com, ajd@linux.ibm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, mpe@ellerman.id.au,
        imunsie@au1.ibm.com, mikey@neuling.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] cxl: Fix an error message
Date:   Wed,  5 May 2021 21:38:49 +0200
Message-Id: <fa2b2c9c72335ab4c3d5e6a33415e7f020b1d51b.1620243401.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'rc' is known to be 0 here.
Initialize 'rc' with the expected error code before using it.

While at it, avoid the affectation of 'rc' in a 'if' to make things more
obvious and linux style.

Fixes: f204e0b8ce ("cxl: Driver code for powernv PCIe based cards for userspace access")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/misc/cxl/file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index bd3bd32333c5..3dbdce96fae0 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -569,7 +569,8 @@ static int cxl_add_chardev(struct cxl_afu *afu, dev_t devt, struct cdev *cdev,
 	int rc;
 
 	cdev_init(cdev, fops);
-	if ((rc = cdev_add(cdev, devt, 1))) {
+	rc = cdev_add(cdev, devt, 1);
+	if (rc) {
 		dev_err(&afu->dev, "Unable to add %s chardev: %i\n", desc, rc);
 		return rc;
 	}
@@ -577,8 +578,8 @@ static int cxl_add_chardev(struct cxl_afu *afu, dev_t devt, struct cdev *cdev,
 	dev = device_create(cxl_class, &afu->dev, devt, afu,
 			"afu%i.%i%s", afu->adapter->adapter_num, afu->slice, postfix);
 	if (IS_ERR(dev)) {
-		dev_err(&afu->dev, "Unable to create %s chardev in sysfs: %i\n", desc, rc);
 		rc = PTR_ERR(dev);
+		dev_err(&afu->dev, "Unable to create %s chardev in sysfs: %i\n", desc, rc);
 		goto err;
 	}
 
-- 
2.30.2

