Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCD63A72D7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 02:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhFOAR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 20:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhFOAR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 20:17:56 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D33C061767
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:15:40 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id i68so36727663qke.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EK/XjKlPss6dDuvMGZ+OrIaZvyCfgXSmCD0kbK6k3l8=;
        b=k3Kd5ey5vppBS3IPYEJZath9JTdaTy7lX1qxqeJWe3VsV2chGk/cj2jGqHBlpBzDgC
         9gyhDwmrVVsaL1Rlq7L1mvk5SPTAYoh2PjGnblP/AXjPzzV1alOfA9nfiahqCnzwp/Rz
         Ki1YqLomKU/Hf/fp0IQAM86/Tf4bJeAZvigiyqU7+wlBuSTCbMF/XChe6Bkm4gOh1BNv
         gGU5SvwY3QmopJkP9y8Q3E7oISPLloWG5s5O1OrmiJzWTQVbnutEuwrp19QHRybdjFzn
         TTbsZDVS0IxE9YnjDoBH0FS/W0j2NJbxQZiB8ym4JjTRl/FzNzTZr4eFiqczAoYyOEr8
         2AMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EK/XjKlPss6dDuvMGZ+OrIaZvyCfgXSmCD0kbK6k3l8=;
        b=a0E+JQT9ezlBraKtqQvgVTzDiMQAacw4ksufwgBrvEfILb7ps0iKx+Z8Qfm97sFe1D
         mphQ0TnDmcpIhrsuEc2EhrCHp+AWbAa84tZS4FXaHlpec6V4vF8BILUm2HoBwPqGaGXx
         VqiJiQc/7lTV8NmZ86pHWqUiAfVBtfSTuL330AnOH/W7PBp7qNBxdpa+8ZJB0IHxj/VG
         c14ZRe+faT01O54pDzlJL5MX/I3UBnpXWfNzNKGPImJt1ShMcI/PIxKTodvaq+o0A0FM
         Yzijuynt+URbuLKyfEQJhQ+d6b3dXzRFQNZQGDo/AV0HaYRq19bU75VgU8dYlh1sAv/j
         8B1A==
X-Gm-Message-State: AOAM531Mqn/y2VBaUe4WWC2LtegTj4IgCUVn/5qX2GQHufCY9ndzZSFm
        Fo4gw+JB6xtFXBrSNChmv5pazA==
X-Google-Smtp-Source: ABdhPJzZy7/OhkLaHwnNvopnxxpQM2+WAVSrpD/yimAWR34aXH5BTa+laYuSJWTrgS32HKlsWkiCjg==
X-Received: by 2002:a37:f502:: with SMTP id l2mr18619257qkk.195.1623716139984;
        Mon, 14 Jun 2021 17:15:39 -0700 (PDT)
Received: from localhost.localdomain (5.d.e.a.c.b.a.1.5.0.9.4.d.7.7.d.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:d77d:4905:1abc:aed5])
        by smtp.gmail.com with ESMTPSA id m199sm11244248qke.71.2021.06.14.17.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 17:15:39 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 05/28] staging: rtl8188eu: remove all DBG_88E calls from core/rtw_ap.c
Date:   Tue, 15 Jun 2021 01:14:44 +0100
Message-Id: <20210615001507.1171-6-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615001507.1171-1-phil@philpotter.co.uk>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E calls from core/rtw_ap.c as this macro is
unnecessary, and many of these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/core/rtw_ap.c | 78 +------------------------
 1 file changed, 2 insertions(+), 76 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index 9399c17bfdbf..b817aa8b9de4 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -183,9 +183,6 @@ void expire_timeout_chk(struct adapter *padapter)
 				list_del_init(&psta->auth_list);
 				pstapriv->auth_list_cnt--;
 
-				DBG_88E("auth expire %6ph\n",
-					psta->hwaddr);
-
 				spin_unlock_bh(&pstapriv->auth_list_lock);
 
 				spin_lock_bh(&pstapriv->sta_hash_lock);
@@ -254,20 +251,13 @@ void expire_timeout_chk(struct adapter *padapter)
 			list_del_init(&psta->asoc_list);
 			pstapriv->asoc_list_cnt--;
 
