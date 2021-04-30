Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3E236FCC0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbhD3OqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbhD3Opf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:45:35 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98386C06138B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:44 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id l4so105605319ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kxnsY7XxgR5LPkLt/HzBZqQVJx7TOeoHfiVCxdpmUW4=;
        b=huHmkcG0shMFd+wVfhIXFj6YLFfnIhH9F8fowk6Wb+mZCEcLlAQIBcGNovzPSRHPJW
         VLI/SBO+BoZ5zS3JpX4quytJKRA3ApdYPj0Kbk5S52ofE+cpk1G3slEGvdv0Az+pk9/J
         881mre3wrtzEBavU0WaGJHuE+H/KINRo/8LAe6DJF3CM+5m49NSHho27HSde4BTS/jqS
         y7mw3C1ktOp8vQ/mg92cJJxF0lCQ9pCEoP8CA/3wwdRiNRHuLOFT0VbMVyz82Gt0MvbC
         LDCJekrmj3IDxiZu4h7jJgH01bGn/OZoFLmBa6MtBwHzmwz7uAIHgwYe9t+m2McEBGXC
         OsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kxnsY7XxgR5LPkLt/HzBZqQVJx7TOeoHfiVCxdpmUW4=;
        b=CYtmnNMgyR/6J+6WpXSfkAcSpQzq0bS+ZBQg99PS7ZICAcmOwGjuEh8YX7GTUqPk43
         /NlSJH4x4gQmj7JUPxQaipeb/mmWBWgxhWzGxPdAh4MmowP/dRe3BaOGvt1hXS4xYRhF
         /6KNTRLcCr72L7CC5l4Hf5xRwS6z5rlhqtFvLo+MYf2X3InmHm9doyESEzSP8Sjm/1D/
         9T9XOnmMwF18mfvuu7C0Dz2uheOwM8NDc9BkWOuivWryrLDGSuBWvDcdaL2iow265CZ7
         lznCxRb1wz3ICNGMfSfbLWUhWDP+pj38yqFhRatumexTItGy15JCGNj89F0sZdvk5sPT
         nwPQ==
X-Gm-Message-State: AOAM533f7XeaIldUy9+WJlGFKXUAhLtM2VsR6geZj1y53UL/C/S/Cfqv
        4qdpHQXVjNci6eivys6tIuVBp7/70/0=
X-Google-Smtp-Source: ABdhPJwTZY4wiYi1atNVhq1UQzNeOhJMl2IhzE2Vy3lTRxdqed5/gFxnkT4PaHc8Ghl9srvDglgjQg==
X-Received: by 2002:a17:906:3111:: with SMTP id 17mr4626782ejx.403.1619793883210;
        Fri, 30 Apr 2021 07:44:43 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id k5sm1623710edk.46.2021.04.30.07.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:44:42 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/43] staging: rtl8723bs: remove unused RT_PRINTK macro
Date:   Fri, 30 Apr 2021 16:43:49 +0200
Message-Id: <4ff899706cdbf0fc496e06105d074a4c5cc5f220.1619793406.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused RT_PRINTK macro definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_debug.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
index 3faf4da42bd7..5c4412bf6fbd 100644
--- a/drivers/staging/rtl8723bs/hal/odm_debug.h
+++ b/drivers/staging/rtl8723bs/hal/odm_debug.h
@@ -87,8 +87,6 @@
 
 /*------------------------Export Marco Definition---------------------------*/
 	#define DbgPrint printk
-	#define RT_PRINTK(fmt, args...)\
-		DbgPrint("%s(): " fmt, __func__, ## args)
 	#define RT_DISP(dbgtype, dbgflag, printstr)
 
 void ODM_InitDebugSetting(struct dm_odm_t *pDM_Odm);
-- 
2.20.1

