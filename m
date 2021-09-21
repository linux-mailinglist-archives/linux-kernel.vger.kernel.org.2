Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3A9413AFD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 21:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbhIUTtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 15:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbhIUTs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 15:48:59 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8609CC061766
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 12:47:30 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t8so145487wrq.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 12:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=czrP6QE0oWPp2IhYAOngMIyhTl+nVLIjWbQ3m00v7QA=;
        b=m5Sos2iGL079vJXKEZQ0e8MA2dClwVyjJsPWI16owIYwRZRYxP0mSFZ+Zqrt488qX3
         RShZ0A/GdtU548amVYVZox2QpsA7NZxcEXvWzZLZUBs1ypUCamBBAiWfG65nkwzHCY8N
         1yUWubXS1qRm89HH46cpWc29DxdjIDtl8xm8z1R292CDOUKzer89p6fSAcovP4RktQM3
         x2KjEnnTlTVzIVzC8ZeqIdZDu6MZMA7fuoqriDmhn4HWBuKgbHyimhV4tRZoxuqaodoM
         Q9hUqOhPfCXgPfyanRxSWP8KpM+qIqOKsE0anM++A9H1tfamXtALllAcWtYJBrgGS2fa
         HJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=czrP6QE0oWPp2IhYAOngMIyhTl+nVLIjWbQ3m00v7QA=;
        b=buTQFlerfWfrhLxOMBFjA6mHzOxBf4WuhCA5eyTUaNloB+3ETiuQNNNa46D/AtTFZx
         8xchBcSXks4WlTv/0++6vOwyPm3TfsLtP+g5kn0XzyUSpMA6jASc/Fi9AViWdfoFncsy
         zHQ0wkt4Kr7Tc2rNOGCCNj6xr616oW7y3u5EgU8rqkEkkSz/ccv1KijC5NGfZLqiBY/+
         Nhlo+IKKeKkC0GyKfRXrCQcZTYnW2LowdXgTR2q0Tw04LERCB8Ty7AbzmpkEgKkAwU+n
         kyml0GY/O4LniLhFHhxurIsWNDILRAXraqMxSAYFcJuKOSEARpEKuVYz9wcNPJGrQrsP
         7c8Q==
X-Gm-Message-State: AOAM532yd77aRRup4BW28SJSQgrbi3lx0c9QrtFLkjB4zyDTAPpEqnir
        bcCnvCc+1vCgeLAQxnPGRIo=
X-Google-Smtp-Source: ABdhPJxkceAbiZL5yL+cUubPZ6waOHIV41xb+da3h9eEMnjG+MNWp72+nz8wjAGBs6osjSG1Br8pfw==
X-Received: by 2002:adf:9d47:: with SMTP id o7mr37449901wre.50.1632253649256;
        Tue, 21 Sep 2021 12:47:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id s13sm3891243wmc.47.2021.09.21.12.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 12:47:28 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 8/8] staging: r8188eu: remove odm_DynamicTxPowerInit()
Date:   Tue, 21 Sep 2021 21:46:58 +0200
Message-Id: <20210921194658.10654-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921194658.10654-1-straube.linux@gmail.com>
References: <20210921194658.10654-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function odm_DynamicTxPowerInit() is empty now, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c             | 9 ---------
 drivers/staging/r8188eu/include/odm_precomp.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 87f0ea84819a..e0784e38e083 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -165,7 +165,6 @@ void ODM_DMInit(struct odm_dm_struct *pDM_Odm)
 
 	odm_PrimaryCCA_Init(pDM_Odm);    /*  Gary */
 	odm_DynamicBBPowerSavingInit(pDM_Odm);
-	odm_DynamicTxPowerInit(pDM_Odm);
 	odm_TXPowerTrackingInit(pDM_Odm);
 	ODM_EdcaTurboInit(pDM_Odm);
 	ODM_RAInfo_Init_all(pDM_Odm);
@@ -1174,14 +1173,6 @@ bool ODM_RAStateCheck(struct odm_dm_struct *pDM_Odm, s32 RSSI, bool bForceUpdate
 	return false;
 }
 
-/* 3============================================================ */
-/* 3 Dynamic Tx Power */
-/* 3============================================================ */
-
-void odm_DynamicTxPowerInit(struct odm_dm_struct *pDM_Odm)
-{
-}
-
 /* 3============================================================ */
 /* 3 RSSI Monitor */
 /* 3============================================================ */
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h b/drivers/staging/r8188eu/include/odm_precomp.h
index 43f8e6849a45..6b3800894bc6 100644
--- a/drivers/staging/r8188eu/include/odm_precomp.h
+++ b/drivers/staging/r8188eu/include/odm_precomp.h
@@ -36,7 +36,6 @@
 void odm_DIGInit(struct odm_dm_struct *pDM_Odm);
 void odm_RateAdaptiveMaskInit(struct odm_dm_struct *pDM_Odm);
 void odm_DynamicBBPowerSavingInit(struct odm_dm_struct *pDM_Odm);
-void odm_DynamicTxPowerInit(struct odm_dm_struct *pDM_Odm);
 void odm_TXPowerTrackingInit(struct odm_dm_struct *pDM_Odm);
 void ODM_EdcaTurboInit(struct odm_dm_struct *pDM_Odm);
 void odm_SwAntDivInit_NIC(struct odm_dm_struct *pDM_Odm);
-- 
2.33.0

