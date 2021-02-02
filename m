Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEC430C756
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237325AbhBBRRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236140AbhBBROW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:14:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB003C061786
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 09:13:42 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612286021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iZnDnGN6Nqh9IQDCt9rgVBHu3N60IWcA9dxTuagGxdE=;
        b=DYFy/RGiU4JPvUc9+htW8LQi4hT15UGsSK4ntVvDNen0l8NVThKWyRMvoSmRHji2d5TRoY
        ngJnlU4TiOwmNlEoeqZCQaGmRcpvlWlDZTiylWO+FEYn2rE5nsfGTbtGaa+H4a6sWWHJBf
        ofcl5lWVwp453y0A/+XL+dbN0yybSRWPQ9msP4wAReP9iNzNlwYExgwmArqEjRziozCeeN
        zpqrycmUFFg+x93pYusPr3rmtg3108bmL6K+09f+t7gUMiGXaMamCUvzfijWFk8q0l4xEt
        1VPctWclyyKd+jPS74qiIMJ4M5EJyWvd7DAWw6K1x+c/hamncagMuiSqiSBcQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612286021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iZnDnGN6Nqh9IQDCt9rgVBHu3N60IWcA9dxTuagGxdE=;
        b=meCfLMQnDirchwZYercWfnfai/baV2P37liWY7YH5PKRMQroQF24v+ooJqWn9zsvxzMglI
        hotKs+1eEwt/2yCA==
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, zhengjun.xing@linux.intel.com
Subject: Re: [printk]  b031a684bf: INFO:rcu_tasks_detected_stalls_on_tasks
In-Reply-To: <20210122081311.GA12834@xsang-OptiPlex-9020>
References: <20210122081311.GA12834@xsang-OptiPlex-9020>
Date:   Tue, 02 Feb 2021 18:19:40 +0106
Message-ID: <8735yev1dn.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-22, kernel test robot <oliver.sang@intel.com> wrote:
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: b031a684bfd01d633c79d281bd0cf11c2f834ada ("printk: remove logbuf_lock writer-protection of ringbuffer")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

I am still investigating this in my spare cycles. I have tried to reduce
the changes to determine what is causing the problem.

