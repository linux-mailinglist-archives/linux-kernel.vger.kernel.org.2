Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE7B36FD13
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbhD3O7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhD3O6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:40 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C31C06138D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:51 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gx5so13611425ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HuRDse6cwaQ2xwrTLwG7a4zXuTLnjB8VHStZClnoZTQ=;
        b=Td6CtkVdrm7SNmosLQvuR8caw+RdEYHhtA4bbMmbJMvuPu9e9PWgPrlinYOuG8jXUD
         fLOeWEXkuToz+xOM3qM+BMA7J/hMwISChfG4YdUevbXXynDcmhHCULAamqAtQnDetSA+
         nMI6lDRdxm8eOSkBRfZZRYS6G7aMOieR8753jYgdFpqUI75DdAVYWCj8cCE8XUW5mGUt
         Zw6wzcchLnBKdgJEdUEd03vVCrrPoEtF8VTY4TU46vmW6bN0Umbs5JlmDeqQfrQfArVn
         cdnYpIDxX92eSHLR2RJFd743GlXbcZF9CDZsIalpS48tpW6f1/CSNSuOqSLyOPBfY3J5
         nzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HuRDse6cwaQ2xwrTLwG7a4zXuTLnjB8VHStZClnoZTQ=;
        b=HqtShiILKLuL4p6gYAMPxB1xvpGApeUI4qGF/Rh02JaSw6lKDzpXEXAFoU6EmYI8Zj
         EqHCZ8AQAO3xgQfMwsJMENagZtBHxjQB3s2TFxBr/EMR01vl1WJrUhn+KBUMKlFDeJGR
         7W1ygzjPLv5jG7vKNL7Tc4muays6BbVJy51Rpt9KVSiEWTVArLpdmnir/bND6U9LrgMK
         XANwGHPeBx2vjHwTg6ffpgLTOPFfQfkENL2zqQRbR8QF3Ei7sr0roDUwP/ZklMvZMAYR
         SU2+kktRmpBLvRm2iaMrOuaLO2C/GOfFHCdZWFIyo5Say7Fnp0xILOrZJwI6MFz4wRyi
         cncw==
X-Gm-Message-State: AOAM531Y95AqYW04z1EzybOSdAJ0nTEzMpA/wnDBFvUSbDjFE5bsq0I/
        n1dQemC7OE97eQDG/Jl7Jrid/4SvEwU=
X-Google-Smtp-Source: ABdhPJwgtyRa278HrEIQPpXV8otrCV8NrTV24x7CwBMCsONcGjG8oSAnexbb0tZHrMyPR/Oa9qKJ7A==
X-Received: by 2002:a17:907:8319:: with SMTP id mq25mr4763752ejc.441.1619794670156;
        Fri, 30 Apr 2021 07:57:50 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id sb20sm2094012ejb.100.2021.04.30.07.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:57:49 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 26/43] staging: rtl8723bs: remove BTC_PRINT_DATA definitions
Date:   Fri, 30 Apr 2021 16:56:48 +0200
Message-Id: <0b83b96133af86e73bed64d7fe35ea96b2940208.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
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

