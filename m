Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297533F4F1F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbhHWROf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbhHWRO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:14:26 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9E5C06179A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:13:43 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id u8-20020a0cee88000000b00363b89e1c50so9507562qvr.16
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mey0v7exe5c+yBAN3SU9wb93KZCOv1Lxd2KHYNUz0Mk=;
        b=pRDBRM0ZDSPHtwYk6vo2nEL4sl7uSQgEKF6lqCG9PRSUXW0+hY09NZKkepss+zOhJB
         RZJ4OhpnIQe5VsAhZobgjkF8NjkXH/ic6yTt8/iS4ehrVTNLNP7dY0hxecAiBQKFHA56
         bnHbtB8ONjGJv6HhgbciR0XXNOh6bBf0QPK9uszzpKLRjZlrmvIZMbpmmKtbZslPQBBN
         FyjTNlMOMiSJZ8qLdOpjKIjsP7KRGEjKiLWJB59jeDiJtzwRiyA5FD9MKm73hAvItrif
         tEBz/IgNIv9FMsrMbd7lmEwkbTBlOAnwi0bERDIorGb82NlUHbWpaVvH/5cTjjtwHvhi
         ai6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mey0v7exe5c+yBAN3SU9wb93KZCOv1Lxd2KHYNUz0Mk=;
        b=aL0x9RWE1gJUNlTeKYEqYYmQlKJgoVAoi+QUAh0FhNHBPzjiZEDfyiOcnqghJ3JaXV
         OSkf9CDmlYqDw06NkiCzPQ38PxOjx6NIzNh+eJSAnz7vB8x2WUiAXBuiox+jYVzVBk5t
         fJWMfbJ1l/kKcVXzgpavrs1lxqndYqhWHp2C6tal4rZF/nXaMud6V6wIZL2eKLu2l9Tl
         PEjSkKx46+tn8VGwXsd3MFLOky5zqU9ckIVfIClI63GaoLdzKlY6f6ESa1VqNsnik0iV
         p//UgrIecxpn7gjzL3OaYwtWthW6LEYiP7lhn5/ufNZmPxpNEqOsV/lmU1VcZM/qHsnG
         SZXA==
X-Gm-Message-State: AOAM533sy5Jcew0xfLuN5DW5BtyszYPodJY6DVCCDV7XSRW/POlV/Lgq
        nXTwZ1qYfc24v8pskSe7PXxN8maSWDNPIhWHdPQ=
X-Google-Smtp-Source: ABdhPJx7GCdUxAsclqml/3nj1pOEX1o+zNUpaZiH2IQlvhX2sRoNhrD4ck7AleYysi5ixwnD13R/KRhwqUQ/nL0Kk3M=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:cc48:aa6a:f4ec:7d19])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:e4e:: with SMTP id
 o14mr33977238qvc.46.1629738822531; Mon, 23 Aug 2021 10:13:42 -0700 (PDT)
Date:   Mon, 23 Aug 2021 10:13:13 -0700
In-Reply-To: <20210823171318.2801096-1-samitolvanen@google.com>
Message-Id: <20210823171318.2801096-10-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v2 09/14] x86/purgatory: Disable CFI
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

Disable CONFIG_CFI_CLANG for the stand-alone purgatory.ro.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/purgatory/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 95ea17a9d20c..ed46ad780130 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -31,7 +31,7 @@ KCOV_INSTRUMENT := n
 # These are adjustments to the compiler flags used for objects that
 # make up the standalone purgatory.ro
 
-PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
+PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel $(CC_FLAGS_CFI)
 PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss -g0
 PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
 PURGATORY_CFLAGS += -fno-stack-protector
-- 
2.33.0.rc2.250.ged5fa647cd-goog

