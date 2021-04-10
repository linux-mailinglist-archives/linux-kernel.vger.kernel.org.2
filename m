Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D3435AA43
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 04:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbhDJCNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 22:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDJCNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 22:13:17 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B478C061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 19:13:03 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id g10so3599266plt.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 19:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=H4JBybcyVdit3LlCjtiu0PtEyNhtJrRBX+ityRlDmVU=;
        b=lHPkNWnbDZB6hbYSyq11SYll5bNsBsBby70IJDygyWZIhq1PnBkpdLoSGFB4BJoEMj
         JRw0otNXdWNRbA8zI7q6TBdwqMl6aLDdi22xJXgHX/bFmXUnlsLuNr9DLEfieCVhNX44
         Y4ZroOxi03+U0/9zIO7E5l82w+d/0Sefozt+3KT0Kvx49vPEAka7z14w2tAM/ClXeBi8
         8w3M+clmzr5O4FSqbtwbSCKVTcBrmd+hsDnyGjqekX8sKf1A3VMcdpBRFKY1bu09S0R+
         CSWUBUwKo8BZbrmM0zcHY2tshPY1oebGgJmshqWlOaNKDCRLzx+zz+OhdE83ZZ4A4+v+
         97iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=H4JBybcyVdit3LlCjtiu0PtEyNhtJrRBX+ityRlDmVU=;
        b=iBrPYxQ6n2XIJpQXUHKesRk+FCJ7yHLgb4GhNxTP8U1OD8c+d2V6BdGHcwF1Hj7SWF
         eiVlTxSxYFhfayVZDbBrm1yOF0gd6Ea3LBtMmoG4XAeiFCw4YHaP7MknvL3kBcczoeX2
         Rym1ULwl6Q3phGRNUGRWVBbeAfThN+adfuk/wSc1NG6ysF1tFukP+AKfI44j0N8qUkUb
         vBCFl1YV0rStUPbBRt9Cxx3ZPfKCUNWRbJoX4LGbs6V1uJR6PffL1E2EX2p58JK22NVn
         /BWeYT2dC+1K0WmHc63orMMUd9pVSycGACzFCD/0KgpZ4abc1bAQaHHiAruYTSLDCtJ+
         5AEw==
X-Gm-Message-State: AOAM532OC+W1fADDHC8A7XbfZqtpp2Tnl5BVEq0yEo0lFGIKp1nCSWHL
        qmSDhug2Nzgexb2Ujq+nPyA=
X-Google-Smtp-Source: ABdhPJxafIj4tw0GmNz2zeJOZmshYYQGVBg3ThyjlX6JLgvl6kHBIkx1JqiquMrfEZZ7zWQxjmy+0A==
X-Received: by 2002:a17:902:9f83:b029:e9:3455:44d2 with SMTP id g3-20020a1709029f83b02900e9345544d2mr15741805plq.11.1618020783151;
        Fri, 09 Apr 2021 19:13:03 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id v6sm239697pfb.130.2021.04.09.19.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 19:13:02 -0700 (PDT)
Date:   Sat, 10 Apr 2021 07:42:57 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH 2/3] staging: rtl8192e: remove unnecessary ftrace-like logging
Message-ID: <YHEJqTJchcKdNMyg@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unncessary ftrace-like logging by simply deleting that statement
as we have other modes of logging like ftrace.
Reported by checkpatch.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
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

