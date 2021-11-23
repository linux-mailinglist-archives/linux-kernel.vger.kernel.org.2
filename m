Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2EF45A33E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 13:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237552AbhKWMxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 07:53:06 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:31899 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237089AbhKWMwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 07:52:40 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Hz3k71VxnzcbJt;
        Tue, 23 Nov 2021 20:44:31 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 20:49:30 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 20:49:29 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>
Subject: [PATCH v16 08/11] x86, arm64: Add ARCH_WANT_RESERVE_CRASH_KERNEL config
Date:   Tue, 23 Nov 2021 20:46:43 +0800
Message-ID: <20211123124646.1995-9-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20211123124646.1995-1-thunder.leizhen@huawei.com>
References: <20211123124646.1995-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Zhou <chenzhou10@huawei.com>

We make the functions reserve_crashkernel[_low]() as generic for
x86 and arm64. Since reserve_crashkernel[_low]() implementations
are quite similar on other architectures as well, we can have more
users of this later.

So have CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL in arch/Kconfig and
select this by X86 and ARM64.

Suggested-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/Kconfig        | 3 +++
 arch/arm64/Kconfig  | 1 +
 arch/x86/Kconfig    | 2 ++
 kernel/crash_core.c | 7 ++-----
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 26b8ed11639da46..19256aa924c3b2c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -24,6 +24,9 @@ config KEXEC_ELF
 config HAVE_IMA_KEXEC
 	bool
 
+config ARCH_WANT_RESERVE_CRASH_KERNEL
+	bool
+
 config SET_FS
 	bool
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c4207cf9bb17ffb..4b99efa36da3793 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -95,6 +95,7 @@ config ARM64
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
 	select ARCH_WANT_LD_ORPHAN_WARN
+	select ARCH_WANT_RESERVE_CRASH_KERNEL if KEXEC_CORE
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARM_AMBA
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7399327d1eff79d..528034b4276ecf8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -12,6 +12,7 @@ config X86_32
 	depends on !64BIT
 	# Options that are inherently 32-bit kernel only:
 	select ARCH_WANT_IPC_PARSE_VERSION
+	select ARCH_WANT_RESERVE_CRASH_KERNEL if KEXEC_CORE
 	select CLKSRC_I8253
 	select CLONE_BACKWARDS
 	select GENERIC_VDSO_32
@@ -28,6 +29,7 @@ config X86_64
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_USE_CMPXCHG_LOCKREF
+	select ARCH_WANT_RESERVE_CRASH_KERNEL if KEXEC_CORE
 	select HAVE_ARCH_SOFT_DIRTY
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 4dc2643fcbccf99..b23cfc0ca8905fd 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -321,9 +321,7 @@ int __init parse_crashkernel_low(char *cmdline,
  * --------- Crashkernel reservation ------------------------------
  */
 
-#ifdef CONFIG_KEXEC_CORE
-
-#if defined(CONFIG_X86) || defined(CONFIG_ARM64)
+#ifdef CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL
 static int __init reserve_crashkernel_low(void)
 {
 #ifdef CONFIG_64BIT
@@ -451,8 +449,7 @@ void __init reserve_crashkernel(void)
 	crashk_res.start = crash_base;
 	crashk_res.end   = crash_base + crash_size - 1;
 }
-#endif
-#endif /* CONFIG_KEXEC_CORE */
+#endif /* CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL */
 
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
-- 
2.25.1

