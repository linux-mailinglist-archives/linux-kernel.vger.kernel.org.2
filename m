Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9391E370B55
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 13:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhEBLbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 07:31:06 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:38847 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhEBLbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 07:31:05 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d40 with ME
        id znW92400221Fzsu03nW9Wa; Sun, 02 May 2021 13:30:10 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 02 May 2021 13:30:10 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] staging: rtl8188eu: remove enum WIFI_FRAME_SUBTYPE
Date:   Sun,  2 May 2021 13:30:06 +0200
Message-Id: <7c1007d5706a42e0ba1fe805089fab523f9db7ea.1619953884.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The values defined in enum WIFI_FRAME_SUBTYPE are the same the #define
IEEE80211_STYPE_xxx from <linux/ieee80211.h>.

Special care must be taken for control and data frame, because  the coding
of the frame type is not included in the IEEE80211_STYPE_xxx values and
must be added explicitly.

There is no problem for management frame because the type si coded as (0)
(in rtl8188eu) and (0x0000) (in <linux/ieee80211.h>).

Values used for control frame (WIFI_PSPOLL) must be OR'eded with
IEEE80211_FTYPE_CTL.

Values used for data frame (WIFI_DATA_NULL and WIFI_QOS_DATA_NULL) must be
OR'ed with IEEE80211_FTYPE_DATA.

Use theses values to avoid code duplication.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 86 +++++++++----------
 drivers/staging/rtl8188eu/core/rtw_recv.c     |  9 +-
 .../staging/rtl8188eu/core/rtw_wlan_util.c    |  2 +-
 drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c  | 10 +--
 .../staging/rtl8188eu/hal/rtl8188e_rxdesc.c   |  2 +-
 drivers/staging/rtl8188eu/include/wifi.h      | 36 --------
 6 files changed, 55 insertions(+), 90 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 50d3c3631be0..f164ea20b939 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -344,7 +344,7 @@ static void issue_beacon(struct adapter *padapter, int timeout_ms)
 
 	SetSeqNum(pwlanhdr, 0/*pmlmeext->mgnt_seq*/);
 	/* pmlmeext->mgnt_seq++; */
