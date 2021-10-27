Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7D043D0D5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 20:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243590AbhJ0Shf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 14:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243575AbhJ0ShT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 14:37:19 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4D2C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:34:53 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id g184so3782104pgc.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=rZ1FB3CWtcfDgjKcIVRiQbXOzmz1nIz649iaBjymSHo=;
        b=mrbbF+vgf43ds9NpeoL/+XuV3Xfrdr6jd3L521mLardiqMytamE3RyxWtCFwhN/0Ft
         wHgvxePuJ/275+kqYouKBlRHPAApF9e6vLWbVAGo26/rB+YWRlHJvoF9tg8mPSc997O1
         fJiDIHm7ytyi+X+p6ScerhojaTKizMdoKurHDzHAUDpiLJkqHk9DF+MmlOguCUSGSEgy
         4NtDDd5NWoBZHCJZv6Oou0GMlYh/Hb5nX4FYCZb4Q+AmcYgVeJl/rGbB6y5JqAT2n4fP
         ML/q1PkhKWOQ2aVt6E5gwLzysXU7j+JUBVqPaXw7EVN+zd/Je4g5qP31PVnt6b8ehaZ3
         zVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=rZ1FB3CWtcfDgjKcIVRiQbXOzmz1nIz649iaBjymSHo=;
        b=U/yNE+wX2Z9OqI2f3mrq9uzXKOilVOUsl84/92KfbVoKvFbKnAVN4996pdjj+UGmbW
         3JVs6ovhj8ORpNi7bHu5fQKBBCylRNHPuMJCOrtdPa0qTa3AkpkVoYqyJYJimuvcGBJ9
         oVWGlet8unReTlKcybSyYpTu6tGqSFst7fyEZbG+5EkGehTASUG2qOi85gZweRvfD8zJ
         kFPdisURv5veFJ7rQ7ytxODwGXo+I98JHudCGxwKM2gknqTkNzrj0H6Wu8VeuWKPjoFO
         9MATE5kJ7wi61w0EgUO4VzaHdCBmPAZ8X0wqACCgw4kps2T/aasaiNrWX5Yhgg+PdKoB
         XdIQ==
X-Gm-Message-State: AOAM5332qn9qPsKpEuJQBAEPhberbedtlDDQzsx9UzsWQTTOIlhTEY5H
        qAMaBlae0r/E7qAGJI5HKac=
X-Google-Smtp-Source: ABdhPJyGnmA2pc2Astk74/frWI2/SMTiF094cWxXNalcN9sUhHtVsSOPu/xxYGoE57wt6MqhIHVOuQ==
X-Received: by 2002:a63:2cd8:: with SMTP id s207mr25375160pgs.312.1635359692896;
        Wed, 27 Oct 2021 11:34:52 -0700 (PDT)
Received: from Sauravs-MacBook-Air.local ([59.95.83.133])
        by smtp.gmail.com with ESMTPSA id k14sm419556pji.45.2021.10.27.11.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 11:34:51 -0700 (PDT)
Date:   Thu, 28 Oct 2021 00:04:43 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
        will+git@drnd.me, mitaliborkar810@gmail.com,
        eduard.vintila47@gmail.com, saurav.girepunje@gmail.com,
        zhaoxiao@uniontech.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: rtl8192e: remove condition with no effect
Message-ID: <YXmap8VIxfOpqeEY@Sauravs-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the if and else code section for variable pHTInfo->bRegBW40MHz.
Just before the if condition variable is assign with value 1.
So if condition check for pHTInfo->bRegBW40MHz is always true.

Similarly for the variable pHTInfo->SelfMimoPs value '3' is assign.
So if condition check with value '2' will never be true. Remove the
if condition check for pHTInfo->SelfMimoPs.

Remove the extra blank lines from HTUpdateDefaultSetting function.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 3b8efaf9b88c..6925654dbc03 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -72,34 +72,20 @@ void HTUpdateDefaultSetting(struct rtllib_device *ieee)
 	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;

 	pHTInfo->bAcceptAddbaReq = 1;
-
 	pHTInfo->bRegShortGI20MHz = 1;
 	pHTInfo->bRegShortGI40MHz = 1;
-
 	pHTInfo->bRegBW40MHz = 1;
-
-	if (pHTInfo->bRegBW40MHz)
-		pHTInfo->bRegSuppCCK = 1;
-	else
-		pHTInfo->bRegSuppCCK = true;
-
+	pHTInfo->bRegSuppCCK = 1;
 	pHTInfo->nAMSDU_MaxSize = 7935UL;
 	pHTInfo->bAMSDU_Support = 0;
-
 	pHTInfo->bAMPDUEnable = 1;
 	pHTInfo->AMPDU_Factor = 2;
 	pHTInfo->MPDU_Density = 0;
-
 	pHTInfo->SelfMimoPs = 3;
-	if (pHTInfo->SelfMimoPs == 2)
-		pHTInfo->SelfMimoPs = 3;
 	ieee->bTxDisableRateFallBack = 0;
 	ieee->bTxUseDriverAssingedRate = 0;
-
 	ieee->bTxEnableFwCalcDur = 1;
-
 	pHTInfo->bRegRT2RTAggregation = 1;
-
 	pHTInfo->bRegRxReorderEnable = 1;
 	pHTInfo->RxReorderWinSize = 64;
 	pHTInfo->RxReorderPendingTime = 30;
--
2.33.0

