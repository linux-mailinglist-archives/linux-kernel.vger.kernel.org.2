Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CD135A9F7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 03:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbhDJBfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 21:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbhDJBfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 21:35:53 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C6BC061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 18:35:39 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso5810064pji.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 18:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=UypD/qBMLUB6o+gYkcDEMH+/YYMDUSAMeMwPH9I+xZM=;
        b=GsvFfEE+y9TWs8iItPTW1QOD0A/A/DaDpzhKO86OcIYBj1qzNdOB1dbdsWfeWu6ZS4
         BWOdznuh1HBlhARQtZS0NC7xRURaVFH87nsZ0U0BWm76xdtvipaV44WRuUBnhk22uS/C
         SdwP0gVA9/DbO+g+eEVI6H6XoF812gZxyygh798ZjRNgpuwgLDns11TVY6+ZYXOZZEC4
         FGAeiEQtxExvJdxy7rLScE65q4SZCy/TTE/K1LUxZOWnW0V4QE6rpkozfHLAT8AfNDL2
         8AGlGEvBrLUrcrMIBozPMYItM4irGm5T0Vy+WHUim+1F94dl8pJrvl7NrMvtCVFkGX/F
         qFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=UypD/qBMLUB6o+gYkcDEMH+/YYMDUSAMeMwPH9I+xZM=;
        b=Eet0dw+DzaH4Zm7wQ1/MVxa0hXEe673mjT0mjso5gnmDMLGg5REYLQa5XBttPu12fA
         No7nsM+6zXMLqiGFh9Hvpg6OPUbdGvPYN6b8lyVt8z36xdY9GlC/zin3Ts25+X0rcquF
         XQMkJSfAMZExOAKwoJ4ds0tmBYQ1Zb/txMWf7JAwL4ASr5uBKqRCCmMtodU/UQkBcXvF
         eKPKKIyn4b94bt7AhwCQlmFu7ZR3gyWcNEvGNNUuP6cHwxfB1azU2iWj9kFovGk4ZZQi
         gJd6BvA8cXbuMmuz9hhf+96yHbHmQ0X3Eo2DwBmw4Mul6gZ/6cyO4ThejB1uc3lb6hb6
         Gb/Q==
X-Gm-Message-State: AOAM5339LWC4AFtMfeFEDXy129LteV8A3+EDNbwH5NJqSieWSkjaEFKp
        /p+AyO3j53RvDZlKHAXarPdaqdrYiwdZhQ==
X-Google-Smtp-Source: ABdhPJzewxRxDZYUYHkqn5vcntQo/XurFBdC5uclAagbjBtcKOQYX1rFC/kvZdcAidqhbvqAmhaOQg==
X-Received: by 2002:a17:90b:33c7:: with SMTP id lk7mr16681837pjb.95.1618018539509;
        Fri, 09 Apr 2021 18:35:39 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id m7sm3312883pfd.52.2021.04.09.18.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 18:35:39 -0700 (PDT)
Date:   Sat, 10 Apr 2021 07:05:33 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH 5/6] staging: rtl8192e: removed multiple blank lines
Message-ID: <YHEA5QW6kbhfZ4k+@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed multiple blank lines to make code better and neater.
Reported by checkpatch.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 12f31ba9aa13..2b9e275f42bb 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -214,7 +214,6 @@ static u8 HTIOTActIsDisableMCS14(struct rtllib_device *ieee, u8 *PeerMacAddr)
 	return 0;
 }
 
-
 static bool HTIOTActIsDisableMCS15(struct rtllib_device *ieee)
 {
 	return false;
@@ -236,7 +235,6 @@ static u8 HTIOTActIsMgntUseCCK6M(struct rtllib_device *ieee,
 {
 	u8	retValue = 0;
 
-
 	if (ieee->pHTInfo->IOTPeer == HT_IOT_PEER_BROADCOM)
 		retValue = 1;
 
@@ -315,7 +313,6 @@ void HTConstructCapabilityElement(struct rtllib_device *ieee, u8 *posHTCap,
 	pCapELE->PSMP = 0;
 	pCapELE->LSigTxopProtect = 0;
 
-
 	netdev_dbg(ieee->dev,
 		   "TX HT cap/info ele BW=%d MaxAMSDUSize:%d DssCCk:%d\n",
 		   pCapELE->ChlWidth, pCapELE->MaxAMSDUSize, pCapELE->DssCCk);
@@ -390,7 +387,6 @@ void HTConstructInfoElement(struct rtllib_device *ieee, u8 *posHTInfo,
 
 		memset(pHTInfoEle->BasicMSC, 0, 16);
 
-
 		*len = 22 + 2;
 
 	} else {
@@ -541,7 +537,6 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 	else
 		pPeerHTInfo = (struct ht_info_ele *)(pHTInfo->PeerHTInfoBuf);
 
-
 #ifdef VERBOSE_DEBUG
 	print_hex_dump_bytes("%s: ", __func__, DUMP_PREFIX_NONE,
 			     pPeerHTCap, sizeof(struct ht_capab_ele));
@@ -562,7 +557,6 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 			       ((pPeerHTCap->DssCCk == 1) ? true :
 			       false) : false);
 
-
 	pHTInfo->bCurrent_AMSDU_Support = pHTInfo->bAMSDU_Support;
 
 	nMaxAMSDUSize = (pPeerHTCap->MaxAMSDUSize == 0) ? 3839 : 7935;
@@ -752,7 +746,6 @@ void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
 		if (bIOTAction)
 			pHTInfo->IOTAction |= HT_IOT_ACT_DISABLE_ALL_2SS;
 
-
 		bIOTAction = HTIOTActIsDisableEDCATurbo(ieee, pNetwork->bssid);
 		if (bIOTAction)
 			pHTInfo->IOTAction |= HT_IOT_ACT_DISABLE_EDCA_TURBO;
-- 
2.30.2

