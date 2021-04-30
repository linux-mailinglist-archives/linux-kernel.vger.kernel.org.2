Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DFF36FD24
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhD3PAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 11:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbhD3O72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:59:28 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A92C061342
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:58:15 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id zg3so24107745ejb.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=221EpUeP2nbQrzcZn2qyIAnSOKrHvxfj40S2UXto0Rc=;
        b=YYseqk10cNcidXmweDjz74Grq1Wq/QPYtIcxVPodLd5utppbQS73tnITLPBloYtuvb
         3nQVJ5DOTFrQKKr8nJWpmJhgJfI/Q1EG88qVTdM8Op+WkSjQOgnDCphwV+4MOGiCeQoA
         rZWn6Z3afSG703phpnN122fG7HkmVrrah9UajNIv1Pk+kk6VBcWCe9XYnIvuE/fOk6ZI
         wYe+Ptwulob188QYxXCjDKqm4o8Wjljuq/Pi+bGwCX5X+SlqAKZJTUtgHsC3S5qDRocc
         L5C5bx4RR/2NZ9ddZZEJeDw1st3++p/FxhoJWPMiVVxeU3BEIS+VbTLWpNNLj7+qlD7N
         PgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=221EpUeP2nbQrzcZn2qyIAnSOKrHvxfj40S2UXto0Rc=;
        b=jtbCKGvmjKSM3eqOVMzPhIgk4fxhzJkJ5UomUyZxelR8URcidSrtdxcIl0OmcFk29J
         Zwr5GYTNAwYD64DaoJF+o4N0vjn2cJD/9yG1yXKiWl992DK1qcnJFblJWoK79TAn3WH9
         MakCBlbCw6iTifpM4XBsOt9IpxW4DjG880wO3/+w24av3cx204Ffla0OnW1tXk6fG4CS
         b8L1M+qYtOfqMd4qB4dKWOpNX0uG31PyO2fzVf2Dd87tQsK6oSCkMX8BDhzpSffJqpiJ
         hBESe2rFx15ryyXD7/iObvNnwdNEnWrqQuZx+t/GHJETd514ZM1po85qEMdeyeg422m+
         kdlA==
X-Gm-Message-State: AOAM533KHWiEb8PUfYej5c2iJufkxjbAaUvIb6u70a01Clo9eOD/kwHw
        UzmHmGmg9t0pyqOpXAQYvF3iQ4yznz0=
X-Google-Smtp-Source: ABdhPJxxaHzWELz6JfC5Ut6JU83xC91WcFNeYGiMACtZaUl8wwz/mjZzjxnHBgYSaGZ/tV4hlXhw4w==
X-Received: by 2002:a17:906:151a:: with SMTP id b26mr4881392ejd.492.1619794693546;
        Fri, 30 Apr 2021 07:58:13 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id d15sm1516981edu.86.2021.04.30.07.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:58:13 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 41/43] staging: rtl8723bs: remove member in dm_odm_t struct
Date:   Fri, 30 Apr 2021 16:57:03 +0200
Message-Id: <313d08514d2105c826ef3c92555fa557def2b9c2.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove DebugComponent in dm_odm_t struct,
remove private debug component tracing.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_com.c | 10 ----------
 drivers/staging/rtl8723bs/hal/odm.c     |  4 ----
 drivers/staging/rtl8723bs/hal/odm.h     |  1 -
 3 files changed, 15 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index e82f59fc5e9b..8d1a18b5f914 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -1093,13 +1093,6 @@ u8 SetHalDefVar(
 	u8 bResult = _SUCCESS;
 
 	switch (variable) {
-	case HW_DEF_FA_CNT_DUMP:
-		/* ODM_COMP_COMMON */
-		if (*((u8 *)value))
-			odm->DebugComponents |= (ODM_COMP_DIG | ODM_COMP_FA_CNT);
-		else
-			odm->DebugComponents &= ~(ODM_COMP_DIG | ODM_COMP_FA_CNT);
-		break;
 	case HAL_DEF_DBG_RX_INFO_DUMP:
 
 		if (odm->bLinked) {
@@ -1183,9 +1176,6 @@ u8 GetHalDefVar(
 				*((int *)value) = psta->rssi_stat.UndecoratedSmoothedPWDB;
 		}
 		break;
-	case HW_DEF_ODM_DBG_FLAG:
-		*((u64 *)value) = odm->DebugComponents;
-		break;
 	case HW_DEF_ODM_DBG_LEVEL:
 		*((u32 *)value) = odm->DebugLevel;
 		break;
diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index 45e4038530c0..b867629a577b 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -1172,10 +1172,6 @@ void ODM_CmnInfoUpdate(struct dm_odm_t *pDM_Odm, u32 CmnInfo, u64 Value)
 		pDM_Odm->RSSI_Min = (u8)Value;
 		break;
 
-	case ODM_CMNINFO_DBG_COMP:
-		pDM_Odm->DebugComponents = Value;
-		break;
-
 	case ODM_CMNINFO_DBG_LEVEL:
 		pDM_Odm->DebugLevel = (u32)Value;
 		break;
diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index ba723ed7aa96..6b9865f5f283 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -709,7 +709,6 @@ struct dm_odm_t { /* DM_Out_Source_Dynamic_Mechanism_Structure */
 	enum phy_reg_pg_type PhyRegPgValueType;
 	u8 PhyRegPgVersion;
 
-	u64	DebugComponents;
 	u32 DebugLevel;
 
 	u32 NumQryPhyStatusAll;	/* CCK + OFDM */
-- 
2.20.1

