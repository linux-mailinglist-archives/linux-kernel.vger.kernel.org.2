Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3DB3C1C0E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 01:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhGHX2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 19:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhGHX2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 19:28:14 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19216C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 16:25:32 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id x12-20020a05620a448cb02903b3dabbe857so4944615qkp.15
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 16:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SwO6fBZGz2iC3nN2qsSyi7QNR9xbovSrkFUoBq2YBxQ=;
        b=PicVCFX7aq3C0LfwA5o/vKjKqx2f9hG07XU7N7Ij5aRvpT3ZMf2+GA2T+bQ4XkA0wn
         uIBTsyHl4mTuFrohrFxYwB7C2JMuzxiQBxwqCHEPprMfajKRKBCTWlzbfXWV9HU3WIxz
         fVI+jUBLp5qip5uCMCgAoL5hZUZ9ZCftcP5uDn8jmaYrD3Uzfe1lsDvL1RGnb7SQxV3E
         Gn4sosY7Xsu2YdDA/qhGHy5BOhWxZn/GI9k6NS1W4DXayWEI8trfr8fzIn25jZImddjk
         40K4u5VLkmwCDal1JieOoiTOwGIxT087Jg/CKe04fnlnyvZlTKfsLiH+scx9TDfNjfX0
         G+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SwO6fBZGz2iC3nN2qsSyi7QNR9xbovSrkFUoBq2YBxQ=;
        b=iL20mvPN1bzCJwmriSn4f55/vBdShSjdw33KwgxCX8QfXsv8YYTGP7g2Je+LnliBdM
         rxGg+S1vet+CjkuDlHb45VgScfYA+lrJ/T2w8xiBsl/6CV2Z9jsILAREWjMSSiMkJjJJ
         JeXe6WodW8U94phJpFCrg6C9KoADUWaD/QfLL3kkMqjFpYQLtlArzm5i0yUkwyRQ8/i4
         ScmruttCHGhbe1ZNuGSvu7Cj4FcJ03soPBo+afAcIzO5OGtr+zM1KsmOmEKBuRtrWlgg
         ySPjyxVw+wWuSohU+KHbhB/nXKarbi/kmrlBYaONOyZqR0HoO+rVCieVamnUjNBnLWkT
         LAAg==
X-Gm-Message-State: AOAM530ax/NYUzYV7JKOpBpAftUug6V5eExILY8t5xLgJXlh9PrAcG87
        28bIq1wQuK6nEa1qLNeEDDtvZ48xk9Tv6539kkg=
X-Google-Smtp-Source: ABdhPJxbl4/glWYghmfTYXi+1oKuqYroUw6XvbRsXBsvOzn28ijUeZE6bkSwdkd8ihbLVreF/05ziSJl8qCWv0q3jrE=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:9fd:98a9:be3a:391d])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6214:21cf:: with SMTP id
 d15mr33140677qvh.12.1625786731194; Thu, 08 Jul 2021 16:25:31 -0700 (PDT)
Date:   Thu,  8 Jul 2021 16:25:22 -0700
In-Reply-To: <20210708232522.3118208-1-ndesaulniers@google.com>
Message-Id: <20210708232522.3118208-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210708232522.3118208-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 2/2] Makefile: infer CROSS_COMPILE from SRCARCH for LLVM=1 LLVM_IAS=1
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>, Fangrui Song <maskray@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get constant feedback that the command line invocation of make is too
long. CROSS_COMPILE is helpful when a toolchain has a prefix of the
target triple, or is an absolute path outside of $PATH, but it's mostly
redundant for a given SRCARCH. SRCARCH itself is derived from ARCH
(normalized for a few different targets).

If CROSS_COMPILE is not set, simply set --target= for CLANG_FLAGS,
KBUILD_CFLAGS, and KBUILD_AFLAGS based on $SRCARCH.

Previously, we'd cross compile via:
$ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make LLVM=1 LLVM_IAS=1
Now:
$ ARCH=arm64 make LLVM=1 LLVM_IAS=1

