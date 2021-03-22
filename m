Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A75B34403B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhCVLz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:55:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229692AbhCVLzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:55:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A656E61990;
        Mon, 22 Mar 2021 11:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616414136;
        bh=tXQ2qryOXzcB4s2UYJeUT+ESxm2JHWqIVLxP9U3OzYU=;
        h=From:To:Cc:Subject:Date:From;
        b=AdWbRjGjFTPVXIuLdz6qxx5BQzVrbYIkcN6RiR6KDjOsY3hd76xJyODGw2tEYRBFZ
         JbJJEwkjdIRPevpt5q2bK+0RCj3zAPhNXZfGPZeK1OrmAIxdI2iwBMEy12QpGY0GpU
         jMaPlIVUt50DGueQu1+eYOBq47vwfkoIvQdE2xUFuOZdej22poxMf18+1rbVE6RqZT
         uA++0DAeUjTFt24jjNE7k6VOcBr8wYazdPNUBGMZSx47Wt9BEPr/LSBbr7vIVdUEU+
         gt0MICVqjfJR97sC3ZW5wNlz54Fy5mk49WXSOgl8XdSkTaT6yRfmM+0wLYJ7vZi0YU
         3QGntNb1NPirA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] lockdep: address clang -Wformat warning printing for %hd
Date:   Mon, 22 Mar 2021 12:55:25 +0100
Message-Id: <20210322115531.3987555-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Clang doesn't like format strings that truncate a 32-bit
value to something shorter:

kernel/locking/lockdep.c:709:4: error: format specifies type 'short' but the argument has type 'int' [-Werror,-Wformat]

In this case, the warning is a slightly questionable, as it could realize
that both class->wait_type_outer and class->wait_type_inner are in fact
8-bit struct members, even though the result of the ?: operator becomes an
'int'.

However, there is really no point in printing the number as a 16-bit
'short' rather than either an 8-bit or 32-bit number, so just change
it to a normal %d.

Fixes: de8f5e4f2dc1 ("lockdep: Introduce wait-type checks")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/locking/lockdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 70bf3e48eae3..bb3b0bc6ee17 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -705,7 +705,7 @@ static void print_lock_name(struct lock_class *class)
 
 	printk(KERN_CONT " (");
 	__print_lock_name(class);
-	printk(KERN_CONT "){%s}-{%hd:%hd}", usage,
+	printk(KERN_CONT "){%s}-{%d:%d}", usage,
 			class->wait_type_outer ?: class->wait_type_inner,
 			class->wait_type_inner);
 }
-- 
2.29.2

