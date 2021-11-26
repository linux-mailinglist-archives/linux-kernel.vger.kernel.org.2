Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0711745F341
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 18:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238726AbhKZSA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 13:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbhKZR6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 12:58:54 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DF9C061398
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 09:32:36 -0800 (PST)
Received: from dslb-084-059-234-221.084.059.pools.vodafone-ip.de ([84.59.234.221] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mqf5M-00083N-Bj; Fri, 26 Nov 2021 18:32:32 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 8/8] staging: r8188eu: require a single bulk in endpoint
Date:   Fri, 26 Nov 2021 18:32:05 +0100
Message-Id: <20211126173205.21352-9-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211126173205.21352-1-martin@kaiser.cx>
References: <20211126173205.21352-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current r8188eu driver code has no support for interrupt in
endpoints. Some parts of the code assume implicitly that we use
one single bulk in endpoint for the incoming network data.

Make this assumption clearer and reject devices that have more than
one bulk in endpoint. Ignore any interrupt in endpoints.

We can then change RtInPipe into a single value instead of an array.
There's no need any more to pass around the number of in endpoints.
We know that it's one or the device would have been rejected.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c   | 20 +++-----------------
 drivers/staging/r8188eu/hal/usb_ops_linux.c |  2 +-
 drivers/staging/r8188eu/include/drv_types.h |  3 +--
 drivers/staging/r8188eu/os_dep/usb_intf.c   | 20 +++++++++++---------
 4 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index ad54d5fcf45e..ceaf5af8c465 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -40,24 +40,11 @@ static void _ConfigNormalChipOutEP_8188E(struct adapter *adapt, u8 NumOutPipe)
 	DBG_88E("%s OutEpQueueSel(0x%02x), OutEpNumber(%d)\n", __func__, haldata->OutEpQueueSel, haldata->OutEpNumber);
 }
 
-static bool HalUsbSetQueuePipeMapping8188EUsb(struct adapter *adapt, u8 NumInPipe, u8 NumOutPipe)
+static bool HalUsbSetQueuePipeMapping8188EUsb(struct adapter *adapt, u8 NumOutPipe)
 {
-	struct hal_data_8188e	*haldata	= GET_HAL_DATA(adapt);
-	bool			result		= false;
 
 	_ConfigNormalChipOutEP_8188E(adapt, NumOutPipe);
-
-	/*  Normal chip with one IN and one OUT doesn't have interrupt IN EP. */
-	if (1 == haldata->OutEpNumber) {
-		if (1 != NumInPipe)
-			return result;
-	}
-
-	/*  All config other than above support one Bulk IN and one Interrupt IN. */
-
-	result = Hal_MappingOutPipe(adapt, NumOutPipe);
-
-	return result;
+	return Hal_MappingOutPipe(adapt, NumOutPipe);
 }
 
 void rtl8188eu_interface_configure(struct adapter *adapt)
@@ -81,8 +68,7 @@ void rtl8188eu_interface_configure(struct adapter *adapt)
 	haldata->UsbRxAggPageCount	= 48; /* uint :128 b 0x0A;	10 = MAX_RX_DMA_BUFFER_SIZE/2/haldata->UsbBulkOutSize */
 	haldata->UsbRxAggPageTimeout	= 0x4; /* 6, absolute time = 34ms/(2^6) */
 
-	HalUsbSetQueuePipeMapping8188EUsb(adapt,
-				pdvobjpriv->RtNumInPipes, pdvobjpriv->RtNumOutPipes);
+	HalUsbSetQueuePipeMapping8188EUsb(adapt, pdvobjpriv->RtNumOutPipes);
 }
 
 u32 rtl8188eu_InitPowerOn(struct adapter *adapt)
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index d66a4b394610..6232e5c49e85 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -507,7 +507,7 @@ u32 rtw_read_port(struct adapter *adapter, u8 *rmem)
 	purb = precvbuf->purb;
 
 	/* translate DMA FIFO addr to pipehandle */
