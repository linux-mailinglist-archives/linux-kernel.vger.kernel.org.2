Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8BA36FCCD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbhD3Oq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbhD3OqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:46:05 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ADEC06135B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:45:03 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id h10so82910427edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oXNpztwSPie87ZGBOUIq/Wsi+dyDvcyo8iFcSTDhBAs=;
        b=it3wxcs4z3lCcDg9KH0JPpS7cY+24Jp2wtkMEnjN8IEaYUh8fsJnz85RUOIvpf+nVy
         chTVdAb3ylt4rNn8qGNQ29+NRTuaSa/js9hAjEzgVBTrBd8b/WZ0IHurzPp/V9sLcBVE
         f0bNG0PA9EP3YzDnFHg7wvYkdkbXdl1JLlRLa4c6Q0zSK23fUMUkT3X6olevdtIG3erI
         VV+MtXmTKh1h32OhH20bJS9LMLH3VFMXVKtV2PRTthzCltUKtyP1U5k85v7fLVptyZh5
         M5q3Z1HW/zvvnCKynkG5BSLfql4weHQeoDR0rUWhkqQ4cCF6Dq6qw2Jn5dwLdEAC4XhH
         MZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oXNpztwSPie87ZGBOUIq/Wsi+dyDvcyo8iFcSTDhBAs=;
        b=R0Rr+t6kyLx9+cadaFiwRdzDiXmFLkaPbgOCsFw+jQaJp9Nn7Cbh018WGtlPgEurI5
         k1MpAXSHucx3gI0ARPC2KOg+aCHuP6F92Vk86dgpAPk+UMGZkoN3STsvjgDTOzIyz1uw
         3xItVEfRd2Y5Qf83oujiK3FYK4/VXlNKYZZn840bh5evohubgzwskdGEJ8M6X6QvxzFv
         Wfm9SuE2rYJT829hV7AUkDZ+akeSYR+lmfjjRuTQ499Rtke4hcpfu6mzQ99t1kON2jP5
         0/HxiFJhO02o5g1r2CHdkLWwFFhf8wNT0orHBk1wXEjNiiaRTB4+Jkjy3GCHlxI+b5sF
         YNSQ==
X-Gm-Message-State: AOAM533t81n+YE6UcxvNV9dt8lr0aAkzl3k/bb7OizqHhNLF5L0pDoOZ
        jsj0bjzLpLszjsmqB1HeimFyw+ZuPd0=
X-Google-Smtp-Source: ABdhPJxzuIEWNywo9Wz+PZyLnlRDvD6ajM+z5KebZgnINBBheAnlk1auIlVeO1IFsA4bpCnsxjjHhQ==
X-Received: by 2002:aa7:ce17:: with SMTP id d23mr6377068edv.47.1619793902398;
        Fri, 30 Apr 2021 07:45:02 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id g11sm1456923edt.35.2021.04.30.07.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:45:02 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 32/43] staging: rtl8723bs: remove obsolete GLBtcDbgType array declarations
Date:   Fri, 30 Apr 2021 16:44:02 +0200
Message-Id: <83cc0a8d2128e3d22a385d247667fb4865612507.1619793406.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
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

