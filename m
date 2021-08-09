Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425883E4A42
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 18:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbhHIQv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 12:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbhHIQvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:51:11 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13143C061796
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 09:50:51 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h13so22313993wrp.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 09:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YH/WkCDYxN3/iqeL5lUPjhGa2P7aX4/pallRUPPCAJQ=;
        b=XDrBNfIIiXigZu6i2KFJEzqKBxA8slmvh6S4MAubUGlYw7Yab5epVAoOJiakl5IKcT
         UEX4cri/oTvAoK+WspvQ6zf5Cc/lvLW+1Q9q33hiSdCAKiugLIWjUTywVhdriP3eZydw
         LhKgIUxY8yOBSeGARyXNeq0cm+T7eYtBjir/PPliikaOtst2Hen38zVuVbjcuf/u5Ut7
         7yrqsSlQX8aB+EzAgLyLlFb2E6bAPVht699KSEVr9n4fbPNmQBzniKH4uQMbQfdqBa47
         esgibMLuSOE+SlUad2XRxxzMGrhlwTgT5qwOCZG7jhyLBaygjkrEk95ORNjG0Oko3wBB
         jzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YH/WkCDYxN3/iqeL5lUPjhGa2P7aX4/pallRUPPCAJQ=;
        b=aTeCA5BNa/+lubsF8+/wR+B9zum93u9mhgp19QX7PIkf+08p16dDQ9XOc6bEvcVciP
         nJyauySCSJeXUlMzovkSMSFsO/SQKx8qe+sZSOMxaxt6Dsy6oxmvXVsNUEv7Uxw4p0Nb
         ey8KzuTczGuw+iCJ1+oCLc+7XRDi9YqqtBsjPbsfzTCCKxdR8PPAcF8Xmsemvgs8kRxJ
         kgqWUvE0p8u9yy7UIxgK+ZbO9tjox+oE+5HvAChSu/pPh26mOD1+tSVzrRRaKmBRcELQ
         /uCkEAZawq0MGM4PCeIvhSaSh/seo522BWMBab+VmiyrBe3X4cciJtpjjyk2+ikCZjbm
         Mkqw==
X-Gm-Message-State: AOAM533RC2qDEnJEycQBLH4anpRX83mr1J7ck+gKK+MMQ8Uw0F7RJR7H
        TnmWttz8s6vsiWWxG8hHDpSqkl/L2Jg=
X-Google-Smtp-Source: ABdhPJy5tEznbCnzfu8/3Ma1IOAqaAZNjQl/wV0HfIWZs4F2bIaCpPEpZMTRJy2/9Lbf2HNA2GOoYg==
X-Received: by 2002:a5d:5987:: with SMTP id n7mr26764307wri.260.1628527849685;
        Mon, 09 Aug 2021 09:50:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::996b])
        by smtp.gmail.com with ESMTPSA id q5sm20484469wrx.33.2021.08.09.09.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 09:50:49 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 04/17] staging: r8188eu: remove unnecessary parentheses in core/rtw_ap.c