For example, instead of applying the problematic commit, I can reproduce
the problem with:

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 150bfde41ba1..17a92a76cae2 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1943,7 +1943,10 @@ int vprintk_store(int facility, int level,
 	 * prb_reserve_in_last() and prb_reserve() purposely invalidate the
 	 * structure when they fail.
 	 */
-	prb_rec_init_wr(&r, text_len);
+	if (text_len < 200)
+		prb_rec_init_wr(&r, 200);
+	else
+		prb_rec_init_wr(&r, text_len);
 	if (!prb_reserve(&e, prb, &r)) {
 		/* truncate the message if it is too long for empty buffer */
 		truncate_msg(&text_len, &trunc_msg_len);

which simply makes sure at least 200-byte datablocks are allocated. This
totally different change causes the _exact_ same rcu stall
behavior/pattern as the problematic commit that is removing spinlock
usage. That pattern is:

1. printk() is getting called about 65 times a second with:

   "tasks-torture:torture_onoff task: online 0 failed: errno -5"

2. About 60 seconds after "rmmod rcutorture" is called, the following
ruc warning appears:

[  390.440235] ??? Writer stall state RTWS_SYNC(7) g0 f0x0 ->state 0x2 cpu 1
[  390.441250] task:rcu_torture_wri state:D stack:    0 pid:  505 ppid:     2 flags:0x00004000
[  390.442473] Call Trace:
[  390.442938]  __schedule+0xa12/0xab5
[  390.443495]  ? firmware_map_remove+0xd1/0xd1
[  390.444151]  ? ttwu_do_wakeup+0x1d/0x2dd
[  390.444764]  schedule+0x16c/0x1df
[  390.445311]  schedule_timeout+0x77/0x1b4
[  390.445911]  ? usleep_range+0x130/0x130
[  390.446522]  ? do_raw_spin_lock+0x74/0xbf
[  390.447180]  ? queued_read_unlock+0x19/0x19
[  390.447825]  ? __prepare_to_swait+0xa4/0x141
[  390.448491]  __wait_for_common+0x22d/0x337
[  390.449139]  ? usleep_range+0x130/0x130
[  390.450860]  ? _raw_spin_lock_irqsave+0x81/0xd1
[  390.451543]  ? bit_wait_io_timeout+0x8a/0x8a
[  390.452196]  __wait_rcu_gp+0x20d/0x229
[  390.452788]  synchronize_rcu_tasks_generic.isra.0+0x7e/0xb2
[  390.453604]  ? rcu_tasks_rude_wait_gp+0x3d/0x3d
[  390.454334]  ? call_rcu_tasks_generic+0x134/0x134
[  390.455055]  ? rcu_torture_alloc+0x50/0xbc [rcutorture]
[  390.455847]  ? rcu_unexpedite_gp+0x19/0x19
[  390.456488]  ? delay_tsc+0x41/0x7c
[  390.457053]  rcu_torture_writer+0x815/0xaea [rcutorture]
[  390.457889]  ? rcu_torture_pipe_update+0x100/0x100 [rcutorture]
[  390.458801]  ? test_bit+0x15/0x1f
[  390.459349]  ? __kthread_parkme+0xb2/0x142
[  390.459968]  kthread+0x2ff/0x30e
[  390.460539]  ? rcu_torture_pipe_update+0x100/0x100 [rcutorture]
[  390.461408]  ? kthread_create_worker_on_cpu+0xce/0xce
[  390.462171]  ret_from_fork+0x22/0x30

3. About 9 minutes later, 2 stalls are reported:

[  926.880657] INFO: rcu_tasks detected stalls on tasks:
[  926.881387] 000000003a288f24: .. nvcsw: 0/0 holdout: 1 idle_cpu: -1/1
[  926.882313] task:dmesg           state:R  running task     stack:    0 pid: 1717 ppid:   497 flags:0x20020000
[  926.883727] Call Trace:
[  926.884148]  __schedule+0xa12/0xab5
[  926.884706]  ? firmware_map_remove+0xd1/0xd1
[  926.885355]  ? ksys_read+0x116/0x150
[  926.885930]  schedule+0x16c/0x1df
[  926.886458]  exit_to_user_mode_loop+0x28/0x84
[  926.887123]  exit_to_user_mode_prepare+0x1d/0x4a
[  926.887823]  syscall_exit_to_user_mode+0x41/0x4f
[  926.888513]  entry_INT80_compat+0x71/0x76
[  926.889131] RIP: 0023:0xf7fcca02
[  926.889658] RSP: 002b:00000000ffd230c4 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[  926.890780] RAX: 0000000000000050 RBX: 0000000000000004 RCX: 0000000056601234
[  926.891720] RDX: 0000000000001fff RSI: 00000000000001e0 RDI: 0000000056601234
[  926.892724] RBP: 00000000ffd231d8 R08: 0000000000000000 R09: 0000000000000000
[  926.893733] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  926.894745] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

and

[  926.931950] 00000000a4109e4e: .. nvcsw: 21326/21326 holdout: 1 idle_cpu: -1/1
[  926.932883] task:dmesg           state:R  running task     stack:    0 pid:  447 ppid:   442 flags:0x20020000
[  926.934286] Call Trace:
[  926.934714]  __schedule+0xa12/0xab5
[  926.935268]  ? firmware_map_remove+0xd1/0xd1
[  926.935919]  ? ksys_read+0x116/0x150
[  926.936478]  schedule+0x16c/0x1df
[  926.937012]  exit_to_user_mode_loop+0x28/0x84
[  926.937674]  exit_to_user_mode_prepare+0x1d/0x4a
[  926.938363]  syscall_exit_to_user_mode+0x41/0x4f
[  926.939059]  entry_INT80_compat+0x71/0x76
[  926.939680] RIP: 0023:0xf7f9da02
[  926.940193] RSP: 002b:00000000ffdb2864 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[  926.941301] RAX: ffffffffffffffe0 RBX: 0000000000000003 RCX: 0000000056659234
[  926.942307] RDX: 0000000000001fff RSI: 00000000000001e0 RDI: 0000000056659234
[  926.943312] RBP: 00000000ffffffff R08: 0000000000000000 R09: 0000000000000000
[  926.944313] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  926.945314] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

This pattern is _always_ the same (using either my simple change or with
the problematic commit applied). Obviously the removal of the spinlock
usage is not the issue. But I am concerned that the ringbuffer is
somehow involved. I have tried to reproduce this problem doing
non-ringbuffer activity, but have not had success.

Also, the problem disappears if a newer kernel is used. So maybe there
was something fixed in rcu or an rcu user. But still, it is very odd
that the ringbuffer is triggering it.

I will continue investigating this.

Also, I plan to send a patch to lkp so that the test script is not
doing:

    dmesg > /dev/kmsg

Although this may be a great test for printk, for rcutorture it would be
more appropriate to do something like:

    dmesg > /tmpfile
    cat /tmpfile > /dev/kmsg

to avoid the endless read/feed cycle.

John Ogness
