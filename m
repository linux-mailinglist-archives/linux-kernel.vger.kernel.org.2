Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED5E362986
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 22:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344070AbhDPUkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 16:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343970AbhDPUjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 16:39:41 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB46DC06138E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:39:12 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id n13-20020ac86f4d0000b02901b35920b3cbso6764071qtv.23
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=L00sBSj1ELLX/Krj/tO4geuDmUwEKOoDhO2GtbyEzGY=;
        b=tQpc8LYT+nLLdKLnwAODeiwTmYEi1/jJ0aNEkLBltpaGbhdVWc0+KaaXi8k3HcarW+
         GdRqkLdtkXIlYhizJYvLuf0lzKsKhdhV1Ae+Qfyw90OvKhnSG7xB+p6X9VDFFOkgQSZp
         mHEGXW+hiHjirCI7ibaMRiLYFKqhLm9u4JAdjORGQ8yUbI/F5tTnTpLOQuayPAMDMXtq
         +6K5lugx7vpSFe07/YiaPPWqWKauJjeoW3rPM7SnBHq7hw3Ahmtz688DjELw6KRPccMy
         uXQXH805Yn26oCHIDRw1bddHahzkmEWEYK0vdu9d0ZMj0cJPd5qgql652R7uTp17TZ+D
         qAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L00sBSj1ELLX/Krj/tO4geuDmUwEKOoDhO2GtbyEzGY=;
        b=kbKJtAF2TnKlc+VAlneAjHQkKjgijSkDCvqy5z4Uav4C0RgGf7xchvsOIht3zwrlVc
         WYIGpAft/IuVec+5/iolbd+7/ro9M2cHaqZ951VbRcIMx9RNmt4NebLblmp7pfkTc78Z
         igtDsTzFpoSKLVzz4oGH0sIxOsK3qQkAuyawjuQ3g/RuuxJDnHzTqlhY3Y7/06UvVjtO
         yhlxrY71Nmv3h1Zd/o2AAFPi+pKltqbeh1ahG+hx4/ie92xPd4/s+pReiZN0iUzseoIN
         5NdYGGlDs9wcb53mox2tt2WwBis32nfv/Rfp4VND2KI7VditqHkz5EwUW0LdqYnPwwSU
         iFbQ==
X-Gm-Message-State: AOAM531MeErA02pVkYSoU6bHe+J2Z9NYxKfNl4JnnaXZ+RKrii8mvpw4
        rvp/uCwf2DCIgz0WpCZzjRSx0P+hMdt9R5gVJh0=
X-Google-Smtp-Source: ABdhPJyV6aw2CRxX5Ka4nkDEUs0zr6DNTz7zFBmr5kr8bNdUja0e+FxUztdUP/+nH7or7ogmyaJPg0f4LpP4gJiAOPs=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e262:3d8e:cbf:6164])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:13c2:: with SMTP id
 cg2mr10524752qvb.4.1618605551808; Fri, 16 Apr 2021 13:39:11 -0700 (PDT)
Date:   Fri, 16 Apr 2021 13:38:42 -0700
In-Reply-To: <20210416203844.3803177-1-samitolvanen@google.com>
Message-Id: <20210416203844.3803177-14-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 13/15] x86, cpu: Use LTO for cpu.c with CFI
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
2.31.1.368.gbe11c130af-goog

