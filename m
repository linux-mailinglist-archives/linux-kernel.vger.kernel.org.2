Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3150936A04F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237538AbhDXJEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237243AbhDXJDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:03:38 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A25C061574
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:00 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id x7so50644585wrw.10
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uebmfgQMAfcpGhNA6iUMcWPD2SCRSOhYjmZfyYN/7+o=;
        b=a23N+5LN+79hjgqq1Gcoy9rys2Qb1OOE1+7LOZmBv4QUbL1+YgpUkF8vVXa+i2WppG
         IHcJkFHkoSDKrP49LkWeLjiOzfL1BPCHVwdA6h3CX2CVsqDgjlSVrEiWTYFnmUjnyUYm
         fAe2M1T3sdZwBNcKcagrW23xU3/oyCvazaGH1OeIl9PTwrU9uSL66BKsxjhP5ENGyGkk
         zaoO4njoYcz6HCo5WJT2KfJuGN9/jqQZS89x5djElQFj9CWZ9xzKFZUgURTN9a4nQKZM
         ZqcxJfN6kwwKtjv5CSlKbTLAuFdw6TIMdYFdKs8Zfj5wjk0RcDEQEdF5bbjcLukh9ZtK
         I2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uebmfgQMAfcpGhNA6iUMcWPD2SCRSOhYjmZfyYN/7+o=;
        b=g/3cN17gxdNM+06cg8oZ4w+fAbVHFUU0yzIZZ5Q2yzI7I7QgtaFwojPGH4YWolBh6E
         ZpPRRUiIT4v6h40vDdI7MuJvi5l+JH/E5xDHQd7vxUd6Y2PHzfQI7sj+HdsNUhsJrzvB
         pB+/23Qm2uL8kPg6XR2QxtFiss6hwnwwi3TV/H/D8h8uVHrlMG3+lpKxMJvBlj26JVpi
         vOa6bMnsYHk4nd/jL1mdg3vR9wXsx3U28y4TeNddrJi5pHDE2JdKnxENyC/XWXWhXtWS
         Cn9ltvArtKp+4x5rkXYfSzI48Sa5ygur29DmpCu9UI3t1p1tWFnFZoin2ayIqaIUA0nV
         idQQ==
X-Gm-Message-State: AOAM533iEg7Xc+HXvNbwSenpBWUPlexZ9VZ251GbqvmtseuzUHmQzv3E
        Zv7GROwZFshKDil6SYJwshPiaYrZX/Iq5Q==
X-Google-Smtp-Source: ABdhPJwEyLDYyosZyr+vw9gnKKcz4XodLgoZl5Q1iCE/hAbj7CEywvO8YAK4DMwI3LysSN1KicJe1Q==
X-Received: by 2002:a5d:6648:: with SMTP id f8mr9776583wrw.76.1619254978780;
        Sat, 24 Apr 2021 02:02:58 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id h8sm9011272wmq.19.2021.04.24.02.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:02:58 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/50] staging: rtl8723bs: remove debug macros related to core/rtw_xmit.c tracing
Date:   Sat, 24 Apr 2021 11:01:57 +0200
Message-Id: <fd7f02bee9b97bf4222931710092a54892825a3a.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
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

