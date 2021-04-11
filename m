Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8732C35B18A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 06:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbhDKEex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 00:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhDKEev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 00:34:51 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76482C06138B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 21:34:36 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id t22so6865855pgu.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 21:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T2BqAHrw2lrAPveG5tNBR1zjqxaEBIbo2AlCFYFiJmQ=;
        b=P89JbJrFS35OLMoOnZ3PzsM4t153DPBw+PCNvnnp5YLyoT4G34xWY4CtV3DLczZKfS
         lSzFEl/8jUf6qnCub6OZIcMP91wYkydmsR6bDIjG8/NK3NPrWLqlQ1JiSI/dF2mo43pb
         UXTR1F/sf1fQxSUX96JGDgs3BNpCdfdxR02C8hlnC1XTmFVuYwudCNCzHBS8m8Rv9uPk
         v44oTiq0+KVV1cOIPneaekhGFexJR/ERlb9aY/2smG64jD/jmP2sYQQH4xPuSzYV1WpQ
         Owd4o3GRRqXQOE9Jsl3k3G2AyAJYFgYobbY8tIYz4JbC/SxWnxHownJcUb3b6vGUF6q9
         wJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T2BqAHrw2lrAPveG5tNBR1zjqxaEBIbo2AlCFYFiJmQ=;
        b=ozfb20QCHzhMAbDhvmhzzNFg7MwLiZ4Fm15oIFuojy5RbmktLPrP6UpOm7klbRBG7w
         j9PRFaM0YEISlOAB0NtNx5Dh80btB9kfTLsZRwtw/uUJ7hnaSWidtx1qAt99saTWrfOV
         sGbAGgumaQyyQ7irXyarBD5jfbJjplzZKvUc2ClLaqlLNPG8i9A2p8rmbPC4C0+i+oOq
         cWnGfv+n9SE69d9fEehUOn3LTQZCTNJTWe8ozEMEf07NmmNBbioThJC2vMkOC8v2tJpC
         DyFyCf+mDC3Q748FFSLL0CQIfncDep6MvX4/Tlhu/kxy7Rvv87VNmCYqEUOehvFcd7Y2
         Qr4g==
X-Gm-Message-State: AOAM531+St62Rwwh7kiRwqWjphJZAqulEg2XiR/BLDSNcCc2UsCkJybr
        2CYUyf0fjLhrS/IKd1mAmoM=
X-Google-Smtp-Source: ABdhPJygjyld7FhoVZGn8ulNcZ52CjsBgouBigNZuioN19fT/HBiGY2bSCi2Sd+zxBrMECOaf/ao2g==
X-Received: by 2002:a63:2c8f:: with SMTP id s137mr20179759pgs.51.1618115675991;
        Sat, 10 Apr 2021 21:34:35 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id s195sm6218785pfc.211.2021.04.10.21.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 21:34:35 -0700 (PDT)
Date:   Sun, 11 Apr 2021 10:04:30 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v2 2/3] staging: rtl8192e: remove unnecessary ftrace-like
 logging
Message-ID: <667dd268dd1387584cc28d2c63cb3b18edb4bc7f.1618110617.git.mitaliborkar810@gmail.com>
References: <cover.1618110617.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618110617.git.mitaliborkar810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unncessary ftrace-like logging by simply deleting that statement
as we have other modes of logging like ftrace.
Reported by checkpatch.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---

Changes from v1:- No changes made.

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 0b1e92f17805..89d0e9ec188d 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -630,7 +630,6 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 {
 	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
 
-	netdev_vdbg(ieee->dev, "%s()\n", __func__);
 	pHTInfo->bCurrentHTSupport = false;
 
 	pHTInfo->bCurBW40MHz = false;
@@ -698,7 +697,6 @@ void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
 	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
 	u8	bIOTAction = 0;
 
-	netdev_vdbg(ieee->dev, "%s()\n", __func__);
 	/* unmark bEnableHT flag here is the same reason why unmarked in
 	 * function rtllib_softmac_new_net. WB 2008.09.10
 	 */
@@ -832,8 +830,6 @@ static void HTSetConnectBwModeCallback(struct rtllib_device *ieee)
 {
 	struct rt_hi_throughput *pHTInfo = ieee->pHTInfo;
 
-	netdev_vdbg(ieee->dev, "%s()\n", __func__);
-
 	if (pHTInfo->bCurBW40MHz) {
 		if (pHTInfo->CurSTAExtChnlOffset == HT_EXTCHNL_OFFSET_UPPER)
 			ieee->set_chan(ieee->dev,
-- 
2.30.2

