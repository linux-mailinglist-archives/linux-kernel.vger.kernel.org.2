Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF24C3E34A5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhHGKNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbhHGKMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:12:46 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89730C0613D3
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 03:12:08 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id w5so197583ejq.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 03:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=58u2FJuWuA47ZDrh35oXOeGJPX+yKzsfZ5B6RjigtYs=;
        b=ircHYuxOC5cizSUJsQAVrYLKEKO3VTFNl7eVP203RDQGtolG1hf7ARi8alTNvMLH8x
         aDWxWJ4ZebJPhT53wigzOGXEOLzKzuZlWHVaKb17awqmz1mf+9MlkDNCCOC65J17+G0R
         eQqwC2HtUPme6kweppf3XQNyB6PJeE47EZZr6aTdP150A7Cj/dY3eOCRy9Dw0c/NdZzh
         0jJOy1ohY7bhhO+ncaVmhq2ZRNG/jlUcTtc2hSLdiZib/m7BYJnfleL+0gXkz8igFQv/
         nYH+K6NSxetMCy7BAc33ST3OLp3NJj4P9CLVKeAOt4DTVBVKdXKZI6MSOmQekHgs7YHU
         F1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=58u2FJuWuA47ZDrh35oXOeGJPX+yKzsfZ5B6RjigtYs=;
        b=Hl+NEjMxKw0Io43pheAbYz8kp5hK5ghy4XDB5LdO2BogzJxt7wTBBTWHwLyuCrc3XY
         BFVJQSKJKmO2IGwS3B+J5aWeI3tYn9ISyPHlPy7vior9FrTirqk98L2bSki7BPy1JvaL
         To46C+LQ/USTBpH9pGkwNOWsezWvhF8zXtI57FB/z6kRzRtR0R85ramfYdiASmDWgY8H
         7DHNhqzvQo9oPRp5AfG4r1s+C8dMAAQDpDmQQ7O6+lSqi1U+5RM11jT1xhPYpOCYMupY
         EOjYdz+Yz+lpR4VnkQGOCc8kXVkH4/6H1f+7zzZvnVImk10m7M2PDWP5bp4EZ/XiVwkk
         70mA==
X-Gm-Message-State: AOAM5300bsnDWc6YVJ6dPTcqcXrXBGy67XGm/qC48QGOiC5yaaf5l6L8
        V3nly73bnqrcYd7VuycPDR8=
X-Google-Smtp-Source: ABdhPJyR083oBqrcIuWhvP+bGQGI/nhok6h95tOEP6nu3txsxeWW1xiXrzglp+6+3oNnvPPZ69pGWA==
X-Received: by 2002:a17:907:1c9f:: with SMTP id nb31mr14255091ejc.114.1628331127018;
        Sat, 07 Aug 2021 03:12:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::a83e])
        by smtp.gmail.com with ESMTPSA id u4sm3662514eje.81.2021.08.07.03.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 03:12:06 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 01/17] staging: r8188eu: remove unnecessary parentheses in os_dep dir
Date:   Sat,  7 Aug 2021 12:11:03 +0200
Message-Id: <20210807101119.16085-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210807101119.16085-1-straube.linux@gmail.com>
References: <20210807101119.16085-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses in the os_dep directory reported by
checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 162 +++++++++---------
 drivers/staging/r8188eu/os_dep/os_intfs.c     |   4 +-
 .../staging/r8188eu/os_dep/osdep_service.c    |   4 +-
 drivers/staging/r8188eu/os_dep/recv_linux.c   |   4 +-
 drivers/staging/r8188eu/os_dep/rtw_android.c  |   2 +-
 drivers/staging/r8188eu/os_dep/usb_intf.c     |   2 +-
 6 files changed, 89 insertions(+), 89 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 34dce01e469c..83529ff1fd5d 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -168,7 +168,7 @@ static char *translate_scan(struct adapter *padapter,
 			    struct wlan_network *pnetwork,
 			    char *start, char *stop)
 {
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct iw_event iwe;
 	u16 cap;
 	__le16 le_tmp;
@@ -551,7 +551,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 				ret = -EOPNOTSUPP;
 				goto exit;
 			}
