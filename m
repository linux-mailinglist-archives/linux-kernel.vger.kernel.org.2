Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB75E356D44
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241437AbhDGN1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:27:38 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:61766 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbhDGN1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:27:36 -0400
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 137DQRCB010036;
        Wed, 7 Apr 2021 22:26:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp);
 Wed, 07 Apr 2021 22:26:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 137DQQSg010028
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 7 Apr 2021 22:26:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: [PATCH v2] tty: use printk_deferred() at tty_msg()
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20210403041444.4081-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <YGx59PEq2Y015YdK@alley>
 <3c15d32f-c568-7f6f-fa7e-af4deb9b49f9@i-love.sakura.ne.jp>
Message-ID: <d78ae8da-16e9-38d9-e274-048c54e24360@i-love.sakura.ne.jp>
Date:   Wed, 7 Apr 2021 22:26:21 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <3c15d32f-c568-7f6f-fa7e-af4deb9b49f9@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is reporting circular locking dependency due to calling printk()
with port lock held [1]. Update tty_msg() to use printk_deferred() in
order to break this dependency. Since tty_info_ratelimited() is used by
only tty_init_dev() which is called without holding port lock, just
redirect tty_info_ratelimited() to pr_info_ratelimited().

  ======================================================
  WARNING: possible circular locking dependency detected
  5.12.0-rc6-syzkaller #0 Not tainted
  ------------------------------------------------------
  syz-executor.4/2155 is trying to acquire lock:
  ffffffff8be805a0 (console_owner){....}-{0:0}, at: console_unlock+0x2f2/0xc80 kernel/printk/printk.c:2551

  but task is already holding lock:
  ffffffff90114698 (&port->lock){-.-.}-{2:2}, at: tty_port_close_start.part.0+0x28/0x550 drivers/tty/tty_port.c:567

  which lock already depends on the new lock.

  the existing dependency chain (in reverse order) is:

  -> #2 (&port->lock){-.-.}-{2:2}:
         __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
         _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:159
         tty_port_tty_get+0x1f/0x100 drivers/tty/tty_port.c:288
         tty_port_default_wakeup+0x11/0x40 drivers/tty/tty_port.c:47
         serial8250_tx_chars+0x487/0xa80 drivers/tty/serial/8250/8250_port.c:1832
         serial8250_handle_irq.part.0+0x328/0x3d0 drivers/tty/serial/8250/8250_port.c:1919
         serial8250_handle_irq drivers/tty/serial/8250/8250_port.c:1892 [inline]
         serial8250_default_handle_irq+0xb2/0x220 drivers/tty/serial/8250/8250_port.c:1935
         serial8250_interrupt+0xfd/0x200 drivers/tty/serial/8250/8250_core.c:126
         __handle_irq_event_percpu+0x303/0x8f0 kernel/irq/handle.c:156
         handle_irq_event_percpu kernel/irq/handle.c:196 [inline]
         handle_irq_event+0x102/0x290 kernel/irq/handle.c:213
         handle_edge_irq+0x25f/0xd00 kernel/irq/chip.c:819
         generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
         handle_irq arch/x86/kernel/irq.c:231 [inline]
         __common_interrupt+0x9e/0x200 arch/x86/kernel/irq.c:250
         common_interrupt+0x9f/0xd0 arch/x86/kernel/irq.c:240
         asm_common_interrupt+0x1e/0x40 arch/x86/include/asm/idtentry.h:623
         __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:161 [inline]
         _raw_spin_unlock_irqrestore+0x38/0x70 kernel/locking/spinlock.c:191
         spin_unlock_irqrestore include/linux/spinlock.h:409 [inline]
         uart_write+0x30d/0x570 drivers/tty/serial/serial_core.c:615
         do_output_char+0x5de/0x850 drivers/tty/n_tty.c:443
         process_output drivers/tty/n_tty.c:510 [inline]
         n_tty_write+0x4c3/0xfd0 drivers/tty/n_tty.c:2365
         do_tty_write drivers/tty/tty_io.c:1043 [inline]
         file_tty_write.constprop.0+0x526/0x910 drivers/tty/tty_io.c:1133
         redirected_tty_write+0xa1/0xc0 drivers/tty/tty_io.c:1140
         call_write_iter include/linux/fs.h:1977 [inline]
         do_iter_readv_writev+0x46f/0x740 fs/read_write.c:740
         do_iter_write+0x188/0x670 fs/read_write.c:866
         vfs_writev+0x1aa/0x630 fs/read_write.c:939
         do_writev+0x139/0x300 fs/read_write.c:982
         do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
         entry_SYSCALL_64_after_hwframe+0x44/0xae

  -> #1 (&port_lock_key){-.-.}-{2:2}:
         __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
         _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:159
         serial8250_console_write+0x8b2/0xae0 drivers/tty/serial/8250/8250_port.c:3292
         call_console_drivers kernel/printk/printk.c:1862 [inline]
         console_unlock+0x895/0xc80 kernel/printk/printk.c:2576
         vprintk_emit+0x1ca/0x560 kernel/printk/printk.c:2098
         vprintk_func+0x8d/0x1e0 kernel/printk/printk_safe.c:401
         printk+0xba/0xed kernel/printk/printk.c:2146
         register_console kernel/printk/printk.c:2927 [inline]
         register_console+0x606/0x840 kernel/printk/printk.c:2807
         univ8250_console_init+0x3a/0x46 drivers/tty/serial/8250/8250_core.c:690
         console_init+0x3c7/0x596 kernel/printk/printk.c:3027
         start_kernel+0x306/0x496 init/main.c:993
         secondary_startup_64_no_verify+0xb0/0xbb

  -> #0 (console_owner){....}-{0:0}:
         check_prev_add kernel/locking/lockdep.c:2936 [inline]
         check_prevs_add kernel/locking/lockdep.c:3059 [inline]
         validate_chain kernel/locking/lockdep.c:3674 [inline]
         __lock_acquire+0x2b14/0x54c0 kernel/locking/lockdep.c:4900
         lock_acquire kernel/locking/lockdep.c:5510 [inline]
         lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5475
         console_lock_spinning_enable kernel/printk/printk.c:1714 [inline]
         console_unlock+0x371/0xc80 kernel/printk/printk.c:2573
         vprintk_emit+0x1ca/0x560 kernel/printk/printk.c:2098
         vprintk_func+0x8d/0x1e0 kernel/printk/printk_safe.c:401
         printk+0xba/0xed kernel/printk/printk.c:2146
         tty_port_close_start.part.0+0x503/0x550 drivers/tty/tty_port.c:569
         tty_port_close_start drivers/tty/tty_port.c:641 [inline]
         tty_port_close+0x46/0x170 drivers/tty/tty_port.c:634
         tty_release+0x45e/0x1210 drivers/tty/tty_io.c:1779
         __fput+0x288/0x920 fs/file_table.c:280
         task_work_run+0xdd/0x1a0 kernel/task_work.c:140
         exit_task_work include/linux/task_work.h:30 [inline]
         do_exit+0xbfc/0x2a60 kernel/exit.c:825
         do_group_exit+0x125/0x310 kernel/exit.c:922
         get_signal+0x47f/0x2150 kernel/signal.c:2781
         arch_do_signal_or_restart+0x2a8/0x1eb0 arch/x86/kernel/signal.c:789
         handle_signal_work kernel/entry/common.c:147 [inline]
         exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
         exit_to_user_mode_prepare+0x148/0x250 kernel/entry/common.c:208
         __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
         syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:301
         entry_SYSCALL_64_after_hwframe+0x44/0xae

  other info that might help us debug this:

  Chain exists of:
    console_owner --> &port_lock_key --> &port->lock

   Possible unsafe locking scenario:

         CPU0                    CPU1
         ----                    ----
    lock(&port->lock);
                                 lock(&port_lock_key);
                                 lock(&port->lock);
    lock(console_owner);

   *** DEADLOCK ***

  3 locks held by syz-executor.4/2155:
   #0: ffff88802ce391c0 (&tty->legacy_mutex){+.+.}-{3:3}, at: tty_lock+0xbd/0x120 drivers/tty/tty_mutex.c:19
   #1: ffffffff90114698 (&port->lock){-.-.}-{2:2}, at: tty_port_close_start.part.0+0x28/0x550 drivers/tty/tty_port.c:567
   #2: ffffffff8bf60920 (console_lock){+.+.}-{0:0}, at: vprintk_func+0x8d/0x1e0 kernel/printk/printk_safe.c:401

  stack backtrace:
  CPU: 0 PID: 2155 Comm: syz-executor.4 Not tainted 5.12.0-rc6-syzkaller #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
  Call Trace:
   __dump_stack lib/dump_stack.c:79 [inline]
   dump_stack+0x141/0x1d7 lib/dump_stack.c:120
   check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2127
   check_prev_add kernel/locking/lockdep.c:2936 [inline]
   check_prevs_add kernel/locking/lockdep.c:3059 [inline]
   validate_chain kernel/locking/lockdep.c:3674 [inline]
   __lock_acquire+0x2b14/0x54c0 kernel/locking/lockdep.c:4900
   lock_acquire kernel/locking/lockdep.c:5510 [inline]
   lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5475
   console_lock_spinning_enable kernel/printk/printk.c:1714 [inline]
   console_unlock+0x371/0xc80 kernel/printk/printk.c:2573
   vprintk_emit+0x1ca/0x560 kernel/printk/printk.c:2098
   vprintk_func+0x8d/0x1e0 kernel/printk/printk_safe.c:401
   printk+0xba/0xed kernel/printk/printk.c:2146
   tty_port_close_start.part.0+0x503/0x550 drivers/tty/tty_port.c:569
   tty_port_close_start drivers/tty/tty_port.c:641 [inline]
   tty_port_close+0x46/0x170 drivers/tty/tty_port.c:634
   tty_release+0x45e/0x1210 drivers/tty/tty_io.c:1779
   __fput+0x288/0x920 fs/file_table.c:280
   task_work_run+0xdd/0x1a0 kernel/task_work.c:140
   exit_task_work include/linux/task_work.h:30 [inline]
   do_exit+0xbfc/0x2a60 kernel/exit.c:825
   do_group_exit+0x125/0x310 kernel/exit.c:922
   get_signal+0x47f/0x2150 kernel/signal.c:2781
   arch_do_signal_or_restart+0x2a8/0x1eb0 arch/x86/kernel/signal.c:789
   handle_signal_work kernel/entry/common.c:147 [inline]
   exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
   exit_to_user_mode_prepare+0x148/0x250 kernel/entry/common.c:208
   __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
   syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:301
   entry_SYSCALL_64_after_hwframe+0x44/0xae

