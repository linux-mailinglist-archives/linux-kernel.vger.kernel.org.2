Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6A63ADB9D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 22:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhFSUQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 16:16:39 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:60127 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhFSUQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 16:16:37 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d18 with ME
        id K8EM2500721Fzsu038EMqf; Sat, 19 Jun 2021 22:14:24 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 19 Jun 2021 22:14:24 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        insafonov@gmail.com, linux@roeck-us.net, straube.linux@gmail.com,
        gustavoars@kernel.org, liushixin2@huawei.com,
        yepeilin.cs@gmail.com, phil@philpotter.co.uk
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] staging: rtl8188eu: remove "rtw_ieee80211_back_actioncode"
Date:   Sat, 19 Jun 2021 22:14:20 +0200
Message-Id: <6b6d8d81e7b2115e9206d2960ce09e1b2e8b6381.1624132543.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enum is the same as "ieee80211_back_actioncode" in
"include/linux/ieee80211.h".

Update the code accordingly and remove useless comment.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 14 +++++++-------
 drivers/staging/rtl8188eu/include/ieee80211.h |  7 -------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 6107257900c2..eb2202a11aa7 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -1744,7 +1744,7 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 	if (initiator == 0) { /*  recipient */
 		for (tid = 0; tid < MAXTID; tid++) {
 			if (psta->recvreorder_ctrl[tid].enable) {
-				issue_action_BA(padapter, addr, RTW_WLAN_ACTION_DELBA, (((tid << 1) | initiator) & 0x1F));
+				issue_action_BA(padapter, addr, WLAN_ACTION_DELBA, (((tid << 1) | initiator) & 0x1F));
 				psta->recvreorder_ctrl[tid].enable = false;
 				psta->recvreorder_ctrl[tid].indicate_seq = 0xffff;
 			}
@@ -1752,7 +1752,7 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 	} else if (initiator == 1) { /*  originator */
 		for (tid = 0; tid < MAXTID; tid++) {
 			if (psta->htpriv.agg_enable_bitmap & BIT(tid)) {
-				issue_action_BA(padapter, addr, RTW_WLAN_ACTION_DELBA, (((tid << 1) | initiator) & 0x1F));
+				issue_action_BA(padapter, addr, WLAN_ACTION_DELBA, (((tid << 1) | initiator) & 0x1F));
 				psta->htpriv.agg_enable_bitmap &= ~BIT(tid);
 				psta->htpriv.candidate_tid_bitmap &= ~BIT(tid);
 			}
@@ -3426,16 +3426,16 @@ static unsigned int OnAction_back(struct adapter *padapter,
 			return _SUCCESS;
 		action = frame_body[1];
 		switch (action) {
-		case RTW_WLAN_ACTION_ADDBA_REQ: /* ADDBA request */
+		case WLAN_ACTION_ADDBA_REQ:
 			memcpy(&pmlmeinfo->ADDBA_req, &frame_body[2], sizeof(struct ADDBA_request));
 			process_addba_req(padapter, (u8 *)&pmlmeinfo->ADDBA_req, addr);
 
 			/* 37 = reject ADDBA Req */
 			issue_action_BA(padapter, addr,
-					RTW_WLAN_ACTION_ADDBA_RESP,
+					WLAN_ACTION_ADDBA_RESP,
 					pmlmeinfo->accept_addba_req ? 0 : 37);
 			break;
-		case RTW_WLAN_ACTION_ADDBA_RESP: /* ADDBA response */
+		case WLAN_ACTION_ADDBA_RESP:
 			status = get_unaligned_le16(&frame_body[3]);
 			tid = (frame_body[5] >> 2) & 0x7;
 			if (status == 0) {	/* successful */
@@ -3445,7 +3445,7 @@ static unsigned int OnAction_back(struct adapter *padapter,
 				psta->htpriv.agg_enable_bitmap &= ~BIT(tid);
 			}
 			break;
-		case RTW_WLAN_ACTION_DELBA: /* DELBA */
+		case WLAN_ACTION_DELBA:
 			if ((frame_body[3] & BIT(3)) == 0) {
 				psta->htpriv.agg_enable_bitmap &= ~(1 << ((frame_body[3] >> 4) & 0xf));
 				psta->htpriv.candidate_tid_bitmap &= ~(1 << ((frame_body[3] >> 4) & 0xf));
@@ -5068,7 +5068,7 @@ u8 add_ba_hdl(struct adapter *padapter, unsigned char *pbuf)
 
 	if (((pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) && (pmlmeinfo->HT_enable)) ||
 	    ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE)) {
-		issue_action_BA(padapter, pparm->addr, RTW_WLAN_ACTION_ADDBA_REQ, (u16)pparm->tid);
+		issue_action_BA(padapter, pparm->addr, WLAN_ACTION_ADDBA_REQ, (u16)pparm->tid);
 		mod_timer(&psta->addba_retry_timer,
 			  jiffies + msecs_to_jiffies(ADDBA_TO));
 	} else {
diff --git a/drivers/staging/rtl8188eu/include/ieee80211.h b/drivers/staging/rtl8188eu/include/ieee80211.h
index cb6940d2aeab..4becf4edaa25 100644
--- a/drivers/staging/rtl8188eu/include/ieee80211.h
+++ b/drivers/staging/rtl8188eu/include/ieee80211.h
@@ -546,13 +546,6 @@ enum _PUBLIC_ACTION {
 	ACT_PUBLIC_MAX
 };
 
-/* BACK action code */
-enum rtw_ieee80211_back_actioncode {
-	RTW_WLAN_ACTION_ADDBA_REQ = 0,
-	RTW_WLAN_ACTION_ADDBA_RESP = 1,
-	RTW_WLAN_ACTION_DELBA = 2,
-};
-
 /* HT features action code */
 enum rtw_ieee80211_ht_actioncode {
 	RTW_WLAN_ACTION_NOTIFY_CH_WIDTH = 0,
-- 
2.30.2

