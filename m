Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB660405B9A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 18:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239687AbhIIQ70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 12:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237002AbhIIQ7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 12:59:25 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D5EC061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 09:58:16 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id s20so3341499oiw.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 09:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gPBOrGWdsOHFecocyOlDS82ne3N1lR+8IshWbaUphiU=;
        b=B8Dh0q89UY7+ChrR2FIVnszlRqd4FUS01I+jlYzRTP+dstViW/Appc+GzIYKi/EDgs
         WyvxrSPNJD/P9qjl9hhEaoZZw3f+Sf81RbaDpqE+yG1R09wesIQcgviBmknmgFQcN160
         5r1KjGyoeLoZzZFH+sYKahE3oJ7KzoSezG7MK3kYGDZNeOIXGyNOSMRxWHk8uodnokxU
         pTaCcttCG7kfS2Gu+cKauDd/ADQXhEUIM32WWm+4Ms9lVd71rI5jM9gCZAUDDI0UkuRT
         e5fuxcKzqElgPzB5+bEAc7/mj2U9OgLPuVNKUS7m7ZnVbl72YRgfzUSowWJIhaetdHVh
         9eHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=gPBOrGWdsOHFecocyOlDS82ne3N1lR+8IshWbaUphiU=;
        b=P+MYL6WvD/3f5wRMqK/K98dPKizgFEZL/WyKr4gY8dtjF9nljiAVo/GgLZEOFKcJEH
         /tsYPI3zlUF1qp5osNR2LgbTHGWyGR6YZzYrJj2NJ1UmaYfuVxL1QYhcSrZugt/IqYbA
         yBhwNH2HetZz6xKO3blWJmjcB27RbOEsyG2UEs82UwTy9SypmkyFdhhHYxWNtsRQ8e3+
         o9+713MKhNPFwaewzCqCtGYsGti3UVhETyx+7C5KxdCy6F97jrI3hvXllGR0b3XhqE8R
         pwfdefoj6q1QSX0xQ63kC7N/YfgM+Kn+3OjVQuAqCRwiTztX+fQsRaYB6IGcXaknE1Uz
         an7Q==
X-Gm-Message-State: AOAM531Y6KkTR93XIgB5MmCudrlZBDUpB0B5e5Cy4/eykXh+ycSfNZVp
        suCEVZcekpzEs8tule8TjSk=
X-Google-Smtp-Source: ABdhPJwBpiWfBR8MCMy2OOwy+Os+TnwyKqN3EUsThj8Qe7ARhtfJ5RCz6Se35lwkI/6sVxLhUgElmA==
X-Received: by 2002:aca:a90a:: with SMTP id s10mr621683oie.12.1631206694874;
        Thu, 09 Sep 2021 09:58:14 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-102d.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-102d.res6.spectrum.com. [2603:8090:2005:39b3::102d])
        by smtp.gmail.com with ESMTPSA id d10sm511784ooj.24.2021.09.09.09.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 09:58:14 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v3] staging: r8188eu: Remove conditionals CONFIG_88EU_{AP_MODE,P2P}
Date:   Thu,  9 Sep 2021 11:58:09 -0500
Message-Id: <20210909165809.12634-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These rwo conditional compile symbols are explicitely defined.
As a result, their included code is always compiled. They could be
converted to Kconfig symbols; however, my experience with this driver
in a GitHub repo is that many users of the device have it built into
a SOC or SBC that they wish to use as an access point. As a result,
CONFIG_88EU_APMODE would need to be selected. Thuse it should be built in.

There have also been many users the wish to establish peer-to-peer
networks with this device. For this reason, I am also proposing that
CONFIG_88EU_P2P be automatically included.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - removed AP symbol from Kconfig following GregKH suggestion
v3 - fixed some merge problems with Greg's tree
---
 drivers/staging/r8188eu/Kconfig               |  10 --
 drivers/staging/r8188eu/core/rtw_ap.c         |   8 -
 drivers/staging/r8188eu/core/rtw_cmd.c        |  13 --
 drivers/staging/r8188eu/core/rtw_debug.c      |   3 -
 drivers/staging/r8188eu/core/rtw_ieee80211.c  |   5 -
 drivers/staging/r8188eu/core/rtw_ioctl_set.c  |   5 -
 drivers/staging/r8188eu/core/rtw_mlme.c       |  20 +--
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 156 ++----------------
 drivers/staging/r8188eu/core/rtw_p2p.c        |  16 --
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    |  19 ---
 drivers/staging/r8188eu/core/rtw_recv.c       |   9 -
 drivers/staging/r8188eu/core/rtw_sta_mgt.c    |  17 --
 drivers/staging/r8188eu/core/rtw_wlan_util.c  |   2 -
 drivers/staging/r8188eu/core/rtw_xmit.c       |   6 -
 drivers/staging/r8188eu/hal/hal_intf.c        |   2 -
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |   3 -
 drivers/staging/r8188eu/hal/usb_halinit.c     |   2 -
 drivers/staging/r8188eu/include/drv_types.h   |   8 -
 drivers/staging/r8188eu/include/ieee80211.h   |  12 --
 .../staging/r8188eu/include/ioctl_cfg80211.h  |   2 -
 .../staging/r8188eu/include/rtl8188e_cmd.h    |   2 -
 .../staging/r8188eu/include/rtl8188e_hal.h    |   2 -
 drivers/staging/r8188eu/include/rtw_ap.h      |   5 -
 drivers/staging/r8188eu/include/rtw_cmd.h     |   4 -
 drivers/staging/r8188eu/include/rtw_debug.h   |   4 -
 drivers/staging/r8188eu/include/rtw_mlme.h    |   5 -
 .../staging/r8188eu/include/rtw_mlme_ext.h    |   4 -
 .../staging/r8188eu/include/rtw_security.h    |   2 -
 drivers/staging/r8188eu/include/rtw_xmit.h    |   2 -
 drivers/staging/r8188eu/include/sta_info.h    |   7 -
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  38 -----
 drivers/staging/r8188eu/os_dep/mlme_linux.c   |   4 -
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  13 --
 drivers/staging/r8188eu/os_dep/usb_intf.c     |   4 -
 .../staging/r8188eu/os_dep/usb_ops_linux.c    |   2 -
 35 files changed, 12 insertions(+), 404 deletions(-)

diff --git a/drivers/staging/r8188eu/Kconfig b/drivers/staging/r8188eu/Kconfig
index dc1719d3f2e4..f5fe423530f0 100644
--- a/drivers/staging/r8188eu/Kconfig
+++ b/drivers/staging/r8188eu/Kconfig
@@ -14,13 +14,3 @@ config R8188EU
 	sources for version v4.1.4_6773.20130222, and contains modifications for
 	newer kernel features. If built as a module, it will be called r8188eu.
 
-if R8188EU
-
-config 88EU_AP_MODE
-	bool "Realtek RTL8188EU AP mode"
-	help
-	This option enables Access Point mode. Unless you know that your system
-	will never be used as an AP, or the target system has limited memory,
-	"Y" should be selected.
-
-endif
diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 8e6b1964f533..84f853c304f4 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -9,8 +9,6 @@
 #include "../include/ieee80211.h"
 #include "../include/rtl8188e_cmd.h"
 
-#ifdef CONFIG_88EU_AP_MODE
-
 void init_mlme_ap_info(struct adapter *padapter)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -604,9 +602,7 @@ static void start_bss_network(struct adapter *padapter, u8 *pbuf)
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	struct wlan_bssid_ex *pnetwork_mlmeext = &pmlmeinfo->network;
 	struct HT_info_element *pht_info = NULL;
-#ifdef CONFIG_88EU_P2P
 	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
-#endif /* CONFIG_88EU_P2P */
 
 	bcn_interval = (u16)pnetwork->Configuration.BeaconPeriod;
 	cur_channel = pnetwork->Configuration.DSConfig;
@@ -707,10 +703,8 @@ static void start_bss_network(struct adapter *padapter, u8 *pbuf)
 	/* let pnetwork_mlmeext == pnetwork_mlme. */
 	memcpy(pnetwork_mlmeext, pnetwork, pnetwork->Length);
 
-#ifdef CONFIG_88EU_P2P
 	memcpy(pwdinfo->p2p_group_ssid, pnetwork->Ssid.Ssid, pnetwork->Ssid.SsidLength);
 	pwdinfo->p2p_group_ssid_len = pnetwork->Ssid.SsidLength;
-#endif /* CONFIG_88EU_P2P */
 
 	if (pmlmeext->bstart_bss) {
 		update_beacon(padapter, _TIM_IE_, NULL, false);
@@ -1847,5 +1841,3 @@ void stop_ap_mode(struct adapter *padapter)
 
 	rtw_free_mlme_priv_ie_data(pmlmepriv);
 }
-
-#endif /* CONFIG_88EU_AP_MODE */
diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index a52c17dd2e5a..b3695f1282de 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1488,10 +1488,8 @@ static void dynamic_chk_wk_hdl(struct adapter *padapter, u8 *pbuf, int sz)
 	padapter = (struct adapter *)pbuf;
 	pmlmepriv = &padapter->mlmepriv;
 
-#ifdef CONFIG_88EU_AP_MODE
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE))
 		expire_timeout_chk(padapter);
-#endif
 
 	rtl8188e_sreset_xmit_status_check(padapter);
 
@@ -1676,7 +1674,6 @@ static void power_saving_wk_hdl(struct adapter *padapter, u8 *pbuf, int sz)
 	 rtw_ps_processor(padapter);
 }
 
-#ifdef CONFIG_88EU_P2P
 u8 p2p_protocol_wk_cmd(struct adapter *padapter, int intCmdType)
 {
 	struct cmd_obj	*ph2c;
@@ -1713,7 +1710,6 @@ u8 p2p_protocol_wk_cmd(struct adapter *padapter, int intCmdType)
 
 	return res;
 }
-#endif /* CONFIG_88EU_P2P */
 
 u8 rtw_ps_cmd(struct adapter *padapter)
 {
@@ -1747,8 +1743,6 @@ u8 rtw_ps_cmd(struct adapter *padapter)
 	return res;
 }
 
-#ifdef CONFIG_88EU_AP_MODE
-
 static void rtw_chk_hi_queue_hdl(struct adapter *padapter)
 {
 	int cnt = 0;
@@ -1819,7 +1813,6 @@ u8 rtw_chk_hi_queue_cmd(struct adapter *padapter)
 exit:
 	return res;
 }
-#endif
 
 u8 rtw_c2h_wk_cmd(struct adapter *padapter, u8 *c2h_evt)
 {
@@ -1896,10 +1889,8 @@ static void c2h_wk_callback(struct work_struct *work)
 			continue;
 		}
 
-#ifdef CONFIG_88EU_P2P
 		/* Enqueue into cmd_thread for others */
 		rtw_c2h_wk_cmd(adapter, (u8 *)c2h_evt);
-#endif
 	}
 
 	evtpriv->c2h_wk_alive = false;
@@ -1930,7 +1921,6 @@ u8 rtw_drvextra_cmd_hdl(struct adapter *padapter, unsigned char *pbuf)
 	case ANT_SELECT_WK_CID:
 		antenna_select_wk_hdl(padapter, pdrvextra_cmd->type_size);
 		break;
-#ifdef CONFIG_88EU_P2P
 	case P2P_PS_WK_CID:
 		p2p_ps_wk_hdl(padapter, pdrvextra_cmd->type_size);
 		break;
@@ -1939,12 +1929,9 @@ u8 rtw_drvextra_cmd_hdl(struct adapter *padapter, unsigned char *pbuf)
 		/* 	I used the type_size as the type command */
 		p2p_protocol_wk_hdl(padapter, pdrvextra_cmd->type_size);
 		break;
-#endif
-#ifdef CONFIG_88EU_AP_MODE
 	case CHECK_HIQ_WK_CID:
 		rtw_chk_hi_queue_hdl(padapter);
 		break;
-#endif /* CONFIG_88EU_AP_MODE */
 	case C2H_WK_CID:
 		c2h_evt_hdl(padapter, (struct c2h_evt_hdr *)pdrvextra_cmd->pbuf, NULL);
 		break;
