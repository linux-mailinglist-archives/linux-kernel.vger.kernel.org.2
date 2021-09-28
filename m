Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBA941ABFF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239959AbhI1Jgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:36:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239724AbhI1Jgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:36:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2091610E5;
        Tue, 28 Sep 2021 09:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632821701;
        bh=C25EEUziHpymaVoXyCUtu9/yeAR6P+59r636iT5bdE4=;
        h=From:To:Cc:Subject:Date:From;
        b=mSiKHiGEYpXRI79JFMg03dOw4Ju8ad8RSoLqmTxoyCxlPzHvXHtSxnBET3tjpTZm4
         eror797UKeXhgEzAF3N685Kx9ii+cF/qVreuofHrOyXSOdJagqv7jolEKIZgO0c3hm
         zeOlSfZMrz7brIBZvtLac3pr5wrwlfRtWorQz3LEGBxLSg565C8FqGHuOiLkLccMjR
         IpC4wGXMkHAu/hWOWGZorUVH6VTOFS40VfC5meMBAx7LlCz1i9ie1MFAhBmMX1Ulwi
         752117BBy0DQlOE1jWaYWBO5DSNvoBpd7VLfF1M3km2Vwu6jTC+E2bvwWSmT4mHEyF
         Zl/3fczbOEamw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Chris Down <chris@chrisdown.name>,
        John Ogness <john.ogness@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        YueHaibing <yuehaibing@huawei.com>, Jessica Yu <jeyu@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] [v2] printk: avoid -Wsometimes-uninitialized warning
Date:   Tue, 28 Sep 2021 11:34:33 +0200
Message-Id: <20210928093456.2438109-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

clang notices that the pi_get_entry() function would use
uninitialized data if it was called with a non-NULL module
pointer on a kernel that does not support modules:

kernel/printk/index.c:32:6: error: variable 'nr_entries' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
        if (!mod) {
            ^~~~
kernel/printk/index.c:38:13: note: uninitialized use occurs here
        if (pos >= nr_entries)
                   ^~~~~~~~~~
kernel/printk/index.c:32:2: note: remove the 'if' if its condition is always true
        if (!mod) {

Rework the condition to make it clear to the compiler that we are always
in the second case. Unfortunately the #ifdef is still required as the
definition of 'struct module' is hidden when modules are disabled.

Fixes: 337015573718 ("printk: Userspace format indexing support")
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
--
v2: use a simpler trick of having an 'else' in the #ifdef
    block, as Steven suggested.
---
 kernel/printk/index.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/index.c b/kernel/printk/index.c
index d3709408debe..43b45a916ff6 100644
--- a/kernel/printk/index.c
+++ b/kernel/printk/index.c
@@ -26,10 +26,9 @@ static struct pi_entry *pi_get_entry(const struct module *mod, loff_t pos)
 	if (mod) {
 		entries = mod->printk_index_start;
 		nr_entries = mod->printk_index_size;
-	}
+	} else 
 #endif
-
-	if (!mod) {
+	{
 		/* vmlinux, comes from linker symbols */
 		entries = __start_printk_index;
 		nr_entries = __stop_printk_index - __start_printk_index;
-- 
2.29.2

