Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E293DADEF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 22:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbhG2Uy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 16:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhG2UyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 16:54:25 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60A1C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 13:54:21 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h8so9978049ede.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 13:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=usBsehgRLO8yBDJdVm0jGsDqhFCcetjnZvT1SyvVNfs=;
        b=Gh0TbzRaoBeJs9ialmAwceZRjyffE2dVJy8s9rQSmMN40X/r1/KR2oTIZ9MfXYwJ7T
         MpTYGfqj+0M/9T1lzVxW4l2LeNuY9HUr/PTt5WzkT283FRGVhbuUX35S5ZOeinJM7Gvg
         juTcXgBrG0QXHOwuhh1pji9P8lze6PPZDDwi/18RWfQIOmYw3a8XzyV2RqIMbWJXpMCV
         HawSskzdX0OG5Kyjfmy1ruwWq3K9T8ZEnjYNtyDe14jwqNro9CPrPHm5E+UTHVam4CXp
         nZQSlZ5Pn0b9NerlvVAzd1NvBjQchg9GB+ZeMqkqiNOqezr13jKi/llk/2toT6AABeuG
         eD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=usBsehgRLO8yBDJdVm0jGsDqhFCcetjnZvT1SyvVNfs=;
        b=l1/TXh21IQNoVgISFy75IldPxychA+T8ZK7SpE+F9Vnx3Z01SsQ6mNicaEMmf2eNNs
         VScWUg/szYaXjze7MtkL/7b5fuJaIZCJ70vukFoMoMTUWcA1GhGhM+A3WAJVXrL6ArlT
         JWkClZteSyaAWtcV4a7bR9v164skegW7q3ekJRwdEgTL6kFwDSUPb88uAsvcSUbpZqtW
         SOM2KNxFOemKWvyON+bwUcCgZY9UvdSltVi+h1a8gSfwyC3k0i6RsCykzR6+/SJOcGBg
         O3Tsgl6ZQpCHQ9aUAW2BnLEjuPm244X/8ZUt/56X/QWpmhR8f079K5QYIiL1I6bAG/OW
         O7fQ==
X-Gm-Message-State: AOAM531kl/DwcWqBHuiawVahGd9sVKIq/qaqxGYz0XmROqBAmRMtA+tG
        1x1UbXGvk2Q1lEW7NifSKcA=
X-Google-Smtp-Source: ABdhPJwM+7nJUOTtuEbOTqF070FuYekctKfXehp18mhoRc5l0D4NXnz42aZAWOtK3wPb/R1X9q2/Lg==
X-Received: by 2002:a05:6402:2919:: with SMTP id ee25mr8299804edb.222.1627592060156;
        Thu, 29 Jul 2021 13:54:20 -0700 (PDT)
Received: from localhost.localdomain (i59F726E2.versanet.de. [89.247.38.226])
        by smtp.gmail.com with ESMTPSA id u2sm1625307edd.82.2021.07.29.13.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 13:54:19 -0700 (PDT)
From:   Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
To:     jeyu@kernel.org, keescook@chromium.org, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     samitolvanen@google.com, treasure4paddy@gmail.com,
        Miroslav Benes <mbenes@suse.cz>,
        Stephen Boyd <swboyd@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH v3] kallsyms: strip CLANG CFI postfix ".cfi_jt"
Date:   Thu, 29 Jul 2021 22:53:12 +0200
Message-Id: <20210729205317.25685-1-treasure4paddy@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CABCJKudYRiK0KcMHGHeBFcr+Smwa9EM+NFeBpMo_ePqK+zHz0w@mail.gmail.com>
References: <CABCJKudYRiK0KcMHGHeBFcr+Smwa9EM+NFeBpMo_ePqK+zHz0w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang CFI adds a postfix ".cfi_jt" to a symbols of extern functions.
For example this breaks syscall tracer that doesn't expect such postfix,
so strip out the postfix from the expanded symbol.

Signed-off-by: Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
---

Change in v3:
  - Modified commit message to indicate fix is for Clang CFI postfix
  - Rebased on recent patch from ndesaulniers@google.com.
  - Fix is enabled even for CONFIG_LTO_CLANG

Change in v2:
  - Use existing routine in kallsyms to strip postfix ".cfi_jt" from
    extern function name.
  - Modified the commit message accordingly

 kernel/kallsyms.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 5cabe4dd3ff4..67d015854cbd 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -174,7 +174,8 @@ static bool cleanup_symbol_name(char *s)
 	 * foo.llvm.974640843467629774. This can break hooking of static
 	 * functions with kprobes.
 	 */
-	if (!IS_ENABLED(CONFIG_LTO_CLANG_THIN))
+	if (!(IS_ENABLED(CONFIG_LTO_CLANG) ||
+	      IS_ENABLED(CONFIG_LTO_CLANG_THIN)))
 		return false;
 
 	res = strstr(s, ".llvm.");
@@ -184,16 +185,24 @@ static bool cleanup_symbol_name(char *s)
 	}
 
 	/*
-	 * LLVM appends a hash to static function names when ThinLTO and CFI
-	 * are both enabled, i.e. foo() becomes
-	 * foo$707af9a22804d33c81801f27dcfe489b. This causes confusion and
-	 * potentially breaks user space tools, so we strip the suffix from
-	 * expanded symbol names.
+	 * LLVM appends a hash to static function names when both
+	 * (Thin/FULL) LTO and CFI are enabled, i.e. foo() becomes
+	 * foo$707af9a22804d33c81801f27dcfe489b.
+	 *
+	 * In case of non static function symbol <funcsym>,
+	 * the local jump table will have entry as <funcsym>.cfi_jt.
+	 *
+	 * This causes confusion and potentially breaks
+	 * user space tools and some built-in components.
+	 * So we strip the suffix from expanded symbol names.
 	 */
 	if (!IS_ENABLED(CONFIG_CFI_CLANG))
 		return false;
 
 	res = strrchr(s, '$');
+	if (!res)
+		res = strstr(s, ".cfi_jt");
+
 	if (res) {
 		*res = '\0';
 		return true;
-- 
2.17.1

