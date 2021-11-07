Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383A24473B7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 17:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbhKGQW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 11:22:26 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:45385 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbhKGQWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 11:22:25 -0500
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 1A7GIBqt010505;
        Mon, 8 Nov 2021 01:18:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 1A7GIBqt010505
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1636301892;
        bh=L7NVYUTKQRaSf3zmJ7tch8Fq/p/5g/YPanoKCU7mZ9s=;
        h=From:To:Cc:Subject:Date:From;
        b=acS5ty7TejmKNVXuHe8WleVU0yc73HKZdR6FpjGOoILDOykqn7zm+zUtQmsO90Fvn
         KM8qRESTJaE8UfbwrhecoCGZgwmFl/wdt1o1cmxK4SptZG6ZbzlGIGSWzkqjDAN83o
         3SYUl9zD26dnbDgKb9m8XgtqdCo3uXaOfm/ZAaFYpvhW0oOgspDqERwgqHMcKw01fI
         FkHz4syr2wdmp2dXMcjEWUL4y8NuVuJAv6VNW17TO2iC8Lctu3W6oaHWbw2z79DSy+
         jIVlOYXhi4mAHBcVSnbcxv78Fd6HNW5fLue4d+gro9TZjTF3xD34yNH4t8Ks6+ZHeZ
         9CbI45ArFpDLQ==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     clang-built-linux@googlegroups.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Collingbourne <pcc@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: vdso: remove -nostdlib compiler flag
Date:   Mon,  8 Nov 2021 01:18:02 +0900
Message-Id: <20211107161802.323125-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The -nostdlib option requests the compiler to not use the standard
system startup files or libraries when linking. It is effective only
when $(CC) is used as a linker driver.

Since commit 691efbedc60d ("arm64: vdso: use $(LD) instead of $(CC)
to link VDSO"), $(LD) is directly used, hence -nostdlib is unneeded.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arm64/kernel/vdso/Makefile   | 2 +-
 arch/arm64/kernel/vdso32/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 945e6bb326e3..700767dfd221 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -23,7 +23,7 @@ btildflags-$(CONFIG_ARM64_BTI_KERNEL) += -z force-bti
 # potential future proofing if we end up with internal calls to the exported
 # routines, as x86 does (see 6f121e548f83 ("x86, vdso: Reimplement vdso.so
 # preparation in build-time C")).
-ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 --hash-style=sysv	\
+ldflags-y := -shared -soname=linux-vdso.so.1 --hash-style=sysv	\
 	     -Bsymbolic --build-id=sha1 -n $(btildflags-y) -T
 
 ccflags-y := -fno-common -fno-builtin -fno-stack-protector -ffixed-x18
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index c8fec493a450..6c01b63ff56d 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -102,7 +102,7 @@ VDSO_AFLAGS += -D__ASSEMBLY__
 # From arm vDSO Makefile
 VDSO_LDFLAGS += -Bsymbolic --no-undefined -soname=linux-vdso.so.1
 VDSO_LDFLAGS += -z max-page-size=4096 -z common-page-size=4096
-VDSO_LDFLAGS += -nostdlib -shared --hash-style=sysv --build-id=sha1
+VDSO_LDFLAGS += -shared --hash-style=sysv --build-id=sha1
 
 
 # Borrow vdsomunge.c from the arm vDSO
-- 
2.30.2

