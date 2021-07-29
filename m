Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16E83DA970
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhG2Qu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbhG2Qu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 12:50:56 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5334AC061796
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:50:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t101-20020a25aaee0000b0290578c0c455b2so7258855ybi.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ylYcXn1I/C5/EruhE/ifxy8Gri68DuJqkeFXLL+fN5g=;
        b=BBNZEUxpdzDxN9t94KfFCjGR9iBMGkTi9PWw5nc21I4mNwBZYd8Z8FRexA4+M3bg5u
         xrCl6OCU/lEKjcDgE8E7CCAubEAgYKQe6wN6kJ8VsdkNb6d00t0sQcH+5prrqs9gMgUz
         czk8i3RDwmA5po52czoCd3Z5w+1AehgoupP+ghAd/mEUoBSPKMkdYvsSH2YaTgmcgFBA
         am5V/96qHqqWxtsywwMJX5of9IxBXj9POlRjx29oeimRVL6TiugEJgTKpwIrFdWaGzGp
         Trv/NAPHPQnaeXTaPC40WU7qHI7DYAUoA6cUpSQguqi4Rq8uurvPrR0G1YJ+8wKr7UvZ
         zWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ylYcXn1I/C5/EruhE/ifxy8Gri68DuJqkeFXLL+fN5g=;
        b=DrxUfBHkGX7Xfn4nri6KJm/pKYXSydsRVSJN0o2Y6kJLHBtKNspaF2mu8yXgqfkpVb
         dX6grXzlMEcKDLqm6MJfjGGLvykdfvMneUmvf/cA1xdM8XZM9DK+YpOTmGZr6qEU3/XQ
         XfhLGnCQzWzXfK3WkE1XR20vhrYi6oMRCPi4X1ilx+um/xBR2tWi60llNJI+M/raI/pL
         yPjVJZqFNt1U+ZihmXbzzfyQ0zbjaHno20SOruS7nm6uJP+BC0UswVI2MMKH8928cEVR
         P4lzl4SDPCZY/aE9dE3EQlL+Cl4dD10FnASCBd5B+EADrqmNaV36AJOwVt7mNVJ0ISfA
         5ytQ==
X-Gm-Message-State: AOAM531I9HLY0jcsPAnj/XrHublqgGcQUUXh4fYPWYR63uUJOQf5I7o0
        2J8lomczeOHC4swwJpQnGFODs2fIYMrFiPJ1Dmw=
X-Google-Smtp-Source: ABdhPJwI/00H9XAupr++60gtOSPMpO6+vqnsx3bZt7qMIMWSb4tBxazgKfnF1xTZ7YyUePGOkKozBKiJufZbKb41dFY=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:8132:32f4:cf29:1268])
 (user=ndesaulniers job=sendgmr) by 2002:a25:31c5:: with SMTP id
 x188mr7825846ybx.185.1627577448502; Thu, 29 Jul 2021 09:50:48 -0700 (PDT)
Date:   Thu, 29 Jul 2021 09:50:39 -0700
In-Reply-To: <20210729165039.23896-1-ndesaulniers@google.com>
Message-Id: <20210729165039.23896-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210729165039.23896-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 2/2] Makefile: infer CROSS_COMPILE from SRCARCH for
 CC=clang LLVM_IAS=1
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
Changes v2 -> v3:
* Drop check/requirement for LLVM=1, as per Masahiro.
* Change oneliner from LLVM=1 LLVM_IAS=1 to CC=clang LLVM_IAS=1.
* Don't carry forward Nathan's RB/TB tags. :( Sorry Nathan, but thank
  you for testing+reviewing v2.
* Update wording of docs slightly.

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

 Documentation/kbuild/llvm.rst |  6 ++++++
 scripts/Makefile.clang        | 32 ++++++++++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/kbuild/llvm.rst b/Documentation/kbuild/llvm.rst
index b18401d2ba82..aef1587fc09b 100644
--- a/Documentation/kbuild/llvm.rst
+++ b/Documentation/kbuild/llvm.rst
@@ -46,6 +46,12 @@ example: ::
 
 	clang --target=aarch64-linux-gnu foo.c
 
+When both ``CC=clang`` (set via ``LLVM=1``) and ``LLVM_IAS=1`` are used,
+``CROSS_COMPILE`` becomes unnecessary and can be inferred from ``ARCH``.
+Example: ::
+
+	ARCH=arm64 make LLVM=1 LLVM_IAS=1
+
 LLVM Utilities
 --------------
 
diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
index 297932e973d4..a1b46811bdc6 100644
--- a/scripts/Makefile.clang
+++ b/scripts/Makefile.clang
@@ -1,6 +1,34 @@
-ifneq ($(CROSS_COMPILE),)
+# Individual arch/{arch}/Makfiles should use -EL/-EB to set intended endianness
+# and -m32/-m64 to set word size based on Kconfigs instead of relying on the
+# target triple.
+ifeq ($(CROSS_COMPILE),)
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
+else
 CLANG_FLAGS	+= --target=$(notdir $(CROSS_COMPILE:%-=%))
-endif
+endif # CROSS_COMPILE
+
 ifeq ($(LLVM_IAS),1)
 CLANG_FLAGS	+= -integrated-as
 else
-- 
2.32.0.432.gabb21c7263-goog

