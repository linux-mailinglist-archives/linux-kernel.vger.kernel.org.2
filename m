Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626403AD99F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 12:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbhFSKua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 06:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbhFSKtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 06:49:53 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC67FC06175F
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 03:47:42 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r9so13704232wrz.10
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 03:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3vV2U8AiPVrINMpNtQIz9UVvV3NauTZiADFopAb6V3Q=;
        b=Yg/OJoOas9Ors+r5bnXh464rPXwRz/EL34/9+8Lg5TbtDZJXg02EP+hNl0CrjmW8Cw
         AdjX3e+nIHzi2NgQ3/uN7HLHN5EcOpoja6G/u3lfzwzPqSgFqeao6Eh+peJ5O7KWtwzz
         cTwu6HEQ08NnfMGSqasPNQCLj+/WXeNtpVWvV45xtqXp8G0MgFtkvkYXwlwejjlEMZfg
         0E96iqckMmxmQTHH48UXEv68qdZtcQU4mrWer4fu4eedW3kzLwvlnluT/tSPaJ/SzRIZ
         GNuYil/9fVxTWyHfZsyfIKV4Uo62qNy0Y2BEi4gg37t3iR1O8U0/A3E9oogSvFjkj/8x
         Qr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3vV2U8AiPVrINMpNtQIz9UVvV3NauTZiADFopAb6V3Q=;
        b=hUNpQGTn3/5w1alFNp3ghJb+7xJQkLZktk070nO3x7o6WjeY6hVp4bMd4f2TOy0xja
         mkxgJi+2FZzKYzGgwxAclgf7743rnJ8dPBGelTOMkuGM/NGMZpSsCkkchLMESLHxNh/m
         FuXnpDGouqkROcSNLqxWXrxaDs6sFM8ZeFKyD61Dk1/ixQvoRoO2VFq1R088E80520qc
         t5mLwEYPtqTk9B4TNWCvpsz7DTtj+AxhWH7UoN4SboeK1DMvUBVuoTJWmT1TTTPpuok2
         uHpXAc3CVcdx/STrSQ5ikY4sCAoCsBMz9copTefjLKNiNzoP2m5N8+DPr7gCM6p/agao
         4wcQ==
X-Gm-Message-State: AOAM532bBk3VUAkcbI0TRXvF6UPLRryu3PKrpfYHjQ5781TmGYeUAB1L
        tTNI4+9p06APYClkCnXRCXFrxUCmOYR/MQ==
X-Google-Smtp-Source: ABdhPJxUGEwInlcojT97n9kRihicD2gRb/nL8vrwukQVtbFwqPlg97pYxVlC+JEpTpYk3EmDWXnDHQ==
X-Received: by 2002:a05:6000:154e:: with SMTP id 14mr17404276wry.305.1624099661264;
        Sat, 19 Jun 2021 03:47:41 -0700 (PDT)
Received: from agape ([5.171.81.81])
        by smtp.gmail.com with ESMTPSA id p11sm881896wre.57.2021.06.19.03.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 03:47:40 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 13/18] staging: rtl8723bs: remove unused ODM_CMNINFO_BOARD_TYPE enum item
Date:   Sat, 19 Jun 2021 12:47:16 +0200
Message-Id: <fff36a612ff93ff2f4c8b38f3b65272f75ff82eb.1624099126.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624099125.git.fabioaiuto83@gmail.com>
References: <cover.1624099125.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove ODM_CMNINFO_BOARD_TYPE enum item, fix comments
accordingly (given that 5GHz code isn't supported).

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm.c | 4 ----
 drivers/staging/rtl8723bs/hal/odm.h | 5 +----
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index 4c959efd447a..68dfb77772b2 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -884,10 +884,6 @@ void ODM_CmnInfoInit(struct dm_odm_t *pDM_Odm, enum odm_cmninfo_e CmnInfo, u32 V
 		pDM_Odm->AntDivType = (u8)Value;
 		break;
 
-	case ODM_CMNINFO_BOARD_TYPE:
-		pDM_Odm->BoardType = (u8)Value;
-		break;
-
 	case ODM_CMNINFO_PACKAGE_TYPE:
 		pDM_Odm->PackageType = (u8)Value;
 		break;
diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index a5bca7d7826a..c349de205f93 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -291,7 +291,6 @@ enum odm_cmninfo_e {
 	ODM_CMNINFO_FAB_VER,					/*  ODM_FAB_E */
 	ODM_CMNINFO_RF_TYPE,					/*  ODM_RF_PATH_E or ODM_RF_TYPE_E? */
 	ODM_CMNINFO_RFE_TYPE,
-	ODM_CMNINFO_BOARD_TYPE,				/*  ODM_BOARD_TYPE_E */
 	ODM_CMNINFO_PACKAGE_TYPE,
 	ODM_CMNINFO_EXT_LNA,					/*  true */
 	ODM_CMNINFO_EXT_PA,
@@ -461,9 +460,7 @@ enum { /* tag_Bandwidth_Definition */
 	ODM_BW40M		= 1,
 };
 
-/*  ODM_CMNINFO_BOARD_TYPE */
-/*  For non-AC-series IC , ODM_BOARD_5G_EXT_PA and ODM_BOARD_5G_EXT_LNA are ignored */
-/*  For AC-series IC, external PA & LNA can be indivisuallly added on 2.4G and/or 5G */
+/*  For AC-series IC, external PA & LNA can be individually added on 2.4G */
 
 enum odm_type_gpa_e { /* tag_ODM_TYPE_GPA_Definition */
 	TYPE_GPA0 = 0,
-- 
2.20.1

