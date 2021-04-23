Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41172369556
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243202AbhDWPAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243025AbhDWO7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:59:49 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F540C061344
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:13 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id g9so32691947wrx.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YcuffsLTjuFNEp9yR3yPCxH/1v2srf0L4WVCdD7zdno=;
        b=PL1ktp6WwrVG9BHvzOQtMPTLtKMy9ZtV0lHFaWlDaqd+cZbwrnKaDXMEuJWJKzSS4p
         i9VhsZZEpc4A+auiLWRJ13d5CTRam9YNGVp0RCIZmF3CAaT15mQAuJVXZOWgmXGJBM7D
         bU3N79aqndm/Hnt+izuBQFEb3xVPF5lvgXsyiZag8L4ah3kSwYZizRzXr8vz+y+N+Efe
         uxJ2cL1437YOP3pfahYElcI4aeuHqkdMyOk2T/pSBDL0grGnpaw48DrQzIu29+Y6wHnU
         OUChe5LiRXMChdSHQe2vF2SwFX//tMJzjhFcxtPZZH7Eh4JXUuBYP6PERCyUIMfN62D/
         xIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YcuffsLTjuFNEp9yR3yPCxH/1v2srf0L4WVCdD7zdno=;
        b=Epyg818RhMsd6w3hR9xjxMJkD9S0scGTXfmSi+zgTXl1rz4LnQcZCL9/eCwAoMfjJq
         ORG4HsmpaucTqbvYOT0ep5uK36Ckc8kCibMyD+32g5S/kjq5SUjcmDF/Q3n9jr3O6yvp
         U1HrASytNw+BAHmQw4kRN9WjNVWCBPCiUOrXKr3Re6mEq4FNZe88qD1HT/IIPahWMacI
         4kCgGcnWaVuR7Jt1M8bum0cddXIBA3MEcucxFkzKBfesqMHReelP61bqvBHV6utowDKA
         VypFst3ChbOIsfgLO+BO11KgHtL+qoe7uJuisCQIW6pudQYh3uZsYtLFbiuRsMqCkqjQ
         f7mA==
X-Gm-Message-State: AOAM532TaZZ+h7lacIoOMpvcukzXF30aQWEmCvNHbYswdLa+mg46rwKt
        pS/zBAa+1Q4CQZYLqh3bOiPGLKZNB1w=
X-Google-Smtp-Source: ABdhPJyh/vdvhVuSdTnyUrz72NuaKjjUxoExed49o/z2Iw152YPoGpkcyGjmwvowy9nBYvSnkjDN3w==
X-Received: by 2002:a5d:47c1:: with SMTP id o1mr5251729wrc.216.1619189951569;
        Fri, 23 Apr 2021 07:59:11 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id y19sm10938803wmj.28.2021.04.23.07.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:11 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 18/49] staging: rtl8723bs: remove debug macros related to os_dep/mlme_linux.c tracing
Date:   Fri, 23 Apr 2021 16:58:09 +0200
Message-Id: <03280c041f2476619874b281b6b5caf397cd024a.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove debug macro definitions related to os_dep/mlme_linux.c
obsolete tracing.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c | 4 ----
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 01d723268254..7f5b98578d60 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_mlme_osdep_c_		BIT(5)
 #define _module_rtl871x_sta_mgt_c_		BIT(6)
 #define _module_rtl871x_cmd_c_			BIT(7)
 #define _module_cmd_osdep_c_		BIT(8)
@@ -38,9 +37,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _MLME_OSDEP_C_
-	#define _MODULE_DEFINE_	_module_mlme_osdep_c_
-#elif defined _RTW_MLME_EXT_C_
+#if defined _RTW_MLME_EXT_C_
 	#define _MODULE_DEFINE_ 1
 #elif defined _RTW_STA_MGT_C_
 	#define _MODULE_DEFINE_	_module_rtl871x_sta_mgt_c_
diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
index 0a16752f805b..a4560ba22db1 100644
--- a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
@@ -4,10 +4,6 @@
  * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-
-
-#define _MLME_OSDEP_C_
-
 #include <drv_types.h>
 #include <rtw_debug.h>
 
-- 
2.20.1

