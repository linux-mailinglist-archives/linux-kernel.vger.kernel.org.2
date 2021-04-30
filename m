Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E75F36F697
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhD3HqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbhD3Hpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:34 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672CEC061347
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:46 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id n25so9411400edr.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z2J3mDg2zWp/DiXrFZERoJKoUUydS2LszSVYaoRZjCo=;
        b=j+n+e8njFCzB1griAqLKTp1DMR1dpalhHbH33EAmHa0TrQIDWOtxGwHSF66H/3cuZc
         e/TtPy+9FqiVYP/6APJb1QtJxP8JeqhjU4UPLQCYRSmy1HRjA5EIIqT7DUDhl2UIz68E
         9mxwTY4rt7KTVoDoRwQqmLf6mnAf6WMccIV+6R+Hpc1ORNHpFNzFH4zIR3igtMUpAArn
         0aQGjlLpcQqwIoV6nWsRZFgcMgBVcx/XnkV/Z0Cg8b8+7k4ZesH5eiuSwrgcG74XkRz7
         RuMe9dtfhFLZd98RbRx7Sh8ByCXGu2d64LVY9CZIZeRoz97X47df4HV6358C9grpHB5P
         papQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z2J3mDg2zWp/DiXrFZERoJKoUUydS2LszSVYaoRZjCo=;
        b=DBqweqMWcfc0N3mnt5PTVm2YzX5Pu+dy7p+Sm0xbAvCoHVBOaoMJOuphLE5823bDT+
         FRePVTmPJN72XwU0JP4p4OLAiiDbcaABEjyRgZ65oEkqgsL7qrHh1Ideskd60eQzU97+
         u4WkT7S8X3VFolTV5ga1rI10Qig7fbAtCfhFXMxK6OuYMqhtWTDzjeV1p77KlJk9W0Z3
         ZG1gPEYDYX16vsEfrqttbvtltinMqngLe01AuVwtgHOEjHJ8tVAgIqe/iZ0kKr75tl0A
         STytxl4Pwpj9cK8CdgX+KBFlSdSJ+GeXJ89OmmGw3patTBri0H/+PYGijUgSoz+NrNED
         JR7g==
X-Gm-Message-State: AOAM530r1jyLBUX+CxBoW+Flbqgun6inj8QIh2FI+2/sb+ThkUqUruuJ
        NKR2ZFBUniaa3R7YUzwZAyPumYgUmxTjFg==
X-Google-Smtp-Source: ABdhPJxreh8JfxzjPqCOIKYDMD975lZYkiASyr1c0L2Pxmusp9HZ/YSC/DTPlbKAV2MiUtYAd/E/Vw==
X-Received: by 2002:a05:6402:cb4:: with SMTP id cn20mr4029344edb.167.1619768684779;
        Fri, 30 Apr 2021 00:44:44 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id w13sm667205edx.80.2021.04.30.00.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:44 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 24/43] staging: rtl8723bs: remove BTC_PRINT macro definitions
Date:   Fri, 30 Apr 2021 09:43:42 +0200
Message-Id: <3bf024cf41776c2437ef6b7966df75dcbc458947.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
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

