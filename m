Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0EA36F699
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbhD3Hqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbhD3Hpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:38 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41F2C06134A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:49 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id f24so5275950ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HuRDse6cwaQ2xwrTLwG7a4zXuTLnjB8VHStZClnoZTQ=;
        b=cJn8v7kdVGCUzTJ4D6WpbaBz+uN8JYnB/Cj219Amr7XcKpgHTNcFtBncHLs+AijoLm
         s8aMX30SeG1pmTO9TLvSuesYIQBCf4v/lacIQvgbPRShiQynUf+fcqLK839CgPAzlP3e
         Ewu7rwqToOT0mr6yIwuCcrgD5Dr8ndVQotURWzsisgQG5oKFJbp3bDtsS6OQYmOc/uaH
         LTfcfI2haoA0YsjXNXeGAweaF+zR5hCjyJ3dzaAVQBeaERMtHoxX5/7K35vEWDq0hdM5
         ZaBAD7FOto7RihC7XY2e6yZXyyj8EiSBv+mZh5/fdrwMgLoOzaO21Cg8QQnb+BigApIH
         4nxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HuRDse6cwaQ2xwrTLwG7a4zXuTLnjB8VHStZClnoZTQ=;
        b=CDfB+/dyHm9TGxOr2OQXqar0UxkntRZeqfnaQ1N9o1uYb0/7W10CBmfAQfsuhChAt8
         Fk//LR/p+V9nNbI71B5of/RuknJyiKZ36xccHmEPX82XLayySFNrql6N52WGUUlEE52v
         vPnE6EdZw1hyaJvtcHSSZH3Gp1fFdAlo8y3BN0ilTdY7sbV+W1qJwt32sZNCQZII83yh
         FEteh7UyvXOtTSxbOhHOv5Ze02ryFc/ISeQOpjG/W+s+O5kOWvVd1Oxu/eDb4e21xIbF
         4+CraAM2rUpV+dWjTvi7kbEhAn4j/KbxZWcWtI3cD571sWJMZCh58p/dogVTsTi0NqXg
         L3gg==
X-Gm-Message-State: AOAM533T6bCwrfNfBw5TD0qzHD0s7WVHk/6dYd7CplSPTAMBnLfUmtMO
        z2IDBPgxVxCW3AsGxFr6Weuob8CmBP1VXg==
X-Google-Smtp-Source: ABdhPJxfjVTyddW7ze4xAH4ra8e5UaekqloXafHmT+wSOYrkPJ+UhG+bYB012NhwNOb4tubVlS7yKQ==
X-Received: by 2002:a17:906:8390:: with SMTP id p16mr2728409ejx.430.1619768688311;
        Fri, 30 Apr 2021 00:44:48 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id v19sm1416152ejy.78.2021.04.30.00.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:48 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 26/43] staging: rtl8723bs: remove BTC_PRINT_DATA definitions
Date:   Fri, 30 Apr 2021 09:43:44 +0200
Message-Id: <8420804720d6b5711b75265bc65cdec97742c3ec.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused BTC_PRINT_DATA definitions.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
index 00705305305b..36636ad62aac 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
+++ b/drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h
@@ -114,25 +114,8 @@ extern u32 		GLBtcDbgType[];
 
 /*  The following is for dbgview print */
 #if DBG
-#define BTC_PRINT_DATA(dbgtype, dbgflag, _TitleString, _HexData, _HexDataLen)\
-{\
-	if (GLBtcDbgType[dbgtype] & dbgflag) {\
-		int __i;\
-		u8 *ptr = (u8 *)_HexData;\
-		DbgPrint(_TitleString);\
-		for (__i = 0; __i < (int)_HexDataLen; __i++) {\
-			DbgPrint("%02X%s", ptr[__i], (((__i + 1) % 4) == 0) ? "  " : " ");\
-			if (((__i + 1) % 16) == 0)\
-				DbgPrint("\n");\
-		} \
-		DbgPrint("\n");\
-	} \
-}
-
 #else
 #define BTC_PRINT_F(dbgtype, dbgflag, printstr)		 no_printk printstr
-#define BTC_PRINT_DATA(dbgtype, dbgflag, _TitleString, _HexData, _HexDataLen) \
-			no_printk("%s %p %zu", _TitleString, _HexData, _HexDataLen)
 #endif
 
 struct btc_board_info {
-- 
2.20.1

