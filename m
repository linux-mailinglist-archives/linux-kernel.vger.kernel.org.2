Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2299A36FD1A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbhD3O7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbhD3O64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:56 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3421FC061354
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:58:01 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a4so12349951ejk.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oXNpztwSPie87ZGBOUIq/Wsi+dyDvcyo8iFcSTDhBAs=;
        b=LbGox2N2QODja8YDDpDX1Qwr780Xn2Uh83Y1yS0C6VDGsPl2s+uZsJXCV5UPdwn1ia
         wAvT6u0l7F/1g490ad3pQKRY/15sK48HeaAh3rwHtaG7TUzRpTk1HXH0+eGuMQEsbgjk
         gY8O+Jo8fXLJ3Tbkj9kdNHcar48dhcMIhBk2Wz3P2zFVQcdJ1Mv2OboPYKs7Si3sMs+E
         g9F730VVt3J5FcPLmlSd+v8hHu4N3d0RL/4P2LmZjq0ag7Bk6cFMBIdo9nhZQk5CjpAe
         JaqiHVLbfZgAg2K7TNGS5FcdY3R1vF0VIxvFX7zLfecdwPmEgY/6qL4R9JCx/SSzI7mZ
         m5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oXNpztwSPie87ZGBOUIq/Wsi+dyDvcyo8iFcSTDhBAs=;
        b=Lkwn2tldxUxkI9Spz5yr3yi/hz/9fY26vOKSobyF5OzMCDJkc2RqWUVJmBjWvMj05w
         Zox+V6EmxOV3HzoXcZ9RCc24jst7r+UJuib3FyBibfRLNU923lLCDXsoiG2MNbdjrDZl
         qn2pqGFeKxYQi7u2OwA15PNR4Jfv0Mzyi+RoxlJUCfYHauxdB3QN1lauX/IHDL4O8Zrd
         ZCky0JOS+lVUTaBheViWVOsohqLlt2655a2hiwnsysc3l7sCP7L1Yxe/jg6zdXESYXza
         9CdtVC2iV0FMtqY8uwHain7N4+8832j8Vel6ukz2nV3lnb/lQ+yyHO8bRpUmUpK8qNIu
         w2IA==
X-Gm-Message-State: AOAM531s4MEfBDJ8O7K0850ubkEEV5fJRS+Y7rUCbG/IT9MwHtlA9FDo
        BW2baziy7eH5kdV3yo9yFCWg49K/1Dw=
X-Google-Smtp-Source: ABdhPJyJ9RMj7uN2UsNEjSFu3OkIUYamprlQXJOqS7NAfO3RpiLUqPqLGFzc108H3vZI7QSvlDF6Mg==
X-Received: by 2002:a17:907:3e23:: with SMTP id hp35mr4859305ejc.437.1619794679776;
        Fri, 30 Apr 2021 07:57:59 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id f24sm1496798edt.44.2021.04.30.07.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:57:59 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 32/43] staging: rtl8723bs: remove obsolete GLBtcDbgType array declarations
Date:   Fri, 30 Apr 2021 16:56:54 +0200
Message-Id: <000825941048c41cc53a0cc675fae2b45b781aad.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove obsolete GLBtcDbgType declarations for it was intended
for private debug facilities.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h | 1 -
 drivers/staging/rtl8723bs/hal/hal_btcoex.c   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
index f2793d5d9a30..c5444f965699 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
+++ b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
@@ -83,7 +83,6 @@ enum {
 	BTC_MSG_ALGORITHM	= 0x1,
 	BTC_MSG_MAX
 };
-extern u32 		GLBtcDbgType[];
 
 /*  following is for BTC_MSG_INTERFACE */
 #define INTF_INIT	BIT0
diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
index fd26187a976a..da545c4eaac0 100644
--- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
+++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
@@ -17,7 +17,6 @@ struct btc_coexist GLBtCoexist;
 static u8 GLBtcWiFiInScanState;
 static u8 GLBtcWiFiInIQKState;
 
-u32 GLBtcDbgType[BTC_MSG_MAX];
 static u8 GLBtcDbgBuf[BT_TMP_BUF_SIZE];
 
 struct btcdbginfo { /* _btcoexdbginfo */
-- 
2.20.1

