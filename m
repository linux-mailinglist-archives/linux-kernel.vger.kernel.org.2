Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1353F41D1C4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 05:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347940AbhI3DNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 23:13:35 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:33877 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347891AbhI3DNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 23:13:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Uq4HdaD_1632971500;
Received: from j66e01291.sqa.eu95.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0Uq4HdaD_1632971500)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 30 Sep 2021 11:11:50 +0800
From:   Guanghui Feng <guanghuifeng@linux.alibaba.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH] tty: tty_buffer: Fix the softlockup issue in flush_to_ldisc
Date:   Thu, 30 Sep 2021 11:11:38 +0800
Message-Id: <1632971498-57869-1-git-send-email-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I run ltp testcase(ltp/testcases/kernel/pty/pty04.c) with arm64, there is a soft lockup,
which look like this one:

  watchdog: BUG: soft lockup - CPU#41 stuck for 67s! [kworker/u192:2:106867]
  CPU: 41 PID: 106867 Comm: kworker/u192:2 Kdump: loaded Tainted: G           OE     5.10.23 #1
  Hardware name: H3C R4960 G3/BC82AMDDA, BIOS 1.70 01/07/2021
  Workqueue: events_unbound flush_to_ldisc
  pstate: 00c00009 (nzcv daif +PAN +UAO -TCO BTYPE=--)
  pc : slip_unesc+0x80/0x214 [slip]
  lr : slip_receive_buf+0x84/0x100 [slip]
  sp : ffff80005274bce0
  x29: ffff80005274bce0 x28: 0000000000000000
  x27: ffff00525626fcc8 x26: ffff800011921078
  x25: 0000000000000000 x24: 0000000000000004
  x23: ffff00402b4059c0 x22: ffff00402b405940
  x21: ffff205d87b81e21 x20: ffff205d87b81b9b
  x19: 0000000000000000 x18: 0000000000000000
  x17: 0000000000000000 x16: 0000000000000000
  x15: 0000000000000000 x14: 5f5f5f5f5f5f5f5f
  x13: 5f5f5f5f5f5f5f5f x12: 5f5f5f5f5f5f5f5f
  x11: 5f5f5f5f5f5f5f5f x10: 5f5f5f5f5f5f5f5f
  x9 : ffff8000097d7628 x8 : ffff205d87b85e20
  x7 : 0000000000000000 x6 : 0000000000000001
  x5 : ffff8000097dc008 x4 : ffff8000097d75a4
  x3 : ffff205d87b81e1f x2 : 0000000000000005
  x1 : 000000000000005f x0 : ffff00402b405940
  Call trace:
   slip_unesc+0x80/0x214 [slip]
   tty_ldisc_receive_buf+0x64/0x80
   tty_port_default_receive_buf+0x50/0x90
   flush_to_ldisc+0xbc/0x110
   process_one_work+0x1d4/0x4b0
   worker_thread+0x180/0x430
   kthread+0x11c/0x120
  Kernel panic - not syncing: softlockup: hung tasks
  CPU: 41 PID: 106867 Comm: kworker/u192:2 Kdump: loaded Tainted: G           OEL    5.10.23 #1
  Hardware name: H3C R4960 G3/BC82AMDDA, BIOS 1.70 01/07/2021
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
  SMP: stopping secondary CPUs

In the testcase pty04, there are multple processes and we only pay close attention to the
first three actually. The first process call the write syscall to send data to the pty master
with all one's strength(tty_write->file_tty_write->do_tty_write->n_tty_write call chain).
The second process call the read syscall to receive data by the pty slave(with PF_PACKET socket).
The third process will wait a moment in which the first two processes will do there work and then
it call ioctl to hangup the pty pair which will cease the first two process read/write to the pty.
Before hangup the pty, the first process send data to the pty buffhead with high speed. At the same
time if the workqueue is waken up, the workqueue will do the flush_to_ldisc to pop data from pty
master's buffhead to line discipline in a loop until there is no more data left without any on one's
own schedule which will result in doing work in flush_to_ldisc for a long time. As kernel configured
without CONFIG_PREEMPT, there maybe occurs softlockup in the flush_to_ldisc. So I add cond_resched
in the flush_to_ldisc while loop to avoid it.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/tty/tty_buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index bd2d915..77b92f9 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -534,6 +534,7 @@ static void flush_to_ldisc(struct work_struct *work)
 		if (!count)
 			break;
 		head->read += count;
+		cond_resched();
 	}
 
 	mutex_unlock(&buf->lock);
-- 
1.8.3.1

