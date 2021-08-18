Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED123EF80D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 04:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbhHRCYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 22:24:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236663AbhHRCYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 22:24:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4BEC6103A;
        Wed, 18 Aug 2021 02:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629253430;
        bh=1DuFOn+0bqnQNfOj9HOqtlzhTzMm2SFrLK1tRs8HL0s=;
        h=From:To:Cc:Subject:Date:From;
        b=tfCJtlcSJvko9M0HIS8syEt/0Dwn9pVQgbjAGTTcrcVNceS7Xahag5ET9oc1l8EJ1
         DDozWyDBtBkBR1AKSsfghWaaWCFljnneKDY793WYNNqGldzsRcXLTyE1XBUsBuBAOd
         GBkwDLCtDjXILANDA+2rDYa3GjR3bv1HepMpb5WjloLkiZtoQL9tacuqULz31yhDRW
         tWkukFhdF9CRp1aYtTay76eTpCQ9VavQm9jEIfXgYboLt6dmvEsSyIFNNC2Yu8cl3D
         Gyp5CnbH7jxjnjIAvGK/LJ/e8sSlCEXSJvpp+ZmetA7VNfqaGX7fRquZiLcXT8dr5U
         a3m2O9yeYGhPQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] MAINTAINERS: Update ClangBuiltLinux IRC chat
Date:   Tue, 17 Aug 2021 19:23:39 -0700
Message-Id: <20210818022339.3863058-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone has moved from Freenode to Libera so updated the channel entry
for MAINTAINERS.

Link: https://github.com/ClangBuiltLinux/linux/issues/1402
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd25e4ecf0b9..b68f04755b2e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4498,7 +4498,7 @@ L:	clang-built-linux@googlegroups.com
 S:	Supported
 W:	https://clangbuiltlinux.github.io/
 B:	https://github.com/ClangBuiltLinux/linux/issues
-C:	irc://chat.freenode.net/clangbuiltlinux
+C:	irc://irc.libera.chat/clangbuiltlinux
 F:	Documentation/kbuild/llvm.rst
 F:	include/linux/compiler-clang.h
 F:	scripts/clang-tools/

base-commit: 7c60610d476766e128cc4284bb6349732cbd6606
-- 
2.33.0

