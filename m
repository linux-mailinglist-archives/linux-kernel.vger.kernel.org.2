Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0915536FD04
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhD3O6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbhD3O6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:16 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81809C061347
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:26 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id w3so105737901ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5KtDzlglqZBamkEg3baS39llf/wufOaHK1MWrZxa8uQ=;
        b=AlWBx7/oB3YlhNtCS6fmYXufz89ZPE+hdIuJ1po89twnm6pXmrEZ9y9Pz9SvSZkV0K
         Mb4sferP5wVXkul86OXANpJgMqyB7mpfz9OH3J8afxCXwhHaLtkWlNGpGYwUWC2lULwG
         uuLZQ/B6tKkj53jWRnkU2eDzoDdAuGlHTgpL0ChCRRhJMx31OfA58Pjowq2MW3Ww8BQo
         5D1ZLs75hESGHrkffRtidWSinXMudUpu0NGpqlTbjblsGsXTZvOm4rZUnw5cdqtimu3Z
         Q9tCn1lRD5cmJScywufNknke4zqFPJYkmiavJcYfzshhW4A7+FQAQZpPs5PbCxYYITFn
         6Zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5KtDzlglqZBamkEg3baS39llf/wufOaHK1MWrZxa8uQ=;
        b=Ee5A/OZWXKLF+Q+YdZSNVTl2huO52au/A5WB2EGp5LigIfKbj7JT8WzMMbotx1HgUm
         M9/+8OI9i2GLSPfWXCWaYX/STqOCAUnkybE0CzKnNCbU7QjBpbHhmB4elvCaUkWoeJMf
         WmX0h4s7rdZP+yzmx8D0rW2N4O6q8bJL+HxtTOSnw6IkS2xG0U0TkmMWJBg7DzAO2YJr
         hdxIBQRVaidTaNFFonnP1jfUxaUjCz6XkhgnnFSaG5e8dh+5mXA0YZwZL/em3BppPnhf
         TeWSNNo7TQRmZlvxpDyq/m3uKedJSEoxGhD4H3fg7VVJZqyXNmZag/4t10DqD7I3J76R
         DcCw==
X-Gm-Message-State: AOAM531lkphNWBZ3w7UOvUI/JnFDuJ5lMQOM0hSMONXzMs088+kcgriy
        nm3iwhrOyd+WuCkBsv6RJVWYfnXh6/A=
X-Google-Smtp-Source: ABdhPJyYEI65+jJeDYqpyFQvJxJiPhO+XNts1sUqbDb/dFjScoVHCWyCbf9JqU78xANRt0vrqhJGFg==
X-Received: by 2002:a17:907:1b1e:: with SMTP id mp30mr4905363ejc.532.1619794644955;
        Fri, 30 Apr 2021 07:57:24 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id jt20sm2072544ejb.79.2021.04.30.07.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:57:24 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/43] staging: rtl8723bs: remove unused ODM_PRINT_ADDR macro
Date:   Fri, 30 Apr 2021 16:56:33 +0200
Message-Id: <8f04c3b8b841efc4271d4a7ef71a95e04894d64a.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused ODM_PRINT_ADDR macro definitions.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_debug.h | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
index b4fc247242fe..58de4d16335e 100644
--- a/drivers/staging/rtl8723bs/hal/odm_debug.h
+++ b/drivers/staging/rtl8723bs/hal/odm_debug.h
@@ -97,29 +97,10 @@
 
 #if DBG
 #define ODM_dbg_trace(str) { DbgPrint("%s:%s\n", __func__, str); }
-
-#define ODM_PRINT_ADDR(pDM_Odm, comp, level, title_str, ptr)\
-	do {\
-		if (\
-			(comp & pDM_Odm->DebugComponents) &&\
-			(level <= pDM_Odm->DebugLevel)\
-		) {\
-			int __i;\
-			u8 *__ptr = (u8 *)ptr;\
-			DbgPrint("[ODM] ");\
-			DbgPrint(title_str);\
-			DbgPrint(" ");\
-			for (__i = 0; __i < 6; __i++)\
-				DbgPrint("%02X%s", __ptr[__i], (__i == 5) ? "" : "-");\
-			DbgPrint("\n");\
-		} \
-	} while (0)
 #else
 #define ODM_dbg_enter()					do {} while (0)
 #define ODM_dbg_exit()					do {} while (0)
 #define ODM_dbg_trace(str)				no_printk("%s", str)
-#define ODM_PRINT_ADDR(pDM_Odm, comp, level, title_str, ptr) \
-	no_printk("%s %p", title_str, ptr)
 #endif
 
 void ODM_InitDebugSetting(struct dm_odm_t *pDM_Odm);
-- 
2.20.1