-		      memcpy(&(psecuritypriv->dot11DefKey[wep_key_idx].skey[0]), pwep->KeyMaterial, pwep->KeyLength);
+		      memcpy(&psecuritypriv->dot11DefKey[wep_key_idx].skey[0], pwep->KeyMaterial, pwep->KeyLength);
 			psecuritypriv->dot11DefKeylen[wep_key_idx] = pwep->KeyLength;
 			rtw_set_key(padapter, psecuritypriv, wep_key_idx, 0);
 		}
@@ -578,8 +578,8 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 					memcpy(psta->dot118021x_UncstKey.skey,  param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 
 					if (strcmp(param->u.crypt.alg, "TKIP") == 0) { /* set mic key */
-						memcpy(psta->dot11tkiptxmickey.skey, &(param->u.crypt.key[16]), 8);
-						memcpy(psta->dot11tkiprxmickey.skey, &(param->u.crypt.key[24]), 8);
+						memcpy(psta->dot11tkiptxmickey.skey, &param->u.crypt.key[16], 8);
+						memcpy(psta->dot11tkiprxmickey.skey, &param->u.crypt.key[24], 8);
 						padapter->securitypriv.busetkipkey = false;
 					}
 
@@ -588,8 +588,8 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 					rtw_setstakey_cmd(padapter, (unsigned char *)psta, true);
 				} else { /* group key */
 					memcpy(padapter->securitypriv.dot118021XGrpKey[param->u.crypt.idx].skey,  param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
-					memcpy(padapter->securitypriv.dot118021XGrptxmickey[param->u.crypt.idx].skey, &(param->u.crypt.key[16]), 8);
-					memcpy(padapter->securitypriv.dot118021XGrprxmickey[param->u.crypt.idx].skey, &(param->u.crypt.key[24]), 8);
+					memcpy(padapter->securitypriv.dot118021XGrptxmickey[param->u.crypt.idx].skey, &param->u.crypt.key[16], 8);
+					memcpy(padapter->securitypriv.dot118021XGrprxmickey[param->u.crypt.idx].skey, &param->u.crypt.key[24], 8);
 					padapter->securitypriv.binstallGrpkey = true;
 					DBG_88E(" ~~~~set sta key:groupkey\n");
 
@@ -768,7 +768,7 @@ static int rtw_wx_get_name(struct net_device *dev,
 	u32 ht_ielen = 0;
 	char *p;
 	u8 ht_cap = false;
-	struct	mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
+	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
 	NDIS_802_11_RATES_EX *prates = NULL;
 
@@ -834,7 +834,7 @@ static int rtw_wx_get_freq(struct net_device *dev,
 			     union iwreq_data *wrqu, char *extra)
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct	mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
+	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
@@ -906,7 +906,7 @@ static int rtw_wx_get_mode(struct net_device *dev, struct iw_request_info *a,
 			     union iwreq_data *wrqu, char *b)
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct	mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
+	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, (" rtw_wx_get_mode\n"));
 
@@ -1115,10 +1115,10 @@ static int rtw_wx_set_wap(struct net_device *dev,
 	uint ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct sockaddr *temp = (struct sockaddr *)awrq;
-	struct	mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
+	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 	struct list_head *phead;
 	u8 *dst_bssid, *src_bssid;
-	struct __queue *queue	= &(pmlmepriv->scanned_queue);
+	struct __queue *queue	= &pmlmepriv->scanned_queue;
 	struct	wlan_network	*pnetwork = NULL;
 	enum ndis_802_11_auth_mode	authmode;
 
@@ -1185,7 +1185,7 @@ static int rtw_wx_get_wap(struct net_device *dev,
 			    union iwreq_data *wrqu, char *extra)
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct	mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
+	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
 
 	wrqu->ap_addr.sa_family = ARPHRD_ETHER;
@@ -1250,7 +1250,7 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct ndis_802_11_ssid ssid[RTW_SSID_SCAN_AMOUNT];
 #ifdef CONFIG_88EU_P2P
-	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 #endif /* CONFIG_88EU_P2P */
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_set_scan\n"));
 
@@ -1392,8 +1392,8 @@ static int rtw_wx_get_scan(struct net_device *dev, struct iw_request_info *a,
 {
 	struct list_head *plist, *phead;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct	mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
-	struct __queue *queue	= &(pmlmepriv->scanned_queue);
+	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
+	struct __queue *queue	= &pmlmepriv->scanned_queue;
 	struct	wlan_network	*pnetwork = NULL;
 	char *ev = extra;
 	char *stop = ev + wrqu->data.length;
@@ -1584,7 +1584,7 @@ static int rtw_wx_get_essid(struct net_device *dev,
 {
 	u32 len, ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct	mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
+	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
 
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_essid\n"));
@@ -1815,7 +1815,7 @@ static int rtw_wx_set_enc(struct net_device *dev,
 	struct ndis_802_11_wep	 wep;
 	enum ndis_802_11_auth_mode authmode;
 
-	struct iw_point *erq = &(wrqu->encoding);
+	struct iw_point *erq = &wrqu->encoding;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
 	DBG_88E("+rtw_wx_set_enc, flags = 0x%x\n", erq->flags);
@@ -1930,8 +1930,8 @@ static int rtw_wx_get_enc(struct net_device *dev,
 {
 	uint key, ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct iw_point *erq = &(wrqu->encoding);
-	struct	mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
+	struct iw_point *erq = &wrqu->encoding;
+	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 
 
 
@@ -2019,7 +2019,7 @@ static int rtw_wx_set_auth(struct net_device *dev,
 			     union iwreq_data *wrqu, char *extra)
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct iw_param *param = (struct iw_param *)&(wrqu->param);
+	struct iw_param *param = (struct iw_param *)&wrqu->param;
 	int ret = 0;
 
 	switch (param->flags & IW_AUTH_INDEX) {
@@ -2554,8 +2554,8 @@ static int rtw_get_ap_info(struct net_device *dev,
 	char data[32];
 	struct wlan_network *pnetwork = NULL;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct __queue *queue = &(pmlmepriv->scanned_queue);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct __queue *queue = &pmlmepriv->scanned_queue;
 	struct iw_point *pdata = &wrqu->data;
 
 	DBG_88E("+rtw_get_aplist_info\n");
@@ -2699,7 +2699,7 @@ static int rtw_wext_p2p_enable(struct net_device *dev,
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	enum P2P_ROLE init_role = P2P_ROLE_DISABLE;
 
@@ -2749,7 +2749,7 @@ static int rtw_p2p_set_go_nego_ssid(struct net_device *dev,
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
 	DBG_88E("[%s] ssid = %s, len = %zu\n", __func__, extra, strlen(extra));
 	memcpy(pwdinfo->nego_ssid, extra, strlen(extra));
@@ -2764,7 +2764,7 @@ static int rtw_p2p_set_intent(struct net_device *dev,
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 	u8 intent = pwdinfo->intent;
 
 	switch (wrqu->data.length) {
@@ -2789,7 +2789,7 @@ static int rtw_p2p_set_listen_ch(struct net_device *dev,
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 	u8 listen_ch = pwdinfo->listen_channel;	/*	Listen channel number */
 
 	switch (wrqu->data.length) {
@@ -2822,7 +2822,7 @@ static int rtw_p2p_set_op_ch(struct net_device *dev,
 
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 	u8 op_ch = pwdinfo->operating_channel;	/*	Operating channel number */
 
 	switch (wrqu->data.length) {
@@ -2850,7 +2850,7 @@ static int rtw_p2p_profilefound(struct net_device *dev,
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
 	/*	Comment by Albert 2010/10/13 */
 	/*	Input data format: */
@@ -2897,7 +2897,7 @@ static int rtw_p2p_setDN(struct net_device *dev,
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
 	DBG_88E("[%s] %s %d\n", __func__, extra, wrqu->data.length - 1);
 	memset(pwdinfo->device_name, 0x00, WPS_MAX_DEVICE_NAME_LEN);
@@ -2913,7 +2913,7 @@ static int rtw_p2p_get_status(struct net_device *dev,
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
 	if (padapter->bShowGetP2PState)
 		DBG_88E("[%s] Role = %d, Status = %d, peer addr = %.2X:%.2X:%.2X:%.2X:%.2X:%.2X\n", __func__, rtw_p2p_role(pwdinfo), rtw_p2p_state(pwdinfo),
@@ -2940,7 +2940,7 @@ static int rtw_p2p_get_req_cm(struct net_device *dev,
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
 	sprintf(extra, "\n\nCM =%s\n", pwdinfo->rx_prov_disc_info.strconfig_method_desc_of_prov_disc_req);
 	wrqu->data.length = strlen(extra);
@@ -2953,7 +2953,7 @@ static int rtw_p2p_get_role(struct net_device *dev,
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
 	DBG_88E("[%s] Role = %d, Status = %d, peer addr = %.2X:%.2X:%.2X:%.2X:%.2X:%.2X\n", __func__, rtw_p2p_role(pwdinfo), rtw_p2p_state(pwdinfo),
 			pwdinfo->p2p_peer_interface_addr[0], pwdinfo->p2p_peer_interface_addr[1], pwdinfo->p2p_peer_interface_addr[2],
@@ -2970,7 +2970,7 @@ static int rtw_p2p_get_peer_ifaddr(struct net_device *dev,
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
 	DBG_88E("[%s] Role = %d, Status = %d, peer addr = %pM\n", __func__,
 		rtw_p2p_role(pwdinfo), rtw_p2p_state(pwdinfo),
@@ -2988,7 +2988,7 @@ static int rtw_p2p_get_peer_devaddr(struct net_device *dev,
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
 	DBG_88E("[%s] Role = %d, Status = %d, peer addr = %pM\n", __func__,
 		rtw_p2p_role(pwdinfo), rtw_p2p_state(pwdinfo),
@@ -3006,7 +3006,7 @@ static int rtw_p2p_get_peer_devaddr_by_invitation(struct net_device *dev,
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
 	DBG_88E("[%s] Role = %d, Status = %d, peer addr = %pM\n",
 		__func__, rtw_p2p_role(pwdinfo), rtw_p2p_state(pwdinfo),
@@ -3024,7 +3024,7 @@ static int rtw_p2p_get_groupid(struct net_device *dev,
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
 	sprintf(extra, "\n%.2X:%.2X:%.2X:%.2X:%.2X:%.2X %s",
 		pwdinfo->groupid_info.go_device_addr[0], pwdinfo->groupid_info.go_device_addr[1],
@@ -3042,7 +3042,7 @@ static int rtw_p2p_get_op_ch(struct net_device *dev,
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
 	DBG_88E("[%s] Op_ch = %02x\n", __func__, pwdinfo->operating_channel);
 
@@ -3062,7 +3062,7 @@ static int rtw_p2p_get_wps_configmethod(struct net_device *dev,
 	u8 peerMACStr[17] = {0x00};
 	struct mlme_priv		*pmlmepriv = &padapter->mlmepriv;
 	struct list_head *plist, *phead;
-	struct __queue *queue	= &(pmlmepriv->scanned_queue);
+	struct __queue *queue	= &pmlmepriv->scanned_queue;
 	struct	wlan_network	*pnetwork = NULL;
 	u8 blnMatch = 0;
 	u16	attr_content = 0;
@@ -3130,7 +3130,7 @@ static int rtw_p2p_get_go_device_address(struct net_device *dev,
 	u8 peerMACStr[17] = {0x00};
 	struct mlme_priv		*pmlmepriv = &padapter->mlmepriv;
 	struct list_head *plist, *phead;
-	struct __queue *queue	= &(pmlmepriv->scanned_queue);
+	struct __queue *queue	= &pmlmepriv->scanned_queue;
 	struct	wlan_network	*pnetwork = NULL;
 	u8 blnMatch = 0;
 	u8 *p2pie;
@@ -3213,7 +3213,7 @@ static int rtw_p2p_get_device_type(struct net_device *dev,
 	u8 peerMACStr[17] = {0x00};
 	struct mlme_priv		*pmlmepriv = &padapter->mlmepriv;
 	struct list_head *plist, *phead;
-	struct __queue *queue	= &(pmlmepriv->scanned_queue);
+	struct __queue *queue	= &pmlmepriv->scanned_queue;
 	struct	wlan_network	*pnetwork = NULL;
 	u8 blnMatch = 0;
 	u8 dev_type[8] = {0x00};
@@ -3289,7 +3289,7 @@ static int rtw_p2p_get_device_name(struct net_device *dev,
 	u8 peerMACStr[17] = {0x00};
 	struct mlme_priv		*pmlmepriv = &padapter->mlmepriv;
 	struct list_head *plist, *phead;
-	struct __queue *queue	= &(pmlmepriv->scanned_queue);
+	struct __queue *queue	= &pmlmepriv->scanned_queue;
 	struct	wlan_network	*pnetwork = NULL;
 	u8 blnMatch = 0;
 	u8 dev_name[WPS_MAX_DEVICE_NAME_LEN] = {0x00};
@@ -3355,7 +3355,7 @@ static int rtw_p2p_get_invitation_procedure(struct net_device *dev,
 	u8 peerMACStr[17] = {0x00};
 	struct mlme_priv		*pmlmepriv = &padapter->mlmepriv;
 	struct list_head *plist, *phead;
-	struct __queue *queue	= &(pmlmepriv->scanned_queue);
+	struct __queue *queue	= &pmlmepriv->scanned_queue;
 	struct	wlan_network	*pnetwork = NULL;
 	u8 blnMatch = 0;
 	u8 *p2pie;
@@ -3426,12 +3426,12 @@ static int rtw_p2p_connect(struct net_device *dev,
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 	u8 peerMAC[ETH_ALEN] = {0x00};
 	int jj, kk;
 	struct mlme_priv		*pmlmepriv = &padapter->mlmepriv;
 	struct list_head *plist, *phead;
-	struct __queue *queue	= &(pmlmepriv->scanned_queue);
+	struct __queue *queue	= &pmlmepriv->scanned_queue;
 	struct	wlan_network	*pnetwork = NULL;
 	uint uintPeerChannel = 0;
 
@@ -3505,11 +3505,11 @@ static int rtw_p2p_invite_req(struct net_device *dev,
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 	int jj, kk;
 	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 	struct list_head *plist, *phead;
-	struct __queue *queue	= &(pmlmepriv->scanned_queue);
+	struct __queue *queue	= &pmlmepriv->scanned_queue;
 	struct	wlan_network	*pnetwork = NULL;
 	uint uintPeerChannel = 0;
 	u8 attr_content[50] = {0x00};
@@ -3614,7 +3614,7 @@ static int rtw_p2p_set_persistent(struct net_device *dev,
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
 	/*	The input data is 0 or 1 */
 	/*	0: disable persistent group functionality */
@@ -3643,12 +3643,12 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 	u8 peerMAC[ETH_ALEN] = {0x00};
 	int jj, kk;
 	struct mlme_priv		*pmlmepriv = &padapter->mlmepriv;
 	struct list_head *plist, *phead;
-	struct __queue *queue	= &(pmlmepriv->scanned_queue);
+	struct __queue *queue	= &pmlmepriv->scanned_queue;
 	struct	wlan_network	*pnetwork = NULL;
 	uint uintPeerChannel = 0;
 	u8 attr_content[100] = {0x00};
@@ -3775,7 +3775,7 @@ static int rtw_p2p_got_wpsinfo(struct net_device *dev,
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct wifidirect_info *pwdinfo = &(padapter->wdinfo);
+	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
 	DBG_88E("[%s] data = %s\n", __func__, extra);
 	/*	Added by Albert 20110328 */
@@ -4077,11 +4077,11 @@ static int rtw_dbg_port(struct net_device *dev,
 	u32 *pdata, val32;
 	struct sta_info *psta;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
-	struct wlan_network *cur_network = &(pmlmepriv->cur_network);
+	struct wlan_network *cur_network = &pmlmepriv->cur_network;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
 	pdata = (u32 *)&wrqu->data;
@@ -4388,7 +4388,7 @@ static int rtw_dbg_port(struct net_device *dev,
 				spin_lock_bh(&pstapriv->sta_hash_lock);
 
 				for (i = 0; i < NUM_STA; i++) {
-					phead = &(pstapriv->sta_hash[i]);
+					phead = &pstapriv->sta_hash[i];
 					plist = phead->next;
 
 					while (phead != plist) {
@@ -4759,7 +4759,7 @@ static int set_group_key(struct adapter *padapter, u8 *key, u8 alg, int keyid)
 	u8 keylen;
 	struct cmd_obj *pcmd;
 	struct setkey_parm *psetkeyparm;
-	struct cmd_priv	*pcmdpriv = &(padapter->cmdpriv);
+	struct cmd_priv	*pcmdpriv = &padapter->cmdpriv;
 	int res = _SUCCESS;
 
 	DBG_88E("%s\n", __func__);
@@ -4798,7 +4798,7 @@ static int set_group_key(struct adapter *padapter, u8 *key, u8 alg, int keyid)
 		keylen = 16;
 	}
 
-	memcpy(&(psetkeyparm->key[0]), key, keylen);
+	memcpy(&psetkeyparm->key[0], key, keylen);
 
 	pcmd->cmdcode = _SetKey_CMD_;
 	pcmd->parmbuf = (u8 *)psetkeyparm;
@@ -4841,7 +4841,7 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 	struct sta_info *psta = NULL, *pbcmc_sta = NULL;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
-	struct security_priv *psecuritypriv = &(padapter->securitypriv);
+	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
 	DBG_88E("%s\n", __func__);
@@ -4912,7 +4912,7 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 
 			psecuritypriv->dot11PrivacyKeyIndex = wep_key_idx;
 
-			memcpy(&(psecuritypriv->dot11DefKey[wep_key_idx].skey[0]), pwep->KeyMaterial, pwep->KeyLength);
+			memcpy(&psecuritypriv->dot11DefKey[wep_key_idx].skey[0], pwep->KeyMaterial, pwep->KeyLength);
 
 			psecuritypriv->dot11DefKeylen[wep_key_idx] = pwep->KeyLength;
 
@@ -4923,7 +4923,7 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 			/* don't update "psecuritypriv->dot11PrivacyAlgrthm" and */
 			/* psecuritypriv->dot11PrivacyKeyIndex = keyid", but can rtw_set_key to cam */
 
-		      memcpy(&(psecuritypriv->dot11DefKey[wep_key_idx].skey[0]), pwep->KeyMaterial, pwep->KeyLength);
+		      memcpy(&psecuritypriv->dot11DefKey[wep_key_idx].skey[0], pwep->KeyMaterial, pwep->KeyLength);
 
 			psecuritypriv->dot11DefKeylen[wep_key_idx] = pwep->KeyLength;
 
@@ -4950,8 +4950,8 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 				memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey,
 					    param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 				/* set mic key */
-				memcpy(psecuritypriv->dot118021XGrptxmickey[param->u.crypt.idx].skey, &(param->u.crypt.key[16]), 8);
-				memcpy(psecuritypriv->dot118021XGrprxmickey[param->u.crypt.idx].skey, &(param->u.crypt.key[24]), 8);
+				memcpy(psecuritypriv->dot118021XGrptxmickey[param->u.crypt.idx].skey, &param->u.crypt.key[16], 8);
+				memcpy(psecuritypriv->dot118021XGrprxmickey[param->u.crypt.idx].skey, &param->u.crypt.key[24], 8);
 
 				psecuritypriv->busetkipkey = true;
 			} else if (strcmp(param->u.crypt.alg, "CCMP") == 0) {
@@ -4993,8 +4993,8 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 					psta->dot118021XPrivacy = _TKIP_;
 
 					/* set mic key */
-					memcpy(psta->dot11tkiptxmickey.skey, &(param->u.crypt.key[16]), 8);
-					memcpy(psta->dot11tkiprxmickey.skey, &(param->u.crypt.key[24]), 8);
+					memcpy(psta->dot11tkiptxmickey.skey, &param->u.crypt.key[16], 8);
+					memcpy(psta->dot11tkiprxmickey.skey, &param->u.crypt.key[24], 8);
 
 					psecuritypriv->busetkipkey = true;
 				} else if (strcmp(param->u.crypt.alg, "CCMP") == 0) {
@@ -5024,8 +5024,8 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 						    param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 
 					/* set mic key */
-					memcpy(psecuritypriv->dot118021XGrptxmickey[param->u.crypt.idx].skey, &(param->u.crypt.key[16]), 8);
-					memcpy(psecuritypriv->dot118021XGrprxmickey[param->u.crypt.idx].skey, &(param->u.crypt.key[24]), 8);
+					memcpy(psecuritypriv->dot118021XGrptxmickey[param->u.crypt.idx].skey, &param->u.crypt.key[16], 8);
+					memcpy(psecuritypriv->dot118021XGrprxmickey[param->u.crypt.idx].skey, &param->u.crypt.key[24], 8);
 
 					psecuritypriv->busetkipkey = true;
 				} else if (strcmp(param->u.crypt.alg, "CCMP") == 0) {
@@ -5065,7 +5065,7 @@ static int rtw_set_beacon(struct net_device *dev, struct ieee_param *param, int
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	unsigned char *pbuf = param->u.bcn_ie.buf;
 
@@ -5106,7 +5106,7 @@ static int rtw_add_sta(struct net_device *dev, struct ieee_param *param)
 	int ret = 0;
 	struct sta_info *psta = NULL;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
 	DBG_88E("rtw_add_sta(aid =%d) =%pM\n", param->u.add_sta.aid, (param->sta_addr));
@@ -5161,7 +5161,7 @@ static int rtw_del_sta(struct net_device *dev, struct ieee_param *param)
 	int ret = 0;
 	struct sta_info *psta = NULL;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	int updated = 0;
 
@@ -5198,7 +5198,7 @@ static int rtw_ioctl_get_sta_data(struct net_device *dev, struct ieee_param *par
 	int ret = 0;
 	struct sta_info *psta = NULL;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct ieee_param_ex *param_ex = (struct ieee_param_ex *)param;
 	struct sta_data *psta_data = (struct sta_data *)param_ex->data;
@@ -5255,7 +5255,7 @@ static int rtw_get_sta_wpaie(struct net_device *dev, struct ieee_param *param)
 	int ret = 0;
 	struct sta_info *psta = NULL;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
 	DBG_88E("rtw_get_sta_wpaie, sta_addr: %pM\n", (param->sta_addr));
@@ -5293,8 +5293,8 @@ static int rtw_set_wps_beacon(struct net_device *dev, struct ieee_param *param,
 	int ret = 0;
 	unsigned char wps_oui[4] = {0x0, 0x50, 0xf2, 0x04};
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	int ie_len;
 
 	DBG_88E("%s, len =%d\n", __func__, len);
@@ -5331,7 +5331,7 @@ static int rtw_set_wps_probe_resp(struct net_device *dev, struct ieee_param *par
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	int ie_len;
 
 	DBG_88E("%s, len =%d\n", __func__, len);
@@ -5363,7 +5363,7 @@ static int rtw_set_wps_assoc_resp(struct net_device *dev, struct ieee_param *par
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	int ie_len;
 
 	DBG_88E("%s, len =%d\n", __func__, len);
@@ -5396,9 +5396,9 @@ static int rtw_set_hidden_ssid(struct net_device *dev, struct ieee_param *param,
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
-	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
-	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
 
 	u8 value;
 
@@ -5421,7 +5421,7 @@ static int rtw_ioctl_acl_remove_sta(struct net_device *dev, struct ieee_param *p
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
 		return -EINVAL;
@@ -5438,7 +5438,7 @@ static int rtw_ioctl_acl_add_sta(struct net_device *dev, struct ieee_param *para
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
 		return -EINVAL;
@@ -5455,7 +5455,7 @@ static int rtw_ioctl_set_macaddr_acl(struct net_device *dev, struct ieee_param *
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
 		return -EINVAL;
@@ -5582,7 +5582,7 @@ static int rtw_wx_set_priv(struct net_device *dev,
 	/* added for wps2.0 @20110524 */
 	if (dwrq->flags == 0x8766 && len > 8) {
 		u32 cp_sz;
-		struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+		struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 		u8 *probereq_wpsie = ext;
 		int probereq_wpsie_len = len;
 		u8 wps_oui[4] = {0x0, 0x50, 0xf2, 0x04};
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 935e35c82666..9de31d0e7800 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -591,8 +591,8 @@ static int rtw_net_set_mac_address(struct net_device *pnetdev, void *p)
 static struct net_device_stats *rtw_net_get_stats(struct net_device *pnetdev)
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(pnetdev);
-	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
-	struct recv_priv *precvpriv = &(padapter->recvpriv);
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
+	struct recv_priv *precvpriv = &padapter->recvpriv;
 
 	padapter->stats.tx_packets = pxmitpriv->tx_pkts;/* pxmitpriv->tx_pkts++; */
 	padapter->stats.rx_packets = precvpriv->rx_pkts;/* precvpriv->rx_pkts++; */
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index 9f097f2b3ddd..22e22924948e 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -96,8 +96,8 @@ void	_rtw_mutex_free(struct mutex *pmutex)
 
 void	_rtw_init_queue(struct __queue *pqueue)
 {
-	INIT_LIST_HEAD(&(pqueue->queue));
-	spin_lock_init(&(pqueue->lock));
+	INIT_LIST_HEAD(&pqueue->queue);
+	spin_lock_init(&pqueue->lock);
 }
 
 inline u32 rtw_systime_to_ms(u32 systime)
diff --git a/drivers/staging/r8188eu/os_dep/recv_linux.c b/drivers/staging/r8188eu/os_dep/recv_linux.c
index 1fd3f1bf1fe5..7c3299fb1c1a 100644
--- a/drivers/staging/r8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/r8188eu/os_dep/recv_linux.c
@@ -114,8 +114,8 @@ int rtw_recv_indicatepkt(struct adapter *padapter,
 	struct sk_buff *skb;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	precvpriv = &(padapter->recvpriv);
-	pfree_recv_queue = &(precvpriv->free_recv_queue);
+	precvpriv = &padapter->recvpriv;
+	pfree_recv_queue = &precvpriv->free_recv_queue;
 
 	skb = precv_frame->pkt;
 	if (!skb) {
diff --git a/drivers/staging/r8188eu/os_dep/rtw_android.c b/drivers/staging/r8188eu/os_dep/rtw_android.c
index b55c86131dc7..d666feb87a7a 100644
--- a/drivers/staging/r8188eu/os_dep/rtw_android.c
+++ b/drivers/staging/r8188eu/os_dep/rtw_android.c
@@ -78,7 +78,7 @@ static int rtw_android_get_rssi(struct net_device *net, char *command,
 				int total_len)
 {
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(net);
-	struct	mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
+	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 	struct	wlan_network	*pcur_network = &pmlmepriv->cur_network;
 	int bytes_written = 0;
 
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index b1184c36ddfc..e1af4e05ba93 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -207,7 +207,7 @@ static struct dvobj_priv *usb_dvobj_init(struct usb_interface *usb_intf)
 	}
 
 	/* 3 misc */
-	sema_init(&(pdvobjpriv->usb_suspend_sema), 0);
+	sema_init(&pdvobjpriv->usb_suspend_sema, 0);
 	rtw_reset_continual_urb_error(pdvobjpriv);
 
 	usb_get_dev(pusbd);
-- 
2.32.0

