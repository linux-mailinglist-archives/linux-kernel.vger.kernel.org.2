Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960B035A9F6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 03:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbhDJBfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 21:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbhDJBfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 21:35:43 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3994FC061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 18:35:28 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id p12so5162643pgj.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 18:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=cgG4mXiFk80jblksoZQMc9jgMHe+qe9jhj0xaapBykQ=;
        b=ZJkH9Mr+fDdJoB7cEjmQumMAzsNitSNtK+OjJOn/vPumF/UqWMpB6muM/7y9MC7SaG
         xcZ1GYxtfdxsW1hgHy4882wYwQ+uWZj0KIXO8cR5ivW+m1xyEUXwgKVB+PTPt3gmq0Nl
         fThLubv3VWFaIQictPvKxcp3LNx4bSzqaU4q/IkNUfsO1OAL4nBFNAIZX3MfSK2BOISn
         fxs1M2l4tGQH7/OiaqaxLalJoXX2n5F6R3sz7dyhJBc3fx23PowgwQg0Ve8+++THg6mm
         GRQZcM7XLHm09GgrsEatpZ0rGUu1bKO3gFLBpoRtcD3YYnYlYhaRUnzBH/TjcvNWZmUb
         czfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=cgG4mXiFk80jblksoZQMc9jgMHe+qe9jhj0xaapBykQ=;
        b=kPGJoNi9wjboHq2L6fksqk8cspvzfs8ZKADIVsQnvNpPDJB+nVhaIx1tY/5RAxAofv
         A8CHB2CJEzK8SdRrUZ7feue9WO+4qCPGZwx5TI7LFsFMLqEEO2iAXf0o15i4gFCZYsCZ
         PEzbPuYD0xv8W7bvKJGkdP9uq6VGRL5GCw4SmXPDNINTY5DGlWraRh9Qs+/xnnGBf7r5
         7+pU3Ep3t6QoLkuINre8lAgluiwQXxI4lvcbbOHcszzypRQnzq7z1V1vFrDJhNKWyb3X
         NlUGnge0ZKa1Oi8TiOEbRXD3bU1kRE4+WivZghefmgoa4r5hvYKauSMouagb8Wi0GBDL
         Qk7Q==
X-Gm-Message-State: AOAM532YsXqHyo/2UBNEsV6kY8VTbWVvZeFm3yAdzbnkZJKFZetqz1FE
        IEqEqHkUoKQuD8WaCPqgpVo=
X-Google-Smtp-Source: ABdhPJxxBOfkii6BsgRStLX2FXIfY/TE4D+8n0tPEcsDMKrIQWc/5E/f+2O4KOY0rQZUZE1bBa04GQ==
X-Received: by 2002:a63:c847:: with SMTP id l7mr16322643pgi.445.1618018527642;
        Fri, 09 Apr 2021 18:35:27 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id s21sm3893876pgl.36.2021.04.09.18.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 18:35:27 -0700 (PDT)
Date:   Sat, 10 Apr 2021 07:05:21 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH 4/6] staging: rtl8192e: matched alignment with open
 parenthesis
Message-ID: <YHEA2Te3Hik5J39t@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matched the alignment with open parenthesis to meet linux kernel coding
style.
Reported by checkpatch.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 20 ++++++++++----------
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 18 +++++++++---------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 0ded86da1562..12f31ba9aa13 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -154,7 +154,7 @@ bool IsHTHalfNmodeAPs(struct rtllib_device *ieee)
 	    (net->ralink_cap_exist))
 		retValue = true;
 	else if (!memcmp(net->bssid, UNKNOWN_BORADCOM, 3) ||
-		!memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) ||
+		 !memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) ||
 		!memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) ||
 		(net->broadcom_cap_exist))
 		retValue = true;
@@ -547,7 +547,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 			     pPeerHTCap, sizeof(struct ht_capab_ele));
 #endif
 	HTSetConnectBwMode(ieee, (enum ht_channel_width)(pPeerHTCap->ChlWidth),
-			  (enum ht_extchnl_offset)(pPeerHTInfo->ExtChlOffset));
+			   (enum ht_extchnl_offset)(pPeerHTInfo->ExtChlOffset));
 	pHTInfo->bCurTxBW40MHz = ((pPeerHTInfo->RecommemdedTxWidth == 1) ?
 				 true : false);
 
@@ -574,9 +574,9 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 
 	pHTInfo->bCurrentAMPDUEnable = pHTInfo->bAMPDUEnable;
 	if (ieee->rtllib_ap_sec_type &&
-	   (ieee->rtllib_ap_sec_type(ieee) & (SEC_ALG_WEP | SEC_ALG_TKIP))) {
+	    (ieee->rtllib_ap_sec_type(ieee) & (SEC_ALG_WEP | SEC_ALG_TKIP))) {
 		if ((pHTInfo->IOTPeer == HT_IOT_PEER_ATHEROS) ||
-				(pHTInfo->IOTPeer == HT_IOT_PEER_UNKNOWN))
+		    (pHTInfo->IOTPeer == HT_IOT_PEER_UNKNOWN))
 			pHTInfo->bCurrentAMPDUEnable = false;
 	}
 
