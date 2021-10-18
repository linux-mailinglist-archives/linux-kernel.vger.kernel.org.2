Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899B34312B0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 11:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhJRJFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 05:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhJRJFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 05:05:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE36C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 02:03:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y18-20020a25a092000000b005bddb39f160so17831853ybh.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 02:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/jLgYY9FHQZ8avyfzaHKNWaR9y8yi3ezRHCd3fYvHMg=;
        b=dgalgf38BqWecuzYBfGNg/maUD4zW4onnwBwjhWxjnSu/7tGULZ2vJj+1zITx+C2zy
         IeyG4RtWTZ2iqIw6/Vt0+0eMsD1U8TDN5N1qZKJAzWUFrPv9O5C+e+3elid7ZSnkg2AX
         j7Am0B6UwrTnS6E6WpulO4WRpH5JHD9YxF0a0tfp3SIz6QTC6+VnMnaZCZjsX5jjlsd1
         KnLm2JrGM1qYLRZjezmFC1oE3+dcAHvFkIxvoGoPPd+XpGY5+zvy7KaMf7J1isoUIEX/
         8SiBNDSUcIMo3ODHXj1O+8zW6jGY3ZTN5U9+xiYk3QKnyjON/pzhdoY8lj3epaEG+eQs
         99dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/jLgYY9FHQZ8avyfzaHKNWaR9y8yi3ezRHCd3fYvHMg=;
        b=gJFXdWrW7qTMyawjimISG/h8C0rVClFVHbq35c1t/i42OmI0LdSIHnb97ZOyyoN3HR
         vj+9pjGKP7q6KcBjIFSkhPjOKoFedXr6gfxk9wtZdg9irNgsxpDt1oNisK6aydBvTdNh
         VKMWj+8wNC4pOc2Gdtske7J74dEgPbWQRtrGzVyjm0feg3omS+LXfFZ3Y+0g9qQcUojy
         mL4Tsh3+CVg+h7M+tuUMiUB1YauxyYBwp/qaJu0EMXN6ADC4SlqYv4vkWFklAVX8iKA9
         Q8S2CWwOHRs0pXri4hA/D7LOKcxERXBvsxbUy8nYyzP9dZEAUmQpTdnRBxBS8RJw0oEW
         jr2g==
X-Gm-Message-State: AOAM533X/ITGr9cFjKB59Pm1TYP55lyT0gExI3gYU+wZgduavj3IrxW+
        zekCW5t+LzDzZoe1SIxnYWumXBAuHrAe
X-Google-Smtp-Source: ABdhPJw1H7/hYIizAMiROFVGcYVD0bnHD7ntVYDg4i26vwE/cjSvsQiHm+CPKCyQZCykjnf4DB1sLJv+/9y9
X-Received: from tzungbi-z840.tpe.corp.google.com ([2401:fa00:1:10:e23e:fe98:6410:7fad])
 (user=tzungbi job=sendgmr) by 2002:a25:ac6:: with SMTP id 189mr21925114ybk.330.1634547779405;
 Mon, 18 Oct 2021 02:02:59 -0700 (PDT)
Date:   Mon, 18 Oct 2021 17:02:47 +0800
Message-Id: <20211018090247.3779368-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [RESEND PATCH] platform/chrome: cros_ec_debugfs: detach log reader wq
 from devm
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
2.33.0.1079.g6e70778dc9-goog

