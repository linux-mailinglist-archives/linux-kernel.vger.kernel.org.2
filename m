Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBEA340939
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhCRPwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:52:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230465AbhCRPwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:52:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24B2A64EF2;
        Thu, 18 Mar 2021 15:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616082720;
        bh=DX0hq+tbj++s6Jy8noJrCLIzxuMHgJ5jusyx7A2Vmkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZqOVqLWcz5vyUbQyf9zz7dY17+eAVM+PZmjFiFJ+80ltTkFgYMSjhBWOqWEk25uQg
         cJp0xCEKhAh48L5HJJrnI7S12zFiNIQE+cNEF4LfwHFDSl4+ExpyFAZnWOmVutbZ4S
         hjUR1O7zDNLyuUAijeG0fxRD8eO4RcUFqqWLIMlCcs2oscyWYZxD58K/KETvS9bzbR
         JX3obSLvl1rV2w6xCP6CU9kOMzS13/yfLn5KYWoQlEzN7OfruPHFQvkvPJBqlBEPjM
         MYPcw61Sc26V+fmig4f12idsKVuOsYjitdp3zSbY17p6fyD8ppiZz1YOd0JvmTWINv
         3QxS9gqucEG7Q==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lMuwc-0005nd-Bm; Thu, 18 Mar 2021 16:52:18 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 5/7] USB: cdc-acm: clean up probe error labels
Date:   Thu, 18 Mar 2021 16:52:00 +0100
Message-Id: <20210318155202.22230-6-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210318155202.22230-1-johan@kernel.org>
References: <20210318155202.22230-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Name the probe error labels after what they do rather than using
sequence numbers which is harder to review and maintain (e.g. may
require renaming unrelated labels when a label is added or removed).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/class/cdc-acm.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 682772b8a4f7..e3c45f5880fc 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1324,7 +1324,7 @@ static int acm_probe(struct usb_interface *intf,
 
 	acm = kzalloc(sizeof(struct acm), GFP_KERNEL);
 	if (acm == NULL)
-		goto alloc_fail;
+		return -ENOMEM;
 
 	tty_port_init(&acm->port);
 	acm->port.ops = &acm_port_ops;
@@ -1341,7 +1341,7 @@ static int acm_probe(struct usb_interface *intf,
 
 	minor = acm_alloc_minor(acm);
 	if (minor < 0)
-		goto alloc_fail1;
+		goto err_put_port;
 
 	acm->minor = minor;
 	acm->dev = usb_dev;
@@ -1372,15 +1372,15 @@ static int acm_probe(struct usb_interface *intf,
 
 	buf = usb_alloc_coherent(usb_dev, ctrlsize, GFP_KERNEL, &acm->ctrl_dma);
 	if (!buf)
-		goto alloc_fail1;
+		goto err_put_port;
 	acm->ctrl_buffer = buf;
 
 	if (acm_write_buffers_alloc(acm) < 0)
-		goto alloc_fail2;
+		goto err_free_ctrl_buffer;
 
 	acm->ctrlurb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!acm->ctrlurb)
-		goto alloc_fail3;
+		goto err_free_write_buffers;
 
 	for (i = 0; i < num_rx_buf; i++) {
 		struct acm_rb *rb = &(acm->read_buffers[i]);
@@ -1389,13 +1389,13 @@ static int acm_probe(struct usb_interface *intf,
 		rb->base = usb_alloc_coherent(acm->dev, readsize, GFP_KERNEL,
 								&rb->dma);
 		if (!rb->base)
-			goto alloc_fail4;
+			goto err_free_read_urbs;
 		rb->index = i;
 		rb->instance = acm;
 
 		urb = usb_alloc_urb(0, GFP_KERNEL);
 		if (!urb)
-			goto alloc_fail4;
+			goto err_free_read_urbs;
 
 		urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 		urb->transfer_dma = rb->dma;
@@ -1417,7 +1417,7 @@ static int acm_probe(struct usb_interface *intf,
 
 		snd->urb = usb_alloc_urb(0, GFP_KERNEL);
 		if (snd->urb == NULL)
-			goto alloc_fail5;
+			goto err_free_write_urbs;
 
 		if (usb_endpoint_xfer_int(epwrite))
 			usb_fill_int_urb(snd->urb, usb_dev, acm->out,
@@ -1435,7 +1435,7 @@ static int acm_probe(struct usb_interface *intf,
 
 	i = device_create_file(&intf->dev, &dev_attr_bmCapabilities);
 	if (i < 0)
-		goto alloc_fail5;
+		goto err_free_write_urbs;
 
 	if (h.usb_cdc_country_functional_desc) { /* export the country data */
 		struct usb_cdc_country_functional_desc * cfd =
@@ -1492,7 +1492,7 @@ static int acm_probe(struct usb_interface *intf,
 			&control_interface->dev);
 	if (IS_ERR(tty_dev)) {
 		rv = PTR_ERR(tty_dev);
-		goto alloc_fail6;
+		goto err_release_data_interface;
 	}
 
 	if (quirks & CLEAR_HALT_CONDITIONS) {
@@ -1501,7 +1501,8 @@ static int acm_probe(struct usb_interface *intf,
 	}
 
 	return 0;
-alloc_fail6:
+
+err_release_data_interface:
 	if (!acm->combined_interfaces) {
 		/* Clear driver data so that disconnect() returns early. */
 		usb_set_intfdata(data_interface, NULL);
@@ -1514,21 +1515,21 @@ static int acm_probe(struct usb_interface *intf,
 				&dev_attr_iCountryCodeRelDate);
 	}
 	device_remove_file(&acm->control->dev, &dev_attr_bmCapabilities);
-alloc_fail5:
+err_free_write_urbs:
 	for (i = 0; i < ACM_NW; i++)
 		usb_free_urb(acm->wb[i].urb);
-alloc_fail4:
+err_free_read_urbs:
 	for (i = 0; i < num_rx_buf; i++)
 		usb_free_urb(acm->read_urbs[i]);
 	acm_read_buffers_free(acm);
 	usb_free_urb(acm->ctrlurb);
-alloc_fail3:
+err_free_write_buffers:
 	acm_write_buffers_free(acm);
-alloc_fail2:
+err_free_ctrl_buffer:
 	usb_free_coherent(usb_dev, ctrlsize, acm->ctrl_buffer, acm->ctrl_dma);
-alloc_fail1:
+err_put_port:
 	tty_port_put(&acm->port);
-alloc_fail:
+
 	return rv;
 }
 
-- 
2.26.2

