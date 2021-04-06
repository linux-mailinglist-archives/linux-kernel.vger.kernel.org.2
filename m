Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B81355D07
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 22:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245500AbhDFUls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 16:41:48 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:41633 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235692AbhDFUlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 16:41:46 -0400
Received: from localhost.localdomain ([90.126.11.170])
        by mwinf5d04 with ME
        id pYhY2400D3g7mfN03YhZxb; Tue, 06 Apr 2021 22:41:34 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 06 Apr 2021 22:41:34 +0200
X-ME-IP: 90.126.11.170
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] staging: rtl8712: Use constants from <linux/ieee80211.h>
Date:   Tue,  6 Apr 2021 22:41:32 +0200
Message-Id: <fe35fb45323adc3a30f31b7280cec7700fd325d8.1617741313.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some constants defined in wifi.h are already defined in <linux/ieee80211.h>
with some other (but similar) names.
Be consistent and use the ones from <linux/ieee80211.h>.

The conversions made are:
_SSID_IE_                -->  WLAN_EID_SSID
_SUPPORTEDRATES_IE_      -->  WLAN_EID_SUPP_RATES
_DSSET_IE_               -->  WLAN_EID_DS_PARAMS
_IBSS_PARA_IE_           -->  WLAN_EID_IBSS_PARAMS
_ERPINFO_IE_             -->  WLAN_EID_ERP_INFO
_EXT_SUPPORTEDRATES_IE_  -->  WLAN_EID_EXT_SUPP_RATES

_HT_CAPABILITY_IE_       -->  WLAN_EID_HT_CAPABILITY
_HT_EXTRA_INFO_IE_       -->  WLAN_EID_HT_OPERATION    (not used)
_HT_ADD_INFO_IE_         -->  WLAN_EID_HT_OPERATION

_VENDOR_SPECIFIC_IE_     -->  WLAN_EID_VENDOR_SPECIFIC

_RESERVED47_             --> (not used)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/staging/rtl8712/ieee80211.c           | 12 ++++++------
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c |  8 ++++----
 drivers/staging/rtl8712/rtl871x_mlme.c        | 10 +++++-----
 drivers/staging/rtl8712/rtl871x_xmit.c        |  3 ++-
 drivers/staging/rtl8712/wifi.h                | 15 ---------------
 5 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/rtl8712/ieee80211.c b/drivers/staging/rtl8712/ieee80211.c
index 13fc3c1ec0db..f926809b1021 100644
--- a/drivers/staging/rtl8712/ieee80211.c
+++ b/drivers/staging/rtl8712/ieee80211.c
@@ -181,25 +181,25 @@ int r8712_generate_ie(struct registry_priv *registrypriv)
 	sz += 2;
 	ie += 2;
 	/*SSID*/
