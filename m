Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C075840797B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 18:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhIKQMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 12:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhIKQLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 12:11:48 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566CDC061757
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 09:10:35 -0700 (PDT)
Received: from dslb-084-059-243-091.084.059.pools.vodafone-ip.de ([84.59.243.91] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mP5aJ-0007nr-HW; Sat, 11 Sep 2021 18:10:31 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/4] staging: r8188eu: remove rtw_hw_suspend
Date:   Sat, 11 Sep 2021 18:10:18 +0200
Message-Id: <20210911161019.26881-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210911161019.26881-1-martin@kaiser.cx>
References: <20210911161019.26881-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bHWPwrPindetect cleanup removed the only call to rtw_hw_suspend.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/osdep_intf.h |  1 -
 drivers/staging/r8188eu/os_dep/usb_intf.c    | 59 --------------------
 2 files changed, 60 deletions(-)

diff --git a/drivers/staging/r8188eu/include/osdep_intf.h b/drivers/staging/r8188eu/include/osdep_intf.h
index 3ea60feee2db..5a2c7a98f023 100644
--- a/drivers/staging/r8188eu/include/osdep_intf.h
+++ b/drivers/staging/r8188eu/include/osdep_intf.h
@@ -58,7 +58,6 @@ void rtw_ips_dev_unload(struct adapter *padapter);
 
 int rtw_ips_pwr_up(struct adapter *padapter);
 void rtw_ips_pwr_down(struct adapter *padapter);
-int rtw_hw_suspend(struct adapter *padapter);
 int rtw_hw_resume(struct adapter *padapter);
 
 #endif	/* _OSDEP_INTF_H_ */
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index fc5ed770cb71..f532dab0254c 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -278,65 +278,6 @@ static void process_spec_devid(const struct usb_device_id *pdid)
 	}
 }
 
-int rtw_hw_suspend(struct adapter *padapter)
-{
-	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
-	struct net_device *pnetdev = padapter->pnetdev;
-
-	if ((!padapter->bup) || (padapter->bDriverStopped) ||
-	    (padapter->bSurpriseRemoved)) {
-		DBG_88E("padapter->bup=%d bDriverStopped=%d bSurpriseRemoved = %d\n",
-			padapter->bup, padapter->bDriverStopped,
-			padapter->bSurpriseRemoved);
-		goto error_exit;
-	}
-
-	LeaveAllPowerSaveMode(padapter);
-
-	DBG_88E("==> rtw_hw_suspend\n");
-	_enter_pwrlock(&pwrpriv->lock);
-	pwrpriv->bips_processing = true;
-	/* s1. */
-	if (pnetdev) {
-		netif_carrier_off(pnetdev);
-		rtw_netif_stop_queue(pnetdev);
-	}
-
-	/* s2. */
-	rtw_disassoc_cmd(padapter, 500, false);
-
-	/* s2-2.  indicate disconnect to os */
-	{
-		struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
-
-		if (check_fwstate(pmlmepriv, _FW_LINKED)) {
-			_clr_fwstate_(pmlmepriv, _FW_LINKED);
-
-			rtw_led_control(padapter, LED_CTL_NO_LINK);
-
-			rtw_os_indicate_disconnect(padapter);
-
-			/* donnot enqueue cmd */
-			rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_DISCONNECT, 0);
-		}
-	}
-	/* s2-3. */
-	rtw_free_assoc_resources(padapter, 1);
-
-	/* s2-4. */
-	rtw_free_network_queue(padapter, true);
-	rtw_ips_dev_unload(padapter);
-	pwrpriv->rf_pwrstate = rf_off;
-	pwrpriv->bips_processing = false;
-
-	_exit_pwrlock(&pwrpriv->lock);
-	return 0;
-
-error_exit:
-	DBG_88E("%s, failed\n", __func__);
-	return -1;
-}
-
 int rtw_hw_resume(struct adapter *padapter)
 {
 	struct pwrctrl_priv *pwrpriv;
-- 
2.20.1

