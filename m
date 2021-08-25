Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AE33F7D9C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 23:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbhHYVTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 17:19:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234224AbhHYVTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 17:19:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF668610CB;
        Wed, 25 Aug 2021 21:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629926327;
        bh=wUO6p5vjJOLqGlIsoKDDeG3mUuzZMCt3eI8cwxSaPlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RPAfDw/9TFXzzRAHGo5fFgUSX2nI7aovTjQ01kSMWV29fEqAGomONOclW5K6EIvwd
         akg2AB2UX8G+Aj6cKf0yeMjGekS1dlSJ+8tJY84JZ8QywzCFk8yItnvHlMqHwBhfPY
         5Bt2Kc8St042OSjp2gPbS3XYeaIVcOaEUgz+2r8rKtJ9L65TzfBzzRlkHVzM51ySng
         WpJfqAxYeyNgv0qHBR8aEdQf8eeBk0NNjNMFQ+7IhDdMXhvSovKr6jWofuQCPzoQmZ
         AIhTEKk9CGPIoatnzxVfj6/sd4vsoz9ftuAHnlg6iEKypXwWuxsksTQnXE5y/Tawvf
         OHQBTbQBAgAwA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 3/3] Documentation/llvm: Update IRC location
Date:   Wed, 25 Aug 2021 14:18:23 -0700
Message-Id: <20210825211823.6406-3-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210825211823.6406-1-nathan@kernel.org>
References: <20210825211823.6406-1-nathan@kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should have been done with commit 91ed3ed0f798 ("MAINTAINERS:
update ClangBuiltLinux IRC chat") but I did not realize it was in two
separate spots.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 Documentation/kbuild/llvm.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/kbuild/llvm.rst b/Documentation/kbuild/llvm.rst
index 06b8f826e1a3..683f8b7cca0b 100644
--- a/Documentation/kbuild/llvm.rst
+++ b/Documentation/kbuild/llvm.rst
@@ -114,7 +114,7 @@ Getting Help
 - `Mailing List <https://lore.kernel.org/llvm/>`_: <llvm@lists.linux.dev>
 - `Old Mailing List Archives <https://groups.google.com/g/clang-built-linux>`_
 - `Issue Tracker <https://github.com/ClangBuiltLinux/linux/issues>`_
-- IRC: #clangbuiltlinux on chat.freenode.net
+- IRC: #clangbuiltlinux on irc.libera.chat
 - `Telegram <https://t.me/ClangBuiltLinux>`_: @ClangBuiltLinux
 - `Wiki <https://github.com/ClangBuiltLinux/linux/wiki>`_
 - `Beginner Bugs <https://github.com/ClangBuiltLinux/linux/issues?q=is%3Aopen+is%3Aissue+label%3A%22good+first+issue%22>`_
-- 
2.33.0

