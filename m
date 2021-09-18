Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB774106F7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 15:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238325AbhIRN7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 09:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbhIRN7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 09:59:02 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E42DC061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 06:57:39 -0700 (PDT)
Received: from dslb-178-004-203-016.178.004.pools.vodafone-ip.de ([178.4.203.16] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mRaqV-0001vu-8k; Sat, 18 Sep 2021 15:57:35 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v3 2/2] staging: r8188eu: remove rtw_hw_resume
Date:   Sat, 18 Sep 2021 15:57:22 +0200
Message-Id: <20210918135722.23976-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210918135722.23976-1-martin@kaiser.cx>
References: <20210911161019.26881-1-martin@kaiser.cx>
 <20210918135722.23976-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c0a099b7341c ("staging: r8188eu: bHWPwrPindetect is always false")
removed the only call to rtw_hw_resume.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v3:
- another rebase against today's staging-testing branch

v2:
- rebased against today's staging-testing branch

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
index 25dc90847380..11a584cbe9d8 100644
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

