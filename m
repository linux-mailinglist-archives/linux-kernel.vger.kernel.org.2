Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDD4362975
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 22:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343816AbhDPUjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 16:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343711AbhDPUjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 16:39:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A09C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:38:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p75so7516148ybc.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pmn8+hgLRHNyGuEUjdW5q+p1kqYnyhA2JKs6WoTHh2Y=;
        b=uRFE7haSCOtcrAbD8X0LpMW7fs7JNAgip1q3xFA8l8rTOMzSEBsEL8HK1CJowtI+EU
         o1XeFdireWjSJ0YCcYdlkgW0NEI2st5c+Fl5gozJg68z1Z2GIjjCNm6sJkKxHhG4iSEL
         7/cKRcV2HfukH9YsK6fdiOH0tNLpdbsxIDD80IM9Z2RWVdz1XD3VN1mpmEy3Vqcb/Kzx
         TsposH+2Q8tWGv66bUOPScT94QitM5//0wAJygdH0c+6CUi9sGb2tsf2CJrTwDAIg5jG
         GmyfTRwxEY865LUMzXu24t/yCk4IKKtE5hmCJkM6QIeyed+u7KYY3Ih1Iih66/mkdVug
         +vkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pmn8+hgLRHNyGuEUjdW5q+p1kqYnyhA2JKs6WoTHh2Y=;
        b=NKWNuucI4WL75fGPaAHjLaNFtZ9yVbvXFJL7Cg/zVv3JUf26H5N4KYM8WLv1T8ZNII
         vO6r9pI+fb2uTgw1oJ+Jli8Gip0Y5pG6gePPhKPDXMeQqDmgBCvEhzDlO4mTwm+isVsw
         mOsKqPVaoB0SC94HjQ/C2jI+knsvZeHGYuXtweKmL5GUCbq/5WZWcir3oFeLilDffZdn
         dOhuVLXq0LJfINKlpCSdEnSQwJbk4GPiPVNoUJunyWQDfC8LvW4u16+hmF98YD9rNQVt
         Ss8f3FbvffwBXW/rdS2yGxwUZlUAcOu6Cj+tZIGjEoc0DUx6qbUh4q//c27Pdi63sTpv
         uONg==
X-Gm-Message-State: AOAM532N2qkq/O4Kqx16rng/3tCBh02KzQEXK7FrpVoK+Wnfkvuu7LGP
        whEzSwp3CTjcZ6yNMScBgilsn1W/l6wpHpP2Wn0=
X-Google-Smtp-Source: ABdhPJzAoCWzAKTWZwYMUD8MhbdEgBqnpfkFsdVC5AUG01f74KhJvNXz7U9gQyUOoZ8GTKFvYGEVqUAlb8FQJo24O6E=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e262:3d8e:cbf:6164])
 (user=samitolvanen job=sendgmr) by 2002:a25:b983:: with SMTP id
 r3mr1409748ybg.238.1618605534346; Fri, 16 Apr 2021 13:38:54 -0700 (PDT)
Date:   Fri, 16 Apr 2021 13:38:33 -0700
In-Reply-To: <20210416203844.3803177-1-samitolvanen@google.com>
Message-Id: <20210416203844.3803177-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 04/15] static_call: Use global functions for the self-test
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

With CONFIG_CFI_CLANG, the compiler renames static functions. This
breaks static_call users using static functions, because the current
implementation assumes functions have stable names by hardcoding them
in inline assembly. Make the self-test functions global to prevent the
compiler from renaming them.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 kernel/static_call.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/static_call.c b/kernel/static_call.c
index 723fcc9d20db..d09f500c2d2a 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -503,12 +503,12 @@ long __static_call_return0(void)
 
 #ifdef CONFIG_STATIC_CALL_SELFTEST
 
-static int func_a(int x)
+int func_a(int x)
 {
 	return x+1;
 }
 
-static int func_b(int x)
+int func_b(int x)
 {
 	return x+2;
 }
-- 
2.31.1.368.gbe11c130af-goog

