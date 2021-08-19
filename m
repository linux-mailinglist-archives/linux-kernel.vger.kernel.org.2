Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CCE3F1E64
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhHSQzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhHSQyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:54:49 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA8AC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 09:54:12 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id o20so9298300oiw.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 09:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2Fm/k3knRfhwkSDXJuuwpFcbW7KSmYVRVnmz8kqStnc=;
        b=DLEJ3pLhbm5W3bzg7E5Jk9mceVqcoiEqY81g09/16XSqyFTkBo7Bce9g882Pbrd0pc
         /fmKFRXjdh4gkVqWu7mhZfRHZhqIe/pGKE89/JnoHuapPdEP7uiumvzT/SBHnL6vIoqd
         MpAm+QwyoovhWHMEbttjUsUkv97SHYRLcDOQjQXCg8mmXtKke15S8u3dJi5iWb6Pudl/
         Wzoom/HQQiKnd8HGwsYxKne+k7tpmTRXcLQ/+HFF8wgEv0kxNX7UbdRa95v9kRi+sBum
         bp9Xg83X9LrW9kmdq5KrpPYfYMPsVAJYRVyXP+EqlkWmgKc0NlbPpJwyzekSXIfX/ncR
         Efog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2Fm/k3knRfhwkSDXJuuwpFcbW7KSmYVRVnmz8kqStnc=;
        b=i+RV8YZk8FSkp4V5zlH0mtkOxZzfjo1n4Devk5prp9ixR/pVSgLUqG1phkicKDPR8R
         Qx8S77ld/IQo1/0sAlEMX4hb3B5hE+gIXHfrT9ErY2UwinoQZD3HolSdBm5ZJyJ37fjL
         uQTHFAGWFexRZcvsOkPJS6Cj1OS4kmUH/Of6Itq/xDlSllpiRDByAceHLhPksBWKintm
         D82Sz/ENSDBV7vtjyrfj9fIBqYdBFOOu4aWyoEYOeagnfaTrL4ZYzf20J4msTjeEqp3l
         XEh6IZNKfCI/FCA3Q97D++mh8JKfkatcY6HzOWYMBjApOc/qBve7GFJFs92Zq7goF7bd
         OXpA==
X-Gm-Message-State: AOAM531WCnXcKPErCmBIkiVQd2bIwkapz+VKSXzWGJiPa+ZU9cKWy098
        jT+SwqbrBX4xlMsTxOZtqRs=
X-Google-Smtp-Source: ABdhPJyQx+6MwvU6hO3vu0IE+13oQ3PQwXqGyKAa2WQtEzRvhuJTWsMbqlcIBZeblav05XMOlDrxOA==
X-Received: by 2002:a05:6808:18a9:: with SMTP id bi41mr3298757oib.73.1629392052009;
        Thu, 19 Aug 2021 09:54:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g13sm691907oos.39.2021.08.19.09.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 09:54:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 19 Aug 2021 09:54:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [patch V5 41/72] locking/ww_mutex: Gather mutex_waiter
 initialization
Message-ID: <20210819165409.GA2335652@roeck-us.net>
References: <20210815203225.710392609@linutronix.de>
 <20210815211304.281927514@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210815211304.281927514@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Aug 15, 2021 at 11:28:39PM +0200, Thomas Gleixner wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---

This patch causes a large number of crashes with various architectures
if mutex debugging is enabled. Reverting it fixes the problem.

Example and bisect log attached.

Guenter

---
Crash:

