Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576D93E3476
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbhHGJtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbhHGJst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:48:49 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78129C06179B
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 02:48:31 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id d131-20020a1c1d890000b02902516717f562so7751398wmd.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 02:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2eP60BAewtPb8OrcJ+QFT8Xszokf67jZLlK3tsEIbVQ=;
        b=u+KJ5T2Zb+LhDxixAbZLWp54GSMxqsmw0ewA6jHY/Zf1jxAZ3ThTiLZR6rtX/GWak7
         rqH8eb5dW+uiPks2ABWvyfHIqCgASG8nPw1jy6EF9hU5/E2H3tySRzsCEm5OBuEe3VZP
         iRq57H06qeZO/w0MyVz0RCbi0hCyquAE5jm5xfMQdowYbKGP0Ujk67TIhgSBnpwE0F/2
         Wtrqfv/f9AMjbdf+2+nr1+KAFAVTTG0f4xJNk6eNtWbBFDq/MjjHOu2nJGFcrpNMnV24
         2wDWWuFlwFYkfkXcUbnnEBSYwIunUYNryGzABf/glkaro5PWJ8pDkRFM71sB4FvBqQoK
         t8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2eP60BAewtPb8OrcJ+QFT8Xszokf67jZLlK3tsEIbVQ=;
        b=or03OcnA9xwg0o4VjDBU1cnX9m7jez7tfVlYhSEhInSVGjnM5l1H99UqKPDXqpJNpo
         s79jmkFUG+2uCNtzndtJZRUtY/VSZk9xV7Ph+o/DEXhjMFNiACAoD3/vs4foOfTUZT6c
         /CZ5qaPqKLdIT/Cnt9WboM0l3tZ9NqW1Jk3kobN58Rr3JXTWKUBRtVto9Zorl1M7V0iI
         k72dxkaOJv29SuwWw3SSEd0abYFTDQW3khVYG0KHZ3J3e/3VBcl+StVQbvYA5/hAjCvE
         +zzuwLixD0p/6gXubKcpbDJKI6qVKRmkeLoX0I0y2VxJ6mlX8Bihgpzyl/8u8hJH9Hk0
         O9qg==
X-Gm-Message-State: AOAM532iG6T/D1ikYMeT4m9YTJBv7pFfqwVGXYcNF00dZCM0sTmaioyu
        WVVbFHbLcmcT0paV3ghgkLFqJiAaWok=
X-Google-Smtp-Source: ABdhPJyY/kDcYU08ilYUJbIuntBXJ5r1U9lpd2S0rnAeUHsT+gbAmRo9eyAdOAmljokycvvjK9fPfQ==
X-Received: by 2002:a1c:c914:: with SMTP id f20mr1650548wmb.140.1628329709961;
        Sat, 07 Aug 2021 02:48:29 -0700 (PDT)
Received: from agape ([5.171.80.112])
        by smtp.gmail.com with ESMTPSA id j2sm1738073wmi.36.2021.08.07.02.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 02:48:29 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 11/21] staging: rtl8723bs: remove unused struct member
Date:   Sat,  7 Aug 2021 11:48:03 +0200
Message-Id: <ad7831868683a99598cd00a3aacc45f76ba234e8.1628329348.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1628329348.git.fabioaiuto83@gmail.com>
References: <cover.1628329348.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused bIsMPChip struct member and all code
storing it.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm.c         | 4 ----
 drivers/staging/rtl8723bs/hal/odm.h         | 2 --
 drivers/staging/rtl8723bs/hal/rtl8723b_dm.c | 1 -
 3 files changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index fd5656398c3d..f87dd84434f7 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -856,10 +856,6 @@ void ODM_CmnInfoInit(struct dm_odm_t *pDM_Odm, enum odm_cmninfo_e CmnInfo, u32 V
 		pDM_Odm->SupportInterface = (u8)Value;
 		break;
 
-	case ODM_CMNINFO_MP_TEST_CHIP:
-		pDM_Odm->bIsMPChip = (u8)Value;
-		break;
-
 	case ODM_CMNINFO_IC_TYPE:
 		pDM_Odm->SupportICType = Value;
 		break;
diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index c77fb6e341b2..814f4d54a96d 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -282,7 +282,6 @@ enum odm_cmninfo_e {
 	ODM_CMNINFO_PLATFORM = 0,
 	ODM_CMNINFO_ABILITY,					/*  ODM_ABILITY_E */
 	ODM_CMNINFO_INTERFACE,				/*  ODM_INTERFACE_E */
-	ODM_CMNINFO_MP_TEST_CHIP,
 	ODM_CMNINFO_IC_TYPE,					/*  ODM_IC_TYPE_E */
 	ODM_CMNINFO_CUT_VER,					/*  ODM_CUT_VERSION_E */
 	ODM_CMNINFO_FAB_VER,					/*  ODM_FAB_E */
@@ -802,7 +801,6 @@ struct dm_odm_t { /* DM_Out_Source_Dynamic_Mechanism_Structure */
 	bool bsta_state;
 	u8 RSSI_Min;
 	u8 InterfaceIndex; /*  Add for 92D  dual MAC: 0--Mac0 1--Mac1 */
-	bool bIsMPChip;
 	bool bOneEntryOnly;
 	/*  Common info for BTDM */
 	bool bBtEnabled;			/*  BT is disabled */
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
index 54e2a68a0824..c1caeaf44943 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_dm.c
@@ -44,7 +44,6 @@ static void Init_ODM_ComInfo_8723b(struct adapter *Adapter)
 
 	ODM_CmnInfoInit(pDM_Odm, ODM_CMNINFO_FAB_VER, fab_ver);
 	ODM_CmnInfoInit(pDM_Odm, ODM_CMNINFO_CUT_VER, cut_ver);
-	ODM_CmnInfoInit(pDM_Odm, ODM_CMNINFO_MP_TEST_CHIP, IS_NORMAL_CHIP(pHalData->VersionID));
 
 	ODM_CmnInfoInit(pDM_Odm, ODM_CMNINFO_PATCH_ID, pHalData->CustomerID);
 	/* 	ODM_CMNINFO_BINHCT_TEST only for MP Team */
-- 
2.20.1

