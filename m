Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1754101BE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 01:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345149AbhIQXc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 19:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236771AbhIQXcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 19:32:35 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9826C061766
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:31:12 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w29so17618215wra.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DgZ+hqLf0FtG7Wd9/tJWqhkp5dALrXXdBCxii4LerqQ=;
        b=Eds4Vv8GsCjIsiL6IKoHai2iGtELq9WFBq6kvACRQRNRSsRm3g+SQw6VkeYmvDS/Dv
         IgG4cygAM0iuINojJtG3uUvUNsRhfY3bMuV6aSgHl7Mg+4O+qqki78JhfUuZQDUpcm9H
         Bldm5JDI5aQxn1oia9SXTr67lMyjENU1KoYlHP5v0j70EF4QCNS1fFahxPSi1mZCu6SK
         WdJGfM5BT6JmKKRylw/+3kiaN0tuDoRfLjw93S+AioPyxw5yUTF/51B+1UL0MEJopcjt
         RjQheeThV32Tm/IaXQpL7OIuZIj3IpIHyDetMVnXIUIbhSjMh5c0ISx6bueU9JGD0QKm
         7NWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DgZ+hqLf0FtG7Wd9/tJWqhkp5dALrXXdBCxii4LerqQ=;
        b=P+pMDPLRIv57dOiIiQzPlO+EtFvy3oJ5N9RJhNSkoKvGmIffhFDie2prHGbUkcDqO9
         Xkse6kXFEa/JkP8s1xyHQJ+26zehy0Y4MZhQrn6lLtdtwmLxKpZeqOVFRxptzFZVOCJx
         MKvdWGt3hyfcjxej7/X+Sl5CctW+2J3I6PQE7agQKAAlaLjg4TzeUslnNcpMwyfncy1B
         FLOdt1KFyofpO3ISsN+n1DXGZVAQXka+PFUoPUJs9D23TmiK1jzwFzYbTIyZ7KEefZyY
         h6HR9iv95x7pX3HVnl1E+KByw+FFMc6sygTq+SKjWxXKUhJjprn5pWihUW65ljKKw+Dh
         X6sg==
X-Gm-Message-State: AOAM5319pNCr5rPFwst8u9UIcn6cEbJcHZr+xInH+rlgxLCpVm5846qk
        HqCCrAg6ngI2FD+v6sYihwc=
X-Google-Smtp-Source: ABdhPJwXrr4CBwXn+G2GB57hpSHm0UjJPfiOZDYgJQI2cMdVsqW7K77UYiLjdD5t3dFH/tikPT1d/w==
X-Received: by 2002:adf:b748:: with SMTP id n8mr14851986wre.133.1631921471449;
        Fri, 17 Sep 2021 16:31:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id w9sm7523148wmc.19.2021.09.17.16.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 16:31:11 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 09/12] staging: r8188eu: remove unnecessary if statements
Date:   Sat, 18 Sep 2021 01:30:45 +0200
Message-Id: <20210917233048.31677-10-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917233048.31677-1-straube.linux@gmail.com>
References: <20210917233048.31677-1-straube.linux@gmail.com>
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

