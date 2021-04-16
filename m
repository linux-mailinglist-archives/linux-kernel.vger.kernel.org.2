Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4152B362977
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 22:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343837AbhDPUj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 16:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343674AbhDPUjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 16:39:22 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA41C061760
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:38:57 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id o17-20020ac869910000b02901a7c59f1c14so6787729qtq.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aY+by2sfCpbHCEdjbOQBS7MTkTUc3k2rkTxgoQckLqo=;
        b=Im3IocGwO9YFJ6VH4rQo49yBHnqdFgUpUQkTVi3qo3NST/5NgsJMQ+TdzIgMyhSR8G
         rg/5oHXno1DRk5pL5yWYCIpRVtvwMr5wdg/7sZ/JqHuSyh0K/nZbH+YizOcnfLZxjA9y
         a27XL33qn9FWiBLzgHnpUQxZCnEfIOgSia0itNtO4ddbDCSmpBCSKTtEuY1Mp86G55QT
         vdFJnGKPYlhn/1Iwc+xO2PMBZUTtHD38L+UVruq8H5+wxNDe06AnJ48kzsjfgpCSou+H
         yY02a8UGk9QItfJJC0uJ5MBAMRRsEna+d0rX3x+BUYzD6rNzLWfAaOK2FUJpD9GuN9r7
         1tWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aY+by2sfCpbHCEdjbOQBS7MTkTUc3k2rkTxgoQckLqo=;
        b=cG16HYBzsV1YgsJznZOZ9L68fRn1JRRSLpegKk9Oa+FCKFHcCkdu/sWE0eQi6v3AIC
         r5kKCUqxyqLlR1jayZrI6N4lqc67I98PvqNE2+rM0Auo2+TfsMm+S/v8miSmFlPNkvcf
         cPdjZt/6uPDKpPktzms9R351qCO6jttmxitxURSqc51HIOFrykLamQXQWvVtkEjPhraA
         qPabB4ZZeqR7tEuTZRNpaoyM8LG8uXGo++7wZVlfqxMyAWJBiaFaGL6ZWpWtybpdjN1D
         BnhCJBATichXTbmZ6WixcZ553YjDG6Sm4IyczQOjYhPA8HIb/4oSh8RM8wJT5VL4AG5N
         tf3A==
X-Gm-Message-State: AOAM530LT7+D1svOnvHUs/LxKBAsEO4G0kRnO/WmITPnGnyfM1/zc6Gn
        uqprf4pYaxzkQzVH9ThoHQPmCZ7fIwekZoaxjps=
X-Google-Smtp-Source: ABdhPJx7jRoAmenzmCcYKAbuR9t5VWv3GmzLBrBMyxEX6XR7mV3d/eNvgwQ9FHrSdjficlJTFqDpjw96mfSrHX0SvdI=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e262:3d8e:cbf:6164])
 (user=samitolvanen job=sendgmr) by 2002:ad4:420a:: with SMTP id
 k10mr10548306qvp.50.1618605536511; Fri, 16 Apr 2021 13:38:56 -0700 (PDT)
Date:   Fri, 16 Apr 2021 13:38:34 -0700
In-Reply-To: <20210416203844.3803177-1-samitolvanen@google.com>
Message-Id: <20210416203844.3803177-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 05/15] x86: Implement function_nocfi
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

With CONFIG_CFI_CLANG, the compiler replaces function addresses in
instrumented C code with jump table addresses. This change implements
the function_nocfi() macro, which returns the actual function address
instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/include/asm/page.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index 7555b48803a8..5499a05c44fc 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -71,6 +71,20 @@ static inline void copy_user_page(void *to, void *from, unsigned long vaddr,
 extern bool __virt_addr_valid(unsigned long kaddr);
 #define virt_addr_valid(kaddr)	__virt_addr_valid((unsigned long) (kaddr))
 
+#ifdef CONFIG_CFI_CLANG
+/*
+ * With CONFIG_CFI_CLANG, the compiler replaces function address
+ * references with the address of the function's CFI jump table
+ * entry. The function_nocfi macro always returns the address of the
+ * actual function instead.
+ */
+#define function_nocfi(x) ({						\
+	void *addr;							\
+	asm("leaq " __stringify(x) "(%%rip), %0\n\t" : "=r" (addr));	\
+	addr;								\
+})
+#endif
+
 #endif	/* __ASSEMBLY__ */
 
 #include <asm-generic/memory_model.h>
-- 
2.31.1.368.gbe11c130af-goog

