Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89A836A057
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237770AbhDXJFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237278AbhDXJDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:03:53 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693BFC06138B
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:15 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n84so62891wma.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FguT1SZP0JKjZXOwzC5Q0evIdGUpU5e+RgS1n8RdIQY=;
        b=DaXqSCdh3chxk2lFcY0cx3yw6zm/lhWXLGbkTVEVN/y9A8CRwnk6HVhneedZzg8spZ
         D1eGfxSyIc/pTQ9QIf3weK/4r+8v4K/h3M5Fsh9INxd/pe1EfzDZy5HBUgYwkYOZf8fg
         pKsGFK5Jr0kD13j3itPKbsnalHSnfnzlNTWamr65zFprUPK27n1LXpxXA+Wa11DLiEq7
         EwjtqQNf/S33dP8czBMgsg6cgYNBzUBYj4eILuDQH1ctvmV7W4jbBcC89OvsS0DQ38An
         uq4aIE6SrEclsU6nUNOJnaXhLH/K3/yKDEeapF4ftW5Qd0UAmfJLjVua8mW85KhEHwbi
         Sehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FguT1SZP0JKjZXOwzC5Q0evIdGUpU5e+RgS1n8RdIQY=;
        b=X6aX1mQ3+DK0mGsuhACZh86kv5w366go9O+ncKXNsyEgx5+ZwveFVTxxlGNHQXpBdB
         LNdMGrqiC3BKKsYBerv/Qb+Uo/LslrvcekX+LxXnoYYRvcj63x4i8GL/tRKTqCENSNNb
         XGoTyPkxPmUEzEc0R+mocxMb7vuQuXMbaDsrjBteRa5+dADcDDDNXbTRgw25t0aiNuQB
         Qs1J0W9Gwngz8yaF1sr/JDTpsPteoKqKg2hiJhVEBchVR3UHLCEb2lR4+9so/eQ1vemh
         7Hq7Pc3jbmahhsNjUy5eLhCrhqsbKmYqXxiMAi1qJRI+lL6zneKaQda/EAiGass6YDmE
         pJkA==
X-Gm-Message-State: AOAM5300DfZLrqIIvnp3sQyJkDVqY8XQE9s8H8aipxnkXoSrLlJEMnES
        jIbKK4FC2n8UpGOgiO7DTdovyHKihOSdLw==
X-Google-Smtp-Source: ABdhPJzO7dxzl9aJhTM8WTKXi8AG+9/ODeRhwBR0g0eMdyU1iULXRT3w2XjHTuXSlwSNE2nMaKWZxQ==
X-Received: by 2002:a1c:a949:: with SMTP id s70mr2384137wme.84.1619254993954;
        Sat, 24 Apr 2021 02:03:13 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id b16sm13178275wmb.39.2021.04.24.02.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:13 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/50] staging: rtl8723bs: remove debug macros related to core/rtw_cmd.c tracing
Date:   Sat, 24 Apr 2021 11:02:06 +0200
Message-Id: <7b32950581f7584b448ee277627fc57beb113026.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove debug macro definitions related to core/rtw_cmd.c
obsolete tracing.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c      | 2 --
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index e1a8f8b47edd..75db4272e537 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -4,8 +4,6 @@
  * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _RTW_CMD_C_
-
 #include <drv_types.h>
 #include <rtw_debug.h>
 #include <hal_btcoex.h>
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 76756f6aac99..bb56d38e6b7a 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_rtl871x_cmd_c_			BIT(7)
 #define _module_cmd_osdep_c_		BIT(8)
 #define _module_rtl871x_io_c_				BIT(9)
 #define _module_io_osdep_c_		BIT(10)
@@ -36,9 +35,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _RTW_CMD_C_
-	#define _MODULE_DEFINE_	_module_rtl871x_cmd_c_
-#elif defined _CMD_OSDEP_C_
+#if defined _CMD_OSDEP_C_
 	#define _MODULE_DEFINE_	_module_cmd_osdep_c_
 #elif defined _RTW_IO_C_
 	#define _MODULE_DEFINE_	_module_rtl871x_io_c_
-- 
2.20.1

