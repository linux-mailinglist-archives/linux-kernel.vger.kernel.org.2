Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8C3407855
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 15:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238755AbhIKNai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 09:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238626AbhIKN3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 09:29:20 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B8EC0613A9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:21 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n7-20020a05600c3b8700b002f8ca941d89so3254853wms.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 06:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K81N07aeMQ4yN5JOc3ofjhpo4aDsEShDa2X3/T0mFkw=;
        b=mJVud1bpL5+mCNsNgUMdSY6AQkJfEV5lf4D+kCmTB9c5l5t+RZUurqUYqMwILOK5Sx
         DyozchwAnLCOGPxPPLIt+Z20G+yuypJRtpVHHF5YDmCYGLY+K3GGRT+FgZq5I7hFckij
         7e1Z3FQ0yy/+7uyicW6hUAlgwl2rOveiMrU0mGoLz5NLnge/fSt1ePjC1dxvZIYgfFaR
         mIICwaNiMLlfZoplsrzaxL2hUtOjJ240r9tNFWC8gRxwb5biWgwhmgG02xeAFBSgFb5/
         C8k09UgyaUGNbR02KE1hXvUpm6vGWzfmP2CtOIeFvXyEUjilfBiiAeV94hDiO15qWk+w
         Df4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K81N07aeMQ4yN5JOc3ofjhpo4aDsEShDa2X3/T0mFkw=;
        b=dDiVnp/Fns08S2cj3nWEEOlepO+ATSmTh662azZUW+DlETz37tGyE56f31WXg3KyRX
         gELc94eER//oOgx3+Q39nRRljqFpv2sByXA8efwQ/TdJOT34Jg4EaRc7yMS/p7xrDuxo
         DqiMq5UJQUH6Hbe/yqoR0UiNFKBeyWOJ1siWw+nK7PSR/yYo5rA+UT81XVX0DN0JZgU5
         9N4a/LVBhrMk2X6rDCGB7yRAIGvkwz3RUewll1hej1LnF6uaS4edFEkou4no/UGs8xwl
         cc8OMbQMoSYxgP0otb9JbVY3MxDTe++eN5xr+xv4AMrIg2RxE4YJH0I28FSHzUixa4+H
         EGYQ==
X-Gm-Message-State: AOAM531NcHDpKQXSFUvcmR20vUctfXj9+OBU3nZzwqVAgaTN711jKujM
        he1Hl7zEO/079EOPwQyDZrA=
X-Google-Smtp-Source: ABdhPJyR9cl3+3PlylS609rU04lnnhCWGdcA2gbtBWPnjdHks33G0PKp+/6hh+9DQk358tK//QBeuw==
X-Received: by 2002:a1c:7ec9:: with SMTP id z192mr2773844wmc.152.1631366840602;
        Sat, 11 Sep 2021 06:27:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 48sm1770253wrc.14.2021.09.11.06.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 06:27:20 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 18/18] staging: r8188eu: remove unused ODM_InitAllTimers()
Date:   Sat, 11 Sep 2021 15:26:35 +0200
Message-Id: <20210911132635.30369-19-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210911132635.30369-1-straube.linux@gmail.com>
References: <20210911132635.30369-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ODM_InitAllTimers() is unused, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c     | 5 -----
 drivers/staging/r8188eu/include/odm.h | 2 --
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 0e5b14051ffd..d23e9296a10e 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -1404,11 +1404,6 @@ void odm_RSSIMonitorCheckAP(struct odm_dm_struct *pDM_Odm)
 {
 }
 
-void ODM_InitAllTimers(struct odm_dm_struct *pDM_Odm)
-{
-	timer_setup(&pDM_Odm->DM_SWAT_Table.SwAntennaSwitchTimer, odm_SwAntDivChkAntSwitchCallback, 0);
-}
-
 /* 3============================================================ */
 /* 3 Tx Power Tracking */
 /* 3============================================================ */
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 4a5a7c754008..dd0681c138a8 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -1135,8 +1135,6 @@ void ODM_CmnInfoPtrArrayHook(struct odm_dm_struct *pDM_Odm,
 
 void ODM_CmnInfoUpdate(struct odm_dm_struct *pDM_Odm, u32 CmnInfo, u64 Value);
 
-void ODM_InitAllTimers(struct odm_dm_struct *pDM_Odm);
-
 void ODM_AntselStatistics_88C(struct odm_dm_struct *pDM_Odm, u8 MacId,
 			      u32 PWDBAll, bool isCCKrate);
 
-- 
2.33.0