diff --git a/drivers/staging/r8188eu/core/rtw_debug.c b/drivers/staging/r8188eu/core/rtw_debug.c
index c5bb8b05b3c2..65daf674ea69 100644
--- a/drivers/staging/r8188eu/core/rtw_debug.c
+++ b/drivers/staging/r8188eu/core/rtw_debug.c
@@ -795,8 +795,6 @@ int proc_set_rssi_disp(struct file *file, const char __user *buffer,
 	return count;
 }
 
-#ifdef CONFIG_88EU_AP_MODE
-
 int proc_get_all_sta_info(char *page, char **start,
 			  off_t offset, int count,
 			  int *eof, void *data)
@@ -851,7 +849,6 @@ int proc_get_all_sta_info(char *page, char **start,
 	*eof = 1;
 	return len;
 }
-#endif
 
 int proc_get_best_channel(char *page, char **start,
 			  off_t offset, int count,
diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index 952ad3eec5bc..5f8bd8cd886d 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -1051,9 +1051,7 @@ void dump_ies(u8 *buf, u32 buf_len)
 		len = *(pos + 1);
 
 		DBG_88E("%s ID:%u, LEN:%u\n", __func__, id, len);
-		#ifdef CONFIG_88EU_P2P
 		dump_p2p_ie(pos, len);
-		#endif
 		dump_wps_ie(pos, len);
 
 		pos += (2 + len);
@@ -1081,7 +1079,6 @@ void dump_wps_ie(u8 *ie, u32 ie_len)
 	}
 }
 
-#ifdef CONFIG_88EU_P2P
 void dump_p2p_ie(u8 *ie, u32 ie_len)
 {
 	u8 *pos = (u8 *)ie;
@@ -1283,8 +1280,6 @@ void rtw_wlan_bssid_ex_remove_p2p_attr(struct wlan_bssid_ex *bss_ex, u8 attr_id)
 	}
 }
 
-#endif /* CONFIG_88EU_P2P */
-
 /* Baron adds to avoid FreeBSD warning */
 int ieee80211_is_empty_essid(const char *essid, int essid_len)
 {
diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index c187de78b4ac..8f5611d9d0d8 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -312,9 +312,7 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
 			/* change to other mode from Ndis802_11APMode */
 			cur_network->join_res = -1;
 
-#ifdef CONFIG_88EU_AP_MODE
 			stop_ap_mode(padapter);
-#endif
 		}
 
 		if ((check_fwstate(pmlmepriv, _FW_LINKED)) ||
@@ -343,9 +341,6 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
 			break;
 		case Ndis802_11APMode:
 			set_fwstate(pmlmepriv, WIFI_AP_STATE);
-#ifdef CONFIG_88EU_AP_MODE
-			start_ap_mode(padapter);
-#endif
 			break;
 		case Ndis802_11AutoUnknown:
 		case Ndis802_11InfrastructureMax:
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 848b1d4bf398..977f12bd9aae 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -89,7 +89,6 @@ static void rtw_mfree_mlme_priv_lock(struct mlme_priv *pmlmepriv)
 {
 }
 
-#if defined(CONFIG_88EU_AP_MODE)
 static void rtw_free_mlme_ie_data(u8 **ppie, u32 *plen)
 {
 	kfree(*ppie);
@@ -112,11 +111,6 @@ void rtw_free_mlme_priv_ie_data(struct mlme_priv *pmlmepriv)
 	rtw_free_mlme_ie_data(&pmlmepriv->p2p_go_probe_resp_ie, &pmlmepriv->p2p_go_probe_resp_ie_len);
 	rtw_free_mlme_ie_data(&pmlmepriv->p2p_assoc_req_ie, &pmlmepriv->p2p_assoc_req_ie_len);
 }
-#else
-void rtw_free_mlme_priv_ie_data(struct mlme_priv *pmlmepriv)
-{
-}
-#endif
 
 void _rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
 {
@@ -612,9 +606,7 @@ static void rtw_add_network(struct adapter *adapter,
 			    struct wlan_bssid_ex *pnetwork)
 {
 
-#if defined(CONFIG_88EU_P2P)
 	rtw_wlan_bssid_ex_remove_p2p_attr(pnetwork, P2P_ATTR_GROUP_INFO);
-#endif
 	update_current_network(adapter, pnetwork);
 	rtw_update_scanned_network(adapter, pnetwork);
 
@@ -1201,24 +1193,20 @@ void rtw_joinbss_event_callback(struct adapter *adapter, u8 *pbuf)
 static u8 search_max_mac_id(struct adapter *padapter)
 {
 	u8 mac_id;
-#if defined(CONFIG_88EU_AP_MODE)
 	u8 aid;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct sta_priv *pstapriv = &padapter->stapriv;
-#endif
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
-#if defined(CONFIG_88EU_AP_MODE)
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		for (aid = (pstapriv->max_num_sta); aid > 0; aid--) {
 			if (pstapriv->sta_aid[aid - 1])
 				break;
 		}
 		mac_id = aid + 1;
-	} else
-#endif
-	{/* adhoc  id =  31~2 */
+	} else {
+		/* adhoc  id =  31~2 */
 		for (mac_id = (NUM_STA - 1); mac_id >= IBSS_START_MAC_ID; mac_id--) {
 			if (pmlmeinfo->FW_sta_info[mac_id].status == 1)
 				break;
@@ -1256,14 +1244,12 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 	if (!rtw_access_ctrl(adapter, pstassoc->macaddr))
 		return;
 
-#if defined(CONFIG_88EU_AP_MODE)
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		psta = rtw_get_stainfo(&adapter->stapriv, pstassoc->macaddr);
 		if (psta)
 			rtw_indicate_sta_assoc_event(adapter, psta);
 		return;
 	}
-#endif
 	/* for AD-HOC mode */
 	psta = rtw_get_stainfo(&adapter->stapriv, pstassoc->macaddr);
 	if (psta)
@@ -1487,10 +1473,8 @@ void rtw_dynamic_check_timer_handlder(struct adapter *adapter)
 	rtw_dynamic_chk_wk_cmd(adapter);
 
 	if (pregistrypriv->wifi_spec == 1) {
-#ifdef CONFIG_88EU_P2P
 		struct wifidirect_info *pwdinfo = &adapter->wdinfo;
 		if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE))
-#endif
 		{
 			/* auto site survey */
 			rtw_auto_scan_handler(adapter);
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 45acbd17f5e8..abbf541618ed 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -363,9 +363,7 @@ int	init_mlme_ext_priv(struct adapter *padapter)
 
 	init_mlme_ext_timer(padapter);
 
-#ifdef CONFIG_88EU_AP_MODE
 	init_mlme_ap_info(padapter);
-#endif
 
 	pmlmeext->max_chan_nums = init_channel_set(padapter, pmlmepriv->ChannelPlan, pmlmeext->channel_set);
 	init_channel_list(padapter, pmlmeext->channel_set, pmlmeext->max_chan_nums, &pmlmeext->channel_list);
@@ -410,9 +408,7 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 {
 	int index;
 	struct mlme_handler *ptable;
-#ifdef CONFIG_88EU_AP_MODE
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-#endif /* CONFIG_88EU_AP_MODE */
 	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 	u8 *pframe = precv_frame->rx_data;
 	struct sta_info *psta = rtw_get_stainfo(&padapter->stapriv, GetAddr2Ptr(pframe));
@@ -444,7 +440,6 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 		psta->RxMgmtFrameSeqNum = precv_frame->attrib.seq_num;
 	}
 
-#ifdef CONFIG_88EU_AP_MODE
 	switch (GetFrameSubType(pframe)) {
 	case WIFI_AUTH:
 		if (check_fwstate(pmlmepriv, WIFI_AP_STATE))
@@ -465,12 +460,8 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 			rtw_hostapd_mlme_rx(padapter, precv_frame);
 		break;
 	}
-#else
-	_mgt_dispatcher(padapter, ptable, precv_frame);
-#endif
 }
 
-#ifdef CONFIG_88EU_P2P
 static u32 p2p_listen_state_process(struct adapter *padapter, unsigned char *da)
 {
 	bool response = true;
@@ -484,7 +475,6 @@ static u32 p2p_listen_state_process(struct adapter *padapter, unsigned char *da)
 
 	return _SUCCESS;
 }
-#endif /* CONFIG_88EU_P2P */
 
 /****************************************************************************
 
@@ -504,7 +494,6 @@ unsigned int OnProbeReq(struct adapter *padapter, struct recv_frame *precv_frame
 	uint len = precv_frame->len;
 	u8 is_valid_p2p_probereq = false;
 
-#ifdef CONFIG_88EU_P2P
 	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 	u8 wifi_test_chk_rate = 1;
 
@@ -539,7 +528,6 @@ unsigned int OnProbeReq(struct adapter *padapter, struct recv_frame *precv_frame
 	}
 
 _continue:
-#endif /* CONFIG_88EU_P2P */
 
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
 		return _SUCCESS;
@@ -573,12 +561,9 @@ unsigned int OnProbeReq(struct adapter *padapter, struct recv_frame *precv_frame
 unsigned int OnProbeRsp(struct adapter *padapter, struct recv_frame *precv_frame)
 {
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-#ifdef CONFIG_88EU_P2P
 	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 	u8 *pframe = precv_frame->rx_data;
-#endif
 
-#ifdef CONFIG_88EU_P2P
 	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_TX_PROVISION_DIS_REQ)) {
 		if (pwdinfo->tx_prov_disc_info.benable) {
 			if (!memcmp(pwdinfo->tx_prov_disc_info.peerIFAddr, GetAddr2Ptr(pframe), ETH_ALEN)) {
@@ -613,8 +598,6 @@ unsigned int OnProbeRsp(struct adapter *padapter, struct recv_frame *precv_frame
 			}
 		}
 	}
-#endif
-
 	if (pmlmeext->sitesurvey_res.state == SCAN_PROCESS) {
 		report_survey_event(padapter, precv_frame);
 		return _SUCCESS;
@@ -715,7 +698,6 @@ unsigned int OnBeacon(struct adapter *padapter, struct recv_frame *precv_frame)
 
 unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 {
-#ifdef CONFIG_88EU_AP_MODE
 	unsigned int	auth_mode, ie_len;
 	u16 seq;
 	unsigned char	*sa, *p;
@@ -859,9 +841,7 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 	/*  Now, we are going to issue_auth... */
 	pstat->auth_seq = seq + 1;
 
-#ifdef CONFIG_88EU_AP_MODE
 	issue_auth(padapter, pstat, (unsigned short)(_STATS_SUCCESSFUL_));
-#endif
 
 	if (pstat->state & WIFI_FW_AUTH_SUCCESS)
 		pstat->auth_seq = 0;
@@ -878,11 +858,7 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 	pstat->auth_seq = 2;
 	memcpy(pstat->hwaddr, sa, 6);
 
-#ifdef CONFIG_88EU_AP_MODE
 	issue_auth(padapter, pstat, (unsigned short)status);
-#endif
-
-#endif
 	return _FAIL;
 }
 
@@ -963,7 +939,6 @@ unsigned int OnAuthClient(struct adapter *padapter, struct recv_frame *precv_fra
 
 unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame)
 {
-#ifdef CONFIG_88EU_AP_MODE
 	u16 capab_info;
 	struct rtw_ieee802_11_elems elems;
 	struct sta_info	*pstat;
@@ -982,12 +957,10 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	u8 *pframe = precv_frame->rx_data;
 	uint pkt_len = precv_frame->len;
-#ifdef CONFIG_88EU_P2P
 	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 	u8 p2p_status_code = P2P_STATUS_SUCCESS;
 	u8 *p2pie;
 	u32 p2pielen = 0;
-#endif /* CONFIG_88EU_P2P */
 
 	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
 		return _FAIL;
@@ -1311,7 +1284,6 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 	if (status != _STATS_SUCCESSFUL_)
 		goto OnAssocReqFail;
 
-#ifdef CONFIG_88EU_P2P
 	pstat->is_p2p_device = false;
 	if (rtw_p2p_chk_role(pwdinfo, P2P_ROLE_GO)) {
 		p2pie = rtw_get_p2p_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, pkt_len - WLAN_HDR_A3_LEN - ie_offset, NULL, &p2pielen);
@@ -1326,7 +1298,6 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 		}
 	}
 	pstat->p2p_status_code = p2p_status_code;
-#endif /* CONFIG_88EU_P2P */
 
 	/* TODO: identify_proprietary_vendor_ie(); */
 	/*  Realtek proprietary IE */
@@ -1377,7 +1348,6 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 
 	/*  now the station is qualified to join our BSS... */
 	if (pstat && (pstat->state & WIFI_FW_ASSOC_SUCCESS) && (_STATS_SUCCESSFUL_ == status)) {
-#ifdef CONFIG_88EU_AP_MODE
 		/* 1 bss_cap_update & sta_info_update */
 		bss_cap_update_on_sta_join(padapter, pstat);
 		sta_info_update(padapter, pstat);
@@ -1394,30 +1364,23 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 
 		/* 3-(1) report sta add event */
 		report_add_sta_event(padapter, pstat->hwaddr, pstat->aid);
-#endif
 	}
 
 	return _SUCCESS;
 
 asoc_class2_error:
 
-#ifdef CONFIG_88EU_AP_MODE
 	issue_deauth(padapter, (void *)GetAddr2Ptr(pframe), status);
-#endif
 
 	return _FAIL;
 
 OnAssocReqFail:
 
-#ifdef CONFIG_88EU_AP_MODE
 	pstat->aid = 0;
 	if (frame_type == WIFI_ASSOCREQ)
 		issue_asocrsp(padapter, status, pstat, WIFI_ASSOCRSP);
 	else
 		issue_asocrsp(padapter, status, pstat, WIFI_REASSOCRSP);
-#endif
-
-#endif /* CONFIG_88EU_AP_MODE */
 
 	return _FAIL;
 }
@@ -1519,26 +1482,21 @@ unsigned int OnDeAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 *pframe = precv_frame->rx_data;
-#ifdef CONFIG_88EU_P2P
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
-#endif /* CONFIG_88EU_P2P */
 
 	/* check A3 */
 	if (!(!memcmp(GetAddr3Ptr(pframe), get_my_bssid(&pmlmeinfo->network), ETH_ALEN)))
 		return _SUCCESS;
 
-#ifdef CONFIG_88EU_P2P
 	if (pwdinfo->rx_invitereq_info.scan_op_ch_only) {
 		_cancel_timer_ex(&pwdinfo->reset_ch_sitesurvey);
 		_set_timer(&pwdinfo->reset_ch_sitesurvey, 10);
 	}
-#endif /* CONFIG_88EU_P2P */
 
 	reason = le16_to_cpu(*(__le16 *)(pframe + WLAN_HDR_A3_LEN));
 
 	DBG_88E("%s Reason code(%d)\n", __func__, reason);
 
-#ifdef CONFIG_88EU_AP_MODE
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		struct sta_info *psta;
 		struct sta_priv *pstapriv = &padapter->stapriv;
@@ -1562,9 +1520,7 @@ unsigned int OnDeAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 		}
 
 		return _SUCCESS;
-	} else
-#endif
-	{
+	} else {
 		int	ignore_received_deauth = 0;
 
 		/* Before sending the auth frame to start the STA/GC mode connection with AP/GO,
@@ -1599,26 +1555,21 @@ unsigned int OnDisassoc(struct adapter *padapter, struct recv_frame *precv_frame
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	u8 *pframe = precv_frame->rx_data;
-#ifdef CONFIG_88EU_P2P
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
-#endif /* CONFIG_88EU_P2P */
 
 	/* check A3 */
 	if (!(!memcmp(GetAddr3Ptr(pframe), get_my_bssid(&pmlmeinfo->network), ETH_ALEN)))
 		return _SUCCESS;
 
-#ifdef CONFIG_88EU_P2P
 	if (pwdinfo->rx_invitereq_info.scan_op_ch_only) {
 		_cancel_timer_ex(&pwdinfo->reset_ch_sitesurvey);
 		_set_timer(&pwdinfo->reset_ch_sitesurvey, 10);
 	}
-#endif /* CONFIG_88EU_P2P */
 
 	reason = le16_to_cpu(*(__le16 *)(pframe + WLAN_HDR_A3_LEN));
 
 	DBG_88E("%s Reason code(%d)\n", __func__, reason);
 
-#ifdef CONFIG_88EU_AP_MODE
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		struct sta_info *psta;
 		struct sta_priv *pstapriv = &padapter->stapriv;
@@ -1642,9 +1593,7 @@ unsigned int OnDisassoc(struct adapter *padapter, struct recv_frame *precv_frame
 		}
 
 		return _SUCCESS;
-	} else
-#endif
-	{
+	} else {
 		DBG_88E_LEVEL(_drv_always_, "ap recv disassoc reason code(%d) sta:%pM\n",
 			      reason, GetAddr3Ptr(pframe));
 
@@ -1786,8 +1735,6 @@ unsigned int OnAction_back(struct adapter *padapter, struct recv_frame *precv_fr
 	return _SUCCESS;
 }
 
-#ifdef CONFIG_88EU_P2P
-
 static int get_reg_classes_full_count(struct p2p_channels *channel_list)
 {
 	int cnt = 0;
@@ -3780,8 +3727,6 @@ int issue_probereq_p2p_ex(struct adapter *adapter, u8 *da, int try_cnt, int wait
 	return ret;
 }
 
-#endif /* CONFIG_88EU_P2P */
-
 static s32 rtw_action_public_decache(struct recv_frame *recv_frame, s32 token)
 {
 	struct adapter *adapter = recv_frame->adapter;
@@ -3819,7 +3764,6 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 	u8 *pframe = precv_frame->rx_data;
 	u8 *frame_body;
 	u8 dialogToken = 0;
-#ifdef CONFIG_88EU_P2P
 	struct adapter *padapter = precv_frame->adapter;
 	uint len = precv_frame->len;
 	u8 *p2p_ie;
@@ -3827,7 +3771,6 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 	struct	wifidirect_info	*pwdinfo = &padapter->wdinfo;
 	u8	result = P2P_STATUS_SUCCESS;
 	u8	empty_addr[ETH_ALEN] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
-#endif /* CONFIG_88EU_P2P */
 
 	frame_body = (unsigned char *)(pframe + sizeof(struct rtw_ieee80211_hdr_3addr));
 
@@ -3836,7 +3779,6 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 	if (rtw_action_public_decache(precv_frame, dialogToken) == _FAIL)
 		return _FAIL;
 
-#ifdef CONFIG_88EU_P2P
 	_cancel_timer_ex(&pwdinfo->reset_ch_sitesurvey);
 	/*	Do nothing if the driver doesn't enable the P2P function. */
 	if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE) || rtw_p2p_chk_state(pwdinfo, P2P_STATE_IDLE))
@@ -4099,7 +4041,6 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 		_set_timer(&pwdinfo->restore_p2p_state_timer, P2P_PROVISION_TIMEOUT);
 		break;
 	}
-#endif /* CONFIG_88EU_P2P */
 
 	return _SUCCESS;
 }
