Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BC635B2EE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 11:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbhDKJ4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 05:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhDKJ4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 05:56:19 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38F2C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 02:56:03 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d8so4791664plh.11
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 02:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/rlS+5t+v4UNQErM732BFvhcFr/EzAmioR8Qn4jYDRE=;
        b=Q7pVt2SSzxpa69mlDrb+533e9sYFCBLLnzwTBAmKrpikVaZt5PUT7AW69fbBi3WoXd
         pniPCjCx1yUrqGGU50ztCfRK9F0YvuGAYfYskemanMtAWRpDEUaRbVoTJLm0fswpw9Z0
         30xdc4KS0AAou3vfTcYxtUIwFnYaB2NtUjsaXnh1+ElS1LOTgNhr7uTKL7/sTfm1xCPi
         hfN4ZZlERDDJm5an3QTPcvHJuK38Df6YuzOy8K/3igLbN7it0rVgMAPSf6weSAbD3hTV
         1VhgujsW27Ai6l4uhDSQwc/GFb/HCtPAPFG+G5TcRZ6c+P8PQiJXP3g8ebbhuySqb9/b
         Qggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/rlS+5t+v4UNQErM732BFvhcFr/EzAmioR8Qn4jYDRE=;
        b=JaFcl7oO8TZk7nife5brqSUGZH5SNeDwfGEm04iPXO5+HfbUAG8/gRojii6GF7Otqa
         25URIXy17//Hb5+zn6sevK+voCR0m7aNlTRHgUo2WNKYbR4k7DTFD6XlE/hN9kC4Hs+j
         puyllbDuT7/nn0nhU0LFOwa9tpgKzY8iL7GQJuCfMxkmNk91ZFL7o4C+XJ5WMpVfyhQL
         MQSLrDT8VYu7rNN5Yosmn0CI5RAsQw3eF38C89v5w52hgeSoycTSOmBU2/Mpdki5eD+5
         Liy4BQFjLH3u5rPKxL0w6H/ju6zVKE7IuevaeBb4l7j2kId0MGsI5BWIVjOEc0+mgzg+
         lBkQ==
X-Gm-Message-State: AOAM533dXTC7FBDGeBYA6Ha6as9oIKNyE4WiLkMpku/huNEElja+NN+d
        DLdDyuJU5Gb9G+/KgtIoFdE=
X-Google-Smtp-Source: ABdhPJypnSaidHAhJSCiqlXLISeBKKl7f2a4oEMfJoXurYuBCjEY04HFCyqRlPtZGMiDmJZ0f8Z1cA==
X-Received: by 2002:a17:90b:1b4e:: with SMTP id nv14mr23602815pjb.115.1618134963139;
        Sun, 11 Apr 2021 02:56:03 -0700 (PDT)
Received: from kali ([103.141.87.253])
        by smtp.gmail.com with ESMTPSA id v6sm3868283pfb.130.2021.04.11.02.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 02:56:02 -0700 (PDT)
Date:   Sun, 11 Apr 2021 15:25:55 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v3 3/3] staging: rtl8192e: remove unnecessary parentheses
Message-ID: <29464cba775f9529db30b7fb4168198975098b55.1618133351.git.mitaliborkar810@gmail.com>
References: <cover.1618133351.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618133351.git.mitaliborkar810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unnecessary parentheses because they must be used only when it
is necessary or they improve readability.
Reported by checkpatch.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 
Changes from v2:- Rectified spelling mistake in subject description.
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

