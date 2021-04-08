Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902D3358DF3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 21:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbhDHT6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 15:58:51 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:49760 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbhDHT6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 15:58:43 -0400
Received: from localhost.localdomain ([90.126.11.170])
        by mwinf5d05 with ME
        id qKyV240023g7mfN03KyVAX; Thu, 08 Apr 2021 21:58:30 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 08 Apr 2021 21:58:30 +0200
X-ME-IP: 90.126.11.170
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/3] staging: rtl8712: remove struct rtl_ieee80211_ht_cap and ieee80211_ht_addt_info
Date:   Thu,  8 Apr 2021 21:58:27 +0200
Message-Id: <4291cb10744457cc12c89fc9fd414c37d732bc9d.1617911201.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct 'ieee80211_ht_addt_info' is unused and can be removed.

struct 'rtl_ieee80211_ht_cap' can be replaced by 'ieee80211_ht_cap'
defined in <linux/ieee80211.h> which has the same layout.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/staging/rtl8712/rtl871x_ht.h          |  2 +-
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c |  6 ++--
 drivers/staging/rtl8712/rtl871x_mlme.c        | 10 +++---
 drivers/staging/rtl8712/wifi.h                | 35 -------------------
 4 files changed, 9 insertions(+), 44 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_ht.h b/drivers/staging/rtl8712/rtl871x_ht.h