-			DBG_88E("asoc expire %pM, state = 0x%x\n",
-				(psta->hwaddr), psta->state);
 			updated = ap_free_sta(padapter, psta, true,
 					      WLAN_REASON_DEAUTH_LEAVING);
 		} else {
 			/* TODO: Aging mechanism to digest frames in sleep_q to avoid running out of xmitframe */
 			if (psta->sleepq_len > (NR_XMITFRAME / pstapriv->asoc_list_cnt) &&
-			    padapter->xmitpriv.free_xmitframe_cnt < (NR_XMITFRAME / pstapriv->asoc_list_cnt / 2)) {
-				DBG_88E("%s sta:%pM, sleepq_len:%u, free_xmitframe_cnt:%u, asoc_list_cnt:%u, clear sleep_q\n", __func__,
-					(psta->hwaddr), psta->sleepq_len,
-					padapter->xmitpriv.free_xmitframe_cnt,
-					pstapriv->asoc_list_cnt);
+			    padapter->xmitpriv.free_xmitframe_cnt < (NR_XMITFRAME / pstapriv->asoc_list_cnt / 2))
 				wakeup_sta_to_xmit(padapter, psta);
-			}
 		}
 	}
 
@@ -299,21 +289,16 @@ void expire_timeout_chk(struct adapter *padapter)
 
 			psta->keep_alive_trycnt++;
 			if (ret == _SUCCESS) {
-				DBG_88E("asoc check, sta(%pM) is alive\n",
-					(psta->hwaddr));
 				psta->expire_to = pstapriv->expire_to;
 				psta->keep_alive_trycnt = 0;
 				continue;
 			} else if (psta->keep_alive_trycnt <= 3) {
-				DBG_88E("ack check for asoc expire, keep_alive_trycnt =%d\n", psta->keep_alive_trycnt);
 				psta->expire_to = 1;
 				continue;
 			}
 
 			psta->keep_alive_trycnt = 0;
 
-			DBG_88E("asoc expire %pM, state = 0x%x\n",
-				psta->hwaddr, psta->state);
 			spin_lock_bh(&pstapriv->asoc_list_lock);
 			list_del_init(&psta->asoc_list);
 			pstapriv->asoc_list_cnt--;
@@ -384,9 +369,6 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 
 		tx_ra_bitmap |= ((raid << 28) & 0xf0000000);
 
-		DBG_88E("%s => mac_id:%d , raid:%d , bitmap = 0x%x, arg = 0x%x\n",
-			__func__, psta->mac_id, raid, tx_ra_bitmap, arg);
-
 		/* bitmap[0:27] = tx_rate_bitmap */
 		/* bitmap[28:31]= Rate Adaptive id */
 		/* arg[0:4] = macid */
@@ -400,8 +382,6 @@ void add_RATid(struct adapter *padapter, struct sta_info *psta, u8 rssi_level)
 		psta->raid = raid;
 		psta->init_rate = init_rate;
 
-	} else {
-		DBG_88E("station aid %d exceed the max number\n", psta->aid);
 	}
 }
 
@@ -457,8 +437,6 @@ static void update_bmc_sta(struct adapter *padapter)
 			arg = psta->mac_id & 0x1f;
 			arg |= BIT(7);
 			tx_ra_bitmap |= ((raid << 28) & 0xf0000000);
-			DBG_88E("%s, mask = 0x%x, arg = 0x%x\n", __func__,
-				tx_ra_bitmap, arg);
 
 			/* bitmap[0:27] = tx_rate_bitmap */
 			/* bitmap[28:31]= Rate Adaptive id */
@@ -476,8 +454,6 @@ static void update_bmc_sta(struct adapter *padapter)
 		psta->state = _FW_LINKED;
 		spin_unlock_bh(&psta->lock);
 
-	} else {
-		DBG_88E("add_RATid_bmc_sta error!\n");
 	}
 }
 
@@ -572,8 +548,6 @@ static void update_hw_ht_param(struct adapter *padapter)
 
 	/* Config SM Power Save setting */
 	pmlmeinfo->SM_PS = (le16_to_cpu(pmlmeinfo->HT_caps.cap_info) & 0x0C) >> 2;
