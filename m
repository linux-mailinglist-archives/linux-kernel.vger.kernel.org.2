Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CE735C4F2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 13:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240300AbhDLLWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 07:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240287AbhDLLWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 07:22:43 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE34EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 04:22:25 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id b17so9114854pgh.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 04:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AagLpiU/5w+hbS3rSIWdhh9pnQqTVxdZ8rB4CC9+7cc=;
        b=FLTR6RBmPhwEinIlAiy2/1Ym/PLTq4voDNISociO5qk2JAVweN4mIVaj+wCS2Kb3q4
         bNButkxGaBeVmgyKYTOhCVvz6OZVpR23bCFynDvfZDa5zZT5XD0oz/0mjVGjsQVNTEXG
         cWJhJ2hb/ZFjC2bkUPsDKJM1vKQtfqLjboRFLvMrzBAZeCLKoE1m+CQNX2jIpAnOwZRh
         nby45/7cC+my89h/rZHYtdcbQrmvDYnSYLwzlRuV9O9dBvM3fwyhX+exK4Agce8PZXSf
         jbXDeMHJ5Hnhr2cuW1cMgQ0hKpIHEKGoAOUtPQMBFAqLAXn9up+/wqFAbOTxT3PDgN1f
         1zrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AagLpiU/5w+hbS3rSIWdhh9pnQqTVxdZ8rB4CC9+7cc=;
        b=oUe+mW1xhHIbDBeFByKuqnskSMk6pV+7tZ3bJYjp5o5SvtLaS2a4dHflUUSFhihDZJ
         OfnWsFMTIhDojebcKLeX76Vv+p99jLwELvN4tH24Cesnmb07FWJRN4iqzB7e8mvg5+il
         LZhW1ZaTmOdSV3TIV0p/kkBc3smdtZzL/8jk86G9KtvjIJbPqoTazh/OvMb9AXg/tTZL
         NJP4/4BR3wwU2pSmOTFo8thKI+GbgxguzzneiyWOTZGIv/FsmuF+dR9glPGPFo3Sof8O
         VM25BYv+XbaMnwXyfOrEXsSLSLt7u4/wUSS+U8gWbjUjoB7eTkfSPxqTG+MzK75PnlvG
         eLkQ==
X-Gm-Message-State: AOAM530nI4lFDfU7vdP9oFIiNmzqWleDSmhZo/yDQ/4Lx/i/yORCkZQs
        KSeH7bUl3TB6nR+yTVDwNrQ=
X-Google-Smtp-Source: ABdhPJz2LiuZnGHPVLAo0QQuXPbLVH1BQ/Fk7LABV/WHMKUBiZ966VP/dcczpkZJHnHgdug+7Z7x4g==
X-Received: by 2002:a62:de83:0:b029:23e:6d5f:b166 with SMTP id h125-20020a62de830000b029023e6d5fb166mr24149312pfg.78.1618226545431;
        Mon, 12 Apr 2021 04:22:25 -0700 (PDT)
Received: from kali ([103.141.87.253])
        by smtp.gmail.com with ESMTPSA id 123sm7085090pfx.180.2021.04.12.04.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:22:25 -0700 (PDT)
Date:   Mon, 12 Apr 2021 16:52:16 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v4 3/3] staging: rtl8192e: remove unnecessary parentheses
Message-ID: <29464cba775f9529db30b7fb4168198975098b55.1618224838.git.mitaliborkar810@gmail.com>
References: <cover.1618224838.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618224838.git.mitaliborkar810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unnecessary parentheses because they must be used only when it
is necessary or they improve readability.
Reported by checkpatch.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 
Changes from v3:- No changes.
Changes from v2:- Rectified spelling mistake in subject description.
Changes has been made in v3.
Changes from v1:- No changes.

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

