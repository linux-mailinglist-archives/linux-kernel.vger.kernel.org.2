Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB2B3DEB32
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbhHCKoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:44:25 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:39746
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234821AbhHCKoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:44:23 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id E4FCA3F0FA;
        Tue,  3 Aug 2021 10:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627987451;
        bh=H70shhkZ9RHSOOUTpD8rIbO+HlJ2IcOm45dkmasYSrE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=DCeMB0PMIa1clSDT5PHDUClHWCVflxQ0x8X46i4YcaxRqofLeHG60e43RLZ1/4dzJ
         XZlKqcBK+4ApOHpTXvglxifvACuNieXtZkQuZeFlWv96MJljcVRwIMx8y0dmgj7Ctg
         3HHFnYUKpJyjqo/e29TIBieZJlIHg82UK6iRQ0MW2REF5jEImWu1/wGwPaoXxT4pdb
         gZwT3TkVbwxz6vzsd/D3gJyGoMoX6eNUFlyPiOR2gnIaM7Y2TRF29OXJw3WapNLKj/
         itnd85jYfAYeoAKlaROAh+yijHos3k/hYhsnjiKmLgWAPXwISX/9IFkEN9Zw8yxZGq
         sH+ZJpUlEYV0A==
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Cesati <marcocesati@gmail.com>,
        linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] staging: r8188eu: Fix spelling mistakes and typos
Date:   Tue,  3 Aug 2021 11:44:10 +0100
Message-Id: <20210803104410.337982-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are quire a few spelling mistakes and typos in the driver
in comments, literal strings and function names. Fix these.

Note that this just corrects spelling mistakes and does not
clean up any existing checkpatch warnings.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c         | 10 ++---
 drivers/staging/r8188eu/core/rtw_br_ext.c     |  6 +--
 drivers/staging/r8188eu/core/rtw_cmd.c        |  4 +-
 drivers/staging/r8188eu/core/rtw_debug.c      |  2 +-
 drivers/staging/r8188eu/core/rtw_efuse.c      |  2 +-
 drivers/staging/r8188eu/core/rtw_ieee80211.c  |  4 +-
 drivers/staging/r8188eu/core/rtw_ioctl_set.c  |  4 +-
 drivers/staging/r8188eu/core/rtw_iol.c        |  2 +-
 drivers/staging/r8188eu/core/rtw_mlme.c       | 16 +++----
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 42 +++++++++---------
 drivers/staging/r8188eu/core/rtw_mp.c         |  4 +-
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    |  2 +-
 drivers/staging/r8188eu/core/rtw_recv.c       | 18 ++++----
 drivers/staging/r8188eu/core/rtw_xmit.c       | 10 ++---
 .../staging/r8188eu/hal/HalHWImg8188E_BB.c    |  8 ++--
 .../staging/r8188eu/hal/HalHWImg8188E_MAC.c   |  4 +-
 .../staging/r8188eu/hal/HalHWImg8188E_RF.c    |  4 +-
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  |  2 +-
 drivers/staging/r8188eu/hal/odm.c             |  6 +--
 drivers/staging/r8188eu/hal/odm_HWConfig.c    |  4 +-
 drivers/staging/r8188eu/hal/odm_RTL8188E.c    |  2 +-
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  2 +-
 drivers/staging/r8188eu/hal/rtl8188e_dm.c     |  2 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  4 +-
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 26 +++++------
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  |  8 ++--
 drivers/staging/r8188eu/hal/usb_halinit.c     | 12 ++---
 drivers/staging/r8188eu/hal/usb_ops_linux.c   |  6 +--
 .../staging/r8188eu/include/Hal8188EPhyCfg.h  |  4 +-
 .../staging/r8188eu/include/Hal8188EPhyReg.h  |  4 +-
 .../staging/r8188eu/include/Hal8188EPwrSeq.h  |  2 +-
 .../staging/r8188eu/include/HalPwrSeqCmd.h    |  2 +-
 drivers/staging/r8188eu/include/basic_types.h |  2 +-
 drivers/staging/r8188eu/include/drv_types.h   |  4 +-
 drivers/staging/r8188eu/include/ieee80211.h   |  2 +-
 .../staging/r8188eu/include/mp_custom_oid.h   |  2 +-
 drivers/staging/r8188eu/include/odm.h         |  4 +-
 .../staging/r8188eu/include/osdep_service.h   |  4 +-
 .../staging/r8188eu/include/rtl8188e_hal.h    | 10 ++---
 .../staging/r8188eu/include/rtl8188e_spec.h   | 10 ++---
 drivers/staging/r8188eu/include/rtw_cmd.h     |  6 +--
 drivers/staging/r8188eu/include/rtw_event.h   |  2 +-
 drivers/staging/r8188eu/include/rtw_io.h      |  2 +-
 drivers/staging/r8188eu/include/rtw_iol.h     |  2 +-
 drivers/staging/r8188eu/include/rtw_led.h     |  5 +--
 drivers/staging/r8188eu/include/rtw_mlme.h    |  6 +--
 drivers/staging/r8188eu/include/rtw_mp.h      |  2 +-
 .../r8188eu/include/rtw_mp_phy_regdef.h       |  6 +--
 drivers/staging/r8188eu/include/rtw_recv.h    |  4 +-
 drivers/staging/r8188eu/include/rtw_xmit.h    |  4 +-
 drivers/staging/r8188eu/include/wifi.h        | 24 +++++-----
 drivers/staging/r8188eu/include/wlan_bssdef.h |  2 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 44 +++++++++----------
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  2 +-
 drivers/staging/r8188eu/os_dep/usb_intf.c     |  2 +-
 .../staging/r8188eu/os_dep/usb_ops_linux.c    |  2 +-
 56 files changed, 190 insertions(+), 191 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 0bb545135206..015f4087cca4 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -807,7 +807,7 @@ static void start_bss_network(struct adapter *padapter, u8 *pbuf)
 	/* update cur_wireless_mode */
 	update_wireless_mode(padapter);
 
-	/* udpate capability after cur_wireless_mode updated */
+	/* update capability after cur_wireless_mode updated */
 	update_capinfo(padapter, rtw_get_capability((struct wlan_bssid_ex *)pnetwork));
 
 	/* let pnetwork_mlmeext == pnetwork_mlme. */
@@ -1399,7 +1399,7 @@ void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx)
 
 /*
 op_mode
-Set to 0 (HT pure) under the followign conditions
+Set to 0 (HT pure) under the following conditions
 	- all STAs in the BSS are 20/40 MHz HT in 20/40 MHz BSS or
 	- all STAs in the BSS are 20 MHz HT in 20 MHz BSS
 Set to 1 (HT non-member protection) if there may be non-HT STAs
@@ -1479,7 +1479,7 @@ static int rtw_ht_operation_update(struct adapter *padapter)
 
 void associated_clients_update(struct adapter *padapter, u8 updated)
 {
-	/* update associcated stations cap. */
+	/* update associated stations cap. */
 	if (updated) {
 		struct list_head *phead, *plist;
 		struct sta_info *psta = NULL;
@@ -1632,7 +1632,7 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 		update_beacon(padapter, _HT_ADD_INFO_IE_, NULL, true);
 	}
 
-	/* update associcated stations cap. */
+	/* update associated stations cap. */
 	associated_clients_update(padapter,  beacon_updated);
 
 	DBG_88E("%s, updated =%d\n", __func__, beacon_updated);
@@ -1696,7 +1696,7 @@ u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta)
 		update_beacon(padapter, _HT_ADD_INFO_IE_, NULL, true);
 	}
 
-	/* update associcated stations cap. */
+	/* update associated stations cap. */
 
 	DBG_88E("%s, updated =%d\n", __func__, beacon_updated);
 
diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 8f434768dd15..380550fade3b 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -549,10 +549,10 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 			if (!__nat25_db_network_lookup_and_replace(priv, skb, networkAddr)) {
 				if (*((unsigned char *)&iph->daddr + 3) == 0xff) {
 					/*  L2 is unicast but L3 is broadcast, make L2 bacome broadcast */
-					DEBUG_INFO("NAT25: Set DA as boardcast\n");
+					DEBUG_INFO("NAT25: Set DA as broadcast\n");
 					memset(skb->data, 0xff, ETH_ALEN);
 				} else {
-					/*  forward unknow IP packet to upper TCP/IP */
+					/*  forward unknown IP packet to upper TCP/IP */
 					DEBUG_INFO("NAT25: Replace DA with BR's MAC\n");
 					if ((*(u32 *)priv->br_mac) == 0 && (*(u16 *)(priv->br_mac+4)) == 0) {
 						printk("Re-init netdev_br_init() due to br_mac == 0!\n");
@@ -938,7 +938,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 						(ph->code == PADO_CODE ? "PADO" : "PADS"),	skb->dev->name);
 				} else { /*  not add relay tag */
 					if (!priv->pppoe_connection_in_progress) {
-						DEBUG_ERR("Discard PPPoE packet due to no connection in progresss!\n");
+						DEBUG_ERR("Discard PPPoE packet due to no connection in progress!\n");
 						return -1;
 					}
 					memcpy(skb->data, priv->pppoe_addr, ETH_ALEN);
diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 4e17972ee66e..8ad944c69281 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -342,7 +342,7 @@ int rtw_cmd_thread(void *context)
 				rtw_free_cmd_obj(pcmd);
 			} else {
 				/* todo: !!! fill rsp_buf to pcmd->rsp if (pcmd->rsp!= NULL) */
-				pcmd_callback(pcmd->padapter, pcmd);/* need conider that free cmd_obj in rtw_cmd_callback */
+				pcmd_callback(pcmd->padapter, pcmd);/* need consider that free cmd_obj in rtw_cmd_callback */
 			}
 		} else {
 			RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("%s: cmdcode = 0x%x callback not defined!\n", __func__, pcmd->cmdcode));
@@ -2169,7 +2169,7 @@ void rtw_setassocsta_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *
 	struct sta_info *psta = rtw_get_stainfo(pstapriv, passocsta_parm->addr);
 
 	if (psta == NULL) {
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\nERROR: setassocsta_cmdrsp_callbac => can't get sta_info\n\n"));
+		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\nERROR: setassocsta_cmdrsp_callback => can't get sta_info\n\n"));
 		goto exit;
 	}
 
