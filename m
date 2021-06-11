Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335483A485D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhFKSG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:06:29 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:42584 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbhFKSGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:06:06 -0400
Received: by mail-wm1-f41.google.com with SMTP id l7-20020a05600c1d07b02901b0e2ebd6deso9085218wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=InEOMOZ7wGAOxeUq6PLoyewZ6xlseHrkNPhjJnzVF/0=;
        b=erIFfuqiRhByY/ZG1wQU2rUOpL/ZI8cMbtEf3/LDDrK4tyzLZIhrZSlkkEesdzKBSp
         t+5c06yhEfHKFdu1nnhntEzqNcWVyz1alPLM4zSTIkRvZxvynNP9oqpqoQhmJUMP6rqZ
         rVtD4RtHV2uuVJpMMDDKaUMB2TLhEk4Ys/S9UJT8OvKVmGbr5/RNtu3lJh4kQhsp1nFp
         xPBGAROpzHDXRq59gXCyhmkaI1TamTox0S2LEdBl80eA+bbwmdNDdpKySnt4Flv7GGKl
         qKhYv2Ci0FFgXG+IduAcazkpMjOAqH74nNV5qZU3KrUwmk5zGU+xwbHd8fKZMgvxlML4
         vqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=InEOMOZ7wGAOxeUq6PLoyewZ6xlseHrkNPhjJnzVF/0=;
        b=NmyI42PM/DB8wh0b11EXwph8BlF4MEAt3QXTr+zSOArVBFqNe5yjdrlmIAuZP9oLme
         C6qoJ2Ro9FUsVRAnfkmgFdw/kYck5sCndOzbDr7oz9uUwe0t219fgWKrhiAx2d90kfdL
         urY27iEZ2E9T2mcqMKC882gMBcb3ABBrO8pTeOsDWSCOKliQfSrTPObLkwipHbpapDEq
         ynbk93WkrJSUaHlVMhZ9UCGzFL1XjIOp+/YBMI0puRoWnim/HQXVfKtdooww+Xk5vZ3O
         7b0uvo3oCSOaWr5YvLhOWutVsW6Zz5HX2N4L3BdfeU/vkb+KN5fpVMgZLHPwECA0xHwh
         RaAw==
X-Gm-Message-State: AOAM532H8lX9cges6KQ21WwFMRlZnT1FkJNu3nxB0qYnlc+78gvn8o4l
        le3C5S9JQF26JYwM0BOjquAoDev7U8zQ9XS+
X-Google-Smtp-Source: ABdhPJyp3rrZZLcvEpdTZBNjXlCZzaCIf7fty6bKs9tygqmwfhNrWA9YuzZLA/7S/GXYUtj23/u26Q==
X-Received: by 2002:a7b:cf18:: with SMTP id l24mr20820984wmg.160.1623434579365;
        Fri, 11 Jun 2021 11:02:59 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id v15sm7425881wrw.24.2021.06.11.11.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 11:02:59 -0700 (PDT)
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
        Will Deacon <will@kernel.org>, x86@kernel.org
Subject: [PATCH v3 07/23] vdso: Set mm->context.vdso only on success of _install_special_mapping()
Date:   Fri, 11 Jun 2021 19:02:26 +0100
Message-Id: <20210611180242.711399-8-dima@arista.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611180242.711399-1-dima@arista.com>
References: <20210611180242.711399-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Old pattern was:
1. set mm->context.vdso = addr;
2. try install_special_mapping()
3. on failure set mm->context.vdso = 0

The reason behind the old pattern was to make arch_vma_name() work
in perf_event_mmap_event().  These days using _install_special_mapping()
instead of install_special_mapping() makes old pattern obsolete:
:		if (vma->vm_ops && vma->vm_ops->name) {
:			name = (char *) vma->vm_ops->name(vma);
:			if (name)
:				goto cpy_name;

Setting mm->context.vdso = 0 also makes little sense: mm_alloc()
zero-fills new mm_struct. And for double-safety if
arch_setup_additional_pages() fails, bprm_execve() makes sure that the
half-initialized process doesn't make it way to userspace by
:		force_sigsegv(SIGSEGV);

Let's cleanup code: set mm->context.vdso only on success, assuming that
any new mm_struct is clean.

Some platforms do_munmap() vvar if vdso mapping failed, but it's really
necessary only on x86 where vdso/vvar pair can be mapped by userspace
(see prctl_map_vdso()). On other platforms vdso/vvar is only pre-mapped
by ELF loader, which as described above will make sure to not let any
half-baked process out. I've left do_unmap() on !x86 in case prctl()
will be supported.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm/kernel/vdso.c     |  2 --
 arch/arm64/kernel/vdso.c   | 16 +++++-----------
 arch/nds32/kernel/vdso.c   |  5 +----
 arch/powerpc/kernel/vdso.c |  9 ++-------
 arch/sparc/vdso/vma.c      |  7 ++-----
 5 files changed, 10 insertions(+), 29 deletions(-)

diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index 3408269d19c7..015eff0a6e93 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -238,8 +238,6 @@ void arm_install_vdso(struct mm_struct *mm, unsigned long addr)
 	struct vm_area_struct *vma;
 	unsigned long len;
 
-	mm->context.vdso = 0;
-
 	if (vdso_text_pagelist == NULL)
 		return;
 
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index a8bf72320ad0..1bc8adefa293 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -227,34 +227,28 @@ static int __setup_additional_pages(enum vdso_abi abi,
 	vdso_mapping_len = vdso_text_len + VVAR_NR_PAGES * PAGE_SIZE;
 
 	vdso_base = get_unmapped_area(NULL, 0, vdso_mapping_len, 0, 0);
-	if (IS_ERR_VALUE(vdso_base)) {
-		ret = ERR_PTR(vdso_base);
-		goto up_fail;
-	}
+	if (IS_ERR_VALUE(vdso_base))
+		return vdso_base;
 
 	ret = _install_special_mapping(mm, vdso_base, VVAR_NR_PAGES * PAGE_SIZE,
 				       VM_READ|VM_MAYREAD|VM_PFNMAP,
 				       vdso_info[abi].dm);
 	if (IS_ERR(ret))
-		goto up_fail;
+		return PTR_ERR(ret);
 
 	if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL) && system_supports_bti())
 		gp_flags = VM_ARM64_BTI;
 
 	vdso_base += VVAR_NR_PAGES * PAGE_SIZE;
