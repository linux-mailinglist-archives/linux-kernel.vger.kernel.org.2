Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6DD345EF62
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 14:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242814AbhKZNtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 08:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240968AbhKZNrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 08:47:45 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C89C0619D6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 05:04:22 -0800 (PST)
Received: from dslb-178-004-171-146.178.004.pools.vodafone-ip.de ([178.4.171.146] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mqatm-0006Hl-BI; Fri, 26 Nov 2021 14:04:18 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 1/4] staging: r8188eu: remove pm_netdev_open
Date:   Fri, 26 Nov 2021 14:03:57 +0100
Message-Id: <20211126130400.26151-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211126130400.26151-1-martin@kaiser.cx>
References: <20211125164745.8188-1-martin@kaiser.cx>
 <20211126130400.26151-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only caller of pm_netdev_open sets bnormal to true. In this case,
pm_netdev_open just calls netdev_open.

Remove pm_netdev_open and call netdev_open directly.

Reviewed-by: Michael Straube <straube.linux@gmail.com>
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2:
 - add Reviewed-by

 drivers/staging/r8188eu/include/usb_osintf.h |  1 -
 drivers/staging/r8188eu/os_dep/os_intfs.c    | 11 -----------
 drivers/staging/r8188eu/os_dep/usb_intf.c    |  2 +-
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/include/usb_osintf.h b/drivers/staging/r8188eu/include/usb_osintf.h
index 624298b4bd0b..3e777ca52745 100644
--- a/drivers/staging/r8188eu/include/usb_osintf.h
+++ b/drivers/staging/r8188eu/include/usb_osintf.h
@@ -16,7 +16,6 @@ extern int rtw_mc2u_disable;
 u8 usbvendorrequest(struct dvobj_priv *pdvobjpriv, enum bt_usb_request brequest,
 		    enum rt_usb_wvalue wvalue, u8 windex, void *data,
 		    u8 datalen, u8 isdirectionin);
-int pm_netdev_open(struct net_device *pnetdev, u8 bnormal);
 void netdev_br_init(struct net_device *netdev);
 void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb);
 void *scdb_findEntry(struct adapter *priv, unsigned char *ipAddr);
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 5a5f182d30c9..397981bc9a62 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -760,17 +760,6 @@ void rtw_ips_dev_unload(struct adapter *padapter)
 		rtw_hal_deinit(padapter);
 }
 
-int pm_netdev_open(struct net_device *pnetdev, u8 bnormal)
-{
-	int status;
-
-	if (bnormal)
-		status = netdev_open(pnetdev);
-	else
-		status =  (_SUCCESS == ips_netdrv_open((struct adapter *)rtw_netdev_priv(pnetdev))) ? (0) : (-1);
-	return status;
-}
-
 int netdev_close(struct net_device *pnetdev)
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(pnetdev);
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index ba74cfc9a523..e66046c82973 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -297,7 +297,7 @@ static int rtw_resume(struct usb_interface *pusb_intf)
 		pwrpriv->bkeepfwalive = false;
 
 	DBG_88E("bkeepfwalive(%x)\n", pwrpriv->bkeepfwalive);
-	if (pm_netdev_open(pnetdev, true) != 0) {
+	if (netdev_open(pnetdev) != 0) {
 		mutex_unlock(&pwrpriv->lock);
 		goto exit;
 	}
-- 
2.20.1

