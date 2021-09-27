Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE2041948F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbhI0Mv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 08:51:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234427AbhI0Mvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 08:51:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD20E61052;
        Mon, 27 Sep 2021 12:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632747012;
        bh=Mn3+/4wak9bCLKuXFHDiBxA5y8otZjMtkB/6idWI6Ys=;
        h=From:To:Cc:Subject:Date:From;
        b=LdxOEOBxib7D/G1ojHvOuzTpBfflhMVKlZ4u0YyjbyKCmn0xXyDTxJE6UYU33LjvO
         dmPCUgC2MXvr9C22wAznHUq/Wx1ec236k+IvUDH+YpVolkQUCDIYtNi9Q4aeRMi4Sj
         fSnyKZgjBVzzhqIeHVaIaqh4kwqCHFcB7BjtDjTi6N07FFk13uC2WbgOqyvmDYHYmL
         LJe+2Lrnxt7oWSQSXHgy+YzGL3vHR+L8yCn9+4BiWhMIGuqA4n9NleEa9jEILGnstU
         cJYIoyb4apYYePy39RQYts7mIB7ZX+pjg4jpWPzWWJOYSDXKGcy+SN9I4XQ/PPAwMz
         PeZZzg4kPQSSg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jessica Yu <jeyu@kernel.org>, Chris Down <chris@chrisdown.name>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] printk: avoid -Wsometimes-uninitialized warning
Date:   Mon, 27 Sep 2021 14:49:47 +0200
Message-Id: <20210927125007.1581919-1-arnd@kernel.org>
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
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/printk/index.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/index.c b/kernel/printk/index.c
index d3709408debe..b4d90bab6d4d 100644
--- a/kernel/printk/index.c
+++ b/kernel/printk/index.c
@@ -22,14 +22,12 @@ static struct pi_entry *pi_get_entry(const struct module *mod, loff_t pos)
 	struct pi_entry **entries;
 	unsigned int nr_entries;
 
+	if (IS_ENABLED(CONFIG_MODULES) && mod) {
 #ifdef CONFIG_MODULES
-	if (mod) {
 		entries = mod->printk_index_start;
 		nr_entries = mod->printk_index_size;
-	}
 #endif
-
-	if (!mod) {
+	} else {
 		/* vmlinux, comes from linker symbols */
 		entries = __start_printk_index;
 		nr_entries = __stop_printk_index - __start_printk_index;
-- 
2.29.2