@@ -4176,7 +4117,6 @@ unsigned int OnAction_wmm(struct adapter *padapter, struct recv_frame *precv_fra
 
 unsigned int OnAction_p2p(struct adapter *padapter, struct recv_frame *precv_frame)
 {
-#ifdef CONFIG_88EU_P2P
 	u8 *frame_body;
 	u8 category, OUI_Subtype;
 	u8 *pframe = precv_frame->rx_data;
@@ -4214,7 +4154,6 @@ unsigned int OnAction_p2p(struct adapter *padapter, struct recv_frame *precv_fra
 	default:
 		break;
 	}
-#endif /* CONFIG_88EU_P2P */
 	return _SUCCESS;
 }
 
@@ -4412,18 +4351,14 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	struct wlan_bssid_ex		*cur_network = &pmlmeinfo->network;
 	u8	bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
-#ifdef CONFIG_88EU_P2P
 	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
-#endif /* CONFIG_88EU_P2P */
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe) {
 		DBG_88E("%s, alloc mgnt frame fail\n", __func__);
 		return;
 	}
-#if defined(CONFIG_88EU_AP_MODE)
 	spin_lock_bh(&pmlmepriv->bcn_update_lock);
-#endif /* if defined (CONFIG_88EU_AP_MODE) */
 
 	/* update attribute */
 	pattrib = &pmgntframe->attrib;
@@ -4450,7 +4385,6 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
 
 	if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE) {
-#ifdef CONFIG_88EU_P2P
 		/*  for P2P : Primary Device Type & Device Name */
 		u32 wpsielen = 0, insert_len = 0;
 		u8 *wpsie = NULL;
@@ -4515,9 +4449,7 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 			memcpy(pframe, premainder_ie, remainder_ielen);
 			pframe += remainder_ielen;
 			pattrib->pktlen += remainder_ielen;
-		} else
-#endif /* CONFIG_88EU_P2P */
-		{
+		} else {
 			int len_diff;
 			memcpy(pframe, cur_network->IEs, cur_network->IELength);
 			len_diff = update_hidden_ssid(
@@ -4543,7 +4475,6 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 				_clr_fwstate_(pmlmepriv, WIFI_UNDER_WPS);
 		}
 
-#ifdef CONFIG_88EU_P2P
 		if (rtw_p2p_chk_role(pwdinfo, P2P_ROLE_GO)) {
 			u32 len;
 			len = build_beacon_p2p_ie(pwdinfo, pframe);
@@ -4551,7 +4482,6 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 			pframe += len;
 			pattrib->pktlen += len;
 		}
-#endif /* CONFIG_88EU_P2P */
 
 		goto _issue_bcn;
 	}
@@ -4603,11 +4533,9 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 	/* todo:HT for adhoc */
 _issue_bcn:
 
-#if defined(CONFIG_88EU_AP_MODE)
 	pmlmepriv->update_bcn = false;
 
 	spin_unlock_bh(&pmlmepriv->bcn_update_lock);
-#endif /* if defined (CONFIG_88EU_AP_MODE) */
 
 	if ((pattrib->pktlen + TXDESC_SIZE) > 512) {
 		DBG_88E("beacon frame too large\n");
@@ -4632,18 +4560,14 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 	__le16 *fctrl;
 	unsigned char					*mac, *bssid;
 	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
-#if defined(CONFIG_88EU_AP_MODE)
 	u8 *pwps_ie;
 	uint wps_ielen;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-#endif /* if defined (CONFIG_88EU_AP_MODE) */
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	struct wlan_bssid_ex		*cur_network = &pmlmeinfo->network;
 	unsigned int	rate_len;
-#ifdef CONFIG_88EU_P2P
 	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
-#endif /* CONFIG_88EU_P2P */
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe) {
@@ -4680,7 +4604,6 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 	if (cur_network->IELength > MAX_IE_SZ)
 		return;
 
-#if defined(CONFIG_88EU_AP_MODE)
 	if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE) {
 		pwps_ie = rtw_get_wps_ie(cur_network->IEs + _FIXED_IE_LENGTH_, cur_network->IELength - _FIXED_IE_LENGTH_, NULL, &wps_ielen);
 
@@ -4716,9 +4639,7 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 			pframe += cur_network->IELength;
 			pattrib->pktlen += cur_network->IELength;
 		}
-	} else
-#endif
-	{
+	} else {
 		/* timestamp will be inserted by hardware */
 		pframe += 8;
 		pattrib->pktlen += 8;
@@ -4767,7 +4688,6 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 		/* todo:HT for adhoc */
 	}
 
-#ifdef CONFIG_88EU_P2P
 	if (rtw_p2p_chk_role(pwdinfo, P2P_ROLE_GO) && is_valid_p2p_probereq) {
 		u32 len;
 		len = build_probe_resp_p2p_ie(pwdinfo, pframe);
@@ -4775,7 +4695,6 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 		pframe += len;
 		pattrib->pktlen += len;
 	}
-#endif /* CONFIG_88EU_P2P */
 
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
@@ -4923,9 +4842,7 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short
 	__le16 *fctrl;
 	unsigned int val32;
 	u16 val16;
-#ifdef CONFIG_88EU_AP_MODE
 	__le16 le_val16;
