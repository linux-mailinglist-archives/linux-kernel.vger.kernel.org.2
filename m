Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE943DC20F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 02:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbhGaAkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 20:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbhGaAjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 20:39:54 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DC1C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:39:48 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l18so13374563wrv.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fQ9W/AmV0MCvyTypY0gyZNqN0CL0/4onHcDd3tEQqS0=;
        b=EwV4PRARfPHAjHUJPCMDKAZflpXcTazIh1shmTrY8ekwtSSie7yJu/lzPCzlpZF64S
         kvNRr8HGK81izVCCnD6uuhO7Ep0coOuwK/YSzjL4Hlf2Zq3AKa2ZSr4628fuTuZWYvdL
         SvOvprVWqudu8jnHzSLxkvXJdpX4Vc53RjdznfQ0STAkYc/NdJTljg0LGrahLRSkOlvC
         jTkzuiyEv8pGdNCG/fZInQIR1yo69TxHe1JcnnAoaUcscHQlfh2YZxrTf2sb8KK+pW6n
         6EIpdzEciZOalGADqTLSRlzNNnR4Y3KbyXjMgyjYkFuFTdayywBkXsxClkLi1LN51IyN
         I2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fQ9W/AmV0MCvyTypY0gyZNqN0CL0/4onHcDd3tEQqS0=;
        b=EMBB3eNkFI+IMpHj0+7prkLxidD7fmmZteMhFUfoL36tnX7hscEORqAgGnVL1ldNJX
         kaP5ZzmJL7lBogT4nUdQO+2zXErN/DKTntPnmJj5+CjZrA+Af7RRyBbht5laIXARV3Co
         hBRa5Vo2CN/uBzRMP4o5BMi5pNool5yL6J++gMT09WKP3yFEvndsIGvljwXf2fDrYqOO
         8P1er7Vf10InF513aLCEL6gRWYbfC6EFG40oBveVQueTscfUpuwOSk91zpjaMfodxkVV
         i4knr/YwbS/7C+yK8hHa9umnqUvmWS0Py1fHEx4wluANg4wm9qayFxw1q4oswl0TClnU
         oppQ==
X-Gm-Message-State: AOAM5319YNCLlPQlu8MeE/z14DjAlw6k03zzprpIwIBLJAVPW5ZyFEiL
        DSomGknujNeMXy0B9HJ42Uv8Sg==
X-Google-Smtp-Source: ABdhPJxP3E5vkzGlNyxEInuxBJM/SgOkmtiQtp95N17F7irGFvk7t+Vy6jQo1i4Md+DzM19oZewXyg==
X-Received: by 2002:a05:6000:2a9:: with SMTP id l9mr5767475wry.75.1627691986740;
        Fri, 30 Jul 2021 17:39:46 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id g138sm3829614wmg.32.2021.07.30.17.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 17:39:46 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/14 resent] staging: r8188eu: remove ODM_RT_TRACE calls from hal/odm_RegConfig8188E.c
Date:   Sat, 31 Jul 2021 01:39:33 +0100
Message-Id: <20210731003937.68615-11-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731003937.68615-1-phil@philpotter.co.uk>
References: <20210731003937.68615-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove ODM_RT_TRACE calls from hal/odm_RegConfig8188E.c, as by removing these
calls in this file and others, we can ultimately then remove the macro
definition itself, which does not follow best practice.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 .../staging/r8188eu/hal/odm_RegConfig8188E.c  | 29 +++++--------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
index a26c36cf8786..ec8158e37cb3 100644
--- a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
@@ -32,7 +32,6 @@ void odm_ConfigRF_RadioA_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Data
 	u32 maskforPhySet = (u32)(content&0xE000);
 
 	odm_ConfigRFReg_8188E(pDM_Odm, Addr, Data, RF_PATH_A, Addr|maskforPhySet);
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_INIT, ODM_DBG_TRACE, ("===> ODM_ConfigRFWithHeaderFile: [RadioA] %08X %08X\n", Addr, Data));
 }
 
 void odm_ConfigRF_RadioB_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Data)
@@ -41,14 +40,11 @@ void odm_ConfigRF_RadioB_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Data
 	u32 maskforPhySet = (u32)(content&0xE000);
 
 	odm_ConfigRFReg_8188E(pDM_Odm, Addr, Data, RF_PATH_B, Addr|maskforPhySet);
-
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_INIT, ODM_DBG_TRACE, ("===> ODM_ConfigRFWithHeaderFile: [RadioB] %08X %08X\n", Addr, Data));
 }
 
 void odm_ConfigMAC_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u8 Data)
 {
 	ODM_Write1Byte(pDM_Odm, Addr, Data);
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_INIT, ODM_DBG_TRACE, ("===> ODM_ConfigMACWithHeaderFile: [MAC_REG] %08X %08X\n", Addr, Data));
 }
 
 void odm_ConfigBB_AGC_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Bitmask, u32 Data)
@@ -56,33 +52,25 @@ void odm_ConfigBB_AGC_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Bitmask
 	ODM_SetBBReg(pDM_Odm, Addr, Bitmask, Data);
 	/*  Add 1us delay between BB/RF register setting. */
 	ODM_delay_us(1);
-
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_INIT, ODM_DBG_TRACE,
-		     ("===> ODM_ConfigBBWithHeaderFile: [AGC_TAB] %08X %08X\n",
-		     Addr, Data));
 }
 
 void odm_ConfigBB_PHY_REG_PG_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
 				   u32 Bitmask, u32 Data)
 {
-	if (Addr == 0xfe) {
+	if (Addr == 0xfe)
 		ODM_sleep_ms(50);
-	} else if (Addr == 0xfd) {
+	else if (Addr == 0xfd)
 		ODM_delay_ms(5);
-	} else if (Addr == 0xfc) {
+	else if (Addr == 0xfc)
 		ODM_delay_ms(1);
-	} else if (Addr == 0xfb) {
+	else if (Addr == 0xfb)
 		ODM_delay_us(50);
-	} else if (Addr == 0xfa) {
+	else if (Addr == 0xfa)
 		ODM_delay_us(5);
-	} else if (Addr == 0xf9) {
+	else if (Addr == 0xf9)
 		ODM_delay_us(1);
-	} else{
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_INIT, ODM_DBG_LOUD,
-			     ("===> @@@@@@@ ODM_ConfigBBWithHeaderFile: [PHY_REG] %08X %08X %08X\n",
-			     Addr, Bitmask, Data));
+	else
 		storePwrIndexDiffRateOffset(pDM_Odm->Adapter, Addr, Bitmask, Data);
-	}
 }
 
 void odm_ConfigBB_PHY_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Bitmask, u32 Data)
@@ -106,8 +94,5 @@ void odm_ConfigBB_PHY_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Bitmask
 
 		/*  Add 1us delay between BB/RF register setting. */
 		ODM_delay_us(1);
-		ODM_RT_TRACE(pDM_Odm, ODM_COMP_INIT, ODM_DBG_TRACE,
-			     ("===> ODM_ConfigBBWithHeaderFile: [PHY_REG] %08X %08X\n",
-			     Addr, Data));
 	}
 }
-- 
2.31.1

