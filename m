Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3349407DA6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 15:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbhILN3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 09:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbhILN3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 09:29:30 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5748BC061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 06:28:16 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id c6so14598406ybm.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 06:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Sj0gDiK4nhxFby3hXNB6TOKgK1dHJdi2IB1tYBHrTts=;
        b=LYB5WSR1WUaBRaXsQoHsHo3nDySvUqmxpI8QMX3svHrzyO3J/ruyt5zNVfMCUDVwQM
         LzeJ4HdSDTHa8efeQq3L6QeQqECecG37zDA5PHoII48qdnod3LFJG6thjtMQ4Z09eBUo
         CuOsAzFAGaOBvayeFgm50hkdRin4u9J6+Dn7yWqIH53qPzdkIPnTo68MH6RmQbO0yf8G
         WC6RF4D2i8p1I0wzyp17csh9Le2kMT1KL9V+DsSclHnmcj3CmKbyPjMzjipuJ0tpdWWI
         gOQ10abY1m0jn9dUWXTrGfFLTcu0iURdZi3VSEDGclfYz3Ya7daXPMgQ5yO4R2eRH6Bp
         lJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Sj0gDiK4nhxFby3hXNB6TOKgK1dHJdi2IB1tYBHrTts=;
        b=3ik/K1fFy6NyoM2euzZEcR5Rp1hRP4/kHaUswnSYyXKkDxTx1YN+a7xCYvvwKS/Q1y
         uWf92+L4hZ8hi7Bv6GPl1rUzqoCanhVSwUTSJV0fZr/IoH74v3ok02jVuyCPC3a0y4ej
         CH80M12XGA8kmhXAQTvTrFm39r+h3Ow/3Zp63A3BKcgP4M7reoZZtjvejjJ3FsMZK6ua
         HUx/EbK4FwVuOTNY1vXYEnPw8RjUkTSOdPni/1oUiMR7JcNj4dcPxCUNVS1/rare5Qyh
         HOqBSpc2Yk9W0wtvuntNNxHUfXQj42p7UT/r9YcgrvnbNyLmnnOglrsEfhadws/iGtNP
         e84Q==
X-Gm-Message-State: AOAM5304bEJRGaNADfNu4FERmdfwDJjUAI8aWixDlgLDiqpb98zFT+Ki
        MQjnLK6JGDHDwKdgV3Zis3kHwMSrRZce7Zpu9WCKMpeEjds=
X-Google-Smtp-Source: ABdhPJw6DkgudXM+DKF/zhtX7DYmV8JYjLm2tkbCgr8XNBt/8MyskJzqgSVXGkeLRrvTtmscSnZNhTtgEc9nqutcH7o=
X-Received: by 2002:a25:ea52:: with SMTP id o18mr9623998ybe.150.1631453295337;
 Sun, 12 Sep 2021 06:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAEtum4m92ibKHY6W2hWDB8vg96HMreyoXCEPVCq137nO25E7Gg@mail.gmail.com>
 <CAEtum4m4b+q9+T7s1-ReYYa0VXwb1h+n6BKWssB=YzcJgCznaA@mail.gmail.com> <CAEtum4kzuWgCTyzUAdGwQZFxj76wnbptN-5Vf4kyv2-nTmM62w@mail.gmail.com>
In-Reply-To: <CAEtum4kzuWgCTyzUAdGwQZFxj76wnbptN-5Vf4kyv2-nTmM62w@mail.gmail.com>
From:   lixiaofeng li <lixiaofeng427@gmail.com>
Date:   Sun, 12 Sep 2021 21:28:03 +0800
Message-ID: <CAEtum4kcs-c6RHFg1+nVcc+mc7DK2QuBWg9qrR9EJDnwAKDo1w@mail.gmail.com>
Subject: Fwd: rcu stall in __d_lookup_rcu
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
      The rcu stall warming is reported randomly after the system was
uptime more than 100 days. Because it is an embedded system, the
vmcore can not be generated.  From the dumpstack of rcu stall warm,
the rcu stall was detected in __d_lookup_rcu() function.
The similar rcu stall warnings happened 6 times on different machines,
which all pointed to  d_alloc_parallel()-->__d_lookup_rcu().  Some of
them triggered the oops due to khungtaskd detection..
     And the commits 015555f and 8cc07c8 by Will Deacon  have already
been present in our linux  kernel.
Can someone help guide what the issue is and how to process this type
of issue further?

1. The linux version is 4.14.47 and the cpu is fsl,T1040RDB, 32bits.
    4.14.47+gb09b730 #1 SMP Fri Apr 2 01:34:59 UTC 2021 ppc GNU/Linux.
2. The tree rcu is used and preempt is disabled
CONFIG_TREE_RCU=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_TRACE=y

CONFIG_PREEMPT_NONE=y

