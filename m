Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1648F40797C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 18:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhIKQMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 12:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhIKQLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 12:11:49 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB3AC061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 09:10:36 -0700 (PDT)
Received: from dslb-084-059-243-091.084.059.pools.vodafone-ip.de ([84.59.243.91] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mP5aK-0007nr-Sf; Sat, 11 Sep 2021 18:10:32 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/4] staging: r8188eu: remove rtw_hw_resume
Date:   Sat, 11 Sep 2021 18:10:19 +0200
Message-Id: <20210911161019.26881-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210911161019.26881-1-martin@kaiser.cx>
References: <20210911161019.26881-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bHWPwrPindetect cleanup removed the only call to rtw_hw_resume.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/osdep_intf.h |  1 -
 drivers/staging/r8188eu/os_dep/usb_intf.c    | 39 --------------------
 2 files changed, 40 deletions(-)

diff --git a/drivers/staging/r8188eu/include/osdep_intf.h b/drivers/staging/r8188eu/include/osdep_intf.h
index 5a2c7a98f023..da36770852f8 100644
--- a/drivers/staging/r8188eu/include/osdep_intf.h
+++ b/drivers/staging/r8188eu/include/osdep_intf.h
@@ -58,6 +58,5 @@ void rtw_ips_dev_unload(struct adapter *padapter);
 
 int rtw_ips_pwr_up(struct adapter *padapter);
 void rtw_ips_pwr_down(struct adapter *padapter);
-int rtw_hw_resume(struct adapter *padapter);
 
 #endif	/* _OSDEP_INTF_H_ */
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index f532dab0254c..da381f42f3f6 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -278,45 +278,6 @@ static void process_spec_devid(const struct usb_device_id *pdid)
 	}
 }
 
-int rtw_hw_resume(struct adapter *padapter)
-{
-	struct pwrctrl_priv *pwrpriv;
-	struct net_device *pnetdev = padapter->pnetdev;
-
-	if (!padapter)
-		goto error_exit;
-	pwrpriv = &padapter->pwrctrlpriv;
-	DBG_88E("==> rtw_hw_resume\n");
-	_enter_pwrlock(&pwrpriv->lock);
-	pwrpriv->bips_processing = true;
-	rtw_reset_drv_sw(padapter);
-
-	if (pm_netdev_open(pnetdev, false) != 0) {
-		_exit_pwrlock(&pwrpriv->lock);
-		goto error_exit;
-	}
-
-	netif_device_attach(pnetdev);
-	netif_carrier_on(pnetdev);
-
-	if (!netif_queue_stopped(pnetdev))
-		netif_start_queue(pnetdev);
-	else
-		netif_wake_queue(pnetdev);
-
-	pwrpriv->bkeepfwalive = false;
-
-	pwrpriv->rf_pwrstate = rf_on;
-	pwrpriv->bips_processing = false;
-
-	_exit_pwrlock(&pwrpriv->lock);
-
-	return 0;
-error_exit:
-	DBG_88E("%s, Open net dev failed\n", __func__);
-	return -1;
-}
-
 static int rtw_suspend(struct usb_interface *pusb_intf, pm_message_t message)
 {
 	struct dvobj_priv *dvobj = usb_get_intfdata(pusb_intf);
-- 
2.20.1

