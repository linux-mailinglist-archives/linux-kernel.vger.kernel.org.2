Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9002A35EDE8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349700AbhDNG4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346591AbhDNGzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:55:33 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89A8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 23:55:11 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id g35so13690753pgg.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 23:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WOD1vszs28Y8cd70dkw1Qc027ESGrGzF9sDa2/FEUQE=;
        b=HDh7A9oc4N7gCKs6fksCjZvQrhMHeMGNy8B/Bwvd3c3O1kyh6Y+jMrRzPahdmbAJLJ
         p0ryiZGy8eu2jdPFlt9MBBbhkaex0cYqoI3kKZOCjxDQSmNdQEMs08Hi8Mq3DiJzuWz+
         7++AdU5v1ocTuEg+IJOSKCdxZYGSu3+52xG5K9QpY0gdXDTH88QblIGMkJV2MDDOsMGo
         t5VBJMWI/UeNauD+lbHpv+yTAtUhLTH4WHi4UCx5Xkr5eZBrQ4Nr2Tjb84Xi4iIA4d+Q
         kmX+WGsGKYr7HOxY1ZbxqpAGcHZV+VjnMp6nGbpYIWwZNOXMDwzXlD27EnhQg0KHJINe
         EMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WOD1vszs28Y8cd70dkw1Qc027ESGrGzF9sDa2/FEUQE=;
        b=X7uO4AMcbYdqHvjsyxYVSUTKF0hVqJuzLNnk/m6kx8g1JyT1n//Oijr/X6ZX+axvLC
         VPWL+f/RdvBJokb+T8J8UFpkrW44leZj99AaTQmpEUtBi4bBzeVa1Is3zvA7lsSKHqjP
         E8lLgINUMPq2/bDdtNPggsB7pp3l6OrDDz+I76eZS1CjctDRGMr6dBMEGvgj0m+wSdn6
         dB/UMI1IrQY5+AW40QmKfd/V0SkupsxzaUMdsLNA2+A/BGBEtI+Yup33l5yf0kafDshH
         Hb7mjZNXCchuEmOPxFIT197xRW+S2AZeeai/Ll4rbETqn+SDiAPRrnWqfvxkTwkGUElY
         lHRg==
X-Gm-Message-State: AOAM532RHZsQzeOy2WyGrzI8PkUuUAfyQkyWNEUR4CEjvtr4IrdaSgDp
        t+PXZHg9VGuGV3Sp04pq3g8=
X-Google-Smtp-Source: ABdhPJy+f626OZMcaa+3EmbKIiZF7LOh3EbLZZ6ZoPisNZCSLZ2LMBXciiGo2/19o4AydWhGyfD/XQ==
X-Received: by 2002:a65:6496:: with SMTP id e22mr36756023pgv.46.1618383311404;
        Tue, 13 Apr 2021 23:55:11 -0700 (PDT)
Received: from kali ([103.141.87.253])
        by smtp.gmail.com with ESMTPSA id j7sm5586444pfd.129.2021.04.13.23.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 23:55:11 -0700 (PDT)
Date:   Wed, 14 Apr 2021 12:25:03 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v2 1/5] staging: rtl8192e: add spaces around binary operators
Message-ID: <28cbc4825fdfacf5d5ea8bb688a8bd6a1c65f059.1618380932.git.mitaliborkar810@gmail.com>
References: <cover.1618380932.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618380932.git.mitaliborkar810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added spaces around binary operators like '+', '*', '|', '-', '&',
to improve readability and to meet linux kernel coding style.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 
Changes from v1:- No changes.

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 8 ++++----
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 4a2968566b93..b74c6ac817d4 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -138,7 +138,7 @@ u16  TxCountToDataRate(struct rtllib_device *ieee, u8 nDataRate)
 		is40MHz = 1;
 		isShortGI = 1;
 	}
-	return MCS_DATA_RATE[is40MHz][isShortGI][nDataRate&0xf];
+	return MCS_DATA_RATE[is40MHz][isShortGI][nDataRate & 0xf];
 }
 
 bool IsHTHalfNmodeAPs(struct rtllib_device *ieee)
@@ -479,8 +479,8 @@ u8 HTGetHighestMCSRate(struct rtllib_device *ieee, u8 *pMCSRateSet,
 		if (availableMcsRate[i] != 0) {
 			bitMap = availableMcsRate[i];
 			for (j = 0; j < 8; j++) {
-				if ((bitMap%2) != 0) {
-					if (HTMcsToDataRate(ieee, (8*i+j)) >
+				if ((bitMap % 2) != 0) {
+					if (HTMcsToDataRate(ieee, (8 * i + j)) >
 					    HTMcsToDataRate(ieee, mcsRate))
 						mcsRate = 8 * i + j;
 				}
@@ -577,7 +577,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 
 	pHTInfo->bCurrentAMPDUEnable = pHTInfo->bAMPDUEnable;
 	if (ieee->rtllib_ap_sec_type &&
-	   (ieee->rtllib_ap_sec_type(ieee)&(SEC_ALG_WEP|SEC_ALG_TKIP))) {
+	   (ieee->rtllib_ap_sec_type(ieee) & (SEC_ALG_WEP | SEC_ALG_TKIP))) {
 		if ((pHTInfo->IOTPeer == HT_IOT_PEER_ATHEROS) ||
 				(pHTInfo->IOTPeer == HT_IOT_PEER_UNKNOWN))
 			pHTInfo->bCurrentAMPDUEnable = false;
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 6c51323104e5..b14ed3534ffa 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -104,7 +104,7 @@ static void ResetTsCommonInfo(struct ts_common_info *pTsCommonInfo)
 {
 	eth_zero_addr(pTsCommonInfo->Addr);
 	memset(&pTsCommonInfo->TSpec, 0, sizeof(union tspec_body));
-	memset(&pTsCommonInfo->TClass, 0, sizeof(union qos_tclas)*TCLAS_NUM);
+	memset(&pTsCommonInfo->TClass, 0, sizeof(union qos_tclas) * TCLAS_NUM);
 	pTsCommonInfo->TClasProc = 0;
 	pTsCommonInfo->TClasNum = 0;
 }
@@ -188,9 +188,9 @@ void TSInitialize(struct rtllib_device *ieee)
 	for (count = 0; count < REORDER_ENTRY_NUM; count++) {
 		list_add_tail(&pRxReorderEntry->List,
 			      &ieee->RxReorder_Unused_List);
-		if (count == (REORDER_ENTRY_NUM-1))
+		if (count == (REORDER_ENTRY_NUM - 1))
 			break;
-		pRxReorderEntry = &ieee->RxReorderEntry[count+1];
+		pRxReorderEntry = &ieee->RxReorderEntry[count + 1];
 	}
 
 }
@@ -517,7 +517,7 @@ void TsStartAddBaProcess(struct rtllib_device *ieee, struct tx_ts_record *pTxTS)
 				  msecs_to_jiffies(TS_ADDBA_DELAY));
 		} else {
 			netdev_dbg(ieee->dev, "Immediately Start ADDBA\n");
-			mod_timer(&pTxTS->TsAddBaTimer, jiffies+10);
+			mod_timer(&pTxTS->TsAddBaTimer, jiffies + 10);
 		}
 	} else
 		netdev_dbg(ieee->dev, "BA timer is already added\n");
-- 
2.30.2

