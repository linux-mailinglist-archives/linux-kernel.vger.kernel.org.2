Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2EA35B392
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 13:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbhDKLfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 07:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbhDKLfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 07:35:50 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675ADC061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 04:35:34 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id g35so7184194pgg.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 04:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vA8lw1ubzFZMaLM7kqq8oMrtyRFAa93RWghGoalPd7A=;
        b=D5Gk92YsRMpnAtiafUraa1IM89Wi/bc2KSEwOC2hgUUTEtI+eGY9sJYv3WTwOTZ8D5
         ijZ1rtM2iYbRocFVqg8J1AqDgjMzYzAWsqHVeSaPtPko81t2T/J8X99ftzKT9/AkcFy0
         Lq0iKICotnX9mKeVeKzKPrtBeIQ04UddS4e4AHFWbHHUuxvvt5dBpaf/uNDiNHJYdAyI
         KUZQtnohHC0ajVgiYQ6KDFyER52AFqI70MxAh96HOPw411HYaNS2rNEAPQkiC8Z09XBC
         Dc31qJeO64b4c+HMq3RU84DMUTBZQ694XXw1hEkBVzxNGBX69VwVNEclqpCWjIpRE3Cf
         liLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vA8lw1ubzFZMaLM7kqq8oMrtyRFAa93RWghGoalPd7A=;
        b=GqLf2KWWuTLYhG2w+3y/xZ2oqQE/W0jQlNs8XhKTiasvxeo8vkIwwqZisKerlHYNAz
         ZlKOSCDA82wTxu0pEKKT51/+CZkdNucaNEgA1RUKkcG+/qeZybcJR6DqQDhxRDYW8Iie
         8WHF7kPP6wB0HI5OcxzWah7kXF3orbYAnllm4s9UGv6cs/bDSHUtoPQ5vUWZEAWQMVhs
         eU+HKwrjoAyHB3Bm3Gj9xZPh8N2PhvD2DvjdxOxv2v6aFxbJobBcbsPiYqs/Le2HeIds
         1zdQRKnlQXQrafDFehXsN+vwmdiszsW0sFErTmoiQge1kVZuzuLSyd7zcEv9p6rkAqjW
         UA5A==
X-Gm-Message-State: AOAM530Z+07wTHggXHB3pJaxsNaTw6galhywjF5EP0g1fY7Uh8hud8/K
        9L6W7OJBTd1yCwfcW3/8ZIc=
X-Google-Smtp-Source: ABdhPJyGkP1rrZjMFDWS31reanTv93OoKhwT190NZ7P+y0yD3TuiCALdC9KgQlw9wZs7DADFFlYZAQ==
X-Received: by 2002:a62:2cc8:0:b029:23d:bd0d:2ac3 with SMTP id s191-20020a622cc80000b029023dbd0d2ac3mr20390208pfs.41.1618140933800;
        Sun, 11 Apr 2021 04:35:33 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id l25sm8731836pgu.72.2021.04.11.04.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 04:35:33 -0700 (PDT)
Date:   Sun, 11 Apr 2021 17:05:24 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v4 2/3] staging: rtl8192e: remove unnecessary ftrace-like
 logging
Message-ID: <460ba9cdd256bf1064c4e3a694caa046171cb60e.1618139271.git.mitaliborkar810@gmail.com>
References: <cover.1618139271.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618139271.git.mitaliborkar810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unncessary ftrace-like logging by simply deleting that statement
as we have other modes of logging like ftrace.
Reported by checkpatch.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---

Changes from v3:- No changes.
Changes from v2:- No changes.
Changes from v1:- NO changes.

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

