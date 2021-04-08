Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607F93583C0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhDHMwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:52:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231650AbhDHMwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:52:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CD5661105;
        Thu,  8 Apr 2021 12:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617886312;
        bh=bEar2ldeNJ2WSZ5Gwxgo5kAdDvRSPn09fM1dSSCO9G0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pMOF48X1QM0sABiITreQM2iEP0zd7vVusn1y9zmpq+txDIjWcX2WYFT1tNxl8bwnr
         mLPhBMOlzhvqsmq5iT58WxY5V357ozgktJR3WBuDv0DtnLNsEB/N2saWPNd7lNzBJM
         6d+WDi2R/WojVKqHB+4aKqNKAXUYQIkr0k4W6SYo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 11/13] tty: move some tty-only functions to drivers/tty/tty.h
Date:   Thu,  8 Apr 2021 14:51:32 +0200
Message-Id: <20210408125134.3016837-12-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
References: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flow change and restricted_tty_write() logic is internal to the tty
core only, so move it out of the include/linux/tty.h file.

Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/tty.h       | 17 +++++++++++++++++
 drivers/tty/tty_ioctl.c |  1 +
 include/linux/tty.h     | 16 ----------------
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/tty.h b/drivers/tty/tty.h
index ff904e947483..b0d78bfdbd8c 100644
--- a/drivers/tty/tty.h
+++ b/drivers/tty/tty.h
@@ -29,6 +29,21 @@ enum {
 	TTY_LOCK_SLAVE,
 };
 
+/* Values for tty->flow_change */
+#define TTY_THROTTLE_SAFE	1
+#define TTY_UNTHROTTLE_SAFE	2
+
+static inline void __tty_set_flow_change(struct tty_struct *tty, int val)
+{
+	tty->flow_change = val;
+}
+
+static inline void tty_set_flow_change(struct tty_struct *tty, int val)
+{
+	tty->flow_change = val;
+	smp_mb();
+}
+
 int tty_ldisc_lock(struct tty_struct *tty, unsigned long timeout);
 void tty_ldisc_unlock(struct tty_struct *tty);
 
@@ -46,4 +61,6 @@ static inline void tty_audit_tiocsti(struct tty_struct *tty, char ch)
 }
 #endif
 
+ssize_t redirected_tty_write(struct kiocb *, struct iov_iter *);
+
 #endif
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 053290ab5cb8..70972344946e 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -21,6 +21,7 @@
 #include <linux/bitops.h>
 #include <linux/mutex.h>
 #include <linux/compat.h>
+#include "tty.h"
 
 #include <asm/io.h>
 #include <linux/uaccess.h>
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 1b6f5dc3dcb2..777887d8bd6d 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -349,21 +349,6 @@ struct tty_file_private {
 #define TTY_LDISC_CHANGING	20	/* Change pending - non-block IO */
 #define TTY_LDISC_HALTED	22	/* Line discipline is halted */
 
-/* Values for tty->flow_change */
-#define TTY_THROTTLE_SAFE 1
-#define TTY_UNTHROTTLE_SAFE 2
-
-static inline void __tty_set_flow_change(struct tty_struct *tty, int val)
-{
-	tty->flow_change = val;
-}
-
-static inline void tty_set_flow_change(struct tty_struct *tty, int val)
-{
-	tty->flow_change = val;
-	smp_mb();
-}
-
 static inline bool tty_io_nonblock(struct tty_struct *tty, struct file *file)
 {
 	return file->f_flags & O_NONBLOCK ||
@@ -395,7 +380,6 @@ extern struct tty_struct *tty_kopen_exclusive(dev_t device);
 extern struct tty_struct *tty_kopen_shared(dev_t device);
 extern void tty_kclose(struct tty_struct *tty);
 extern int tty_dev_name_to_number(const char *name, dev_t *number);
-extern ssize_t redirected_tty_write(struct kiocb *, struct iov_iter *);
 #else
 static inline void tty_kref_put(struct tty_struct *tty)
 { }
-- 
2.31.1

