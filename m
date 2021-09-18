Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFCA410571
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244321AbhIRJ1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238327AbhIRJ0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:26:37 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623ACC0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:25:13 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c190-20020a1c9ac7000000b0030b459ea869so2979171wme.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DgZ+hqLf0FtG7Wd9/tJWqhkp5dALrXXdBCxii4LerqQ=;
        b=Ihr1l87bWK7MTYjEuqozYrrc/Ll0WnFH4v4CZE/z23N28tp4uNtHznT/EvAUO6hpxk
         XiNwDvGP/AAjYwHPpyzZIOZgC3vWuODmimvaD1GBhMTwUsnPsa8InlM4Ko7cZewBu6MG
         ukPql6HNm/xT9sZFUzTyrFNgzP4qah+KpSRMM73rQKgVpa9O3mt6bBoO3ZT2axcBWCrH
         8QbdmSpKg03uQFwUyolSwYSYD9Uaptj5OIu1aL/++RBzVxgn3Mei1FFijFSzQ2zNn88F
         UlIcYtbJLBd4a64ob8RArzKZfBJpoeNUGBmSzjdsdW7UTZumqLK4leUcdn2vWqM4oyz8
         qa5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DgZ+hqLf0FtG7Wd9/tJWqhkp5dALrXXdBCxii4LerqQ=;
        b=p++7cZhLe08Q34ysYwTqrhDyTbWsduvlWv0gMKapo5P2ESrk+4C8V494vFMd2eJXW1
         gWYL4Szw+n3CtgJWCcv3lxbpNl/lAvXUE5k67dK06CdkMNM19DEoXe0HinEzZqiFbio0
         /nRnX+7Gcy1k1Dbc9ZXmhET8dbytvVvPHmuHI21wzrgN/WBizXoWLNztMPEaAc8qw1WA
         cbyU6azEa993TQ9/UySQW8sioK+BfNtc/JjIfMwJSU0IOa9njXmVXC3BYMHZos1K2kAx
         7xJ6CezmcP30VXmRRB36r209+n/QDkiwS3B1OgYG9uHPN49QX8P3+j6x49UVMEj4gSro
         Y8Gg==
X-Gm-Message-State: AOAM5306JgXs/hXpuf1CXA+KuNVj3X10L2xCYN1ZUQArqJbZr+FyXM1v
        tMprnrHmJUAkyXEYUqigXHE=
X-Google-Smtp-Source: ABdhPJy3Mq31E43QAUlrzwCFGL2vG7YyoPCfwlgYjzuKJ4jwQ+0M4zIPVwYFiu2Xf9p3aP1IsNiKuQ==
X-Received: by 2002:a7b:cde8:: with SMTP id p8mr19211053wmj.178.1631957112062;
        Sat, 18 Sep 2021 02:25:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 5sm4233742wmb.37.2021.09.18.02.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 02:25:11 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 09/12] staging: r8188eu: remove unnecessary if statements
Date:   Sat, 18 Sep 2021 11:24:40 +0200
Message-Id: <20210918092443.8724-10-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210918092443.8724-1-straube.linux@gmail.com>
References: <20210918092443.8724-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(pDM_Odm->SupportICType & ODM_IC_11AC_SERIES) is always false and
(pDM_Odm->SupportICType & ODM_IC_11N_SERIES) is always true since
SupportICType is ODM_RTL8188E in this driver. Remove unnecessary
if statements that check for this.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c | 39 +++++++++++++------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index cb27edf657d9..23ef08fc64cd 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -163,22 +163,18 @@ void ODM_DMInit(struct odm_dm_struct *pDM_Odm)
 	odm_DIGInit(pDM_Odm);
 	odm_RateAdaptiveMaskInit(pDM_Odm);
 
-	if (pDM_Odm->SupportICType & ODM_IC_11AC_SERIES) {
-		;
-	} else if (pDM_Odm->SupportICType & ODM_IC_11N_SERIES) {
-		odm_PrimaryCCA_Init(pDM_Odm);    /*  Gary */
-		odm_DynamicBBPowerSavingInit(pDM_Odm);
-		odm_DynamicTxPowerInit(pDM_Odm);
-		odm_TXPowerTrackingInit(pDM_Odm);
-		ODM_EdcaTurboInit(pDM_Odm);
-		ODM_RAInfo_Init_all(pDM_Odm);
-		if ((pDM_Odm->AntDivType == CG_TRX_HW_ANTDIV)	||
-		    (pDM_Odm->AntDivType == CGCS_RX_HW_ANTDIV) ||
-		    (pDM_Odm->AntDivType == CG_TRX_SMART_ANTDIV))
-			odm_InitHybridAntDiv(pDM_Odm);
-		else if (pDM_Odm->AntDivType == CGCS_RX_SW_ANTDIV)
-			odm_SwAntDivInit(pDM_Odm);
-	}
+	odm_PrimaryCCA_Init(pDM_Odm);    /*  Gary */
+	odm_DynamicBBPowerSavingInit(pDM_Odm);
+	odm_DynamicTxPowerInit(pDM_Odm);
+	odm_TXPowerTrackingInit(pDM_Odm);
+	ODM_EdcaTurboInit(pDM_Odm);
+	ODM_RAInfo_Init_all(pDM_Odm);
+	if ((pDM_Odm->AntDivType == CG_TRX_HW_ANTDIV)	||
+	    (pDM_Odm->AntDivType == CGCS_RX_HW_ANTDIV) ||
+	    (pDM_Odm->AntDivType == CG_TRX_SMART_ANTDIV))
+		odm_InitHybridAntDiv(pDM_Odm);
+	else if (pDM_Odm->AntDivType == CGCS_RX_SW_ANTDIV)
+		odm_SwAntDivInit(pDM_Odm);
 }
 
 /*  2011/09/20 MH This is the entry pointer for all team to execute HW out source DM. */
@@ -218,13 +214,10 @@ void ODM_DMWatchdog(struct odm_dm_struct *pDM_Odm)
 	else if (pDM_Odm->AntDivType == CGCS_RX_SW_ANTDIV)
 		odm_SwAntDivChkAntSwitch(pDM_Odm, SWAW_STEP_PEAK);
 
-	if (pDM_Odm->SupportICType & ODM_IC_11AC_SERIES) {
-		;
-	} else if (pDM_Odm->SupportICType & ODM_IC_11N_SERIES) {
-		ODM_TXPowerTrackingCheck(pDM_Odm);
-		odm_EdcaTurboCheck(pDM_Odm);
-		odm_DynamicTxPower(pDM_Odm);
-	}
+	ODM_TXPowerTrackingCheck(pDM_Odm);
+	odm_EdcaTurboCheck(pDM_Odm);
+	odm_DynamicTxPower(pDM_Odm);
+
 	odm_dtc(pDM_Odm);
 }
 
-- 
2.33.0

