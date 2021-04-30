Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EBD36FD05
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhD3O6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhD3O6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:16 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDF9C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:27 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id i24so23399711edy.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CBMRL9okd6exFYzTetsEZ3MsVPUnPB4cIvHOO2Zf8iE=;
        b=Zc1+7wI7aOqq0hjmpYddIAn+mNWVhOqeqWoCw/2snDV2/idwSdyvmOjLKucNWv1xfk
         KjMpKAL/iyP0apb+UZ7Z+dwlU00qP1RW1gyQZf2qonhl6AMofR8e+sCfLOBiYYm0PPuz
         Qb6iZHteza7NVY3rYQaqm6ZyyIkxUttWdfnO75KXTGs9hVaU3kn8pOF3fzrsSoedwDGP
         MRKO7qguxTdTAxkWwZjpO4v5gcAqdYN9YE5dyZHfSnMtj2DnSmW/Nqh9b78X0HTOjgFe
         c19ZPXjrDt83PIBolsM+vRUufc7iKDVgVQg/TQLLpdxFtdTkovpntPYiizeY6LzMkBFk
         mg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CBMRL9okd6exFYzTetsEZ3MsVPUnPB4cIvHOO2Zf8iE=;
        b=kX1jCJLkj4Za/+Cs3+OhIDpYM06R901yNuma+Q5E/V8fZqt/bVJDF4clEb7kLFXiDo
         RCFu3r7nG166/Fr+xgUcPs9SwN09BuXwik3XZoYWq2t4Wq/qrIDZdVmdhQ44Qy41WYS9
         Fpvkn79KTpJsYRiqCDcmS92pglobEhQ/HiNolES+uVIeRtTXS7+DqtNwLdp6bs4tbLL8
         9mNP7rGfZdhSknLf1p1QHiVpm7ICsq2PX98ePIAIlZGfhkqfOQQ0R846jwxbCa39n5UJ
         YeoMDGOBiQCJBbUVWQRxjyEoSYNvnQy5UaM8NshKdHiCstHSbcxRjx27UDdVSE8rNhKS
         9XHA==
X-Gm-Message-State: AOAM533Q0PWv9ejHV1RWvFQxIs8jKzYUHvbGO4JPLdPSUDdKUtN0czmV
        /oxLLB+EVgPkvyA/ATleyUPeFblVyIA=
X-Google-Smtp-Source: ABdhPJyP3OFwXt70owCY3qp4LX+a64ZzGOx7cWB9tbKqhpEM2j3G5TXpX87oR8/VHnFMUVW2SYYr2Q==
X-Received: by 2002:a05:6402:441:: with SMTP id p1mr6496473edw.298.1619794646450;
        Fri, 30 Apr 2021 07:57:26 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id lx20sm2122035ejb.31.2021.04.30.07.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:57:26 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/43] staging: rtl8723bs: remove unused ODM_dbg_trace macro
Date:   Fri, 30 Apr 2021 16:56:34 +0200
Message-Id: <ed3cc3b2c0df4f3c3f691b353f181f7c22309dbd.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused ODM_dbg_trace macro definitions.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_debug.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
index 58de4d16335e..cd68c583699a 100644
--- a/drivers/staging/rtl8723bs/hal/odm_debug.h
+++ b/drivers/staging/rtl8723bs/hal/odm_debug.h
@@ -96,11 +96,9 @@
 #endif
 
 #if DBG
-#define ODM_dbg_trace(str) { DbgPrint("%s:%s\n", __func__, str); }
 #else
 #define ODM_dbg_enter()					do {} while (0)
 #define ODM_dbg_exit()					do {} while (0)
-#define ODM_dbg_trace(str)				no_printk("%s", str)
 #endif
 
 void ODM_InitDebugSetting(struct dm_odm_t *pDM_Odm);
-- 
2.20.1

