Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2EA35B2ED
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 11:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbhDKJ4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 05:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhDKJ4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 05:56:02 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD223C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 02:55:46 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id t22so7146595pgu.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 02:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9+Tud+EwHobwTf+ByrLi6YGTbViJEd1nIvc/V1lBmp0=;
        b=pFNSOKCBR6L8loV8oFAVLnvUBfHS1UArAffhRwOUDaoA0Iw7fq9YY2MRVVwHOy5IEB
         /B7OfrSOP9Uqw1UKBOBr+qICE0Spu+oD/23kav/Jzy93/nHi8oJ9YIaTVoCnnFvDwf+r
         wG3ErJudWtO/tbgwhT9r+DvJ7m5EQLKBLjp4FZh5AhBUbhn27baht5Z23LdHKm93Zs+e
         X/xRjJP22immfK+Za7ZWmV5MjRoopyI2e/PATVD7VHnlhY6KcnXXQZtnaLbGcfBjqQc/
         V1WDUY46W0YjvOo3JydPwk/RXBZsjHfp83JtiVFp4QufIrCaNbL2NsQXCYACStULlI+F
         rTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9+Tud+EwHobwTf+ByrLi6YGTbViJEd1nIvc/V1lBmp0=;
        b=Sv/Y6JFIgXECJeBFzeC+8HGRLFYbvw/ga34xMNDp7CrHBJbC/5yFFv9k/2XPDPknMY
         xwEznYICE/oppN0L0FtCh9SXomCgYlxYfvF6Z6gtKsr8mshLG+f63LXwYt0+oQW1jQBw
         f7YFBMZhFMT8byAK9FQNpAs/OypZ1YugW9n2pSzMCC0v1rAZ7rEKc3FCfQa/A6QHU1vU
         jSUQ0XfHdpVytpLqWwJgnBsSKMGDSDQnrHUkFrLeq9m/br6HVx3ghJGI3iF9zsqQxRlP
         2B//M3K7RaYKUp57ABFeBdmNcU/lCKlxKeeYQlejijTNEvB3VLfWmoGq9Oj8cP+PtT0g
         oC2Q==
X-Gm-Message-State: AOAM532g6Qdarb/uHBpQ/Eu05Gc6pEea61RzSnONzk4CIeV8FXZGo2il
        P5wBX5sZneIuxrcs9zEJTYk=
X-Google-Smtp-Source: ABdhPJwf0po7d6X6MCXuOW2FKDqHxJSioh/sgIqwIGqzjsM5dRdxmV4tRnFr/W4oDeQ9EO5UYzgRSw==
X-Received: by 2002:a63:43c2:: with SMTP id q185mr21052350pga.41.1618134946241;
        Sun, 11 Apr 2021 02:55:46 -0700 (PDT)
Received: from kali ([103.141.87.253])
        by smtp.gmail.com with ESMTPSA id e7sm6581072pfv.107.2021.04.11.02.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 02:55:45 -0700 (PDT)
Date:   Sun, 11 Apr 2021 15:25:39 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v3 2/3] staging: rtl8192e: remove unnecessary ftrace-like
 logging
Message-ID: <460ba9cdd256bf1064c4e3a694caa046171cb60e.1618133351.git.mitaliborkar810@gmail.com>
References: <cover.1618133351.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618133351.git.mitaliborkar810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unncessary ftrace-like logging by simply deleting that statement
as we have other modes of logging like ftrace.
Reported by checkpatch.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 
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