-	mm->context.vdso = (void *)vdso_base;
 	ret = _install_special_mapping(mm, vdso_base, vdso_text_len,
 				       VM_READ|VM_EXEC|gp_flags|
 				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
 				       vdso_info[abi].cm);
 	if (IS_ERR(ret))
-		goto up_fail;
+		return PTR_ERR(ret);
 
+	mm->context.vdso = (void *)vdso_base;
 	return 0;
-
-up_fail:
-	mm->context.vdso = NULL;
-	return PTR_ERR(ret);
 }
 
 #ifdef CONFIG_COMPAT
diff --git a/arch/nds32/kernel/vdso.c b/arch/nds32/kernel/vdso.c
index e16009a07971..2d1d51a0fc64 100644
--- a/arch/nds32/kernel/vdso.c
+++ b/arch/nds32/kernel/vdso.c
@@ -175,7 +175,6 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 	/*Map vdso to user space */
 	vdso_base += PAGE_SIZE;
-	mm->context.vdso = (void *)vdso_base;
 	vma = _install_special_mapping(mm, vdso_base, vdso_text_len,
 				       VM_READ | VM_EXEC |
 				       VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC,
@@ -185,11 +184,9 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 		goto up_fail;
 	}
 
-	mmap_write_unlock(mm);
-	return 0;
+	mm->context.vdso = (void *)vdso_base;
 
 up_fail:
-	mm->context.vdso = NULL;
 	mmap_write_unlock(mm);
 	return ret;
 }
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 717f2c9a7573..76e898b56002 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -229,13 +229,6 @@ static int __arch_setup_additional_pages(struct linux_binprm *bprm, int uses_int
 	/* Add required alignment. */
 	vdso_base = ALIGN(vdso_base, VDSO_ALIGNMENT);
 
-	/*
-	 * Put vDSO base into mm struct. We need to do this before calling
-	 * install_special_mapping or the perf counter mmap tracking code
-	 * will fail to recognise it as a vDSO.
-	 */
-	mm->context.vdso = (void __user *)vdso_base + vvar_size;
-
 	vma = _install_special_mapping(mm, vdso_base, vvar_size,
 				       VM_READ | VM_MAYREAD | VM_IO |
 				       VM_DONTDUMP | VM_PFNMAP, &vvar_spec);
@@ -257,6 +250,8 @@ static int __arch_setup_additional_pages(struct linux_binprm *bprm, int uses_int
 				       VM_MAYWRITE | VM_MAYEXEC, vdso_spec);
 	if (IS_ERR(vma))
 		do_munmap(mm, vdso_base, vvar_size, NULL);
+	else
+		mm->context.vdso = (void __user *)vdso_base + vvar_size;
 
 	return PTR_ERR_OR_ZERO(vma);
 }
diff --git a/arch/sparc/vdso/vma.c b/arch/sparc/vdso/vma.c
index cc19e09b0fa1..d8a344f6c914 100644
--- a/arch/sparc/vdso/vma.c
+++ b/arch/sparc/vdso/vma.c
@@ -390,7 +390,6 @@ static int map_vdso(const struct vdso_image *image,
 	}
 
 	text_start = addr - image->sym_vvar_start;
-	current->mm->context.vdso = (void __user *)text_start;
 
 	/*
 	 * MAYWRITE to allow gdb to COW and set breakpoints
@@ -412,16 +411,14 @@ static int map_vdso(const struct vdso_image *image,
 				       -image->sym_vvar_start,
 				       VM_READ|VM_MAYREAD,
 				       &vvar_mapping);
-
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
 		do_munmap(mm, text_start, image->size, NULL);
+	} else {
+		current->mm->context.vdso = (void __user *)text_start;
 	}
 
 up_fail:
-	if (ret)
-		current->mm->context.vdso = NULL;
-
 	mmap_write_unlock(mm);
 	return ret;
 }
-- 
2.31.1

