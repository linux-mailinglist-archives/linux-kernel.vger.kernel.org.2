Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E7636FCA7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbhD3OpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbhD3OpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:45:09 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B17EC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:21 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r12so105635688ejr.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NRDjGF5wjUwRiaPQw2H+cRKReTA8UwpiAU5+UbMDALU=;
        b=XXxZS+Z7Ypr9xzn70/A9s61xGFF3f+eaDxkfhnGgVDxqkW8v/wn2f3r5J9PPnnKIWe
         UwXw+pS8MIw1HfzCzUiNmPppaan8H8wCyhirfqjkcUJtBeU9mZN+GUF8oAvRwvbLWexI
         V45OuxGkd/oi519sqvm4uiV+RETXTU+4gyLXtiFFDw3AEvTS3aL7hEdjJSqZrVPLetNr
         niE31dU8zV04h1v9yEryL7BPuWY9v2FLUr9UxUoZpNEcB+p4rXqsAKMhjHrQRMtdh/E7
         iDHAb8/rItc30eaT94MNS00mAte28YOFAt68/atORqe6V23E5vqo69+/2ZaXpr/pSvJb
         WIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NRDjGF5wjUwRiaPQw2H+cRKReTA8UwpiAU5+UbMDALU=;
        b=RlJYgnO26kyAhSXqhRW5oZTf+rx0slRwqSPbev4DUM/qkSb2LOGodX5Fn5cVpVCoCu
         e161RIY9Wy0U8SUOvKqc/+MbIPV2Q7AbS2GkF+qTvOLC3/W6hUzgQP1Z14NL1HrgX5Zz
         B92AM7Wd36x3gCnCb5UKs9ne8lY+7AkqtDDW3jl9/yapEjA2NlvppcSdMPwZDw/TqWfh
         D+ItgqpjhTqm1EsBBpeZ4IJ+pTWGKC0MWeyr/yg6q03E5c5e9yfw7R80jfFHSeWO1IEV
         6bM5yHowskpjgd/yOhdXK8bA/NnAERFsZgpXoyAbe1i07fEK098sHQLsbRzXzfLqa3Qf
         YxQw==
X-Gm-Message-State: AOAM533sLivZQ2Ujh5COW7YN43e3UvAKWEsJJHll3hEIwDP45qUyXGyk
        HHZEIL/EhgZlEzwQ90FW6t14mNiBkAU=
X-Google-Smtp-Source: ABdhPJydPnDG0ac7a/7cVdMPdo6C09G6PY8Bo7KWkb0WW1iQ3g1SJA0Fg6O0MmL/jqTQaj9qa9dGRA==
X-Received: by 2002:a17:906:3544:: with SMTP id s4mr4804801eja.73.1619793859816;
        Fri, 30 Apr 2021 07:44:19 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id l7sm2201099ejk.115.2021.04.30.07.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:44:19 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/43] staging: rtl8723bs: remove empty functions
Date:   Fri, 30 Apr 2021 16:43:33 +0200
Message-Id: <1430232d3b907ee4d286cc495429230a0dd4dce2.1619793405.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
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

