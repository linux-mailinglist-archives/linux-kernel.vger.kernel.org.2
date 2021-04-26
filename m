Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB7836BABF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 22:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241600AbhDZUgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 16:36:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235996AbhDZUgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 16:36:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E89D1601FC;
        Mon, 26 Apr 2021 20:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619469336;
        bh=dWUS68fI1Cq65yaAuW1711yZzsjTCGo01+dzI5wZyOg=;
        h=From:To:Cc:Subject:Date:From;
        b=JZKpcTWIGHvo2ju0xvHbAMfO5KD+YY7U0Ui2tsf0R8vzyMCIIX4Es+MJ/kJu3w4sQ
         hEBHl4Hir0hPig9Yd6IFN/QA8hi47gloUMqvjkMg8RNUSuIcJnwQReMWBsJ2MRC/t7
         hs5aKoR7KFQTl/8p43SZ/goygTlKXmI67ojsC1OSth5uJ+13flim6wBCM4BgwwE8u4
         t7Qa59jYacCAtUZTSHUGS2y0CDeuGPuV9N3HZ0r49JE/HZdxDXo50zf/ypLQjwX31l
         YGLCzjzY6pVmvSKGzx4aFzxoScRtAcEbHUwok6qArwK1TbFvYwoy+vznqZroQ9XmPh
         h2PBbdE72lW/g==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] powerpc: Avoid clang uninitialized warning in __get_user_size_allowed
Date:   Mon, 26 Apr 2021 13:35:18 -0700
Message-Id: <20210426203518.981550-1-nathan@kernel.org>
X-Mailer: git-send-email 2.31.1.362.g311531c9de
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9975f852ce1b ("powerpc/uaccess: Remove calls to __get_user_bad()
and __put_user_bad()") switch to BUILD_BUG() in the default case, which
leaves x uninitialized. This will not be an issue because the build will
be broken in that case but clang does static analysis before it realizes
the default case will be done so it warns about x being uninitialized
(trimmed for brevity):

 In file included from mm/mprotect.c:13:
 In file included from ./include/linux/hugetlb.h:28:
 In file included from ./include/linux/mempolicy.h:16:
 ./include/linux/pagemap.h:772:16: warning: variable '__gu_val' is used
 uninitialized whenever switch default is taken [-Wsometimes-uninitialized]
                 if (unlikely(__get_user(c, uaddr) != 0))
                              ^~~~~~~~~~~~~~~~~~~~
 ./arch/powerpc/include/asm/uaccess.h:266:2: note: expanded from macro '__get_user'
         __get_user_size_allowed(__gu_val, __gu_addr, __gu_size, __gu_err);      \
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 ./arch/powerpc/include/asm/uaccess.h:235:2: note: expanded from macro
 '__get_user_size_allowed'
        default: BUILD_BUG();                                   \
        ^~~~~~~

Commit 5cd29b1fd3e8 ("powerpc/uaccess: Use asm goto for get_user when
compiler supports it") added an initialization for x because of the same
reason. Do the same thing here so there is no warning across all
versions of clang.

Link: https://github.com/ClangBuiltLinux/linux/issues/1359
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/powerpc/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index a4e791bcd3fe..a09e4240c5b1 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -232,7 +232,7 @@ do {								\
 	case 2: __get_user_asm(x, (u16 __user *)ptr, retval, "lhz"); break;	\
 	case 4: __get_user_asm(x, (u32 __user *)ptr, retval, "lwz"); break;	\
 	case 8: __get_user_asm2(x, (u64 __user *)ptr, retval);  break;	\
-	default: BUILD_BUG();					\
+	default: x = 0; BUILD_BUG();				\
 	}							\
 } while (0)
 

base-commit: ee6b25fa7c037e42cc5f3b5c024b2a779edab6dd
-- 
2.31.1.362.g311531c9de