Note that this patch has a small side effect that 5 tty_debug() messages
in __proc_set_tty()/tty_release_checks() are enabled, for pr_debug() is
conditional while KERN_DEBUG is unconditional. It seems that remaining
tty_debug() messages meant to be unconditional without knowing that
pr_debug() is conditional.

Note that this patch is not complete, for there is same dependency due to
memory allocation fault injection at tty_buffer_alloc().

By the way, as soon as applying this patch, I guess that syzkaller starts
generating hung task reports because /dev/ttyprintk can trivially trigger
flood of

  tty_warn(tty, "%s: tty->count = 1 port count = %d\n", __func__,
           port->count);

message, and adding

  if (strcmp(tty_driver_name(tty), "ttyprintk"))

immediately before this tty_warn() gave me Tested-by: response.

[1] https://syzkaller.appspot.com/bug?id=39ea6caa479af471183997376dc7e90bc7d64a6a

Reported-by: syzbot <syzbot+43e93968b964e369db0b@syzkaller.appspotmail.com>
Reported-by: syzbot <syzbot+3ed715090790806d8b18@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: b6da31b2c07c46f2 ("tty: Fix data race in tty_insert_flip_string_fixed_flag")
Cc: <stable@vger.kernel.org> # 4.18+
---
 include/linux/tty.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index 95fc2f100f12..042d968e5d50 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -772,16 +772,16 @@ static inline void proc_tty_register_driver(struct tty_driver *d) {}
 static inline void proc_tty_unregister_driver(struct tty_driver *d) {}
 #endif
 
