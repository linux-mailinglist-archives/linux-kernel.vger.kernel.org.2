Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394A535A9F8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 03:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbhDJBgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 21:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbhDJBgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 21:36:04 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86854C061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 18:35:50 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id g10so3572905plt.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 18:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=vd8lMgu3zkr2z6g7xcisDVvdvTxxf93W5Kur6M5AgCE=;
        b=pjWwg+1y5IL9DISwRYtHV5mqgLMoNyUUSI8L2ZaCDgnAhgNKtgmpczwGAoAaM/YHNO
         piGExD3Hsl+9zazWBVqpupyQCmTNh79HGaoxKii5uU0HJ7/t+w58yg55KeyaRgiQtRbV
         D0H+xf7lDtYr2nX4QDJ64y/26kijC+/9PvAFnyJZUJhhiasMVmfZdSpFo4D4CpFc/27Q
         0qg2OvRUI1z81wiG+wgKYpyif+j8kvZ8ehtbCas7oNcRUqLIeArCQZjPYzo3utaeA2l6
         tY8TRx1h4i16MQjOl7Paa2tzI97k/jWcJHZo2G6ENcJp3ODzygwviwRjQ4e49dRk0TrW
         vlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=vd8lMgu3zkr2z6g7xcisDVvdvTxxf93W5Kur6M5AgCE=;
        b=LwjYR5GRlaeg94fddQNSbzfMoW4tv8ibQ2n+h4JUcmFwEyZlI+Ap7u97+3TmhzF3qM
         mbQ9NPeRBXqpbgCAXhIwlHq3Wft/V8w3ul/Ax05o3hOehj2RNQZ096IKwTDsre/k7vrK
         Bt/LcIFZP5viMTJnnaB+Ef82aBNMkUbL9BglRfJ0gVfT25diuvbkDEalUS9D4dXSkXzk
         g9IKS8/GpiKIHACuPmPOHxd9K9zdMmFHxfQxeTvNqRsk0GKF3BMt0kexy4B3SWARrIie
         3tZwq+KlqT5JbiZ70Ic3Ch4H+snpgbHNJF52v1KZGpzPry0scglTpTvLRt2myy+HsKIC
         L5dA==
X-Gm-Message-State: AOAM530sVAKt4ywlsgDmeBIUuQhXumL6ED8nzQt5XY5JQzaKGDBxdj4F
        tTqr/Bv+ed3go+CCUbHDOzZ4gz+tTqSbBg==
X-Google-Smtp-Source: ABdhPJyAXgEMAGxMzgkToJGpihLSoY6PKV6GJHaGOCDQSsp2uyZk0f3r9/ddmsDUQ7rTG+g32bs4sg==
X-Received: by 2002:a17:903:2306:b029:e7:1c8d:63fc with SMTP id d6-20020a1709032306b02900e71c8d63fcmr15769758plh.35.1618018550053;
        Fri, 09 Apr 2021 18:35:50 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id e68sm3126832pfa.78.2021.04.09.18.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 18:35:49 -0700 (PDT)
Date:   Sat, 10 Apr 2021 07:05:44 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH 6/6] staging: rtl8192e: align statements properly
Message-ID: <YHEA8CgeJAXI8z93@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aligned the statements properly in one line to make code neater and to
improve readability.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 2b9e275f42bb..65202dd53447 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -155,8 +155,8 @@ bool IsHTHalfNmodeAPs(struct rtllib_device *ieee)
 		retValue = true;
 	else if (!memcmp(net->bssid, UNKNOWN_BORADCOM, 3) ||
 		 !memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) ||
-		!memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) ||
-		(net->broadcom_cap_exist))
+		 !memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) ||
+		 (net->broadcom_cap_exist))
 		retValue = true;
 	else if (net->bssht.bd_rt2rt_aggregation)
 		retValue = true;
@@ -809,7 +809,7 @@ void HTUseDefaultSetting(struct rtllib_device *ieee)
 				ieee->dot11HTOperationalRateSet);
 		ieee->HTHighestOperaRate = HTGetHighestMCSRate(ieee,
 							       ieee->dot11HTOperationalRateSet,
-					   MCS_FILTER_ALL);
+							       MCS_FILTER_ALL);
 		ieee->HTCurrentOperaRate = ieee->HTHighestOperaRate;
 
 	} else {
-- 
2.30.2