-#endif
 	int use_shared_key = 0;
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
@@ -4955,8 +4872,6 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short
 	pattrib->pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
 
 	if (psta) {/*  for AP mode */
-#ifdef CONFIG_88EU_AP_MODE
-
 		memcpy(pwlanhdr->addr1, psta->hwaddr, ETH_ALEN);
 		memcpy(pwlanhdr->addr2, myid(&padapter->eeprompriv), ETH_ALEN);
 		memcpy(pwlanhdr->addr3, myid(&padapter->eeprompriv), ETH_ALEN);
@@ -4989,7 +4904,6 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short
 		/*  added challenging text... */
 		if ((psta->auth_seq == 2) && (psta->state & WIFI_FW_AUTH_STATE) && (use_shared_key == 1))
 			pframe = rtw_set_ie(pframe, _CHLGETXT_IE_, 128, psta->chg_txt, &pattrib->pktlen);
-#endif
 	} else {
 		__le32 le_tmp32;
 		__le16 le_tmp16;
@@ -5048,7 +4962,6 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short
 
 void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_info *pstat, int pkt_type)
 {
-#ifdef CONFIG_88EU_AP_MODE
 	struct xmit_frame	*pmgntframe;
 	struct rtw_ieee80211_hdr	*pwlanhdr;
 	struct pkt_attrib *pattrib;
@@ -5062,9 +4975,7 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 	struct wlan_bssid_ex *pnetwork = &pmlmeinfo->network;
 	u8 *ie = pnetwork->IEs;
 	__le16 lestatus, leval;
-#ifdef CONFIG_88EU_P2P
 	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
-#endif /* CONFIG_88EU_P2P */
 
 	DBG_88E("%s\n", __func__);
 
@@ -5167,7 +5078,6 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 		pattrib->pktlen += pmlmepriv->wps_assoc_resp_ie_len;
 	}
 
-#ifdef CONFIG_88EU_P2P
 	if (rtw_p2p_chk_role(pwdinfo, P2P_ROLE_GO) && (pstat->is_p2p_device)) {
 		u32 len;
 
@@ -5176,10 +5086,8 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 		pframe += len;
 		pattrib->pktlen += len;
 	}
-#endif /* CONFIG_88EU_P2P */
 	pattrib->last_txcmdsz = pattrib->pktlen;
 	dump_mgntframe(padapter, pmgntframe);
-#endif
 }
 
 void issue_assocreq(struct adapter *padapter)
@@ -5200,11 +5108,9 @@ void issue_assocreq(struct adapter *padapter)
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	int	bssrate_len = 0, sta_bssrate_len = 0;
-#ifdef CONFIG_88EU_P2P
 	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
 	u8 p2pie[255] = { 0x00 };
 	u16 p2pielen = 0;
-#endif /* CONFIG_88EU_P2P */
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
@@ -5370,8 +5276,6 @@ void issue_assocreq(struct adapter *padapter)
 	if (pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_REALTEK)
 		pframe = rtw_set_ie(pframe, _VENDOR_SPECIFIC_IE_, 6, REALTEK_96B_IE, &pattrib->pktlen);
 
-#ifdef CONFIG_88EU_P2P
-
 	if (!rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE) && !rtw_p2p_chk_state(pwdinfo, P2P_STATE_IDLE)) {
 		/*	Should add the P2P IE in the association request frame. */
 		/*	P2P OUI */
@@ -5499,8 +5403,6 @@ void issue_assocreq(struct adapter *padapter)
 		pframe = rtw_set_ie(pframe, _VENDOR_SPECIFIC_IE_, p2pielen, (unsigned char *)p2pie, &pattrib->pktlen);
 	}
 
-#endif /* CONFIG_88EU_P2P */
-
 	pattrib->last_txcmdsz = pattrib->pktlen;
 	dump_mgntframe(padapter, pmgntframe);
 
@@ -5759,16 +5661,12 @@ static int _issue_deauth(struct adapter *padapter, unsigned char *da, unsigned s
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	int ret = _FAIL;
 	__le16 le_tmp;
-#ifdef CONFIG_88EU_P2P
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
-#endif /* CONFIG_88EU_P2P */
 
-#ifdef CONFIG_88EU_P2P
 	if (!(rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE)) && (pwdinfo->rx_invitereq_info.scan_op_ch_only)) {
 		_cancel_timer_ex(&pwdinfo->reset_ch_sitesurvey);
 		_set_timer(&pwdinfo->reset_ch_sitesurvey, 10);
 	}
-#endif /* CONFIG_88EU_P2P */
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
@@ -6267,8 +6165,6 @@ void site_survey(struct adapter *padapter)
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	u32 initialgain = 0;
-
-#ifdef CONFIG_88EU_P2P
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
 	if ((pwdinfo->rx_invitereq_info.scan_op_ch_only) || (pwdinfo->p2p_info.scan_op_ch_only)) {
@@ -6288,9 +6184,7 @@ void site_survey(struct adapter *padapter)
 			ScanType = pmlmeext->channel_set[ch_set_idx].ScanType;
 		else
 			ScanType = SCAN_ACTIVE;
-	} else
-#endif /* CONFIG_88EU_P2P */
-	{
+	} else {
 		struct rtw_ieee80211_channel *ch;
 		if (pmlmeext->sitesurvey_res.channel_idx < pmlmeext->sitesurvey_res.ch_num) {
 			ch = &pmlmeext->sitesurvey_res.ch[pmlmeext->sitesurvey_res.channel_idx];
@@ -6310,15 +6204,12 @@ void site_survey(struct adapter *padapter)
 			SelectChannel(padapter, survey_channel);
 
 		if (ScanType == SCAN_ACTIVE) { /* obey the channel plan setting... */
-			#ifdef CONFIG_88EU_P2P
 			if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_SCAN) ||
 			    rtw_p2p_chk_state(pwdinfo, P2P_STATE_FIND_PHASE_SEARCH)) {
 				issue_probereq_p2p(padapter, NULL);
 				issue_probereq_p2p(padapter, NULL);
 				issue_probereq_p2p(padapter, NULL);
-			} else
-			#endif /* CONFIG_88EU_P2P */
-			{
+			} else {
 				int i;
 				for (i = 0; i < RTW_SSID_SCAN_AMOUNT; i++) {
 					if (pmlmeext->sitesurvey_res.ssid[i].SsidLength) {
@@ -6341,8 +6232,6 @@ void site_survey(struct adapter *padapter)
 		set_survey_timer(pmlmeext, pmlmeext->chan_scan_time);
 	} else {
 		/*	channel number is 0 or this channel is not valid. */
-
-#ifdef CONFIG_88EU_P2P
 		if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_SCAN) || rtw_p2p_chk_state(pwdinfo, P2P_STATE_FIND_PHASE_SEARCH)) {
 			if ((pwdinfo->rx_invitereq_info.scan_op_ch_only) || (pwdinfo->p2p_info.scan_op_ch_only)) {
 				/*	Set the find_phase_state_exchange_cnt to P2P_FINDPHASE_EX_CNT. */
@@ -6364,9 +6253,7 @@ void site_survey(struct adapter *padapter)
 			/* Switch_DM_Func(padapter, DYNAMIC_FUNC_DIG|DYNAMIC_FUNC_HP|DYNAMIC_FUNC_SS, true); */
 
 			_set_timer(&pwdinfo->find_phase_timer, (u32)((u32)(pwdinfo->listen_dwell) * 100));
-		} else
-#endif /* CONFIG_88EU_P2P */
-		{
+		} else {
 			/*  20100721:Interrupt scan operation here. */
 			/*  For SW antenna diversity before link, it needs to switch to another antenna and scan again. */
 			/*  It compares the scan result and select beter one to do connection. */
@@ -6377,22 +6264,18 @@ void site_survey(struct adapter *padapter)
 				set_survey_timer(pmlmeext, pmlmeext->chan_scan_time);
 				return;
 			}
-#ifdef CONFIG_88EU_P2P
 			if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_SCAN) || rtw_p2p_chk_state(pwdinfo, P2P_STATE_FIND_PHASE_SEARCH))
 				rtw_p2p_set_state(pwdinfo, rtw_p2p_pre_state(pwdinfo));
 			rtw_p2p_findphase_ex_set(pwdinfo, P2P_FINDPHASE_EX_NONE);
-#endif /* CONFIG_88EU_P2P */
 
 			pmlmeext->sitesurvey_res.state = SCAN_COMPLETE;
 
 			/* switch back to the original channel */
 
-#ifdef CONFIG_88EU_P2P
 			if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_LISTEN))
 				set_channel_bwmode(padapter, pwdinfo->listen_channel, HAL_PRIME_CHNL_OFFSET_DONT_CARE, HT_CHANNEL_WIDTH_20);
 			else
 				set_channel_bwmode(padapter, pmlmeext->cur_channel, pmlmeext->cur_ch_offset, pmlmeext->cur_bwmode);
-#endif /* CONFIG_88EU_P2P */
 
 			/* flush 4-AC Queue after site_survey */
 			/* val8 = 0; */
@@ -7413,9 +7296,7 @@ void linked_status_chk(struct adapter *padapter)
 		psta = rtw_get_stainfo(pstapriv, pmlmeinfo->network.MacAddress);
 		if (psta) {
 			bool is_p2p_enable = false;
-			#ifdef CONFIG_88EU_P2P
 			is_p2p_enable = !rtw_p2p_chk_state(&padapter->wdinfo, P2P_STATE_NONE);
-			#endif
 
 			if (!chk_ap_is_alive(padapter, psta))
 				rx_chk = _FAIL;
@@ -7513,9 +7394,7 @@ void survey_timer_hdl(struct adapter *padapter)
 	struct sitesurvey_parm	*psurveyPara;
 	struct cmd_priv					*pcmdpriv = &padapter->cmdpriv;
 	struct mlme_ext_priv		*pmlmeext = &padapter->mlmeextpriv;
-#ifdef CONFIG_88EU_P2P
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
-#endif
 
 	/* issue rtw_sitesurvey_cmd */
 	if (pmlmeext->sitesurvey_res.state > SCAN_START) {
@@ -7523,7 +7402,6 @@ void survey_timer_hdl(struct adapter *padapter)
 			pmlmeext->sitesurvey_res.channel_idx++;
 
 		if (pmlmeext->scan_abort) {
-			#ifdef CONFIG_88EU_P2P
 			if (!rtw_p2p_chk_state(&padapter->wdinfo, P2P_STATE_NONE)) {
 				rtw_p2p_findphase_ex_set(pwdinfo, P2P_FINDPHASE_EX_MAX);
 				pmlmeext->sitesurvey_res.channel_idx = 3;
@@ -7531,9 +7409,7 @@ void survey_timer_hdl(struct adapter *padapter)
 					, pmlmeext->sitesurvey_res.channel_idx
 					, pwdinfo->find_phase_state_exchange_cnt
 			);
-			} else
-			#endif
-			{
+			} else {
 				pmlmeext->sitesurvey_res.channel_idx = pmlmeext->sitesurvey_res.ch_num;
 				DBG_88E("%s idx:%d\n", __func__
 					, pmlmeext->sitesurvey_res.channel_idx
@@ -7651,13 +7527,10 @@ u8 createbss_hdl(struct adapter *padapter, u8 *pbuf)
 	/* u32	initialgain; */
 
 	if (pparm->network.InfrastructureMode == Ndis802_11APMode) {
-#ifdef CONFIG_88EU_AP_MODE
-
 		if (pmlmeinfo->state == WIFI_FW_AP_STATE) {
 			/* todo: */
 			return H2C_SUCCESS;
 		}
-#endif
 	}
 
 	/* below is for ad-hoc master */
@@ -7908,10 +7781,7 @@ u8 sitesurvey_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 	u8 val8;
 	u32	initialgain;
 	u32	i;
-
-#ifdef CONFIG_88EU_P2P
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
-#endif
 
 	if (pmlmeext->sitesurvey_res.state == SCAN_DISABLE) {
 		/* for first time sitesurvey_cmd */
@@ -7958,14 +7828,10 @@ u8 sitesurvey_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 		Switch_DM_Func(padapter, DYNAMIC_FUNC_DISABLE, false);
 
 		/* config the initial gain under scanning, need to write the BB registers */
-#ifdef CONFIG_88EU_P2P
 		if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE))
 			initialgain = 0x1E;
 		else
 			initialgain = 0x28;
-#else	/*  CONFIG_88EU_P2P */
-		initialgain = 0x1E;
-#endif /*  CONFIG_88EU_P2P */
 
 		rtw_hal_set_hwreg(padapter, HW_VAR_INITIAL_GAIN, (u8 *)(&initialgain));
 
@@ -8197,9 +8063,8 @@ u8 tx_beacon_hdl(struct adapter *padapter, unsigned char *pbuf)
 	if (send_beacon(padapter) == _FAIL) {
 		DBG_88E("issue_beacon, fail!\n");
 		return H2C_PARAMETERS_ERROR;
-	}
-#ifdef CONFIG_88EU_AP_MODE
-	else { /* tx bc/mc frames after update TIM */
+	} else {
+		/* tx bc/mc frames after update TIM */
 		struct sta_info *psta_bmc;
 		struct list_head *xmitframe_plist, *xmitframe_phead;
 		struct xmit_frame *pxmitframe = NULL;
@@ -8242,7 +8107,6 @@ u8 tx_beacon_hdl(struct adapter *padapter, unsigned char *pbuf)
 			spin_unlock_bh(&psta_bmc->sleep_q.lock);
 		}
 	}
-#endif
 	return H2C_SUCCESS;
 }
 
diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index 3d237f276847..f942f8f9e3f6 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -7,8 +7,6 @@
 #include "../include/rtw_p2p.h"
 #include "../include/wifi.h"
 
-#ifdef CONFIG_88EU_P2P
-
 static int rtw_p2p_is_channel_list_ok(u8 desired_ch, u8 *ch_list, u8 ch_cnt)
 {
 	int found = 0, i = 0;
@@ -1832,7 +1830,6 @@ void rtw_init_wifidirect_timers(struct adapter *padapter)
 
 void rtw_init_wifidirect_addrs(struct adapter *padapter, u8 *dev_addr, u8 *iface_addr)
 {
-#ifdef CONFIG_88EU_P2P
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
 	/*init device&interface address */
@@ -1840,7 +1837,6 @@ void rtw_init_wifidirect_addrs(struct adapter *padapter, u8 *dev_addr, u8 *iface
 		memcpy(pwdinfo->device_addr, dev_addr, ETH_ALEN);
 	if (iface_addr)
 		memcpy(pwdinfo->interface_addr, iface_addr, ETH_ALEN);
-#endif
 }
 
 void init_wifidirect_info(struct adapter *padapter, enum P2P_ROLE role)
@@ -1983,15 +1979,3 @@ int rtw_p2p_enable(struct adapter *padapter, enum P2P_ROLE role)
 exit:
 	return ret;
 }
-
-#else
-u8 p2p_ps_wk_cmd(struct adapter *padapter, u8 p2p_ps_state, u8 enqueue)
-{
-	return _FAIL;
-}
-
-void process_p2p_ps_ie(struct adapter *padapter, u8 *IEs, u32 IELength)
-{
-}
-
-#endif /* CONFIG_88EU_P2P */
diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index 00750394c50b..353b7bd850d9 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -99,10 +99,7 @@ static bool rtw_pwr_unassociated_idle(struct adapter *adapter)
 {
 	struct adapter *buddy = adapter->pbuddy_adapter;
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
-#ifdef CONFIG_88EU_P2P
 	struct wifidirect_info	*pwdinfo = &adapter->wdinfo;
-#endif
-
 	bool ret = false;
 
 	if (adapter->pwrctrlpriv.ips_deny_time >= jiffies)
@@ -113,29 +110,19 @@ static bool rtw_pwr_unassociated_idle(struct adapter *adapter)
 	    check_fwstate(pmlmepriv, WIFI_UNDER_WPS) ||
 	    check_fwstate(pmlmepriv, WIFI_AP_STATE) ||
 	    check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE | WIFI_ADHOC_STATE) ||
-#if defined(CONFIG_88EU_P2P)
 	    !rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE))
