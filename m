Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B46358C49
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 20:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhDHS3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 14:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbhDHS3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 14:29:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDE5C0613D8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 11:28:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i6so2882910ybk.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 11:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sqe+SRM2tt54QgMNprHB5Ltl/JmQ4l0M9EfeayUX7cA=;
        b=prCsiu3tjKJFc4pP0/+ujOO/HtNJYS943pILJiCXrDbIUQY4DwftcDzmjbqU8Znqzs
         ReSZn865iFbsu11kWjfPBjM/AAiEJpAQQHUMwHxVVAeHXhQN1OHlhomroaYK7Vaim+wi
         us6bUks8K563fMiSGiRf7cDSFVVRsSPVT9Kp3Y6HKLvXNYAASpNp0uCsZPUmsVI2RO78
         7etrNqjlHs2AhheD8vpQrc/1+H0Q9t7QljuufEgx8rL0gFyVyX8i17OaiFy0DvugM8k8
         kC3kVB6YoMV5Pfl80tgCca3MJ2B4VTCYyxzgyxEgHMcv4rScjHAd8A0N7P1fnaJc+bQt
         ykzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sqe+SRM2tt54QgMNprHB5Ltl/JmQ4l0M9EfeayUX7cA=;
        b=U8f1KulAu5elSx39OpLcM6ub8UEAfslfeGdUn9tafu3XqLorSDQj8oPcFt3B0H7vQK
         3KgXaiILQPd5N6ivex30n+9kAg2F0gn1v514MqTrgO/TDTGq+XtQZ8zGSy02CjTtm7Rx
         WDO5IfT7Q1bAfbIgRNSWTjI7Prl78FWlmTkFljMbUrwWnfUECCAwILXViSXVDKlm8O3b
         INyaQZH0aI6GxLN0w3jHBEK7bg1DXxFwFaSr0QkjiSTPkxIvn5fd9uJfWEv6YkuVkH8c
         y1tsf2bQWkmJdNI8drTa0sJp6e+QzizOlG431lulS4wL/rRT82VxhtgtRIBPFse1I8OX
         q6Ng==
X-Gm-Message-State: AOAM531915ftmT9rCuceVfP/esWxITdDchJEdyjRa65AX/E41toDJe6+
        FX9BUvYWxwDZAnoRlkRvurZHmAdwsSkt80UekjE=
X-Google-Smtp-Source: ABdhPJxYVjdCzFadep6CzUxo/2ynBssueHSOvDokbrGpmosVElcDFd+DnNsM/GYXnls1d0LLyuI1Tzej1BjrPfvz2Cw=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:3560:8505:40a2:e021])
 (user=samitolvanen job=sendgmr) by 2002:a25:ae03:: with SMTP id
 a3mr14172639ybj.118.1617906531475; Thu, 08 Apr 2021 11:28:51 -0700 (PDT)
Date:   Thu,  8 Apr 2021 11:28:28 -0700
In-Reply-To: <20210408182843.1754385-1-samitolvanen@google.com>
Message-Id: <20210408182843.1754385-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210408182843.1754385-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v6 03/18] mm: add generic function_nocfi macro
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_CFI_CLANG, the compiler replaces function addresses
in instrumented C code with jump table addresses. This means that
__pa_symbol(function) returns the physical address of the jump table
entry instead of the actual function, which may not work as the jump
table code will immediately jump to a virtual address that may not be
mapped.

To avoid this address space confusion, this change adds a generic
definition for function_nocfi(), which architectures that support CFI
can override. The typical implementation of would use inline assembly
to take the function address, which avoids compiler instrumentation.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 include/linux/mm.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8ba434287387..22cce9c7dd05 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -124,6 +124,16 @@ extern int mmap_rnd_compat_bits __read_mostly;
 #define lm_alias(x)	__va(__pa_symbol(x))
 #endif
 
+/*
+ * With CONFIG_CFI_CLANG, the compiler replaces function addresses in
+ * instrumented C code with jump table addresses. Architectures that
+ * support CFI can define this macro to return the actual function address
+ * when needed.
+ */
+#ifndef function_nocfi
+#define function_nocfi(x) (x)
+#endif
+
 /*
  * To prevent common memory management code establishing
  * a zero page mapping on a read fault.
-- 
2.31.1.295.g9ea45b61b8-goog

