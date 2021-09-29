Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4FB41C1DE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 11:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245133AbhI2Jqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 05:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245124AbhI2Jqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 05:46:52 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B18EC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 02:45:11 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b26so6493289edt.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 02:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=EDKANOONw+wUFRbgPz23kCz+0E9P2dSIh8LvsvqPyao=;
        b=BHEl/iu0LXmmDqXkIlELAcH23FAPbujYkOgVaXLt8vn5x/wCcPUVrVjJZ6olPWlgcN
         gxCfXtsDtMyscSTNuJ9UkGLBiH5mWia/94ogGCHTCVec56Q7Js+EnysylsXwAgr3SXBI
         IRxJ+kTHrkU45ZuRDVTo6fMq4uUrr+FhIURPEZXaDYlv92gMyoLq2mqUnGfInsKcxwp5
         vVmWdq4uZCfc0y5BoKGaPB2mHghN1qYTiRlurnWY+Xjb6Q9pRz+8V+oTkK7iTV0IryUc
         fmEyLV4MAh7XBZnspkK6m5tZ83yrZMqZdCnFUuhD4hF5z5CeOUPQ85NVTGHzuM3lpcwH
         2bBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EDKANOONw+wUFRbgPz23kCz+0E9P2dSIh8LvsvqPyao=;
        b=4CzvfPhFV34g4MSvBVslcDU+RF7vYM+LdHCnlg3l3PK1nCHpn+KmDxzz3K2omTY5Ld
         csMlCrbb8QkmjKcbEM16pOloEMjETVOjKQvEA1gvwykj3JM9BOhB82lxAzcQ0BaCB5KE
         6zndPV9aPovdsH0ZSCAwWvOTPXGsQA4DPikEOW2mIha11wrbANTsOTp3ciOY5b+BKt+V
         39SL+p4Pq2EF6LQXJYJdGEljLgmGT1K1VRqNx4x0ToAKxHONDup/hmY/Ynhi7gFSSZvk
         sgpShykI2H66wUyzWYEItKM8I6DDVx8LlBZ79ZGADSxhwl2sQYAdpuNu6pkaqazeYYbg
         iqyw==
X-Gm-Message-State: AOAM533GF22o5my18k1FNWCezPeMZsJ2x8uZCCbTVZPRu6yyxXmWPONd
        8SdWA6m8XAtHAhBLofcvrEo=
X-Google-Smtp-Source: ABdhPJzO/OBmcG+F+4jTHff0qKUoQn+VrV2mtd81rxgR37FArv5IUOSbHP7kf2RP6XXpo3dyHJwKqg==
X-Received: by 2002:a50:e085:: with SMTP id f5mr13860521edl.9.1632908710042;
        Wed, 29 Sep 2021 02:45:10 -0700 (PDT)
Received: from ruhe.localdomain (109-186-97-74.bb.netvision.net.il. [109.186.97.74])
        by smtp.gmail.com with ESMTPSA id w2sm1211282edj.44.2021.09.29.02.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 02:45:09 -0700 (PDT)
From:   eli.billauer@gmail.com
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr,
        Eli Billauer <eli.billauer@gmail.com>
Subject: [PATCH v2] char: xillybus: Eliminate redundant wrappers to DMA related calls
Date:   Wed, 29 Sep 2021 12:44:42 +0300
Message-Id: <20210929094442.46383-1-eli.billauer@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eli Billauer <eli.billauer@gmail.com>

The driver was originally written with the assumption that a different
API must be used for DMA-related functions if the device is PCIe based
or if not. Since Xillybus' driver supports devices on a PCIe bus (with
xillybus_pcie) as well as connected directly to the processor (with
xillybus_of), it originally used wrapper functions that ensure that
a different API is used for each.

This patch eliminates the said wrapper functions, as all use the same
dma_* API now. This is most notable by the code deleted in xillybus_pcie.c
and xillybus_of.c.

It also eliminates the OF driver's check for a "dma-coherent" attribute
in the device's OF entry, since this is taken care of by the kernel's
implementation of dma_sync_single_for_*().