diff --git a/drivers/staging/r8188eu/core/rtw_debug.c b/drivers/staging/r8188eu/core/rtw_debug.c
index 30ef77842787..0159c9b13ec8 100644
--- a/drivers/staging/r8188eu/core/rtw_debug.c
+++ b/drivers/staging/r8188eu/core/rtw_debug.c
@@ -217,7 +217,7 @@ int proc_get_rf_info(char *page, char **start,
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	int len = 0;
 
-	len += snprintf(page + len, count - len, "cur_ch=%d, cur_bw=%d, cur_ch_offet=%d\n",
+	len += snprintf(page + len, count - len, "cur_ch=%d, cur_bw=%d, cur_ch_offset=%d\n",
 					pmlmeext->cur_channel, pmlmeext->cur_bwmode, pmlmeext->cur_ch_offset);
 	*eof = 1;
 	return len;
diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index e84540a7d2c5..2fba12eeae15 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -425,7 +425,7 @@ static u8 efuse_write8(struct adapter *padapter, u16 address, u8 *value)
 }
 
 /*
- * read/wirte raw efuse data
+ * read/write raw efuse data
  */
 u8 rtw_efuse_access(struct adapter *padapter, u8 write, u16 start_addr, u16 cnts, u8 *data)
 {
diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index f5ea93e2fff9..62ef760a425e 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -275,7 +275,7 @@ u8 *rtw_get_ie_ex(u8 *in_ie, uint in_len, u8 eid, u8 *oui, u8 oui_len, u8 *ie, u
  * rtw_ies_remove_ie - Find matching IEs and remove
  * @ies: Address of IEs to search
  * @ies_len: Pointer of length of ies, will update to new length
- * @offset: The offset to start scarch
+ * @offset: The offset to start search
  * @eid: Element ID to match
  * @oui: OUI to match
  * @oui_len: OUI length
@@ -1098,7 +1098,7 @@ void rtw_macaddr_cfg(u8 *mac_addr)
 		mac[3] = 0x87;
 		mac[4] = 0x00;
 		mac[5] = 0x00;
-		/*  use default mac addresss */
+		/*  use default mac address */
 		memcpy(mac_addr, mac, ETH_ALEN);
 		DBG_88E("MAC Address from efuse error, assign default one !!!\n");
 	}
diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index 778da7c86995..8d407d692be4 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -377,7 +377,7 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
 
 		if ((*pold_state == Ndis802_11Infrastructure) || (*pold_state == Ndis802_11IBSS)) {
 			if (check_fwstate(pmlmepriv, _FW_LINKED) == true)
-				rtw_indicate_disconnect(padapter); /* will clr Linked_state; before this function, we must have chked whether  issue dis-assoc_cmd or not */
+				rtw_indicate_disconnect(padapter); /* will clr Linked_state; before this function, we must have checked whether  issue dis-assoc_cmd or not */
 	       }
 
 		*pold_state = networktype;
@@ -530,7 +530,7 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
 		break;
 	}
 	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_,
-		 ("rtw_set_802_11_add_wep:befor memcpy, wep->KeyLength = 0x%x wep->KeyIndex = 0x%x  keyid =%x\n",
+		 ("rtw_set_802_11_add_wep:before memcpy, wep->KeyLength = 0x%x wep->KeyIndex = 0x%x  keyid =%x\n",
 		 wep->KeyLength, wep->KeyIndex, keyid));
 
 	memcpy(&(psecuritypriv->dot11DefKey[keyid].skey[0]), &(wep->KeyMaterial), wep->KeyLength);
diff --git a/drivers/staging/r8188eu/core/rtw_iol.c b/drivers/staging/r8188eu/core/rtw_iol.c
index 0382ff524657..ba32fc1541f6 100644
--- a/drivers/staging/r8188eu/core/rtw_iol.c
+++ b/drivers/staging/r8188eu/core/rtw_iol.c
@@ -3,7 +3,7 @@
 
 #include "../include/rtw_iol.h"
 
-struct xmit_frame	*rtw_IOL_accquire_xmit_frame(struct adapter  *adapter)
+struct xmit_frame	*rtw_IOL_acquire_xmit_frame(struct adapter  *adapter)
 {
 	struct xmit_frame	*xmit_frame;
 	struct xmit_buf	*xmitbuf;
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index a6d62074289f..95c4297c97ad 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -46,7 +46,7 @@ int	_rtw_init_mlme_priv (struct adapter *padapter)
 	pmlmepriv->pscanned = NULL;
 	pmlmepriv->fw_state = 0;
 	pmlmepriv->cur_network.network.InfrastructureMode = Ndis802_11AutoUnknown;
-	pmlmepriv->scan_mode = SCAN_ACTIVE;/*  1: active, 0: pasive. Maybe someday we should rename this varable to "active_mode" (Jeff) */
+	pmlmepriv->scan_mode = SCAN_ACTIVE;/*  1: active, 0: passive. Maybe someday we should rename this variable to "active_mode" (Jeff) */
 
 	spin_lock_init(&(pmlmepriv->lock));
 	_rtw_init_queue(&(pmlmepriv->free_bss_pool));
@@ -248,7 +248,7 @@ void _rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *
 /*
 	return the wlan_network with the matching addr
 
-	Shall be calle under atomic context... to avoid possible racing condition...
+	Shall be called under atomic context... to avoid possible racing condition...
 */
 struct wlan_network *_rtw_find_network(struct __queue *scanned_queue, u8 *addr)
 {
@@ -398,7 +398,7 @@ void rtw_free_network_queue(struct adapter *dev, u8 isfreeall)
 /*
 	return the wlan_network with the matching addr
 
-	Shall be calle under atomic context... to avoid possible racing condition...
+	Shall be called under atomic context... to avoid possible racing condition...
 */
 struct	wlan_network *rtw_find_network(struct __queue *scanned_queue, u8 *addr)
 {
@@ -1059,7 +1059,7 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 		}
 		/* 	Commented by Albert 2012/07/21 */
 		/* 	When doing the WPS, the wps_ie_len won't equal to 0 */
-		/* 	And the Wi-Fi driver shouldn't allow the data packet to be tramsmitted. */
+		/* 	And the Wi-Fi driver shouldn't allow the data packet to be trasmitted. */
 		if (padapter->securitypriv.wps_ie_len != 0) {
 			psta->ieee8021x_blocked = true;
 			padapter->securitypriv.wps_ie_len = 0;
@@ -1243,10 +1243,10 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 					RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("adhoc mode, fw_state:%x", get_fwstate(pmlmepriv)));
 				}
 
-			/* s5. Cancle assoc_timer */
+			/* s5. cancel assoc_timer */
 			_cancel_timer(&pmlmepriv->assoc_timer, &timer_cancelled);
 
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("Cancle assoc_timer\n"));
+			RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("cancel assoc_timer\n"));
 
 		} else {
 			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_joinbss_event_callback err: fw_state:%x", get_fwstate(pmlmepriv)));
@@ -1498,7 +1498,7 @@ void rtw_cpwm_event_callback(struct adapter *padapter, u8 *pbuf)
 }
 
 /*
-* _rtw_join_timeout_handler - Timeout/faliure handler for CMD JoinBss
+* _rtw_join_timeout_handler - Timeout/failure handler for CMD JoinBss
 * @adapter: pointer to struct adapter structure
 */
 void _rtw_join_timeout_handler (struct adapter *adapter)
@@ -1539,7 +1539,7 @@ void _rtw_join_timeout_handler (struct adapter *adapter)
 }
 
 /*
-* rtw_scan_timeout_handler - Timeout/Faliure handler for CMD SiteSurvey
+* rtw_scan_timeout_handler - Timeout/Failure handler for CMD SiteSurvey
 * @adapter: pointer to struct adapter structure
 */
 void rtw_scan_timeout_handler (struct adapter *adapter)
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 78f66664bf9c..8ca1a8eb508b 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -154,7 +154,7 @@ static struct rt_channel_plan_map	RTW_ChannelPlanMap[RT_CHANNEL_DOMAIN_MAX] = {
 	{0x03},	/* 0x41, RT_CHANNEL_DOMAIN_GLOBAL_DOAMIN_2G */
 };
 
-static struct rt_channel_plan_map RTW_CHANNEL_PLAN_MAP_REALTEK_DEFINE = {0x03}; /* use the conbination for max channel numbers */
+static struct rt_channel_plan_map RTW_CHANNEL_PLAN_MAP_REALTEK_DEFINE = {0x03}; /* use the combination for max channel numbers */
 
 /*
  * Search the @param channel_num in given @param channel_set
@@ -1038,7 +1038,7 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 
 	DBG_88E("%s\n", __func__);
 
-	/*  check if this stat has been successfully authenticated/assocated */
+	/*  check if this stat has been successfully authenticated/associated */
 	if (!((pstat->state) & WIFI_FW_AUTH_SUCCESS)) {
 		if (!((pstat->state) & WIFI_FW_ASSOC_SUCCESS)) {
 			status = _RSON_CLS2_;
@@ -1587,7 +1587,7 @@ unsigned int OnDeAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 
 		/* Before sending the auth frame to start the STA/GC mode connection with AP/GO,
 		 *	we will send the deauth first.
-		 *	However, the Win8.1 with BRCM Wi-Fi will send the deauth with reason code 6 to us after receieving our deauth.
+		 *	However, the Win8.1 with BRCM Wi-Fi will send the deauth with reason code 6 to us after receiving our deauth.
 		 *	Added the following code to avoid this case.
 		 */
 		if ((pmlmeinfo->state & WIFI_FW_AUTH_STATE) ||
@@ -1921,7 +1921,7 @@ void issue_p2p_GO_request(struct adapter *padapter, u8 *raddr)
 	p2pie[p2pielen++] = 0x09;	/*	WFA P2P v1.0 */
 
 	/*	Commented by Albert 20110306 */
-	/*	According to the P2P Specification, the group negoitation request frame should contain 9 P2P attributes */
+	/*	According to the P2P Specification, the group negotiation request frame should contain 9 P2P attributes */
 	/*	1. P2P Capability */
 	/*	2. Group Owner Intent */
 	/*	3. Configuration Timeout */
@@ -2279,7 +2279,7 @@ static void issue_p2p_GO_response(struct adapter *padapter, u8 *raddr, u8 *frame
 	p2pie[p2pielen++] = 0x09;	/*	WFA P2P v1.0 */
 
 	/*	Commented by Albert 20100908 */
-	/*	According to the P2P Specification, the group negoitation response frame should contain 9 P2P attributes */
+	/*	According to the P2P Specification, the group negotiation response frame should contain 9 P2P attributes */
 	/*	1. Status */
 	/*	2. P2P Capability */
 	/*	3. Group Owner Intent */
@@ -2577,7 +2577,7 @@ static void issue_p2p_GO_confirm(struct adapter *padapter, u8 *raddr, u8 result)
 	p2pie[p2pielen++] = 0x09;	/*	WFA P2P v1.0 */
 
 	/*	Commented by Albert 20110306 */
-	/*	According to the P2P Specification, the group negoitation request frame should contain 5 P2P attributes */
+	/*	According to the P2P Specification, the group negotiation request frame should contain 5 P2P attributes */
 	/*	1. Status */
 	/*	2. P2P Capability */
 	/*	3. Operating Channel */
@@ -4123,7 +4123,7 @@ static unsigned int on_action_public_p2p(struct recv_frame *precv_frame)
 		/*	Should we check the pwdinfo->tx_prov_disc_info.bsent flag here?? */
 		DBG_88E("[%s] Got Provisioning Discovery Response Frame\n", __func__);
 		/*	Commented by Albert 20110426 */
-		/*	The restore timer is enabled when issuing the provisioing request frame in rtw_p2p_prov_disc function. */
+		/*	The restore timer is enabled when issuing the provisioning request frame in rtw_p2p_prov_disc function. */
 		_cancel_timer_ex(&pwdinfo->restore_p2p_state_timer);
 		rtw_p2p_set_state(pwdinfo, P2P_STATE_RX_PROVISION_DIS_RSP);
 		process_p2p_provdisc_resp(pwdinfo, pframe);
@@ -4300,7 +4300,7 @@ struct xmit_frame *alloc_mgtxmitframe(struct xmit_priv *pxmitpriv)
 
 /****************************************************************************
 
-Following are some TX fuctions for WiFi MLME
+Following are some TX functions for WiFi MLME
 
 *****************************************************************************/
 
@@ -4951,7 +4951,7 @@ int issue_probereq_ex(struct adapter *padapter, struct ndis_802_11_ssid *pssid,
 	return ret;
 }
 
-/*  if psta == NULL, indiate we are station(client) now... */
+/*  if psta == NULL, indicate we are station(client) now... */
 void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short status)
 {
 	struct xmit_frame *pmgntframe;
@@ -5394,7 +5394,7 @@ void issue_assocreq(struct adapter *padapter)
 				if (!padapter->registrypriv.wifi_spec) {
 					/* Commented by Kurt 20110629 */
 					/* In some older APs, WPS handshake */
-					/* would be fail if we append vender extensions informations to AP */
+					/* would be fail if we append vendor extensions information to AP */
 					if (!memcmp(pIE->data, WPS_OUI, 4))
 						pIE->Length = 14;
 				}
@@ -5555,7 +5555,7 @@ void issue_assocreq(struct adapter *padapter)
 	return;
 }
 
-/* when wait_ack is ture, this function shoule be called at process context */
+/* when wait_ack is true, this function should be called at process context */
 static int _issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned int power_mode, int wait_ack)
 {
 	int ret = _FAIL;
@@ -5624,7 +5624,7 @@ static int _issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned
 	return ret;
 }
 
-/* when wait_ms > 0 , this function shoule be called at process context */
+/* when wait_ms > 0 , this function should be called at process context */
 /* da == NULL for station mode */
 int issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned int power_mode, int try_cnt, int wait_ms)
 {
@@ -5634,7 +5634,7 @@ int issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned int pow
 	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
 	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
 
-	/* da == NULL, assum it's null data for sta to ap*/
+	/* da == NULL, assume it's null data for sta to ap*/
 	if (da == NULL)
 		da = get_my_bssid(&(pmlmeinfo->network));
 
@@ -5669,7 +5669,7 @@ int issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned int pow
 	return ret;
 }
 
-/* when wait_ack is ture, this function shoule be called at process context */
+/* when wait_ack is true, this function should be called at process context */
 static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16 tid, int wait_ack)
 {
 	int ret = _FAIL;
@@ -5747,7 +5747,7 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16
 	return ret;
 }
 
