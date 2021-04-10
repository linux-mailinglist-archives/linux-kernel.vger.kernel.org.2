Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF7235AA42
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 04:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbhDJCNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 22:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDJCNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 22:13:06 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D0FC061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 19:12:52 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso4080587pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 19:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=WGt33fyzs9vaRoy1gnWqTwImiQXUTfb1a9wEvlX+v/4=;
        b=cCUx/8TwT17qk8zeQrZ9Qtp+w7FhtWgrLg246MkazYfJi77Tp7oAxqrbS/PicqPNr0
         lVMJbEizklYWV7f0ff1S+h2hMm19PdfEiFZF1nKNMux1PksBfyBZknOrSO58mHt5DxYN
         cxTTKMVRlmS8uL1BcLKNlSPOuSEbjaGzcEyp2PqQ7+DZICjKssAGMoW5WcdJDdtrw3r+
         3CMS9Hf9rl2tZYWZF/Q6PZzzb8t77b9UW1cVFibNecvPmS3+Maay6Fy0jXKb7hObayDI
         A6wQ8iMEMkwUV7AWB5dfPWcvIzlJSWluoEsVAFMiaztX1QrzZUwAR0z3g3aJ7yUsOxZn
         Oxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=WGt33fyzs9vaRoy1gnWqTwImiQXUTfb1a9wEvlX+v/4=;
        b=ACAL3oOePIvALZ5Ae7mf1pwenzrpytDb9kkGIR0lY3MirA0D3qLcigRf28ETBWVsr6
         IMYLsUUH4hQx3EEhR6B9XagQxHJBV4su4SYYav3A09J7uSnIhDNm4zDzWEXFd7JH44IF
         /LJScmMlXXPW6B5jB8o6ecdyqxfG3HEfkQAwe8psC7aRyFayqg6k1dfTnBJmiJmYc3q8
         gIIA9RjroSfksVK/PMrrkDETwtqBrW8+/+vKIMvzPdXh2fK64uARMZ/uK/JPGiZpxnE/
         g358qd+F75Q9shqWf8TnFNThCwc8yXtLQyq2dYVuEht+jsTwBXpWa0/muGSmqhh/oNJY
         xP/g==
X-Gm-Message-State: AOAM530nmNPywAoFatULLn3IxHM47tTawcsBdH6BgyJcSRdNOpc1B7j5
        EzKRbvwvFifYh/VA7cZUSPk=
X-Google-Smtp-Source: ABdhPJyb358NYQKZqWdsSp5glOG9T653mysoNaLWGEv4nACSePa6ZkgA+PmOGY1JqY0xsWPtNtcTBg==
X-Received: by 2002:a17:902:bd4b:b029:e6:a4a1:9d8b with SMTP id b11-20020a170902bd4bb02900e6a4a19d8bmr16124572plx.56.1618020772346;
        Fri, 09 Apr 2021 19:12:52 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id y15sm4227966pgi.31.2021.04.09.19.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 19:12:51 -0700 (PDT)
Date:   Sat, 10 Apr 2021 07:42:46 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH 1/3] staging: rtl8192e: replace comparison to NULL by boolean
Message-ID: <YHEJngq5MHBEspGY@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced comparison to NULL by boolean expressions
(here used boolean negations). This improves readability of code.
Reported by checkpatch.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 65202dd53447..0b1e92f17805 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -276,7 +276,7 @@ void HTConstructCapabilityElement(struct rtllib_device *ieee, u8 *posHTCap,
 	struct rt_hi_throughput *pHT = ieee->pHTInfo;
 	struct ht_capab_ele *pCapELE = NULL;
 
-	if ((posHTCap == NULL) || (pHT == NULL)) {
+	if ((!posHTCap) || (!pHT)) {
 		netdev_warn(ieee->dev,
 			    "%s(): posHTCap and pHTInfo are null\n", __func__);
 		return;
@@ -357,7 +357,7 @@ void HTConstructInfoElement(struct rtllib_device *ieee, u8 *posHTInfo,
 	struct rt_hi_throughput *pHT = ieee->pHTInfo;
 	struct ht_info_ele *pHTInfoEle = (struct ht_info_ele *)posHTInfo;
 
-	if ((posHTInfo == NULL) || (pHTInfoEle == NULL)) {
+	if ((!posHTInfo) || (!pHTInfoEle)) {
 		netdev_warn(ieee->dev,
 			    "%s(): posHTInfo and pHTInfoEle are null\n",
 			    __func__);
@@ -397,7 +397,7 @@ void HTConstructInfoElement(struct rtllib_device *ieee, u8 *posHTInfo,
 void HTConstructRT2RTAggElement(struct rtllib_device *ieee, u8 *posRT2RTAgg,
 				u8 *len)
 {
-	if (posRT2RTAgg == NULL) {
+	if (!posRT2RTAgg) {
 		netdev_warn(ieee->dev, "%s(): posRT2RTAgg is null\n", __func__);
 		return;
 	}
@@ -420,7 +420,7 @@ static u8 HT_PickMCSRate(struct rtllib_device *ieee, u8 *pOperateMCS)
 {
 	u8 i;
 
-	if (pOperateMCS == NULL) {
+	if (!pOperateMCS) {
 		netdev_warn(ieee->dev, "%s(): pOperateMCS is null\n", __func__);
 		return false;
 	}
@@ -453,7 +453,7 @@ u8 HTGetHighestMCSRate(struct rtllib_device *ieee, u8 *pMCSRateSet,
 	u8		mcsRate = 0;
 	u8		availableMcsRate[16];
 
-	if (pMCSRateSet == NULL || pMCSFilter == NULL) {
+	if (!pMCSRateSet || !pMCSFilter) {
 		netdev_warn(ieee->dev,
 			    "%s(): pMCSRateSet and pMCSFilter are null\n",
 			    __func__);
-- 
2.30.2

