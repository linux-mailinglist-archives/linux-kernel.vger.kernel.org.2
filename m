Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DFD3969AA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 00:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbhEaWXl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 31 May 2021 18:23:41 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3357 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbhEaWXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 18:23:38 -0400
Received: from dggeme766-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Fv8nK37fCz677M;
        Tue,  1 Jun 2021 06:18:13 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme766-chm.china.huawei.com (10.3.19.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 1 Jun 2021 06:21:55 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Tue, 1 Jun 2021 06:21:55 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Mel Gorman <mgorman@suse.de>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        yangyicong <yangyicong@huawei.com>,
        tangchengchang <tangchengchang@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH] sched: fair: don't depend on wake_wide if waker and wakee
 are already in same LLC
Thread-Topic: [PATCH] sched: fair: don't depend on wake_wide if waker and
 wakee are already in same LLC
Thread-Index: AQHXUhAXdUizMfoReUmU6BSpTsz4hqr1J2iAgAEbn9CAAHZUgIAHdICQ
Date:   Mon, 31 May 2021 22:21:55 +0000
Message-ID: <07e4ba63a19c451ab47e6a636c400f4a@hisilicon.com>
References: <20210526091057.1800-1-song.bao.hua@hisilicon.com>
 <YK474+4xpYlAha+2@hirez.programming.kicks-ass.net>
 <7dd00a98d6454d5e92a7d9b936d1aa1c@hisilicon.com>
 <20210527121409.GK3672@suse.de>
In-Reply-To: <20210527121409.GK3672@suse.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Mel Gorman [mailto:mgorman@suse.de]
> Sent: Friday, May 28, 2021 12:14 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: Peter Zijlstra <peterz@infradead.org>; vincent.guittot@linaro.org;
> mingo@redhat.com; dietmar.eggemann@arm.com; rostedt@goodmis.org;
> bsegall@google.com; valentin.schneider@arm.com; juri.lelli@redhat.com;
> bristot@redhat.com; linux-kernel@vger.kernel.org; guodong.xu@linaro.org;
> yangyicong <yangyicong@huawei.com>; tangchengchang
> <tangchengchang@huawei.com>; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH] sched: fair: don't depend on wake_wide if waker and wakee
> are already in same LLC
> 
> On Wed, May 26, 2021 at 09:38:19PM +0000, Song Bao Hua (Barry Song) wrote:
> > > And no supportive numbers...
> >
> > Sorry for the confusion.
> >
> > I actually put some supportive numbers at the below thread which
> > derived this patch:
> >
> https://lore.kernel.org/lkml/bbc339cef87e4009b6d56ee37e202daf@hisilicon.co
> m/
> >
> > when I tried to give Dietmar some pgbench data in that thread,
> > I found in kunpeng920, while software ran in one die/numa with
> > 24cores sharing LLC, disabling wake_wide() brought the best
> > pgbench result.
> >
> >                 llc_as_factor          don't_use_wake_wide
> > Hmean     1     10869.27 (   0.00%)    10723.08 *  -1.34%*
> > Hmean     8     19580.59 (   0.00%)    19469.34 *  -0.57%*
> > Hmean     12    29643.56 (   0.00%)    29520.16 *  -0.42%*
> > Hmean     24    43194.47 (   0.00%)    43774.78 *   1.34%*
> > Hmean     32    40163.23 (   0.00%)    40742.93 *   1.44%*
> > Hmean     48    42249.29 (   0.00%)    48329.00 *  14.39%*
> >
> > The test was done by https://github.com/gormanm/mmtests
> > and
> > ./run-mmtests.sh --config ./configs/config-db-pgbench-timed-ro-medium
> test_tag
> >
> 
> Out of curiousity, I briefly tested this on a Zen2 machine which also
> has multiple LLCs per node. Only tbench4 was executed and I cancelled
> the other tests because of results like this
> 
> tbench4
>                           5.13.0-rc2             5.13.0-rc2
>                              vanilla sched-nowakewidellc-v1r1
> Hmean     1        349.34 (   0.00%)      334.18 *  -4.34%*
> Hmean     2        668.49 (   0.00%)      659.12 *  -1.40%*
> Hmean     4       1307.90 (   0.00%)     1274.35 *  -2.57%*
> Hmean     8       2482.08 (   0.00%)     2377.84 *  -4.20%*
> Hmean     16      4460.06 (   0.00%)     4656.28 *   4.40%*
> Hmean     32      9463.76 (   0.00%)     8909.61 *  -5.86%*
> Hmean     64     15865.30 (   0.00%)    19682.77 *  24.06%*
> Hmean     128    24350.06 (   0.00%)    21593.20 * -11.32%*
> Hmean     256    39593.90 (   0.00%)    31389.33 * -20.72%*
> Hmean     512    37851.54 (   0.00%)    30260.23 * -20.06%*

Thanks, Mel.

I guess a major difference between your testing and mine
is that I was actually running tests on CPUs sharing LLC
rather than in CPUs which are crossing several LLCs.

