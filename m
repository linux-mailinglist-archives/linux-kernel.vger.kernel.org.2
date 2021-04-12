Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A3235C4EE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 13:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240275AbhDLLW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 07:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239752AbhDLLWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 07:22:25 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F85C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 04:22:07 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y16so9001468pfc.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 04:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IF7DiNeW+btUxyTKofRBmzZoNs1Ddr8B6E6fKZD+Y8c=;
        b=BXwH1gx1FDC5C0bniBbo3dMjUpqV6el5fFbg/3NfIieNfMr3wm3z359mGwzwNtHRAH
         MLJowFhfPp//s/QA3jlA9WgEfd/N/0Xp3xVwPluhb01sWj1aXNA6H4VYB1eEMIL3BU+v
         OjBALDIAIE72J5jzU9+JOO1cuIyWyFyuO1lyteGJaZ+eEyEcPjXXR00I9dpUFTW6iy59
         Jw7jzwaYFBugfnI9Y6ps9dhoFapwnQ9lpgLD1UaxZ/TxgkeXRa17tdcBC8oNkiLECOvv
         z9otx4BwjeKtlH8pZm4PUzy9dbOOIrtmkrPQOx5aIJpCcVOpIGtLmd7kk5Sq5ZT836E8
         DLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IF7DiNeW+btUxyTKofRBmzZoNs1Ddr8B6E6fKZD+Y8c=;
        b=dYKUZ3exNHt5Q1PnUXpfPKw8LxojEKuH+6g2wDNH9qEVcHxjLIey+Ja8nzckVfPT7r
         oVGWeqndiN+TcFaj0o6GB29iK6iZsKC3fSZKgy6vVTGdAl9g/PqUhW76zzNbElPTJAql
         0kxoIBquZw/03DU+hRy4UvoOO6JwDkeTnXDx7JfHQ/2dE4Q1w008zkjUOf9XVyZGGU9L
         rzSZW4PpSDqBbea10KTT04+dcuCDUr8041fnwjxI0RWFc1J9kbFwveGdz/5KBRqikteJ
         g62d0ZNNzkd4TqgH3TEJRMbou9IMpJ+PvhtBcSe6rXctSYypIDUBI0OTDDlYe3BeCwIa
         ZeqQ==
X-Gm-Message-State: AOAM530ewVrVEsdy63Q/1/kKPu0qlrOVFNXLTaXYQw1udUjKmRYoBX78
        Xaf9aWcOfmxstuZUNsQz9rs=
X-Google-Smtp-Source: ABdhPJwtqDtVYMmCvPmJZtyEbTaswqZ6t1KZ+hhT+KqEAHG2+0SpZRK8SH6ebSyYku60XfeEE5uf4g==
X-Received: by 2002:a63:7708:: with SMTP id s8mr26647721pgc.265.1618226526669;
        Mon, 12 Apr 2021 04:22:06 -0700 (PDT)
Received: from kali ([103.141.87.253])
        by smtp.gmail.com with ESMTPSA id e14sm11488811pga.14.2021.04.12.04.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:22:05 -0700 (PDT)
Date:   Mon, 12 Apr 2021 16:51:57 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v4 2/3] staging: rtl8192e: remove unnecessary ftrace-like
 logging
Message-ID: <460ba9cdd256bf1064c4e3a694caa046171cb60e.1618224838.git.mitaliborkar810@gmail.com>
References: <cover.1618224838.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618224838.git.mitaliborkar810@gmail.com>
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
Changes from v1:- No changes.

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

