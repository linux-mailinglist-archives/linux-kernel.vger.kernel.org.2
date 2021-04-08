Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6A93583C5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhDHMwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:52:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231691AbhDHMwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:52:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A85DC61132;
        Thu,  8 Apr 2021 12:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617886317;
        bh=irMJyin2pC6eZ/wh8AcJyr9OaXTShfUN3UnfBb0Bcgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i5YVa2yJ33IT59X5VaTjFqMHSxgW1aBmd9eYXh79WffPo6KjMOd1hrfBFCHCA0rZg
         0nxMiv+yT0DoUQokaCp+x/CpaHL53ARb/qsc3dXjIsyuRohBB4TqRSzDlR7YULc1f+
         hq/5kTp0yHvLuDioWuOmcm0XgnioYP6BdQUIeLoA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH 13/13] tty: clean include/linux/tty.h up
Date:   Thu,  8 Apr 2021 14:51:34 +0200
Message-Id: <20210408125134.3016837-14-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
References: <20210408125134.3016837-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a lot of tty-core-only functions that are listed in
include/linux/tty.h.  Move them to drivers/tty/tty.h so that no one else
can accidentally call them or think that they are public functions.

Cc: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/n_gsm.c  |  1 +
 drivers/tty/n_hdlc.c |  1 +
 drivers/tty/tty.h    | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/tty.h  | 34 ----------------------------------
 4 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 51dafc06f541..6114980c832d 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -50,6 +50,7 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/gsmmux.h>
+#include "tty.h"
 
 static int debug;
 module_param(debug, int, 0600);
diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 1363e659dc1d..e64ab74c9a2c 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -100,6 +100,7 @@
 
 #include <asm/termios.h>
 #include <linux/uaccess.h>
+#include "tty.h"
 
 /*
  * Buffers for individual HDLC frames
diff --git a/drivers/tty/tty.h b/drivers/tty/tty.h
index b0d78bfdbd8c..caaf97ba5267 100644
--- a/drivers/tty/tty.h
+++ b/drivers/tty/tty.h
@@ -47,6 +47,43 @@ static inline void tty_set_flow_change(struct tty_struct *tty, int val)
 int tty_ldisc_lock(struct tty_struct *tty, unsigned long timeout);
 void tty_ldisc_unlock(struct tty_struct *tty);
 
+int __tty_check_change(struct tty_struct *tty, int sig);
+int tty_check_change(struct tty_struct *tty);
+void __stop_tty(struct tty_struct *tty);
+void __start_tty(struct tty_struct *tty);
+void tty_vhangup_session(struct tty_struct *tty);
+void tty_open_proc_set_tty(struct file *filp, struct tty_struct *tty);
+int tty_signal_session_leader(struct tty_struct *tty, int exit_session);
+void session_clear_tty(struct pid *session);
+void tty_buffer_free_all(struct tty_port *port);
+void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld);
+void tty_buffer_init(struct tty_port *port);
+void tty_buffer_set_lock_subclass(struct tty_port *port);
+bool tty_buffer_restart_work(struct tty_port *port);
+bool tty_buffer_cancel_work(struct tty_port *port);
+void tty_buffer_flush_work(struct tty_port *port);
+speed_t tty_termios_input_baud_rate(struct ktermios *termios);
+void tty_ldisc_hangup(struct tty_struct *tty, bool reset);
+int tty_ldisc_reinit(struct tty_struct *tty, int disc);
+long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+long tty_jobctrl_ioctl(struct tty_struct *tty, struct tty_struct *real_tty,
+		       struct file *file, unsigned int cmd, unsigned long arg);
+void tty_default_fops(struct file_operations *fops);
+struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx);
+int tty_alloc_file(struct file *file);
+void tty_add_file(struct tty_struct *tty, struct file *file);
+void tty_free_file(struct file *file);
+int tty_release(struct inode *inode, struct file *filp);
+
+#define tty_is_writelocked(tty)  (mutex_is_locked(&tty->atomic_write_lock))
+
+int tty_ldisc_setup(struct tty_struct *tty, struct tty_struct *o_tty);
+void tty_ldisc_release(struct tty_struct *tty);
+int __must_check tty_ldisc_init(struct tty_struct *tty);
+void tty_ldisc_deinit(struct tty_struct *tty);
+
+void tty_sysctl_init(void);
+
 /* tty_audit.c */
 #ifdef CONFIG_AUDIT
 void tty_audit_add_data(struct tty_struct *tty, const void *data, size_t size);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 143f393dca3b..1611214c8457 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -431,11 +431,7 @@ static inline struct tty_struct *tty_kref_get(struct tty_struct *tty)
 }
 
 extern void tty_wait_until_sent(struct tty_struct *tty, long timeout);
-extern int __tty_check_change(struct tty_struct *tty, int sig);
-extern int tty_check_change(struct tty_struct *tty);
-extern void __stop_tty(struct tty_struct *tty);
 extern void stop_tty(struct tty_struct *tty);
