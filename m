Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C189B3408D1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhCRP1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbhCRP0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:26:50 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61131C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:26:50 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v11so5967804wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2dsKlAf/qEII96se9L5UfS3Ntz2FSu9YgdiWWeao6ag=;
        b=qUw3V8Ap5/nYrxdTb0uoQuga5GtkAgSh7OeulZts6sYKVnhmuAmsr+t8o+ufeGZv3A
         f01QsDGfZ3mYAwxNGMxzEXKfGKrJjhPDV35V2kIjdLZi5UyPbtLoOsIMZAsTeedXh9Ae
         IOEl2fdWk6EkG2wBWHRxriNa2LPW310bMzC9pz4PLsE0m+GYZKCXj+HdQe5WGXe7PF5k
         N7z4cnQfZuHAdM2tY8aeeW6yQYokUdtBfhakdjwTOct/684/cLgQ6VhCEoTgbYrPon6T
         b4pTwZxSzH4JkWQcTIO4/yVG/kVvYABL6AAgbbDMjKSGcn62El4Dc7K0xdV3wRBlBgvz
         H27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2dsKlAf/qEII96se9L5UfS3Ntz2FSu9YgdiWWeao6ag=;
        b=En8IpSL0HtpQpFUDMhjIhLsawU7jYmYzlmSdNzESKES2f73V5LCi6Exm8wXha7YQ2G
         Fe9IkRDqeKeU7MaQqxRN8PdGIekjnhw0TsfnJ4zvIx4IaUiNQEo3/vhV1GGKV553njNF
         hVxFu84l8CUlREt+AW67x/78OkcpasrhRbibd2yYO/q35sd374F3yqH3NXsOe9ZbfisE
         mQKtpEi1whgUzWbvIi0I73MhmI+nfJRTNPXJ+QC3EOr0XVEHlNH3v6MU5hNan+XEgkGk
         Xo9uiWlF0xDE71h1pTRoLvoSoyKX/BCn30pmbwmJ1GQwRQuDb0M5xGvCpZ+j6CF4/+pC
         6aKA==
X-Gm-Message-State: AOAM532edHp6ZSTawrLXZFMqTFJPdd+T2JWNCFmezhClTJrGpsH16cfI
        xXR0PkHJ4E7i88hMds+L4rs=
X-Google-Smtp-Source: ABdhPJzvQBvNESM6SUbyR2bmFVlmHgH/4WFJXyZR7Cla4mId1UXRS+EOUCZSGAlwF+Qni4LvZeqPOg==
X-Received: by 2002:adf:eb0a:: with SMTP id s10mr10457171wrn.6.1616081209180;
        Thu, 18 Mar 2021 08:26:49 -0700 (PDT)
Received: from agape ([151.46.162.59])
        by smtp.gmail.com with ESMTPSA id t8sm3374230wrr.10.2021.03.18.08.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 08:26:48 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 03/15] staging: rtl8723bs: remove unnecessary logging in core/rtw_mlme_ext.c
Date:   Thu, 18 Mar 2021 16:25:58 +0100
Message-Id: <20210318152610.16758-4-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210318152610.16758-1-fabioaiuto83@gmail.com>
References: <YFMb+7jjmj7Oty8B@kroah.com>
 <20210318152610.16758-1-fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch.pl issues:

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
987: FILE: drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:987:
+	DBG_871X("%s\n", __func__);
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
1115: FILE: drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:1115:
+	DBG_871X("%s\n", __func__);
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
1547: FILE: drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:1547:
+	DBG_871X("%s\n", __func__);
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
1760: FILE: drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:1760:
+	DBG_871X("%s\n", __func__);
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
1813: FILE: drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:1813:
+	DBG_871X("%s\n", __func__);
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
2340: FILE: drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:2340:
+	/* DBG_871X("%s\n", __func__); */
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
2499: FILE: drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:2499:
+	/* DBG_871X("%s\n", __func__); */
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
2948: FILE: drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:2948:
+	DBG_871X("%s\n", __func__);
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
2969: FILE: drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:2969:
+	DBG_871X("%s\n", __func__);
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
3445: FILE: drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:3445:
+	DBG_871X("%s\n", __func__);
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
3677: FILE: drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:3677:
+	DBG_871X("%s\n", __func__);
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
3915: FILE: drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:3915:
+	DBG_871X("%s\n", __func__);
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
4599: FILE: drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:4599:
+	DBG_871X("%s\n", __func__);
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
5355: FILE: drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:5355:
+	DBG_871X("=>%s\n", __func__);
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
5366: FILE: drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:5366:
+	DBG_871X("%s\n", __func__);

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 36 +------------------
 1 file changed, 1 insertion(+), 35 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index e60a2ed32de5..1633f868467b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -984,8 +984,6 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 	u8 *pframe = precv_frame->u.hdr.rx_data;
 	uint pkt_len = precv_frame->u.hdr.len;
 
-	DBG_871X("%s\n", __func__);
-
 	/* check A1 matches or not */
 	if (memcmp(myid(&(padapter->eeprompriv)), get_da(pframe), ETH_ALEN))
 		return _SUCCESS;
