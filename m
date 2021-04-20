Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DC0365F7B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 20:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhDTSfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 14:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbhDTSfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 14:35:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2789C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 11:35:08 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618943706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GoSz3Zg75vfMnXTQmprPnAW/4nC65sCLw6CwlSbZDKI=;
        b=VDX530FeFQPTnGxO54+rfc9PHijHsxhVmYq3dq3U83tBr59P/lNFBTKz9Kfn4bhTc4eyvp
        7Fzkqapp2vOzeuGmUcxtcl+pKUcr7Aw5Vkv/i1hDh4IHgQiygysE39DEgA5Kqi7S/gZftn
        SPfi8L/25jvRE72uS3bEzYLJqqIAX//b7/NNRB3wrza9VTtp+1gy8t4yfuib9fR0s2Nyk1
        F1gG4aVPfMiL425qISa7fnDqx8CJDRfzkbGucTeV1msSG+UQVebe++uuXdRG8StxnvNGoz
        TlQKAiWK+pZ7jR8htpZfaLsQCwsJcbs/hFiPU1ND49xPx5HFj7HU0vI6FCvTcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618943706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GoSz3Zg75vfMnXTQmprPnAW/4nC65sCLw6CwlSbZDKI=;
        b=h/VyqAINJDv1Es3nUx+uZzypYRaoCn4js0KGMLsGUP8xYgfJBpZ6c5YYUjnLNDzRV935fW
        cSjolamTi01yZ0BA==
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@intel.com
Subject: Re: [signal]  4bad58ebc8:  will-it-scale.per_thread_ops -3.3% regression
In-Reply-To: <20210420030837.GB31773@xsang-OptiPlex-9020>
References: <20210420030837.GB31773@xsang-OptiPlex-9020>
Date:   Tue, 20 Apr 2021 20:35:06 +0200
Message-ID: <87bla8rehx.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20 2021 at 11:08, kernel test robot wrote:
> FYI, we noticed a -3.3% regression of will-it-scale.per_thread_ops due to=
 commit:
>
> commit: 4bad58ebc8bc4f20d89cff95417c9b4674769709 ("signal: Allow tasks to=
 cache one sigqueue struct")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core
>
> in testcase: will-it-scale
> on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz=
 with 192G memory
> with following parameters:
>
> 	nr_task: 100%
> 	mode: thread
> 	test: futex3
> 	cpufreq_governor: performance
> 	ucode: 0x5003006
>
> test-description: Will It Scale takes a testcase and runs it from 1 throu=
gh to n parallel copies to see if the testcase will scale. It builds both a=
 process and threads based test in order to see any differences between the=
 two.
> test-url: https://github.com/antonblanchard/will-it-scale
> commit:=20
>   69995ebbb9 ("signal: Hand SIGQUEUE_PREALLOC flag to __sigqueue_alloc()")
>   4bad58ebc8 ("signal: Allow tasks to cache one sigqueue struct")
>
> 69995ebbb9d37173 4bad58ebc8bc4f20d89cff95417=20
> ---------------- ---------------------------=20
>          %stddev     %change         %stddev
>              \          |                \=20=20
>  1.273e+09            -3.3%  1.231e+09        will-it-scale.192.threads
>    6630224            -3.3%    6409738        will-it-scale.per_thread_ops
>  1.273e+09            -3.3%  1.231e+09        will-it-scale.workload
>       1638 =C2=B1  3%      -7.8%       1510 =C2=B1  5%  sched_debug.cfs_r=
q:/.runnable_avg.max
>     297.83 =C2=B1 68%   +1747.6%       5502 =C2=B1152%  interrupts.33:PCI=
-MSI.524291-edge.eth0-TxRx-2
>     297.83 =C2=B1 68%   +1747.6%       5502 =C2=B1152%  interrupts.CPU12.=
33:PCI-MSI.524291-edge.eth0-TxRx-2

This change is definitely not causing more network traffic

>       8200           -33.4%       5459 =C2=B1 35%  interrupts.CPU27.NMI:N=
on-maskable_interrupts
>       8200           -33.4%       5459 =C2=B1 35%  interrupts.CPU27.PMI:P=
erformance_monitoring_interrupts
>       8199           -33.4%       5459 =C2=B1 35%  interrupts.CPU28.NMI:N=
on-maskable_interrupts
>       8199           -33.4%       5459 =C2=B1 35%  interrupts.CPU28.PMI:P=
erformance_monitoring_interrupts
>       6148 =C2=B1 33%     -11.2%       5459 =C2=B1 35%  interrupts.CPU29.=
NMI:Non-maskable_interrupts
>       6148 =C2=B1 33%     -11.2%       5459 =C2=B1 35%  interrupts.CPU29.=
PMI:Performance_monitoring_interrupts
>       4287 =C2=B1  8%     +33.6%       5730 =C2=B1 15%  interrupts.CPU49.=
CAL:Function_call_interrupts
>       6356 =C2=B1 19%     +49.6%       9509 =C2=B1 19%  interrupts.CPU97.=
CAL:Function_call_interrupts

Neither does it increase the number of function calls

>     407730 =C2=B1  8%     +37.5%     560565 =C2=B1  7%  perf-stat.i.dTLB-=
load-misses
>     415959 =C2=B1  8%     +40.4%     583928 =C2=B1  7%  perf-stat.ps.dTLB=
-load-misses

And this massive increase does not make sense either.

Confused.

Thanks,

        tglx