index 4bcf5591c44d..ebd78665775d 100644
--- a/drivers/staging/rtl8712/rtl871x_ht.h
+++ b/drivers/staging/rtl8712/rtl871x_ht.h
@@ -26,7 +26,7 @@ struct ht_priv {
 	unsigned int	rx_ampdu_maxlen; /* for rx reordering ctrl win_sz,
 					  * updated when join_callback.
 					  */
-	struct rtl_ieee80211_ht_cap ht_cap;
+	struct ieee80211_ht_cap ht_cap;
 };
 
 #endif	/*_RTL871X_HT_H_ */
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
index 14fe12eb930c..3b6926613257 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
@@ -1389,7 +1389,7 @@ static int r8711_wx_get_rate(struct net_device *dev,
 	struct _adapter *padapter = netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct wlan_bssid_ex *pcur_bss = &pmlmepriv->cur_network.network;
-	struct rtl_ieee80211_ht_cap *pht_capie;
+	struct ieee80211_ht_cap *pht_capie;
 	unsigned char rf_type = padapter->registrypriv.rf_config;
 	int i;
 	u8 *p;
@@ -1405,8 +1405,8 @@ static int r8711_wx_get_rate(struct net_device *dev,
 			 pcur_bss->IELength - 12);
 	if (p && ht_ielen > 0) {
 		ht_cap = true;
-		pht_capie = (struct rtl_ieee80211_ht_cap *)(p + 2);
-		memcpy(&mcs_rate, pht_capie->supp_mcs_set, 2);
+		pht_capie = (struct ieee80211_ht_cap *)(p + 2);
+		memcpy(&mcs_rate, &pht_capie->mcs, 2);
 		bw_40MHz = (le16_to_cpu(pht_capie->cap_info) &
 			    IEEE80211_HT_CAP_SUP_WIDTH_20_40) ? 1 : 0;
 		short_GI = (le16_to_cpu(pht_capie->cap_info) &
diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index b377c0b94cfb..6328da8a498e 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -1640,7 +1640,7 @@ unsigned int r8712_restructure_ht_ie(struct _adapter *padapter, u8 *in_ie,
 {
 	u32 ielen, out_len;
 	unsigned char *p;
-	struct rtl_ieee80211_ht_cap ht_capie;
+	struct ieee80211_ht_cap ht_capie;
 	unsigned char WMM_IE[] = {0x00, 0x50, 0xf2, 0x02, 0x00, 0x01, 0x00};
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct qos_priv *pqospriv = &pmlmepriv->qospriv;
@@ -1656,7 +1656,7 @@ unsigned int r8712_restructure_ht_ie(struct _adapter *padapter, u8 *in_ie,
 			pqospriv->qos_option = 1;
 		}
 		out_len = *pout_len;
-		memset(&ht_capie, 0, sizeof(struct rtl_ieee80211_ht_cap));
+		memset(&ht_capie, 0, sizeof(struct ieee80211_ht_cap));
 		ht_capie.cap_info = cpu_to_le16(IEEE80211_HT_CAP_SUP_WIDTH_20_40 |
 				    IEEE80211_HT_CAP_SGI_20 |
 				    IEEE80211_HT_CAP_SGI_40 |
@@ -1666,7 +1666,7 @@ unsigned int r8712_restructure_ht_ie(struct _adapter *padapter, u8 *in_ie,
 		ht_capie.ampdu_params_info = (IEEE80211_HT_AMPDU_PARM_FACTOR &
 				0x03) | (IEEE80211_HT_AMPDU_PARM_DENSITY & 0x00);
 		r8712_set_ie(out_ie + out_len, WLAN_EID_HT_CAPABILITY,
-			     sizeof(struct rtl_ieee80211_ht_cap),
+			     sizeof(struct ieee80211_ht_cap),
 			     (unsigned char *)&ht_capie, pout_len);
 		phtpriv->ht_option = 1;
 	}
@@ -1680,7 +1680,7 @@ static void update_ht_cap(struct _adapter *padapter, u8 *pie, uint ie_len)
 	int i;
 	uint len;
 	struct sta_info *bmc_sta, *psta;
-	struct rtl_ieee80211_ht_cap *pht_capie;
+	struct ieee80211_ht_cap *pht_capie;
 	struct recv_reorder_ctrl *preorder_ctrl;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
@@ -1700,7 +1700,7 @@ static void update_ht_cap(struct _adapter *padapter, u8 *pie, uint ie_len)
 				&len, ie_len -
 				sizeof(struct NDIS_802_11_FIXED_IEs));
 	if (p && len > 0) {
-		pht_capie = (struct rtl_ieee80211_ht_cap *)(p + 2);
+		pht_capie = (struct ieee80211_ht_cap *)(p + 2);
 		max_ampdu_sz = (pht_capie->ampdu_params_info &
 				IEEE80211_HT_AMPDU_PARM_FACTOR);
 		/* max_ampdu_sz (kbytes); */
diff --git a/drivers/staging/rtl8712/wifi.h b/drivers/staging/rtl8712/wifi.h
index c4e756316b5e..61ebc730427f 100644
--- a/drivers/staging/rtl8712/wifi.h
+++ b/drivers/staging/rtl8712/wifi.h
@@ -276,40 +276,5 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
  */
 #define _WMM_IE_Length_				7  /* for WMM STA */
 
-/*-----------------------------------------------------------------------------
- *			Below is the definition for 802.11n
- *------------------------------------------------------------------------------
- */
-
-/*
- * struct rtl_ieee80211_ht_cap - HT capabilities
- *
- * This structure refers to "HT capabilities element" as
- * described in 802.11n draft section 7.3.2.52
- */
-
-struct rtl_ieee80211_ht_cap {
-	__le16	cap_info;
-	unsigned char	ampdu_params_info;
-	unsigned char	supp_mcs_set[16];
-	__le16	extended_ht_cap_info;
-	__le32	tx_BF_cap_info;
-	unsigned char	       antenna_selection_info;
-} __packed;
-
-/**
- * struct ieee80211_ht_addt_info - HT additional information
- *
- * This structure refers to "HT information element" as
- * described in 802.11n draft section 7.3.2.53
- */
-struct ieee80211_ht_addt_info {
-	unsigned char	control_chan;
-	unsigned char		ht_param;
-	__le16	operation_mode;
-	__le16	stbc_param;
-	unsigned char		basic_set[16];
-} __packed;
-
 #endif /* _WIFI_H_ */
 
-- 
2.27.0