-#else
-	    0)
-#endif
 		goto exit;
 
 	/* consider buddy, if exist */
 	if (buddy) {
 		struct mlme_priv *b_pmlmepriv = &buddy->mlmepriv;
-		#ifdef CONFIG_88EU_P2P
 		struct wifidirect_info *b_pwdinfo = &buddy->wdinfo;
-		#endif
 
 		if (check_fwstate(b_pmlmepriv, WIFI_ASOC_STATE | WIFI_SITE_MONITOR) ||
 		    check_fwstate(b_pmlmepriv, WIFI_UNDER_LINKING | WIFI_UNDER_WPS) ||
 		    check_fwstate(b_pmlmepriv, WIFI_AP_STATE) ||
 		    check_fwstate(b_pmlmepriv, WIFI_ADHOC_MASTER_STATE | WIFI_ADHOC_STATE) ||
-#if defined(CONFIG_88EU_P2P)
 		    !rtw_p2p_chk_state(b_pwdinfo, P2P_STATE_NONE))
-#else
-		    0)
-#endif
 			goto exit;
 	}
 	ret = true;
@@ -274,9 +261,7 @@ static u8 PS_RDY_CHECK(struct adapter *padapter)
 void rtw_set_ps_mode(struct adapter *padapter, u8 ps_mode, u8 smart_ps, u8 bcn_ant_mode)
 {
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
-#ifdef CONFIG_88EU_P2P
 	struct wifidirect_info	*pwdinfo = &padapter->wdinfo;
-#endif /* CONFIG_88EU_P2P */
 
 	if (ps_mode > PM_Card_Disable)
 		return;
@@ -292,7 +277,6 @@ void rtw_set_ps_mode(struct adapter *padapter, u8 ps_mode, u8 smart_ps, u8 bcn_a
 
 	/* if (pwrpriv->pwr_mode == PS_MODE_ACTIVE) */
 	if (ps_mode == PS_MODE_ACTIVE) {
-#ifdef CONFIG_88EU_P2P
 		if (pwdinfo->opp_ps == 0) {
 			DBG_88E("rtw_set_ps_mode: Leave 802.11 power save\n");
 			pwrpriv->pwr_mode = ps_mode;
@@ -301,7 +285,6 @@ void rtw_set_ps_mode(struct adapter *padapter, u8 ps_mode, u8 smart_ps, u8 bcn_a
 			pwrpriv->bFwCurrentInPSMode = false;
 		}
 	} else {
-#endif /* CONFIG_88EU_P2P */
 		if (PS_RDY_CHECK(padapter)) {
 			DBG_88E("%s: Enter 802.11 power save\n", __func__);
 			pwrpriv->bFwCurrentInPSMode = true;
@@ -310,11 +293,9 @@ void rtw_set_ps_mode(struct adapter *padapter, u8 ps_mode, u8 smart_ps, u8 bcn_a
 			pwrpriv->bcn_ant_mode = bcn_ant_mode;
 			rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_PWRMODE, (u8 *)(&ps_mode));
 
-#ifdef CONFIG_88EU_P2P
 			/*  Set CTWindow after LPS */
 			if (pwdinfo->opp_ps == 1)
 				p2p_ps_wk_cmd(padapter, P2P_PS_ENABLE, 0);
-#endif /* CONFIG_88EU_P2P */
 
 			rtw_set_rpwm(padapter, PS_STATE_S2);
 		}
diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index ba69cf9facfe..a0375207a8e4 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -523,7 +523,6 @@ static int recv_decache(struct recv_frame *precv_frame, u8 bretry, struct stainf
 void process_pwrbit_data(struct adapter *padapter, struct recv_frame *precv_frame);
 void process_pwrbit_data(struct adapter *padapter, struct recv_frame *precv_frame)
 {
-#ifdef CONFIG_88EU_AP_MODE
 	unsigned char pwrbit;
 	u8 *ptr = precv_frame->rx_data;
 	struct rx_pkt_attrib *pattrib = &precv_frame->attrib;
@@ -543,13 +542,10 @@ void process_pwrbit_data(struct adapter *padapter, struct recv_frame *precv_fram
 				wakeup_sta_to_xmit(padapter, psta);
 		}
 	}
-
-#endif
 }
 
 static void process_wmmps_data(struct adapter *padapter, struct recv_frame *precv_frame)
 {
-#ifdef CONFIG_88EU_AP_MODE
 	struct rx_pkt_attrib *pattrib = &precv_frame->attrib;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct sta_info *psta = NULL;
@@ -598,8 +594,6 @@ static void process_wmmps_data(struct adapter *padapter, struct recv_frame *prec
 			}
 		}
 	}
-
-#endif
 }
 
 static void count_rx_stats(struct adapter *padapter, struct recv_frame *prframe, struct sta_info *sta)
@@ -883,7 +877,6 @@ static int sta2ap_data_frame(struct adapter *adapter,
 static int validate_recv_ctrl_frame(struct adapter *padapter,
 				    struct recv_frame *precv_frame)
 {
-#ifdef CONFIG_88EU_AP_MODE
 	struct rx_pkt_attrib *pattrib = &precv_frame->attrib;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	u8 *pframe = precv_frame->rx_data;
@@ -996,8 +989,6 @@ static int validate_recv_ctrl_frame(struct adapter *padapter,
 		}
 	}
 
-#endif
-
 	return _FAIL;
 }
 
diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index fc6484e403d0..37bd05fd1832 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -24,8 +24,6 @@ static void _rtw_init_stainfo(struct sta_info *psta)
 	_rtw_init_sta_xmit_priv(&psta->sta_xmitpriv);
 	_rtw_init_sta_recv_priv(&psta->sta_recvpriv);
 
-#ifdef CONFIG_88EU_AP_MODE
-
 	INIT_LIST_HEAD(&psta->asoc_list);
 
 	INIT_LIST_HEAD(&psta->auth_list);
@@ -38,21 +36,16 @@ static void _rtw_init_stainfo(struct sta_info *psta)
 
 	psta->bpairwise_key_installed = false;
 
-#ifdef CONFIG_88EU_AP_MODE
 	psta->nonerp_set = 0;
 	psta->no_short_slot_time_set = 0;
 	psta->no_short_preamble_set = 0;
 	psta->no_ht_gf_set = 0;
 	psta->no_ht_set = 0;
 	psta->ht_20mhz_set = 0;
-#endif
 
 	psta->under_exist_checking = 0;
 
 	psta->keep_alive_trycnt = 0;
-
-#endif	/*  CONFIG_88EU_AP_MODE */
-
 }
 
 u32	_rtw_init_sta_priv(struct	sta_priv *pstapriv)
@@ -88,8 +81,6 @@ u32	_rtw_init_sta_priv(struct	sta_priv *pstapriv)
 		psta++;
 	}
 
-#ifdef CONFIG_88EU_AP_MODE
-
 	pstapriv->sta_dz_bitmap = 0;
 	pstapriv->tim_bitmap = 0;
 
@@ -104,7 +95,6 @@ u32	_rtw_init_sta_priv(struct	sta_priv *pstapriv)
 	pstapriv->assoc_to = 3;
 	pstapriv->expire_to = 3; /*  3*2 = 6 sec */
 	pstapriv->max_num_sta = NUM_STA;
-#endif
 
 	return _SUCCESS;
 }
@@ -322,8 +312,6 @@ u32	rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 	if (!(psta->state & WIFI_AP_STATE))
 		rtl8188e_SetHalODMVar(padapter, HAL_ODM_STA_INFO, psta, false);
 
