Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9487840D47C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 10:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbhIPIaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 04:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbhIPIai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 04:30:38 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03E1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 01:29:17 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q26so8087481wrc.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 01:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZZccAzt1xxxXzq/Q0/mhYP15uyP5RiZKfB2//wDW8cY=;
        b=mvWbX36gCST29e6vttj8Wd+a+X4DEEn1xewKjXhYnUCJeLVVDjJyOP3CdJOBhfgT9g
         EUN3xwFbxtQ7C58cH9EwYNuKdQRaChmlhUZLYOHkMUL2/RDvZ5/qKe51CxRPJ5YqV/AV
         A6RgQKoFX5fQE2POGIkopqyiG4RCiOJEEIwSOVZEnCh0gQ0WYyvnQM+WJxgZw/S+gXDT
         1tXebLWkyQxx3kgKOHfQlYIUYnR3r0lDlK6qZrMt+zwOGoUzj+bl2LyrJylCNPxjt7Tb
         tPwXhFfjUFGbUkpKLoMxYIZKUXk/eZuNGuNxYtglpGeHuEo2NUsc5BdcYvWMEG4ZbhMx
         lYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZZccAzt1xxxXzq/Q0/mhYP15uyP5RiZKfB2//wDW8cY=;
        b=N1EzLgFvELmNQyg16hfdVrGFJWSXaEYq1VjErFTH4KAGDYJFYoO6a7SwSVrxgZCCBM
         kwt829VeNV9wK5kOrds5h1gIsEWP/cmUNDUXVLEKlnskiTxWuKevkNQXTpnIoLnBHfrQ
         UUpWPFu7kpsa+BE8uWSGArxJYFOvLLw1V7SgadcPMOrl+xo8K79kVUb1jQzz1Rw56Hir
         BM+Ww/9qo3VvW1+a33lmax11thiL57vyeR697UvCaKU+QwHX6L69/Zyh+JLEDTwk927h
         KUr2GgELmaYQIMfowvydiuaTFtofvsCGbVLDr6KaZZ/vg9/TqeE5Iq5J3mECa/O6qE7K
         i2lQ==
X-Gm-Message-State: AOAM5316UCPiweL9Dba3gVLeEE/TDTA5gfCZ55mPeKcMmTrQYOVoFUXl
        PXoGS+EbzdRC9ud2aqG0n+4=
X-Google-Smtp-Source: ABdhPJyR2DRZ7H5uDZ7Bb89R90sHWZlhRwRAKCyUa7W2osBroCZ8dH10oEGaFUlrNPyw2c5pbBq5Vw==
X-Received: by 2002:adf:816f:: with SMTP id 102mr4571518wrm.368.1631780955905;
        Thu, 16 Sep 2021 01:29:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id d129sm7458079wmd.23.2021.09.16.01.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 01:29:15 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: r8188eu: remove unused ODM_RASupport_Init()
Date:   Thu, 16 Sep 2021 10:29:05 +0200
Message-Id: <20210916082906.25294-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ODM_RASupport_Init() is unused, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c     | 10 ----------
 drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h |  2 --
 2 files changed, 12 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
index d873672feb27..8a6cb18b0f29 100644
--- a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
+++ b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
@@ -471,16 +471,6 @@ odm_RATxRPTTimerSetting(
 	}
 }
 
-void
-ODM_RASupport_Init(
-		struct odm_dm_struct *dm_odm
-	)
-{
-	/*  2012/02/14 MH Be noticed, the init must be after IC type is recognized!!!!! */
-	if (dm_odm->SupportICType == ODM_RTL8188E)
-		dm_odm->RaSupport88E = true;
-}
-
 int ODM_RAInfo_Init(struct odm_dm_struct *dm_odm, u8 macid)
 {
 	struct odm_ra_info *pRaInfo = &dm_odm->RAInfo[macid];
diff --git a/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h b/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h
index d5ced507a648..20d73ca781e8 100644
--- a/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h
+++ b/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h
@@ -37,8 +37,6 @@
 	LE_BITS_TO_1BYTE(__paddr + 6, 0, 8)
 /*  End rate adaptive define */
 
-void ODM_RASupport_Init(struct odm_dm_struct *dm_odm);
-
 int ODM_RAInfo_Init_all(struct odm_dm_struct *dm_odm);
 
 int ODM_RAInfo_Init(struct odm_dm_struct *dm_odm, u8 MacID);
-- 
2.33.0

