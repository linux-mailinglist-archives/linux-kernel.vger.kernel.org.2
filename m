Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79D336FCD0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbhD3OrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbhD3OqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:46:09 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89A0C06134F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:45:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u17so105748327ejk.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wlFfMaqoDNDPkcgOlBfijVc+2KkNjpgO1LG6F4L15Ok=;
        b=VUypWzGXPIeKIyeZvU051xpAGSH9BIZsa6WvbHugTaibnlCGfE/EYtXqtM0JtfkE2x
         u1e2v0m7dG/MF3KkX6GeHxV2xDMvMYrkZYyyhXPZ7wuxgNUNkCyCStVMRCA2Jdjk5neA
         40/zoXWx7DGBUpFSXj5przMt/pxKwSTur5oYuzWUFv3/wzRtMrs7+jRbp3IX7SSlPLRm
         iSJZiI41mGfV+a3IhLPwNQ5ecgUSqUrUTpkO2Xu6nYSv0Lbo61EYy4OG5yXJAwap6anL
         v6jehFXkDmfQbYqJo7H61JLGj7FvBu1Ezbesqk03mxY4jICg+IWtSDAQ7rEBVXfxyO27
         hCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wlFfMaqoDNDPkcgOlBfijVc+2KkNjpgO1LG6F4L15Ok=;
        b=eC11FkWcmZA//LO83nnlEjdR5gpv+MMNYAWjKdWpNiwgK35iDZXJ2GfsGeToP4drXd
         Tb93LytSSef0byDZaQ9BPiodCIcAfuw91pIeVwaEoGjiHo8n/MQ11MRMMRKcEKwm4Wgp
         NoZ+sfcs42DwwuR7XWogx2yO8EGTbyNRs6kC/JWQZS4hoc065ok+ShcBAroFflZnjy3F
         aJhe18WJEiq9vHGrQLTBM5MM29FrHyX63w9iw2905l7KOeRMwdkymbXOxtTyCytavWjl
         NK7YEoC9Rq2SdY+gOHTVUz+I7iG1AiCnVTm9JggUv8QHh7rY/tfmBYbycAxhyrifkYFF
         0R8A==
X-Gm-Message-State: AOAM532fX/RRRcDm+T25I9kpJvTd8tpgGb4ZVBVCjPvbLXzcmwDM7mKU
        +mLptEDGsvwmfER5toulMaVIG8FVWSc=
X-Google-Smtp-Source: ABdhPJwvP8L/9lDGBkJf6l0/31HTCLHA4VsHgkDwq8lC1Jziq0FpJCNUzYcj6KFz0SeyyvapoBFI2w==
X-Received: by 2002:a17:906:ecf4:: with SMTP id qt20mr4792889ejb.59.1619793908352;
        Fri, 30 Apr 2021 07:45:08 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id nd36sm1987686ejc.21.2021.04.30.07.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:45:08 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 36/43] staging: rtl8723bs: remove unused DbgPrint macro
Date:   Fri, 30 Apr 2021 16:44:06 +0200
Message-Id: <0b1c2cb7087dc4d92a9fc86dd2739e1bad2522fa.1619793406.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused DbgPrint macro definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_debug.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
index 5c4412bf6fbd..c6c62bed5f3c 100644
--- a/drivers/staging/rtl8723bs/hal/odm_debug.h
+++ b/drivers/staging/rtl8723bs/hal/odm_debug.h
@@ -86,7 +86,6 @@
 #define ODM_COMP_INIT				BIT31
 
 /*------------------------Export Marco Definition---------------------------*/
-	#define DbgPrint printk
 	#define RT_DISP(dbgtype, dbgflag, printstr)
 
 void ODM_InitDebugSetting(struct dm_odm_t *pDM_Odm);
-- 
2.20.1

