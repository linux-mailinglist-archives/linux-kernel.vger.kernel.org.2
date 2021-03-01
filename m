Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C5F327F46
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 14:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbhCANSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 08:18:13 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:36815 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbhCANSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:18:04 -0500
Received: from oscar.flets-west.jp (softbank126026090165.bbtec.net [126.26.90.165]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 121DFe7W026106;
        Mon, 1 Mar 2021 22:15:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 121DFe7W026106
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614604547;
        bh=bAqpionFgaebbYb13Tt6/ukwBV2OkJQk/Ijoh06rRD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fU6htlQUsieNG4DtV+wncStgu8tPaab9bMR1rqLxqasHGe63cu1RyBRRHVpWkqcWE
         iW8y951OaRlfESxNPiozTIiTa9ZFvpK78kiYZQw7klFvZUvPa0GK5JtAa+arUr6ufZ
         SSHa5lUlfi4g8KLGWPeOP7piM7w+1Jkqe4m20FOGRIkmn6xUu6TZwEiv6EgEy5GVk9
         fSPu4p1Xs7C5ac2lIgiquRgQmp0lrm53CKtEixJqHZ3Vk5BESd7h4OzXWPYwV2tn8y
         cgMC1bgJRJ49KXXG9yBsCnWqREriK1InK5zEr/lnxh45CJvBUIedrI72CxkbcJx1mb
         3iF3dA/wQtx8A==
X-Nifty-SrcIP: [126.26.90.165]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 5/7] x86/unistd: define X32_NR_syscalls only for 64-bit kernel
Date:   Mon,  1 Mar 2021 22:15:30 +0900
Message-Id: <20210301131533.64671-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210301131533.64671-1-masahiroy@kernel.org>
References: <20210301131533.64671-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

X32_NR_syscalls is needed only when building arch/x86/entry/common.c
for x86_64 kernel. It is not used for i386 kernel.

Move it to the else part of #ifdef CONFIG_X86_32.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/include/asm/unistd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/unistd.h b/arch/x86/include/asm/unistd.h
index c1c3d31b15c0..1bc6020bc58d 100644
--- a/arch/x86/include/asm/unistd.h
+++ b/arch/x86/include/asm/unistd.h
@@ -26,11 +26,11 @@
 #  define __ARCH_WANT_COMPAT_SYS_PWRITEV64
 #  define __ARCH_WANT_COMPAT_SYS_PREADV64V2
 #  define __ARCH_WANT_COMPAT_SYS_PWRITEV64V2
+#  define X32_NR_syscalls (__NR_x32_syscall_max + 1)
 
 # endif
 
 # define NR_syscalls (__NR_syscall_max + 1)
-# define X32_NR_syscalls (__NR_x32_syscall_max + 1)
 # define IA32_NR_syscalls (__NR_ia32_syscall_max + 1)
 
 # define __ARCH_WANT_NEW_STAT
-- 
2.27.0

