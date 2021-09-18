Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73CC410572
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243987AbhIRJ1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238434AbhIRJ0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:26:39 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AD5C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:25:15 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w17so10988969wrv.10
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=reovVjRvWVVgh0neDi2EWdAtfsrfN9OXCYPujWCZGUs=;
        b=HclLpT5aCCA+KL2o90azu8rN/oVe2uHN0zUyJwyrfVasoG57Uk4NrUfSVnAdta/k85
         ZhISz2qCBbJ7L/CEMgvP+AYtj9DIBtRu+IjjV1mI8yvt1lQxgEiqVWll9jEcNXIDQxLS
         5YrBoL9ACEkBFWSnSKi7KLGbTmFyl9Peo0U2BPqOE7Zyjku09DFLyv1fnLKavFsgYeEy
         Xfc8yF9UQjvUSGijouizzJtijjG8JjDDXbAdsyLg2IrtbSsstlTQVgOJlkiim+xh4kwb
         ygJOi9vYpGQuirfdKttxfXWmEdKq/Lp3xtp/GO3bkj+/424irmlnMjtKrO/12sOwlDPR
         hmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=reovVjRvWVVgh0neDi2EWdAtfsrfN9OXCYPujWCZGUs=;
        b=y/u/LpGay77W4wtgCpJScspESmoCfj2FimWoR0MitcbRC07Q24DHOkCP6bW6bvZQKv
         7IW7qglv8iDOI5/buqNfClQWmULxsqDzIh58/zxSVrPD3M6Wa/dmH3tT0XNu+fXTeche
         DMP8NlEo4ALTYoBAeDcNlD1qmWnUXEctI8lXj6xto262JQ1PrvY9uPaM6dw4goPidvxR
         Z7y18ZuwZTNVte0cJjmUAGXwbPyzdzMbe5n8mmKlXda4JReuB5m2hxIQ6hJGqDOVUxeC
         ynY56klZBxf75vkDcEFnRiVN16hR+ZDZCaVpMuIxX08cGTgqOgYBgQOvCvpIGZXIb5i8
         yirQ==
X-Gm-Message-State: AOAM532o8lLD4fyVxtW+ijXDn/nwCOx8UHVzmaK15IwGKLZfRIaz1abt
        y6MXPV6wv21Vmu1DNgTITNs=
X-Google-Smtp-Source: ABdhPJySEoNnyYOQtMa+y42ZBOhTvlXO2RPrn0PWLPFc2QOXOdbuTOCIcmhXc4xBS8zgSfLsHADfsQ==
X-Received: by 2002:a5d:4287:: with SMTP id k7mr8587682wrq.347.1631957114498;
        Sat, 18 Sep 2021 02:25:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 5sm4233742wmb.37.2021.09.18.02.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 02:25:14 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 12/12] staging: r8188eu: remove header file odm_RegDefine11AC.h
Date:   Sat, 18 Sep 2021 11:24:43 +0200
Message-Id: <20210918092443.8724-13-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210918092443.8724-1-straube.linux@gmail.com>
References: <20210918092443.8724-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finally the header odm_RegDefine11AC.h is unused now.
Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../r8188eu/include/odm_RegDefine11AC.h       | 29 -------------------
 drivers/staging/r8188eu/include/odm_precomp.h |  1 -
 2 files changed, 30 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/odm_RegDefine11AC.h

diff --git a/drivers/staging/r8188eu/include/odm_RegDefine11AC.h b/drivers/staging/r8188eu/include/odm_RegDefine11AC.h
deleted file mode 100644
index bba7511cf244..000000000000
--- a/drivers/staging/r8188eu/include/odm_RegDefine11AC.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#ifndef	__ODM_REGDEFINE11AC_H__
-#define __ODM_REGDEFINE11AC_H__
-
-/* 2 RF REG LIST */
-
-/* 2 BB REG LIST */
-/* PAGE 8 */
-/* PAGE 9 */
-#define	ODM_REG_OFDM_FA_RST_11AC		0x9A4
-/* PAGE A */
-#define	ODM_REG_CCK_CCA_11AC				0xA0A
-#define	ODM_REG_CCK_FA_RST_11AC			0xA2C
-#define	ODM_REG_CCK_FA_11AC				0xA5C
-/* PAGE C */
-#define	ODM_REG_IGI_A_11AC				0xC50
-/* PAGE E */
-#define	ODM_REG_IGI_B_11AC				0xE50
-/* PAGE F */
-#define	ODM_REG_OFDM_FA_11AC			0xF48
-
-/* 2 MAC REG LIST */
-
-/* DIG Related */
-#define	ODM_BIT_IGI_11AC				0xFFFFFFFF
-
-#endif
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h b/drivers/staging/r8188eu/include/odm_precomp.h
index ffc6f8ecafc0..cd8e3d2db212 100644
--- a/drivers/staging/r8188eu/include/odm_precomp.h
+++ b/drivers/staging/r8188eu/include/odm_precomp.h
@@ -18,7 +18,6 @@
 
 #include "odm.h"
 #include "odm_HWConfig.h"
-#include "odm_RegDefine11AC.h"
 #include "odm_RegDefine11N.h"
 
 #include "HalPhyRf_8188e.h"/* for IQK,LCK,Power-tracking */
-- 
2.33.0