@@ -626,7 +626,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 	else
 		pMcsFilter = MCS_FILTER_ALL;
 	ieee->HTHighestOperaRate = HTGetHighestMCSRate(ieee,
-				   ieee->dot11HTOperationalRateSet, pMcsFilter);
+						       ieee->dot11HTOperationalRateSet, pMcsFilter);
 	ieee->HTCurrentOperaRate = ieee->HTHighestOperaRate;
 
 	pHTInfo->CurrentOpMode = pPeerHTInfo->OptMode;
@@ -654,13 +654,13 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 	pHTInfo->CurrentAMPDUFactor = pHTInfo->AMPDU_Factor;
 
 	memset((void *)(&(pHTInfo->SelfHTCap)), 0,
-		sizeof(pHTInfo->SelfHTCap));
+	       sizeof(pHTInfo->SelfHTCap));
 	memset((void *)(&(pHTInfo->SelfHTInfo)), 0,
-		sizeof(pHTInfo->SelfHTInfo));
+	       sizeof(pHTInfo->SelfHTInfo));
 	memset((void *)(&(pHTInfo->PeerHTCapBuf)), 0,
-		sizeof(pHTInfo->PeerHTCapBuf));
+	       sizeof(pHTInfo->PeerHTCapBuf));
 	memset((void *)(&(pHTInfo->PeerHTInfoBuf)), 0,
-		sizeof(pHTInfo->PeerHTInfoBuf));
+	       sizeof(pHTInfo->PeerHTInfoBuf));
 
 	pHTInfo->bSwBwInProgress = false;
 
@@ -815,7 +815,7 @@ void HTUseDefaultSetting(struct rtllib_device *ieee)
 		HTFilterMCSRate(ieee, ieee->Regdot11TxHTOperationalRateSet,
 				ieee->dot11HTOperationalRateSet);
 		ieee->HTHighestOperaRate = HTGetHighestMCSRate(ieee,
-					   ieee->dot11HTOperationalRateSet,
+							       ieee->dot11HTOperationalRateSet,
 					   MCS_FILTER_ALL);
 		ieee->HTCurrentOperaRate = ieee->HTHighestOperaRate;
 
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 1b994a57633f..65eac33aaa5b 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -34,7 +34,7 @@ static void RxPktPendingTimeout(struct timer_list *t)
 		while (!list_empty(&pRxTs->rx_pending_pkt_list)) {
 			pReorderEntry = (struct rx_reorder_entry *)
 					list_entry(pRxTs->rx_pending_pkt_list.prev,
-					struct rx_reorder_entry, List);
+						   struct rx_reorder_entry, List);
 			if (index == 0)
 				pRxTs->rx_indicate_seq = pReorderEntry->SeqNum;
 
@@ -45,7 +45,7 @@ static void RxPktPendingTimeout(struct timer_list *t)
 				list_del_init(&pReorderEntry->List);
 
 				if (SN_EQUAL(pReorderEntry->SeqNum,
-				    pRxTs->rx_indicate_seq))
+					     pRxTs->rx_indicate_seq))
 					pRxTs->rx_indicate_seq =
 					      (pRxTs->rx_indicate_seq + 1) % 4096;
 
@@ -158,7 +158,7 @@ void TSInitialize(struct rtllib_device *ieee)
 
 		ResetTxTsEntry(pTxTS);
 		list_add_tail(&pTxTS->TsCommonInfo.List,
-				&ieee->Tx_TS_Unused_List);
+			      &ieee->Tx_TS_Unused_List);
 		pTxTS++;
 	}
 
@@ -276,7 +276,7 @@ static void MakeTSEntry(struct ts_common_info *pTsCommonInfo, u8 *Addr,
 
 	if (pTSPEC != NULL)
 		memcpy((u8 *)(&(pTsCommonInfo->TSpec)), (u8 *)pTSPEC,
-			sizeof(union tspec_body));
+		       sizeof(union tspec_body));
 
 	for (count = 0; count < TCLAS_Num; count++)
 		memcpy((u8 *)(&(pTsCommonInfo->TClass[count])),
@@ -355,14 +355,14 @@ bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 		if (TxRxSelect == TX_DIR) {
 			struct tx_ts_record *tmp =
 				container_of(*ppTS,
-				struct tx_ts_record,
-				TsCommonInfo);
+					     struct tx_ts_record,
+					     TsCommonInfo);
 			ResetTxTsEntry(tmp);
 		} else {
 			struct rx_ts_record *tmp =
 				 container_of(*ppTS,
-				 struct rx_ts_record,
-				 ts_common_info);
+					      struct rx_ts_record,
+					      ts_common_info);
 			ResetRxTsEntry(tmp);
 		}
 
@@ -409,7 +409,7 @@ static void RemoveTsEntry(struct rtllib_device *ieee,
 		while (!list_empty(&pRxTS->rx_pending_pkt_list)) {
 			pRxReorderEntry = (struct rx_reorder_entry *)
 					list_entry(pRxTS->rx_pending_pkt_list.prev,
-					struct rx_reorder_entry, List);
+						   struct rx_reorder_entry, List);
 			netdev_dbg(ieee->dev,  "%s(): Delete SeqNum %d!\n",
 				   __func__, pRxReorderEntry->SeqNum);
 			list_del_init(&pRxReorderEntry->List);
-- 
2.30.2

