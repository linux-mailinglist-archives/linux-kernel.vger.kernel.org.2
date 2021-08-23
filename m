Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18A93F4F24
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhHWROy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbhHWROd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:14:33 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58F7C0613A4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:13:50 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id gw9-20020a0562140f0900b0035decb1dfecso12906039qvb.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QdQnBYBrTtlb7EbgqCKiS4RqSCRV3iiUzEvkTpjIQRc=;
        b=UKMKXPgsxPVJpHWknSOnrvq5i4Af2vp7VUEDXYmudNQxKlaDg5IP44KGL2ICHIaAUP
         uS4jHYeVyLSsAjIfQZ6EyFjp1JJmN+baPDYfljZpOZIJauKPyphJMpHd+iMjbDn0AyIi
         IOCvKaGjnwYwuw58SENKcTnoZzIxwQCy24omsw2lavoQvMTxZQwK5XjaKvA5YK/he5uC
         oTrVJHC/225xqnIgTFAaIcMjFMx3zZH6Mf/bV2SU868O0sfnMpoWHIz5WoOJkPCtIBkJ
         0khvTREPZ/R+rWMzOEpZc9+m/YzzAa92daDnajT24DMe18qRfuptLrte1KBXnV2z0Ic2
         s4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QdQnBYBrTtlb7EbgqCKiS4RqSCRV3iiUzEvkTpjIQRc=;
        b=YQw6u5fW09EFykAKl7c158Eg5H9DCx/sPy9GT50NKYGds+4VBBDjiE7pmdN9xXQs0B
         tZvgM4HCTSYOWGGyPSiijOwffiDbevMxR8wl3uPnSA/Lf7HnoLnbl3TdazdBpSNYcmAQ
         1vpxMBhBpWzsrex9RTGz2tA4k0MvEzQx/lQw1NWHEcmZpk9qMkLpmHWoUINtuvQ/F+u7
         Xnf+QpcnwPUADE9lHmwHlYH/8QCR3J1aVnHMIFftDtbbq+FaPv9MCMFnWbjar5KU+0+O
         9QPi/2KLbyq7jQ7YtI7uSC+5uVV/NPfIjR8abPklt5iX2fHD6UYs2T0qZyv0S3IEpM6m
         fmrw==
X-Gm-Message-State: AOAM530mR3ANkMAZAh3oNUr1XQGB6Otu0rWy/o9N8qAUvVJCSoccUzFH
        v1js9ypDT7rWpPC2ZtSjWq570+Q5AyvRcy1W+DY=
X-Google-Smtp-Source: ABdhPJyChryW6mdCOPUw4wQMlYeq6A1vhaSzSiaqRF+46DFpRFp/LiLDnrxItx+PUGIwLHFNJFOXEVyp54xFmj4C5DU=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:cc48:aa6a:f4ec:7d19])
 (user=samitolvanen job=sendgmr) by 2002:a0c:e883:: with SMTP id
 b3mr34406392qvo.23.1629738829630; Mon, 23 Aug 2021 10:13:49 -0700 (PDT)
Date:   Mon, 23 Aug 2021 10:13:16 -0700
In-Reply-To: <20210823171318.2801096-1-samitolvanen@google.com>
Message-Id: <20210823171318.2801096-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v2 12/14] x86, cpu: Use LTO for cpu.c with CFI
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

Allow LTO to be used for cpu.c when CONFIG_CFI_CLANG is enabled to avoid
indirect call failures. CFI requires Clang >= 12, which doesn't have the
stack protector inlining bug.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
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
2.33.0.rc2.250.ged5fa647cd-goog

