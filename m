Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08BA3B0476
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 14:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhFVMc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 08:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbhFVMcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:32:21 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BF5C061787
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:30:05 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m3so12700845wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3vV2U8AiPVrINMpNtQIz9UVvV3NauTZiADFopAb6V3Q=;
        b=cCbzsB5e2oZLgJ5FGXSdAsvhX5m8ywtLTR55allVlsSe2eqnwLR2fhksY4nghCdlM8
         I8j2WPyKABpaPrJYR1ZBZK7Xjo4XnjDL6VCnPnwiYt9Q4KOkszSjlGHSJEJVP8hJ8VXu
         lIyOx4JaWqoUqiOHcqwMV+eZGPBuoaZJApM/b9wJ9QnjLzmJ4yyeJpW1J6Yl4sq/5oQq
         /gk422Rq47L/GaeB1c4yy2AEzG9vi4bFLcC9TkoWzBzh5T+pdSekautvR3tj1vxrJpwY
         UTatBr6ay5/a12FFfPL/DectWaOJ3/cVX5Np2905fLLqK5TFpjNPAC//90vlUaZTmjvW
         6CYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3vV2U8AiPVrINMpNtQIz9UVvV3NauTZiADFopAb6V3Q=;
        b=Lzlia0Das3SXya9SwToBYXh6IS9dNh/og8Ym+HczFE9vP+asxEM4TmgaVNQHZbyXqf
         uYvCNvim9F671/9MHvlOLp697FQfAZ0mUj+gX0ChpVlK9Irm/06pQJrHq31IQAX7Lzy2
         5d8YOegb5u8CkcDBJ+tt3wCGUMRiH0ostXv8JoYX20JRGsrZSqBUnBCMXGxpUR115zUw
         xvN2kVC7LqFeMEdbkNUle/1vvdGdy6o/BTsPr023LZy1tLbR7GRP9uMgSnsCovuVWScs
         l4QAvJogCUbRi6dFRv3n8/l8rz8h+a+O31G8ueYR97++Y5eWA3XMXPsH4qdxjr6i6Iga
         GUdA==
X-Gm-Message-State: AOAM5331wKr3Qo014xi9gWAynDCrR8TkibSd2HfugPiwbQUuYRinYhyA
        Hat7D+JRlhi9JQ5BzEE1y8OgyFtSMtLWwQ==
X-Google-Smtp-Source: ABdhPJwg2D+G7gYfGgKwohhs4wbVBupD3Xm436MysbgZAn1G7ioFreCNsFiILCELO3ETIsFmqA945A==
X-Received: by 2002:a1c:f613:: with SMTP id w19mr3921309wmc.141.1624365003514;
        Tue, 22 Jun 2021 05:30:03 -0700 (PDT)
Received: from agape ([5.171.73.108])
        by smtp.gmail.com with ESMTPSA id l12sm21208383wro.32.2021.06.22.05.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 05:30:03 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/17] staging: rtl8723bs: remove unused ODM_CMNINFO_BOARD_TYPE enum item
Date:   Tue, 22 Jun 2021 14:29:38 +0200
Message-Id: <fff36a612ff93ff2f4c8b38f3b65272f75ff82eb.1624364582.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624364582.git.fabioaiuto83@gmail.com>
References: <cover.1624364582.git.fabioaiuto83@gmail.com>
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

