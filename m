Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A643924AB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 04:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbhE0CCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 22:02:39 -0400
Received: from shelob.surriel.com ([96.67.55.147]:45360 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbhE0CCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 22:02:38 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1lm5KS-0003HC-6j; Wed, 26 May 2021 22:00:56 -0400
Message-ID: <ed06ccf4ddb98ec9c31d30d5f92f637bdb890326.camel@surriel.com>
Subject: Re: [LKP] [sched/fair] c722f35b51: tbench.throughput-MB/sec -29.1%
 regression
From:   Rik van Riel <riel@surriel.com>
To:     "Xing, Zhengjun" <zhengjun.xing@intel.com>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, aubrey.li@linux.intel.com, yu.c.chen@intel.com
Date:   Wed, 26 May 2021 22:00:55 -0400
In-Reply-To: <1d942826-badc-ca0d-6d46-1b207caf7f84@intel.com>
References: <20210519082211.GF29704@xsang-OptiPlex-9020>
         <1d942826-badc-ca0d-6d46-1b207caf7f84@intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-3RAqqMZngejL9R9dpnPv"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3RAqqMZngejL9R9dpnPv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2021-05-27 at 09:27 +0800, Xing, Zhengjun wrote:
> Hi Rik,
>=20
>    Do you have time to look at this? Thanks.

Hello,

I will try to take a look at this on Friday.

However, even if I manage to reproduce it on one of
the systems I have access to, I'm still not sure how
exactly we would root cause the issue.

Is it due to
select_idle_sibling() doing a little bit
more work?

Is it because we invoke test_idle_cores() a little
earlier, widening the race window with CPUs going idle,
causing select_idle_cpu to do a lot more work?

Is it a locality thing where random placement on any
core in the LLC is somehow better than placement on
the same core as "prev" when there is no idle core?

Is it tbench running
faster when the woken up task is
placed on the runqueue behind the current task on the
"target" cpu, even though that CPU isn't currently
idle, because tbench happens to go to sleep fast?

In other words, I'm
not quite sure whether this is
a tbench (and other similar benchmark) specific thing,
or a kernel thing, or what instrumentation we would
want in select_idle_sibling / select_idle_cpu for us
to root cause issues like this more easily in the
future...

> On 5/19/2021 4:22 PM, kernel test robot wrote:
> > Greeting,
> >=20
> > FYI, we noticed a -29.1% regression of tbench.throughput-MB/sec due
> > to commit:
> >=20
> >=20
> > commit: c722f35b513f807629603bbf24640b1a48be21b5 ("sched/fair:
> > Bring back select_idle_smt(), but differently")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git
> > master
> >=20
> >=20
> > in testcase: tbench
> > on test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252
> > CPU @ 2.10GHz with 128G memory
> > with following parameters:
> >=20
> > 	nr_threads: 100%
> > 	cluster: cs-localhost
> > 	cpufreq_governor: performance
> > 	ucode: 0x5003006
> >=20
> >=20
> >=20
> >=20
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> >=20
> >=20
> > Details are as below:
> > -----------------------------------------------------------------
> > --------------------------------->
> >=20
> >=20
> > To reproduce:
> >=20
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp install                job.yaml  # job file is
> > attached in this email
> >         bin/lkp split-job --compatible job.yaml  # generate the
> > yaml file for lkp run
> >         bin/lkp run                    generated-yaml-file
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > cluster/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_gr
> > oup/testcase/ucode:
> >   cs-localhost/gcc-9/performance/x86_64-rhel-8.3/100%/debian-10.4-
> > x86_64-20200603.cgz/lkp-csl-2sp8/tbench/0x5003006
> >=20
> > commit:=20
> >   6db12ee045 ("psi: allow unprivileged users with CAP_SYS_RESOURCE
> > to write psi files")
> >   c722f35b51 ("sched/fair: Bring back select_idle_smt(), but
> > differently")
> >=20
> > 6db12ee0456d0e36 c722f35b513f807629603bbf246=20
> > ---------------- ---------------------------=20
> >          %stddev     %change         %stddev
> >              \          |                \ =20
> >      15027           -29.1%      10651 =C2=B1  5%  tbench.throughput-
> > MB/sec
> >  1.893e+09 =C2=B1  2%     -87.5%   2.36e+08 =C2=B1
> > 73%  tbench.time.involuntary_context_switches
> >      51693 =C2=B1 21%     +65.7%      85645
> > =C2=B1  7%  tbench.time.minor_page_faults
> >       5200           -45.9%       2815
> > =C2=B1  9%  tbench.time.percent_of_cpu_this_job_got
> >      32467           -48.9%      16595 =C2=B1
> > 10%  tbench.time.system_time
> >       4990           -26.1%       3686 =C2=B1  6%  tbench.time.user_tim=
e
> >  1.387e+08 =C2=B1 25%    +760.7%  1.194e+09
> > =C2=B1  8%  tbench.time.voluntary_context_switches
> >       3954 =C2=B1  8%    +307.9%      16131 =C2=B1  8%  uptime.idle
> >   93556034 =C2=B1  4%     -24.5%   70597092 =C2=B1  5%  numa-
> > numastat.node0.local_node
> >   93594173 =C2=B1  4%     -24.5%   70643519 =C2=B1  5%  numa-
> > numastat.node0.numa_hit
> >  1.011e+08 =C2=B1  2%     -29.7%   71069877 =C2=B1  6%  numa-
> > numastat.node1.local_node
> >  1.012e+08 =C2=B1  2%     -29.7%   71110181 =C2=B1  6%  numa-
> > numastat.node1.numa_hit
> >   47900004 =C2=B1  3%     -21.4%   37635451 =C2=B1  6%  numa-
> > vmstat.node0.numa_hit
> >   47817433 =C2=B1  3%     -21.5%   37543255 =C2=B1  6%  numa-
> > vmstat.node0.numa_local
> >   51712415 =C2=B1  2%     -26.3%   38110581 =C2=B1  8%  numa-
> > vmstat.node1.numa_hit
> >   51561304 =C2=B1  2%     -26.4%   37969236 =C2=B1  8%  numa-
> > vmstat.node1.numa_local
> >       2.17 =C2=B1 31%    +861.5%      20.83 =C2=B1  9%  vmstat.cpu.id
> >      88.67           -19.5%      71.33 =C2=B1  2%  vmstat.cpu.sy
> >     132.50           -16.2%     111.00        vmstat.procs.r
> >     197679            +6.4%     210333        vmstat.system.in
> >  1.445e+09 =C2=B1 24%    +838.9%  1.357e+10 =C2=B1 10%  cpuidle.C1.time
> >  1.585e+08 =C2=B1 24%    +803.8%  1.433e+09 =C2=B1  8%  cpuidle.C1.usag=
e
> >     238575 =C2=B1 17%    +101.0%     479497 =C2=B1  9%  cpuidle.C1E.usa=
ge
> >   16003682 =C2=B1 25%    +636.0%  1.178e+08 =C2=B1  7%  cpuidle.POLL.ti=
me
> >    1428997 =C2=B1 25%    +572.1%    9604232 =C2=B1  8%  cpuidle.POLL.us=
age
> >      22.00           +14.7       36.65 =C2=B1  4%  mpstat.cpu.all.idle%
> >       0.81            +0.1        0.90        mpstat.cpu.all.irq%
> >      15.57            +4.6       20.20 =C2=B1  2%  mpstat.cpu.all.soft%
> >      54.87           -18.2       36.68 =C2=B1  5%  mpstat.cpu.all.sys%
> >       6.75            -1.2        5.57 =C2=B1  3%  mpstat.cpu.all.usr%
> >  1.948e+08           -27.3%  1.417e+08 =C2=B1  4%  proc-vmstat.numa_hit
> >  1.947e+08           -27.3%  1.416e+08 =C2=B1  4%  proc-
> > vmstat.numa_local
> >  1.516e+09           -28.0%  1.092e+09 =C2=B1  5%  proc-
> > vmstat.pgalloc_normal
> >    2867654 =C2=B1  2%      +5.3%    3018753        proc-vmstat.pgfault
> >  1.512e+09           -28.1%  1.087e+09 =C2=B1  5%  proc-vmstat.pgfree
> >       2663           -15.7%       2244        turbostat.Avg_MHz
> >      97.59           -15.8       81.80 =C2=B1  2%  turbostat.Busy%
> >  1.585e+08 =C2=B1 24%    +803.8%  1.433e+09 =C2=B1  8%  turbostat.C1
> >       2.09 =C2=B1 24%     +17.5       19.58 =C2=B1 10%  turbostat.C1%
> >     237770 =C2=B1 17%    +101.5%     479071 =C2=B1  9%  turbostat.C1E
> >       2.38 =C2=B1 17%    +663.9%      18.18 =C2=B1 10%  turbostat.CPU%c=
1
> >      74.39            -6.2%      69.77        turbostat.RAMWatt
> >       0.01 =C2=B1 59%    +886.2%       0.10 =C2=B1 48%  perf-
> > sched.sch_delay.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_us
> > er_mode.entry_SYSCALL_64_after_hwframe.[unknown]
> >       0.00 =C2=B1 62%   +2215.4%       0.05 =C2=B1 40%  perf-
> > sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.__rel
> > ease_sock.release_sock.tcp_sendmsg
> >       0.01 =C2=B1 24%    +378.9%       0.05 =C2=B1 22%  perf-
> > sched.sch_delay.avg.ms.preempt_schedule_common.__cond_resched.kmem_
> > cache_alloc_node.__alloc_skb.sk_stream_alloc_skb
> >       0.05 =C2=B1 24%     +47.3%       0.07 =C2=B1 12%  perf-
> > sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do
> > _open.isra
> >       2347 =C2=B1 20%     +28.2%       3010        perf-
> > sched.sch_delay.max.ms.pipe_read.new_sync_read.vfs_read.ksys_read
> >       1.41 =C2=B1 25%     -34.8%       0.92 =C2=B1 19%  perf-
> > sched.sch_delay.max.ms.preempt_schedule_common.__cond_resched.aa_sk
> > _perm.security_socket_sendmsg.sock_sendmsg
> >     790.43 =C2=B1 10%     +30.2%       1029        perf-
> > sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
> >     215752 =C2=B1 29%     -94.4%      12122 =C2=B1 46%  perf-
> > sched.wait_and_delay.count.exit_to_user_mode_prepare.syscall_exit_t
> > o_user_mode.entry_SYSCALL_64_after_hwframe.[unknown]
> >       2004 =C2=B1 12%     -37.7%       1248 =C2=B1  6%  perf-
> > sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
> >       0.06 =C2=B1 23%    +762.8%       0.53 =C2=B1 42%  perf-
> > sched.wait_time.avg.ms.exit_to_user_mode_prepare.syscall_exit_to_us
> > er_mode.entry_SYSCALL_64_after_hwframe.[unknown]
> >       0.02 =C2=B1  8%    +421.8%       0.10 =C2=B1 32%  perf-
> > sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.__rel
> > ease_sock.release_sock.tcp_sendmsg
> >       0.03 =C2=B1 12%    +191.3%       0.09 =C2=B1 18%  perf-
> > sched.wait_time.avg.ms.preempt_schedule_common.__cond_resched.kmem_
> > cache_alloc_node.__alloc_skb.sk_stream_alloc_skb
> >     685.22 =C2=B1  7%     +17.4%     804.65 =C2=B1 12%  perf-
> > sched.wait_time.avg.ms.schedule_timeout.kcompactd.kthread.ret_from_
> > fork
> >     785.50 =C2=B1 10%     +30.3%       1023        perf-
> > sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
> >       1.18 =C2=B1 35%     -33.6%       0.78 =C2=B1 18%  perf-
> > sched.wait_time.max.ms.exit_to_user_mode_prepare.irqentry_exit_to_u
> > ser_mode.asm_sysvec_apic_timer_interrupt.[unknown]
> >       1.58 =C2=B1 15%     -34.9%       1.03 =C2=B1 14%  perf-
> > sched.wait_time.max.ms.preempt_schedule_common.__cond_resched.aa_sk
> > _perm.security_socket_sendmsg.sock_sendmsg
> >      51178 =C2=B1 93%   +1451.5%     794049
> > =C2=B1  9%  sched_debug.cfs_rq:/.MIN_vruntime.avg
> >    2407970 =C2=B1 59%    +466.9%   13650279
> > =C2=B1  4%  sched_debug.cfs_rq:/.MIN_vruntime.max
> >     330425 =C2=B1 71%    +821.3%    3044331
> > =C2=B1  6%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
> >       6186 =C2=B1  5%     -91.9%     499.13
> > =C2=B1165%  sched_debug.cfs_rq:/.load.min
> >       4.01 =C2=B1  7%     -39.0%       2.45 =C2=B1
> > 15%  sched_debug.cfs_rq:/.load_avg.min
> >      51178 =C2=B1 93%   +1451.5%     794049
> > =C2=B1  9%  sched_debug.cfs_rq:/.max_vruntime.avg
> >    2407973 =C2=B1 59%    +466.9%   13650279
> > =C2=B1  4%  sched_debug.cfs_rq:/.max_vruntime.max
> >     330425 =C2=B1 71%    +821.3%    3044331
> > =C2=B1  6%  sched_debug.cfs_rq:/.max_vruntime.stddev
> >   23445823           -41.9%   13622977 =C2=B1
> > 11%  sched_debug.cfs_rq:/.min_vruntime.avg
> >   25062917 =C2=B1  2%     -32.7%   16866064
> > =C2=B1  8%  sched_debug.cfs_rq:/.min_vruntime.max
> >   22902926 =C2=B1  2%     -42.8%   13102629 =C2=B1
> > 11%  sched_debug.cfs_rq:/.min_vruntime.min
> >       0.92           -19.0%       0.75
> > =C2=B1  3%  sched_debug.cfs_rq:/.nr_running.avg
> >       0.74 =C2=B1 12%     -89.7%       0.08
> > =C2=B1115%  sched_debug.cfs_rq:/.nr_running.min
> >       0.07 =C2=B1 32%    +432.3%       0.38 =C2=B1
> > 10%  sched_debug.cfs_rq:/.nr_running.stddev
> >       1096 =C2=B1  2%     -
> > 18.1%     898.07        sched_debug.cfs_rq:/.runnable_avg.avg
> >     203.00 =C2=B1  4%      +8.1%     219.36
> > =C2=B1  2%  sched_debug.cfs_rq:/.runnable_avg.stddev
> >     996603 =C2=B1 48%    +225.1%    3240056 =C2=B1
> > 25%  sched_debug.cfs_rq:/.spread0.max
> >     855.14           -35.7%     549.90
> > =C2=B1  6%  sched_debug.cfs_rq:/.util_avg.avg
> >       1230 =C2=B1  6%     -21.1%     971.21
> > =C2=B1  6%  sched_debug.cfs_rq:/.util_avg.max
> >     142.21 =C2=B1  3%     -38.9%      86.89 =C2=B1
> > 17%  sched_debug.cfs_rq:/.util_avg.stddev
> >     630.23 =C2=B1  5%     -86.6%      84.51 =C2=B1
> > 65%  sched_debug.cfs_rq:/.util_est_enqueued.avg
> >       1148 =C2=B1  5%     -57.8%     484.29 =C2=B1
> > 17%  sched_debug.cfs_rq:/.util_est_enqueued.max
> >     162.67 =C2=B1 21%     -92.9%      11.56
> > =C2=B1138%  sched_debug.cfs_rq:/.util_est_enqueued.min
> >     189.55 =C2=B1  5%     -60.4%      75.05 =C2=B1
> > 31%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
> >      13.27 =C2=B1  7%     -56.2%       5.81 =C2=B1
> > 16%  sched_debug.cpu.clock.stddev
> >       2627           -22.2%       2042 =C2=B1  3%  sched_debug.cpu.curr=
-
> > >pid.avg
> >       1954 =C2=B1 10%     -92.0%     157.14 =C2=B1137%  sched_debug.cpu=
.curr-
> > >pid.min
> >     963.90 =C2=B1  6%     +58.2%       1525 =C2=B1  4%  sched_debug.cpu=
.curr-
> > >pid.stddev
> >       0.00 =C2=B1  7%     -47.7%       0.00 =C2=B1
> > 15%  sched_debug.cpu.next_balance.stddev
> >       1.30           -14.2%       1.12
> > =C2=B1  2%  sched_debug.cpu.nr_running.avg
> >       2.50 =C2=B1  6%     +79.0%       4.47
> > =C2=B1  6%  sched_debug.cpu.nr_running.max
> >       0.76 =C2=B1 10%     -89.8%       0.08
> > =C2=B1115%  sched_debug.cpu.nr_running.min
> >       0.51 =C2=B1  3%     +73.6%       0.89
> > =C2=B1  6%  sched_debug.cpu.nr_running.stddev
> >       8.53 =C2=B1  3%    +154.8%      21.73 =C2=B1  6%  perf-stat.i.MPK=
I
> >  2.178e+10           -13.8%  1.878e+10 =C2=B1  3%  perf-stat.i.branch-
> > instructions
> >       1.69            +0.2        1.90        perf-stat.i.branch-
> > miss-rate%
> >  3.675e+08            -3.5%  3.545e+08        perf-stat.i.branch-
> > misses
> >      18.30 =C2=B1  7%     -13.5        4.80 =C2=B1 36%  perf-stat.i.cac=
he-
> > miss-rate%
> >  1.546e+08 =C2=B1  9%     -48.7%   79255656 =C2=B1 18%  perf-stat.i.cac=
he-
> > misses
> >  9.224e+08 =C2=B1  2%    +113.6%  1.971e+09 =C2=B1  4%  perf-stat.i.cac=
he-
> > references
> >  2.553e+11           -14.5%  2.183e+11        perf-stat.i.cpu-
> > cycles
> >     240694 =C2=B1 23%    +737.9%    2016725 =C2=B1  7%  perf-stat.i.cpu=
-
> > migrations
> >       1700 =C2=B1 10%     +78.2%       3029 =C2=B1 11%  perf-stat.i.cyc=
les-
> > between-cache-misses
> >       0.02 =C2=B1 19%      +0.2        0.18 =C2=B1  7%  perf-stat.i.dTL=
B-
> > load-miss-rate%
> >    6572698 =C2=B1 19%    +582.9%   44886023 =C2=B1  7%  perf-stat.i.dTL=
B-
> > load-misses
> >  3.024e+10           -14.7%   2.58e+10 =C2=B1  3%  perf-stat.i.dTLB-
> > loads
> >       0.01 =C2=B1 16%      +0.1        0.06 =C2=B1  8%  perf-stat.i.dTL=
B-
> > store-miss-rate%
> >    1539288 =C2=B1 16%    +464.4%    8687418 =C2=B1  8%  perf-stat.i.dTL=
B-
> > store-misses
> >  1.709e+10           -14.7%  1.457e+10 =C2=B1  3%  perf-stat.i.dTLB-
> > stores
> >      73.36           -12.9       60.46 =C2=B1  2%  perf-stat.i.iTLB-
> > load-miss-rate%
> >  1.847e+08 =C2=B1  2%     -10.9%  1.645e+08 =C2=B1  2%  perf-stat.i.iTL=
B-
> > load-misses
> >   67816199 =C2=B1  2%     +59.3%   1.08e+08 =C2=B1  3%  perf-stat.i.iTL=
B-
> > loads
> >  1.073e+11           -13.7%  9.264e+10 =C2=B1  3%  perf-
> > stat.i.instructions
> >       2.66           -14.5%       2.27        perf-
> > stat.i.metric.GHz
> >       1188 =C2=B1  4%     -48.1%     616.51 =C2=B1 13%  perf-
> > stat.i.metric.K/sec
> >     729.51           -12.6%     637.79 =C2=B1  2%  perf-
> > stat.i.metric.M/sec
> >       3886 =C2=B1  2%      +5.4%       4097        perf-stat.i.minor-
> > faults
> >   31516592 =C2=B1  8%     -29.4%   22240687 =C2=B1 13%  perf-stat.i.nod=
e-
> > load-misses
> >    5444441 =C2=B1  5%     -16.3%    4559306 =C2=B1  4%  perf-stat.i.nod=
e-
> > loads
> >      96.59            -4.9       91.73        perf-stat.i.node-
> > store-miss-rate%
> >     432854 =C2=B1  9%     +96.5%     850464 =C2=B1 17%  perf-stat.i.nod=
e-
> > stores
> >       3887 =C2=B1  2%      +5.4%       4098        perf-stat.i.page-
> > faults
> >       8.60 =C2=B1  3%    +147.7%      21.30 =C2=B1  6%  perf-
> > stat.overall.MPKI
> >       1.69            +0.2        1.89        perf-
> > stat.overall.branch-miss-rate%
> >      16.76 =C2=B1  9%     -12.7        4.07 =C2=B1 23%  perf-
> > stat.overall.cache-miss-rate%
> >       1666 =C2=B1  9%     +69.9%       2830 =C2=B1 14%  perf-
> > stat.overall.cycles-between-cache-misses
> >       0.02 =C2=B1 18%      +0.2        0.17 =C2=B1  8%  perf-
> > stat.overall.dTLB-load-miss-rate%
> >       0.01 =C2=B1 16%      +0.1        0.06 =C2=B1  9%  perf-
> > stat.overall.dTLB-store-miss-rate%
> >      73.13           -12.8       60.37 =C2=B1  2%  perf-
> > stat.overall.iTLB-load-miss-rate%
> >      95.70            -4.9       90.84        perf-
> > stat.overall.node-store-miss-rate%
> >  2.175e+10           -13.7%  1.876e+10 =C2=B1  3%  perf-stat.ps.branch-
> > instructions
> >   3.67e+08            -3.5%   3.54e+08        perf-stat.ps.branch-
> > misses
> >  1.543e+08 =C2=B1  9%     -48.7%   79211813 =C2=B1 18%  perf-stat.ps.ca=
che-
> > misses
> >  9.214e+08 =C2=B1  2%    +113.5%  1.967e+09 =C2=B1  4%  perf-stat.ps.ca=
che-
> > references
> >  2.549e+11           -14.5%   2.18e+11        perf-stat.ps.cpu-
> > cycles
> >     240897 =C2=B1 23%    +735.5%    2012779 =C2=B1  7%  perf-stat.ps.cp=
u-
> > migrations
> >    6575045 =C2=B1 19%    +581.3%   44797852 =C2=B1  7%  perf-stat.ps.dT=
LB-
> > load-misses
> >   3.02e+10           -14.7%  2.577e+10 =C2=B1  3%  perf-stat.ps.dTLB-
> > loads
> >    1539214 =C2=B1 16%    +463.3%    8670426 =C2=B1  8%  perf-stat.ps.dT=
LB-
> > store-misses
> >  1.707e+10           -14.7%  1.456e+10 =C2=B1  3%  perf-stat.ps.dTLB-
> > stores
> >  1.844e+08 =C2=B1  2%     -10.9%  1.643e+08 =C2=B1  2%  perf-stat.ps.iT=
LB-
> > load-misses
> >   67743849 =C2=B1  2%     +59.2%  1.079e+08 =C2=B1  3%  perf-stat.ps.iT=
LB-
> > loads
> >  1.072e+11           -13.7%  9.253e+10 =C2=B1  3%  perf-
> > stat.ps.instructions
> >       3886 =C2=B1  2%      +5.5%       4098        perf-stat.ps.minor-
> > faults
> >   31470314 =C2=B1  8%     -29.4%   22222434 =C2=B1 13%  perf-stat.ps.no=
de-
> > load-misses
> >    5442735 =C2=B1  5%     -16.2%    4560730 =C2=B1  3%  perf-stat.ps.no=
de-
> > loads
> >     432399 =C2=B1  9%     +96.4%     849120 =C2=B1 17%  perf-stat.ps.no=
de-
> > stores
> >       3886 =C2=B1  2%      +5.5%       4098        perf-stat.ps.page-
> > faults
> >   7.73e+13           -13.7%  6.672e+13 =C2=B1  3%  perf-
> > stat.total.instructions
> >       0.00       +4.1e+103%      40.83 =C2=B1117%  interrupts.102:PCI-
> > MSI.31981635-edge.i40e-eth0-TxRx-66
> >     163522 =C2=B1  5%    +659.4%    1241719 =C2=B1
> > 40%  interrupts.CAL:Function_call_interrupts
> >       2717 =C2=B1 28%    +275.9%      10215 =C2=B1
> > 52%  interrupts.CPU0.CAL:Function_call_interrupts
> >      30618 =C2=B1 41%    +290.0%     119405
> > =C2=B1  9%  interrupts.CPU0.RES:Rescheduling_interrupts
> >       1686 =C2=B1 25%    +483.4%       9836 =C2=B1
> > 44%  interrupts.CPU1.CAL:Function_call_interrupts
> >      26633 =C2=B1 50%    +342.3%     117798 =C2=B1
> > 10%  interrupts.CPU1.RES:Rescheduling_interrupts
> >       1633 =C2=B1 25%    +563.1%      10833 =C2=B1
> > 50%  interrupts.CPU10.CAL:Function_call_interrupts
> >      27398 =C2=B1 51%    +319.3%     114895 =C2=B1
> > 10%  interrupts.CPU10.RES:Rescheduling_interrupts
> >       1857 =C2=B1 21%    +446.8%      10154 =C2=B1
> > 50%  interrupts.CPU11.CAL:Function_call_interrupts
> >      26206 =C2=B1 53%    +312.9%     108207
> > =C2=B1  8%  interrupts.CPU11.RES:Rescheduling_interrupts
> >       1423 =C2=B1 15%    +614.7%      10176 =C2=B1
> > 52%  interrupts.CPU12.CAL:Function_call_interrupts
> >      26880 =C2=B1 58%    +322.7%     113610
> > =C2=B1  8%  interrupts.CPU12.RES:Rescheduling_interrupts
> >       1457 =C2=B1 18%    +585.6%       9988 =C2=B1
> > 52%  interrupts.CPU13.CAL:Function_call_interrupts
> >      26741 =C2=B1 57%    +330.3%     115064 =C2=B1
> > 10%  interrupts.CPU13.RES:Rescheduling_interrupts
> >       1440 =C2=B1  8%    +626.7%      10466 =C2=B1
> > 52%  interrupts.CPU14.CAL:Function_call_interrupts
> >      27280 =C2=B1 58%    +321.3%     114920 =C2=B1
> > 10%  interrupts.CPU14.RES:Rescheduling_interrupts
> >       1547 =C2=B1 13%    +550.6%      10065 =C2=B1
> > 51%  interrupts.CPU15.CAL:Function_call_interrupts
> >      24652 =C2=B1 60%    +366.8%     115077 =C2=B1
> > 10%  interrupts.CPU15.RES:Rescheduling_interrupts
> >       1613 =C2=B1 14%    +518.7%       9981 =C2=B1
> > 52%  interrupts.CPU16.CAL:Function_call_interrupts
> >      26360 =C2=B1 60%    +338.3%     115544
> > =C2=B1  9%  interrupts.CPU16.RES:Rescheduling_interrupts
> >       1783 =C2=B1 22%    +476.1%      10273 =C2=B1
> > 50%  interrupts.CPU17.CAL:Function_call_interrupts
> >      29465 =C2=B1 57%    +290.9%     115190 =C2=B1
> > 10%  interrupts.CPU17.RES:Rescheduling_interrupts
> >       1692 =C2=B1 15%    +539.1%      10816 =C2=B1
> > 49%  interrupts.CPU18.CAL:Function_call_interrupts
> >      25242 =C2=B1 56%    +355.0%     114843
> > =C2=B1  8%  interrupts.CPU18.RES:Rescheduling_interrupts
> >       1546 =C2=B1 14%    +576.6%      10463 =C2=B1
> > 48%  interrupts.CPU19.CAL:Function_call_interrupts
> >      27541 =C2=B1 53%    +318.0%     115135 =C2=B1
> > 10%  interrupts.CPU19.RES:Rescheduling_interrupts
> >       1539 =C2=B1 20%    +597.8%      10744 =C2=B1
> > 50%  interrupts.CPU2.CAL:Function_call_interrupts
> >      26770 =C2=B1 52%    +333.8%     116123 =C2=B1
> > 10%  interrupts.CPU2.RES:Rescheduling_interrupts
> >       1904 =C2=B1 25%    +432.4%      10138 =C2=B1
> > 52%  interrupts.CPU20.CAL:Function_call_interrupts
> >      25460 =C2=B1 61%    +353.1%     115361
> > =C2=B1  8%  interrupts.CPU20.RES:Rescheduling_interrupts
> >       1762 =C2=B1 23%    +469.0%      10028 =C2=B1
> > 47%  interrupts.CPU21.CAL:Function_call_interrupts
> >      26522 =C2=B1 54%    +331.6%     114472
> > =C2=B1  8%  interrupts.CPU21.RES:Rescheduling_interrupts
> >       1684 =C2=B1 19%    +506.5%      10214 =C2=B1
> > 49%  interrupts.CPU22.CAL:Function_call_interrupts
> >      26964 =C2=B1 52%    +320.4%     113356
> > =C2=B1  9%  interrupts.CPU22.RES:Rescheduling_interrupts
> >       1664 =C2=B1 16%    +552.7%      10863 =C2=B1
> > 47%  interrupts.CPU23.CAL:Function_call_interrupts
> >      25881 =C2=B1 53%    +331.9%     111768
> > =C2=B1  9%  interrupts.CPU23.RES:Rescheduling_interrupts
> >       2767 =C2=B1 70%    +456.6%      15402 =C2=B1
> > 58%  interrupts.CPU24.CAL:Function_call_interrupts
> >      34637 =C2=B1 23%    +245.6%     119696
> > =C2=B1  7%  interrupts.CPU24.RES:Rescheduling_interrupts
> >       1644 =C2=B1 19%    +790.7%      14649 =C2=B1
> > 62%  interrupts.CPU25.CAL:Function_call_interrupts
> >      31698 =C2=B1 34%    +271.3%     117692
> > =C2=B1  9%  interrupts.CPU25.RES:Rescheduling_interrupts
> >       1600 =C2=B1 20%    +885.1%      15766 =C2=B1
> > 63%  interrupts.CPU26.CAL:Function_call_interrupts
> >      32053 =C2=B1 35%    +263.6%     116533
> > =C2=B1  8%  interrupts.CPU26.RES:Rescheduling_interrupts
> >       1906 =C2=B1 40%    +773.1%      16646 =C2=B1
> > 65%  interrupts.CPU27.CAL:Function_call_interrupts
> >      32311 =C2=B1 37%    +257.4%     115489
> > =C2=B1  8%  interrupts.CPU27.RES:Rescheduling_interrupts
> >       1847 =C2=B1 15%    +729.0%      15312 =C2=B1
> > 64%  interrupts.CPU28.CAL:Function_call_interrupts
> >      30973 =C2=B1 38%    +271.9%     115189
> > =C2=B1  8%  interrupts.CPU28.RES:Rescheduling_interrupts
> >       1637 =C2=B1 24%    +825.0%      15146 =C2=B1
> > 64%  interrupts.CPU29.CAL:Function_call_interrupts
> >      32830 =C2=B1 34%    +250.8%     115184
> > =C2=B1  6%  interrupts.CPU29.RES:Rescheduling_interrupts
> >       1433 =C2=B1 14%    +603.8%      10090 =C2=B1
> > 50%  interrupts.CPU3.CAL:Function_call_interrupts
> >      26983 =C2=B1 49%    +320.2%     113392 =C2=B1
> > 10%  interrupts.CPU3.RES:Rescheduling_interrupts
> >       1597 =C2=B1 14%    +863.9%      15400 =C2=B1
> > 62%  interrupts.CPU30.CAL:Function_call_interrupts
> >      31376 =C2=B1 38%    +260.7%     113167
> > =C2=B1  8%  interrupts.CPU30.RES:Rescheduling_interrupts
> >       1648 =C2=B1 16%    +828.7%      15304 =C2=B1
> > 62%  interrupts.CPU31.CAL:Function_call_interrupts
> >      32435 =C2=B1 33%    +258.4%     116241
> > =C2=B1  8%  interrupts.CPU31.RES:Rescheduling_interrupts
> >       2081 =C2=B1 28%    +635.8%      15314 =C2=B1
> > 64%  interrupts.CPU32.CAL:Function_call_interrupts
> >      30678 =C2=B1 34%    +276.2%     115409
> > =C2=B1  8%  interrupts.CPU32.RES:Rescheduling_interrupts
> >       1508 =C2=B1 19%    +951.6%      15860 =C2=B1
> > 65%  interrupts.CPU33.CAL:Function_call_interrupts
> >      32920 =C2=B1 39%    +251.5%     115730
> > =C2=B1  8%  interrupts.CPU33.RES:Rescheduling_interrupts
> >       1529 =C2=B1 22%    +936.7%      15857 =C2=B1
> > 65%  interrupts.CPU34.CAL:Function_call_interrupts
> >      31214 =C2=B1 27%    +266.4%     114381
> > =C2=B1  8%  interrupts.CPU34.RES:Rescheduling_interrupts
> >       1543 =C2=B1 19%    +933.2%      15950 =C2=B1
> > 60%  interrupts.CPU35.CAL:Function_call_interrupts
> >      30887 =C2=B1 33%    +269.9%     114244
> > =C2=B1  7%  interrupts.CPU35.RES:Rescheduling_interrupts
> >       1566 =C2=B1 17%    +890.1%      15505 =C2=B1
> > 64%  interrupts.CPU36.CAL:Function_call_interrupts
> >      31545 =C2=B1 41%    +254.5%     111828
> > =C2=B1  9%  interrupts.CPU36.RES:Rescheduling_interrupts
> >       1518 =C2=B1 17%    +889.4%      15021 =C2=B1
> > 61%  interrupts.CPU37.CAL:Function_call_interrupts
> >      31749 =C2=B1 38%    +266.0%     116188
> > =C2=B1  9%  interrupts.CPU37.RES:Rescheduling_interrupts
> >       1507 =C2=B1 18%    +946.1%      15770 =C2=B1
> > 62%  interrupts.CPU38.CAL:Function_call_interrupts
> >      32670 =C2=B1 36%    +257.7%     116863
> > =C2=B1  7%  interrupts.CPU38.RES:Rescheduling_interrupts
> >       1662 =C2=B1 22%    +818.7%      15277 =C2=B1
> > 63%  interrupts.CPU39.CAL:Function_call_interrupts
> >      32667 =C2=B1 37%    +255.3%     116081
> > =C2=B1  9%  interrupts.CPU39.RES:Rescheduling_interrupts
> >       1908 =C2=B1 49%    +447.9%      10454 =C2=B1
> > 49%  interrupts.CPU4.CAL:Function_call_interrupts
> >      26121 =C2=B1 56%    +341.3%     115279
> > =C2=B1  7%  interrupts.CPU4.RES:Rescheduling_interrupts
> >       1599 =C2=B1 30%    +883.5%      15734 =C2=B1
> > 66%  interrupts.CPU40.CAL:Function_call_interrupts
> >      31759 =C2=B1 37%    +259.8%     114285
> > =C2=B1  8%  interrupts.CPU40.RES:Rescheduling_interrupts
> >       1535 =C2=B1 19%    +889.5%      15194 =C2=B1
> > 62%  interrupts.CPU41.CAL:Function_call_interrupts
> >      31350 =C2=B1 37%    +263.1%     113826
> > =C2=B1  9%  interrupts.CPU41.RES:Rescheduling_interrupts
> >       1565 =C2=B1 19%    +959.8%      16588 =C2=B1
> > 63%  interrupts.CPU42.CAL:Function_call_interrupts
> >      30781 =C2=B1 33%    +269.8%     113842
> > =C2=B1  7%  interrupts.CPU42.RES:Rescheduling_interrupts
> >       1581 =C2=B1 11%    +929.0%      16272 =C2=B1
> > 63%  interrupts.CPU43.CAL:Function_call_interrupts
> >      31679 =C2=B1 33%    +268.0%     116568
> > =C2=B1  7%  interrupts.CPU43.RES:Rescheduling_interrupts
> >       1520 =C2=B1 22%    +914.5%      15422 =C2=B1
> > 65%  interrupts.CPU44.CAL:Function_call_interrupts
> >      31967 =C2=B1 41%    +264.6%     116553
> > =C2=B1  9%  interrupts.CPU44.RES:Rescheduling_interrupts
> >       1503 =C2=B1 16%    +931.3%      15503 =C2=B1
> > 63%  interrupts.CPU45.CAL:Function_call_interrupts
> >      30829 =C2=B1 32%    +272.3%     114770
> > =C2=B1  8%  interrupts.CPU45.RES:Rescheduling_interrupts
> >       1492 =C2=B1 15%    +948.3%      15643 =C2=B1
> > 64%  interrupts.CPU46.CAL:Function_call_interrupts
> >      32136 =C2=B1 37%    +256.1%     114426
> > =C2=B1  8%  interrupts.CPU46.RES:Rescheduling_interrupts
> >       6530 =C2=B1  4%    +186.1%      18685 =C2=B1
> > 49%  interrupts.CPU47.CAL:Function_call_interrupts
> >      32843 =C2=B1 36%    +239.2%     111397
> > =C2=B1  8%  interrupts.CPU47.RES:Rescheduling_interrupts
> >       1501 =C2=B1 21%    +552.3%       9795 =C2=B1
> > 49%  interrupts.CPU48.CAL:Function_call_interrupts
> >      27770 =C2=B1 49%    +306.1%     112779 =C2=B1
> > 10%  interrupts.CPU48.RES:Rescheduling_interrupts
> >       1716 =C2=B1 12%    +479.8%       9951 =C2=B1
> > 47%  interrupts.CPU49.CAL:Function_call_interrupts
> >      27441 =C2=B1 50%    +306.8%     111620 =C2=B1
> > 12%  interrupts.CPU49.RES:Rescheduling_interrupts
> >       1536 =C2=B1 20%    +561.4%      10164 =C2=B1
> > 45%  interrupts.CPU5.CAL:Function_call_interrupts
> >      26043 =C2=B1 58%    +336.2%     113601
> > =C2=B1  8%  interrupts.CPU5.RES:Rescheduling_interrupts
> >       1466 =C2=B1 15%    +652.1%      11028 =C2=B1
> > 52%  interrupts.CPU50.CAL:Function_call_interrupts
> >      25157 =C2=B1 58%    +346.9%     112432 =C2=B1
> > 11%  interrupts.CPU50.RES:Rescheduling_interrupts
> >       1480 =C2=B1 14%    +607.5%      10472 =C2=B1
> > 49%  interrupts.CPU51.CAL:Function_call_interrupts
> >      25280 =C2=B1 53%    +326.7%     107877 =C2=B1
> > 10%  interrupts.CPU51.RES:Rescheduling_interrupts
> >       1718 =C2=B1 28%    +513.8%      10546 =C2=B1
> > 49%  interrupts.CPU52.CAL:Function_call_interrupts
> >      25402 =C2=B1 61%    +343.7%     112698
> > =C2=B1  9%  interrupts.CPU52.RES:Rescheduling_interrupts
> >       1471 =C2=B1 18%    +584.4%      10067 =C2=B1
> > 51%  interrupts.CPU53.CAL:Function_call_interrupts
> >      26502 =C2=B1 51%    +317.7%     110702
> > =C2=B1  9%  interrupts.CPU53.RES:Rescheduling_interrupts
> >       1520 =C2=B1 10%    +577.5%      10301 =C2=B1
> > 49%  interrupts.CPU54.CAL:Function_call_interrupts
> >      26868 =C2=B1 53%    +311.4%     110540 =C2=B1
> > 11%  interrupts.CPU54.RES:Rescheduling_interrupts
> >       1378 =C2=B1 15%    +629.6%      10059 =C2=B1
> > 48%  interrupts.CPU55.CAL:Function_call_interrupts
> >      26538 =C2=B1 55%    +328.1%     113615
> > =C2=B1  9%  interrupts.CPU55.RES:Rescheduling_interrupts
> >       1432 =C2=B1 12%    +613.7%      10226 =C2=B1
> > 50%  interrupts.CPU56.CAL:Function_call_interrupts
> >      27378 =C2=B1 54%    +318.3%     114536
> > =C2=B1  9%  interrupts.CPU56.RES:Rescheduling_interrupts
> >       1578 =C2=B1 23%    +551.4%      10283 =C2=B1
> > 51%  interrupts.CPU57.CAL:Function_call_interrupts
> >      25737 =C2=B1 62%    +337.5%     112612 =C2=B1
> > 10%  interrupts.CPU57.RES:Rescheduling_interrupts
> >       1483 =C2=B1 22%    +630.0%      10829 =C2=B1
> > 52%  interrupts.CPU58.CAL:Function_call_interrupts
> >      27343 =C2=B1 53%    +315.8%     113705
> > =C2=B1  9%  interrupts.CPU58.RES:Rescheduling_interrupts
> >       1460 =C2=B1 18%    +602.5%      10261 =C2=B1
> > 51%  interrupts.CPU59.CAL:Function_call_interrupts
> >      25911 =C2=B1 58%    +298.8%     103334
> > =C2=B1  7%  interrupts.CPU59.RES:Rescheduling_interrupts
> >       1569 =C2=B1  8%    +530.0%       9889 =C2=B1
> > 50%  interrupts.CPU6.CAL:Function_call_interrupts
> >      27162 =C2=B1 52%    +310.3%     111462 =C2=B1
> > 10%  interrupts.CPU6.RES:Rescheduling_interrupts
> >       1587 =C2=B1 31%    +530.4%      10005 =C2=B1
> > 51%  interrupts.CPU60.CAL:Function_call_interrupts
> >      26060 =C2=B1 56%    +330.3%     112129
> > =C2=B1  9%  interrupts.CPU60.RES:Rescheduling_interrupts
> >       1414 =C2=B1 16%    +608.1%      10012 =C2=B1
> > 49%  interrupts.CPU61.CAL:Function_call_interrupts
> >      25916 =C2=B1 59%    +345.2%     115375 =C2=B1
> > 10%  interrupts.CPU61.RES:Rescheduling_interrupts
> >       1501 =C2=B1 18%    +601.8%      10534 =C2=B1
> > 53%  interrupts.CPU62.CAL:Function_call_interrupts
> >      27209 =C2=B1 60%    +317.1%     113499
> > =C2=B1  9%  interrupts.CPU62.RES:Rescheduling_interrupts
> >       1411 =C2=B1 18%    +612.3%      10052 =C2=B1
> > 51%  interrupts.CPU63.CAL:Function_call_interrupts
> >      25584 =C2=B1 59%    +345.4%     113944
> > =C2=B1  9%  interrupts.CPU63.RES:Rescheduling_interrupts
> >       1890 =C2=B1 17%    +437.8%      10169 =C2=B1
> > 50%  interrupts.CPU64.CAL:Function_call_interrupts
> >      26884 =C2=B1 60%    +322.0%     113444 =C2=B1
> > 10%  interrupts.CPU64.RES:Rescheduling_interrupts
> >       1729 =C2=B1 25%    +475.6%       9955 =C2=B1
> > 48%  interrupts.CPU65.CAL:Function_call_interrupts
> >      26952 =C2=B1 54%    +321.5%     113608 =C2=B1
> > 10%  interrupts.CPU65.RES:Rescheduling_interrupts
> >       1897 =C2=B1 16%    +481.0%      11020 =C2=B1
> > 46%  interrupts.CPU66.CAL:Function_call_interrupts
> >      25947 =C2=B1 58%    +327.7%     110971
> > =C2=B1  9%  interrupts.CPU66.RES:Rescheduling_interrupts
> >       1761 =C2=B1 18%    +467.0%       9987 =C2=B1
> > 50%  interrupts.CPU67.CAL:Function_call_interrupts
> >      27578 =C2=B1 52%    +307.5%     112380 =C2=B1
> > 10%  interrupts.CPU67.RES:Rescheduling_interrupts
> >       1784 =C2=B1 18%    +451.1%       9835 =C2=B1
> > 49%  interrupts.CPU68.CAL:Function_call_interrupts
> >      25578 =C2=B1 60%    +340.7%     112722 =C2=B1
> > 10%  interrupts.CPU68.RES:Rescheduling_interrupts
> >       1837 =C2=B1 17%    +436.5%       9857 =C2=B1
> > 49%  interrupts.CPU69.CAL:Function_call_interrupts
> >      26266 =C2=B1 59%    +329.5%     112809
> > =C2=B1  9%  interrupts.CPU69.RES:Rescheduling_interrupts
> >       1465 =C2=B1 15%    +583.8%      10020 =C2=B1
> > 49%  interrupts.CPU7.CAL:Function_call_interrupts
> >      25720 =C2=B1 57%    +351.1%     116026
> > =C2=B1  8%  interrupts.CPU7.RES:Rescheduling_interrupts
> >       1810 =C2=B1 21%    +425.7%       9515 =C2=B1
> > 44%  interrupts.CPU70.CAL:Function_call_interrupts
> >      27634 =C2=B1 51%    +304.4%     111767 =C2=B1
> > 10%  interrupts.CPU70.RES:Rescheduling_interrupts
> >       1891 =C2=B1 12%    +415.1%       9740 =C2=B1
> > 48%  interrupts.CPU71.CAL:Function_call_interrupts
> >      26205 =C2=B1 55%    +323.3%     110934
> > =C2=B1  9%  interrupts.CPU71.RES:Rescheduling_interrupts
> >       2946 =C2=B1 93%    +429.1%      15592 =C2=B1
> > 63%  interrupts.CPU72.CAL:Function_call_interrupts
> >      33476 =C2=B1 29%    +241.2%     114214
> > =C2=B1  8%  interrupts.CPU72.RES:Rescheduling_interrupts
> >       1797 =C2=B1 28%    +730.7%      14931 =C2=B1
> > 64%  interrupts.CPU73.CAL:Function_call_interrupts
> >      31188 =C2=B1 31%    +269.5%     115229
> > =C2=B1  9%  interrupts.CPU73.RES:Rescheduling_interrupts
> >       1649 =C2=B1 23%    +918.0%      16794 =C2=B1
> > 64%  interrupts.CPU74.CAL:Function_call_interrupts
> >      30456 =C2=B1 37%    +274.1%     113927
> > =C2=B1  9%  interrupts.CPU74.RES:Rescheduling_interrupts
> >       1875 =C2=B1 31%    +785.5%      16610 =C2=B1
> > 62%  interrupts.CPU75.CAL:Function_call_interrupts
> >      31503 =C2=B1 38%    +259.7%     113310
> > =C2=B1  8%  interrupts.CPU75.RES:Rescheduling_interrupts
> >       1833 =C2=B1 17%    +766.5%      15885 =C2=B1
> > 64%  interrupts.CPU76.CAL:Function_call_interrupts
> >      29718 =C2=B1 38%    +278.7%     112554
> > =C2=B1  9%  interrupts.CPU76.RES:Rescheduling_interrupts
> >       1650 =C2=B1 15%    +857.9%      15811 =C2=B1
> > 66%  interrupts.CPU77.CAL:Function_call_interrupts
> >      31625 =C2=B1 29%    +252.2%     111391
> > =C2=B1  7%  interrupts.CPU77.RES:Rescheduling_interrupts
> >       1740 =C2=B1 16%    +798.0%      15632 =C2=B1
> > 62%  interrupts.CPU78.CAL:Function_call_interrupts
> >      32549 =C2=B1 34%    +239.6%     110549
> > =C2=B1  9%  interrupts.CPU78.RES:Rescheduling_interrupts
> >       1675 =C2=B1 19%    +830.7%      15595 =C2=B1
> > 64%  interrupts.CPU79.CAL:Function_call_interrupts
> >      31016 =C2=B1 36%    +266.4%     113656
> > =C2=B1  8%  interrupts.CPU79.RES:Rescheduling_interrupts
> >       1437 =C2=B1 11%    +635.4%      10570 =C2=B1
> > 49%  interrupts.CPU8.CAL:Function_call_interrupts
> >      27602 =C2=B1 60%    +322.8%     116699 =C2=B1
> > 10%  interrupts.CPU8.RES:Rescheduling_interrupts
> >       1683 =C2=B1 27%    +802.2%      15187 =C2=B1
> > 65%  interrupts.CPU80.CAL:Function_call_interrupts
> >      31149 =C2=B1 43%    +268.5%     114795
> > =C2=B1  8%  interrupts.CPU80.RES:Rescheduling_interrupts
> >       1583 =C2=B1 24%    +911.9%      16020 =C2=B1
> > 66%  interrupts.CPU81.CAL:Function_call_interrupts
> >      31699 =C2=B1 38%    +260.9%     114418
> > =C2=B1  8%  interrupts.CPU81.RES:Rescheduling_interrupts
> >       1752 =C2=B1 36%    +827.9%      16262 =C2=B1
> > 66%  interrupts.CPU82.CAL:Function_call_interrupts
> >      29360 =C2=B1 36%    +288.9%     114167
> > =C2=B1  8%  interrupts.CPU82.RES:Rescheduling_interrupts
> >       1558 =C2=B1 13%    +932.4%      16090 =C2=B1
> > 64%  interrupts.CPU83.CAL:Function_call_interrupts
> >      30230 =C2=B1 36%    +270.2%     111904
> > =C2=B1  8%  interrupts.CPU83.RES:Rescheduling_interrupts
> >       1455 =C2=B1 17%    +958.3%      15407 =C2=B1
> > 64%  interrupts.CPU84.CAL:Function_call_interrupts
> >      30911 =C2=B1 34%    +254.7%     109645 =C2=B1
> > 10%  interrupts.CPU84.RES:Rescheduling_interrupts
> >       1603 =C2=B1 10%    +827.8%      14881 =C2=B1
> > 62%  interrupts.CPU85.CAL:Function_call_interrupts
> >      31085 =C2=B1 37%    +265.4%     113578
> > =C2=B1  8%  interrupts.CPU85.RES:Rescheduling_interrupts
> >       1575 =C2=B1 17%    +904.7%      15827 =C2=B1
> > 64%  interrupts.CPU86.CAL:Function_call_interrupts
> >      33065 =C2=B1 38%    +248.7%     115301
> > =C2=B1  8%  interrupts.CPU86.RES:Rescheduling_interrupts
> >       1498 =C2=B1 18%    +920.9%      15295 =C2=B1
> > 64%  interrupts.CPU87.CAL:Function_call_interrupts
> >      30477 =C2=B1 42%    +274.6%     114181
> > =C2=B1  9%  interrupts.CPU87.RES:Rescheduling_interrupts
> >       1418 =C2=B1 17%    +960.6%      15044 =C2=B1
> > 64%  interrupts.CPU88.CAL:Function_call_interrupts
> >      31735 =C2=B1 32%    +255.3%     112741
> > =C2=B1  9%  interrupts.CPU88.RES:Rescheduling_interrupts
> >       1459 =C2=B1 21%    +984.3%      15826 =C2=B1
> > 65%  interrupts.CPU89.CAL:Function_call_interrupts
> >      31037 =C2=B1 41%    +260.3%     111826
> > =C2=B1  9%  interrupts.CPU89.RES:Rescheduling_interrupts
> >       1505 =C2=B1 18%    +562.6%       9975 =C2=B1
> > 47%  interrupts.CPU9.CAL:Function_call_interrupts
> >      27015 =C2=B1 64%    +327.1%     115392
> > =C2=B1  9%  interrupts.CPU9.RES:Rescheduling_interrupts
> >       1592 =C2=B1 24%    +935.1%      16487 =C2=B1
> > 66%  interrupts.CPU90.CAL:Function_call_interrupts
> >      31256 =C2=B1 37%    +257.9%     111877
> > =C2=B1  8%  interrupts.CPU90.RES:Rescheduling_interrupts
> >       1576 =C2=B1 19%    +882.7%      15489 =C2=B1
> > 66%  interrupts.CPU91.CAL:Function_call_interrupts
> >      31276 =C2=B1 37%    +266.3%     114573
> > =C2=B1  8%  interrupts.CPU91.RES:Rescheduling_interrupts
> >       1706 =C2=B1 18%    +786.3%      15121 =C2=B1
> > 66%  interrupts.CPU92.CAL:Function_call_interrupts
> >      31400 =C2=B1 43%    +260.4%     113170
> > =C2=B1  8%  interrupts.CPU92.RES:Rescheduling_interrupts
> >       1347 =C2=B1 18%   +1012.1%      14981 =C2=B1
> > 66%  interrupts.CPU93.CAL:Function_call_interrupts
> >      29869 =C2=B1 35%    +277.4%     112727
> > =C2=B1  8%  interrupts.CPU93.RES:Rescheduling_interrupts
> >       1372 =C2=B1 12%    +937.5%      14243 =C2=B1
> > 67%  interrupts.CPU94.CAL:Function_call_interrupts
> >      30286 =C2=B1 40%    +271.0%     112366
> > =C2=B1  7%  interrupts.CPU94.RES:Rescheduling_interrupts
> >       1739 =C2=B1 27%    +735.8%      14538 =C2=B1
> > 64%  interrupts.CPU95.CAL:Function_call_interrupts
> >      30315 =C2=B1 39%    +266.8%     111198
> > =C2=B1  8%  interrupts.CPU95.RES:Rescheduling_interrupts
> >    2791109 =C2=B1 14%    +291.3%   10921566
> > =C2=B1  8%  interrupts.RES:Rescheduling_interrupts
> >       1.73 =C2=B1 27%      -1.5        0.26 =C2=B1100%  perf-
> > profile.calltrace.cycles-
> > pp.kill_pid_info.kill_something_info.__x64_sys_kill.do_syscall_64.e
> > ntry_SYSCALL_64_after_hwframe
> >       2.22 =C2=B1 22%      -1.2        0.97        perf-
> > profile.calltrace.cycles-pp.kill
> >       2.08 =C2=B1 23%      -1.2        0.84        perf-
> > profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.kill
> >       2.03 =C2=B1 24%      -1.2        0.80        perf-
> > profile.calltrace.cycles-
> > pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.kill
> >       1.99 =C2=B1 24%      -1.2        0.76        perf-
> > profile.calltrace.cycles-
> > pp.__x64_sys_kill.do_syscall_64.entry_SYSCALL_64_after_hwframe.kill
> >       1.85 =C2=B1 26%      -1.2        0.62        perf-
> > profile.calltrace.cycles-
> > pp.kill_something_info.__x64_sys_kill.do_syscall_64.entry_SYSCALL_6
> > 4_after_hwframe.kill
> >      45.78            -0.9       44.84        perf-
> > profile.calltrace.cycles-pp.__send
> >      45.45            -0.9       44.56        perf-
> > profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__send
> >      44.92            -0.6       44.37        perf-
> > profile.calltrace.cycles-
> > pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send
> >      44.85            -0.5       44.31        perf-
> > profile.calltrace.cycles-
> > pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.__
> > send
> >      44.78            -0.5       44.25        perf-
> > profile.calltrace.cycles-
> > pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_aft
> > er_hwframe.__send
> >      44.54            -0.5       44.03        perf-
> > profile.calltrace.cycles-
> > pp.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_S
> > YSCALL_64_after_hwframe
> >       1.47 =C2=B1  4%      -0.2        1.29 =C2=B1  2%  perf-
> > profile.calltrace.cycles-
> > pp.__dev_queue_xmit.ip_finish_output2.ip_output.__ip_queue_xmit.__t
> > cp_transmit_skb
> >       2.48            -0.1        2.33        perf-
> > profile.calltrace.cycles-
> > pp.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol
> > _deliver_rcu
> >       1.66            -0.1        1.57        perf-
> > profile.calltrace.cycles-
> > pp.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.tc
> > p_v4_rcv
> >       0.74 =C2=B1  3%      -0.1        0.64 =C2=B1  2%  perf-
> > profile.calltrace.cycles-
> > pp.__kfree_skb.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.__sys_re
> > cvfrom
> >       0.62 =C2=B1  5%      -0.1        0.54 =C2=B1  2%  perf-
> > profile.calltrace.cycles-
> > pp.skb_release_all.__kfree_skb.tcp_recvmsg_locked.tcp_recvmsg.inet_
> > recvmsg
> >       0.61 =C2=B1  4%      -0.1        0.53 =C2=B1  2%  perf-
> > profile.calltrace.cycles-
> > pp.skb_release_head_state.skb_release_all.__kfree_skb.tcp_recvmsg_l
> > ocked.tcp_recvmsg
> >       0.88 =C2=B1  3%      -0.1        0.79        perf-
> > profile.calltrace.cycles-
> > pp.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.ip_output
> > .__ip_queue_xmit
> >       0.80 =C2=B1  4%      -0.1        0.72        perf-
> > profile.calltrace.cycles-
> > pp.loopback_xmit.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_out
> > put2.ip_output
> >       1.27 =C2=B1  3%      -0.1        1.20        perf-
> > profile.calltrace.cycles-
> > pp._copy_from_iter_full.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
> > .__sys_sendto
> >       1.14 =C2=B1  3%      -0.1        1.08        perf-
> > profile.calltrace.cycles-
> > pp.copyin._copy_from_iter_full.tcp_sendmsg_locked.tcp_sendmsg.sock_
> > sendmsg
> >       0.96 =C2=B1  2%      -0.1        0.90        perf-
> > profile.calltrace.cycles-
> > pp.sk_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.
> > __sys_sendto
> >       1.59            -0.1        1.53        perf-
> > profile.calltrace.cycles-
> > pp.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg.inet_recvm
> > sg.__sys_recvfrom
> >       1.57            -0.1        1.51        perf-
> > profile.calltrace.cycles-
> > pp.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tc
> > p_recvmsg.inet_recvmsg
> >       1.06 =C2=B1  3%      -0.1        1.01        perf-
> > profile.calltrace.cycles-
> > pp.copy_user_enhanced_fast_string.copyin._copy_from_iter_full.tcp_s
> > endmsg_locked.tcp_sendmsg
> >       0.90 =C2=B1  2%      -0.1        0.85        perf-
> > profile.calltrace.cycles-
> > pp.__alloc_skb.sk_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.s
> > ock_sendmsg
> >       0.95            -0.0        0.91        perf-
> > profile.calltrace.cycles-
> > pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_rec
> > vmsg_locked.tcp_recvmsg
> >       1.76 =C2=B1  3%      +0.1        1.82        perf-
> > profile.calltrace.cycles-
> > pp.perf_swevent_overflow.perf_tp_event.perf_trace_sched_switch.__sc
> > hedule.schedule_idle
> >       1.81 =C2=B1  3%      +0.1        1.88        perf-
> > profile.calltrace.cycles-
> > pp.perf_tp_event.perf_trace_sched_switch.__schedule.schedule_idle.d
> > o_idle
> >       0.61 =C2=B1  2%      +0.1        0.68        perf-
> > profile.calltrace.cycles-
> > pp.menu_select.do_idle.cpu_startup_entry.start_secondary.secondary_
> > startup_64_no_verify
> >       1.94 =C2=B1  3%      +0.1        2.01        perf-
> > profile.calltrace.cycles-
> > pp.perf_trace_sched_switch.__schedule.schedule_idle.do_idle.cpu_sta
> > rtup_entry
> >       0.58 =C2=B1  2%      +0.1        0.67 =C2=B1  2%  perf-
> > profile.calltrace.cycles-
> > pp.pick_next_task_fair.__schedule.schedule_idle.do_idle.cpu_startup
> > _entry
> >       0.89 =C2=B1  6%      +0.2        1.07 =C2=B1  5%  perf-
> > profile.calltrace.cycles-
> > pp.update_load_avg.enqueue_entity.enqueue_task_fair.ttwu_do_activat
> > e.try_to_wake_up
> >       0.92 =C2=B1  3%      +0.2        1.10 =C2=B1  5%  perf-
> > profile.calltrace.cycles-
> > pp.update_load_avg.dequeue_entity.dequeue_task_fair.__schedule.sche
> > dule
> >       2.55            +0.2        2.78        perf-
> > profile.calltrace.cycles-
> > pp.select_task_rq_fair.try_to_wake_up.__wake_up_common.__wake_up_co
> > mmon_lock.sock_def_readable
> >       6.25 =C2=B1  3%      +0.2        6.48        perf-
> > profile.calltrace.cycles-
> > pp.update_curr.dequeue_entity.dequeue_task_fair.__schedule.schedule
> >       2.10 =C2=B1  3%      +0.2        2.34        perf-
> > profile.calltrace.cycles-
> > pp._raw_spin_lock.try_to_wake_up.__wake_up_common.__wake_up_common_
> > lock.sock_def_readable
> >       1.96 =C2=B1  3%      +0.2        2.20        perf-
> > profile.calltrace.cycles-
> > pp.native_queued_spin_lock_slowpath._raw_spin_lock.try_to_wake_up._
> > _wake_up_common.__wake_up_common_lock
> >       3.94 =C2=B1  2%      +0.2        4.19        perf-
> > profile.calltrace.cycles-
> > pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up
> > .__wake_up_common
> >       4.83 =C2=B1  2%      +0.3        5.11        perf-
> > profile.calltrace.cycles-
> > pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.__wake_up_comm
> > on.__wake_up_common_lock
> >       4.86 =C2=B1  2%      +0.3        5.15        perf-
> > profile.calltrace.cycles-
> > pp.ttwu_do_activate.try_to_wake_up.__wake_up_common.__wake_up_commo
> > n_lock.sock_def_readable
> >       5.42 =C2=B1  2%      +0.3        5.72        perf-
> > profile.calltrace.cycles-
> > pp.set_task_cpu.try_to_wake_up.__wake_up_common.__wake_up_common_lo
> > ck.sock_def_readable
> >       3.86 =C2=B1  2%      +0.5        4.31        perf-
> > profile.calltrace.cycles-
> > pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_seconda
> > ry
> >       3.90 =C2=B1  2%      +0.5        4.36        perf-
> > profile.calltrace.cycles-
> > pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondar
> > y_startup_64_no_verify
> >       0.18 =C2=B1141%      +0.5        0.66 =C2=B1  5%  perf-
> > profile.calltrace.cycles-
> > pp._raw_spin_lock.__schedule.schedule_idle.do_idle.cpu_startup_entr
> > y
> >       0.00            +0.5        0.53 =C2=B1  2%  perf-
> > profile.calltrace.cycles-
> > pp.set_next_entity.pick_next_task_fair.__schedule.schedule_idle.do_
> > idle
> >       7.74 =C2=B1  2%      +0.6        8.32        perf-
> > profile.calltrace.cycles-
> > pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.schedule_ti
> > meout
> >      33.75            +0.6       34.34        perf-
> > profile.calltrace.cycles-
> > pp.__softirqentry_text_start.do_softirq.__local_bh_enable_ip.ip_fin
> > ish_output2.ip_output
> >       0.00            +0.6        0.59 =C2=B1  6%  perf-
> > profile.calltrace.cycles-
> > pp.native_queued_spin_lock_slowpath._raw_spin_lock.__schedule.sched
> > ule_idle.do_idle
> >      23.16            +0.6       23.75        perf-
> > profile.calltrace.cycles-
> > pp.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.ent
> > ry_SYSCALL_64_after_hwframe
> >      23.06            +0.6       23.66        perf-
> > profile.calltrace.cycles-
> > pp.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_sy
> > scall_64
> >       8.59 =C2=B1  2%      +0.6        9.21        perf-
> > profile.calltrace.cycles-
> > pp.dequeue_task_fair.__schedule.schedule.schedule_timeout.wait_woke
> > n
> >      22.39            +0.6       23.03        perf-
> > profile.calltrace.cycles-
> > pp.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64
> > _sys_recvfrom
> >      33.98            +0.7       34.64        perf-
> > profile.calltrace.cycles-
> > pp.__local_bh_enable_ip.ip_finish_output2.ip_output.__ip_queue_xmit
> > .__tcp_transmit_skb
> >      33.89            +0.7       34.56        perf-
> > profile.calltrace.cycles-
> > pp.do_softirq.__local_bh_enable_ip.ip_finish_output2.ip_output.__ip
> > _queue_xmit
> >      16.58 =C2=B1  2%      +0.7       17.32        perf-
> > profile.calltrace.cycles-
> > pp.__schedule.schedule.schedule_timeout.wait_woken.sk_wait_data
> >      31.96            +0.7       32.70        perf-
> > profile.calltrace.cycles-
> > pp.ip_rcv.__netif_receive_skb_one_core.process_backlog.__napi_poll.
> > net_rx_action
> >      16.76 =C2=B1  2%      +0.8       17.51        perf-
> > profile.calltrace.cycles-
> > pp.schedule.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_lo
> > cked
> >      16.91 =C2=B1  2%      +0.8       17.66        perf-
> > profile.calltrace.cycles-
> > pp.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked.tcp_
> > recvmsg
> >      17.24 =C2=B1  2%      +0.8       18.00        perf-
> > profile.calltrace.cycles-
> > pp.wait_woken.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg.inet_recv
> > msg
> >      18.29            +0.8       19.07        perf-
> > profile.calltrace.cycles-
> > pp.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.__sys_r
> > ecvfrom
> >      31.40            +0.9       32.29        perf-
> > profile.calltrace.cycles-
> > pp.ip_local_deliver.ip_rcv.__netif_receive_skb_one_core.process_bac
> > klog.__napi_poll
> >      31.33            +0.9       32.22        perf-
> > profile.calltrace.cycles-
> > pp.ip_local_deliver_finish.ip_local_deliver.ip_rcv.__netif_receive_
> > skb_one_core.process_backlog
> >      31.29            +0.9       32.18        perf-
> > profile.calltrace.cycles-
> > pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_local_deliver
> > .ip_rcv.__netif_receive_skb_one_core
> >      31.15            +0.9       32.05        perf-
> > profile.calltrace.cycles-
> > pp.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.ip_lo
> > cal_deliver.ip_rcv
> >      29.63            +1.0       30.61        perf-
> > profile.calltrace.cycles-
> > pp.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_delive
> > r_finish.ip_local_deliver
> >      29.48            +1.0       30.49        perf-
> > profile.calltrace.cycles-
> > pp.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver
> > _rcu.ip_local_deliver_finish
> >       0.00            +1.1        1.05        perf-
> > profile.calltrace.cycles-
> > pp.available_idle_cpu.select_idle_cpu.select_idle_sibling.select_ta
> > sk_rq_fair.try_to_wake_up
> >      24.86 =C2=B1  2%      +1.2       26.07        perf-
> > profile.calltrace.cycles-
> > pp.__wake_up_common.__wake_up_common_lock.sock_def_readable.tcp_rcv
> > _established.tcp_v4_do_rcv
> >      24.61 =C2=B1  2%      +1.2       25.82        perf-
> > profile.calltrace.cycles-
> > pp.try_to_wake_up.__wake_up_common.__wake_up_common_lock.sock_def_r
> > eadable.tcp_rcv_established
> >      25.65 =C2=B1  2%      +1.2       26.87        perf-
> > profile.calltrace.cycles-
> > pp.sock_def_readable.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.i
> > p_protocol_deliver_rcu
> >      25.34 =C2=B1  2%      +1.2       26.58        perf-
> > profile.calltrace.cycles-
> > pp.__wake_up_common_lock.sock_def_readable.tcp_rcv_established.tcp_
> > v4_do_rcv.tcp_v4_rcv
> >      14.20 =C2=B1  2%      +1.6       15.78        perf-
> > profile.calltrace.cycles-
> > pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup
> > _entry
> >      14.62 =C2=B1  2%      +1.6       16.26        perf-
> > profile.calltrace.cycles-
> > pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_entry.star
> > t_secondary
> >      14.64 =C2=B1  2%      +1.6       16.28        perf-
> > profile.calltrace.cycles-
> > pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.secondar
> > y_startup_64_no_verify
> >       0.00            +2.0        2.03        perf-
> > profile.calltrace.cycles-
> > pp.select_idle_cpu.select_idle_sibling.select_task_rq_fair.try_to_w
> > ake_up.__wake_up_common
> >      19.87 =C2=B1  2%      +2.3       22.16        perf-
> > profile.calltrace.cycles-
> > pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_n
> > o_verify
> >      19.89 =C2=B1  2%      +2.3       22.19        perf-
> > profile.calltrace.cycles-
> > pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
> >      19.89 =C2=B1  2%      +2.3       22.19        perf-
> > profile.calltrace.cycles-
> > pp.start_secondary.secondary_startup_64_no_verify
> >      20.12 =C2=B1  2%      +2.3       22.45        perf-
> > profile.calltrace.cycles-pp.secondary_startup_64_no_verify
> >       0.00            +2.4        2.36        perf-
> > profile.calltrace.cycles-
> > pp.select_idle_sibling.select_task_rq_fair.try_to_wake_up.__wake_up
> > _common.__wake_up_common_lock
> >      74.35            -2.1       72.23        perf-
> > profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
> >      73.04            -1.8       71.27        perf-
> > profile.children.cycles-pp.do_syscall_64
> >       2.25 =C2=B1 22%      -1.3        0.99        perf-
> > profile.children.cycles-pp.kill
> >       1.99 =C2=B1 24%      -1.2        0.76        perf-
> > profile.children.cycles-pp.__x64_sys_kill
> >       1.85 =C2=B1 26%      -1.2        0.62        perf-
> > profile.children.cycles-pp.kill_something_info
> >       1.73 =C2=B1 27%      -1.2        0.50        perf-
> > profile.children.cycles-pp.kill_pid_info
> >       1.71 =C2=B1 28%      -1.2        0.48        perf-
> > profile.children.cycles-pp.group_send_sig_info
> >       1.59 =C2=B1 30%      -1.2        0.38        perf-
> > profile.children.cycles-pp.security_task_kill
> >       1.58 =C2=B1 30%      -1.2        0.37        perf-
> > profile.children.cycles-pp.apparmor_task_kill
> >      45.86            -1.0       44.90        perf-
> > profile.children.cycles-pp.__send
> >       1.28 =C2=B1 21%      -0.9        0.39 =C2=B1  2%  perf-
> > profile.children.cycles-pp.aa_sk_perm
> >       0.85 =C2=B1 30%      -0.6        0.24 =C2=B1  3%  perf-
> > profile.children.cycles-pp.aa_get_task_label
> >       0.91 =C2=B1 19%      -0.6        0.32 =C2=B1  3%  perf-
> > profile.children.cycles-pp.security_socket_recvmsg
> >       0.93 =C2=B1 19%      -0.6        0.34 =C2=B1  3%  perf-
> > profile.children.cycles-pp.sock_recvmsg
> >      44.86            -0.5       44.31        perf-
> > profile.children.cycles-pp.__x64_sys_sendto
> >      44.79            -0.5       44.25        perf-
> > profile.children.cycles-pp.__sys_sendto
> >      44.54            -0.5       44.03        perf-
> > profile.children.cycles-pp.sock_sendmsg
> >       1.09 =C2=B1  8%      -0.3        0.75        perf-
> > profile.children.cycles-pp.syscall_exit_to_user_mode
> >       0.91 =C2=B1  9%      -0.3        0.59        perf-
> > profile.children.cycles-pp.exit_to_user_mode_prepare
> >       0.44 =C2=B1 22%      -0.3        0.14 =C2=B1  2%  perf-
> > profile.children.cycles-pp.security_socket_sendmsg
> >       1.53 =C2=B1  4%      -0.2        1.35 =C2=B1  2%  perf-
> > profile.children.cycles-pp.__dev_queue_xmit
> >       2.59            -0.1        2.44        perf-
> > profile.children.cycles-pp.tcp_ack
> >       1.46 =C2=B1  2%      -0.1        1.34        perf-
> > profile.children.cycles-pp.__kfree_skb
> >       1.74 =C2=B1  2%      -0.1        1.64        perf-
> > profile.children.cycles-pp.tcp_clean_rtx_queue
> >       0.72 =C2=B1  4%      -0.1        0.62 =C2=B1  2%  perf-
> > profile.children.cycles-pp.skb_release_all
> >       0.70 =C2=B1  4%      -0.1        0.61 =C2=B1  2%  perf-
> > profile.children.cycles-pp.skb_release_head_state
> >       0.82 =C2=B1  4%      -0.1        0.74        perf-
> > profile.children.cycles-pp.loopback_xmit
> >       0.90 =C2=B1  4%      -0.1        0.82        perf-
> > profile.children.cycles-pp.dev_hard_start_xmit
> >       1.28 =C2=B1  3%      -0.1        1.20        perf-
> > profile.children.cycles-pp._copy_from_iter_full
> >       0.69 =C2=B1  4%      -0.1        0.62 =C2=B1  2%  perf-
> > profile.children.cycles-pp._raw_spin_lock_bh
> >       0.54 =C2=B1  6%      -0.1        0.46 =C2=B1  2%  perf-
> > profile.children.cycles-pp.switch_mm_irqs_off
> >       0.53 =C2=B1  4%      -0.1        0.45 =C2=B1  2%  perf-
> > profile.children.cycles-pp.dst_release
> >       1.58            -0.1        1.51        perf-
> > profile.children.cycles-pp.__skb_datagram_iter
> >       0.96 =C2=B1  2%      -0.1        0.90        perf-
> > profile.children.cycles-pp.sk_stream_alloc_skb
> >       1.60            -0.1        1.53        perf-
> > profile.children.cycles-pp.skb_copy_datagram_iter
> >       0.40 =C2=B1  3%      -0.1        0.34 =C2=B1  4%  perf-
> > profile.children.cycles-pp.tcp_send_mss
> >       0.36 =C2=B1  4%      -0.1        0.31 =C2=B1  3%  perf-
> > profile.children.cycles-pp.tcp_current_mss
> >       0.91 =C2=B1  2%      -0.1        0.86        perf-
> > profile.children.cycles-pp.__alloc_skb
> >       0.23 =C2=B1  5%      -0.0        0.18 =C2=B1  4%  perf-
> > profile.children.cycles-pp.irqtime_account_irq
> >       0.27 =C2=B1  5%      -0.0        0.23        perf-
> > profile.children.cycles-pp.load_new_mm_cr3
> >       0.17 =C2=B1  2%      -0.0        0.13 =C2=B1  4%  perf-
> > profile.children.cycles-pp.tcp_ack_update_rtt
> >       0.53            -0.0        0.49 =C2=B1  2%  perf-
> > profile.children.cycles-pp.sched_clock_cpu
> >       0.61 =C2=B1  4%      -0.0        0.58 =C2=B1  3%  perf-
> > profile.children.cycles-pp.release_sock
> >       0.33 =C2=B1  8%      -0.0        0.29 =C2=B1  2%  perf-
> > profile.children.cycles-pp.next_token
> >       0.95            -0.0        0.92        perf-
> > profile.children.cycles-pp._copy_to_iter
> >       0.49 =C2=B1  2%      -0.0        0.46 =C2=B1  2%  perf-
> > profile.children.cycles-pp.switch_fpu_return
> >       0.41 =C2=B1  3%      -0.0        0.38 =C2=B1  3%  perf-
> > profile.children.cycles-pp.tcp_event_new_data_sent
> >       0.39 =C2=B1  3%      -0.0        0.36 =C2=B1  2%  perf-
> > profile.children.cycles-pp.netif_rx
> >       0.31 =C2=B1  2%      -0.0        0.28        perf-
> > profile.children.cycles-pp.reweight_entity
> >       0.21 =C2=B1  4%      -0.0        0.18 =C2=B1  4%  perf-
> > profile.children.cycles-pp.kmem_cache_alloc_node
> >       0.33 =C2=B1  2%      -0.0        0.30 =C2=B1  3%  perf-
> > profile.children.cycles-pp.__entry_text_start
> >       0.20 =C2=B1  4%      -0.0        0.17 =C2=B1  3%  perf-
> > profile.children.cycles-pp.enqueue_to_backlog
> >       0.38            -0.0        0.35 =C2=B1  2%  perf-
> > profile.children.cycles-pp.__check_object_size
> >       0.38 =C2=B1  3%      -0.0        0.35        perf-
> > profile.children.cycles-pp.netif_rx_internal
> >       0.32 =C2=B1  3%      -0.0        0.29        perf-
> > profile.children.cycles-pp.syscall_return_via_sysret
> >       0.16 =C2=B1  4%      -0.0        0.13 =C2=B1  5%  perf-
> > profile.children.cycles-pp.ip_local_out
> >       0.28 =C2=B1  3%      -0.0        0.25 =C2=B1  2%  perf-
> > profile.children.cycles-pp.ttwu_do_wakeup
> >       0.13 =C2=B1  5%      -0.0        0.11 =C2=B1  6%  perf-
> > profile.children.cycles-pp.__virt_addr_valid
> >       0.13 =C2=B1  3%      -0.0        0.11 =C2=B1  6%  perf-
> > profile.children.cycles-pp.nf_hook_slow
> >       0.31            -0.0        0.29 =C2=B1  2%  perf-
> > profile.children.cycles-pp.simple_copy_to_iter
> >       0.11 =C2=B1  6%      -0.0        0.09 =C2=B1  5%  perf-
> > profile.children.cycles-pp.import_single_range
> >       0.11 =C2=B1  9%      -0.0        0.09 =C2=B1  4%  perf-
> > profile.children.cycles-pp.sock_put
> >       0.26 =C2=B1  2%      -0.0        0.24 =C2=B1  3%  perf-
> > profile.children.cycles-pp.check_preempt_curr
> >       0.09 =C2=B1  5%      -0.0        0.07 =C2=B1  7%  perf-
> > profile.children.cycles-pp.__might_fault
> >       0.13 =C2=B1  5%      -0.0        0.11 =C2=B1  4%  perf-
> > profile.children.cycles-pp.copy_fpregs_to_fpstate
> >       0.17 =C2=B1  2%      -0.0        0.15 =C2=B1  3%  perf-
> > profile.children.cycles-pp.tcp_rearm_rto
> >       0.13 =C2=B1  6%      -0.0        0.11 =C2=B1  5%  perf-
> > profile.children.cycles-pp.__cond_resched
> >       0.10 =C2=B1  7%      -0.0        0.09 =C2=B1  4%  perf-
> > profile.children.cycles-pp.tcp_event_data_recv
> >       0.11 =C2=B1  6%      -0.0        0.09 =C2=B1  5%  perf-
> > profile.children.cycles-pp.check_kill_permission
> >       0.23 =C2=B1  3%      -0.0        0.22        perf-
> > profile.children.cycles-pp.__ksize
> >       0.10 =C2=B1  4%      -0.0        0.08 =C2=B1  5%  perf-
> > profile.children.cycles-pp.tcp_update_pacing_rate
> >       0.07 =C2=B1  7%      -0.0        0.05 =C2=B1  8%  perf-
> > profile.children.cycles-pp.server
> >       0.08 =C2=B1  4%      +0.0        0.09 =C2=B1  4%  perf-
> > profile.children.cycles-pp.attach_entity_load_avg
> >       0.07 =C2=B1  5%      +0.0        0.09 =C2=B1  5%  perf-
> > profile.children.cycles-pp.is_module_text_address
> >       0.10 =C2=B1  8%      +0.0        0.12 =C2=B1  5%  perf-
> > profile.children.cycles-pp.set_next_task_idle
> >       0.09 =C2=B1  5%      +0.0        0.11 =C2=B1  4%  perf-
> > profile.children.cycles-pp.__update_idle_core
> >       0.29            +0.0        0.32 =C2=B1  2%  perf-
> > profile.children.cycles-pp.tcp_cleanup_rbuf
> >       0.30            +0.0        0.33        perf-
> > profile.children.cycles-pp.kmem_cache_free
> >       0.13 =C2=B1  5%      +0.0        0.15 =C2=B1  3%  perf-
> > profile.children.cycles-pp.perf_instruction_pointer
> >       0.08 =C2=B1  7%      +0.0        0.10 =C2=B1  6%  perf-
> > profile.children.cycles-pp.cpus_share_cache
> >       0.10 =C2=B1  4%      +0.0        0.13 =C2=B1  5%  perf-
> > profile.children.cycles-pp.pick_next_task_idle
> >       0.20 =C2=B1  3%      +0.0        0.23 =C2=B1  2%  perf-
> > profile.children.cycles-pp.tick_nohz_idle_exit
> >       0.55 =C2=B1  2%      +0.0        0.58        perf-
> > profile.children.cycles-pp.update_rq_clock
> >       0.32 =C2=B1  4%      +0.0        0.34 =C2=B1  2%  perf-
> > profile.children.cycles-pp.tick_nohz_get_sleep_length
> >       0.23 =C2=B1  2%      +0.0        0.26 =C2=B1  2%  perf-
> > profile.children.cycles-pp._find_next_bit
> >       0.19 =C2=B1  5%      +0.0        0.22 =C2=B1  3%  perf-
> > profile.children.cycles-pp.tick_nohz_next_event
> >       0.49 =C2=B1  2%      +0.0        0.52 =C2=B1  2%  perf-
> > profile.children.cycles-pp.finish_task_switch
> >       0.33 =C2=B1  3%      +0.0        0.37        perf-
> > profile.children.cycles-pp.migrate_task_rq_fair
> >       0.22 =C2=B1  5%      +0.0        0.26 =C2=B1  4%  perf-
> > profile.children.cycles-pp.start_kernel
> >       0.19 =C2=B1  2%      +0.0        0.23 =C2=B1  2%  perf-
> > profile.children.cycles-pp.cpumask_next
> >       0.29 =C2=B1  4%      +0.0        0.34 =C2=B1  2%  perf-
> > profile.children.cycles-pp.__slab_free
> >       0.60            +0.0        0.65 =C2=B1  2%  perf-
> > profile.children.cycles-pp.set_next_entity
> >       0.90            +0.0        0.94        perf-
> > profile.children.cycles-pp._raw_spin_lock_irqsave
> >       0.62 =C2=B1  2%      +0.1        0.69        perf-
> > profile.children.cycles-pp.menu_select
> >       2.01            +0.1        2.10        perf-
> > profile.children.cycles-pp.select_idle_cpu
> >       1.16            +0.1        1.27        perf-
> > profile.children.cycles-pp.available_idle_cpu
> >       2.62            +0.2        2.86        perf-
> > profile.children.cycles-pp.select_task_rq_fair
> >       4.07 =C2=B1  2%      +0.2        4.32        perf-
> > profile.children.cycles-pp.enqueue_entity
> >       5.00 =C2=B1  2%      +0.3        5.28        perf-
> > profile.children.cycles-pp.ttwu_do_activate
> >       4.97 =C2=B1  2%      +0.3        5.26        perf-
> > profile.children.cycles-pp.enqueue_task_fair
> >       5.60 =C2=B1  3%      +0.3        5.90        perf-
> > profile.children.cycles-pp.set_task_cpu
> >       2.54 =C2=B1  4%      +0.4        2.91 =C2=B1  4%  perf-
> > profile.children.cycles-pp.update_load_avg
> >       3.37 =C2=B1  2%      +0.4        3.76        perf-
> > profile.children.cycles-pp._raw_spin_lock
> >       2.61 =C2=B1  3%      +0.4        3.02 =C2=B1  2%  perf-
> > profile.children.cycles-pp.native_queued_spin_lock_slowpath
> >       1.46 =C2=B1  8%      +0.4        1.88 =C2=B1  8%  perf-
> > profile.children.cycles-pp.update_cfs_group
> >       3.95 =C2=B1  2%      +0.5        4.42        perf-
> > profile.children.cycles-pp.schedule_idle
> >      17.05            +0.5       17.54        perf-
> > profile.children.cycles-pp.schedule
> >       7.76 =C2=B1  2%      +0.6        8.34        perf-
> > profile.children.cycles-pp.dequeue_entity
> >      23.16            +0.6       23.76        perf-
> > profile.children.cycles-pp.inet_recvmsg
> >      23.07            +0.6       23.67        perf-
> > profile.children.cycles-pp.tcp_recvmsg
> >       8.61 =C2=B1  2%      +0.6        9.23        perf-
> > profile.children.cycles-pp.dequeue_task_fair
> >      22.41            +0.6       23.05        perf-
> > profile.children.cycles-pp.tcp_recvmsg_locked
> >      34.18            +0.7       34.86        perf-
> > profile.children.cycles-pp.__local_bh_enable_ip
> >      33.99            +0.7       34.68        perf-
> > profile.children.cycles-pp.do_softirq
> >      34.00            +0.7       34.69        perf-
> > profile.children.cycles-pp.__softirqentry_text_start
> >      33.40            +0.7       34.14        perf-
> > profile.children.cycles-pp.net_rx_action
> >      33.18            +0.8       33.94        perf-
> > profile.children.cycles-pp.__napi_poll
> >      16.91 =C2=B1  2%      +0.8       17.66        perf-
> > profile.children.cycles-pp.schedule_timeout
> >      17.24 =C2=B1  2%      +0.8       18.00        perf-
> > profile.children.cycles-pp.wait_woken
> >      33.09            +0.8       33.86        perf-
> > profile.children.cycles-pp.process_backlog
> >      18.30            +0.8       19.07        perf-
> > profile.children.cycles-pp.sk_wait_data
> >      32.81            +0.8       33.61        perf-
> > profile.children.cycles-pp.__netif_receive_skb_one_core
> >      32.47            +0.8       33.30        perf-
> > profile.children.cycles-pp.ip_rcv
> >      31.91            +0.9       32.81        perf-
> > profile.children.cycles-pp.ip_local_deliver_finish
> >      31.97            +0.9       32.87        perf-
> > profile.children.cycles-pp.ip_local_deliver
> >      31.86            +0.9       32.77        perf-
> > profile.children.cycles-pp.ip_protocol_deliver_rcu
> >      31.72            +0.9       32.63        perf-
> > profile.children.cycles-pp.tcp_v4_rcv
> >      20.81            +0.9       21.74        perf-
> > profile.children.cycles-pp.__schedule
> >      30.18            +1.0       31.16        perf-
> > profile.children.cycles-pp.tcp_v4_do_rcv
> >      30.03            +1.0       31.04        perf-
> > profile.children.cycles-pp.tcp_rcv_established
> >      25.54 =C2=B1  2%      +1.2       26.76        perf-
> > profile.children.cycles-pp.__wake_up_common
> >      25.29 =C2=B1  2%      +1.2       26.52        perf-
> > profile.children.cycles-pp.try_to_wake_up
> >      26.34 =C2=B1  2%      +1.2       27.58        perf-
> > profile.children.cycles-pp.sock_def_readable
> >      26.04 =C2=B1  2%      +1.2       27.29        perf-
> > profile.children.cycles-pp.__wake_up_common_lock
> >      14.36 =C2=B1  2%      +1.6       15.96        perf-
> > profile.children.cycles-pp.intel_idle
> >      14.80 =C2=B1  2%      +1.7       16.46        perf-
> > profile.children.cycles-pp.cpuidle_enter_state
> >      14.80 =C2=B1  2%      +1.7       16.47        perf-
> > profile.children.cycles-pp.cpuidle_enter
> >      19.89 =C2=B1  2%      +2.3       22.19        perf-
> > profile.children.cycles-pp.start_secondary
> >      20.10 =C2=B1  2%      +2.3       22.43        perf-
> > profile.children.cycles-pp.do_idle
> >      20.12 =C2=B1  2%      +2.3       22.45        perf-
> > profile.children.cycles-pp.secondary_startup_64_no_verify
> >      20.12 =C2=B1  2%      +2.3       22.45        perf-
> > profile.children.cycles-pp.cpu_startup_entry
> >       0.00            +2.4        2.43        perf-
> > profile.children.cycles-pp.select_idle_sibling
> >       1.18 =C2=B1 22%      -0.9        0.30 =C2=B1  2%  perf-
> > profile.self.cycles-pp.aa_sk_perm
> >       0.84 =C2=B1 30%      -0.6        0.23 =C2=B1  4%  perf-
> > profile.self.cycles-pp.aa_get_task_label
> >       0.66 =C2=B1 31%      -0.6        0.10 =C2=B1  4%  perf-
> > profile.self.cycles-pp.apparmor_task_kill
> >       0.61 =C2=B1  5%      -0.1        0.55 =C2=B1  3%  perf-
> > profile.self.cycles-pp._raw_spin_lock_bh
> >       0.52 =C2=B1  4%      -0.1        0.45 =C2=B1  2%  perf-
> > profile.self.cycles-pp.dst_release
> >       0.33 =C2=B1  2%      -0.1        0.26 =C2=B1  2%  perf-
> > profile.self.cycles-pp.select_task_rq_fair
> >       0.43 =C2=B1  6%      -0.1        0.38 =C2=B1  2%  perf-
> > profile.self.cycles-pp.__tcp_transmit_skb
> >       0.70 =C2=B1  3%      -0.1        0.65 =C2=B1  2%  perf-
> > profile.self.cycles-pp.tcp_sendmsg_locked
> >       0.27 =C2=B1  5%      -0.0        0.23        perf-
> > profile.self.cycles-pp.load_new_mm_cr3
> >       0.49 =C2=B1  2%      -0.0        0.45 =C2=B1  2%  perf-
> > profile.self.cycles-pp.switch_fpu_return
> >       0.16 =C2=B1  4%      -0.0        0.12 =C2=B1  3%  perf-
> > profile.self.cycles-pp.tcp_ack_update_rtt
> >       0.33 =C2=B1  3%      -0.0        0.30 =C2=B1  3%  perf-
> > profile.self.cycles-pp.tcp_clean_rtx_queue
> >       0.18 =C2=B1  6%      -0.0        0.15 =C2=B1  2%  perf-
> > profile.self.cycles-pp.__ip_queue_xmit
> >       0.34 =C2=B1  2%      -0.0        0.30 =C2=B1  3%  perf-
> > profile.self.cycles-pp.tcp_write_xmit
> >       0.25 =C2=B1  7%      -0.0        0.22 =C2=B1  6%  perf-
> > profile.self.cycles-pp.switch_mm_irqs_off
> >       0.13 =C2=B1  7%      -0.0        0.10 =C2=B1 12%  perf-
> > profile.self.cycles-pp.tcp_current_mss
> >       0.25 =C2=B1  5%      -0.0        0.22 =C2=B1  3%  perf-
> > profile.self.cycles-pp.ip_finish_output2
> >       0.10 =C2=B1  7%      -0.0        0.07 =C2=B1  8%  perf-
> > profile.self.cycles-pp.exit_to_user_mode_prepare
> >       0.13 =C2=B1  5%      -0.0        0.10 =C2=B1  3%  perf-
> > profile.self.cycles-pp.do_user_addr_fault
> >       0.13 =C2=B1  5%      -0.0        0.11 =C2=B1  6%  perf-
> > profile.self.cycles-pp.__virt_addr_valid
> >       0.21 =C2=B1  6%      -0.0        0.18 =C2=B1  3%  perf-
> > profile.self.cycles-pp.tcp_wfree
> >       0.32 =C2=B1  3%      -0.0        0.29 =C2=B1  2%  perf-
> > profile.self.cycles-pp.syscall_return_via_sysret
> >       0.23 =C2=B1  4%      -0.0        0.21 =C2=B1  2%  perf-
> > profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
> >       0.11 =C2=B1  8%      -0.0        0.09        perf-
> > profile.self.cycles-pp.import_single_range
> >       0.15 =C2=B1  3%      -0.0        0.14 =C2=B1  3%  perf-
> > profile.self.cycles-pp.tcp_rearm_rto
> >       0.09 =C2=B1  8%      -0.0        0.07 =C2=B1  5%  perf-
> > profile.self.cycles-pp.sched_clock_cpu
> >       0.22            -0.0        0.20 =C2=B1  3%  perf-
> > profile.self.cycles-pp.__softirqentry_text_start
> >       0.11 =C2=B1  5%      -0.0        0.09 =C2=B1  5%  perf-
> > profile.self.cycles-pp.__netif_receive_skb_one_core
> >       0.07 =C2=B1  8%      -0.0        0.05 =C2=B1  8%  perf-
> > profile.self.cycles-pp.tcp_v4_do_rcv
> >       0.10 =C2=B1  4%      -0.0        0.08 =C2=B1  7%  perf-
> > profile.self.cycles-pp.perf_callchain
> >       0.13 =C2=B1  5%      -0.0        0.11 =C2=B1  3%  perf-
> > profile.self.cycles-pp.copy_fpregs_to_fpstate
> >       0.13 =C2=B1  5%      -0.0        0.11 =C2=B1  4%  perf-
> > profile.self.cycles-pp.kmem_cache_alloc_node
> >       0.09            -0.0        0.08 =C2=B1  6%  perf-
> > profile.self.cycles-pp.__napi_poll
> >       0.08 =C2=B1  6%      -0.0        0.06 =C2=B1  6%  perf-
> > profile.self.cycles-pp.__x64_sys_sendto
> >       0.12 =C2=B1  3%      -0.0        0.11 =C2=B1  3%  perf-
> > profile.self.cycles-pp.__sys_sendto
> >       0.11 =C2=B1  6%      -0.0        0.09 =C2=B1  5%  perf-
> > profile.self.cycles-pp.__x64_sys_recvfrom
> >       0.14 =C2=B1  3%      -0.0        0.12 =C2=B1  3%  perf-
> > profile.self.cycles-pp.__kmalloc_node_track_caller
> >       0.07 =C2=B1  7%      -0.0        0.05 =C2=B1  8%  perf-
> > profile.self.cycles-pp.ftrace_ops_trampoline
> >       0.09 =C2=B1  5%      -0.0        0.08 =C2=B1  5%  perf-
> > profile.self.cycles-pp.tcp_update_pacing_rate
> >       0.06 =C2=B1  8%      +0.0        0.07        perf-
> > profile.self.cycles-pp.cpuidle_enter_state
> >       0.06            +0.0        0.07 =C2=B1  6%  perf-
> > profile.self.cycles-pp.rcu_nocb_flush_deferred_wakeup
> >       0.08 =C2=B1  7%      +0.0        0.10 =C2=B1  4%  perf-
> > profile.self.cycles-pp.cpus_share_cache
> >       0.05 =C2=B1  8%      +0.0        0.07 =C2=B1  5%  perf-
> > profile.self.cycles-pp.perf_instruction_pointer
> >       0.28            +0.0        0.30 =C2=B1  3%  perf-
> > profile.self.cycles-pp.tcp_cleanup_rbuf
> >       0.18 =C2=B1  5%      +0.0        0.20        perf-
> > profile.self.cycles-pp.migrate_task_rq_fair
> >       0.24 =C2=B1  3%      +0.0        0.27 =C2=B1  2%  perf-
> > profile.self.cycles-pp.menu_select
> >       0.41 =C2=B1  3%      +0.0        0.44 =C2=B1  2%  perf-
> > profile.self.cycles-pp.update_rq_clock
> >       0.22 =C2=B1  4%      +0.0        0.26 =C2=B1  2%  perf-
> > profile.self.cycles-pp._find_next_bit
> >       0.16 =C2=B1  2%      +0.0        0.20 =C2=B1  3%  perf-
> > profile.self.cycles-pp.do_idle
> >       0.29 =C2=B1  3%      +0.0        0.34 =C2=B1  2%  perf-
> > profile.self.cycles-pp.__slab_free
> >       0.87            +0.0        0.92        perf-
> > profile.self.cycles-pp._raw_spin_lock_irqsave
> >       1.24            +0.0        1.29 =C2=B1  2%  perf-
> > profile.self.cycles-pp.__schedule
> >       1.15            +0.1        1.26        perf-
> > profile.self.cycles-pp.available_idle_cpu
> >       0.00            +0.1        0.14 =C2=B1  3%  perf-
> > profile.self.cycles-pp.select_idle_sibling
> >       0.43 =C2=B1  7%      +0.2        0.61 =C2=B1  8%  perf-
> > profile.self.cycles-pp.set_task_cpu
> >       1.78 =C2=B1  4%      +0.3        2.12 =C2=B1  5%  perf-
> > profile.self.cycles-pp.update_load_avg
> >       2.61 =C2=B1  3%      +0.4        3.01 =C2=B1  2%  perf-
> > profile.self.cycles-pp.native_queued_spin_lock_slowpath
> >       1.46 =C2=B1  8%      +0.4        1.88 =C2=B1  8%  perf-
> > profile.self.cycles-pp.update_cfs_group
> >      14.36 =C2=B1  2%      +1.6       15.96        perf-
> > profile.self.cycles-pp.intel_idle
> >   20074513 =C2=B1  7%     -24.9%   15075828 =C2=B1  7%  softirqs.CPU0.N=
ET_RX
> >      38385 =C2=B1 66%    +476.2%     221177 =C2=B1  9%  softirqs.CPU0.S=
CHED
> >      32352 =C2=B1 12%     -78.4%       6999 =C2=B1 45%  softirqs.CPU0.T=
IMER
> >   20359880 =C2=B1  5%     -26.9%   14879840 =C2=B1  7%  softirqs.CPU1.N=
ET_RX
> >      36748 =C2=B1 67%    +492.7%     217810 =C2=B1 10%  softirqs.CPU1.S=
CHED
> >      31252 =C2=B1 13%     -85.5%       4524 =C2=B1 59%  softirqs.CPU1.T=
IMER
> >   20405448 =C2=B1  5%     -25.5%   15210284 =C2=B1  7%  softirqs.CPU10.=
NET_RX
> >      36443 =C2=B1 69%    +499.5%     218467 =C2=B1  9%  softirqs.CPU10.=
SCHED
> >      30609 =C2=B1 11%     -84.5%       4741 =C2=B1 63%  softirqs.CPU10.=
TIMER
> >   20394573 =C2=B1  4%     -29.0%   14484845 =C2=B1 10%  softirqs.CPU11.=
NET_RX
> >      36636 =C2=B1 70%    +464.1%     206683 =C2=B1  7%  softirqs.CPU11.=
SCHED
> >      30678 =C2=B1 11%     -84.8%       4653 =C2=B1 67%  softirqs.CPU11.=
TIMER
> >   20405829 =C2=B1  4%     -26.1%   15089688 =C2=B1  7%  softirqs.CPU12.=
NET_RX
> >      37061 =C2=B1 70%    +494.1%     220185 =C2=B1  8%  softirqs.CPU12.=
SCHED
> >      31218 =C2=B1 10%     -84.2%       4919 =C2=B1 66%  softirqs.CPU12.=
TIMER
> >   20444043 =C2=B1  5%     -26.2%   15095203 =C2=B1  7%  softirqs.CPU13.=
NET_RX
> >      36503 =C2=B1 70%    +497.6%     218132 =C2=B1  9%  softirqs.CPU13.=
SCHED
> >      30651 =C2=B1 11%     -84.6%       4710 =C2=B1 62%  softirqs.CPU13.=
TIMER
> >   20419827 =C2=B1  5%     -25.6%   15186252 =C2=B1  7%  softirqs.CPU14.=
NET_RX
> >      36704 =C2=B1 70%    +494.3%     218149 =C2=B1  9%  softirqs.CPU14.=
SCHED
> >      30681 =C2=B1 11%     -84.3%       4806 =C2=B1 65%  softirqs.CPU14.=
TIMER
> >   20510872 =C2=B1  5%     -25.7%   15232936 =C2=B1  7%  softirqs.CPU15.=
NET_RX
> >      36871 =C2=B1 69%    +493.3%     218761 =C2=B1  9%  softirqs.CPU15.=
SCHED
> >      31009 =C2=B1 12%     -84.5%       4793 =C2=B1 63%  softirqs.CPU15.=
TIMER
> >   20418436 =C2=B1  5%     -25.4%   15224178 =C2=B1  7%  softirqs.CPU16.=
NET_RX
> >      36854 =C2=B1 69%    +495.1%     219327 =C2=B1  9%  softirqs.CPU16.=
SCHED
> >      31013 =C2=B1 11%     -84.7%       4758 =C2=B1 64%  softirqs.CPU16.=
TIMER
> >   20372676 =C2=B1  4%     -25.9%   15095272 =C2=B1  7%  softirqs.CPU17.=
NET_RX
> >      36811 =C2=B1 70%    +494.0%     218669 =C2=B1  9%  softirqs.CPU17.=
SCHED
> >      31390 =C2=B1 13%     -77.9%       6929 =C2=B1 67%  softirqs.CPU17.=
TIMER
> >   20416587 =C2=B1  5%     -26.0%   15118161 =C2=B1  7%  softirqs.CPU18.=
NET_RX
> >      36394 =C2=B1 70%    +502.6%     219293 =C2=B1  9%  softirqs.CPU18.=
SCHED
> >      30912 =C2=B1 11%     -84.5%       4784 =C2=B1 63%  softirqs.CPU18.=
TIMER
> >   20432227 =C2=B1  4%     -25.8%   15168258 =C2=B1  7%  softirqs.CPU19.=
NET_RX
> >      36602 =C2=B1 70%    +497.8%     218796 =C2=B1  9%  softirqs.CPU19.=
SCHED
> >      30843 =C2=B1 11%     -82.9%       5259 =C2=B1 56%  softirqs.CPU19.=
TIMER
> >   20304573 =C2=B1  6%     -26.0%   15034216 =C2=B1  7%  softirqs.CPU2.N=
ET_RX
> >      36968 =C2=B1 69%    +495.1%     220012 =C2=B1  9%  softirqs.CPU2.S=
CHED
> >      30526 =C2=B1 12%     -84.4%       4764 =C2=B1 62%  softirqs.CPU2.T=
IMER
> >   20444514 =C2=B1  5%     -25.5%   15240754 =C2=B1  7%  softirqs.CPU20.=
NET_RX
> >      36759 =C2=B1 70%    +495.9%     219056 =C2=B1  9%  softirqs.CPU20.=
SCHED
> >      30846 =C2=B1 11%     -84.3%       4831 =C2=B1 61%  softirqs.CPU20.=
TIMER
> >   20253081 =C2=B1  6%     -25.1%   15174237 =C2=B1  7%  softirqs.CPU21.=
NET_RX
> >      36699 =C2=B1 70%    +495.2%     218452 =C2=B1  8%  softirqs.CPU21.=
SCHED
> >      30719 =C2=B1 12%     -83.5%       5060 =C2=B1 65%  softirqs.CPU21.=
TIMER
> >   20460332 =C2=B1  4%     -25.8%   15186744 =C2=B1  7%  softirqs.CPU22.=
NET_RX
> >      36652 =C2=B1 70%    +497.1%     218854 =C2=B1  9%  softirqs.CPU22.=
SCHED
> >      30899 =C2=B1 11%     -84.4%       4811 =C2=B1 63%  softirqs.CPU22.=
TIMER
> >   20389322 =C2=B1  5%     -26.5%   14979439 =C2=B1  8%  softirqs.CPU23.=
NET_RX
> >      36717 =C2=B1 70%    +492.5%     217548 =C2=B1  8%  softirqs.CPU23.=
SCHED
> >      30864 =C2=B1 11%     -83.1%       5216 =C2=B1 60%  softirqs.CPU23.=
TIMER
> >   21350836 =C2=B1  3%     -30.0%   14945967 =C2=B1  6%  softirqs.CPU24.=
NET_RX
> >      47117 =C2=B1 46%    +359.7%     216593 =C2=B1  8%  softirqs.CPU24.=
SCHED
> >      31954 =C2=B1 20%     -84.0%       5123 =C2=B1 66%  softirqs.CPU24.=
TIMER
> >   21494795 =C2=B1  3%     -28.6%   15347973 =C2=B1  6%  softirqs.CPU25.=
NET_RX
> >      46755 =C2=B1 49%    +362.6%     216302 =C2=B1  8%  softirqs.CPU25.=
SCHED
> >      30392 =C2=B1  9%     -82.7%       5245 =C2=B1 47%  softirqs.CPU25.=
TIMER
> >   21529925 =C2=B1  3%     -28.8%   15338064 =C2=B1  6%  softirqs.CPU26.=
NET_RX
> >      46989 =C2=B1 48%    +360.6%     216437 =C2=B1  8%  softirqs.CPU26.=
SCHED
> >      30126 =C2=B1  9%     -84.3%       4715 =C2=B1 60%  softirqs.CPU26.=
TIMER
> >   21609177 =C2=B1  3%     -28.9%   15374089 =C2=B1  6%  softirqs.CPU27.=
NET_RX
> >      47211 =C2=B1 48%    +358.1%     216275 =C2=B1  8%  softirqs.CPU27.=
SCHED
> >      30806 =C2=B1  9%     -84.4%       4806 =C2=B1 59%  softirqs.CPU27.=
TIMER
> >   21434518 =C2=B1  3%     -28.0%   15426523 =C2=B1  6%  softirqs.CPU28.=
NET_RX
> >      46072 =C2=B1 49%    +369.3%     216211 =C2=B1  8%  softirqs.CPU28.=
SCHED
> >      29926 =C2=B1 10%     -83.7%       4871 =C2=B1 60%  softirqs.CPU28.=
TIMER
> >   21436007 =C2=B1  3%     -28.3%   15360927 =C2=B1  6%  softirqs.CPU29.=
NET_RX
> >      46751 =C2=B1 48%    +363.2%     216561 =C2=B1  8%  softirqs.CPU29.=
SCHED
> >      29983 =C2=B1  9%     -83.7%       4876 =C2=B1 58%  softirqs.CPU29.=
TIMER
> >   20556029 =C2=B1  5%     -27.1%   14991636 =C2=B1  9%  softirqs.CPU3.N=
ET_RX
> >      36617 =C2=B1 69%    +485.7%     214485 =C2=B1  9%  softirqs.CPU3.S=
CHED
> >      30777 =C2=B1 11%     -82.7%       5311 =C2=B1 54%  softirqs.CPU3.T=
IMER
> >   21514774 =C2=B1  3%     -29.0%   15275932 =C2=B1  6%  softirqs.CPU30.=
NET_RX
> >      46934 =C2=B1 48%    +361.6%     216667 =C2=B1  8%  softirqs.CPU30.=
SCHED
> >      30153 =C2=B1  9%     -84.1%       4799 =C2=B1 58%  softirqs.CPU30.=
TIMER
> >   21317864 =C2=B1  4%     -28.1%   15318620 =C2=B1  6%  softirqs.CPU31.=
NET_RX
> >      46511 =C2=B1 49%    +365.4%     216450 =C2=B1  8%  softirqs.CPU31.=
SCHED
> >      29862 =C2=B1 10%     -83.9%       4819 =C2=B1 60%  softirqs.CPU31.=
TIMER
> >   21191794 =C2=B1  5%     -27.4%   15375714 =C2=B1  6%  softirqs.CPU32.=
NET_RX
> >      45002 =C2=B1 47%    +380.8%     216377 =C2=B1  8%  softirqs.CPU32.=
SCHED
> >      30188 =C2=B1 13%     -84.0%       4825 =C2=B1 60%  softirqs.CPU32.=
TIMER
> >   21594693 =C2=B1  3%     -28.5%   15432125 =C2=B1  6%  softirqs.CPU33.=
NET_RX
> >      46875 =C2=B1 48%    +361.2%     216187 =C2=B1  8%  softirqs.CPU33.=
SCHED
> >      30026 =C2=B1 10%     -84.0%       4803 =C2=B1 60%  softirqs.CPU33.=
TIMER
> >   21459214 =C2=B1  3%     -28.2%   15402703 =C2=B1  6%  softirqs.CPU34.=
NET_RX
> >      45836 =C2=B1 47%    +371.2%     215962 =C2=B1  8%  softirqs.CPU34.=
SCHED
> >      29899 =C2=B1 10%     -84.1%       4764 =C2=B1 58%  softirqs.CPU34.=
TIMER
> >   21334265 =C2=B1  4%     -28.2%   15311475 =C2=B1  6%  softirqs.CPU35.=
NET_RX
> >      46008 =C2=B1 47%    +369.7%     216108 =C2=B1  8%  softirqs.CPU35.=
SCHED
> >      30033 =C2=B1  9%     -83.8%       4872 =C2=B1 61%  softirqs.CPU35.=
TIMER
> >   21434454 =C2=B1  3%     -29.8%   15051817 =C2=B1  6%  softirqs.CPU36.=
NET_RX
> >      47102 =C2=B1 48%    +353.6%     213647 =C2=B1  8%  softirqs.CPU36.=
SCHED
> >      30159 =C2=B1  9%     -84.3%       4724 =C2=B1 59%  softirqs.CPU36.=
TIMER
> >   21446302 =C2=B1  3%     -28.5%   15324037 =C2=B1  6%  softirqs.CPU37.=
NET_RX
> >      46540 =C2=B1 48%    +365.2%     216506 =C2=B1  8%  softirqs.CPU37.=
SCHED
> >      29955 =C2=B1  9%     -84.3%       4688 =C2=B1 60%  softirqs.CPU37.=
TIMER
> >   21408080 =C2=B1  4%     -28.1%   15398099 =C2=B1  6%  softirqs.CPU38.=
NET_RX
> >      46514 =C2=B1 47%    +364.5%     216055 =C2=B1  8%  softirqs.CPU38.=
SCHED
> >      30224 =C2=B1 10%     -84.2%       4763 =C2=B1 59%  softirqs.CPU38.=
TIMER
> >   21488127 =C2=B1  3%     -28.2%   15418075 =C2=B1  6%  softirqs.CPU39.=
NET_RX
> >      46334 =C2=B1 49%    +366.6%     216186 =C2=B1  8%  softirqs.CPU39.=
SCHED
> >      29912 =C2=B1 10%     -84.1%       4757 =C2=B1 59%  softirqs.CPU39.=
TIMER
> >   20494991 =C2=B1  5%     -25.8%   15203629 =C2=B1  7%  softirqs.CPU4.N=
ET_RX
> >      36606 =C2=B1 70%    +500.9%     219950 =C2=B1  8%  softirqs.CPU4.S=
CHED
> >      30735 =C2=B1 11%     -83.9%       4963 =C2=B1 64%  softirqs.CPU4.T=
IMER
> >   21463890 =C2=B1  3%     -28.3%   15380723 =C2=B1  6%  softirqs.CPU40.=
NET_RX
> >      46863 =C2=B1 48%    +361.7%     216368 =C2=B1  8%  softirqs.CPU40.=
SCHED
> >      30014 =C2=B1  9%     -84.1%       4763 =C2=B1 59%  softirqs.CPU40.=
TIMER
> >   21482678 =C2=B1  3%     -28.7%   15323146 =C2=B1  6%  softirqs.CPU41.=
NET_RX
> >      46944 =C2=B1 48%    +361.1%     216451 =C2=B1  8%  softirqs.CPU41.=
SCHED
> >      30167 =C2=B1  9%     -83.9%       4864 =C2=B1 59%  softirqs.CPU41.=
TIMER
> >   21294399 =C2=B1  4%     -28.3%   15278181 =C2=B1  6%  softirqs.CPU42.=
NET_RX
> >      45452 =C2=B1 47%    +376.3%     216501 =C2=B1  8%  softirqs.CPU42.=
SCHED
> >      29866 =C2=B1 10%     -82.6%       5185 =C2=B1 54%  softirqs.CPU42.=
TIMER
> >   21365880 =C2=B1  3%     -28.1%   15358507 =C2=B1  6%  softirqs.CPU43.=
NET_RX
> >      46603 =C2=B1 49%    +364.4%     216428 =C2=B1  8%  softirqs.CPU43.=
SCHED
> >      30073 =C2=B1  9%     -84.0%       4809 =C2=B1 59%  softirqs.CPU43.=
TIMER
> >   21520046 =C2=B1  3%     -28.2%   15449623 =C2=B1  6%  softirqs.CPU44.=
NET_RX
> >      46912 =C2=B1 48%    +361.0%     216249 =C2=B1  8%  softirqs.CPU44.=
SCHED
> >      29983 =C2=B1 10%     -83.8%       4865 =C2=B1 58%  softirqs.CPU44.=
TIMER
> >   21519719 =C2=B1  3%     -28.4%   15408388 =C2=B1  6%  softirqs.CPU45.=
NET_RX
> >      46866 =C2=B1 48%    +361.2%     216163 =C2=B1  8%  softirqs.CPU45.=
SCHED
> >      29935 =C2=B1  9%     -83.0%       5082 =C2=B1 55%  softirqs.CPU45.=
TIMER
> >   21419897 =C2=B1  3%     -28.3%   15362156 =C2=B1  6%  softirqs.CPU46.=
NET_RX
> >      46939 =C2=B1 48%    +361.6%     216649 =C2=B1  8%  softirqs.CPU46.=
SCHED
> >      29931 =C2=B1 10%     -83.4%       4981 =C2=B1 56%  softirqs.CPU46.=
TIMER
> >   21420535 =C2=B1  3%     -28.7%   15271884 =C2=B1  6%  softirqs.CPU47.=
NET_RX
> >      45846 =C2=B1 47%    +370.1%     215519 =C2=B1  8%  softirqs.CPU47.=
SCHED
> >      29858 =C2=B1 10%     -84.1%       4740 =C2=B1 60%  softirqs.CPU47.=
TIMER
> >   20312914 =C2=B1  5%     -25.7%   15093130 =C2=B1  7%  softirqs.CPU48.=
NET_RX
> >      36150 =C2=B1 69%    +505.3%     218836 =C2=B1  9%  softirqs.CPU48.=
SCHED
> >      30533 =C2=B1 12%     -84.7%       4657 =C2=B1 65%  softirqs.CPU48.=
TIMER
> >   20470745 =C2=B1  4%     -28.8%   14574011 =C2=B1  8%  softirqs.CPU49.=
NET_RX
> >      36483 =C2=B1 70%    +488.7%     214762 =C2=B1 11%  softirqs.CPU49.=
SCHED
> >      30893 =C2=B1 11%     -85.0%       4630 =C2=B1 54%  softirqs.CPU49.=
TIMER
> >   20156700 =C2=B1  7%     -24.7%   15172321 =C2=B1  7%  softirqs.CPU5.N=
ET_RX
> >      35518 =C2=B1 68%    +517.8%     219449 =C2=B1  9%  softirqs.CPU5.S=
CHED
> >      30265 =C2=B1 13%     -83.0%       5157 =C2=B1 53%  softirqs.CPU5.T=
IMER
> >   20423756 =C2=B1  5%     -26.0%   15104088 =C2=B1  7%  softirqs.CPU50.=
NET_RX
> >      36375 =C2=B1 70%    +499.0%     217904 =C2=B1  9%  softirqs.CPU50.=
SCHED
> >      30692 =C2=B1 11%     -83.8%       4974 =C2=B1 56%  softirqs.CPU50.=
TIMER
> >   20528259 =C2=B1  5%     -27.9%   14802498 =C2=B1 11%  softirqs.CPU51.=
NET_RX
> >      36471 =C2=B1 71%    +481.1%     211940 =C2=B1  9%  softirqs.CPU51.=
SCHED
> >      30830 =C2=B1 11%     -84.8%       4699 =C2=B1 64%  softirqs.CPU51.=
TIMER
> >   20406992 =C2=B1  4%     -25.5%   15212005 =C2=B1  7%  softirqs.CPU52.=
NET_RX
> >      36584 =C2=B1 70%    +498.1%     218812 =C2=B1  9%  softirqs.CPU52.=
SCHED
> >      30640 =C2=B1 11%     -83.2%       5158 =C2=B1 60%  softirqs.CPU52.=
TIMER
> >   20215189 =C2=B1  6%     -25.1%   15148729 =C2=B1  7%  softirqs.CPU53.=
NET_RX
> >      35623 =C2=B1 68%    +515.2%     219165 =C2=B1  9%  softirqs.CPU53.=
SCHED
> >      30368 =C2=B1 13%     -82.7%       5247 =C2=B1 54%  softirqs.CPU53.=
TIMER
> >   20363531 =C2=B1  5%     -25.9%   15088299 =C2=B1  7%  softirqs.CPU54.=
NET_RX
> >      36829 =C2=B1 70%    +495.7%     219407 =C2=B1  9%  softirqs.CPU54.=
SCHED
> >      30604 =C2=B1 12%     -84.6%       4718 =C2=B1 63%  softirqs.CPU54.=
TIMER
> >   20446122 =C2=B1  5%     -26.0%   15123333 =C2=B1  7%  softirqs.CPU55.=
NET_RX
> >      36648 =C2=B1 70%    +496.4%     218572 =C2=B1  9%  softirqs.CPU55.=
SCHED
> >      30692 =C2=B1 11%     -84.3%       4807 =C2=B1 61%  softirqs.CPU55.=
TIMER
> >   20460809 =C2=B1  5%     -26.2%   15103440 =C2=B1  6%  softirqs.CPU56.=
NET_RX
> >      36546 =C2=B1 71%    +499.2%     218984 =C2=B1  9%  softirqs.CPU56.=
SCHED
> >      30796 =C2=B1 11%     -85.0%       4612 =C2=B1 60%  softirqs.CPU56.=
TIMER
> >   20579289 =C2=B1  5%     -25.7%   15290133 =C2=B1  7%  softirqs.CPU57.=
NET_RX
> >      36635 =C2=B1 70%    +497.9%     219057 =C2=B1  9%  softirqs.CPU57.=
SCHED
> >      30824 =C2=B1 11%     -84.1%       4887 =C2=B1 61%  softirqs.CPU57.=
TIMER
> >   20340209 =C2=B1  5%     -25.1%   15226056 =C2=B1  7%  softirqs.CPU58.=
NET_RX
> >      36661 =C2=B1 70%    +497.4%     219034 =C2=B1  9%  softirqs.CPU58.=
SCHED
> >      30643 =C2=B1 12%     -83.8%       4958 =C2=B1 67%  softirqs.CPU58.=
TIMER
> >   20407456 =C2=B1  5%     -31.2%   14032788 =C2=B1 14%  softirqs.CPU59.=
NET_RX
> >      36581 =C2=B1 70%    +445.7%     199631 =C2=B1  7%  softirqs.CPU59.=
SCHED
> >      30705 =C2=B1 11%     -84.8%       4662 =C2=B1 66%  softirqs.CPU59.=
TIMER
> >   20391632 =C2=B1  5%     -26.0%   15081271 =C2=B1  7%  softirqs.CPU6.N=
ET_RX
> >      36990 =C2=B1 70%    +492.1%     219031 =C2=B1  9%  softirqs.CPU6.S=
CHED
> >      31051 =C2=B1 10%     -84.9%       4685 =C2=B1 66%  softirqs.CPU6.T=
IMER
> >   20313212 =C2=B1  5%     -25.8%   15082404 =C2=B1  7%  softirqs.CPU60.=
NET_RX
> >      36711 =C2=B1 70%    +497.9%     219487 =C2=B1  9%  softirqs.CPU60.=
SCHED
> >      30611 =C2=B1 12%     -77.9%       6758 =C2=B1 62%  softirqs.CPU60.=
TIMER
> >   20370636 =C2=B1  5%     -25.5%   15182632 =C2=B1  7%  softirqs.CPU61.=
NET_RX
> >      36456 =C2=B1 69%    +499.3%     218484 =C2=B1  9%  softirqs.CPU61.=
SCHED
> >      30655 =C2=B1 11%     -83.6%       5031 =C2=B1 56%  softirqs.CPU61.=
TIMER
> >   20447745 =C2=B1  5%     -25.8%   15175825 =C2=B1  7%  softirqs.CPU62.=
NET_RX
> >      36878 =C2=B1 70%    +491.8%     218266 =C2=B1  9%  softirqs.CPU62.=
SCHED
> >      30914 =C2=B1 12%     -83.8%       5002 =C2=B1 63%  softirqs.CPU62.=
TIMER
> >   20585734 =C2=B1  4%     -26.3%   15163240 =C2=B1  7%  softirqs.CPU63.=
NET_RX
> >      36766 =C2=B1 69%    +493.6%     218247 =C2=B1  9%  softirqs.CPU63.=
SCHED
> >      30783 =C2=B1 11%     -84.3%       4848 =C2=B1 63%  softirqs.CPU63.=
TIMER
> >   20529909 =C2=B1  5%     -26.0%   15201926 =C2=B1  7%  softirqs.CPU64.=
NET_RX
> >      36996 =C2=B1 69%    +492.3%     219138 =C2=B1  9%  softirqs.CPU64.=
SCHED
> >      31589 =C2=B1 12%     -84.3%       4944 =C2=B1 59%  softirqs.CPU64.=
TIMER
> >   20469049 =C2=B1  5%     -26.2%   15105347 =C2=B1  7%  softirqs.CPU65.=
NET_RX
> >      36816 =C2=B1 70%    +495.3%     219168 =C2=B1  9%  softirqs.CPU65.=
SCHED
> >      31163 =C2=B1 11%     -84.5%       4843 =C2=B1 62%  softirqs.CPU65.=
TIMER
> >   20451275 =C2=B1  5%     -26.1%   15117422 =C2=B1  7%  softirqs.CPU66.=
NET_RX
> >      36621 =C2=B1 70%    +498.4%     219158 =C2=B1  9%  softirqs.CPU66.=
SCHED
> >      31143 =C2=B1 11%     -84.5%       4812 =C2=B1 63%  softirqs.CPU66.=
TIMER
> >   20535600 =C2=B1  4%     -26.1%   15183175 =C2=B1  7%  softirqs.CPU67.=
NET_RX
> >      36716 =C2=B1 70%    +496.0%     218827 =C2=B1  9%  softirqs.CPU67.=
SCHED
> >      31123 =C2=B1 11%     -84.5%       4811 =C2=B1 62%  softirqs.CPU67.=
TIMER
> >   20606503 =C2=B1  4%     -25.9%   15263709 =C2=B1  7%  softirqs.CPU68.=
NET_RX
> >      36843 =C2=B1 71%    +493.6%     218696 =C2=B1  9%  softirqs.CPU68.=
SCHED
> >      31375 =C2=B1 10%     -84.5%       4850 =C2=B1 61%  softirqs.CPU68.=
TIMER
> >   20565997 =C2=B1  4%     -26.1%   15207162 =C2=B1  7%  softirqs.CPU69.=
NET_RX
> >      36903 =C2=B1 70%    +493.4%     218980 =C2=B1  9%  softirqs.CPU69.=
SCHED
> >      31377 =C2=B1 10%     -84.6%       4840 =C2=B1 63%  softirqs.CPU69.=
TIMER
> >   20398774 =C2=B1  5%     -26.3%   15029635 =C2=B1  7%  softirqs.CPU7.N=
ET_RX
> >      36601 =C2=B1 69%    +495.4%     217915 =C2=B1  9%  softirqs.CPU7.S=
CHED
> >      30791 =C2=B1 11%     -84.9%       4640 =C2=B1 66%  softirqs.CPU7.T=
IMER
> >   20433298 =C2=B1  4%     -26.2%   15079571 =C2=B1  7%  softirqs.CPU70.=
NET_RX
> >      36471 =C2=B1 70%    +499.8%     218755 =C2=B1  9%  softirqs.CPU70.=
SCHED
> >      31125 =C2=B1 11%     -84.6%       4791 =C2=B1 61%  softirqs.CPU70.=
TIMER
> >   20514519 =C2=B1  4%     -26.6%   15064099 =C2=B1  7%  softirqs.CPU71.=
NET_RX
> >      36787 =C2=B1 70%    +493.4%     218283 =C2=B1  9%  softirqs.CPU71.=
SCHED
> >      31230 =C2=B1 11%     -84.3%       4914 =C2=B1 64%  softirqs.CPU71.=
TIMER
> >   21343935 =C2=B1  3%     -29.8%   14976558 =C2=B1  6%  softirqs.CPU72.=
NET_RX
> >      47439 =C2=B1 47%    +356.6%     216628 =C2=B1  8%  softirqs.CPU72.=
SCHED
> >      33558 =C2=B1 25%     -86.3%       4611 =C2=B1 62%  softirqs.CPU72.=
TIMER
> >   21417052 =C2=B1  3%     -28.3%   15349903 =C2=B1  6%  softirqs.CPU73.=
NET_RX
> >      46794 =C2=B1 48%    +362.8%     216549 =C2=B1  8%  softirqs.CPU73.=
SCHED
> >      30149 =C2=B1 10%     -83.8%       4893 =C2=B1 57%  softirqs.CPU73.=
TIMER
> >   21398667 =C2=B1  3%     -28.4%   15321598 =C2=B1  6%  softirqs.CPU74.=
NET_RX
> >     117019 =C2=B1 29%     -36.5%      74286 =C2=B1 24%  softirqs.CPU74.=
RCU
> >      46710 =C2=B1 47%    +363.0%     216256 =C2=B1  8%  softirqs.CPU74.=
SCHED
> >      30250 =C2=B1 10%     -84.3%       4756 =C2=B1 61%  softirqs.CPU74.=
TIMER
> >   21158934 =C2=B1  6%     -27.3%   15387291 =C2=B1  6%  softirqs.CPU75.=
NET_RX
> >     116793 =C2=B1 29%     -36.3%      74379 =C2=B1 24%  softirqs.CPU75.=
RCU
> >      46862 =C2=B1 48%    +361.5%     216265 =C2=B1  8%  softirqs.CPU75.=
SCHED
> >      29925 =C2=B1 11%     -83.8%       4847 =C2=B1 57%  softirqs.CPU75.=
TIMER
> >   21327908 =C2=B1  4%     -27.8%   15394469 =C2=B1  6%  softirqs.CPU76.=
NET_RX
> >      45803 =C2=B1 47%    +372.3%     216338 =C2=B1  8%  softirqs.CPU76.=
SCHED
> >      30109 =C2=B1 10%     -83.7%       4920 =C2=B1 57%  softirqs.CPU76.=
TIMER
> >   21477994 =C2=B1  4%     -28.6%   15330910 =C2=B1  6%  softirqs.CPU77.=
NET_RX
> >      46487 =C2=B1 47%    +365.6%     216466 =C2=B1  8%  softirqs.CPU77.=
SCHED
> >      30216 =C2=B1 10%     -84.4%       4726 =C2=B1 59%  softirqs.CPU77.=
TIMER
> >   21460057 =C2=B1  4%     -29.1%   15225183 =C2=B1  6%  softirqs.CPU78.=
NET_RX
> >      46884 =C2=B1 48%    +362.1%     216676 =C2=B1  8%  softirqs.CPU78.=
SCHED
> >      30421 =C2=B1 10%     -84.4%       4730 =C2=B1 60%  softirqs.CPU78.=
TIMER
> >   21541321 =C2=B1  3%     -28.9%   15319139 =C2=B1  6%  softirqs.CPU79.=
NET_RX
> >      46875 =C2=B1 48%    +362.6%     216857 =C2=B1  8%  softirqs.CPU79.=
SCHED
> >      30230 =C2=B1  9%     -82.5%       5291 =C2=B1 76%  softirqs.CPU79.=
TIMER
> >   20493021 =C2=B1  4%     -26.0%   15160469 =C2=B1  7%  softirqs.CPU8.N=
ET_RX
> >      36579 =C2=B1 70%    +498.1%     218781 =C2=B1  9%  softirqs.CPU8.S=
CHED
> >      30682 =C2=B1 11%     -84.4%       4790 =C2=B1 59%  softirqs.CPU8.T=
IMER
> >   21172364 =C2=B1  7%     -27.3%   15402317 =C2=B1  6%  softirqs.CPU80.=
NET_RX
> >      46254 =C2=B1 47%    +368.0%     216468 =C2=B1  8%  softirqs.CPU80.=
SCHED
> >      29465 =C2=B1 12%     -83.2%       4953 =C2=B1 56%  softirqs.CPU80.=
TIMER
> >   21567300 =C2=B1  3%     -28.5%   15430307 =C2=B1  6%  softirqs.CPU81.=
NET_RX
> >      46695 =C2=B1 48%    +362.7%     216072 =C2=B1  8%  softirqs.CPU81.=
SCHED
> >      30093 =C2=B1  9%     -84.0%       4801 =C2=B1 60%  softirqs.CPU81.=
TIMER
> >   21491215 =C2=B1  3%     -28.3%   15417714 =C2=B1  6%  softirqs.CPU82.=
NET_RX
> >      46133 =C2=B1 47%    +368.7%     216210 =C2=B1  8%  softirqs.CPU82.=
SCHED
> >      29921 =C2=B1 10%     -76.8%       6934 =C2=B1 67%  softirqs.CPU82.=
TIMER
> >   21460124 =C2=B1  3%     -28.5%   15348172 =C2=B1  6%  softirqs.CPU83.=
NET_RX
> >      46491 =C2=B1 48%    +365.6%     216476 =C2=B1  8%  softirqs.CPU83.=
SCHED
> >      29970 =C2=B1 10%     -83.7%       4888 =C2=B1 56%  softirqs.CPU83.=
TIMER
> >   21445385 =C2=B1  4%     -30.8%   14839411 =C2=B1  9%  softirqs.CPU84.=
NET_RX
> >      46941 =C2=B1 48%    +350.7%     211545 =C2=B1  9%  softirqs.CPU84.=
SCHED
> >      30037 =C2=B1 10%     -84.3%       4718 =C2=B1 60%  softirqs.CPU84.=
TIMER
> >   21551635 =C2=B1  3%     -28.9%   15333781 =C2=B1  6%  softirqs.CPU85.=
NET_RX
> >      46814 =C2=B1 48%    +362.1%     216323 =C2=B1  8%  softirqs.CPU85.=
SCHED
> >      29996 =C2=B1 10%     -83.9%       4817 =C2=B1 59%  softirqs.CPU85.=
TIMER
> >   21556404 =C2=B1  3%     -28.6%   15382397 =C2=B1  6%  softirqs.CPU86.=
NET_RX
> >      46934 =C2=B1 48%    +360.7%     216231 =C2=B1  8%  softirqs.CPU86.=
SCHED
> >      30053 =C2=B1  9%     -83.7%       4900 =C2=B1 55%  softirqs.CPU86.=
TIMER
> >   21549266 =C2=B1  3%     -28.5%   15417462 =C2=B1  6%  softirqs.CPU87.=
NET_RX
> >      46429 =C2=B1 49%    +366.0%     216351 =C2=B1  8%  softirqs.CPU87.=
SCHED
> >      29937 =C2=B1 10%     -83.9%       4806 =C2=B1 58%  softirqs.CPU87.=
TIMER
> >   21537823 =C2=B1  3%     -28.7%   15361608 =C2=B1  6%  softirqs.CPU88.=
NET_RX
> >      46887 =C2=B1 48%    +360.1%     215706 =C2=B1  8%  softirqs.CPU88.=
SCHED
> >      29981 =C2=B1  9%     -84.1%       4781 =C2=B1 59%  softirqs.CPU88.=
TIMER
> >   21559950 =C2=B1  3%     -29.0%   15300783 =C2=B1  6%  softirqs.CPU89.=
NET_RX
> >      46878 =C2=B1 48%    +361.6%     216403 =C2=B1  8%  softirqs.CPU89.=
SCHED
> >      30017 =C2=B1  9%     -84.1%       4783 =C2=B1 59%  softirqs.CPU89.=
TIMER
> >   20571529 =C2=B1  5%     -25.7%   15286193 =C2=B1  7%  softirqs.CPU9.N=
ET_RX
> >      36585 =C2=B1 70%    +498.6%     219007 =C2=B1  9%  softirqs.CPU9.S=
CHED
> >      30724 =C2=B1 11%     -83.7%       5009 =C2=B1 58%  softirqs.CPU9.T=
IMER
> >   21116816 =C2=B1  5%     -27.5%   15303522 =C2=B1  6%  softirqs.CPU90.=
NET_RX
> >      46158 =C2=B1 48%    +368.6%     216275 =C2=B1  8%  softirqs.CPU90.=
SCHED
> >      29583 =C2=B1 11%     -83.6%       4842 =C2=B1 58%  softirqs.CPU90.=
TIMER
> >   21247319 =C2=B1  4%     -27.6%   15382623 =C2=B1  6%  softirqs.CPU91.=
NET_RX
> >      46803 =C2=B1 48%    +362.0%     216238 =C2=B1  8%  softirqs.CPU91.=
SCHED
> >      29690 =C2=B1 10%     -83.6%       4856 =C2=B1 58%  softirqs.CPU91.=
TIMER
> >   21660224 =C2=B1  3%     -28.6%   15460344 =C2=B1  6%  softirqs.CPU92.=
NET_RX
> >      46935 =C2=B1 48%    +359.9%     215852 =C2=B1  8%  softirqs.CPU92.=
SCHED
> >      30143 =C2=B1  9%     -84.0%       4814 =C2=B1 59%  softirqs.CPU92.=
TIMER
> >   21653985 =C2=B1  3%     -28.9%   15405532 =C2=B1  6%  softirqs.CPU93.=
NET_RX
> >      46972 =C2=B1 48%    +359.5%     215821 =C2=B1  8%  softirqs.CPU93.=
SCHED
> >      30034 =C2=B1 10%     -83.5%       4964 =C2=B1 59%  softirqs.CPU93.=
TIMER
> >   21602751 =C2=B1  3%     -28.8%   15385232 =C2=B1  6%  softirqs.CPU94.=
NET_RX
> >      46892 =C2=B1 48%    +362.2%     216728 =C2=B1  8%  softirqs.CPU94.=
SCHED
> >      29959 =C2=B1 10%     -83.6%       4921 =C2=B1 58%  softirqs.CPU94.=
TIMER
> >   21277877 =C2=B1  4%     -28.4%   15224899 =C2=B1  6%  softirqs.CPU95.=
NET_RX
> >      45607 =C2=B1 48%    +373.5%     215952 =C2=B1  8%  softirqs.CPU95.=
SCHED
> >      29711 =C2=B1 10%     -83.0%       5065 =C2=B1 55%  softirqs.CPU95.=
TIMER
> >  2.009e+09           -27.4%   1.46e+09 =C2=B1  5%  softirqs.NET_RX
> >    3996567 =C2=B1 14%    +421.3%   20835185 =C2=B1  8%  softirqs.SCHED
> >    2929735 =C2=B1  3%     -83.8%     474988 =C2=B1 53%  softirqs.TIMER
> >=20
> >=20
> >                                                                   =20
> >             =20
> >                               tbench.throughput-
> > MB_sec                         =20
> >                                                                   =20
> >             =20
> >   16000 +--------------------------------------------------------
> > -----------+  =20
> >         |                  .+.          .+.                       =20
> >          |  =20
> >   15000 |.+.+..+. .+.+.+..+   +.+.+..+.+   +. .+..+.
> > .+.+.    .+.+.+.+..+.+.|  =20
> >         |        +                           +      +     +..+    =20
> >          |  =20
> >   14000 |-
> > +                                                                 |
> >   =20
> >         |                                                         =20
> >          |  =20
> >   13000 |-
> > +                                                                 |
> >   =20
> >         |                                                         =20
> >          |  =20
> >   12000 |-
> > +                                                                 |
> >   =20
> >         | O                     O O    O
> > O                           O      |  =20
> >   11000 |-+            O    O
> > O                     O          O        O   |  =20
> >         |      O O O O    O          O     O O O  O   O O
> > O      O        O |  =20
> >   10000 |-+
> > O                                                O     O        | =20
> > =20
> >         |                                                         =20
> >          |  =20
> >    9000 +--------------------------------------------------------
> > -----------+  =20
> >                                                                   =20
> >             =20
> >                                                                   =20
> >                                                                   =20
> >                          =20
> >                                tbench.time.user_time              =20
> >             =20
> >                                                                   =20
> >             =20
> >   5200 +-----------------------------------------------------------
> > ---------+  =20
> >   5000 |-+.+..          .+.+   +..   .+.+..     + +    + :      .+.
> > .+..   .|  =20
> >        |.+    +.+. .+..+    + +   +.+      +. .+   +
> > .+  :    .+   +    +.+ |  =20
> >   4800 |-
> > +        +          +               +      +     +.+.             =20
> > |  =20
> >   4600 |-
> > +                                                                 =20
> > |  =20
> >        |                                                          =20
> >          |  =20
> >   4400 |-
> > +                                                                 =20
> > |  =20
> >   4200 |-
> > +                                                                 =20
> > |  =20
> >   4000 |-+                     O  O   O
> > O                            O      |  =20
> >        |
> > O                   O                      O          O        O  =20
> > |  =20
> >   3800 |-+             O   O                   O
> > O                          |  =20
> >   3600 |-+    O O   O    O                   O        O
> > O                 O |  =20
> >        |   O      O                                       O
> > O    O          |  =20
> >   3400 |-
> > +                          O      O                       O       =20
> > |  =20
> >   3200 +-----------------------------------------------------------
> > ---------+  =20
> >                                                                   =20
> >             =20
> >                                                                   =20
> >                                                                   =20
> >                          =20
> >                                tbench.time.system_time            =20
> >             =20
> >                                                                   =20
> >             =20
> >   34000 +--------------------------------------------------------
> > -----------+  =20
> >   32000 |.+     .+  :            .+.. .+.+.
> > .+.    .+.        .+   +.+..+.+.|  =20
> >         | +.+..+    :
> > .+..+.+.+.+    +     +   +..+   +.+.+..+              |  =20
> >   30000 |-
> > +          +                                                      |
> >   =20
> >   28000 |-
> > +                                                                 |
> >   =20
> >         |                                                         =20
> >          |  =20
> >   26000 |-
> > +                                                                 |
> >   =20
> >   24000 |-
> > +                                                                 |
> >   =20
> >   22000 |-
> > +                                                                 |
> >   =20
> >         |                                                         =20
> >          |  =20
> >   20000 |-
> > +                       O      O                           O      |
> >   =20
> >   18000 |-
> > O                 O   O      O            O          O            |
> >   =20
> >         |              O      O      O     O O
> > O  O     O               O O |  =20
> >   16000 |-+ O  O O O
> > O    O                           O   O  O   O          |  =20
> >   14000 +--------------------------------------------------------
> > -----------+  =20
> >                                                                   =20
> >             =20
> >                                                                   =20
> >                                                                   =20
> >                          =20
> >                       tbench.time.percent_of_cpu_this_job_got     =20
> >             =20
> >                                                                   =20
> >             =20
> >   5500 +-----------------------------------------------------------
> > ---------+  =20
> >        |.       +.+              .+. .+.+..
> > .+     .+         .+.+.    .+.+.|  =20
> >   5000 |-+.    +   +  .+.+.+.+.+.   +      +  + .+.  +
> > .+.+.+.     +.+.     |  =20
> >        |   +..+     +.                         +      +           =20
> >          |  =20
> >        |                                                          =20
> >          |  =20
> >   4500 |-
> > +                                                                 =20
> > |  =20
> >        |                                                          =20
> >          |  =20
> >   4000 |-
> > +                                                                 =20
> > |  =20
> >        |                                                          =20
> >          |  =20
> >   3500 |-
> > +                                                                 =20
> > |  =20
> >        |                                                          =20
> >   O      |  =20
> >        |                       O  O   O
> > O                      O            |  =20
> >   3000 |-O                 O O                 O
> > O  O                   O   |  =20
> >        |      O O O O  O O          O      O O        O O O
> > O    O        O |  =20
> >   2500 +-----------------------------------------------------------
> > ---------+  =20
> >                                                                   =20
> >             =20
> >                                                                   =20
> >                                                                   =20
> >                          =20
> >                         tbench.time.voluntary_context_switches    =20
> >             =20
> >                                                                   =20
> >             =20
> >   1.4e+09 +------------------------------------------------------
> > -----------+  =20
> >           |   O
> > O    O     O                                 O     O        |  =20
> >   1.2e+09 |-O      O   O O     O      O     O O O O    O O
> > O     O      O O |  =20
> >           |                  O   O      O            O         O  =20
> >          |  =20
> >     1e+09 |-
> > +                       O     O                           O     | =20
> > =20
> >           |                                                       =20
> >          |  =20
> >     8e+08 |-
> > +                                                               | =20
> > =20
> >           |                                                       =20
> >          |  =20
> >     6e+08 |-
> > +                                                               | =20
> > =20
> >           |                                                       =20
> >          |  =20
> >     4e+08 |-
> > +                                                               | =20
> > =20
> >           |  .+.+..    +.                       +.     +.         =20
> >          |  =20
> >     2e+08 |.+         +  +.+.+.+.+.. .+.   .+. +  +..
> > +  +.+.+.   .+..+.   .|  =20
> >           |        +.+              +   +.+   +      +         +.+=20
> >      +.+ |  =20
> >         0 +------------------------------------------------------
> > -----------+  =20
> >                                                                   =20
> >             =20
> >                                                                   =20
> >                                                                   =20
> >                          =20
> >                        tbench.time.involuntary_context_switches   =20
> >             =20
> >                                                                   =20
> >             =20
> >     2e+09 +------------------------------------------------------
> > -----------+  =20
> >   1.8e+09 |.+.    .+  + .+.+.+.+.+..+.+.+   +.+. .+..+.
> > .+.   .+   +..+.+.+.|  =20
> >           |   +.+.     +                        +      +   +.+    =20
> >          |  =20
> >   1.6e+09 |-
> > +                                                               | =20
> > =20
> >   1.4e+09 |-
> > +                                                               | =20
> > =20
> >           |                                                       =20
> >          |  =20
> >   1.2e+09 |-
> > +                                                               | =20
> > =20
> >     1e+09 |-
> > +                                                               | =20
> > =20
> >     8e+08 |-
> > +                                                               | =20
> > =20
> >           |                                                       =20
> >          |  =20
> >     6e+08 |-
> > +                       O     O                           O     | =20
> > =20
> >     4e+08 |-
> > O                O   O      O            O         O            | =20
> > =20
> >           |              O     O      O     O   O
> > O      O              O   |  =20
> >     2e+08 |-+ O O  O O O   O                  O        O   O
> > O   O        O |  =20
> >         0 +------------------------------------------------------
> > -----------+  =20
> >                                                                   =20
> >             =20
> >                                                                   =20
> >             =20
> > [*] bisect-good sample
> > [O] bisect-bad  sample
> >=20
> >=20
> >=20
> > Disclaimer:
> > Results have been estimated based on internal Intel analysis and
> > are provided
> > for informational purposes only. Any difference in system hardware
> > or software
> > design or configuration may affect actual performance.
> >=20
> >=20
> > ---
> > 0DAY/LKP+ Test Infrastructure                   Open Source
> > Technology Center
> > https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel
> > Corporation
> >=20
> > Thanks,
> > Oliver Sang
> >=20
> >=20
> >=20
> > _______________________________________________
> > LKP mailing list -- lkp@lists.01.org
> > To unsubscribe send an email to lkp-leave@lists.01.org
> =20
--=20
All Rights Reversed.

--=-3RAqqMZngejL9R9dpnPv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmCu/VcACgkQznnekoTE
3oNvxAf6A1sAqioCq10bRH35KHubdaIuN9geVZJjgzWBladTOGTFJt6z+7X5kvQK
vwPSdXSJrrcUanqkZxyDpmRwr1Zqd6v2SVmyZSw99oHnLCbab02gQyxN7RmyqH+S
j117YZe+93MSUa+gB9DxA4xU85T6YiflFJHjyB2Bwhp0LztmL8NhzQn+WSPk6thm
JZzPawMavsrO6eteqVOK5w/Zzzu3ukxB0mvVyfr3j+LCsghGSJSG47an+73LUYOZ
WFGZ+Mcj2/T+QZe6J5B8ikcZ8yp85pGCR3JcnwAgH4IPYxRjVGQ6gNG6ldgalVLP
w8V2vHunGF9NDhNt68lUIXXIulmCUQ==
=JCqM
-----END PGP SIGNATURE-----

--=-3RAqqMZngejL9R9dpnPv--