3. Below is the rcu warming:
[10953024.068601] INFO: rcu_sched self-detected stall on CPU
[10953024.074035]    0-...: (59998 ticks this GP)
idle=cc2/140000000000001/0 softirq=1466139644/1466139644 fqs=14337
[10953024.084226]     (t=60000 jiffies g=872597753 c=872597752 q=83688)
[10953024.090418] Task dump for CPU 0:
[10953024.090421] pidof           R  running task     6096 29584
29580 0x00000006
[10953024.090439] Call Trace:
[10953024.090450] [e871fb00] [c00cc2f4] rcu_dump_cpu_stacks+0xa4/0x100
(unreliable)
[10953024.090465] [e871fb20] [c00cb52c] rcu_check_callbacks+0x7dc/0xa00
[10953024.090476] [e871fb90] [c00d3ec0] update_process_times+0x40/0x80
[10953024.090481] [e871fba0] [c00eccac] tick_sched_handle.isra.5+0x4c/0x70
[10953024.090486] [e871fbb0] [c00ecd44] tick_sched_timer+0x74/0x110
[10953024.090493] [e871fbd0] [c00d5698] __hrtimer_run_queues+0x138/0x380
[10953024.090499] [e871fc20] [c00d5cc8] hrtimer_interrupt+0x108/0x2c0
[10953024.090510] [e871fc60] [c000bee8] __timer_interrupt+0xf8/0x340
[10953024.090516] [e871fc90] [c000c360] timer_interrupt+0xd0/0x110
[10953024.090525] [e871fcb0] [c0013928] ret_from_except+0x0/0x18
[10953024.090537] --- interrupt: 901 at __d_lookup_rcu+0x8c/0x210
[10953024.090537]     LR = d_alloc_parallel+0xe4/0x520
[10953024.090541] [e871fd70] [c02537bc] __d_alloc+0x10c/0x230 (unreliable)
[10953024.090547] [e871fda0] [c02540b4] d_alloc_parallel+0xe4/0x520
[10953024.090556] [e871fe10] [c02ae7b0] proc_fill_cache+0x120/0x1e0
[10953024.090562] [e871fe70] [c02af940] proc_pid_readdir+0x1a0/0x300
[10953024.090567] [e871fed0] [c024c4e4] iterate_dir+0x1d4/0x240
[10953024.090572] [e871ff00] [c024cbd8] SyS_getdents+0x98/0x160
[10953024.090578] [e871ff40] [c0013278] ret_from_syscall+0x0/0x3c
[10953024.090583] --- interrupt: c01 at 0xfea2d14
[10953024.090583]     LR = 0xfea2ccc
[10953125.985432] INFO: task notfmgrd:5188 blocked for more than 120 seconds.
[10953125.992357]       Tainted: P           O    4.14.47+gb09b730 #1
[10953125.998646] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[10953126.006769] notfmgrd        D 3984  5188      1 0x00000002
[10953126.006785] Call Trace:
[10953126.006800] [e78cdad0] [c0088584]
__update_load_avg_se.isra.3+0x234/0x270 (unreliable)
[10953126.006808] [e78cdb90] [c09b8dcc] __schedule+0x2cc/0x9d0
[10953126.006813] [e78cdbf0] [c09b9508] schedule+0x38/0xc0
[10953126.006820] [e78cdc00] [c09bd6d4] schedule_timeout+0x244/0x4b0
[10953126.006826] [e78cdc50] [c09ba428] wait_for_common+0xc8/0x1c0
[10953126.006835] [e78cdc90] [c00c128c] __wait_rcu_gp+0x22c/0x240
[10953126.006844] [e78cdcd0] [c00ca284] synchronize_sched+0x54/0x90
[10953126.006861] [e78cdd00] [f46dc804] pram_notify_change+0x214/0x3b0 [pramfs]
[10953126.006872] [e78cdd40] [c02592f4] notify_change+0x1e4/0x520
[10953126.006879] [e78cdd70] [c022d9ec] do_truncate+0x7c/0x100
[10953126.006890] [e78cddc0] [c0246674] path_openat+0xf74/0x13f0
[10953126.006896] [e78cde50] [c02481e4] do_filp_open+0x74/0x100
[10953126.006902] [e78cdf00] [c022f3c0] do_sys_open+0x220/0x2c0
[10953126.006913] [e78cdf40] [c0013278] ret_from_syscall+0x0/0x3c
[10953126.006918] --- interrupt: c01 at 0xfed5eb8
[10953126.006918]     LR = 0xfed5e7c
[10953126.006921] Kernel panic - not syncing: hung_task: blocked tasks
[10953126.013201] CPU: 3 PID: 404 Comm: khungtaskd Tainted: P
 O    4.14.47+gb09b730 #1
[10953126.021740] Call Trace:
[10953126.024452] [e93b1e30] [c09a05a8] dump_stack+0x88/0xc0 (unreliable)
[10953126.030993] [e93b1e50] [c004a088] panic+0x124/0x28c
[10953126.036145] [e93b1eb0] [c0124fd8] watchdog+0x3c8/0x430
[10953126.041557] [e93b1f10] [c0072594] kthread+0x164/0x170
[10953126.046878] [e93b1f40] [c00133b0] ret_from_kernel_thread+0x5c/0x64

Thanks

regards
sky