-	if (pmlmeinfo->SM_PS == WLAN_HT_CAP_SM_PS_STATIC)
-		DBG_88E("%s(): WLAN_HT_CAP_SM_PS_STATIC\n", __func__);
 }
 
 static void start_bss_network(struct adapter *padapter, u8 *pbuf)
@@ -685,9 +659,6 @@ static void start_bss_network(struct adapter *padapter, u8 *pbuf)
 	 */
 	set_channel_bwmode(padapter, cur_channel, cur_ch_offset, cur_bwmode);
 
-	DBG_88E("CH =%d, BW =%d, offset =%d\n", cur_channel, cur_bwmode,
-		cur_ch_offset);
-
 	/*  */
 	pmlmeext->cur_channel = cur_channel;
 	pmlmeext->cur_bwmode = cur_bwmode;
@@ -707,8 +678,7 @@ static void start_bss_network(struct adapter *padapter, u8 *pbuf)
 		update_beacon(padapter, WLAN_EID_TIM, NULL, false);
 
 		/* issue beacon frame */
-		if (send_beacon(padapter) == _FAIL)
-			DBG_88E("send_beacon, fail!\n");
+		send_beacon(padapter);
 	}
 
 	/* update bc/mc sta_info */
@@ -746,8 +716,6 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	/* ht_capab, ht_oper */
 	/* WPS IE */
 
-	DBG_88E("%s, len =%d\n", __func__, len);
-
 	if (!check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		return _FAIL;
 
@@ -999,8 +967,6 @@ void rtw_set_macaddr_acl(struct adapter *padapter, int mode)
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct wlan_acl_pool *pacl_list = &pstapriv->acl_list;
 
-	DBG_88E("%s, mode =%d\n", __func__, mode);
-
 	pacl_list->mode = mode;
 }
 
@@ -1014,8 +980,6 @@ int rtw_acl_add_sta(struct adapter *padapter, u8 *addr)
 	struct wlan_acl_pool *pacl_list = &pstapriv->acl_list;
 	struct __queue *pacl_node_q = &pacl_list->acl_node_q;
 
-	DBG_88E("%s(acl_num =%d) =%pM\n", __func__, pacl_list->num, (addr));
-
 	if ((NUM_ACL - 1) < pacl_list->num)
 		return -1;
 
@@ -1028,7 +992,6 @@ int rtw_acl_add_sta(struct adapter *padapter, u8 *addr)
 		if (!memcmp(paclnode->addr, addr, ETH_ALEN)) {
 			if (paclnode->valid) {
 				added = true;
-				DBG_88E("%s, sta has been added\n", __func__);
 				break;
 			}
 		}
@@ -1059,8 +1022,6 @@ int rtw_acl_add_sta(struct adapter *padapter, u8 *addr)
 		}
 	}
 
-	DBG_88E("%s, acl_num =%d\n", __func__, pacl_list->num);
-
 	spin_unlock_bh(&pacl_node_q->lock);
 
 	return ret;
@@ -1074,8 +1035,6 @@ int rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
 	struct wlan_acl_pool *pacl_list = &pstapriv->acl_list;
 	struct __queue *pacl_node_q = &pacl_list->acl_node_q;
 
-	DBG_88E("%s(acl_num =%d) =%pM\n", __func__, pacl_list->num, (addr));
-
 	spin_lock_bh(&pacl_node_q->lock);
 
 	phead = get_list_head(pacl_node_q);
@@ -1093,7 +1052,6 @@ int rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
 
 	spin_unlock_bh(&pacl_node_q->lock);
 
-	DBG_88E("%s, acl_num =%d\n", __func__, pacl_list->num);
 	return 0;
 }
 
@@ -1106,8 +1064,6 @@ static void update_bcn_erpinfo_ie(struct adapter *padapter)
 	unsigned char *p, *ie = pnetwork->ies;
 	u32 len = 0;
 
-	DBG_88E("%s, ERP_enable =%d\n", __func__, pmlmeinfo->ERP_enable);
-
 	if (!pmlmeinfo->ERP_enable)
 		return;
 
