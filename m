Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA71F36FD11
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbhD3O72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhD3O6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:37 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6E7C061349
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:48 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gx5so13611167ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z2J3mDg2zWp/DiXrFZERoJKoUUydS2LszSVYaoRZjCo=;
        b=ZPB4wZ6lysBCbaEVht0bMDG9fYfJVLr3zWFSFNgq53TxBbUmookiiGKutxaOOaUux5
         IY3M0P8l/sR7EbVrgfzYrCPv+6Lq7i/ukJFT+aZRPQ5WbYpG6rRKlf//x/fRKPKZErck
         TnMKTqYs7DC9hrUud3btX1aU9Si/z/Sx80dZsvTNRBayBRlGgCaBfcBHVyo9sKQhb0FU
         JkEV7kyvrgP4fif8iTRs2+Ptzx7ji2H2r5W6bbadaKiCZKcHEUd+iuCfOKa8DJZAVYnH
         un7rqXLjK+VkNp9LW8bexwuPGZudtcZU44sc31UeMn1luaovcWgTj54UvwlBXs5zFt6/
         gcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z2J3mDg2zWp/DiXrFZERoJKoUUydS2LszSVYaoRZjCo=;
        b=Cn4sWoHI9dkgLmXPgQSDXMhAcnEE/9xxsTV+yDQK9FAIH4sxDeSW1Wmfh0t+v9i+DI
         7F0HEQhw27YXO92xuYYtvQv7fDi1MZLYHpRQEu8baabdToXGcnt00XWTskvkJURxbX4+
         elP8KuuKzNYcHnzFKWqgtp8LBAY0xR4QOv0V7hHoyBuXJLqHzfooBFkA9/VF+EmdOy57
         dfOKG5sv9QEi+PlGPdeMzPAfOWTAqZHaKuTqTL4Ajw5G5v1mxvV0eXAfqj54G+thrdVh
         kEyBsE6rypF4SvDmHJafiX+8WDNsC2mbVx4Bmey+TINZ6Jy0zK/i72WwFAbvds1TBgUW
         tApw==
X-Gm-Message-State: AOAM532OA4jfeDl6PVrzBLagRsGVdBqBA9p3yJzGXoH5NUSd1iSkU1n9
        4/iJPAqY/fFCK/JpsGcWyDG9wj+lv8c=
X-Google-Smtp-Source: ABdhPJwbAvG/z9MWIbuF2UmFkvgNwpD5pxrSgbmdUFyZVrkdImBK93sHvXyxNbRM7jJjvisbLwqYMw==
X-Received: by 2002:a17:906:a20b:: with SMTP id r11mr4847600ejy.323.1619794666944;
        Fri, 30 Apr 2021 07:57:46 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id g11sm1452501edw.37.2021.04.30.07.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:57:46 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 24/43] staging: rtl8723bs: remove BTC_PRINT macro definitions
Date:   Fri, 30 Apr 2021 16:56:46 +0200
Message-Id: <0f0129063880553001a2c1d8272d10079abc7132.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused BTC_PRINT macro definitions.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
index 7b2d94a33d9c..ad19ffc2de57 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
+++ b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
@@ -114,12 +114,6 @@ extern u32 		GLBtcDbgType[];
 
 /*  The following is for dbgview print */
 #if DBG
-#define BTC_PRINT(dbgtype, dbgflag, printstr)\
-{\
-	if (GLBtcDbgType[dbgtype] & dbgflag)\
-		DbgPrint printstr;\
-}
-
 #define BTC_PRINT_ADDR(dbgtype, dbgflag, printstr, _Ptr)\
 {\
 	if (GLBtcDbgType[dbgtype] & dbgflag) {\
@@ -149,7 +143,6 @@ extern u32 		GLBtcDbgType[];
 }
 
 #else
-#define BTC_PRINT(dbgtype, dbgflag, printstr)		 no_printk printstr
 #define BTC_PRINT_F(dbgtype, dbgflag, printstr)		 no_printk printstr
 #define BTC_PRINT_ADDR(dbgtype, dbgflag, printstr, _Ptr) no_printk printstr
 #define BTC_PRINT_DATA(dbgtype, dbgflag, _TitleString, _HexData, _HexDataLen) \
-- 
2.20.1

