Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C942636F6A0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhD3Hqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbhD3Hpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:54 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35625C061343
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:45:00 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h10so81487283edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oXNpztwSPie87ZGBOUIq/Wsi+dyDvcyo8iFcSTDhBAs=;
        b=lPymAkw9xVO0DT4C1g9346ZThkivOP2Ogkj9qHunM2NnG7ST1sNl0IX/IEWVdQgGy6
         wAPHNRRRGDoN8rzrfNFnHoYbHU0H9tfYnFS0zdXs0YACfmslUg0b09D/diLVZtQRJaBf
         gYXqxJ+GY3gvshQXHbX9rc4aPMrtFYv+Yj40kqRKQNaBgVT1sa5lrt9aWsi1thbv7JcX
         wUif92mu8uSHWoPmjPXuF03G+4Xf0Lhsz4mf0UonlYvo93XZjX2EpxD/IQjNlqM6SOf1
         BmP1VkBtOHMZ0bOS90xv5LOn8Hc5rZNrM8d+noodKKSBDSPSjY5rbIk/Wib7u0SSoAyo
         4JEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oXNpztwSPie87ZGBOUIq/Wsi+dyDvcyo8iFcSTDhBAs=;
        b=qfWIfvcUor6xfBONMRl6RiBShfgt2j6G3oOVcmd1g/v8KM72dOILKwAsJ7aAQ2dCZM
         UoY4SW8jU9Zk9DDAoFulXVweFeMd2TCtRxBF+YV1sspThmXT2yWGMdsuXOZbX+XAr/6H
         G5R68rdI8eA0sXdFOLZYZth8rLzBVH+FJDDyyLo0+R64AW0IkHnwZ54Fr21wZ06Mktqh
         pStouoNWZ90Uc3Md7oUqNo/yAxg4Thi2DX2E+5rvuvTuq4h/gvafCGIT8epaBQOIxJIz
         qOGJCi3AXo9JYVfuWv+Lm5a0tC1cxTZyN1u+tqq3xU8KyuMOjJJkvPrvleoVxbgg4x14
         FXUw==
X-Gm-Message-State: AOAM531I70gOkzUZpt5YFeP06ZbQHkDw9zUWNpOv9bRZqMbux7Dc1FuK
        we3fGSnCP0UZFfpq/ZSjRgyf+j40CayTgw==
X-Google-Smtp-Source: ABdhPJxgi+WQ5PaMjNdLs8Lnin5ZsGeYiG5HHaJA/rKn9zweY11i00O+tPnRdKUlfOCfoot7rtMC/g==
X-Received: by 2002:aa7:d14f:: with SMTP id r15mr4059899edo.71.1619768698802;
        Fri, 30 Apr 2021 00:44:58 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id mt26sm1456782ejc.32.2021.04.30.00.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:58 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 32/43] staging: rtl8723bs: remove obsolete GLBtcDbgType array declarations
Date:   Fri, 30 Apr 2021 09:43:50 +0200
Message-Id: <cb1f030c561f95fd00b12b003993fbdaa5cc9cdf.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
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

