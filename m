Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262CB43542B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 21:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhJTT4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 15:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbhJTT4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 15:56:53 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C106C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 12:54:38 -0700 (PDT)
Received: from dslb-188-096-142-022.188.096.pools.vodafone-ip.de ([188.96.142.22] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mdHfV-0007Cd-Ih; Wed, 20 Oct 2021 21:54:33 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/5] staging: r8188eu: use helper to check for broadcast address
Date:   Wed, 20 Oct 2021 21:53:59 +0200
Message-Id: <20211020195401.12931-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211020195401.12931-1-martin@kaiser.cx>
References: <20211020195401.12931-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the is_broadcast_ether_addr function to check for a
broadcast address.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 6 ++----
 drivers/staging/r8188eu/hal/odm.c           | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 995a0248c26f..b0dfafe526f7 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -392,13 +392,12 @@ void free_mlme_ext_priv(struct mlme_ext_priv *pmlmeext)
 
 static void _mgt_dispatcher(struct adapter *padapter, struct mlme_handler *ptable, struct recv_frame *precv_frame)
 {
-	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 	u8 *pframe = precv_frame->rx_data;
 
 	if (ptable->func) {
 	/* receive the frames that ra(a1) is my address or ra(a1) is bc address. */
 		if (memcmp(GetAddr1Ptr(pframe), myid(&padapter->eeprompriv), ETH_ALEN) &&
-		    memcmp(GetAddr1Ptr(pframe), bc_addr, ETH_ALEN))
+		    !is_broadcast_ether_addr(GetAddr1Ptr(pframe)))
 			return;
 		ptable->func(padapter, precv_frame);
 	}
@@ -409,7 +408,6 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 	int index;
 	struct mlme_handler *ptable;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 	u8 *pframe = precv_frame->rx_data;
 	struct sta_info *psta = rtw_get_stainfo(&padapter->stapriv, GetAddr2Ptr(pframe));
 
@@ -418,7 +416,7 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 
 	/* receive the frames that ra(a1) is my address or ra(a1) is bc address. */
 	if (memcmp(GetAddr1Ptr(pframe), myid(&padapter->eeprompriv), ETH_ALEN) &&
-	    memcmp(GetAddr1Ptr(pframe), bc_addr, ETH_ALEN))
+	    !is_broadcast_ether_addr(GetAddr1Ptr(pframe)))
 		return;
 
 	ptable = mlme_sta_tbl;
diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 67cf8f7baba5..21f115194df8 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -829,7 +829,6 @@ void odm_RSSIMonitorCheck(struct odm_dm_struct *pDM_Odm)
 	u8	sta_cnt = 0;
 	u32 PWDB_rssi[NUM_STA] = {0};/* 0~15]:MACID, [16~31]:PWDB_rssi */
 	struct sta_info *psta;
-	u8 bcast_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
 	if (!(pDM_Odm->SupportAbility & ODM_BB_RSSI_MONITOR))
 		return;
@@ -841,7 +840,7 @@ void odm_RSSIMonitorCheck(struct odm_dm_struct *pDM_Odm)
 		psta = pDM_Odm->pODM_StaInfo[i];
 		if (IS_STA_VALID(psta) &&
 		    (psta->state & WIFI_ASOC_STATE) &&
-		    memcmp(psta->hwaddr, bcast_addr, ETH_ALEN) &&
+		    !is_broadcast_ether_addr(psta->hwaddr) &&
 		    memcmp(psta->hwaddr, myid(&Adapter->eeprompriv), ETH_ALEN)) {
 			if (psta->rssi_stat.UndecoratedSmoothedPWDB < tmpEntryMinPWDB)
 				tmpEntryMinPWDB = psta->rssi_stat.UndecoratedSmoothedPWDB;
-- 
2.20.1

