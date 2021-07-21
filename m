Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F6A3D0FB8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 15:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238538AbhGUM77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 08:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238293AbhGUM5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:57:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00646C0613DB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:37:32 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gb6so3304958ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UCrbf7xZnamg8tDtV6cJsh0yMaGNZ9OI8Hc1T5lyPlo=;
        b=N8vYX2V+Jsz0GNXOg+HfwhTVeAGKy3Ay5RmkgDTtWuWg4BhvuYAiRooEQzs/b+g9H/
         T5y4NxtAqeBgS4EfuXq+tM4C4IvYWyI2Ffa8XP1dIND0qz10Ug732cHmOxNXv7g5x5HD
         90rEayRSG8Hr/Tr+KPzKG0UZ3WEjh9TsWzfH5fapBVV7tEjTCmgrG6vU5WeZY3FIk2mb
         29cZWc3g+aa1zY9rI9vL6hLmN2SD1+83MzeU+C7hbz4C39mOMHb4SF+Y67zJNEqw0xww
         /NDF+dZ3ZyZWaXADTDQbwDBcRezahkS5qlWQm+t9oLC9npGP+KFyRQGLpIFFB1GI/Cm6
         pJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UCrbf7xZnamg8tDtV6cJsh0yMaGNZ9OI8Hc1T5lyPlo=;
        b=itwFWywzj0UNxOm8jjggVg8zOs2Fbci/HQQHdYoBK3yP7zdx3JH5ENK5MuaIk6hijK
         iKgT4eG14I6GhS4ukqKvzQ7ACfacACKoadMRAWWMPdNTEQEL29aE33A2nk9vK0wGesQq
         A7tBPu0Z0NwQPflfHpdC1XOaQ0oUIG3Ut86xwwRFEVtxYwjTQ+cFCeWw/aCpEPMu/UFg
         /tlVP7ds3I4dTmntLiq/+4qDGRGxvGIHUKXwVrDzjDBm8UrDMTcszSIa8/BQfTgfpQLt
         S0M4mhh29EMhN1i6yhjLz0vslicX0bWhqUwP0lHDkG3CBZu2lhEaEnlO+Eb+DYk9sgxv
         sTUA==
X-Gm-Message-State: AOAM530lFshD/UkBikmVAa+C4WsWj3LTQZ1uWueDmJOPoUSHNHwYJiPk
        wVBb6qMXKU/jQfligSmp9XPLsn7RtGo=
X-Google-Smtp-Source: ABdhPJxebeem8ApwO59CwG+Dj99aoP1jcf3dj/+dncFVYQKaWtAJNREfCh+di3okkaRc0y1NVYBI3Q==
X-Received: by 2002:a17:906:63ca:: with SMTP id u10mr28403724ejk.411.1626874651483;
        Wed, 21 Jul 2021 06:37:31 -0700 (PDT)
Received: from agape ([5.171.73.45])
        by smtp.gmail.com with ESMTPSA id ov38sm8342356ejb.105.2021.07.21.06.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 06:37:31 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/16] staging: rtl8723bs: add spaces around operator
Date:   Wed, 21 Jul 2021 15:37:11 +0200
Message-Id: <e9f65e7600a3c935ef9c310e782790e04cc1f17f.1626874164.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1626874164.git.fabioaiuto83@gmail.com>
References: <cover.1626874164.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following post-commit hook checkpatch warning:

CHECK: spaces preferred around that '+' (ctx:VxV)
29: FILE: drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:2238:
+			hal_get_chnl_group_8723b(ch+1, &group);

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index a680fc1d4bea..d9a2d3e6a56f 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -2235,7 +2235,7 @@ void Hal_EfuseParseTxPowerInfo_8723B(
 		for (ch = 0 ; ch < CHANNEL_MAX_NUMBER; ch++) {
 			u8 group = 0;
 
-			hal_get_chnl_group_8723b(ch+1, &group);
+			hal_get_chnl_group_8723b(ch + 1, &group);
 
 			if (ch == 14-1) {
 				pHalData->Index24G_CCK_Base[rfPath][ch] = pwrInfo24G.IndexCCK_Base[rfPath][5];
-- 
2.20.1

