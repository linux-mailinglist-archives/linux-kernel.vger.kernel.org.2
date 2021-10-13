Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8356542C882
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 20:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238973AbhJMSTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 14:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238761AbhJMSTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 14:19:36 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F233DC061753
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:17:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h185-20020a256cc2000000b005bdce4db0easo4052525ybc.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NLRoIZHIP07xVaQxZ/Th6ra9+3RRZlDKsNZoVY8HRkw=;
        b=sQ9nG9JWWa9Mn97zg9W9ZToGFaIJ+2096eP72oFROHBdWmdU++QLmNkakZgzAhGzJI
         l6VU4DnehIZi61j+bqVrQp6NIU4IOVz+4lFXgddoeQjjJSQZaY4Edt+/4VnpBIfo5p2z
         ij1YdPs5vzTPQbblRpk/dLZ3/7es3995ybY4KCiZyqsh1kcsvvqK9dJudhqjOG/NESe0
         AkhoTR8IwyxPR3LhIcRE1AfA4c0IjmquY9kD0B25IuAhnttXbEHgTDC5vlogLV0M93AM
         4xOJeVFJN8JWaglbFKxv5w7Ttx8GMWD/b9W/6V14TuRAWP7OiNnlijLg0oXPHz3Tpnsi
         Wu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NLRoIZHIP07xVaQxZ/Th6ra9+3RRZlDKsNZoVY8HRkw=;
        b=W3zqOu9iSZEfDst6mMtGxonGxFBNH7M0Z6imIKgIwt8GGNxp2tF30/egtpfSA5u5I6
         w2yVrMptlh80jQRTfSFv0+Jav3EEiUomovK0jig9xfqu7EGx2cokPGK9XgxshDK9OEbx
         TV0FRk++4r7dZNTkezHFOaAO99n1niadmW48GmcPPq57vOYwuYg6hdaSqlDakxYysH1i
         kyFZgSZJ372+96b8R0J5Yh7vdJT6Xxcb6ah0ERhpO8emSTy4F113T+9vKN66DKS5PCEE
         cE4rcdfItgLsMFj2U8/OIQ+FntNlCtVmLHYbI89SlQSw98LyhzTQpRqRj6dATLRqGVHj
         LU2Q==
X-Gm-Message-State: AOAM530VsQ8pBs9lvtrr5p2s8fkPerJZ6zoWKSk4udTwgjUnBCl500eu
        Y3xQwpWjXnuR5lpiortxxZZQ65pcfM1YyvnFT0E=
X-Google-Smtp-Source: ABdhPJxxwA0QAFoSJFmxMJVo9O5lXkV6PkXGEUhUNY0e3KZZDPZAgK5Eup8ThmkRmda4JlzpF43HiVY2FVug05najQ8=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:9ea6:6c27:1876:926c])
 (user=samitolvanen job=sendgmr) by 2002:a25:b790:: with SMTP id
 n16mr917302ybh.395.1634149052151; Wed, 13 Oct 2021 11:17:32 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:16:56 -0700
In-Reply-To: <20211013181658.1020262-1-samitolvanen@google.com>
Message-Id: <20211013181658.1020262-14-samitolvanen@google.com>
Mime-Version: 1.0
References: <20211013181658.1020262-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165; h=from:subject;
 bh=cWgW7c++4rTsWL5fNfmGI8mvplNIrZThQL76GT9fg04=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBhZyKaCYCUH7T+fWoNdx2QCDRdr+KfWhTjVE/9EB9M
 oD6hwNCJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYWcimgAKCRBMtfaEi7xW7qhXDA
 Cc8MvkJ9dETn63gZb8T2sHkjmWGrk7/WGznHUsqwmQG+VZA5JcCeAh9+c5wesuJXP9BqacwjdRKKSj
 56XBWu4BovM5i7dniaLFJq179rRY9/YlknjUBgAR1sMDvpHbQM0wYBlTSTsSwqXgM2rUulhLu2H9+c
 TbjBHDXtalxCYUpP/wQgDOFX7J0PwRpHUb4hGKfFuf51FaLAOQzNscIT0JPD9DZ8KMS4tVwR1Ulziv
 xPJQ1REeLX96kOtZq5doOqPR6h6EWpCs2SnCiTdFCuFNnfwxJoLpFZlL3JGQTDhy8SlIZygC/SN5rD
 6FASRz6UJdPQ21fZNHoRizyKcPIE0Iec9NimvjSTAkOv6N/h/+WUTc5Bcgr/hM/8uJzEuIuf0iCGUO
 5PVAb8WHGpPCH/GhTfKy9a1qeufVESBFH+hf3G3l4PqhLaM0H6ee1eXG92/lQ8gmBuDVYuqmenjL+R
 UNmMhCzNAsGzLX49wnTGk7jqkHv93ooYfVDgfgySqKF5A=
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v5 13/15] x86, cpu: Use LTO for cpu.c with CFI
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow LTO to be used for cpu.c when CONFIG_CFI_CLANG is enabled to avoid
indirect call failures. CFI requires Clang >= 13, which doesn't have the
stack protector inlining bug.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 arch/x86/power/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/power/Makefile b/arch/x86/power/Makefile
index 379777572bc9..a0532851fed7 100644
--- a/arch/x86/power/Makefile
+++ b/arch/x86/power/Makefile
@@ -4,9 +4,11 @@
 # itself be stack-protected
 CFLAGS_cpu.o	:= -fno-stack-protector
 
+ifndef CONFIG_CFI_CLANG
 # Clang may incorrectly inline functions with stack protector enabled into
 # __restore_processor_state(): https://bugs.llvm.org/show_bug.cgi?id=47479
 CFLAGS_REMOVE_cpu.o := $(CC_FLAGS_LTO)
+endif
 
 obj-$(CONFIG_PM_SLEEP)		+= cpu.o
 obj-$(CONFIG_HIBERNATION)	+= hibernate_$(BITS).o hibernate_asm_$(BITS).o hibernate.o
-- 
2.33.0.1079.g6e70778dc9-goog