[    8.013526] 8<--- cut here ---
[    8.013762] Unable to handle kernel NULL pointer dereference at virtual address 00000508
[    8.013934] pgd = (ptrval)
[    8.014146] [00000508] *pgd=00000000
[    8.014552] Internal error: Oops: 5 [#1] ARM
[    8.014879] CPU: 0 PID: 41 Comm: kworker/u2:1 Not tainted 5.14.0-rc6-next-20210819 #1
[    8.015077] Hardware name: Generic DT based system
[    8.015353] Workqueue: test-ww_mutex stress_inorder_work
[    8.015598] PC is at __ww_mutex_check_waiters+0x5c/0xf0
[    8.015696] LR is at lock_is_held_type+0xcc/0x1a0
[    8.015777] pc : [<80155f8c>]    lr : [<80b27fec>]    psr: 20000113
[    8.015873] sp : 81b6bd98  ip : 81b6bd60  fp : 81b6bdb4
[    8.015951] r10: 81b6a000  r9 : 81b6be7c  r8 : 00000000
[    8.016032] r7 : 82411170  r6 : 82411198  r5 : 81b6be7c  r4 : 81ae9e60
[    8.016127] r3 : 00000001  r2 : 00000000  r1 : 00000500  r0 : 00000001
[    8.016262] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    8.016380] Control: 00093177  Table: 40004000  DAC: 00000053
[    8.016491] Register r0 information: non-paged memory
[    8.016712] Register r1 information: non-paged memory
[    8.016793] Register r2 information: NULL pointer
[    8.016870] Register r3 information: non-paged memory
[    8.016956] Register r4 information: non-slab/vmalloc memory
[    8.017102] Register r5 information: non-slab/vmalloc memory
[    8.017189] Register r6 information: slab kmalloc-512k start 82400000 pointer offset 70040 size 524288
[    8.017566] Register r7 information: slab kmalloc-512k start 82400000 pointer offset 70000 size 524288
[    8.017727] Register r8 information: NULL pointer
[    8.017804] Register r9 information: non-slab/vmalloc memory
[    8.017891] Register r10 information: non-slab/vmalloc memory
[    8.017977] Register r11 information: non-slab/vmalloc memory
[    8.018062] Register r12 information: non-slab/vmalloc memory
[    8.018157] Process kworker/u2:1 (pid: 41, stack limit = 0x(ptrval))
[    8.018323] Stack: (0x81b6bd98 to 0x81b6c000)
[    8.018530] bd80:                                                       82411170 82411174
[    8.018726] bda0: 81b9c121 81b9c120 81b6be34 81b6bdb8 80b2d950 80155f3c 00000001 81b6be98
[    8.018918] bdc0: 8016677c 81a80000 00000fb9 00000fff 81b6be04 81b6bde0 824111a4 80b27f2c
[    8.019105] bde0: 8016677c c72ed19c 00000000 00000002 0000032e 00000000 81b6be34 81b6be08
[    8.019287] be00: 8014c0dc c72ed19c 81b6be34 81b6be7c 82411170 8016677c 82400000 81a80000
[    8.019469] be20: 00000fb9 00000fff 81b6be54 81b6be38 80b2ecfc 80b2cf4c 00000000 00000fb9
[    8.019651] be40: 000005d7 82400000 81b6bee4 81b6be58 8016677c 80b2ecc4 00000001 00000000
[    8.019832] be60: 8013431c 81b6be70 80164664 8013431c 81b6a000 81b201c0 00000000 81b9c120
[    8.020018] be80: 00000566 00000fba 00010000 00000000 8101dcd0 00000000 8101dcd4 8156588c
[    8.020200] bea0: 00000000 80e53ba4 81000000 0000146d 000004b5 c72ed19c 81807c00 81b201c0
[    8.020382] bec0: 81b266e0 00000001 81807c00 81849500 810d4d84 81807c00 81b6bf44 81b6bee8
[    8.020563] bee0: 8013431c 80166634 00000001 00000000 80134270 81807c00 81849535 00000000
[    8.020745] bf00: 8170b310 81566124 00000000 80de0964 00000000 c72ed19c 80b32d94 81b266e0
[    8.020934] bf20: 81807c00 81b266f8 81807c38 00000088 81b6a000 81807c00 81b6bf74 81b6bf48
[    8.021117] bf40: 80134808 801340a4 00000000 81b340e0 81b6a000 819c9f80 801347ac 81b266e0
[    8.021298] bf60: 00000000 818d1e6c 81b6bfac 81b6bf78 8013c5e4 801347b8 ffffe000 819c9fc4
[    8.021478] bf80: 81b6bfac 81b340e0 8013c48c 00000000 00000000 00000000 00000000 00000000
[    8.021658] bfa0: 00000000 81b6bfb0 80100118 8013c498 00000000 00000000 00000000 00000000
[    8.021839] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    8.022019] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[    8.022185] Backtrace:
[    8.022367] [<80155f30>] (__ww_mutex_check_waiters) from [<80b2d950>] (__ww_mutex_lock.constprop.0+0xa10/0xe4c)
[    8.022609]  r7:81b9c120 r6:81b9c121 r5:82411174 r4:82411170
[    8.022721] [<80b2cf40>] (__ww_mutex_lock.constprop.0) from [<80b2ecfc>] (ww_mutex_lock+0x44/0xbc)
[    8.022863]  r10:00000fff r9:00000fb9 r8:81a80000 r7:82400000 r6:8016677c r5:82411170
[    8.022968]  r4:81b6be7c
[    8.023010] [<80b2ecb8>] (ww_mutex_lock) from [<8016677c>] (stress_inorder_work+0x154/0x39c)
[    8.023135]  r7:82400000 r6:000005d7 r5:00000fb9 r4:00000000
[    8.023228] [<80166628>] (stress_inorder_work) from [<8013431c>] (process_one_work+0x284/0x714)
[    8.023374]  r10:81807c00 r9:810d4d84 r8:81849500 r7:81807c00 r6:00000001 r5:81b266e0
[    8.023489]  r4:81b201c0
[    8.023536] [<80134098>] (process_one_work) from [<80134808>] (worker_thread+0x5c/0x550)
[    8.023672]  r10:81807c00 r9:81b6a000 r8:00000088 r7:81807c38 r6:81b266f8 r5:81807c00
[    8.023787]  r4:81b266e0
[    8.023837] [<801347ac>] (worker_thread) from [<8013c5e4>] (kthread+0x158/0x180)
[    8.023965]  r10:818d1e6c r9:00000000 r8:81b266e0 r7:801347ac r6:819c9f80 r5:81b6a000
[    8.024080]  r4:81b340e0 r3:00000000
[    8.024140] [<8013c48c>] (kthread) from [<80100118>] (ret_from_fork+0x14/0x3c)
[    8.024280] Exception stack(0x81b6bfb0 to 0x81b6bff8)
[    8.024417] bfa0:                                     00000000 00000000 00000000 00000000
[    8.024614] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    8.024797] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    8.024937]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8013c48c
[    8.025068]  r4:81b340e0
[    8.025290] Code: 0a000015 e1d530be e3530000 0a00000d (e5913008)
[    8.025869] ---[ end trace 4289e0554fe769f0 ]---
[    8.026116] Kernel panic - not syncing: Fatal exception

