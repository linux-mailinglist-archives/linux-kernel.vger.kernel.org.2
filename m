Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC4536FCF2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhD3O6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhD3O6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:02 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD8FC06138C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:13 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id zg3so24102587ejb.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NRDjGF5wjUwRiaPQw2H+cRKReTA8UwpiAU5+UbMDALU=;
        b=WPKIwQ61f0kZLkUwTNTh1mG+bzhCUMbI49ZYW5nL2oL8cqgDN+4pwxX0eKT7fiM3jw
         oEcUFvUBMUAixBGZSePCFIXSnSM3G7I1IcPfWueaz+bg1VnYNXqzjw5Jy7V30gHzt5Ph
         2Co3j6sS2NFHkRxgDHR9ZvocXx5DzUhCdfCcQNcx+wMHqqJmb8y1FbloIVmZ/XJwf/5w
         dG/l3VTwykkppwQoEQVZeQweAUjgqVaKSEjwKj2OPl77lrpwbBqtzoN8IlQxElzGUTHo
         iMrdqf60tXMM5/M+jUvsf+fMBIWC63Zt+cRGBCSFIHAHHbl19F2itmkBoHUMoo5I/4IG
         VZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NRDjGF5wjUwRiaPQw2H+cRKReTA8UwpiAU5+UbMDALU=;
        b=VXLZimMHeanr+//AcX15axkyS7lFCrcUDNJZeb6gtmS3bFDeo2giLtm2QdlqZTf4qa
         WedQr8I00mcfrAB3JP7Hb5gc8M0OhcuLwHx4jinm3rnqLHmn5bFcm56NIRqOichheArP
         AyjrsuVc/zwbpCkaJ60bepOuE3HyzZHPGH4Aw6fy4zpjTpXftyiA3sodLitMzFi+igs0
         vZodjYk8SSaqgrH9RDYC+AV3qkY1sVmlQOSIfSPK59skeL9orrOieAnOkAmmP4NeFiEM
         ojFR9WjwuD7b9l1Sl4lOxDegFD9uSOZOXKYzN5lREI2vfiRXVgn9VOYju3SsmCfNVR42
         zgoQ==
X-Gm-Message-State: AOAM530R5Y1Fk7k3NmygdJ9h/Qj+cCjh22TtOcIGPkoVpzddZUFYEkdf
        Nr95/S5CjRXJpfR55tsaIQy/xf5gPCc=
X-Google-Smtp-Source: ABdhPJz4zzfzQrlizqOTD82+njchkqQERkahLJMgGux7yfwQhFMVXVepAoDJErkbRK6JdnwJifb2cA==
X-Received: by 2002:a17:907:a044:: with SMTP id gz4mr4872340ejc.55.1619794632420;
        Fri, 30 Apr 2021 07:57:12 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id v4sm2275920ejj.84.2021.04.30.07.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:57:12 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/43] staging: rtl8723bs: remove empty functions
Date:   Fri, 30 Apr 2021 16:56:25 +0200
Message-Id: <2a0606394fec2cbb32df6ec0bf4b5974416195f6.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove functions left empty after ODM_RT_TRACE deletion.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm.c         | 4 ----
 drivers/staging/rtl8723bs/hal/odm_PathDiv.c | 7 -------
 2 files changed, 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index a9f8d6a4a62c..73068a1681a9 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -807,9 +807,6 @@ void ODM_DMInit(struct dm_odm_t *pDM_Odm)
 
 	ODM_ClearTxPowerTrackingState(pDM_Odm);
 
-	if (*(pDM_Odm->mp_mode) != 1)
-		odm_PathDiversityInit(pDM_Odm);
-
 	odm_DynamicBBPowerSavingInit(pDM_Odm);
 	odm_DynamicTxPowerInit(pDM_Odm);
 
@@ -857,7 +854,6 @@ void ODM_DMWatchdog(struct dm_odm_t *pDM_Odm)
 
 	odm_RefreshRateAdaptiveMask(pDM_Odm);
 	odm_EdcaTurboCheck(pDM_Odm);
-	odm_PathDiversity(pDM_Odm);
 	ODM_CfoTracking(pDM_Odm);
 
 	ODM_TXPowerTrackingCheck(pDM_Odm);
diff --git a/drivers/staging/rtl8723bs/hal/odm_PathDiv.c b/drivers/staging/rtl8723bs/hal/odm_PathDiv.c
index bedce2c10b22..1a2e367bb306 100644
--- a/drivers/staging/rtl8723bs/hal/odm_PathDiv.c
+++ b/drivers/staging/rtl8723bs/hal/odm_PathDiv.c
@@ -7,10 +7,3 @@
 
 #include "odm_precomp.h"
 
-void odm_PathDiversityInit(void *pDM_VOID)
-{
-}
-
-void odm_PathDiversity(void *pDM_VOID)
-{
-}
-- 
2.20.1

