Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C42A358DF8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 21:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhDHT7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 15:59:08 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:39847 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhDHT7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 15:59:06 -0400
Received: from localhost.localdomain ([90.126.11.170])
        by mwinf5d05 with ME
        id qKyt240033g7mfN03KytBu; Thu, 08 Apr 2021 21:58:53 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 08 Apr 2021 21:58:53 +0200
X-ME-IP: 90.126.11.170
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/3] staging: rtl8712: remove (most of) enum WIFI_FRAME_TYPE
Date:   Thu,  8 Apr 2021 21:58:53 +0200
Message-Id: <e009a4ee6429a3f79742f9a912e3f6a650fb33ed.1617911201.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <4291cb10744457cc12c89fc9fd414c37d732bc9d.1617911201.git.christophe.jaillet@wanadoo.fr>
References: <4291cb10744457cc12c89fc9fd414c37d732bc9d.1617911201.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The values defined in enum WIFI_FRAME_TYPE are the same the #define
IEEE80211_FTYPE_xxx from <linux/ieee80211.h>

Use these values to avoid code duplication.

WIFI_QOS_DATA_TYPE is a bit more tricky and doesn't have a direct
equivalence in <linux/ieee80211.h>. So leave this one as-is for now.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/staging/rtl8712/rtl871x_recv.c | 7 ++++---
 drivers/staging/rtl8712/rtl871x_xmit.c | 5 ++---
 drivers/staging/rtl8712/wifi.h         | 3 ---
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_recv.c b/drivers/staging/rtl8712/rtl871x_recv.c
index c13076b0e3d1..db2add576418 100644
--- a/drivers/staging/rtl8712/rtl871x_recv.c
+++ b/drivers/staging/rtl8712/rtl871x_recv.c
@@ -21,6 +21,7 @@
 #include <linux/if_ether.h>
 #include <linux/kmemleak.h>
 #include <linux/etherdevice.h>
+#include <linux/ieee80211.h>
 #include <net/cfg80211.h>
 
 #include "osdep_service.h"
@@ -565,13 +566,13 @@ sint r8712_validate_recv_frame(struct _adapter *adapter,
 	pattrib->privacy =  GetPrivacy(ptr);
 	pattrib->order = GetOrder(ptr);
 	switch (type) {
-	case WIFI_MGT_TYPE: /*mgnt*/
+	case IEEE80211_FTYPE_MGMT:
 		retval = validate_recv_mgnt_frame(adapter, precv_frame);
 		break;
-	case WIFI_CTRL_TYPE:/*ctrl*/
+	case IEEE80211_FTYPE_CTL:
 		retval = validate_recv_ctrl_frame(adapter, precv_frame);
 		break;
-	case WIFI_DATA_TYPE: /*data*/
+	case IEEE80211_FTYPE_DATA:
 		pattrib->qos = (subtype & BIT(7)) ? 1 : 0;
 		retval = validate_recv_data_frame(adapter, precv_frame);
 		break;
diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
index 15491859aeda..bb4de927fb02 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -18,7 +18,6 @@
 
 #include "osdep_service.h"
 #include "drv_types.h"
-#include "wifi.h"
 #include "osdep_intf.h"
 #include "usb_ops.h"
 
@@ -294,7 +293,7 @@ int r8712_update_attrib(struct _adapter *padapter, _pkt *pkt,
 		r8712_set_qos(&pktfile, pattrib);
 	} else {
 		pattrib->hdrlen = WLAN_HDR_A3_LEN;
-		pattrib->subtype = WIFI_DATA_TYPE;
+		pattrib->subtype = IEEE80211_FTYPE_DATA;
 		pattrib->priority = 0;
 	}
 	if (psta->ieee8021x_blocked) {
@@ -480,7 +479,7 @@ static int make_wlanhdr(struct _adapter *padapter, u8 *hdr,
 
 	memset(hdr, 0, WLANHDR_OFFSET);
 	SetFrameSubType(fctrl, pattrib->subtype);
-	if (!(pattrib->subtype & WIFI_DATA_TYPE))
+	if (!(pattrib->subtype & IEEE80211_FTYPE_DATA))
 		return 0;
 
 	bssid = get_bssid(pmlmepriv);
diff --git a/drivers/staging/rtl8712/wifi.h b/drivers/staging/rtl8712/wifi.h
index 68c253b0f66d..577a95c62d6c 100644
--- a/drivers/staging/rtl8712/wifi.h
+++ b/drivers/staging/rtl8712/wifi.h
@@ -23,9 +23,6 @@
 #define P80211CAPTURE_VERSION	0x80211001
 
 enum WIFI_FRAME_TYPE {
-	WIFI_MGT_TYPE  =	(0),
-	WIFI_CTRL_TYPE =	(BIT(2)),
-	WIFI_DATA_TYPE =	(BIT(3)),
 	WIFI_QOS_DATA_TYPE	= (BIT(7) | BIT(3)),	/*!< QoS Data */
 };
 
-- 
2.27.0

