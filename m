Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E9B35460B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 19:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238406AbhDER3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 13:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238299AbhDER3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 13:29:35 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B971C061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 10:29:27 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x15so2334342wrq.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 10:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rcUgpTqj2kdU+YBskPn+v5vQYu9sPyQVI1xkvuqXoSs=;
        b=Pcn1mDLVtc2ZToBS3hq3liVHxCZozL7WAC8eAFCcnnfpjQxtun1OD7nOkWsg03hmR8
         YHOTEuom5dqrubW9YGhKDojT24v1KNUi7RFLDcG0onDJ0xg698AImgstOFj3uBWqsDKo
         fb9pEqFiSeSpuIVxNPqlkiWuowNSFNJnK4celRjZHFYKsgdhpoyqWYzXyL/hQ+gkkkad
         Uu9RSmDuvVT7fBMD9j8K3gKjaj7Vk/hFUISjnRq2kVO6HS48WYwVDoUUUuaFI5CoXUk1
         CAhiLz3ym6DgWEx3EwDOP2h+ruEGSTgz6YXl+XTFCFfzCL1tPWDzxpGGaiK7uks61+jT
         ojUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rcUgpTqj2kdU+YBskPn+v5vQYu9sPyQVI1xkvuqXoSs=;
        b=SlZv16lX90btQtNSZbFAcFklTMkZn6rwh+cQebVe/my4KZQnbPa/3k3rnD4q5lMl4E
         aM819EsA8T8QrUmA5ZSPumriXcjNRXxUUTMSZ3luELNCXqkPssDHspZINXr/pIHsGeCy
         Bi+eIS4pIlBSZm+gqzCpg1hs+crhdcu8PnbCxQougk0a2GYVeqZuFQxja26hobtA0I/e
         uKQXitWL3AO4S73Ny9HGwqUyR33IRg9zq1d04IDyRI7zKse9sGA0zno39R0DGo1i7tI4
         I4vK3J0sxj2Bs2e5FhjnRtVLMpaA32YoieTy9DermreBRdLaZ29QwLA61LPFwTMRmbE/
         +iVg==
X-Gm-Message-State: AOAM532G122Ju/ixnBf6oyKm2Sv+WPTwMVMjCr9XpoRseDQtMYP5zbQ1
        H730PsqhLiA/ZcD81Y9Vrng=
X-Google-Smtp-Source: ABdhPJy7Ct4lChRU7qyUfTa66278O83sBZDYlZ5pKVDoGqpu9qC5ZlV99o2ANuG4EsRwmS4uvAYu5w==
X-Received: by 2002:a05:6000:c9:: with SMTP id q9mr3496265wrx.17.1617643765979;
        Mon, 05 Apr 2021 10:29:25 -0700 (PDT)
Received: from bcarvalho-Ubuntu.lan ([2001:818:de85:7e00:9a5b:98e6:2174:bf29])
        by smtp.gmail.com with ESMTPSA id x1sm17858699wro.66.2021.04.05.10.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 10:29:25 -0700 (PDT)
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH 4/4] staging: rtl8723bs: core: align arguments with open parenthesis
Date:   Mon,  5 Apr 2021 18:29:20 +0100
Message-Id: <00250c746ed850f6a73ff0ad4c1735cbd019b58f.1617641790.git.martinsdecarvalhobeatriz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1617641790.git.martinsdecarvalhobeatriz@gmail.com>
References: <cover.1617641790.git.martinsdecarvalhobeatriz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up checks of "Alignment should match open parenthesis"
in file rtw_ap.c

Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index ca6fec52d213..73a35b3320fe 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -439,7 +439,7 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 		arg[3] = psta->init_rate;
 
 		DBG_871X("%s => mac_id:%d , raid:%d , shortGIrate =%d, bitmap = 0x%x\n",
-			__func__, psta->mac_id, psta->raid, shortGIrate, tx_ra_bitmap);
+			 __func__, psta->mac_id, psta->raid, shortGIrate, tx_ra_bitmap);
 
 		rtw_hal_add_ra_tid(padapter, tx_ra_bitmap, arg, rssi_level);
 	} else {
@@ -512,7 +512,7 @@ void update_bmc_sta(struct adapter *padapter)
 			arg[3] = psta->init_rate;
 
 			DBG_871X("%s => mac_id:%d , raid:%d , bitmap = 0x%x\n",
-				__func__, psta->mac_id, psta->raid, tx_ra_bitmap);
+				 __func__, psta->mac_id, psta->raid, tx_ra_bitmap);
 
 			rtw_hal_add_ra_tid(padapter, tx_ra_bitmap, arg, 0);
 		}
