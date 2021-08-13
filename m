Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688BF3EB4F0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 13:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240179AbhHML7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 07:59:39 -0400
Received: from ozlabs.org ([203.11.71.1]:36491 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239493AbhHML7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 07:59:30 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GmMXk48kvz9t5m; Fri, 13 Aug 2021 21:59:02 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     mhiramat@kernel.org, benh@kernel.crashing.org, ruscur@russell.cc,
        naveen.n.rao@linux.vnet.ibm.com, christophe.leroy@csgroup.eu,
        npiggin@gmail.com, mpe@ellerman.id.au, peterz@infradead.org,
        Pu Lehui <pulehui@huawei.com>, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        zhangjinhao2@huawei.com
In-Reply-To: <20210809023658.218915-1-pulehui@huawei.com>
References: <20210809023658.218915-1-pulehui@huawei.com>
Subject: Re: [PATCH v2] powerpc/kprobes: Fix kprobe Oops happens in booke
Message-Id: <162885586769.2317031.16207724458965456130.b4-ty@ellerman.id.au>
Date:   Fri, 13 Aug 2021 21:57:47 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Aug 2021 10:36:58 +0800, Pu Lehui wrote:
> When using kprobe on powerpc booke series processor, Oops happens
> as show bellow:
> 
> / # echo "p:myprobe do_nanosleep" > /sys/kernel/debug/tracing/kprobe_events
> / # echo 1 > /sys/kernel/debug/tracing/events/kprobes/myprobe/enable
> / # sleep 1
> [   50.076730] Oops: Exception in kernel mode, sig: 5 [#1]
> [   50.077017] BE PAGE_SIZE=4K SMP NR_CPUS=24 QEMU e500
> [   50.077221] Modules linked in:
> [   50.077462] CPU: 0 PID: 77 Comm: sleep Not tainted 5.14.0-rc4-00022-g251a1524293d #21
> [   50.077887] NIP:  c0b9c4e0 LR: c00ebecc CTR: 00000000
> [   50.078067] REGS: c3883de0 TRAP: 0700   Not tainted (5.14.0-rc4-00022-g251a1524293d)
> [   50.078349] MSR:  00029000 <CE,EE,ME>  CR: 24000228  XER: 20000000
> [   50.078675]
> [   50.078675] GPR00: c00ebdf0 c3883e90 c313e300 c3883ea0 00000001 00000000 c3883ecc 00000001
> [   50.078675] GPR08: c100598c c00ea250 00000004 00000000 24000222 102490c2 bff4180c 101e60d4
> [   50.078675] GPR16: 00000000 102454ac 00000040 10240000 10241100 102410f8 10240000 00500000
> [   50.078675] GPR24: 00000002 00000000 c3883ea0 00000001 00000000 0000c350 3b9b8d50 00000000
> [   50.080151] NIP [c0b9c4e0] do_nanosleep+0x0/0x190
> [   50.080352] LR [c00ebecc] hrtimer_nanosleep+0x14c/0x1e0
> [   50.080638] Call Trace:
> [   50.080801] [c3883e90] [c00ebdf0] hrtimer_nanosleep+0x70/0x1e0 (unreliable)
> [   50.081110] [c3883f00] [c00ec004] sys_nanosleep_time32+0xa4/0x110
> [   50.081336] [c3883f40] [c001509c] ret_from_syscall+0x0/0x28
> [   50.081541] --- interrupt: c00 at 0x100a4d08
> [   50.081749] NIP:  100a4d08 LR: 101b5234 CTR: 00000003
> [   50.081931] REGS: c3883f50 TRAP: 0c00   Not tainted (5.14.0-rc4-00022-g251a1524293d)
> [   50.082183] MSR:  0002f902 <CE,EE,PR,FP,ME>  CR: 24000222  XER: 00000000
> [   50.082457]
> [   50.082457] GPR00: 000000a2 bf980040 1024b4d0 bf980084 bf980084 64000000 00555345 fefefeff
> [   50.082457] GPR08: 7f7f7f7f 101e0000 00000069 00000003 28000422 102490c2 bff4180c 101e60d4
> [   50.082457] GPR16: 00000000 102454ac 00000040 10240000 10241100 102410f8 10240000 00500000
> [   50.082457] GPR24: 00000002 bf9803f4 10240000 00000000 00000000 100039e0 00000000 102444e8
> [   50.083789] NIP [100a4d08] 0x100a4d08
> [   50.083917] LR [101b5234] 0x101b5234
> [   50.084042] --- interrupt: c00
> [   50.084238] Instruction dump:
> [   50.084483] 4bfffc40 60000000 60000000 60000000 9421fff0 39400402 914200c0 38210010
> [   50.084841] 4bfffc20 00000000 00000000 00000000 <7fe00008> 7c0802a6 7c892378 93c10048
> [   50.085487] ---[ end trace f6fffe98e2fa8f3e ]---
> [   50.085678]
> Trace/breakpoint trap
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/kprobes: Fix kprobe Oops happens in booke
      https://git.kernel.org/powerpc/c/43e8f76006592cb1573a959aa287c45421066f9c

cheers
