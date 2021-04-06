Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D2E35591A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 18:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346382AbhDFQXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 12:23:38 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50951 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346372AbhDFQXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 12:23:36 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 136GMa4S080855;
        Wed, 7 Apr 2021 01:22:36 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp);
 Wed, 07 Apr 2021 01:22:36 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 136GMaEQ080848
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 7 Apr 2021 01:22:36 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] tty: use printk_safe context at tty_msg()
To:     Petr Mladek <pmladek@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20210403041444.4081-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <YGx59PEq2Y015YdK@alley>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <3c15d32f-c568-7f6f-fa7e-af4deb9b49f9@i-love.sakura.ne.jp>
Date:   Wed, 7 Apr 2021 01:22:34 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YGx59PEq2Y015YdK@alley>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/04/07 0:10, Petr Mladek wrote:
>> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
>> index 6d4995a5f318..d59f7873bc49 100644
>> --- a/drivers/tty/tty_buffer.c
>> +++ b/drivers/tty/tty_buffer.c
>> @@ -156,6 +156,7 @@ static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
>>  {
>>  	struct llist_node *free;
>>  	struct tty_buffer *p;
>> +	unsigned long flags;
>>  
>>  	/* Round the buffer size out */
>>  	size = __ALIGN_MASK(size, TTYB_ALIGN_MASK);
>> @@ -172,7 +173,9 @@ static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
>>  	   have queued and recycle that ? */
>>  	if (atomic_read(&port->buf.mem_used) > port->buf.mem_limit)
>>  		return NULL;
>> -	p = kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC);
>> +	printk_safe_enter_irqsave(flags);
>> +	p = kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC | __GFP_NOWARN);
>> +	printk_safe_exit_irqrestore(flags);
> 
> I do not see tty_buffer_alloc() anywhere at
> https://syzkaller.appspot.com/bug?id=39ea6caa479af471183997376dc7e90bc7d64a6a
> 
> Could you please provide more details why this is needed?

Quoting from https://syzkaller.appspot.com/text?tag=CrashLog&x=131d4ddf800000 at https://syzkaller.appspot.com/bug?id=bda1a87bea05a9072003e6447c44b03ca1492b1c :

