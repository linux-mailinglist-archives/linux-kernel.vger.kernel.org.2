Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39F736FCB0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbhD3OpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbhD3OpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:45:14 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC68C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:25 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id q6so23657777edr.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FleOPJ3gtiTATKAeonx+PuxFi1VSxS1weEi5bkXodsY=;
        b=DPlODUjjtpLUnCmPwOACFt5+vdFxr+MjMFSBntVB8Uq+OebUxKUcYMbymK9Wi43/qe
         89fzhPCfc5M+yxQ4UOwMxWkoH1O9naypx13Y1nlBE45Hlxhn2ec48Ns2b4kU3D6k1pJi
         JpcWVzuEkakShuKoNbi7aOiTJzLodcQ2XgdMgrlOMCpmKKUCX5mQAQ684vKhItqrCLF3
         YY3CpaEa+WcF5iRVSPactPdSRIvf/Pja9qAyI61aXCruu2eLuuMxdPmn/txMQfjjSbph
         2QdqA5aQb5T4hudB3qfxKtUYm34K9V8rkIfsFBik7gAbYE1ozLBWZxdh6FiuLqh3PWBw
         Kwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FleOPJ3gtiTATKAeonx+PuxFi1VSxS1weEi5bkXodsY=;
        b=jExZ/kb3mM26tw2gGlY6Jxp85aYET5cDz9CEbXXd2yd8vv3AjC4mBzPg8S1GHcNg4R
         vCjOl7AJ2EOMPAE/UqyG8XaaTd7tpdPmoBbIHOZq7eCN9hOnH5szIxkuCPnFhgYj/ewY
         N0TdtqjY/yGcGqs5ONnxhKKAuYCQRUUCjJciC4aVgkz3XQXiuObgLxvM/KTV8+SyyKog
         pJ5d6mEMbcBICIQSLlvUamAOTjAzjzW7NayLTqZBA/5n/YIqCAvBfT6BiJfA6cJf4mYY
         G3ZNq0UQAxCbb3339AOULtnCGHqIG89jaRetgr6lmByS49K3rXGPJbjnwL5OWOXzpAmj
         s7FA==
X-Gm-Message-State: AOAM530Z9zIJKso9oPeoQnIM/tNWM23i0svNqnEdWHGxMsKLL089K4sf
        ulliquq4k+6aWpmFmxeJsNyqRhmHHjk=
X-Google-Smtp-Source: ABdhPJwq28x2qhU1owqNQnD2/fYSDQYLpre+fiAl9n/o7jTDFrFn7lZmnOmF7p4lDE0WNa/huiBvlQ==
X-Received: by 2002:aa7:d0c9:: with SMTP id u9mr6387737edo.43.1619793864006;
        Fri, 30 Apr 2021 07:44:24 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id i8sm1458860edu.64.2021.04.30.07.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:44:23 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/43] staging: rtl8723bs: remove empty header file
Date:   Fri, 30 Apr 2021 16:43:36 +0200
Message-Id: <be22d880ed628ffba261db08845e5efb5df854ab.1619793405.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove empty header file.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm.h         |  1 -
 drivers/staging/rtl8723bs/hal/odm_PathDiv.h | 11 -----------
 drivers/staging/rtl8723bs/hal/odm_precomp.h |  1 -
 3 files changed, 13 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_PathDiv.h

diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index ff21343fbe0b..ba723ed7aa96 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -11,7 +11,6 @@
 
 #include "odm_EdcaTurboCheck.h"
 #include "odm_DIG.h"
-#include "odm_PathDiv.h"
 #include "odm_DynamicBBPowerSaving.h"
 #include "odm_DynamicTxPower.h"
 #include "odm_CfoTracking.h"
diff --git a/drivers/staging/rtl8723bs/hal/odm_PathDiv.h b/drivers/staging/rtl8723bs/hal/odm_PathDiv.h
deleted file mode 100644
index de69d5ea6ffd..000000000000
--- a/drivers/staging/rtl8723bs/hal/odm_PathDiv.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-
-#ifndef	__ODMPATHDIV_H__
-#define    __ODMPATHDIV_H__
-
- #endif		 /* ifndef  __ODMPATHDIV_H__ */
diff --git a/drivers/staging/rtl8723bs/hal/odm_precomp.h b/drivers/staging/rtl8723bs/hal/odm_precomp.h
index d48d681472d5..440a549bffc7 100644
--- a/drivers/staging/rtl8723bs/hal/odm_precomp.h
+++ b/drivers/staging/rtl8723bs/hal/odm_precomp.h
@@ -31,7 +31,6 @@
 #include "odm_RegDefine11N.h"
 #include "odm_EdcaTurboCheck.h"
 #include "odm_DIG.h"
-#include "odm_PathDiv.h"
 #include "odm_DynamicBBPowerSaving.h"
 #include "odm_DynamicTxPower.h"
 #include "odm_CfoTracking.h"
-- 
2.20.1

