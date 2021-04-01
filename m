Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFCE3523E6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 01:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbhDAXdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 19:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236411AbhDAXdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 19:33:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5333C0610DF
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 16:32:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y13so7391721ybk.20
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 16:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=US4jGgKY8G5DfLFeUodkpP35btrx7ts0CLHDF+n9ZqI=;
        b=PRz3MFDuokm+w3IxnWltMpzxfsPLf8nUTH2Cm2JRtKoFDs5tjZV9dE2QQ7zHJVdVLi
         4iY5onXSOWdoZLvRKnbHGN3US9zL9LyQt6POgqN1iJGwPo0t9Q6Mzom1yqVFkfTwGgxR
         7g0AQg/BkgU93LW8c8y/FNi1kjeU5+buOKaJ+c+1Zo96nm+JnRe7GXMG0bfZSVbgwrBy
         S8gTnIGO8lKmp/TA2Irs02Gsmasx5KNnKuAz71fowOI44G0xsJvDSVa4EdT6ZwJ7oiHW
         JIRrVdeZXPVojoF1m9tr8GOvmzAdnoz0Xuud72L3TS/uh00kfkLUB7c1SinbKPgzQdVq
         t+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=US4jGgKY8G5DfLFeUodkpP35btrx7ts0CLHDF+n9ZqI=;
        b=RTUNh24zPEVgctr0FAgbmr0sGKbhqn058efX85QVIlH9vguTwT3hKuv2bjMa3WJtOP
         S95E0SYGkHIopTv7ZtqnzRrpGI3lQe+vl7pRIMZsXSTdEtoz7zY6B/FmK4/foGLAxb2a
         lBxrRYbOC0GdWDnN1MbE81zJMf9imIGVe00s/80Kc/ojZiq/sZkvI1OWay931J5l3o3p
         xG80E3hj3kxPoVU861igoVvAZge/LaC5zmuMb8dtFF9Zx53O4SBKGMe4HS8PMXz5nS9C
         pLcoht+N22OeL30haKaq1SVbKaM3yVw4azgGiIfehkb/jnRgIqccvrUAaCStz+9Kx+m+
         u4Dw==
X-Gm-Message-State: AOAM533+HajqojPqvSQfKY21Stt07h7bHrTHj0PIQuG9nh0e2dnIkXn2
        Wnbeg4MkH2nbwSngfPGznwKHwyKNFkHsiibXgvM=
X-Google-Smtp-Source: ABdhPJyAtum2nuP+lVZ9BfeUeCfXFUi2ZrH2E6FgcEuBzztVxnpeaqWs+SRUS0lZ2LuUE5T5CK4HQCRb+WFqq84q4xA=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:4cd1:da86:e91b:70b4])
 (user=samitolvanen job=sendgmr) by 2002:a25:ba85:: with SMTP id
 s5mr15701230ybg.336.1617319963848; Thu, 01 Apr 2021 16:32:43 -0700 (PDT)
Date:   Thu,  1 Apr 2021 16:32:10 -0700
In-Reply-To: <20210401233216.2540591-1-samitolvanen@google.com>
Message-Id: <20210401233216.2540591-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210401233216.2540591-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v5 12/18] arm64: implement function_nocfi
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

With CONFIG_CFI_CLANG, the compiler replaces function addresses in
instrumented C code with jump table addresses. This change implements
the function_nocfi() macro, which returns the actual function address
instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/include/asm/memory.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 0aabc3be9a75..b55410afd3d1 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -321,6 +321,21 @@ static inline void *phys_to_virt(phys_addr_t x)
 #define virt_to_pfn(x)		__phys_to_pfn(__virt_to_phys((unsigned long)(x)))
 #define sym_to_pfn(x)		__phys_to_pfn(__pa_symbol(x))
 
+#ifdef CONFIG_CFI_CLANG
+/*
+ * With CONFIG_CFI_CLANG, the compiler replaces function address
+ * references with the address of the function's CFI jump table
+ * entry. The function_nocfi macro always returns the address of the
+ * actual function instead.
+ */
+#define function_nocfi(x) ({						\
+	void *addr;							\
+	asm("adrp %0, " __stringify(x) "\n\t"				\
+	    "add  %0, %0, :lo12:" __stringify(x) : "=r" (addr));	\
+	addr;								\
+})
+#endif
+
 /*
  *  virt_to_page(x)	convert a _valid_ virtual address to struct page *
  *  virt_addr_valid(x)	indicates whether a virtual address is valid
-- 
2.31.0.208.g409f899ff0-goog

