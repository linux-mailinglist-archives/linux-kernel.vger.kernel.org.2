Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E27A4101C0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 01:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345180AbhIQXdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 19:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344931AbhIQXcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 19:32:36 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A61CC0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:31:13 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 196-20020a1c04cd000000b002fa489ffe1fso11110639wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Zy5mhgewa9a0uZy3rtygxAsubHg3zkYkDDVaK9v8Os=;
        b=R64ZQv9uGLCMOi0A6CscyRJVu0WSCaTMEeGIocawZYeWiGpS19MhViuks0mbQxoIOV
         NW6bGNSsWHeCdi/u4+/Hwhd6b3ii5wzS32NbF+TC7dZArwg5pu/BeDRqL+D93g4Xa8Aj
         1XKhxRjLR3HQwEZNozDJa0IlNKIM/I84/C1ciXiW5g0wc6JwWIPYd8JQ55ObvslfppnY
         MTdxkHZ8TP/TzqsX0x+d9oZjq9F1ZCaebEE8x0f3x8VdQcwQ1xCAiJe2zItu6pMPQRuA
         vdHQBC7BOLPx2Xg6n1AA2UyVxaRfcoougtzOPgcBJ3DYrjAL+MbUWeeENaGqGfYL4J42
         +IWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Zy5mhgewa9a0uZy3rtygxAsubHg3zkYkDDVaK9v8Os=;
        b=rABo5CKhfnVeRwPiFbFySQUM1m1PhVgTlCsyX/DMO+AZ0f1g9HgLvnhWXQvudFmqNI
         IGLYFazO2r107OCUvQtXLhp+t6JkaFyy2mLTL0M+TtmZ3WMwqcGaGKkxp6joJLNDA4lf
         uawJanR/NJtN9i8GXUqNTvnS92aPYmXSGwwvfEyG3UF0mpROdXIonppIfGrfRE6OupzW
         gWYO1fN0isilbkcbuJxCzW3x0SqP6WvDBqxpoppf+2/hrOunkvlm+0S/xBd0aPU1go5G
         XEV8Pb6s4SXdDF4SFH1vKk53g/1U8HHaLfcbM5KUbCMePq68so+xbxCUzChNNDkP0t0V
         4cmA==
X-Gm-Message-State: AOAM5313sOYTmZ2KV6jQZYoVFDf0yVnunk7L41vOVKwFOAQJHVf9n2kA
        5JOmiv5AgMIXATgunMVUqOYkUqtUV6z1iQ==
X-Google-Smtp-Source: ABdhPJy31Aa2OgsxgiA6FCUHPiD1Yl0neyOaJgFELRLNYxPdtgQ1G6CaajddU/+allDMHuPLgBlIsA==
X-Received: by 2002:a05:600c:a4b:: with SMTP id c11mr12894409wmq.97.1631921472283;
        Fri, 17 Sep 2021 16:31:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id w9sm7523148wmc.19.2021.09.17.16.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 16:31:11 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 10/12] staging: r8188eu: remove dead code from odm.c
Date:   Sat, 18 Sep 2021 01:30:46 +0200
Message-Id: <20210917233048.31677-11-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917233048.31677-1-straube.linux@gmail.com>
References: <20210917233048.31677-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(pDM_Odm->SupportICType & ODM_IC_11N_SERIES) is true in this driver.
There is an if statement that checks this. Remove it and its never
executed else arm.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c | 140 ++++++++++++++----------------
 1 file changed, 63 insertions(+), 77 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 23ef08fc64cd..1a4c2e93f732 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -739,84 +739,70 @@ void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm)
 	if (!(pDM_Odm->SupportAbility & ODM_BB_FA_CNT))
 		return;
 
