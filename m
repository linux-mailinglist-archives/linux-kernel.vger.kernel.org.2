Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE8035AE2E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbhDJOW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbhDJOVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:21:24 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FA8C061345
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:21:08 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id v6so11779352ejo.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u3axE6AJxT3yRAZr7qJdeIcOX6qBh+IEsk+878q7teU=;
        b=tPJhLJE/GS3CSfw9zeYQOAdEh2Bua1XB7hmiTU9oLEsHl5o1t6igaX23XQNYv2Viky
         00DTp6grzNQzp/7p6dMIZh3Enmy2cuQCqdKQNfxV4OAuMQfZFBA2J1nAZyGm8MX55Zqg
         VlygX+wjnBHJEn5MfxT3AMYEKfBCkpxe3GYhYG0yuvnQqOGtfglA2h1uQVJThvkkEzDS
         hCQQ/3AnuambV65HPtZpL/DuAXTcOfros+r8PWW+SLUGEpnlTlxhwtPFGR7sTmE6iWDn
         Tt3RzhL1BzLkXmXqCk7TSwRHILpRYqNA3jQjKLQRrrVil+PAcJOsbj6wNRrS/BCt602C
         tP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u3axE6AJxT3yRAZr7qJdeIcOX6qBh+IEsk+878q7teU=;
        b=rLbApAnzKDxHxnZssgcF6jINY+Jk2hzaTlIg+i8xPl0HBJJGNSQ/UaCNY+QtuajjC0
         cyp0VPt5K6MPRC9VoWAMVnFfdlUXBjtARkZ3EtcwLU6CJ5mM82IHOJZNv4li5LQMgcG+
         yHZcvYxp6YuMkQaOD6eFSWZQcCgcC89G2OCap4hJno3dGLisafxFf/upU5uDDQDp2tFW
         F/8+GFNNZ0Q1IT5G2uLD15NFC7JY0XccrZYMevKRemUPLzygo4ENaMlPLNXRT1W6mfd3
         ZbD5uiZ4uhHe2GXLZvCYMoTRak52yQaGsptCMIqhwCcwOC+a1LnOXIXOALZ37QTSxN2A
         1wwg==
X-Gm-Message-State: AOAM531L3gdNh40n4xtSgrHmj6v5xHJS1ixtJtJam0uLf3PIGsv0Dswr
        6UDabGflolwYapqvYkQaW8Mg41FhQdGtWA==
X-Google-Smtp-Source: ABdhPJySQ0axZVKA8urHBmig6TdgQJzTL/1r69S51bft5v0kiuuCwToSQ1ditfaCxPEELHZz8r109w==
X-Received: by 2002:a17:906:3c1b:: with SMTP id h27mr5592595ejg.182.1618064467371;
        Sat, 10 Apr 2021 07:21:07 -0700 (PDT)
Received: from agape ([5.171.81.28])
        by smtp.gmail.com with ESMTPSA id gt37sm2688713ejc.12.2021.04.10.07.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 07:21:07 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 17/25] staging: rtl8723bs: split long line
Date:   Sat, 10 Apr 2021 16:20:30 +0200
Message-Id: <28c078c685059c9b883b563f2c08cfb1d49cb82c.1618064274.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618064274.git.fabioaiuto83@gmail.com>
References: <cover.1618064274.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following post-commit hook checkpatch issue:

WARNING: line length of 103 exceeds 100 columns
168: FILE: drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:1086:
+			if (efuse_OneByteRead(padapter, efuse_addr, &efuse_data, bPseudoTest) == false)

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 00115a0c70be..54cb1ab8d4cf 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1083,7 +1083,8 @@ static u16 hal_EfuseGetCurrentSize_BT(struct adapter *padapter, u8 bPseudoTest)
 #if 1
 
 		while (AVAILABLE_EFUSE_ADDR(efuse_addr)) {
-			if (efuse_OneByteRead(padapter, efuse_addr, &efuse_data, bPseudoTest) == false)
+			if (efuse_OneByteRead(padapter, efuse_addr,
+					      &efuse_data, bPseudoTest) == false)
 				/* bank = EFUSE_MAX_BANK; */
 				break;
 
-- 
2.20.1

