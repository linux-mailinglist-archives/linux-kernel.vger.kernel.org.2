Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD34369577
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243595AbhDWPCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242999AbhDWPBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:01:17 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AC0C061363
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:59 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j5so47741672wrn.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fTcOY2KPuML+7k+l89QwiCfZDtCp1C6AXB96qqJFx+U=;
        b=pLWS4sC31Vc6QYX//XgjZKZwTphbe9939JFEyWpbJrCpQKG0WAy351UAlQKgx2B10E
         LAzmTse/h+sBqre8HDvjQcok10n/FY0Dnm8xBrQ0rtHhhPc9sxgeWK03kgAZ3bUaUepz
         RSx5TUycoJZzGvOY/Bnj3XxkICqNM4QW3eAGilPNdqPp+iTes0llR24ZdJPzkQAY6Lc0
         20qKTN5G2dRP1Dwl/Tbx9Y3GBEaMIknzeSwS+WilLlJvPkv3X0uqojS8ccckSgbVJx4A
         gSzwdzgZHvn1qecOPSfMoLHwXWeoXDdg31PTm0wAk08D1X1P3hUSOTqd38rMgxj8eVJP
         y0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fTcOY2KPuML+7k+l89QwiCfZDtCp1C6AXB96qqJFx+U=;
        b=X0Qy4Qlqf97A59nbhoqaakK0EcIaQKcVtNPVtNuAt7LD0ay6es8fanPCtnzKjMBs5x
         supYGJi1q+w+KgMVyd1+bM4k3agRG/PwbNZrWaBFWf/FeM68WdhqGZO6oUDKfld9nSgS
         cOrOlMdQe9Im3C+iNh1GKQg+iJfkLkZP3IYBjaXwlY5czQJHpVHUpmERyBU5EyzarNde
         HPsIZ1fnJqbmyMJmPHJglxj+9QXjfJoGRNLhL+WNbZLf6xD9YSgbm9fmIxyqR8hCZ+yx
         KEcq5CKQpRtQ/QY7AT064O6Eyl+c2JvuM74uREfGCKVi8ZwiUkZdKeaI4f1cH+BlzY7J
         jLGw==
X-Gm-Message-State: AOAM532kYdIwMv1lXv5C2RSKKT8tnrdkGeFPJSj1snXFDd3B0ECLYetI
        0arU5rs8jRnZq1QMi0CPMSOpMcXvqYw=
X-Google-Smtp-Source: ABdhPJwbKhdGqdQAaCc50mPmWWBjC1Ko7ZXBrgsvtRX0/CmYO5Hh+l1i8Fz4ItLVRR13j/Bg0v815g==
X-Received: by 2002:adf:8046:: with SMTP id 64mr5136805wrk.176.1619189998050;
        Fri, 23 Apr 2021 07:59:58 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id i20sm10237654wmq.29.2021.04.23.07.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:57 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 46/49] staging: rtl8723bs: remove unused macros tied to core/rtw_efuse.c debug
Date:   Fri, 23 Apr 2021 16:58:37 +0200
Message-Id: <f2e7d02bd66dc3e6c2ae37a53f88608f306d80e4.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused macros tied to core/rtw_efuse.c debug.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c    | 2 --
 drivers/staging/rtl8723bs/include/rtw_debug.h | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index a28a06d5a576..1f22eb4a29fa 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -4,8 +4,6 @@
  * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _RTW_EFUSE_C_
-
 #include <drv_types.h>
 #include <rtw_debug.h>
 #include <hal_data.h>
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index ad96fe1de971..6b657190b124 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_efuse_			BIT(29)
 #define _module_rtl8712_recv_c_		BIT(30)
 
 #undef _MODULE_DEFINE_
@@ -22,8 +21,6 @@
 	#define	_MODULE_DEFINE_	_module_rtl8712_recv_c_
 #elif defined _RTL871X_MLME_EXT_C_
 	#define _MODULE_DEFINE_	_module_mlme_osdep_c_
-#elif defined _RTW_EFUSE_C_
-	#define	_MODULE_DEFINE_	_module_efuse_
 #endif
 
 #define DRIVER_PREFIX "RTL8723BS: "
-- 
2.20.1

