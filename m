Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6757B41AFE0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 15:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240926AbhI1NV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 09:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240828AbhI1NVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 09:21:25 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D3AC061604
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 06:19:45 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id c73-20020a1c9a4c000000b0030d040bb895so2758900wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 06:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/SmoyI4Lll6AWitzCqkM6cMjwJFHYFfQHXwNr4z9RaY=;
        b=U9UTlHRNxjunOSnsrQdZ9V0nmMcQYcqjRA/LOU2fgkR1wUaDyD10tJnc5bQWCboIfo
         Kq0hxoHAyW9O/nBdObbApKeLapaGjXDJbV6npFMMXWVFP9DDcK+z58ugnQH2qM7QOZOM
         LzM4jxUJcPv4rk8Z47ancqe+gDSuqyOWcgCbA/jGJ5pQXB2vFCpeMpai4f7O9i+dV1xR
         2e6kRQa9INj+HgyPrcg1wB5QQYP21amhaJFStyLjshzzM3PzCUHZmNfVd5rQsTP19Wwp
         6A+pi3nArvr2cBlU1upqiITMq9LtcCcTLCllOag2UBUCjp1TwWJN0y1bOX3BE8p41oce
         ypmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/SmoyI4Lll6AWitzCqkM6cMjwJFHYFfQHXwNr4z9RaY=;
        b=ik1mhOXZn/ZYnbYHwmL5fvOt+BzF1qdHf4TgUfeA6NYhTN8HO4Dlu/Bo4CrPU+/i2N
         0McMUNtrGAtEBPuU1f0cuxggaLbvz8iFKmRkQKJPmSXG2zv8jjfayHLSCkr2EPvJjGFl
         3KhoG/F6w8rqL+wmsUoflTSHh9bt4uFGN7pet64lhs/RWEweVn0Knnt48djLhyv5khF3
         n7/e/pATlwomPg1eR5RYFZsp3NPPGozOd9sDWBpKD+S0a4d3oFa0dXZr9yB8o/sAxggr
         xWCJwIpbBzImoGKtL7lw+0a5tJVo0EUSCHBvP6yiNfyXcZHJAzXTmhXR+LcNyNctF/Ze
         xAaQ==
X-Gm-Message-State: AOAM531q80UqVyQgzOLkCpbEt4AiEeOA7qtTWwA549mQuILSG7jvjz15
        e3GEBgfFUxQed1UrnpFX/R/DbuNAnls=
X-Google-Smtp-Source: ABdhPJxAV9aMRAxie0IcPxRTZjsQB67pQRCd07Ma3Zo5LB079gvKvpbdBJvwirylXc7fsKxr9G8yNQ==
X-Received: by 2002:a1c:21d5:: with SMTP id h204mr4569166wmh.9.1632835184428;
        Tue, 28 Sep 2021 06:19:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::dc89])
        by smtp.gmail.com with ESMTPSA id m5sm1727030wms.41.2021.09.28.06.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 06:19:44 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: r8188eu: remove odm_GlobalAdapterCheck()
Date:   Tue, 28 Sep 2021 15:19:30 +0200
Message-Id: <20210928131930.8866-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210928131930.8866-1-straube.linux@gmail.com>
References: <20210928131930.8866-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function odm_GlobalAdapterCheck() is empty, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c             | 6 ------
 drivers/staging/r8188eu/include/odm_precomp.h | 1 -
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 277357111452..bc49dc856a60 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -182,7 +182,6 @@ void ODM_DMInit(struct odm_dm_struct *pDM_Odm)
 void ODM_DMWatchdog(struct odm_dm_struct *pDM_Odm)
 {
 	/* 2012.05.03 Luke: For all IC series */
-	odm_GlobalAdapterCheck();
 	odm_CommonInfoSelfUpdate(pDM_Odm);
 	odm_FalseAlarmCounterStatistics(pDM_Odm);
 	odm_RSSIMonitorCheck(pDM_Odm);
@@ -1521,11 +1520,6 @@ u32 ConvertTo_dB(u32 Value)
 	return dB;
 }
 
-/*  2011/09/22 MH Add for 92D global spin lock utilization. */
-void odm_GlobalAdapterCheck(void)
-{
-}	/*  odm_GlobalAdapterCheck */
-
 /*  Description: */
 /* 	Set Single/Dual Antenna default setting for products that do not do detection in advance. */
 /*  Added by Joseph, 2012.03.22 */
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h b/drivers/staging/r8188eu/include/odm_precomp.h
index 210275a51994..1340b3df1181 100644
--- a/drivers/staging/r8188eu/include/odm_precomp.h
+++ b/drivers/staging/r8188eu/include/odm_precomp.h
@@ -39,7 +39,6 @@ void odm_DynamicBBPowerSavingInit(struct odm_dm_struct *pDM_Odm);
 void odm_TXPowerTrackingInit(struct odm_dm_struct *pDM_Odm);
 void ODM_EdcaTurboInit(struct odm_dm_struct *pDM_Odm);
 void odm_SwAntDivInit_NIC(struct odm_dm_struct *pDM_Odm);
-void odm_GlobalAdapterCheck(void);
 void odm_CommonInfoSelfUpdate(struct odm_dm_struct *pDM_Odm);
 void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm);
 void odm_DIG(struct odm_dm_struct *pDM_Odm);
-- 
2.33.0