-	pipe = usb_rcvbulkpipe(pusbd, pdvobj->RtInPipe[0]);
+	pipe = usb_rcvbulkpipe(pusbd, pdvobj->RtInPipe);
 
 	usb_fill_bulk_urb(purb, pusbd, pipe,
 			  precvbuf->pbuf,
diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index 1eb6b5f29425..700fc4d571d6 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -135,7 +135,7 @@ struct dvobj_priv {
 	u8	NumInterfaces;
 
 	/* In /Out Pipe information */
-	int	RtInPipe[2];
+	int	RtInPipe;
 	int	RtOutPipe[3];
 	u8	Queue2Pipe[HW_QUEUE_ENTRY];/* for out pipe mapping */
 
@@ -146,7 +146,6 @@ struct dvobj_priv {
 /*-------- below is for USB INTERFACE --------*/
 
 	u8	ishighspeed;
-	u8	RtNumInPipes;
 	u8	RtNumOutPipes;
 	int	RegUsbSS;
 	struct semaphore usb_suspend_sema;
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 04454237a477..6e08ccafe2b9 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -69,6 +69,7 @@ static struct rtw_usb_drv *usb_drv = &rtl8188e_usb_drv;
 static struct dvobj_priv *usb_dvobj_init(struct usb_interface *usb_intf)
 {
 	int	i;
+	u8	rt_num_in_pipes = 0;
 	struct dvobj_priv *pdvobjpriv;
 	struct usb_host_config		*phost_conf;
 	struct usb_config_descriptor	*pconf_desc;
@@ -79,14 +80,13 @@ static struct dvobj_priv *usb_dvobj_init(struct usb_interface *usb_intf)
 
 	pdvobjpriv = kzalloc(sizeof(*pdvobjpriv), GFP_KERNEL);
 	if (!pdvobjpriv)
-		goto exit;
+		goto err;
 
 	pdvobjpriv->pusbintf = usb_intf;
 	pusbd = interface_to_usbdev(usb_intf);
 	pdvobjpriv->pusbdev = pusbd;
 	usb_set_intfdata(usb_intf, pdvobjpriv);
 
-	pdvobjpriv->RtNumInPipes = 0;
 	pdvobjpriv->RtNumOutPipes = 0;
 
 	phost_conf = pusbd->actconfig;
@@ -105,11 +105,8 @@ static struct dvobj_priv *usb_dvobj_init(struct usb_interface *usb_intf)
 		ep_num = usb_endpoint_num(pendp_desc);
 
 		if (usb_endpoint_is_bulk_in(pendp_desc)) {
-			pdvobjpriv->RtInPipe[pdvobjpriv->RtNumInPipes] = ep_num;
-			pdvobjpriv->RtNumInPipes++;
-		} else if (usb_endpoint_is_int_in(pendp_desc)) {
-			pdvobjpriv->RtInPipe[pdvobjpriv->RtNumInPipes] = ep_num;
-			pdvobjpriv->RtNumInPipes++;
+			pdvobjpriv->RtInPipe = ep_num;
+			rt_num_in_pipes++;
 		} else if (usb_endpoint_is_bulk_out(pendp_desc)) {
 			pdvobjpriv->RtOutPipe[pdvobjpriv->RtNumOutPipes] =
 				ep_num;
@@ -117,6 +114,9 @@ static struct dvobj_priv *usb_dvobj_init(struct usb_interface *usb_intf)
 		}
 	}
 
+	if (rt_num_in_pipes != 1)
+		goto err;
+
 	if (pusbd->speed == USB_SPEED_HIGH) {
 		pdvobjpriv->ishighspeed = true;
 		DBG_88E("USB_SPEED_HIGH\n");
@@ -130,9 +130,11 @@ static struct dvobj_priv *usb_dvobj_init(struct usb_interface *usb_intf)
 	rtw_reset_continual_urb_error(pdvobjpriv);
 
 	usb_get_dev(pusbd);
-
-exit:
 	return pdvobjpriv;
+
+err:
+	kfree(pdvobjpriv);
+	return NULL;
 }
 
 static void usb_dvobj_deinit(struct usb_interface *usb_intf)
-- 
2.20.1

