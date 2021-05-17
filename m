Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74B7382578
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 09:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbhEQHlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 03:41:08 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:33329 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbhEQHlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 03:41:06 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 14H7cLoM027919;
        Mon, 17 May 2021 16:38:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 14H7cLoM027919
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1621237105;
        bh=bAqpionFgaebbYb13Tt6/ukwBV2OkJQk/Ijoh06rRD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E2xaCdpQXpA3Po0UrNYB1lxpKjrEIN5jVW1K2WulNsqjvw4Ua1pvJKq2rVFZYv3uP
         kvLLynIepEwMR5dXAlOAaXW+/S0NsXy/biFB4yQyY5CxMXkKcwfPsaMU8o8TNb8aty
         dSD8M2zWo52uphHOuW+sQ4bje/vLj4sxVGGSt0yzKHHGasVSJFj6oP1KGQiSG42ji5
         Hk0385Md74kgLS8kkMlc3+Pmy2kptI3693WuOCX2wUhGUt6V7Xha3pRjC/xnDyAwm8
         KkagO5vzn9AB+uw/aB7vk8rdhT3Xe/T3E0TR+QteNHizMkPWLBOgUlIkQyO5+ZkHZV
         vO37N2hBZHxHw==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 4/6] x86/unistd: define X32_NR_syscalls only for 64-bit kernel
Date:   Mon, 17 May 2021 16:38:12 +0900
Message-Id: <20210517073815.97426-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210517073815.97426-1-masahiroy@kernel.org>
References: <20210517073815.97426-1-masahiroy@kernel.org>
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

