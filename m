Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CC13A485A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhFKSGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:06:16 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:38552 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbhFKSGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:06:02 -0400
Received: by mail-wm1-f49.google.com with SMTP id t4-20020a1c77040000b029019d22d84ebdso9123859wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ZxH3CixZlkWsIeQExEBk552GYn4yb7O/v8JQ0YrsFk=;
        b=CRVK7dMpBkCDDD+iOdTmCqSaZQuZ87krHodrl41Glz6l6NZ9VFDc1J0o2YrZHUjKDy
         I4lf/bX9fyac0+a3k0m6mXrQ9COhAzVjw3Y/5GeCz8xjPmF8fr7pMbEyqRNbSFEhrmTk
         G/IaJdXsu3nxxenMeJpEr8e8AXhETF4z3YUHrnPXwDYiAQDbfVdKFBEUw9VNYOpDuT7/
         EtkI6LD6tVWKULk2it6dTHBw3iW20VKbbnq9oVnOwdUceWxu0zr+Fla9W9PTkPuxkj7E
         35i33amVo3SvU26nnsW408bMN2pIMrXKVbIQVmmoL/7knP2A1YNoGMBVBRYUqsoufuWk
         Tmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ZxH3CixZlkWsIeQExEBk552GYn4yb7O/v8JQ0YrsFk=;
        b=cn2oZpaYr0eHL9RVwuNLZio5WfxlKfr1Tl5nzVpxupa8w2J/i9rWw9MGUuoHPFiFap
         saTfYuifIkAr3ixEL4FIZwQkvvI1Yaw6mOnu9auPtgsYD8kOQxY4pVAA3J5PbYJnYjSN
         wFpqaiDbhhpAB9oH8V2XAkGupPC3sVpCN9urlxh7gIjer2qXvKLKFCXMwgNjyY67/cgt
         kX3uPCkqBJIVLOwRe1bgq5xGkdGdIfIChjNsY2RMBfjcEoOa4tf9gfOq8ejbfp95V2F6
         FJ+DTcWoGKfWRgjff6nYhc2BUuix/8li8Fg+msYfJV3DDu8btjOhkZHwwlNVIFxLCzIN
         j9Ag==
X-Gm-Message-State: AOAM531+BBxv+vEye8YUFO8V3wQJRehYesa/CC+4JpfswkdMkCEFGkg0
        SodnnyLKBLoCMJQkBLqK+tijQpp3qL6DqeSO
X-Google-Smtp-Source: ABdhPJwwjZ2UPiMcwOhfpARIPLcq2/5bx41bOdaa+KiB8dZU/X/bki+LCybOVoQ2Qelszgc9HJkDWQ==
X-Received: by 2002:a7b:c8d0:: with SMTP id f16mr22257887wml.115.1623434574885;
        Fri, 11 Jun 2021 11:02:54 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id v15sm7425881wrw.24.2021.06.11.11.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 11:02:54 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 04/23] arm64: Use in_compat_task() in arch_setup_additional_pages()
Date:   Fri, 11 Jun 2021 19:02:23 +0100
Message-Id: <20210611180242.711399-5-dima@arista.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611180242.711399-1-dima@arista.com>
References: <20210611180242.711399-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of providing compat_arch_setup_additional_pages(), check if the
task is compatible from personality, which is set earlier in
load_elf_binary(). That will align code with powerpc and sparc, also
it'll allow to completely remove compat_arch_setyp_addtional_pages()
macro after doing the same for x86, simiplifying the binfmt code
in the end and leaving elf loader single function.

Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm64/include/asm/elf.h |  5 -----
 arch/arm64/kernel/vdso.c     | 21 ++++++++++-----------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index d1073ffa7f24..a81953bcc1cf 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -237,11 +237,6 @@ do {									\
 #else
 #define COMPAT_ARCH_DLINFO
 #endif
-struct linux_binprm;
-extern int aarch32_setup_additional_pages(struct linux_binprm *bprm,
-					  int uses_interp);
-#define compat_arch_setup_additional_pages \
-					aarch32_setup_additional_pages
 
 #endif /* CONFIG_COMPAT */
 
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index a61fc4f989b3..a8bf72320ad0 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -411,29 +411,24 @@ static int aarch32_sigreturn_setup(struct mm_struct *mm)
 	return PTR_ERR_OR_ZERO(ret);
 }
 
-int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+static int aarch32_setup_additional_pages(struct linux_binprm *bprm,
+					  int uses_interp)
 {
 	struct mm_struct *mm = current->mm;
 	int ret;
 
-	if (mmap_write_lock_killable(mm))
-		return -EINTR;
-
 	ret = aarch32_kuser_helpers_setup(mm);
 	if (ret)
-		goto out;
+		return ret;
 
 	if (IS_ENABLED(CONFIG_COMPAT_VDSO)) {
 		ret = __setup_additional_pages(VDSO_ABI_AA32, mm, bprm,
 					       uses_interp);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
-	ret = aarch32_sigreturn_setup(mm);
-out:
-	mmap_write_unlock(mm);
-	return ret;
+	return aarch32_sigreturn_setup(mm);
 }
 #endif /* CONFIG_COMPAT */
 
@@ -470,7 +465,11 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 
-	ret = __setup_additional_pages(VDSO_ABI_AA64, mm, bprm, uses_interp);
+	if (is_compat_task())
+		ret = aarch32_setup_additional_pages(bprm, uses_interp);
+	else
+		ret = __setup_additional_pages(VDSO_ABI_AA64, mm, bprm, uses_interp);
+
 	mmap_write_unlock(mm);
 
 	return ret;
-- 
2.31.1

