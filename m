Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB4C35D5E7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 05:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242778AbhDMD0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 23:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242503AbhDMD0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 23:26:06 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4878BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 20:25:47 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t22so7129340ply.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 20:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dSZfSUphe0NnbZB4k0O50WfWli08mKIdprthWm9Rpno=;
        b=Q2zyqbhkJBE+68u2PKiL6DXL1fRUnCaElQ5huclQL9s5/ARpDjGe+BQ+/6Fwu6SJoB
         lhhqE++b+6bpKJBmIxMtXPtOeuYPrwxliwSyyhXxyVzMV5QMo4/pQnP+sbYWtMNCwzDB
         SaO3oIjJAr60Q6hHixI6zO30B/buCvH6clz1gwhuzujMC6zK1nYe8qCdDKTOK2Uo6tO0
         aLAWxN4au9GG2KGT9XT2uhSnpezXZJypo9G279gHbm/fPLZZi6uBZDj5eGqndlErlah+
         GXKswWWEDlemT8ZkZF1RlNWxogeMEZ4KFjNDsKxxvEDVCs/+Bdw+tz1eYQAx2GtPZKYR
         L8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dSZfSUphe0NnbZB4k0O50WfWli08mKIdprthWm9Rpno=;
        b=G33m/ZOxlRd5AV0pKLK/WsVSXR1cr0PEMU1Reyk9ZjoSu2HKvVoJ8tx5WuENYvmijK
         tihF9WTdKxUvVnsKrJZrplbF6EehqqK9Hkfk6NvVPuJZtv+SlRilNRRsF09GPZ3BXn1E
         Iv4yst1cRySa3aP6jgSxC1LS9p2Cuz3hFi2k8AsEZ4I+GY/IAi72Eh/JZ2ltT9iw68B9
         yHPkJThHjw11jEwMXsfi8PayztZ38xoDVpm9atbb+SpWeSsggTAn88kMsoc30cbJwcl0
         bAY9TDW58zkyg9xObapBV9gfn+vBBwbGBBt6NfOc5pfbTtukCqSJGv/b4dg90yqZosp0
         iAqA==
X-Gm-Message-State: AOAM5306BJDdit+ZROX/6Ah+EWI6ta65kbGeG9OYEDz6aujDdgSf1gSh
        zEvWsBhEIQJ+eayIIkoAuWg=
X-Google-Smtp-Source: ABdhPJyKAZCA9CN6M9vXmT3sUkhVKKtehRUoTVZaKf8uB1pYlKWygMK+JjrfoVEBNT56jYha6AGeBw==
X-Received: by 2002:a17:902:d306:b029:ea:bb6c:3c99 with SMTP id b6-20020a170902d306b02900eabb6c3c99mr15772422plc.9.1618284346794;
        Mon, 12 Apr 2021 20:25:46 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id k13sm10334636pfc.50.2021.04.12.20.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 20:25:46 -0700 (PDT)
Date:   Tue, 13 Apr 2021 08:55:41 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v5 2/3] staging: rtl8192e: remove unnecessary ftrace-like
 logging
Message-ID: <460ba9cdd256bf1064c4e3a694caa046171cb60e.1618283232.git.mitaliborkar810@gmail.com>
References: <cover.1618283232.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618283232.git.mitaliborkar810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unncessary ftrace-like logging by simply deleting that statement
as we have other modes of logging like ftrace.
Reported by checkpatch.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 
Changes from v4:- No changes.
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

