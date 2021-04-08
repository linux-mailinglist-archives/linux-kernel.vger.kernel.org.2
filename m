Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824423583D9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhDHMwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:52:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231784AbhDHMw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:52:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0E8F61154;
        Thu,  8 Apr 2021 12:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617886338;
        bh=piulwOfs3Q/htdTQUT7rT3NxVXw4xuOw7TR5dbSr4uM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fO5didSKLOZkWUJaL3eC6sBtY+PHzj5yUFB4k/dl5QDmXUkmrvuAjmtYEJxXPDMAm
         heA/kOEKvZSkABzKjYYqjCs5UPQGD8aFpBxTwQCbbwETkI0evETnSAqmlHd6UogA1+
         R9pzX2czuXIM9vvggraSLYEwhgNJWfcUD2jLsTcg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 09/13] tty: move some internal tty lock enums and functions out of tty.h
Date:   Thu,  8 Apr 2021 14:51:30 +0200
Message-Id: <20210408125134.3016837-10-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
References: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the TTY_LOCK_* enums and tty_ldisc lock functions out of the global
tty.h into the local header file to clean things up.

Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/tty.h        | 26 ++++++++++++++++++++++++++
 drivers/tty/tty_buffer.c |  2 +-
 drivers/tty/tty_mutex.c  |  1 +
 include/linux/tty.h      | 26 --------------------------
 4 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/tty.h b/drivers/tty/tty.h
index a8a7abe5d635..ff904e947483 100644
--- a/drivers/tty/tty.h
+++ b/drivers/tty/tty.h
@@ -6,6 +6,32 @@
 #ifndef _TTY_INTERNAL_H
 #define _TTY_INTERNAL_H
 
+/*
+ * Lock subclasses for tty locks
+ *
+ * TTY_LOCK_NORMAL is for normal ttys and master ptys.
+ * TTY_LOCK_SLAVE is for slave ptys only.
+ *
+ * Lock subclasses are necessary for handling nested locking with pty pairs.
+ * tty locks which use nested locking:
+ *
+ * legacy_mutex - Nested tty locks are necessary for releasing pty pairs.
+ *		  The stable lock order is master pty first, then slave pty.
+ * termios_rwsem - The stable lock order is tty_buffer lock->termios_rwsem.
+ *		   Subclassing this lock enables the slave pty to hold its
+ *		   termios_rwsem when claiming the master tty_buffer lock.
+ * tty_buffer lock - slave ptys can claim nested buffer lock when handling
+ *		     signal chars. The stable lock order is slave pty, then
+ *		     master.
+ */
+enum {
+	TTY_LOCK_NORMAL = 0,
+	TTY_LOCK_SLAVE,
+};
+
+int tty_ldisc_lock(struct tty_struct *tty, unsigned long timeout);
+void tty_ldisc_unlock(struct tty_struct *tty);
+
 /* tty_audit.c */
 #ifdef CONFIG_AUDIT
 void tty_audit_add_data(struct tty_struct *tty, const void *data, size_t size);
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 6d4995a5f318..9733469a14b2 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -17,7 +17,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/ratelimit.h>
-
+#include "tty.h"
 
 #define MIN_TTYB_SIZE	256
 #define TTYB_ALIGN_MASK	255
diff --git a/drivers/tty/tty_mutex.c b/drivers/tty/tty_mutex.c
index 2640635ee177..393518a24cfe 100644
--- a/drivers/tty/tty_mutex.c
+++ b/drivers/tty/tty_mutex.c
@@ -4,6 +4,7 @@
 #include <linux/kallsyms.h>
 #include <linux/semaphore.h>
 #include <linux/sched.h>
+#include "tty.h"
 
 /* Legacy tty mutex glue */
 
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 981ee31c58e1..4b21d47bc098 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -16,30 +16,6 @@
 #include <linux/llist.h>
 
 
-/*
- * Lock subclasses for tty locks
- *
- * TTY_LOCK_NORMAL is for normal ttys and master ptys.
- * TTY_LOCK_SLAVE is for slave ptys only.
- *
- * Lock subclasses are necessary for handling nested locking with pty pairs.
- * tty locks which use nested locking:
- *
- * legacy_mutex - Nested tty locks are necessary for releasing pty pairs.
- *		  The stable lock order is master pty first, then slave pty.
- * termios_rwsem - The stable lock order is tty_buffer lock->termios_rwsem.
- *		   Subclassing this lock enables the slave pty to hold its
- *		   termios_rwsem when claiming the master tty_buffer lock.
- * tty_buffer lock - slave ptys can claim nested buffer lock when handling
- *		     signal chars. The stable lock order is slave pty, then
- *		     master.
- */
-
-enum {
-	TTY_LOCK_NORMAL = 0,
-	TTY_LOCK_SLAVE,
-};
-
 /*
  * (Note: the *_driver.minor_start values 1, 64, 128, 192 are
  * hardcoded at present.)
@@ -419,8 +395,6 @@ extern struct tty_struct *tty_kopen_exclusive(dev_t device);
 extern struct tty_struct *tty_kopen_shared(dev_t device);
 extern void tty_kclose(struct tty_struct *tty);
 extern int tty_dev_name_to_number(const char *name, dev_t *number);
-extern int tty_ldisc_lock(struct tty_struct *tty, unsigned long timeout);
-extern void tty_ldisc_unlock(struct tty_struct *tty);
 extern ssize_t redirected_tty_write(struct kiocb *, struct iov_iter *);
 extern struct file *tty_release_redirect(struct tty_struct *tty);
 #else
-- 
2.31.1

