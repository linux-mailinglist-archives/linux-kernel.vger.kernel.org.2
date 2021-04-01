Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00C93523F1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 01:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbhDAXd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 19:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236442AbhDAXdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 19:33:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AA4C05BD41
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 16:32:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n13so7448386ybp.14
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 16:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=37WXlWpJE/MH2/fTLXwSTxqjd9/AH96OFcukUiyJmR0=;
        b=MUQr6v2A7LCBmGGXinKbAauiWDZhchJOpufB06vPc+y89Shk0A0npRr/9pi/BMnqsB
         YGYxOoOiR3PrdY8ZvOt3qRolktkxmVSz3ty9GU49sjcOVoOvAMpyI+Ym5JD2voui9ciR
         JDoFs1ykTMsPlDGAgu+Bm8m691JtKnEnsA7+jISAWcEE4cW3JV2MHZho27EcQA/kuCau
         VXHlisP8AHfL1MQKDwgviz2t0wRX58nf0mMrORxHPTAzQYVrbXDCVawyEvB4IkXkQbBZ
         Jm4KgKNJEYjjwWfViZj9dmkUZDckfv04mz1AgpKxpkTAfwcF9/HjIbATeU6V1dfNJ4d0
         DsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=37WXlWpJE/MH2/fTLXwSTxqjd9/AH96OFcukUiyJmR0=;
        b=U3AQyPrwBNR2BXSzpxSI847PMbmdsNQq6nBxgiApPfagL3g8iQip39zLx326BpB9LW
         VnA///8VUxPMsOK4PyLfHiDzHsajBtPGUIDjTQon+HIkGfEiO79YpIRn7sP+byqDXtCk
         GY2hzmepsqrtIXFiWIAqiYhc1jvlLS1AigOBRCQW9Oova2Te5KwFKTZk9EvV7NYNoKz2
         kggk3pa5w+qvUtaYzt+Cxy6RRGpdWW+RbVvWdsIl5eqlILZntXopb1HmEIBkrpXBAR1d
         hpJ8Lr6All+B2fVcItjTEFCpsfv4sH1tS8K+5yH+xAJhjjYB8I2L8MNtr3Ukr28gXoBK
         XgCA==
X-Gm-Message-State: AOAM532YzEKg4Oj+ejwKOEdaFS2y0lK/fs/GOQ0CvK/W7vry8gWgGfXx
        sFb0Zk9RmA4406J38fF24jZaGIahwjB6iI1q3C8=
X-Google-Smtp-Source: ABdhPJyacKdTlF1o2JuZj83r2EZ9uWCYLJKXhYnoqbWWXjMYOdLghpkywDwL6B11A1p+0Vayoc5nWlpe10PZfvZrig0=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:4cd1:da86:e91b:70b4])
 (user=samitolvanen job=sendgmr) by 2002:a5b:98d:: with SMTP id
 c13mr14426086ybq.463.1617319968075; Thu, 01 Apr 2021 16:32:48 -0700 (PDT)
Date:   Thu,  1 Apr 2021 16:32:12 -0700
In-Reply-To: <20210401233216.2540591-1-samitolvanen@google.com>
Message-Id: <20210401233216.2540591-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210401233216.2540591-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v5 14/18] arm64: add __nocfi to functions that jump to a
 physical address
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

Disable CFI checking for functions that switch to linear mapping and
make an indirect call to a physical address, since the compiler only
understands virtual addresses and the CFI check for such indirect calls
would always fail.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/include/asm/mmu_context.h | 2 +-
 arch/arm64/kernel/cpu-reset.h        | 8 ++++----
 arch/arm64/kernel/cpufeature.c       | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 386b96400a57..d3cef9133539 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -119,7 +119,7 @@ static inline void cpu_install_idmap(void)
  * Atomically replaces the active TTBR1_EL1 PGD with a new VA-compatible PGD,
  * avoiding the possibility of conflicting TLB entries being allocated.
  */
-static inline void cpu_replace_ttbr1(pgd_t *pgdp)
+static inline void __nocfi cpu_replace_ttbr1(pgd_t *pgdp)
 {
 	typedef void (ttbr_replace_func)(phys_addr_t);
 	extern ttbr_replace_func idmap_cpu_replace_ttbr1;
diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
index f3adc574f969..9a7b1262ef17 100644
--- a/arch/arm64/kernel/cpu-reset.h
+++ b/arch/arm64/kernel/cpu-reset.h
@@ -13,10 +13,10 @@
 void __cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
 	unsigned long arg0, unsigned long arg1, unsigned long arg2);
 
-static inline void __noreturn cpu_soft_restart(unsigned long entry,
-					       unsigned long arg0,
-					       unsigned long arg1,
-					       unsigned long arg2)
+static inline void __noreturn __nocfi cpu_soft_restart(unsigned long entry,
+						       unsigned long arg0,
+						       unsigned long arg1,
+						       unsigned long arg2)
 {
 	typeof(__cpu_soft_restart) *restart;
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 0b2e0d7b13ec..c2f94a5206e0 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1445,7 +1445,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 }
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-static void
+static void __nocfi
 kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
 {
 	typedef void (kpti_remap_fn)(int, int, phys_addr_t);
-- 
2.31.0.208.g409f899ff0-goog