-/* when wait_ms > 0 , this function shoule be called at process context */
+/* when wait_ms > 0 , this function should be called at process context */
 /* da == NULL for station mode */
 int issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16 tid, int try_cnt, int wait_ms)
 {
@@ -5757,7 +5757,7 @@ int issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16 tid, int
 	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
 	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
 
-	/* da == NULL, assum it's null data for sta to ap*/
+	/* da == NULL, assume it's null data for sta to ap*/
 	if (da == NULL)
 		da = get_my_bssid(&(pmlmeinfo->network));
 
@@ -6301,7 +6301,7 @@ unsigned int send_beacon(struct adapter *padapter)
 
 /****************************************************************************
 
-Following are some utitity fuctions for WiFi MLME
+Following are some utility functions for WiFi MLME
 
 *****************************************************************************/
 
@@ -6414,7 +6414,7 @@ void site_survey(struct adapter *padapter)
 		{
 			/*  20100721:Interrupt scan operation here. */
 			/*  For SW antenna diversity before link, it needs to switch to another antenna and scan again. */
-			/*  It compares the scan result and select beter one to do connection. */
+			/*  It compares the scan result and select better one to do connection. */
 			if (rtw_hal_antdiv_before_linked(padapter)) {
 				pmlmeext->sitesurvey_res.bss_cnt = 0;
 				pmlmeext->sitesurvey_res.channel_idx = -1;
@@ -6645,7 +6645,7 @@ void start_create_ibss(struct adapter *padapter)
 	/* update wireless mode */
 	update_wireless_mode(padapter);
 
-	/* udpate capability */
+	/* update capability */
 	caps = rtw_get_capability((struct wlan_bssid_ex *)pnetwork);
 	update_capinfo(padapter, caps);
 	if (caps&cap_IBSS) {/* adhoc master */
@@ -6700,7 +6700,7 @@ void start_clnt_join(struct adapter *padapter)
 	/* update wireless mode */
 	update_wireless_mode(padapter);
 
-	/* udpate capability */
+	/* update capability */
 	caps = rtw_get_capability((struct wlan_bssid_ex *)pnetwork);
 	update_capinfo(padapter, caps);
 	if (caps&cap_ESS) {
@@ -7313,7 +7313,7 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 	/* BCN interval */
 	rtw_hal_set_hwreg(padapter, HW_VAR_BEACON_INTERVAL, (u8 *)(&pmlmeinfo->bcn_interval));
 
-	/* udpate capability */
+	/* update capability */
 	update_capinfo(padapter, pmlmeinfo->capability);
 
 	/* WMM, Update EDCA param */
diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index 1b4e9bbc394b..e610d3dfbafb 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -389,7 +389,7 @@ s32 mp_start_test(struct adapter *padapter)
 		goto end_of_mp_start_test;
 	}
 
-	/* 3 3. join psudo AdHoc */
+	/* 3 3. join pseudo AdHoc */
 	tgt_network->join_res = 1;
 	tgt_network->aid = 1;
 	psta->aid = 1;
@@ -425,7 +425,7 @@ void mp_stop_test(struct adapter *padapter)
 		if (check_fwstate(pmlmepriv, WIFI_MP_STATE) == false)
 			goto end_of_mp_stop_test;
 
-		/* 3 1. disconnect psudo AdHoc */
+		/* 3 1. disconnect pseudo AdHoc */
 		rtw_indicate_disconnect(padapter);
 
 		/* 3 2. clear psta used in mp test mode. */
diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index d67eeb045002..0755ce765df2 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -512,7 +512,7 @@ inline void rtw_set_ips_deny(struct adapter *padapter, u32 ms)
 /*
 * rtw_pwr_wakeup - Wake the NIC up from: 1)IPS. 2)USB autosuspend
 * @adapter: pointer to struct adapter structure
-* @ips_deffer_ms: the ms wiil prevent from falling into IPS after wakeup
+* @ips_deffer_ms: the ms will prevent from falling into IPS after wakeup
 * Return _SUCCESS or _FAIL
 */
 
diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 610cc699caf9..9df1a615d076 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -398,7 +398,7 @@ static int recvframe_chkmic(struct adapter *adapter,  struct recv_frame *precvfr
 					 *(pframemic-10), *(pframemic-9)));
 				{
 					uint i;
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n ======demp packet (len=%d)======\n", precvframe->len));
+					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n ====== temp packet (len=%d)======\n", precvframe->len));
 					for (i = 0; i < precvframe->len; i = i+8) {
 						RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x:0x%02x",
 							 *(precvframe->rx_data+i), *(precvframe->rx_data+i+1),
@@ -406,7 +406,7 @@ static int recvframe_chkmic(struct adapter *adapter,  struct recv_frame *precvfr
 							 *(precvframe->rx_data+i+4), *(precvframe->rx_data+i+5),
 							 *(precvframe->rx_data+i+6), *(precvframe->rx_data+i+7)));
 					}
-					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n ====== demp packet end [len=%d]======\n", precvframe->len));
+					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n ====== temp packet end [len=%d]======\n", precvframe->len));
 					RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("\n hrdlen=%d,\n", prxattrib->hdrlen));
 				}
 
@@ -884,7 +884,7 @@ static int ap2sta_data_frame (
 		/*  */
 
 		if (GetFrameSubType(ptr) & BIT(6)) {
-			/* No data, will not indicate to upper layer, temporily count it here */
+			/* No data, will not indicate to upper layer, temporarily count it here */
 			count_rx_stats(adapter, precv_frame, *psta);
 			ret = RTW_RX_HANDLED;
 			goto exit;
@@ -964,7 +964,7 @@ static int sta2ap_data_frame(struct adapter *adapter,
 		}
 
 		if (GetFrameSubType(ptr) & BIT(6)) {
-			/* No data, will not indicate to upper layer, temporily count it here */
+			/* No data, will not indicate to upper layer, temporarily count it here */
 			count_rx_stats(adapter, precv_frame, *psta);
 			ret = RTW_RX_HANDLED;
 			goto exit;
@@ -1077,7 +1077,7 @@ static int validate_recv_ctrl_frame(struct adapter *padapter,
 				if (psta->sleepq_len == 0) {
 					pstapriv->tim_bitmap &= ~BIT(psta->aid);
 
-					/* upate BCN for TIM IE */
+					/* update BCN for TIM IE */
 					/* update_BCNTIM(padapter); */
 					update_beacon(padapter, _TIM_IE_, NULL, false);
 				}
@@ -1095,7 +1095,7 @@ static int validate_recv_ctrl_frame(struct adapter *padapter,
 
 					pstapriv->tim_bitmap &= ~BIT(psta->aid);
 
-					/* upate BCN for TIM IE */
+					/* update BCN for TIM IE */
 					/* update_BCNTIM(padapter); */
 					update_beacon(padapter, _TIM_IE_, NULL, false);
 				}
@@ -1579,7 +1579,7 @@ struct recv_frame *recvframe_chk_defrag(struct adapter *padapter, struct recv_fr
 			phead = get_list_head(pdefrag_q);
 			list_add_tail(&pfhdr->list, phead);
 
-			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("Enqueuq: ismfrag=%d, fragnum=%d\n", ismfrag, fragnum));
+			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("Enqueue: ismfrag=%d, fragnum=%d\n", ismfrag, fragnum));
 
 			prtnframe = NULL;
 		} else {
@@ -2183,13 +2183,13 @@ void rtw_signal_stat_timer_hdl(struct timer_list *t)
 	} else {
 		if (recvpriv->signal_strength_data.update_req == 0) {/*  update_req is clear, means we got rx */
 			avg_signal_strength = recvpriv->signal_strength_data.avg_val;
-			/*  after avg_vals are accquired, we can re-stat the signal values */
+			/*  after avg_vals are acquired, we can re-stat the signal values */
 			recvpriv->signal_strength_data.update_req = 1;
 		}
 
 		if (recvpriv->signal_qual_data.update_req == 0) {/*  update_req is clear, means we got rx */
 			avg_signal_qual = recvpriv->signal_qual_data.avg_val;
-			/*  after avg_vals are accquired, we can re-stat the signal values */
+			/*  after avg_vals are acquired, we can re-stat the signal values */
 			recvpriv->signal_qual_data.update_req = 1;
 		}
 
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 4a5393184737..6fa46f769f16 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -53,7 +53,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	sema_init(&pxmitpriv->terminate_xmitthread_sema, 0);
 
 	/*
-	Please insert all the queue initializaiton using _rtw_init_queue below
+	Please insert all the queue initialization using _rtw_init_queue below
 	*/
 
 	pxmitpriv->adapter = padapter;
@@ -1076,7 +1076,7 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 		}
 
 		if (bmcst) {
-			/*  don't do fragment to broadcat/multicast packets */
+			/*  don't do fragment to broadcast/multicast packets */
 			mem_sz = _rtw_pktfile_read(&pktfile, pframe, pattrib->pktlen);
 		} else {
 			mem_sz = _rtw_pktfile_read(&pktfile, pframe, mpdu_len);
@@ -1934,7 +1934,7 @@ int xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fra
 			pstapriv->tim_bitmap |= BIT(0);/*  */
 			pstapriv->sta_dz_bitmap |= BIT(0);
 
-			update_beacon(padapter, _TIM_IE_, NULL, false);/* tx bc/mc packets after upate bcn */
+			update_beacon(padapter, _TIM_IE_, NULL, false);/* tx bc/mc packets after update bcn */
 
 			ret = true;
 		}
@@ -1984,7 +1984,7 @@ int xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fra
 				pstapriv->tim_bitmap |= BIT(psta->aid);
 
 				if (psta->sleepq_len == 1) {
-					/* upate BCN for TIM IE */
+					/* update BCN for TIM IE */
 					update_beacon(padapter, _TIM_IE_, NULL, false);
 				}
 			}
@@ -2253,7 +2253,7 @@ void xmit_delivery_enabled_frames(struct adapter *padapter, struct sta_info *pst
 		if ((psta->sleepq_ac_len == 0) && (!psta->has_legacy_ac) && (wmmps_ac)) {
 			pstapriv->tim_bitmap &= ~BIT(psta->aid);
 
-			/* upate BCN for TIM IE */
+			/* update BCN for TIM IE */
 			update_beacon(padapter, _TIM_IE_, NULL, false);
 		}
 	}
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
index f90827577059..c8ec82dfb3cf 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
@@ -194,9 +194,9 @@ enum HAL_STATUS ODM_ReadAndConfig_AGC_TAB_1T_8188E(struct odm_dm_struct *dm_odm)
 	biol = rtw_IOL_applied(adapter);
 
 	if (biol) {
-		pxmit_frame = rtw_IOL_accquire_xmit_frame(adapter);
+		pxmit_frame = rtw_IOL_acquire_xmit_frame(adapter);
 		if (pxmit_frame == NULL) {
-			pr_info("rtw_IOL_accquire_xmit_frame failed\n");
+			pr_info("rtw_IOL_acquire_xmit_frame failed\n");
 			return HAL_STATUS_FAILURE;
 		}
 	}
@@ -473,9 +473,9 @@ enum HAL_STATUS ODM_ReadAndConfig_PHY_REG_1T_8188E(struct odm_dm_struct *dm_odm)
 	biol = rtw_IOL_applied(adapter);
 
 	if (biol) {
-		pxmit_frame = rtw_IOL_accquire_xmit_frame(adapter);
+		pxmit_frame = rtw_IOL_acquire_xmit_frame(adapter);
 		if (pxmit_frame == NULL) {
-			pr_info("rtw_IOL_accquire_xmit_frame failed\n");
+			pr_info("rtw_IOL_acquire_xmit_frame failed\n");
 			return HAL_STATUS_FAILURE;
 		}
 	}
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
index 06ef2c04cebf..63ffd0115ed7 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
@@ -152,9 +152,9 @@ enum HAL_STATUS ODM_ReadAndConfig_MAC_REG_8188E(struct odm_dm_struct *dm_odm)
 	biol = rtw_IOL_applied(adapt);
 
 	if (biol) {
-		pxmit_frame = rtw_IOL_accquire_xmit_frame(adapt);
+		pxmit_frame = rtw_IOL_acquire_xmit_frame(adapt);
 		if (pxmit_frame == NULL) {
-			pr_info("rtw_IOL_accquire_xmit_frame failed\n");
+			pr_info("rtw_IOL_acquire_xmit_frame failed\n");
 			return HAL_STATUS_FAILURE;
 		}
 	}
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
index 7659b0953100..8eecf0f81614 100644
--- a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
@@ -162,9 +162,9 @@ enum HAL_STATUS ODM_ReadAndConfig_RadioA_1T_8188E(struct odm_dm_struct *pDM_Odm)
 	biol = rtw_IOL_applied(Adapter);
 
 	if (biol) {
-		pxmit_frame = rtw_IOL_accquire_xmit_frame(Adapter);
+		pxmit_frame = rtw_IOL_acquire_xmit_frame(Adapter);
 		if (pxmit_frame == NULL) {
-			pr_info("rtw_IOL_accquire_xmit_frame failed\n");
+			pr_info("rtw_IOL_acquire_xmit_frame failed\n");
 			return HAL_STATUS_FAILURE;
 		}
 	}
diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 166adaac371a..11621092e248 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -69,7 +69,7 @@ void ODM_TxPwrTrackAdjust88E(struct odm_dm_struct *dm_odm, u8 Type,/*  0 = OFDM,
 /*-----------------------------------------------------------------------------
  * Function:	odm_TxPwrTrackSetPwr88E()
  *
- * Overview:	88E change all channel tx power accordign to flag.
+ * Overview:	88E change all channel tx power according to flag.
  *				OFDM & CCK are all different.
  *
  * Input:		NONE
diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 0bc836311036..8e0743339d18 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -294,7 +294,7 @@ void ODM_CmnInfoInit(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def Cmn
 
 	/*  Tx power tracking BB swing table. */
 	/*  The base index = 12. +((12-n)/2)dB 13~?? = decrease tx pwr by -((n-12)/2)dB */
-	pDM_Odm->BbSwingIdxOfdm			= 12; /*  Set defalut value as index 12. */
+	pDM_Odm->BbSwingIdxOfdm			= 12; /*  Set default value as index 12. */
 	pDM_Odm->BbSwingIdxOfdmCurrent	= 12;
 	pDM_Odm->BbSwingFlagOfdm		= false;
 }
@@ -869,7 +869,7 @@ void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm)
 		FalseAlmCnt->Cnt_Cck_fail = ODM_GetBBReg(pDM_Odm, ODM_REG_CCK_FA_11AC, bMaskLWord);
 		FalseAlmCnt->Cnt_all = FalseAlmCnt->Cnt_Ofdm_fail + FalseAlmCnt->Cnt_Cck_fail;
 
-		/*  reset OFDM FA coutner */
+		/*  reset OFDM FA counter */
 		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RST_11AC, BIT17, 1);
 		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RST_11AC, BIT17, 0);
 		/*  reset CCK FA counter */
