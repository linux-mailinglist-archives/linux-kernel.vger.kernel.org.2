Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13BF35B393
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 13:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbhDKLgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 07:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbhDKLgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 07:36:13 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4F4C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 04:35:57 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id w10so7208979pgh.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 04:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zTJs2BTaTABCUyNSzygxb7w5Eiwv3e639bQ2LLKnHnM=;
        b=Mj4WQJXcma0VVgXG/XUr0XCRq3oX0Y9P0ITCXK1+tSYapq25iwmM2IdVbHfYeGgxod
         k1MZ+Kb8vS0ge4hkPhW68QAdRygMrHUuuOnfANT72Kvz8SM8hJC77boWoWUQGq4l9DgI
         svNHX+rgL9sFIH0evpLe6d/U74qC+sps0ZGswLPor38xfvV3IdHwsRltpR99idI4rE9W
         /QznuMRFXSBPkW3TV4VRn4bs5Lqg0pKZvPDHbj8GLAWDBtjCM1I2ubHXGtd5n9x8ERNm
         PDNblmivdRukkUyCeberzc0NkfBnVrx0RWiBt171trkFjzbV4D+I3cCqiU6Lkr/shQ40
         VDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zTJs2BTaTABCUyNSzygxb7w5Eiwv3e639bQ2LLKnHnM=;
        b=cpYh9Nzp7rdkg5DOcAGi6esQLR1ZTb82cU+pwRkAUeL/A0cG87k1j4cNm9SOu43tZj
         NngEoviaDLqTAuR4lTP0H4VyMbpnH+o8F4M52tP/bU9LWu27oVcLvhXa+MBeJ+FS7sfd
         CjBzmm73YnuiPvzsuwixYh8RKi1txoVMugHEwyk4dCYvRpjvW8QxiSXCL4tXZNKJOxxe
         IBQLvgRqxHzQaSAPuGiO2WICJ+7tdv6GJ37VDXXlfcpuEeuyTksyTna9jVpXTba1RJ5x
         cVT+zXbcdPa9XFlA3TUOxaVUpI1504rfWWv6jcA7nSjhGObgPmmqBwTxlI41WOlKf/cU
         Uw1Q==
X-Gm-Message-State: AOAM530WdrAMsFTvtyjUF2sRyMDRQ2fMi+Q72QnwmVVK/PuAPrqpMgRi
        UHhIHrhzvVZ3sQLwnmVcAgo=
X-Google-Smtp-Source: ABdhPJzzjfTQgNj1uOMSGiIM5Ixftq7aqAZORbDaUofhh2y/8KmJi8b6TJ57B7BY6Go3QTlP6S1TRA==
X-Received: by 2002:a62:2cc8:0:b029:23d:bd0d:2ac3 with SMTP id s191-20020a622cc80000b029023dbd0d2ac3mr20391256pfs.41.1618140956629;
        Sun, 11 Apr 2021 04:35:56 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id w1sm8151277pgh.26.2021.04.11.04.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 04:35:56 -0700 (PDT)
Date:   Sun, 11 Apr 2021 17:05:47 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v4 3/3] staging: rtl8192e: remove unnecessary parentheses
Message-ID: <29464cba775f9529db30b7fb4168198975098b55.1618139271.git.mitaliborkar810@gmail.com>
References: <cover.1618139271.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618139271.git.mitaliborkar810@gmail.com>
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

