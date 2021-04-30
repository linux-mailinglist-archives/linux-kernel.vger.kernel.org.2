Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A9B36FCB7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbhD3Opn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbhD3OpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:45:21 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3632C061347
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:32 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id i3so57232554edt.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5KtDzlglqZBamkEg3baS39llf/wufOaHK1MWrZxa8uQ=;
        b=Din4203pEgVpqjQKJGQkaXfTU30nqSKvYezRNXIoPMnpMevN7Vw87VJu9GfJRSJHB1
         7OXoQyZh24fRxvijirNtacRDtxBQOdJGHkx/nBbZXUqdraGYaUlikVPK6LUTP4rDkU4p
         b2lIuhxGjAO4ZXhxM+bClhUrX6pWq4kDNZHX5IbMokSr9kXkto7T4seWdcNrWuDnXcPl
         1D9EjBZin40AjSyzwTet37R4Z1G1HQ0BrRfc+9OgbPJ5YyVzPQXzIpzaEYzISdgzqtTY
         OKCi271mW6G0di3vGY8XIpUND9m47SgGFfeTtCObsYp9pHT/AlJIYtoYEERQoQ+5wlMD
         6eyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5KtDzlglqZBamkEg3baS39llf/wufOaHK1MWrZxa8uQ=;
        b=tMcQA7eGXXnEHf/KWXulOC6K6kb/N8QwjXdVnifo35qMsxDyLX3YTt9gvFAjbC3jLb
         MUYjoHe35az0s5oKLhq6nXRpjxo3BTi8JxMxvDbPpPBvycONSTH+ADBxOuuu1fk7MxqK
         Uv48j43WcF2K3Q5Ao9KkcWjJ9mExISVs7/X6CaEYkg5rpCpmrEg8BvUVtyMbNz7Ea+pw
         zNyJJ4wu9b8dHI7yVkbsy2TJcFGh0gljyQTED3hSXzTynrfQHyZvV+WRh22H3zgiV0QV
         UKbfxQSu8xQiS/hVcL9Z9Mj2+oZeDPSFtR9QuJ7J6dRs8UIbs2+RC9OgPPbYBJ1O/HV0
         buPQ==
X-Gm-Message-State: AOAM533h5kBlMRnZ9JCLlEJj/ZAp7lqrv5w/E2LGnXBwxU/4RRAIXXAl
        kBYfKr3vZ5DWgximvkzFa5C3QYCRAR4=
X-Google-Smtp-Source: ABdhPJxOcVrMm3JvgAQV/iZfdDLo9lSHg+RYcGzEih4tDBOoPFcgoNXhe2P63S9BHCEmhP6sJWgvcQ==
X-Received: by 2002:a05:6402:341:: with SMTP id r1mr6316402edw.113.1619793871368;
        Fri, 30 Apr 2021 07:44:31 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id c19sm1466194edu.20.2021.04.30.07.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:44:31 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/43] staging: rtl8723bs: remove unused ODM_PRINT_ADDR macro
Date:   Fri, 30 Apr 2021 16:43:41 +0200
Message-Id: <b4ecd3b4481f5ef4a526b7ca62d6389b8d097bd4.1619793405.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
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

