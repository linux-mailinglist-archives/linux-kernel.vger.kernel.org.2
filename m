Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EC33F9DA9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 19:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240426AbhH0RSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 13:18:41 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:41540 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240346AbhH0RSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 13:18:38 -0400
Received: from pop-os.home ([90.126.253.178])
        by mwinf5d74 with ME
        id mhHo250013riaq203hHoaS; Fri, 27 Aug 2021 19:17:48 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 27 Aug 2021 19:17:48 +0200
X-ME-IP: 90.126.253.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     eli.billauer@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v1 3/4] char: xillybus: Remove usage of remaining deprecated pci_ API
Date:   Fri, 27 Aug 2021 19:17:47 +0200
Message-Id: <19d67ac0208a609aef1e28278b3f2477aa714029.1630083668.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1630083668.git.christophe.jaillet@wanadoo.fr>
References: <cover.1630083668.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'struct xilly_endpoint' has a 'dev' field which is a 'struct device *' and
a 'pdev' field which is 'struct pci_dev *'.

Both fields are initialized by 'xillybus_init_endpoint()' and in
'xillybus_pcie.c', we have:
	xillybus_init_endpoint(pdev, &pdev->dev, &pci_hw);
                                 ^       ^
        xilly_endpoint.pdev = ___|       |___ = xilly_endpoint.dev
So the modification from pci_ to dma_ function is straightforward.

Update all remaining deprecated pci_ function calls to equivalent
dma_ API function.
Switching from 'ep->pdev' to 'ep->dev' makes the transformation
straightforward.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/char/xillybus/xillybus.h      |  1 -
 drivers/char/xillybus/xillybus_core.c |  2 +-
 drivers/char/xillybus/xillybus_pcie.c | 16 ++++++----------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/char/xillybus/xillybus.h b/drivers/char/xillybus/xillybus.h
index 7c71bdef7ccb..55d47cb13a7b 100644
--- a/drivers/char/xillybus/xillybus.h
+++ b/drivers/char/xillybus/xillybus.h
@@ -87,7 +87,6 @@ struct xilly_channel {
 };
 
 struct xilly_endpoint {
-	struct pci_dev *pdev;
 	struct device *dev;
 	struct xilly_endpoint_hardware *ephw;
 
diff --git a/drivers/char/xillybus/xillybus_core.c b/drivers/char/xillybus/xillybus_core.c
index 931d0bf4cec6..0ced9ec6977f 100644
--- a/drivers/char/xillybus/xillybus_core.c
+++ b/drivers/char/xillybus/xillybus_core.c
@@ -1783,7 +1783,7 @@ struct xilly_endpoint *xillybus_init_endpoint(struct pci_dev *pdev,
 	if (!endpoint)
 		return NULL;
 
-	endpoint->pdev = pdev;
+	(void)pdev;	// silence a compiler warning, will be removed
 	endpoint->dev = dev;
 	endpoint->ephw = ephw;
 	endpoint->msg_counter = 0x0b;
diff --git a/drivers/char/xillybus/xillybus_pcie.c b/drivers/char/xillybus/xillybus_pcie.c
index 8360427e4226..f4be61349ca6 100644
--- a/drivers/char/xillybus/xillybus_pcie.c
+++ b/drivers/char/xillybus/xillybus_pcie.c
@@ -48,10 +48,8 @@ static void xilly_dma_sync_single_for_cpu_pci(struct xilly_endpoint *ep,
 					      size_t size,
 					      int direction)
 {
-	pci_dma_sync_single_for_cpu(ep->pdev,
-				    dma_handle,
-				    size,
-				    xilly_pci_direction(direction));
+	dma_sync_single_for_cpu(ep->dev, dma_handle, size,
+				xilly_pci_direction(direction));
 }
 
 static void xilly_dma_sync_single_for_device_pci(struct xilly_endpoint *ep,
@@ -59,10 +57,8 @@ static void xilly_dma_sync_single_for_device_pci(struct xilly_endpoint *ep,
 						 size_t size,
 						 int direction)
 {
-	pci_dma_sync_single_for_device(ep->pdev,
-				       dma_handle,
-				       size,
-				       xilly_pci_direction(direction));
+	dma_sync_single_for_device(ep->dev, dma_handle, size,
+				   xilly_pci_direction(direction));
 }
 
 static void xilly_pci_unmap(void *ptr)
@@ -98,9 +94,9 @@ static int xilly_map_single_pci(struct xilly_endpoint *ep,
 
 	pci_direction = xilly_pci_direction(direction);
 
-	addr = pci_map_single(ep->pdev, ptr, size, pci_direction);
+	addr = dma_map_single(ep->dev, ptr, size, pci_direction);
 
-	if (pci_dma_mapping_error(ep->pdev, addr)) {
+	if (dma_mapping_error(ep->dev, addr)) {
 		kfree(this);
 		return -ENODEV;
 	}
-- 
2.30.2