@@ -950,7 +950,7 @@ void odm_DynamicBBPowerSaving(struct odm_dm_struct *pDM_Odm)
 		odm_1R_CCA(pDM_Odm);
 	} else {
 	/*  20100628 Joseph: Turn off BB power save for 88CE because it makesthroughput unstable. */
-	/*  20100831 Joseph: Turn ON BB power save again after modifying AGC delay from 900ns ot 600ns. */
+	/*  20100831 Joseph: Turn ON BB power save again after modifying AGC delay from 900ns to 600ns. */
 	/* 1 3.Power Saving for 88C */
 		ODM_RF_Saving(pDM_Odm, false);
 	}
diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index 5f29535590cd..e944373b9f3f 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -117,7 +117,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 
 		dm_odm->PhyDbgInfo.NumQryPhyStatusCCK++;
 		/*  (1)Hardware does not provide RSSI for CCK */
-		/*  (2)PWDB, Average PWDB cacluated by hardware (for rate adaptive) */
+		/*  (2)PWDB, Average PWDB calculated by hardware (for rate adaptive) */
 
 		cck_highpwr = dm_odm->bCckHighPower;
 
@@ -305,7 +305,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 				}
 			}
 		}
-		/*  (2)PWDB, Average PWDB cacluated by hardware (for rate adaptive) */
+		/*  (2)PWDB, Average PWDB calculated by hardware (for rate adaptive) */
 		rx_pwr_all = (((pPhyStaRpt->cck_sig_qual_ofdm_pwdb_all) >> 1) & 0x7f) - 110;
 
 		PWDB_ALL = odm_QueryRxPwrPercentage(rx_pwr_all);