There is however still need for one wrapper function, which is merged
from xillybus_pcie.c and xillybus_of.c into xillybus_core.c: The call to
dma_map_single() is wrapped by a function that uses the Managed Device
(devres) framework, in the absence of a relevant function in the current
kernel's API.

Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Eli Billauer <eli.billauer@gmail.com>
---

Notes:
    Changelog:
    
    v2
      -- Eliminate the OF driver's check for a "dma-coherent" attribute:
         The driver always calls dma_sync_single_for_*(), and the kernel's
         implementation of these functions makes sure that nothing is done if
         the "dma-coherent" attribute is present for the device. Thanks to Arnd
         for pointing this out.

 drivers/char/xillybus/xillybus.h      |  23 +----
 drivers/char/xillybus/xillybus_core.c | 129 ++++++++++++++++----------
 drivers/char/xillybus/xillybus_of.c   |  86 +----------------
 drivers/char/xillybus/xillybus_pcie.c |  90 +-----------------
 4 files changed, 86 insertions(+), 242 deletions(-)

diff --git a/drivers/char/xillybus/xillybus.h b/drivers/char/xillybus/xillybus.h
index afce5bb4d127..51de7cbc579e 100644
--- a/drivers/char/xillybus/xillybus.h
+++ b/drivers/char/xillybus/xillybus.h
@@ -88,7 +88,7 @@ struct xilly_channel {
 
 struct xilly_endpoint {
 	struct device *dev;
-	struct xilly_endpoint_hardware *ephw;
+	struct module *owner;
 
 	int dma_using_dac; /* =1 if 64-bit DMA is used, =0 otherwise. */
 	__iomem void *registers;
@@ -108,23 +108,6 @@ struct xilly_endpoint {
 	unsigned int msg_buf_size;
 };
 
-struct xilly_endpoint_hardware {
-	struct module *owner;
-	void (*hw_sync_sgl_for_cpu)(struct xilly_endpoint *,
-				    dma_addr_t,
-				    size_t,
-				    int);
-	void (*hw_sync_sgl_for_device)(struct xilly_endpoint *,
-				       dma_addr_t,
-				       size_t,
-				       int);
-	int (*map_single)(struct xilly_endpoint *,
-			  void *,
-			  size_t,
-			  int,
-			  dma_addr_t *);
-};
-
 struct xilly_mapping {
 	struct device *device;
 	dma_addr_t dma_addr;
@@ -134,9 +117,7 @@ struct xilly_mapping {
 
 irqreturn_t xillybus_isr(int irq, void *data);
 
-struct xilly_endpoint *xillybus_init_endpoint(struct device *dev,
-					      struct xilly_endpoint_hardware
-					      *ephw);
+struct xilly_endpoint *xillybus_init_endpoint(struct device *dev);
 
 int xillybus_endpoint_discovery(struct xilly_endpoint *endpoint);
 
diff --git a/drivers/char/xillybus/xillybus_core.c b/drivers/char/xillybus/xillybus_core.c
index 02f30140c2d5..11b7c4749274 100644
--- a/drivers/char/xillybus/xillybus_core.c
+++ b/drivers/char/xillybus/xillybus_core.c
@@ -122,10 +122,8 @@ irqreturn_t xillybus_isr(int irq, void *data)
 	buf = ep->msgbuf_addr;
 	buf_size = ep->msg_buf_size/sizeof(u32);
 
-	ep->ephw->hw_sync_sgl_for_cpu(ep,
-				      ep->msgbuf_dma_addr,
-				      ep->msg_buf_size,
-				      DMA_FROM_DEVICE);
+	dma_sync_single_for_cpu(ep->dev, ep->msgbuf_dma_addr,
+				ep->msg_buf_size, DMA_FROM_DEVICE);
 
 	for (i = 0; i < buf_size; i += 2) {
 		if (((buf[i+1] >> 28) & 0xf) != ep->msg_counter) {
@@ -140,11 +138,10 @@ irqreturn_t xillybus_isr(int irq, void *data)
 				dev_err(ep->dev,
 					"Lost sync with interrupt messages. Stopping.\n");
 			} else {
-				ep->ephw->hw_sync_sgl_for_device(
-					ep,
-					ep->msgbuf_dma_addr,
-					ep->msg_buf_size,
-					DMA_FROM_DEVICE);
+				dma_sync_single_for_device(ep->dev,
+							   ep->msgbuf_dma_addr,
+							   ep->msg_buf_size,
+							   DMA_FROM_DEVICE);
 
 				iowrite32(0x01,  /* Message NACK */
 					  ep->registers + fpga_msg_ctrl_reg);
@@ -275,10 +272,8 @@ irqreturn_t xillybus_isr(int irq, void *data)
 		}
 	}
 
-	ep->ephw->hw_sync_sgl_for_device(ep,
-					 ep->msgbuf_dma_addr,
-					 ep->msg_buf_size,
-					 DMA_FROM_DEVICE);
+	dma_sync_single_for_device(ep->dev, ep->msgbuf_dma_addr,
+				   ep->msg_buf_size, DMA_FROM_DEVICE);
 
 	ep->msg_counter = (ep->msg_counter + 1) & 0xf;
 	ep->failed_messages = 0;
@@ -304,6 +299,47 @@ struct xilly_alloc_state {
 	u32 regdirection;
 };
 
+static void xilly_unmap(void *ptr)
+{
+	struct xilly_mapping *data = ptr;
+
+	dma_unmap_single(data->device, data->dma_addr,
+			 data->size, data->direction);
+
+	kfree(ptr);
+}
+
+static int xilly_map_single(struct xilly_endpoint *ep,
+			    void *ptr,
+			    size_t size,
+			    int direction,
+			    dma_addr_t *ret_dma_handle
+	)
+{
+	dma_addr_t addr;
+	struct xilly_mapping *this;
+
+	this = kzalloc(sizeof(*this), GFP_KERNEL);
+	if (!this)
+		return -ENOMEM;
+
+	addr = dma_map_single(ep->dev, ptr, size, direction);
+
+	if (dma_mapping_error(ep->dev, addr)) {
+		kfree(this);
+		return -ENODEV;
+	}
+
+	this->device = ep->dev;
+	this->dma_addr = addr;
+	this->size = size;
+	this->direction = direction;
+
+	*ret_dma_handle = addr;
+
+	return devm_add_action_or_reset(ep->dev, xilly_unmap, this);
+}
+
 static int xilly_get_dma_buffers(struct xilly_endpoint *ep,
 				 struct xilly_alloc_state *s,
 				 struct xilly_buffer **buffers,
@@ -355,9 +391,9 @@ static int xilly_get_dma_buffers(struct xilly_endpoint *ep,
 			s->left_of_salami = allocsize;
 		}
 
-		rc = ep->ephw->map_single(ep, s->salami,
-					  bytebufsize, s->direction,
-					  &dma_addr);
+		rc = xilly_map_single(ep, s->salami,
+				      bytebufsize, s->direction,
+				      &dma_addr);
 		if (rc)
 			return rc;
 
@@ -620,11 +656,10 @@ static int xilly_obtain_idt(struct xilly_endpoint *endpoint)
 		return -ENODEV;
 	}
 
-	endpoint->ephw->hw_sync_sgl_for_cpu(
-		channel->endpoint,
-		channel->wr_buffers[0]->dma_addr,
-		channel->wr_buf_size,
-		DMA_FROM_DEVICE);
+	dma_sync_single_for_cpu(channel->endpoint->dev,
+				channel->wr_buffers[0]->dma_addr,
+				channel->wr_buf_size,
+				DMA_FROM_DEVICE);
 
 	if (channel->wr_buffers[0]->end_offset != endpoint->idtlen) {
 		dev_err(endpoint->dev,
@@ -735,11 +770,10 @@ static ssize_t xillybus_read(struct file *filp, char __user *userbuf,
 		if (!empty) { /* Go on, now without the spinlock */
 
 			if (bufpos == 0) /* Position zero means it's virgin */
-				channel->endpoint->ephw->hw_sync_sgl_for_cpu(
-					channel->endpoint,
-					channel->wr_buffers[bufidx]->dma_addr,
-					channel->wr_buf_size,
-					DMA_FROM_DEVICE);
+				dma_sync_single_for_cpu(channel->endpoint->dev,
+							channel->wr_buffers[bufidx]->dma_addr,
+							channel->wr_buf_size,
+							DMA_FROM_DEVICE);
 
 			if (copy_to_user(
 				    userbuf,
@@ -751,11 +785,10 @@ static ssize_t xillybus_read(struct file *filp, char __user *userbuf,
 			bytes_done += howmany;
 
 			if (bufferdone) {
-				channel->endpoint->ephw->hw_sync_sgl_for_device(
-					channel->endpoint,
-					channel->wr_buffers[bufidx]->dma_addr,
-					channel->wr_buf_size,
-					DMA_FROM_DEVICE);
+				dma_sync_single_for_device(channel->endpoint->dev,
+							   channel->wr_buffers[bufidx]->dma_addr,
+							   channel->wr_buf_size,
+							   DMA_FROM_DEVICE);
 
 				/*
 				 * Tell FPGA the buffer is done with. It's an
@@ -1055,11 +1088,10 @@ static int xillybus_myflush(struct xilly_channel *channel, long timeout)
 		else
 			channel->rd_host_buf_idx++;
 
-		channel->endpoint->ephw->hw_sync_sgl_for_device(
-			channel->endpoint,
-			channel->rd_buffers[bufidx]->dma_addr,
-			channel->rd_buf_size,
-			DMA_TO_DEVICE);
+		dma_sync_single_for_device(channel->endpoint->dev,
+					   channel->rd_buffers[bufidx]->dma_addr,
+					   channel->rd_buf_size,
+					   DMA_TO_DEVICE);
 
 		mutex_lock(&channel->endpoint->register_mutex);
 
@@ -1275,11 +1307,10 @@ static ssize_t xillybus_write(struct file *filp, const char __user *userbuf,
 
 			if ((bufpos == 0) || /* Zero means it's virgin */
 			    (channel->rd_leftovers[3] != 0)) {
-				channel->endpoint->ephw->hw_sync_sgl_for_cpu(
-					channel->endpoint,
-					channel->rd_buffers[bufidx]->dma_addr,
-					channel->rd_buf_size,
-					DMA_TO_DEVICE);
+				dma_sync_single_for_cpu(channel->endpoint->dev,
+							channel->rd_buffers[bufidx]->dma_addr,
+							channel->rd_buf_size,
+							DMA_TO_DEVICE);
 
 				/* Virgin, but leftovers are due */
 				for (i = 0; i < bufpos; i++)
@@ -1297,11 +1328,10 @@ static ssize_t xillybus_write(struct file *filp, const char __user *userbuf,
 			bytes_done += howmany;
 
 			if (bufferdone) {
-				channel->endpoint->ephw->hw_sync_sgl_for_device(
-					channel->endpoint,
-					channel->rd_buffers[bufidx]->dma_addr,
-					channel->rd_buf_size,
-					DMA_TO_DEVICE);
+				dma_sync_single_for_device(channel->endpoint->dev,
+							   channel->rd_buffers[bufidx]->dma_addr,
+							   channel->rd_buf_size,
+							   DMA_TO_DEVICE);
 
 				mutex_lock(&channel->endpoint->register_mutex);
 
@@ -1772,9 +1802,7 @@ static const struct file_operations xillybus_fops = {
 	.poll       = xillybus_poll,
 };
 
-struct xilly_endpoint *xillybus_init_endpoint(struct device *dev,
-					      struct xilly_endpoint_hardware
-					      *ephw)
+struct xilly_endpoint *xillybus_init_endpoint(struct device *dev)
 {
 	struct xilly_endpoint *endpoint;
 
@@ -1783,7 +1811,6 @@ struct xilly_endpoint *xillybus_init_endpoint(struct device *dev,
 		return NULL;
 
 	endpoint->dev = dev;
-	endpoint->ephw = ephw;
 	endpoint->msg_counter = 0x0b;
 	endpoint->failed_messages = 0;
 	endpoint->fatal_error = 0;
@@ -1910,7 +1937,7 @@ int xillybus_endpoint_discovery(struct xilly_endpoint *endpoint)
 		goto failed_idt;
 
 	rc = xillybus_init_chrdev(dev, &xillybus_fops,
-				  endpoint->ephw->owner, endpoint,
+				  endpoint->owner, endpoint,
 				  idt_handle.names,
 				  idt_handle.names_len,
 				  endpoint->num_channels,
diff --git a/drivers/char/xillybus/xillybus_of.c b/drivers/char/xillybus/xillybus_of.c
index 4e6e0c19d8c8..e5372e45d211 100644
--- a/drivers/char/xillybus/xillybus_of.c
+++ b/drivers/char/xillybus/xillybus_of.c
@@ -31,102 +31,22 @@ static const struct of_device_id xillybus_of_match[] = {
 
 MODULE_DEVICE_TABLE(of, xillybus_of_match);
 
-static void xilly_dma_sync_single_for_cpu_of(struct xilly_endpoint *ep,
-					     dma_addr_t dma_handle,
-					     size_t size,
-					     int direction)
-{
-	dma_sync_single_for_cpu(ep->dev, dma_handle, size, direction);
-}
-
-static void xilly_dma_sync_single_for_device_of(struct xilly_endpoint *ep,
-						dma_addr_t dma_handle,
-						size_t size,
-						int direction)
-{
-	dma_sync_single_for_device(ep->dev, dma_handle, size, direction);
-}
-
-static void xilly_dma_sync_single_nop(struct xilly_endpoint *ep,
-				      dma_addr_t dma_handle,
-				      size_t size,
-				      int direction)
-{
-}
-
-static void xilly_of_unmap(void *ptr)
-{
-	struct xilly_mapping *data = ptr;
-
-	dma_unmap_single(data->device, data->dma_addr,
-			 data->size, data->direction);
-
-	kfree(ptr);
-}
-
-static int xilly_map_single_of(struct xilly_endpoint *ep,
-			       void *ptr,
-			       size_t size,
-			       int direction,
-			       dma_addr_t *ret_dma_handle
-	)
-{
-	dma_addr_t addr;
-	struct xilly_mapping *this;
-
-	this = kzalloc(sizeof(*this), GFP_KERNEL);
-	if (!this)
-		return -ENOMEM;
-
-	addr = dma_map_single(ep->dev, ptr, size, direction);
-
-	if (dma_mapping_error(ep->dev, addr)) {
-		kfree(this);
-		return -ENODEV;
-	}
-
-	this->device = ep->dev;
-	this->dma_addr = addr;
-	this->size = size;
-	this->direction = direction;
-
-	*ret_dma_handle = addr;
-
-	return devm_add_action_or_reset(ep->dev, xilly_of_unmap, this);
-}
-
-static struct xilly_endpoint_hardware of_hw = {
-	.owner = THIS_MODULE,
-	.hw_sync_sgl_for_cpu = xilly_dma_sync_single_for_cpu_of,
-	.hw_sync_sgl_for_device = xilly_dma_sync_single_for_device_of,
-	.map_single = xilly_map_single_of,
-};
-
-static struct xilly_endpoint_hardware of_hw_coherent = {
-	.owner = THIS_MODULE,
-	.hw_sync_sgl_for_cpu = xilly_dma_sync_single_nop,
-	.hw_sync_sgl_for_device = xilly_dma_sync_single_nop,
-	.map_single = xilly_map_single_of,
-};
-
 static int xilly_drv_probe(struct platform_device *op)
 {
 	struct device *dev = &op->dev;
 	struct xilly_endpoint *endpoint;
 	int rc;
 	int irq;
-	struct xilly_endpoint_hardware *ephw = &of_hw;
 
-	if (of_property_read_bool(dev->of_node, "dma-coherent"))
-		ephw = &of_hw_coherent;
-
-	endpoint = xillybus_init_endpoint(dev, ephw);
+	endpoint = xillybus_init_endpoint(dev);
 
 	if (!endpoint)
 		return -ENOMEM;
 
 	dev_set_drvdata(dev, endpoint);
 
+	endpoint->owner = THIS_MODULE;
+
 	endpoint->registers = devm_platform_ioremap_resource(op, 0);
 	if (IS_ERR(endpoint->registers))
 		return PTR_ERR(endpoint->registers);
diff --git a/drivers/char/xillybus/xillybus_pcie.c b/drivers/char/xillybus/xillybus_pcie.c
index a6ef4ce90649..9858711e3e79 100644
--- a/drivers/char/xillybus/xillybus_pcie.c
+++ b/drivers/char/xillybus/xillybus_pcie.c
@@ -32,105 +32,21 @@ static const struct pci_device_id xillyids[] = {
 	{ /* End: all zeroes */ }
 };
 
-static int xilly_pci_direction(int direction)
-{
-	switch (direction) {
-	case DMA_TO_DEVICE:
-	case DMA_FROM_DEVICE:
-		return direction;
-	default:
-		return DMA_BIDIRECTIONAL;
-	}
-}
-
-static void xilly_dma_sync_single_for_cpu_pci(struct xilly_endpoint *ep,
-					      dma_addr_t dma_handle,
-					      size_t size,
-					      int direction)
-{
-	dma_sync_single_for_cpu(ep->dev, dma_handle, size,
-				xilly_pci_direction(direction));
-}
-
-static void xilly_dma_sync_single_for_device_pci(struct xilly_endpoint *ep,
-						 dma_addr_t dma_handle,
-						 size_t size,
-						 int direction)
-{
-	dma_sync_single_for_device(ep->dev, dma_handle, size,
-				   xilly_pci_direction(direction));
-}
-
-static void xilly_pci_unmap(void *ptr)
-{
-	struct xilly_mapping *data = ptr;
-
-	dma_unmap_single(data->device, data->dma_addr, data->size,
-			 data->direction);
-
-	kfree(ptr);
-}
-
-/*
- * Map either through the PCI DMA mapper or the non_PCI one. Behind the
- * scenes exactly the same functions are called with the same parameters,
- * but that can change.
- */
-
-static int xilly_map_single_pci(struct xilly_endpoint *ep,
-				void *ptr,
-				size_t size,
-				int direction,
-				dma_addr_t *ret_dma_handle
-	)
-{
-	int pci_direction;
-	dma_addr_t addr;
-	struct xilly_mapping *this;
-
-	this = kzalloc(sizeof(*this), GFP_KERNEL);
-	if (!this)
-		return -ENOMEM;
-
-	pci_direction = xilly_pci_direction(direction);
-
-	addr = dma_map_single(ep->dev, ptr, size, pci_direction);
-
-	if (dma_mapping_error(ep->dev, addr)) {
-		kfree(this);
-		return -ENODEV;
-	}
-
-	this->device = ep->dev;
-	this->dma_addr = addr;
-	this->size = size;
-	this->direction = pci_direction;
-
-	*ret_dma_handle = addr;
-
-	return devm_add_action_or_reset(ep->dev, xilly_pci_unmap, this);
-}
-
-static struct xilly_endpoint_hardware pci_hw = {
-	.owner = THIS_MODULE,
-	.hw_sync_sgl_for_cpu = xilly_dma_sync_single_for_cpu_pci,
-	.hw_sync_sgl_for_device = xilly_dma_sync_single_for_device_pci,
-	.map_single = xilly_map_single_pci,
-};
-
 static int xilly_probe(struct pci_dev *pdev,
 		       const struct pci_device_id *ent)
 {
 	struct xilly_endpoint *endpoint;
 	int rc;
 
-	endpoint = xillybus_init_endpoint(&pdev->dev, &pci_hw);
+	endpoint = xillybus_init_endpoint(&pdev->dev);
 
 	if (!endpoint)
 		return -ENOMEM;
 
 	pci_set_drvdata(pdev, endpoint);
 
+	endpoint->owner = THIS_MODULE;
+
 	rc = pcim_enable_device(pdev);
 	if (rc) {
 		dev_err(endpoint->dev,
-- 
2.17.1