-	if (pDM_Odm->SupportICType & ODM_IC_11N_SERIES) {
-		/* hold ofdm counter */
-		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_HOLDC_11N, BIT(31), 1); /* hold page C counter */
-		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTD_11N, BIT(31), 1); /* hold page D counter */
-
-		ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_OFDM_FA_TYPE1_11N, bMaskDWord);
-		FalseAlmCnt->Cnt_Fast_Fsync = (ret_value & 0xffff);
-		FalseAlmCnt->Cnt_SB_Search_fail = ((ret_value & 0xffff0000) >> 16);
-		ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_OFDM_FA_TYPE2_11N, bMaskDWord);
-		FalseAlmCnt->Cnt_OFDM_CCA = (ret_value & 0xffff);
-		FalseAlmCnt->Cnt_Parity_Fail = ((ret_value & 0xffff0000) >> 16);
-		ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_OFDM_FA_TYPE3_11N, bMaskDWord);
-		FalseAlmCnt->Cnt_Rate_Illegal = (ret_value & 0xffff);
-		FalseAlmCnt->Cnt_Crc8_fail = ((ret_value & 0xffff0000) >> 16);
-		ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_OFDM_FA_TYPE4_11N, bMaskDWord);
-		FalseAlmCnt->Cnt_Mcs_fail = (ret_value & 0xffff);
-
-		FalseAlmCnt->Cnt_Ofdm_fail = FalseAlmCnt->Cnt_Parity_Fail + FalseAlmCnt->Cnt_Rate_Illegal +
-					     FalseAlmCnt->Cnt_Crc8_fail + FalseAlmCnt->Cnt_Mcs_fail +
-					     FalseAlmCnt->Cnt_Fast_Fsync + FalseAlmCnt->Cnt_SB_Search_fail;
-
-		if (pDM_Odm->SupportICType == ODM_RTL8188E) {
-			ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_SC_CNT_11N, bMaskDWord);
-			FalseAlmCnt->Cnt_BW_LSC = (ret_value & 0xffff);
-			FalseAlmCnt->Cnt_BW_USC = ((ret_value & 0xffff0000) >> 16);
-		}
+	/* hold ofdm counter */
+	ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_HOLDC_11N, BIT(31), 1); /* hold page C counter */
+	ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTD_11N, BIT(31), 1); /* hold page D counter */
+
+	ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_OFDM_FA_TYPE1_11N, bMaskDWord);
+	FalseAlmCnt->Cnt_Fast_Fsync = (ret_value & 0xffff);
+	FalseAlmCnt->Cnt_SB_Search_fail = ((ret_value & 0xffff0000) >> 16);
+	ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_OFDM_FA_TYPE2_11N, bMaskDWord);
+	FalseAlmCnt->Cnt_OFDM_CCA = (ret_value & 0xffff);
+	FalseAlmCnt->Cnt_Parity_Fail = ((ret_value & 0xffff0000) >> 16);
+	ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_OFDM_FA_TYPE3_11N, bMaskDWord);
+	FalseAlmCnt->Cnt_Rate_Illegal = (ret_value & 0xffff);
+	FalseAlmCnt->Cnt_Crc8_fail = ((ret_value & 0xffff0000) >> 16);
+	ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_OFDM_FA_TYPE4_11N, bMaskDWord);
+	FalseAlmCnt->Cnt_Mcs_fail = (ret_value & 0xffff);
+
+	FalseAlmCnt->Cnt_Ofdm_fail = FalseAlmCnt->Cnt_Parity_Fail + FalseAlmCnt->Cnt_Rate_Illegal +
+				     FalseAlmCnt->Cnt_Crc8_fail + FalseAlmCnt->Cnt_Mcs_fail +
+				     FalseAlmCnt->Cnt_Fast_Fsync + FalseAlmCnt->Cnt_SB_Search_fail;
 
