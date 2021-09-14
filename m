Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED4540B7A6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbhINTNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbhINTMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:12:51 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B859C061797
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:11:22 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id j23-20020ac86657000000b0029cb70967ebso61438823qtp.14
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fFCvJWug7bauvAerSk8DsPanFpmiKREnwLe0beFIomQ=;
        b=nD5XzlTypImdd/oPybicKlrz8zUhRN9g+uNSLkIczGQJR2I4tjNxtsS7NThpohf75w
         PUiFDcqyOnR9QiX1VMMiRtyt2Cooz7OGyEnta1g7hhOCQv3cl37zL5gtjc7f3aWvOc6p
         gvl1OxyIGiZbOgF121Umexe3usYciXcmOnsTN7IbjpJE8CdZXdzC+xO8nuNZ4XwTZPkk
         atgYAVTZp49mIbJRZbCCVXydFiaeO27Slkc0R1J1+nW2lQ8NVuKHxe+aXtBtYcvHG30s
         I6zB6XmYc9vvc1GmJ7McPMbhLE+Tk/4zvCt/A4AbtxL+q32suxpYQk70AA+BrjTmKmjv
         NNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fFCvJWug7bauvAerSk8DsPanFpmiKREnwLe0beFIomQ=;
        b=HkDDzIvUQrEF6euStI9KKdccpTZS8b9qE6ocuKNVuCDAhvZv93YVSEhwskjDHugrpP
         7aT9PGU4X8Wb9q8V2GtizCscsOnKj+ZkqwJE5V+++Lbcx2moAeZtzMM/MQZA1gftNqlb
         q4gBK6xSR/cKNGYg/0tMdRPU4cRulMAeer3FMdhaWrvUn4c/dmOsVHyKipFALjTXD2uW
         fUslzyabw8m3dKhaWzQR7S0wKKShvalFZbeV1VP4RC7dgSnUA02gfUx2NcnMD0ThCI4/
         S7G/xwoZ9pYqVbmOUkF2UCnWu4xjXQt5fCi5FekyP5BtFB7McKm8WYA+IRn9YLkR8hKj
         jhCA==
X-Gm-Message-State: AOAM531ebCuBBM+JRuJWBVRpQt3XzqJkI+0JGP6BFFsWmoYScpFOPjTR
        u1C+OT0cKFrXa+/BZRb9+mK72qwEssMQxCCvkcQ=
X-Google-Smtp-Source: ABdhPJxUkEbd6MqiNa0YQikYTQZXHSQ16XBIBC4qHqf5VyvIYtbxinPvuPBdcN70cPLeaKLvMQ4B5coQCJnt+UP1ZG0=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:d19c:5902:49bb:c41])
 (user=samitolvanen job=sendgmr) by 2002:a0c:9c8a:: with SMTP id
 i10mr6916385qvf.59.1631646681262; Tue, 14 Sep 2021 12:11:21 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:10:43 -0700
In-Reply-To: <20210914191045.2234020-1-samitolvanen@google.com>
Message-Id: <20210914191045.2234020-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v3 14/16] x86, cpu: Use LTO for cpu.c with CFI
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
indirect call failures. CFI requires Clang >= 13, which doesn't have the
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
2.33.0.309.g3052b89438-goog

