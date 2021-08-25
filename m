Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5C13F7D99
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 23:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhHYVT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 17:19:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232017AbhHYVT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 17:19:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42D9A60E77;
        Wed, 25 Aug 2021 21:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629926321;
        bh=KzK2u+qqaUwjSmbS7DwbWvoeTpLJjJxB+U2h49PaJho=;
        h=From:To:Cc:Subject:Date:From;
        b=ijzqEZ/beJ6+TnLB6pnWRj0eAfpE1GEkJZcQZE9eNYNwst+tjDt8Sdm6glj/XVKKh
         EBqVKdso6quehPYjr5CD4lfcZJu4K1H+fh7+0vphUeGTJgmh0lk/5VH3ujETP5gBMj
         +kSgm8uBd1qYg24DF755fz9Q+qjEbUs1anpYlnRBFaod+umqQqZTJlB69tj2fWWRYC
         SAPKPwhZnjo085L5T+myWMRroyDgvNSnvfDdrAkQ+mboo+UdLRLZnxCeeqX1URGU5O
         RGBOTWEHhwRKZAp9SZXcB1++9IO6OA4tQfMJ8wjuqLPRnGYEApvbAOVuqNm/rzcbEo
         yrbhSK5W/LrMA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 1/3] MAINTAINERS: Update ClangBuiltLinux mailing list
Date:   Wed, 25 Aug 2021 14:18:21 -0700
Message-Id: <20210825211823.6406-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are now at llvm@lists.linux.dev.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c6b8a720c0bc..8e36f55430de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4504,7 +4504,7 @@ F:	.clang-format
 CLANG/LLVM BUILD SUPPORT
 M:	Nathan Chancellor <nathan@kernel.org>
 M:	Nick Desaulniers <ndesaulniers@google.com>
-L:	clang-built-linux@googlegroups.com
+L:	llvm@lists.linux.dev
 S:	Supported
 W:	https://clangbuiltlinux.github.io/
 B:	https://github.com/ClangBuiltLinux/linux/issues
@@ -4519,7 +4519,7 @@ M:	Sami Tolvanen <samitolvanen@google.com>
 M:	Kees Cook <keescook@chromium.org>
 R:	Nathan Chancellor <nathan@kernel.org>
 R:	Nick Desaulniers <ndesaulniers@google.com>
-L:	clang-built-linux@googlegroups.com
+L:	llvm@lists.linux.dev
 S:	Supported
 B:	https://github.com/ClangBuiltLinux/linux/issues
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/clang/features

base-commit: e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93
-- 
2.33.0