-#ifdef CONFIG_88EU_AP_MODE
-
 	spin_lock_bh(&pstapriv->auth_list_lock);
 	if (!list_empty(&psta->auth_list)) {
 		list_del_init(&psta->auth_list);
@@ -353,8 +341,6 @@ u32	rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 
 	psta->under_exist_checking = 0;
 
-#endif	/*  CONFIG_88EU_AP_MODE */
-
 	spin_lock_bh(&pfree_sta_queue->lock);
 	list_add_tail(&psta->list, get_list_head(pfree_sta_queue));
 	spin_unlock_bh(&pfree_sta_queue->lock);
@@ -470,7 +456,6 @@ struct sta_info *rtw_get_bcmc_stainfo(struct adapter *padapter)
 u8 rtw_access_ctrl(struct adapter *padapter, u8 *mac_addr)
 {
 	u8 res = true;
-#ifdef CONFIG_88EU_AP_MODE
 	struct list_head *plist, *phead;
 	struct rtw_wlan_acl_node *paclnode;
 	u8 match = false;
@@ -501,7 +486,5 @@ u8 rtw_access_ctrl(struct adapter *padapter, u8 *mac_addr)
 	else
 		res = true;
 
-#endif
-
 	return res;
 }
diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index c2f664bdb979..26106dd06d56 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -1233,7 +1233,6 @@ void set_sta_rate(struct adapter *padapter, struct sta_info *psta)
 void update_tx_basic_rate(struct adapter *padapter, u8 wirelessmode)
 {
 	unsigned char supported_rates[NDIS_802_11_LENGTH_RATES_EX];
-#ifdef CONFIG_88EU_P2P
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
 	/* 	Added by Albert 2011/03/22 */
@@ -1241,7 +1240,6 @@ void update_tx_basic_rate(struct adapter *padapter, u8 wirelessmode)
 	/* 	So, the Tx packet shouldn't use the CCK rate */
 	if (!rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE))
 		return;
-#endif /* CONFIG_88EU_P2P */
 	memset(supported_rates, 0, NDIS_802_11_LENGTH_RATES_EX);
 
 	if ((wirelessmode & WIRELESS_11B) && (wirelessmode == WIRELESS_11B))
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 875d1bf1679c..1bfb91f445df 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -1773,14 +1773,12 @@ s32 rtw_xmit(struct adapter *padapter, struct sk_buff **ppkt)
 
 	do_queue_select(padapter, &pxmitframe->attrib);
 
-#ifdef CONFIG_88EU_AP_MODE
 	spin_lock_bh(&pxmitpriv->lock);
 	if (xmitframe_enqueue_for_sleeping_sta(padapter, pxmitframe)) {
 		spin_unlock_bh(&pxmitpriv->lock);
 		return 1;
 	}
 	spin_unlock_bh(&pxmitpriv->lock);
-#endif
 
 	if (!rtw_hal_xmit(padapter, pxmitframe))
 		return 1;
@@ -1788,8 +1786,6 @@ s32 rtw_xmit(struct adapter *padapter, struct sk_buff **ppkt)
 	return 0;
 }
 
-#if defined(CONFIG_88EU_AP_MODE)
-
 int xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_frame *pxmitframe)
 {
 	int ret = false;
@@ -2156,8 +2152,6 @@ void xmit_delivery_enabled_frames(struct adapter *padapter, struct sta_info *pst
 	spin_unlock_bh(&psta->sleep_q.lock);
 }
 
-#endif
-
 void rtw_sctx_init(struct submit_ctx *sctx, int timeout_ms)
 {
 	sctx->timeout_ms = timeout_ms;
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 92c55b9ab244..53459e7f3db4 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -130,14 +130,12 @@ void rtw_hal_update_ra_mask(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 	struct mlme_priv *pmlmepriv = &adapt->mlmepriv;
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
-#ifdef CONFIG_88EU_AP_MODE
 		struct sta_info *psta = NULL;
 		struct sta_priv *pstapriv = &adapt->stapriv;
 		if ((mac_id - 1) > 0)
 			psta = pstapriv->sta_aid[(mac_id - 1) - 1];
 		if (psta)
 			add_RATid(adapt, psta, 0);/* todo: based on rssi_level*/
-#endif
 	} else {
 		UpdateHalRAMask8188EUsb(adapt, mac_id, rssi_level);
 	}
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index 7d50d64cf34d..f5268d295278 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -667,7 +667,6 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 
 void rtl8188e_set_p2p_ps_offload_cmd(struct adapter *adapt, u8 p2p_ps_state)
 {
-#ifdef CONFIG_88EU_P2P
 	struct hal_data_8188e *haldata = GET_HAL_DATA(adapt);
 	struct wifidirect_info	*pwdinfo = &adapt->wdinfo;
 	struct P2P_PS_Offload_t	*p2p_ps_offload = &haldata->p2p_ps_offload;
@@ -732,6 +731,4 @@ void rtl8188e_set_p2p_ps_offload_cmd(struct adapter *adapt, u8 p2p_ps_state)
 	}
 
 	FillH2CCmd_88E(adapt, H2C_PS_P2P_OFFLOAD, 1, (u8 *)p2p_ps_offload);
-#endif
-
 }
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 37a976c56f06..c5347c5459d6 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1761,14 +1761,12 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			rtl8188e_set_FwJoinBssReport_cmd(Adapter, mstatus);
 		}
 		break;
-#ifdef CONFIG_88EU_P2P
 	case HW_VAR_H2C_FW_P2P_PS_OFFLOAD:
 		{
 			u8 p2p_ps_state = (*(u8 *)val);
 			rtl8188e_set_p2p_ps_offload_cmd(Adapter, p2p_ps_state);
 		}
 		break;