@@ -1187,8 +1143,6 @@ static void update_bcn_vendor_spec_ie(struct adapter *padapter, u8 *oui)
 
 	if (!memcmp(WPS_OUI, oui, 4))
 		update_bcn_wps_ie(padapter);
-	else
-		DBG_88E("unknown OUI type!\n");
 }
 
 void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx)
@@ -1251,9 +1205,6 @@ static int rtw_ht_operation_update(struct adapter *padapter)
 	if (pmlmepriv->htpriv.ht_option)
 		return 0;
 
-	DBG_88E("%s current operation mode = 0x%X\n",
-		__func__, pmlmepriv->ht_op_mode);
-
 	if (!(pmlmepriv->ht_op_mode & HT_INFO_OPERATION_MODE_NON_GF_DEVS_PRESENT) &&
 	    pmlmepriv->num_sta_ht_no_gf) {
 		pmlmepriv->ht_op_mode |=
@@ -1303,9 +1254,6 @@ static int rtw_ht_operation_update(struct adapter *padapter)
 		op_mode_changes++;
 	}
 
-	DBG_88E("%s new operation mode = 0x%X changes =%d\n",
-		__func__, pmlmepriv->ht_op_mode, op_mode_changes);
-
 	return op_mode_changes;
 }
 
@@ -1416,9 +1364,6 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 	if (psta->flags & WLAN_STA_HT) {
 		u16 ht_capab = le16_to_cpu(psta->htpriv.ht_cap.cap_info);
 
-		DBG_88E("HT: STA %pM HT Capabilities Info: 0x%04x\n",
-			(psta->hwaddr), ht_capab);
-
 		if (psta->no_ht_set) {
 			psta->no_ht_set = 0;
 			pmlmepriv->num_sta_no_ht--;
@@ -1429,9 +1374,6 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 				psta->no_ht_gf_set = 1;
 				pmlmepriv->num_sta_ht_no_gf++;
 			}
-			DBG_88E("%s STA %pM - no greenfield, num of non-gf stations %d\n",
-				__func__, (psta->hwaddr),
-				pmlmepriv->num_sta_ht_no_gf);
 		}
 
 		if ((ht_capab & IEEE80211_HT_CAP_SUP_WIDTH_20_40) == 0) {
@@ -1439,20 +1381,12 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 				psta->ht_20mhz_set = 1;
 				pmlmepriv->num_sta_ht_20mhz++;
 			}
-			DBG_88E("%s STA %pM - 20 MHz HT, num of 20MHz HT STAs %d\n",
-				__func__, (psta->hwaddr),
-				pmlmepriv->num_sta_ht_20mhz);
 		}
 	} else {
 		if (!psta->no_ht_set) {
 			psta->no_ht_set = 1;
 			pmlmepriv->num_sta_no_ht++;
 		}
-		if (pmlmepriv->htpriv.ht_option) {
-			DBG_88E("%s STA %pM - no HT, num of non-HT stations %d\n",
-				__func__, (psta->hwaddr),
-				pmlmepriv->num_sta_no_ht);
-		}
 	}
 
 	if (rtw_ht_operation_update(padapter) > 0) {
@@ -1462,8 +1396,6 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 
 	/* update associated stations cap. */
 	associated_clients_update(padapter,  beacon_updated);
-
-	DBG_88E("%s, updated =%d\n", __func__, beacon_updated);
 }
 
 u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta)
@@ -1526,8 +1458,6 @@ u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta)
 
 	/* update associated stations cap. */
 
-	DBG_88E("%s, updated =%d\n", __func__, beacon_updated);
-
 	return beacon_updated;
 }
 
@@ -1580,8 +1510,6 @@ int rtw_sta_flush(struct adapter *padapter)
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
-	DBG_88E(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(padapter->pnetdev));
-
 	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
 		return 0;
 
@@ -1719,8 +1647,6 @@ void stop_ap_mode(struct adapter *padapter)
 	}
 	spin_unlock_bh(&pacl_node_q->lock);
 
-	DBG_88E("%s, free acl_node_queue, num =%d\n", __func__, pacl_list->num);
-
 	rtw_sta_flush(padapter);
 
 	/* free_assoc_sta_resources */
-- 
2.30.2