@@ -1111,9 +1109,6 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 	left = pkt_len - (sizeof(struct ieee80211_hdr_3addr) + ie_offset);
 	pos = pframe + (sizeof(struct ieee80211_hdr_3addr) + ie_offset);
 
-
-	DBG_871X("%s\n", __func__);
-
 	/*  check if this stat has been successfully authenticated/assocated */
 	if (!((pstat->state) & WIFI_FW_AUTH_SUCCESS)) {
 		if (!((pstat->state) & WIFI_FW_ASSOC_SUCCESS)) {
@@ -1544,8 +1539,6 @@ unsigned int OnAssocRsp(struct adapter *padapter, union recv_frame *precv_frame)
 	u8 *pframe = precv_frame->u.hdr.rx_data;
 	uint pkt_len = precv_frame->u.hdr.len;
 
-	DBG_871X("%s\n", __func__);
-
 	/* check A1 matches or not */
 	if (memcmp(myid(&(padapter->eeprompriv)), get_da(pframe), ETH_ALEN))
 		return _SUCCESS;
@@ -1757,7 +1750,6 @@ unsigned int OnDisassoc(struct adapter *padapter, union recv_frame *precv_frame)
 
 unsigned int OnAtim(struct adapter *padapter, union recv_frame *precv_frame)
 {
-	DBG_871X("%s\n", __func__);
 	return _SUCCESS;
 }
 
@@ -1810,8 +1802,6 @@ unsigned int OnAction_back(struct adapter *padapter, union recv_frame *precv_fra
 	u8 *pframe = precv_frame->u.hdr.rx_data;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
-	DBG_871X("%s\n", __func__);
-
 	/* check RA matches or not */
 	if (memcmp(myid(&(padapter->eeprompriv)), GetAddr1Ptr(pframe), ETH_ALEN))/* for if1, sta/ap mode */
 		return _SUCCESS;
@@ -2337,8 +2327,6 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	struct wlan_bssid_ex		*cur_network = &(pmlmeinfo->network);
 	u8 bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
-	/* DBG_871X("%s\n", __func__); */
-
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe) {
 		DBG_871X("%s, alloc mgnt frame fail\n", __func__);
@@ -2496,8 +2484,6 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 	struct wlan_bssid_ex		*cur_network = &(pmlmeinfo->network);
 	unsigned int	rate_len;
 
-	/* DBG_871X("%s\n", __func__); */
-
 	if (da == NULL)
 		return;
 
@@ -2945,7 +2931,6 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
 	rtw_wep_encrypt(padapter, (u8 *)pmgntframe);
-	DBG_871X("%s\n", __func__);
 	dump_mgntframe(padapter, pmgntframe);
 }
 
@@ -2966,8 +2951,6 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 	u8 *ie = pnetwork->IEs;
 	__le16 lestatus, le_tmp;
 
-	DBG_871X("%s\n", __func__);
-
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (pmgntframe == NULL)
 		return;
@@ -3442,8 +3425,6 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da,
 	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 
-	DBG_871X("%s\n", __func__);
-
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (pmgntframe == NULL)
 		goto exit;
@@ -3674,8 +3655,6 @@ void issue_action_SA_Query(struct adapter *padapter, unsigned char *raddr, unsig
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	__le16 le_tmp;
 
-	DBG_871X("%s\n", __func__);
-
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (pmgntframe == NULL) {
 		DBG_871X("%s: alloc_mgtxmitframe fail\n", __func__);
@@ -3911,10 +3890,6 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 	if (true == pmlmeinfo->bwmode_updated)
 		return;
 
-
-	DBG_871X("%s\n", __func__);
-
-
 	category = RTW_WLAN_CATEGORY_PUBLIC;
 	action = ACT_PUBLIC_BSSCOEXIST;
 
@@ -4596,8 +4571,6 @@ unsigned int receive_disconnect(struct adapter *padapter, unsigned char *MacAddr
 	if (!(!memcmp(MacAddr, get_my_bssid(&pmlmeinfo->network), ETH_ALEN)))
 		return _SUCCESS;
 
-	DBG_871X("%s\n", __func__);
-
 	if ((pmlmeinfo->state&0x03) == WIFI_FW_STATION_STATE) {
 		if (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) {
 			pmlmeinfo->state = WIFI_FW_NULL_STATE;
@@ -5287,7 +5260,7 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 		rtw_hal_set_hwreg(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
 		rtw_hal_set_hwreg(padapter, HW_VAR_BSSID, null_addr);
 
-		goto exit_mlmeext_joinbss_event_callback;
+		return;
 	}
 
 	if ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE)
@@ -5349,11 +5322,6 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 
 	if (get_iface_type(padapter) == IFACE_PORT0)
 		rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_CONNECT, 0);
-
-exit_mlmeext_joinbss_event_callback:
-
-	DBG_871X("=>%s\n", __func__);
-
 }
 
 /* currently only adhoc mode will go here */
@@ -5363,8 +5331,6 @@ void mlmeext_sta_add_event_callback(struct adapter *padapter, struct sta_info *p
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	u8 join_type;
 
-	DBG_871X("%s\n", __func__);
-
 	if ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) {
 		if (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) { /* adhoc master or sta_count>1 */
 
-- 
2.20.1