For native builds (not involving cross compilation) we now explicitly
specify a target triple rather than rely on the implicit host triple.

Link: https://github.com/ClangBuiltLinux/linux/issues/1399
Suggested-by: Arnd Bergmann <arnd@kernel.org>
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes v1 -> v2:
* Fix typos in commit message as per Geert and Masahiro.
* Use SRCARCH instead of ARCH, simplifying x86 handling, as per
  Masahiro. Add his sugguested by tag.
* change commit oneline from 'drop' to 'infer.'
* Add detail about explicit host --target and relationship of ARCH to
  SRCARCH, as per Masahiro.

Changes RFC -> v1:
* Rebase onto linux-kbuild/for-next
* Keep full target triples since missing the gnueabi suffix messes up
  32b ARM. Drop Fangrui's sugguested by tag. Update commit message to
  drop references to arm64.
* Flush out TODOS.
* Add note about -EL/-EB, -m32/-m64.
* Add note to Documentation/.

 Documentation/kbuild/llvm.rst |  5 +++++
 scripts/Makefile.clang        | 34 ++++++++++++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/Documentation/kbuild/llvm.rst b/Documentation/kbuild/llvm.rst
index b18401d2ba82..80c63dd9a6d1 100644
--- a/Documentation/kbuild/llvm.rst
+++ b/Documentation/kbuild/llvm.rst
@@ -46,6 +46,11 @@ example: ::
 
 	clang --target=aarch64-linux-gnu foo.c
 
+When both ``LLVM=1`` and ``LLVM_IAS=1`` are used, ``CROSS_COMPILE`` becomes
+unnecessary and can be inferred from ``ARCH``. Example: ::
+
+	ARCH=arm64 make LLVM=1 LLVM_IAS=1
+
 LLVM Utilities
 --------------
 
diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
index 297932e973d4..956603f56724 100644
--- a/scripts/Makefile.clang
+++ b/scripts/Makefile.clang
@@ -1,6 +1,36 @@
-ifneq ($(CROSS_COMPILE),)
+# Individual arch/{arch}/Makfiles should use -EL/-EB to set intended endianness
+# and -m32/-m64 to set word size based on Kconfigs instead of relying on the
+# target triple.
+ifeq ($(CROSS_COMPILE),)
+ifneq ($(LLVM),)
+ifeq ($(LLVM_IAS),1)
+ifeq ($(SRCARCH),arm)
+CLANG_FLAGS	+= --target=arm-linux-gnueabi
+else ifeq ($(SRCARCH),arm64)
+CLANG_FLAGS	+= --target=aarch64-linux-gnu
+else ifeq ($(SRCARCH),hexagon)
+CLANG_FLAGS	+= --target=hexagon-linux-gnu
+else ifeq ($(SRCARCH),m68k)
+CLANG_FLAGS	+= --target=m68k-linux-gnu
+else ifeq ($(SRCARCH),mips)
+CLANG_FLAGS	+= --target=mipsel-linux-gnu
+else ifeq ($(SRCARCH),powerpc)
+CLANG_FLAGS	+= --target=powerpc64le-linux-gnu
+else ifeq ($(SRCARCH),riscv)
+CLANG_FLAGS	+= --target=riscv64-linux-gnu
+else ifeq ($(SRCARCH),s390)
+CLANG_FLAGS	+= --target=s390x-linux-gnu
+else ifeq ($(SRCARCH),x86)
+CLANG_FLAGS	+= --target=x86_64-linux-gnu
+else
+$(error Specify CROSS_COMPILE or add '--target=' option to scripts/Makefile.clang)
+endif # SRCARCH
+endif # LLVM_IAS
+endif # LLVM
+else
 CLANG_FLAGS	+= --target=$(notdir $(CROSS_COMPILE:%-=%))
-endif
+endif # CROSS_COMPILE
+
 ifeq ($(LLVM_IAS),1)
 CLANG_FLAGS	+= -integrated-as
 else
-- 
2.32.0.93.g670b81a890-goog

