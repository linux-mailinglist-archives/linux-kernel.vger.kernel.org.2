Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA0136A056
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237606AbhDXJFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237338AbhDXJDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:03:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A31C061349
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:11 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x5so383577wrv.13
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cKfjBv5oTcSk6L5J12Sz3Xed8IildkiInI8JvUMXG+I=;
        b=pnCcuvbIGaWdqR4V/LQbfi6kXIiXQFcPHDBk8XFUT/wqMNstezCtn6+5j3zGOzhNul
         5+KnlHJpj4dPkIgXIQSa5nnED8tEsOFbhGez5KE27CgI2RUbOZcgGxX+jG++kIIoWSgz
         S3mVgQxjsgLSTatKdvAMvGtnsqAgYPlUw9qr+KPnZoHwq7qHjNQb0i+JS3aYDGAYWEu5
         9JbwOnGpVSK+tHZYNktXb6ZTBUP9GBBBZcNdjoPdp9UjSPU15+VvS+lwXzDJepjbug8h
         K53DqZFxPzyor/2vk2sD1WiJsjIRlHUpN889i7BV5Rrni0DbdMapkbO3GrayOAfVcFaW
         ldzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cKfjBv5oTcSk6L5J12Sz3Xed8IildkiInI8JvUMXG+I=;
        b=f70Z9G4lJoYLtNehnCx6dOrwCsxHju6ZTd8T+mSpK6a+ohC5qMW1Z3pVOHKUJ79avv
         cSMFHSE057JB6wcbL/F9aCqHDcCV24aI0jAWg+TZ9I2coV9ujVW5vwkECQSbH7Q/hJ+4
         bbri8giaKRXFuYJDbZn4rqasGnFodBTRNw6dWjjur5qHO2PMy4IIYTpg+nUYHL9w7CIa
         hAXtxeMkqKLg2HbGRVUqLHioxYFy20/4ayIDSoXdaA4e0Mm/GY/SAdwAG0oPhbaiztuE
         qL1JgSbgz92ympLs0HZWdhp4Unk1SG2EtOGG02DnI2Dfr2/sJFCGxqwf4IUmljhWxGs7
         HLJw==
X-Gm-Message-State: AOAM530taUK/vTwgCkK2ZycP93s0tY8l/H1FYZgAqmfMGZUjoLVKlVQB
        6c5mNblDkBhS5f9whNktRLk/j/TGPItdrw==
X-Google-Smtp-Source: ABdhPJyPvo0oks687lQmMxXLutE7tIoQmcZTUIUDaimewHaCowJBbXx5m+eIykv2b4wP+hJCO9JPRQ==
X-Received: by 2002:adf:ed4b:: with SMTP id u11mr1165798wro.293.1619254990482;
        Sat, 24 Apr 2021 02:03:10 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id e33sm12402294wmp.43.2021.04.24.02.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:10 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 21/50] staging: rtl8723bs: remove debug macros related to core/rtw_mlme_ext.c tracing
Date:   Sat, 24 Apr 2021 11:02:04 +0200
Message-Id: <1579e958f5aa4584f6477a5b7c9bc3bd8933a5f7.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove debug macro definitions related to core/rtw_mlme_ext.c
obsolete tracing.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 2 --
 drivers/staging/rtl8723bs/include/rtw_debug.h | 4 +---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 1ff2b3a28bab..3e4dc44c8599 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -4,8 +4,6 @@
  * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _RTW_MLME_EXT_C_
-
 #include <drv_types.h>
 #include <rtw_debug.h>
 #include <rtw_wifi_regd.h>
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 7f5b98578d60..d51e22ee1328 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -37,9 +37,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _RTW_MLME_EXT_C_
-	#define _MODULE_DEFINE_ 1
-#elif defined _RTW_STA_MGT_C_
+#if defined _RTW_STA_MGT_C_
 	#define _MODULE_DEFINE_	_module_rtl871x_sta_mgt_c_
 #elif defined _RTW_CMD_C_
 	#define _MODULE_DEFINE_	_module_rtl871x_cmd_c_
-- 
2.20.1