-extern void __start_tty(struct tty_struct *tty);
 extern void start_tty(struct tty_struct *tty);
 extern int tty_register_driver(struct tty_driver *driver);
 extern int tty_unregister_driver(struct tty_driver *driver);
@@ -462,23 +458,11 @@ extern int tty_get_icount(struct tty_struct *tty,
 extern int is_current_pgrp_orphaned(void);
 extern void tty_hangup(struct tty_struct *tty);
 extern void tty_vhangup(struct tty_struct *tty);
-extern void tty_vhangup_session(struct tty_struct *tty);
 extern int tty_hung_up_p(struct file *filp);
 extern void do_SAK(struct tty_struct *tty);
 extern void __do_SAK(struct tty_struct *tty);
-extern void tty_open_proc_set_tty(struct file *filp, struct tty_struct *tty);
-extern int tty_signal_session_leader(struct tty_struct *tty, int exit_session);
-extern void session_clear_tty(struct pid *session);
 extern void no_tty(void);
-extern void tty_buffer_free_all(struct tty_port *port);
-extern void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld);
-extern void tty_buffer_init(struct tty_port *port);
-extern void tty_buffer_set_lock_subclass(struct tty_port *port);
-extern bool tty_buffer_restart_work(struct tty_port *port);
-extern bool tty_buffer_cancel_work(struct tty_port *port);
-extern void tty_buffer_flush_work(struct tty_port *port);
 extern speed_t tty_termios_baud_rate(struct ktermios *termios);
-extern speed_t tty_termios_input_baud_rate(struct ktermios *termios);
 extern void tty_termios_encode_baud_rate(struct ktermios *termios,
 						speed_t ibaud, speed_t obaud);
 extern void tty_encode_baud_rate(struct tty_struct *tty,
@@ -506,27 +490,16 @@ extern int tty_set_termios(struct tty_struct *tty, struct ktermios *kt);
 extern struct tty_ldisc *tty_ldisc_ref(struct tty_struct *);
 extern void tty_ldisc_deref(struct tty_ldisc *);
 extern struct tty_ldisc *tty_ldisc_ref_wait(struct tty_struct *);
-extern void tty_ldisc_hangup(struct tty_struct *tty, bool reset);
-extern int tty_ldisc_reinit(struct tty_struct *tty, int disc);
 extern const struct seq_operations tty_ldiscs_seq_ops;
 
 extern void tty_wakeup(struct tty_struct *tty);
 extern void tty_ldisc_flush(struct tty_struct *tty);
 
-extern long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 extern int tty_mode_ioctl(struct tty_struct *tty, struct file *file,
 			unsigned int cmd, unsigned long arg);
-extern long tty_jobctrl_ioctl(struct tty_struct *tty, struct tty_struct *real_tty,
-			      struct file *file, unsigned int cmd, unsigned long arg);
 extern int tty_perform_flush(struct tty_struct *tty, unsigned long arg);
-extern void tty_default_fops(struct file_operations *fops);
-extern struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx);
-extern int tty_alloc_file(struct file *file);
-extern void tty_add_file(struct tty_struct *tty, struct file *file);
-extern void tty_free_file(struct file *file);
 extern struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx);
 extern void tty_release_struct(struct tty_struct *tty, int idx);
-extern int tty_release(struct inode *inode, struct file *filp);
 extern void tty_init_termios(struct tty_struct *tty);
 extern void tty_save_termios(struct tty_struct *tty);
 extern int tty_standard_install(struct tty_driver *driver,
@@ -534,8 +507,6 @@ extern int tty_standard_install(struct tty_driver *driver,
 
 extern struct mutex tty_mutex;
 
-#define tty_is_writelocked(tty)  (mutex_is_locked(&tty->atomic_write_lock))
-
 extern void tty_port_init(struct tty_port *port);
 extern void tty_port_link_device(struct tty_port *port,
 		struct tty_driver *driver, unsigned index);
@@ -655,13 +626,8 @@ static inline int tty_port_users(struct tty_port *port)
 extern int tty_register_ldisc(int disc, struct tty_ldisc_ops *new_ldisc);
 extern int tty_unregister_ldisc(int disc);
 extern int tty_set_ldisc(struct tty_struct *tty, int disc);
-extern int tty_ldisc_setup(struct tty_struct *tty, struct tty_struct *o_tty);
-extern void tty_ldisc_release(struct tty_struct *tty);
-extern int __must_check tty_ldisc_init(struct tty_struct *tty);
-extern void tty_ldisc_deinit(struct tty_struct *tty);
 extern int tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
 				 char *f, int count);
-extern void tty_sysctl_init(void);
 
 /* n_tty.c */
 extern void n_tty_inherit_ops(struct tty_ldisc_ops *ops);
-- 
2.31.1

