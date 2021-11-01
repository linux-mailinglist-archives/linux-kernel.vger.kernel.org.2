Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2992441565
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 09:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhKAIjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 04:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhKAIjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 04:39:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2D9C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 01:36:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r67-20020a252b46000000b005bea12c4befso24715946ybr.19
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 01:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tW2BwZ/A2idI8vdQ6mfzvJNCFKK49jl6hiLJYBpZXOA=;
        b=bcAkjB5N/ALnCWb9pY+6F7kgyfg4zg1z7lPbKC1K16po2LQCVt7vxQKW95i0bLemul
         wW+jkpFAEyUb7GBeVKqqTdB6Szxp7niKWdR/26kmXYX4MW7nk6U4+c6+m99Q59enHQGU
         28lfykJ/7XvtUZlTR2mbnCl1blZjKxsp4QZGpsRaVIdBJkTT1n3S72iqd0nGdUjeR0wP
         P1PTa2PNaJ+Dib6spkuN3Ektc64L8lFuXPKmekU5rZ0FMsDtu+/CnP/eI5gyy8Y5eS8D
         LmzCZ3GheOcqq6fE8NjauNsivJBtUiEkpN8jQMm/A3yKznhpZPs+RDXB5C0F3MXXvYmi
         Rewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tW2BwZ/A2idI8vdQ6mfzvJNCFKK49jl6hiLJYBpZXOA=;
        b=tMNDL2Ngaoj77DLF2Hd+TL2QQELDgRiBAjPFonata/0Kr8ZksX8YWX8Tr+Osr14/0q
         yGBWzekjLDmdFI7hIFiquNbDavUZWuwddUWv7AkBWKHBCABQVQ7U8+8cj+tVhcN0ThkB
         oIQFoR4L5IpyHZicfypsN8VEFHcFpPrGYumkV1Snx3ZJCO724fdXnS17/E2Zh4YB1gRM
         HfT4YJxsmy5F9F79wWIVVezV7rR7g/VzGyHTXe5gqVHsnIOM1t15SIh2wAHWX301ukog
         eRKI8VOR6TzzJxdR7/ZjAuAbNkeihDO2ihoZuvTw3tW9BaBWHeMmLiueDHpu1rnHUKkd
         +MqQ==
X-Gm-Message-State: AOAM531RrP9HhHjJr2k1nIDoxwRto/YIkTn2IMfCPFVrGgAfGM+XbF5a
        Zu5o/rwsvj0N3n789MjdPBp1hpC95C64
X-Google-Smtp-Source: ABdhPJzhDkT/R0C2yWtTPMTHfSUvC2R462znbwsBoJwm+CQCtNQxjPPkm+dP5eLvtpGAnMz6NCFQpJZtUPQj
X-Received: from tzungbi-z840.tpe.corp.google.com ([2401:fa00:1:10:c50e:bfd4:4c17:a3f9])
 (user=tzungbi job=sendgmr) by 2002:a05:6902:1009:: with SMTP id
 w9mr6640620ybt.120.1635755797396; Mon, 01 Nov 2021 01:36:37 -0700 (PDT)
Date:   Mon,  1 Nov 2021 16:36:29 +0800
Message-Id: <20211101083629.101241-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v2] platform/chrome: cros_ec_debugfs: detach log reader wq
 from devm
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     bleung@chromium.org, groeck@chromium.org, bleung@google.com,
        groeck@google.com
Cc:     linux-kernel@vger.kernel.org, tzungbi@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Debugfs console_log uses devm memory (e.g. debug_info in
cros_ec_console_log_poll()).  However, lifecycles of device and debugfs
are independent.  An use-after-free issue is observed if userland
program operates the debugfs after the memory has been freed.

The call trace:
 do_raw_spin_lock
 _raw_spin_lock_irqsave
 remove_wait_queue
 ep_unregister_pollwait
 ep_remove
 do_epoll_ctl

A Python example to reproduce the issue:
... import select
... p = select.epoll()
... f = open('/sys/kernel/debug/cros_scp/console_log')
... p.register(f, select.POLLIN)
... p.poll(1)
[(4, 1)]                    # 4=fd, 1=select.POLLIN

