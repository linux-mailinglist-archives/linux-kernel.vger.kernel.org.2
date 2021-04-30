Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC90536F68A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhD3Hpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbhD3HpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:13 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3BFC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:24 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id y7so4960603ejj.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5KtDzlglqZBamkEg3baS39llf/wufOaHK1MWrZxa8uQ=;
        b=d3/pUR2Nqt+W28OZ2lCM5Uzhw66hGJis+TaE54rQAq8K2vp0SsA4z99DVqfeozCkSs
         v29xslHPgu85UMHNfTd89VEwnsuomP+KJbPLNg3rweRqBK1b9uA+BaDGlRr9jJV+6dNF
         RUsZQCbz8b4qU0foo/MNWgUkPSI11BCeTYK4Ucys40WyrmzchQM53xba/UKE0dGbOwIy
         8yInow2klFYNZtzUDqXTu/TsKD5l1eqmDEUdNrJv+VGiU3h4uGwA1AGU+eOWTIIaMtrx
         Mkytl2aiWjf5pXdo+HzchGHO7yWVewkYLEw2ojYEs3HIJUN3gPs6FNEW+TIAg3lP7s0a
         EH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5KtDzlglqZBamkEg3baS39llf/wufOaHK1MWrZxa8uQ=;
        b=owwrJ3ws3YG8z7h9pwFNxZ4uImRzknBR8huXHbg/xJwG8Sj0MVrCym1IhVsmC1aP94
         Ad7pF0c7s3vOqxlyLKDdklq8NfmfVXVjXRg3vrmLzhplCPYJJr/Lwvog6AK+JM+HshS/
         gwvFGeMe1HBqlxrjRASGrkjGRAp/xS25rdqtk1UeF3AC2RH+cGkDIL0k02iT4k42SRyh
         x6g66cz2hlf4Nm6w227vs9CWNipvaBIhAtg4QMZg7PMdfYOwqdtmeUBdnloZpV2NZfYR
         nk4cNQn7BKfIXUoczCy8pm+DwM+IBNyc9lDVQll0KXfLRbdMWDFLhFbPCGNRlAt61lTi
         lTEQ==
X-Gm-Message-State: AOAM530jaPfSdnv/O1JhxEz7PlwH9Owlhyt1UDqbtj4K7DjlHC9vAmq5
        muyifkhQf5Fd/ZDp9b2GO8wpWbCpbOW43A==
X-Google-Smtp-Source: ABdhPJwVIF8ITMhVb8X8Em+35NkKrPoysMsTYu0Gd8AgstVPCStRMqwR0u6NikdMwS6CCvWgUwej6g==
X-Received: by 2002:a17:906:11cc:: with SMTP id o12mr2846392eja.85.1619768662943;
        Fri, 30 Apr 2021 00:44:22 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id kt21sm844481ejb.5.2021.04.30.00.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:22 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 11/43] staging: rtl8723bs: remove unused ODM_PRINT_ADDR macro
Date:   Fri, 30 Apr 2021 09:43:29 +0200
Message-Id: <a306d9db52e6d91cc5462e8482ab5ea002b65f91.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
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