-	ie = r8712_set_ie(ie, _SSID_IE_, dev_network->Ssid.SsidLength,
+	ie = r8712_set_ie(ie, WLAN_EID_SSID, dev_network->Ssid.SsidLength,
 			  dev_network->Ssid.Ssid, &sz);
 	/*supported rates*/
 	set_supported_rate(dev_network->rates, registrypriv->wireless_mode);
 	rate_len = r8712_get_rateset_len(dev_network->rates);
 	if (rate_len > 8) {
-		ie = r8712_set_ie(ie, _SUPPORTEDRATES_IE_, 8,
+		ie = r8712_set_ie(ie, WLAN_EID_SUPP_RATES, 8,
 				  dev_network->rates, &sz);
-		ie = r8712_set_ie(ie, _EXT_SUPPORTEDRATES_IE_, (rate_len - 8),
+		ie = r8712_set_ie(ie, WLAN_EID_EXT_SUPP_RATES, (rate_len - 8),
 				  (dev_network->rates + 8), &sz);
 	} else {
-		ie = r8712_set_ie(ie, _SUPPORTEDRATES_IE_,
+		ie = r8712_set_ie(ie, WLAN_EID_SUPP_RATES,
 				  rate_len, dev_network->rates, &sz);
 	}
 	/*DS parameter set*/
-	ie = r8712_set_ie(ie, _DSSET_IE_, 1,
+	ie = r8712_set_ie(ie, WLAN_EID_DS_PARAMS, 1,
 			  (u8 *)&dev_network->Configuration.DSConfig, &sz);
 	/*IBSS Parameter Set*/
-	ie = r8712_set_ie(ie, _IBSS_PARA_IE_, 2,
+	ie = r8712_set_ie(ie, WLAN_EID_IBSS_PARAMS, 2,
 			  (u8 *)&dev_network->Configuration.ATIMWindow, &sz);
 	return sz;
 }
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
index 60dd798a6e51..8fb02458618d 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
@@ -236,7 +236,7 @@ static char *translate_scan(struct _adapter *padapter,
 	start = iwe_stream_add_point(info, start, stop, &iwe,
 				     pnetwork->network.Ssid.Ssid);
 	/* parsing HT_CAP_IE */
-	p = r8712_get_ie(&pnetwork->network.IEs[12], _HT_CAPABILITY_IE_,
+	p = r8712_get_ie(&pnetwork->network.IEs[12], WLAN_EID_HT_CAPABILITY,
 			 &ht_ielen, pnetwork->network.IELength - 12);
 	if (p && ht_ielen > 0)
 		ht_cap = true;
@@ -567,7 +567,7 @@ static int r871x_set_wpa_ie(struct _adapter *padapter, char *pie,
 			while (cnt < ielen) {
 				eid = buf[cnt];
 
-				if ((eid == _VENDOR_SPECIFIC_IE_) &&
+				if ((eid == WLAN_EID_VENDOR_SPECIFIC) &&
 				    (!memcmp(&buf[cnt + 2], wps_oui, 4))) {
 					netdev_info(padapter->pnetdev, "r8712u: SET WPS_IE\n");
 					padapter->securitypriv.wps_ie_len =
@@ -609,7 +609,7 @@ static int r8711_wx_get_name(struct net_device *dev,
 	if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE) ==
 	    true) {
 		/* parsing HT_CAP_IE */
-		p = r8712_get_ie(&pcur_bss->IEs[12], _HT_CAPABILITY_IE_,
+		p = r8712_get_ie(&pcur_bss->IEs[12], WLAN_EID_HT_CAPABILITY,
 				 &ht_ielen, pcur_bss->IELength - 12);
 		if (p && ht_ielen > 0)
 			ht_cap = true;
@@ -1403,7 +1403,7 @@ static int r8711_wx_get_rate(struct net_device *dev,
 	i = 0;
 	if (!check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE))
 		return -ENOLINK;
-	p = r8712_get_ie(&pcur_bss->IEs[12], _HT_CAPABILITY_IE_, &ht_ielen,
+	p = r8712_get_ie(&pcur_bss->IEs[12], WLAN_EID_HT_CAPABILITY, &ht_ielen,
 			 pcur_bss->IELength - 12);
 	if (p && ht_ielen > 0) {
 		ht_cap = true;
diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index f5886b39b3b5..2fa8ad00ead4 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -1650,11 +1650,11 @@ unsigned int r8712_restructure_ht_ie(struct _adapter *padapter, u8 *in_ie,
 	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 
 	phtpriv->ht_option = 0;
-	p = r8712_get_ie(in_ie + 12, _HT_CAPABILITY_IE_, &ielen, in_len - 12);
+	p = r8712_get_ie(in_ie + 12, WLAN_EID_HT_CAPABILITY, &ielen, in_len - 12);
 	if (p && (ielen > 0)) {
 		if (pqospriv->qos_option == 0) {
 			out_len = *pout_len;
-			r8712_set_ie(out_ie + out_len, _VENDOR_SPECIFIC_IE_,
+			r8712_set_ie(out_ie + out_len, WLAN_EID_VENDOR_SPECIFIC,
 				     _WMM_IE_Length_, WMM_IE, pout_len);
 			pqospriv->qos_option = 1;
 		}
@@ -1668,7 +1668,7 @@ unsigned int r8712_restructure_ht_ie(struct _adapter *padapter, u8 *in_ie,
 				    IEEE80211_HT_CAP_DSSSCCK40);
 		ht_capie.ampdu_params_info = (IEEE80211_HT_AMPDU_PARM_FACTOR &
 				0x03) | (IEEE80211_HT_AMPDU_PARM_DENSITY & 0x00);
-		r8712_set_ie(out_ie + out_len, _HT_CAPABILITY_IE_,
+		r8712_set_ie(out_ie + out_len, WLAN_EID_HT_CAPABILITY,
 			     sizeof(struct rtl_ieee80211_ht_cap),
 			     (unsigned char *)&ht_capie, pout_len);
 		phtpriv->ht_option = 1;
@@ -1699,7 +1699,7 @@ static void update_ht_cap(struct _adapter *padapter, u8 *pie, uint ie_len)
 	/*check Max Rx A-MPDU Size*/
 	len = 0;
 	p = r8712_get_ie(pie + sizeof(struct NDIS_802_11_FIXED_IEs),
-				_HT_CAPABILITY_IE_,
+				WLAN_EID_HT_CAPABILITY,
 				&len, ie_len -
 				sizeof(struct NDIS_802_11_FIXED_IEs));
 	if (p && len > 0) {
@@ -1734,7 +1734,7 @@ static void update_ht_cap(struct _adapter *padapter, u8 *pie, uint ie_len)
 	}
 	len = 0;
 	p = r8712_get_ie(pie + sizeof(struct NDIS_802_11_FIXED_IEs),
-		   _HT_ADD_INFO_IE_, &len,
+		   WLAN_EID_HT_OPERATION, &len,
 		   ie_len - sizeof(struct NDIS_802_11_FIXED_IEs));
 }
 
diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
index fd99782a400a..15491859aeda 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -22,6 +22,7 @@
 #include "osdep_intf.h"
 #include "usb_ops.h"
 
+#include <linux/ieee80211.h>
 
 static const u8 P802_1H_OUI[P80211_OUI_LEN] = {0x00, 0x00, 0xf8};
 static const u8 RFC1042_OUI[P80211_OUI_LEN] = {0x00, 0x00, 0x00};
@@ -709,7 +710,7 @@ void r8712_update_protection(struct _adapter *padapter, u8 *ie, uint ie_len)
 		break;
 	case AUTO_VCS:
 	default:
-		perp = r8712_get_ie(ie, _ERPINFO_IE_, &erp_len, ie_len);
+		perp = r8712_get_ie(ie, WLAN_EID_ERP_INFO, &erp_len, ie_len);
 		if (!perp) {
 			pxmitpriv->vcs = NONE_VCS;
 		} else {
diff --git a/drivers/staging/rtl8712/wifi.h b/drivers/staging/rtl8712/wifi.h
index f941efb1f4e2..b8269b97fd11 100644
--- a/drivers/staging/rtl8712/wifi.h
+++ b/drivers/staging/rtl8712/wifi.h
@@ -245,21 +245,6 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
 
 #define _FIXED_IE_LENGTH_	_BEACON_IE_OFFSET_
 
-#define _SSID_IE_		0
-#define _SUPPORTEDRATES_IE_	1
-#define _DSSET_IE_		3
-#define _IBSS_PARA_IE_		6
-#define _ERPINFO_IE_		42
-#define _EXT_SUPPORTEDRATES_IE_	50
-
-#define _HT_CAPABILITY_IE_	45
-#define _HT_EXTRA_INFO_IE_	61
-#define _HT_ADD_INFO_IE_	61 /* _HT_EXTRA_INFO_IE_ */
-
-#define _VENDOR_SPECIFIC_IE_	221
-
-#define	_RESERVED47_		47
-
 /* ---------------------------------------------------------------------------
  *			Below is the fixed elements...
  * ---------------------------------------------------------------------------
-- 
2.27.0