In the tested machine kunpeng920, 24 cores share LLC and
become one NUMA, though we have 4 numa, the benchmark was
running in one LLC domain and one NUMA only. This is supposed
to benefit those use cases using "numactl -N x tasks" to bind
tasks, which is quite common.

I also tried to reproduce tbench4 in my desktop with intel
i9 10cores(20 threads) sharing only one 20MB LLC:

$ lstopo -c
Machine (15GB total) cpuset=0x000fffff
  Package L#0 cpuset=0x000fffff
    NUMANode L#0 (P#0 15GB) cpuset=0x000fffff
    L3 L#0 (20MB) cpuset=0x000fffff
      L2 L#0 (256KB) cpuset=0x00000401
        L1d L#0 (32KB) cpuset=0x00000401
          L1i L#0 (32KB) cpuset=0x00000401
            Core L#0 cpuset=0x00000401
              PU L#0 (P#0) cpuset=0x00000001
              PU L#1 (P#10) cpuset=0x00000400
      L2 L#1 (256KB) cpuset=0x00000802
        L1d L#1 (32KB) cpuset=0x00000802
          L1i L#1 (32KB) cpuset=0x00000802
            Core L#1 cpuset=0x00000802
              PU L#2 (P#1) cpuset=0x00000002
              PU L#3 (P#11) cpuset=0x00000800
      L2 L#2 (256KB) cpuset=0x00001004
        L1d L#2 (32KB) cpuset=0x00001004
          L1i L#2 (32KB) cpuset=0x00001004
            Core L#2 cpuset=0x00001004
              PU L#4 (P#2) cpuset=0x00000004
              PU L#5 (P#12) cpuset=0x00001000
      L2 L#3 (256KB) cpuset=0x00002008
        L1d L#3 (32KB) cpuset=0x00002008
          L1i L#3 (32KB) cpuset=0x00002008
            Core L#3 cpuset=0x00002008
              PU L#6 (P#3) cpuset=0x00000008
              PU L#7 (P#13) cpuset=0x00002000
      L2 L#4 (256KB) cpuset=0x00004010
        L1d L#4 (32KB) cpuset=0x00004010
          L1i L#4 (32KB) cpuset=0x00004010
            Core L#4 cpuset=0x00004010
              PU L#8 (P#4) cpuset=0x00000010
              PU L#9 (P#14) cpuset=0x00004000
      L2 L#5 (256KB) cpuset=0x00008020
        L1d L#5 (32KB) cpuset=0x00008020
          L1i L#5 (32KB) cpuset=0x00008020
            Core L#5 cpuset=0x00008020
              PU L#10 (P#5) cpuset=0x00000020
              PU L#11 (P#15) cpuset=0x00008000
      L2 L#6 (256KB) cpuset=0x00010040
        L1d L#6 (32KB) cpuset=0x00010040
          L1i L#6 (32KB) cpuset=0x00010040
            Core L#6 cpuset=0x00010040
              PU L#12 (P#6) cpuset=0x00000040
              PU L#13 (P#16) cpuset=0x00010000
      L2 L#7 (256KB) cpuset=0x00020080
        L1d L#7 (32KB) cpuset=0x00020080
          L1i L#7 (32KB) cpuset=0x00020080
            Core L#7 cpuset=0x00020080
              PU L#14 (P#7) cpuset=0x00000080
              PU L#15 (P#17) cpuset=0x00020000
      L2 L#8 (256KB) cpuset=0x00040100
        L1d L#8 (32KB) cpuset=0x00040100
          L1i L#8 (32KB) cpuset=0x00040100
            Core L#8 cpuset=0x00040100
              PU L#16 (P#8) cpuset=0x00000100
              PU L#17 (P#18) cpuset=0x00040000
      L2 L#9 (256KB) cpuset=0x00080200
        L1d L#9 (32KB) cpuset=0x00080200
          L1i L#9 (32KB) cpuset=0x00080200
            Core L#9 cpuset=0x00080200
              PU L#18 (P#9) cpuset=0x00000200
              PU L#19 (P#19) cpuset=0x00080000

The benchmark of tbenchs is still positive:

tbench4

                           5.13-rc4               5.13-rc4
                                     disable-llc-wakewide/

Hmean     1       514.87 (   0.00%)      505.17 *  -1.88%*
Hmean     2       914.45 (   0.00%)      918.45 *   0.44%*
Hmean     4      1483.81 (   0.00%)     1485.38 *   0.11%*
Hmean     8      2211.62 (   0.00%)     2236.02 *   1.10%*
Hmean     16     2129.80 (   0.00%)     2450.81 *  15.07%*
Hmean     32     5098.35 (   0.00%)     5085.20 *  -0.26%*
Hmean     64     4797.62 (   0.00%)     4801.34 *   0.08%*
Hmean     80     4802.89 (   0.00%)     4780.40 *  -0.47%*

I guess something which work across several LLC domains
cause performance regression.

I wonder how your test will be like if you pin the testing
to CPUs within one LLC?

Thanks
Barry

