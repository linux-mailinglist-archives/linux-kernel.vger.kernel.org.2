Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A6A3DBB6E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239421AbhG3OyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239209AbhG3OyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:54:19 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0B3C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:54:13 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id go31so17243669ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7H3v8Qcwg8Lpys0E0Cq3kosQrL695o9ij2wxMs6+rrc=;
        b=cYm0JJXmbf9kgNWZrX4L0fpBOBO4+/Uka9V0kklQS1Kr4IJWmEMcKPmP1oox5hR161
         i9KPe2TkJrBsyvR+XjdOeWDWSeeggwN6WJ0d3p34mXi1G5B/8rqnPMobSvZFCp17UuLw
         +KOvFujApF/SdKhTNgPijeumee3XAp3RlGzd0Aix3puHo/sThb3R8lAoXD9Sh6Xim+IM
         eDfqUWmFrZki7hohN1zt1hoZzjKoHkJmBpIBf5Fy0FFFIXwpLDtjGB+FKWo2e0Ja0rrE
         QXnRBRCaOWguRPDSPtViQD5Z+02c5Fu4Tv8dA0aNE7SPiOzqBVzFXaMEwTIhCnAgn/O6
         kNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7H3v8Qcwg8Lpys0E0Cq3kosQrL695o9ij2wxMs6+rrc=;
        b=JmvLOLz5crHlNCPXsSgLAEJej6zTuj3J1+jBcpzb1RbEG8YAzHDnqSfJcOMIYlFizD
         H6muLHAnmTtSlY+CeJ1x+Uazrw5w27RqsJdvs5ZCpec7CRNlknYtq5mvMUDiARmy1JgO
         OJ7ZzLTXvAlNxAT04Nq/6fsJrG+G7QWb8ARKxABNE6D6VRQUiI9VClz9sZ4skWnCz/jt
         msMtqwxbIHMJ1qzf4rDUbOxZDR8iN7s6ckQUQhTo7ZT6KF0eod95piektM/We8GngXdd
         6uCmNKFxNRDWEVVIDTPsa2Ch7pfJqV82cut4aTkVu3xT2YgD/ggEOcUHPsMlhVeAT//1
         LMwQ==
X-Gm-Message-State: AOAM533T7KXtyacIXS6EHcl5zP1usxFtutbLj9HE/SeOCIXsPsVgAS9Y
        w6bgp2Y39vzddyhMOU5NXXaaJvTjxZc=
X-Google-Smtp-Source: ABdhPJyTp1O/3KaB3I5URmg26F9AFIrceeXRPfzgKDSqn3g2Wi8h+aBOlLLTv/uR/S88F3BrK+oAWA==
X-Received: by 2002:a17:906:7210:: with SMTP id m16mr3014734ejk.10.1627656851829;
        Fri, 30 Jul 2021 07:54:11 -0700 (PDT)
Received: from agape ([5.171.81.215])
        by smtp.gmail.com with ESMTPSA id l20sm642213ejb.23.2021.07.30.07.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 07:54:11 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] staging: rtl8723bs: fix camel case issue in struct wlan_bssid_ex
Date:   Fri, 30 Jul 2021 16:54:05 +0200
Message-Id: <a70fd91a46fd2c75eb27824ea57ae0d87d65bf81.1627656773.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1627656773.git.fabioaiuto83@gmail.com>
References: <cover.1627656773.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix camel case issue in field Reserved in struct wlan_bssid_ex

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c         | 12 ++++++------
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c     |  8 ++++----
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c    |  2 +-
 drivers/staging/rtl8723bs/include/wlan_bssdef.h   |  2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c    | 12 ++++++------
 6 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index a0c19253095d..9f97986e8680 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -483,8 +483,8 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 	}
 
 	if (update_ie) {
-		dst->Reserved[0] = src->Reserved[0];
-		dst->Reserved[1] = src->Reserved[1];
+		dst->reserved[0] = src->reserved[0];
+		dst->reserved[1] = src->reserved[1];
 		memcpy((u8 *)dst, (u8 *)src, get_wlan_bssid_ex_sz(src));
 	}
 
@@ -600,13 +600,13 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 
 		pnetwork->last_scanned = jiffies;
 
-		/* target.Reserved[0]== 1, means that scanned network is a bcn frame. */
-		if ((pnetwork->network.ie_length > target->ie_length) && (target->Reserved[0] == 1))
+		/* target.reserved[0]== 1, means that scanned network is a bcn frame. */
+		if ((pnetwork->network.ie_length > target->ie_length) && (target->reserved[0] == 1))
 			update_ie = false;
 
 		/*  probe resp(3) > beacon(1) > probe req(2) */
