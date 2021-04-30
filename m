Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23DD36FCC6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhD3Oqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbhD3Opr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:45:47 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30523C061352
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:52 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id n2so105629836ejy.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z2J3mDg2zWp/DiXrFZERoJKoUUydS2LszSVYaoRZjCo=;
        b=SofdKNmG4M4wWj56waA5VPE51JKS2z6vGXr7RCBdj2Jqz9sah/4l8wn875Q2jNDuuS
         Wmh386IfakectVnnxKFiRLOmrvVKiHE3E6jxuMpmH6v1M1Q/QTfYdRxcviI8USsxMNjx
         nU1Nyfvxq15+O+d9rd6a+eX2znYNCQcU3KSvrEatsSUx1j5R3jnjLLqmRqo3QZrilc5z
         jcPjmniQ61BZe6qd3c9DJ7JdKMilA7SvXoMr8cCl1Gvhc3va9Xjd4mepY3RmQlZYld6v
         /PGrgbS7x5FpfnR0vYQNrDGL3kPmz7xx1tVoFVclRl5bEK7HH9rGLdsSzewrxHM8IWpd
         XNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z2J3mDg2zWp/DiXrFZERoJKoUUydS2LszSVYaoRZjCo=;
        b=pt2CorU0hiwK1vio3ssoxuvz7dVuDvyFY3T8ucDRyOOqr84IigYY4dAeOEz0q2bC2h
         UXbKN3t1Yln8gktkUHa/xoAJAetiH126ssyl3tjRID7gNYE1oESNBMmNULjnUuWqk0dr
         ZmQ+Zhq3QWKjIG0Aq/ihRryG9HeVlgKQdsbOKzB3b1ipgKBetwVNKnK0LUwGN2xXe+Lw
         eaORwqOVXRP2KqJDYpa2DxcZszEx2ePuem2qAbnBaytUQvB7B49IY66QvY8P5hoT1F4m
         NrVl7NGJILYrkr0mD3HC2DGBLWthF8SQn2PeE6VBdFbhU04pfTszZZuiKaBslbc4g/5n
         bvzw==
X-Gm-Message-State: AOAM5305S8F0CZ9BmTX6a0MEI869T5Zwe4xiSqHhT0xbNqqd1yyNN0tt
        6UfiCZn2PViLpH/WbFitHjYJegDmPHA=
X-Google-Smtp-Source: ABdhPJx08SYq7K99CdroG6JOaaUFW1jzWU0NvOjD1iWV8A+kqwGhK5NliGnXFJn9FWOpvsvnH51a6A==
X-Received: by 2002:a17:906:6544:: with SMTP id u4mr4750351ejn.455.1619793890726;
        Fri, 30 Apr 2021 07:44:50 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id g4sm1442761edq.0.2021.04.30.07.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:44:50 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 24/43] staging: rtl8723bs: remove BTC_PRINT macro definitions
Date:   Fri, 30 Apr 2021 16:43:54 +0200
Message-Id: <7bb4e54fcf8a17d71d1e8361d62a97c9cd9ebe35.1619793406.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
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