-#endif
 	case HW_VAR_INITIAL_GAIN:
 		{
 			struct rtw_dig *pDigTable = &podmpriv->DM_DigTable;
diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index 04f4224c11de..626c6273be6f 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -11,8 +11,6 @@
 #define __DRV_TYPES_H__
 
 #define DRV_NAME "r8188eu"
-#define CONFIG_88EU_AP_MODE 1
-#define CONFIG_88EU_P2P 1
 
 #include "osdep_service.h"
 #include "wlan_bssdef.h"
@@ -231,11 +229,7 @@ struct adapter {
 	struct	eeprom_priv eeprompriv;
 	struct	led_priv	ledpriv;
 	struct	mp_priv	mppriv;
-
-#ifdef CONFIG_88EU_AP_MODE
 	struct	hostapd_priv	*phostapdpriv;
-#endif
-
 	struct wifidirect_info	wdinfo;
 
 	void *HalData;
@@ -286,11 +280,9 @@ struct adapter {
 	/* The driver will show up the desired channel number
 	 * when this flag is 1. */
 	u8 bNotifyChannelChange;
-#ifdef CONFIG_88EU_P2P
 	/* The driver will show the current P2P status when the
 	 * upper application reads it. */
 	u8 bShowGetP2PState;
-#endif
 	struct adapter *pbuddy_adapter;
 
 	struct mutex *hw_init_mutex;
diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index ef0a7c20bd58..d64358ab8503 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -15,8 +15,6 @@
 #define ETH_TYPE_LEN		2
 #define PAYLOAD_TYPE_LEN	1
 
-#ifdef CONFIG_88EU_AP_MODE
-
 #define RTL_IOCTL_HOSTAPD (SIOCIWFIRSTPRIV + 28)
 
 /* STA flags */
@@ -36,8 +34,6 @@
 #define WLAN_STA_MAYBE_WPS BIT(13)
 #define WLAN_STA_NONERP BIT(31)
 
-#endif
-
 #define IEEE_CMD_SET_WPA_PARAM			1
 #define IEEE_CMD_SET_WPA_IE				2
 #define IEEE_CMD_SET_ENCRYPTION			3
@@ -172,7 +168,6 @@ struct ieee_param {
 			u16 key_len;
 			u8 key[0];
 		} crypt;
-#ifdef CONFIG_88EU_AP_MODE
 		struct {
 			u16 aid;
 			u16 capability;
@@ -184,12 +179,9 @@ struct ieee_param {
 			u8	reserved[2];/* for set max_num_sta */
 			u8	buf[0];
 		} bcn_ie;
-#endif
-
 	} u;
 };
 
-#ifdef CONFIG_88EU_AP_MODE
 struct ieee_param_ex {
 	u32 cmd;
 	u8 sta_addr[ETH_ALEN];
@@ -211,7 +203,6 @@ struct sta_data {
 	u64	tx_bytes;
 	u64	tx_drops;
 };
-#endif
 
 #define IEEE80211_DATA_LEN		2304
 /* Maximum size for the MA-UNITDATA primitive, 802.11 standard section
@@ -1158,7 +1149,6 @@ u8 *rtw_get_wps_attr_content(u8 *wps_ie, uint wps_ielen, u16 target_attr_id,
 void dump_ies(u8 *buf, u32 buf_len);
 void dump_wps_ie(u8 *ie, u32 ie_len);
 
-#ifdef CONFIG_88EU_P2P
 void dump_p2p_ie(u8 *ie, u32 ie_len);
 u8 *rtw_get_p2p_ie(u8 *in_ie, int in_len, u8 *p2p_ie, uint *p2p_ielen);
 u8 *rtw_get_p2p_attr(u8 *p2p_ie, uint p2p_ielen, u8 target_attr_id,
@@ -1169,8 +1159,6 @@ u32 rtw_set_p2p_attr_content(u8 *pbuf, u8 attr_id, u16 attr_len,
 			     u8 *pdata_attr);
 void rtw_wlan_bssid_ex_remove_p2p_attr(struct wlan_bssid_ex *bss_ex,
 				       u8 attr_id);
-#endif
-
 uint	rtw_get_rateset_len(u8	*rateset);
 
 struct registry_priv;
diff --git a/drivers/staging/r8188eu/include/ioctl_cfg80211.h b/drivers/staging/r8188eu/include/ioctl_cfg80211.h
index e22481050ef8..738f645f9bbc 100644
--- a/drivers/staging/r8188eu/include/ioctl_cfg80211.h
+++ b/drivers/staging/r8188eu/include/ioctl_cfg80211.h
@@ -61,13 +61,11 @@ void rtw_cfg80211_indicate_disconnect(struct adapter *padapter);
 void rtw_cfg80211_indicate_scan_done(struct rtw_wdev_priv *pwdev_priv,
 				     bool aborted);
 
-#ifdef CONFIG_88EU_AP_MODE
 void rtw_cfg80211_indicate_sta_assoc(struct adapter *padapter,
 				     u8 *pmgmt_frame, uint frame_len);
 void rtw_cfg80211_indicate_sta_disassoc(struct adapter *padapter,
 					unsigned char *da,
 					unsigned short reason);
-#endif /* CONFIG_88EU_AP_MODE */
 
 void rtw_cfg80211_issue_p2p_provision_request(struct adapter *padapter,
 					      const u8 *buf, size_t len);
diff --git a/drivers/staging/r8188eu/include/rtl8188e_cmd.h b/drivers/staging/r8188eu/include/rtl8188e_cmd.h
index 6fbf9a47430b..626df5f44fc5 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_cmd.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_cmd.h
@@ -96,9 +96,7 @@ u8 rtl8188e_set_raid_cmd(struct adapter *padapter, u32 mask);
 void rtl8188e_Add_RateATid(struct adapter *padapter, u32 bitmap, u8 arg,
 			   u8 rssi_level);
 
-#ifdef CONFIG_88EU_P2P
 void rtl8188e_set_p2p_ps_offload_cmd(struct adapter *adapt, u8 p2p_ps_state);
-#endif /* CONFIG_88EU_P2P */
 
 void CheckFwRsvdPageContent(struct adapter *adapt);
 void rtl8188e_set_FwMediaStatus_cmd(struct adapter *adapt, __le16 mstatus_rpt);
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 13217789d495..a9ca29b5b9c1 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -364,9 +364,7 @@ struct hal_data_8188e {
 
 	u16	EfuseUsedBytes;
 
-#ifdef CONFIG_88EU_P2P
 	struct P2P_PS_Offload_t	p2p_ps_offload;
-#endif
 
 	/*  Auto FSM to Turn On, include clock, isolation, power control
 	 *  for MAC only */
diff --git a/drivers/staging/r8188eu/include/rtw_ap.h b/drivers/staging/r8188eu/include/rtw_ap.h
index 2eb556968509..c7cdab00538d 100644
--- a/drivers/staging/r8188eu/include/rtw_ap.h
+++ b/drivers/staging/r8188eu/include/rtw_ap.h
@@ -7,8 +7,6 @@
 #include "osdep_service.h"
 #include "drv_types.h"
 
-#ifdef CONFIG_88EU_AP_MODE
-
 /* external function */
 void rtw_indicate_sta_assoc_event(struct adapter *padapter,
 				  struct sta_info *psta);
@@ -28,7 +26,6 @@ void rtw_set_macaddr_acl(struct adapter *padapter, int mode);
 int rtw_acl_add_sta(struct adapter *padapter, u8 *addr);
 int rtw_acl_remove_sta(struct adapter *padapter, u8 *addr);
 
-#ifdef CONFIG_88EU_AP_MODE
 void associated_clients_update(struct adapter *padapter, u8 updated);
 void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta);
 u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta);
@@ -40,8 +37,6 @@ int rtw_sta_flush(struct adapter *padapter);
 int rtw_ap_inform_ch_switch(struct adapter *padapter, u8 new_ch, u8 ch_offset);
 void start_ap_mode(struct adapter *padapter);
 void stop_ap_mode(struct adapter *padapter);
-#endif
-#endif /* end of CONFIG_88EU_AP_MODE */
 void update_bmc_sta(struct adapter *padapter);
 
 #endif
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index c14d9052b997..90ebe1eca896 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -91,9 +91,7 @@ u32 rtw_init_evt_priv(struct evt_priv *pevtpriv);
 void rtw_free_evt_priv(struct evt_priv *pevtpriv);
 void rtw_cmd_clr_isr(struct cmd_priv *pcmdpriv);
 void rtw_evt_notify_isr(struct evt_priv *pevtpriv);
-#ifdef CONFIG_88EU_P2P
 u8 p2p_protocol_wk_cmd(struct adapter *padapter, int intCmdType);
-#endif /* CONFIG_88EU_P2P */
 
 enum rtw_drvextra_cmd_id {
 	NONE_WK_CID,
@@ -785,9 +783,7 @@ u8 rtw_rpt_timer_cfg_cmd(struct adapter*padapter, u16 minRptTime);
  u8 rtw_antenna_select_cmd(struct adapter*padapter, u8 antenna,u8 enqueue);
 u8 rtw_ps_cmd(struct adapter*padapter);
 
-#ifdef CONFIG_88EU_AP_MODE
 u8 rtw_chk_hi_queue_cmd(struct adapter*padapter);
-#endif
 
 u8 rtw_set_ch_cmd(struct adapter*padapter, u8 ch, u8 bw, u8 ch_offset, u8 enqueue);
 u8 rtw_set_chplan_cmd(struct adapter*padapter, u8 chplan, u8 enqueue);
diff --git a/drivers/staging/r8188eu/include/rtw_debug.h b/drivers/staging/r8188eu/include/rtw_debug.h
index 9de3a0ed12ba..002139cacfb5 100644
--- a/drivers/staging/r8188eu/include/rtw_debug.h
+++ b/drivers/staging/r8188eu/include/rtw_debug.h
@@ -156,14 +156,10 @@ int proc_get_rf_reg_dump4(char *page, char **start,
 			  off_t offset, int count,
 			  int *eof, void *data);
 
-#ifdef CONFIG_88EU_AP_MODE
-
 int proc_get_all_sta_info(char *page, char **start,
 			  off_t offset, int count,
 			  int *eof, void *data);
 
-#endif
-
 int proc_get_best_channel(char *page, char **start,
 			  off_t offset, int count,
 			  int *eof, void *data);
diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index bbb41471472d..3e583748df74 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -379,7 +379,6 @@ struct mlme_priv {
 	u8 *assoc_rsp;
 	u32 assoc_rsp_len;
 
-#if defined (CONFIG_88EU_AP_MODE)
 	/* Number of associated Non-ERP stations (i.e., stations using 802.11b
 	 * in 802.11g BSS) */
 	int num_sta_non_erp;
@@ -428,18 +427,14 @@ struct mlme_priv {
 	u32 p2p_assoc_req_ie_len;
 	spinlock_t bcn_update_lock;
 	u8		update_bcn;
-#endif /* if defined (CONFIG_88EU_AP_MODE) */
 };
 
-#ifdef CONFIG_88EU_AP_MODE
-
 struct hostapd_priv {
 	struct adapter *padapter;
 };
 
 int hostapd_mode_init(struct adapter *padapter);
 void hostapd_mode_unload(struct adapter *padapter);
-#endif
 
 extern unsigned char WPA_TKIP_CIPHER[4];
 extern unsigned char RSN_TKIP_CIPHER[4];
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index e15e2cec77bd..c00ed9553209 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -416,9 +416,7 @@ struct mlme_ext_priv {
 
 	u64 TSFValue;
 
-#ifdef CONFIG_88EU_AP_MODE
 	unsigned char bstart_bss;
-#endif
 	u8 update_channel_plan_by_ap_done;
 	/* recv_decache check for Action_public frame */
 	u8 action_public_dialog_token;
@@ -538,7 +536,6 @@ s32 dump_mgntframe_and_wait(struct adapter *padapter,
 s32 dump_mgntframe_and_wait_ack(struct adapter *padapter,
 				struct xmit_frame *pmgntframe);
 
-#ifdef CONFIG_88EU_P2P
 void issue_probersp_p2p(struct adapter *padapter, unsigned char *da);
 void issue_p2p_provision_request(struct adapter *padapter, u8 *pssid,
 				 u8 ussidlen, u8 *pdev_raddr);
@@ -549,7 +546,6 @@ int issue_probereq_p2p_ex(struct adapter *adapter, u8 *da, int try_cnt,
 void issue_p2p_invitation_response(struct adapter *padapter, u8 *raddr,
 				   u8 dialogToken, u8 success);
 void issue_p2p_invitation_request(struct adapter *padapter, u8* raddr);
-#endif /* CONFIG_88EU_P2P */
 void issue_beacon(struct adapter *padapter, int timeout_ms);
 void issue_probersp(struct adapter *padapter, unsigned char *da,
 		    u8 is_valid_p2p_probereq);
diff --git a/drivers/staging/r8188eu/include/rtw_security.h b/drivers/staging/r8188eu/include/rtw_security.h
index 9bbda86a6641..9231201f1009 100644
--- a/drivers/staging/r8188eu/include/rtw_security.h
+++ b/drivers/staging/r8188eu/include/rtw_security.h
@@ -111,7 +111,6 @@ struct security_priv {
 	struct arc4_ctx xmit_arc4_ctx;
 	struct arc4_ctx recv_arc4_ctx;
 
-#ifdef CONFIG_88EU_AP_MODE
 	/* extend security capabilities for AP_MODE */
 	unsigned int dot8021xalg;/* 0:disable, 1:psk, 2:802.1x */
 	unsigned int wpa_psk;/* 0:disable, bit(0): WPA, bit(1):WPA2 */
@@ -119,7 +118,6 @@ struct security_priv {
 	unsigned int wpa2_group_cipher;
 	unsigned int wpa_pairwise_cipher;
 	unsigned int wpa2_pairwise_cipher;
-#endif
 	u8 wps_ie[MAX_WPS_IE_LEN];/* added in assoc req */
 	int wps_ie_len;
 	u8	binstallGrpkey;
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index 5f6e2402e5c4..1244545070c7 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -349,12 +349,10 @@ void rtw_alloc_hwxmits(struct adapter *padapter);
 void rtw_free_hwxmits(struct adapter *padapter);
 s32 rtw_xmit(struct adapter *padapter, struct sk_buff **pkt);
 
-#if defined(CONFIG_88EU_AP_MODE)
 int xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_frame *pxmitframe);
 void stop_sta_xmit(struct adapter *padapter, struct sta_info *psta);
 void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta);
 void xmit_delivery_enabled_frames(struct adapter *padapter, struct sta_info *psta);
-#endif
 
 u8	qos_acm(u8 acm_mask, u8 priority);
 u32	rtw_get_ff_hwaddr(struct xmit_frame *pxmitframe);
diff --git a/drivers/staging/r8188eu/include/sta_info.h b/drivers/staging/r8188eu/include/sta_info.h
index 8ff99fc6381d..24b1254310b2 100644
--- a/drivers/staging/r8188eu/include/sta_info.h
+++ b/drivers/staging/r8188eu/include/sta_info.h
@@ -124,7 +124,6 @@ struct sta_info {
 	/* sta_info: (AP & STA) CAP/INFO */
 
 	struct list_head asoc_list;
-#ifdef CONFIG_88EU_AP_MODE
 	struct list_head auth_list;
 
 	unsigned int expire_to;
@@ -164,9 +163,7 @@ struct sta_info {
 
 	u8 has_legacy_ac;
 	unsigned int sleepq_ac_len;
-#endif	/*  CONFIG_88EU_AP_MODE */
 
-#ifdef CONFIG_88EU_P2P
 	/* p2p priv data */
 	u8 is_p2p_device;
 	u8 p2p_status_code;
@@ -180,7 +177,6 @@ struct sta_info {
 	u8 secdev_types_list[32];/*  32/8 == 4; */
 	u16 dev_name_len;
 	u8 dev_name[32];
-#endif /* CONFIG_88EU_P2P */
 	u8 under_exist_checking;
 	u8 keep_alive_trycnt;
 
@@ -306,7 +302,6 @@ struct	sta_priv {
 	spinlock_t asoc_list_lock;
 	struct list_head asoc_list;
 
-#ifdef CONFIG_88EU_AP_MODE
 	struct list_head auth_list;
 	spinlock_t auth_list_lock;
 	u8 asoc_list_cnt;
@@ -330,8 +325,6 @@ struct	sta_priv {
 	u16 max_num_sta;
 
 	struct wlan_acl_pool acl_list;
-#endif
-
 };
 
 static inline u32 wifi_mac_hash(u8 *mac)
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 08b891b9c708..1349348b9b32 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -138,7 +138,6 @@ static char *translate_scan(struct adapter *padapter,
 	u8 bw_40MHz = 0, short_GI = 0;
 	u16 mcs_rate = 0;
 	u8 ss, sq;
-#ifdef CONFIG_88EU_P2P
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
 	if (!rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE)) {
@@ -166,7 +165,6 @@ static char *translate_scan(struct adapter *padapter,
 		if (!blnGotP2PIE)
 			return start;
 	}
-#endif /* CONFIG_88EU_P2P */
 
 	/*  AP MAC address  */
 	iwe.cmd = SIOCGIWAP;
@@ -425,9 +423,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
-#ifdef CONFIG_88EU_P2P
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
-#endif /* CONFIG_88EU_P2P */
 
 	param->u.crypt.err = 0;
 	param->u.crypt.alg[IEEE_CRYPT_ALG_NAME_LEN - 1] = '\0';
@@ -540,10 +536,8 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 					padapter->securitypriv.dot118021XGrpKeyid = param->u.crypt.idx;
 
 					rtw_set_key(padapter, &padapter->securitypriv, param->u.crypt.idx, 1);
-#ifdef CONFIG_88EU_P2P
 					if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_PROVISIONING_ING))
 						rtw_p2p_set_state(pwdinfo, P2P_STATE_PROVISIONING_DONE);
-#endif /* CONFIG_88EU_P2P */
 				}
 			}
 			pbcmc_sta = rtw_get_bcmc_stainfo(padapter);
@@ -573,9 +567,7 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 	u8 *buf = NULL;
 	int group_cipher = 0, pairwise_cipher = 0;
 	int ret = 0;
-#ifdef CONFIG_88EU_P2P
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
-#endif /* CONFIG_88EU_P2P */
 
 	if (ielen > MAX_WPA_IE_LEN || !pie) {
 		_clr_fwstate_(&padapter->mlmepriv, WIFI_UNDER_WPS);
@@ -678,10 +670,8 @@ static int rtw_set_wpa_ie(struct adapter *padapter, char *pie, unsigned short ie
 					memcpy(padapter->securitypriv.wps_ie, &buf[cnt], padapter->securitypriv.wps_ie_len);
 
 					set_fwstate(&padapter->mlmepriv, WIFI_UNDER_WPS);
-#ifdef CONFIG_88EU_P2P
 					if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_GONEGO_OK))
 						rtw_p2p_set_state(pwdinfo, P2P_STATE_PROVISIONING_ING);
-#endif /* CONFIG_88EU_P2P */
 					cnt += buf[cnt + 1] + 2;
 					break;
 				} else {
@@ -1150,9 +1140,7 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct ndis_802_11_ssid ssid[RTW_SSID_SCAN_AMOUNT];
-#ifdef CONFIG_88EU_P2P
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
-#endif /* CONFIG_88EU_P2P */
 
 	if (padapter->registrypriv.mp_mode == 1) {
 		if (check_fwstate(pmlmepriv, WIFI_MP_STATE)) {
@@ -1198,14 +1186,12 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 /*	the pmlmepriv->scan_interval is always equal to 3. */
 /*	So, the wpa_supplicant won't find out the WPS SoftAP. */
 
-#ifdef CONFIG_88EU_P2P
 	if (pwdinfo->p2p_state != P2P_STATE_NONE) {
 		rtw_p2p_set_pre_state(pwdinfo, rtw_p2p_state(pwdinfo));
 		rtw_p2p_set_state(pwdinfo, P2P_STATE_FIND_PHASE_SEARCH);
 		rtw_p2p_findphase_ex_set(pwdinfo, P2P_FINDPHASE_EX_FULL);
 		rtw_free_network_queue(padapter, true);
 	}
-#endif /* CONFIG_88EU_P2P */
 
 	memset(ssid, 0, sizeof(struct ndis_802_11_ssid) * RTW_SSID_SCAN_AMOUNT);
 
@@ -1301,16 +1287,13 @@ static int rtw_wx_get_scan(struct net_device *dev, struct iw_request_info *a,
 	u32 cnt = 0;
 	u32 wait_for_surveydone;
 	int wait_status;
-#ifdef CONFIG_88EU_P2P
 	struct	wifidirect_info *pwdinfo = &padapter->wdinfo;
-#endif /* CONFIG_88EU_P2P */
 
 	if (padapter->pwrctrlpriv.brfoffbyhw && padapter->bDriverStopped) {
 		ret = -EINVAL;
 		goto exit;
 	}
 
-#ifdef CONFIG_88EU_P2P
 	if (!rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE)) {
 		/*	P2P is enabled */
 		wait_for_surveydone = 200;
@@ -1318,11 +1301,6 @@ static int rtw_wx_get_scan(struct net_device *dev, struct iw_request_info *a,
 		/*	P2P is disabled */
 		wait_for_surveydone = 100;
 	}
-#else
-	{
-		wait_for_surveydone = 100;
-	}
-#endif /* CONFIG_88EU_P2P */
 
 	wait_status = _FW_UNDER_SURVEY | _FW_UNDER_LINKING;
 
@@ -2558,7 +2536,6 @@ static int rtw_wps_start(struct net_device *dev,
 	return ret;
 }
 
-#ifdef CONFIG_88EU_P2P
 static int rtw_wext_p2p_enable(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
@@ -3663,15 +3640,12 @@ static int rtw_p2p_got_wpsinfo(struct net_device *dev,
 	return ret;
 }
 
-#endif /* CONFIG_88EU_P2P */
-
 static int rtw_p2p_set(struct net_device *dev,
 			       struct iw_request_info *info,
 			       union iwreq_data *wrqu, char *extra)
 {
 	int ret = 0;
 
-#ifdef CONFIG_88EU_P2P
 	DBG_88E("[%s] extra = %s\n", __func__, extra);
 	if (!memcmp(extra, "enable =", 7)) {
 		rtw_wext_p2p_enable(dev, info, wrqu, &extra[7]);
@@ -3718,7 +3692,6 @@ static int rtw_p2p_set(struct net_device *dev,
 		wrqu->data.length -= 11;
 		rtw_p2p_set_persistent(dev, info, wrqu, &extra[11]);
 	}
-#endif /* CONFIG_88EU_P2P */
 
 	return ret;
 }
@@ -3729,7 +3702,6 @@ static int rtw_p2p_get(struct net_device *dev,
 {
 	int ret = 0;
 
-#ifdef CONFIG_88EU_P2P
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 
 	if (padapter->bShowGetP2PState)
@@ -3753,7 +3725,6 @@ static int rtw_p2p_get(struct net_device *dev,
 	} else if (!memcmp(wrqu->data.pointer, "op_ch", 5)) {
 		rtw_p2p_get_op_ch(dev, info, wrqu, extra);
 	}
-#endif /* CONFIG_88EU_P2P */
 	return ret;
 }
 
@@ -3763,7 +3734,6 @@ static int rtw_p2p_get2(struct net_device *dev,
 {
 	int ret = 0;
 
-#ifdef CONFIG_88EU_P2P
 	DBG_88E("[%s] extra = %s\n", __func__, (char *)wrqu->data.pointer);
 	if (!memcmp(extra, "wpsCM =", 6)) {
 		wrqu->data.length -= 6;
@@ -3782,8 +3752,6 @@ static int rtw_p2p_get2(struct net_device *dev,
 		rtw_p2p_get_invitation_procedure(dev, info, wrqu, &extra[8]);
 	}
 
-#endif /* CONFIG_88EU_P2P */
-
 	return ret;
 }
 
@@ -4248,9 +4216,7 @@ static int rtw_dbg_port(struct net_device *dev,
 				struct list_head *plist, *phead;
 				struct recv_reorder_ctrl *preorder_ctrl;
 
-#ifdef CONFIG_88EU_AP_MODE
 				DBG_88E("sta_dz_bitmap = 0x%x, tim_bitmap = 0x%x\n", pstapriv->sta_dz_bitmap, pstapriv->tim_bitmap);
-#endif
 				spin_lock_bh(&pstapriv->sta_hash_lock);
 
 				for (i = 0; i < NUM_STA; i++) {
@@ -4271,14 +4237,12 @@ static int rtw_dbg_port(struct net_device *dev,
 							DBG_88E("ampdu_enable = %d\n", psta->htpriv.ampdu_enable);
 							DBG_88E("agg_enable_bitmap =%x, candidate_tid_bitmap =%x\n", psta->htpriv.agg_enable_bitmap, psta->htpriv.candidate_tid_bitmap);
 
-#ifdef CONFIG_88EU_AP_MODE
 							DBG_88E("capability = 0x%x\n", psta->capability);
 							DBG_88E("flags = 0x%x\n", psta->flags);
 							DBG_88E("wpa_psk = 0x%x\n", psta->wpa_psk);
 							DBG_88E("wpa2_group_cipher = 0x%x\n", psta->wpa2_group_cipher);
 							DBG_88E("wpa2_pairwise_cipher = 0x%x\n", psta->wpa2_pairwise_cipher);
 							DBG_88E("qos_info = 0x%x\n", psta->qos_info);
-#endif
 							DBG_88E("dot118021XPrivacy = 0x%x\n", psta->dot118021XPrivacy);
 
 							for (j = 0; j < 16; j++) {
@@ -4359,10 +4323,8 @@ static int rtw_dbg_port(struct net_device *dev,
 			padapter->bNotifyChannelChange = extra_arg;
 			break;
 		case 0x24:
-#ifdef CONFIG_88EU_P2P
 			DBG_88E("turn %s the bShowGetP2PState Variable\n", (extra_arg == 1) ? "on" : "off");
 			padapter->bShowGetP2PState = extra_arg;
-#endif /*  CONFIG_88EU_P2P */
 			break;
 		case 0xaa:
 			if (extra_arg > 0x13)
diff --git a/drivers/staging/r8188eu/os_dep/mlme_linux.c b/drivers/staging/r8188eu/os_dep/mlme_linux.c
index e3ee9dc7ab90..cc33baf38da7 100644
--- a/drivers/staging/r8188eu/os_dep/mlme_linux.c
+++ b/drivers/staging/r8188eu/os_dep/mlme_linux.c
@@ -165,8 +165,6 @@ void init_mlme_ext_timer(struct adapter *padapter)
 	timer_setup(&pmlmeext->link_timer, _link_timer_hdl, 0);
 }
 
-#ifdef CONFIG_88EU_AP_MODE
-
 void rtw_indicate_sta_assoc_event(struct adapter *padapter, struct sta_info *psta)
 {
 	union iwreq_data wrqu;
@@ -212,5 +210,3 @@ void rtw_indicate_sta_disassoc_event(struct adapter *padapter, struct sta_info *
 
 	wireless_send_event(padapter->pnetdev, IWEVEXPIRED, &wrqu, NULL);
 }
-
-#endif
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index a1136c0dadf7..306377fe8bfc 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -364,15 +364,12 @@ void rtw_proc_init_one(struct net_device *dev)
 		}
 	}
 
-#ifdef CONFIG_88EU_AP_MODE
-
 	entry = create_proc_read_entry("all_sta_info", S_IFREG | S_IRUGO,
 				   dir_dev, proc_get_all_sta_info, dev);
 	if (!entry) {
 		pr_info("Unable to create_proc_read_entry!\n");
 		return;
 	}
-#endif
 
 	entry = create_proc_read_entry("best_channel", S_IFREG | S_IRUGO,
 				   dir_dev, proc_get_best_channel, dev);
@@ -469,9 +466,7 @@ void rtw_proc_remove_one(struct net_device *dev)
 			remove_proc_entry("rf_reg_dump3", dir_dev);
 			remove_proc_entry("rf_reg_dump4", dir_dev);
 		}
-#ifdef CONFIG_88EU_AP_MODE
 		remove_proc_entry("all_sta_info", dir_dev);
-#endif
 
 		remove_proc_entry("best_channel", dir_dev);
 		remove_proc_entry("rx_signal", dir_dev);
@@ -788,9 +783,7 @@ static u8 rtw_init_default_value(struct adapter *padapter)
 	padapter->bWritePortCancel = false;
 	padapter->bRxRSSIDisplay = 0;
 	padapter->bNotifyChannelChange = 0;
-#ifdef CONFIG_88EU_P2P
 	padapter->bShowGetP2PState = 1;
-#endif
 	return _SUCCESS;
 }
 
@@ -845,11 +838,9 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 		goto exit;
 	}
 
-#ifdef CONFIG_88EU_P2P
 	rtw_init_wifidirect_timers(padapter);
 	init_wifidirect_info(padapter, P2P_ROLE_DISABLE);
 	reset_global_wifidirect_info(padapter);
-#endif /* CONFIG_88EU_P2P */
 
 	if (init_mlme_ext_priv(padapter) == _FAIL) {
 		ret8 = _FAIL;
@@ -919,7 +910,6 @@ u8 rtw_free_drv_sw(struct adapter *padapter)
 	/* we can call rtw_p2p_enable here, but: */
 	/*  1. rtw_p2p_enable may have IO operation */
 	/*  2. rtw_p2p_enable is bundled with wext interface */
-	#ifdef CONFIG_88EU_P2P
 	{
 		struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 		if (!rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE)) {
@@ -929,7 +919,6 @@ u8 rtw_free_drv_sw(struct adapter *padapter)
 			rtw_p2p_set_state(pwdinfo, P2P_STATE_NONE);
 		}
 	}
-	#endif
 
 	free_mlme_ext_priv(&padapter->mlmeextpriv);
 
@@ -1184,9 +1173,7 @@ int netdev_close(struct net_device *pnetdev)
 
 	nat25_db_cleanup(padapter);
 
-#ifdef CONFIG_88EU_P2P
 	rtw_p2p_enable(padapter, P2P_ROLE_DISABLE);
-#endif /* CONFIG_88EU_P2P */
 
 	kfree(dvobj->firmware.szFwBuffer);
 	dvobj->firmware.szFwBuffer = NULL;
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 4828862260d5..da93512993f1 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -627,10 +627,8 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 	/*  alloc dev name after read efuse. */
 	rtw_init_netdev_name(pnetdev, padapter->registrypriv.ifname);
 	rtw_macaddr_cfg(padapter->eeprompriv.mac_addr);
-#ifdef CONFIG_88EU_P2P
 	rtw_init_wifidirect_addrs(padapter, padapter->eeprompriv.mac_addr,
 				  padapter->eeprompriv.mac_addr);
-#endif
 	memcpy(pnetdev->dev_addr, padapter->eeprompriv.mac_addr, ETH_ALEN);
 	DBG_88E("MAC Address from pnetdev->dev_addr =  %pM\n",
 		pnetdev->dev_addr);
@@ -674,9 +672,7 @@ static void rtw_usb_if1_deinit(struct adapter *if1)
 	if (check_fwstate(pmlmepriv, _FW_LINKED))
 		rtw_disassoc_cmd(if1, 0, false);
 
-#ifdef CONFIG_88EU_AP_MODE
 	free_mlme_ap_info(if1);
-#endif
 
 	if (if1->DriverState != DRIVER_DISAPPEAR) {
 		if (pnetdev) {
diff --git a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
index 62dd4a131534..928730158450 100644
--- a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
@@ -79,9 +79,7 @@ static void usb_write_port_complete(struct urb *purb, struct pt_regs *regs)
 		pxmitpriv->bkq_cnt--;
 		break;
 	case HIGH_QUEUE_INX:
-#ifdef CONFIG_88EU_AP_MODE
 		rtw_chk_hi_queue_cmd(padapter);
-#endif
 		break;
 	default:
 		break;
-- 
2.33.0