-	SetFrameSubType(pframe, WIFI_BEACON);
+	SetFrameSubType(pframe, IEEE80211_STYPE_BEACON);
 
 	pframe += sizeof(struct ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
@@ -487,7 +487,7 @@ static void issue_probersp(struct adapter *padapter, unsigned char *da)
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	SetFrameSubType(fctrl, WIFI_PROBERSP);
+	SetFrameSubType(fctrl, IEEE80211_STYPE_PROBE_RESP);
 
 	pattrib->hdrlen = sizeof(struct ieee80211_hdr_3addr);
 	pattrib->pktlen = pattrib->hdrlen;
@@ -640,7 +640,7 @@ static int issue_probereq(struct adapter *padapter,
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	SetFrameSubType(pframe, WIFI_PROBEREQ);
+	SetFrameSubType(pframe, IEEE80211_STYPE_PROBE_REQ);
 
 	pframe += sizeof(struct ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
@@ -762,7 +762,7 @@ static void issue_auth(struct adapter *padapter, struct sta_info *psta,
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	SetFrameSubType(pframe, WIFI_AUTH);
+	SetFrameSubType(pframe, IEEE80211_STYPE_AUTH);
 
 	pframe += sizeof(struct ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
@@ -912,7 +912,7 @@ static void issue_asocrsp(struct adapter *padapter, unsigned short status,
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	if ((pkt_type == WIFI_ASSOCRSP) || (pkt_type == WIFI_REASSOCRSP))
+	if ((pkt_type == IEEE80211_STYPE_ASSOC_RESP) || (pkt_type == IEEE80211_STYPE_REASSOC_RESP))
 		SetFrameSubType(pwlanhdr, pkt_type);
 	else
 		return;
@@ -1034,7 +1034,7 @@ static void issue_assocreq(struct adapter *padapter)
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	SetFrameSubType(pframe, WIFI_ASSOCREQ);
+	SetFrameSubType(pframe, IEEE80211_STYPE_ASSOC_REQ);
 
 	pframe += sizeof(struct ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
@@ -1226,7 +1226,7 @@ static int _issue_nulldata(struct adapter *padapter, unsigned char *da,
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	SetFrameSubType(pframe, WIFI_DATA_NULL);
+	SetFrameSubType(pframe, IEEE80211_FTYPE_DATA | IEEE80211_STYPE_NULLFUNC);
 
 	pframe += sizeof(struct ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
@@ -1355,7 +1355,7 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da,
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	SetFrameSubType(pframe, WIFI_QOS_DATA_NULL);
+	SetFrameSubType(pframe, IEEE80211_FTYPE_DATA | IEEE80211_STYPE_QOS_NULLFUNC);
 
 	pframe += sizeof(struct ieee80211_qos_hdr);
 	pattrib->pktlen = sizeof(struct ieee80211_qos_hdr);
@@ -1460,7 +1460,7 @@ static int _issue_deauth(struct adapter *padapter, unsigned char *da,
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	SetFrameSubType(pframe, WIFI_DEAUTH);
+	SetFrameSubType(pframe, IEEE80211_STYPE_DEAUTH);
 
 	pframe += sizeof(struct ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
@@ -1578,7 +1578,7 @@ static void issue_action_BA(struct adapter *padapter, unsigned char *raddr,
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	SetFrameSubType(pframe, WIFI_ACTION);
+	SetFrameSubType(pframe, IEEE80211_STYPE_ACTION);
 
 	pframe += sizeof(struct ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
@@ -1735,7 +1735,7 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 
 	SetSeqNum(pwlanhdr, pmlmeext->mgnt_seq);
 	pmlmeext->mgnt_seq++;
-	SetFrameSubType(pframe, WIFI_ACTION);
+	SetFrameSubType(pframe, IEEE80211_STYPE_ACTION);
 
 	pframe += sizeof(struct ieee80211_hdr_3addr);
 	pattrib->pktlen = sizeof(struct ieee80211_hdr_3addr);
@@ -2024,15 +2024,15 @@ static u8 collect_bss_info(struct adapter *padapter,
 
 	subtype = GetFrameSubType(pframe);
 
-	if (subtype == WIFI_BEACON) {
+	if (subtype == IEEE80211_STYPE_BEACON) {
 		bssid->Reserved[0] = 1;
 		ie_offset = _BEACON_IE_OFFSET_;
 	} else {
 		/*  FIXME : more type */
-		if (subtype == WIFI_PROBEREQ) {
+		if (subtype == IEEE80211_STYPE_PROBE_REQ) {
 			ie_offset = _PROBEREQ_IE_OFFSET_;
 			bssid->Reserved[0] = 2;
-		} else if (subtype == WIFI_PROBERSP) {
+		} else if (subtype == IEEE80211_STYPE_PROBE_RESP) {
 			ie_offset = _PROBERSP_IE_OFFSET_;
 			bssid->Reserved[0] = 3;
 		} else {
@@ -2120,7 +2120,7 @@ static u8 collect_bss_info(struct adapter *padapter,
 		}
 	}
 
-	if (subtype == WIFI_PROBEREQ) {
+	if (subtype == IEEE80211_STYPE_PROBE_REQ) {
 		/*  FIXME */
 		bssid->InfrastructureMode = Ndis802_11Infrastructure;
 		ether_addr_copy(bssid->MacAddress, GetAddr2Ptr(pframe));
@@ -2907,10 +2907,10 @@ static unsigned int OnAssocReq(struct adapter *padapter,
 		return _FAIL;
 
 	frame_type = GetFrameSubType(pframe);
-	if (frame_type == WIFI_ASSOCREQ) {
+	if (frame_type == IEEE80211_STYPE_ASSOC_REQ) {
 		reassoc = 0;
 		ie_offset = _ASOCREQ_IE_OFFSET_;
-	} else { /*  WIFI_REASSOCREQ */
+	} else { /*  IEEE80211_STYPE_REASSOC_REQ */
 		reassoc = 1;
 		ie_offset = _REASOCREQ_IE_OFFSET_;
 	}
@@ -3282,10 +3282,10 @@ static unsigned int OnAssocReq(struct adapter *padapter,
 		sta_info_update(padapter, pstat);
 
 		/* issue assoc rsp before notify station join event. */
-		if (frame_type == WIFI_ASSOCREQ)
-			issue_asocrsp(padapter, status, pstat, WIFI_ASSOCRSP);
+		if (frame_type == IEEE80211_STYPE_ASSOC_REQ)
+			issue_asocrsp(padapter, status, pstat, IEEE80211_STYPE_ASSOC_RESP);
 		else
-			issue_asocrsp(padapter, status, pstat, WIFI_REASSOCRSP);
+			issue_asocrsp(padapter, status, pstat, IEEE80211_STYPE_REASSOC_RESP);
 
 		/* 2 - report to upper layer */
 		DBG_88E("indicate_sta_join_event to upper layer - hostapd\n");
@@ -3306,10 +3306,10 @@ static unsigned int OnAssocReq(struct adapter *padapter,
 OnAssocReqFail:
 
 	pstat->aid = 0;
-	if (frame_type == WIFI_ASSOCREQ)
-		issue_asocrsp(padapter, status, pstat, WIFI_ASSOCRSP);
+	if (frame_type == IEEE80211_STYPE_ASSOC_REQ)
+		issue_asocrsp(padapter, status, pstat, IEEE80211_STYPE_ASSOC_RESP);
 	else
-		issue_asocrsp(padapter, status, pstat, WIFI_REASSOCRSP);
+		issue_asocrsp(padapter, status, pstat, IEEE80211_STYPE_REASSOC_RESP);
 
 #endif /* CONFIG_88EU_AP_MODE */
 
@@ -3822,20 +3822,20 @@ Following are the initialization functions for WiFi MLME
 *****************************************************************************/
 
 static struct mlme_handler mlme_sta_tbl[] = {
-	{WIFI_ASSOCREQ,	  "OnAssocReq",	  &OnAssocReq},
-	{WIFI_ASSOCRSP,	  "OnAssocRsp",	  &OnAssocRsp},
-	{WIFI_REASSOCREQ, "OnReAssocReq", &OnAssocReq},
-	{WIFI_REASSOCRSP, "OnReAssocRsp", &OnAssocRsp},
-	{WIFI_PROBEREQ,	  "OnProbeReq",	  &OnProbeReq},
-	{WIFI_PROBERSP,	  "OnProbeRsp",	  &OnProbeRsp},
-	{0,		  "DoReserved",	  &DoReserved},
-	{0,		  "DoReserved",	  &DoReserved},
-	{WIFI_BEACON,	  "OnBeacon",	  &OnBeacon},
-	{WIFI_ATIM,	  "OnATIM",	  &OnAtim},
-	{WIFI_DISASSOC,	  "OnDisassoc",	  &OnDisassoc},
-	{WIFI_AUTH,	  "OnAuth",	  &OnAuthClient},
-	{WIFI_DEAUTH,	  "OnDeAuth",	  &OnDeAuth},
-	{WIFI_ACTION,	  "OnAction",	  &OnAction},
+	{IEEE80211_STYPE_ASSOC_REQ,	"OnAssocReq",	&OnAssocReq},
+	{IEEE80211_STYPE_ASSOC_RESP,	"OnAssocRsp",	&OnAssocRsp},
+	{IEEE80211_STYPE_REASSOC_REQ,	"OnReAssocReq",	&OnAssocReq},
+	{IEEE80211_STYPE_REASSOC_RESP,	"OnReAssocRsp",	&OnAssocRsp},
+	{IEEE80211_STYPE_PROBE_REQ,	"OnProbeReq",	&OnProbeReq},
+	{IEEE80211_STYPE_PROBE_RESP,	"OnProbeRsp",	&OnProbeRsp},
+	{0,				"DoReserved",	&DoReserved},
+	{0,				"DoReserved",	&DoReserved},
+	{IEEE80211_STYPE_BEACON,	"OnBeacon",	&OnBeacon},
+	{IEEE80211_STYPE_ATIM,		"OnATIM",	&OnAtim},
+	{IEEE80211_STYPE_DISASSOC,	"OnDisassoc",	&OnDisassoc},
+	{IEEE80211_STYPE_AUTH,		"OnAuth",	&OnAuthClient},
+	{IEEE80211_STYPE_DEAUTH,	"OnDeAuth",	&OnDeAuth},
+	{IEEE80211_STYPE_ACTION,	"OnAction",	&OnAction},
 };
 
 int init_hw_mlme_ext(struct adapter *padapter)
@@ -4121,17 +4121,17 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 
 #ifdef CONFIG_88EU_AP_MODE
 	switch (GetFrameSubType(pframe)) {
-	case WIFI_AUTH:
+	case IEEE80211_STYPE_AUTH:
 		if (check_fwstate(pmlmepriv, WIFI_AP_STATE))
 			ptable->func = &OnAuth;
 		else
 			ptable->func = &OnAuthClient;
 		fallthrough;
-	case WIFI_ASSOCREQ:
-	case WIFI_REASSOCREQ:
-	case WIFI_PROBEREQ:
-	case WIFI_BEACON:
-	case WIFI_ACTION:
+	case IEEE80211_STYPE_ASSOC_REQ:
+	case IEEE80211_STYPE_REASSOC_REQ:
+	case IEEE80211_STYPE_PROBE_REQ:
+	case IEEE80211_STYPE_BEACON:
+	case IEEE80211_STYPE_ACTION:
 		_mgt_dispatcher(padapter, ptable, precv_frame);
 		break;
 	default:
diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index b2fe448d999d..f8013b3a568c 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -866,7 +866,7 @@ static int validate_recv_ctrl_frame(struct adapter *padapter,
 		return _FAIL;
 
 	/* only handle ps-poll */
-	if (GetFrameSubType(pframe) == WIFI_PSPOLL) {
+	if (GetFrameSubType(pframe) == (IEEE80211_FTYPE_CTL | IEEE80211_STYPE_PSPOLL)) {
 		u16 aid;
 		u8 wmmps_ac = 0;
 		struct sta_info *psta = NULL;
@@ -997,11 +997,11 @@ static int validate_recv_mgnt_frame(struct adapter *padapter,
 			       GetAddr2Ptr(precv_frame->pkt->data));
 	if (psta) {
 		psta->sta_stats.rx_mgnt_pkts++;
-		if (GetFrameSubType(precv_frame->pkt->data) == WIFI_BEACON) {
+		if (GetFrameSubType(precv_frame->pkt->data) == IEEE80211_STYPE_BEACON) {
 			psta->sta_stats.rx_beacon_pkts++;
-		} else if (GetFrameSubType(precv_frame->pkt->data) == WIFI_PROBEREQ) {
+		} else if (GetFrameSubType(precv_frame->pkt->data) == IEEE80211_STYPE_PROBE_REQ) {
 			psta->sta_stats.rx_probereq_pkts++;
-		} else if (GetFrameSubType(precv_frame->pkt->data) == WIFI_PROBERSP) {
+		} else if (GetFrameSubType(precv_frame->pkt->data) == IEEE80211_STYPE_PROBE_RESP) {
 			if (!memcmp(padapter->eeprompriv.mac_addr,
 				    GetAddr1Ptr(precv_frame->pkt->data), ETH_ALEN))
 				psta->sta_stats.rx_probersp_pkts++;
diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index 7015db16dcf8..3e244e949995 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -820,7 +820,7 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 
 	subtype = GetFrameSubType(pframe) >> 4;
 
-	if (subtype == WIFI_BEACON)
+	if (subtype == IEEE80211_STYPE_BEACON)
 		bssid->Reserved[0] = 1;
 
 	bssid->Length = sizeof(struct wlan_bssid_ex) - MAX_IE_SZ + len;
diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c b/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
index 3a0e3d41a404..e22352f5d72d 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
@@ -218,7 +218,7 @@ static void ConstructBeacon(struct adapter *adapt, u8 *pframe, u32 *pLength)
 	ether_addr_copy(pwlanhdr->addr3, cur_network->MacAddress);
 
 	SetSeqNum(pwlanhdr, 0/*pmlmeext->mgnt_seq*/);
-	SetFrameSubType(pframe, WIFI_BEACON);
+	SetFrameSubType(pframe, IEEE80211_STYPE_BEACON);
 
 	pframe += sizeof(struct ieee80211_hdr_3addr);
 	pktlen = sizeof(struct ieee80211_hdr_3addr);
@@ -297,7 +297,7 @@ static void ConstructPSPoll(struct adapter *adapt, u8 *pframe, u32 *pLength)
 	fctrl = &pwlanhdr->frame_control;
 	*(fctrl) = 0;
 	SetPwrMgt(fctrl);
-	SetFrameSubType(pframe, WIFI_PSPOLL);
+	SetFrameSubType(pframe, IEEE80211_FTYPE_CTL | IEEE80211_STYPE_PSPOLL);
 
 	/*  AID. */
 	SetDuration(pframe, (pmlmeinfo->aid | 0xc000));
@@ -361,7 +361,7 @@ static void ConstructNullFunctionData(struct adapter *adapt, u8 *pframe,
 	if (bQoS) {
 		struct ieee80211_qos_hdr *pwlanqoshdr;
 
-		SetFrameSubType(pframe, WIFI_QOS_DATA_NULL);
+		SetFrameSubType(pframe, IEEE80211_FTYPE_DATA | IEEE80211_STYPE_QOS_NULLFUNC);
 
 		pwlanqoshdr = (struct ieee80211_qos_hdr *)pframe;
 		SetPriority(&pwlanqoshdr->qos_ctrl, AC);
@@ -369,7 +369,7 @@ static void ConstructNullFunctionData(struct adapter *adapt, u8 *pframe,
 
 		pktlen = sizeof(struct ieee80211_qos_hdr);
 	} else {
-		SetFrameSubType(pframe, WIFI_DATA_NULL);
+		SetFrameSubType(pframe, IEEE80211_FTYPE_DATA | IEEE80211_STYPE_NULLFUNC);
 
 		pktlen = sizeof(struct ieee80211_hdr_3addr);
 	}
@@ -399,7 +399,7 @@ static void ConstructProbeRsp(struct adapter *adapt, u8 *pframe, u32 *pLength, u
 	ether_addr_copy(pwlanhdr->addr3, bssid);
 
 	SetSeqNum(pwlanhdr, 0);
-	SetFrameSubType(fctrl, WIFI_PROBERSP);
+	SetFrameSubType(fctrl, IEEE80211_STYPE_PROBE_RESP);
 
 	pktlen = sizeof(struct ieee80211_hdr_3addr);
 	pframe += pktlen;
diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c b/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c
index 8669bf097479..05dbd3f08328 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c
@@ -156,7 +156,7 @@ void update_recvframe_phyinfo_88e(struct recv_frame *precvframe,
 				  myid(&padapter->eeprompriv), ETH_ALEN));
 
 	pkt_info.bPacketBeacon = pkt_info.bPacketMatchBSSID &&
-				 (GetFrameSubType(wlanhdr) == WIFI_BEACON);
+				 (GetFrameSubType(wlanhdr) == IEEE80211_STYPE_BEACON);
 
 	if (pkt_info.bPacketBeacon) {
 		if (check_fwstate(&padapter->mlmepriv, WIFI_STATION_STATE))
diff --git a/drivers/staging/rtl8188eu/include/wifi.h b/drivers/staging/rtl8188eu/include/wifi.h
index 84e17330628e..716fec036e54 100644
--- a/drivers/staging/rtl8188eu/include/wifi.h
+++ b/drivers/staging/rtl8188eu/include/wifi.h
@@ -25,42 +25,6 @@ enum WIFI_FRAME_TYPE {
 	WIFI_QOS_DATA_TYPE	= (BIT(7) | BIT(3)),	/*  QoS Data */
 };
 
-enum WIFI_FRAME_SUBTYPE {
-	/*  below is for mgt frame */
-	WIFI_ASSOCREQ       = (0 | WIFI_MGT_TYPE),
-	WIFI_ASSOCRSP       = (BIT(4) | WIFI_MGT_TYPE),
-	WIFI_REASSOCREQ     = (BIT(5) | WIFI_MGT_TYPE),
-	WIFI_REASSOCRSP     = (BIT(5) | BIT(4) | WIFI_MGT_TYPE),
-	WIFI_PROBEREQ       = (BIT(6) | WIFI_MGT_TYPE),
-	WIFI_PROBERSP       = (BIT(6) | BIT(4) | WIFI_MGT_TYPE),
-	WIFI_BEACON         = (BIT(7) | WIFI_MGT_TYPE),
-	WIFI_ATIM           = (BIT(7) | BIT(4) | WIFI_MGT_TYPE),
-	WIFI_DISASSOC       = (BIT(7) | BIT(5) | WIFI_MGT_TYPE),
-	WIFI_AUTH           = (BIT(7) | BIT(5) | BIT(4) | WIFI_MGT_TYPE),
-	WIFI_DEAUTH         = (BIT(7) | BIT(6) | WIFI_MGT_TYPE),
-	WIFI_ACTION         = (BIT(7) | BIT(6) | BIT(4) | WIFI_MGT_TYPE),
-
-	/*  below is for control frame */
-	WIFI_PSPOLL         = (BIT(7) | BIT(5) | WIFI_CTRL_TYPE),
-	WIFI_RTS            = (BIT(7) | BIT(5) | BIT(4) | WIFI_CTRL_TYPE),
-	WIFI_CTS            = (BIT(7) | BIT(6) | WIFI_CTRL_TYPE),
-	WIFI_ACK            = (BIT(7) | BIT(6) | BIT(4) | WIFI_CTRL_TYPE),
-	WIFI_CFEND          = (BIT(7) | BIT(6) | BIT(5) | WIFI_CTRL_TYPE),
-	WIFI_CFEND_CFACK    = (BIT(7) | BIT(6) | BIT(5) | BIT(4) |
-	WIFI_CTRL_TYPE),
-
-	/*  below is for data frame */
-	WIFI_DATA           = (0 | WIFI_DATA_TYPE),
-	WIFI_DATA_CFACK     = (BIT(4) | WIFI_DATA_TYPE),
-	WIFI_DATA_CFPOLL    = (BIT(5) | WIFI_DATA_TYPE),
-	WIFI_DATA_CFACKPOLL = (BIT(5) | BIT(4) | WIFI_DATA_TYPE),
-	WIFI_DATA_NULL      = (BIT(6) | WIFI_DATA_TYPE),
-	WIFI_CF_ACK         = (BIT(6) | BIT(4) | WIFI_DATA_TYPE),
-	WIFI_CF_POLL        = (BIT(6) | BIT(5) | WIFI_DATA_TYPE),
-	WIFI_CF_ACKPOLL     = (BIT(6) | BIT(5) | BIT(4) | WIFI_DATA_TYPE),
-	WIFI_QOS_DATA_NULL	= (BIT(6) | WIFI_QOS_DATA_TYPE),
-};
-
 #define SetToDs(pbuf)	\
 	*(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_TODS)
 
-- 
2.30.2

