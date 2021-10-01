Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F69841E911
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 10:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352717AbhJAI0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 04:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhJAI0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 04:26:51 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F24EC061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 01:25:07 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id h2-20020a05620a400200b0045e87af96ebso3750348qko.14
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 01:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=FBeS3lAS+por1ohyx/M0kt+AefAERRaWIO//vKJDGMg=;
        b=Igt9T9yO/5jq8bTU8Slk/+qXPJnpzeVRlwYbguo4zhvuxTnqitoD/MUmgK4d4wP+jy
         JCgz+0rDWfpeLlkkhq1RLKraTzwEGldb6F02+fWK9x77HWxkc+VXSbADRkLa7NEqROBf
         5lLCrjsARGKKremElg5bLtqws68xRA3E/ta2/+3ISY/lbbljJsRX2vxbgRv8e57iP455
         i4UxcKSEVu3JPyeLpLu26qlaNEelGbkFMKeB5V66id/k3JOKJM3a6Afj3tan0yZ44Yr3
         a+naMXOW32aWMge4au5lzL4z2YeXvHV1syA4nHeLh988AB7AwhzWlX7QlebPWg08FjH/
         R7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=FBeS3lAS+por1ohyx/M0kt+AefAERRaWIO//vKJDGMg=;
        b=z2sv+qPPS2LCwip4aJy5zGiihaAgF/kNDGjYbU+Tkk+ctobwkiPZtWgNp5vigXVZhg
         z2fvIudeiTrjbvnsogZttIvw+Cn9bYbcrnV2t2gDyqFEF5cGSN0Hq/g7ZDuXsQqfS6lF
         gcK/nwpvXRbRvMWCjVaaBGJ+6ow9DGI0Dzd0zmURwdUNlYDUtgaLIrW9ajoa9mYl1mRY
         oEZ4EVQpmWfRBNg938kgYz1qwuYpdaTen7CULHQObx8hMC+flnYzDI5S/usPlKhsA4QR
         gnawHukja/X63mWe4XTMLzRkf5GpfADiF5MtbqbKT6SqbBkv7XeZfoQnphUeFTDCjjCC
         dOXQ==
X-Gm-Message-State: AOAM530ddRjzBJ7Sp4JygYrNKgA6zpYP9CNnHFbPK53KJ28dMtGyMgZ3
        +ZSl+pX1Min20H5WhIzz8kNsmQNDYP6g
X-Google-Smtp-Source: ABdhPJwhkUAODYrhLn6L1bmIF8sOe7J0I9ppMJm9mpv+iX8G/rSh4U/jKkv1R1/VneNtOqsP0oKplnV/vL+5
X-Received: from tzungbi-z840.tpe.corp.google.com ([2401:fa00:1:10:2aeb:a516:cf6:c5a1])
 (user=tzungbi job=sendgmr) by 2002:a05:6214:1233:: with SMTP id
 p19mr7994309qvv.20.1633076706803; Fri, 01 Oct 2021 01:25:06 -0700 (PDT)
Date:   Fri,  1 Oct 2021 16:24:56 +0800
Message-Id: <20211001082456.1986968-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH] platform/chrome: cros_ec_debugfs: detach log reader wq from devm
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     bleung@chromium.org, enric.balletbo@collabora.com
Cc:     groeck@chromium.org, linux-kernel@vger.kernel.org,
        tzungbi@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Debugfs console_log uses devm memory (see struct cros_ec_debugfs in
cros_ec_console_log fops).  However, lifecycles of device and debugfs
are independent.  An use-after-free issue is observed if userland
program operates the debugfs after the memory has been freed.

An userland program example in Python code:
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

The calling stack:
do_raw_spin_lock
_raw_spin_lock_irqsave
remove_wait_queue
ep_unregister_pollwait
ep_remove
do_epoll_ctl

Detaches log reader's workqueue from devm to make sure it is persistent
even if the device has been removed.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
As for 2 other cases:

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
2.33.0.800.g4c38ced690-goog