-		if ((target->Reserved[0] != 2) &&
-			(target->Reserved[0] >= pnetwork->network.Reserved[0])
+		if ((target->reserved[0] != 2) &&
+			(target->reserved[0] >= pnetwork->network.reserved[0])
 			) {
 			update_ie = true;
 		} else {
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 07986eeafe08..375d2a742dd2 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -3971,18 +3971,18 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 	subtype = GetFrameSubType(pframe);
 
 	if (subtype == WIFI_BEACON) {
-		bssid->Reserved[0] = 1;
+		bssid->reserved[0] = 1;
 		ie_offset = _BEACON_IE_OFFSET_;
 	} else {
 		/*  FIXME : more type */
 		if (subtype == WIFI_PROBERSP) {
 			ie_offset = _PROBERSP_IE_OFFSET_;
-			bssid->Reserved[0] = 3;
+			bssid->reserved[0] = 3;
 		} else if (subtype == WIFI_PROBEREQ) {
 			ie_offset = _PROBEREQ_IE_OFFSET_;
-			bssid->Reserved[0] = 2;
+			bssid->reserved[0] = 2;
 		} else {
-			bssid->Reserved[0] = 0;
+			bssid->reserved[0] = 0;
 			ie_offset = _FIXED_IE_LENGTH_;
 		}
 	}
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 2a2a8634beb7..865a82d5cedb 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1223,7 +1223,7 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	subtype = GetFrameSubType(pframe) >> 4;
 
 	if (subtype == WIFI_BEACON)
-		bssid->Reserved[0] = 1;
+		bssid->reserved[0] = 1;
 
 	bssid->length = sizeof(struct wlan_bssid_ex) - MAX_IE_SZ + len;
 
diff --git a/drivers/staging/rtl8723bs/include/wlan_bssdef.h b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
index 530c95275c1e..eb38594c8f5c 100644
--- a/drivers/staging/rtl8723bs/include/wlan_bssdef.h
+++ b/drivers/staging/rtl8723bs/include/wlan_bssdef.h
@@ -156,7 +156,7 @@ struct wlan_bcn_info {
 struct wlan_bssid_ex {
 	u32  length;
 	NDIS_802_11_MAC_ADDRESS  mac_address;
-	u8  Reserved[2];/* 0]: IS beacon frame */
+	u8  reserved[2];/* 0]: IS beacon frame */
 	struct ndis_802_11_ssid  ssid;
 	u32  privacy;
 	long  rssi;/* in dBM, raw data , get from PHY) */
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index dc23470fcdef..12b8e1773a84 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -305,7 +305,7 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 	SetSeqNum(pwlanhdr, 0/*pmlmeext->mgnt_seq*/);
 	/* pmlmeext->mgnt_seq++; */
 
-	if (pnetwork->network.Reserved[0] == 1) { /*  WIFI_BEACON */
+	if (pnetwork->network.reserved[0] == 1) { /*  WIFI_BEACON */
 		eth_broadcast_addr(pwlanhdr->addr1);
 		SetFrameSubType(pbuf, WIFI_BEACON);
 	} else {
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 1383f84a4425..19c5c7e8f403 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -84,7 +84,7 @@ static char *translate_scan(struct adapter *padapter,
 	u32 i = 0;
 	u8 bw_40MHz = 0, short_GI = 0;
 	u16 mcs_rate = 0, vht_data_rate = 0;
-	u8 ie_offset = (pnetwork->network.Reserved[0] == 2 ? 0 : 12);
+	u8 ie_offset = (pnetwork->network.reserved[0] == 2 ? 0 : 12);
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	u8 ss, sq;
 
@@ -102,7 +102,7 @@ static char *translate_scan(struct adapter *padapter,
 	start = iwe_stream_add_point(info, start, stop, &iwe, pnetwork->network.ssid.ssid);
 
 	/* parsing HT_CAP_IE */
-	if (pnetwork->network.Reserved[0] == 2) { /*  Probe Request */
+	if (pnetwork->network.reserved[0] == 2) { /*  Probe Request */
 		p = rtw_get_ie(&pnetwork->network.ies[0], WLAN_EID_HT_CAPABILITY, &ht_ielen, pnetwork->network.ie_length);
 	} else {
 		p = rtw_get_ie(&pnetwork->network.ies[12], WLAN_EID_HT_CAPABILITY, &ht_ielen, pnetwork->network.ie_length-12);
@@ -140,7 +140,7 @@ static char *translate_scan(struct adapter *padapter,
 	start = iwe_stream_add_event(info, start, stop, &iwe, IW_EV_CHAR_LEN);
 
 	  /* Add mode */
-	if (pnetwork->network.Reserved[0] == 2) { /*  Probe Request */
+	if (pnetwork->network.reserved[0] == 2) { /*  Probe Request */
 		cap = 0;
 	} else {
 		__le16 le_tmp;
@@ -211,7 +211,7 @@ static char *translate_scan(struct adapter *padapter,
 	start = iwe_stream_add_event(info, start, stop, &iwe, IW_EV_PARAM_LEN);
 
 	/* parsing WPA/WPA2 IE */
-	if (pnetwork->network.Reserved[0] != 2) { /*  Probe Request */
+	if (pnetwork->network.reserved[0] != 2) { /*  Probe Request */
 		u8 *buf;
 		u8 wpa_ie[255], rsn_ie[255];
 		u16 wpa_len = 0, rsn_len = 0;
@@ -274,7 +274,7 @@ static char *translate_scan(struct adapter *padapter,
 		u8 *ie_ptr;
 		total_ielen = pnetwork->network.ie_length - ie_offset;
 
-		if (pnetwork->network.Reserved[0] == 2) { /*  Probe Request */
+		if (pnetwork->network.reserved[0] == 2) { /*  Probe Request */
 			ie_ptr = pnetwork->network.ies;
 			total_ielen = pnetwork->network.ie_length;
 		} else {    /*  Beacon or Probe Respones */
@@ -324,7 +324,7 @@ static char *translate_scan(struct adapter *padapter,
 		if (!buf)
 			goto exit;
 
-		pos = pnetwork->network.Reserved;
+		pos = pnetwork->network.reserved;
 		memset(&iwe, 0, sizeof(iwe));
 		iwe.cmd = IWEVCUSTOM;
 		iwe.u.data.length = scnprintf(buf, MAX_WPA_IE_LEN, "fm =%02X%02X", pos[1], pos[0]);
-- 
2.20.1

