Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625AD3572B8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354619AbhDGRGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354582AbhDGRGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:06:19 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D28C06175F;
        Wed,  7 Apr 2021 10:06:09 -0700 (PDT)
Received: from ipservice-092-217-079-185.092.217.pools.vodafone-ip.de ([92.217.79.185] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lUBd0-0001Q6-4H; Wed, 07 Apr 2021 19:06:06 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 10/10] staging: rtl8188eu: make rtw_usb_if1_init return a status
Date:   Wed,  7 Apr 2021 19:05:31 +0200
Message-Id: <20210407170531.29356-10-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407170531.29356-1-martin@kaiser.cx>
References: <20210407170531.29356-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return an error status instead of the struct adapter that was allocated
and filled. This is more useful for the probe function, who calls
rtw_usb_if1_init.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/os_dep/usb_intf.c | 28 ++++++++++-----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/usb_intf.c b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
index 71ef7941f688..3a970d67aa8c 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
@@ -322,17 +322,17 @@ static int rtw_resume(struct usb_interface *pusb_intf)
  *        We accept the new device by returning 0.
  */
 
-static struct adapter *rtw_usb_if1_init(struct usb_interface *pusb_intf)
+static int rtw_usb_if1_init(struct usb_interface *pusb_intf)
 {
 	struct dvobj_priv *dvobj = usb_get_intfdata(pusb_intf);
 	struct adapter *padapter;
 	struct net_device *pnetdev;
 	struct net_device *pmondev;
-	int status = _FAIL;
+	int err = 0;
 
 	pnetdev = rtw_init_netdev();
 	if (!pnetdev)
-		return NULL;
+		return -ENOMEM;
 	SET_NETDEV_DEV(pnetdev, dvobj_to_dev(dvobj));
 
 	padapter = netdev_priv(pnetdev);
@@ -352,6 +352,7 @@ static struct adapter *rtw_usb_if1_init(struct usb_interface *pusb_intf)
 	padapter->HalData = kzalloc(sizeof(struct hal_data_8188e), GFP_KERNEL);
 	if (!padapter->HalData) {
 		DBG_88E("Failed to allocate memory for HAL data\n");
+		err = -ENOMEM;
 		goto free_adapter;
 	}
 
@@ -368,6 +369,7 @@ static struct adapter *rtw_usb_if1_init(struct usb_interface *pusb_intf)
 	if (rtw_init_drv_sw(padapter) == _FAIL) {
 		RT_TRACE(_module_hci_intfs_c_, _drv_err_,
 			 ("Initialize driver software resource Failed!\n"));
+		err = -ENOMEM;
 		goto free_hal_data;
 	}
 
@@ -397,7 +399,8 @@ static struct adapter *rtw_usb_if1_init(struct usb_interface *pusb_intf)
 		 pnetdev->dev_addr);
 
 	/* step 6. Tell the network stack we exist */
-	if (register_netdev(pnetdev) != 0) {
+	err = register_netdev(pnetdev);
+	if (err) {
 		RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("register_netdev() failed\n"));
 		goto free_hal_data;
 	}
@@ -409,17 +412,13 @@ static struct adapter *rtw_usb_if1_init(struct usb_interface *pusb_intf)
 		, padapter->hw_init_completed
 	);
 
-	status = _SUCCESS;
+	return 0;
 
 free_hal_data:
-	if (status != _SUCCESS)
-		kfree(padapter->HalData);
+	kfree(padapter->HalData);
 free_adapter:
-	if (status != _SUCCESS) {
-		free_netdev(pnetdev);
-		padapter = NULL;
-	}
-	return padapter;
+	free_netdev(pnetdev);
+	return err;
 }
 
 static void rtw_usb_if1_deinit(struct adapter *if1)
@@ -458,10 +457,11 @@ static int rtw_drv_init(struct usb_interface *pusb_intf, const struct usb_device
 		return err;
 	}
 
-	if (!rtw_usb_if1_init(pusb_intf)) {
+	err = rtw_usb_if1_init(pusb_intf);
+	if (err) {
 		pr_debug("rtw_usb_if1_init failed\n");
 		usb_dvobj_deinit(pusb_intf);
-		return -ENODEV;
+		return err;
 	}
 
 	return 0;
-- 
2.20.1

