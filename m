Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BA63F4F1B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhHWRO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbhHWROU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:14:20 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157EAC0617AE
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:13:36 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id j23-20020ac86657000000b0029cb70967ebso3571456qtp.14
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OjHgDJUvJmMOnMd0mi83Z9bddC5eVI/HUOS0aA/fCjo=;
        b=Dna0EQXkdpMIYwRPENTuTtD45Xxz00+bPzyOn6DWxIcwL0q6aW6lkwtVlDnuMZuAEA
         8sIkWePDkiji5yZon0dVb8HXmOr7mEzoHZ5lQQHdTzgZHGUhTEo6QEZ5jHCtKwjZa60J
         uNEz1aSczSOjajbuJjU/0lZ4076zCEjFHCzb/GzyleOAAJDdTiLueqUl6x5XGftohdwu
         U+8rspiV1W6jiMa8ujDzD710tDfqTvVPsz9/JR2Koyb14Kfwnn4SUA3EIPZ4b92ksJBL
         iYBJb7esO6wqajz4QMQjRtUQg/vPUrnXPvvvgrq2KcZy+42G0jJwrxzNFIPxfUOLIkFT
         QDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OjHgDJUvJmMOnMd0mi83Z9bddC5eVI/HUOS0aA/fCjo=;
        b=Ms7xYEOr1tUAh82HYrwrbvS/p/OsatPlmvOJwrffAcsTMtvKzdodXYo1gb8/GZuH3j
         RTsc9wW0ooC+j1cV//I1L7foDYLPvT1vgxtbKQ4l4Gup4dLQifgRFl4BlSbPgwfJA2Ny
         nCtjIgpmTKlEQB2JKmRvpWjFsGwVbNJCSCUq5MZedJ+Lq8OXzkf16053coP4EF61kwyM
         U8g8XmLPVE3dyNoLtMM41IypouNJ6iwh2nErraQ+Y4pzDJpRmQ5c72xRz1r4Oy9uGCbq
         ygIM+CKUBAD25XuIbFOhJ3vA1skN+mgmo4OVASWkOkXgRl1hG5leFVr2lvzOA1a43Mzm
         S9Cg==
X-Gm-Message-State: AOAM533JaUfAqNjwBd0lPlZyNkPypuubcSAGpcSmK8GbGIK7awqj/rMF
        GclO1+GTMRdmefElQS/f9FPbD8a+8uBxgh36M8M=
X-Google-Smtp-Source: ABdhPJzi9cvrwOFBpM3xgvXo+JzAAlmiz1LkJnW74n84Ibws5mGYLA0Os3m+2on4AveQflOlFROtCJbTM/5knrZQjsg=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:cc48:aa6a:f4ec:7d19])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:1142:: with SMTP id
 b2mr34567008qvt.0.1629738815199; Mon, 23 Aug 2021 10:13:35 -0700 (PDT)
Date:   Mon, 23 Aug 2021 10:13:10 -0700
In-Reply-To: <20210823171318.2801096-1-samitolvanen@google.com>
Message-Id: <20210823171318.2801096-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v2 06/14] lkdtm: Use an opaque type for lkdtm_rodata_do_nothing
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
index 6a30b60519f3..90d92eb92c16 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -129,7 +129,7 @@ void lkdtm_REFCOUNT_TIMING(void);
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
2.33.0.rc2.250.ged5fa647cd-goog

