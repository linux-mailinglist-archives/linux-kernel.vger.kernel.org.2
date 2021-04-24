Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC9136A050
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237300AbhDXJEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbhDXJDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:03:42 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD3DC061756
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:03 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m5so486236wmf.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5c1+Q0KzVEpEp4ZoM+JKnpzyHdyY1+xbVigGE4V/QiE=;
        b=EnIVTGkuzCzlhCRwBD9Oz78o7BO/cEo1yICL4IMJ1RzNjshl3yupAV8uLU3XMotmty
         CPL/tFAiV1776mj3YcIudRtqL8l2VLZAPWJMSn1fqp93GsbQ+H3lU60bPwbABznOImjb
         0drdgHDX/xCIyToZL8kNHfvxuLXYINMZuTNAteTG5EZmgLzizlhNZgbYOT3MpuSONepI
         2I1MdHJsMaJ614pQ+1LASBvHmXyWZ8TED06+/HjXzO3lreJ+oHRAgpwby9PiGJ7hrtvW
         w9k1MoBsvMXzfNpYJ2EYmldxZWqQuLfeECX2QvvDx8LqyrbPgRsx0WmQ+D8mMW5APugs
         CWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5c1+Q0KzVEpEp4ZoM+JKnpzyHdyY1+xbVigGE4V/QiE=;
        b=TmhsY8i4q6pQzLu1cafSw/E1Mo9iIL7SaGJjRBj7TBvtbpLkABwq5ZhfK1qXacnb4A
         eptyC3TCbZUmOqNMxwujTha/OvoYPPX2s1l4uVb0aiam6aQyBxzwyfx2ak5vMgcjOic6
         EgPATlrz1WK50Gk8am7h1fpA9J2aTJoWGiRhX50kQ7clPhPuu9o07/DEdO4ZXsnBGEtT
         yZ+RYmJ3YhTWOc6lcKBDYNfEvy73Dzakcfe8TbuQ1iGOx1mSVjZYksLYyPLYs3np9way
         gOMW8C4KWJMbrdPASAV3LPu07nOUKjyiQLIb7fNWuHaoNkXFhWfzaFhmrO32SKC8sg9b
         DkTA==
X-Gm-Message-State: AOAM533Huj5kO9GVG7uUVt1IoyfhqUvYctlFRHX6tTkuBLFbWOrbCmf1
        8xodE5GQHkYDMPpiKrRw/AkKQBhGATz/1w==
X-Google-Smtp-Source: ABdhPJxjehdPwrwm46TU8LHIi2jNeBKqBag6Uo02OxUSe7X/vNJZ+x1+AjSjZOY0puixzQFWR5aU0w==
X-Received: by 2002:a05:600c:1546:: with SMTP id f6mr8346403wmg.156.1619254982147;
        Sat, 24 Apr 2021 02:03:02 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id q17sm12222607wro.33.2021.04.24.02.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:01 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/50] staging: rtl8723bs: remove debug macros related to core/rtw_recv.c tracing
Date:   Sat, 24 Apr 2021 11:01:59 +0200
Message-Id: <5af86d4dea96caf9c84f9ac302ec060edbc2fb65.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove debug macros definitions related to core/rtw_recv.c
obsolete tracing.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c     | 2 --
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 668a703dee7f..7432def1eb6f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -4,8 +4,6 @@
  * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _RTW_RECV_C_
-
 #include <drv_types.h>
 #include <rtw_debug.h>
 #include <linux/jiffies.h>
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 6403a11d712d..422d6bcfcc6f 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_rtl871x_recv_c_		BIT(2)
 #define _module_recv_osdep_c_		BIT(3)
 #define _module_rtl871x_mlme_c_		BIT(4)
 #define _module_mlme_osdep_c_		BIT(5)
@@ -41,9 +40,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _RTW_RECV_C_
-	#define _MODULE_DEFINE_	_module_rtl871x_recv_c_
-#elif defined _RECV_OSDEP_C_
+#if defined _RECV_OSDEP_C_
 	#define _MODULE_DEFINE_	_module_recv_osdep_c_
 #elif defined _RTW_MLME_C_
 	#define _MODULE_DEFINE_	_module_rtl871x_mlme_c_
-- 
2.20.1

