Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1283E45DF11
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 17:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356611AbhKYRAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 12:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347615AbhKYQ6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:58:08 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA56C061372
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 08:48:01 -0800 (PST)
Received: from dslb-188-097-211-055.188.097.pools.vodafone-ip.de ([188.97.211.55] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mqHuf-0006ye-4A; Thu, 25 Nov 2021 17:47:57 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/4] staging: r8188eu: remove pm_netdev_open
Date:   Thu, 25 Nov 2021 17:47:42 +0100
Message-Id: <20211125164745.8188-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211125164745.8188-1-martin@kaiser.cx>
References: <20211125164745.8188-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only caller of pm_netdev_open sets bnormal to true. In this case,
pm_netdev_open just calls netdev_open.

Remove pm_netdev_open and call netdev_open directly.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
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
index eca1036a721f..984e408f9366 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -298,7 +298,7 @@ static int rtw_resume(struct usb_interface *pusb_intf)
 		pwrpriv->bkeepfwalive = false;
 
 	DBG_88E("bkeepfwalive(%x)\n", pwrpriv->bkeepfwalive);
-	if (pm_netdev_open(pnetdev, true) != 0) {
+	if (netdev_open(pnetdev) != 0) {
 		mutex_unlock(&pwrpriv->lock);
 		goto exit;
 	}
-- 
2.20.1

