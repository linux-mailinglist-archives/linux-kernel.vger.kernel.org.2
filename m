Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4E735AA44
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 04:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbhDJCNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 22:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhDJCNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 22:13:30 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B7AC061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 19:13:16 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a85so4968028pfa.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 19:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=nPOFyIIlua33yWGhXrEphFLgIKlagAmifofs3UcXjLU=;
        b=pou+hH1r5XCVI4nwllZpV2muFqU45ynq/ro4ciJaA15IfBIAgZuzBR19o4diZVKePh
         36c4fWXFHl+jr+z+s1t5UsmCJ/RfLoAoVBoh6kvWbGZSjRzfdpIdGeqU/1iQwa1dJEY1
         Lxr1ZC2/d1vESMsWWKJfGfAAHEO4T4FLBOHi29ePiItf25XvdKD4yPLdaUcs9Pu8XAgc
         H0akB4IjgvYEODSOGouQIi8/1LFEqD4CNfByXfiHRIm4d/VBSvaLysXI5EUsIsAiCbyG
         NEaIoIYff9bryGVI9wye4Mk3FIn1TbRJuA1sFhY+FT3wLspysiXjh0k9+rOxLI7PE5uP
         AXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=nPOFyIIlua33yWGhXrEphFLgIKlagAmifofs3UcXjLU=;
        b=OEVI+20I8F6hRrX5JEqZtA4d1zGtbCUGfu//CkVVCd8Bnkv2cPBUmJSmwSEQkHmqZJ
         KcOgA3pDrl9dfIh62uys1pbU5MFbAP26GqhfvUfta1PCgIzlbCQ0k1JFkiTOl7DeeDo5
         LD402KvoYHhFCZJufKUdnUcISq1OHYgA4VJudJnu6zW92oS2w07/RYifCZz39RPnZegW
         UjIFsspAcxus3W+2FEIAH2L9VV7QDqYHySEi+YpPAIeszDYmLniYmbstz52xlu/Nfwhy
         WtOOpiO8vvNEcgEoi5hccO3fYel6DgSq3GPxY4KiVlKa4GROQK0XGUhG+Vu8e3WOk8FM
         74eA==
X-Gm-Message-State: AOAM532Ijk39TggW7EBZSUJUUdz/3+wpcOlWOOUKlfyR6RAqe1Vu7bYE
        CAQkMj9FvmVPfOsLQs4JLsk=
X-Google-Smtp-Source: ABdhPJx6A9m9dxKB1E5XyPPTqYzNk5zTivMr3wfmnlGaTgzuVo7/6vOwyx0MQ2nOOYcBD+UNxuUEhA==
X-Received: by 2002:a63:544e:: with SMTP id e14mr16749833pgm.288.1618020795974;
        Fri, 09 Apr 2021 19:13:15 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id q14sm4174933pgt.54.2021.04.09.19.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 19:13:15 -0700 (PDT)
Date:   Sat, 10 Apr 2021 07:43:10 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH 3/3] staging: rtl8192e: remove unncessary parentheses
Message-ID: <YHEJtkbGtHmajJIt@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unnecessary parentheses because they must be used only when it
is necessary or they improve readability.
Reported by checkpatch.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 89d0e9ec188d..b1fa8e9a4f28 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -287,7 +287,7 @@ void HTConstructCapabilityElement(struct rtllib_device *ieee, u8 *posHTCap,
 		u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};
 
 		memcpy(posHTCap, EWC11NHTCap, sizeof(EWC11NHTCap));
-		pCapELE = (struct ht_capab_ele *)&(posHTCap[4]);
+		pCapELE = (struct ht_capab_ele *)&posHTCap[4];
 		*len = 30 + 2;
 	} else {
 		pCapELE = (struct ht_capab_ele *)posHTCap;
@@ -646,13 +646,13 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 	pHTInfo->CurrentMPDUDensity = pHTInfo->MPDU_Density;
 	pHTInfo->CurrentAMPDUFactor = pHTInfo->AMPDU_Factor;
 
-	memset((void *)(&(pHTInfo->SelfHTCap)), 0,
+	memset((void *)(&pHTInfo->SelfHTCap), 0,
 	       sizeof(pHTInfo->SelfHTCap));
-	memset((void *)(&(pHTInfo->SelfHTInfo)), 0,
+	memset((void *)(&pHTInfo->SelfHTInfo), 0,
 	       sizeof(pHTInfo->SelfHTInfo));
-	memset((void *)(&(pHTInfo->PeerHTCapBuf)), 0,
+	memset((void *)(&pHTInfo->PeerHTCapBuf), 0,
 	       sizeof(pHTInfo->PeerHTCapBuf));
-	memset((void *)(&(pHTInfo->PeerHTInfoBuf)), 0,
+	memset((void *)(&pHTInfo->PeerHTInfoBuf), 0,
 	       sizeof(pHTInfo->PeerHTInfoBuf));
 
 	pHTInfo->bSwBwInProgress = false;
@@ -668,7 +668,7 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 	pHTInfo->IOTRaFunc = 0;
 
 	{
-		u8 *RegHTSuppRateSets = &(ieee->RegHTSuppRateSet[0]);
+		u8 *RegHTSuppRateSets = &ieee->RegHTSuppRateSet[0];
 
 		RegHTSuppRateSets[0] = 0xFF;
 		RegHTSuppRateSets[1] = 0xFF;
-- 
2.30.2

