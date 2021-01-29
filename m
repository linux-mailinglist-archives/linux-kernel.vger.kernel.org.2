Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54FF3308FC9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 23:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbhA2WHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 17:07:33 -0500
Received: from relay.smtp-ext.broadcom.com ([192.19.232.172]:38502 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233113AbhA2WHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 17:07:32 -0500
Received: from lbrmn-lnxub113.broadcom.net (lbrmn-lnxub113.ric.broadcom.net [10.136.13.65])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id E2A597DA6;
        Fri, 29 Jan 2021 14:06:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com E2A597DA6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1611957990;
        bh=rMOGMJroDYt7ixmjHrfKW0YVRnEgUqo9UIkprnDPuHw=;
        h=From:To:Cc:Subject:Date:From;
        b=QFgKFpcliIhxkuE6VuSedQ8VMpop8DSjmnhe91Q+4VzltYf9bVYRnNjFvnuhHum+g
         lRFar2/cP/fC8l6JwkKotgDJrZwVMeZGlZfSOLBFtivoEAsPRRAdHtOJgmcWZ1Gz2Q
         6oWnn4WbbF2K+5CIgrfgbecOo3NJpPRaHIMquVbk=
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>,
        Desmond Yan <desmond.yan@broadcom.com>
Subject: [PATCH v2] misc: bcm-vk: only support ttyVK if CONFIG_TTY is set
Date:   Fri, 29 Jan 2021 14:06:27 -0800
Message-Id: <20210129220627.22641-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct compile issue if CONFIG_TTY is not set by
only adding ttyVK devices if CONFIG_TTY is set.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>

---
Changes since v1:
Add function stubs rather than compiling out code
---
 drivers/misc/bcm-vk/Makefile     |  4 ++--
 drivers/misc/bcm-vk/bcm_vk.h     | 35 +++++++++++++++++++++++++++++---
 drivers/misc/bcm-vk/bcm_vk_dev.c |  3 +--
 drivers/misc/bcm-vk/bcm_vk_tty.c |  6 ++++++
 4 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/bcm-vk/Makefile b/drivers/misc/bcm-vk/Makefile
index e4a1486f7209..8d81a734fcad 100644
--- a/drivers/misc/bcm-vk/Makefile
+++ b/drivers/misc/bcm-vk/Makefile
@@ -7,6 +7,6 @@ obj-$(CONFIG_BCM_VK) += bcm_vk.o
 bcm_vk-objs := \
 	bcm_vk_dev.o \
 	bcm_vk_msg.o \
-	bcm_vk_sg.o \
-	bcm_vk_tty.o
+	bcm_vk_sg.o
 
+bcm_vk-$(CONFIG_TTY) += bcm_vk_tty.o
diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
index 3f37c640a814..4a1d515374c7 100644
--- a/drivers/misc/bcm-vk/bcm_vk.h
+++ b/drivers/misc/bcm-vk/bcm_vk.h
@@ -258,7 +258,11 @@ enum pci_barno {
 	BAR_2
 };
 
+#ifdef CONFIG_TTY
 #define BCM_VK_NUM_TTY 2
+#else
+#define BCM_VK_NUM_TTY 0
+#endif
 
 struct bcm_vk_tty {
 	struct tty_port port;
@@ -366,11 +370,15 @@ struct bcm_vk {
 	struct miscdevice miscdev;
 	int devid; /* dev id allocated */
 
+#ifdef CONFIG_TTY
 	struct tty_driver *tty_drv;
 	struct timer_list serial_timer;
 	struct bcm_vk_tty tty[BCM_VK_NUM_TTY];
 	struct workqueue_struct *tty_wq_thread;
 	struct work_struct tty_wq_work;
+#else
+	struct bcm_vk_tty *tty;
+#endif
 
 	/* Reference-counting to handle file operations */
 	struct kref kref;
@@ -501,13 +509,34 @@ int bcm_vk_send_shutdown_msg(struct bcm_vk *vk, u32 shut_type,
 			     const pid_t pid, const u32 q_num);
 void bcm_to_v_q_doorbell(struct bcm_vk *vk, u32 q_num, u32 db_val);
 int bcm_vk_auto_load_all_images(struct bcm_vk *vk);
-int bcm_vk_tty_init(struct bcm_vk *vk, char *name);
-void bcm_vk_tty_exit(struct bcm_vk *vk);
-void bcm_vk_tty_terminate_tty_user(struct bcm_vk *vk);
 void bcm_vk_hb_init(struct bcm_vk *vk);
 void bcm_vk_hb_deinit(struct bcm_vk *vk);
 void bcm_vk_handle_notf(struct bcm_vk *vk);
 bool bcm_vk_drv_access_ok(struct bcm_vk *vk);
 void bcm_vk_set_host_alert(struct bcm_vk *vk, u32 bit_mask);
 
+#ifdef CONFIG_TTY
+int bcm_vk_tty_init(struct bcm_vk *vk, char *name);
+void bcm_vk_tty_exit(struct bcm_vk *vk);
+void bcm_vk_tty_terminate_tty_user(struct bcm_vk *vk);
+void bcm_vk_tty_wq_exit(struct bcm_vk *vk);
+#else
+static inline int bcm_vk_tty_init(struct bcm_vk *vk, char *name)
+{
+	return 0;
+}
+
+static inline void bcm_vk_tty_exit(struct bcm_vk *vk)
+{
+}
+
+static inline void bcm_vk_tty_terminate_tty_user(struct bcm_vk *vk)
+{
+}
+
+static inline void bcm_vk_tty_wq_exit(struct bcm_vk *vk)
+{
+}
+#endif /* CONFIG_TTY */
+
 #endif
diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index c3d2bba68ef1..5d2030b67007 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -1580,8 +1580,7 @@ static void bcm_vk_remove(struct pci_dev *pdev)
 
 	cancel_work_sync(&vk->wq_work);
 	destroy_workqueue(vk->wq_thread);
-	cancel_work_sync(&vk->tty_wq_work);
-	destroy_workqueue(vk->tty_wq_thread);
+	bcm_vk_tty_wq_exit(vk);
 
 	for (i = 0; i < MAX_BAR; i++) {
 		if (vk->bar[i])
diff --git a/drivers/misc/bcm-vk/bcm_vk_tty.c b/drivers/misc/bcm-vk/bcm_vk_tty.c
index be3964949b63..4d02692ecfc7 100644
--- a/drivers/misc/bcm-vk/bcm_vk_tty.c
+++ b/drivers/misc/bcm-vk/bcm_vk_tty.c
@@ -331,3 +331,9 @@ void bcm_vk_tty_terminate_tty_user(struct bcm_vk *vk)
 			kill_pid(find_vpid(vktty->pid), SIGKILL, 1);
 	}
 }
+
+void bcm_vk_tty_wq_exit(struct bcm_vk *vk)
+{
+	cancel_work_sync(&vk->tty_wq_work);
+	destroy_workqueue(vk->tty_wq_thread);
+}
-- 
2.17.1

