Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC3A410815
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 20:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240833AbhIRSVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 14:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240331AbhIRSUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 14:20:52 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E9FC06175F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 11:19:28 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h17so43084781edj.6
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 11:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DgZ+hqLf0FtG7Wd9/tJWqhkp5dALrXXdBCxii4LerqQ=;
        b=nH8ibwqhlzozh3fn0saTBzpfLwjERDE7ESePzWVFmhi9g1vWXLLsDr29TYUToksws9
         82NmE9F5Z1L6u/XybPjKdx7tGCSvKzjcL2B6i7zy+O4ReXog9vBFm6gfXC6/wzVzQ2rK
         kmSBRAStCHyi4LQH9/vSiM3hpkQWot59GUSKiCFL4t+P3DdSLWIP3uU6WOkm01B1/Fo1
         DQpRknl31oRkNkcMfL/U6h3sBnlAhfNdu0mYsaEkH30yiKLxPdBxElLUw0cW90ospp6Y
         K8LXaAQPOV9KXY8w1DLZxSOyK29tLIBac+wO25YoY4h2WcxvC7JYU4oKpKSi4AHAdpGY
         Lnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DgZ+hqLf0FtG7Wd9/tJWqhkp5dALrXXdBCxii4LerqQ=;
        b=FDaoyhKB4VVwSBb/GBQdhcrTNy08iXVPI/nogamD3oEjQ43kKV0UPqSNDI19I0ytDT
         uTL+5ep2GVSqygnwXfVS2wz7WzijnP+iMS+52MgzdU3ie3pREQftlECfH6uKTUd22DM7
         n9ZWE/WPkYB2dMhqnXExsK6BWbnBsMZcpczXD0wZ3O4fsZvM2q6399Neb9DNfKwCmeLO
         A1KY68TXvVmtMPXv9BV0Puk+/Ida5Aeu5LCTs0Iq2xTlQpWGiQiTOIuDLyIXdrVAJCFv
         hQkFq6c/yYNUCgMa/WcL9SmoZBvUHYuM3+mt6GGfOt7rnybwfP/g0Hr3KiSH24arH6ew
         2sww==
X-Gm-Message-State: AOAM532jMWmB60YhVvtJoI69+bc2zb/EmmvLdyTmYWnNmNhU5biohFCv
        WszOkDpS/dLuRtzUBJGXrHQ=
X-Google-Smtp-Source: ABdhPJybUwYcsBwwWpsD2s667w8HZiEga0iYY5HPxvNeZyPUJfBQQ6tWteyahDUDvd34ilRle+9udA==
X-Received: by 2002:a17:906:158f:: with SMTP id k15mr20058402ejd.241.1631989167373;
        Sat, 18 Sep 2021 11:19:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id t19sm3903673ejb.115.2021.09.18.11.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 11:19:26 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 09/14] staging: r8188eu: remove unnecessary if statements
Date:   Sat, 18 Sep 2021 20:18:59 +0200
Message-Id: <20210918181904.12000-10-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210918181904.12000-1-straube.linux@gmail.com>
References: <20210918181904.12000-1-straube.linux@gmail.com>
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