Date:   Mon,  9 Aug 2021 18:49:54 +0200
Message-Id: <20210809165007.23204-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210809165007.23204-1-straube.linux@gmail.com>
References: <20210809165007.23204-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses in core/rtw_ap.c reported by
checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c | 80 +++++++++++++--------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index ad37f1f02ee2..d7548619061e 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -12,7 +12,7 @@
 
 void init_mlme_ap_info(struct adapter *padapter)
 {
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct wlan_acl_pool *pacl_list = &pstapriv->acl_list;
 
@@ -28,9 +28,9 @@ void free_mlme_ap_info(struct adapter *padapter)
 {
 	struct sta_info *psta = NULL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	pmlmepriv->update_bcn = false;
 	pmlmeext->bstart_bss = false;
@@ -52,9 +52,9 @@ void free_mlme_ap_info(struct adapter *padapter)
 static void update_BCNTIM(struct adapter *padapter)
 {
 	struct sta_priv *pstapriv = &padapter->stapriv;
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *pnetwork_mlmeext = &(pmlmeinfo->network);
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *pnetwork_mlmeext = &pmlmeinfo->network;
 	unsigned char *pie = pnetwork_mlmeext->IEs;
 
 	/* update TIM IE */
@@ -426,7 +426,7 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 	unsigned char limit;
 	unsigned int tx_ra_bitmap = 0;
 	struct ht_priv	*psta_ht = NULL;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct wlan_bssid_ex *pcur_network = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
 
 	if (psta)
@@ -518,7 +518,7 @@ void update_bmc_sta(struct adapter *padapter)
 	unsigned char	network_type, raid;
 	int i, supportRateNum = 0;
 	unsigned int tx_ra_bitmap = 0;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct wlan_bssid_ex *pcur_network = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
 	struct sta_info *psta = rtw_get_bcmc_stainfo(padapter);
 
@@ -600,9 +600,9 @@ void update_bmc_sta(struct adapter *padapter)
 
 void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 {
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct ht_priv	*phtpriv_ap = &pmlmepriv->htpriv;
 	struct ht_priv	*phtpriv_sta = &psta->htpriv;
 	u16 sta_cap_info;
@@ -670,7 +670,7 @@ static void update_hw_ht_param(struct adapter *padapter)
 	unsigned char		max_AMPDU_len;
 	unsigned char		min_MPDU_spacing;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	DBG_88E("%s\n", __func__);
 
@@ -703,15 +703,15 @@ static void start_bss_network(struct adapter *padapter, u8 *pbuf)
 	u32	acparm;
 	int	ie_len;
 	struct registry_priv	 *pregpriv = &padapter->registrypriv;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct security_priv *psecuritypriv = &(padapter->securitypriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *pnetwork_mlmeext = &(pmlmeinfo->network);
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *pnetwork_mlmeext = &pmlmeinfo->network;
 	struct HT_info_element *pht_info = NULL;
 #ifdef CONFIG_88EU_P2P
-	struct wifidirect_info	*pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 #endif /* CONFIG_88EU_P2P */
 
 	bcn_interval = (u16)pnetwork->Configuration.BeaconPeriod;
@@ -846,7 +846,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	u8 WMM_PARA_IE[] = {0x00, 0x50, 0xf2, 0x02, 0x01, 0x01};
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct wlan_bssid_ex *pbss_network = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
 	u8 *ie = pbss_network->IEs;
 
@@ -880,7 +880,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 
 	pbss_network->Rssi = 0;
 
-	memcpy(pbss_network->MacAddress, myid(&(padapter->eeprompriv)), ETH_ALEN);
+	memcpy(pbss_network->MacAddress, myid(&padapter->eeprompriv), ETH_ALEN);
 
 	/* beacon interval */
 	p = rtw_get_beacon_interval_from_ie(ie);/* 8: TimeStamp, 2: Beacon Interval 2:Capability */
@@ -1219,10 +1219,10 @@ static void update_bcn_fixed_ie(struct adapter *padapter)
 
 static void update_bcn_erpinfo_ie(struct adapter *padapter)
 {
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 	unsigned char *p, *ie = pnetwork->IEs;
 	u32 len = 0;
 
@@ -1281,10 +1281,10 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 	u8 *pwps_ie = NULL, *pwps_ie_src;
 	u8 *premainder_ie, *pbackup_remainder_ie = NULL;
 	uint wps_ielen = 0, wps_offset, remainder_ielen;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
-	struct wlan_bssid_ex *pnetwork = &(pmlmeinfo->network);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
+	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 	unsigned char *ie = pnetwork->IEs;
 	u32 ielen = pnetwork->IELength;
 
@@ -1355,8 +1355,8 @@ void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx)
 	if (!padapter)
 		return;
 
-	pmlmepriv = &(padapter->mlmepriv);
-	pmlmeext = &(padapter->mlmeextpriv);
+	pmlmepriv = &padapter->mlmepriv;
+	pmlmeext = &padapter->mlmeextpriv;
 
 	if (!pmlmeext->bstart_bss)
 		return;
@@ -1413,7 +1413,7 @@ static int rtw_ht_operation_update(struct adapter *padapter)
 {
 	u16 cur_op_mode, new_op_mode;
 	int op_mode_changes = 0;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct ht_priv	*phtpriv_ap = &pmlmepriv->htpriv;
 
 	if (pmlmepriv->htpriv.ht_option)
@@ -1506,8 +1506,8 @@ void associated_clients_update(struct adapter *padapter, u8 updated)
 void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 {
 	u8 beacon_updated = false;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
 	if (!(psta->flags & WLAN_STA_SHORT_PREAMBLE)) {
 		if (!psta->no_short_preamble_set) {
@@ -1641,8 +1641,8 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta)
 {
 	u8 beacon_updated = false;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 
 	if (!psta)
 		return beacon_updated;
@@ -1750,7 +1750,7 @@ int rtw_ap_inform_ch_switch(struct adapter *padapter, u8 new_ch, u8 ch_offset)
 	struct sta_info *psta = NULL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
 	if ((pmlmeinfo->state&0x03) != WIFI_FW_AP_STATE)
@@ -1785,7 +1785,7 @@ int rtw_sta_flush(struct adapter *padapter)
 	struct sta_info *psta = NULL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
 	DBG_88E(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(padapter->pnetdev));
@@ -1821,7 +1821,7 @@ int rtw_sta_flush(struct adapter *padapter)
 void sta_info_update(struct adapter *padapter, struct sta_info *psta)
 {
 	int flags = psta->flags;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	/* update wmm cap. */
 	if (WLAN_STA_WME&flags)
@@ -1858,7 +1858,7 @@ void ap_sta_info_defer_update(struct adapter *padapter, struct sta_info *psta)
 void start_ap_mode(struct adapter *padapter)
 {
 	int i;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct wlan_acl_pool *pacl_list = &pstapriv->acl_list;
@@ -1894,7 +1894,7 @@ void start_ap_mode(struct adapter *padapter)
 	pmlmepriv->p2p_probe_resp_ie = NULL;
 
 	/* for ACL */
-	INIT_LIST_HEAD(&(pacl_list->acl_node_q.queue));
+	INIT_LIST_HEAD(&pacl_list->acl_node_q.queue);
 	pacl_list->num = 0;
 	pacl_list->mode = 0;
 	for (i = 0; i < NUM_ACL; i++) {
@@ -1909,7 +1909,7 @@ void stop_ap_mode(struct adapter *padapter)
 	struct rtw_wlan_acl_node *paclnode;
 	struct sta_info *psta = NULL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct wlan_acl_pool *pacl_list = &pstapriv->acl_list;
 	struct __queue *pacl_node_q = &pacl_list->acl_node_q;
-- 
2.32.0