[  274.992629] FAULT_INJECTION: forcing a failure.
[  274.992629] name failslab, interval 1, probability 0, space 0, times 0
[  274.994085] CPU: 1 PID: 19187 Comm: syz-executor6 Not tainted 4.17.0+ #89
[  274.994094] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[  274.994099] Call Trace:
[  274.994120]  dump_stack+0x1b9/0x294
[  274.994145]  ? dump_stack_print_info.cold.2+0x52/0x52
[  275.270563]  should_fail.cold.4+0xa/0x1a
[  275.274639]  ? fault_create_debugfs_attr+0x1f0/0x1f0
[  275.279747]  ? graph_lock+0x170/0x170
[  275.283541]  ? check_noncircular+0x20/0x20
[  275.287788]  ? debug_check_no_locks_freed+0x310/0x310
[  275.292983]  ? lock_acquire+0x1dc/0x520
[  275.296961]  ? process_echoes+0xb6/0x170
[  275.301021]  ? check_same_owner+0x320/0x320
[  275.305347]  ? print_usage_bug+0xc0/0xc0
[  275.309404]  ? __might_sleep+0x95/0x190
[  275.313394]  ? __sanitizer_cov_trace_const_cmp8+0x18/0x20
[  275.318934]  __should_failslab+0x124/0x180
[  275.323168]  should_failslab+0x9/0x14
[  275.326974]  __kmalloc+0x63/0x760
[  275.330423]  ? mutex_trylock+0x2a0/0x2a0
[  275.334479]  ? print_usage_bug+0xc0/0xc0
[  275.338539]  ? __tty_buffer_request_room+0x2d2/0x7f0
[  275.343648]  __tty_buffer_request_room+0x2d2/0x7f0
[  275.348576]  ? flush_to_ldisc+0x560/0x560
[  275.352717]  ? lock_acquire+0x1dc/0x520
[  275.356698]  ? pty_write+0xf9/0x1f0
[  275.360325]  ? lock_release+0xa10/0xa10
[  275.364293]  ? kasan_check_read+0x11/0x20
[  275.368434]  ? do_raw_spin_unlock+0x9e/0x2e0
[  275.372831]  ? do_raw_spin_trylock+0x1b0/0x1b0
[  275.377411]  tty_insert_flip_string_fixed_flag+0x8d/0x1f0
[  275.382942]  ? do_raw_spin_lock+0xc1/0x200
[  275.387174]  pty_write+0x12c/0x1f0
[  275.390720]  tty_put_char+0x129/0x150
[  275.394525]  ? dev_match_devt+0x90/0x90
[  275.398498]  ? pty_write_room+0xc9/0xf0
[  275.402485]  ? __sanitizer_cov_trace_switch+0x53/0x90
[  275.407684]  __process_echoes+0x4d9/0x8d0
[  275.411829]  ? _raw_spin_unlock_irqrestore+0x74/0xc0
[  275.416936]  process_echoes+0xfc/0x170
[  275.420816]  n_tty_set_termios+0xb56/0xe80
[  275.425047]  ? n_tty_receive_signal_char+0x120/0x120
[  275.430148]  tty_set_termios+0x7a0/0xac0
[  275.434201]  ? tty_wait_until_sent+0x5b0/0x5b0
[  275.438782]  ? __sanitizer_cov_trace_const_cmp8+0x18/0x20
[  275.444318]  set_termios+0x41e/0x7d0
[  275.448026]  ? tty_perform_flush+0x80/0x80
[  275.452256]  ? __sanitizer_cov_trace_const_cmp8+0x18/0x20
[  275.457845]  tty_mode_ioctl+0x535/0xb50
[  275.461821]  ? set_termios+0x7d0/0x7d0
[  275.465740]  ? check_same_owner+0x320/0x320
[  275.470059]  ? graph_lock+0x170/0x170
[  275.473857]  n_tty_ioctl_helper+0x54/0x3b0
[  275.478085]  n_tty_ioctl+0x54/0x320
[  275.481711]  ? ldsem_down_read+0x37/0x40
[  275.485760]  ? ldsem_down_read+0x37/0x40
[  275.489836]  tty_ioctl+0x5e1/0x1870
[  275.493454]  ? commit_echoes+0x1d0/0x1d0
[  275.497506]  ? tty_vhangup+0x30/0x30
[  275.501212]  ? rcu_is_watching+0x85/0x140
[  275.505353]  ? rcu_report_qs_rnp+0x790/0x790
[  275.509757]  ? __fget+0x40c/0x650
[  275.513243]  ? find_held_lock+0x31/0x1c0
[  275.517439]  ? expand_files.part.8+0x9a0/0x9a0
[  275.522033]  ? kasan_check_write+0x14/0x20
[  275.526389]  ? __mutex_unlock_slowpath+0x180/0x8a0
[  275.531314]  ? wait_for_completion+0x870/0x870
[  275.535907]  ? tty_vhangup+0x30/0x30
[  275.539616]  do_vfs_ioctl+0x1cf/0x16f0
[  275.543522]  ? ioctl_preallocate+0x2e0/0x2e0
[  275.547934]  ? fget_raw+0x20/0x20
[  275.551554]  ? __sb_end_write+0xac/0xe0
[  275.555525]  ? __sanitizer_cov_trace_const_cmp1+0x1a/0x20
[  275.561064]  ? fput+0x130/0x1a0
[  275.564345]  ? ksys_write+0x1a6/0x250
[  275.568144]  ? security_file_ioctl+0x94/0xc0
[  275.572576]  ksys_ioctl+0xa9/0xd0
[  275.576028]  __x64_sys_ioctl+0x73/0xb0
[  275.579911]  do_syscall_64+0x1b1/0x800
[  275.583789]  ? finish_task_switch+0x1ca/0x840
[  275.588301]  ? syscall_return_slowpath+0x5c0/0x5c0
[  275.593310]  ? syscall_return_slowpath+0x30f/0x5c0
[  275.598239]  ? entry_SYSCALL_64_after_hwframe+0x59/0xbe
[  275.603605]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  275.608463]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  275.613649] RIP: 0033:0x4559f9
[  275.616823] Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00 
[  275.636056] RSP: 002b:00007f7ad0e91c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  275.643775] RAX: ffffffffffffffda RBX: 00007f7ad0e926d4 RCX: 00000000004559f9
[  275.651034] RDX: 0000000020002000 RSI: 0000000000005403 RDI: 0000000000000015
[  275.658293] RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
[  275.665554] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000016
[  275.672819] R13: 00000000004be500 R14: 00000000004ccad8 R15: 0000000000000000
[  275.680137] CPU: 0 PID: 19202 Comm: syz-executor2 Not tainted 4.17.0+ #89
[  275.680139] 
[  275.680149] ======================================================
[  275.680154] WARNING: possible circular locking dependency detected
[  275.680156] 4.17.0+ #89 Not tainted
[  275.680160] ------------------------------------------------------
[  275.680163] syz-executor6/19187 is trying to acquire lock:
[  275.680165] 000000006e810651 (console_owner){-.-.}, at: vprintk_emit+0x826/0xde0
[  275.680175] 
[  275.680178] but task is already holding lock:
[  275.680181] 000000004ec3be2c (&(&port->lock)->rlock){-.-.}, at: pty_write+0xf9/0x1f0
[  275.680192] 
[  275.680196] which lock already depends on the new lock.
[  275.680197] 
[  275.680199] 
[  275.680203] the existing dependency chain (in reverse order) is:
[  275.680205] 
[  275.680207] -> #2 (&(&port->lock)->rlock){-.-.}:
[  275.680219]        _raw_spin_lock_irqsave+0x96/0xc0
[  275.680222]        tty_port_tty_get+0x20/0x80
[  275.680226]        tty_port_default_wakeup+0x15/0x40
[  275.680230]        tty_port_tty_wakeup+0x5d/0x70
[  275.680233]        uart_write_wakeup+0x44/0x60
[  275.680237]        serial8250_tx_chars+0x4be/0xb60
[  275.680241]        serial8250_handle_irq.part.25+0x1ee/0x280
[  275.680245]        serial8250_default_handle_irq+0xc8/0x150
[  275.680248]        serial8250_interrupt+0xfa/0x1d0
[  275.680252]        __handle_irq_event_percpu+0x1c0/0xad0
[  275.680256]        handle_irq_event_percpu+0x98/0x1c0
[  275.680259]        handle_irq_event+0xa7/0x135
[  275.680262]        handle_edge_irq+0x20f/0x870
[  275.680265]        handle_irq+0x18c/0x2e7
[  275.680268]        do_IRQ+0x78/0x190
[  275.680271]        ret_from_intr+0x0/0x1e
[  275.680274]        native_safe_halt+0x6/0x10
[  275.680277]        default_idle+0xc2/0x440
[  275.680280]        arch_cpu_idle+0x10/0x20
[  275.680283]        default_idle_call+0x6d/0x90
[  275.680286]        do_idle+0x395/0x560
[  275.680289]        cpu_startup_entry+0x104/0x120
[  275.680293]        start_secondary+0x42b/0x5c0
[  275.680296]        secondary_startup_64+0xa5/0xb0
[  275.680298] 
[  275.680300] -> #1 (&port_lock_key){-.-.}:
[  275.680312]        _raw_spin_lock_irqsave+0x96/0xc0
[  275.680315]        serial8250_console_write+0x8d5/0xb00
[  275.680319]        univ8250_console_write+0x5f/0x70
[  275.680322]        console_unlock+0xa9d/0x10a0
[  275.680325]        vprintk_emit+0x6b2/0xde0
[  275.680329]        vprintk_default+0x28/0x30
[  275.680332]        vprintk_func+0x7a/0xe7
[  275.680335]        printk+0x9e/0xba
[  275.680338]        register_console+0x7e7/0xc00
[  275.680341]        univ8250_console_init+0x3f/0x4b
[  275.680344]        console_init+0x6d9/0xa38
[  275.680348]        start_kernel+0x608/0x92d
[  275.680351]        x86_64_start_reservations+0x29/0x2b
[  275.680354]        x86_64_start_kernel+0x76/0x79
[  275.680358]        secondary_startup_64+0xa5/0xb0
[  275.680359] 
[  275.680361] -> #0 (console_owner){-.-.}:
[  275.680372]        lock_acquire+0x1dc/0x520
[  275.680375]        vprintk_emit+0x884/0xde0
[  275.680379]        vprintk_default+0x28/0x30
[  275.680382]        vprintk_func+0x7a/0xe7
[  275.680384]        printk+0x9e/0xba
[  275.680388]        should_fail+0x97a/0xbcd
[  275.680391]        __should_failslab+0x124/0x180
[  275.680394]        should_failslab+0x9/0x14
[  275.680397]        __kmalloc+0x63/0x760
[  275.680401]        __tty_buffer_request_room+0x2d2/0x7f0
[  275.680405]        tty_insert_flip_string_fixed_flag+0x8d/0x1f0
[  275.680408]        pty_write+0x12c/0x1f0
[  275.680411]        tty_put_char+0x129/0x150
[  275.680414]        __process_echoes+0x4d9/0x8d0
[  275.680418]        process_echoes+0xfc/0x170
[  275.680421]        n_tty_set_termios+0xb56/0xe80
[  275.680424]        tty_set_termios+0x7a0/0xac0
[  275.680427]        set_termios+0x41e/0x7d0
[  275.680430]        tty_mode_ioctl+0x535/0xb50
[  275.680434]        n_tty_ioctl_helper+0x54/0x3b0
[  275.680437]        n_tty_ioctl+0x54/0x320
[  275.680440]        tty_ioctl+0x5e1/0x1870
[  275.680443]        do_vfs_ioctl+0x1cf/0x16f0
[  275.680446]        ksys_ioctl+0xa9/0xd0
[  275.680449]        __x64_sys_ioctl+0x73/0xb0
[  275.680452]        do_syscall_64+0x1b1/0x800
[  275.680456]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  275.680458] 
[  275.680461] other info that might help us debug this:
[  275.680463] 
[  275.680466] Chain exists of:
[  275.680467]   console_owner --> &port_lock_key --> &(&port->lock)->rlock
[  275.680482] 
[  275.680485]  Possible unsafe locking scenario:
[  275.680487] 
[  275.680490]        CPU0                    CPU1
[  275.680493]        ----                    ----
[  275.680495]   lock(&(&port->lock)->rlock);
[  275.680503]                                lock(&port_lock_key);
[  275.680511]                                lock(&(&port->lock)->rlock);
[  275.680517]   lock(console_owner);
[  275.680524] 
[  275.680526]  *** DEADLOCK ***
[  275.680528] 
[  275.680531] 5 locks held by syz-executor6/19187:
[  275.680533]  #0: 000000007080a3ba (&tty->ldisc_sem){++++}, at: ldsem_down_read+0x37/0x40
[  275.680547]  #1: 000000006fe00659 (&o_tty->termios_rwsem/1){++++}, at: tty_set_termios+0xfd/0xac0
[  275.680563]  #2: 000000007080a3ba (&tty->ldisc_sem){++++}, at: tty_ldisc_ref+0x22/0x90
[  275.680576]  #3: 00000000f8d1ab16 (&ldata->output_lock){+.+.}, at: process_echoes+0xb6/0x170
[  275.680589]  #4: 000000004ec3be2c (&(&port->lock)->rlock){-.-.}, at: pty_write+0xf9/0x1f0
[  275.680603] 
[  275.680605] stack backtrace:
[  275.680610] CPU: 1 PID: 19187 Comm: syz-executor6 Not tainted 4.17.0+ #89
[  275.680616] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[  275.680618] Call Trace:
[  275.680621]  dump_stack+0x1b9/0x294
[  275.680625]  ? dump_stack_print_info.cold.2+0x52/0x52
[  275.680628]  ? vprintk_func+0xd0/0xe7
[  275.680632]  print_circular_bug.isra.36.cold.56+0x1bd/0x27d
[  275.680636]  ? save_trace+0xe0/0x290
[  275.680639]  __lock_acquire+0x343e/0x5140
[  275.680643]  ? debug_check_no_locks_freed+0x310/0x310
[  275.680646]  ? check_noncircular+0x20/0x20
[  275.680649]  ? dentry_name+0x687/0x930
[  275.680653]  ? restricted_pointer+0x400/0x400
[  275.680656]  ? __lock_acquire+0x7f5/0x5140
[  275.680659]  ? print_usage_bug+0xc0/0xc0
[  275.680662]  ? graph_lock+0x170/0x170
[  275.680665]  ? graph_lock+0x170/0x170
[  275.680668]  ? graph_lock+0x170/0x170
[  275.680672]  ? find_held_lock+0x36/0x1c0
[  275.680675]  lock_acquire+0x1dc/0x520
[  275.680678]  ? vprintk_emit+0x826/0xde0
[  275.680681]  ? lock_release+0xa10/0xa10
[  275.680684]  ? kasan_check_read+0x11/0x20
[  275.680687]  ? do_raw_spin_unlock+0x9e/0x2e0
[  275.680691]  ? do_raw_spin_trylock+0x1b0/0x1b0
[  275.680694]  ? kasan_check_write+0x14/0x20
[  275.680698]  ? do_raw_spin_lock+0xc1/0x200
[  275.680701]  vprintk_emit+0x884/0xde0
[  275.680704]  ? vprintk_emit+0x826/0xde0
[  275.680707]  ? wake_up_klogd+0x100/0x100
[  275.680711]  ? debug_check_no_locks_freed+0x310/0x310
[  275.680714]  ? print_usage_bug+0xc0/0xc0
[  275.680717]  ? print_usage_bug+0xc0/0xc0
[  275.680720]  vprintk_default+0x28/0x30
[  275.680723]  vprintk_func+0x7a/0xe7
[  275.680726]  printk+0x9e/0xba
[  275.680730]  ? kmsg_dump_rewind_nolock+0xe4/0xe4
[  275.680733]  should_fail+0x97a/0xbcd
[  275.680737]  ? fault_create_debugfs_attr+0x1f0/0x1f0
[  275.680740]  ? graph_lock+0x170/0x170
[  275.680743]  ? check_noncircular+0x20/0x20
[  275.680747]  ? debug_check_no_locks_freed+0x310/0x310
[  275.680750]  ? lock_acquire+0x1dc/0x520
[  275.680753]  ? process_echoes+0xb6/0x170
[  275.680757]  ? check_same_owner+0x320/0x320
[  275.680760]  ? print_usage_bug+0xc0/0xc0
[  275.680763]  ? __might_sleep+0x95/0x190
[  275.680767]  ? __sanitizer_cov_trace_const_cmp8+0x18/0x20
[  275.680770]  __should_failslab+0x124/0x180
[  275.680774]  should_failslab+0x9/0x14
[  275.680776]  __kmalloc+0x63/0x760
[  275.680780]  ? mutex_trylock+0x2a0/0x2a0
[  275.680783]  ? print_usage_bug+0xc0/0xc0
[  275.680787]  ? __tty_buffer_request_room+0x2d2/0x7f0
[  275.680790]  __tty_buffer_request_room+0x2d2/0x7f0
[  275.680794]  ? flush_to_ldisc+0x560/0x560
[  275.680797]  ? lock_acquire+0x1dc/0x520
[  275.680800]  ? pty_write+0xf9/0x1f0
[  275.680803]  ? lock_release+0xa10/0xa10
[  275.680806]  ? kasan_check_read+0x11/0x20
[  275.680810]  ? do_raw_spin_unlock+0x9e/0x2e0
[  275.680813]  ? do_raw_spin_trylock+0x1b0/0x1b0
[  275.680817]  tty_insert_flip_string_fixed_flag+0x8d/0x1f0
[  275.680821]  ? do_raw_spin_lock+0xc1/0x200
[  275.680823]  pty_write+0x12c/0x1f0
[  275.680827]  tty_put_char+0x129/0x150
[  275.680830]  ? dev_match_devt+0x90/0x90
[  275.680833]  ? pty_write_room+0xc9/0xf0
[  275.680837]  ? __sanitizer_cov_trace_switch+0x53/0x90
[  275.680840]  __process_echoes+0x4d9/0x8d0
[  275.680844]  ? _raw_spin_unlock_irqrestore+0x74/0xc0
[  275.680847]  process_echoes+0xfc/0x170
[  275.680850]  n_tty_set_termios+0xb56/0xe80
[  275.680854]  ? n_tty_receive_signal_char+0x120/0x120
[  275.680857]  tty_set_termios+0x7a0/0xac0
[  275.680861]  ? tty_wait_until_sent+0x5b0/0x5b0
[  275.680865]  ? __sanitizer_cov_trace_const_cmp8+0x18/0x20
[  275.680868]  set_termios+0x41e/0x7d0
[  275.680871]  ? tty_perform_flush+0x80/0x80
[  275.680875]  ? __sanitizer_cov_trace_const_cmp8+0x18/0x20
[  275.680878]  tty_mode_ioctl+0x535/0xb50
[  275.680881]  ? set_termios+0x7d0/0x7d0
[  275.680885]  ? check_same_owner+0x320/0x320
[  275.680887]  ? graph_lock+0x170/0x170
[  275.680891]  n_tty_ioctl_helper+0x54/0x3b0
[  275.680894]  n_tty_ioctl+0x54/0x320
[  275.680897]  ? ldsem_down_read+0x37/0x40
[  275.680900]  ? ldsem_down_read+0x37/0x40
[  275.680903]  tty_ioctl+0x5e1/0x1870
[  275.680906]  ? commit_echoes+0x1d0/0x1d0
[  275.680909]  ? tty_vhangup+0x30/0x30
[  275.680913]  ? rcu_is_watching+0x85/0x140
[  275.680916]  ? rcu_report_qs_rnp+0x790/0x790
[  275.680919]  ? __fget+0x40c/0x650
[  275.680922]  ? find_held_lock+0x31/0x1c0
[  275.680926]  ? expand_files.part.8+0x9a0/0x9a0
[  275.680929]  ? kasan_check_write+0x14/0x20
[  275.680933]  ? __mutex_unlock_slowpath+0x180/0x8a0
[  275.680936]  ? wait_for_completion+0x870/0x870
[  275.680939]  ? tty_vhangup+0x30/0x30
[  275.680942]  do_vfs_ioctl+0x1cf/0x16f0
[  275.680945]  ? ioctl_preallocate+0x2e0/0x2e0
[  275.680948]  ? fget_raw+0x20/0x20
[  275.680951]  ? __sb_end_write+0xac/0xe0
[  275.680955]  ? __sanitizer_cov_trace_const_cmp1+0x1a/0x20
[  275.680958]  ? fput+0x130/0x1a0
[  275.680961]  ? ksys_write+0x1a6/0x250
[  275.680965]  ? security_file_ioctl+0x94/0xc0
[  275.680968]  ksys_ioctl+0xa9/0xd0
[  275.680970]  __x64_sys_ioctl+0x73/0xb0
[  275.680974]  do_syscall_64+0x1b1/0x800
[  275.680977]  ? finish_task_switch+0x1ca/0x840
[  275.680981]  ? syscall_return_slowpath+0x5c0/0x5c0
[  275.680984]  ? syscall_return_slowpath+0x30f/0x5c0
[  275.680988]  ? entry_SYSCALL_64_after_hwframe+0x59/0xbe
[  275.680992]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  275.680996]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  275.680999] RIP: 0033:0x4559f9
[  275.681001] Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff

