Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A56C396931
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 23:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhEaVIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 17:08:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230032AbhEaVIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 17:08:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74801610C8;
        Mon, 31 May 2021 21:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622495201;
        bh=ScI5+s0yDN2M7yJJsUBvqOK9XVBhxsJd1eVpnKyFbiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h13i/CFKF8x1V25adYfIyZzkmfaRavVh0EVEKCoWbgl5BLhsUx07BTKjMNqee/Hlz
         xkWHadFantp+ZhdEUfF18EKwU6AH5ukH0GkahP/QrAA5NX4Cm313olWTik6n4l6ufl
         rspj7X7hr9ptvZZJGMfK4zykvEsOYGE8VStqQlN/plZYM+8w1shMV+pJQjGkSXt+aL
         66uztX1j7eMYUH0HiFZCpe9Pgy7+MDenTtWaV7IxccFYzXX4lCA2ApvZ9sFlE5eytW
         R3OaOJJ5OifOHJGf2aX1IHloYYrEy9uyiWnuO0B5EcNGyZscWOd+FaYTsadSxebsaK
         Z664D670ApnsQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2] MAINTAINERS: Add Clang CFI section
Date:   Mon, 31 May 2021 14:06:30 -0700
Message-Id: <20210531210629.864888-1-nathan@kernel.org>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210531205405.67993-1-nathan@kernel.org>
References: <20210531205405.67993-1-nathan@kernel.org>
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

v1 -> v2:

* Add "git " in front of the "T:" entry to match the rest of MAINTAINERS

 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 008fcad7ac00..4ddf370572d3 100644
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
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/clang/features
+F:	include/linux/cfi.h
+F:	kernel/cfi.c
+
 CLEANCACHE API
 M:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
 L:	linux-kernel@vger.kernel.org

base-commit: 24845dcb170e16b3100bd49743687648c71387ae
-- 
2.32.0.rc0

