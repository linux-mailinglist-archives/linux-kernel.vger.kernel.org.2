Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290CB41E098
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 20:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353081AbhI3SHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 14:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353039AbhI3SHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 14:07:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE00C061772
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:05:47 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d81-20020a251d54000000b005b55772ca97so9479631ybd.19
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+kIR6qTjG/q5eMITJU4my49cgyuaT1AvUzOJ+gtDnlg=;
        b=gkCn4CDHLNSjsTR7OqrAxG6q83amYoBjzRr52f4LFVrdFSlQ8WBZn3Kp+3hZbL0upx
         4QgBEhfGWRMKKAB/Rg5nkWRPHjKEkG/A1Q1qhUvrWVXvLGMuMuBA65OpsS/tfbRK1pcp
         eZTHr+xF/PKqk0va5Z1T6QCYSxxDDVLojGTe6x4KArjInUM6eej4hO0563SYOBLYvQxu
         yxWiLR/GGIF9MjLLQ4I9iznSEWKsa3Wm0AcgJ7EcWRtashf7JTUQz/Fz45R7wS4Xruin
         N84Os+Y9Bz4ZPFcIAj4+J/A0L0R7xfD7qZl7197i2pE3AEJLLWz5uVkY+0dbWWm5rWpY
         CXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+kIR6qTjG/q5eMITJU4my49cgyuaT1AvUzOJ+gtDnlg=;
        b=sweQ7Fo52W7GzYO8Q635vaRjjcnXx3ShFyp+t2Y7SAz5+pBdJEiBxAMNIfg5Yg4yfD
         QlH1fHCEgahJOzPXL4+wl8xHDmB8N2rU01MHpINNUbgCu8abCeGy51gmf2FB9znwgxuQ
         Ik5mbHkQo8wEjPvsENnnC5i76aYR6bANCpEAtWHBmb639m1iJ63xavk2FLajXVHVjx4n
         IsKgQGDFLKiQ5fgDX+H6UB1HIbbE0phU21RdwymTdz390d1t2ZEvyN4Yhya+HMbXjGUk
         4bskcGX+CVPab0h44Hua879CL5aDd9RwJLDTjV80ISzzRLBMnaigSyC4wDKlExd5q9+V
         dKaw==
X-Gm-Message-State: AOAM532YiLxg7GhuirPyyb4UJv8qnRGhWAw9lRGRMnIT9PPsaQ+q12rA
        JHtheQAwddLUXD6F05Rf6q8SlAwPxb65FlWY3JM=
X-Google-Smtp-Source: ABdhPJzeouRFzQrqqzPBJAENZtj4Ib+N4rD5s05tDGC56V66KMQtSgvl9JGoFrlez4rsmfK0wargeV1Nvuyh26mOOio=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:ce43:4366:95ca:d6e9])
 (user=samitolvanen job=sendgmr) by 2002:a25:45c6:: with SMTP id
 s189mr689329yba.290.1633025146834; Thu, 30 Sep 2021 11:05:46 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:05:21 -0700
In-Reply-To: <20210930180531.1190642-1-samitolvanen@google.com>
Message-Id: <20210930180531.1190642-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4 05/15] tracepoint: Exclude tp_stub_func from CFI checking
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If allocate_probes fails, func_remove replaces the old function
with a pointer to tp_stub_func, which is called using a mismatching
function pointer that will always trip indirect call checks with
CONFIG_CFI_CLANG. Use DEFINE_CFI_IMMEDATE_RETURN_STUB to define
tp_stub_func to allow it to pass CFI checking.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---
 kernel/tracepoint.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 64ea283f2f86..58acc7d86c3f 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -99,10 +99,7 @@ struct tp_probes {
 };
 
 /* Called in removal of a func but failed to allocate a new tp_funcs */
-static void tp_stub_func(void)
-{
-	return;
-}
+static DEFINE_CFI_IMMEDIATE_RETURN_STUB(tp_stub_func);
 
 static inline void *allocate_probes(int count)
 {
-- 
2.33.0.800.g4c38ced690-goog