---
bisect log:

# bad: [33e65b1f975cd2814fc0ea9617250fc4c1d7a553] Add linux-next specific files for 20210819
# good: [7c60610d476766e128cc4284bb6349732cbd6606] Linux 5.14-rc6
git bisect start 'HEAD' 'v5.14-rc6'
# good: [9350441ab026f2bb3760b33604c6961f91ee109e] Merge remote-tracking branch 'crypto/master'
git bisect good 9350441ab026f2bb3760b33604c6961f91ee109e
# good: [1f676083dea89f0f9fa898eeffa0dc39d22570fd] Merge remote-tracking branch 'spi/for-next'
git bisect good 1f676083dea89f0f9fa898eeffa0dc39d22570fd
# bad: [81ecf5c642ca990d8ad0c9540b9eee2f2dbba951] Merge remote-tracking branch 'staging/staging-next'
git bisect bad 81ecf5c642ca990d8ad0c9540b9eee2f2dbba951
# bad: [c3811532d39d915de6bc28957a90ce8eebf0da71] Merge remote-tracking branch 'usb/usb-next'
git bisect bad c3811532d39d915de6bc28957a90ce8eebf0da71
# bad: [4ee4149259cdcd1f835a860e5a7140e0b27826db] Merge remote-tracking branch 'rcu/rcu/next'
git bisect bad 4ee4149259cdcd1f835a860e5a7140e0b27826db
# bad: [a27fdfde0570b552d0ba088938c6cf5833e5dbe1] Merge branch 'locking/core'
git bisect bad a27fdfde0570b552d0ba088938c6cf5833e5dbe1
# good: [747ea3fa46d5c1c692433fdbc946e1c386a733b2] Merge branch 'perf/core'
git bisect good 747ea3fa46d5c1c692433fdbc946e1c386a733b2
# bad: [c0afb0ffc06e6b4e492a3b711f1fb32074f9949c] locking/ww_mutex: Gather mutex_waiter initialization
git bisect bad c0afb0ffc06e6b4e492a3b711f1fb32074f9949c
# good: [709e0b62869f625afd18edd79f190c38cb39dfb2] locking/rtmutex: Switch to from cmpxchg_*() to try_cmpxchg_*()
git bisect good 709e0b62869f625afd18edd79f190c38cb39dfb2
# good: [cbcebf5bd3d056d7a0ae332118888d867ac346c0] locking/lockdep: Reduce header dependencies in <linux/debug_locks.h>
git bisect good cbcebf5bd3d056d7a0ae332118888d867ac346c0
# good: [8282947f67345246b4a6344dbceb07484d3d4dad] locking/rwlock: Provide RT variant
git bisect good 8282947f67345246b4a6344dbceb07484d3d4dad
# good: [43d2d52d704e025518d35c3079fcbff744623166] locking/mutex: Move the 'struct mutex_waiter' definition from <linux/mutex.h> to the internal header
git bisect good 43d2d52d704e025518d35c3079fcbff744623166
# good: [ebf4c55c1ddbabaea120fe8d48ce25b4f5da93a1] locking/mutex: Make mutex::wait_lock raw
git bisect good ebf4c55c1ddbabaea120fe8d48ce25b4f5da93a1
# good: [cf702eddcd03dca3184947170930bf284aea27e9] locking/ww_mutex: Simplify lockdep annotations
git bisect good cf702eddcd03dca3184947170930bf284aea27e9
# first bad commit: [c0afb0ffc06e6b4e492a3b711f1fb32074f9949c] locking/ww_mutex: Gather mutex_waiter initialization
