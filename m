Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A308396924
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 22:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhEaU5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 16:57:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:37526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230032AbhEaU5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 16:57:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D208611CA;
        Mon, 31 May 2021 20:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622494521;
        bh=j5HBmshwLt3mNLRxp+fAeZPgLQ38MJJ4aZZ/b8ukD0w=;
        h=From:To:Cc:Subject:Date:From;
        b=jeIcBvqB9HEMOKDGB+Ef10RtoqyQOQXPSyi1q03+T4yfKv9i3m7SYWi4Jz7k/cPL6
         i+zNeXAFx1aTQci090Gj36gF5iXzjPf6dnoPm7CzqH3HfP2l7JKNvo+XVvf8YTfHaq
         72Wvs8tN4LvK3zrewDNxbhbYnofGmvqcBeHe4yZVNFbxh4eQ/ex1lys8XgxgZ1qsdc
         TUOzYxz3G2paUhJci7WpzOKFs5wd8/PgFWfSItv7u6qmMwCKMO8dRSp5oYdNrtOGa6
         u7MQe8L6xtmqc6edL8O8O8NJk4reJYj7M2zcx7arTR+NPp7S3T8XLuwfMoBtO6kG8/
         OSgMGBiswtI3w==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] MAINTAINERS: Add Clang CFI section
Date:   Mon, 31 May 2021 13:54:06 -0700
Message-Id: <20210531205405.67993-1-nathan@kernel.org>
X-Mailer: git-send-email 2.32.0.rc0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sami is the primary developer and Kees has been chauffeuring the patches
to Linus so ensure they are always kept in the loop about proposed
changes to these files. Add Nick and I as reviewers so we are CC'd as
well.

Fixes: cf68fffb66d6 ("add support for Clang CFI")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

Not that I really expect this code to change all that much but I
personally hate when there is no clear path for a patch to go upstream
so it makes sense to solidify this.

 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 008fcad7ac00..81a507cda338 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4436,6 +4436,18 @@ F:	include/linux/compiler-clang.h
 F:	scripts/clang-tools/
 K:	\b(?i:clang|llvm)\b
 
+CLANG CONTROL FLOW INTEGRITY SUPPORT
+M:	Sami Tolvanen <samitolvanen@google.com>
+M:	Kees Cook <keescook@chromium.org>
+R:	Nathan Chancellor <nathan@kernel.org>
+R:	Nick Desaulniers <ndesaulniers@google.com>
+L:	clang-built-linux@googlegroups.com
+S:	Supported
+B:	https://github.com/ClangBuiltLinux/linux/issues
+T:	git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/clang/features
+F:	include/linux/cfi.h
+F:	kernel/cfi.c
+
 CLEANCACHE API
 M:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
 L:	linux-kernel@vger.kernel.org

base-commit: 24845dcb170e16b3100bd49743687648c71387ae
-- 
2.32.0.rc0

