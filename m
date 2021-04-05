Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEADE3545AA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 18:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhDEQuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 12:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbhDEQu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 12:50:27 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D6CC061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 09:50:21 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o6so3041605wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 09:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EEUP96OVrvwGYcMCP5tEx9U5jXD8e7IXitjWFfxwGhk=;
        b=fSFoP7S1yfqp+Xhz0wmvjfM0U0dGydB+lqV0x6OhkoEdOuHL4v+FOvI81Y/42AYFZ5
         S74UuRI87E10zqffPz3IhYEVzVV5DpVHETBQSozMblD4HIiK7xkGMdISEwTVdjEbeY1d
         sI5AyY/K7uE/pXyuIYT12H4c1X7LACzerSY8yF8iciqqm+fEzSg0GIWBvC/BIL39aTXM
         baLrTQjvfBfKZRRmDuziRyBR9egNbY4rXPGcJbKdgUe5nsTeFROFCw+o16/lpHHKWgBX
         HI6cL8kUIPIpjVrJmip47U41+PAK2mOOcxQtRHYxEsmLl4VsDjjElq/5CjDgZ4ZEUuQo
         0yWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EEUP96OVrvwGYcMCP5tEx9U5jXD8e7IXitjWFfxwGhk=;
        b=Rkl+Q2DEoHGRRtJ4BQ/FgFoLETMOSSgiURmS0CBdA3BL/fKVtB+6q+cstgfBDJ5htS
         l5iqAoQT6W39uoL/bVL0x/VNw9s89puLbpxPXDFST37zc8kWb/iHRhychjRjIxuseCBz
         47OOUSf/PMTP8m4QZPMK5Ml47nGtpvMJhYDCZkYs/SZ4FmR2WnNKwiuH/UzTXi68nI9r
         E73PFf7eNSqHuSnoQw6UqYrzVRn1+F9lc7LTp5QLlSJthhU+U03i+BqaGDsP/k4hDQbF
         0+iwaBdCTsT/DXjTlFJ9/TmrX3xHG+2aqmGpWL3spmqygAQnK9/dpsz4M37909bQ1f0Z
         75NQ==
X-Gm-Message-State: AOAM530iAFgxA4Y1lk5G/bcJSWpJHLmb5RFBgbjKjnreNzZqMr+OrS7A
        iPmtKQkpp2MZCfD8GKB2Bng=
X-Google-Smtp-Source: ABdhPJyOgVVzgb0TtrW7bKTdaskuxxvmpHd10cpmFd6tW9J9rx86em/nBhfmoyM/5m04hDtCk+hA9g==
X-Received: by 2002:a1c:49c2:: with SMTP id w185mr22267wma.163.1617641420248;
        Mon, 05 Apr 2021 09:50:20 -0700 (PDT)
Received: from agape ([5.171.72.58])
        by smtp.gmail.com with ESMTPSA id h14sm34304884wrq.45.2021.04.05.09.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 09:50:19 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 05/10] staging: rtl8723bs: remove empty #ifdef blocks after RT_TRACE deletion
Date:   Mon,  5 Apr 2021 18:49:52 +0200
Message-Id: <f054fa97ff8197bd9d0320a601428c132de95e1b.1617640221.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617640221.git.fabioaiuto83@gmail.com>
References: <cover.1617640221.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all empty #ifdef blocks left empty after
RT_TRACE macro deletion.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 9c544b5888d0..9fdaefe6e183 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -2465,8 +2465,6 @@ void Hal_EfuseParseTxPowerInfo_8723B(
 				pHalData->Index24G_CCK_Base[rfPath][ch] = pwrInfo24G.IndexCCK_Base[rfPath][group];
 				pHalData->Index24G_BW40_Base[rfPath][ch] = pwrInfo24G.IndexBW40_Base[rfPath][group];
 			}
-#ifdef DEBUG
-#endif
 		}
 
 		for (TxCount = 0; TxCount < MAX_TX_COUNT; TxCount++) {
@@ -2474,9 +2472,6 @@ void Hal_EfuseParseTxPowerInfo_8723B(
 			pHalData->OFDM_24G_Diff[rfPath][TxCount] = pwrInfo24G.OFDM_Diff[rfPath][TxCount];
 			pHalData->BW20_24G_Diff[rfPath][TxCount] = pwrInfo24G.BW20_Diff[rfPath][TxCount];
 			pHalData->BW40_24G_Diff[rfPath][TxCount] = pwrInfo24G.BW40_Diff[rfPath][TxCount];
-
-#ifdef DEBUG
-#endif
 		}
 	}
 
-- 
2.20.1