diff --git a/drivers/staging/r8188eu/hal/odm_RTL8188E.c b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
index 62219a908097..4258987ae48f 100644
--- a/drivers/staging/r8188eu/hal/odm_RTL8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
@@ -254,7 +254,7 @@ static void odm_HWAntDiv(struct odm_dm_struct *dm_odm)
 	for (i = 0; i < ODM_ASSOCIATE_ENTRY_NUM; i++) {
 		pEntry = dm_odm->pODM_StaInfo[i];
 		if (IS_STA_VALID(pEntry)) {
-			/* 2 Caculate RSSI per Antenna */
+			/* 2 Calculate RSSI per Antenna */
 			Main_RSSI = (dm_fat_tbl->MainAnt_Cnt[i] != 0) ? (dm_fat_tbl->MainAnt_Sum[i]/dm_fat_tbl->MainAnt_Cnt[i]) : 0;
 			Aux_RSSI = (dm_fat_tbl->AuxAnt_Cnt[i] != 0) ? (dm_fat_tbl->AuxAnt_Sum[i]/dm_fat_tbl->AuxAnt_Cnt[i]) : 0;
 			TargetAnt = (Main_RSSI >= Aux_RSSI) ? MAIN_ANT : AUX_ANT;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index 4bd471873531..9040f339ec99 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -651,7 +651,7 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 		rtw_write8(adapt, REG_BCN_CTRL, rtw_read8(adapt, REG_BCN_CTRL)&(~BIT(4)));
 
 		/*  To make sure that if there exists an adapter which would like to send beacon. */
-		/*  If exists, the origianl value of 0x422[6] will be 1, we should check this to */
+		/*  If exists, the original value of 0x422[6] will be 1, we should check this to */
 		/*  prevent from setting 0x422[6] to 0 after download reserved page, or it will cause */
 		/*  the beacon cannot be sent by HW. */
 		/*  2010.06.23. Added by tynli. */
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index 0e264c39d636..fa21bd29a7af 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -151,7 +151,7 @@ void rtl8188e_HalDmWatchDog(struct adapter *Adapter)
 	rtw_hal_get_hwreg(Adapter, HW_VAR_FWLPS_RF_ON, (u8 *)(&fw_ps_awake));
 
 	/*  Fw is under p2p powersaving mode, driver should stop dynamic mechanism. */
-	/*  modifed by thomas. 2011.06.11. */
+	/*  modified by thomas. 2011.06.11. */
 	if (Adapter->wdinfo.p2p_ps_mode)
 		fw_ps_awake = false;
 
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 1a7a62dd8504..5934fb377954 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -591,7 +591,7 @@ static int load_firmware(struct rt_firmware *pFirmware, struct device *device)
 	memcpy(pFirmware->szFwBuffer, fw->data, fw->size);
 	pFirmware->ulFwLength = fw->size;
 	release_firmware(fw);
-	DBG_88E_LEVEL(_drv_info_, "+%s: !bUsedWoWLANFw, FmrmwareLen:%d+\n", __func__, pFirmware->ulFwLength);
+	DBG_88E_LEVEL(_drv_info_, "+%s: !bUsedWoWLANFw, FirmwareLen:%d+\n", __func__, pFirmware->ulFwLength);
 
 Exit:
 	return rtStatus;
@@ -739,7 +739,7 @@ hal_EfusePowerSwitch_RTL8188E(
 	if (PwrState) {
 		rtw_write8(pAdapter, REG_EFUSE_ACCESS, EFUSE_ACCESS_ON);
 
-		/*  1.2V Power: From VDDON with Power Cut(0x0000h[15]), defualt valid */
+		/*  1.2V Power: From VDDON with Power Cut(0x0000h[15]), default valid */
 		tmpV16 = rtw_read16(pAdapter, REG_SYS_ISO_CTRL);
 		if (!(tmpV16 & PWC_EV12V)) {
 			tmpV16 |= PWC_EV12V;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 37f2342ddbaa..3ea59b22ef7d 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -56,7 +56,7 @@ static	u32 phy_CalculateBitShift(u32 BitMask)
 /**
 * Function:	PHY_QueryBBReg
 *
-* OverView:	Read "sepcific bits" from BB register
+* OverView:	Read "specific bits" from BB register
 *
 * Input:
 *			struct adapter *Adapter,
@@ -119,7 +119,7 @@ void rtl8188e_PHY_SetBBReg(struct adapter *Adapter, u32 RegAddr, u32 BitMask, u3
 /**
 * Function:	phy_RFSerialRead
 *
-* OverView:	Read regster from RF chips
+* OverView:	Read register from RF chips
 *
 * Input:
 *			struct adapter *Adapter,
@@ -128,7 +128,7 @@ void rtl8188e_PHY_SetBBReg(struct adapter *Adapter, u32 RegAddr, u32 BitMask, u3
 *
 * Output:	None
 * Return:		u32			reback value
-* Note:		Threre are three types of serial operations:
+* Note:		There are three types of serial operations:
 *			1. Software serial write
 *			2. Hardware LSSI-Low Speed Serial Interface
 *			3. Hardware HSSI-High speed
@@ -204,7 +204,7 @@ phy_RFSerialRead(
 *
 * Output:	None
 * Return:		None
-* Note:		Threre are three types of serial operations:
+* Note:		There are three types of serial operations:
 *			1. Software serial write
 *			2. Hardware LSSI-Low Speed Serial Interface
 *			3. Hardware HSSI-High speed
@@ -340,7 +340,7 @@ rtl8188e_PHY_SetRFReg(
 /*-----------------------------------------------------------------------------
  * Function:    PHY_MACConfig8192C
  *
- * Overview:	Condig MAC by header file or parameter file.
+ * Overview:	Config MAC by header file or parameter file.
  *
  * Input:       NONE
  *
@@ -409,7 +409,7 @@ phy_InitBBRFRegisterDefinition(
 	pHalData->PHYRegDef[RF_PATH_A].rfintfe = rFPGA0_XA_RFInterfaceOE; /*  16 MSBs if read 32-bit from 0x860 (16-bit for 0x862) */
 	pHalData->PHYRegDef[RF_PATH_B].rfintfe = rFPGA0_XB_RFInterfaceOE; /*  16 MSBs if read 32-bit from 0x864 (16-bit for 0x866) */
 
-	/* Addr of LSSI. Wirte RF register by driver */
+	/* Addr of LSSI. Write RF register by driver */
 	pHalData->PHYRegDef[RF_PATH_A].rf3wireOffset = rFPGA0_XA_LSSIParameter; /* LSSI Parameter */
 	pHalData->PHYRegDef[RF_PATH_B].rf3wireOffset = rFPGA0_XB_LSSIParameter;
 
@@ -425,11 +425,11 @@ phy_InitBBRFRegisterDefinition(
 	pHalData->PHYRegDef[RF_PATH_C].rfTxGainStage = rFPGA0_TxGainStage; /* Tx gain stage */
 	pHalData->PHYRegDef[RF_PATH_D].rfTxGainStage = rFPGA0_TxGainStage; /* Tx gain stage */
 
-	/*  Tranceiver A~D HSSI Parameter-1 */
+	/*  Transceiver A~D HSSI Parameter-1 */
 	pHalData->PHYRegDef[RF_PATH_A].rfHSSIPara1 = rFPGA0_XA_HSSIParameter1;  /* wire control parameter1 */
 	pHalData->PHYRegDef[RF_PATH_B].rfHSSIPara1 = rFPGA0_XB_HSSIParameter1;  /* wire control parameter1 */
 
-	/*  Tranceiver A~D HSSI Parameter-2 */
+	/*  Transceiver A~D HSSI Parameter-2 */
 	pHalData->PHYRegDef[RF_PATH_A].rfHSSIPara2 = rFPGA0_XA_HSSIParameter2;  /* wire control parameter2 */
 	pHalData->PHYRegDef[RF_PATH_B].rfHSSIPara2 = rFPGA0_XB_HSSIParameter2;  /* wire control parameter2 */
 
@@ -475,13 +475,13 @@ phy_InitBBRFRegisterDefinition(
 	pHalData->PHYRegDef[RF_PATH_C].rfTxAFE = rOFDM0_XCTxAFE;
 	pHalData->PHYRegDef[RF_PATH_D].rfTxAFE = rOFDM0_XDTxAFE;
 
-	/*  Tranceiver LSSI Readback SI mode */
+	/*  Transceiver LSSI Readback SI mode */
 	pHalData->PHYRegDef[RF_PATH_A].rfLSSIReadBack = rFPGA0_XA_LSSIReadBack;
 	pHalData->PHYRegDef[RF_PATH_B].rfLSSIReadBack = rFPGA0_XB_LSSIReadBack;
 	pHalData->PHYRegDef[RF_PATH_C].rfLSSIReadBack = rFPGA0_XC_LSSIReadBack;
 	pHalData->PHYRegDef[RF_PATH_D].rfLSSIReadBack = rFPGA0_XD_LSSIReadBack;
 
-	/*  Tranceiver LSSI Readback PI mode */
+	/*  Transceiver LSSI Readback PI mode */
 	pHalData->PHYRegDef[RF_PATH_A].rfLSSIReadBackPi = TransceiverA_HSPI_Readback;
 	pHalData->PHYRegDef[RF_PATH_B].rfLSSIReadBackPi = TransceiverB_HSPI_Readback;
 }
@@ -727,7 +727,7 @@ static int phy_TxPwrIdxToDbm(struct adapter *Adapter, enum wireless_mode Wireles
 /*-----------------------------------------------------------------------------
  * Function:    GetTxPowerLevel8190()
  *
- * Overview:    This function is export to "common" moudule
+ * Overview:    This function is export to "common" module
  *
  * Input:       struct adapter *Adapter
  *			psByte			Power Level
@@ -859,7 +859,7 @@ static void phy_PowerIndexCheck88E(struct adapter *Adapter, u8 channel, u8 *cckP
 /*-----------------------------------------------------------------------------
  * Function:    SetTxPowerLevel8190()
  *
- * Overview:    This function is export to "HalCommon" moudule
+ * Overview:    This function is export to "HalCommon" module
  *			We must consider RF path later!!!!!!!
  *
  * Input:       struct adapter *Adapter
@@ -1042,7 +1042,7 @@ _PHY_SetBWMode92C(
  /*-----------------------------------------------------------------------------
  * Function:   SetBWMode8190Pci()
  *
- * Overview:  This function is export to "HalCommon" moudule
+ * Overview:  This function is export to "HalCommon" module
  *
  * Input:		struct adapter *Adapter
  *			enum ht_channel_width Bandwidth	20M or 40M
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index e44a01af7f5c..0db6de19b815 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -68,7 +68,7 @@ void rtl8188e_fill_fake_txdesc(struct adapter *adapt, u8 *desc, u32 BufferLen, u
 	/* offset 4 */
 	ptxdesc->txdw1 |= cpu_to_le32((QSLT_MGNT<<QSEL_SHT)&0x00001f00); /*  Fixed queue of Mgnt queue */
 
-	/* Set NAVUSEHDR to prevent Ps-poll AId filed to be changed to error vlaue by Hw. */
+	/* Set NAVUSEHDR to prevent Ps-poll AId filed to be changed to error value by Hw. */
 	if (ispspoll) {
 		ptxdesc->txdw1 |= cpu_to_le32(NAVUSEHDR);
 	} else {
@@ -318,7 +318,7 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 	/*  (1) The sequence number of each non-Qos frame / broadcast / multicast / */
 	/*  mgnt frame should be controlled by Hw because Fw will also send null data */
 	/*  which we cannot control when Fw LPS enable. */
-	/*  --> default enable non-Qos data sequense number. 2010.06.23. by tynli. */
+	/*  --> default enable non-Qos data sequence number. 2010.06.23. by tynli. */
 	/*  (2) Enable HW SEQ control for beacon packet, because we use Hw beacon. */
 	/*  (3) Use HW Qos SEQ to control the seq num of Ext port non-Qos packets. */
 	/*  2010.06.23. Added by tynli. */
@@ -406,7 +406,7 @@ static u32 xmitframe_need_length(struct xmit_frame *pxmitframe)
 
 	u32 len = 0;
 
-	/*  no consider fragement */
+	/*  no consider fragment */
 	len = pattrib->hdrlen + pattrib->iv_len +
 		SNAP_SIZE + sizeof(u16) +
 		pattrib->pktlen +
@@ -612,7 +612,7 @@ static s32 xmitframe_direct(struct adapter *adapt, struct xmit_frame *pxmitframe
 	if (res == _SUCCESS)
 		rtw_dump_xframe(adapt, pxmitframe);
 	else
-		DBG_88E("==> %s xmitframe_coalsece failed\n", __func__);
+		DBG_88E("==> %s xmitframe_coalesce failed\n", __func__);
 	return res;
 }
 
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index d985894c0f30..d6d5c00cd161 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -164,7 +164,7 @@ static void _InitQueueReservedPage(struct adapter *Adapter)
 		if (haldata->OutEpQueueSel & TX_SELE_LQ)
 			numLQ = 0x1C;
 
-		/*  NOTE: This step shall be proceed before writting REG_RQPN. */
+		/*  NOTE: This step shall be proceed before writing REG_RQPN. */
 		if (haldata->OutEpQueueSel & TX_SELE_NQ)
 			numNQ = 0x1C;
 		value8 = (u8)_NPQ(numNQ);
@@ -598,7 +598,7 @@ static void _InitBeaconParameters(struct adapter *Adapter)
 	rtw_write8(Adapter, REG_BCNDMATIM, BCN_DMA_ATIME_INT_TIME); /*  2ms */
 
 	/*  Suggested by designer timchen. Change beacon AIFS to the largest number */
-	/*  beacause test chip does not contension before sending beacon. by tynli. 2009.11.03 */
+	/*  because test chip does not contension before sending beacon. by tynli. 2009.11.03 */
 	rtw_write16(Adapter, REG_BCNTCFG, 0x660F);
 
 	haldata->RegBcnCtrlVal = rtw_read8(Adapter, REG_BCN_CTRL);
@@ -1022,7 +1022,7 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 }
 static void rtl8192cu_hw_power_down(struct adapter *adapt)
 {
-	/*  2010/-8/09 MH For power down module, we need to enable register block contrl reg at 0x1c. */
+	/*  2010/-8/09 MH For power down module, we need to enable register block control reg at 0x1c. */
 	/*  Then enable power down control bit of register 0x04 BIT4 and BIT15 as 1. */
 
 	/*  Enable register area 0x0-0xc. */
@@ -1255,7 +1255,7 @@ static void ResumeTxBeacon(struct adapter *adapt)
 {
 	struct hal_data_8188e *haldata = GET_HAL_DATA(adapt);
 
-	/*  2010.03.01. Marked by tynli. No need to call workitem beacause we record the value */
+	/*  2010.03.01. Marked by tynli. No need to call workitem because we record the value */
 	/*  which should be read from register to a global variable. */
 
 	rtw_write8(adapt, REG_FWHW_TXQ_CTRL+2, (haldata->RegFwHwTxQCtrl) | BIT6);
@@ -1269,7 +1269,7 @@ static void StopTxBeacon(struct adapter *adapt)
 {
 	struct hal_data_8188e *haldata = GET_HAL_DATA(adapt);
 
-	/*  2010.03.01. Marked by tynli. No need to call workitem beacause we record the value */
+	/*  2010.03.01. Marked by tynli. No need to call workitem because we record the value */
 	/*  which should be read from register to a global variable. */
 
 	rtw_write8(adapt, REG_FWHW_TXQ_CTRL+2, (haldata->RegFwHwTxQCtrl) & (~BIT6));
@@ -2254,7 +2254,7 @@ void rtl8188eu_set_hal_ops(struct adapter *adapt)
 
 	adapt->HalData = rtw_zmalloc(sizeof(struct hal_data_8188e));
 	if (adapt->HalData == NULL)
-		DBG_88E("cant not alloc memory for HAL DATA\n");
+		DBG_88E("can't alloc memory for HAL DATA\n");
 	adapt->hal_data_sz = sizeof(struct hal_data_8188e);
 
 	halfunc->hal_power_on = rtl8188eu_InitPowerOn;
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 577090db84be..dbe1e9722782 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -90,7 +90,7 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u8 request, u16 value, u
 
 		}
 
-		/*  firmware download is checksumed, don't retry */
+		/*  firmware download is checksummed, don't retry */
 		if ((value >= FW_8188E_START_ADDRESS && value <= FW_8188E_END_ADDRESS) || status == len)
 			break;
 	}
@@ -312,7 +312,7 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 
 	do {
 		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_,
-			 ("recvbuf2recvframe: rxdesc=offsset 0:0x%08x, 4:0x%08x, 8:0x%08x, C:0x%08x\n",
+			 ("recvbuf2recvframe: rxdesc=offset 0:0x%08x, 4:0x%08x, 8:0x%08x, C:0x%08x\n",
 			  prxstat->rxdw0, prxstat->rxdw1, prxstat->rxdw2, prxstat->rxdw4));
 
 		prxstat = (struct recv_stat *)pbuf;
@@ -346,7 +346,7 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 
 		if ((pattrib->pkt_len <= 0) || (pkt_offset > transfer_len)) {
 			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("recvbuf2recvframe: pkt_len<=0\n"));
-			DBG_88E("%s()-%d: RX Warning!,pkt_len<=0 or pkt_offset> transfoer_len\n", __func__, __LINE__);
+			DBG_88E("%s()-%d: RX Warning!,pkt_len<=0 or pkt_offset> transfer_len\n", __func__, __LINE__);
 			rtw_free_recvframe(precvframe, pfree_recv_queue);
 			goto _exit_recvbuf2recvframe;
 		}
diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
index 63b068fa9f4d..429e084a347e 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
@@ -93,7 +93,7 @@ enum RF_TYPE_8190P {
 	RF_8256 = 2,		/*  2 11b/g/n */
 	RF_8258 = 3,		/*  3 11a/b/g/n RF */
 	RF_6052 = 4,		/*  4 11b/g/n RF */
-	/*  TODO: We should remove this psudo PHY RF after we get new RF. */
+	/*  TODO: We should remove this pseudo PHY RF after we get new RF. */
 	RF_PSEUDO_11N = 5,	/*  5, It is a temporality RF. */
 };
 
@@ -209,7 +209,7 @@ void PHY_ScanOperationBackup8188E(struct adapter *Adapter, u8 Operation);
 void PHY_SetBWMode8188E(struct adapter *adapter,
 			enum ht_channel_width chnlwidth, unsigned char offset);
 
-/*  channel switch related funciton */
+/*  channel switch related function */
 void PHY_SwChnl8188E(struct adapter *adapter, u8 channel);
 /*  Call after initialization */
 void ChkFwCmdIoDone(struct adapter *adapter);
diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyReg.h b/drivers/staging/r8188eu/include/Hal8188EPhyReg.h
index 8b8c75a1f149..da2329be4474 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPhyReg.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPhyReg.h
@@ -92,7 +92,7 @@
 #define	rFPGA0_AdDaClockEn		0x888
 #define	rFPGA0_AnalogParameter4		0x88c
 
-#define	rFPGA0_XA_LSSIReadBack		0x8a0	/*  Tranceiver LSSI Readback */
+#define	rFPGA0_XA_LSSIReadBack		0x8a0	/*  Transceiver LSSI Readback */
 #define	rFPGA0_XB_LSSIReadBack		0x8a4
 #define	rFPGA0_XC_LSSIReadBack		0x8a8
 #define	rFPGA0_XD_LSSIReadBack		0x8ac
@@ -167,7 +167,7 @@
 
 /* RxIQ DC offset, Rx digital filter, DC notch filter */
 #define	rOFDM0_XARxAFE			0xc10
-#define	rOFDM0_XARxIQImbalance		0xc14  /* RxIQ imblance matrix */
+#define	rOFDM0_XARxIQImbalance		0xc14  /* RxIQ imbalance matrix */
 #define	rOFDM0_XBRxAFE			0xc18
 #define	rOFDM0_XBRxIQImbalance		0xc1c
 #define	rOFDM0_XCRxAFE			0xc20
diff --git a/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h b/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h
index 43f41e77a939..8e6a63fb91fb 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h
@@ -16,7 +16,7 @@
 	4: LPS--Low Power State
 	5: SUS--Suspend
 
-	The transision from different states are defined below
+	The transition from different states are defined below
 	TRANS_CARDEMU_TO_ACT
 	TRANS_ACT_TO_CARDEMU
 	TRANS_CARDEMU_TO_SUS
diff --git a/drivers/staging/r8188eu/include/HalPwrSeqCmd.h b/drivers/staging/r8188eu/include/HalPwrSeqCmd.h
index fe7ac910beb8..e4ef183b541f 100644
--- a/drivers/staging/r8188eu/include/HalPwrSeqCmd.h
+++ b/drivers/staging/r8188eu/include/HalPwrSeqCmd.h
@@ -13,7 +13,7 @@
      /*  offset: the read register offset */
      /*  msk: the mask of the read value */
      /*  value: N/A, left by 0 */
-     /*  note: dirver shall implement this function by read & msk */
+     /*  note: driver shall implement this function by read & msk */
 
 #define PWR_CMD_WRITE			0x01
      /*  offset: the read register offset */
diff --git a/drivers/staging/r8188eu/include/basic_types.h b/drivers/staging/r8188eu/include/basic_types.h
index 9c34e2dad6bb..9b2201339936 100644
--- a/drivers/staging/r8188eu/include/basic_types.h
+++ b/drivers/staging/r8188eu/include/basic_types.h
@@ -161,7 +161,7 @@ value to host byte ordering.*/
 		((((u8)__val) & BIT_LEN_MASK_8(__bitlen)) << (__bitoffset)) \
 		)
 
-/*  Get the N-bytes aligment offset from the current length */
+/*  Get the N-bytes alignment offset from the current length */
 #define	N_BYTE_ALIGMENT(__value, __aligment) ((__aligment == 1) ? \
 	(__value) : (((__value + __aligment - 1) / __aligment) * __aligment))
 
diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index 8cefb5c288f3..dad4d80ca4fe 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -208,10 +208,10 @@ enum driver_state {
 };
 
 struct adapter {
-	int	DriverState;/* for disable driver using module, use dongle toi
+	int	DriverState;/* for disable driver using module, use dongle to
 			     * replace module. */
 	int	pid[3];/* process id from UI, 0:wps, 1:hostapd, 2:dhcpcd */
-	int	bDongle;/* build-in module or external dongle */
+	int	bDongle;/* built-in module or external dongle */
 	u16	chip_type;
 	u16	HardwareType;
 	u16	interface_type;/* USB,SDIO,SPI,PCI */
diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index 4dfa817175e7..10e761099d10 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -896,7 +896,7 @@ enum ieee80211_state {
 	/* the association procedure is sending AUTH request*/
 	IEEE80211_ASSOCIATING_AUTHENTICATING,
 
-	/* the association procedure has successfully authentcated
+	/* the association procedure has successfully authenticated
 	 * and is sending association request
 	 */
 	IEEE80211_ASSOCIATING_AUTHENTICATED,
diff --git a/drivers/staging/r8188eu/include/mp_custom_oid.h b/drivers/staging/r8188eu/include/mp_custom_oid.h
index 7bcb857c795d..af42bc3b4000 100644
--- a/drivers/staging/r8188eu/include/mp_custom_oid.h
+++ b/drivers/staging/r8188eu/include/mp_custom_oid.h
@@ -12,7 +12,7 @@
 /*  */
 
 /*  by Owen for Production Kit */
-/*  For Production Kit with Agilent Equipments */
+/*  For Production Kit with Agilent Equipment */
 /*  in order to make our custom oids hopefully somewhat unique */
 /*  we will use 0xFF (indicating implementation specific OID) */
 /*	81(first byte of non zero Realtek unique identifier) */
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 2a6fd4072e00..b0b02b6d58ef 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -615,7 +615,7 @@ struct odm_ra_info {
 	u8 PTStopCount;	/* Stop PT counter */
 	u8 PTPreRate;	/*  if rate change do PT */
 	u8 PTPreRssi;	/*  if RSSI change 5% do PT */
-	u8 PTModeSS;	/*  decide whitch rate should do PT */
+	u8 PTModeSS;	/*  decide which rate should do PT */
 	u8 RAstage;	/*  StageRA, decide how many times RA will be done
 			 * between PT */
 	u8 PTSmoothFactor;
@@ -868,7 +868,7 @@ struct odm_dm_struct {
 	/*  Latest packet phy info (ODM write) */
 	struct odm_mac_status_info *pMacInfo;
 
-	/*  Different Team independt structure?? */
+	/*  Different Team independent structure?? */
 
 	/* ODM Structure */
 	struct fast_ant_train DM_FatTable;
diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index ac0bd5cd0f82..3becb998a0f0 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -195,11 +195,11 @@ enum {
 	MEM_STAT_PHY_ALLOC_SUCCESS,
 	MEM_STAT_PHY_ALLOC_FAIL,
 	MEM_STAT_PHY_FREE,
-	MEM_STAT_TX, /* used to distinguish TX/RX, asigned from caller */
+	MEM_STAT_TX, /* used to distinguish TX/RX, assigned from caller */
 	MEM_STAT_TX_ALLOC_SUCCESS,
 	MEM_STAT_TX_ALLOC_FAIL,
 	MEM_STAT_TX_FREE,
-	MEM_STAT_RX, /* used to distinguish TX/RX, asigned from caller */
+	MEM_STAT_RX, /* used to distinguish TX/RX, assigned from caller */
 	MEM_STAT_RX_ALLOC_SUCCESS,
 	MEM_STAT_RX_ALLOC_FAIL,
 	MEM_STAT_RX_FREE
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index ea879572d6e1..86ba80f46384 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -62,7 +62,7 @@
 /*  This structure must be careful with byte-ordering */
 
 struct rt_firmware_hdr {
-	/*  8-byte alinment required */
+	/*  8-byte alignment required */
 	/*  LONG WORD 0 ---- */
 	__le16		Signature;	/* 92C0: test chip; 92C,
 					 * 88C0: test chip; 88C1: MP A-cut;
@@ -178,7 +178,7 @@ struct txpowerinfo24g {
 /*  | 1byte|----8bytes----|1byte|--5bytes--| */
 /*  |         |            Reserved(14bytes)	      | */
 
-/*  PG data exclude header, dummy 6 bytes frome CP test and reserved 1byte. */
+/*  PG data exclude header, dummy 6 bytes from CP test and reserved 1byte. */
 #define EFUSE_OOB_PROTECT_BYTES			15
 
 #define		HWSET_MAX_SIZE_88E		512
@@ -196,7 +196,7 @@ struct txpowerinfo24g {
 /*  9bytes + 1byt + 5bytes and pre 1byte. */
 /*  For worst case: */
 /*  | 2byte|----8bytes----|1byte|--7bytes--| 92D */
-/*  PG data exclude header, dummy 7 bytes frome CP test and reserved 1byte. */
+/*  PG data exclude header, dummy 7 bytes from CP test and reserved 1byte. */
 #define		EFUSE_OOB_PROTECT_BYTES_88E	18
 #define		EFUSE_PROTECT_BYTES_BANK_88E	16
 
@@ -357,7 +357,7 @@ struct hal_data_8188e {
 	u8	OutEpQueueSel;
 	u8	OutEpNumber;
 
-	/*  Add for USB aggreation mode dynamic shceme. */
+	/*  Add for USB aggregation mode dynamic shceme. */
 	bool		UsbRxHighSpeedMode;
 
 	/*  2010/11/22 MH Add for slim combo debug mode selective. */
@@ -377,7 +377,7 @@ struct hal_data_8188e {
 
 	u32	UsbBulkOutSize;
 
-	/*  Interrupt relatd register information. */
+	/*  Interrupt related register information. */
 	u32	IntArray[3];/* HISR0,HISR1,HSISR */
 	u32	IntrMask[3];
 	u8	C2hArray[16];
diff --git a/drivers/staging/r8188eu/include/rtl8188e_spec.h b/drivers/staging/r8188eu/include/rtl8188e_spec.h
index 85e66d6ca2ba..27151f38a212 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_spec.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_spec.h
@@ -41,7 +41,7 @@
 #define BIT30	0x40000000
 #define BIT31	0x80000000
 
-/*        8192C Regsiter offset definition */
+/*        8192C Register offset definition */
 
 #define		HAL_PS_TIMER_INT_DELAY	50	/*   50 microseconds */
 #define		HAL_92C_NAV_UPPER_UNIT	128	/*  micro-second */
@@ -677,7 +677,7 @@ Current IOREG MAP
 /*  Note: */
 /* 	The bits of stopping AC(VO/VI/BE/BK) queue in datasheet
  *	RTL8192S/RTL8192C are wrong, */
-/* 	the correct arragement is VO - Bit0, VI - Bit1, BE - Bit2,
+/* 	the correct arrangement is VO - Bit0, VI - Bit1, BE - Bit2,
  *	and BK - Bit3. */
 /* 	8723 and 88E may be not correct either in the earlier version. */
 #define		StopBecon			BIT6
@@ -726,7 +726,7 @@ Current IOREG MAP
 
 #define REG_USB_HRPWM			0xFE58
 #define REG_USB_HCPWM			0xFE57
-/*        8192C Regsiter Bit and Content definition */
+/*        8192C Register Bit and Content definition */
 /* 	0x0000h ~ 0x00FFh	System Configuration */
 
 /* 2 SYS_ISO_CTRL */
@@ -1163,7 +1163,7 @@ Current IOREG MAP
 #define SDIO_REG_HCPWM1			0x0024
 /*  HCI Current Power Mode 2 */
 #define SDIO_REG_HCPWM2			0x0026
-/*  HTSF Informaion */
+/*  HTSF Information */
 #define SDIO_REG_HTSFR_INFO		0x0030
 /*  HCI Request Power Mode 1 */
 #define SDIO_REG_HRPWM1			0x0080
@@ -1375,7 +1375,7 @@ Current IOREG MAP
 #define EEPROM_Default_CrystalCap_88E		0x20
 #define	EEPROM_Default_ThermalMeter_88E		0x18
 
-/* New EFUSE deafult value */
+/* New EFUSE default value */
 #define		EEPROM_DEFAULT_24G_INDEX	0x2D
 #define		EEPROM_DEFAULT_24G_HT20_DIFF	0X02
 #define		EEPROM_DEFAULT_24G_OFDM_DIFF	0X04
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
index 0f64b72bb5de..9fb32cda5f9f 100644
--- a/drivers/staging/r8188eu/include/rtw_cmd.h
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -472,7 +472,7 @@ struct Tx_Beacon_param
 
 	mac[0] == 0
 	==> CMD mode, return H2C_SUCCESS.
-	The following condition must be ture under CMD mode
+	The following condition must be true under CMD mode
 		mac[1] == mac[4], mac[2] == mac[3], mac[0]=mac[5]= 0;
 		s0 == 0x1234, s1 == 0xabcd, w0 == 0x78563412, w1 == 0x5aa5def7;
 		s2 == (b1 << 8 | b0);
@@ -525,7 +525,7 @@ struct drvextra_cmd_parm {
 	unsigned char *pbuf;
 };
 
-/*------------------- Below are used for RF/BB tunning ---------------------*/
+/*------------------- Below are used for RF/BB tuning ---------------------*/
 
 struct	setantenna_parm {
 	u8	tx_antset;
@@ -730,7 +730,7 @@ struct TDLSoption_param
 Result:
 0x00: success
 0x01: success, and check Response.
-0x02: cmd ignored due to duplicated sequcne number
+0x02: cmd ignored due to duplicated sequence number
 0x03: cmd dropped due to invalid cmd code
 0x04: reserved.
 
diff --git a/drivers/staging/r8188eu/include/rtw_event.h b/drivers/staging/r8188eu/include/rtw_event.h
index 54dc1ea437fc..5d4bd0e49394 100644
--- a/drivers/staging/r8188eu/include/rtw_event.h
+++ b/drivers/staging/r8188eu/include/rtw_event.h
@@ -29,7 +29,7 @@ struct surveydone_event {
 };
 
 /*
-Used to report the link result of joinning the given bss
+Used to report the link result of joining the given bss
 
 join_res:
 -1: authentication fail
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index f1b3074fa075..5bb22d83c2de 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -76,7 +76,7 @@
 #define IO_RD_BURST(x)						\
 	(_IO_SYNC_ | _IO_BURST_ | ((x) & _IOSZ_MASK_))
 
-/* below is for the intf_option bit defition... */
+/* below is for the intf_option bit definition... */
 
 #define _INTF_ASYNC_	BIT(0)	/* support async io */
 
diff --git a/drivers/staging/r8188eu/include/rtw_iol.h b/drivers/staging/r8188eu/include/rtw_iol.h
index 471f9ca092a8..464b4118b222 100644
--- a/drivers/staging/r8188eu/include/rtw_iol.h
+++ b/drivers/staging/r8188eu/include/rtw_iol.h
@@ -30,7 +30,7 @@ enum ioreg_cmd {
 	IOREG_CMD_END		= 0xFF,
 };
 
-struct xmit_frame *rtw_IOL_accquire_xmit_frame(struct adapter *adapter);
+struct xmit_frame *rtw_IOL_acquire_xmit_frame(struct adapter *adapter);
 int rtw_IOL_append_cmds(struct xmit_frame *xmit_frame, u8 *IOL_cmds,
 			u32 cmd_len);
 int rtw_IOL_append_LLT_cmd(struct xmit_frame *xmit_frame, u8 page_boundary);
diff --git a/drivers/staging/r8188eu/include/rtw_led.h b/drivers/staging/r8188eu/include/rtw_led.h
index f0965aa5b470..08153d42ba2d 100644
--- a/drivers/staging/r8188eu/include/rtw_led.h
+++ b/drivers/staging/r8188eu/include/rtw_led.h
@@ -67,9 +67,8 @@ enum LED_STATE_871x {
 	LED_BLINK_SCAN = 6, /*  LED is blinking during scanning period,
 			     * the # of times to blink is depend on time
 			     * for scanning. */
-	LED_BLINK_NO_LINK = 7, /*  LED is blinking during no link state. */
-	LED_BLINK_StartToBlink = 8,/*  Customzied for Sercomm Printer
-				    * Server case */
+	LED_BLINK_NO_LINK = 7, /* LED is blinking during no link state. */
+	LED_BLINK_StartToBlink = 8, /* Customized for Sercomm Printer Server case */
 	LED_BLINK_TXRX = 9,
 	LED_BLINK_WPS = 10,	/*  LED is blinkg during WPS communication */
 	LED_BLINK_WPS_STOP = 11,	/* for ALPHA */
diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index 8c54da73f1a7..71149089d07a 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -182,7 +182,7 @@ struct wifidirect_info {
 	struct timer_list find_phase_timer;
 	struct timer_list restore_p2p_state_timer;
 
-	/* Used to do the scanning. After confirming the peer is availalble,
+	/* Used to do the scanning. After confirming the peer is available,
 	 * the driver transmits the P2P frame to peer. */
 	struct timer_list pre_tx_scan_timer;
 	struct timer_list reset_ch_sitesurvey;
@@ -226,7 +226,7 @@ struct wifidirect_info {
 	/* The device password ID for group negotiation */
 	u16 device_password_id_for_nego;
 	u8 negotiation_dialog_token;
-	/* SSID information for group negotitation */
+	/* SSID information for group negotiation */
 	u8 nego_ssid[WLAN_SSID_MAXLEN];
 	u8 nego_ssidlen;
 	u8 p2p_group_ssid[WLAN_SSID_MAXLEN];
@@ -267,7 +267,7 @@ struct wifidirect_info {
 	 * attribute of group negotiation response frame. */
 	uint channel_list_attr_len;
 	/* This field will contain the body of P2P Channel List attribute of
-	 * group negotitation response frame. */
+	 * group negotiation response frame. */
 	/* We will use the channel_cnt and channel_list fields when constructing
 	 * the group negotiation confirm frame. */
 	u8 channel_list_attr[100];
diff --git a/drivers/staging/r8188eu/include/rtw_mp.h b/drivers/staging/r8188eu/include/rtw_mp.h
index b64b16554343..c23190ad7107 100644
--- a/drivers/staging/r8188eu/include/rtw_mp.h
+++ b/drivers/staging/r8188eu/include/rtw_mp.h
@@ -181,7 +181,7 @@ struct mpt_context {
 	/*  For MP Tx Power index */
 	u8	TxPwrLevel[2];	/*  rf-A, rf-B */
 
-	/*  Content of RCR Regsiter for Mass Production Test. */
+	/*  Content of RCR Register for Mass Production Test. */
 	u32	MptRCR;
 	/*  true if we only receive packets with specific pattern. */
 	bool	bMptFilterPattern;
diff --git a/drivers/staging/r8188eu/include/rtw_mp_phy_regdef.h b/drivers/staging/r8188eu/include/rtw_mp_phy_regdef.h
index c2be770a5f5d..3c2e7a823b3d 100644
--- a/drivers/staging/r8188eu/include/rtw_mp_phy_regdef.h
+++ b/drivers/staging/r8188eu/include/rtw_mp_phy_regdef.h
@@ -30,7 +30,7 @@
 /*--------------------------Define Parameters-------------------------------*/
 
 /*  */
-/*	8192S Regsiter offset definition */
+/*	8192S Register offset definition */
 /*  */
 
 /*  */
@@ -131,7 +131,7 @@
 #define	rFPGA0_AnalogParameter3		0x888	/*  Useless now */
 #define	rFPGA0_AnalogParameter4		0x88c
 
-#define	rFPGA0_XA_LSSIReadBack		0x8a0	/*  Tranceiver LSSI Readback */
+#define	rFPGA0_XA_LSSIReadBack		0x8a0	/*  Transceiver LSSI Readback */
 #define	rFPGA0_XB_LSSIReadBack		0x8a4
 #define	rFPGA0_XC_LSSIReadBack		0x8a8
 #define	rFPGA0_XD_LSSIReadBack		0x8ac
@@ -185,7 +185,7 @@
 #define	rOFDM0_TRSWIsolation		0xc0c
 
 #define	rOFDM0_XARxAFE			0xc10  /* RxIQ DC offset, Rx digital filter, DC notch filter */
-#define	rOFDM0_XARxIQImbalance		0xc14  /* RxIQ imblance matrix */
+#define	rOFDM0_XARxIQImbalance		0xc14  /* RxIQ imbalance matrix */
 #define	rOFDM0_XBRxAFE			0xc18
 #define	rOFDM0_XBRxIQImbalance		0xc1c
 #define	rOFDM0_XCRxAFE			0xc20
diff --git a/drivers/staging/r8188eu/include/rtw_recv.h b/drivers/staging/r8188eu/include/rtw_recv.h
index 857269ae4209..17a4ce3d64e1 100644
--- a/drivers/staging/r8188eu/include/rtw_recv.h
+++ b/drivers/staging/r8188eu/include/rtw_recv.h
@@ -101,7 +101,7 @@ struct rx_pkt_attrib {
 	u8	privacy; /* in frame_ctrl field */
 	u8	bdecrypted;
 	u8	encrypt; /* when 0 indicate no encrypt. when non-zero,
-			  * indicate the encrypt algorith */
+			  * indicate the encrypt algorithm */
 	u8	iv_len;
 	u8	icv_len;
 	u8	crc_err;
@@ -187,7 +187,7 @@ struct recv_priv {
 	u8 *precv_buf;    /*  4 alignment */
 	struct __queue free_recv_buf_queue;
 	u32	free_recv_buf_queue_cnt;
-	/* For display the phy informatiom */
+	/* For display the phy information */
 	u8 is_signal_dbg;	/*  for debug */
 	u8 signal_strength_dbg;	/*  for debug */
 	s8 rssi;
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index e1418a3f7ed1..eaef374e0953 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -12,7 +12,7 @@
 
 #define XMITBUF_ALIGN_SZ	4
 
-/*  xmit extension buff defination */
+/*  xmit extension buff definition */
 #define MAX_XMIT_EXTBUF_SZ	(1536)
 #define NR_XMIT_EXTBUFF		(32)
 
@@ -113,7 +113,7 @@ struct pkt_attrib {
 	u32	last_txcmdsz;
 	u8	nr_frags;
 	u8	encrypt;	/* when 0 indicate no encrypt. when non-zero,
-				 * indicate the encrypt algorith */
+				 * indicate the encrypt algorithm */
 	u8	iv_len;
 	u8	icv_len;
 	u8	iv[18];
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 2c56d1d70d03..f2e0be2191f2 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -170,7 +170,7 @@ enum WIFI_STATUS_CODE {
 #define WLAN_STATUS_AP_UNABLE_TO_HANDLE_NEW_STA 17
 #define WLAN_STATUS_ASSOC_DENIED_RATES 18 */
 
-/* entended */
+/* extended */
 /* IEEE 802.11b */
 #define WLAN_STATUS_ASSOC_DENIED_NOSHORT 19
 #define WLAN_STATUS_ASSOC_DENIED_NOPBCC 20
@@ -876,7 +876,7 @@ enum ht_cap_ampdu_factor {
 #define	P2P_STATUS_FAIL_INCOMPATIBLE_PROVSION		0x0A
 #define	P2P_STATUS_FAIL_USER_REJECT			0x0B
 
-/*	Value of Inviation Flags Attribute */
+/*	Value of Invitation Flags Attribute */
 #define	P2P_INVITATION_FLAGS_PERSISTENT			BIT(0)
 
 #define	DMP_P2P_DEVCAP_SUPPORT	(P2P_DEVCAP_SERVICE_DISCOVERY | \
@@ -994,13 +994,13 @@ enum P2P_STATE {
 	P2P_STATE_TX_PROVISION_DIS_REQ = 6,
 	P2P_STATE_RX_PROVISION_DIS_RSP = 7,
 	P2P_STATE_RX_PROVISION_DIS_REQ = 8,
-	/* Doing the group owner negoitation handshake */
+	/* Doing the group owner negotiation handshake */
 	P2P_STATE_GONEGO_ING = 9,
-	/* finish the group negoitation handshake with success */
+	/* finish the group negotiation handshake with success */
 	P2P_STATE_GONEGO_OK = 10,
-	/* finish the group negoitation handshake with failure */
+	/* finish the group negotiation handshake with failure */
 	P2P_STATE_GONEGO_FAIL = 11,
-	/* receiving the P2P Inviation request and match with the profile. */
+	/* receiving the P2P Invitation request and match with the profile. */
 	P2P_STATE_RECV_INVITE_REQ_MATCH = 12,
 	/* Doing the P2P WPS */
 	P2P_STATE_PROVISIONING_ING = 13,
@@ -1010,17 +1010,17 @@ enum P2P_STATE {
 	P2P_STATE_TX_INVITE_REQ = 15,
 	/* Receiving the P2P Invitation response */
 	P2P_STATE_RX_INVITE_RESP_OK = 16,
-	/* receiving the P2P Inviation request and dismatch with the profile. */
+	/* receiving the P2P Invitation request and dismatch with the profile. */
 	P2P_STATE_RECV_INVITE_REQ_DISMATCH = 17,
-	/* receiving the P2P Inviation request and this wifi is GO. */
+	/* receiving the P2P Invitation request and this wifi is GO. */
 	P2P_STATE_RECV_INVITE_REQ_GO = 18,
-	/* receiving the P2P Inviation request to join an existing P2P Group. */
+	/* receiving the P2P Invitation request to join an existing P2P Group. */
 	P2P_STATE_RECV_INVITE_REQ_JOIN = 19,
-	/* recveing the P2P Inviation response with failure */
+	/* recveing the P2P Invitation response with failure */
 	P2P_STATE_RX_INVITE_RESP_FAIL = 20,
-	/* receiving p2p negoitation response with information is not available */
+	/* receiving p2p negotiation response with information is not available */
 	P2P_STATE_RX_INFOR_NOREADY = 21,
-	/* sending p2p negoitation response with information is not available */
+	/* sending p2p negotiation response with information is not available */
 	P2P_STATE_TX_INFOR_NOREADY = 22,
 };
 
diff --git a/drivers/staging/r8188eu/include/wlan_bssdef.h b/drivers/staging/r8188eu/include/wlan_bssdef.h
index bada3e168c42..2c2cf1919f9f 100644
--- a/drivers/staging/r8188eu/include/wlan_bssdef.h
+++ b/drivers/staging/r8188eu/include/wlan_bssdef.h
@@ -215,7 +215,7 @@ struct wlan_phy_info {
 };
 
 struct wlan_bcn_info {
-	/* these infor get from rtw_get_encrypt_info when
+	/* the info got from rtw_get_encrypt_info when
 	 *	 * translate scan to UI */
 	u8 encryp_protocol;/* ENCRYP_PROTOCOL_E: OPEN/WEP/WPA/WPA2/WAPI */
 	int group_cipher; /* WPA/WPA2 group cipher */
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 8ba2b81e32b8..17823bb1fed4 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -1042,7 +1042,7 @@ static int rtw_wx_get_range(struct net_device *dev,
 	range->max_qual.updated = 7; /* Updated all three */
 
 	range->avg_qual.qual = 92; /* > 8% missed beacons is 'bad' */
-	/* TODO: Find real 'good' to 'bad' threshol value for RSSI */
+	/* TODO: Find real 'good' to 'bad' threshold value for RSSI */
 	range->avg_qual.level = 178; /* -78 dBm */
 	range->avg_qual.noise = 0;
 	range->avg_qual.updated = 7; /* Updated all three */
@@ -3438,8 +3438,8 @@ static int rtw_p2p_connect(struct net_device *dev,
 	uint uintPeerChannel = 0;
 
 	/*	Commented by Albert 20110304 */
-	/*	The input data contains two informations. */
-	/*	1. First information is the MAC address which wants to formate with */
+	/*	The input data contains two items of information: */
+	/*	1. First information is the MAC address which wants to format with */
 	/*	2. Second information is the WPS PINCode or "pbc" string for push button method */
 	/*	Format: 00:E0:4C:00:00:05 */
 	/*	Format: 00:E0:4C:00:00:05 */
@@ -3519,7 +3519,7 @@ static int rtw_p2p_invite_req(struct net_device *dev,
 	uint p2pielen = 0, attr_contentlen = 0;
 	struct tx_invite_req_info *pinvite_req_info = &pwdinfo->invitereq_info;
 
-	/*	The input data contains two informations. */
+	/*	The input data contains two items of information: */
 	/*	1. First information is the P2P device address which you want to send to. */
 	/*	2. Second information is the group id which combines with GO's mac address, space and GO's ssid. */
 	/*	Command line sample: iwpriv wlan0 p2p_set invite ="00:11:22:33:44:55 00:E0:4C:00:00:05 DIRECT-xy" */
@@ -3657,7 +3657,7 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
 	u8 *p2pie;
 	uint p2pielen = 0, attr_contentlen = 0;
 
-	/*	The input data contains two informations. */
+	/*	The input data contains two items of information: */
 	/*	1. First information is the MAC address which wants to issue the provisioning discovery request frame. */
 	/*	2. Second information is the WPS configuration method which wants to discovery */
 	/*	Format: 00:E0:4C:00:00:05_display */
@@ -3692,7 +3692,7 @@ static int rtw_p2p_prov_disc(struct net_device *dev,
 	} else if (!memcmp(&extra[18], "label", 5)) {
 		pwdinfo->tx_prov_disc_info.wps_config_method_request = WPS_CM_LABEL;
 	} else {
-		DBG_88E("[%s] Unknown WPS config methodn", __func__);
+		DBG_88E("[%s] Unknown WPS config method\n", __func__);
 		return ret;
 	}
 
@@ -3991,7 +3991,7 @@ static int rtw_rereg_nd_name(struct net_device *dev,
 
 	if (!memcmp(new_ifname, "disable%d", 9)) {
 		DBG_88E("%s disable\n", __func__);
-		/*  free network queue for Android's timming issue */
+		/*  free network queue for Android's timing issue */
 		rtw_free_network_queue(padapter, true);
 
 		/*  close led */
@@ -4160,7 +4160,7 @@ static int rtw_dbg_port(struct net_device *dev,
 			u8 page_boundary = 0xf9;
 			struct xmit_frame	*xmit_frame;
 
-			xmit_frame = rtw_IOL_accquire_xmit_frame(padapter);
+			xmit_frame = rtw_IOL_acquire_xmit_frame(padapter);
 			if (!xmit_frame) {
 				ret = -ENOMEM;
 				break;
@@ -4180,7 +4180,7 @@ static int rtw_dbg_port(struct net_device *dev,
 			int i;
 			struct xmit_frame	*xmit_frame;
 
-			xmit_frame = rtw_IOL_accquire_xmit_frame(padapter);
+			xmit_frame = rtw_IOL_acquire_xmit_frame(padapter);
 			if (!xmit_frame) {
 				ret = -ENOMEM;
 				break;
@@ -4206,7 +4206,7 @@ static int rtw_dbg_port(struct net_device *dev,
 			u8 final;
 			struct xmit_frame	*xmit_frame;
 
-			xmit_frame = rtw_IOL_accquire_xmit_frame(padapter);
+			xmit_frame = rtw_IOL_acquire_xmit_frame(padapter);
 			if (!xmit_frame) {
 				ret = -ENOMEM;
 				break;
@@ -4235,7 +4235,7 @@ static int rtw_dbg_port(struct net_device *dev,
 			u16 final;
 			struct xmit_frame	*xmit_frame;
 
-			xmit_frame = rtw_IOL_accquire_xmit_frame(padapter);
+			xmit_frame = rtw_IOL_acquire_xmit_frame(padapter);
 			if (!xmit_frame) {
 				ret = -ENOMEM;
 				break;
@@ -4263,7 +4263,7 @@ static int rtw_dbg_port(struct net_device *dev,
 			u32 final;
 			struct xmit_frame	*xmit_frame;
 
-			xmit_frame = rtw_IOL_accquire_xmit_frame(padapter);
+			xmit_frame = rtw_IOL_acquire_xmit_frame(padapter);
 			if (!xmit_frame) {
 				ret = -ENOMEM;
 				break;
@@ -4339,7 +4339,7 @@ static int rtw_dbg_port(struct net_device *dev,
 				DBG_88E("SSID =%s\n", cur_network->network.Ssid.Ssid);
 				DBG_88E("sta's macaddr: %pM\n", psta->hwaddr);
 				DBG_88E("cur_channel =%d, cur_bwmode =%d, cur_ch_offset =%d\n", pmlmeext->cur_channel, pmlmeext->cur_bwmode, pmlmeext->cur_ch_offset);
-				DBG_88E("rtsen =%d, cts2slef =%d\n", psta->rtsen, psta->cts2self);
+				DBG_88E("rtsen =%d, cts2self =%d\n", psta->rtsen, psta->cts2self);
 				DBG_88E("state = 0x%x, aid =%d, macid =%d, raid =%d\n", psta->state, psta->aid, psta->mac_id, psta->raid);
 				DBG_88E("qos_en =%d, ht_en =%d, init_rate =%d\n", psta->qos_option, psta->htpriv.ht_option, psta->init_rate);
 				DBG_88E("bwmode =%d, ch_offset =%d, sgi =%d\n", psta->htpriv.bwmode, psta->htpriv.ch_offset, psta->htpriv.sgi);
@@ -4400,7 +4400,7 @@ static int rtw_dbg_port(struct net_device *dev,
 
 						if (extra_arg == psta->aid) {
 							DBG_88E("sta's macaddr:%pM\n", (psta->hwaddr));
-							DBG_88E("rtsen =%d, cts2slef =%d\n", psta->rtsen, psta->cts2self);
+							DBG_88E("rtsen =%d, cts2self =%d\n", psta->rtsen, psta->cts2self);
 							DBG_88E("state = 0x%x, aid =%d, macid =%d, raid =%d\n", psta->state, psta->aid, psta->mac_id, psta->raid);
 							DBG_88E("qos_en =%d, ht_en =%d, init_rate =%d\n", psta->qos_option, psta->htpriv.ht_option, psta->init_rate);
 							DBG_88E("bwmode =%d, ch_offset =%d, sgi =%d\n", psta->htpriv.bwmode, psta->htpriv.ch_offset, psta->htpriv.sgi);
@@ -4446,7 +4446,7 @@ static int rtw_dbg_port(struct net_device *dev,
 		case 0x15:
 			{
 				struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
-				DBG_88E("==>silent resete cnts:%d\n", pwrpriv->ips_enter_cnts);
+				DBG_88E("==>silent reset cnts:%d\n", pwrpriv->ips_enter_cnts);
 			}
 			break;
 		case 0x10:/*  driver version display */
@@ -5141,7 +5141,7 @@ static int rtw_add_sta(struct net_device *dev, struct ieee_param *param)
 		if (pmlmepriv->qospriv.qos_option == 0)
 			psta->qos_option = 0;
 
-		/* chec 802.11n ht cap. */
+		/* check 802.11n ht cap. */
 		if (WLAN_STA_HT&flags) {
 			psta->htpriv.ht_option = true;
 			psta->qos_option = 1;
@@ -6333,7 +6333,7 @@ static int rtw_mp_efuse_set(struct net_device *dev,
  *		"w" for WORD (2 bytes)
  *		"dw" for DWORD (4 bytes)
  *	1st %d is address(offset)
- *	2st %d is data to write
+ *	2nd %d is data to write
  */
 static int rtw_mp_write_reg(struct net_device *dev,
 			struct iw_request_info *info,
@@ -6407,7 +6407,7 @@ static int rtw_mp_write_reg(struct net_device *dev,
  *	%d is address(offset)
  *
  * Return:
- *	%d for data readed
+ *	%d for data read
  */
 static int rtw_mp_read_reg(struct net_device *dev,
 			struct iw_request_info *info,
@@ -6535,7 +6535,7 @@ static int rtw_mp_read_reg(struct net_device *dev,
  * Input Format: %d,%x,%x
  *	%d is RF path, should be smaller than RF_PATH_MAX
  *	1st %x is address(offset)
- *	2st %x is data to write
+ *	2nd %x is data to write
  */
  static int rtw_mp_write_rf(struct net_device *dev,
 			    struct iw_request_info *info,
@@ -6572,7 +6572,7 @@ static int rtw_mp_read_reg(struct net_device *dev,
  *	%x is address(offset)
  *
  * Return:
- *	%d for data readed
+ *	%d for data read
  */
 static int rtw_mp_read_rf(struct net_device *dev,
 			struct iw_request_info *info,
@@ -7082,7 +7082,7 @@ static int rtw_mp_pwrtrk(struct net_device *dev,
 		if (strncmp(input, "stop", 4) == 0) {
 			enable = 0;
 			sprintf(extra, "mp tx power tracking stop");
-		} else if (sscanf(input, "ther =%d", &thermal)) {
+		} else if (sscanf(input, "thermal =%d", &thermal)) {
 				ret = Hal_SetThermalMeter(padapter, (u8)thermal);
 				if (ret == _FAIL)
 					return -EPERM;
@@ -7534,7 +7534,7 @@ static iw_handler rtw_handlers[] = {
 	rtw_wx_set_wap,		/* SIOCSIWAP */
 	rtw_wx_get_wap,		/* SIOCGIWAP */
 	rtw_wx_set_mlme,		/* request MLME operation; uses struct iw_mlme */
-	dummy,					/* SIOCGIWAPLIST -- depricated */
+	dummy,				/* SIOCGIWAPLIST -- deprecated */
 	rtw_wx_set_scan,		/* SIOCSIWSCAN */
 	rtw_wx_get_scan,		/* SIOCGIWSCAN */
 	rtw_wx_set_essid,		/* SIOCSIWESSID */
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 5f1ec883d6ed..3a3fb571bd07 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -763,7 +763,7 @@ void rtw_stop_drv_threads(struct adapter *padapter)
 {
 	RT_TRACE(_module_os_intfs_c_, _drv_info_, ("+rtw_stop_drv_threads\n"));
 
-	/* Below is to termindate rtw_cmd_thread & event_thread... */
+	/* Below is to terminate rtw_cmd_thread & event_thread... */
 	up(&padapter->cmdpriv.cmd_queue_sema);
 	if (padapter->cmdThread)
 		_rtw_down_sema(&padapter->cmdpriv.terminate_cmdthread_sema);
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index bc7f4bd7ce0b..02d8faeae05f 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -387,7 +387,7 @@ int rtw_hw_suspend(struct adapter *padapter)
 
 				rtw_os_indicate_disconnect(padapter);
 
-				/* donnot enqueue cmd */
+				/* do not enqueue cmd */
 				rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_DISCONNECT, 0);
 			}
 		}
diff --git a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
index dd4bd14b76c2..d0670d3faa43 100644
--- a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
@@ -106,7 +106,7 @@ static void usb_write_port_complete(struct urb *purb, struct pt_regs *regs)
 		if ((purb->status == -EPIPE) || (purb->status == -EPROTO)) {
 			sreset_set_wifi_error_status(padapter, USB_WRITE_PORT_FAIL);
 		} else if (purb->status == -EINPROGRESS) {
-			RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("usb_write_port_complete: EINPROGESS\n"));
+			RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("usb_write_port_complete: EINPROGRESS\n"));
 			goto check_completion;
 		} else if (purb->status == -ENOENT) {
 			DBG_88E("%s: -ENOENT\n", __func__);
-- 
2.31.1

