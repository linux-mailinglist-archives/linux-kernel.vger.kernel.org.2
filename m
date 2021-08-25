Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83333F7D9A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 23:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbhHYVTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 17:19:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232017AbhHYVTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 17:19:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B08C9610CA;
        Wed, 25 Aug 2021 21:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629926324;
        bh=dY6ehSPQvcX5ZMO0zHR/lS3tO6Knhey2PG8PCVrE5n8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fw+wBESN1qQUgJ2OAqOiLhC5UfZf5KDQIqEIvF+Ccxn8a7D9S2Dr4zL2wp93kXRD0
         9CJmMEsMoTKnZ2J+EIde78knxHrMBFG2gBXoni5Jhfx9lM1Ksbxc8wjoCH3E9s8xaH
         KjD84rBmXRE2s3KTGlLZYItM7+kchq+v3bhzPtY9dygLB//iRGdxxcB2Ys+g6gs0/W
         Z4ApxYMVVSuoCpBOdGAFM/r2G9gNoUO8ty1ANLgLuz5+Qg1HJpGWJJ3g9xA5YF4cFW
         +ggJugvUGWscrqWkxnNmMHaG+KOIu6UVpsyinrs/FviVqGYIbqTt4fzW9nR6W90l6X
         lV/fePu1FtAcw==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 2/3] Documentation/llvm: Update mailing list
Date:   Wed, 25 Aug 2021 14:18:22 -0700
Message-Id: <20210825211823.6406-2-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210825211823.6406-1-nathan@kernel.org>
References: <20210825211823.6406-1-nathan@kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are now at llvm@lists.linux.dev.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 Documentation/kbuild/llvm.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/kbuild/llvm.rst b/Documentation/kbuild/llvm.rst
index b18401d2ba82..06b8f826e1a3 100644
--- a/Documentation/kbuild/llvm.rst
+++ b/Documentation/kbuild/llvm.rst
@@ -111,7 +111,8 @@ Getting Help
 ------------
 
 - `Website <https://clangbuiltlinux.github.io/>`_
-- `Mailing List <https://groups.google.com/forum/#!forum/clang-built-linux>`_: <clang-built-linux@googlegroups.com>
+- `Mailing List <https://lore.kernel.org/llvm/>`_: <llvm@lists.linux.dev>
+- `Old Mailing List Archives <https://groups.google.com/g/clang-built-linux>`_
 - `Issue Tracker <https://github.com/ClangBuiltLinux/linux/issues>`_
 - IRC: #clangbuiltlinux on chat.freenode.net
 - `Telegram <https://t.me/ClangBuiltLinux>`_: @ClangBuiltLinux
-- 
2.33.0

