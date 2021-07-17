Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C9F3CC3E7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 16:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbhGQPAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 11:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbhGQO76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 10:59:58 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93997C061762
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 07:57:00 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v5so15559333wrt.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 07:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NRZ7g2XupwJPq+x4HLucSDiltZoeOFMk7jUDnIg2pRU=;
        b=MNjWiC0A30y9Vpj9ZekYZ/22+NtGO22u5VfsDjmtAtgTqxNxBTLvtA0GCGzCqj0kJT
         dG1SBUNqdxAw0gqidh5lJF+lmyEnBBQCXy18rPpWiD4xvgWTGvxvMHiAbJm6A/xVP5hu
         9eHv77UJlYRymdwtOcD2V4FTDoveEsYu9OA7DTPJKtO61VfSzgN73yYHhHLGkO1HNeMf
         tcyo94rbRNbSjwNGcEJU4YOM2kjuUF5v6nGQ3MWYmdmZgT1LaXXchc16cxiLXpqv/AuO
         aZNW/JUvGWN37M/2t3mIgOKTHBy47HZLxmSGM9pEr34quwQBrLo8gHfTzygLWVtLR0lQ
         1Z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NRZ7g2XupwJPq+x4HLucSDiltZoeOFMk7jUDnIg2pRU=;
        b=CSDnnYm9j9+Ral5VbMRN4eQgQtA8i7FZXNoWI+C01xvN6TnJFd9WhV5p0Nq6qHEH/F
         I4a12R7CruqfbVbCRhjUhpbxVQl6OAgmFakgC+ZFkiQ0VBhDNkkMAG50E+CR9MCfbw1f
         zNXuVgy16GpqT5TGt2IphksRIUZGpW24g9ERhWaz8nuJM0A8y8+t4gGUHO2r87E1Syqz
         EVtgO5CUgFltqqx/gW4Lx9jujfZLmrNGhSkzsheR3Og1JRdjcb0pRGf5zKHPcavT2zNr
         IZbICOFsOYDONxc2pkdbNBJSvk/rYayiAxK1vJjSA9qqZoGmbdyQ+CtK/J68bh1A5mhK
         Xdjg==
X-Gm-Message-State: AOAM530z3ZZ3gXTkX40xRXZsoByjfvRVbE0Sya3oNe+lcGfcFi9GBIxY
        kID0F5MUCJge5BfdRg7W7m+YywitCbk=
X-Google-Smtp-Source: ABdhPJyXYL2OzAteDl1mDzZrKNsBqj1p9Xw8qn7f4+HhMfomNns74ibiSNlSpdWzDkYbCbofS6QYhQ==
X-Received: by 2002:a5d:568a:: with SMTP id f10mr174796wrv.293.1626533819161;
        Sat, 17 Jul 2021 07:56:59 -0700 (PDT)
Received: from agape ([5.171.72.101])
        by smtp.gmail.com with ESMTPSA id p2sm10939508wmg.6.2021.07.17.07.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 07:56:59 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/10] staging: rtl8723bs: fix camel case name in macro IsLegacyOnly()
Date:   Sat, 17 Jul 2021 16:56:45 +0200
Message-Id: <52656190cefed1b0f9a2dd6dcb080adf2ca0a89b.1626533647.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1626533647.git.fabioaiuto83@gmail.com>
References: <cover.1626533647.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix camel case name in macro IsLegacyOnly()

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_btcoex.c    | 2 +-
 drivers/staging/rtl8723bs/include/ieee80211.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
index 3b0573885dce..8ec8f283893b 100644
--- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
+++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
@@ -401,7 +401,7 @@ static u8 halbtcoutsrc_Get(void *pBtcContext, u8 getType, void *pOutBuf)
 		break;
 
 	case BTC_GET_U4_WIFI_BW:
-		if (IsLegacyOnly(mlmeext->cur_wireless_mode))
+		if (is_legacy_only(mlmeext->cur_wireless_mode))
 			*pU4Tmp = BTC_WIFI_BW_LEGACY;
 		else if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_20)
 			*pU4Tmp = BTC_WIFI_BW_HT20;
diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index b2c1a7dafcee..ea1800de3ef8 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -154,7 +154,7 @@ enum network_type {
 
 #define SUPPORTED_24G_NETTYPE_MSK (WIRELESS_11B | WIRELESS_11G | WIRELESS_11_24N)
 
-#define IsLegacyOnly(NetType)  ((NetType) == ((NetType) & (WIRELESS_11BG)))
+#define is_legacy_only(NetType)  ((NetType) == ((NetType) & (WIRELESS_11BG)))
 
 #define IsSupported24G(NetType) ((NetType) & SUPPORTED_24G_NETTYPE_MSK ? true : false)
 
-- 
2.20.1

