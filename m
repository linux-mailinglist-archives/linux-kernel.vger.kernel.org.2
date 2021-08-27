Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00063F9DA7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 19:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240334AbhH0RSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 13:18:36 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:55996 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237357AbhH0RSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 13:18:32 -0400
Received: from pop-os.home ([90.126.253.178])
        by mwinf5d74 with ME
        id mhHh2500J3riaq203hHiZl; Fri, 27 Aug 2021 19:17:42 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 27 Aug 2021 19:17:42 +0200
X-ME-IP: 90.126.253.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     eli.billauer@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v1 2/4] char: xillybus: Remove usage of 'pci_unmap_single()'
Date:   Fri, 27 Aug 2021 19:17:39 +0200
Message-Id: <baa3f6c7f009d9c231ae320bf1d568268bfef089.1630083668.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1630083668.git.christophe.jaillet@wanadoo.fr>
References: <cover.1630083668.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'struct xilly_mapping' includes a 'void *device' field which holds,
depending of the context, a 'struct device *' or a 'struct pci_dev *'.

This field is then used with 'pci_umap_single()' in 'xillybus_pcie.c' and
with 'dma_umap_single()' in 'xillybus_of.c'.

In order to remove usage of the deprecated 'pci_unmap_single()' API, turn
the 'void *device' field from 'struct xilly_mapping', into an explicit
'struct device *device' and use 'dma_umap_single()' everywhere.

In order to update 'xillybus_pcie.c', use the 'dev' field instead of the
'pdev' field from the 'struct xilly_endpoint'.
Both fields are initialized by 'xillybus_init_endpoint()' and in
'xillybus_pcie.c', we have:
	xillybus_init_endpoint(pdev, &pdev->dev, &pci_hw);
                                 ^       ^
        xilly_endpoint.pdev = ___|       |___ = xilly_endpoint.dev
So the modification from pci_ to dma_ function is straightforward.

While at it, remove a comment that is wrong, because in the case above,
both 'dev' and 'pdev' are not NULL.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/char/xillybus/xillybus.h      | 6 +-----
 drivers/char/xillybus/xillybus_pcie.c | 6 +++---
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/char/xillybus/xillybus.h b/drivers/char/xillybus/xillybus.h
index c63ffc56637c..7c71bdef7ccb 100644
--- a/drivers/char/xillybus/xillybus.h
+++ b/drivers/char/xillybus/xillybus.h
@@ -87,10 +87,6 @@ struct xilly_channel {
 };
 
 struct xilly_endpoint {
-	/*
-	 * One of pdev and dev is always NULL, and the other is a valid
-	 * pointer, depending on the type of device
-	 */
 	struct pci_dev *pdev;
 	struct device *dev;
 	struct xilly_endpoint_hardware *ephw;
@@ -131,7 +127,7 @@ struct xilly_endpoint_hardware {
 };
 
 struct xilly_mapping {
-	void *device;
+	struct device *device;
 	dma_addr_t dma_addr;
 	size_t size;
 	int direction;
diff --git a/drivers/char/xillybus/xillybus_pcie.c b/drivers/char/xillybus/xillybus_pcie.c
index be25bfdb0d9a..8360427e4226 100644
--- a/drivers/char/xillybus/xillybus_pcie.c
+++ b/drivers/char/xillybus/xillybus_pcie.c
@@ -69,8 +69,8 @@ static void xilly_pci_unmap(void *ptr)
 {
 	struct xilly_mapping *data = ptr;
 
-	pci_unmap_single(data->device, data->dma_addr,
-			 data->size, data->direction);
+	dma_unmap_single(data->device, data->dma_addr, data->size,
+			 data->direction);
 
 	kfree(ptr);
 }
@@ -105,7 +105,7 @@ static int xilly_map_single_pci(struct xilly_endpoint *ep,
 		return -ENODEV;
 	}
 
-	this->device = ep->pdev;
+	this->device = ep->dev;
 	this->dma_addr = addr;
 	this->size = size;
 	this->direction = pci_direction;
-- 
2.30.2