-#define tty_msg(fn, tty, f, ...) \
-	fn("%s %s: " f, tty_driver_name(tty), tty_name(tty), ##__VA_ARGS__)
+#define tty_msg(lv, tty, f, ...) \
+	printk_deferred(lv pr_fmt("%s %s: " f), tty_driver_name(tty), tty_name(tty), ##__VA_ARGS__)
 
-#define tty_debug(tty, f, ...)	tty_msg(pr_debug, tty, f, ##__VA_ARGS__)
-#define tty_info(tty, f, ...)	tty_msg(pr_info, tty, f, ##__VA_ARGS__)
-#define tty_notice(tty, f, ...)	tty_msg(pr_notice, tty, f, ##__VA_ARGS__)
-#define tty_warn(tty, f, ...)	tty_msg(pr_warn, tty, f, ##__VA_ARGS__)
-#define tty_err(tty, f, ...)	tty_msg(pr_err, tty, f, ##__VA_ARGS__)
+#define tty_debug(tty, f, ...)	tty_msg(KERN_DEBUG, tty, f, ##__VA_ARGS__)
+#define tty_info(tty, f, ...)	tty_msg(KERN_INFO, tty, f, ##__VA_ARGS__)
+#define tty_notice(tty, f, ...)	tty_msg(KERN_NOTICE, tty, f, ##__VA_ARGS__)
+#define tty_warn(tty, f, ...)	tty_msg(KERN_WARNING, tty, f, ##__VA_ARGS__)
+#define tty_err(tty, f, ...)	tty_msg(KERN_ERR, tty, f, ##__VA_ARGS__)
 
 #define tty_info_ratelimited(tty, f, ...) \
-		tty_msg(pr_info_ratelimited, tty, f, ##__VA_ARGS__)
+	pr_info_ratelimited("%s %s: " f, tty_driver_name(tty), tty_name(tty), ##__VA_ARGS__)
 
 #endif
-- 
2.18.4


