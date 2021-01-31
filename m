Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF55C309F76
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 00:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhAaXcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 18:32:15 -0500
Received: from relay.smtp-ext.broadcom.com ([192.19.232.172]:52894 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229769AbhAaXb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 18:31:59 -0500
Received: from lbrmn-lnxub113.broadcom.net (lbrmn-lnxub113.ric.broadcom.net [10.136.13.65])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 645C37DDA;
        Sun, 31 Jan 2021 15:30:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 645C37DDA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1612135857;
        bh=/46ablTqIxcOdCVQqcOOIvTTceJIsufOEJVTuv2n8hM=;
        h=From:To:Cc:Subject:Date:From;
        b=exnc8lFNzdBUdKSLhoAK5pVV5X2O2K/pt7sNru9DI1s9JtwSkV7Yk8SAv5/pSwzjt
         vgzeSVB6Xfu0hTSNUxNelR7NmAwzvt4kKUJwiTj9qiUgek15067VlRMHdCVOb3Qgu5
         JItOLPTBmIqF7kqPxBx9cXXDvHmBiUi0uSyUqhNw=
From:   Scott Branden <scott.branden@broadcom.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Olof Johansson <olof@lixom.net>,
        Desmond Yan <desmond.yan@broadcom.com>
Subject: [PATCH v3] misc: bcm-vk: only support ttyVK if CONFIG_TTY is set
Date:   Sun, 31 Jan 2021 15:30:49 -0800
Message-Id: <20210131233049.5500-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct compile issue if CONFIG_TTY is not set by
only adding ttyVK devices if CONFIG_BCM_VK_TTY is set.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>

---
Changes since v2:
- add CONFIG_BCM_VK_TTY
- add function and stub for bcm_vk_tty_set_irq_enabled
Changes since v1:
- add function stubs rather than compiling out code
---
 drivers/misc/bcm-vk/Kconfig      | 16 ++++++++++++
 drivers/misc/bcm-vk/Makefile     |  4 +--
 drivers/misc/bcm-vk/bcm_vk.h     | 42 +++++++++++++++++++++++++++++---
 drivers/misc/bcm-vk/bcm_vk_dev.c |  5 ++--
 drivers/misc/bcm-vk/bcm_vk_tty.c |  6 +++++
 5 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/bcm-vk/Kconfig b/drivers/misc/bcm-vk/Kconfig
index 052f6f28b540..16ce98c964b8 100644
--- a/drivers/misc/bcm-vk/Kconfig
+++ b/drivers/misc/bcm-vk/Kconfig
@@ -15,3 +15,19 @@ config BCM_VK
 	  accelerators via /dev/bcm-vk.N devices.
 
 	  If unsure, say N.
+
+if BCM_VK
+
+config BCM_VK_TTY
+	bool "Enable ttyVK"
+	depends on TTY
+	default y
+	help
+	  Select this option to enable ttyVK support to allow console
+	  access to VK cards from host.
+
+	  Device node will in the form /dev/bcm-vk.x_ttyVKy where:
+	  x is the instance of the VK card
+	  y is the tty device number on the VK card.
+
+endif # BCM_VK
diff --git a/drivers/misc/bcm-vk/Makefile b/drivers/misc/bcm-vk/Makefile
index e4a1486f7209..1df2ebe851ca 100644
--- a/drivers/misc/bcm-vk/Makefile
+++ b/drivers/misc/bcm-vk/Makefile
@@ -7,6 +7,6 @@ obj-$(CONFIG_BCM_VK) += bcm_vk.o
 bcm_vk-objs := \
 	bcm_vk_dev.o \
 	bcm_vk_msg.o \
-	bcm_vk_sg.o \
-	bcm_vk_tty.o
+	bcm_vk_sg.o
 
+bcm_vk-$(CONFIG_BCM_VK_TTY) += bcm_vk_tty.o
diff --git a/drivers/misc/bcm-vk/bcm_vk.h b/drivers/misc/bcm-vk/bcm_vk.h
index 3f37c640a814..a1338f375589 100644
--- a/drivers/misc/bcm-vk/bcm_vk.h
+++ b/drivers/misc/bcm-vk/bcm_vk.h
@@ -258,7 +258,11 @@ enum pci_barno {
 	BAR_2
 };
 
+#ifdef CONFIG_BCM_VK_TTY
 #define BCM_VK_NUM_TTY 2
+#else
+#define BCM_VK_NUM_TTY 0
+#endif
 
 struct bcm_vk_tty {
 	struct tty_port port;
@@ -366,11 +370,13 @@ struct bcm_vk {
 	struct miscdevice miscdev;
 	int devid; /* dev id allocated */
 
+#ifdef CONFIG_BCM_VK_TTY
 	struct tty_driver *tty_drv;
 	struct timer_list serial_timer;
 	struct bcm_vk_tty tty[BCM_VK_NUM_TTY];
 	struct workqueue_struct *tty_wq_thread;
 	struct work_struct tty_wq_work;
+#endif
 
 	/* Reference-counting to handle file operations */
 	struct kref kref;
@@ -501,13 +507,43 @@ int bcm_vk_send_shutdown_msg(struct bcm_vk *vk, u32 shut_type,
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
 
+#ifdef CONFIG_BCM_VK_TTY
+int bcm_vk_tty_init(struct bcm_vk *vk, char *name);
+void bcm_vk_tty_exit(struct bcm_vk *vk);
+void bcm_vk_tty_terminate_tty_user(struct bcm_vk *vk);
+void bcm_vk_tty_wq_exit(struct bcm_vk *vk);
+
+static inline void bcm_vk_tty_set_irq_enabled(struct bcm_vk *vk, int index)
+{
+	vk->tty[index].irq_enabled = true;
+}
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
+
+static inline void bcm_vk_tty_set_irq_enabled(struct bcm_vk *vk, int index)
+{
+}
+#endif /* CONFIG_BCM_VK_TTY */
+
 #endif
diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_vk_dev.c
index c3d2bba68ef1..59b4859d68d2 100644
--- a/drivers/misc/bcm-vk/bcm_vk_dev.c
+++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
@@ -1396,7 +1396,7 @@ static int bcm_vk_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 				pdev->irq + vk->num_irqs, vk->num_irqs + 1);
 			goto err_irq;
 		}
-		vk->tty[i].irq_enabled = true;
+		bcm_vk_tty_set_irq_enabled(vk, i);
 	}
 
 	id = ida_simple_get(&bcm_vk_ida, 0, 0, GFP_KERNEL);
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