>>  /*
>> @@ -773,7 +774,13 @@ static inline void proc_tty_unregister_driver(struct tty_driver *d) {}
>>  #endif
>>  
>>  #define tty_msg(fn, tty, f, ...) \
>> -	fn("%s %s: " f, tty_driver_name(tty), tty_name(tty), ##__VA_ARGS__)
>> +	do {						\
>> +		unsigned long flags;			\
>> +							\
>> +		printk_safe_enter_irqsave(flags);	\
>> +		fn("%s %s: " f, tty_driver_name(tty), tty_name(tty), ##__VA_ARGS__); \
>> +		printk_safe_exit_irqrestore(flags);	\
>> +	} while (0)
> 
> There is no need to call single printk() in printk_safe() context.
> printk_deferred() is enough.

Then, regarding tty_msg() we can update

  #define tty_msg(fn, tty, f, ...) \
          fn("%s %s: " f, tty_driver_name(tty), tty_name(tty), ##__VA_ARGS__)

  #define tty_debug(tty, f, ...)  tty_msg(pr_debug, tty, f, ##__VA_ARGS__)
  #define tty_info(tty, f, ...)   tty_msg(pr_info, tty, f, ##__VA_ARGS__)
  #define tty_notice(tty, f, ...) tty_msg(pr_notice, tty, f, ##__VA_ARGS__)
  #define tty_warn(tty, f, ...)   tty_msg(pr_warn, tty, f, ##__VA_ARGS__)
  #define tty_err(tty, f, ...)    tty_msg(pr_err, tty, f, ##__VA_ARGS__)

  #define tty_info_ratelimited(tty, f, ...) \
                  tty_msg(pr_info_ratelimited, tty, f, ##__VA_ARGS__)

to use printk_deferred().

> Just note that printk_deferred()/printk_safe() is only temporary
> solution. It will get obsoleted by offloading the console handling
> to kthreads. It goes slowly because it is not trivial. We want
> to do it a clean way and carefully. Any historic or new
> workarounds/hacks would only slow it down.
> 
> My estimation is that we could have the offloaded consoles
> within the next 3-4 development cycles.
> 
> Please, consider whether it is really worth adding these workarounds.

1000+ days have elapsed since this problem was reported. Given that
offloading the console handling to kthreads needs big changes which
are not suitable for backporting, what can we offer for current and
stable kernels?

