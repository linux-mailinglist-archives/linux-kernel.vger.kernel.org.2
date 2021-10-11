Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0093F4290DF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243690AbhJKONS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:13:18 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:19863 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242698AbhJKOKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:10:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UrSvinA_1633961304;
Received: from VM20190228-102.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0UrSvinA_1633961304)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 11 Oct 2021 22:08:33 +0800
From:   Guanghui Feng <guanghuifeng@linux.alibaba.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     baolin.wang@linux.alibaba.com, zhuo.song@linux.alibaba.com,
        zhangliguang@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] tty: tty_buffer: Fix the softlockup issue in flush_to_ldisc
Date:   Mon, 11 Oct 2021 22:08:24 +0800
Message-Id: <1633961304-24759-1-git-send-email-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running ltp testcase(ltp/testcases/kernel/pty/pty04.c) with arm64, there is a soft lockup,
which look like this one:

  Workqueue: events_unbound flush_to_ldisc
  Call trace:
   dump_backtrace+0x0/0x1ec
   show_stack+0x24/0x30
   dump_stack+0xd0/0x128
   panic+0x15c/0x374
   watchdog_timer_fn+0x2b8/0x304
   __run_hrtimer+0x88/0x2c0
   __hrtimer_run_queues+0xa4/0x120
   hrtimer_interrupt+0xfc/0x270
   arch_timer_handler_phys+0x40/0x50
   handle_percpu_devid_irq+0x94/0x220
   __handle_domain_irq+0x88/0xf0
   gic_handle_irq+0x84/0xfc
   el1_irq+0xc8/0x180
   slip_unesc+0x80/0x214 [slip]
   tty_ldisc_receive_buf+0x64/0x80
   tty_port_default_receive_buf+0x50/0x90
   flush_to_ldisc+0xbc/0x110
   process_one_work+0x1d4/0x4b0
   worker_thread+0x180/0x430
   kthread+0x11c/0x120

In the testcase pty04, The first process call the write syscall to send
data to the pty master. At the same time, the workqueue will do the
flush_to_ldisc to pop data in a loop until there is no more data left.
When the sender and workqueue running in different core, the sender sends
data fastly in full time which will result in workqueue doing work in loop
for a long time and occuring softlockup in flush_to_ldisc with kernel
configured without preempt. So I add need_resched check and cond_resched
in the flush_to_ldisc loop to avoid it.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
Change from v1:
 - add need_resched check and avoid unneeded schedule

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 635d0af..6c7e65b 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -544,6 +544,9 @@ static void flush_to_ldisc(struct work_struct *work)
 		if (!count)
 			break;
 		head->read += count;
+
+		if (need_resched())
+			cond_resched();
 	}
 
 	mutex_unlock(&buf->lock);
-- 
1.8.3.1