-		/* hold cck counter */
-		ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(12), 1);
-		ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(14), 1);
-
-		ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_CCK_FA_LSB_11N, bMaskByte0);
-		FalseAlmCnt->Cnt_Cck_fail = ret_value;
-		ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_CCK_FA_MSB_11N, bMaskByte3);
-		FalseAlmCnt->Cnt_Cck_fail +=  (ret_value & 0xff) << 8;
-
-		ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_CCK_CCA_CNT_11N, bMaskDWord);
-		FalseAlmCnt->Cnt_CCK_CCA = ((ret_value & 0xFF) << 8) | ((ret_value & 0xFF00) >> 8);
-
-		FalseAlmCnt->Cnt_all = (FalseAlmCnt->Cnt_Fast_Fsync +
-					FalseAlmCnt->Cnt_SB_Search_fail +
-					FalseAlmCnt->Cnt_Parity_Fail +
-					FalseAlmCnt->Cnt_Rate_Illegal +
-					FalseAlmCnt->Cnt_Crc8_fail +
-					FalseAlmCnt->Cnt_Mcs_fail +
-					FalseAlmCnt->Cnt_Cck_fail);
-
-		FalseAlmCnt->Cnt_CCA_all = FalseAlmCnt->Cnt_OFDM_CCA + FalseAlmCnt->Cnt_CCK_CCA;
-
-		if (pDM_Odm->SupportICType >= ODM_RTL8723A) {
-			/* reset false alarm counter registers */
-			ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTC_11N, BIT(31), 1);
-			ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTC_11N, BIT(31), 0);
-			ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTD_11N, BIT(27), 1);
-			ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTD_11N, BIT(27), 0);
-			/* update ofdm counter */
-			ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_HOLDC_11N, BIT(31), 0); /* update page C counter */
-			ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTD_11N, BIT(31), 0); /* update page D counter */
-
-			/* reset CCK CCA counter */
-			ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(13) | BIT(12), 0);
-			ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(13) | BIT(12), 2);
-			/* reset CCK FA counter */
-			ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(15) | BIT(14), 0);
-			ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(15) | BIT(14), 2);
-		}
-	} else { /* FOR ODM_IC_11AC_SERIES */
-		/* read OFDM FA counter */
-		FalseAlmCnt->Cnt_Ofdm_fail = ODM_GetBBReg(pDM_Odm, ODM_REG_OFDM_FA_11AC, bMaskLWord);
-		FalseAlmCnt->Cnt_Cck_fail = ODM_GetBBReg(pDM_Odm, ODM_REG_CCK_FA_11AC, bMaskLWord);
-		FalseAlmCnt->Cnt_all = FalseAlmCnt->Cnt_Ofdm_fail + FalseAlmCnt->Cnt_Cck_fail;
-
-		/*  reset OFDM FA coutner */
-		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RST_11AC, BIT(17), 1);
-		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RST_11AC, BIT(17), 0);
-		/*  reset CCK FA counter */
-		ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11AC, BIT(15), 0);
-		ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11AC, BIT(15), 1);
+	if (pDM_Odm->SupportICType == ODM_RTL8188E) {
+		ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_SC_CNT_11N, bMaskDWord);
+		FalseAlmCnt->Cnt_BW_LSC = (ret_value & 0xffff);
+		FalseAlmCnt->Cnt_BW_USC = ((ret_value & 0xffff0000) >> 16);
+	}
+
+	/* hold cck counter */
+	ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(12), 1);
+	ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(14), 1);
+
+	ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_CCK_FA_LSB_11N, bMaskByte0);
+	FalseAlmCnt->Cnt_Cck_fail = ret_value;
+	ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_CCK_FA_MSB_11N, bMaskByte3);
+	FalseAlmCnt->Cnt_Cck_fail +=  (ret_value & 0xff) << 8;
+
+	ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_CCK_CCA_CNT_11N, bMaskDWord);
+	FalseAlmCnt->Cnt_CCK_CCA = ((ret_value & 0xFF) << 8) | ((ret_value & 0xFF00) >> 8);
+
+	FalseAlmCnt->Cnt_all = (FalseAlmCnt->Cnt_Fast_Fsync +
+				FalseAlmCnt->Cnt_SB_Search_fail +
+				FalseAlmCnt->Cnt_Parity_Fail +
+				FalseAlmCnt->Cnt_Rate_Illegal +
+				FalseAlmCnt->Cnt_Crc8_fail +
+				FalseAlmCnt->Cnt_Mcs_fail +
+				FalseAlmCnt->Cnt_Cck_fail);
+
+	FalseAlmCnt->Cnt_CCA_all = FalseAlmCnt->Cnt_OFDM_CCA + FalseAlmCnt->Cnt_CCK_CCA;
+
+	if (pDM_Odm->SupportICType >= ODM_RTL8723A) {
+		/* reset false alarm counter registers */
+		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTC_11N, BIT(31), 1);
+		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTC_11N, BIT(31), 0);
+		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTD_11N, BIT(27), 1);
+		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTD_11N, BIT(27), 0);
+		/* update ofdm counter */
+		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_HOLDC_11N, BIT(31), 0); /* update page C counter */
+		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTD_11N, BIT(31), 0); /* update page D counter */
+
+		/* reset CCK CCA counter */
+		ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(13) | BIT(12), 0);
+		ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(13) | BIT(12), 2);
+		/* reset CCK FA counter */
+		ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(15) | BIT(14), 0);
+		ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT(15) | BIT(14), 2);
 	}
 }
 
-- 
2.33.0

