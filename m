Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A8C333CB9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 13:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhCJMiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 07:38:06 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:17847 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhCJMhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 07:37:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1615379862; x=1646915862;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=iEdO6aDK+d2ggtmjtN5vrB2R3azyV6RNB/OSwmPdlno=;
  b=jueL9wBEoM5EjgmoutIILIg8KJYFUYfXX/ZB30c2TUHe6alHngb+Eff2
   u0HuC6I3F3O3JWpVfYxCfV+xi938/eh2ZdKBjLgY9Yw8ntCTHiigPQTBI
   riYGViBRTmea9J9TJpHFvO1yRjqtiwshC5rU2ZX9vlW8IbAUyvLMUb+ag
   M=;
X-IronPort-AV: E=Sophos;i="5.81,237,1610409600"; 
   d="scan'208";a="97494826"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 10 Mar 2021 12:37:33 +0000
Received: from EX13D02EUB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id 15996220B75;
        Wed, 10 Mar 2021 12:37:32 +0000 (UTC)
Received: from u2196cf9297dc59.ant.amazon.com (10.43.160.207) by
 EX13D02EUB001.ant.amazon.com (10.43.166.150) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 10 Mar 2021 12:37:24 +0000
From:   Filippo Sironi <sironi@amazon.de>
To:     <linux-kernel@vger.kernel.org>
CC:     <dwmw@amazon.co.uk>, <christian.brauner@ubuntu.com>,
        <akpm@linux-foundation.org>, <ebiederm@xmission.com>,
        <peterz@infradead.org>, <keescook@chromium.org>,
        <krisman@collabora.com>, <peterx@redhat.com>, <axboe@kernel.dk>,
        <surenb@google.com>, <shakeelb@google.com>, <guro@fb.com>,
        <elver@google.com>, Filippo Sironi <sironi@amazon.de>
Subject: [RFC PATCH] mm: fork: Prevent a NULL deref by getting mm only if the refcount isn't 0
Date:   Wed, 10 Mar 2021 13:37:02 +0100
Message-ID: <20210310123703.27894-1-sironi@amazon.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.207]
X-ClientProxiedBy: EX13D29UWC004.ant.amazon.com (10.43.162.25) To
 EX13D02EUB001.ant.amazon.com (10.43.166.150)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've seen a number of crashes with the following signature:

    BUG: kernel NULL pointer dereference, address: 0000000000000000
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page
    ...
    Oops: 0000 [#1] SMP PTI
    ...
    RIP: 0010:__rb_erase_color+0xc2/0x260
    ...
    Call Trace:
     unlink_file_vma+0x36/0x50
     free_pgtables+0x62/0x110
     exit_mmap+0xd5/0x160
     ? put_dec+0x3a/0x90
     ? num_to_str+0xa8/0xc0
     mmput+0x11/0xb0
     do_task_stat+0x940/0xc80
     proc_single_show+0x49/0x80
     ? __check_object_size+0xcc/0x1a0
     seq_read+0xd3/0x400
     vfs_read+0x72/0xb0
     ksys_read+0x9c/0xd0
     do_syscall_64+0x69/0x400
     ? schedule+0x2a/0x90
     entry_SYSCALL_64_after_hwframe+0x44/0xa9
    ...

This happens when a process goes through the tasks stats in procfs while
another is exiting.  This looks like a race where the process that's
exiting drops the last reference on the mm (with mmput) while the other
increases it (with mmget).  By only increasing when the reference isn't
0 to begin with, we prevent this from happening.

Signed-off-by: Filippo Sironi <sironi@amazon.de>
---
 kernel/fork.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index d3171e8e88e5..a7541a85e5a9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1209,10 +1209,8 @@ struct mm_struct *get_task_mm(struct task_struct *task)
 	task_lock(task);
 	mm = task->mm;
 	if (mm) {
-		if (task->flags & PF_KTHREAD)
+		if (task->flags & PF_KTHREAD || !mmget_not_zero(mm))
 			mm = NULL;
-		else
-			mmget(mm);
 	}
 	task_unlock(task);
 	return mm;
-- 
2.17.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



