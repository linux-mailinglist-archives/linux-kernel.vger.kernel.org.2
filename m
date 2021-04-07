Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE76356DCF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347726AbhDGNuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347615AbhDGNuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:50:11 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98992C061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 06:49:59 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id a76so5849794wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 06:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LaVjYcm4RMNyz+tNrcqzXWPDcoMLYJfyZBH6AFIkwNE=;
        b=D9Wc8bm5bDYna+PH71RaC3rOFnR4HYAn0C9ZRMtMrZR2h0rTfeC8VOkPtjnSbIz4Mt
         rxlW3WChSWnFG4t7oKm0/c+EmlHr6aTo4134qunMR/+HDMG1TlhmpxFOfVvDBvCsRSXT
         qrOVMxodgR3z+gpgcXhPYquaix3oTFYC/stzWhdiVcVNYeOhgJ6fr/AcZhOq7zCal1CG
         qZGmBbVT509bp9TXgPio1maU9y4mCzrDbxP+Jkyi0uTBPajwHCvlXQdzDJDGTI+mE5fd
         8Y4NNoPidKpMhXmqGMsdwKj3b3No6yMmPkHdA7kA/7+eKN9SIfzLXB0qPVQsDpNnmjmV
         X4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LaVjYcm4RMNyz+tNrcqzXWPDcoMLYJfyZBH6AFIkwNE=;
        b=TK3xvdIjvxe5fy20U2Y63ZkMORFhPsvHmbR+f3mwow2UbyJMSYaOpvKQdq830mi3QI
         k2lsFMvuWufF29BZPHmQdbFaNIi3pyk1MXKgpnqzmCNkCMS5q0qmizpeMceETdme4IB0
         Q+E1Cytl/jkQryGSL7moyVVt3SErvEt/8xNuNryEdBnKHCoFw/ebIEKibyObp/4Wyx0Z
         PXXWh0Xzk5uPqzevWABsATDcFeDZM1C8cG9SEZQAJyLf/nimDpMeQYxDN7XdgOOfbT+3
         RCjNpede5xcBhFljlymljZeOUeRGK96P6xOxKOppD2/M8oPMLf+Qz9JHxtqGO4Ywju8c
         n4+Q==
X-Gm-Message-State: AOAM5318vwvNw54xbHdZSmHhZdqPi+41KYvHgYJKDi/o976LgntwFmOj
        fyIZjsyr6NRByPmaBZdcICE=
X-Google-Smtp-Source: ABdhPJymmJ0mcB3NHWl4+1BBw5iihV5nW15IPAEY4Dn3c+y+Cq867WetNAgIO54kA6RwMDAgELlz7A==
X-Received: by 2002:a1c:9808:: with SMTP id a8mr3161232wme.47.1617803397420;
        Wed, 07 Apr 2021 06:49:57 -0700 (PDT)
Received: from agape ([5.171.81.68])
        by smtp.gmail.com with ESMTPSA id c2sm8661317wmr.22.2021.04.07.06.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 06:49:56 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 02/19] staging: rtl8723bs: remove all DBG_871X logs
Date:   Wed,  7 Apr 2021 15:49:26 +0200
Message-Id: <89a39f551107ba73b44dd2422765cf8ce371501a.1617802415.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617802415.git.fabioaiuto83@gmail.com>
References: <cover.1617802415.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all of the DBG_871X logs as they
currently do nothing as they require the code to be modified by
hand in order to be turned on. This obviously has not happened
since the code was merged, so just remove them as they are unused.

applied the following semantic patch script:

@@
expression a, b, c, d, e, f, g, h, i, j, k;
constant B, C, D, E;
@@

(
-	DBG_871X(a);
|
-	DBG_871X(a, b);
|
-	DBG_871X(a, B);
|
-	DBG_871X(a, b, c);
|
-	DBG_871X(a, B, c);
|
-	DBG_871X(a, b, C);
|
-	DBG_871X(a, B, C);
|
-	DBG_871X(a, b, c, d);
|
-	DBG_871X(a, B, c, d);
|
-	DBG_871X(a, b, C, d);
|
-	DBG_871X(a, b, c, D);
|
-	DBG_871X(a, B, C, d);
|
-	DBG_871X(a, B, c, D);
|
-	DBG_871X(a, b, C, D);
|
-	DBG_871X(a, B, C, D);
|
-	DBG_871X(a, b, c, d, e);
|
-	DBG_871X(a, B, c, d, e);
|
-	DBG_871X(a, b, C, d, e);
|
-	DBG_871X(a, b, c, D, e);
|
-	DBG_871X(a, b, c, d, E);
|
-	DBG_871X(a, B, C, d, e);
|
-	DBG_871X(a, B, c, D, e);
|
-	DBG_871X(a, B, c, d, E);
|
-	DBG_871X(a, b, C, D, e);
|
-	DBG_871X(a, b, C, d, E);
|
-	DBG_871X(a, b, c, D, E);
|
-	DBG_871X(a, B, C, D, e);
|
-	DBG_871X(a, B, C, d, E);
|
-	DBG_871X(a, B, c, D, E);
|
-	DBG_871X(a, b, C, D, E);
|
-	DBG_871X(a, B, C, D, E);
|
-	DBG_871X(a, b, c, d, e, f);
|
-	DBG_871X(a, b, c, d, e, f, g);
|
-	DBG_871X(a, b, c, d, e, f, g, h);
|
-	DBG_871X(a, b, c, d, e, f, g, h, i);
|
-	DBG_871X(a, b, c, d, e, f, g, h, i, j);
|
-	DBG_871X(a, b, c, d, e, f, g, h, i, j, k);
)

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c       | 124 +-------
 drivers/staging/rtl8723bs/core/rtw_btcoex.c   |   6 -
 drivers/staging/rtl8723bs/core/rtw_cmd.c      |  12 -
 drivers/staging/rtl8723bs/core/rtw_efuse.c    |   5 -
 .../staging/rtl8723bs/core/rtw_ieee80211.c    |  33 --
 drivers/staging/rtl8723bs/core/rtw_io.c       |   1 -
 .../staging/rtl8723bs/core/rtw_ioctl_set.c    |   7 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c     | 112 +------
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 211 +------------
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  |  57 +---
 drivers/staging/rtl8723bs/core/rtw_recv.c     | 106 +------
 drivers/staging/rtl8723bs/core/rtw_security.c |  11 -
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c  |   6 +-
 .../staging/rtl8723bs/core/rtw_wlan_util.c    |  56 +---
 drivers/staging/rtl8723bs/core/rtw_xmit.c     |  44 +--
 .../staging/rtl8723bs/hal/HalPhyRf_8723B.c    |  11 -
 drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c  |   5 -
 drivers/staging/rtl8723bs/hal/hal_com.c       |  40 +--
 .../staging/rtl8723bs/hal/hal_com_phycfg.c    |  49 +--
 drivers/staging/rtl8723bs/hal/hal_intf.c      |  10 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  |  46 +--
 drivers/staging/rtl8723bs/hal/rtl8723b_dm.c   |   5 -
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |  68 +---
 .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   |   9 -
 .../staging/rtl8723bs/hal/rtl8723bs_recv.c    |   1 -
 .../staging/rtl8723bs/hal/rtl8723bs_xmit.c    |  24 --
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  |  25 +-
 drivers/staging/rtl8723bs/hal/sdio_ops.c      |  14 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 143 +--------
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 294 +-----------------
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c |   2 -
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   |  63 ----
 .../staging/rtl8723bs/os_dep/osdep_service.c  |   2 -
 drivers/staging/rtl8723bs/os_dep/recv_linux.c |   1 -
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c  |  18 --
 .../staging/rtl8723bs/os_dep/sdio_ops_linux.c |  30 +-
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c |   4 -
 37 files changed, 89 insertions(+), 1566 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index d65832b06444..dcf1dec635d7 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -171,17 +171,6 @@ u8 chk_sta_is_alive(struct sta_info *psta);
 u8 chk_sta_is_alive(struct sta_info *psta)
 {
 	#ifdef DBG_EXPIRATION_CHK
-	DBG_871X(
-		"sta:%pM, rssi:%d, rx:"STA_PKTS_FMT", expire_to:%u, %s%ssq_len:%u\n"
-		, MAC_ARG(psta->hwaddr)
-		, psta->rssi_stat.UndecoratedSmoothedPWDB
-		/*  STA_RX_PKTS_ARG(psta) */
-		, STA_RX_PKTS_DIFF_ARG(psta)
-		, psta->expire_to
-		, psta->state & WIFI_SLEEP_STATE ? "PS, " : ""
-		, psta->state & WIFI_STA_ALIVE_CHK_STATE ? "SAC, " : ""
-		, psta->sleepq_len
-	);
 	#endif
 
 	sta_update_last_rx_pkts(psta);
@@ -207,9 +196,6 @@ void expire_timeout_chk(struct adapter *padapter)
 	/* check auth_queue */
 	#ifdef DBG_EXPIRATION_CHK
 	if (phead != plist) {
-		DBG_871X(FUNC_NDEV_FMT " auth_list, cnt:%u\n",
-			 FUNC_NDEV_ARG(padapter->pnetdev),
-			 pstapriv->auth_list_cnt);
 	}
 	#endif
 	while (phead != plist) {
@@ -223,15 +209,6 @@ void expire_timeout_chk(struct adapter *padapter)
 				list_del_init(&psta->auth_list);
 				pstapriv->auth_list_cnt--;
 
-				DBG_871X("auth expire %02X%02X%02X%02X%02X%02X\n",
-					 psta->hwaddr[0],
-					 psta->hwaddr[1],
-					 psta->hwaddr[2],
-					 psta->hwaddr[3],
-					 psta->hwaddr[4],
-					 psta->hwaddr[5]
-				);
-
 				spin_unlock_bh(&pstapriv->auth_list_lock);
 
 				rtw_free_stainfo(padapter, psta);
@@ -252,8 +229,6 @@ void expire_timeout_chk(struct adapter *padapter)
 	/* check asoc_queue */
 	#ifdef DBG_EXPIRATION_CHK
 	if (phead != plist) {
-		DBG_871X(FUNC_NDEV_FMT" asoc_list, cnt:%u\n"
-			, FUNC_NDEV_ARG(padapter->pnetdev), pstapriv->asoc_list_cnt);
 	}
 	#endif
 	while (phead != plist) {
@@ -304,10 +279,6 @@ void expire_timeout_chk(struct adapter *padapter)
 			}
 			list_del_init(&psta->asoc_list);
 			pstapriv->asoc_list_cnt--;
-			DBG_871X("asoc expire %pM, state = 0x%x\n",
-				 MAC_ARG(psta->hwaddr),
-				 psta->state
-			);
 			updated = ap_free_sta(padapter, psta, false, WLAN_REASON_DEAUTH_LEAVING);
 		} else {
 			/* TODO: Aging mechanism to digest frames in sleep_q to */
@@ -317,14 +288,6 @@ void expire_timeout_chk(struct adapter *padapter)
 					NR_XMITFRAME / pstapriv->asoc_list_cnt
 				) / 2)
 			) {
-				DBG_871X(
-					"%s sta:%pM, sleepq_len:%u, free_xmitframe_cnt:%u, asoc_list_cnt:%u, clear sleep_q\n",
-					__func__,
-					MAC_ARG(psta->hwaddr),
-					psta->sleepq_len,
-					padapter->xmitpriv.free_xmitframe_cnt,
-					pstapriv->asoc_list_cnt
-				);
 				wakeup_sta_to_xmit(padapter, psta);
 			}
 		}
@@ -357,22 +320,15 @@ void expire_timeout_chk(struct adapter *padapter)
 
 			psta->keep_alive_trycnt++;
 			if (ret == _SUCCESS) {
-				DBG_871X("asoc check, sta(%pM) is alive\n",
-					 MAC_ARG(psta->hwaddr)
-					);
 				psta->expire_to = pstapriv->expire_to;
 				psta->keep_alive_trycnt = 0;
 				continue;
 			} else if (psta->keep_alive_trycnt <= 3) {
-				DBG_871X("ack check for asoc expire, keep_alive_trycnt =%d\n",
-					 psta->keep_alive_trycnt);
 				psta->expire_to = 1;
 				continue;
 			}
 
 			psta->keep_alive_trycnt = 0;
-			DBG_871X("asoc expire %pM, state = 0x%x\n", MAC_ARG(psta->hwaddr),
-				 psta->state);
 			spin_lock_bh(&pstapriv->asoc_list_lock);
 			if (list_empty(&psta->asoc_list) == false) {
 				list_del_init(&psta->asoc_list);
@@ -437,12 +393,8 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 		arg[2] = shortGIrate;
 		arg[3] = psta->init_rate;
 
-		DBG_871X("%s => mac_id:%d , raid:%d , shortGIrate =%d, bitmap = 0x%x\n",
-			 __func__, psta->mac_id, psta->raid, shortGIrate, tx_ra_bitmap);
-
 		rtw_hal_add_ra_tid(padapter, tx_ra_bitmap, arg, rssi_level);
 	} else {
-		DBG_871X("station aid %d exceed the max number\n", psta->aid);
 	}
 }
 
@@ -509,9 +461,6 @@ void update_bmc_sta(struct adapter *padapter)
 			arg[2] = 0;
 			arg[3] = psta->init_rate;
 
-			DBG_871X("%s => mac_id:%d , raid:%d , bitmap = 0x%x\n",
-				 __func__, psta->mac_id, psta->raid, tx_ra_bitmap);
-
 			rtw_hal_add_ra_tid(padapter, tx_ra_bitmap, arg, 0);
 		}
 
@@ -522,7 +471,6 @@ void update_bmc_sta(struct adapter *padapter)
 		spin_unlock_bh(&psta->lock);
 
 	} else {
-		DBG_871X("add_RATid_bmc_sta error!\n");
 	}
 }
 
@@ -605,14 +553,12 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 		if (TEST_FLAG(phtpriv_ap->ldpc_cap, LDPC_HT_ENABLE_TX) &&
 			      GET_HT_CAPABILITY_ELE_LDPC_CAP((u8 *)(&phtpriv_sta->ht_cap))) {
 			SET_FLAG(cur_ldpc_cap, (LDPC_HT_ENABLE_TX | LDPC_HT_CAP_TX));
-			DBG_871X("Enable HT Tx LDPC for STA(%d)\n", psta->aid);
 		}
 
 		/*  B7 B8 B9 Config STBC setting */
 		if (TEST_FLAG(phtpriv_ap->stbc_cap, STBC_HT_ENABLE_TX) &&
 			      GET_HT_CAPABILITY_ELE_RX_STBC((u8 *)(&phtpriv_sta->ht_cap))) {
 			SET_FLAG(cur_stbc_cap, (STBC_HT_ENABLE_TX | STBC_HT_CAP_TX));
-			DBG_871X("Enable HT Tx STBC for STA(%d)\n", psta->aid);
 		}
 	} else {
 		phtpriv_sta->ampdu_enable = false;
@@ -719,7 +665,7 @@ static void update_hw_ht_param(struct adapter *padapter)
 		pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info
 	) & 0x0C) >> 2;
 	if (pmlmeinfo->SM_PS == WLAN_HT_CAP_SM_PS_STATIC)
-		DBG_871X("%s(): WLAN_HT_CAP_SM_PS_STATIC\n", __func__);
+		{}
 
 	/*  */
 	/*  Config current HT Protection mode. */
@@ -863,11 +809,6 @@ void start_bss_network(struct adapter *padapter, u8 *pbuf)
 	}
 
 	set_channel_bwmode(padapter, cur_channel, cur_ch_offset, cur_bwmode);
-	DBG_871X("CH =%d, BW =%d, offset =%d\n",
-		 cur_channel,
-		 cur_bwmode,
-		 cur_ch_offset
-	);
 	pmlmeext->cur_channel = cur_channel;
 	pmlmeext->cur_bwmode = cur_bwmode;
 	pmlmeext->cur_ch_offset = cur_ch_offset;
@@ -894,7 +835,7 @@ void start_bss_network(struct adapter *padapter, u8 *pbuf)
 
 		/* issue beacon frame */
 		if (send_beacon(padapter) == _FAIL)
-			DBG_871X("issue_beacon, fail!\n");
+			{}
 	}
 
 	/* update bc/mc sta_info */
@@ -924,19 +865,6 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		*pbss_network = (struct wlan_bssid_ex *)&pmlmepriv->cur_network.network;
 	u8 *ie = pbss_network->IEs;
 
-	/* SSID */
-	/* Supported rates */
-	/* DS Params */
-	/* WLAN_EID_COUNTRY */
-	/* ERP Information element */
-	/* Extended supported rates */
-	/* WPA/WPA2 */
-	/* Wi-Fi Wireless Multimedia Extensions */
-	/* ht_capab, ht_oper */
-	/* WPS IE */
-
-	DBG_871X("%s, len =%d\n", __func__, len);
-
 	if (!check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		return _FAIL;
 
@@ -1284,8 +1212,6 @@ void rtw_set_macaddr_acl(struct adapter *padapter, int mode)
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct wlan_acl_pool *pacl_list = &pstapriv->acl_list;
 
-	DBG_871X("%s, mode =%d\n", __func__, mode);
-
 	pacl_list->mode = mode;
 }
 
@@ -1299,8 +1225,6 @@ int rtw_acl_add_sta(struct adapter *padapter, u8 *addr)
 	struct wlan_acl_pool *pacl_list = &pstapriv->acl_list;
 	struct __queue	*pacl_node_q = &pacl_list->acl_node_q;
 
-	DBG_871X("%s(acl_num =%d) =%pM\n", __func__, pacl_list->num, MAC_ARG(addr));
-
 	if ((NUM_ACL - 1) < pacl_list->num)
 		return (-1);
 
@@ -1316,7 +1240,6 @@ int rtw_acl_add_sta(struct adapter *padapter, u8 *addr)
 		if (!memcmp(paclnode->addr, addr, ETH_ALEN)) {
 			if (paclnode->valid == true) {
 				added = true;
-				DBG_871X("%s, sta has been added\n", __func__);
 				break;
 			}
 		}
@@ -1347,8 +1270,6 @@ int rtw_acl_add_sta(struct adapter *padapter, u8 *addr)
 		}
 	}
 
-	DBG_871X("%s, acl_num =%d\n", __func__, pacl_list->num);
-
 	spin_unlock_bh(&(pacl_node_q->lock));
 
 	return ret;
@@ -1363,8 +1284,6 @@ void rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
 	struct __queue	*pacl_node_q = &pacl_list->acl_node_q;
 	u8 baddr[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };	/* Baddr is used for clearing acl_list */
 
-	DBG_871X("%s(acl_num =%d) =%pM\n", __func__, pacl_list->num, MAC_ARG(addr));
-
 	spin_lock_bh(&(pacl_node_q->lock));
 
 	phead = get_list_head(pacl_node_q);
@@ -1390,8 +1309,6 @@ void rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
 
 	spin_unlock_bh(&(pacl_node_q->lock));
 
-	DBG_871X("%s, acl_num =%d\n", __func__, pacl_list->num);
-
 }
 
 u8 rtw_ap_set_pairwise_key(struct adapter *padapter, struct sta_info *psta)
@@ -1536,8 +1453,6 @@ static void update_bcn_erpinfo_ie(struct adapter *padapter)
 	unsigned char *p, *ie = pnetwork->IEs;
 	u32 len = 0;
 
-	DBG_871X("%s, ERP_enable =%d\n", __func__, pmlmeinfo->ERP_enable);
-
 	if (!pmlmeinfo->ERP_enable)
 		return;
 
@@ -1662,7 +1577,7 @@ static void update_bcn_vendor_spec_ie(struct adapter *padapter, u8 *oui)
 		update_bcn_p2p_ie(padapter);
 
 	else
-		DBG_871X("unknown OUI type!\n");
+		{}
 }
 
 void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx)
@@ -1762,12 +1677,6 @@ static int rtw_ht_operation_update(struct adapter *padapter)
 	if (pmlmepriv->htpriv.ht_option)
 		return 0;
 
-	/* if (!iface->conf->ieee80211n || iface->conf->ht_op_mode_fixed) */
-	/*  return 0; */
-
-	DBG_871X("%s current operation mode = 0x%X\n",
-		   __func__, pmlmepriv->ht_op_mode);
-
 	if (!(pmlmepriv->ht_op_mode & IEEE80211_HT_OP_MODE_NON_GF_STA_PRSNT)
 	    && pmlmepriv->num_sta_ht_no_gf) {
 		pmlmepriv->ht_op_mode |=
@@ -1817,9 +1726,6 @@ static int rtw_ht_operation_update(struct adapter *padapter)
 		op_mode_changes++;
 	}
 
-	DBG_871X("%s new operation mode = 0x%X changes =%d\n",
-		 __func__, pmlmepriv->ht_op_mode, op_mode_changes);
-
 	return op_mode_changes;
 }
 
@@ -1935,9 +1841,6 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 	if (psta->flags & WLAN_STA_HT) {
 		u16 ht_capab = le16_to_cpu(psta->htpriv.ht_cap.cap_info);
 
-		DBG_871X("HT: STA %pM HT Capabilities Info: 0x%04x\n",
-			 MAC_ARG(psta->hwaddr), ht_capab);
-
 		if (psta->no_ht_set) {
 			psta->no_ht_set = 0;
 			pmlmepriv->num_sta_no_ht--;
@@ -1948,9 +1851,6 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 				psta->no_ht_gf_set = 1;
 				pmlmepriv->num_sta_ht_no_gf++;
 			}
-			DBG_871X("%s STA %pM - no greenfield, num of non-gf stations %d\n",
-				 __func__, MAC_ARG(psta->hwaddr),
-				 pmlmepriv->num_sta_ht_no_gf);
 		}
 
 		if ((ht_capab & IEEE80211_HT_CAP_SUP_WIDTH) == 0) {
@@ -1958,9 +1858,6 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 				psta->ht_20mhz_set = 1;
 				pmlmepriv->num_sta_ht_20mhz++;
 			}
-			DBG_871X("%s STA %pM - 20 MHz HT, num of 20MHz HT STAs %d\n",
-				 __func__, MAC_ARG(psta->hwaddr),
-				 pmlmepriv->num_sta_ht_20mhz);
 		}
 
 	} else {
@@ -1969,9 +1866,6 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 			pmlmepriv->num_sta_no_ht++;
 		}
 		if (pmlmepriv->htpriv.ht_option == true) {
-			DBG_871X("%s STA %pM - no HT, num of non-HT stations %d\n",
-				   __func__, MAC_ARG(psta->hwaddr),
-				   pmlmepriv->num_sta_no_ht);
 		}
 	}
 
@@ -1982,8 +1876,6 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 
 	/* update associated stations cap. */
 	associated_clients_update(padapter,  beacon_updated);
-
-	DBG_871X("%s, updated =%d\n", __func__, beacon_updated);
 }
 
 u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta)
@@ -2044,11 +1936,6 @@ u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta)
 		update_beacon(padapter, WLAN_EID_HT_OPERATION, NULL, true);
 	}
 
-	/* update associated stations cap. */
-	/* associated_clients_update(padapter,  beacon_updated); //move it to avoid deadlock */
-
-	DBG_871X("%s, updated =%d\n", __func__, beacon_updated);
-
 	return beacon_updated;
 }
 
@@ -2106,8 +1993,6 @@ void rtw_sta_flush(struct adapter *padapter)
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
-	DBG_871X(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(padapter->pnetdev));
-
 	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
 		return;
 
@@ -2235,7 +2120,6 @@ void rtw_ap_restore_network(struct adapter *padapter)
 		psta = rtw_get_stainfo_by_offset(pstapriv, chk_alive_list[i]);
 
 		if (psta == NULL) {
-			DBG_871X(FUNC_ADPT_FMT" sta_info is null\n", FUNC_ADPT_ARG(padapter));
 		} else if (psta->state & _FW_LINKED) {
 			rtw_sta_media_status_rpt(padapter, psta, 1);
 			Update_RA_Entry(padapter, psta);
@@ -2339,8 +2223,6 @@ void stop_ap_mode(struct adapter *padapter)
 	}
 	spin_unlock_bh(&(pacl_node_q->lock));
 
-	DBG_871X("%s, free acl_node_queue, num =%d\n", __func__, pacl_list->num);
-
 	rtw_sta_flush(padapter);
 
 	/* free_assoc_sta_resources */
diff --git a/drivers/staging/rtl8723bs/core/rtw_btcoex.c b/drivers/staging/rtl8723bs/core/rtw_btcoex.c
index 44219b7b6123..ebdbd328b62c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_btcoex.c
+++ b/drivers/staging/rtl8723bs/core/rtw_btcoex.c
@@ -22,16 +22,10 @@ void rtw_btcoex_MediaStatusNotify(struct adapter *padapter, u8 mediaStatus)
 void rtw_btcoex_HaltNotify(struct adapter *padapter)
 {
 	if (!padapter->bup) {
-		DBG_871X(FUNC_ADPT_FMT ": bup =%d Skip!\n",
-			FUNC_ADPT_ARG(padapter), padapter->bup);
-
 		return;
 	}
 
 	if (padapter->bSurpriseRemoved) {
-		DBG_871X(FUNC_ADPT_FMT ": bSurpriseRemoved =%d Skip!\n",
-			FUNC_ADPT_ARG(padapter), padapter->bSurpriseRemoved);
-
 		return;
 	}
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 77c583c60343..6958891eb0e5 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -492,9 +492,6 @@ int rtw_cmd_thread(void *context)
 
 		cmd_process_time = jiffies_to_msecs(jiffies - cmd_start_time);
 		if (cmd_process_time > 1000) {
-			DBG_871X("%s cmd= %d process_time= %lu > 1 sec\n",
-				 ADPT_ARG(pcmd->padapter), pcmd->cmdcode,
-				 cmd_process_time);
 		}
 
 		/* call callback function for post-processed */
@@ -582,9 +579,6 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 			if (ssid[i].SsidLength) {
 				memcpy(&psurveyPara->ssid[i], &ssid[i], sizeof(struct ndis_802_11_ssid));
 				psurveyPara->ssid_num++;
-
-				DBG_871X(FUNC_ADPT_FMT" ssid:(%s, %d)\n", FUNC_ADPT_ARG(padapter),
-					psurveyPara->ssid[i].Ssid, psurveyPara->ssid[i].SsidLength);
 			}
 		}
 	}
@@ -596,9 +590,6 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 			if (ch[i].hw_value && !(ch[i].flags & RTW_IEEE80211_CHAN_DISABLED)) {
 				memcpy(&psurveyPara->ch[i], &ch[i], sizeof(struct rtw_ieee80211_channel));
 				psurveyPara->ch_num++;
-
-				DBG_871X(FUNC_ADPT_FMT" ch:%u\n", FUNC_ADPT_ARG(padapter),
-					psurveyPara->ch[i].hw_value);
 			}
 		}
 	}
@@ -1545,9 +1536,6 @@ static void rtw_lps_change_dtim_hdl(struct adapter *padapter, u8 dtim)
 	mutex_lock(&pwrpriv->lock);
 
 	if (pwrpriv->dtim != dtim) {
-		DBG_871X("change DTIM from %d to %d, bFwCurrentInPSMode =%d, ps_mode =%d\n", pwrpriv->dtim, dtim,
-			pwrpriv->bFwCurrentInPSMode, pwrpriv->pwr_mode);
-
 		pwrpriv->dtim = dtim;
 	}
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index 3701336e7ff6..a8e6d1b258eb 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -285,8 +285,6 @@ bool		bPseudoTest)
 	} else {
 		*data = 0xff;
 		bResult = false;
-		DBG_871X("%s: [ERROR] addr = 0x%x bResult =%d time out 1s !!!\n", __func__, addr, bResult);
-		DBG_871X("%s: [ERROR] EFUSE_CTRL = 0x%08x !!!\n", __func__, rtw_read32(padapter, EFUSE_CTRL));
 	}
 
 	return bResult;
@@ -334,9 +332,6 @@ u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool bPseudoT
 		bResult = true;
 	} else {
 		bResult = false;
-		DBG_871X("%s: [ERROR] addr = 0x%x , efuseValue = 0x%x , bResult =%d time out 1s !!!\n",
-					__func__, addr, efuseValue, bResult);
-		DBG_871X("%s: [ERROR] EFUSE_CTRL = 0x%08x !!!\n", __func__, rtw_read32(padapter, EFUSE_CTRL));
 	}
 
 	/*  disable Efuse program enable */
diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index a0d664e254a8..7d13b2669d45 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -821,9 +821,6 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 	 * sub-type. */
 	if (elen < 4) {
 		if (show_errors) {
-			DBG_871X("short vendor specific "
-				   "information element ignored (len =%lu)\n",
-				   (unsigned long) elen);
 		}
 		return -1;
 	}
@@ -842,10 +839,6 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 			break;
 		case WME_OUI_TYPE: /* this is a Wi-Fi WME info. element */
 			if (elen < 5) {
-				DBG_871X("short WME "
-					   "information element ignored "
-					   "(len =%lu)\n",
-					   (unsigned long) elen);
 				return -1;
 			}
 			switch (pos[4]) {
@@ -859,10 +852,6 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 				elems->wme_tspec_len = elen;
 				break;
 			default:
-				DBG_871X("unknown WME "
-					   "information element ignored "
-					   "(subtype =%d len =%lu)\n",
-					   pos[4], (unsigned long) elen);
 				return -1;
 			}
 			break;
@@ -872,10 +861,6 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 			elems->wps_ie_len = elen;
 			break;
 		default:
-			DBG_871X("Unknown Microsoft "
-				   "information element ignored "
-				   "(type =%d len =%lu)\n",
-				   pos[3], (unsigned long) elen);
 			return -1;
 		}
 		break;
@@ -887,19 +872,11 @@ static int rtw_ieee802_11_parse_vendor_specific(u8 *pos, uint elen,
 			elems->vendor_ht_cap_len = elen;
 			break;
 		default:
-			DBG_871X("Unknown Broadcom "
-				   "information element ignored "
-				   "(type =%d len =%lu)\n",
-				   pos[3], (unsigned long) elen);
 			return -1;
 		}
 		break;
 
 	default:
-		DBG_871X("unknown vendor specific information "
-			   "element ignored (vendor OUI %02x:%02x:%02x "
-			   "len =%lu)\n",
-			   pos[0], pos[1], pos[2], (unsigned long) elen);
 		return -1;
 	}
 
@@ -933,10 +910,6 @@ enum ParseRes rtw_ieee802_11_parse_elems(u8 *start, uint len,
 
 		if (elen > left) {
 			if (show_errors) {
-				DBG_871X("IEEE 802.11 element "
-					   "parse failed (id =%d elen =%d "
-					   "left =%lu)\n",
-					   id, elen, (unsigned long) left);
 			}
 			return ParseFailed;
 		}
@@ -1036,9 +1009,6 @@ enum ParseRes rtw_ieee802_11_parse_elems(u8 *start, uint len,
 			unknown++;
 			if (!show_errors)
 				break;
-			DBG_871X("IEEE 802.11 element parse "
-				   "ignored unknown element (id =%d elen =%d)\n",
-				   id, elen);
 			break;
 		}
 
@@ -1077,11 +1047,8 @@ void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
 			ether_addr_copy(mac_addr, addr);
 		} else {
 			eth_random_addr(mac_addr);
-			DBG_871X("MAC Address from efuse error, assign random one !!!\n");
 		}
 	}
-
-	DBG_871X("rtw_macaddr_cfg MAC Address  = %pM\n", MAC_ARG(mac_addr));
 }
 
 static int rtw_get_cipher_info(struct wlan_network *pnetwork)
diff --git a/drivers/staging/rtl8723bs/core/rtw_io.c b/drivers/staging/rtl8723bs/core/rtw_io.c
index c3f63f903547..03ba5bca8156 100644
--- a/drivers/staging/rtl8723bs/core/rtw_io.c
+++ b/drivers/staging/rtl8723bs/core/rtw_io.c
@@ -173,7 +173,6 @@ int rtw_inc_and_chk_continual_io_error(struct dvobj_priv *dvobj)
 	int ret = false;
 	int value = atomic_inc_return(&dvobj->continual_io_error);
 	if (value > MAX_CONTINUAL_IO_ERR) {
-		DBG_871X("[dvobj:%p][ERROR] continual_io_error:%d > %d\n", dvobj, value, MAX_CONTINUAL_IO_ERR);
 		ret = true;
 	} else {
 		/* DBG_871X("[dvobj:%p] continual_io_error:%d\n", dvobj, value); */
diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index f8c7dcb7ab7d..8711e4630423 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -153,7 +153,6 @@ u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid)
 	spin_lock_bh(&pmlmepriv->lock);
 
 
-	DBG_871X("Set BSSID under fw_state = 0x%08x\n", get_fwstate(pmlmepriv));
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY) == true)
 		goto handle_tkip_countermeasure;
 	else if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING) == true)
@@ -218,7 +217,6 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 
 	spin_lock_bh(&pmlmepriv->lock);
 
-	DBG_871X("Set SSID under fw_state = 0x%08x\n", get_fwstate(pmlmepriv));
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY) == true)
 		goto handle_tkip_countermeasure;
 	else if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING) == true)
@@ -303,8 +301,6 @@ u8 rtw_set_802_11_connect(struct adapter *padapter, u8 *bssid, struct ndis_802_1
 		bssid_valid = false;
 
 	if (!ssid_valid && !bssid_valid) {
-		DBG_871X(FUNC_ADPT_FMT" ssid:%p, ssid_valid:%d, bssid:%p, bssid_valid:%d\n",
-			FUNC_ADPT_ARG(padapter), ssid, ssid_valid, bssid, bssid_valid);
 		status = _FAIL;
 		goto exit;
 	}
@@ -430,7 +426,7 @@ u8 rtw_set_802_11_disassociate(struct adapter *padapter)
 		/* modify for CONFIG_IEEE80211W, none 11w can use it */
 		rtw_free_assoc_resources_cmd(padapter);
 		if (_FAIL == rtw_pwr_wakeup(padapter))
-			DBG_871X("%s(): rtw_pwr_wakeup fail !!!\n", __func__);
+			{}
 	}
 
 	spin_unlock_bh(&pmlmepriv->lock);
@@ -459,7 +455,6 @@ u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_802_11_s
 
 	} else {
 		if (rtw_is_scan_deny(padapter)) {
-			DBG_871X(FUNC_ADPT_FMT": scan deny\n", FUNC_ADPT_ARG(padapter));
 			indicate_wx_scan_complete_event(padapter);
 			return _SUCCESS;
 		}
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index e6bced0269b1..dc9b0b36c174 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -483,12 +483,6 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 
 	#if defined(DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) && 1
 	if (strcmp(dst->Ssid.Ssid, DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) == 0) {
-		DBG_871X(FUNC_ADPT_FMT" %s(%pM, ch%u) ss_ori:%3u, sq_ori:%3u, rssi_ori:%3ld, ss_smp:%3u, sq_smp:%3u, rssi_smp:%3ld\n"
-			, FUNC_ADPT_ARG(padapter)
-			, src->Ssid.Ssid, MAC_ARG(src->MacAddress), src->Configuration.DSConfig
-			, ss_ori, sq_ori, rssi_ori
-			, ss_smp, sq_smp, rssi_smp
-		);
 	}
 	#endif
 
@@ -528,9 +522,6 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 
 	#if defined(DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) && 1
 	if (strcmp(dst->Ssid.Ssid, DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) == 0) {
-		DBG_871X(FUNC_ADPT_FMT" %s(%pM), SignalStrength:%u, SignalQuality:%u, RawRSSI:%ld\n"
-			, FUNC_ADPT_ARG(padapter)
-			, dst->Ssid.Ssid, MAC_ARG(dst->MacAddress), dst->PhyInfo.SignalStrength, dst->PhyInfo.SignalQuality, dst->Rssi);
 	}
 	#endif
 }
@@ -729,7 +720,6 @@ int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwor
 	}
 
 	if ((desired_encmode != Ndis802_11EncryptionDisabled) && (privacy == 0)) {
-		DBG_871X("desired_encmode: %d, privacy: %d\n", desired_encmode, privacy);
 		bselected = false;
 	}
 
@@ -848,8 +838,6 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 				_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 				rtw_indicate_connect(adapter);
 			} else {
-				DBG_871X("try_to_join, but select scanning queue fail, to_roam:%d\n", rtw_to_roam(adapter));
-
 				if (rtw_to_roam(adapter) != 0) {
 					if (rtw_dec_to_roam(adapter) == 0
 						|| _SUCCESS != rtw_sitesurvey_cmd(adapter, &pmlmepriv->assoc_ssid, 1, NULL, 0)
@@ -1039,8 +1027,6 @@ void rtw_indicate_disconnect(struct adapter *padapter)
 
 inline void rtw_indicate_scan_done(struct adapter *padapter, bool aborted)
 {
-	DBG_871X(FUNC_ADPT_FMT"\n", FUNC_ADPT_ARG(padapter));
-
 	rtw_os_indicate_scan_done(padapter, aborted);
 
 	if (is_primary_adapter(padapter) &&
@@ -1066,13 +1052,12 @@ void rtw_scan_abort(struct adapter *adapter)
 		if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
 			break;
 
-		DBG_871X(FUNC_NDEV_FMT"fw_state = _FW_UNDER_SURVEY!\n", FUNC_NDEV_ARG(adapter->pnetdev));
 		msleep(20);
 	}
 
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) {
 		if (!adapter->bDriverStopped && !adapter->bSurpriseRemoved)
-			DBG_871X(FUNC_NDEV_FMT"waiting for scan_abort time out!\n", FUNC_NDEV_ARG(adapter->pnetdev));
+			{}
 		rtw_indicate_scan_done(adapter, true);
 	}
 	pmlmeext->scan_abort = false;
@@ -1144,8 +1129,6 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 			preorder_ctrl->enable = false;
 			preorder_ctrl->indicate_seq = 0xffff;
 			#ifdef DBG_RX_SEQ
-			DBG_871X("DBG_RX_SEQ %s:%d indicate_seq:%u\n", __func__, __LINE__,
-				preorder_ctrl->indicate_seq);
 			#endif
 			preorder_ctrl->wend_b = 0xffff;
 			preorder_ctrl->wsize_b = 64;/* max_ampdu_sz;ex. 32(kbytes) -> wsize_b =32 */
@@ -1159,8 +1142,6 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 				preorder_ctrl->enable = false;
 				preorder_ctrl->indicate_seq = 0xffff;
 				#ifdef DBG_RX_SEQ
-				DBG_871X("DBG_RX_SEQ %s:%d indicate_seq:%u\n", __func__, __LINE__,
-					preorder_ctrl->indicate_seq);
 				#endif
 				preorder_ctrl->wend_b = 0xffff;
 				preorder_ctrl->wsize_b = 64;/* max_ampdu_sz;ex. 32(kbytes) -> wsize_b =32 */
@@ -1194,13 +1175,6 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 	/* the ptarget_wlan->network.Rssi is raw data, we use ptarget_wlan->network.PhyInfo.SignalStrength instead (has scaled) */
 	padapter->recvpriv.rssi = translate_percentage_to_dbm(ptarget_wlan->network.PhyInfo.SignalStrength);
 	#if defined(DBG_RX_SIGNAL_DISPLAY_PROCESSING) && 1
-		DBG_871X(FUNC_ADPT_FMT" signal_strength:%3u, rssi:%3d, signal_qual:%3u"
-			"\n"
-			, FUNC_ADPT_ARG(padapter)
-			, padapter->recvpriv.signal_strength
-			, padapter->recvpriv.rssi
-			, padapter->recvpriv.signal_qual
-	);
 	#endif
 
 	rtw_set_signal_stat_timer(&padapter->recvpriv);
@@ -1411,7 +1385,6 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 			ap_sta_info_defer_update(adapter, psta);
 
 			/* report to upper layer */
-			DBG_871X("indicate_sta_assoc_event to upper layer - hostapd\n");
 			spin_lock_bh(&psta->lock);
 			if (psta->passoc_req && psta->assoc_req_len > 0) {
 				passoc_req = rtw_zmalloc(psta->assoc_req_len);
@@ -1502,8 +1475,6 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 	else
 		mac_id = pstadel->mac_id;
 
-	DBG_871X("%s(mac_id =%d) =%pM\n", __func__, mac_id, MAC_ARG(pstadel->macaddr));
-
 	if (mac_id >= 0) {
 		u16 media_status;
 
@@ -1629,8 +1600,6 @@ void _rtw_join_timeout_handler(struct timer_list *t)
 						  mlmepriv.assoc_timer);
 	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
-	DBG_871X("%s, fw_state =%x\n", __func__, get_fwstate(pmlmepriv));
-
 	if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
 		return;
 
@@ -1642,15 +1611,12 @@ void _rtw_join_timeout_handler(struct timer_list *t)
 			if (rtw_to_roam(adapter) != 0) { /* try another */
 				int do_join_r;
 
-				DBG_871X("%s try another roaming\n", __func__);
 				do_join_r = rtw_do_join(adapter);
 				if (_SUCCESS != do_join_r) {
-					DBG_871X("%s roaming do_join return %d\n", __func__, do_join_r);
 					continue;
 				}
 				break;
 			} else {
-				DBG_871X("%s We've try roaming but fail\n", __func__);
 				rtw_indicate_disconnect(adapter);
 				break;
 			}
@@ -1678,8 +1644,6 @@ void rtw_scan_timeout_handler(struct timer_list *t)
 						  mlmepriv.scan_to_timer);
 	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
-	DBG_871X(FUNC_ADPT_FMT" fw_state =%x\n", FUNC_ADPT_ARG(adapter), get_fwstate(pmlmepriv));
-
 	spin_lock_bh(&pmlmepriv->lock);
 
 	_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
@@ -1717,18 +1681,14 @@ static void rtw_auto_scan_handler(struct adapter *padapter)
 
 		if (!padapter->registrypriv.wifi_spec) {
 			if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY|_FW_UNDER_LINKING) == true) {
-				DBG_871X(FUNC_ADPT_FMT" _FW_UNDER_SURVEY|_FW_UNDER_LINKING\n", FUNC_ADPT_ARG(padapter));
 				goto exit;
 			}
 
 			if (pmlmepriv->LinkDetectInfo.bBusyTraffic) {
-				DBG_871X(FUNC_ADPT_FMT" exit BusyTraffic\n", FUNC_ADPT_ARG(padapter));
 				goto exit;
 			}
 		}
 
-		DBG_871X(FUNC_ADPT_FMT"\n", FUNC_ADPT_ARG(padapter));
-
 		rtw_set_802_11_bssid_list_scan(padapter, NULL, 0);
 	}
 
@@ -1751,7 +1711,7 @@ void rtw_dynamic_check_timer_handler(struct adapter *adapter)
 		return;
 
 	if (is_primary_adapter(adapter))
-		DBG_871X("IsBtDisabled =%d, IsBtControlLps =%d\n", hal_btcoex_IsBtDisabled(adapter), hal_btcoex_IsBtControlLps(adapter));
+		{}
 
 	if ((adapter_to_pwrctl(adapter)->bFwCurrentInPSMode)
 		&& !(hal_btcoex_IsBtControlLps(adapter))
@@ -1789,15 +1749,12 @@ inline void rtw_clear_scan_deny(struct adapter *adapter)
 	struct mlme_priv *mlmepriv = &adapter->mlmepriv;
 
 	atomic_set(&mlmepriv->set_scan_deny, 0);
-
-	DBG_871X(FUNC_ADPT_FMT"\n", FUNC_ADPT_ARG(adapter));
 }
 
 void rtw_set_scan_deny(struct adapter *adapter, u32 ms)
 {
 	struct mlme_priv *mlmepriv = &adapter->mlmepriv;
 
-	DBG_871X(FUNC_ADPT_FMT"\n", FUNC_ADPT_ARG(adapter));
 	atomic_set(&mlmepriv->set_scan_deny, 1);
 	_set_timer(&mlmepriv->set_scan_deny_timer, ms);
 }
@@ -1819,15 +1776,6 @@ static int rtw_check_roaming_candidate(struct mlme_priv *mlme
 	if (rtw_is_desired_network(adapter, competitor) == false)
 		goto exit;
 
-	DBG_871X("roam candidate:%s %s(%pM, ch%3u) rssi:%d, age:%5d\n",
-		(competitor == mlme->cur_network_scanned)?"*":" ",
-		competitor->network.Ssid.Ssid,
-		MAC_ARG(competitor->network.MacAddress),
-		competitor->network.Configuration.DSConfig,
-		(int)competitor->network.Rssi,
-		jiffies_to_msecs(jiffies - competitor->last_scanned)
-	);
-
 	/* got specific addr to roam */
 	if (!is_zero_mac_addr(mlme->roam_tgt_addr)) {
 		if (!memcmp(mlme->roam_tgt_addr, competitor->network.MacAddress, ETH_ALEN))
@@ -1880,25 +1828,14 @@ int rtw_select_roaming_candidate(struct mlme_priv *mlme)
 
 		mlme->pscanned = get_next(mlme->pscanned);
 
-		DBG_871X("%s(%pM, ch%u) rssi:%d\n"
-			, pnetwork->network.Ssid.Ssid
-			, MAC_ARG(pnetwork->network.MacAddress)
-			, pnetwork->network.Configuration.DSConfig
-			, (int)pnetwork->network.Rssi);
-
 		rtw_check_roaming_candidate(mlme, &candidate, pnetwork);
 
 	}
 
 	if (!candidate) {
-		DBG_871X("%s: return _FAIL(candidate == NULL)\n", __func__);
 		ret = _FAIL;
 		goto exit;
 	} else {
-		DBG_871X("%s: candidate: %s(%pM, ch:%u)\n", __func__,
-			candidate->network.Ssid.Ssid, MAC_ARG(candidate->network.MacAddress),
-			candidate->network.Configuration.DSConfig);
-
 		mlme->roam_network = candidate;
 
 		if (!memcmp(candidate->network.MacAddress, mlme->roam_tgt_addr, ETH_ALEN))
@@ -1953,17 +1890,6 @@ static int rtw_check_join_candidate(struct mlme_priv *mlme
 	}
 
 	if (updated) {
-		DBG_871X("[by_bssid:%u][assoc_ssid:%s]"
-			"[to_roam:%u] "
-			"new candidate: %s(%pM, ch%u) rssi:%d\n",
-			mlme->assoc_by_bssid,
-			mlme->assoc_ssid.Ssid,
-			rtw_to_roam(adapter),
-			(*candidate)->network.Ssid.Ssid,
-			MAC_ARG((*candidate)->network.MacAddress),
-			(*candidate)->network.Configuration.DSConfig,
-			(int)(*candidate)->network.Rssi
-		);
 	}
 
 exit:
@@ -2009,24 +1935,14 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 
 		pmlmepriv->pscanned = get_next(pmlmepriv->pscanned);
 
-		DBG_871X("%s(%pM, ch%u) rssi:%d\n"
-			, pnetwork->network.Ssid.Ssid
-			, MAC_ARG(pnetwork->network.MacAddress)
-			, pnetwork->network.Configuration.DSConfig
-			, (int)pnetwork->network.Rssi);
-
 		rtw_check_join_candidate(pmlmepriv, &candidate, pnetwork);
 
 	}
 
 	if (!candidate) {
-		DBG_871X("%s: return _FAIL(candidate == NULL)\n", __func__);
 		ret = _FAIL;
 		goto exit;
 	} else {
-		DBG_871X("%s: candidate: %s(%pM, ch:%u)\n", __func__,
-			candidate->network.Ssid.Ssid, MAC_ARG(candidate->network.MacAddress),
-			candidate->network.Configuration.DSConfig);
 		goto candidate_exist;
 	}
 
@@ -2034,8 +1950,6 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 
 	/*  check for situation of  _FW_LINKED */
 	if (check_fwstate(pmlmepriv, _FW_LINKED) == true) {
-		DBG_871X("%s: _FW_LINKED while ask_for_joinbss!!!\n", __func__);
-
 		rtw_disassoc_cmd(adapter, 0, true);
 		rtw_indicate_disconnect(adapter);
 		rtw_free_assoc_resources(adapter, 0);
@@ -2109,8 +2023,6 @@ signed int rtw_set_key(struct adapter *adapter, struct security_priv *psecurityp
 	if (is_wep_enc(psetkeyparm->algorithm))
 		adapter->securitypriv.key_mask |= BIT(psetkeyparm->keyid);
 
-	DBG_871X("==> rtw_set_key algorithm(%x), keyid(%x), key_mask(%x)\n", psetkeyparm->algorithm, psetkeyparm->keyid, adapter->securitypriv.key_mask);
-
 	switch (psetkeyparm->algorithm) {
 
 	case _WEP40_:
@@ -2444,7 +2356,7 @@ void rtw_ht_use_default_setting(struct adapter *padapter)
 			SET_FLAG(phtpriv->ldpc_cap, LDPC_HT_ENABLE_TX);
 	}
 	if (phtpriv->ldpc_cap)
-		DBG_871X("[HT] Support LDPC = 0x%02X\n", phtpriv->ldpc_cap);
+		{}
 
 	/*  STBC */
 	rtw_hal_get_def_var(padapter, HAL_DEF_TX_STBC, (u8 *)&bHwSTBCSupport);
@@ -2459,7 +2371,7 @@ void rtw_ht_use_default_setting(struct adapter *padapter)
 			SET_FLAG(phtpriv->stbc_cap, STBC_HT_ENABLE_RX);
 	}
 	if (phtpriv->stbc_cap)
-		DBG_871X("[HT] Support STBC = 0x%02X\n", phtpriv->stbc_cap);
+		{}
 
 	/*  Beamforming setting */
 	rtw_hal_get_def_var(padapter, HAL_DEF_EXPLICIT_BEAMFORMER, (u8 *)&bHwSupportBeamformer);
@@ -2467,11 +2379,9 @@ void rtw_ht_use_default_setting(struct adapter *padapter)
 	CLEAR_FLAGS(phtpriv->beamform_cap);
 	if (TEST_FLAG(pregistrypriv->beamform_cap, BIT4) && bHwSupportBeamformer) {
 		SET_FLAG(phtpriv->beamform_cap, BEAMFORMING_HT_BEAMFORMER_ENABLE);
-		DBG_871X("[HT] Support Beamformer\n");
 	}
 	if (TEST_FLAG(pregistrypriv->beamform_cap, BIT5) && bHwSupportBeamformee) {
 		SET_FLAG(phtpriv->beamform_cap, BEAMFORMING_HT_BEAMFORMEE_ENABLE);
-		DBG_871X("[HT] Support Beamformee\n");
 	}
 }
 
@@ -2570,7 +2480,6 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 		if ((channel <= 14 && pregistrypriv->rx_stbc == 0x1) ||	/* enable for 2.4GHz */
 			(pregistrypriv->wifi_spec == 1)) {
 			stbc_rx_enable = 1;
-			DBG_871X("declare supporting RX STBC\n");
 		}
 	}
 
@@ -2661,8 +2570,6 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 	if ((!pmlmeinfo->HT_info_enable) || (!pmlmeinfo->HT_caps_enable))
 		return;
 
-	DBG_871X("+rtw_update_ht_cap()\n");
-
 	/* maybe needs check if ap supports rx ampdu. */
 	if (!(phtpriv->ampdu_enable) && pregistrypriv->ampdu_enable == 1) {
 		phtpriv->ampdu_enable = true;
@@ -2744,7 +2651,7 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 		(le16_to_cpu(pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info) &
 		 0x0C) >> 2;
 	if (pmlmeinfo->SM_PS == WLAN_HT_CAP_SM_PS_STATIC)
-		DBG_871X("%s(): WLAN_HT_CAP_SM_PS_STATIC\n", __func__);
+		{}
 
 	/*  */
 	/*  Config current HT Protection mode. */
@@ -2769,17 +2676,14 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 
 	psta = rtw_get_stainfo(&padapter->stapriv, pattrib->ra);
 	if (pattrib->psta != psta) {
-		DBG_871X("%s, pattrib->psta(%p) != psta(%p)\n", __func__, pattrib->psta, psta);
 		return;
 	}
 
 	if (!psta) {
-		DBG_871X("%s, psta ==NUL\n", __func__);
 		return;
 	}
 
 	if (!(psta->state & _FW_LINKED)) {
-		DBG_871X("%s, psta->state(0x%x) != _FW_LINKED\n", __func__, psta->state);
 		return;
 	}
 
@@ -2790,7 +2694,6 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 		issued |= (phtpriv->candidate_tid_bitmap>>priority)&0x1;
 
 		if (0 == issued) {
-			DBG_871X("rtw_issue_addbareq_cmd, p =%d\n", priority);
 			psta->htpriv.candidate_tid_bitmap |= BIT((u8)priority);
 			rtw_addbareq_cmd(padapter, (u8) priority, pattrib->ra);
 		}
@@ -2843,9 +2746,6 @@ void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 	int do_join_r;
 
 	if (0 < rtw_to_roam(padapter)) {
-		DBG_871X("roaming from %s(%pM), length:%d\n",
-				cur_network->network.Ssid.Ssid, MAC_ARG(cur_network->network.MacAddress),
-				cur_network->network.Ssid.SsidLength);
 		memcpy(&pmlmepriv->assoc_ssid, &cur_network->network.Ssid, sizeof(struct ndis_802_11_ssid));
 
 		pmlmepriv->assoc_by_bssid = false;
@@ -2855,13 +2755,11 @@ void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 			if (_SUCCESS == do_join_r) {
 				break;
 			} else {
-				DBG_871X("roaming do_join return %d\n", do_join_r);
 				rtw_dec_to_roam(padapter);
 
 				if (rtw_to_roam(padapter) > 0) {
 					continue;
 				} else {
-					DBG_871X("%s(%d) -to roaming fail, indicate_disconnect\n", __func__, __LINE__);
 					rtw_indicate_disconnect(padapter);
 					break;
 				}
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 9855a77a5188..7a407b9bfba0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -401,7 +401,6 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, struct rt_c
 	memset(channel_set, 0, sizeof(struct rt_channel_info)*MAX_CHANNEL_NUM);
 
 	if (ChannelPlan >= RT_CHANNEL_DOMAIN_MAX && ChannelPlan != RT_CHANNEL_DOMAIN_REALTEK_DEFINE) {
-		DBG_871X("ChannelPlan ID %x error !!!!!\n", ChannelPlan);
 		return chanset_size;
 	}
 
@@ -446,13 +445,11 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, struct rt_c
 					channel_set[chanset_size].ScanType = SCAN_PASSIVE;
 				else
 					channel_set[chanset_size].ScanType = SCAN_ACTIVE;
-				DBG_871X("%s(): channel_set[%d].ChannelNum = %d\n", __func__, chanset_size, channel_set[chanset_size].ChannelNum);
 				chanset_size++;
 			}
 		}
 	}
 
-	DBG_871X("%s ChannelPlan ID %x Chan num:%d \n", __func__, ChannelPlan, chanset_size);
 	return chanset_size;
 }
 
@@ -549,7 +546,6 @@ void mgt_dispatcher(struct adapter *padapter, union recv_frame *precv_frame)
 			if (precv_frame->u.hdr.attrib.seq_num == psta->RxMgmtFrameSeqNum) {
 				/* drop the duplicate management frame */
 				pdbgpriv->dbg_rx_dup_mgt_frame_drop_count++;
-				DBG_871X("Drop duplicate management frame with seq_num = %d.\n", precv_frame->u.hdr.attrib.seq_num);
 				return;
 			}
 		}
@@ -671,7 +667,6 @@ unsigned int OnBeacon(struct adapter *padapter, union recv_frame *precv_frame)
 	if (p && ielen > 0) {
 		if ((*(p + 1 + ielen) == 0x2D) && (*(p + 2 + ielen) != 0x2D)) {
 			/* Invalid value 0x2D is detected in Extended Supported Rates (ESR) IE. Try to fix the IE length to avoid failed Beacon parsing. */
-			DBG_871X("[WIFIDBG] Error in ESR IE is detected in Beacon of BSSID:%pM. Fix the length of ESR IE to avoid failed Beacon parsing.\n", MAC_ARG(GetAddr3Ptr(pframe)));
 			*(p + 1) = ielen - 1;
 		}
 	}
@@ -785,8 +780,6 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 	if ((pmlmeinfo->state&0x03) != WIFI_FW_AP_STATE)
 		return _FAIL;
 
-	DBG_871X("+OnAuth\n");
-
 	sa = GetAddr2Ptr(pframe);
 
 	auth_mode = psecuritypriv->dot11AuthAlgrthm;
@@ -812,8 +805,6 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 	algorithm = le16_to_cpu(*(__le16 *)((SIZE_PTR)pframe + WLAN_HDR_A3_LEN + offset));
 	seq	= le16_to_cpu(*(__le16 *)((SIZE_PTR)pframe + WLAN_HDR_A3_LEN + offset + 2));
 
-	DBG_871X("auth alg =%x, seq =%X\n", algorithm, seq);
-
 	if (auth_mode == 2 &&
 			psecuritypriv->dot11PrivacyAlgrthm != _WEP40_ &&
 			psecuritypriv->dot11PrivacyAlgrthm != _WEP104_)
@@ -821,8 +812,6 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 
 	if ((algorithm > 0 && auth_mode == 0) ||	/*  rx a shared-key auth but shared not enabled */
 		(algorithm == 0 && auth_mode == 1)) {	/*  rx a open-system auth but shared-key is enabled */
-		DBG_871X("auth rejected due to bad alg [alg =%d, auth_mib =%d] %02X%02X%02X%02X%02X%02X\n",
-			algorithm, auth_mode, sa[0], sa[1], sa[2], sa[3], sa[4], sa[5]);
 
 		status = WLAN_STATUS_NOT_SUPPORTED_AUTH_ALG;
 
@@ -838,10 +827,8 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 	if (pstat == NULL) {
 
 		/*  allocate a new one */
-		DBG_871X("going to alloc stainfo for sa =%pM\n",  MAC_ARG(sa));
 		pstat = rtw_alloc_stainfo(pstapriv, sa);
 		if (pstat == NULL) {
-			DBG_871X(" Exceed the upper limit of supported clients...\n");
 			status = WLAN_STATUS_AP_UNABLE_TO_HANDLE_NEW_STA;
 			goto auth_fail;
 		}
@@ -881,8 +868,6 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 
 
 	if ((pstat->auth_seq + 1) != seq) {
-		DBG_871X("(1)auth rejected because out of seq [rx_seq =%d, exp_seq =%d]!\n",
-			seq, pstat->auth_seq+1);
 		status = WLAN_STATUS_UNKNOWN_AUTH_TRANSACTION;
 		goto auth_fail;
 	}
@@ -894,8 +879,6 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 			pstat->expire_to = pstapriv->assoc_to;
 			pstat->authalg = algorithm;
 		} else {
-			DBG_871X("(2)auth rejected because out of seq [rx_seq =%d, exp_seq =%d]!\n",
-				seq, pstat->auth_seq+1);
 			status = WLAN_STATUS_UNKNOWN_AUTH_TRANSACTION;
 			goto auth_fail;
 		}
@@ -909,14 +892,11 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 			pstat->authalg = algorithm;
 			pstat->auth_seq = 2;
 		} else if (seq == 3) {
-			/* checking for challenging txt... */
-			DBG_871X("checking for challenging txt...\n");
 
 			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + 4 + _AUTH_IE_OFFSET_, WLAN_EID_CHALLENGE, (int *)&ie_len,
 					len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_ - 4);
 
 			if ((p == NULL) || (ie_len <= 0)) {
-				DBG_871X("auth rejected because challenge failure!(1)\n");
 				status = WLAN_STATUS_CHALLENGE_FAIL;
 				goto auth_fail;
 			}
@@ -927,13 +907,10 @@ unsigned int OnAuth(struct adapter *padapter, union recv_frame *precv_frame)
 				/*  challenging txt is correct... */
 				pstat->expire_to =  pstapriv->assoc_to;
 			} else {
-				DBG_871X("auth rejected because challenge failure!\n");
 				status = WLAN_STATUS_CHALLENGE_FAIL;
 				goto auth_fail;
 			}
 		} else {
-			DBG_871X("(3)auth rejected because out of seq [rx_seq =%d, exp_seq =%d]!\n",
-				seq, pstat->auth_seq+1);
 			status = WLAN_STATUS_UNKNOWN_AUTH_TRANSACTION;
 			goto auth_fail;
 		}
@@ -990,7 +967,6 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 	status	= le16_to_cpu(*(__le16 *)((SIZE_PTR)pframe + WLAN_HDR_A3_LEN + offset + 4));
 
 	if (status != 0) {
-		DBG_871X("clnt auth fail, status: %d\n", status);
 		if (status == 13) { /*  pmlmeinfo->auth_algo == dot11AuthAlgrthm_Auto) */
 			if (pmlmeinfo->auth_algo == dot11AuthAlgrthm_Shared)
 				pmlmeinfo->auth_algo = dot11AuthAlgrthm_Open;
@@ -1085,8 +1061,6 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 
 
 	if (pkt_len < sizeof(struct ieee80211_hdr_3addr) + ie_offset) {
-		DBG_871X("handle_assoc(reassoc =%d) - too short payload (len =%lu)"
-		       "\n", reassoc, (unsigned long)pkt_len);
 		return _FAIL;
 	}
 
@@ -1122,8 +1096,6 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 	/* now parse all ieee802_11 ie to point to elems */
 	if (rtw_ieee802_11_parse_elems(pos, left, &elems, 1) == ParseFailed ||
 	    !elems.ssid) {
-		DBG_871X("STA %pM sent invalid association request\n",
-		       MAC_ARG(pstat->hwaddr));
 		status = WLAN_STATUS_CHALLENGE_FAIL;
 		goto OnAssocReqFail;
 	}
@@ -1152,7 +1124,6 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 	/*  check if the supported rate is ok */
 	p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, WLAN_EID_SUPP_RATES, &ie_len, pkt_len - WLAN_HDR_A3_LEN - ie_offset);
 	if (p == NULL) {
-		DBG_871X("Rx a sta assoc-req which supported rate is empty!\n");
 		/*  use our own rate set as statoin used */
 		/* memcpy(supportRate, AP_BSSRATE, AP_BSSRATE_LEN); */
 		/* supportRateNum = AP_BSSRATE_LEN; */
@@ -1248,17 +1219,11 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 	pstat->flags &= ~(WLAN_STA_WPS | WLAN_STA_MAYBE_WPS);
 	if (!wpa_ie) {
 		if (elems.wps_ie) {
-			DBG_871X("STA included WPS IE in "
-				   "(Re)Association Request - assume WPS is "
-				   "used\n");
 			pstat->flags |= WLAN_STA_WPS;
 			/* wpabuf_free(sta->wps_ie); */
 			/* sta->wps_ie = wpabuf_alloc_copy(elems.wps_ie + 4, */
 			/* 				elems.wps_ie_len - 4); */
 		} else {
-			DBG_871X("STA did not include WPA/RSN IE "
-				   "in (Re)Association Request - possible WPS "
-				   "use\n");
 			pstat->flags |= WLAN_STA_MAYBE_WPS;
 		}
 
@@ -1273,8 +1238,6 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 				rtw_get_wps_attr_content(pmlmepriv->wps_beacon_ie, pmlmepriv->wps_beacon_ie_len, WPS_ATTR_SELECTED_REGISTRAR, &selected_registrar, NULL);
 
 				if (!selected_registrar) {
-					DBG_871X("selected_registrar is false , or AP is not ready to do WPS\n");
-
 					status = WLAN_STATUS_AP_UNABLE_TO_HANDLE_NEW_STA;
 
 					goto OnAssocReqFail;
@@ -1286,9 +1249,6 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 		int copy_len;
 
 		if (psecuritypriv->wpa_psk == 0) {
-			DBG_871X("STA %pM: WPA/RSN IE in association "
-			"request, but AP don't support WPA/RSN\n", MAC_ARG(pstat->hwaddr));
-
 			status = WLAN_STATUS_INVALID_IE;
 
 			goto OnAssocReqFail;
@@ -1296,9 +1256,6 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 		}
 
 		if (elems.wps_ie) {
-			DBG_871X("STA included WPS IE in "
-				   "(Re)Association Request - WPS is "
-				   "used\n");
 			pstat->flags |= WLAN_STA_WPS;
 			copy_len = 0;
 		} else {
@@ -1394,8 +1351,6 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 	if ((pstat->flags & WLAN_STA_HT) &&
 		    ((pstat->wpa2_pairwise_cipher&WPA_CIPHER_TKIP) ||
 		      (pstat->wpa_pairwise_cipher&WPA_CIPHER_TKIP))) {
-		DBG_871X("HT: %pM tried to use TKIP with HT association\n", MAC_ARG(pstat->hwaddr));
-
 		/* status = WLAN_STATUS_CIPHER_SUITE_REJECTED; */
 		/* goto OnAssocReqFail; */
 	}
@@ -1427,7 +1382,6 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 
 	/* get a unique AID */
 	if (pstat->aid > 0) {
-		DBG_871X("  old AID %d\n", pstat->aid);
 	} else {
 		for (pstat->aid = 1; pstat->aid <= NUM_STA; pstat->aid++)
 			if (pstapriv->sta_aid[pstat->aid - 1] == NULL)
@@ -1438,8 +1392,6 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 
 			pstat->aid = 0;
 
-			DBG_871X("  no room for more AIDs\n");
-
 			status = WLAN_STATUS_AP_UNABLE_TO_HANDLE_NEW_STA;
 
 			goto OnAssocReqFail;
@@ -1447,7 +1399,6 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 
 		} else {
 			pstapriv->sta_aid[pstat->aid - 1] = pstat;
-			DBG_871X("allocate new AID = (%d)\n", pstat->aid);
 		}
 	}
 
@@ -1547,7 +1498,6 @@ unsigned int OnAssocRsp(struct adapter *padapter, union recv_frame *precv_frame)
 	/* status */
 	status = le16_to_cpu(*(__le16 *)(pframe + WLAN_HDR_A3_LEN + 2));
 	if (status > 0) {
-		DBG_871X("assoc reject, status code: %d\n", status);
 		pmlmeinfo->state = WIFI_FW_NULL_STATE;
 		res = -4;
 		goto report_assoc_result;
@@ -1625,8 +1575,6 @@ unsigned int OnDeAuth(struct adapter *padapter, union recv_frame *precv_frame)
 
 	reason = le16_to_cpu(*(__le16 *)(pframe + WLAN_HDR_A3_LEN));
 
-	DBG_871X("%s Reason code(%d)\n", __func__, reason);
-
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		struct sta_info *psta;
 		struct sta_priv *pstapriv = &padapter->stapriv;
@@ -1700,8 +1648,6 @@ unsigned int OnDisassoc(struct adapter *padapter, union recv_frame *precv_frame)
 
 	reason = le16_to_cpu(*(__le16 *)(pframe + WLAN_HDR_A3_LEN));
 
-	DBG_871X("%s Reason code(%d)\n", __func__, reason);
-
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		struct sta_info *psta;
 		struct sta_priv *pstapriv = &padapter->stapriv;
@@ -1755,8 +1701,6 @@ unsigned int on_action_spct(struct adapter *padapter, union recv_frame *precv_fr
 	u8 category;
 	u8 action;
 
-	DBG_871X(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(padapter->pnetdev));
-
 	psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
 
 	if (!psta)
@@ -1817,7 +1761,6 @@ unsigned int OnAction_back(struct adapter *padapter, union recv_frame *precv_fra
 			return _SUCCESS;
 
 		action = frame_body[1];
-		DBG_871X("%s, action =%d\n", __func__, action);
 		switch (action) {
 		case WLAN_ACTION_ADDBA_REQ: /* ADDBA request */
 
@@ -1839,7 +1782,6 @@ unsigned int OnAction_back(struct adapter *padapter, union recv_frame *precv_fra
 
 			if (status == 0) {
 				/* successful */
-				DBG_871X("agg_enable for TID =%d\n", tid);
 				psta->htpriv.agg_enable_bitmap |= BIT(tid);
 				psta->htpriv.candidate_tid_bitmap &= ~BIT(tid);
 			} else {
@@ -1847,7 +1789,6 @@ unsigned int OnAction_back(struct adapter *padapter, union recv_frame *precv_fra
 			}
 
 			if (psta->state & WIFI_STA_ALIVE_CHK_STATE) {
-				DBG_871X("%s alive check - rx ADDBA response\n", __func__);
 				psta->htpriv.agg_enable_bitmap &= ~BIT(tid);
 				psta->expire_to = pstapriv->expire_to;
 				psta->state ^= WIFI_STA_ALIVE_CHK_STATE;
@@ -1872,12 +1813,8 @@ unsigned int OnAction_back(struct adapter *padapter, union recv_frame *precv_fra
 				preorder_ctrl->enable = false;
 				preorder_ctrl->indicate_seq = 0xffff;
 				#ifdef DBG_RX_SEQ
-				DBG_871X("DBG_RX_SEQ %s:%d indicate_seq:%u\n", __func__, __LINE__,
-					preorder_ctrl->indicate_seq);
 				#endif
 			}
-
-			DBG_871X("%s(): DELBA: %x(%x)\n", __func__, pmlmeinfo->agg_enable_bitmap, reason_code);
 			/* todo: how to notify the host while receiving DELETE BA */
 			break;
 
@@ -1900,14 +1837,10 @@ static s32 rtw_action_public_decache(union recv_frame *recv_frame, s32 token)
 		if (token >= 0) {
 			if ((seq_ctrl == mlmeext->action_public_rxseq)
 				&& (token == mlmeext->action_public_dialog_token)) {
-				DBG_871X(FUNC_ADPT_FMT" seq_ctrl = 0x%x, rxseq = 0x%x, token:%d\n",
-					FUNC_ADPT_ARG(adapter), seq_ctrl, mlmeext->action_public_rxseq, token);
 				return _FAIL;
 			}
 		} else {
 			if (seq_ctrl == mlmeext->action_public_rxseq) {
-				DBG_871X(FUNC_ADPT_FMT" seq_ctrl = 0x%x, rxseq = 0x%x\n",
-					FUNC_ADPT_ARG(adapter), seq_ctrl, mlmeext->action_public_rxseq);
 				return _FAIL;
 			}
 		}
@@ -2036,20 +1969,15 @@ unsigned int OnAction_sa_query(struct adapter *padapter, union recv_frame *precv
 	struct rx_pkt_attrib *pattrib = &precv_frame->u.hdr.attrib;
 	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
 	unsigned short tid;
-	/* Baron */
-
-	DBG_871X("OnAction_sa_query\n");
 
 	switch (pframe[WLAN_HDR_A3_LEN+1]) {
 	case 0: /* SA Query req */
 		memcpy(&tid, &pframe[WLAN_HDR_A3_LEN+2], sizeof(unsigned short));
-		DBG_871X("OnAction_sa_query request, action =%d, tid =%04x\n", pframe[WLAN_HDR_A3_LEN+1], tid);
 		issue_action_SA_Query(padapter, GetAddr2Ptr(pframe), 1, tid);
 		break;
 
 	case 1: /* SA Query rsp */
 		del_timer_sync(&pmlmeext->sa_query_timer);
-		DBG_871X("OnAction_sa_query response, action =%d, tid =%04x, cancel timer\n", pframe[WLAN_HDR_A3_LEN+1], pframe[WLAN_HDR_A3_LEN+2]);
 		break;
 	default:
 		break;
@@ -2108,13 +2036,11 @@ static struct xmit_frame *_alloc_mgtxmitframe(struct xmit_priv *pxmitpriv, bool
 		pmgntframe = rtw_alloc_xmitframe_ext(pxmitpriv);
 
 	if (pmgntframe == NULL) {
-		DBG_871X(FUNC_ADPT_FMT" alloc xmitframe fail, once:%d\n", FUNC_ADPT_ARG(pxmitpriv->adapter), once);
 		goto exit;
 	}
 
 	pxmitbuf = rtw_alloc_xmitbuf_ext(pxmitpriv);
 	if (pxmitbuf == NULL) {
-		DBG_871X(FUNC_ADPT_FMT" alloc xmitbuf fail\n", FUNC_ADPT_ARG(pxmitpriv->adapter));
 		rtw_free_xmitframe(pxmitpriv, pmgntframe);
 		pmgntframe = NULL;
 		goto exit;
@@ -2322,7 +2248,6 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe) {
-		DBG_871X("%s, alloc mgnt frame fail\n", __func__);
 		return;
 	}
 
@@ -2445,7 +2370,6 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	spin_unlock_bh(&pmlmepriv->bcn_update_lock);
 
 	if ((pattrib->pktlen + TXDESC_SIZE) > 512) {
-		DBG_871X("beacon frame too large\n");
 		return;
 	}
 
@@ -2482,7 +2406,6 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (pmgntframe == NULL) {
-		DBG_871X("%s, alloc mgnt frame fail\n", __func__);
 		return;
 	}
 
@@ -2779,13 +2702,9 @@ int issue_probereq_ex(struct adapter *padapter, struct ndis_802_11_ssid *pssid,
 
 	if (try_cnt && wait_ms) {
 		if (da)
-			DBG_871X(FUNC_ADPT_FMT" to %pM, ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), MAC_ARG(da), rtw_get_oper_ch(padapter),
-				ret == _SUCCESS?", acked":"", i, try_cnt, (i + 1) * wait_ms);
+			{}
 		else
-			DBG_871X(FUNC_ADPT_FMT", ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), rtw_get_oper_ch(padapter),
-				ret == _SUCCESS?", acked":"", i, try_cnt, (i + 1) * wait_ms);
+			{}
 	}
 exit:
 	return ret;
@@ -3131,7 +3050,6 @@ void issue_assocreq(struct adapter *padapter)
 	for (i = 0; i < NDIS_802_11_LENGTH_RATES_EX; i++) {
 		if (pmlmeinfo->network.SupportedRates[i] == 0)
 			break;
-		DBG_871X("network.SupportedRates[%d]=%02X\n", i, pmlmeinfo->network.SupportedRates[i]);
 	}
 
 
@@ -3153,8 +3071,6 @@ void issue_assocreq(struct adapter *padapter)
 		}
 
 		if (j == sta_bssrate_len) {
-			/*  the rate is not supported by STA */
-			DBG_871X("%s(): the rate[%d]=%02X is not supported by STA!\n", __func__, i, pmlmeinfo->network.SupportedRates[i]);
 		} else {
 			/*  the rate is supported by STA */
 			bssrate[index++] = pmlmeinfo->network.SupportedRates[i];
@@ -3162,7 +3078,6 @@ void issue_assocreq(struct adapter *padapter)
 	}
 
 	bssrate_len = index;
-	DBG_871X("bssrate_len = %d\n", bssrate_len);
 
 	if (bssrate_len == 0) {
 		rtw_free_xmitbuf(pxmitpriv, pmgntframe->pxmitbuf);
@@ -3338,8 +3253,6 @@ int issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned int pow
 		else
 			rtw_hal_macid_wakeup(padapter, psta->mac_id);
 	} else {
-		DBG_871X(FUNC_ADPT_FMT ": Can't find sta info for %pM, skip macid %s!!\n",
-			FUNC_ADPT_ARG(padapter), MAC_ARG(da), power_mode?"sleep":"wakeup");
 		rtw_warn_on(1);
 	}
 
@@ -3365,13 +3278,9 @@ int issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned int pow
 
 	if (try_cnt && wait_ms) {
 		if (da)
-			DBG_871X(FUNC_ADPT_FMT" to %pM, ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), MAC_ARG(da), rtw_get_oper_ch(padapter),
-				ret == _SUCCESS?", acked":"", i, try_cnt, (i + 1) * wait_ms);
+			{}
 		else
-			DBG_871X(FUNC_ADPT_FMT", ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), rtw_get_oper_ch(padapter),
-				ret == _SUCCESS?", acked":"", i, try_cnt, (i + 1) * wait_ms);
+			{}
 	}
 exit:
 	return ret;
@@ -3511,13 +3420,9 @@ int issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16 tid, int
 
 	if (try_cnt && wait_ms) {
 		if (da)
-			DBG_871X(FUNC_ADPT_FMT" to %pM, ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), MAC_ARG(da), rtw_get_oper_ch(padapter),
-				ret == _SUCCESS?", acked":"", i, try_cnt, (i + 1) * wait_ms);
+			{}
 		else
-			DBG_871X(FUNC_ADPT_FMT", ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), rtw_get_oper_ch(padapter),
-				ret == _SUCCESS?", acked":"", i, try_cnt, (i + 1) * wait_ms);
+			{}
 	}
 exit:
 	return ret;
@@ -3587,7 +3492,6 @@ static int _issue_deauth(struct adapter *padapter, unsigned char *da,
 
 int issue_deauth(struct adapter *padapter, unsigned char *da, unsigned short reason)
 {
-	DBG_871X("%s to %pM\n", __func__, MAC_ARG(da));
 	return _issue_deauth(padapter, da, reason, false);
 }
 
@@ -3619,13 +3523,9 @@ int issue_deauth_ex(struct adapter *padapter, u8 *da, unsigned short reason, int
 
 	if (try_cnt && wait_ms) {
 		if (da)
-			DBG_871X(FUNC_ADPT_FMT" to %pM, ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), MAC_ARG(da), rtw_get_oper_ch(padapter),
-				ret == _SUCCESS?", acked":"", i, try_cnt, (i + 1) * wait_ms);
+			{}
 		else
-			DBG_871X(FUNC_ADPT_FMT", ch:%u%s, %d/%d in %u ms\n",
-				FUNC_ADPT_ARG(padapter), rtw_get_oper_ch(padapter),
-				ret == _SUCCESS?", acked":"", i, try_cnt, (i + 1) * wait_ms);
+			{}
 	}
 exit:
 	return ret;
@@ -3646,7 +3546,6 @@ void issue_action_SA_Query(struct adapter *padapter, unsigned char *raddr, unsig
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (pmgntframe == NULL) {
-		DBG_871X("%s: alloc_mgtxmitframe fail\n", __func__);
 		return;
 	}
 
@@ -3722,8 +3621,6 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 	struct registry_priv 	*pregpriv = &padapter->registrypriv;
 	__le16 le_tmp;
 
-	DBG_871X("%s, category =%d, action =%d, status =%d\n", __func__, category, action, status);
-
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
 		return;
@@ -3787,8 +3684,6 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 			if (psta) {
 				start_seq = (psta->sta_xmitpriv.txseq_tid[status & 0x07]&0xfff) + 1;
 
-				DBG_871X("BA_starting_seqctrl = %d for TID =%d\n", start_seq, status & 0x07);
-
 				psta->BA_starting_seqctrl[status & 0x07] = start_seq;
 
 				BA_starting_seqctrl = start_seq << 4;
@@ -4021,13 +3916,10 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 	if (initiator == 0) {/*  recipient */
 		for (tid = 0; tid < MAXTID; tid++) {
 			if (psta->recvreorder_ctrl[tid].enable) {
-				DBG_871X("rx agg disable tid(%d)\n", tid);
 				issue_action_BA(padapter, addr, WLAN_ACTION_DELBA, (((tid << 1) | initiator)&0x1F));
 				psta->recvreorder_ctrl[tid].enable = false;
 				psta->recvreorder_ctrl[tid].indicate_seq = 0xffff;
 				#ifdef DBG_RX_SEQ
-				DBG_871X("DBG_RX_SEQ %s:%d indicate_seq:%u\n", __func__, __LINE__,
-					psta->recvreorder_ctrl[tid].indicate_seq);
 				#endif
 			}
 		}
@@ -4035,7 +3927,6 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 		/* DBG_871X("tx agg_enable_bitmap(0x%08x)\n", psta->htpriv.agg_enable_bitmap); */
 		for (tid = 0; tid < MAXTID; tid++) {
 			if (psta->htpriv.agg_enable_bitmap & BIT(tid)) {
-				DBG_871X("tx agg disable tid(%d)\n", tid);
 				issue_action_BA(padapter, addr, WLAN_ACTION_DELBA, (((tid << 1) | initiator)&0x1F));
 				psta->htpriv.agg_enable_bitmap &= ~BIT(tid);
 				psta->htpriv.candidate_tid_bitmap &= ~BIT(tid);
@@ -4074,13 +3965,12 @@ unsigned int send_beacon(struct adapter *padapter)
 
 
 	if (false == bxmitok) {
-		DBG_871X("%s fail! %u ms\n", __func__, jiffies_to_msecs(jiffies - start));
 		return _FAIL;
 	} else {
 		unsigned long passing_time = jiffies_to_msecs(jiffies - start);
 
 		if (passing_time > 100 || issue > 3)
-			DBG_871X("%s success, issue:%d, poll:%d, %lu ms\n", __func__, issue, poll, passing_time);
+			{}
 		/* else */
 		/* 	DBG_871X("%s success, issue:%d, poll:%d, %u ms\n", __func__, issue, poll, passing_time); */
 
@@ -4113,16 +4003,8 @@ void site_survey(struct adapter *padapter)
 		}
 	}
 
-	DBG_871X(FUNC_ADPT_FMT" ch:%u (cnt:%u) at %dms, %c%c%c\n"
-		 , FUNC_ADPT_ARG(padapter)
-		 , survey_channel
-		 , pmlmeext->sitesurvey_res.channel_idx
-		 , jiffies_to_msecs(jiffies - padapter->mlmepriv.scan_start_time)
-		 , ScanType?'A':'P', pmlmeext->sitesurvey_res.scan_mode?'A':'P'
-		 , pmlmeext->sitesurvey_res.ssid[0].SsidLength?'S':' '
-		);
 #ifdef DBG_FIXED_CHAN
-	DBG_871X(FUNC_ADPT_FMT" fixed_chan:%u\n", pmlmeext->fixed_chan);
+	
 #endif
 
 	if (survey_channel != 0) {
@@ -4278,13 +4160,11 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 	/*  checking SSID */
 	p = rtw_get_ie(bssid->IEs + ie_offset, WLAN_EID_SSID, &len, bssid->IELength - ie_offset);
 	if (p == NULL) {
-		DBG_871X("marc: cannot find SSID for survey event\n");
 		return _FAIL;
 	}
 
 	if (*(p + 1)) {
 		if (len > NDIS_802_11_LENGTH_SSID) {
-			DBG_871X("%s()-%d: IE too long (%d) for survey event\n", __func__, __LINE__, len);
 			return _FAIL;
 		}
 		memcpy(bssid->Ssid.Ssid, (p + 2), *(p + 1));
@@ -4299,7 +4179,6 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 	p = rtw_get_ie(bssid->IEs + ie_offset, WLAN_EID_SUPP_RATES, &len, bssid->IELength - ie_offset);
 	if (p) {
 		if (len > NDIS_802_11_LENGTH_RATES_EX) {
-			DBG_871X("%s()-%d: IE too long (%d) for survey event\n", __func__, __LINE__, len);
 			return _FAIL;
 		}
 		memcpy(bssid->SupportedRates, (p + 2), len);
@@ -4309,7 +4188,6 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 	p = rtw_get_ie(bssid->IEs + ie_offset, WLAN_EID_EXT_SUPP_RATES, &len, bssid->IELength - ie_offset);
 	if (p) {
 		if (len > (NDIS_802_11_LENGTH_RATES_EX-i)) {
-			DBG_871X("%s()-%d: IE too long (%d) for survey event\n", __func__, __LINE__, len);
 			return _FAIL;
 		}
 		memcpy(bssid->SupportedRates + i, (p + 2), len);
@@ -4379,11 +4257,6 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 
 	#if defined(DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) & 1
 	if (strcmp(bssid->Ssid.Ssid, DBG_RX_SIGNAL_DISPLAY_SSID_MONITORED) == 0) {
-		DBG_871X("Receiving %s(%pM, DSConfig:%u) from ch%u with ss:%3u, sq:%3u, RawRSSI:%3ld\n"
-			, bssid->Ssid.Ssid, MAC_ARG(bssid->MacAddress), bssid->Configuration.DSConfig
-			, rtw_get_oper_ch(padapter)
-			, bssid->PhyInfo.SignalStrength, bssid->PhyInfo.SignalQuality, bssid->Rssi
-		);
 	}
 	#endif
 
@@ -4442,7 +4315,6 @@ void start_create_ibss(struct adapter *padapter)
 			rtw_indicate_connect(padapter);
 		}
 	} else {
-		DBG_871X("start_create_ibss, invalid cap:%x\n", caps);
 		return;
 	}
 	/* update bc/mc sta_info */
@@ -4629,23 +4501,18 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
 
 #ifdef DEBUG_RTL871X
 		i = 0;
-		DBG_871X("%s: AP[%s] channel plan {", __func__, bssid->Ssid.Ssid);
 		while ((i < chplan_ap.Len) && (chplan_ap.Channel[i] != 0)) {
 			DBG_8192C("%02d,", chplan_ap.Channel[i]);
 			i++;
 		}
-		DBG_871X("}\n");
 #endif
 
 		memcpy(chplan_sta, pmlmeext->channel_set, sizeof(chplan_sta));
 #ifdef DEBUG_RTL871X
 		i = 0;
-		DBG_871X("%s: STA channel plan {", __func__);
 		while ((i < MAX_CHANNEL_NUM) && (chplan_sta[i].ChannelNum != 0)) {
-			DBG_871X("%02d(%c),", chplan_sta[i].ChannelNum, chplan_sta[i].ScanType == SCAN_PASSIVE?'p':'a');
 			i++;
 		}
-		DBG_871X("}\n");
 #endif
 
 		memset(pmlmeext->channel_set, 0, sizeof(pmlmeext->channel_set));
@@ -4777,12 +4644,9 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
 
 #ifdef DEBUG_RTL871X
 		k = 0;
-		DBG_871X("%s: new STA channel plan {", __func__);
 		while ((k < MAX_CHANNEL_NUM) && (chplan_new[k].ChannelNum != 0)) {
-			DBG_871X("%02d(%c),", chplan_new[k].ChannelNum, chplan_new[k].ScanType == SCAN_PASSIVE?'p':'c');
 			k++;
 		}
-		DBG_871X("}\n");
 #endif
 	}
 
@@ -4910,8 +4774,6 @@ void report_surveydone_event(struct adapter *padapter)
 	psurveydone_evt = (struct surveydone_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
 	psurveydone_evt->bss_cnt = pmlmeext->sitesurvey_res.bss_cnt;
 
-	DBG_871X("survey done event(%x) band:%d for %s\n", psurveydone_evt->bss_cnt, padapter->setband, ADPT_ARG(padapter));
-
 	rtw_enqueue_cmd(pcmdpriv, pcmd_obj);
 
 	return;
@@ -4958,8 +4820,6 @@ void report_join_res(struct adapter *padapter, int res)
 	memcpy((unsigned char *)(&(pjoinbss_evt->network.network)), &(pmlmeinfo->network), sizeof(struct wlan_bssid_ex));
 	pjoinbss_evt->network.join_res	= pjoinbss_evt->network.aid = res;
 
-	DBG_871X("report_join_res(%d)\n", res);
-
 
 	rtw_joinbss_event_prehandle(padapter, (u8 *)&pjoinbss_evt->network);
 
@@ -5065,8 +4925,6 @@ void report_del_sta_event(struct adapter *padapter, unsigned char *MacAddr, unsi
 
 	pdel_sta_evt->mac_id = mac_id;
 
-	DBG_871X("report_del_sta_event: delete STA, mac_id =%d\n", mac_id);
-
 	rtw_enqueue_cmd(pcmdpriv, pcmd_obj);
 }
 
@@ -5109,8 +4967,6 @@ void report_add_sta_event(struct adapter *padapter, unsigned char *MacAddr, int
 	memcpy((unsigned char *)(&(padd_sta_evt->macaddr)), MacAddr, ETH_ALEN);
 	padd_sta_evt->cam_id = cam_idx;
 
-	DBG_871X("report_add_sta_event: add STA\n");
-
 	rtw_enqueue_cmd(pcmdpriv, pcmd_obj);
 }
 
@@ -5380,13 +5236,8 @@ void _linked_info_dump(struct adapter *padapter)
 
 	if (padapter->bLinkInfoDump) {
 
-		DBG_871X("\n ============[%s] linked status check ===================\n", ADPT_ARG(padapter));
-
 		if ((pmlmeinfo->state&0x03) == WIFI_FW_STATION_STATE) {
 			rtw_hal_get_def_var(padapter, HAL_DEF_UNDERCORATEDSMOOTHEDPWDB, &UndecoratedSmoothedPWDB);
-
-			DBG_871X("AP[%pM] - UndecoratedSmoothedPWDB:%d\n",
-				MAC_ARG(padapter->mlmepriv.cur_network.network.MacAddress), UndecoratedSmoothedPWDB);
 		} else if ((pmlmeinfo->state&0x03) == _HW_STATE_AP_) {
 			struct list_head	*phead, *plist;
 
@@ -5399,9 +5250,6 @@ void _linked_info_dump(struct adapter *padapter)
 			while (phead != plist) {
 				psta = container_of(plist, struct sta_info, asoc_list);
 				plist = get_next(plist);
-
-				DBG_871X("STA[%pM]:UndecoratedSmoothedPWDB:%d\n",
-					MAC_ARG(psta->hwaddr), psta->rssi_stat.UndecoratedSmoothedPWDB);
 			}
 			spin_unlock_bh(&pstapriv->asoc_list_lock);
 
@@ -5426,24 +5274,6 @@ static u8 chk_ap_is_alive(struct adapter *padapter, struct sta_info *psta)
 	u8 ret = false;
 
 	#ifdef DBG_EXPIRATION_CHK
-	DBG_871X(FUNC_ADPT_FMT" rx:"STA_PKTS_FMT", beacon:%llu, probersp_to_self:%llu"
-				/*", probersp_bm:%llu, probersp_uo:%llu, probereq:%llu, BI:%u"*/
-				", retry:%u\n"
-		, FUNC_ADPT_ARG(padapter)
-		, STA_RX_PKTS_DIFF_ARG(psta)
-		, psta->sta_stats.rx_beacon_pkts - psta->sta_stats.last_rx_beacon_pkts
-		, psta->sta_stats.rx_probersp_pkts - psta->sta_stats.last_rx_probersp_pkts
-		/*, psta->sta_stats.rx_probersp_bm_pkts - psta->sta_stats.last_rx_probersp_bm_pkts
-		, psta->sta_stats.rx_probersp_uo_pkts - psta->sta_stats.last_rx_probersp_uo_pkts
-		, psta->sta_stats.rx_probereq_pkts - psta->sta_stats.last_rx_probereq_pkts
-		, pmlmeinfo->bcn_interval*/
-		, pmlmeext->retry
-	);
-
-	DBG_871X(FUNC_ADPT_FMT" tx_pkts:%llu, link_count:%u\n", FUNC_ADPT_ARG(padapter)
-		, padapter->xmitpriv.tx_pkts
-		, pmlmeinfo->link_count
-	);
 	#endif
 
 	if ((sta_rx_data_pkts(psta) == sta_last_rx_data_pkts(psta))
@@ -5499,7 +5329,6 @@ void linked_status_chk(struct adapter *padapter)
 				if (rx_chk != _SUCCESS) {
 					if (pmlmeext->retry == 0) {
 						#ifdef DBG_EXPIRATION_CHK
-						DBG_871X("issue_probereq to trigger probersp, retry =%d\n", pmlmeext->retry);
 						#endif
 						issue_probereq_ex(padapter, &pmlmeinfo->network.Ssid, pmlmeinfo->network.MacAddress, 0, 0, 0, 0);
 						issue_probereq_ex(padapter, &pmlmeinfo->network.Ssid, pmlmeinfo->network.MacAddress, 0, 0, 0, 0);
@@ -5509,7 +5338,6 @@ void linked_status_chk(struct adapter *padapter)
 
 				if (tx_chk != _SUCCESS && pmlmeinfo->link_count++ == link_count_limit) {
 					#ifdef DBG_EXPIRATION_CHK
-					DBG_871X("%s issue_nulldata 0\n", __func__);
 					#endif
 					tx_chk = issue_nulldata_in_interrupt(padapter, NULL);
 				}
@@ -5590,9 +5418,6 @@ void survey_timer_hdl(struct timer_list *t)
 		if (pmlmeext->scan_abort) {
 			{
 				pmlmeext->sitesurvey_res.channel_idx = pmlmeext->sitesurvey_res.ch_num;
-				DBG_871X("%s idx:%d\n", __func__
-					, pmlmeext->sitesurvey_res.channel_idx
-				);
 			}
 
 			pmlmeext->scan_abort = false;/* reset */
@@ -5632,7 +5457,6 @@ void link_timer_hdl(struct timer_list *t)
 
 
 	if (pmlmeinfo->state & WIFI_FW_AUTH_NULL) {
-		DBG_871X("link_timer_hdl:no beacon while connecting\n");
 		pmlmeinfo->state = WIFI_FW_NULL_STATE;
 		report_join_res(padapter, -3);
 	} else if (pmlmeinfo->state & WIFI_FW_AUTH_STATE) {
@@ -5651,7 +5475,6 @@ void link_timer_hdl(struct timer_list *t)
 			/*  */
 		}
 
-		DBG_871X("link_timer_hdl: auth timeout and try again\n");
 		pmlmeinfo->auth_seq = 1;
 		issue_auth(padapter, NULL, 0);
 		set_link_timer(pmlmeext, REAUTH_TO);
@@ -5663,7 +5486,6 @@ void link_timer_hdl(struct timer_list *t)
 			return;
 		}
 
-		DBG_871X("link_timer_hdl: assoc timeout and try again\n");
 		issue_assocreq(padapter);
 		set_link_timer(pmlmeext, REASSOC_TO);
 	}
@@ -5701,7 +5523,6 @@ void sa_query_timer_hdl(struct timer_list *t)
 	}
 
 	spin_unlock_bh(&pmlmepriv->lock);
-	DBG_871X("SA query timeout disconnect\n");
 }
 
 u8 NULL_hdl(struct adapter *padapter, u8 *pbuf)
@@ -5911,8 +5732,6 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 						pmlmeext->cur_bwmode = CHANNEL_WIDTH_20;
 						break;
 					}
-
-					DBG_871X("set HT ch/bw before connected\n");
 				}
 			}
 			break;
@@ -5991,8 +5810,6 @@ static int rtw_scan_ch_decision(struct adapter *padapter, struct rtw_ieee80211_c
 	j = 0;
 	for (i = 0; i < in_num; i++) {
 
-		DBG_871X(FUNC_ADPT_FMT" "CHAN_FMT"\n", FUNC_ADPT_ARG(padapter), CHAN_ARG(&in[i]));
-
 		set_idx = rtw_ch_set_search_ch(pmlmeext->channel_set, in[i].hw_value);
 		if (in[i].hw_value && !(in[i].flags & RTW_IEEE80211_CHAN_DISABLED)
 			&& set_idx >= 0
@@ -6019,8 +5836,6 @@ static int rtw_scan_ch_decision(struct adapter *padapter, struct rtw_ieee80211_c
 	if (j == 0) {
 		for (i = 0; i < pmlmeext->max_chan_nums; i++) {
 
-			DBG_871X(FUNC_ADPT_FMT" ch:%u\n", FUNC_ADPT_ARG(padapter), pmlmeext->channel_set[i].ChannelNum);
-
 			if (rtw_mlme_band_check(padapter, pmlmeext->channel_set[i].ChannelNum)) {
 
 				if (j >= out_num) {
@@ -6412,7 +6227,6 @@ u8 chk_bmc_sleepq_hdl(struct adapter *padapter, unsigned char *pbuf)
 u8 tx_beacon_hdl(struct adapter *padapter, unsigned char *pbuf)
 {
 	if (send_beacon(padapter) == _FAIL) {
-		DBG_871X("issue_beacon, fail!\n");
 		return H2C_PARAMETERS_ERROR;
 	}
 
@@ -6436,7 +6250,6 @@ int rtw_chk_start_clnt_join(struct adapter *padapter, u8 *ch, u8 *bw, u8 *offset
 	}
 
 	if (connect_allow) {
-		DBG_871X("start_join_set_ch_bw: ch =%d, bwmode =%d, ch_offset =%d\n", cur_ch, cur_bw, cur_ch_offset);
 		*ch = cur_ch;
 		*bw = cur_bw;
 		*offset = cur_ch_offset;
@@ -6476,10 +6289,6 @@ u8 set_ch_hdl(struct adapter *padapter, u8 *pbuf)
 
 	set_ch_parm = (struct set_ch_parm *)pbuf;
 
-	DBG_871X(FUNC_NDEV_FMT" ch:%u, bw:%u, ch_offset:%u\n",
-		FUNC_NDEV_ARG(padapter->pnetdev),
-		set_ch_parm->ch, set_ch_parm->bw, set_ch_parm->ch_offset);
-
 	pmlmeext->cur_channel = set_ch_parm->ch;
 	pmlmeext->cur_ch_offset = set_ch_parm->ch_offset;
 	pmlmeext->cur_bwmode = set_ch_parm->bw;
diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index 23897a4b663f..4c5df7272ab8 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -22,11 +22,9 @@ void _ips_enter(struct adapter *padapter)
 	pwrpriv->ips_mode = pwrpriv->ips_mode_req;
 
 	pwrpriv->ips_enter_cnts++;
-	DBG_871X("==>ips_enter cnts:%d\n", pwrpriv->ips_enter_cnts);
 
 	if (rf_off == pwrpriv->change_rfpwrstate) {
 		pwrpriv->bpower_saving = true;
-		DBG_871X("nolinked power save enter\n");
 
 		if (pwrpriv->ips_mode == IPS_LEVEL_2)
 			pwrpriv->bkeepfwalive = true;
@@ -59,15 +57,11 @@ int _ips_leave(struct adapter *padapter)
 		pwrpriv->bips_processing = true;
 		pwrpriv->change_rfpwrstate = rf_on;
 		pwrpriv->ips_leave_cnts++;
-		DBG_871X("==>ips_leave cnts:%d\n", pwrpriv->ips_leave_cnts);
 
 		result = rtw_ips_pwr_up(padapter);
 		if (result == _SUCCESS) {
 			pwrpriv->rf_pwrstate = rf_on;
 		}
-		DBG_871X("nolinked power save leave\n");
-
-		DBG_871X("==> ips_leave.....LED(0x%08x)...\n", rtw_read32(padapter, 0x4c));
 		pwrpriv->bips_processing = false;
 
 		pwrpriv->bkeepfwalive = false;
@@ -162,14 +156,11 @@ void rtw_ps_processor(struct adapter *padapter)
 	ps_deny = rtw_ps_deny_get(padapter);
 	mutex_unlock(&adapter_to_pwrctl(padapter)->lock);
 	if (ps_deny != 0) {
-		DBG_871X(FUNC_ADPT_FMT ": ps_deny = 0x%08X, skip power save!\n",
-			FUNC_ADPT_ARG(padapter), ps_deny);
 		goto exit;
 	}
 
 	if (pwrpriv->bInSuspend) {/* system suspend or autosuspend */
 		pdbgpriv->dbg_ps_insuspend_cnt++;
-		DBG_871X("%s, pwrpriv->bInSuspend == true ignore this process\n", __func__);
 		return;
 	}
 
@@ -220,7 +211,6 @@ void traffic_check_for_leave_lps(struct adapter *padapter, u8 tx, u32 tx_packets
 				if (adapter_to_pwrctl(padapter)->bLeisurePs
 				    && (adapter_to_pwrctl(padapter)->pwr_mode != PS_MODE_ACTIVE)
 				    && !(hal_btcoex_IsBtControlLps(padapter))) {
-					DBG_871X("leave lps via Tx = %d\n", xmit_cnt);
 					bLeaveLPS = true;
 				}
 			}
@@ -234,7 +224,6 @@ void traffic_check_for_leave_lps(struct adapter *padapter, u8 tx, u32 tx_packets
 			if (adapter_to_pwrctl(padapter)->bLeisurePs
 			    && (adapter_to_pwrctl(padapter)->pwr_mode != PS_MODE_ACTIVE)
 			    && !(hal_btcoex_IsBtControlLps(padapter))) {
-				DBG_871X("leave lps via Rx = %d\n", pmlmepriv->LinkDetectInfo.NumRxUnicastOkInPeriod);
 				bLeaveLPS = true;
 			}
 		}
@@ -264,7 +253,6 @@ void rtw_set_rpwm(struct adapter *padapter, u8 pslv)
 	pslv = PS_STATE(pslv);
 
 	if (pwrpriv->brpwmtimeout) {
-		DBG_871X("%s: RPWM timeout, force to set RPWM(0x%02X) again!\n", __func__, pslv);
 	} else {
 		if (pwrpriv->rpwm == pslv ||
 		    (pwrpriv->rpwm >= PS_STATE_S2 && pslv >= PS_STATE_S2))
@@ -320,7 +308,6 @@ void rtw_set_rpwm(struct adapter *padapter, u8 pslv)
 			}
 
 			if (jiffies_to_msecs(jiffies - start_time) > LPS_RPWM_WAIT_MS) {
-				DBG_871X("%s: polling cpwm timeout! poll_cnt =%d, cpwm_orig =%02x, cpwm_now =%02x\n", __func__, poll_cnt, cpwm_orig, cpwm_now);
 				_set_timer(&pwrpriv->pwr_rpwm_timer, 1);
 				break;
 			}
@@ -354,7 +341,6 @@ static u8 PS_RDY_CHECK(struct adapter *padapter)
 		return false;
 
 	if ((padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) && !(padapter->securitypriv.binstallGrpkey)) {
-		DBG_871X("Group handshake still in progress !!!\n");
 		return false;
 	}
 
@@ -383,9 +369,6 @@ void rtw_set_ps_mode(struct adapter *padapter, u8 ps_mode, u8 smart_ps, u8 bcn_a
 		if (!(hal_btcoex_IsBtControlLps(padapter))
 				|| (hal_btcoex_IsBtControlLps(padapter)
 					&& !(hal_btcoex_IsLpsOn(padapter)))) {
-			DBG_871X(FUNC_ADPT_FMT" Leave 802.11 power save - %s\n",
-				FUNC_ADPT_ARG(padapter), msg);
-
 			pwrpriv->pwr_mode = ps_mode;
 			rtw_set_rpwm(padapter, PS_STATE_S4);
 
@@ -400,9 +383,6 @@ void rtw_set_ps_mode(struct adapter *padapter, u8 ps_mode, u8 smart_ps, u8 bcn_a
 			) {
 			u8 pslv;
 
-			DBG_871X(FUNC_ADPT_FMT" Enter 802.11 power save - %s\n",
-				FUNC_ADPT_ARG(padapter), msg);
-
 			hal_btcoex_LpsNotify(padapter, ps_mode);
 
 			pwrpriv->bFwCurrentInPSMode = true;
@@ -452,13 +432,11 @@ s32 LPS_RF_ON_check(struct adapter *padapter, u32 delay_ms)
 
 		if (padapter->bSurpriseRemoved) {
 			err = -2;
-			DBG_871X("%s: device surprise removed!!\n", __func__);
 			break;
 		}
 
 		if (jiffies_to_msecs(jiffies - start_time) > delay_ms) {
 			err = -1;
-			DBG_871X("%s: Wait for FW LPS leave more than %u ms!!!\n", __func__, delay_ms);
 			break;
 		}
 		msleep(1);
@@ -548,15 +526,12 @@ void LeaveAllPowerSaveModeDirect(struct adapter *Adapter)
 	struct pwrctrl_priv *pwrpriv = adapter_to_pwrctl(Adapter);
 
 	if (Adapter->bSurpriseRemoved) {
-		DBG_871X(FUNC_ADPT_FMT ": bSurpriseRemoved =%d Skip!\n",
-			FUNC_ADPT_ARG(Adapter), Adapter->bSurpriseRemoved);
 		return;
 	}
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED)) { /* connect */
 
 		if (pwrpriv->pwr_mode == PS_MODE_ACTIVE) {
-			DBG_871X("%s: Driver Already Leave LPS\n", __func__);
 			return;
 		}
 
@@ -570,7 +545,7 @@ void LeaveAllPowerSaveModeDirect(struct adapter *Adapter)
 	} else {
 		if (pwrpriv->rf_pwrstate == rf_off)
 			if (!ips_leave(pri_padapter))
-				DBG_871X("======> ips_leave fail.............\n");
+				{}
 	}
 }
 
@@ -585,14 +560,10 @@ void LeaveAllPowerSaveMode(struct adapter *Adapter)
 	int n_assoc_iface = 0;
 
 	if (!Adapter->bup) {
-		DBG_871X(FUNC_ADPT_FMT ": bup =%d Skip!\n",
-			FUNC_ADPT_ARG(Adapter), Adapter->bup);
 		return;
 	}
 
 	if (Adapter->bSurpriseRemoved) {
-		DBG_871X(FUNC_ADPT_FMT ": bSurpriseRemoved =%d Skip!\n",
-			FUNC_ADPT_ARG(Adapter), Adapter->bSurpriseRemoved);
 		return;
 	}
 
@@ -608,7 +579,7 @@ void LeaveAllPowerSaveMode(struct adapter *Adapter)
 	} else {
 		if (adapter_to_pwrctl(Adapter)->rf_pwrstate == rf_off) {
 			if (!ips_leave(Adapter))
-				DBG_871X("======> ips_leave fail.............\n");
+				{}
 		}
 	}
 }
@@ -640,7 +611,6 @@ void LPS_Leave_check(struct adapter *padapter)
 			break;
 
 		if (jiffies_to_msecs(jiffies - start_time) > 100) {
-			DBG_871X("Wait for cpwm event  than 100 ms!!!\n");
 			break;
 		}
 		msleep(1);
@@ -663,7 +633,6 @@ void cpwm_int_hdl(struct adapter *padapter, struct reportpwrstate_parm *preportp
 	mutex_lock(&pwrpriv->lock);
 
 	if (pwrpriv->rpwm < PS_STATE_S2) {
-		DBG_871X("%s: Redundant CPWM Int. RPWM = 0x%02X CPWM = 0x%02x\n", __func__, pwrpriv->rpwm, pwrpriv->cpwm);
 		goto exit;
 	}
 
@@ -708,7 +677,6 @@ static void rpwmtimeout_workitem_callback(struct work_struct *work)
 
 	mutex_lock(&pwrpriv->lock);
 	if ((pwrpriv->rpwm == pwrpriv->cpwm) || (pwrpriv->cpwm >= PS_STATE_S2)) {
-		DBG_871X("%s: rpwm = 0x%02X cpwm = 0x%02X CPWM done!\n", __func__, pwrpriv->rpwm, pwrpriv->cpwm);
 		goto exit;
 	}
 	mutex_unlock(&pwrpriv->lock);
@@ -717,7 +685,6 @@ static void rpwmtimeout_workitem_callback(struct work_struct *work)
 		struct reportpwrstate_parm report;
 
 		report.state = PS_STATE_S2;
-		DBG_871X("\n%s: FW already leave 32K!\n\n", __func__);
 		cpwm_int_hdl(padapter, &report);
 
 		return;
@@ -726,7 +693,6 @@ static void rpwmtimeout_workitem_callback(struct work_struct *work)
 	mutex_lock(&pwrpriv->lock);
 
 	if ((pwrpriv->rpwm == pwrpriv->cpwm) || (pwrpriv->cpwm >= PS_STATE_S2)) {
-		DBG_871X("%s: cpwm =%d, nothing to do!\n", __func__, pwrpriv->cpwm);
 		goto exit;
 	}
 	pwrpriv->brpwmtimeout = true;
@@ -744,10 +710,7 @@ static void pwr_rpwm_timeout_handler(struct timer_list *t)
 {
 	struct pwrctrl_priv *pwrpriv = from_timer(pwrpriv, t, pwr_rpwm_timer);
 
-	DBG_871X("+%s: rpwm = 0x%02X cpwm = 0x%02X\n", __func__, pwrpriv->rpwm, pwrpriv->cpwm);
-
 	if ((pwrpriv->rpwm == pwrpriv->cpwm) || (pwrpriv->cpwm >= PS_STATE_S2)) {
-		DBG_871X("+%s: cpwm =%d, nothing to do!\n", __func__, pwrpriv->cpwm);
 		return;
 	}
 
@@ -1104,25 +1067,23 @@ int _rtw_pwr_wakeup(struct adapter *padapter, u32 ips_deffer_ms, const char *cal
 
 
 	if (pwrpriv->ps_processing) {
-		DBG_871X("%s wait ps_processing...\n", __func__);
 		while (pwrpriv->ps_processing && jiffies_to_msecs(jiffies - start) <= 3000)
 			mdelay(10);
 		if (pwrpriv->ps_processing)
-			DBG_871X("%s wait ps_processing timeout\n", __func__);
+			{}
 		else
-			DBG_871X("%s wait ps_processing done\n", __func__);
+			{}
 	}
 
 	if (!(pwrpriv->bInternalAutoSuspend) && pwrpriv->bInSuspend) {
-		DBG_871X("%s wait bInSuspend...\n", __func__);
 		while (pwrpriv->bInSuspend && jiffies_to_msecs(jiffies - start) <= 3000
 		) {
 			mdelay(10);
 		}
 		if (pwrpriv->bInSuspend)
-			DBG_871X("%s wait bInSuspend timeout\n", __func__);
+			{}
 		else
-			DBG_871X("%s wait bInSuspend done\n", __func__);
+			{}
 	}
 
 	/* System suspend is not allowed to wakeup */
@@ -1201,11 +1162,9 @@ int rtw_pm_set_ips(struct adapter *padapter, u8 mode)
 
 	if (mode == IPS_NORMAL || mode == IPS_LEVEL_2) {
 		rtw_ips_mode_req(pwrctrlpriv, mode);
-		DBG_871X("%s %s\n", __func__, mode == IPS_NORMAL?"IPS_NORMAL":"IPS_LEVEL_2");
 		return 0;
 	} else if (mode == IPS_NONE) {
 		rtw_ips_mode_req(pwrctrlpriv, mode);
-		DBG_871X("%s %s\n", __func__, "IPS_NONE");
 		if ((padapter->bSurpriseRemoved == 0) && (rtw_pwr_wakeup(padapter) == _FAIL))
 			return -EFAULT;
 	} else
@@ -1229,8 +1188,6 @@ void rtw_ps_deny(struct adapter *padapter, enum ps_deny_reason reason)
 
 	mutex_lock(&pwrpriv->lock);
 	if (pwrpriv->ps_deny & BIT(reason)) {
-		DBG_871X(FUNC_ADPT_FMT ": [WARNING] Reason %d had been set before!!\n",
-			FUNC_ADPT_ARG(padapter), reason);
 	}
 	pwrpriv->ps_deny |= BIT(reason);
 	mutex_unlock(&pwrpriv->lock);
@@ -1255,8 +1212,6 @@ void rtw_ps_deny_cancel(struct adapter *padapter, enum ps_deny_reason reason)
 
 	mutex_lock(&pwrpriv->lock);
 	if ((pwrpriv->ps_deny & BIT(reason)) == 0) {
-		DBG_871X(FUNC_ADPT_FMT ": [ERROR] Reason %d had been canceled before!!\n",
-			FUNC_ADPT_ARG(padapter), reason);
 	}
 	pwrpriv->ps_deny &= ~BIT(reason);
 	mutex_unlock(&pwrpriv->lock);
diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index f18a7afcc0d3..35c87a0be40d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -249,7 +249,7 @@ u32 rtw_free_uc_swdec_pending_queue(struct adapter *adapter)
 	}
 
 	if (cnt)
-		DBG_871X(FUNC_ADPT_FMT" dequeue %d\n", FUNC_ADPT_ARG(adapter), cnt);
+		{}
 
 	return cnt;
 }
@@ -338,7 +338,6 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 
 				if (psecuritypriv->binstallGrpkey == false) {
 					res = _FAIL;
-					DBG_871X("\n recvframe_chkmic:didn't install group key!!!!!!!!!!\n");
 					goto exit;
 				}
 			} else {
@@ -369,9 +368,7 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 
 				if ((prxattrib->bdecrypted == true) && (brpt_micerror == true)) {
 					rtw_handle_tkip_mic_err(adapter, (u8)IS_MCAST(prxattrib->ra));
-					DBG_871X(" mic error :prxattrib->bdecrypted =%d\n", prxattrib->bdecrypted);
 				} else {
-					DBG_871X(" mic error :prxattrib->bdecrypted =%d\n", prxattrib->bdecrypted);
 				}
 
 				res = _FAIL;
@@ -407,8 +404,6 @@ static union recv_frame *decryptor(struct adapter *padapter, union recv_frame *p
 		prxattrib->key_index = (((iv[3])>>6)&0x3);
 
 		if (prxattrib->key_index > WEP_KEYS) {
-			DBG_871X("prxattrib->key_index(%d) > WEP_KEYS\n", prxattrib->key_index);
-
 			switch (prxattrib->encrypt) {
 			case _WEP40_:
 			case _WEP104_:
@@ -427,12 +422,6 @@ static union recv_frame *decryptor(struct adapter *padapter, union recv_frame *p
 		psecuritypriv->hw_decrypted = false;
 
 		#ifdef DBG_RX_DECRYPTOR
-		DBG_871X("[%s] %d:prxstat->bdecrypted:%d,  prxattrib->encrypt:%d,  Setting psecuritypriv->hw_decrypted = %d\n",
-			__func__,
-			__LINE__,
-			prxattrib->bdecrypted,
-			prxattrib->encrypt,
-			psecuritypriv->hw_decrypted);
 		#endif
 
 		switch (prxattrib->encrypt) {
@@ -454,22 +443,10 @@ static union recv_frame *decryptor(struct adapter *padapter, union recv_frame *p
 		) {
 		psecuritypriv->hw_decrypted = true;
 		#ifdef DBG_RX_DECRYPTOR
-		DBG_871X("[%s] %d:prxstat->bdecrypted:%d,  prxattrib->encrypt:%d,  Setting psecuritypriv->hw_decrypted = %d\n",
-			__func__,
-			__LINE__,
-			prxattrib->bdecrypted,
-			prxattrib->encrypt,
-			psecuritypriv->hw_decrypted);
 
 		#endif
 	} else {
 		#ifdef DBG_RX_DECRYPTOR
-		DBG_871X("[%s] %d:prxstat->bdecrypted:%d,  prxattrib->encrypt:%d,  Setting psecuritypriv->hw_decrypted = %d\n",
-			__func__,
-			__LINE__,
-			prxattrib->bdecrypted,
-			prxattrib->encrypt,
-			psecuritypriv->hw_decrypted);
 		#endif
 	}
 
@@ -799,8 +776,6 @@ static signed int ap2sta_data_frame(struct adapter *adapter, union recv_frame *p
 		/*  filter packets that SA is myself or multicast or broadcast */
 		if (!memcmp(myhwaddr, pattrib->src, ETH_ALEN)) {
 			#ifdef DBG_RX_DROP_FRAME
-			DBG_871X("DBG_RX_DROP_FRAME %s SA =%pM, myhwaddr =%pM\n",
-				__func__, MAC_ARG(pattrib->src), MAC_ARG(myhwaddr));
 			#endif
 			ret = _FAIL;
 			goto exit;
@@ -809,7 +784,6 @@ static signed int ap2sta_data_frame(struct adapter *adapter, union recv_frame *p
 		/*  da should be for me */
 		if ((memcmp(myhwaddr, pattrib->dst, ETH_ALEN)) && (!bmcast)) {
 			#ifdef DBG_RX_DROP_FRAME
-			DBG_871X("DBG_RX_DROP_FRAME %s DA =%pM\n", __func__, MAC_ARG(pattrib->dst));
 			#endif
 			ret = _FAIL;
 			goto exit;
@@ -821,13 +795,9 @@ static signed int ap2sta_data_frame(struct adapter *adapter, union recv_frame *p
 		     !memcmp(mybssid, "\x0\x0\x0\x0\x0\x0", ETH_ALEN) ||
 		     (memcmp(pattrib->bssid, mybssid, ETH_ALEN))) {
 			#ifdef DBG_RX_DROP_FRAME
-			DBG_871X("DBG_RX_DROP_FRAME %s BSSID =%pM, mybssid =%pM\n",
-				__func__, MAC_ARG(pattrib->bssid), MAC_ARG(mybssid));
-			DBG_871X("this adapter = %d, buddy adapter = %d\n", adapter->adapter_type, adapter->pbuddystruct);
 			#endif
 
 			if (!bmcast) {
-				DBG_871X("issue_deauth to the nonassociated ap =%pM for the reason(7)\n", MAC_ARG(pattrib->bssid));
 				issue_deauth(adapter, pattrib->bssid, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
 			}
 
@@ -842,7 +812,6 @@ static signed int ap2sta_data_frame(struct adapter *adapter, union recv_frame *p
 
 		if (!*psta) {
 			#ifdef DBG_RX_DROP_FRAME
-			DBG_871X("DBG_RX_DROP_FRAME %s can't get psta under STATION_MODE ; drop pkt\n", __func__);
 			#endif
 			ret = _FAIL;
 			goto exit;
@@ -870,7 +839,6 @@ static signed int ap2sta_data_frame(struct adapter *adapter, union recv_frame *p
 		*psta = rtw_get_stainfo(pstapriv, pattrib->bssid); /*  get sta_info */
 		if (!*psta) {
 			#ifdef DBG_RX_DROP_FRAME
-			DBG_871X("DBG_RX_DROP_FRAME %s can't get psta under WIFI_MP_STATE ; drop pkt\n", __func__);
 			#endif
 			ret = _FAIL;
 			goto exit;
@@ -894,8 +862,6 @@ static signed int ap2sta_data_frame(struct adapter *adapter, union recv_frame *p
 				if (jiffies_to_msecs(jiffies - send_issue_deauth_time) > 10000 || send_issue_deauth_time == 0) {
 					send_issue_deauth_time = jiffies;
 
-					DBG_871X("issue_deauth to the ap =%pM for the reason(7)\n", MAC_ARG(pattrib->bssid));
-
 					issue_deauth(adapter, pattrib->bssid, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
 				}
 			}
@@ -903,7 +869,6 @@ static signed int ap2sta_data_frame(struct adapter *adapter, union recv_frame *p
 
 		ret = _FAIL;
 		#ifdef DBG_RX_DROP_FRAME
-		DBG_871X("DBG_RX_DROP_FRAME %s fw_state:0x%x\n", __func__, get_fwstate(pmlmepriv));
 		#endif
 	}
 
@@ -930,8 +895,6 @@ static signed int sta2ap_data_frame(struct adapter *adapter, union recv_frame *p
 
 		*psta = rtw_get_stainfo(pstapriv, pattrib->src);
 		if (!*psta) {
-			DBG_871X("issue_deauth to sta =%pM for the reason(7)\n", MAC_ARG(pattrib->src));
-
 			issue_deauth(adapter, pattrib->src, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
 
 			ret = RTW_RX_HANDLED;
@@ -955,7 +918,6 @@ static signed int sta2ap_data_frame(struct adapter *adapter, union recv_frame *p
 			ret = RTW_RX_HANDLED;
 			goto exit;
 		}
-		DBG_871X("issue_deauth to sta =%pM for the reason(7)\n", MAC_ARG(pattrib->src));
 		issue_deauth(adapter, pattrib->src, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
 		ret = RTW_RX_HANDLED;
 		goto exit;
@@ -1022,7 +984,6 @@ static signed int validate_recv_ctrl_frame(struct adapter *padapter, union recv_
 			return _FAIL;
 
 		if (psta->state & WIFI_STA_ALIVE_CHK_STATE) {
-			DBG_871X("%s alive check-rx ps-poll\n", __func__);
 			psta->expire_to = pstapriv->expire_to;
 			psta->state ^= WIFI_STA_ALIVE_CHK_STATE;
 		}
@@ -1078,12 +1039,9 @@ static signed int validate_recv_ctrl_frame(struct adapter *padapter, union recv_
 				/* DBG_871X("no buffered packets to xmit\n"); */
 				if (pstapriv->tim_bitmap&BIT(psta->aid)) {
 					if (psta->sleepq_len == 0) {
-						DBG_871X("no buffered packets to xmit\n");
-
 						/* issue nulldata with More data bit = 0 to indicate we have no buffered packets */
 						issue_nulldata_in_interrupt(padapter, psta->hwaddr);
 					} else {
-						DBG_871X("error!psta->sleepq_len =%d\n", psta->sleepq_len);
 						psta->sleepq_len = 0;
 					}
 
@@ -1329,7 +1287,6 @@ static signed int validate_recv_data_frame(struct adapter *adapter, union recv_f
 
 	if (!pbssid) {
 		#ifdef DBG_RX_DROP_FRAME
-		DBG_871X("DBG_RX_DROP_FRAME %s pbssid == NULL\n", __func__);
 		#endif
 		ret = _FAIL;
 		goto exit;
@@ -1373,7 +1330,6 @@ static signed int validate_recv_data_frame(struct adapter *adapter, union recv_f
 
 	if (ret == _FAIL) {
 		#ifdef DBG_RX_DROP_FRAME
-		DBG_871X("DBG_RX_DROP_FRAME %s case:%d, res:%d\n", __func__, pattrib->to_fr_ds, ret);
 		#endif
 		goto exit;
 	} else if (ret == RTW_RX_HANDLED) {
@@ -1383,7 +1339,6 @@ static signed int validate_recv_data_frame(struct adapter *adapter, union recv_f
 
 	if (!psta) {
 		#ifdef DBG_RX_DROP_FRAME
-		DBG_871X("DBG_RX_DROP_FRAME %s psta == NULL\n", __func__);
 		#endif
 		ret = _FAIL;
 		goto exit;
@@ -1420,7 +1375,6 @@ static signed int validate_recv_data_frame(struct adapter *adapter, union recv_f
 	/*  decache, drop duplicate recv packets */
 	if (recv_decache(precv_frame, bretry, &psta->sta_recvpriv.rxcache) == _FAIL) {
 		#ifdef DBG_RX_DROP_FRAME
-		DBG_871X("DBG_RX_DROP_FRAME %s recv_decache return _FAIL\n", __func__);
 		#endif
 		ret = _FAIL;
 		goto exit;
@@ -1468,7 +1422,6 @@ static signed int validate_80211w_mgmt(struct adapter *adapter, union recv_frame
 			data_len = pattrib->pkt_len - pattrib->hdrlen - pattrib->iv_len - pattrib->icv_len;
 			mgmt_DATA = rtw_zmalloc(data_len);
 			if (!mgmt_DATA) {
-				DBG_871X("%s mgmt allocate fail  !!!!!!!!!\n", __func__);
 				goto validate_80211w_fail;
 			}
 			precv_frame = decryptor(adapter, precv_frame);
@@ -1480,7 +1433,6 @@ static signed int validate_80211w_mgmt(struct adapter *adapter, union recv_frame
 			pattrib->pkt_len = pattrib->pkt_len - pattrib->iv_len - pattrib->icv_len;
 			kfree(mgmt_DATA);
 			if (!precv_frame) {
-				DBG_871X("%s mgmt descrypt fail  !!!!!!!!!\n", __func__);
 				goto validate_80211w_fail;
 			}
 		} else if (IS_MCAST(GetAddr1Ptr(ptr)) &&
@@ -1505,11 +1457,9 @@ static signed int validate_80211w_mgmt(struct adapter *adapter, union recv_frame
 					ptr[WLAN_HDR_A3_LEN] != RTW_WLAN_CATEGORY_UNPROTECTED_WNM &&
 					ptr[WLAN_HDR_A3_LEN] != RTW_WLAN_CATEGORY_SELF_PROTECTED  &&
 					ptr[WLAN_HDR_A3_LEN] != RTW_WLAN_CATEGORY_P2P) {
-					DBG_871X("action frame category =%d should robust\n", ptr[WLAN_HDR_A3_LEN]);
 					goto validate_80211w_fail;
 				}
 			} else if (subtype == WIFI_DEAUTH || subtype == WIFI_DISASSOC) {
-				DBG_871X("802.11w recv none protected packet\n");
 				/* issue sa query request */
 				issue_action_SA_Query(adapter, NULL, 0, 0);
 				goto validate_80211w_fail;
@@ -1527,11 +1477,8 @@ static inline void dump_rx_packet(u8 *ptr)
 {
 	int i;
 
-	DBG_871X("#############################\n");
 	for (i = 0; i < 64; i = i+8)
-		DBG_871X("%02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X:\n", *(ptr+i),
-		*(ptr+i+1), *(ptr+i+2), *(ptr+i+3), *(ptr+i+4), *(ptr+i+5), *(ptr+i+6), *(ptr+i+7));
-	DBG_871X("#############################\n");
+		{}
 }
 
 static signed int validate_recv_frame(struct adapter *adapter, union recv_frame *precv_frame)
@@ -1614,7 +1561,6 @@ static signed int validate_recv_frame(struct adapter *adapter, union recv_frame
 		break;
 	default:
 		#ifdef DBG_RX_DROP_FRAME
-		DBG_871X("DBG_RX_DROP_FRAME validate_recv_data_frame fail! type = 0x%x\n", type);
 		#endif
 		retval = _FAIL;
 		break;
@@ -1714,13 +1660,11 @@ static int amsdu_to_msdu(struct adapter *padapter, union recv_frame *prframe)
 		nSubframe_Length = get_unaligned_be16(pdata + 12);
 
 		if (a_len < (ETHERNET_HEADER_SIZE + nSubframe_Length)) {
-			DBG_871X("nRemain_Length is %d and nSubframe_Length is : %d\n", a_len, nSubframe_Length);
 			break;
 		}
 
 		sub_pkt = rtw_os_alloc_msdu_pkt(prframe, nSubframe_Length, pdata);
 		if (!sub_pkt) {
-			DBG_871X("%s(): allocate sub packet fail !!!\n", __func__);
 			break;
 		}
 
@@ -1731,7 +1675,6 @@ static int amsdu_to_msdu(struct adapter *padapter, union recv_frame *prframe)
 		subframes[nr_subframes++] = sub_pkt;
 
 		if (nr_subframes >= MAX_SUBFRAME_COUNT) {
-			DBG_871X("ParseSubframe(): Too many Subframes! Packets dropped!\n");
 			break;
 		}
 
@@ -1743,7 +1686,6 @@ static int amsdu_to_msdu(struct adapter *padapter, union recv_frame *prframe)
 				padding_len = 0;
 
 			if (a_len < padding_len) {
-				DBG_871X("ParseSubframe(): a_len < padding_len !\n");
 				break;
 			}
 			pdata += padding_len;
@@ -1777,8 +1719,6 @@ static int check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl, u16 seq_n
 	if (preorder_ctrl->indicate_seq == 0xFFFF) {
 		preorder_ctrl->indicate_seq = seq_num;
 		#ifdef DBG_RX_SEQ
-		DBG_871X("DBG_RX_SEQ %s:%d init IndicateSeq: %d, NewSeq: %d\n", __func__, __LINE__,
-			preorder_ctrl->indicate_seq, seq_num);
 		#endif
 
 		/* DbgPrint("check_indicate_seq, 1st->indicate_seq =%d\n", precvpriv->indicate_seq); */
@@ -1791,8 +1731,6 @@ static int check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl, u16 seq_n
 		/* DbgPrint("CheckRxTsIndicateSeq(): Packet Drop! IndicateSeq: %d, NewSeq: %d\n", precvpriv->indicate_seq, seq_num); */
 
 		#ifdef DBG_RX_DROP_FRAME
-		DBG_871X("%s IndicateSeq: %d > NewSeq: %d\n", __func__,
-			preorder_ctrl->indicate_seq, seq_num);
 		#endif
 
 
@@ -1808,8 +1746,6 @@ static int check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl, u16 seq_n
 		preorder_ctrl->indicate_seq = (preorder_ctrl->indicate_seq + 1) & 0xFFF;
 
 		#ifdef DBG_RX_SEQ
-		DBG_871X("DBG_RX_SEQ %s:%d SN_EQUAL IndicateSeq: %d, NewSeq: %d\n", __func__, __LINE__,
-			preorder_ctrl->indicate_seq, seq_num);
 		#endif
 	} else if (SN_LESS(wend, seq_num)) {
 		/* DbgPrint("CheckRxTsIndicateSeq(): Window Shift! IndicateSeq: %d, NewSeq: %d\n", precvpriv->indicate_seq, seq_num); */
@@ -1821,8 +1757,6 @@ static int check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl, u16 seq_n
 			preorder_ctrl->indicate_seq = 0xFFF - (wsize - (seq_num + 1)) + 1;
 		pdbgpriv->dbg_rx_ampdu_window_shift_cnt++;
 		#ifdef DBG_RX_SEQ
-		DBG_871X("DBG_RX_SEQ %s:%d SN_LESS(wend, seq_num) IndicateSeq: %d, NewSeq: %d\n", __func__, __LINE__,
-			preorder_ctrl->indicate_seq, seq_num);
 		#endif
 	}
 
@@ -1922,8 +1856,6 @@ static int recv_indicatepkts_in_order(struct adapter *padapter, struct recv_reor
 		pattrib = &prframe->u.hdr.attrib;
 
 		#ifdef DBG_RX_SEQ
-		DBG_871X("DBG_RX_SEQ %s:%d IndicateSeq: %d, NewSeq: %d\n", __func__, __LINE__,
-			preorder_ctrl->indicate_seq, pattrib->seq_num);
 		#endif
 		recv_indicatepkts_pkt_loss_cnt(pdbgpriv, preorder_ctrl->indicate_seq, pattrib->seq_num);
 		preorder_ctrl->indicate_seq = pattrib->seq_num;
@@ -1944,8 +1876,6 @@ static int recv_indicatepkts_in_order(struct adapter *padapter, struct recv_reor
 			if (SN_EQUAL(preorder_ctrl->indicate_seq, pattrib->seq_num)) {
 				preorder_ctrl->indicate_seq = (preorder_ctrl->indicate_seq + 1) & 0xFFF;
 				#ifdef DBG_RX_SEQ
-				DBG_871X("DBG_RX_SEQ %s:%d IndicateSeq: %d, NewSeq: %d\n", __func__, __LINE__,
-					preorder_ctrl->indicate_seq, pattrib->seq_num);
 				#endif
 			}
 
@@ -2014,7 +1944,6 @@ static int recv_indicatepkt_reorder(struct adapter *padapter, union recv_frame *
 			}
 
 			#ifdef DBG_RX_DROP_FRAME
-			DBG_871X("DBG_RX_DROP_FRAME %s pattrib->qos != 1\n", __func__);
 			#endif
 
 			return _FAIL;
@@ -2025,16 +1954,12 @@ static int recv_indicatepkt_reorder(struct adapter *padapter, union recv_frame *
 			/* indicate this recv_frame */
 			preorder_ctrl->indicate_seq = pattrib->seq_num;
 			#ifdef DBG_RX_SEQ
-			DBG_871X("DBG_RX_SEQ %s:%d IndicateSeq: %d, NewSeq: %d\n", __func__, __LINE__,
-				preorder_ctrl->indicate_seq, pattrib->seq_num);
 			#endif
 
 			rtw_recv_indicatepkt(padapter, prframe);
 
 			preorder_ctrl->indicate_seq = (preorder_ctrl->indicate_seq + 1)%4096;
 			#ifdef DBG_RX_SEQ
-			DBG_871X("DBG_RX_SEQ %s:%d IndicateSeq: %d, NewSeq: %d\n", __func__, __LINE__,
-				preorder_ctrl->indicate_seq, pattrib->seq_num);
 			#endif
 
 			return _SUCCESS;
@@ -2043,21 +1968,16 @@ static int recv_indicatepkt_reorder(struct adapter *padapter, union recv_frame *
 		if (preorder_ctrl->enable == false) {
 			preorder_ctrl->indicate_seq = pattrib->seq_num;
 			#ifdef DBG_RX_SEQ
-			DBG_871X("DBG_RX_SEQ %s:%d IndicateSeq: %d, NewSeq: %d\n", __func__, __LINE__,
-				preorder_ctrl->indicate_seq, pattrib->seq_num);
 			#endif
 
 			retval = amsdu_to_msdu(padapter, prframe);
 
 			preorder_ctrl->indicate_seq = (preorder_ctrl->indicate_seq + 1)%4096;
 			#ifdef DBG_RX_SEQ
-			DBG_871X("DBG_RX_SEQ %s:%d IndicateSeq: %d, NewSeq: %d\n", __func__, __LINE__,
-				preorder_ctrl->indicate_seq, pattrib->seq_num);
 			#endif
 
 			if (retval != _SUCCESS) {
 				#ifdef DBG_RX_DROP_FRAME
-				DBG_871X("DBG_RX_DROP_FRAME %s amsdu_to_msdu fail\n", __func__);
 				#endif
 			}
 
@@ -2071,7 +1991,6 @@ static int recv_indicatepkt_reorder(struct adapter *padapter, union recv_frame *
 	if (!check_indicate_seq(preorder_ctrl, pattrib->seq_num)) {
 		pdbgpriv->dbg_rx_ampdu_drop_count++;
 		#ifdef DBG_RX_DROP_FRAME
-		DBG_871X("DBG_RX_DROP_FRAME %s check_indicate_seq fail\n", __func__);
 		#endif
 		goto _err_exit;
 	}
@@ -2083,7 +2002,6 @@ static int recv_indicatepkt_reorder(struct adapter *padapter, union recv_frame *
 		/* spin_unlock_irqrestore(&ppending_recvframe_queue->lock, irql); */
 		/* return _FAIL; */
 		#ifdef DBG_RX_DROP_FRAME
-		DBG_871X("DBG_RX_DROP_FRAME %s enqueue_reorder_recvframe fail\n", __func__);
 		#endif
 		goto _err_exit;
 	}
@@ -2152,7 +2070,6 @@ static int process_recv_indicatepkts(struct adapter *padapter, union recv_frame
 
 		if (recv_indicatepkt_reorder(padapter, prframe) != _SUCCESS) { /*  including perform A-MPDU Rx Ordering Buffer Control */
 			#ifdef DBG_RX_DROP_FRAME
-			DBG_871X("DBG_RX_DROP_FRAME %s recv_indicatepkt_reorder error!\n", __func__);
 			#endif
 
 			if ((padapter->bDriverStopped == false) &&
@@ -2165,7 +2082,6 @@ static int process_recv_indicatepkts(struct adapter *padapter, union recv_frame
 		retval = wlanhdr_to_ethhdr(prframe);
 		if (retval != _SUCCESS) {
 			#ifdef DBG_RX_DROP_FRAME
-			DBG_871X("DBG_RX_DROP_FRAME %s wlanhdr_to_ethhdr error!\n", __func__);
 			#endif
 			return retval;
 		}
@@ -2210,7 +2126,6 @@ static int recv_func_posthandle(struct adapter *padapter, union recv_frame *prfr
 	prframe = decryptor(padapter, prframe);
 	if (!prframe) {
 		#ifdef DBG_RX_DROP_FRAME
-		DBG_871X("DBG_RX_DROP_FRAME %s decryptor: drop pkt\n", __func__);
 		#endif
 		ret = _FAIL;
 		goto _recv_data_drop;
@@ -2219,7 +2134,6 @@ static int recv_func_posthandle(struct adapter *padapter, union recv_frame *prfr
 	prframe = recvframe_chk_defrag(padapter, prframe);
 	if (!prframe)	{
 		#ifdef DBG_RX_DROP_FRAME
-		DBG_871X("DBG_RX_DROP_FRAME %s recvframe_chk_defrag: drop pkt\n", __func__);
 		#endif
 		goto _recv_data_drop;
 	}
@@ -2227,7 +2141,6 @@ static int recv_func_posthandle(struct adapter *padapter, union recv_frame *prfr
 	prframe = portctrl(padapter, prframe);
 	if (!prframe) {
 		#ifdef DBG_RX_DROP_FRAME
-		DBG_871X("DBG_RX_DROP_FRAME %s portctrl: drop pkt\n", __func__);
 		#endif
 		ret = _FAIL;
 		goto _recv_data_drop;
@@ -2238,7 +2151,6 @@ static int recv_func_posthandle(struct adapter *padapter, union recv_frame *prfr
 	ret = process_recv_indicatepkts(padapter, prframe);
 	if (ret != _SUCCESS) {
 		#ifdef DBG_RX_DROP_FRAME
-		DBG_871X("DBG_RX_DROP_FRAME %s process_recv_indicatepkts fail!\n", __func__);
 		#endif
 		rtw_free_recvframe(orig_prframe, pfree_recv_queue);/* free this recv_frame */
 		goto _recv_data_drop;
@@ -2268,8 +2180,7 @@ static int recv_func(struct adapter *padapter, union recv_frame *rframe)
 		}
 
 		if (cnt)
-			DBG_871X(FUNC_ADPT_FMT" dequeue %d from uc_swdec_pending_queue\n",
-				FUNC_ADPT_ARG(padapter), cnt);
+			{}
 	}
 
 	ret = recv_func_prehandle(padapter, rframe);
@@ -2397,17 +2308,6 @@ static void rtw_signal_stat_timer_hdl(struct timer_list *t)
 		recvpriv->signal_qual = tmp_q;
 
 		#if defined(DBG_RX_SIGNAL_DISPLAY_PROCESSING) && 1
-		DBG_871X(FUNC_ADPT_FMT" signal_strength:%3u, rssi:%3d, signal_qual:%3u"
-			", num_signal_strength:%u, num_signal_qual:%u"
-			", on_cur_ch_ms:%d"
-			"\n"
-			, FUNC_ADPT_ARG(adapter)
-			, recvpriv->signal_strength
-			, recvpriv->rssi
-			, recvpriv->signal_qual
-			, num_signal_strength, num_signal_qual
-			, rtw_get_on_cur_ch_time(adapter) ? jiffies_to_msecs(jiffies - rtw_get_on_cur_ch_time(adapter)) : 0
-		);
 		#endif
 	}
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 6c74c0444abc..eca1e0f0680c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -1588,11 +1588,6 @@ static signed int aes_decipher(u8 *key, uint	hdrlen,
 	/* compare the mic */
 	for (i = 0; i < 8; i++) {
 		if (pframe[hdrlen+8+plen-8+i] != message[hdrlen+8+plen-8+i]) {
-			DBG_871X("%s:mic check error mic[%d]: pframe(%x) != message(%x)\n",
-					__func__,
-					i,
-					pframe[hdrlen + 8 + plen - 8 + i],
-					message[hdrlen + 8 + plen - 8 + i]);
 			res = _FAIL;
 		}
 	}
@@ -1658,8 +1653,6 @@ u32 rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
 
 				prwskey = psecuritypriv->dot118021XGrpKey[prxattrib->key_index].skey;
 				if (psecuritypriv->dot118021XGrpKeyid != prxattrib->key_index) {
-					DBG_871X("not match packet_index =%d, install_index =%d\n"
-					, prxattrib->key_index, psecuritypriv->dot118021XGrpKeyid);
 					res = _FAIL;
 					goto exit;
 				}
@@ -1696,7 +1689,6 @@ u32 rtw_BIP_verify(struct adapter *padapter, u8 *precvframe)
 	BIP_AAD = rtw_zmalloc(ori_len);
 
 	if (BIP_AAD == NULL) {
-		DBG_871X("BIP AAD allocate fail\n");
 		return _FAIL;
 	}
 	/* PKT start */
@@ -1716,14 +1708,12 @@ u32 rtw_BIP_verify(struct adapter *padapter, u8 *precvframe)
 		temp_ipn = le64_to_cpu(le_tmp64);
 		/* BIP packet number should bigger than previous BIP packet */
 		if (temp_ipn <= pmlmeext->mgnt_80211w_IPN_rx) {
-			DBG_871X("replay BIP packet\n");
 			goto BIP_exit;
 		}
 		/* copy key index */
 		memcpy(&le_tmp, p+2, 2);
 		keyid = le16_to_cpu(le_tmp);
 		if (keyid != padapter->securitypriv.dot11wBIPKeyid) {
-			DBG_871X("BIP key index error!\n");
 			goto BIP_exit;
 		}
 		/* clear the MIC field of MME to zero */
@@ -1746,7 +1736,6 @@ u32 rtw_BIP_verify(struct adapter *padapter, u8 *precvframe)
 			pmlmeext->mgnt_80211w_IPN_rx = temp_ipn;
 			res = _SUCCESS;
 		} else {
-			DBG_871X("BIP MIC error!\n");
 		}
 
 	} else {
diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
index 7dcac4dd9de2..2afda4f7d58c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
@@ -107,7 +107,7 @@ inline int rtw_stainfo_offset(struct sta_priv *stapriv, struct sta_info *sta)
 	int offset = (((u8 *)sta) - stapriv->pstainfo_buf)/sizeof(struct sta_info);
 
 	if (!stainfo_offset_valid(offset))
-		DBG_871X("%s invalid offset(%d), out of range!!!", __func__, offset);
+		{}
 
 	return offset;
 }
@@ -115,7 +115,7 @@ inline int rtw_stainfo_offset(struct sta_priv *stapriv, struct sta_info *sta)
 inline struct sta_info *rtw_get_stainfo_by_offset(struct sta_priv *stapriv, int offset)
 {
 	if (!stainfo_offset_valid(offset))
-		DBG_871X("%s invalid offset(%d), out of range!!!", __func__, offset);
+		{}
 
 	return (struct sta_info *)(stapriv->pstainfo_buf + offset * sizeof(struct sta_info));
 }
@@ -251,8 +251,6 @@ struct	sta_info *rtw_alloc_stainfo(struct	sta_priv *pstapriv, u8 *hwaddr)
 
 			preorder_ctrl->indicate_seq = 0xffff;
 			#ifdef DBG_RX_SEQ
-			DBG_871X("DBG_RX_SEQ %s:%d IndicateSeq: %d\n", __func__, __LINE__,
-				preorder_ctrl->indicate_seq);
 			#endif
 			preorder_ctrl->wend_b = 0xffff;
 			/* preorder_ctrl->wsize_b = (NR_RECVBUFF-2); */
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index f6a7993005ab..bb864d3bea0d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -312,7 +312,6 @@ inline void rtw_set_oper_ch(struct adapter *adapter, u8 ch)
 			cnt += scnprintf(msg+cnt, len-cnt, "]");
 		}
 
-		DBG_871X(FUNC_ADPT_FMT" %s\n", FUNC_ADPT_ARG(adapter), msg);
 #endif /* DBG_CH_SWITCH */
 	}
 
@@ -381,7 +380,7 @@ void set_channel_bwmode(struct adapter *padapter, unsigned char channel, unsigne
 	u8 center_ch, chnl_offset80 = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
 
 	if (padapter->bNotifyChannelChange)
-		DBG_871X("[%s] ch = %d, offset = %d, bwmode = %d\n", __func__, channel, channel_offset, bwmode);
+		{}
 
 	center_ch = rtw_get_center_ch(channel, bwmode, channel_offset);
 
@@ -628,11 +627,9 @@ static s16 _rtw_camid_search(struct adapter *adapter, u8 *addr, s16 kid)
 	}
 
 	if (addr)
-		DBG_871X(FUNC_ADPT_FMT" addr:%pM kid:%d, return cam_id:%d\n"
-			 , FUNC_ADPT_ARG(adapter), MAC_ARG(addr), kid, cam_id);
+		{}
 	else
-		DBG_871X(FUNC_ADPT_FMT" addr:%p kid:%d, return cam_id:%d\n"
-			 , FUNC_ADPT_ARG(adapter), addr, kid, cam_id);
+		{}
 
 	return cam_id;
 }
@@ -873,8 +870,6 @@ void WMMOnAssocRsp(struct adapter *padapter)
 				edca[XMIT_VO_QUEUE] = acParm;
 				break;
 			}
-
-			DBG_871X("WMM(%x): %x, %x\n", ACI, ACM, acParm);
 		}
 
 		if (padapter->registrypriv.acm_method == 1)
@@ -916,7 +911,6 @@ void WMMOnAssocRsp(struct adapter *padapter)
 
 		for (i = 0; i < 4; i++) {
 			pxmitpriv->wmm_para_seq[i] = inx[i];
-			DBG_871X("wmm_para_seq(%d): %d\n", i, pxmitpriv->wmm_para_seq[i]);
 		}
 	}
 }
@@ -1075,21 +1069,18 @@ void HT_caps_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 		/*  Config STBC setting */
 		if (TEST_FLAG(phtpriv->stbc_cap, STBC_HT_ENABLE_TX) && GET_HT_CAPABILITY_ELE_TX_STBC(pIE->data)) {
 			SET_FLAG(cur_stbc_cap, STBC_HT_ENABLE_TX);
-			DBG_871X("Enable HT Tx STBC !\n");
 		}
 		phtpriv->stbc_cap = cur_stbc_cap;
 	} else {
 		/*  Config LDPC Coding Capability */
 		if (TEST_FLAG(phtpriv->ldpc_cap, LDPC_HT_ENABLE_TX) && GET_HT_CAPABILITY_ELE_LDPC_CAP(pIE->data)) {
 			SET_FLAG(cur_ldpc_cap, (LDPC_HT_ENABLE_TX | LDPC_HT_CAP_TX));
-			DBG_871X("Enable HT Tx LDPC!\n");
 		}
 		phtpriv->ldpc_cap = cur_ldpc_cap;
 
 		/*  Config STBC setting */
 		if (TEST_FLAG(phtpriv->stbc_cap, STBC_HT_ENABLE_TX) && GET_HT_CAPABILITY_ELE_RX_STBC(pIE->data)) {
 			SET_FLAG(cur_stbc_cap, (STBC_HT_ENABLE_TX | STBC_HT_CAP_TX));
-			DBG_871X("Enable HT Tx STBC!\n");
 		}
 		phtpriv->stbc_cap = cur_stbc_cap;
 	}
@@ -1239,19 +1230,15 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	len = packet_len - sizeof(struct ieee80211_hdr_3addr);
 
 	if (len > MAX_IE_SZ) {
-		DBG_871X("%s IE too long for survey event\n", __func__);
 		return _FAIL;
 	}
 
 	if (memcmp(cur_network->network.MacAddress, pbssid, 6)) {
-		DBG_871X("Oops: rtw_check_network_encrypt linked but recv other bssid bcn %pM %pM\n",
-				MAC_ARG(pbssid), MAC_ARG(cur_network->network.MacAddress));
 		return true;
 	}
 
 	bssid = rtw_zmalloc(sizeof(struct wlan_bssid_ex));
 	if (!bssid) {
-		DBG_871X("%s rtw_zmalloc fail !!!\n", __func__);
 		return true;
 	}
 
@@ -1290,11 +1277,6 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	}
 	if (ht_cap_info != cur_network->BcnInfo.ht_cap_info ||
 		((ht_info_infos_0&0x03) != (cur_network->BcnInfo.ht_info_infos_0&0x03))) {
-			DBG_871X("%s bcn now: ht_cap_info:%x ht_info_infos_0:%x\n", __func__,
-							ht_cap_info, ht_info_infos_0);
-			DBG_871X("%s bcn link: ht_cap_info:%x ht_info_infos_0:%x\n", __func__,
-							cur_network->BcnInfo.ht_cap_info, cur_network->BcnInfo.ht_info_infos_0);
-			DBG_871X("%s bw mode change\n", __func__);
 			{
 				/* bcn_info_update */
 				cur_network->BcnInfo.ht_cap_info = ht_cap_info;
@@ -1318,8 +1300,6 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 			}
 	}
 	if (bcn_channel != Adapter->mlmeextpriv.cur_channel) {
-			DBG_871X("%s beacon channel:%d cur channel:%d disconnect\n", __func__,
-						   bcn_channel, Adapter->mlmeextpriv.cur_channel);
 			goto _mismatch;
 	}
 
@@ -1337,7 +1317,6 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	if (memcmp(bssid->Ssid.Ssid, cur_network->network.Ssid.Ssid, 32) ||
 			bssid->Ssid.SsidLength != cur_network->network.Ssid.SsidLength) {
 		if (bssid->Ssid.Ssid[0] != '\0' && bssid->Ssid.SsidLength != 0) { /* not hidden ssid */
-			DBG_871X("%s(), SSID is not match\n", __func__);
 			goto _mismatch;
 		}
 	}
@@ -1351,7 +1330,6 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 		bssid->Privacy = 0;
 
 	if (cur_network->network.Privacy != bssid->Privacy) {
-		DBG_871X("%s(), privacy is not match\n", __func__);
 		goto _mismatch;
 	}
 
@@ -1367,7 +1345,6 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	}
 
 	if (cur_network->BcnInfo.encryp_protocol != encryp_protocol) {
-		DBG_871X("%s(): enctyp is not match\n", __func__);
 		goto _mismatch;
 	}
 
@@ -1386,14 +1363,10 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 		}
 
 		if (pairwise_cipher != cur_network->BcnInfo.pairwise_cipher || group_cipher != cur_network->BcnInfo.group_cipher) {
-			DBG_871X("%s pairwise_cipher(%x:%x) or group_cipher(%x:%x) is not match\n", __func__,
-					pairwise_cipher, cur_network->BcnInfo.pairwise_cipher,
-					group_cipher, cur_network->BcnInfo.group_cipher);
 			goto _mismatch;
 		}
 
 		if (is_8021x != cur_network->BcnInfo.is_8021x) {
-			DBG_871X("%s authentication is not match\n", __func__);
 			goto _mismatch;
 		}
 	}
@@ -1408,12 +1381,9 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 		pmlmepriv->timeBcnInfoChkStart = jiffies;
 
 	pmlmepriv->NumOfBcnInfoChkFail++;
-	DBG_871X("%s by %s - NumOfChkFail = %d (SeqNum of this Beacon frame = %d).\n", __func__, ADPT_ARG(Adapter), pmlmepriv->NumOfBcnInfoChkFail, GetSequence(pframe));
 
 	if ((pmlmepriv->timeBcnInfoChkStart != 0) && (jiffies_to_msecs(jiffies - pmlmepriv->timeBcnInfoChkStart) <= DISCONNECT_BY_CHK_BCN_FAIL_OBSERV_PERIOD_IN_MS)
 		&& (pmlmepriv->NumOfBcnInfoChkFail >= DISCONNECT_BY_CHK_BCN_FAIL_THRESHOLD)) {
-		DBG_871X("%s by %s - NumOfChkFail = %d >= threshold : %d (in %d ms), return FAIL.\n", __func__, ADPT_ARG(Adapter), pmlmepriv->NumOfBcnInfoChkFail,
-			DISCONNECT_BY_CHK_BCN_FAIL_THRESHOLD, jiffies_to_msecs(jiffies - pmlmepriv->timeBcnInfoChkStart));
 		pmlmepriv->timeBcnInfoChkStart = 0;
 		pmlmepriv->NumOfBcnInfoChkFail = 0;
 		return _FAIL;
@@ -1551,21 +1521,16 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
 		switch (pIE->ElementID) {
 		case WLAN_EID_VENDOR_SPECIFIC:
 			if ((!memcmp(pIE->data, ARTHEROS_OUI1, 3)) || (!memcmp(pIE->data, ARTHEROS_OUI2, 3))) {
-				DBG_871X("link to Artheros AP\n");
 				return HT_IOT_PEER_ATHEROS;
 			} else if ((!memcmp(pIE->data, BROADCOM_OUI1, 3)) ||
 				   (!memcmp(pIE->data, BROADCOM_OUI2, 3)) ||
 				   (!memcmp(pIE->data, BROADCOM_OUI3, 3))) {
-				DBG_871X("link to Broadcom AP\n");
 				return HT_IOT_PEER_BROADCOM;
 			} else if (!memcmp(pIE->data, MARVELL_OUI, 3)) {
-				DBG_871X("link to Marvell AP\n");
 				return HT_IOT_PEER_MARVELL;
 			} else if (!memcmp(pIE->data, RALINK_OUI, 3)) {
-				DBG_871X("link to Ralink AP\n");
 				return HT_IOT_PEER_RALINK;
 			} else if (!memcmp(pIE->data, CISCO_OUI, 3)) {
-				DBG_871X("link to Cisco AP\n");
 				return HT_IOT_PEER_CISCO;
 			} else if (!memcmp(pIE->data, REALTEK_OUI, 3)) {
 				u32 Vender = HT_IOT_PEER_REALTEK;
@@ -1584,19 +1549,15 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
 					if (pIE->data[4] == 2) {
 						if (pIE->data[6] & RT_HT_CAP_USE_JAGUAR_BCUT) {
 							Vender = HT_IOT_PEER_REALTEK_JAGUAR_BCUTAP;
-							DBG_871X("link to Realtek JAGUAR_BCUTAP\n");
 						}
 						if (pIE->data[6] & RT_HT_CAP_USE_JAGUAR_CCUT) {
 							Vender = HT_IOT_PEER_REALTEK_JAGUAR_CCUTAP;
-							DBG_871X("link to Realtek JAGUAR_CCUTAP\n");
 						}
 					}
 				}
 
-				DBG_871X("link to Realtek AP\n");
 				return Vender;
 			} else if (!memcmp(pIE->data, AIRGOCAP_OUI, 3)) {
-				DBG_871X("link to Airgo Cap\n");
 				return HT_IOT_PEER_AIRGO;
 			} else {
 				break;
@@ -1609,7 +1570,6 @@ unsigned char check_assoc_AP(u8 *pframe, uint len)
 		i += (pIE->Length + 2);
 	}
 
-	DBG_871X("link to new AP\n");
 	return HT_IOT_PEER_UNKNOWN;
 }
 
@@ -1866,25 +1826,18 @@ void adaptive_early_32k(struct mlme_ext_priv *pmlmeext, u8 *pframe, uint len)
 		DrvBcnEarly = 0xff;
 		DrvBcnTimeOut = 0xff;
 
-		DBG_871X("%s(): bcn_cnt = %d\n", __func__, pmlmeext->bcn_cnt);
-
 		for (i = 0; i < 9; i++) {
 			pmlmeext->bcn_delay_ratio[i] = (pmlmeext->bcn_delay_cnt[i] * 100) / pmlmeext->bcn_cnt;
 
-			DBG_871X("%s():bcn_delay_cnt[%d]=%d,  bcn_delay_ratio[%d]=%d\n", __func__, i,
-				pmlmeext->bcn_delay_cnt[i], i, pmlmeext->bcn_delay_ratio[i]);
-
 			ratio_20_delay += pmlmeext->bcn_delay_ratio[i];
 			ratio_80_delay += pmlmeext->bcn_delay_ratio[i];
 
 			if (ratio_20_delay > 20 && DrvBcnEarly == 0xff) {
 				DrvBcnEarly = i;
-				DBG_871X("%s(): DrvBcnEarly = %d\n", __func__, DrvBcnEarly);
 			}
 
 			if (ratio_80_delay > 80 && DrvBcnTimeOut == 0xff) {
 				DrvBcnTimeOut = i;
-				DBG_871X("%s(): DrvBcnTimeOut = %d\n", __func__, DrvBcnTimeOut);
 			}
 
 			/* reset adaptive_early_32k cnt */
@@ -1924,10 +1877,8 @@ void rtw_alloc_macid(struct adapter *padapter, struct sta_info *psta)
 
 	if (i > (NUM_STA-1)) {
 		psta->mac_id = NUM_STA;
-		DBG_871X("  no room for more MACIDs\n");
 	} else {
 		psta->mac_id = i;
-		DBG_871X("%s = %d\n", __func__, psta->mac_id);
 	}
 }
 
@@ -1945,7 +1896,6 @@ void rtw_release_macid(struct adapter *padapter, struct sta_info *psta)
 	spin_lock_bh(&pdvobj->lock);
 	if (psta->mac_id < NUM_STA && psta->mac_id != 1) {
 		if (pdvobj->macid[psta->mac_id] == true) {
-			DBG_871X("%s = %d\n", __func__, psta->mac_id);
 			pdvobj->macid[psta->mac_id] = false;
 			psta->mac_id = NUM_STA;
 		}
diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 957d7e3a4d4a..62429571151c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -481,7 +481,6 @@ static s32 update_attrib_sec_info(struct adapter *padapter, struct pkt_attrib *p
 
 		if ((pattrib->ether_type != 0x888e) && (check_fwstate(pmlmepriv, WIFI_MP_STATE) == false)) {
 			#ifdef DBG_TX_DROP_FRAME
-			DBG_871X("DBG_TX_DROP_FRAME %s psta->ieee8021x_blocked == true,  pattrib->ether_type(%04x) != 0x888e\n", __func__, pattrib->ether_type);
 			#endif
 			res = _FAIL;
 			goto exit;
@@ -525,7 +524,6 @@ static s32 update_attrib_sec_info(struct adapter *padapter, struct pkt_attrib *p
 
 		if (psecuritypriv->busetkipkey == _FAIL) {
 			#ifdef DBG_TX_DROP_FRAME
-			DBG_871X("DBG_TX_DROP_FRAME %s psecuritypriv->busetkipkey(%d) == _FAIL drop packet\n", __func__, psecuritypriv->busetkipkey);
 			#endif
 			res = _FAIL;
 			goto exit;
@@ -594,7 +592,6 @@ u8 qos_acm(u8 acm_mask, u8 priority)
 			priority = 5;
 		break;
 	default:
-		DBG_871X("qos_acm(): invalid pattrib->priority: %d!!!\n", priority);
 		break;
 	}
 
@@ -704,7 +701,6 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 		psta = rtw_get_stainfo(pstapriv, pattrib->ra);
 		if (!psta)	{ /*  if we cannot get psta => drop the pkt */
 			#ifdef DBG_TX_DROP_FRAME
-			DBG_871X("DBG_TX_DROP_FRAME %s get sta_info fail, ra:%pM\n", __func__, MAC_ARG(pattrib->ra));
 			#endif
 			res = _FAIL;
 			goto exit;
@@ -717,14 +713,12 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 	if (!psta) {
 		/*  if we cannot get psta => drop the pkt */
 		#ifdef DBG_TX_DROP_FRAME
-		DBG_871X("DBG_TX_DROP_FRAME %s get sta_info fail, ra:%pM\n", __func__, MAC_ARG(pattrib->ra));
 		#endif
 		res = _FAIL;
 		goto exit;
 	}
 
 	if (!(psta->state & _FW_LINKED)) {
-		DBG_871X("%s, psta(%pM)->state(0x%x) != _FW_LINKED\n", __func__, MAC_ARG(psta->hwaddr), psta->state);
 		return _FAIL;
 	}
 
@@ -946,17 +940,14 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 
 			psta = rtw_get_stainfo(&padapter->stapriv, pattrib->ra);
 			if (pattrib->psta != psta) {
-				DBG_871X("%s, pattrib->psta(%p) != psta(%p)\n", __func__, pattrib->psta, psta);
 				return _FAIL;
 			}
 
 			if (!psta) {
-				DBG_871X("%s, psta ==NUL\n", __func__);
 				return _FAIL;
 			}
 
 			if (!(psta->state & _FW_LINKED)) {
-				DBG_871X("%s, psta->state(0x%x) != _FW_LINKED\n", __func__, psta->state);
 				return _FAIL;
 			}
 
@@ -1193,7 +1184,6 @@ s32 rtw_mgmt_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, s
 
 	/* IGTK key is not install, it may not support 802.11w */
 	if (padapter->securitypriv.binstallBIPkey != true) {
-		DBG_871X("no instll BIP key\n");
 		goto xmitframe_coalesce_success;
 	}
 	/* station mode doesn't need TX BIP, just ready the code */
@@ -1250,12 +1240,10 @@ s32 rtw_mgmt_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, s
 				psta = rtw_get_stainfo(&padapter->stapriv, pattrib->ra);
 
 			if (!psta) {
-				DBG_871X("%s, psta ==NUL\n", __func__);
 				goto xmitframe_coalesce_fail;
 			}
 
 			if (!(psta->state & _FW_LINKED) || !pxmitframe->buf_addr) {
-				DBG_871X("%s, not _FW_LINKED or addr null\n", __func__);
 				goto xmitframe_coalesce_fail;
 			}
 
@@ -1435,11 +1423,9 @@ static struct xmit_buf *__rtw_alloc_cmd_xmitbuf(struct xmit_priv *pxmitpriv,
 		pxmitbuf->pg_num = 0;
 
 		if (pxmitbuf->sctx) {
-			DBG_871X("%s pxmitbuf->sctx is not NULL\n", __func__);
 			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
 		}
 	} else {
-		DBG_871X("%s fail, no xmitbuf available !!!\n", __func__);
 	}
 
 	return pxmitbuf;
@@ -1453,13 +1439,11 @@ struct xmit_frame *__rtw_alloc_cmdxmitframe(struct xmit_priv *pxmitpriv,
 
 	pcmdframe = rtw_alloc_xmitframe(pxmitpriv);
 	if (!pcmdframe) {
-		DBG_871X("%s, alloc xmitframe fail\n", __func__);
 		return NULL;
 	}
 
 	pxmitbuf = __rtw_alloc_cmd_xmitbuf(pxmitpriv, buf_type);
 	if (!pxmitbuf) {
-		DBG_871X("%s, alloc xmitbuf fail\n", __func__);
 		rtw_free_xmitframe(pxmitpriv, pcmdframe);
 		return NULL;
 	}
@@ -1499,7 +1483,6 @@ struct xmit_buf *rtw_alloc_xmitbuf_ext(struct xmit_priv *pxmitpriv)
 	if (pxmitbuf) {
 		pxmitpriv->free_xmit_extbuf_cnt--;
 		#ifdef DBG_XMIT_BUF_EXT
-		DBG_871X("DBG_XMIT_BUF_EXT ALLOC no =%d,  free_xmit_extbuf_cnt =%d\n", pxmitbuf->no, pxmitpriv->free_xmit_extbuf_cnt);
 		#endif
 
 		pxmitbuf->priv_data = NULL;
@@ -1509,7 +1492,6 @@ struct xmit_buf *rtw_alloc_xmitbuf_ext(struct xmit_priv *pxmitpriv)
 		pxmitbuf->agg_num = 1;
 
 		if (pxmitbuf->sctx) {
-			DBG_871X("%s pxmitbuf->sctx is not NULL\n", __func__);
 			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
 		}
 	}
@@ -1534,7 +1516,6 @@ s32 rtw_free_xmitbuf_ext(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
 	list_add_tail(&pxmitbuf->list, get_list_head(pfree_queue));
 	pxmitpriv->free_xmit_extbuf_cnt++;
 	#ifdef DBG_XMIT_BUF_EXT
-	DBG_871X("DBG_XMIT_BUF_EXT FREE no =%d, free_xmit_extbuf_cnt =%d\n", pxmitbuf->no, pxmitpriv->free_xmit_extbuf_cnt);
 	#endif
 
 	spin_unlock_irqrestore(&pfree_queue->lock, irqL);
@@ -1566,7 +1547,6 @@ struct xmit_buf *rtw_alloc_xmitbuf(struct xmit_priv *pxmitpriv)
 	if (pxmitbuf) {
 		pxmitpriv->free_xmitbuf_cnt--;
 		#ifdef DBG_XMIT_BUF
-		DBG_871X("DBG_XMIT_BUF ALLOC no =%d,  free_xmitbuf_cnt =%d\n", pxmitbuf->no, pxmitpriv->free_xmitbuf_cnt);
 		#endif
 
 		pxmitbuf->priv_data = NULL;
@@ -1577,13 +1557,12 @@ struct xmit_buf *rtw_alloc_xmitbuf(struct xmit_priv *pxmitpriv)
 		pxmitbuf->pg_num = 0;
 
 		if (pxmitbuf->sctx) {
-			DBG_871X("%s pxmitbuf->sctx is not NULL\n", __func__);
 			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
 		}
 	}
 	#ifdef DBG_XMIT_BUF
 	else
-		DBG_871X("DBG_XMIT_BUF rtw_alloc_xmitbuf return NULL\n");
+		{}
 	#endif
 
 	spin_unlock_irqrestore(&pfree_xmitbuf_queue->lock, irqL);
@@ -1600,7 +1579,6 @@ s32 rtw_free_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
 		return _FAIL;
 
 	if (pxmitbuf->sctx) {
-		DBG_871X("%s pxmitbuf->sctx is not NULL\n", __func__);
 		rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_FREE);
 	}
 
@@ -1617,7 +1595,6 @@ s32 rtw_free_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
 
 		pxmitpriv->free_xmitbuf_cnt++;
 		#ifdef DBG_XMIT_BUF
-		DBG_871X("DBG_XMIT_BUF FREE no =%d, free_xmitbuf_cnt =%d\n", pxmitbuf->no, pxmitpriv->free_xmitbuf_cnt);
 		#endif
 		spin_unlock_irqrestore(&pfree_xmitbuf_queue->lock, irqL);
 	}
@@ -1732,8 +1709,6 @@ struct xmit_frame *rtw_alloc_xmitframe_once(struct xmit_priv *pxmitpriv)
 
 	rtw_init_xmitframe(pxframe);
 
-	DBG_871X("################## %s ##################\n", __func__);
-
 exit:
 	return pxframe;
 }
@@ -1753,7 +1728,6 @@ s32 rtw_free_xmitframe(struct xmit_priv *pxmitpriv, struct xmit_frame *pxmitfram
 	}
 
 	if (pxmitframe->alloc_addr) {
-		DBG_871X("################## %s with alloc_addr ##################\n", __func__);
 		kfree(pxmitframe->alloc_addr);
 		goto check_pkt_complete;
 	}
@@ -1862,7 +1836,6 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 
 	psta = rtw_get_stainfo(&padapter->stapriv, pattrib->ra);
 	if (pattrib->psta != psta) {
-		DBG_871X("%s, pattrib->psta(%p) != psta(%p)\n", __func__, pattrib->psta, psta);
 		return _FAIL;
 	}
 
@@ -1873,7 +1846,6 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 	}
 
 	if (!(psta->state & _FW_LINKED)) {
-		DBG_871X("%s, psta->state(0x%x) != _FW_LINKED\n", __func__, psta->state);
 		return _FAIL;
 	}
 
@@ -2017,7 +1989,7 @@ s32 rtw_xmit(struct adapter *padapter, struct sk_buff **ppkt)
 
 	if (jiffies_to_msecs(jiffies - start) > 2000) {
 		if (drop_cnt)
-			DBG_871X("DBG_TX_DROP_FRAME %s no more pxmitframe, drop_cnt:%u\n", __func__, drop_cnt);
+			{}
 		start = jiffies;
 		drop_cnt = 0;
 	}
@@ -2031,7 +2003,6 @@ s32 rtw_xmit(struct adapter *padapter, struct sk_buff **ppkt)
 
 	if (res == _FAIL) {
 		#ifdef DBG_TX_DROP_FRAME
-		DBG_871X("DBG_TX_DROP_FRAME %s update attrib fail\n", __func__);
 		#endif
 		rtw_free_xmitframe(pxmitpriv, pxmitframe);
 		return -1;
@@ -2071,8 +2042,6 @@ inline bool xmitframe_hiq_filter(struct xmit_frame *xmitframe)
 		    attrib->ether_type == 0x888e ||
 		    attrib->dhcp_pkt
 		) {
-			DBG_871X(FUNC_ADPT_FMT" ether_type:0x%04x%s\n", FUNC_ADPT_ARG(xmitframe->padapter)
-				, attrib->ether_type, attrib->dhcp_pkt?" DHCP":"");
 			allow = true;
 		}
 	} else if (registry->hiq_filter == RTW_HIQ_FILTER_ALLOW_ALL)
@@ -2098,17 +2067,14 @@ signed int xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct x
 		return ret;
 	psta = rtw_get_stainfo(&padapter->stapriv, pattrib->ra);
 	if (pattrib->psta != psta) {
-		DBG_871X("%s, pattrib->psta(%p) != psta(%p)\n", __func__, pattrib->psta, psta);
 		return false;
 	}
 
 	if (!psta) {
-		DBG_871X("%s, psta ==NUL\n", __func__);
 		return false;
 	}
 
 	if (!(psta->state & _FW_LINKED)) {
-		DBG_871X("%s, psta->state(0x%x) != _FW_LINKED\n", __func__, psta->state);
 		return false;
 	}
 
@@ -2352,7 +2318,6 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
 			psta->state ^= WIFI_SLEEP_STATE;
 
 		if (psta->state & WIFI_STA_ALIVE_CHK_STATE) {
-			DBG_871X("%s alive check\n", __func__);
 			psta->expire_to = pstapriv->expire_to;
 			psta->state ^= WIFI_STA_ALIVE_CHK_STATE;
 		}
@@ -2615,7 +2580,6 @@ int rtw_sctx_wait(struct submit_ctx *sctx, const char *msg)
 	if (!wait_for_completion_timeout(&sctx->done, expire)) {
 		/* timeout, do something?? */
 		status = RTW_SCTX_DONE_TIMEOUT;
-		DBG_871X("%s timeout: %s\n", __func__, msg);
 	} else {
 		status = sctx->status;
 	}
@@ -2645,7 +2609,7 @@ void rtw_sctx_done_err(struct submit_ctx **sctx, int status)
 {
 	if (*sctx) {
 		if (rtw_sctx_chk_warning_status(status))
-			DBG_871X("%s status:%d\n", __func__, status);
+			{}
 		(*sctx)->status = status;
 		complete(&((*sctx)->done));
 		*sctx = NULL;
@@ -2675,5 +2639,5 @@ void rtw_ack_tx_done(struct xmit_priv *pxmitpriv, int status)
 	if (pxmitpriv->ack_tx)
 		rtw_sctx_done_err(&pack_tx_ops, status);
 	else
-		DBG_871X("%s ack_tx not set\n", __func__);
+		{}
 }
diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
index c36513812d9d..c70b9cf2da32 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
@@ -1839,11 +1839,6 @@ void PHY_IQCalibrate_8723B(
 			offset = pRFCalibrateInfo->TxIQC_8723B[path][i][0];
 			data = pRFCalibrateInfo->TxIQC_8723B[path][i][1];
 			if ((offset == 0) || (data == 0)) {
-				DBG_871X(
-					"%s =>path:%s Restore TX IQK result failed\n",
-					__func__,
-					(path == ODM_RF_PATH_A)?"A":"B"
-				);
 				bResult = FAIL;
 				break;
 			}
@@ -1855,11 +1850,6 @@ void PHY_IQCalibrate_8723B(
 			offset = pRFCalibrateInfo->RxIQC_8723B[path][i][0];
 			data = pRFCalibrateInfo->RxIQC_8723B[path][i][1];
 			if ((offset == 0) || (data == 0)) {
-				DBG_871X(
-					"%s =>path:%s  Restore RX IQK result failed\n",
-					__func__,
-					(path == ODM_RF_PATH_A)?"A":"B"
-				);
 				bResult = FAIL;
 				break;
 			}
@@ -1867,7 +1857,6 @@ void PHY_IQCalibrate_8723B(
 		}
 
 		if (pDM_Odm->RFCalibrateInfo.TxLOK[ODM_RF_PATH_A] == 0) {
-			DBG_871X("%s => Restore Path-A TxLOK result failed\n", __func__);
 			bResult = FAIL;
 		} else {
 			PHY_SetRFReg(pDM_Odm->Adapter, ODM_RF_PATH_A, RF_TXM_IDAC, bRFRegOffsetMask, pDM_Odm->RFCalibrateInfo.TxLOK[ODM_RF_PATH_A]);
diff --git a/drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c b/drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c
index b1f271c65c3e..1d2c828cafe8 100644
--- a/drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c
+++ b/drivers/staging/rtl8723bs/hal/HalPwrSeqCmd.c
@@ -117,11 +117,6 @@ u8 HalPwrSeqCmdParsing(
 						udelay(10);
 
 					if (pollingCount++ > maxPollingCnt) {
-						DBG_871X(
-							"Fail to polling Offset[%#x]=%02x\n",
-							offset,
-							value
-						);
 						return false;
 					}
 				} while (!bPollingBit);
diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index e74d7e21372d..77f7ffb562a0 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -84,8 +84,6 @@ void dump_chip_info(struct hal_version	ChipVersion)
 				"UNKNOWN_RFTYPE(%d)_", ChipVersion.RFType);
 
 	cnt += scnprintf(buf + cnt, sizeof(buf) - cnt, "RomVer(%d)\n", ChipVersion.ROMVer);
-
-	DBG_871X("%s", buf);
 }
 
 
@@ -155,11 +153,9 @@ bool HAL_IsLegalChannel(struct adapter *Adapter, u32 Channel)
 	if ((Channel <= 14) && (Channel >= 1)) {
 		if (IsSupported24G(Adapter->registrypriv.wireless_mode) == false) {
 			bLegalChannel = false;
-			DBG_871X("(Channel <= 14) && (Channel >= 1) but wireless_mode do not support 2.4G\n");
 		}
 	} else {
 		bLegalChannel = false;
-		DBG_871X("Channel is Invalid !!!\n");
 	}
 
 	return bLegalChannel;
@@ -688,7 +684,6 @@ u8 HwRateToMRate(u8 rate)
 		break;
 
 	default:
-		DBG_871X("HwRateToMRate(): Non supported Rate [%x]!!!\n", rate);
 		break;
 	}
 
@@ -927,15 +922,6 @@ s32 c2h_evt_read_88xx(struct adapter *adapter, u8 *buf)
 	print_hex_dump_debug(DRIVER_PREFIX ": c2h_evt_read(): ", DUMP_PREFIX_NONE,
 			     16, 1, &c2h_evt, sizeof(c2h_evt), false);
 
-	DBG_871X(
-		"%s id:%u, len:%u, seq:%u, trigger:0x%02x\n",
-		__func__,
-		c2h_evt->id,
-		c2h_evt->plen,
-		c2h_evt->seq,
-		trigger
-	);
-
 	/* Read the content */
 	for (i = 0; i < c2h_evt->plen; i++)
 		c2h_evt->payload[i] = rtw_read8(adapter, REG_C2HEVT_MSG_NORMAL + 2 + i);
@@ -1124,14 +1110,8 @@ u8 SetHalDefVar(
 			odm->DebugComponents &= ~(ODM_COMP_DIG | ODM_COMP_FA_CNT);
 		break;
 	case HAL_DEF_DBG_RX_INFO_DUMP:
-		DBG_871X("============ Rx Info dump ===================\n");
-		DBG_871X("bLinked = %d, RSSI_Min = %d(%%)\n",
-			odm->bLinked, odm->RSSI_Min);
 
 		if (odm->bLinked) {
-			DBG_871X("RxRate = %s, RSSI_A = %d(%%), RSSI_B = %d(%%)\n",
-				HDATA_RATE(odm->RxRate), odm->RSSI_A, odm->RSSI_B);
-
 			#ifdef DBG_RX_SIGNAL_DISPLAY_RAW_DATA
 			rtw_dump_raw_rssi_info(adapter);
 			#endif
@@ -1356,8 +1336,6 @@ bool GetHexValueFromString(char *szStr, u32 *pu4bVal, u32 *pu4bMove)
 
 	/*  Check input parameter. */
 	if (!szStr || !pu4bVal || !pu4bMove) {
-		DBG_871X("GetHexValueFromString(): Invalid input arguments! szStr: %p, pu4bVal: %p, pu4bMove: %p\n",
-			 szStr, pu4bVal, pu4bMove);
 		return false;
 	}
 
@@ -1533,8 +1511,6 @@ void linked_info_dump(struct adapter *padapter, u8 benable)
 	if (padapter->bLinkInfoDump == benable)
 		return;
 
-	DBG_871X("%s %s\n", __func__, (benable) ? "enable" : "disable");
-
 	if (benable) {
 		pwrctrlpriv->org_power_mgnt = pwrctrlpriv->power_mgnt;/* keep org value */
 		rtw_pm_set_lps(padapter, PS_MODE_ACTIVE);
@@ -1592,9 +1568,6 @@ void rtw_dump_raw_rssi_info(struct adapter *padapter)
 	u8 isCCKrate, rf_path;
 	struct hal_com_data *pHalData =  GET_HAL_DATA(padapter);
 	struct rx_raw_rssi *psample_pkt_rssi = &padapter->recvpriv.raw_rssi_info;
-	DBG_871X("============ RAW Rx Info dump ===================\n");
-	DBG_871X("RxRate = %s, PWDBALL = %d(%%), rx_pwr_all = %d(dBm)\n",
-			HDATA_RATE(psample_pkt_rssi->data_rate), psample_pkt_rssi->pwdball, psample_pkt_rssi->pwr_all);
 
 	isCCKrate = psample_pkt_rssi->data_rate <= DESC_RATE11M;
 
@@ -1602,9 +1575,6 @@ void rtw_dump_raw_rssi_info(struct adapter *padapter)
 		psample_pkt_rssi->mimo_signal_strength[0] = psample_pkt_rssi->pwdball;
 
 	for (rf_path = 0; rf_path < pHalData->NumTotalRFPath; rf_path++) {
-		DBG_871X("RF_PATH_%d =>signal_strength:%d(%%), signal_quality:%d(%%)"
-			, rf_path, psample_pkt_rssi->mimo_signal_strength[rf_path], psample_pkt_rssi->mimo_signal_quality[rf_path]);
-
 		if (!isCCKrate) {
 			printk(", rx_ofdm_pwr:%d(dBm), rx_ofdm_snr:%d(dB)\n",
 			psample_pkt_rssi->ofdm_pwr[rf_path], psample_pkt_rssi->ofdm_snr[rf_path]);
@@ -1662,31 +1632,25 @@ void rtw_bb_rf_gain_offset(struct adapter *padapter)
 	/* DBG_871X("+%s value: 0x%02x+\n", __func__, value); */
 
 	if (value & BIT4) {
-		DBG_871X("Offset RF Gain.\n");
-		DBG_871X("Offset RF Gain.  padapter->eeprompriv.EEPROMRFGainVal = 0x%x\n", padapter->eeprompriv.EEPROMRFGainVal);
 		if (padapter->eeprompriv.EEPROMRFGainVal != 0xff) {
 			res = rtw_hal_read_rfreg(padapter, RF_PATH_A, 0x7f, 0xffffffff);
 			res &= 0xfff87fff;
-			DBG_871X("Offset RF Gain. before reg 0x7f = 0x%08x\n", res);
 			/* res &= 0xfff87fff; */
 			for (i = 0; i < ARRAY_SIZE(Array_kfreemap); i += 2) {
 				v1 = Array[i];
 				v2 = Array[i+1];
 				if (v1 == padapter->eeprompriv.EEPROMRFGainVal) {
-					DBG_871X("Offset RF Gain. got v1 = 0x%x , v2 = 0x%x\n", v1, v2);
 					target = v2;
 					break;
 				}
 			}
-			DBG_871X("padapter->eeprompriv.EEPROMRFGainVal = 0x%x , Gain offset Target Value = 0x%x\n", padapter->eeprompriv.EEPROMRFGainVal, target);
 			PHY_SetRFReg(padapter, RF_PATH_A, REG_RF_BB_GAIN_OFFSET, BIT18|BIT17|BIT16|BIT15, target);
 
 			/* res |= (padapter->eeprompriv.EEPROMRFGainVal & 0x0f)<< 15; */
 			/* rtw_hal_write_rfreg(padapter, RF_PATH_A, REG_RF_BB_GAIN_OFFSET, RF_GAIN_OFFSET_MASK, res); */
 			res = rtw_hal_read_rfreg(padapter, RF_PATH_A, 0x7f, 0xffffffff);
-			DBG_871X("Offset RF Gain. After reg 0x7f = 0x%08x\n", res);
 		} else
-			DBG_871X("Offset RF Gain.  padapter->eeprompriv.EEPROMRFGainVal = 0x%x	!= 0xff, didn't run Kfree\n", padapter->eeprompriv.EEPROMRFGainVal);
+			{}
 	} else
-		DBG_871X("Using the default RF gain.\n");
+		{}
 }
diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index a7ecdf501a14..697d1aa8e747 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -18,7 +18,6 @@ u8 PHY_GetTxPowerByRateBase(struct adapter *Adapter, u8 Band, u8 RfPath,
 	u8	value = 0;
 
 	if (RfPath > ODM_RF_PATH_D) {
-		DBG_871X("Invalid Rf Path %d in PHY_GetTxPowerByRateBase()\n", RfPath);
 		return 0;
 	}
 
@@ -55,8 +54,6 @@ u8 PHY_GetTxPowerByRateBase(struct adapter *Adapter, u8 Band, u8 RfPath,
 			value = pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][9];
 			break;
 		default:
-			DBG_871X("Invalid RateSection %d in Band 2.4G, Rf Path %d, %dTx in PHY_GetTxPowerByRateBase()\n",
-					 RateSection, RfPath, TxNum);
 			break;
 		}
 	} else if (Band == BAND_ON_5G) {
@@ -89,12 +86,10 @@ u8 PHY_GetTxPowerByRateBase(struct adapter *Adapter, u8 Band, u8 RfPath,
 			value = pHalData->TxPwrByRateBase5G[RfPath][TxNum][8];
 			break;
 		default:
-			DBG_871X("Invalid RateSection %d in Band 5G, Rf Path %d, %dTx in PHY_GetTxPowerByRateBase()\n",
-					 RateSection, RfPath, TxNum);
 			break;
 		}
 	} else
-		DBG_871X("Invalid Band %d in PHY_GetTxPowerByRateBase()\n", Band);
+		{}
 
 	return value;
 }
@@ -112,7 +107,6 @@ phy_SetTxPowerByRateBase(
 	struct hal_com_data	*pHalData = GET_HAL_DATA(Adapter);
 
 	if (RfPath > ODM_RF_PATH_D) {
-		DBG_871X("Invalid Rf Path %d in phy_SetTxPowerByRatBase()\n", RfPath);
 		return;
 	}
 
@@ -149,8 +143,6 @@ phy_SetTxPowerByRateBase(
 			pHalData->TxPwrByRateBase2_4G[RfPath][TxNum][9] = Value;
 			break;
 		default:
-			DBG_871X("Invalid RateSection %d in Band 2.4G, Rf Path %d, %dTx in phy_SetTxPowerByRateBase()\n",
-					 RateSection, RfPath, TxNum);
 			break;
 		}
 	} else if (Band == BAND_ON_5G) {
@@ -183,12 +175,10 @@ phy_SetTxPowerByRateBase(
 			pHalData->TxPwrByRateBase5G[RfPath][TxNum][8] = Value;
 			break;
 		default:
-			DBG_871X("Invalid RateSection %d in Band 5G, Rf Path %d, %dTx in phy_SetTxPowerByRateBase()\n",
-					 RateSection, RfPath, TxNum);
 			break;
 		}
 	} else
-		DBG_871X("Invalid Band %d in phy_SetTxPowerByRateBase()\n", Band);
+		{}
 }
 
 static void
@@ -321,7 +311,6 @@ u8 PHY_GetRateSectionIndexOfTxPowerByRate(
 			index = 13;
 			break;
 		default:
-			DBG_871X("Invalid RegAddr 0x3%x in PHY_GetRateSectionIndexOfTxPowerByRate()", RegAddr);
 			break;
 		}
 	}
@@ -711,7 +700,6 @@ PHY_GetRateValuesOfTxPowerByRate(
 		break;
 
 	default:
-		DBG_871X("Invalid RegAddr 0x%x in %s()\n", RegAddr, __func__);
 		break;
 	}
 }
@@ -733,17 +721,14 @@ static void PHY_StoreTxPowerByRateNew(
 	PHY_GetRateValuesOfTxPowerByRate(padapter, RegAddr, BitMask, Data, rateIndex, PwrByRateVal, &rateNum);
 
 	if (Band != BAND_ON_2_4G && Band != BAND_ON_5G) {
-		DBG_871X("Invalid Band %d\n", Band);
 		return;
 	}
 
 	if (RfPath > ODM_RF_PATH_D) {
-		DBG_871X("Invalid RfPath %d\n", RfPath);
 		return;
 	}
 
 	if (TxNum > ODM_RF_PATH_D) {
-		DBG_871X("Invalid TxNum %d\n", TxNum);
 		return;
 	}
 
@@ -803,7 +788,7 @@ void PHY_StoreTxPowerByRate(
 		else if (RegAddr == rTxAGC_B_Mcs15_Mcs12 && pHalData->rf_type != RF_1T1R)
 			pHalData->pwrGroupCnt++;
 	} else
-		DBG_871X("Invalid PHY_REG_PG.txt version %d\n",  pDM_Odm->PhyRegPgVersion);
+		{}
 
 }
 
@@ -1000,7 +985,7 @@ void PHY_SetTxPowerIndexByRateSection(
 					       Channel, vhtRates4T,
 					       ARRAY_SIZE(vhtRates4T));
 	} else
-		DBG_871X("Invalid RateSection %d in %s", RateSection, __func__);
+		{}
 }
 
 static bool phy_GetChnlIndex(u8 Channel, u8 *ChannelIdx)
@@ -1047,7 +1032,6 @@ u8 PHY_GetTxPowerIndexBase(
 
 	if (HAL_IsLegalChannel(padapter, Channel) == false) {
 		chnlIdx = 0;
-		DBG_871X("Illegal channel!!\n");
 	}
 
 	*bIn24G = phy_GetChnlIndex(Channel, &chnlIdx);
@@ -1060,7 +1044,7 @@ u8 PHY_GetTxPowerIndexBase(
 		else if (MGN_6M <= Rate)
 			txPower = pHalData->Index24G_BW40_Base[RFPath][chnlIdx];
 		else
-			DBG_871X("PHY_GetTxPowerIndexBase: INVALID Rate.\n");
+			{}
 
 		/* DBG_871X("Base Tx power(RF-%c, Rate #%d, Channel Index %d) = 0x%X\n", */
 		/*		((RFPath == 0)?'A':'B'), Rate, chnlIdx, txPower); */
@@ -1116,7 +1100,7 @@ u8 PHY_GetTxPowerIndexBase(
 		if (MGN_6M <= Rate)
 			txPower = pHalData->Index5G_BW40_Base[RFPath][chnlIdx];
 		else
-			DBG_871X("===> mpt_ProQueryCalTxPower_Jaguar: INVALID Rate.\n");
+			{}
 
 		/* DBG_871X("Base Tx power(RF-%c, Rate #%d, Channel Index %d) = 0x%X\n", */
 		/*	((RFPath == 0)?'A':'B'), Rate, chnlIdx, txPower); */
@@ -1459,7 +1443,6 @@ u8 PHY_GetRateIndexOfTxPowerByRate(u8 Rate)
 		index = 83;
 		break;
 	default:
-		DBG_871X("Invalid rate 0x%x in %s\n", Rate, __func__);
 		break;
 	}
 	return index;
@@ -1478,19 +1461,15 @@ s8 PHY_GetTxPowerByRate(
 		return 0;
 
 	if (Band != BAND_ON_2_4G && Band != BAND_ON_5G) {
-		DBG_871X("Invalid band %d in %s\n", Band, __func__);
 		return value;
 	}
 	if (RFPath > ODM_RF_PATH_D) {
-		DBG_871X("Invalid RfPath %d in %s\n", RFPath, __func__);
 		return value;
 	}
 	if (TxNum >= RF_MAX_TX_NUM) {
-		DBG_871X("Invalid TxNum %d in %s\n", TxNum, __func__);
 		return value;
 	}
 	if (rateIndex >= TX_PWR_BY_RATE_NUM_RATE) {
-		DBG_871X("Invalid RateIndex %d in %s\n", rateIndex, __func__);
 		return value;
 	}
 
@@ -1511,19 +1490,15 @@ void PHY_SetTxPowerByRate(
 	u8 rateIndex = PHY_GetRateIndexOfTxPowerByRate(Rate);
 
 	if (Band != BAND_ON_2_4G && Band != BAND_ON_5G) {
-		DBG_871X("Invalid band %d in %s\n", Band, __func__);
 		return;
 	}
 	if (RFPath > ODM_RF_PATH_D) {
-		DBG_871X("Invalid RfPath %d in %s\n", RFPath, __func__);
 		return;
 	}
 	if (TxNum >= RF_MAX_TX_NUM) {
-		DBG_871X("Invalid TxNum %d in %s\n", TxNum, __func__);
 		return;
 	}
 	if (rateIndex >= TX_PWR_BY_RATE_NUM_RATE) {
-		DBG_871X("Invalid RateIndex %d in %s\n", rateIndex, __func__);
 		return;
 	}
 
@@ -1598,10 +1573,10 @@ static s8 phy_GetChannelIndexOfTxPowerLimit(u8 Band, u8 Channel)
 				channelIndex = i;
 		}
 	} else
-		DBG_871X("Invalid Band %d in %s", Band, __func__);
+		{}
 
 	if (channelIndex == -1)
-		DBG_871X("Invalid Channel %d of Band %d in %s", Channel, Band, __func__);
+		{}
 
 	return channelIndex;
 }
@@ -1663,7 +1638,6 @@ static s16 get_rate_sctn_idx(const u8 rate)
 	case MGN_VHT4SS_MCS9:
 		return 9;
 	default:
-		DBG_871X("Wrong rate 0x%x\n", rate);
 		return -1;
 	}
 }
@@ -1717,7 +1691,7 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 	idx_rate_sctn = get_rate_sctn_idx(data_rate);
 
 	if (band_type == BAND_ON_5G && idx_rate_sctn == 0)
-		DBG_871X("Wrong rate 0x%x: No CCK in 5G Band\n", DataRate);
+		{}
 
 	/*  workaround for wrong index combination to obtain tx power limit, */
 	/*  OFDM only exists in BW 20M */
@@ -1777,7 +1751,6 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 					       [idx_channel]
 					       [rf_path];
 	} else {
-		DBG_871X("No power limit table of the specified band\n");
 	}
 
 	/* DBG_871X("TxPwrLmt[Regulation %d][Band %d][BW %d][RFPath %d][Rate 0x%x][Chnl %d] = %d\n", */
@@ -1934,7 +1907,7 @@ void PHY_SetTxPowerLimit(
 
 	if (!GetU1ByteIntegerFromStringInDecimal((s8 *)Channel, &channel) ||
 		 !GetU1ByteIntegerFromStringInDecimal((s8 *)PowerLimit, &powerLimit))
-		DBG_871X("Illegal index of power limit table [chnl %s][val %s]\n", Channel, PowerLimit);
+		{}
 
 	powerLimit = powerLimit > MAX_POWER_INDEX ? MAX_POWER_INDEX : powerLimit;
 
@@ -1968,7 +1941,6 @@ void PHY_SetTxPowerLimit(
 	else if (eqNByte(RateSection, (u8 *)("VHT"), 3) && eqNByte(RfPath, (u8 *)("4T"), 2))
 		rateSection = 9;
 	else {
-		DBG_871X("Wrong rate section!\n");
 		return;
 	}
 
@@ -2009,7 +1981,6 @@ void PHY_SetTxPowerLimit(
 		/* DBG_871X("5G Band value : [regulation %d][bw %d][rate_section %d][chnl %d][val %d]\n", */
 		/*	  regulation, bandwidth, rateSection, channel, pHalData->TxPwrLimit_5G[regulation][bandwidth][rateSection][channelIndex][ODM_RF_PATH_A]); */
 	} else {
-		DBG_871X("Cannot recognize the band info in %s\n", Band);
 		return;
 	}
 }
diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 7fbac4c8f2f8..71afbb17448c 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -105,7 +105,6 @@ uint rtw_hal_init(struct adapter *padapter)
 		rtw_bb_rf_gain_offset(padapter);
 	} else {
 		dvobj->padapters->hw_init_completed = false;
-		DBG_871X("rtw_hal_init: hal__init fail\n");
 	}
 
 	return status;
@@ -122,7 +121,6 @@ uint rtw_hal_deinit(struct adapter *padapter)
 		padapter = dvobj->padapters;
 		padapter->hw_init_completed = false;
 	} else {
-		DBG_871X("\n rtw_hal_deinit: hal_init fail\n");
 	}
 	return status;
 }
@@ -176,7 +174,7 @@ void rtw_hal_enable_interrupt(struct adapter *padapter)
 	if (padapter->HalFunc.enable_interrupt)
 		padapter->HalFunc.enable_interrupt(padapter);
 	else
-		DBG_871X("%s: HalFunc.enable_interrupt is NULL!\n", __func__);
+		{}
 }
 
 void rtw_hal_disable_interrupt(struct adapter *padapter)
@@ -184,7 +182,7 @@ void rtw_hal_disable_interrupt(struct adapter *padapter)
 	if (padapter->HalFunc.disable_interrupt)
 		padapter->HalFunc.disable_interrupt(padapter);
 	else
-		DBG_871X("%s: HalFunc.disable_interrupt is NULL!\n", __func__);
+		{}
 }
 
 u8 rtw_hal_check_ips_status(struct adapter *padapter)
@@ -193,7 +191,7 @@ u8 rtw_hal_check_ips_status(struct adapter *padapter)
 	if (padapter->HalFunc.check_ips_status)
 		val = padapter->HalFunc.check_ips_status(padapter);
 	else
-		DBG_871X("%s: HalFunc.check_ips_status is NULL!\n", __func__);
+		{}
 
 	return val;
 }
@@ -446,7 +444,7 @@ s32 rtw_hal_fill_h2c_cmd(struct adapter *padapter, u8 ElementID, u32 CmdLen, u8
 	if (padapter->HalFunc.fill_h2c_cmd)
 		ret = padapter->HalFunc.fill_h2c_cmd(padapter, ElementID, CmdLen, pCmdBuffer);
 	else
-		DBG_871X("%s:  func[fill_h2c_cmd] not defined!\n", __func__);
+		{}
 
 	return ret;
 }
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
index 88f908fd14e3..e53764250cdd 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c
@@ -202,7 +202,6 @@ static void ConstructBeacon(struct adapter *padapter, u8 *pframe, u32 *pLength)
 _ConstructBeacon:
 
 	if ((pktlen + TXDESC_SIZE) > 512) {
-		DBG_871X("beacon frame too large\n");
 		return;
 	}
 
@@ -325,11 +324,6 @@ static void rtl8723b_set_FwRsvdPage_cmd(struct adapter *padapter, struct rsvdpag
 {
 	u8 u1H2CRsvdPageParm[H2C_RSVDPAGE_LOC_LEN] = {0};
 
-	DBG_871X("8723BRsvdPageLoc: ProbeRsp =%d PsPoll =%d Null =%d QoSNull =%d BTNull =%d\n",
-		rsvdpageloc->LocProbeRsp, rsvdpageloc->LocPsPoll,
-		rsvdpageloc->LocNullData, rsvdpageloc->LocQosNull,
-		rsvdpageloc->LocBTQosNull);
-
 	SET_8723B_H2CCMD_RSVDPAGE_LOC_PROBE_RSP(u1H2CRsvdPageParm, rsvdpageloc->LocProbeRsp);
 	SET_8723B_H2CCMD_RSVDPAGE_LOC_PSPOLL(u1H2CRsvdPageParm, rsvdpageloc->LocPsPoll);
 	SET_8723B_H2CCMD_RSVDPAGE_LOC_NULL_DATA(u1H2CRsvdPageParm, rsvdpageloc->LocNullData);
@@ -351,8 +345,6 @@ void rtl8723b_set_FwMediaStatusRpt_cmd(struct adapter *padapter, u8 mstatus, u8
 	u8 u1H2CMediaStatusRptParm[H2C_MEDIA_STATUS_RPT_LEN] = {0};
 	u8 macid_end = 0;
 
-	DBG_871X("%s(): mstatus = %d macid =%d\n", __func__, mstatus, macid);
-
 	SET_8723B_H2CCMD_MSRRPT_PARM_OPMODE(u1H2CMediaStatusRptParm, mstatus);
 	SET_8723B_H2CCMD_MSRRPT_PARM_MACID_IND(u1H2CMediaStatusRptParm, 0);
 	SET_8723B_H2CCMD_MSRRPT_PARM_MACID(u1H2CMediaStatusRptParm, macid);
@@ -368,8 +360,6 @@ void rtl8723b_set_FwMacIdConfig_cmd(struct adapter *padapter, u8 mac_id, u8 raid
 {
 	u8 u1H2CMacIdConfigParm[H2C_MACID_CFG_LEN] = {0};
 
-	DBG_871X("%s(): mac_id =%d raid = 0x%x bw =%d mask = 0x%x\n", __func__, mac_id, raid, bw, mask);
-
 	SET_8723B_H2CCMD_MACID_CFG_MACID(u1H2CMacIdConfigParm, mac_id);
 	SET_8723B_H2CCMD_MACID_CFG_RAID(u1H2CMacIdConfigParm, raid);
 	SET_8723B_H2CCMD_MACID_CFG_SGI_EN(u1H2CMacIdConfigParm, sgi ? 1 : 0);
@@ -414,9 +404,9 @@ void rtl8723b_set_FwPwrMode_cmd(struct adapter *padapter, u8 psmode)
 	u8 PowerState = 0, awake_intvl = 1, byte5 = 0, rlbm = 0;
 
 	if (pwrpriv->dtim > 0)
-		DBG_871X("%s(): FW LPS mode = %d, SmartPS =%d, dtim =%d\n", __func__, psmode, pwrpriv->smart_ps, pwrpriv->dtim);
+		{}
 	else
-		DBG_871X("%s(): FW LPS mode = %d, SmartPS =%d\n", __func__, psmode, pwrpriv->smart_ps);
+		{}
 
 	if (pwrpriv->dtim > 0 && pwrpriv->dtim < 16)
 		awake_intvl = pwrpriv->dtim+1;/* DTIM = (awake_intvl - 1) */
@@ -469,31 +459,18 @@ void rtl8723b_set_FwPwrMode_cmd(struct adapter *padapter, u8 psmode)
 			pmlmeext->DrvBcnEarly = 0xff;
 			pmlmeext->DrvBcnTimeOut = 0xff;
 
-			DBG_871X("%s(): bcn_cnt = %d\n", __func__, pmlmeext->bcn_cnt);
-
 			for (i = 0; i < 9; i++) {
 				pmlmeext->bcn_delay_ratio[i] = (pmlmeext->bcn_delay_cnt[i]*100)/pmlmeext->bcn_cnt;
 
-				DBG_871X(
-					"%s(): bcn_delay_cnt[%d]=%d, bcn_delay_ratio[%d] = %d\n",
-					__func__,
-					i,
-					pmlmeext->bcn_delay_cnt[i],
-					i,
-					pmlmeext->bcn_delay_ratio[i]
-				);
-
 				ratio_20_delay += pmlmeext->bcn_delay_ratio[i];
 				ratio_80_delay += pmlmeext->bcn_delay_ratio[i];
 
 				if (ratio_20_delay > 20 && pmlmeext->DrvBcnEarly == 0xff) {
 					pmlmeext->DrvBcnEarly = i;
-					DBG_871X("%s(): DrvBcnEarly = %d\n", __func__, pmlmeext->DrvBcnEarly);
 				}
 
 				if (ratio_80_delay > 80 && pmlmeext->DrvBcnTimeOut == 0xff) {
 					pmlmeext->DrvBcnTimeOut = i;
-					DBG_871X("%s(): DrvBcnTimeOut = %d\n", __func__, pmlmeext->DrvBcnTimeOut);
 				}
 
 				/* reset adaptive_early_32k cnt */
@@ -506,8 +483,6 @@ void rtl8723b_set_FwPwrMode_cmd(struct adapter *padapter, u8 psmode)
 			pmlmeext->adaptive_tsf_done = true;
 
 		} else {
-			DBG_871X("%s(): DrvBcnEarly = %d\n", __func__, pmlmeext->DrvBcnEarly);
-			DBG_871X("%s(): DrvBcnTimeOut = %d\n", __func__, pmlmeext->DrvBcnTimeOut);
 		}
 
 /* offload to FW if fw version > v15.10
@@ -552,9 +527,6 @@ void rtl8723b_set_FwPsTuneParam_cmd(struct adapter *padapter)
 
 void rtl8723b_set_FwPwrModeInIPS_cmd(struct adapter *padapter, u8 cmd_param)
 {
-	/* BIT0:enable, BIT1:NoConnect32k */
-
-	DBG_871X("%s()\n", __func__);
 
 	FillH2CCmd8723B(padapter, H2C_8723B_FWLPS_IN_IPS_, 1, &cmd_param);
 }
@@ -606,7 +578,6 @@ static void rtl8723b_set_FwRsvdPagePkt(
 
 	pcmdframe = rtw_alloc_cmdxmitframe(pxmitpriv);
 	if (!pcmdframe) {
-		DBG_871X("%s: alloc ReservedPagePacket fail!\n", __func__);
 		return;
 	}
 
@@ -705,8 +676,6 @@ static void rtl8723b_set_FwRsvdPagePkt(
 	TotalPacketLen = BufIndex + BTQosNullLength;
 
 	if (TotalPacketLen > MaxRsvdPageBufSize) {
-		DBG_871X("%s(): ERROR: The rsvd page size is not enough!!TotalPacketLen %d, MaxRsvdPageBufSize %d\n", __func__,
-			TotalPacketLen, MaxRsvdPageBufSize);
 		goto error;
 	} else {
 		/*  update attribute */
@@ -717,7 +686,6 @@ static void rtl8723b_set_FwRsvdPagePkt(
 		dump_mgntframe_and_wait(padapter, pcmdframe, 100);
 	}
 
-	DBG_871X("%s: Set RSVD page location to Fw , TotalPacketLen(%d), TotalPageNum(%d)\n", __func__, TotalPacketLen, TotalPageNum);
 	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
 		rtl8723b_set_FwRsvdPage_cmd(padapter, &RsvdPageLoc);
 		rtl8723b_set_FwAoacRsvdPage_cmd(padapter, &RsvdPageLoc);
@@ -795,13 +763,10 @@ void rtl8723b_download_rsvd_page(struct adapter *padapter, u8 mstatus)
 
 		if (padapter->bSurpriseRemoved || padapter->bDriverStopped) {
 		} else if (!bcn_valid)
-			DBG_871X("%s: 1 DL RSVD page failed! DLBcnCount:%u, poll:%u\n",
-				ADPT_ARG(padapter), DLBcnCount, poll);
+			{}
 		else {
 			struct pwrctrl_priv *pwrctl = adapter_to_pwrctl(padapter);
 			pwrctl->fw_psmode_iface_id = padapter->iface_id;
-			DBG_871X("%s: 1 DL RSVD page success! DLBcnCount:%u, poll:%u\n",
-				ADPT_ARG(padapter), DLBcnCount, poll);
 		}
 
 		/*  2010.05.11. Added by tynli. */
@@ -863,7 +828,6 @@ void rtl8723b_Add_RateATid(
 	if (rssi_level != DM_RATR_STA_INIT)
 		mask = ODM_Get_Rate_Bitmap(&pHalData->odmpriv, mac_id, mask, rssi_level);
 
-	DBG_871X("%s(): mac_id =%d raid = 0x%x bw =%d mask = 0x%x\n", __func__, mac_id, raid, bw, mask);
 	rtl8723b_set_FwMacIdConfig_cmd(padapter, mac_id, raid, bw, shortGI, mask);
 }
 
@@ -883,10 +847,6 @@ static void ConstructBtNullFunctionData(
 	u32 pktlen;
 	u8 bssid[ETH_ALEN];
 
-
-	DBG_871X("+" FUNC_ADPT_FMT ": qos =%d eosp =%d ps =%d\n",
-		FUNC_ADPT_ARG(padapter), bQoS, bEosp, bForcePowerSave);
-
 	pwlanhdr = (struct ieee80211_hdr *)pframe;
 
 	if (!StaAddr) {
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
index 3792280f93d5..c2e9e4a0be22 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
@@ -44,7 +44,6 @@ static void Init_ODM_ComInfo_8723b(struct adapter *Adapter)
 	fab_ver = ODM_TSMC;
 	cut_ver = ODM_CUT_A;
 
-	DBG_871X("%s(): fab_ver =%d cut_ver =%d\n", __func__, fab_ver, cut_ver);
 	ODM_CmnInfoInit(pDM_Odm, ODM_CMNINFO_FAB_VER, fab_ver);
 	ODM_CmnInfoInit(pDM_Odm, ODM_CMNINFO_CUT_VER, cut_ver);
 	ODM_CmnInfoInit(pDM_Odm, ODM_CMNINFO_MP_TEST_CHIP, IS_NORMAL_CHIP(pHalData->VersionID));
@@ -204,8 +203,6 @@ void rtl8723b_hal_dm_in_lps(struct adapter *padapter)
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct sta_info *psta = NULL;
 
-	DBG_871X("%s, RSSI_Min =%d\n", __func__, pDM_Odm->RSSI_Min);
-
 	/* update IGI */
 	ODM_Write_DIG(pDM_Odm, pDM_Odm->RSSI_Min);
 
@@ -257,8 +254,6 @@ void rtl8723b_HalDmWatchDog_in_LPS(struct adapter *Adapter)
 
 	pdmpriv->EntryMinUndecoratedSmoothedPWDB = psta->rssi_stat.UndecoratedSmoothedPWDB;
 
-	DBG_871X("CurIGValue =%d, EntryMinUndecoratedSmoothedPWDB = %d\n", pDM_DigTable->CurIGValue, pdmpriv->EntryMinUndecoratedSmoothedPWDB);
-
 	if (pdmpriv->EntryMinUndecoratedSmoothedPWDB <= 0)
 		goto skip_lps_dm;
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index eaa9f9e2e6a4..d706ab03d434 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -34,7 +34,7 @@ static void _FWDownloadEnable(struct adapter *padapter, bool enable)
 		} while (count++ < 100);
 
 		if (count > 0)
-			DBG_871X("%s: !!!!!!!!Write 0x80 Fail!: count = %d\n", __func__, count);
+			{}
 
 		/*  8051 reset */
 		tmp = rtw_read8(padapter, REG_MCUFWDL+2);
@@ -208,7 +208,6 @@ static s32 polling_fwdl_chksum(
 	}
 
 	if (g_fwdl_chksum_fail) {
-		DBG_871X("%s: fwdl test case: fwdl_chksum_fail\n", __func__);
 		g_fwdl_chksum_fail--;
 		goto exit;
 	}
@@ -216,14 +215,6 @@ static s32 polling_fwdl_chksum(
 	ret = _SUCCESS;
 
 exit:
-	DBG_871X(
-		"%s: Checksum report %s! (%u, %dms), REG_MCUFWDL:0x%08x\n",
-		__func__,
-		(ret == _SUCCESS) ? "OK" : "Fail",
-		cnt,
-		jiffies_to_msecs(jiffies-start),
-		value32
-	);
 
 	return ret;
 }
@@ -258,7 +249,6 @@ static s32 _FWFreeToGo(struct adapter *adapter, u32 min_cnt, u32 timeout_ms)
 	}
 
 	if (g_fwdl_wintint_rdy_fail) {
-		DBG_871X("%s: fwdl test case: wintint_rdy_fail\n", __func__);
 		g_fwdl_wintint_rdy_fail--;
 		goto exit;
 	}
@@ -266,14 +256,6 @@ static s32 _FWFreeToGo(struct adapter *adapter, u32 min_cnt, u32 timeout_ms)
 	ret = _SUCCESS;
 
 exit:
-	DBG_871X(
-		"%s: Polling FW ready %s! (%u, %dms), REG_MCUFWDL:0x%08x\n",
-		__func__,
-		(ret == _SUCCESS) ? "OK" : "Fail",
-		cnt,
-		jiffies_to_msecs(jiffies-start),
-		value32
-	);
 
 	return ret;
 }
@@ -349,7 +331,6 @@ s32 rtl8723b_FirmwareDownload(struct adapter *padapter, bool  bUsedWoWLANFw)
 	tmp_ps = rtw_read8(padapter, 0xa0);
 	tmp_ps &= 0x03;
 	if (tmp_ps != 0x01) {
-		DBG_871X(FUNC_ADPT_FMT" tmp_ps =%x\n", FUNC_ADPT_ARG(padapter), tmp_ps);
 		pdbgpriv->dbg_downloadfw_pwr_state_cnt++;
 	}
 
@@ -399,20 +380,7 @@ s32 rtl8723b_FirmwareDownload(struct adapter *padapter, bool  bUsedWoWLANFw)
 	pHalData->FirmwareSubVersion = le16_to_cpu(pFwHdr->subversion);
 	pHalData->FirmwareSignature = le16_to_cpu(pFwHdr->signature);
 
-	DBG_871X(
-		"%s: fw_ver =%x fw_subver =%04x sig = 0x%x, Month =%02x, Date =%02x, Hour =%02x, Minute =%02x\n",
-		__func__,
-		pHalData->FirmwareVersion,
-		pHalData->FirmwareSubVersion,
-		pHalData->FirmwareSignature,
-		pFwHdr->month,
-		pFwHdr->date,
-		pFwHdr->hour,
-		pFwHdr->minute
-	);
-
 	if (IS_FW_HEADER_EXIST_8723B(pFwHdr)) {
-		DBG_871X("%s(): Shift for fw header!\n", __func__);
 		/*  Shift 32 bytes for FW header */
 		pFirmwareBuf = pFirmwareBuf + 32;
 		FirmwareLen = FirmwareLen - 32;
@@ -452,19 +420,12 @@ s32 rtl8723b_FirmwareDownload(struct adapter *padapter, bool  bUsedWoWLANFw)
 		goto fwdl_stat;
 
 fwdl_stat:
-	DBG_871X(
-		"FWDL %s. write_fw:%u, %dms\n",
-		(rtStatus == _SUCCESS)?"success":"fail",
-		write_fw,
-		jiffies_to_msecs(jiffies - fwdl_start_time)
-	);
 
 exit:
 	kfree(pFirmware->fw_buffer_sz);
 	kfree(pFirmware);
 release_fw1:
 	kfree(pBTFirmware);
-	DBG_871X(" <=== rtl8723b_FirmwareDownload()\n");
 	return rtStatus;
 }
 
@@ -812,7 +773,6 @@ static void hal_ReadEFuse_WiFi(
 if (0) {
 	for (i = 0; i < 256; i++)
 		efuse_OneByteRead(padapter, i, &efuseTbl[i], false);
-	DBG_871X("Efuse Content:\n");
 	for (i = 0; i < 256; i++) {
 		if (i % 16 == 0)
 			printk("\n");
@@ -883,7 +843,6 @@ if (0) {
 
 #ifdef DEBUG
 if (1) {
-	DBG_871X("Efuse Realmap:\n");
 	for (i = 0; i < _size_byte; i++) {
 		if (i % 16 == 0)
 			printk("\n");
@@ -2016,10 +1975,8 @@ static void rtl8723b_SetHalODMVar(
 static void hal_notch_filter_8723b(struct adapter *adapter, bool enable)
 {
 	if (enable) {
-		DBG_871X("Enable notch filter\n");
 		rtw_write8(adapter, rOFDM0_RxDSP+1, rtw_read8(adapter, rOFDM0_RxDSP+1) | BIT1);
 	} else {
-		DBG_871X("Disable notch filter\n");
 		rtw_write8(adapter, rOFDM0_RxDSP+1, rtw_read8(adapter, rOFDM0_RxDSP+1) & ~BIT1);
 	}
 }
@@ -2034,8 +1991,6 @@ static void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_l
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 
-	DBG_871X("%s(): mac_id =%d rssi_level =%d\n", __func__, mac_id, rssi_level);
-
 	if (mac_id >= NUM_STA) /* CAM_SIZE */
 		return;
 
@@ -2049,8 +2004,6 @@ static void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_l
 
 	rate_bitmap = 0xffffffff;
 	rate_bitmap = ODM_Get_Rate_Bitmap(&pHalData->odmpriv, mac_id, mask, rssi_level);
-	DBG_871X("%s => mac_id:%d, networkType:0x%02x, mask:0x%08x\n\t ==> rssi_level:%d, rate_bitmap:0x%08x\n",
-			__func__, mac_id, psta->wireless_mode, mask, rssi_level, rate_bitmap);
 
 	mask &= rate_bitmap;
 
@@ -2063,7 +2016,6 @@ static void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_l
 
 	/* set correct initial date rate for each mac_id */
 	pdmpriv->INIDATA_RATE[mac_id] = psta->init_rate;
-	DBG_871X("%s(): mac_id =%d raid = 0x%x bw =%d mask = 0x%x init_rate = 0x%x\n", __func__, mac_id, psta->raid, psta->bw_mode, mask, psta->init_rate);
 }
 
 
@@ -2343,7 +2295,6 @@ static void Hal_ReadPowerValueFromPROM_8723B(
 		AutoLoadFail = true;
 
 	if (AutoLoadFail) {
-		DBG_871X("%s(): Use Default value!\n", __func__);
 		for (rfPath = 0; rfPath < MAX_RF_PATH; rfPath++) {
 			/* 2.4G default value */
 			for (group = 0; group < MAX_CHNL_GROUP_24G; group++) {
@@ -2584,7 +2535,6 @@ void Hal_EfuseParsePackageType_8723B(
 
 	Efuse_PowerSwitch(padapter, false, true);
 	efuse_OneByteRead(padapter, 0x1FB, &efuseContent, false);
-	DBG_871X("%s phy efuse read 0x1FB =%x\n", __func__, efuseContent);
 	Efuse_PowerSwitch(padapter, false, false);
 
 	package = efuseContent & 0x7;
@@ -2606,8 +2556,6 @@ void Hal_EfuseParsePackageType_8723B(
 		pHalData->PackageType = PACKAGE_DEFAULT;
 		break;
 	}
-
-	DBG_871X("PackageType = 0x%X\n", pHalData->PackageType);
 }
 
 
@@ -2618,9 +2566,7 @@ void Hal_EfuseParseVoltage_8723B(
 	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
 
 	/* memcpy(pEEPROM->adjuseVoltageVal, &hwinfo[EEPROM_Voltage_ADDR_8723B], 1); */
-	DBG_871X("%s hwinfo[EEPROM_Voltage_ADDR_8723B] =%02x\n", __func__, hwinfo[EEPROM_Voltage_ADDR_8723B]);
 	pEEPROM->adjuseVoltageVal = (hwinfo[EEPROM_Voltage_ADDR_8723B] & 0xf0) >> 4;
-	DBG_871X("%s pEEPROM->adjuseVoltageVal =%x\n", __func__, pEEPROM->adjuseVoltageVal);
 }
 
 void Hal_EfuseParseChnlPlan_8723B(
@@ -2704,15 +2650,11 @@ void Hal_ReadRFGainOffset(
 
 	if (!AutoloadFail) {
 		Adapter->eeprompriv.EEPROMRFGainOffset = PROMContent[EEPROM_RF_GAIN_OFFSET];
-		DBG_871X("AutoloadFail =%x,\n", AutoloadFail);
 		Adapter->eeprompriv.EEPROMRFGainVal = EFUSE_Read1Byte(Adapter, EEPROM_RF_GAIN_VAL);
-		DBG_871X("Adapter->eeprompriv.EEPROMRFGainVal =%x\n", Adapter->eeprompriv.EEPROMRFGainVal);
 	} else {
 		Adapter->eeprompriv.EEPROMRFGainOffset = 0;
 		Adapter->eeprompriv.EEPROMRFGainVal = 0xFF;
-		DBG_871X("else AutoloadFail =%x,\n", AutoloadFail);
 	}
-	DBG_871X("EEPRORFGainOffset = 0x%02x\n", Adapter->eeprompriv.EEPROMRFGainOffset);
 }
 
 u8 BWMapping_8723B(struct adapter *Adapter, struct pkt_attrib *pattrib)
@@ -2759,7 +2701,7 @@ u8 SCMapping_8723B(struct adapter *Adapter, struct pkt_attrib *pattrib)
 			else if (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER)
 				SCSettingOfDesc = VHT_DATA_SC_40_UPPER_OF_80MHZ;
 			else
-				DBG_871X("SCMapping: Not Correct Primary40MHz Setting\n");
+				{}
 		} else {
 			if ((pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER) && (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER))
 				SCSettingOfDesc = VHT_DATA_SC_20_LOWEST_OF_80MHZ;
@@ -2770,7 +2712,7 @@ u8 SCMapping_8723B(struct adapter *Adapter, struct pkt_attrib *pattrib)
 			else if ((pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER) && (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER))
 				SCSettingOfDesc = VHT_DATA_SC_20_UPPERST_OF_80MHZ;
 			else
-				DBG_871X("SCMapping: Not Correct Primary40MHz Setting\n");
+				{}
 		}
 	} else if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_40) {
 		/* DBG_871X("SCMapping: HT Case: pHalData->CurrentChannelBW %d, pHalData->nCur40MhzPrimeSC %d\n", pHalData->CurrentChannelBW, pHalData->nCur40MhzPrimeSC); */
@@ -2975,7 +2917,6 @@ static void rtl8723b_fill_default_txdesc(
 			if (pmlmeinfo->preamble_mode == PREAMBLE_SHORT)
 				ptxdesc->data_short = 1;/*  DATA_SHORT */
 			ptxdesc->datarate = MRateToHwRate(pmlmeext->tx_rate);
-			DBG_871X("YJ: %s(): ARP Data: userate =%d, datarate = 0x%x\n", __func__, ptxdesc->userate, ptxdesc->datarate);
 		}
 
 		ptxdesc->usb_txagg_num = pxmitframe->agg_num;
@@ -3154,7 +3095,6 @@ static void hw_var_set_opmode(struct adapter *padapter, u8 variable, u8 *val)
 
 		/*  set net_type */
 		Set_MSR(padapter, mode);
-		DBG_871X("#### %s() -%d iface_type(0) mode = %d ####\n", __func__, __LINE__, mode);
 
 		if ((mode == _HW_STATE_STATION_) || (mode == _HW_STATE_NOLINK_)) {
 			{
@@ -3905,8 +3845,6 @@ void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
 					val32 &= RXDMA_IDLE;
 					if (val32)
 						break;
-
-					DBG_871X("%s: [HW_VAR_FIFO_CLEARN_UP] val =%x times:%d\n", __func__, val32, trycnt);
 				} while (--trycnt);
 
 				if (trycnt == 0) {
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
index 62dd5b582e1c..5c1aa45c2984 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
@@ -547,7 +547,6 @@ void PHY_SetTxPowerIndex(
 			break;
 
 		default:
-			DBG_871X("Invalid Rate!!\n");
 			break;
 		}
 	}
@@ -632,7 +631,6 @@ static void phy_SetRegBW_8723B(
 		break;
 
 	default:
-		DBG_871X("phy_PostSetBWMode8723B():	unknown Bandwidth: %#X\n", CurrentBW);
 		break;
 	}
 }
@@ -744,12 +742,6 @@ static void phy_SwChnlAndSetBwMode8723B(struct adapter *Adapter)
 	struct hal_com_data *pHalData = GET_HAL_DATA(Adapter);
 
 	if (Adapter->bNotifyChannelChange) {
-		DBG_871X("[%s] bSwChnl =%d, ch =%d, bSetChnlBW =%d, bw =%d\n",
-			__func__,
-			pHalData->bSwChnl,
-			pHalData->CurrentChannel,
-			pHalData->bSetChnlBW,
-			pHalData->CurrentChannelBW);
 	}
 
 	if (Adapter->bDriverStopped || Adapter->bSurpriseRemoved)
@@ -789,7 +781,6 @@ static void PHY_HandleSwChnlAndSetBW8723B(
 
 	/* check is swchnl or setbw */
 	if (!bSwitchChannel && !bSetBandWidth) {
-		DBG_871X("PHY_HandleSwChnlAndSetBW8812:  not switch channel and not set bandwidth\n");
 		return;
 	}
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index ce7a72701455..e30c310d8439 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -427,7 +427,6 @@ s32 rtl8723bs_init_recv_priv(struct adapter *padapter)
 			}
 
 			if (!precvbuf->pskb) {
-				DBG_871X("%s: alloc_skb fail!\n", __func__);
 			}
 		}
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
index 54f36ca2f810..2f4601aab9d5 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
@@ -20,7 +20,6 @@ static u8 rtw_sdio_wait_enough_TxOQT_space(struct adapter *padapter, u8 agg_num)
 			(padapter->bSurpriseRemoved) ||
 			(padapter->bDriverStopped)
 		) {
-			DBG_871X("%s: bSurpriseRemoved or bDriverStopped (wait TxOQT)\n", __func__);
 			return false;
 		}
 
@@ -28,8 +27,6 @@ static u8 rtw_sdio_wait_enough_TxOQT_space(struct adapter *padapter, u8 agg_num)
 
 		if ((++n % 60) == 0) {
 			if ((n % 300) == 0) {
-				DBG_871X("%s(%d): QOT free space(%d), agg_num: %d\n",
-				__func__, n, pHalData->SdioTxOQTFreeSpace, agg_num);
 			}
 			msleep(1);
 			/* yield(); */
@@ -236,20 +233,6 @@ static s32 xmit_xmitframes(struct adapter *padapter, struct xmit_priv *pxmitpriv
 			sta_plist = get_next(sta_plist);
 
 #ifdef DBG_XMIT_BUF
-			DBG_871X(
-				"%s idx:%d hwxmit_pkt_num:%d ptxservq_pkt_num:%d\n",
-				__func__,
-				idx,
-				phwxmit->accnt,
-				ptxservq->qcnt
-			);
-			DBG_871X(
-				"%s free_xmit_extbuf_cnt =%d free_xmitbuf_cnt =%d free_xmitframe_cnt =%d\n",
-				__func__,
-				pxmitpriv->free_xmit_extbuf_cnt,
-				pxmitpriv->free_xmitbuf_cnt,
-				pxmitpriv->free_xmitframe_cnt
-			);
 #endif
 			pframe_queue = &ptxservq->sta_pending;
 
@@ -301,11 +284,6 @@ static s32 xmit_xmitframes(struct adapter *padapter, struct xmit_priv *pxmitpriv
 						(pxmitframe->attrib.psta->state & WIFI_SLEEP_STATE) &&
 						(pxmitframe->attrib.triggered == 0)
 					) {
-						DBG_871X(
-							"%s: one not triggered pkt in queue when this STA sleep,"
-							" break and goto next sta\n",
-							__func__
-						);
 						break;
 					}
 				}
@@ -451,8 +429,6 @@ int rtl8723bs_xmit_thread(void *context)
 	rtw_sprintf(thread_name, 20, "RTWHALXT-%s", ADPT_ARG(padapter));
 	thread_enter(thread_name);
 
-	DBG_871X("start "FUNC_ADPT_FMT"\n", FUNC_ADPT_ARG(padapter));
-
 	do {
 		ret = rtl8723bs_xmit_handler(padapter);
 		if (signal_pending(current)) {
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 5553246fa80b..05524cd72c17 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -629,8 +629,6 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 		u8 cpwm_orig, cpwm_now;
 		u8 val8, bMacPwrCtrlOn = true;
 
-		DBG_871X("%s: Leaving IPS in FWLPS state\n", __func__);
-
 		/* for polling cpwm */
 		cpwm_orig = 0;
 		rtw_hal_get_hwreg(padapter, HW_VAR_CPWM, &cpwm_orig);
@@ -641,7 +639,6 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 		val8 += 0x80;
 		val8 |= BIT(6);
 		rtw_write8(padapter, SDIO_LOCAL_BASE | SDIO_REG_HRPWM1, val8);
-		DBG_871X("%s: write rpwm =%02x\n", __func__, val8);
 		adapter_to_pwrctl(padapter)->tog = (val8 + 0x80) & 0x80;
 
 		/* do polling cpwm */
@@ -655,7 +652,6 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 				break;
 
 			if (jiffies_to_msecs(jiffies - start_time) > 100) {
-				DBG_871X("%s: polling cpwm timeout when leaving IPS in FWLPS state\n", __func__);
 				break;
 			}
 		} while (1);
@@ -943,14 +939,11 @@ static u32 rtl8723bs_hal_deinit(struct adapter *padapter)
 				int cnt = 0;
 				u8 val8 = 0;
 
-				DBG_871X("%s: issue H2C to FW when entering IPS\n", __func__);
-
 				rtl8723b_set_FwPwrModeInIPS_cmd(padapter, 0x3);
 				/* poll 0x1cc to make sure H2C command already finished by FW; MAC_0x1cc = 0 means H2C done by FW. */
 				do {
 					val8 = rtw_read8(padapter, REG_HMETFR);
 					cnt++;
-					DBG_871X("%s  polling REG_HMETFR = 0x%x, cnt =%d\n", __func__, val8, cnt);
 					mdelay(10);
 				} while (cnt < 100 && (val8 != 0));
 				/* H2C done, enter 32k */
@@ -960,32 +953,16 @@ static u32 rtl8723bs_hal_deinit(struct adapter *padapter)
 					val8 += 0x80;
 					val8 |= BIT(0);
 					rtw_write8(padapter, SDIO_LOCAL_BASE | SDIO_REG_HRPWM1, val8);
-					DBG_871X("%s: write rpwm =%02x\n", __func__, val8);
 					adapter_to_pwrctl(padapter)->tog = (val8 + 0x80) & 0x80;
 					cnt = val8 = 0;
 					do {
 						val8 = rtw_read8(padapter, REG_CR);
 						cnt++;
-						DBG_871X("%s  polling 0x100 = 0x%x, cnt =%d\n", __func__, val8, cnt);
 						mdelay(10);
 					} while (cnt < 100 && (val8 != 0xEA));
 				} else {
-					DBG_871X(
-						"MAC_1C0 =%08x, MAC_1C4 =%08x, MAC_1C8 =%08x, MAC_1CC =%08x\n",
-						rtw_read32(padapter, 0x1c0),
-						rtw_read32(padapter, 0x1c4),
-						rtw_read32(padapter, 0x1c8),
-						rtw_read32(padapter, 0x1cc)
-					);
 				}
 
-				DBG_871X(
-					"polling done when entering IPS, check result : 0x100 = 0x%x, cnt =%d, MAC_1cc = 0x%02x\n",
-					rtw_read8(padapter, REG_CR),
-					cnt,
-					rtw_read8(padapter, REG_HMETFR)
-				);
-
 				adapter_to_pwrctl(padapter)->pre_ips_type = 0;
 
 			} else {
@@ -1134,7 +1111,7 @@ static void _ReadEfuseInfo8723BS(struct adapter *padapter)
 	/*  */
 
 	if (sizeof(pEEPROM->efuse_eeprom_data) < HWSET_MAX_SIZE_8723B)
-		DBG_871X("[WARNING] size of efuse_eeprom_data is less than HWSET_MAX_SIZE_8723B!\n");
+		{}
 
 	hwinfo = pEEPROM->efuse_eeprom_data;
 
diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index b1f02bb9f0a9..cdfc8cf4aba4 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -470,7 +470,6 @@ static u32 sdio_write_port(
 	psdio = &adapter_to_dvobj(adapter)->intf_data;
 
 	if (!adapter->hw_init_completed) {
-		DBG_871X("%s [addr = 0x%x cnt =%d] adapter->hw_init_completed == false\n", __func__, addr, cnt);
 		return _FAIL;
 	}
 
@@ -817,13 +816,6 @@ void DisableInterrupt8723BSdio(struct adapter *adapter)
 /*  */
 u8 CheckIPSStatus(struct adapter *adapter)
 {
-	DBG_871X(
-		"%s(): Read 0x100 = 0x%02x 0x86 = 0x%02x\n",
-		__func__,
-		rtw_read8(adapter, 0x100),
-		rtw_read8(adapter, 0x86)
-	);
-
 	if (rtw_read8(adapter, 0x100) == 0xEA)
 		return true;
 	else
@@ -865,7 +857,6 @@ static struct recv_buf *sd_recv_rxfifo(struct adapter *adapter, u32 size)
 		}
 
 		if (!recvbuf->pskb) {
-			DBG_871X("%s: alloc_skb fail! read =%d\n", __func__, readsize);
 			return NULL;
 		}
 	}
@@ -968,7 +959,7 @@ void sd_int_dpc(struct adapter *adapter)
 		} else {
 			/* Error handling for malloc fail */
 			if (rtw_cbuf_push(adapter->evtpriv.c2h_queue, NULL) != _SUCCESS)
-				DBG_871X("%s rtw_cbuf_push fail\n", __func__);
+				{}
 			_set_workitem(&adapter->evtpriv.c2h_wk);
 		}
 	}
@@ -993,7 +984,6 @@ void sd_int_dpc(struct adapter *adapter)
 					sd_rxhandler(adapter, recvbuf);
 				else {
 					alloc_fail_time++;
-					DBG_871X("recvbuf is Null for %d times because alloc memory failed\n", alloc_fail_time);
 					if (alloc_fail_time >= 10)
 						break;
 				}
@@ -1009,7 +999,7 @@ void sd_int_dpc(struct adapter *adapter)
 		} while (1);
 
 		if (alloc_fail_time == 10)
-			DBG_871X("exit because alloc memory failed more than 10 times\n");
+			{}
 
 	}
 }
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 42c0685e976e..aa2cd69d7056 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -237,7 +237,6 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 
 	bssinf_len = pnetwork->network.IELength + sizeof(struct ieee80211_hdr_3addr);
 	if (bssinf_len > MAX_BSSINFO_LEN) {
-		DBG_871X("%s IE Length too long > %d byte\n", __func__, MAX_BSSINFO_LEN);
 		goto exit;
 	}
 
@@ -248,7 +247,6 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 		{
 			if (wapi_len > 0)
 			{
-				DBG_871X("%s, no support wapi!\n", __func__);
 				goto exit;
 			}
 		}
@@ -281,7 +279,6 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 				else if (pssid->SsidLength == ssids[0].ssid_len &&
 					!memcmp(pssid->Ssid, ssids[0].ssid, ssids[0].ssid_len))
 				{
-					DBG_871X("%s, got sr and ssid match!\n", __func__);
 				}
 				else
 				{
@@ -395,7 +392,6 @@ void rtw_cfg80211_ibss_indicate_connect(struct adapter *padapter)
 	int freq = (int)cur_network->network.Configuration.DSConfig;
 	struct ieee80211_channel *chan;
 
-	DBG_871X(FUNC_ADPT_FMT"\n", FUNC_ADPT_ARG(padapter));
 	if (pwdev->iftype != NL80211_IFTYPE_ADHOC)
 	{
 		return;
@@ -410,9 +406,9 @@ void rtw_cfg80211_ibss_indicate_connect(struct adapter *padapter)
 
 			memcpy(&cur_network->network, pnetwork, sizeof(struct wlan_bssid_ex));
 			if (!rtw_cfg80211_inform_bss(padapter, cur_network))
-				DBG_871X(FUNC_ADPT_FMT" inform fail !!\n", FUNC_ADPT_ARG(padapter));
+				{}
 			else
-				DBG_871X(FUNC_ADPT_FMT" inform success !!\n", FUNC_ADPT_ARG(padapter));
+				{}
 		}
 		else
 		{
@@ -424,12 +420,10 @@ void rtw_cfg80211_ibss_indicate_connect(struct adapter *padapter)
 				&& !memcmp(scanned->network.MacAddress, pnetwork->MacAddress, sizeof(NDIS_802_11_MAC_ADDRESS))
 			) {
 				if (!rtw_cfg80211_inform_bss(padapter, scanned)) {
-					DBG_871X(FUNC_ADPT_FMT" inform fail !!\n", FUNC_ADPT_ARG(padapter));
 				} else {
 					/* DBG_871X(FUNC_ADPT_FMT" inform success !!\n", FUNC_ADPT_ARG(padapter)); */
 				}
 			} else {
-				DBG_871X("scanned & pnetwork compare fail\n");
 				rtw_warn_on(1);
 			}
 		}
@@ -448,7 +442,6 @@ void rtw_cfg80211_indicate_connect(struct adapter *padapter)
 	struct wlan_network  *cur_network = &(pmlmepriv->cur_network);
 	struct wireless_dev *pwdev = padapter->rtw_wdev;
 
-	DBG_871X(FUNC_ADPT_FMT"\n", FUNC_ADPT_ARG(padapter));
 	if (pwdev->iftype != NL80211_IFTYPE_STATION
 		&& pwdev->iftype != NL80211_IFTYPE_P2P_CLIENT
 	) {
@@ -473,15 +466,10 @@ void rtw_cfg80211_indicate_connect(struct adapter *padapter)
 			&& !memcmp(&(scanned->network.Ssid), &(pnetwork->Ssid), sizeof(struct ndis_802_11_ssid))
 		) {
 			if (!rtw_cfg80211_inform_bss(padapter, scanned)) {
-				DBG_871X(FUNC_ADPT_FMT" inform fail !!\n", FUNC_ADPT_ARG(padapter));
 			} else {
 				/* DBG_871X(FUNC_ADPT_FMT" inform success !!\n", FUNC_ADPT_ARG(padapter)); */
 			}
 		} else {
-			DBG_871X("scanned: %s(%pM), cur: %s(%pM)\n",
-				scanned->network.Ssid.Ssid, MAC_ARG(scanned->network.MacAddress),
-				pnetwork->Ssid.Ssid, MAC_ARG(pnetwork->MacAddress)
-			);
 			rtw_warn_on(1);
 		}
 	}
@@ -501,7 +489,6 @@ void rtw_cfg80211_indicate_connect(struct adapter *padapter)
 
 		notify_channel = ieee80211_get_channel(wiphy, freq);
 
-		DBG_871X(FUNC_ADPT_FMT" call cfg80211_roamed\n", FUNC_ADPT_ARG(padapter));
 		roam_info.channel = notify_channel;
 		roam_info.bssid = cur_network->network.MacAddress;
 		roam_info.req_ie =
@@ -530,8 +517,6 @@ void rtw_cfg80211_indicate_disconnect(struct adapter *padapter)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct wireless_dev *pwdev = padapter->rtw_wdev;
 
-	DBG_871X(FUNC_ADPT_FMT"\n", FUNC_ADPT_ARG(padapter));
-
 	if (pwdev->iftype != NL80211_IFTYPE_STATION
 		&& pwdev->iftype != NL80211_IFTYPE_P2P_CLIENT
 	) {
@@ -958,9 +943,6 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 						/* _set_timer(&padapter->securitypriv.tkip_timer, 50); */
 					}
 
-					/* DEBUG_ERR((" param->u.crypt.key_len =%d\n", param->u.crypt.key_len)); */
-					DBG_871X(" ~~~~set sta key:unicastkey\n");
-
 					rtw_setstakey_cmd(padapter, psta, true, true);
 				}
 				else/* group key */
@@ -971,8 +953,6 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 						memcpy(padapter->securitypriv.dot118021XGrptxmickey[param->u.crypt.idx].skey, &(param->u.crypt.key[16]), 8);
 						memcpy(padapter->securitypriv.dot118021XGrprxmickey[param->u.crypt.idx].skey, &(param->u.crypt.key[24]), 8);
 	                                        padapter->securitypriv.binstallGrpkey = true;
-						/* DEBUG_ERR((" param->u.crypt.key_len =%d\n", param->u.crypt.key_len)); */
-						DBG_871X(" ~~~~set sta key:groupkey\n");
 
 						padapter->securitypriv.dot118021XGrpKeyid = param->u.crypt.idx;
 						rtw_set_key(padapter, &padapter->securitypriv, param->u.crypt.idx, 1, true);
@@ -988,7 +968,6 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 						DBG_871X("\n");*/
 						padapter->securitypriv.dot11wBIPKeyid = param->u.crypt.idx;
 						padapter->securitypriv.binstallBIPkey = true;
-						DBG_871X(" ~~~~set sta key:IGKT\n");
 					}
 				}
 			}
@@ -1034,13 +1013,6 @@ static int cfg80211_rtw_add_key(struct wiphy *wiphy, struct net_device *ndev,
 	struct adapter *padapter = rtw_netdev_priv(ndev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	DBG_871X(FUNC_NDEV_FMT" adding key for %pM\n", FUNC_NDEV_ARG(ndev), mac_addr);
-	DBG_871X("cipher = 0x%x\n", params->cipher);
-	DBG_871X("key_len = 0x%x\n", params->key_len);
-	DBG_871X("seq_len = 0x%x\n", params->seq_len);
-	DBG_871X("key_index =%d\n", key_index);
-	DBG_871X("pairwise =%d\n", pairwise);
-
 	param_len = sizeof(struct ieee_param) + params->key_len;
 	param = rtw_malloc(param_len);
 	if (param == NULL)
@@ -1134,7 +1106,6 @@ static int cfg80211_rtw_get_key(struct wiphy *wiphy, struct net_device *ndev,
 				void (*callback)(void *cookie,
 						 struct key_params*))
 {
-	DBG_871X(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(ndev));
 	return 0;
 }
 
@@ -1144,8 +1115,6 @@ static int cfg80211_rtw_del_key(struct wiphy *wiphy, struct net_device *ndev,
 	struct adapter *padapter = rtw_netdev_priv(ndev);
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 
-	DBG_871X(FUNC_NDEV_FMT" key_index =%d\n", FUNC_NDEV_ARG(ndev), key_index);
-
 	if (key_index == psecuritypriv->dot11PrivacyKeyIndex)
 	{
 		/* clear the flag of wep default key set. */
@@ -1163,9 +1132,6 @@ static int cfg80211_rtw_set_default_key(struct wiphy *wiphy,
 	struct adapter *padapter = rtw_netdev_priv(ndev);
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 
-	DBG_871X(FUNC_NDEV_FMT" key_index =%d, unicast =%d, multicast =%d\n",
-		 FUNC_NDEV_ARG(ndev), key_index, unicast, multicast);
-
 	if ((key_index < WEP_KEYS) && ((psecuritypriv->dot11PrivacyAlgrthm == _WEP40_) || (psecuritypriv->dot11PrivacyAlgrthm == _WEP104_))) /* set wep default key */
 	{
 		psecuritypriv->ndisencryptstatus = Ndis802_11Encryption1Enabled;
@@ -1201,7 +1167,6 @@ static int cfg80211_rtw_get_station(struct wiphy *wiphy,
 	sinfo->filled = 0;
 
 	if (!mac) {
-		DBG_871X(FUNC_NDEV_FMT" mac ==%p\n", FUNC_NDEV_ARG(ndev), mac);
 		ret = -ENOENT;
 		goto exit;
 	}
@@ -1214,7 +1179,6 @@ static int cfg80211_rtw_get_station(struct wiphy *wiphy,
 	}
 
 #ifdef DEBUG_CFG80211
-	DBG_871X(FUNC_NDEV_FMT" mac =%pM\n", FUNC_NDEV_ARG(ndev), MAC_ARG(mac));
 #endif
 
 	/* for infra./P2PClient mode */
@@ -1225,7 +1189,6 @@ static int cfg80211_rtw_get_station(struct wiphy *wiphy,
 		struct wlan_network  *cur_network = &(pmlmepriv->cur_network);
 
 		if (memcmp((u8 *)mac, cur_network->network.MacAddress, ETH_ALEN)) {
-			DBG_871X("%s, mismatch bssid =%pM\n", __func__, MAC_ARG(cur_network->network.MacAddress));
 			ret = -ENOENT;
 			goto exit;
 		}
@@ -1270,8 +1233,6 @@ static int cfg80211_rtw_change_iface(struct wiphy *wiphy,
 	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
 	int ret = 0;
 
-	DBG_871X(FUNC_NDEV_FMT" type =%d\n", FUNC_NDEV_ARG(ndev), type);
-
 	if (adapter_to_dvobj(padapter)->processing_dev_remove == true)
 	{
 		ret = -EPERM;
@@ -1279,23 +1240,18 @@ static int cfg80211_rtw_change_iface(struct wiphy *wiphy,
 	}
 
 	{
-		DBG_871X(FUNC_NDEV_FMT" call netdev_open\n", FUNC_NDEV_ARG(ndev));
 		if (netdev_open(ndev) != 0) {
-			DBG_871X(FUNC_NDEV_FMT" call netdev_open fail\n", FUNC_NDEV_ARG(ndev));
 			ret = -EPERM;
 			goto exit;
 		}
 	}
 
 	if (_FAIL == rtw_pwr_wakeup(padapter)) {
-		DBG_871X(FUNC_NDEV_FMT" call rtw_pwr_wakeup fail\n", FUNC_NDEV_ARG(ndev));
 		ret = -EPERM;
 		goto exit;
 	}
 
 	old_type = rtw_wdev->iftype;
-	DBG_871X(FUNC_NDEV_FMT" old_iftype =%d, new_iftype =%d\n",
-		FUNC_NDEV_ARG(ndev), old_type, type);
 
 	if (old_type != type)
 	{
@@ -1331,7 +1287,6 @@ static int cfg80211_rtw_change_iface(struct wiphy *wiphy,
 
 exit:
 
-	DBG_871X(FUNC_NDEV_FMT" ret:%d\n", FUNC_NDEV_ARG(ndev), ret);
 	return ret;
 }
 
@@ -1345,7 +1300,6 @@ void rtw_cfg80211_indicate_scan_done(struct adapter *adapter, bool aborted)
 	spin_lock_bh(&pwdev_priv->scan_req_lock);
 	if (pwdev_priv->scan_request) {
 		#ifdef DEBUG_CFG80211
-		DBG_871X("%s with scan req\n", __func__);
 		#endif
 
 		/* avoid WARN_ON(request != wiphy_to_dev(request->wiphy)->scan_req); */
@@ -1361,7 +1315,6 @@ void rtw_cfg80211_indicate_scan_done(struct adapter *adapter, bool aborted)
 		pwdev_priv->scan_request = NULL;
 	} else {
 		#ifdef DEBUG_CFG80211
-		DBG_871X("%s without scan req\n", __func__);
 		#endif
 	}
 	spin_unlock_bh(&pwdev_priv->scan_req_lock);
@@ -1492,9 +1445,6 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	padapter = rtw_netdev_priv(ndev);
 	pwdev_priv = adapter_wdev_data(padapter);
 	pmlmepriv = &padapter->mlmepriv;
-
-/* ifdef DEBUG_CFG80211 */
-	DBG_871X(FUNC_ADPT_FMT"\n", FUNC_ADPT_ARG(padapter));
 /* endif */
 
 	spin_lock_bh(&pwdev_priv->scan_req_lock);
@@ -1504,7 +1454,6 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true)
 	{
 #ifdef DEBUG_CFG80211
-		DBG_871X("%s under WIFI_AP_STATE\n", __func__);
 #endif
 
 		if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS|_FW_UNDER_SURVEY|_FW_UNDER_LINKING) == true)
@@ -1551,14 +1500,12 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 		lastscantime = jiffies;
 		if (passtime > 12000)
 		{
-			DBG_871X("%s: bBusyTraffic == true\n", __func__);
 			need_indicate_scan_done = true;
 			goto check_need_indicate_scan_done;
 		}
 	}
 
 	if (rtw_is_scan_deny(padapter)) {
-		DBG_871X(FUNC_ADPT_FMT  ": scan deny\n", FUNC_ADPT_ARG(padapter));
 		need_indicate_scan_done = true;
 		goto check_need_indicate_scan_done;
 	}
@@ -1583,7 +1530,6 @@ static int cfg80211_rtw_scan(struct wiphy *wiphy
 	memset(ch, 0, sizeof(struct rtw_ieee80211_channel)*RTW_CHANNEL_SCAN_AMOUNT);
 	for (i = 0; i < request->n_channels && i < RTW_CHANNEL_SCAN_AMOUNT; i++) {
 		#ifdef DEBUG_CFG80211
-		DBG_871X(FUNC_ADPT_FMT CHAN_FMT"\n", FUNC_ADPT_ARG(padapter), CHAN_ARG(request->channels[i]));
 		#endif
 		ch[i].hw_value = request->channels[i]->hw_value;
 		ch[i].flags = request->channels[i]->flags;
@@ -1967,8 +1913,6 @@ static int cfg80211_rtw_leave_ibss(struct wiphy *wiphy, struct net_device *ndev)
 	enum nl80211_iftype old_type;
 	int ret = 0;
 
-	DBG_871X(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(ndev));
-
 	old_type = rtw_wdev->iftype;
 
 	rtw_set_to_roam(padapter, 0);
@@ -2004,14 +1948,9 @@ static int cfg80211_rtw_connect(struct wiphy *wiphy, struct net_device *ndev,
 
 	padapter->mlmepriv.not_indic_disco = true;
 
-	DBG_871X("=>"FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(ndev));
-	DBG_871X("privacy =%d, key =%p, key_len =%d, key_idx =%d\n",
-		sme->privacy, sme->key, sme->key_len, sme->key_idx);
-
 
 	if (adapter_wdev_data(padapter)->block == true) {
 		ret = -EBUSY;
-		DBG_871X("%s wdev_priv.block is set\n", __func__);
 		goto exit;
 	}
 
@@ -2089,7 +2028,6 @@ static int cfg80211_rtw_connect(struct wiphy *wiphy, struct net_device *ndev,
 	    psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_Auto) && sme->key) {
 		u32 wep_key_idx, wep_key_len, wep_total_len;
 		struct ndis_802_11_wep	 *pwep = NULL;
-		DBG_871X("%s(): Shared/Auto WEP\n", __func__);
 
 		wep_key_idx = sme->key_idx;
 		wep_key_len = sme->key_len;
@@ -2104,7 +2042,6 @@ static int cfg80211_rtw_connect(struct wiphy *wiphy, struct net_device *ndev,
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
 			pwep = rtw_malloc(wep_total_len);
 			if (pwep == NULL) {
-				DBG_871X(" wpa_set_encryption: pwep allocate fail !!!\n");
 				ret = -ENOMEM;
 				goto exit;
 			}
@@ -2175,22 +2112,17 @@ static int cfg80211_rtw_disconnect(struct wiphy *wiphy, struct net_device *ndev,
 {
 	struct adapter *padapter = rtw_netdev_priv(ndev);
 
-	DBG_871X(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(ndev));
-
 	rtw_set_to_roam(padapter, 0);
 
 	rtw_scan_abort(padapter);
 	LeaveAllPowerSaveMode(padapter);
 	rtw_disassoc_cmd(padapter, 500, false);
 
-	DBG_871X("%s...call rtw_indicate_disconnect\n", __func__);
-
 	rtw_indicate_disconnect(padapter);
 
 	rtw_free_assoc_resources(padapter, 1);
 	rtw_pwr_wakeup(padapter);
 
-	DBG_871X(FUNC_NDEV_FMT" return 0\n", FUNC_NDEV_ARG(ndev));
 	return 0;
 }
 
@@ -2223,9 +2155,6 @@ static int cfg80211_rtw_set_power_mgmt(struct wiphy *wiphy,
 	struct adapter *padapter = rtw_netdev_priv(ndev);
 	struct rtw_wdev_priv *rtw_wdev_priv = adapter_wdev_data(padapter);
 
-	DBG_871X(FUNC_NDEV_FMT" enabled:%u, timeout:%d\n", FUNC_NDEV_ARG(ndev),
-		enabled, timeout);
-
 	rtw_wdev_priv->power_mgmt = enabled;
 
 	if (!enabled)
@@ -2243,8 +2172,6 @@ static int cfg80211_rtw_set_pmksa(struct wiphy *wiphy,
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	u8 strZeroMacAddress[ETH_ALEN] = { 0x00 };
 
-	DBG_871X(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(ndev));
-
 	if (!memcmp((u8 *)pmksa->bssid, strZeroMacAddress, ETH_ALEN))
 		return -EINVAL;
 
@@ -2253,8 +2180,6 @@ static int cfg80211_rtw_set_pmksa(struct wiphy *wiphy,
 	/* overwrite PMKID */
 	for (index = 0 ; index < NUM_PMKID_CACHE; index++) {
 		if (!memcmp(psecuritypriv->PMKIDList[index].Bssid, (u8 *)pmksa->bssid, ETH_ALEN)) {
-			/*  BSSID is matched, the same AP => rewrite with new PMKID. */
-			DBG_871X(FUNC_NDEV_FMT" BSSID exists in the PMKList.\n", FUNC_NDEV_ARG(ndev));
 
 			memcpy(psecuritypriv->PMKIDList[index].PMKID, (u8 *)pmksa->pmkid, WLAN_PMKID_LEN);
 			psecuritypriv->PMKIDList[index].bUsed = true;
@@ -2265,9 +2190,6 @@ static int cfg80211_rtw_set_pmksa(struct wiphy *wiphy,
 	}
 
 	if (!blInserted) {
-		/*  Find a new entry */
-		DBG_871X(FUNC_NDEV_FMT" Use the new entry index = %d for this PMKID.\n",
-			FUNC_NDEV_ARG(ndev), psecuritypriv->PMKIDIndex);
 
 		memcpy(psecuritypriv->PMKIDList[psecuritypriv->PMKIDIndex].Bssid, (u8 *)pmksa->bssid, ETH_ALEN);
 		memcpy(psecuritypriv->PMKIDList[psecuritypriv->PMKIDIndex].PMKID, (u8 *)pmksa->pmkid, WLAN_PMKID_LEN);
@@ -2289,8 +2211,6 @@ static int cfg80211_rtw_del_pmksa(struct wiphy *wiphy,
 	struct adapter *padapter = rtw_netdev_priv(ndev);
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 
-	DBG_871X(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(ndev));
-
 	for (index = 0 ; index < NUM_PMKID_CACHE; index++) {
 		if (!memcmp(psecuritypriv->PMKIDList[index].Bssid, (u8 *)pmksa->bssid, ETH_ALEN)) {
 			/*
@@ -2306,8 +2226,6 @@ static int cfg80211_rtw_del_pmksa(struct wiphy *wiphy,
 	}
 
 	if (false == bMatched) {
-		DBG_871X(FUNC_NDEV_FMT" do not have matched BSSID\n"
-			, FUNC_NDEV_ARG(ndev));
 		return -EINVAL;
 	}
 
@@ -2320,8 +2238,6 @@ static int cfg80211_rtw_flush_pmksa(struct wiphy *wiphy,
 	struct adapter *padapter = rtw_netdev_priv(ndev);
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 
-	DBG_871X(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(ndev));
-
 	memset(&psecuritypriv->PMKIDList[0], 0x00, sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
 	psecuritypriv->PMKIDIndex = 0;
 
@@ -2332,8 +2248,6 @@ void rtw_cfg80211_indicate_sta_assoc(struct adapter *padapter, u8 *pmgmt_frame,
 {
 	struct net_device *ndev = padapter->pnetdev;
 
-	DBG_871X(FUNC_ADPT_FMT"\n", FUNC_ADPT_ARG(padapter));
-
 	{
 		struct station_info sinfo;
 		u8 ie_offset;
@@ -2353,8 +2267,6 @@ void rtw_cfg80211_indicate_sta_disassoc(struct adapter *padapter, unsigned char
 {
 	struct net_device *ndev = padapter->pnetdev;
 
-	DBG_871X(FUNC_ADPT_FMT"\n", FUNC_ADPT_ARG(padapter));
-
 	cfg80211_del_sta(ndev, da, GFP_ATOMIC);
 }
 
@@ -2374,8 +2286,6 @@ static netdev_tx_t rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struc
 	struct ieee80211_radiotap_header *rtap_hdr;
 	struct adapter *padapter = rtw_netdev_priv(ndev);
 
-	DBG_871X(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(ndev));
-
 	if (!skb)
 		goto fail;
 
@@ -2450,9 +2360,9 @@ static netdev_tx_t rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struc
 		DBG_8192C("RTW_Tx:da =%pM via "FUNC_NDEV_FMT"\n",
 			MAC_ARG(GetAddr1Ptr(buf)), FUNC_NDEV_ARG(ndev));
 		if (category == RTW_WLAN_CATEGORY_PUBLIC)
-			DBG_871X("RTW_Tx:%s\n", action_public_str(action));
+			{}
 		else
-			DBG_871X("RTW_Tx:category(%u), action(%u)\n", category, action);
+			{}
 
 		/* starting alloc mgmt frame to dump it */
 		pmgntframe = alloc_mgtxmitframe(pxmitpriv);
@@ -2510,21 +2420,17 @@ static int rtw_cfg80211_add_monitor_if(struct adapter *padapter, char *name, str
 	struct rtw_wdev_priv *pwdev_priv = adapter_wdev_data(padapter);
 
 	if (!name) {
-		DBG_871X(FUNC_ADPT_FMT" without specific name\n", FUNC_ADPT_ARG(padapter));
 		ret = -EINVAL;
 		goto out;
 	}
 
 	if (pwdev_priv->pmon_ndev) {
-		DBG_871X(FUNC_ADPT_FMT" monitor interface exist: %s\n",
-			FUNC_ADPT_ARG(padapter), NDEV_ARG(pwdev_priv->pmon_ndev));
 		ret = -EBUSY;
 		goto out;
 	}
 
 	mon_ndev = alloc_etherdev(sizeof(struct rtw_netdev_priv_indicator));
 	if (!mon_ndev) {
-		DBG_871X(FUNC_ADPT_FMT" allocate ndev fail\n", FUNC_ADPT_ARG(padapter));
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -2544,7 +2450,6 @@ static int rtw_cfg80211_add_monitor_if(struct adapter *padapter, char *name, str
 	/*  wdev */
 	mon_wdev = rtw_zmalloc(sizeof(struct wireless_dev));
 	if (!mon_wdev) {
-		DBG_871X(FUNC_ADPT_FMT" allocate mon_wdev fail\n", FUNC_ADPT_ARG(padapter));
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -2587,9 +2492,6 @@ static struct wireless_dev *
 	struct net_device *ndev = NULL;
 	struct adapter *padapter = wiphy_to_adapter(wiphy);
 
-	DBG_871X(FUNC_ADPT_FMT " wiphy:%s, name:%s, type:%d\n",
-		FUNC_ADPT_ARG(padapter), wiphy_name(wiphy), name, type);
-
 	switch (type) {
 	case NL80211_IFTYPE_ADHOC:
 	case NL80211_IFTYPE_AP_VLAN:
@@ -2610,12 +2512,9 @@ static struct wireless_dev *
 		break;
 	default:
 		ret = -ENODEV;
-		DBG_871X("Unsupported interface type\n");
 		break;
 	}
 
-	DBG_871X(FUNC_ADPT_FMT" ndev:%p, ret:%d\n", FUNC_ADPT_ARG(padapter), ndev, ret);
-
 	return ndev ? ndev->ieee80211_ptr : ERR_PTR(ret);
 }
 
@@ -2641,7 +2540,6 @@ static int cfg80211_rtw_del_virtual_intf(struct wiphy *wiphy,
 	if (ndev == pwdev_priv->pmon_ndev) {
 		pwdev_priv->pmon_ndev = NULL;
 		pwdev_priv->ifname_mon[0] = '\0';
-		DBG_871X(FUNC_NDEV_FMT" remove monitor interface\n", FUNC_NDEV_ARG(ndev));
 	}
 
 exit:
@@ -2698,9 +2596,6 @@ static int cfg80211_rtw_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 	int ret = 0;
 	struct adapter *adapter = rtw_netdev_priv(ndev);
 
-	DBG_871X(FUNC_NDEV_FMT" hidden_ssid:%d, auth_type:%d\n", FUNC_NDEV_ARG(ndev),
-		settings->hidden_ssid, settings->auth_type);
-
 	ret = rtw_add_beacon(adapter, settings->beacon.head, settings->beacon.head_len,
 		settings->beacon.tail, settings->beacon.tail_len);
 
@@ -2724,14 +2619,11 @@ static int cfg80211_rtw_change_beacon(struct wiphy *wiphy, struct net_device *nd
 {
 	struct adapter *adapter = rtw_netdev_priv(ndev);
 
-	DBG_871X(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(ndev));
-
 	return rtw_add_beacon(adapter, info->head, info->head_len, info->tail, info->tail_len);
 }
 
 static int cfg80211_rtw_stop_ap(struct wiphy *wiphy, struct net_device *ndev)
 {
-	DBG_871X(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(ndev));
 	return 0;
 }
 
@@ -2739,8 +2631,6 @@ static int	cfg80211_rtw_add_station(struct wiphy *wiphy, struct net_device *ndev
 				const u8 *mac,
 			struct station_parameters *params)
 {
-	DBG_871X(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(ndev));
-
 	return 0;
 }
 
@@ -2756,8 +2646,6 @@ static int cfg80211_rtw_del_station(struct wiphy *wiphy, struct net_device *ndev
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	const u8 *mac = params->mac;
 
-	DBG_871X("+"FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(ndev));
-
 	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true) {
 		DBG_8192C("%s, fw_state != FW_LINKED|WIFI_AP_STATE\n", __func__);
 		return -EINVAL;
@@ -2819,8 +2707,6 @@ static int cfg80211_rtw_del_station(struct wiphy *wiphy, struct net_device *ndev
 
 	associated_clients_update(padapter, updated);
 
-	DBG_871X("-"FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(ndev));
-
 	return ret;
 
 }
@@ -2828,8 +2714,6 @@ static int cfg80211_rtw_del_station(struct wiphy *wiphy, struct net_device *ndev
 static int cfg80211_rtw_change_station(struct wiphy *wiphy, struct net_device *ndev,
 				  const u8 *mac, struct station_parameters *params)
 {
-	DBG_871X(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(ndev));
-
 	return 0;
 }
 
@@ -2861,13 +2745,11 @@ static int	cfg80211_rtw_dump_station(struct wiphy *wiphy, struct net_device *nde
 	struct adapter *padapter = rtw_netdev_priv(ndev);
 	struct sta_info *psta = NULL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
-	DBG_871X(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(ndev));
 
 	spin_lock_bh(&pstapriv->asoc_list_lock);
 	psta = rtw_sta_info_get_by_idx(idx, pstapriv);
 	spin_unlock_bh(&pstapriv->asoc_list_lock);
 	if (NULL == psta) {
-		DBG_871X("Station is not found\n");
 		ret = -ENOENT;
 		goto exit;
 	}
@@ -2882,7 +2764,6 @@ static int	cfg80211_rtw_dump_station(struct wiphy *wiphy, struct net_device *nde
 static int	cfg80211_rtw_change_bss(struct wiphy *wiphy, struct net_device *ndev,
 			      struct bss_parameters *params)
 {
-	DBG_871X(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(ndev));
 	return 0;
 }
 
@@ -2898,9 +2779,9 @@ void rtw_cfg80211_rx_action(struct adapter *adapter, u8 *frame, uint frame_len,
 
 	DBG_8192C("RTW_Rx:cur_ch =%d\n", channel);
 	if (msg)
-		DBG_871X("RTW_Rx:%s\n", msg);
+		{}
 	else
-		DBG_871X("RTW_Rx:category(%u), action(%u)\n", category, action);
+		{}
 
 	freq = rtw_ieee80211_channel_to_frequency(channel, NL80211_BAND_2GHZ);
 
@@ -3013,10 +2894,6 @@ static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy,
 	*cookie = (unsigned long) buf;
 
 #ifdef DEBUG_CFG80211
-	DBG_871X(FUNC_ADPT_FMT" len =%zu, ch =%d"
-		"\n", FUNC_ADPT_ARG(padapter),
-		len, tx_ch
-	);
 #endif /* DEBUG_CFG80211 */
 
 	/* indicate ack before issue frame to avoid racing with rsp frame */
@@ -3030,9 +2907,9 @@ static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy,
 
 	DBG_8192C("RTW_Tx:tx_ch =%d, da =%pM\n", tx_ch, MAC_ARG(GetAddr1Ptr(buf)));
 	if (category == RTW_WLAN_CATEGORY_PUBLIC)
-		DBG_871X("RTW_Tx:%s\n", action_public_str(action));
+		{}
 	else
-		DBG_871X("RTW_Tx:category(%u), action(%u)\n", category, action);
+		{}
 
 	rtw_ps_deny(padapter, PS_DENY_MGNT_TX);
 	if (_FAIL == rtw_pwr_wakeup(padapter)) {
@@ -3046,8 +2923,6 @@ static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy,
 	} while (dump_cnt < dump_limit && tx_ret != _SUCCESS);
 
 	if (tx_ret != _SUCCESS || dump_cnt > 1) {
-		DBG_871X(FUNC_ADPT_FMT" %s (%d/%d)\n", FUNC_ADPT_ARG(padapter),
-			tx_ret == _SUCCESS?"OK":"FAIL", dump_cnt, dump_limit);
 	}
 
 	switch (type) {
@@ -3056,8 +2931,6 @@ static int cfg80211_rtw_mgmt_tx(struct wiphy *wiphy,
 		break;
 	case P2P_INVIT_RESP:
 		if (pwdev_priv->invit_info.flags & BIT(0) && pwdev_priv->invit_info.status == 0) {
-			DBG_871X(FUNC_ADPT_FMT" agree with invitation of persistent group\n",
-				FUNC_ADPT_ARG(padapter));
 			rtw_set_scan_deny(padapter, 5000);
 			rtw_pwr_wakeup_ex(padapter, 5000);
 			rtw_clear_scan_deny(padapter);
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 297287cff5be..17c7730f1434 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -360,27 +360,22 @@ static int wpa_set_auth_algs(struct net_device *dev, u32 value)
 	int ret = 0;
 
 	if ((value & WLAN_AUTH_SHARED_KEY) && (value & WLAN_AUTH_OPEN)) {
-		DBG_871X("wpa_set_auth_algs, WLAN_AUTH_SHARED_KEY and WLAN_AUTH_OPEN [value:0x%x]\n", value);
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
 		padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeAutoSwitch;
 		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Auto;
 	} else if (value & WLAN_AUTH_SHARED_KEY)	{
-		DBG_871X("wpa_set_auth_algs, WLAN_AUTH_SHARED_KEY  [value:0x%x]\n", value);
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
 
 		padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeShared;
 		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Shared;
 	} else if (value & WLAN_AUTH_OPEN) {
-		DBG_871X("wpa_set_auth_algs, WLAN_AUTH_OPEN\n");
 		/* padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled; */
 		if (padapter->securitypriv.ndisauthtype < Ndis802_11AuthModeWPAPSK) {
 			padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeOpen;
 			padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
 		}
 	} else if (value & WLAN_AUTH_LEAP) {
-		DBG_871X("wpa_set_auth_algs, WLAN_AUTH_LEAP\n");
 	} else {
-		DBG_871X("wpa_set_auth_algs, error!\n");
 		ret = -EINVAL;
 	}
 
@@ -421,7 +416,6 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 	}
 
 	if (strcmp(param->u.crypt.alg, "WEP") == 0) {
-		DBG_871X("wpa_set_encryption, crypt.alg = WEP\n");
 
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
 		padapter->securitypriv.dot11PrivacyAlgrthm = _WEP40_;
@@ -430,8 +424,6 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 		wep_key_idx = param->u.crypt.idx;
 		wep_key_len = param->u.crypt.key_len;
 
-		DBG_871X("(1)wep_key_idx =%d\n", wep_key_idx);
-
 		if (wep_key_idx > WEP_KEYS)
 			return -EINVAL;
 
@@ -460,13 +452,9 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 		memcpy(pwep->KeyMaterial,  param->u.crypt.key, pwep->KeyLength);
 
 		if (param->u.crypt.set_tx) {
-			DBG_871X("wep, set_tx = 1\n");
-
 			if (rtw_set_802_11_add_wep(padapter, pwep) == (u8)_FAIL)
 				ret = -EOPNOTSUPP;
 		} else {
-			DBG_871X("wep, set_tx = 0\n");
-
 			/* don't update "psecuritypriv->dot11PrivacyAlgrthm" and */
 			/* psecuritypriv->dot11PrivacyKeyIndex =keyid", but can rtw_set_key to fw/cam */
 
@@ -513,9 +501,6 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 						/* _set_timer(&padapter->securitypriv.tkip_timer, 50); */
 					}
 
-					/* DEBUG_ERR((" param->u.crypt.key_len =%d\n", param->u.crypt.key_len)); */
-					DBG_871X(" ~~~~set sta key:unicastkey\n");
-
 					rtw_setstakey_cmd(padapter, psta, true, true);
 				} else { /* group key */
 					if (strcmp(param->u.crypt.alg, "TKIP") == 0 || strcmp(param->u.crypt.alg, "CCMP") == 0) {
@@ -526,8 +511,6 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 							memcpy(padapter->securitypriv.dot118021XGrprxmickey[param->u.crypt.idx].skey, &(param->u.crypt.key[24]), 8);
 						}
 						padapter->securitypriv.binstallGrpkey = true;
-						/* DEBUG_ERR((" param->u.crypt.key_len =%d\n", param->u.crypt.key_len)); */
-						DBG_871X(" ~~~~set sta key:groupkey\n");
 
 						padapter->securitypriv.dot118021XGrpKeyid = param->u.crypt.idx;
 
@@ -542,7 +525,6 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 						printk("\n");*/
 						padapter->securitypriv.dot11wBIPKeyid = param->u.crypt.idx;
 						padapter->securitypriv.binstallBIPkey = true;
-						DBG_871X(" ~~~~set sta key:IGKT\n");
 					}
 				}
 			}
@@ -598,9 +580,8 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 		/* dump */
 		{
 			int i;
-			DBG_871X("\n wpa_ie(length:%d):\n", ielen);
 			for (i = 0; i < ielen; i = i + 8)
-				DBG_871X("0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x\n", buf[i], buf[i+1], buf[i+2], buf[i+3], buf[i+4], buf[i+5], buf[i+6], buf[i+7]);
+				{}
 		}
 
 		if (ielen < RSN_HEADER_LEN) {
@@ -680,8 +661,6 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 				eid = buf[cnt];
 
 				if ((eid == WLAN_EID_VENDOR_SPECIFIC) && (!memcmp(&buf[cnt+2], wps_oui, 4))) {
-					DBG_871X("SET WPS_IE\n");
-
 					padapter->securitypriv.wps_ie_len = ((buf[cnt+1]+2) < MAX_WPS_IE_LEN) ? (buf[cnt+1]+2):MAX_WPS_IE_LEN;
 
 					memcpy(padapter->securitypriv.wps_ie, &buf[cnt], padapter->securitypriv.wps_ie_len);
@@ -816,20 +795,16 @@ static int rtw_wx_set_mode(struct net_device *dev, struct iw_request_info *a,
 	switch (wrqu->mode) {
 	case IW_MODE_AUTO:
 		networkType = Ndis802_11AutoUnknown;
-		DBG_871X("set_mode = IW_MODE_AUTO\n");
 		break;
 	case IW_MODE_ADHOC:
 		networkType = Ndis802_11IBSS;
-		DBG_871X("set_mode = IW_MODE_ADHOC\n");
 		break;
 	case IW_MODE_MASTER:
 		networkType = Ndis802_11APMode;
-		DBG_871X("set_mode = IW_MODE_MASTER\n");
 		/* rtw_setopmode_cmd(padapter, networkType, true); */
 		break;
 	case IW_MODE_INFRA:
 		networkType = Ndis802_11Infrastructure;
-		DBG_871X("set_mode = IW_MODE_INFRA\n");
 		break;
 	default:
 		ret = -EINVAL;
@@ -901,7 +876,6 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 
 	memcpy(strIssueBssid, pPMK->bssid.sa_data, ETH_ALEN);
         if (pPMK->cmd == IW_PMKSA_ADD) {
-                DBG_871X("[rtw_wx_set_pmkid] IW_PMKSA_ADD!\n");
                 if (!memcmp(strIssueBssid, strZeroMacAddress, ETH_ALEN))
 			return intReturn;
                 else
@@ -912,8 +886,6 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 		/* overwrite PMKID */
 		for (j = 0; j < NUM_PMKID_CACHE; j++) {
 			if (!memcmp(psecuritypriv->PMKIDList[j].Bssid, strIssueBssid, ETH_ALEN)) {
-				/*  BSSID is matched, the same AP => rewrite with new PMKID. */
-                                DBG_871X("[rtw_wx_set_pmkid] BSSID exists in the PMKList.\n");
 
 				memcpy(psecuritypriv->PMKIDList[j].PMKID, pPMK->pmkid, IW_PMKID_LEN);
                                 psecuritypriv->PMKIDList[j].bUsed = true;
@@ -924,9 +896,6 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 	        }
 
 	        if (!blInserted) {
-		    /*  Find a new entry */
-                    DBG_871X("[rtw_wx_set_pmkid] Use the new entry index = %d for this PMKID.\n",
-                            psecuritypriv->PMKIDIndex);
 
 	            memcpy(psecuritypriv->PMKIDList[psecuritypriv->PMKIDIndex].Bssid, strIssueBssid, ETH_ALEN);
 		    memcpy(psecuritypriv->PMKIDList[psecuritypriv->PMKIDIndex].PMKID, pPMK->pmkid, IW_PMKID_LEN);
@@ -937,7 +906,6 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 		        psecuritypriv->PMKIDIndex = 0;
 		}
 	} else if (pPMK->cmd == IW_PMKSA_REMOVE) {
-		DBG_871X("[rtw_wx_set_pmkid] IW_PMKSA_REMOVE!\n");
 		intReturn = true;
 		for (j = 0; j < NUM_PMKID_CACHE; j++) {
 			if (!memcmp(psecuritypriv->PMKIDList[j].Bssid, strIssueBssid, ETH_ALEN)) {
@@ -948,7 +916,6 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 			}
 	        }
 	} else if (pPMK->cmd == IW_PMKSA_FLUSH) {
-		DBG_871X("[rtw_wx_set_pmkid] IW_PMKSA_FLUSH!\n");
 		memset(&psecuritypriv->PMKIDList[0], 0x00, sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
 		psecuritypriv->PMKIDIndex = 0;
 		intReturn = true;
@@ -1182,8 +1149,6 @@ static int rtw_wx_set_mlme(struct net_device *dev,
 
 	reason = mlme->reason_code;
 
-	DBG_871X("%s, cmd =%d, reason =%d\n", __func__, mlme->cmd, reason);
-
 	switch (mlme->cmd) {
 	case IW_MLME_DEAUTH:
 		if (!rtw_set_802_11_disassociate(padapter))
@@ -1210,7 +1175,6 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 	struct ndis_802_11_ssid ssid[RTW_SSID_SCAN_AMOUNT];
 
 	#ifdef DBG_IOCTL
-	DBG_871X("DBG_IOCTL %s:%d\n", __func__, __LINE__);
 	#endif
 
 	rtw_ps_deny(padapter, PS_DENY_SCAN);
@@ -1220,7 +1184,6 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 	}
 
 	if (padapter->bDriverStopped) {
-		DBG_871X("bDriverStopped =%d\n", padapter->bDriverStopped);
 		ret = -1;
 		goto exit;
 	}
@@ -1259,8 +1222,6 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 			memcpy(ssid[0].Ssid, req->essid, len);
 			ssid[0].SsidLength = len;
 
-			DBG_871X("IW_SCAN_THIS_ESSID, ssid =%s, len =%d\n", req->essid, req->essid_len);
-
 			spin_lock_bh(&pmlmepriv->lock);
 
 			_status = rtw_sitesurvey_cmd(padapter, ssid, 1, NULL, 0);
@@ -1268,7 +1229,6 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 			spin_unlock_bh(&pmlmepriv->lock);
 
 		} else if (req->scan_type == IW_SCAN_TYPE_PASSIVE) {
-			DBG_871X("rtw_wx_set_scan, req->scan_type == IW_SCAN_TYPE_PASSIVE\n");
 		}
 
 	} else if (wrqu->data.length >= WEXT_CSCAN_HEADER_SIZE
@@ -1349,7 +1309,6 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 	rtw_ps_deny_cancel(padapter, PS_DENY_SCAN);
 
 	#ifdef DBG_IOCTL
-	DBG_871X("DBG_IOCTL %s:%d return %d\n", __func__, __LINE__, ret);
 	#endif
 
 	return ret;
@@ -1369,7 +1328,6 @@ static int rtw_wx_get_scan(struct net_device *dev, struct iw_request_info *a,
 	signed int wait_status;
 
 	#ifdef DBG_IOCTL
-	DBG_871X("DBG_IOCTL %s:%d\n", __func__, __LINE__);
 	#endif
 
 	if (adapter_to_pwrctl(padapter)->brfoffbyhw && padapter->bDriverStopped) {
@@ -1418,7 +1376,6 @@ static int rtw_wx_get_scan(struct net_device *dev, struct iw_request_info *a,
 exit:
 
 	#ifdef DBG_IOCTL
-	DBG_871X("DBG_IOCTL %s:%d return %d\n", __func__, __LINE__, ret);
 	#endif
 
 	return ret;
@@ -1446,7 +1403,6 @@ static int rtw_wx_set_essid(struct net_device *dev,
 	uint ret = 0, len;
 
 	#ifdef DBG_IOCTL
-	DBG_871X("DBG_IOCTL %s:%d\n", __func__, __LINE__);
 	#endif
 
 	rtw_ps_deny(padapter, PS_DENY_JOIN);
@@ -1475,7 +1431,7 @@ static int rtw_wx_set_essid(struct net_device *dev,
 		len = (wrqu->essid.length < IW_ESSID_MAX_SIZE) ? wrqu->essid.length : IW_ESSID_MAX_SIZE;
 
 		if (wrqu->essid.length != 33)
-			DBG_871X("ssid =%s, len =%d\n", extra, wrqu->essid.length);
+			{}
 
 		memset(&ndis_ssid, 0, sizeof(struct ndis_802_11_ssid));
 		ndis_ssid.SsidLength = len;
@@ -1525,10 +1481,7 @@ static int rtw_wx_set_essid(struct net_device *dev,
 
 	rtw_ps_deny_cancel(padapter, PS_DENY_JOIN);
 
-	DBG_871X("<=%s, ret %d\n", __func__, ret);
-
 	#ifdef DBG_IOCTL
-	DBG_871X("DBG_IOCTL %s:%d return %d\n", __func__, __LINE__, ret);
 	#endif
 
 	return ret;
@@ -1672,8 +1625,6 @@ static int rtw_wx_set_rts(struct net_device *dev,
 		padapter->registrypriv.rts_thresh = wrqu->rts.value;
 	}
 
-	DBG_871X("%s, rts_thresh =%d\n", __func__, padapter->registrypriv.rts_thresh);
-
 	return 0;
 }
 
@@ -1683,8 +1634,6 @@ static int rtw_wx_get_rts(struct net_device *dev,
 {
 	struct adapter *padapter = rtw_netdev_priv(dev);
 
-	DBG_871X("%s, rts_thresh =%d\n", __func__, padapter->registrypriv.rts_thresh);
-
 	wrqu->rts.value = padapter->registrypriv.rts_thresh;
 	wrqu->rts.fixed = 0;	/* no auto select */
 	/* wrqu->rts.disabled = (wrqu->rts.value == DEFAULT_RTS_THRESHOLD); */
@@ -1708,8 +1657,6 @@ static int rtw_wx_set_frag(struct net_device *dev,
 		padapter->xmitpriv.frag_len = wrqu->frag.value & ~0x1;
 	}
 
-	DBG_871X("%s, frag_len =%d\n", __func__, padapter->xmitpriv.frag_len);
-
 	return 0;
 
 }
@@ -1720,8 +1667,6 @@ static int rtw_wx_get_frag(struct net_device *dev,
 {
 	struct adapter *padapter = rtw_netdev_priv(dev);
 
-	DBG_871X("%s, frag_len =%d\n", __func__, padapter->xmitpriv.frag_len);
-
 	wrqu->frag.value = padapter->xmitpriv.frag_len;
 	wrqu->frag.fixed = 0;	/* no auto select */
 	/* wrqu->frag.disabled = (wrqu->frag.value == DEFAULT_FRAG_THRESHOLD); */
@@ -1756,14 +1701,12 @@ static int rtw_wx_set_enc(struct net_device *dev,
 	struct iw_point *erq = &(wrqu->encoding);
 	struct adapter *padapter = rtw_netdev_priv(dev);
 	struct pwrctrl_priv *pwrpriv = adapter_to_pwrctl(padapter);
-	DBG_871X("+rtw_wx_set_enc, flags = 0x%x\n", erq->flags);
 
 	memset(&wep, 0, sizeof(struct ndis_802_11_wep));
 
 	key = erq->flags & IW_ENCODE_INDEX;
 
 	if (erq->flags & IW_ENCODE_DISABLED) {
-		DBG_871X("EncryptionDisabled\n");
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled;
 		padapter->securitypriv.dot11PrivacyAlgrthm = _NO_PRIVACY_;
 		padapter->securitypriv.dot118021XGrpPrivacy = _NO_PRIVACY_;
@@ -1782,12 +1725,10 @@ static int rtw_wx_set_enc(struct net_device *dev,
 	} else {
 		keyindex_provided = 0;
 		key = padapter->securitypriv.dot11PrivacyKeyIndex;
-		DBG_871X("rtw_wx_set_enc, key =%d\n", key);
 	}
 
 	/* set authentication mode */
 	if (erq->flags & IW_ENCODE_OPEN) {
-		DBG_871X("rtw_wx_set_enc():IW_ENCODE_OPEN\n");
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;/* Ndis802_11EncryptionDisabled; */
 
 		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Open;
@@ -1797,7 +1738,6 @@ static int rtw_wx_set_enc(struct net_device *dev,
 		authmode = Ndis802_11AuthModeOpen;
 		padapter->securitypriv.ndisauthtype = authmode;
 	} else if (erq->flags & IW_ENCODE_RESTRICTED) {
-		DBG_871X("rtw_wx_set_enc():IW_ENCODE_RESTRICTED\n");
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
 
 		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Shared;
@@ -1807,8 +1747,6 @@ static int rtw_wx_set_enc(struct net_device *dev,
 		authmode = Ndis802_11AuthModeShared;
 		padapter->securitypriv.ndisauthtype = authmode;
 	} else {
-		DBG_871X("rtw_wx_set_enc():erq->flags = 0x%x\n", erq->flags);
-
 		padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;/* Ndis802_11EncryptionDisabled; */
 		padapter->securitypriv.dot11AuthAlgrthm = dot11AuthAlgrthm_Open; /* open system */
 		padapter->securitypriv.dot11PrivacyAlgrthm = _NO_PRIVACY_;
@@ -1828,8 +1766,6 @@ static int rtw_wx_set_enc(struct net_device *dev,
 		if (keyindex_provided == 1) { /*  set key_id only, no given KeyMaterial(erq->length == 0). */
 			padapter->securitypriv.dot11PrivacyKeyIndex = key;
 
-			DBG_871X("(keyindex_provided == 1), keyid =%d, key_len =%d\n", key, padapter->securitypriv.dot11DefKeylen[key]);
-
 			switch (padapter->securitypriv.dot11DefKeylen[key]) {
 			case 5:
 				padapter->securitypriv.dot11PrivacyAlgrthm = _WEP40_;
@@ -2018,7 +1954,6 @@ static int rtw_wx_set_auth(struct net_device *dev,
 		if (check_fwstate(&padapter->mlmepriv, _FW_LINKED)) {
 			LeaveAllPowerSaveMode(padapter);
 			rtw_disassoc_cmd(padapter, 500, false);
-			DBG_871X("%s...call rtw_indicate_disconnect\n ", __func__);
 			rtw_indicate_disconnect(padapter);
 			rtw_free_assoc_resources(padapter, 1);
 		}
@@ -2184,11 +2119,9 @@ static int rtw_wx_read32(struct net_device *dev,
 		sprintf(extra, "0x%08X", data32);
 		break;
 	default:
-		DBG_871X(KERN_INFO "%s: usage> read [bytes],[address(hex)]\n", __func__);
 		ret = -EINVAL;
 		goto exit;
 	}
-	DBG_871X(KERN_INFO "%s: addr = 0x%08X data =%s\n", __func__, addr, extra);
 
 exit:
 	kfree(ptmp);
@@ -2215,18 +2148,14 @@ static int rtw_wx_write32(struct net_device *dev,
 	switch (bytes) {
 	case 1:
 		rtw_write8(padapter, addr, (u8)data32);
-		DBG_871X(KERN_INFO "%s: addr = 0x%08X data = 0x%02X\n", __func__, addr, (u8)data32);
 		break;
 	case 2:
 		rtw_write16(padapter, addr, (u16)data32);
-		DBG_871X(KERN_INFO "%s: addr = 0x%08X data = 0x%04X\n", __func__, addr, (u16)data32);
 		break;
 	case 4:
 		rtw_write32(padapter, addr, data32);
-		DBG_871X(KERN_INFO "%s: addr = 0x%08X data = 0x%08X\n", __func__, addr, data32);
 		break;
 	default:
-		DBG_871X(KERN_INFO "%s: usage> write [bytes],[address(hex)],[data(hex)]\n", __func__);
 		return -EINVAL;
 	}
 
@@ -2297,7 +2226,7 @@ static int rtw_wx_set_channel_plan(struct net_device *dev,
 	u8 channel_plan_req = (u8)(*((int *)wrqu));
 
 	if (_SUCCESS == rtw_set_chplan_cmd(padapter, channel_plan_req, 1, 1))
-		DBG_871X("%s set channel_plan = 0x%02X\n", __func__, channel_plan_req);
+		{}
 	 else
 		return -EPERM;
 
@@ -2356,8 +2285,6 @@ static int rtw_get_ap_info(struct net_device *dev,
 	struct __queue *queue = &(pmlmepriv->scanned_queue);
 	struct iw_point *pdata = &wrqu->data;
 
-	DBG_871X("+rtw_get_aplist_info\n");
-
 	if ((padapter->bDriverStopped) || (pdata == NULL)) {
 		ret = -EINVAL;
 		goto exit;
@@ -2396,14 +2323,12 @@ static int rtw_get_ap_info(struct net_device *dev,
 		pnetwork = container_of(plist, struct wlan_network, list);
 
 		if (!mac_pton(data, bssid)) {
-			DBG_871X("Invalid BSSID '%s'.\n", (u8 *)data);
 			spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
 			return -EINVAL;
 		}
 
 
 		if (!memcmp(bssid, pnetwork->network.MacAddress, ETH_ALEN)) { /* BSSID match, then check if supporting wpa/wpa2 */
-			DBG_871X("BSSID:%pM\n", MAC_ARG(bssid));
 
 			pbuf = rtw_get_wpa_ie(&pnetwork->network.IEs[12], &wpa_ielen, pnetwork->network.IELength-12);
 			if (pbuf && (wpa_ielen > 0)) {
@@ -2455,10 +2380,9 @@ static int rtw_set_pid(struct net_device *dev,
 	selector = *pdata;
 	if (selector < 3 && selector >= 0) {
 		padapter->pid[selector] = *(pdata+1);
-		DBG_871X("%s set pid[%d]=%d\n", __func__, selector, padapter->pid[selector]);
 	}
 	else
-		DBG_871X("%s selector %d error\n", __func__, selector);
+		{}
 
 exit:
 
@@ -2488,8 +2412,6 @@ static int rtw_wps_start(struct net_device *dev,
 	if (u32wps_start == 0)
 		u32wps_start = *extra;
 
-	DBG_871X("[%s] wps_start = %d\n", __func__, u32wps_start);
-
 exit:
 
 	return ret;
@@ -2550,7 +2472,6 @@ static int rtw_rereg_nd_name(struct net_device *dev,
 	if (0 == strcmp(rereg_priv->old_ifname, new_ifname))
 		return ret;
 
-	DBG_871X("%s new_ifname:%s\n", __func__, new_ifname);
 	ret = rtw_change_ifname(padapter, new_ifname);
 	if (ret != 0)
 		goto exit;
@@ -2559,8 +2480,6 @@ static int rtw_rereg_nd_name(struct net_device *dev,
 	rereg_priv->old_ifname[IFNAMSIZ-1] = 0;
 
 	if (!memcmp(new_ifname, "disable%d", 9)) {
-
-		DBG_871X("%s disable\n", __func__);
 		/*  free network queue for Android's timming issue */
 		rtw_free_network_queue(padapter, true);
 
@@ -2601,13 +2520,10 @@ static int rtw_dbg_port(struct net_device *dev,
 		case 0x70:/* read_reg */
 			switch (minor_cmd) {
 				case 1:
-					DBG_871X("rtw_read8(0x%x) = 0x%02x\n", arg, rtw_read8(padapter, arg));
 					break;
 				case 2:
-					DBG_871X("rtw_read16(0x%x) = 0x%04x\n", arg, rtw_read16(padapter, arg));
 					break;
 				case 4:
-					DBG_871X("rtw_read32(0x%x) = 0x%08x\n", arg, rtw_read32(padapter, arg));
 					break;
 			}
 			break;
@@ -2615,31 +2531,24 @@ static int rtw_dbg_port(struct net_device *dev,
 			switch (minor_cmd) {
 				case 1:
 					rtw_write8(padapter, arg, extra_arg);
-					DBG_871X("rtw_write8(0x%x) = 0x%02x\n", arg, rtw_read8(padapter, arg));
 					break;
 				case 2:
 					rtw_write16(padapter, arg, extra_arg);
-					DBG_871X("rtw_write16(0x%x) = 0x%04x\n", arg, rtw_read16(padapter, arg));
 					break;
 				case 4:
 					rtw_write32(padapter, arg, extra_arg);
-					DBG_871X("rtw_write32(0x%x) = 0x%08x\n", arg, rtw_read32(padapter, arg));
 					break;
 			}
 			break;
 		case 0x72:/* read_bb */
-			DBG_871X("read_bbreg(0x%x) = 0x%x\n", arg, rtw_hal_read_bbreg(padapter, arg, 0xffffffff));
 			break;
 		case 0x73:/* write_bb */
 			rtw_hal_write_bbreg(padapter, arg, 0xffffffff, extra_arg);
-			DBG_871X("write_bbreg(0x%x) = 0x%x\n", arg, rtw_hal_read_bbreg(padapter, arg, 0xffffffff));
 			break;
 		case 0x74:/* read_rf */
-			DBG_871X("read RF_reg path(0x%02x), offset(0x%x), value(0x%08x)\n", minor_cmd, arg, rtw_hal_read_rfreg(padapter, minor_cmd, arg, 0xffffffff));
 			break;
 		case 0x75:/* write_rf */
 			rtw_hal_write_rfreg(padapter, minor_cmd, arg, 0xffffffff, extra_arg);
-			DBG_871X("write RF_reg path(0x%02x), offset(0x%x), value(0x%08x)\n", minor_cmd, arg, rtw_hal_read_rfreg(padapter, minor_cmd, arg, 0xffffffff));
 			break;
 
 		case 0x76:
@@ -2666,8 +2575,6 @@ static int rtw_dbg_port(struct net_device *dev,
 				u8 sign = minor_cmd;
 				u16 write_value = 0;
 
-				DBG_871X("%s set RESP_TXAGC to %s %u\n", __func__, sign?"minus":"plus", value);
-
 				if (sign)
 					value = value | 0x10;
 
@@ -2682,28 +2589,14 @@ static int rtw_dbg_port(struct net_device *dev,
 		case 0x7F:
 			switch (minor_cmd) {
 				case 0x0:
-					DBG_871X("fwstate = 0x%x\n", get_fwstate(pmlmepriv));
 					break;
 				case 0x01:
-					DBG_871X("minor_cmd 0x%x\n", minor_cmd);
 					break;
 				case 0x02:
-					DBG_871X("pmlmeinfo->state = 0x%x\n", pmlmeinfo->state);
-					DBG_871X("DrvBcnEarly =%d\n", pmlmeext->DrvBcnEarly);
-					DBG_871X("DrvBcnTimeOut =%d\n", pmlmeext->DrvBcnTimeOut);
 					break;
 				case 0x03:
-					DBG_871X("qos_option =%d\n", pmlmepriv->qospriv.qos_option);
-					DBG_871X("ht_option =%d\n", pmlmepriv->htpriv.ht_option);
 					break;
 				case 0x04:
-					DBG_871X("cur_ch =%d\n", pmlmeext->cur_channel);
-					DBG_871X("cur_bw =%d\n", pmlmeext->cur_bwmode);
-					DBG_871X("cur_ch_off =%d\n", pmlmeext->cur_ch_offset);
-
-					DBG_871X("oper_ch =%d\n", rtw_get_oper_ch(padapter));
-					DBG_871X("oper_bw =%d\n", rtw_get_oper_bw(padapter));
-					DBG_871X("oper_ch_offset =%d\n", rtw_get_oper_choffset(padapter));
 
 					break;
 				case 0x05:
@@ -2712,43 +2605,27 @@ static int rtw_dbg_port(struct net_device *dev,
 						int i;
 						struct recv_reorder_ctrl *preorder_ctrl;
 
-						DBG_871X("SSID =%s\n", cur_network->network.Ssid.Ssid);
-						DBG_871X("sta's macaddr:%pM\n", MAC_ARG(psta->hwaddr));
-						DBG_871X("cur_channel =%d, cur_bwmode =%d, cur_ch_offset =%d\n", pmlmeext->cur_channel, pmlmeext->cur_bwmode, pmlmeext->cur_ch_offset);
-						DBG_871X("rtsen =%d, cts2slef =%d\n", psta->rtsen, psta->cts2self);
-						DBG_871X("state = 0x%x, aid =%d, macid =%d, raid =%d\n", psta->state, psta->aid, psta->mac_id, psta->raid);
-						DBG_871X("qos_en =%d, ht_en =%d, init_rate =%d\n", psta->qos_option, psta->htpriv.ht_option, psta->init_rate);
-						DBG_871X("bwmode =%d, ch_offset =%d, sgi_20m =%d, sgi_40m =%d\n", psta->bw_mode, psta->htpriv.ch_offset, psta->htpriv.sgi_20m, psta->htpriv.sgi_40m);
-						DBG_871X("ampdu_enable = %d\n", psta->htpriv.ampdu_enable);
-						DBG_871X("agg_enable_bitmap =%x, candidate_tid_bitmap =%x\n", psta->htpriv.agg_enable_bitmap, psta->htpriv.candidate_tid_bitmap);
-
 						for (i = 0; i < 16; i++) {
 							preorder_ctrl = &psta->recvreorder_ctrl[i];
 							if (preorder_ctrl->enable)
-								DBG_871X("tid =%d, indicate_seq =%d\n", i, preorder_ctrl->indicate_seq);
+								{}
 						}
 
 					} else {
-						DBG_871X("can't get sta's macaddr, cur_network's macaddr:%pM\n", MAC_ARG(cur_network->network.MacAddress));
 					}
 					break;
 				case 0x06:
 					{
 						u32 ODMFlag;
 						rtw_hal_get_hwreg(padapter, HW_VAR_DM_FLAG, (u8 *)(&ODMFlag));
-						DBG_871X("(B)DMFlag = 0x%x, arg = 0x%x\n", ODMFlag, arg);
 						ODMFlag = (u32)(0x0f&arg);
-						DBG_871X("(A)DMFlag = 0x%x\n", ODMFlag);
 						rtw_hal_set_hwreg(padapter, HW_VAR_DM_FLAG, (u8 *)(&ODMFlag));
 					}
 					break;
 				case 0x07:
-					DBG_871X("bSurpriseRemoved =%d, bDriverStopped =%d\n",
-						padapter->bSurpriseRemoved, padapter->bDriverStopped);
 					break;
 				case 0x08:
 					{
-						DBG_871X("minor_cmd 0x%x\n", minor_cmd);
 					}
 					break;
 				case 0x09:
@@ -2757,8 +2634,6 @@ static int rtw_dbg_port(struct net_device *dev,
 						struct list_head	*plist, *phead;
 						struct recv_reorder_ctrl *preorder_ctrl;
 
-						DBG_871X("sta_dz_bitmap = 0x%x, tim_bitmap = 0x%x\n", pstapriv->sta_dz_bitmap, pstapriv->tim_bitmap);
-
 						spin_lock_bh(&pstapriv->sta_hash_lock);
 
 						for (i = 0; i < NUM_STA; i++) {
@@ -2771,27 +2646,10 @@ static int rtw_dbg_port(struct net_device *dev,
 								plist = get_next(plist);
 
 								if (extra_arg == psta->aid) {
-									DBG_871X("sta's macaddr:%pM\n", MAC_ARG(psta->hwaddr));
-									DBG_871X("rtsen =%d, cts2slef =%d\n", psta->rtsen, psta->cts2self);
-									DBG_871X("state = 0x%x, aid =%d, macid =%d, raid =%d\n", psta->state, psta->aid, psta->mac_id, psta->raid);
-									DBG_871X("qos_en =%d, ht_en =%d, init_rate =%d\n", psta->qos_option, psta->htpriv.ht_option, psta->init_rate);
-									DBG_871X("bwmode =%d, ch_offset =%d, sgi_20m =%d, sgi_40m =%d\n", psta->bw_mode, psta->htpriv.ch_offset, psta->htpriv.sgi_20m, psta->htpriv.sgi_40m);
-									DBG_871X("ampdu_enable = %d\n", psta->htpriv.ampdu_enable);
-									DBG_871X("agg_enable_bitmap =%x, candidate_tid_bitmap =%x\n", psta->htpriv.agg_enable_bitmap, psta->htpriv.candidate_tid_bitmap);
-									DBG_871X("capability = 0x%x\n", psta->capability);
-									DBG_871X("flags = 0x%x\n", psta->flags);
-									DBG_871X("wpa_psk = 0x%x\n", psta->wpa_psk);
-									DBG_871X("wpa2_group_cipher = 0x%x\n", psta->wpa2_group_cipher);
-									DBG_871X("wpa2_pairwise_cipher = 0x%x\n", psta->wpa2_pairwise_cipher);
-									DBG_871X("qos_info = 0x%x\n", psta->qos_info);
-									DBG_871X("dot118021XPrivacy = 0x%x\n", psta->dot118021XPrivacy);
-
-
-
 									for (j = 0; j < 16; j++) {
 										preorder_ctrl = &psta->recvreorder_ctrl[j];
 										if (preorder_ctrl->enable)
-											DBG_871X("tid =%d, indicate_seq =%d\n", j, preorder_ctrl->indicate_seq);
+											{}
 									}
 								}
 							}
@@ -2810,10 +2668,8 @@ static int rtw_dbg_port(struct net_device *dev,
 					break;
 				case 0x0b: /* Enable = 1, Disable = 0 driver control vrtl_carrier_sense. */
 					if (arg == 0) {
-						DBG_871X("disable driver ctrl vcs\n");
 						padapter->driver_vcs_en = 0;
 					} else if (arg == 1) {
-						DBG_871X("enable driver ctrl vcs = %d\n", extra_arg);
 						padapter->driver_vcs_en = 1;
 
 						if (extra_arg > 2)
@@ -2825,11 +2681,9 @@ static int rtw_dbg_port(struct net_device *dev,
 				case 0x0c:/* dump rx/tx packet */
 					{
 						if (arg == 0) {
-							DBG_871X("dump rx packet (%d)\n", extra_arg);
 							/* pHalData->bDumpRxPkt =extra_arg; */
 							rtw_hal_set_def_var(padapter, HAL_DEF_DBG_DUMP_RXPKT, &(extra_arg));
 						} else if (arg == 1) {
-							DBG_871X("dump tx packet (%d)\n", extra_arg);
 							rtw_hal_set_def_var(padapter, HAL_DEF_DBG_DUMP_TXPKT, &(extra_arg));
 						}
 					}
@@ -2837,12 +2691,9 @@ static int rtw_dbg_port(struct net_device *dev,
 				case 0x0e:
 					{
 						if (arg == 0) {
-							DBG_871X("disable driver ctrl rx_ampdu_factor\n");
 							padapter->driver_rx_ampdu_factor = 0xFF;
 						} else if (arg == 1) {
 
-							DBG_871X("enable driver ctrl rx_ampdu_factor = %d\n", extra_arg);
-
 							if ((extra_arg & 0x03) > 0x03)
 								padapter->driver_rx_ampdu_factor = 0xFF;
 							else
@@ -2866,9 +2717,8 @@ static int rtw_dbg_port(struct net_device *dev,
 					/* default is set to enable 2.4GHZ for IOT issue with bufflao's AP at 5GHZ */
 					if (extra_arg == 0 || extra_arg == 1 || extra_arg == 2 || extra_arg == 3) {
 						pregpriv->rx_stbc = extra_arg;
-						DBG_871X("set rx_stbc =%d\n", pregpriv->rx_stbc);
 					} else
-						DBG_871X("get rx_stbc =%d\n", pregpriv->rx_stbc);
+						{}
 
 				}
 				break;
@@ -2878,15 +2728,13 @@ static int rtw_dbg_port(struct net_device *dev,
 					/*  0: disable, 0x1:enable (but wifi_spec should be 0), 0x2: force enable (don't care wifi_spec) */
 					if (extra_arg < 3) {
 						pregpriv->ampdu_enable = extra_arg;
-						DBG_871X("set ampdu_enable =%d\n", pregpriv->ampdu_enable);
 					} else
-						DBG_871X("get ampdu_enable =%d\n", pregpriv->ampdu_enable);
+						{}
 
 				}
 				break;
 				case 0x14:
 				{
-					DBG_871X("minor_cmd 0x%x\n", minor_cmd);
 				}
 				break;
 				case 0x16:
@@ -2922,10 +2770,8 @@ static int rtw_dbg_port(struct net_device *dev,
 						/*  BIT0: Enable VHT LDPC Rx, BIT1: Enable VHT LDPC Tx, */
 						/*  BIT4: Enable HT LDPC Rx, BIT5: Enable HT LDPC Tx */
 						if (arg == 0) {
-							DBG_871X("driver disable LDPC\n");
 							pregistrypriv->ldpc_cap = 0x00;
 						} else if (arg == 1) {
-							DBG_871X("driver set LDPC cap = 0x%x\n", extra_arg);
 							pregistrypriv->ldpc_cap = (u8)(extra_arg&0x33);
 						}
 					}
@@ -2937,10 +2783,8 @@ static int rtw_dbg_port(struct net_device *dev,
 						/*  BIT0: Enable VHT STBC Rx, BIT1: Enable VHT STBC Tx, */
 						/*  BIT4: Enable HT STBC Rx, BIT5: Enable HT STBC Tx */
 						if (arg == 0) {
-							DBG_871X("driver disable STBC\n");
 							pregistrypriv->stbc_cap = 0x00;
 						} else if (arg == 1) {
-							DBG_871X("driver set STBC cap = 0x%x\n", extra_arg);
 							pregistrypriv->stbc_cap = (u8)(extra_arg&0x33);
 						}
 					}
@@ -2950,7 +2794,6 @@ static int rtw_dbg_port(struct net_device *dev,
 						struct registry_priv *pregistrypriv = &padapter->registrypriv;
 
 						if (arg == 0) {
-							DBG_871X("disable driver ctrl max_rx_rate, reset to default_rate_set\n");
 							init_mlme_default_rate_set(padapter);
 							pregistrypriv->ht_enable = (u8)rtw_ht_enable;
 						} else if (arg == 1) {
@@ -2958,8 +2801,6 @@ static int rtw_dbg_port(struct net_device *dev,
 							int i;
 							u8 max_rx_rate;
 
-							DBG_871X("enable driver ctrl max_rx_rate = 0x%x\n", extra_arg);
-
 							max_rx_rate = (u8)extra_arg;
 
 							if (max_rx_rate < 0xc) { /*  max_rx_rate < MSC0 -> B or G -> disable HT */
@@ -2984,12 +2825,9 @@ static int rtw_dbg_port(struct net_device *dev,
 				case 0x1c: /* enable/disable driver control AMPDU Density for peer sta's rx */
 					{
 						if (arg == 0) {
-							DBG_871X("disable driver ctrl ampdu density\n");
 							padapter->driver_ampdu_spacing = 0xFF;
 						} else if (arg == 1) {
 
-							DBG_871X("enable driver ctrl ampdu density = %d\n", extra_arg);
-
 							if (extra_arg > 0x07)
 								padapter->driver_ampdu_spacing = 0xFF;
 							else
@@ -2999,7 +2837,6 @@ static int rtw_dbg_port(struct net_device *dev,
 					break;
 				case 0x23:
 					{
-						DBG_871X("turn %s the bNotifyChannelChange Variable\n", (extra_arg == 1)?"on":"off");
 						padapter->bNotifyChannelChange = extra_arg;
 						break;
 					}
@@ -3011,7 +2848,6 @@ static int rtw_dbg_port(struct net_device *dev,
 					{
 						if ((extra_arg & 0x7F) > 0x3F)
 							extra_arg = 0xFF;
-						DBG_871X("chang data rate to :0x%02x\n", extra_arg);
 						padapter->fix_rate = extra_arg;
 					}
 					break;
@@ -3032,14 +2868,6 @@ static int rtw_dbg_port(struct net_device *dev,
 
 						if (0xf == extra_arg) {
 							rtw_hal_get_def_var(padapter, HAL_DEF_DBG_DM_FUNC, &odm_flag);
-							DBG_871X(" === DMFlag(0x%08x) ===\n", odm_flag);
-							DBG_871X("extra_arg = 0  - disable all dynamic func\n");
-							DBG_871X("extra_arg = 1  - disable DIG- BIT(0)\n");
-							DBG_871X("extra_arg = 2  - disable High power - BIT(1)\n");
-							DBG_871X("extra_arg = 3  - disable tx power tracking - BIT(2)\n");
-							DBG_871X("extra_arg = 4  - disable BT coexistence - BIT(3)\n");
-							DBG_871X("extra_arg = 5  - disable antenna diversity - BIT(4)\n");
-							DBG_871X("extra_arg = 6  - enable all dynamic func\n");
 						} else {
 							/*extra_arg = 0  - disable all dynamic func
 								extra_arg = 1  - disable DIG
@@ -3048,54 +2876,23 @@ static int rtw_dbg_port(struct net_device *dev,
 							*/
 							rtw_hal_set_def_var(padapter, HAL_DEF_DBG_DM_FUNC, &(extra_arg));
 							rtw_hal_get_def_var(padapter, HAL_DEF_DBG_DM_FUNC, &odm_flag);
-							DBG_871X(" === DMFlag(0x%08x) ===\n", odm_flag);
 						}
 					}
 					break;
 
 				case 0xfd:
 					rtw_write8(padapter, 0xc50, arg);
-					DBG_871X("wr(0xc50) = 0x%x\n", rtw_read8(padapter, 0xc50));
 					rtw_write8(padapter, 0xc58, arg);
-					DBG_871X("wr(0xc58) = 0x%x\n", rtw_read8(padapter, 0xc58));
 					break;
 				case 0xfe:
-					DBG_871X("rd(0xc50) = 0x%x\n", rtw_read8(padapter, 0xc50));
-					DBG_871X("rd(0xc58) = 0x%x\n", rtw_read8(padapter, 0xc58));
 					break;
 				case 0xff:
 					{
-						DBG_871X("dbg(0x210) = 0x%x\n", rtw_read32(padapter, 0x210));
-						DBG_871X("dbg(0x608) = 0x%x\n", rtw_read32(padapter, 0x608));
-						DBG_871X("dbg(0x280) = 0x%x\n", rtw_read32(padapter, 0x280));
-						DBG_871X("dbg(0x284) = 0x%x\n", rtw_read32(padapter, 0x284));
-						DBG_871X("dbg(0x288) = 0x%x\n", rtw_read32(padapter, 0x288));
-
-						DBG_871X("dbg(0x664) = 0x%x\n", rtw_read32(padapter, 0x664));
-
-
-						DBG_871X("\n");
-
-						DBG_871X("dbg(0x430) = 0x%x\n", rtw_read32(padapter, 0x430));
-						DBG_871X("dbg(0x438) = 0x%x\n", rtw_read32(padapter, 0x438));
-
-						DBG_871X("dbg(0x440) = 0x%x\n", rtw_read32(padapter, 0x440));
-
-						DBG_871X("dbg(0x458) = 0x%x\n", rtw_read32(padapter, 0x458));
-
-						DBG_871X("dbg(0x484) = 0x%x\n", rtw_read32(padapter, 0x484));
-						DBG_871X("dbg(0x488) = 0x%x\n", rtw_read32(padapter, 0x488));
-
-						DBG_871X("dbg(0x444) = 0x%x\n", rtw_read32(padapter, 0x444));
-						DBG_871X("dbg(0x448) = 0x%x\n", rtw_read32(padapter, 0x448));
-						DBG_871X("dbg(0x44c) = 0x%x\n", rtw_read32(padapter, 0x44c));
-						DBG_871X("dbg(0x450) = 0x%x\n", rtw_read32(padapter, 0x450));
 					}
 					break;
 			}
 			break;
 		default:
-			DBG_871X("error dbg cmd!\n");
 			break;
 	}
 
@@ -3263,7 +3060,6 @@ static int wpa_supplicant_ioctl(struct net_device *dev, struct iw_point *p)
 		break;
 
 	default:
-		DBG_871X("Unknown WPA supplicant request: %d\n", param->cmd);
 		ret = -EOPNOTSUPP;
 		break;
 
@@ -3310,7 +3106,6 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 		psta = rtw_get_stainfo(pstapriv, param->sta_addr);
 		if (!psta) {
 			/* ret = -EINVAL; */
-			DBG_871X("rtw_set_encryption(), sta has already been removed or never been added\n");
 			goto exit;
 		}
 	}
@@ -3323,20 +3118,14 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 		psecuritypriv->dot11PrivacyAlgrthm = _NO_PRIVACY_;
 		psecuritypriv->dot118021XGrpPrivacy = _NO_PRIVACY_;
 
-		DBG_871X("clear default encryption keys, keyid =%d\n", param->u.crypt.idx);
-
 		goto exit;
 	}
 
 
 	if (strcmp(param->u.crypt.alg, "WEP") == 0 && (psta == NULL)) {
-		DBG_871X("r871x_set_encryption, crypt.alg = WEP\n");
-
 		wep_key_idx = param->u.crypt.idx;
 		wep_key_len = param->u.crypt.key_len;
 
-		DBG_871X("r871x_set_encryption, wep_key_idx =%d, len =%d\n", wep_key_idx, wep_key_len);
-
 		if ((wep_key_idx >= WEP_KEYS) || (wep_key_len <= 0)) {
 			ret = -EINVAL;
 			goto exit;
@@ -3348,7 +3137,6 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
 			pwep = kzalloc(wep_total_len, GFP_KERNEL);
 			if (pwep == NULL) {
-				DBG_871X(" r871x_set_encryption: pwep allocate fail !!!\n");
 				goto exit;
 			}
 
@@ -3362,8 +3150,6 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 		memcpy(pwep->KeyMaterial,  param->u.crypt.key, pwep->KeyLength);
 
 		if (param->u.crypt.set_tx) {
-			DBG_871X("wep, set_tx = 1\n");
-
 			psecuritypriv->dot11AuthAlgrthm = dot11AuthAlgrthm_Auto;
 			psecuritypriv->ndisencryptstatus = Ndis802_11Encryption1Enabled;
 			psecuritypriv->dot11PrivacyAlgrthm = _WEP40_;
@@ -3383,8 +3169,6 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 
 			rtw_ap_set_wep_key(padapter, pwep->KeyMaterial, pwep->KeyLength, wep_key_idx, 1);
 		} else {
-			DBG_871X("wep, set_tx = 0\n");
-
 			/* don't update "psecuritypriv->dot11PrivacyAlgrthm" and */
 			/* psecuritypriv->dot11PrivacyKeyIndex =keyid", but can rtw_set_key to cam */
 
@@ -3403,8 +3187,6 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 	if (!psta && check_fwstate(pmlmepriv, WIFI_AP_STATE)) { /*  group key */
 		if (param->u.crypt.set_tx == 1) {
 			if (strcmp(param->u.crypt.alg, "WEP") == 0) {
-				DBG_871X("%s, set group_key, WEP\n", __func__);
-
 				memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 
 				psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
@@ -3412,8 +3194,6 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 						psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
 
 			} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
-				DBG_871X("%s, set group_key, TKIP\n", __func__);
-
 				psecuritypriv->dot118021XGrpPrivacy = _TKIP_;
 
 				memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
@@ -3427,14 +3207,10 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 
 			}
 			else if (strcmp(param->u.crypt.alg, "CCMP") == 0) {
-				DBG_871X("%s, set group_key, CCMP\n", __func__);
-
 				psecuritypriv->dot118021XGrpPrivacy = _AES_;
 
 				memcpy(psecuritypriv->dot118021XGrpKey[param->u.crypt.idx].skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 			} else {
-				DBG_871X("%s, set group_key, none\n", __func__);
-
 				psecuritypriv->dot118021XGrpPrivacy = _NO_PRIVACY_;
 			}
 
@@ -3463,14 +3239,10 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 				memcpy(psta->dot118021x_UncstKey.skey, param->u.crypt.key, (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 
 				if (strcmp(param->u.crypt.alg, "WEP") == 0) {
-					DBG_871X("%s, set pairwise key, WEP\n", __func__);
-
 					psta->dot118021XPrivacy = _WEP40_;
 					if (param->u.crypt.key_len == 13)
 						psta->dot118021XPrivacy = _WEP104_;
 				} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
-					DBG_871X("%s, set pairwise key, TKIP\n", __func__);
-
 					psta->dot118021XPrivacy = _TKIP_;
 
 					/* DEBUG_ERR("set key length :param->u.crypt.key_len =%d\n", param->u.crypt.key_len); */
@@ -3482,12 +3254,8 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 
 				} else if (strcmp(param->u.crypt.alg, "CCMP") == 0) {
 
-					DBG_871X("%s, set pairwise key, CCMP\n", __func__);
-
 					psta->dot118021XPrivacy = _AES_;
 				} else {
-					DBG_871X("%s, set pairwise key, none\n", __func__);
-
 					psta->dot118021XPrivacy = _NO_PRIVACY_;
 				}
 
@@ -3554,9 +3322,6 @@ static int rtw_set_beacon(struct net_device *dev, struct ieee_param *param, int
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	unsigned char *pbuf = param->u.bcn_ie.buf;
 
-
-	DBG_871X("%s, len =%d\n", __func__, len);
-
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
 		return -EINVAL;
 
@@ -3597,8 +3362,6 @@ static int rtw_add_sta(struct net_device *dev, struct ieee_param *param)
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
-	DBG_871X("rtw_add_sta(aid =%d) =%pM\n", param->u.add_sta.aid, MAC_ARG(param->sta_addr));
-
 	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true)
 		return -EINVAL;
 
@@ -3672,8 +3435,6 @@ static int rtw_del_sta(struct net_device *dev, struct ieee_param *param)
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
-	DBG_871X("rtw_del_sta =%pM\n", MAC_ARG(param->sta_addr));
-
 	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true)
 		return -EINVAL;
 
@@ -3703,8 +3464,6 @@ static int rtw_del_sta(struct net_device *dev, struct ieee_param *param)
 		psta = NULL;
 
 	} else {
-		DBG_871X("rtw_del_sta(), sta has already been removed or never been added\n");
-
 		/* ret = -1; */
 	}
 
@@ -3723,8 +3482,6 @@ static int rtw_ioctl_get_sta_data(struct net_device *dev, struct ieee_param *par
 	struct ieee_param_ex *param_ex = (struct ieee_param_ex *)param;
 	struct sta_data *psta_data = (struct sta_data *)param_ex->data;
 
-	DBG_871X("rtw_ioctl_get_sta_info, sta_addr: %pM\n", MAC_ARG(param_ex->sta_addr));
-
 	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true)
 		return -EINVAL;
 
@@ -3784,8 +3541,6 @@ static int rtw_get_sta_wpaie(struct net_device *dev, struct ieee_param *param)
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
-	DBG_871X("rtw_get_sta_wpaie, sta_addr: %pM\n", MAC_ARG(param->sta_addr));
-
 	if (check_fwstate(pmlmepriv, (_FW_LINKED|WIFI_AP_STATE)) != true)
 		return -EINVAL;
 
@@ -3809,8 +3564,6 @@ static int rtw_get_sta_wpaie(struct net_device *dev, struct ieee_param *param)
 
 			memcpy(param->u.wpa_ie.reserved, psta->wpa_ie, copy_len);
 		} else {
-			/* ret = -1; */
-			DBG_871X("sta's wpa_ie is NONE\n");
 		}
 	} else {
 		ret = -1;
@@ -3829,8 +3582,6 @@ static int rtw_set_wps_beacon(struct net_device *dev, struct ieee_param *param,
 	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
 	int ie_len;
 
-	DBG_871X("%s, len =%d\n", __func__, len);
-
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
 		return -EINVAL;
 
@@ -3844,7 +3595,6 @@ static int rtw_set_wps_beacon(struct net_device *dev, struct ieee_param *param,
 		pmlmepriv->wps_beacon_ie = rtw_malloc(ie_len);
 		pmlmepriv->wps_beacon_ie_len = ie_len;
 		if (pmlmepriv->wps_beacon_ie == NULL) {
-			DBG_871X("%s()-%d: rtw_malloc() ERROR!\n", __func__, __LINE__);
 			return -EINVAL;
 		}
 
@@ -3867,8 +3617,6 @@ static int rtw_set_wps_probe_resp(struct net_device *dev, struct ieee_param *par
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	int ie_len;
 
-	DBG_871X("%s, len =%d\n", __func__, len);
-
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
 		return -EINVAL;
 
@@ -3882,7 +3630,6 @@ static int rtw_set_wps_probe_resp(struct net_device *dev, struct ieee_param *par
 		pmlmepriv->wps_probe_resp_ie = rtw_malloc(ie_len);
 		pmlmepriv->wps_probe_resp_ie_len = ie_len;
 		if (pmlmepriv->wps_probe_resp_ie == NULL) {
-			DBG_871X("%s()-%d: rtw_malloc() ERROR!\n", __func__, __LINE__);
 			return -EINVAL;
 		}
 		memcpy(pmlmepriv->wps_probe_resp_ie, param->u.bcn_ie.buf, ie_len);
@@ -3900,8 +3647,6 @@ static int rtw_set_wps_assoc_resp(struct net_device *dev, struct ieee_param *par
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	int ie_len;
 
-	DBG_871X("%s, len =%d\n", __func__, len);
-
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) != true)
 		return -EINVAL;
 
@@ -3915,7 +3660,6 @@ static int rtw_set_wps_assoc_resp(struct net_device *dev, struct ieee_param *par
 		pmlmepriv->wps_assoc_resp_ie = rtw_malloc(ie_len);
 		pmlmepriv->wps_assoc_resp_ie_len = ie_len;
 		if (pmlmepriv->wps_assoc_resp_ie == NULL) {
-			DBG_871X("%s()-%d: rtw_malloc() ERROR!\n", __func__, __LINE__);
 			return -EINVAL;
 		}
 
@@ -3959,10 +3703,7 @@ static int rtw_set_hidden_ssid(struct net_device *dev, struct ieee_param *param,
 		ssid[ssid_len] = 0x0;
 
 		if (0)
-			DBG_871X(FUNC_ADPT_FMT" ssid:(%s,%d), from ie:(%s,%d), (%s,%d)\n", FUNC_ADPT_ARG(adapter),
-				 ssid, ssid_len,
-				 pbss_network->Ssid.Ssid, pbss_network->Ssid.SsidLength,
-				 pbss_network_ext->Ssid.Ssid, pbss_network_ext->Ssid.SsidLength);
+			{}
 
 		memcpy(pbss_network->Ssid.Ssid, (void *)ssid, ssid_len);
 		pbss_network->Ssid.SsidLength = ssid_len;
@@ -3970,14 +3711,9 @@ static int rtw_set_hidden_ssid(struct net_device *dev, struct ieee_param *param,
 		pbss_network_ext->Ssid.SsidLength = ssid_len;
 
 		if (0)
-			DBG_871X(FUNC_ADPT_FMT" after ssid:(%s,%d), (%s,%d)\n", FUNC_ADPT_ARG(adapter),
-				 pbss_network->Ssid.Ssid, pbss_network->Ssid.SsidLength,
-				 pbss_network_ext->Ssid.Ssid, pbss_network_ext->Ssid.SsidLength);
+			{}
 	}
 
-	DBG_871X(FUNC_ADPT_FMT" ignore_broadcast_ssid:%d, %s,%d\n", FUNC_ADPT_ARG(adapter),
-		ignore_broadcast_ssid, ssid, ssid_len);
-
 	return ret;
 }
 
@@ -4146,7 +3882,6 @@ static int rtw_hostapd_ioctl(struct net_device *dev, struct iw_point *p)
 		break;
 
 	default:
-		DBG_871X("Unknown hostapd request: %d\n", param->cmd);
 		ret = -EOPNOTSUPP;
 		break;
 
@@ -4262,8 +3997,6 @@ static int rtw_pm_set(struct net_device *dev,
 	unsigned	mode = 0;
 	struct adapter *padapter = rtw_netdev_priv(dev);
 
-	DBG_871X("[%s] extra = %s\n", __func__, extra);
-
 	if (!memcmp(extra, "lps =", 4)) {
 		sscanf(extra+4, "%u", &mode);
 		ret = rtw_pm_set_lps(padapter, mode);
@@ -4289,27 +4022,22 @@ static int rtw_test(
 	struct adapter *padapter = rtw_netdev_priv(dev);
 
 
-	DBG_871X("+%s\n", __func__);
 	len = wrqu->data.length;
 
 	pbuf = rtw_zmalloc(len);
 	if (pbuf == NULL) {
-		DBG_871X("%s: no memory!\n", __func__);
 		return -ENOMEM;
 	}
 
 	if (copy_from_user(pbuf, wrqu->data.pointer, len)) {
 		kfree(pbuf);
-		DBG_871X("%s: copy from user fail!\n", __func__);
 		return -EFAULT;
 	}
-	DBG_871X("%s: string =\"%s\"\n", __func__, pbuf);
 
 	ptmp = (char *)pbuf;
 	pch = strsep(&ptmp, delim);
 	if ((pch == NULL) || (strlen(pch) == 0)) {
 		kfree(pbuf);
-		DBG_871X("%s: parameter error(level 1)!\n", __func__);
 		return -EFAULT;
 	}
 
@@ -4339,7 +4067,6 @@ static int rtw_test(
 
 		if (count == 0) {
 			kfree(pbuf);
-			DBG_871X("%s: parameter error(level 2)!\n", __func__);
 			return -EFAULT;
 		}
 
@@ -4576,7 +4303,6 @@ static struct iw_statistics *rtw_get_wireless_stats(struct net_device *dev)
 		tmp_level = padapter->recvpriv.signal_strength;
 		tmp_qual = padapter->recvpriv.signal_qual;
 		tmp_noise = padapter->recvpriv.noise;
-		DBG_871X("level:%d, qual:%d, noise:%d, rssi (%d)\n", tmp_level, tmp_qual, tmp_noise, padapter->recvpriv.rssi);
 
 		piwstats->qual.level = tmp_level;
 		piwstats->qual.qual = tmp_qual;
diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
index b46c086233bb..8a97458f05e0 100644
--- a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
@@ -149,8 +149,6 @@ void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
 	if (authmode == WLAN_EID_VENDOR_SPECIFIC) {
 		buff = rtw_zmalloc(IW_CUSTOM_MAX);
 		if (NULL == buff) {
-			DBG_871X(FUNC_ADPT_FMT ": alloc memory FAIL!!\n",
-				FUNC_ADPT_ARG(adapter));
 			return;
 		}
 		p = buff;
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index fd6309b0bf87..58763dc34f22 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -493,7 +493,6 @@ struct net_device *rtw_init_netdev(struct adapter *old_padapter)
 
 	/* pnetdev->init = NULL; */
 
-	DBG_871X("register rtw_netdev_ops to netdev_ops\n");
 	pnetdev->netdev_ops = &rtw_netdev_ops;
 
 	/* pnetdev->tx_timeout = NULL; */
@@ -716,13 +715,11 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 	init_mlme_ext_priv(padapter);
 
 	if (_rtw_init_xmit_priv(&padapter->xmitpriv, padapter) == _FAIL) {
-		DBG_871X("Can't _rtw_init_xmit_priv\n");
 		ret8 = _FAIL;
 		goto exit;
 	}
 
 	if (_rtw_init_recv_priv(&padapter->recvpriv, padapter) == _FAIL) {
-		DBG_871X("Can't _rtw_init_recv_priv\n");
 		ret8 = _FAIL;
 		goto exit;
 	}
@@ -733,7 +730,6 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 	/* memset((unsigned char *)&padapter->securitypriv, 0, sizeof (struct security_priv)); */
 
 	if (_rtw_init_sta_priv(&padapter->stapriv) == _FAIL) {
-		DBG_871X("Can't _rtw_init_sta_priv\n");
 		ret8 = _FAIL;
 		goto exit;
 	}
@@ -821,13 +817,10 @@ static int _rtw_drv_register_netdev(struct adapter *padapter, char *name)
 
 	/* Tell the network stack we exist */
 	if (register_netdev(pnetdev) != 0) {
-		DBG_871X(FUNC_NDEV_FMT "Failed!\n", FUNC_NDEV_ARG(pnetdev));
 		ret = _FAIL;
 		goto error_register_netdev;
 	}
 
-	DBG_871X("%s, MAC Address (if%d) = %pM\n", __func__, (padapter->iface_id + 1), MAC_ARG(pnetdev->dev_addr));
-
 	return ret;
 
 error_register_netdev:
@@ -854,8 +847,6 @@ static int _netdev_open(struct net_device *pnetdev)
 	struct adapter *padapter = rtw_netdev_priv(pnetdev);
 	struct pwrctrl_priv *pwrctrlpriv = adapter_to_pwrctl(padapter);
 
-	DBG_871X("+871x_drv - drv_open, bup =%d\n", padapter->bup);
-
 	padapter->netif_up = true;
 
 	if (pwrctrlpriv->ps_flag) {
@@ -872,11 +863,8 @@ static int _netdev_open(struct net_device *pnetdev)
 		if (status == _FAIL)
 			goto netdev_open_error;
 
-		DBG_871X("MAC Address = %pM\n", MAC_ARG(pnetdev->dev_addr));
-
 		status = rtw_start_drv_threads(padapter);
 		if (status == _FAIL) {
-			DBG_871X("Initialize driver software resource Failed!\n");
 			goto netdev_open_error;
 		}
 
@@ -899,8 +887,6 @@ static int _netdev_open(struct net_device *pnetdev)
 
 netdev_open_normal_process:
 
-	DBG_871X("-871x_drv - drv_open, bup =%d\n", padapter->bup);
-
 	return 0;
 
 netdev_open_error:
@@ -910,8 +896,6 @@ static int _netdev_open(struct net_device *pnetdev)
 	netif_carrier_off(pnetdev);
 	rtw_netif_stop_queue(pnetdev);
 
-	DBG_871X("-871x_drv - drv_open fail, bup =%d\n", padapter->bup);
-
 	return (-1);
 }
 
@@ -922,7 +906,6 @@ int netdev_open(struct net_device *pnetdev)
 	struct pwrctrl_priv *pwrctrlpriv = adapter_to_pwrctl(padapter);
 
 	if (pwrctrlpriv->bInSuspend) {
-		DBG_871X("+871x_drv - drv_open, bInSuspend =%d\n", pwrctrlpriv->bInSuspend);
 		return 0;
 	}
 
@@ -958,8 +941,6 @@ static int  ips_netdrv_open(struct adapter *padapter)
 	return _SUCCESS;
 
 netdev_open_error:
-	/* padapter->bup = false; */
-	DBG_871X("-ips_netdrv_open - drv_open failure, bup =%d\n", padapter->bup);
 
 	return _FAIL;
 }
@@ -968,24 +949,19 @@ static int  ips_netdrv_open(struct adapter *padapter)
 int rtw_ips_pwr_up(struct adapter *padapter)
 {
 	int result;
-	DBG_871X("===>  rtw_ips_pwr_up..............\n");
 
 	result = ips_netdrv_open(padapter);
 
-	DBG_871X("<===  rtw_ips_pwr_up..............\n");
 	return result;
 }
 
 void rtw_ips_pwr_down(struct adapter *padapter)
 {
-	DBG_871X("===> rtw_ips_pwr_down...................\n");
-
 	padapter->bCardDisableWOHSM = true;
 	padapter->net_closed = true;
 
 	rtw_ips_dev_unload(padapter);
 	padapter->bCardDisableWOHSM = false;
-	DBG_871X("<=== rtw_ips_pwr_down.....................\n");
 }
 
 void rtw_ips_dev_unload(struct adapter *padapter)
@@ -1036,8 +1012,6 @@ static int netdev_close(struct net_device *pnetdev)
 	}
 	else*/
 	if (pwrctl->rf_pwrstate == rf_on) {
-		DBG_871X("(2)871x_drv - drv_close, bup =%d, hw_init_completed =%d\n", padapter->bup, padapter->hw_init_completed);
-
 		/* s1. */
 		if (pnetdev) {
 			if (!rtw_netif_queue_stopped(pnetdev))
@@ -1058,15 +1032,11 @@ static int netdev_close(struct net_device *pnetdev)
 	rtw_scan_abort(padapter);
 	adapter_wdev_data(padapter)->bandroid_scan = false;
 
-	DBG_871X("-871x_drv - drv_close, bup =%d\n", padapter->bup);
-
 	return 0;
 }
 
 void rtw_ndev_destructor(struct net_device *ndev)
 {
-	DBG_871X(FUNC_NDEV_FMT "\n", FUNC_NDEV_ARG(ndev));
-
 	kfree(ndev->ieee80211_ptr);
 }
 
@@ -1092,11 +1062,9 @@ void rtw_dev_unload(struct adapter *padapter)
 
 		while (atomic_read(&pcmdpriv->cmdthd_running)) {
 			if (cnt > 5) {
-				DBG_871X("stop cmdthd timeout\n");
 				break;
 			} else {
 				cnt++;
-				DBG_871X("cmdthd is running(%d)\n", cnt);
 				msleep(10);
 			}
 		}
@@ -1123,7 +1091,6 @@ void rtw_dev_unload(struct adapter *padapter)
 		padapter->bup = false;
 
 	} else {
-		DBG_871X("%s: bup ==false\n", __func__);
 	}
 }
 
@@ -1131,16 +1098,9 @@ static int rtw_suspend_free_assoc_resource(struct adapter *padapter)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
-	DBG_871X("==> " FUNC_ADPT_FMT " entry....\n", FUNC_ADPT_ARG(padapter));
-
 	if (rtw_chk_roam_flags(padapter, RTW_ROAM_ON_RESUME)) {
 		if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)
 			&& check_fwstate(pmlmepriv, _FW_LINKED)) {
-			DBG_871X("%s %s(%pM), length:%d assoc_ssid.length:%d\n", __func__,
-					pmlmepriv->cur_network.network.Ssid.Ssid,
-					MAC_ARG(pmlmepriv->cur_network.network.MacAddress),
-					pmlmepriv->cur_network.network.Ssid.SsidLength,
-					pmlmepriv->assoc_ssid.SsidLength);
 			rtw_set_to_roam(padapter, 1);
 		}
 	}
@@ -1167,7 +1127,6 @@ static int rtw_suspend_free_assoc_resource(struct adapter *padapter)
 		rtw_indicate_disconnect(padapter);
 	}
 
-	DBG_871X("<== " FUNC_ADPT_FMT " exit....\n", FUNC_ADPT_ARG(padapter));
 	return _SUCCESS;
 }
 
@@ -1175,7 +1134,6 @@ static void rtw_suspend_normal(struct adapter *padapter)
 {
 	struct net_device *pnetdev = padapter->pnetdev;
 
-	DBG_871X("==> " FUNC_ADPT_FMT " entry....\n", FUNC_ADPT_ARG(padapter));
 	if (pnetdev) {
 		netif_carrier_off(pnetdev);
 		rtw_netif_stop_queue(pnetdev);
@@ -1191,8 +1149,6 @@ static void rtw_suspend_normal(struct adapter *padapter)
 	/* sdio_deinit(adapter_to_dvobj(padapter)); */
 	if (padapter->intf_deinit)
 		padapter->intf_deinit(adapter_to_dvobj(padapter));
-
-	DBG_871X("<== " FUNC_ADPT_FMT " exit....\n", FUNC_ADPT_ARG(padapter));
 }
 
 int rtw_suspend_common(struct adapter *padapter)
@@ -1206,7 +1162,6 @@ int rtw_suspend_common(struct adapter *padapter)
 	unsigned long start_time = jiffies;
 
 	DBG_871X_LEVEL(_drv_always_, " suspend start\n");
-	DBG_871X("==> %s (%s:%d)\n", __func__, current->comm, current->pid);
 	pdbgpriv->dbg_suspend_cnt++;
 
 	pwrpriv->bInSuspend = true;
@@ -1215,8 +1170,6 @@ int rtw_suspend_common(struct adapter *padapter)
 		msleep(1);
 
 	if ((!padapter->bup) || (padapter->bDriverStopped) || (padapter->bSurpriseRemoved)) {
-		DBG_871X("%s bup =%d bDriverStopped =%d bSurpriseRemoved = %d\n", __func__
-			, padapter->bup, padapter->bDriverStopped, padapter->bSurpriseRemoved);
 		pdbgpriv->dbg_suspend_error_cnt++;
 		goto exit;
 	}
@@ -1231,10 +1184,8 @@ int rtw_suspend_common(struct adapter *padapter)
 	/*  wait for the latest FW to remove this condition. */
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		hal_btcoex_SuspendNotify(padapter, 0);
-		DBG_871X("WIFI_AP_STATE\n");
 	} else if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 		hal_btcoex_SuspendNotify(padapter, 1);
-		DBG_871X("STATION\n");
 	}
 
 	rtw_ps_deny_cancel(padapter, PS_DENY_SUSPEND);
@@ -1251,8 +1202,6 @@ int rtw_suspend_common(struct adapter *padapter)
 		jiffies_to_msecs(jiffies - start_time));
 
 exit:
-	DBG_871X("<===  %s return %d.............. in %dms\n", __func__
-		, ret, jiffies_to_msecs(jiffies - start_time));
 
 	return ret;
 }
@@ -1277,8 +1226,6 @@ static int rtw_resume_process_normal(struct adapter *padapter)
 	pmlmepriv = &padapter->mlmepriv;
 	psdpriv = padapter->dvobj;
 	pdbgpriv = &psdpriv->drv_dbg;
-
-	DBG_871X("==> " FUNC_ADPT_FMT " entry....\n", FUNC_ADPT_ARG(padapter));
 	/*  interface init */
 	/* if (sdio_init(adapter_to_dvobj(padapter)) != _SUCCESS) */
 	if ((padapter->intf_init) && (padapter->intf_init(adapter_to_dvobj(padapter)) != _SUCCESS)) {
@@ -1295,7 +1242,6 @@ static int rtw_resume_process_normal(struct adapter *padapter)
 	rtw_reset_drv_sw(padapter);
 	pwrpriv->bkeepfwalive = false;
 
-	DBG_871X("bkeepfwalive(%x)\n", pwrpriv->bkeepfwalive);
 	if (pm_netdev_open(pnetdev, true) != 0) {
 		ret = -1;
 		pdbgpriv->dbg_resume_error_cnt++;
@@ -1306,27 +1252,19 @@ static int rtw_resume_process_normal(struct adapter *padapter)
 	netif_carrier_on(pnetdev);
 
 	if (padapter->pid[1] != 0) {
-		DBG_871X("pid[1]:%d\n", padapter->pid[1]);
 		rtw_signal_process(padapter->pid[1], SIGUSR2);
 	}
 
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
-		DBG_871X(FUNC_ADPT_FMT " fwstate:0x%08x - WIFI_STATION_STATE\n", FUNC_ADPT_ARG(padapter), get_fwstate(pmlmepriv));
-
 		if (rtw_chk_roam_flags(padapter, RTW_ROAM_ON_RESUME))
 			rtw_roaming(padapter, NULL);
 
 	} else if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
-		DBG_871X(FUNC_ADPT_FMT " fwstate:0x%08x - WIFI_AP_STATE\n", FUNC_ADPT_ARG(padapter), get_fwstate(pmlmepriv));
 		rtw_ap_restore_network(padapter);
 	} else if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
-		DBG_871X(FUNC_ADPT_FMT " fwstate:0x%08x - WIFI_ADHOC_STATE\n", FUNC_ADPT_ARG(padapter), get_fwstate(pmlmepriv));
 	} else {
-		DBG_871X(FUNC_ADPT_FMT " fwstate:0x%08x - ???\n", FUNC_ADPT_ARG(padapter), get_fwstate(pmlmepriv));
 	}
 
-	DBG_871X("<== " FUNC_ADPT_FMT " exit....\n", FUNC_ADPT_ARG(padapter));
-
 exit:
 	return ret;
 }
@@ -1339,7 +1277,6 @@ int rtw_resume_common(struct adapter *padapter)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	DBG_871X_LEVEL(_drv_always_, "resume start\n");
-	DBG_871X("==> %s (%s:%d)\n", __func__, current->comm, current->pid);
 
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 		rtw_resume_process_normal(padapter);
diff --git a/drivers/staging/rtl8723bs/os_dep/osdep_service.c b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
index 5e4200d6b00f..9c6b1666df13 100644
--- a/drivers/staging/rtl8723bs/os_dep/osdep_service.c
+++ b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
@@ -250,7 +250,6 @@ bool rtw_cbuf_push(struct rtw_cbuf *cbuf, void *buf)
 	if (rtw_cbuf_full(cbuf))
 		return _FAIL;
 
-	DBG_871X("%s on %u\n", __func__, cbuf->write);
 	cbuf->bufs[cbuf->write] = buf;
 	cbuf->write = (cbuf->write + 1) % cbuf->size;
 
@@ -270,7 +269,6 @@ void *rtw_cbuf_pop(struct rtw_cbuf *cbuf)
 	if (rtw_cbuf_empty(cbuf))
 		return NULL;
 
-	DBG_871X("%s on %u\n", __func__, cbuf->read);
 	buf = cbuf->bufs[cbuf->read];
 	cbuf->read = (cbuf->read + 1) % cbuf->size;
 
diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index f286c9499106..af39a021dc71 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -63,7 +63,6 @@ struct sk_buff *rtw_os_alloc_msdu_pkt(union recv_frame *prframe, u16 nSubframe_L
 
 	sub_skb = rtw_skb_alloc(nSubframe_Length + 12);
 	if (!sub_skb) {
-		DBG_871X("%s(): rtw_skb_alloc() Fail!!!\n", __func__);
 		return NULL;
 	}
 
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index deba03ad6c6e..99185fa73783 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -59,7 +59,6 @@ static void sd_sync_int_hdl(struct sdio_func *func)
 	psdpriv = sdio_get_drvdata(func);
 
 	if (!psdpriv->if1) {
-		DBG_871X("%s if1 == NULL\n", __func__);
 		return;
 	}
 
@@ -325,13 +324,6 @@ static struct adapter *rtw_sdio_if1_init(struct dvobj_priv *dvobj, const struct
 
 	rtw_hal_disable_interrupt(padapter);
 
-	DBG_871X("bDriverStopped:%d, bSurpriseRemoved:%d, bup:%d, hw_init_completed:%d\n"
-		, padapter->bDriverStopped
-		, padapter->bSurpriseRemoved
-		, padapter->bup
-		, padapter->hw_init_completed
-	);
-
 	status = _SUCCESS;
 
 free_hal_data:
@@ -368,7 +360,6 @@ static void rtw_sdio_if1_deinit(struct adapter *if1)
 	rtw_cancel_all_timer(if1);
 
 	rtw_dev_unload(if1);
-	DBG_871X("+r871xu_dev_remove, hw_init_completed =%d\n", if1->hw_init_completed);
 
 	if (if1->rtw_wdev) {
 		rtw_wdev_free(if1->rtw_wdev);
@@ -400,7 +391,6 @@ static int rtw_drv_init(
 
 	if1 = rtw_sdio_if1_init(dvobj, id);
 	if (if1 == NULL) {
-		DBG_871X("rtw_init_primarystruct adapter Failed!\n");
 		goto free_dvobj;
 	}
 
@@ -446,7 +436,6 @@ static void rtw_dev_remove(struct sdio_func *func)
 		sdio_release_host(func);
 		if (err == -ENOMEDIUM) {
 			padapter->bSurpriseRemoved = true;
-			DBG_871X(KERN_NOTICE "%s: device had been removed!\n", __func__);
 		}
 	}
 
@@ -473,12 +462,10 @@ static int rtw_sdio_suspend(struct device *dev)
 	struct debug_priv *pdbgpriv = &psdpriv->drv_dbg;
 
 	if (padapter->bDriverStopped) {
-		DBG_871X("%s bDriverStopped = %d\n", __func__, padapter->bDriverStopped);
 		return 0;
 	}
 
 	if (pwrpriv->bInSuspend) {
-		DBG_871X("%s bInSuspend = %d\n", __func__, pwrpriv->bInSuspend);
 		pdbgpriv->dbg_suspend_error_cnt++;
 		return 0;
 	}
@@ -494,7 +481,6 @@ static int rtw_resume_process(struct adapter *padapter)
 
 	if (!pwrpriv->bInSuspend) {
 		pdbgpriv->dbg_resume_error_cnt++;
-		DBG_871X("%s bInSuspend = %d\n", __func__, pwrpriv->bInSuspend);
 		return -1;
 	}
 
@@ -510,14 +496,11 @@ static int rtw_sdio_resume(struct device *dev)
 	int ret = 0;
 	struct debug_priv *pdbgpriv = &psdpriv->drv_dbg;
 
-	DBG_871X("==> %s (%s:%d)\n", __func__, current->comm, current->pid);
-
 	pdbgpriv->dbg_resume_cnt++;
 
 	ret = rtw_resume_process(padapter);
 
 	pmlmeext->last_scan_time = jiffies;
-	DBG_871X("<========  %s return %d\n", __func__, ret);
 	return ret;
 }
 
@@ -537,7 +520,6 @@ static int __init rtw_drv_entry(void)
 	if (ret != 0) {
 		sdio_drvpriv.drv_registered = false;
 		rtw_ndev_notifier_unregister();
-		DBG_871X("%s: register driver failed!!(%d)\n", __func__, ret);
 		goto exit;
 	}
 
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
index 079da433d811..ee68b564e8db 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
@@ -54,7 +54,7 @@ u8 sd_f0_read8(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
 	if (claim_needed)
 		sdio_release_host(func);
 	if (err && *err)
-		DBG_871X(KERN_ERR "%s: FAIL!(%d) addr = 0x%05x\n", __func__, *err, addr);
+		{}
 	return v;
 }
 
@@ -86,7 +86,6 @@ s32 _sd_cmd52_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdata)
 	for (i = 0; i < cnt; i++) {
 		pdata[i] = sdio_readb(func, addr + i, &err);
 		if (err) {
-			DBG_871X(KERN_ERR "%s: FAIL!(%d) addr = 0x%05x\n", __func__, err, addr + i);
 			break;
 		}
 	}
@@ -156,8 +155,6 @@ s32 _sd_cmd52_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pdata)
 	for (i = 0; i < cnt; i++) {
 		sdio_writeb(func, pdata[i], addr + i, &err);
 		if (err) {
-			DBG_871X(KERN_ERR "%s: FAIL!(%d) addr = 0x%05x val = 0x%02x\n", __func__,
-				 err, addr + i, pdata[i]);
 			break;
 		}
 	}
@@ -227,7 +224,7 @@ u8 sd_read8(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
 	if (claim_needed)
 		sdio_release_host(func);
 	if (err && *err)
-		DBG_871X(KERN_ERR "%s: FAIL!(%d) addr = 0x%05x\n", __func__, *err, addr);
+		{}
 	return v;
 }
 
@@ -261,8 +258,6 @@ u32 sd_read32(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
 	if (err && *err) {
 		int i;
 
-		DBG_871X(KERN_ERR "%s: (%d) addr = 0x%05x, val = 0x%x\n", __func__, *err, addr, v);
-
 		*err = 0;
 		for (i = 0; i < SD_IO_TRY_CNT; i++) {
 			if (claim_needed)
@@ -275,7 +270,6 @@ u32 sd_read32(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
 				rtw_reset_continual_io_error(psdiodev);
 				break;
 			} else {
-				DBG_871X(KERN_ERR "%s: (%d) addr = 0x%05x, val = 0x%x, try_cnt =%d\n", __func__, *err, addr, v, i);
 				if ((-ESHUTDOWN == *err) || (-ENODEV == *err))
 					padapter->bSurpriseRemoved = true;
 
@@ -287,9 +281,9 @@ u32 sd_read32(struct intf_hdl *pintfhdl, u32 addr, s32 *err)
 		}
 
 		if (i == SD_IO_TRY_CNT)
-			DBG_871X(KERN_ERR "%s: FAIL!(%d) addr = 0x%05x, val = 0x%x, try_cnt =%d\n", __func__, *err, addr, v, i);
+			{}
 		else
-			DBG_871X(KERN_ERR "%s: (%d) addr = 0x%05x, val = 0x%x, try_cnt =%d\n", __func__, *err, addr, v, i);
+			{}
 
 	}
 	return  v;
@@ -321,7 +315,7 @@ void sd_write8(struct intf_hdl *pintfhdl, u32 addr, u8 v, s32 *err)
 	if (claim_needed)
 		sdio_release_host(func);
 	if (err && *err)
-		DBG_871X(KERN_ERR "%s: FAIL!(%d) addr = 0x%05x val = 0x%02x\n", __func__, *err, addr, v);
+		{}
 }
 
 void sd_write32(struct intf_hdl *pintfhdl, u32 addr, u32 v, s32 *err)
@@ -353,8 +347,6 @@ void sd_write32(struct intf_hdl *pintfhdl, u32 addr, u32 v, s32 *err)
 	if (err && *err) {
 		int i;
 
-		DBG_871X(KERN_ERR "%s: (%d) addr = 0x%05x val = 0x%08x\n", __func__, *err, addr, v);
-
 		*err = 0;
 		for (i = 0; i < SD_IO_TRY_CNT; i++) {
 			if (claim_needed)
@@ -366,7 +358,6 @@ void sd_write32(struct intf_hdl *pintfhdl, u32 addr, u32 v, s32 *err)
 				rtw_reset_continual_io_error(psdiodev);
 				break;
 			} else {
-				DBG_871X(KERN_ERR "%s: (%d) addr = 0x%05x, val = 0x%x, try_cnt =%d\n", __func__, *err, addr, v, i);
 				if ((-ESHUTDOWN == *err) || (-ENODEV == *err))
 					padapter->bSurpriseRemoved = true;
 
@@ -378,9 +369,9 @@ void sd_write32(struct intf_hdl *pintfhdl, u32 addr, u32 v, s32 *err)
 		}
 
 		if (i == SD_IO_TRY_CNT)
-			DBG_871X(KERN_ERR "%s: FAIL!(%d) addr = 0x%05x val = 0x%08x, try_cnt =%d\n", __func__, *err, addr, v, i);
+			{}
 		else
-			DBG_871X(KERN_ERR "%s: (%d) addr = 0x%05x val = 0x%08x, try_cnt =%d\n", __func__, *err, addr, v, i);
+			{}
 	}
 }
 
@@ -427,7 +418,6 @@ s32 _sd_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 			*(pbuf + i) = sdio_readb(func, addr + i, &err);
 
 			if (err) {
-				DBG_871X(KERN_ERR "%s: FAIL!(%d) addr = 0x%05x\n", __func__, err, addr);
 				break;
 			}
 		}
@@ -436,7 +426,7 @@ s32 _sd_read(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 
 	err = sdio_memcpy_fromio(func, pdata, addr, cnt);
 	if (err)
-		DBG_871X(KERN_ERR "%s: FAIL(%d)! ADDR =%#x Size =%d\n", __func__, err, addr, cnt);
+		{}
 
 	return err;
 }
@@ -527,8 +517,6 @@ s32 _sd_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 		for (i = 0; i < cnt; i++) {
 			sdio_writeb(func, *(pbuf + i), addr + i, &err);
 			if (err) {
-				DBG_871X(KERN_ERR "%s: FAIL!(%d) addr = 0x%05x val = 0x%02x\n",
-					 __func__, err, addr, *(pbuf + i));
 				break;
 			}
 		}
@@ -539,7 +527,7 @@ s32 _sd_write(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, void *pdata)
 	size = cnt;
 	err = sdio_memcpy_toio(func, addr, pdata, size);
 	if (err)
-		DBG_871X(KERN_ERR "%s: FAIL(%d)! ADDR =%#x Size =%d(%d)\n", __func__, err, addr, cnt, size);
+		{}
 
 	return err;
 }
diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
index 1dc0787a80da..f0bd29a66395 100644
--- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
@@ -173,12 +173,10 @@ static int rtw_mlcst2unicst(struct adapter *padapter, struct sk_buff *skb)
 			memcpy(newskb->data, psta->hwaddr, 6);
 			res = rtw_xmit(padapter, &newskb);
 			if (res < 0) {
-				DBG_871X("%s()-%d: rtw_xmit() return error!\n", __func__, __LINE__);
 				pxmitpriv->tx_drop++;
 				dev_kfree_skb_any(newskb);
 			}
 		} else {
-			DBG_871X("%s-%d: rtw_skb_copy() failed!\n", __func__, __LINE__);
 			pxmitpriv->tx_drop++;
 			/* dev_kfree_skb_any(skb); */
 			return false;	/*  Caller shall tx this multicast frame via normal way. */
@@ -198,7 +196,6 @@ int _rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
 
 	if (rtw_if_up(padapter) == false) {
 		#ifdef DBG_TX_DROP_FRAME
-		DBG_871X("DBG_TX_DROP_FRAME %s if_up fail\n", __func__);
 		#endif
 		goto drop_packet;
 	}
@@ -224,7 +221,6 @@ int _rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
 	res = rtw_xmit(padapter, &pkt);
 	if (res < 0) {
 		#ifdef DBG_TX_DROP_FRAME
-		DBG_871X("DBG_TX_DROP_FRAME %s rtw_xmit fail\n", __func__);
 		#endif
 		goto drop_packet;
 	}
-- 
2.20.1

