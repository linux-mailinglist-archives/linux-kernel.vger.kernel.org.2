Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC0D3F25EB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 06:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhHTEfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 00:35:12 -0400
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:41419 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229457AbhHTEfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 00:35:12 -0400
Received: from MTA-12-4.privateemail.com (mta-12-1.privateemail.com [198.54.122.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 4E1C7800C0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 00:34:34 -0400 (EDT)
Received: from mta-12.privateemail.com (localhost [127.0.0.1])
        by mta-12.privateemail.com (Postfix) with ESMTP id 57B3418000B2;
        Fri, 20 Aug 2021 00:34:33 -0400 (EDT)
Received: from localhost.localdomain (unknown [10.20.151.223])
        by mta-12.privateemail.com (Postfix) with ESMTPA id 0EA4B18000B0;
        Fri, 20 Aug 2021 00:34:31 -0400 (EDT)
From:   Jordy Zomer <jordy@pwning.systems>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Jordy Zomer <jordy@pwning.systems>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH] mm/secretmem: use refcount_t instead of atomic_t
Date:   Fri, 20 Aug 2021 06:33:38 +0200
Message-Id: <20210820043339.2151352-1-jordy@pwning.systems>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a secret memory region is active, memfd_secret disables
hibernation. One of the goals is to keep the secret data from being
written to persistent-storage.

It accomplishes this by maintaining a reference count to
`secretmem_users`. Once this reference is held your system can not be
hibernated due to the check in `hibernation_available()`. However,
because `secretmem_users` is of type `atomic_t`, reference counter
overflows are possible.

As you can see there's an `atomic_inc` for each `memfd` that is opened
in the `memfd_secret` syscall. If a local attacker succeeds to open 2^32
memfd's, the counter will wrap around to 0. This implies that you may
hibernate again, even though there are still regions of this secret
memory, thereby bypassing the security check.

In an attempt to fix this I have used `refcount_t` instead of `atomic_t`
which prevents reference counter overflows.

Signed-off-by: Jordy Zomer <jordy@pwning.systems>
---
 mm/secretmem.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 030f02ddc7c1..1fea68b8d5a6 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -18,6 +18,7 @@
 #include <linux/secretmem.h>
 #include <linux/set_memory.h>
 #include <linux/sched/signal.h>
+#include <linux/refcount.h>
 
 #include <uapi/linux/magic.h>
 
@@ -40,11 +41,11 @@ module_param_named(enable, secretmem_enable, bool, 0400);
 MODULE_PARM_DESC(secretmem_enable,
 		 "Enable secretmem and memfd_secret(2) system call");
 
-static atomic_t secretmem_users;
+static refcount_t secretmem_users;
 
 bool secretmem_active(void)
 {
-	return !!atomic_read(&secretmem_users);
+	return !!refcount_read(&secretmem_users);
 }
 
 static vm_fault_t secretmem_fault(struct vm_fault *vmf)
@@ -103,7 +104,7 @@ static const struct vm_operations_struct secretmem_vm_ops = {
 
 static int secretmem_release(struct inode *inode, struct file *file)
 {
-	atomic_dec(&secretmem_users);
+	refcount_dec(&secretmem_users);
 	return 0;
 }
 
@@ -217,7 +218,7 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
 	file->f_flags |= O_LARGEFILE;
 
 	fd_install(fd, file);
-	atomic_inc(&secretmem_users);
+	refcount_inc(&secretmem_users);
 	return fd;
 
 err_put_fd:
-- 
2.27.0