@@ -605,14 +605,14 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 
 		/*  B0 Config LDPC Coding Capability */
 		if (TEST_FLAG(phtpriv_ap->ldpc_cap, LDPC_HT_ENABLE_TX) &&
-			GET_HT_CAPABILITY_ELE_LDPC_CAP((u8 *)(&phtpriv_sta->ht_cap))) {
+			      GET_HT_CAPABILITY_ELE_LDPC_CAP((u8 *)(&phtpriv_sta->ht_cap))) {
 			SET_FLAG(cur_ldpc_cap, (LDPC_HT_ENABLE_TX | LDPC_HT_CAP_TX));
 			DBG_871X("Enable HT Tx LDPC for STA(%d)\n", psta->aid);
 		}
 
 		/*  B7 B8 B9 Config STBC setting */
 		if (TEST_FLAG(phtpriv_ap->stbc_cap, STBC_HT_ENABLE_TX) &&
-			GET_HT_CAPABILITY_ELE_RX_STBC((u8 *)(&phtpriv_sta->ht_cap))) {
+			      GET_HT_CAPABILITY_ELE_RX_STBC((u8 *)(&phtpriv_sta->ht_cap))) {
 			SET_FLAG(cur_stbc_cap, (STBC_HT_ENABLE_TX | STBC_HT_CAP_TX));
 			DBG_871X("Enable HT Tx STBC for STA(%d)\n", psta->aid);
 		}
@@ -1176,7 +1176,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		);
 
 		if ((psecuritypriv->wpa_pairwise_cipher & WPA_CIPHER_CCMP) ||
-			(psecuritypriv->wpa2_pairwise_cipher & WPA_CIPHER_CCMP)) {
+		     (psecuritypriv->wpa2_pairwise_cipher & WPA_CIPHER_CCMP)) {
 			pht_cap->ampdu_params_info |= (IEEE80211_HT_CAP_AMPDU_DENSITY & (0x07 << 2));
 		} else {
 			pht_cap->ampdu_params_info |= (IEEE80211_HT_CAP_AMPDU_DENSITY & 0x00);
@@ -1233,7 +1233,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	pmlmepriv->htpriv.ht_option = false;
 
 	if ((psecuritypriv->wpa2_pairwise_cipher & WPA_CIPHER_TKIP) ||
-		      (psecuritypriv->wpa_pairwise_cipher & WPA_CIPHER_TKIP)) {
+	     (psecuritypriv->wpa_pairwise_cipher & WPA_CIPHER_TKIP)) {
 		/* todo: */
 		/* ht_cap = false; */
 	}
@@ -1820,7 +1820,7 @@ static int rtw_ht_operation_update(struct adapter *padapter)
 	}
 
 	DBG_871X("%s new operation mode = 0x%X changes =%d\n",
-		   __func__, pmlmepriv->ht_op_mode, op_mode_changes);
+		 __func__, pmlmepriv->ht_op_mode, op_mode_changes);
 
 	return op_mode_changes;
 }
@@ -1865,7 +1865,7 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 			pmlmepriv->num_sta_no_short_preamble++;
 
 			if ((pmlmeext->cur_wireless_mode > WIRELESS_11B) &&
-				(pmlmepriv->num_sta_no_short_preamble == 1)) {
+			    (pmlmepriv->num_sta_no_short_preamble == 1)) {
 				beacon_updated = true;
 				update_beacon(padapter, 0xFF, NULL, true);
 			}
-- 
2.25.1

