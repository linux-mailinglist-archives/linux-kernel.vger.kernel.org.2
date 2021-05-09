Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289DA3775D5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 09:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhEIHyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 03:54:31 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:23520 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhEIHy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 03:54:27 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d86 with ME
        id 2XtN2500C21Fzsu03XtNRd; Sun, 09 May 2021 09:53:23 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 09 May 2021 09:53:23 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     brandon@ifup.org, hjk@linutronix.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] uio: uio_aec: Use pci_iounmap instead of iounmap
Date:   Sun,  9 May 2021 09:53:21 +0200
Message-Id: <f6b2a09a45658e8ef552aa34f0b8615dc1c35838.1620546705.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'pci_iomap()' is used in the probe and 'pci_iounmap()' in the error
handling path of the probe.
So keep things consistent and use 'pci_iounmap()' also in the remove
function.

Fixes: 1bafeb378e91 ("uio: add the uio_aec driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/uio/uio_aec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/uio/uio_aec.c b/drivers/uio/uio_aec.c
index 32357f8a92b5..64eafd59e6e7 100644
--- a/drivers/uio/uio_aec.c
+++ b/drivers/uio/uio_aec.c
@@ -133,7 +133,7 @@ static void remove(struct pci_dev *pdev)
 	uio_unregister_device(info);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
-	iounmap(info->priv);
+	pci_iounmap(pdev, info->priv);
 }
 
 static struct pci_driver pci_driver = {
-- 
2.30.2

