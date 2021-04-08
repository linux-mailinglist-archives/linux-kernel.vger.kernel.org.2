Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B643583D5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbhDHMwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231742AbhDHMw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:52:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E067B61131;
        Thu,  8 Apr 2021 12:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617886335;
        bh=pZSqE4+whOteuHfgzSuKcLta40U8VGf9iWhNxjiyTNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fzo9wx00cfCvx5PU2Lm6zBqQBJ6McJCV4IW+nGz9NLEt5dCafF9f/UjieKf8Z2/Sn
         c1d18b5AM7RT2IxsiqKk2YrfxgaVM3Jg+p9OAWy615he8FDgxVPt5XJn6YfwaESf9z
         kkQg9tnIbSHL8iyuvVk7KLFDODvp4LGqRWynJT/M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 08/13] tty: audit: move some local functions out of tty.h
Date:   Thu,  8 Apr 2021 14:51:29 +0200
Message-Id: <20210408125134.3016837-9-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
References: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions tty_audit_add_data() and tty_audit_tiocsti() are local to
the tty core code, and do not need to be in a "kernel-wide" header file
so move them to drivers/tty/tty.h

Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/tty.h       | 14 ++++++++++++++
 drivers/tty/tty_audit.c |  1 +
 include/linux/tty.h     | 10 ----------
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/tty.h b/drivers/tty/tty.h
index e9cb918348cf..a8a7abe5d635 100644
--- a/drivers/tty/tty.h
+++ b/drivers/tty/tty.h
@@ -6,4 +6,18 @@
 #ifndef _TTY_INTERNAL_H
 #define _TTY_INTERNAL_H
 
+/* tty_audit.c */
+#ifdef CONFIG_AUDIT
+void tty_audit_add_data(struct tty_struct *tty, const void *data, size_t size);
+void tty_audit_tiocsti(struct tty_struct *tty, char ch);
+#else
+static inline void tty_audit_add_data(struct tty_struct *tty, const void *data,
+				      size_t size)
+{
+}
+static inline void tty_audit_tiocsti(struct tty_struct *tty, char ch)
+{
+}
+#endif
+
 #endif
diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
index 32898aabcd06..ca7afd7b2716 100644
--- a/drivers/tty/tty_audit.c
+++ b/drivers/tty/tty_audit.c
@@ -10,6 +10,7 @@
 #include <linux/audit.h>
 #include <linux/slab.h>
 #include <linux/tty.h>
+#include "tty.h"
 
 struct tty_audit_buf {
 	struct mutex mutex;	/* Protects all data below */
diff --git a/include/linux/tty.h b/include/linux/tty.h
index fd8308a1f37e..981ee31c58e1 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -717,20 +717,10 @@ static inline void n_tty_init(void) { }
 
 /* tty_audit.c */
 #ifdef CONFIG_AUDIT
-extern void tty_audit_add_data(struct tty_struct *tty, const void *data,
-			       size_t size);
 extern void tty_audit_exit(void);
 extern void tty_audit_fork(struct signal_struct *sig);
-extern void tty_audit_tiocsti(struct tty_struct *tty, char ch);
 extern int tty_audit_push(void);
 #else
-static inline void tty_audit_add_data(struct tty_struct *tty, const void *data,
-				      size_t size)
-{
-}
-static inline void tty_audit_tiocsti(struct tty_struct *tty, char ch)
-{
-}
 static inline void tty_audit_exit(void)
 {
 }
-- 
2.31.1

