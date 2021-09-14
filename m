Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B04840B79D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbhINTMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbhINTMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:12:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B892FC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:11:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 83-20020a251956000000b0059948f541cbso203300ybz.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q7aDL29AYbdCfi0R0OI5kCSu1GKWHq3p/kh3PEFNLGc=;
        b=IZtUF5oSWiLYuli9Q14pffkIBbMmHN+de1ecxKwM/ROSOtGtOdHglZr+dEEvv1K3SM
         jFh4Xm1pNmyzCqf+jQ2RZAWl71dXhX43RkfitqmXnDaL/zfl7ZUF9FiHLjcv2mEd1M5h
         aPcl6HRVQ3mxq+dHIzwVvFXkqwKsDxVLA9ibEZTz273mBQMhTnTfIEVt96x5k5eUkGW3
         q3jH9xTnCLXrjsIjHpPHb3JQnxt3bunGdlcP3oMHE3wcGwJuPmKIwlUkyK4puU11IdNq
         WLam7kSypb6y6SwHxOOYU5DTanlXbqMeMUpII3uBW4bSN+xi/dNSz+zpMdfd1FUy1DLx
         4qkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q7aDL29AYbdCfi0R0OI5kCSu1GKWHq3p/kh3PEFNLGc=;
        b=gQ8ezTaQKpdhc444YVAVCn4u2o8e9WmDVBCITlehNbYGMBYyb2jMwfp3Oy5R65zOy1
         2VHKl273fArNgTwkq2N3/h2TwJEOnMLsM0bbYG1idL/9UZrCpjAyhLkAeTMYW1RHck0m
         HbtQ+d0L/EaPFo5YQfaKdE/QaDUPsSeCJsr69l3QvkWlEqnKhcOxUKPqklt0ZI/yWeh5
         I+9uu+XRw165Z59CHRVcVUplXOxaWhwT9Tw1+Z7CD3acsN1hoS5pHIN4xZKgXiGKDeMj
         6AUzmy/N41/lSp19HKEXtmRoxkE+VMySVHVC5jnuCq7P7+RhSSDK1blX7Mfb1o/zRuBB
         vHKw==
X-Gm-Message-State: AOAM532Q1wFl1Je9mWGqHIJl05CsVKHMLg4XJzhyq55NQzZtmYgj0mE2
        /wURBsbWd4HtUiu0vjUr1+3pHoxJpeu0GrVN5CM=
X-Google-Smtp-Source: ABdhPJyu4sQFyzg8OehijmM98aIb4TIEeqsyt2h5nJcPwnrqr6TtKW2mJpuUFaE6oehYPaKehRRvWDBNthvBGsiSbPY=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:d19c:5902:49bb:c41])
 (user=samitolvanen job=sendgmr) by 2002:a25:15c7:: with SMTP id
 190mr883313ybv.185.1631646666932; Tue, 14 Sep 2021 12:11:06 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:10:37 -0700
In-Reply-To: <20210914191045.2234020-1-samitolvanen@google.com>
Message-Id: <20210914191045.2234020-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v3 08/16] lkdtm: Use an opaque type for lkdtm_rodata_do_nothing
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use an opaque type for lkdtm_rodata_do_nothing to stop the compiler
from generating a CFI jump table entry that jumps to .rodata.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 drivers/misc/lkdtm/lkdtm.h  | 2 +-
 drivers/misc/lkdtm/perms.c  | 2 +-
 drivers/misc/lkdtm/rodata.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index c212a253edde..2da74236c005 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -137,7 +137,7 @@ void lkdtm_REFCOUNT_TIMING(void);
 void lkdtm_ATOMIC_TIMING(void);
 
 /* rodata.c */
-void lkdtm_rodata_do_nothing(void);
+DECLARE_ASM_FUNC_SYMBOL(lkdtm_rodata_do_nothing);
 
 /* usercopy.c */
 void __init lkdtm_usercopy_init(void);
diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 2dede2ef658f..fa2bd90bd8ee 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -151,7 +151,7 @@ void lkdtm_EXEC_VMALLOC(void)
 
 void lkdtm_EXEC_RODATA(void)
 {
-	execute_location(lkdtm_rodata_do_nothing, CODE_AS_IS);
+	execute_location((void *)lkdtm_rodata_do_nothing, CODE_AS_IS);
 }
 
 void lkdtm_EXEC_USERSPACE(void)
diff --git a/drivers/misc/lkdtm/rodata.c b/drivers/misc/lkdtm/rodata.c
index baacb876d1d9..17ed0ad4e6ae 100644
--- a/drivers/misc/lkdtm/rodata.c
+++ b/drivers/misc/lkdtm/rodata.c
@@ -3,7 +3,7 @@
  * This includes functions that are meant to live entirely in .rodata
  * (via objcopy tricks), to validate the non-executability of .rodata.
  */
-#include "lkdtm.h"
+void lkdtm_rodata_do_nothing(void);
 
 void noinstr lkdtm_rodata_do_nothing(void)
 {
-- 
2.33.0.309.g3052b89438-goog

