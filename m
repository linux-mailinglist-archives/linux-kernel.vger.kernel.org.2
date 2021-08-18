Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782BB3F041A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbhHRNCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:02:48 -0400
Received: from mail.ispras.ru ([83.149.199.84]:53758 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235423AbhHRNCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:02:45 -0400
Received: from kleverstation.intra.ispras.ru (unknown [10.10.2.220])
        by mail.ispras.ru (Postfix) with ESMTPS id B40B740A2BD8;
        Wed, 18 Aug 2021 13:02:08 +0000 (UTC)
From:   Nadezda Lutovinova <lutovinova@ispras.ru>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Nadezda Lutovinova <lutovinova@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] usb: gadget: mv_u3d: Change functon call in mv_u3d_probe()
Date:   Wed, 18 Aug 2021 16:01:35 +0300
Message-Id: <20210818130135.575-1-lutovinova@ispras.ru>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If IRQ occurs between calling  request_irq() and  mv_u3d_eps_init(),
then null pointer dereference occurs since u3d->eps[] wasn't
initialized yet but used in mv_u3d_nuke().

The patch puts registration of the interrupt handler after
initializing of neccesery data.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Nadezda Lutovinova <lutovinova@ispras.ru>
---
 drivers/usb/gadget/udc/mv_u3d_core.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/udc/mv_u3d_core.c b/drivers/usb/gadget/udc/mv_u3d_core.c
index ce3d7a3eb7e3..a1057ddfbda3 100644
--- a/drivers/usb/gadget/udc/mv_u3d_core.c
+++ b/drivers/usb/gadget/udc/mv_u3d_core.c
@@ -1921,14 +1921,6 @@ static int mv_u3d_probe(struct platform_device *dev)
 		goto err_get_irq;
 	}
 	u3d->irq = r->start;
-	if (request_irq(u3d->irq, mv_u3d_irq,
-		IRQF_SHARED, driver_name, u3d)) {
-		u3d->irq = 0;
-		dev_err(&dev->dev, "Request irq %d for u3d failed\n",
-			u3d->irq);
-		retval = -ENODEV;
-		goto err_request_irq;
-	}
 
 	/* initialize gadget structure */
 	u3d->gadget.ops = &mv_u3d_ops;	/* usb_gadget_ops */
@@ -1941,6 +1933,15 @@ static int mv_u3d_probe(struct platform_device *dev)
 
 	mv_u3d_eps_init(u3d);
 
+	if (request_irq(u3d->irq, mv_u3d_irq,
+		IRQF_SHARED, driver_name, u3d)) {
+		u3d->irq = 0;
+		dev_err(&dev->dev, "Request irq %d for u3d failed\n",
+			u3d->irq);
+		retval = -ENODEV;
+		goto err_request_irq;
+	}
+
 	/* external vbus detection */
 	if (u3d->vbus) {
 		u3d->clock_gating = 1;
@@ -1964,8 +1965,8 @@ static int mv_u3d_probe(struct platform_device *dev)
 
 err_unregister:
 	free_irq(u3d->irq, u3d);
-err_request_irq:
 err_get_irq:
+err_request_irq:
 	kfree(u3d->status_req);
 err_alloc_status_req:
 	kfree(u3d->eps);
-- 
2.17.1

