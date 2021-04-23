Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F20236954F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243134AbhDWPAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242895AbhDWO7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:59:42 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C5BC06138F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:04 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id y5-20020a05600c3645b0290132b13aaa3bso1397069wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uebmfgQMAfcpGhNA6iUMcWPD2SCRSOhYjmZfyYN/7+o=;
        b=gUVoNI3QzIrKEoL4wiR3MV+iNT+s6utTeneE6mkLIB/Vioti39Tmslp4E/LQLpoc/7
         Q2svVBD9z3bMi35AP3Eh52loa2vCsL7uiQ93esRApwLmm9N4LukcYenbMJeuVLMHARR5
         ooxtPZnJisZZbBE9A+tcKIX5aQw1BxRwjXqIr8gSX5ci1e4+4Tp7Rxvc+J0RvgKbxwH4
         AewOc4T6VIKH3rG/xlaeiScAWRYSGtUsn+j5VwSfCwCk/93EirP4BqbS44Sv/fAXIAPA
         whVtcLPbifOtj/tggyC7QVtXgO+fWAEA3QJQRYMH5cSms9IKibjf4ZsKWz6cp5eFz9c4
         YtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uebmfgQMAfcpGhNA6iUMcWPD2SCRSOhYjmZfyYN/7+o=;
        b=sbcl/djXhrWuFaN1KxDnSfWlbxI7kZwcxbouuK7sd8uXjpcsD/MedFXhIMyld9m6am
         EuWLh4uiMOjgViwuGA6YJMzroNID7otyI19wk86C/OaSHaoSeUWixp9lLrgcp9JcxA+L
         iFNKUOveHE5PbrALJFCkyACRYJ2DP6IWV/dPZoShmlltO/CtosBGGQ1wBHgQ49wyiEnw
         7E/a0BwMNf7CuRWSfDMK1fzQnkGNqef8/oamFxktgin3sw8JrWI4DrH0vyGb88lp1dEl
         hZGYGHhJjuGCzRP+4bNyafmB/ldKXt1uPTB2ntdIbLzPJaJYHwYlwAwHAQ5Bb7deAr20
         WQnA==
X-Gm-Message-State: AOAM532E8dYOS0tdXpNc0aPFSIO2aqevHA7u2bRLMJbSM4ilCTFwndDr
        EM16s+BHwVw+6ghFqL45e67JA78Mew4=
X-Google-Smtp-Source: ABdhPJzo7CP8XyNaTXltIiOJrsYsW1E01EHQVSJqOcpCGTEjxBEmQrmXFz+ut6Z8/2oQqrpsub6DEg==
X-Received: by 2002:a1c:f618:: with SMTP id w24mr4680983wmc.93.1619189943167;
        Fri, 23 Apr 2021 07:59:03 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id t206sm8149950wmb.11.2021.04.23.07.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:02 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 13/49] staging: rtl8723bs: remove debug macros related to core/rtw_xmit.c tracing
Date:   Fri, 23 Apr 2021 16:58:04 +0200
Message-Id: <6099079cd0e4d0e56c1b0a3e879824f42376a816.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove debug macros definitions related to core/rtw_xmit.c
obsolete tracing.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c     | 2 --
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index bd3acdd7d75f..03d036bd2ac6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -4,8 +4,6 @@
  * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _RTW_XMIT_C_
-
 #include <drv_types.h>
 #include <rtw_debug.h>
 
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 8f56d1e7e644..ea4d34678b9c 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_rtl871x_xmit_c_		BIT(0)
 #define _module_xmit_osdep_c_		BIT(1)
 #define _module_rtl871x_recv_c_		BIT(2)
 #define _module_recv_osdep_c_		BIT(3)
@@ -43,9 +42,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _RTW_XMIT_C_
-	#define _MODULE_DEFINE_	_module_rtl871x_xmit_c_
-#elif defined _XMIT_OSDEP_C_
+#if defined _XMIT_OSDEP_C_
 	#define _MODULE_DEFINE_	_module_xmit_osdep_c_
 #elif defined _RTW_RECV_C_
 	#define _MODULE_DEFINE_	_module_rtl871x_recv_c_
-- 
2.20.1

