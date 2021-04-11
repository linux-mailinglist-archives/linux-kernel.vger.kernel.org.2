Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C4235B18B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 06:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbhDKEfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 00:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhDKEfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 00:35:08 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808B4C06138B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 21:34:53 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t23so4878100pjy.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 21:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T2DCR+pBRj77mnajpSp0QIz6gQyKylZyF8pvYWlFKCA=;
        b=Cnv3VZMvBNQpIlTF30kymRPMQrSvVe3fkJYRDqsHjQHiiI65jQxEUulF0dyfT3+2k7
         zHVBKdpDjs0E797AU7Ti5dSzp3KjuIn4NG6AQuEaHHkIJYExvNcC6ddfTtHUQDBpt1Lr
         STsZw71UMU2WLpcCBjJsnGOh6DlDaGE3JDjfF5rTPS83zma1M5WPeYOd2wz+mCJMJeX4
         0OReNZM10rTBwHFSMphTIpN0avoyr5U1CRQ3G92NH6i4MLwOZSNFGeukltHjhT5avzAx
         Mp8TgGjkqMB5um3ZxWKpxBj1fWgIgHgLRS70Lxh/rg82x7bT3s4BbOIjH3KNqhBwUYXc
         2HOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T2DCR+pBRj77mnajpSp0QIz6gQyKylZyF8pvYWlFKCA=;
        b=bKRsH4oxpmg6wNwKEr2z9b/vSSd9P4Ymi7TPZDhbiAHx0QJv7F7n4q9mC6ZdnxUFS8
         Ae+xUN6DoDePshxu/YtlxSXGd3WNBqbC6K0zNsXeMnMifd3qi3Nwt+QsduhdZ3z8M5Wk
         v18ZU0Ddd0TMKA0VPBm1qW5O8NOJSwd8nn+xsxOtxXt51Jp+idDw+FLBNtD/waDm6Cmw
         CHAgw+RrnJ6wKLKQsGmnhNtZqouQ1ck+DQskj6a8WAHcyFuSw/G4eWEIzM1kTypKNxW6
         PJ09Ji56+8Mb6JX/tE9py9rs43ESA9IHVE3939hF9C119uitc1zR5fXuugI5IUD5Oeph
         +xtw==
X-Gm-Message-State: AOAM533huj/o377aaDAIhGX/ctZvV7sd0P98A6iVjMwU7MWKrzLU596Q
        QpOvM7kmY3tjH+aDS2WHquM2ENZL1u6xVg==
X-Google-Smtp-Source: ABdhPJw0Gr1/G08jbHMa4Woz9j/Esc6kGoPMgZSgZGq7dAjUvpgkuPJRHEUAr6zUoStB+Y4boBDuVA==
X-Received: by 2002:a17:90a:1502:: with SMTP id l2mr21502228pja.149.1618115693009;
        Sat, 10 Apr 2021 21:34:53 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id y29sm6250926pfp.206.2021.04.10.21.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 21:34:52 -0700 (PDT)
Date:   Sun, 11 Apr 2021 10:04:46 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v2 3/3] staging: rtl8192e: remove unncessary parentheses
Message-ID: <1365e7d8dc76842e6fd9d9842bfef1ddd548b4f9.1618110617.git.mitaliborkar810@gmail.com>
References: <cover.1618110617.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618110617.git.mitaliborkar810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unnecessary parentheses because they must be used only when it
is necessary or they improve readability.
Reported by checkpatch.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---

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

