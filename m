Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711B5410814
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 20:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240763AbhIRSVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 14:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240308AbhIRSUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 14:20:51 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19576C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 11:19:27 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id j13so43055986edv.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 11:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HgLgc9yM59ExKmqslgazl+TqXbR0Gqq2UFS62UlS1Jk=;
        b=XOUPgnNQPtGjTIPlZ9rZu45c5QecyapS2H4a+iGfvXsRfWn8FFZMs0xbm/mq1ytGbC
         T/CcZUmEHsJ/kIiv23PIIVfqYyifW44Fz1AVcimiIoF+BoLyOxgLiKu3S5b7tECGSURI
         wByCR8QAfCmrNNCJXyzQ8hI6yNYidfgbmRQvyHRp2TBg3OoVY+pA/troNq0DAEuxqop5
         +9S6GqbkogYf3hjBqt5wqnbBitp+rexjP2dIv0BIDbBm9z/+In895DtjyESZNicVIpaV
         V5+hguHhHX/eqapiqPTZR7Z+g2lL07GW3GOMY/RX5MyB2kbjuSUGYJI6N+PrtCmh0198
         telw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HgLgc9yM59ExKmqslgazl+TqXbR0Gqq2UFS62UlS1Jk=;
        b=RBvMFKTf2DUahhdXLudl2B+HgqfOanpeIYPyV15w2c+g1xSWX+bMbzmOh0L4TnclCa
         eYrAbOEJTDlz+IxnjqTWbqcduuzXq8OQ2Y6au6Ru0oV1rCrrZ3DKlpS+p6oNSbv8H/Zj
         dEBNhOx9t+ziMtCm+Znd83NNP2CvvxlTpRaDYsfoKzN7cN1SaKRKwJd1BI+IaDiYS/Yw
         jG7CCSmht+Hs1bHe3Hp61ttkVvkcUgYxsWsQQRA+Tx47IYdu0bZ2tuzt9p2FpYwxbb2H
         2UkEj+gOrgBVDk97OVidDJ52jh/i0sc5G5BqeVYd6QOUxYU1H7NRXcCNu2CFKi/PoFN2
         bv6w==
X-Gm-Message-State: AOAM533Jh3umpHQOLhkO3DoXIs2dZxPicyzzyS1aZ4vbDfAK6lXSCywE
        oPea7ZNt5uD23U18ULcWQIw=
X-Google-Smtp-Source: ABdhPJzgPqQWuLNsHMlQNKPxfahh/dTerf9cBA/KDInyT48NV/OkkTrOKGgfq6yd6nzNzdiW0sMjHw==
X-Received: by 2002:a17:907:9908:: with SMTP id ka8mr20282100ejc.164.1631989165736;
        Sat, 18 Sep 2021 11:19:25 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id t19sm3903673ejb.115.2021.09.18.11.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 11:19:25 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 08/14] staging: r8188eu: remove macro ODM_BIT
Date:   Sat, 18 Sep 2021 20:18:58 +0200
Message-Id: <20210918181904.12000-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210918181904.12000-1-straube.linux@gmail.com>
References: <20210918181904.12000-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace and remove the macro ODM_BIT to make the code cleaner.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c               | 4 ++--
 drivers/staging/r8188eu/include/odm_interface.h | 6 ------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 1e2deb6cdb58..cb27edf657d9 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -465,7 +465,7 @@ void ODM_Write_DIG(struct odm_dm_struct *pDM_Odm, u8 CurrentIGI)
 	struct rtw_dig *pDM_DigTable = &pDM_Odm->DM_DigTable;
 
 	if (pDM_DigTable->CurIGValue != CurrentIGI) {
-		ODM_SetBBReg(pDM_Odm, ODM_REG_IGI_A_11N, ODM_BIT(IGI, pDM_Odm), CurrentIGI);
+		ODM_SetBBReg(pDM_Odm, ODM_REG_IGI_A_11N, ODM_BIT_IGI_11N, CurrentIGI);
 		pDM_DigTable->CurIGValue = CurrentIGI;
 	}
 }
@@ -521,7 +521,7 @@ void odm_DIGInit(struct odm_dm_struct *pDM_Odm)
 {
 	struct rtw_dig *pDM_DigTable = &pDM_Odm->DM_DigTable;
 
-	pDM_DigTable->CurIGValue = (u8)ODM_GetBBReg(pDM_Odm, ODM_REG_IGI_A_11N, ODM_BIT(IGI, pDM_Odm));
+	pDM_DigTable->CurIGValue = (u8)ODM_GetBBReg(pDM_Odm, ODM_REG_IGI_A_11N, ODM_BIT_IGI_11N);
 	pDM_DigTable->RssiLowThresh	= DM_DIG_THRESH_LOW;
 	pDM_DigTable->RssiHighThresh	= DM_DIG_THRESH_HIGH;
 	pDM_DigTable->FALowThresh	= DM_false_ALARM_THRESH_LOW;
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index a5a7b72815f3..3af58e853828 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -4,12 +4,6 @@
 #ifndef	__ODM_INTERFACE_H__
 #define __ODM_INTERFACE_H__
 
-#define _bit_11N(_name)			ODM_BIT_##_name##_11N
-
-#define _cat(_name, _func)	(_func##_11N(_name))
-
-#define ODM_BIT(_name, _pDM_Odm) _cat(_name, _bit)
-
 enum odm_h2c_cmd {
 	ODM_H2C_RSSI_REPORT = 0,
 	ODM_H2C_PSD_RESULT= 1,
-- 
2.33.0

