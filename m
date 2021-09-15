Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4294B40C250
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 11:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237176AbhIOJDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 05:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237043AbhIOJDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 05:03:39 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A85C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 02:02:21 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id z184-20020a1c7ec1000000b003065f0bc631so4216661wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 02:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hs3mRcTeREmOfSm39kN+QtHRavsM4VI0RyJdbjV285Q=;
        b=DG8M9J6xuHLtr/nbqPvulc3q/HwyojLa2iMboMhpRdjCHJDbu6oVsNDpZ2v4zKYmX/
         mdlOrnj0RA5on2WbdG2k+bmGONRXzvEcaLm+ynrTFqqet29Rn/5voWZl8QC3ujQz5wa1
         b3r++NHQLRYXHQ1bcVbKs1HqNvBmTLxulxa3gMZfuxytCJL6kqvOb8QS9xTx1qiw49QO
         9ziKcozVDI8pTDkCOx/o5EApwDPlnybikC22aP0gMaaK29tvtfvjyyy7rkwO0xhuGCuc
         6njTXp8sWJiuokbao5t0ROFqDCKtkRFFwqJHM8yU3qs1++5aZinYJS+BM9d7np9SbyZ0
         L+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hs3mRcTeREmOfSm39kN+QtHRavsM4VI0RyJdbjV285Q=;
        b=RSfHIu88+MfNKKq8BYveM0Bfhd0O+iVxodzdWZkQurIDVoUm1BmPfV3iEtc1Yb6b+8
         qRgzcVek8Ge6VEhRbNYOKOBnoBOr+9KlNAgoIygvO84LVA7LqsR6uGdt2lc2kayf4DTT
         iEzOsxZzuu21RlPOensIONdaG1DBuiluTevK4+mCjhbQUUkrODmZkvPiH0KkZTq7e6cR
         rp9AHgYr2ceboJsZYHPHgChyyOtoe4cGgy1DzVyOU/FDhtJuOYDZvgnm9HYRxNT6y4uu
         eZqxYe5oHS7QwpPA1oDdiG6I/5qIxAr6HVGtrLrMNY/QNl6Fc9Zq7VveMznTXIiD4G+i
         8VNA==
X-Gm-Message-State: AOAM530MwYRE2S7Zx5TB3LiOEDAnfLzHA5P8vfLyhYOiPZXx3SD4m5T1
        HmbYLrWYzu7hn9U7DuGv1D4=
X-Google-Smtp-Source: ABdhPJyZzjRch5cHfi/ZGfLYSUbX/tVcd0Dy7jLi5u1ctPlm7I7ZM2P6WKgbWQERmoHUtC6yxpu1hA==
X-Received: by 2002:a05:600c:26d4:: with SMTP id 20mr3334117wmv.40.1631696539772;
        Wed, 15 Sep 2021 02:02:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::1db2])
        by smtp.gmail.com with ESMTPSA id n186sm3565530wme.31.2021.09.15.02.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 02:02:19 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 3/4] staging: r8188eu: remove unused enums from rtl8188e_hal.h
Date:   Wed, 15 Sep 2021 11:01:55 +0200
Message-Id: <20210915090156.4169-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915090156.4169-1-straube.linux@gmail.com>
References: <20210915090156.4169-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After removing MultiFunc and RegulatorMode from struct hal_data_8188e
the enums rt_multi_func and rt_regulator_mode are unused now, remove
them.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/rtl8188e_hal.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 7e2feb390416..17913dcc9fbe 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -207,20 +207,6 @@ struct txpowerinfo24g {
 
 #define EFUSE_PROTECT_BYTES_BANK	16
 
-/*  For RTL8723 WiFi/BT/GPS multi-function configuration. */
-enum rt_multi_func {
-	RT_MULTI_FUNC_NONE = 0x00,
-	RT_MULTI_FUNC_WIFI = 0x01,
-	RT_MULTI_FUNC_BT = 0x02,
-	RT_MULTI_FUNC_GPS = 0x04,
-};
-
-/*  For RTL8723 regulator mode. */
-enum rt_regulator_mode {
-	RT_SWITCHING_REGULATOR = 0,
-	RT_LDO_REGULATOR = 1,
-};
-
 struct hal_data_8188e {
 	struct HAL_VERSION	VersionID;
 	u16	CustomerID;
-- 
2.33.0

