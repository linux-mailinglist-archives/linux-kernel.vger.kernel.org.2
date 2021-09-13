Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA25E409CA0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 21:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240845AbhIMTCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 15:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238493AbhIMTCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 15:02:44 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331BCC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 12:01:27 -0700 (PDT)
Received: from 250.57.4.146.static.wline.lns.sme.cust.swisscom.ch ([146.4.57.250] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mPrCm-0005LG-4R; Mon, 13 Sep 2021 21:01:24 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 1/2] staging: r8188eu: brfoffbyhw is always false
Date:   Mon, 13 Sep 2021 20:59:56 +0200
Message-Id: <20210913185957.3166-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210913185957.3166-1-martin@kaiser.cx>
References: <20210911161019.26881-1-martin@kaiser.cx>
 <20210913185957.3166-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a consequence of the bHWPwrPindetect removal, brfoffbyhw is never set
to true any more. Remove the variable and code that depends on
brfoffbyhw == true.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2:
- rebased against today's staging-testing branch

 drivers/staging/r8188eu/include/rtw_pwrctrl.h | 1 -
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 7 -------
 drivers/staging/r8188eu/os_dep/usb_intf.c     | 1 -
 3 files changed, 9 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_pwrctrl.h b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
index 28e4041acb98..a77fb76a0b09 100644
--- a/drivers/staging/r8188eu/include/rtw_pwrctrl.h
+++ b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
@@ -114,7 +114,6 @@ struct pwrctrl_priv {
 	u8		wepkeymask;
 	u8		bHWPowerdown;/* if support hw power down */
 	u8		bkeepfwalive;
-	u8		brfoffbyhw;
 };
 
 #define rtw_get_ips_mode_req(pwrctrlpriv) \
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index ac218da94ce5..a76cb7bd6390 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -1289,11 +1289,6 @@ static int rtw_wx_get_scan(struct net_device *dev, struct iw_request_info *a,
 	int wait_status;
 	struct	wifidirect_info *pwdinfo = &padapter->wdinfo;
 
-	if (padapter->pwrctrlpriv.brfoffbyhw && padapter->bDriverStopped) {
-		ret = -EINVAL;
-		goto exit;
-	}
-
 	if (!rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE)) {
 		/*	P2P is enabled */
 		wait_for_surveydone = 200;
@@ -1336,8 +1331,6 @@ static int rtw_wx_get_scan(struct net_device *dev, struct iw_request_info *a,
 	wrqu->data.length = ev - extra;
 	wrqu->data.flags = 0;
 
-exit:
-
 	return ret;
 }
 
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index d04d2f658ce0..a23b0becb668 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -305,7 +305,6 @@ int rtw_hw_resume(struct adapter *padapter)
 		netif_wake_queue(pnetdev);
 
 	pwrpriv->bkeepfwalive = false;
-	pwrpriv->brfoffbyhw = false;
 
 	pwrpriv->rf_pwrstate = rf_on;
 	pwrpriv->bips_processing = false;
-- 
2.20.1

