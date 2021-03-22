Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25269345206
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 22:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCVVui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 17:50:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229467AbhCVVuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 17:50:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6864619A3;
        Mon, 22 Mar 2021 21:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616449810;
        bh=kXIKly4tZYQVuwd+3BpHcBsCSfm7/1M3LxzZllM8rXg=;
        h=From:To:Cc:Subject:Date:From;
        b=cMt+7qQe84KlJyfvT1fhd6a7E0bUco+56VgGUjja+j0UcqTS6Id58qTDELwfvuHr5
         Q/AJdK5LRIYs2nTp7KGW4vYkAsFnufELpKGlOe7qnAxwUHLP0PlNk1qS5at+rYDzgJ
         pkx7ha1dvpwFCnzB5Ix+HYilsiEaxC1RLVbK730ydMnIzwmnm3fGwLAKUb/i7MOnmp
         qRclC6vQ3iGVSqS0XwrFwwYXx4oSHqvp7x+eQxEXXZFAY9H+cmXkzcJt11nneboPN1
         T5t6cIls9UfwaE5KCiTSBZ5H0wutuTItgtGhpAeWqeiiP+VyiKcL/JzIA69qlj//3z
         xksU3fvLFljAA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ftrace: shut up -Wcast-function-type warning for ftrace_ops_no_ops
Date:   Mon, 22 Mar 2021 22:49:58 +0100
Message-Id: <20210322215006.1028517-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

With 'make W=1', gcc warns about casts between incompatible function
types:

kernel/trace/ftrace.c:128:31: error: cast between incompatible function types from 'void (*)(long unsigned int,  long unsigned int)' to 'void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *, struct ftrace_regs *)' [-Werror=cast-function-type]
  128 | #define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
      |                               ^

As the commet here explains, this one was intentional, so shut up the
warning harder by using a double cast.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4d8e35575549..d8fc87a17421 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -125,7 +125,7 @@ static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 #else
 /* See comment below, where ftrace_ops_list_func is defined */
 static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip);
-#define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
+#define ftrace_ops_list_func ((ftrace_func_t)(void *)ftrace_ops_no_ops)
 #endif
 
 static inline void ftrace_ops_init(struct ftrace_ops *ops)
-- 
2.29.2

