Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2015E36A055
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbhDXJE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237339AbhDXJDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:03:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5B4C06134A
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:13 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x5so383625wrv.13
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iUF9VHzbVOwedrHS/nllSjnFr9sMj9nVtpSdM/jLSwQ=;
        b=Bb25OsTNksE6+kbJKv0uWqr2VY25i4yWe0IOZH9L8QKeJfeKyV+QExF013wiwrF8X0
         cSD3vlmztvZuj2auwXpiS251slR1FyQ17xvqBBIYZE+yevLcq3F1ANge9FVeNT0bcn04
         P30am0v4uOhkOhknGeFE8p04gYw7PourVSAQ2suRgVYTJ/xSXmR3dbvZHabq9TTyhCjV
         WBiWLPgWPjlorCP666rva/6vV0sa2d4+LZFFJ4SKAAucw/R/m04rBOsp8vX20oPDsXrd
         Rsy9gwCahJDZTzqmpcokflGFlI4j5BDho9BsLSZjFNCwFVI7gKY4PTTyvHCCJo8M/KZE
         1a/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iUF9VHzbVOwedrHS/nllSjnFr9sMj9nVtpSdM/jLSwQ=;
        b=PwB0haBydTbfJ7Il5GUsJoCTvUFJe6PaIQ18UX0AVPgmi101WIS2u0FftrbnIlcoki
         afDvRGSYhyl7CyPPCzLoZdfhogo1wpotzCyJG/VqS9TTL9Jx6rUQwF2T5lYJO4tJyG+J
         918ZPT7wcgfMMdVhSeRu0Xoe2vEE9dnwZ1dkP0xozBzi4XVFAGeG5eGLUzJAr29ZIGBj
         L+rvzpWpWBrIh7keeGAs1NTCcMpSHr07ZPpAiGr/jN1hERyEdjvRAml+R2GtMK9x4QLp
         SYX/rF5KR8AmBwD2rOIZ38xsUVgtfJtfsgeFzJZRq6Lz/Rgh1q7eGDGRiKSN8xcZ6dDM
         R+ww==
X-Gm-Message-State: AOAM530wINq8IEysL4eGlW6MyEpsBKD7wWVhHJPSWdimQd+toMF/+/Iy
        HBbOOwkMOsUZz+We/56TtsgSPy1GvNyh2g==
X-Google-Smtp-Source: ABdhPJzENH4fbE2zotZyo/ylyn+7/V0NiIXptJF9XbFkedcaYcXK1sjrI6FYcAhACVHxdFtIHED7NA==
X-Received: by 2002:adf:9042:: with SMTP id h60mr9832556wrh.362.1619254992261;
        Sat, 24 Apr 2021 02:03:12 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id y21sm109488wmc.46.2021.04.24.02.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:11 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/50] staging: rtl8723bs: remove debug macros related to core/rtw_sta_mgt.c tracing
Date:   Sat, 24 Apr 2021 11:02:05 +0200
Message-Id: <7f82e61bc21e53a6c3e5bdcd2ac0322b6ff75a47.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove debug macro definitions related to core/rtw_sta_mgt.c
obsolete tracing.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c  | 2 --
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
index 85663182b388..c056a0ada060 100644
--- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
@@ -4,8 +4,6 @@
  * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _RTW_STA_MGT_C_
-
 #include <drv_types.h>
 #include <rtw_debug.h>
 
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index d51e22ee1328..76756f6aac99 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_rtl871x_sta_mgt_c_		BIT(6)
 #define _module_rtl871x_cmd_c_			BIT(7)
 #define _module_cmd_osdep_c_		BIT(8)
 #define _module_rtl871x_io_c_				BIT(9)
@@ -37,9 +36,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _RTW_STA_MGT_C_
-	#define _MODULE_DEFINE_	_module_rtl871x_sta_mgt_c_
-#elif defined _RTW_CMD_C_
+#if defined _RTW_CMD_C_
 	#define _MODULE_DEFINE_	_module_rtl871x_cmd_c_
 #elif defined _CMD_OSDEP_C_
 	#define _MODULE_DEFINE_	_module_cmd_osdep_c_
-- 
2.20.1