[ shutdown cros_scp at the point ]

... p.poll(1)
[(4, 16)]                   # 4=fd, 16=select.POLLHUP
... p.unregister(f)

An use-after-free issue raises here.  It called epoll_ctl with
EPOLL_CTL_DEL which in turn to use the workqueue in the devm (i.e.
log_wq).

Detaches log reader's workqueue from devm to make sure it is persistent
even if the device has been removed.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
As for 2 other related cases I could image:

Case 1. userland program opens the debugfs after the device has been removed

ENOENT.  cros_ec_debugfs_remove() calls debugfs_remove_recursive().

Case 2. userland program is reading when the device is removing

If the userland program is waiting in cros_ec_console_log_read(), the device
removal will wait for it.

See the calling stack for the case:
 wait_for_completion
 __debugfs_file_removed
 remove_one
 simple_recursive_removal
 debugfs_remove
 cros_ec_debugfs_remove
 platform_drv_remove
 device_release_driver_internal
 device_release_driver
 bus_remove_device
 device_del
 platform_device_del
 platform_device_unregister

Changes from v1:
- rebase to next-20211029.
- change the commit messages.

 drivers/platform/chrome/cros_ec_debugfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 272c89837d74..0dbceee87a4b 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -25,6 +25,9 @@
 
 #define CIRC_ADD(idx, size, value)	(((idx) + (value)) & ((size) - 1))
 
+/* waitqueue for log readers */
+static DECLARE_WAIT_QUEUE_HEAD(cros_ec_debugfs_log_wq);
+
 /**
  * struct cros_ec_debugfs - EC debugging information.
  *
@@ -33,7 +36,6 @@
  * @log_buffer: circular buffer for console log information
  * @read_msg: preallocated EC command and buffer to read console log
  * @log_mutex: mutex to protect circular buffer
- * @log_wq: waitqueue for log readers
  * @log_poll_work: recurring task to poll EC for new console log data
  * @panicinfo_blob: panicinfo debugfs blob
  */
@@ -44,7 +46,6 @@ struct cros_ec_debugfs {
 	struct circ_buf log_buffer;
 	struct cros_ec_command *read_msg;
 	struct mutex log_mutex;
-	wait_queue_head_t log_wq;
 	struct delayed_work log_poll_work;
 	/* EC panicinfo */
 	struct debugfs_blob_wrapper panicinfo_blob;
@@ -107,7 +108,7 @@ static void cros_ec_console_log_work(struct work_struct *__work)
 			buf_space--;
 		}
 
-		wake_up(&debug_info->log_wq);
+		wake_up(&cros_ec_debugfs_log_wq);
 	}
 
 	mutex_unlock(&debug_info->log_mutex);
@@ -141,7 +142,7 @@ static ssize_t cros_ec_console_log_read(struct file *file, char __user *buf,
 
 		mutex_unlock(&debug_info->log_mutex);
 
-		ret = wait_event_interruptible(debug_info->log_wq,
+		ret = wait_event_interruptible(cros_ec_debugfs_log_wq,
 					CIRC_CNT(cb->head, cb->tail, LOG_SIZE));
 		if (ret < 0)
 			return ret;
@@ -173,7 +174,7 @@ static __poll_t cros_ec_console_log_poll(struct file *file,
 	struct cros_ec_debugfs *debug_info = file->private_data;
 	__poll_t mask = 0;
 
-	poll_wait(file, &debug_info->log_wq, wait);
+	poll_wait(file, &cros_ec_debugfs_log_wq, wait);
 
 	mutex_lock(&debug_info->log_mutex);
 	if (CIRC_CNT(debug_info->log_buffer.head,
@@ -377,7 +378,6 @@ static int cros_ec_create_console_log(struct cros_ec_debugfs *debug_info)
 	debug_info->log_buffer.tail = 0;
 
 	mutex_init(&debug_info->log_mutex);
-	init_waitqueue_head(&debug_info->log_wq);
 
 	debugfs_create_file("console_log", S_IFREG | 0444, debug_info->dir,
 			    debug_info, &cros_ec_console_log_fops);
-- 
2.33.1.1089.g2158813163f-goog

