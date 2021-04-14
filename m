Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A008F35EDED
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhDNG5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349721AbhDNG4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:56:55 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531C1C061344
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 23:56:29 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id t22so13764430pgu.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 23:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QAdy8nO8sPO8ys8krsfaC4uTkzbD3JcH3dkMY189rx4=;
        b=Ps0hH/LUdoDEUpfQpfyZNEhz4kWUppQUJJkxmfLlhtWchAhGJ2f/CfwFFg2cU4cjoF
         9o8fbNgAkf3X4fcSAxQUoPrRHvHJqSjwCtePv0LgtRqvZEn9/h505kJcgbFVXrJ8RBe+
         5YwbBYDLpQ1TYbO4baCrVCbZgIW1JKIWnT8hlNWe3gWdk5/UApWTDkRvAXolsCyutQEX
         K7K9VOrrWpSh+gGdKwNVkFbSaoAgER3O5lkM0wJsmx2UOub45Qc81/vNIzlTag1LDHf7
         IxW5GYpPBXrfGNYkL0EzHp0GPTgNSTG+ULEFCeuMn/x1aPPbVN5R7iD0nXlX90cXO7A4
         sNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QAdy8nO8sPO8ys8krsfaC4uTkzbD3JcH3dkMY189rx4=;
        b=ig9RoRgKw6wAUrXipOc9zlS+uudKXt0rAOfh6mYaDHmDr95myEIAfDIKpZVoQ3qGQw
         qYnbkjSmVIoYWDF2ASqXDCjkxP4Lo3/gHQgBxWKO+cgtVYIsD9dGBD0oXBk7EWmOSw5g
         zPN6kd0KWHAbnHfOVBXn5RGAZRE1/QeHmAXj5PjwNzldOXg3rkukeE7hzmhJnGKX5SOf
         KKwp40nzVzp1JUoAXSsBiHlLpXzo2u2y9OC+mO3/czmXuYqo/XjOI2+FE9SCdTcjLtWu
         l35UvpeVH00wvd3UUepXKvVSp3++D7wO9epm20Bd9/7uLCbwt8ZOxKcsaRkuT69Ojvlo
         XN+g==
X-Gm-Message-State: AOAM533GpSCj6WUbuWvYXKD2M0hT8AMcWQgEYF/hB0FAFZzBVoR5bec7
        33MjjuooWlZxhDE9THIVCck=
X-Google-Smtp-Source: ABdhPJwiPG5yRCZLBFbsCXflGJceDl1QR/7IpKdmbdRmD4a6kowvdB56Dm10Bc6QLpl4pmd64l54Tw==
X-Received: by 2002:a65:4887:: with SMTP id n7mr36018509pgs.14.1618383388867;
        Tue, 13 Apr 2021 23:56:28 -0700 (PDT)
Received: from kali ([103.141.87.253])
        by smtp.gmail.com with ESMTPSA id g24sm14123731pgn.18.2021.04.13.23.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 23:56:28 -0700 (PDT)
Date:   Wed, 14 Apr 2021 12:26:20 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v2 5/5] staging: rtl8192e: removed multiple blank lines
Message-ID: <2bfe551f152a611cc49a71a4984f41ef7ee69df5.1618380932.git.mitaliborkar810@gmail.com>
References: <cover.1618380932.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618380932.git.mitaliborkar810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed multiple blank lines to make code better and neater.
Reported by checkpatch.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 
Changes from v1:- No changes.

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index b11b0054d8cb..955442b95bdc 100644
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
@@ -750,7 +744,6 @@ void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
 		if (bIOTAction)
 			pHTInfo->IOTAction |= HT_IOT_ACT_DISABLE_ALL_2SS;
 
-
 		bIOTAction = HTIOTActIsDisableEDCATurbo(ieee, pNetwork->bssid);
 		if (bIOTAction)
 			pHTInfo->IOTAction |= HT_IOT_ACT_DISABLE_EDCA_TURBO;
-- 
2.30.2

