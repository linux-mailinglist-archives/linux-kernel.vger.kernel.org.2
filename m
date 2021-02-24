Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A2C3242B2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbhBXQ5V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 Feb 2021 11:57:21 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:36436 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbhBXQzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:55:35 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lExQt-00DZ1b-De; Wed, 24 Feb 2021 09:54:43 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lExQo-0002Bt-T5; Wed, 24 Feb 2021 09:54:39 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ying.huang@intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        io-uring@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-mm@kvack.org, Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
References: <20210224051845.GB6114@xsang-OptiPlex-9020>
Date:   Wed, 24 Feb 2021 10:54:17 -0600
In-Reply-To: <20210224051845.GB6114@xsang-OptiPlex-9020> (kernel test robot's
        message of "Wed, 24 Feb 2021 13:18:45 +0800")
Message-ID: <m1czwpl83q.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1lExQo-0002Bt-T5;;;mid=<m1czwpl83q.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18PUPfhz92CNLtiv/7aFzG939PKvVvDJaY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: ******
X-Spam-Status: No, score=6.8 required=8.0 tests=ALL_TRUSTED,BAYES_99,BAYES_999,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,T_TM2_M_HEADER_IN_MSG,XMSubLong,
        XM_B_SpammyTLD,XM_B_Unicode autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  5.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XM_B_SpammyTLD Contains uncommon/spammy TLD
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ******;kernel test robot <oliver.sang@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 3739 ms - load_scoreonly_sql: 0.14 (0.0%),
        signal_user_changed: 14 (0.4%), b_tie_ro: 12 (0.3%), parse: 7 (0.2%),
        extract_message_metadata: 115 (3.1%), get_uri_detail_list: 67 (1.8%),
        tests_pri_-1000: 13 (0.4%), tests_pri_-950: 1.36 (0.0%),
        tests_pri_-900: 1.14 (0.0%), tests_pri_-90: 380 (10.2%), check_bayes:
        342 (9.2%), b_tokenize: 122 (3.3%), b_tok_get_all: 91 (2.4%),
        b_comp_prob: 24 (0.6%), b_tok_touch_all: 89 (2.4%), b_finish: 0.97
        (0.0%), tests_pri_0: 3027 (81.0%), check_dkim_signature: 2.4 (0.1%),
        check_dkim_adsp: 3.5 (0.1%), poll_dns_idle: 152 (4.1%), tests_pri_10:
        2.7 (0.1%), tests_pri_500: 164 (4.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: d28296d248:  stress-ng.sigsegv.ops_per_sec -82.7% regression
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <oliver.sang@intel.com> writes:

> Greeting,
>
> FYI, we noticed a -82.7% regression of stress-ng.sigsegv.ops_per_sec due to commit:
>
>
> commit: d28296d2484fa11e94dff65e93eb25802a443d47 ("[PATCH v7 5/7] Reimplement RLIMIT_SIGPENDING on top of ucounts")
> url: https://github.com/0day-ci/linux/commits/Alexey-Gladkov/Count-rlimits-in-each-user-namespace/20210222-175836
> base: https://git.kernel.org/cgit/linux/kernel/git/shuah/linux-kselftest.git next
>
> in testcase: stress-ng
> on test machine: 48 threads Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz with 112G memory
> with following parameters:
>
> 	nr_threads: 100%
> 	disk: 1HDD
> 	testtime: 60s
> 	class: interrupt
> 	test: sigsegv
> 	cpufreq_governor: performance
> 	ucode: 0x42e
>
>
> In addition to that, the commit also has significant impact on the
> following tests:

Thank you.  Now we have a sense of where we need to test the performance
of these changes carefully.

Eric


> +------------------+-----------------------------------------------------------------------+
> | testcase: change | stress-ng: stress-ng.sigq.ops_per_sec -56.1% regression               |
> | test machine     | 48 threads Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz with 112G memory |
> | test parameters  | class=interrupt                                                       |
> |                  | cpufreq_governor=performance                                          |
> |                  | disk=1HDD                                                             |
> |                  | nr_threads=100%                                                       |
> |                  | test=sigq                                                             |
> |                  | testtime=60s                                                          |
> |                  | ucode=0x42e                                                           |
> +------------------+-----------------------------------------------------------------------+
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
>
> Details are as below:
> -------------------------------------------------------------------------------------------------->
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install                job.yaml  # job file is attached in this email
>         bin/lkp split-job --compatible job.yaml
>         bin/lkp run                    compatible-job.yaml
>
> =========================================================================================
> class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime/ucode:
>   interrupt/gcc-9/performance/1HDD/x86_64-rhel-8.3/100%/debian-10.4-x86_64-20200603.cgz/lkp-ivb-2ep1/sigsegv/stress-ng/60s/0x42e
>
> commit: 
>   4660d663b4 ("Reimplement RLIMIT_MSGQUEUE on top of ucounts")
>   d28296d248 ("Reimplement RLIMIT_SIGPENDING on top of ucounts")
>
> 4660d663b4207ce6 d28296d2484fa11e94dff65e93e 
> ---------------- --------------------------- 
>        fail:runs  %reproduction    fail:runs
>            |             |             |    
>          14:6         -217%           1:6     perf-profile.children.cycles-pp.error_entry
>          12:6         -179%           1:6     perf-profile.self.cycles-pp.error_entry
>          %stddev     %change         %stddev
>              \          |                \  
>  4.766e+08           -82.7%   82358308        stress-ng.sigsegv.ops
>    7942807           -82.7%    1372639        stress-ng.sigsegv.ops_per_sec
>      29408           -77.5%       6621 ± 61%  stress-ng.time.file_system_inputs
>       1566           +69.4%       2653        stress-ng.time.system_time
>       1274           -84.8%     193.22 ±  8%  stress-ng.time.user_time
>      12458 ±  5%     +37.2%      17097 ±  5%  numa-meminfo.node1.Active(anon)
>      51.41           +66.5%      85.59        iostat.cpu.system
>      41.17           -84.2%       6.50 ±  7%  iostat.cpu.user
>       3040 ±  4%     +37.9%       4193 ±  4%  numa-vmstat.node1.nr_active_anon
>       3040 ±  4%     +37.9%       4193 ±  4%  numa-vmstat.node1.nr_zone_active_anon
>      50.83           +67.2%      85.00        vmstat.cpu.sy
>      40.50           -85.6%       5.83 ± 11%  vmstat.cpu.us
>     225.33           -77.7%      50.33 ± 62%  vmstat.io.bi
>       7.00          -100.0%       0.00        vmstat.memory.buff
>      20735 ±  2%     -14.1%      17812 ±  5%  meminfo.Active
>      13506 ±  3%     +31.9%      17812 ±  5%  meminfo.Active(anon)
>       7228          -100.0%       0.00        meminfo.Active(file)
>      29308           +18.4%      34687 ±  2%  meminfo.Shmem
>     202067            -9.5%     182899        meminfo.VmallocUsed
>       0.01 ± 17%      -0.0        0.00 ± 10%  mpstat.cpu.all.iowait%
>       1.04            -0.1        0.92        mpstat.cpu.all.irq%
>       0.03 ±  8%      -0.0        0.02 ±  4%  mpstat.cpu.all.soft%
>      51.54           +35.6       87.17        mpstat.cpu.all.sys%
>      42.22           -35.6        6.66 ±  8%  mpstat.cpu.all.usr%
>       0.00 ± 70%    +191.7%       0.01 ± 26%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.worker_thread.kthread.ret_from_fork
>       0.00 ± 47%    +158.8%       0.01 ± 43%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.worker_thread.kthread.ret_from_fork
>       0.27 ± 25%     -55.4%       0.12 ± 37%  perf-sched.total_wait_and_delay.average.ms
>     202.17 ± 23%     -29.5%     142.50 ± 13%  perf-sched.total_wait_and_delay.count.ms
>       0.21 ± 18%     -69.3%       0.06 ± 58%  perf-sched.total_wait_time.average.ms
>       0.00 ± 70%    +191.7%       0.01 ± 26%  perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.worker_thread.kthread.ret_from_fork
>       8.17 ± 29%     -85.7%       1.17 ±125%  perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.schedule_timeout.rcu_gp_kthread.kthread
>       0.00 ± 47%    +158.8%       0.01 ± 43%  perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.worker_thread.kthread.ret_from_fork
>       3.11 ± 11%     -76.1%       0.74 ±142%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.schedule_timeout.rcu_gp_kthread.kthread
>       1790 ± 15%     -30.1%       1250 ± 13%  slabinfo.dmaengine-unmap-16.active_objs
>       1790 ± 15%     -30.1%       1250 ± 13%  slabinfo.dmaengine-unmap-16.num_objs
>     123.00          -100.0%       0.00        slabinfo.ext4_pending_reservation.active_objs
>     123.00          -100.0%       0.00        slabinfo.ext4_pending_reservation.num_objs
>       3619          -100.0%       0.00        slabinfo.f2fs_free_nid.active_objs
>       3619          -100.0%       0.00        slabinfo.f2fs_free_nid.num_objs
>      62865           -44.1%      35155        slabinfo.kmalloc-64.active_objs
>     984.33           -43.9%     552.50        slabinfo.kmalloc-64.active_slabs
>      63031           -43.9%      35389        slabinfo.kmalloc-64.num_objs
>     984.33           -43.9%     552.50        slabinfo.kmalloc-64.num_slabs
>     161.00 ±  9%     +67.1%     269.00 ±  7%  slabinfo.xfs_buf.active_objs
>     161.00 ±  9%     +67.1%     269.00 ±  7%  slabinfo.xfs_buf.num_objs
>       3399 ±  3%     +32.9%       4519 ±  4%  proc-vmstat.nr_active_anon
>       1806          -100.0%       0.00        proc-vmstat.nr_active_file
>       9333            +3.0%       9610        proc-vmstat.nr_mapped
>       7344           +18.4%       8698 ±  2%  proc-vmstat.nr_shmem
>      16319            -0.9%      16176        proc-vmstat.nr_slab_reclaimable
>      24399            -6.2%      22882        proc-vmstat.nr_slab_unreclaimable
>       3399 ±  3%     +32.9%       4519 ±  4%  proc-vmstat.nr_zone_active_anon
>       1806          -100.0%       0.00        proc-vmstat.nr_zone_active_file
>       3693 ± 80%     -80.1%     736.17 ± 61%  proc-vmstat.numa_hint_faults
>     293002            -2.7%     284991        proc-vmstat.numa_hit
>     249530            -3.3%     241180        proc-vmstat.numa_local
>       5007 ±111%     -90.5%     478.00 ± 81%  proc-vmstat.numa_pages_migrated
>      11443 ±  2%      -7.0%      10636 ±  4%  proc-vmstat.pgactivate
>     332528            -3.9%     319693        proc-vmstat.pgalloc_normal
>     249148 ±  2%      -4.1%     239053 ±  2%  proc-vmstat.pgfree
>       5007 ±111%     -90.5%     478.00 ± 81%  proc-vmstat.pgmigrate_success
>      14704           -77.5%       3310 ± 61%  proc-vmstat.pgpgin
>       0.00       +2.1e+105%       2095        proc-vmstat.pgpgout
>      13870 ± 10%     -55.1%       6227 ± 28%  softirqs.CPU0.RCU
>       9989 ±  3%     -62.2%       3775 ± 23%  softirqs.CPU1.RCU
>       8625 ± 13%     -76.1%       2061 ± 10%  softirqs.CPU10.RCU
>       7954 ± 15%     -65.9%       2709 ± 18%  softirqs.CPU14.RCU
>       9075 ± 14%     -78.7%       1929 ± 11%  softirqs.CPU17.RCU
>       8522 ± 13%     -76.7%       1985 ± 22%  softirqs.CPU18.RCU
>       9595 ±  7%     -63.3%       3522 ± 22%  softirqs.CPU2.RCU
>       8455 ± 11%     -74.5%       2152 ± 45%  softirqs.CPU20.RCU
>       8320 ± 12%     -76.7%       1939 ± 14%  softirqs.CPU21.RCU
>       8338 ± 13%     -71.7%       2359 ± 32%  softirqs.CPU23.RCU
>       8541 ± 12%     -75.5%       2089 ± 32%  softirqs.CPU26.RCU
>       9639 ± 20%     -79.5%       1976 ± 17%  softirqs.CPU28.RCU
>       9232 ± 13%     -78.0%       2026 ±  6%  softirqs.CPU30.RCU
>       7857 ± 17%     -68.9%       2446 ± 27%  softirqs.CPU34.RCU
>       8619 ± 11%     -75.8%       2081 ± 30%  softirqs.CPU36.RCU
>       9614 ±  3%     -74.3%       2469 ± 15%  softirqs.CPU4.RCU
>       8962 ± 10%     -77.9%       1981 ± 12%  softirqs.CPU41.RCU
>       9027 ± 12%     -78.6%       1932 ±  8%  softirqs.CPU42.RCU
>       9364 ± 12%     -76.5%       2197 ±  8%  softirqs.CPU44.RCU
>       8774 ± 13%     -75.5%       2147 ± 21%  softirqs.CPU47.RCU
>       8783 ± 12%     -76.0%       2105 ± 12%  softirqs.CPU5.RCU
>       9007 ±  9%     -75.8%       2177 ±  8%  softirqs.CPU6.RCU
>     417664 ±  7%     -72.8%     113621 ±  8%  softirqs.RCU
>      12708 ±  4%     +13.0%      14362 ±  2%  softirqs.TIMER
>      60500           -27.7%      43751        interrupts.CAL:Function_call_interrupts
>       1121           -26.9%     819.17 ±  3%  interrupts.CPU10.CAL:Function_call_interrupts
>       1561 ± 43%     -48.8%     800.00 ±  5%  interrupts.CPU11.CAL:Function_call_interrupts
>       1425 ±  6%     -25.3%       1065 ±  6%  interrupts.CPU12.CAL:Function_call_interrupts
>     166.17 ± 13%     -26.4%     122.33 ± 21%  interrupts.CPU13.RES:Rescheduling_interrupts
>       1402 ± 18%     -25.6%       1043 ± 22%  interrupts.CPU15.CAL:Function_call_interrupts
>     129.17 ± 50%     -42.5%      74.33 ±  4%  interrupts.CPU17.RES:Rescheduling_interrupts
>       1182 ±  9%     -31.0%     815.00 ±  2%  interrupts.CPU20.CAL:Function_call_interrupts
>       1120           -29.7%     787.17 ±  4%  interrupts.CPU21.CAL:Function_call_interrupts
>       1115 ±  3%     -28.2%     801.17        interrupts.CPU23.CAL:Function_call_interrupts
>       1169 ±  7%     -27.2%     851.33 ±  5%  interrupts.CPU24.CAL:Function_call_interrupts
>     177.33 ± 98%     -55.9%      78.17 ±  6%  interrupts.CPU25.RES:Rescheduling_interrupts
>       1142 ± 16%     -28.8%     813.00 ±  3%  interrupts.CPU27.CAL:Function_call_interrupts
>       1229 ± 18%     -33.3%     820.33 ±  4%  interrupts.CPU28.CAL:Function_call_interrupts
>       1124 ±  4%     -28.3%     806.17        interrupts.CPU29.CAL:Function_call_interrupts
>       1123 ±  3%     -28.5%     803.00        interrupts.CPU30.CAL:Function_call_interrupts
>       1127 ±  2%     -32.0%     766.67 ± 19%  interrupts.CPU31.CAL:Function_call_interrupts
>       1066 ±  8%     -22.3%     829.33 ±  7%  interrupts.CPU32.CAL:Function_call_interrupts
>       1109           -26.0%     820.50 ±  4%  interrupts.CPU34.CAL:Function_call_interrupts
>       1315 ± 22%     -37.7%     818.83 ±  2%  interrupts.CPU38.CAL:Function_call_interrupts
>       1164 ±  4%     -29.0%     827.00 ±  3%  interrupts.CPU39.CAL:Function_call_interrupts
>       5513 ± 35%     +13.1%       6237 ± 33%  interrupts.CPU39.NMI:Non-maskable_interrupts
>       5513 ± 35%     +13.1%       6237 ± 33%  interrupts.CPU39.PMI:Performance_monitoring_interrupts
>       1277 ± 23%     -36.1%     815.83        interrupts.CPU40.CAL:Function_call_interrupts
>      97.33 ± 28%     -25.7%      72.33 ±  6%  interrupts.CPU40.RES:Rescheduling_interrupts
>       1116           -24.8%     839.00 ± 11%  interrupts.CPU42.CAL:Function_call_interrupts
>       1130 ±  3%     -28.5%     808.67 ±  3%  interrupts.CPU43.CAL:Function_call_interrupts
>       1121           -29.8%     787.50 ±  4%  interrupts.CPU45.CAL:Function_call_interrupts
>       1119           -27.3%     813.83        interrupts.CPU46.CAL:Function_call_interrupts
>       1167 ±  6%     -28.0%     840.67        interrupts.CPU47.CAL:Function_call_interrupts
>       1667 ± 41%     -44.3%     928.67 ± 24%  interrupts.CPU5.CAL:Function_call_interrupts
>       1369 ± 24%     -39.5%     827.67 ±  3%  interrupts.CPU6.CAL:Function_call_interrupts
>      96.83 ± 25%     -23.1%      74.50 ±  2%  interrupts.CPU7.RES:Rescheduling_interrupts
>       1123           -28.1%     807.00        interrupts.CPU9.CAL:Function_call_interrupts
>       0.72 ±  5%    +107.4%       1.50 ±  2%  perf-stat.i.MPKI
>  8.023e+09           -13.5%  6.943e+09        perf-stat.i.branch-instructions
>       1.08 ±  2%      -0.5        0.55 ±  3%  perf-stat.i.branch-miss-rate%
>   71073978 ±  2%     -67.4%   23149119 ±  3%  perf-stat.i.branch-misses
>      29.33 ±  2%      +5.9       35.23        perf-stat.i.cache-miss-rate%
>    6189596          +120.2%   13628525        perf-stat.i.cache-misses
>   21228048           +82.4%   38714786        perf-stat.i.cache-references
>       3.36           +34.8%       4.53        perf-stat.i.cpi
>     109.52 ±  2%     -22.5%      84.92        perf-stat.i.cpu-migrations
>      22695           -56.5%       9882        perf-stat.i.cycles-between-cache-misses
>       1.15 ±  7%      -0.9        0.30 ±  4%  perf-stat.i.dTLB-load-miss-rate%
>  1.398e+08 ±  7%     -83.4%   23247225 ±  4%  perf-stat.i.dTLB-load-misses
>  1.154e+10           -34.4%  7.564e+09        perf-stat.i.dTLB-loads
>       1.17            -0.0        1.13        perf-stat.i.dTLB-store-miss-rate%
>  1.321e+08           -82.1%   23679743        perf-stat.i.dTLB-store-misses
>  1.071e+10           -81.3%  2.005e+09        perf-stat.i.dTLB-stores
>   41869658           -74.5%   10693569 ± 56%  perf-stat.i.iTLB-load-misses
>   19932113 ± 38%     -88.3%    2325708 ± 64%  perf-stat.i.iTLB-loads
>  3.945e+10           -25.9%  2.924e+10        perf-stat.i.instructions
>       1199 ±  4%    +182.7%       3389 ± 26%  perf-stat.i.instructions-per-iTLB-miss
>       0.31           -23.7%       0.24        perf-stat.i.ipc
>     634.71           -45.5%     345.81        perf-stat.i.metric.M/sec
>     166710 ± 10%   +3369.3%    5783625        perf-stat.i.node-load-misses
>     227268 ±  6%   +3063.1%    7188743        perf-stat.i.node-loads
>      48.41            -4.5       43.91        perf-stat.i.node-store-miss-rate%
>    5425859           -11.8%    4783945        perf-stat.i.node-store-misses
>    5599687            +6.1%    5943407        perf-stat.i.node-stores
>    7532204           -82.7%    1305118        perf-stat.i.page-faults
>       0.54          +146.0%       1.32        perf-stat.overall.MPKI
>       0.89 ±  2%      -0.6        0.33 ±  3%  perf-stat.overall.branch-miss-rate%
>      29.17 ±  2%      +6.0       35.20        perf-stat.overall.cache-miss-rate%
>       3.45           +35.0%       4.65        perf-stat.overall.cpi
>      21953           -54.5%       9979        perf-stat.overall.cycles-between-cache-misses
>       1.20 ±  7%      -0.9        0.31 ±  4%  perf-stat.overall.dTLB-load-miss-rate%
>       1.22            -0.1        1.17        perf-stat.overall.dTLB-store-miss-rate%
>     942.39          +245.5%       3255 ± 28%  perf-stat.overall.instructions-per-iTLB-miss
>       0.29           -25.9%       0.21        perf-stat.overall.ipc
>      42.24 ±  2%      +2.3       44.58        perf-stat.overall.node-load-miss-rate%
>      49.21            -4.6       44.59        perf-stat.overall.node-store-miss-rate%
>  7.894e+09           -13.5%   6.83e+09        perf-stat.ps.branch-instructions
>   69952381 ±  2%     -67.4%   22781972 ±  3%  perf-stat.ps.branch-misses
>    6093197          +120.1%   13409962        perf-stat.ps.cache-misses
>   20897937           +82.3%   38097787        perf-stat.ps.cache-references
>     107.78 ±  2%     -22.4%      83.62        perf-stat.ps.cpu-migrations
>  1.375e+08 ±  7%     -83.4%   22871450 ±  4%  perf-stat.ps.dTLB-load-misses
>  1.135e+10           -34.4%  7.442e+09        perf-stat.ps.dTLB-loads
>    1.3e+08           -82.1%   23295591        perf-stat.ps.dTLB-store-misses
>  1.054e+10           -81.3%  1.973e+09        perf-stat.ps.dTLB-stores
>   41193894           -74.5%   10519305 ± 56%  perf-stat.ps.iTLB-load-misses
>   19610606 ± 38%     -88.3%    2288293 ± 64%  perf-stat.ps.iTLB-loads
>  3.882e+10           -25.9%  2.876e+10        perf-stat.ps.instructions
>     164152 ± 10%   +3366.2%    5689843        perf-stat.ps.node-load-misses
>     223940 ±  6%   +3058.2%    7072454        perf-stat.ps.node-loads
>    5338769           -11.8%    4706549        perf-stat.ps.node-store-misses
>    5510338            +6.1%    5847491        perf-stat.ps.node-stores
>    7410609           -82.7%    1283937        perf-stat.ps.page-faults
>  2.454e+12           -25.9%  1.817e+12        perf-stat.total.instructions
>      33.68           -29.6        4.04        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
>      18.94           -16.5        2.46        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
>      13.67           -12.3        1.42        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret
>      12.27           -10.9        1.36 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       8.04            -7.0        1.05 ±  2%  perf-profile.calltrace.cycles-pp.__entry_text_start
>       6.06            -6.1        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack
>       6.02 ±  2%      -5.4        0.66 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigaction.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       5.51            -4.8        0.70        perf-profile.calltrace.cycles-pp.__setup_rt_frame.arch_do_signal_or_restart.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
>       0.00            +0.6        0.65        perf-profile.calltrace.cycles-pp.inc_rlimit_ucounts_and_test.__sigqueue_alloc.__send_signal.force_sig_info_to_task.force_sig_fault
>      18.91           +27.0       45.89        perf-profile.calltrace.cycles-pp.irqentry_exit_to_user_mode.asm_exc_page_fault
>      15.00           +30.4       45.42        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
>      14.66           +30.7       45.38        perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
>      11.73           +34.2       45.97        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
>       8.85           +36.7       45.54        perf-profile.calltrace.cycles-pp.__bad_area_nosemaphore.exc_page_fault.asm_exc_page_fault
>       8.16           +37.2       45.40        perf-profile.calltrace.cycles-pp.force_sig_fault.__bad_area_nosemaphore.exc_page_fault.asm_exc_page_fault
>       8.04           +37.3       45.39        perf-profile.calltrace.cycles-pp.force_sig_info_to_task.force_sig_fault.__bad_area_nosemaphore.exc_page_fault.asm_exc_page_fault
>       6.53           +37.8       44.36        perf-profile.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
>       7.06           +38.0       45.05        perf-profile.calltrace.cycles-pp.__send_signal.force_sig_info_to_task.force_sig_fault.__bad_area_nosemaphore.exc_page_fault
>       4.28 ±  2%     +39.2       43.46        perf-profile.calltrace.cycles-pp.__sigqueue_free.get_signal.arch_do_signal_or_restart.exit_to_user_mode_prepare.irqentry_exit_to_user_mode
>       4.87 ±  2%     +39.9       44.81        perf-profile.calltrace.cycles-pp.__sigqueue_alloc.__send_signal.force_sig_info_to_task.force_sig_fault.__bad_area_nosemaphore
>       0.00           +42.7       42.72        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.put_ucounts.__sigqueue_free.get_signal
>       0.00           +43.0       42.99        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.put_ucounts.__sigqueue_free.get_signal.arch_do_signal_or_restart
>       0.00           +43.1       43.08        perf-profile.calltrace.cycles-pp.put_ucounts.__sigqueue_free.get_signal.arch_do_signal_or_restart.exit_to_user_mode_prepare
>       0.00           +43.5       43.52        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.get_ucounts.__sigqueue_alloc.__send_signal
>       0.00           +44.0       43.97        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.get_ucounts.__sigqueue_alloc.__send_signal.force_sig_info_to_task
>       0.00           +44.1       44.05        perf-profile.calltrace.cycles-pp.get_ucounts.__sigqueue_alloc.__send_signal.force_sig_info_to_task.force_sig_fault
>      31.89           +60.0       91.94        perf-profile.calltrace.cycles-pp.asm_exc_page_fault
>      33.84           -29.7        4.10        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>      19.01           -16.5        2.48        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>      14.93           -13.3        1.59        perf-profile.children.cycles-pp.syscall_return_via_sysret
>      13.14           -11.7        1.43 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
>      10.60            -9.3        1.27        perf-profile.children.cycles-pp.__entry_text_start
>       6.17 ±  2%      -5.5        0.68 ±  2%  perf-profile.children.cycles-pp.__x64_sys_rt_sigaction
>       5.55            -4.8        0.71 ±  2%  perf-profile.children.cycles-pp.__setup_rt_frame
>       3.63 ±  2%      -3.2        0.40 ±  2%  perf-profile.children.cycles-pp.__x64_sys_rt_sigprocmask
>       3.54            -3.2        0.32 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
>       3.11 ±  3%      -2.8        0.35 ±  3%  perf-profile.children.cycles-pp._copy_from_user
>       2.91            -2.5        0.37 ±  2%  perf-profile.children.cycles-pp.copy_fpstate_to_sigframe
>       2.38            -2.1        0.28        perf-profile.children.cycles-pp.__irqentry_text_end
>       2.40 ±  4%      -2.1        0.30 ±  2%  perf-profile.children.cycles-pp.__might_fault
>       2.23            -1.9        0.32        perf-profile.children.cycles-pp.native_irq_return_iret
>       2.26 ±  2%      -1.9        0.35 ±  5%  perf-profile.children.cycles-pp.do_user_addr_fault
>       1.86            -1.6        0.27 ±  3%  perf-profile.children.cycles-pp.do_sigaction
>       1.75            -1.5        0.21 ±  3%  perf-profile.children.cycles-pp.copy_user_generic_unrolled
>       1.67 ±  3%      -1.5        0.19 ±  3%  perf-profile.children.cycles-pp.__set_current_blocked
>       1.51 ±  2%      -1.3        0.18 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irq
>       1.33 ±  3%      -1.1        0.19        perf-profile.children.cycles-pp.copy_siginfo_to_user
>       1.24 ±  3%      -1.1        0.13 ±  3%  perf-profile.children.cycles-pp.recalc_sigpending
>       1.30 ±  4%      -1.1        0.18 ±  3%  perf-profile.children.cycles-pp._copy_to_user
>       1.23 ±  3%      -1.1        0.15 ±  3%  perf-profile.children.cycles-pp.___might_sleep
>       1.07 ±  4%      -0.9        0.12 ±  3%  perf-profile.children.cycles-pp.signal_setup_done
>       0.98 ±  4%      -0.9        0.11 ±  4%  perf-profile.children.cycles-pp.fpu__clear
>       0.93 ±  4%      -0.8        0.12 ±  8%  perf-profile.children.cycles-pp.__might_sleep
>       0.89            -0.8        0.14 ±  3%  perf-profile.children.cycles-pp.__clear_user
>       0.85 ±  4%      -0.7        0.10 ±  3%  perf-profile.children.cycles-pp.__set_task_blocked
>       0.81 ±  2%      -0.7        0.10 ±  8%  perf-profile.children.cycles-pp.sigprocmask
>       0.76 ± 11%      -0.7        0.07 ± 10%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
>       0.70 ±  2%      -0.6        0.06 ±  9%  perf-profile.children.cycles-pp.signal_wake_up_state
>       0.73            -0.6        0.13 ±  7%  perf-profile.children.cycles-pp.__perf_sw_event
>       0.50 ±  2%      -0.5        0.04 ± 44%  perf-profile.children.cycles-pp.complete_signal
>       0.50 ±  4%      -0.4        0.08 ± 11%  perf-profile.children.cycles-pp.___perf_sw_event
>       0.45            -0.4        0.06 ±  6%  perf-profile.children.cycles-pp.sync_regs
>       0.44            -0.4        0.07 ± 10%  perf-profile.children.cycles-pp.fixup_vdso_exception
>       0.35 ±  2%      -0.3        0.05        perf-profile.children.cycles-pp.prepare_signal
>       0.35 ±  3%      -0.3        0.08 ±  5%  perf-profile.children.cycles-pp.is_prefetch
>       0.33 ± 11%      -0.3        0.07 ±  6%  perf-profile.children.cycles-pp.kmem_cache_alloc
>       0.19 ±  4%      -0.1        0.05 ± 45%  perf-profile.children.cycles-pp.copy_from_kernel_nofault
>       0.33            +0.0        0.37 ±  3%  perf-profile.children.cycles-pp.kmem_cache_free
>       0.00            +0.4        0.36 ±  4%  perf-profile.children.cycles-pp.dec_rlimit_ucounts
>       0.00            +0.6        0.65        perf-profile.children.cycles-pp.inc_rlimit_ucounts_and_test
>      19.11           +26.8       45.91        perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
>      15.69           +29.8       45.51        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>      14.70           +30.7       45.38        perf-profile.children.cycles-pp.arch_do_signal_or_restart
>      11.77           +34.2       45.99        perf-profile.children.cycles-pp.exc_page_fault
>       8.90           +36.7       45.55        perf-profile.children.cycles-pp.__bad_area_nosemaphore
>       8.17           +37.2       45.40        perf-profile.children.cycles-pp.force_sig_fault
>       8.10           +37.3       45.39        perf-profile.children.cycles-pp.force_sig_info_to_task
>       6.57           +37.8       44.38        perf-profile.children.cycles-pp.get_signal
>       7.11           +38.0       45.06        perf-profile.children.cycles-pp.__send_signal
>       4.28 ±  2%     +39.2       43.46        perf-profile.children.cycles-pp.__sigqueue_free
>       4.89 ±  2%     +39.9       44.82        perf-profile.children.cycles-pp.__sigqueue_alloc
>       0.00           +43.1       43.09        perf-profile.children.cycles-pp.put_ucounts
>       0.00           +44.1       44.05        perf-profile.children.cycles-pp.get_ucounts
>      31.95           +60.0       91.95        perf-profile.children.cycles-pp.asm_exc_page_fault
>       0.00           +86.2       86.24        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>       0.32 ±  4%     +86.7       87.01        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>      18.17           -15.8        2.36        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
>      14.90           -13.3        1.58        perf-profile.self.cycles-pp.syscall_return_via_sysret
>      10.60            -9.3        1.27        perf-profile.self.cycles-pp.__entry_text_start
>       4.55 ±  2%      -4.5        0.04 ± 72%  perf-profile.self.cycles-pp.__sigqueue_alloc
>       4.09 ±  2%      -3.6        0.49 ±  2%  perf-profile.self.cycles-pp.irqentry_exit_to_user_mode
>       2.30 ±  5%      -2.1        0.19 ±  4%  perf-profile.self.cycles-pp.do_syscall_64
>       2.38            -2.1        0.28        perf-profile.self.cycles-pp.__irqentry_text_end
>       2.22            -1.9        0.32        perf-profile.self.cycles-pp.native_irq_return_iret
>       1.92 ±  8%      -1.8        0.16 ±  2%  perf-profile.self.cycles-pp.__x64_sys_rt_sigaction
>       1.72 ±  3%      -1.5        0.20 ±  5%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
>       1.71            -1.5        0.21 ±  4%  perf-profile.self.cycles-pp.copy_fpstate_to_sigframe
>       1.68            -1.5        0.20 ±  3%  perf-profile.self.cycles-pp.copy_user_generic_unrolled
>       1.46 ±  4%      -1.3        0.12 ±  4%  perf-profile.self.cycles-pp.__x64_sys_rt_sigprocmask
>       1.46 ±  2%      -1.3        0.17 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irq
>       1.21 ±  6%      -1.1        0.14 ±  5%  perf-profile.self.cycles-pp.__setup_rt_frame
>       1.21 ±  2%      -1.1        0.14 ±  3%  perf-profile.self.cycles-pp.___might_sleep
>       1.06 ±  4%      -1.0        0.09 ±  5%  perf-profile.self.cycles-pp.recalc_sigpending
>       1.01 ±  6%      -1.0        0.05        perf-profile.self.cycles-pp.asm_exc_page_fault
>       0.97 ±  4%      -0.9        0.10 ±  7%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
>       0.95 ±  2%      -0.8        0.12 ±  4%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
>       0.98            -0.8        0.15 ±  4%  perf-profile.self.cycles-pp.do_sigaction
>       0.84 ±  4%      -0.7        0.10 ±  6%  perf-profile.self.cycles-pp.__might_sleep
>       0.72 ±  8%      -0.6        0.09 ±  4%  perf-profile.self.cycles-pp._copy_from_user
>       0.71 ±  2%      -0.6        0.10 ±  7%  perf-profile.self.cycles-pp.do_user_addr_fault
>       0.65 ± 14%      -0.6        0.06 ± 11%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
>       0.68 ±  6%      -0.6        0.10 ±  3%  perf-profile.self.cycles-pp.__might_fault
>       0.80            -0.6        0.25 ±  3%  perf-profile.self.cycles-pp.get_signal
>       0.64 ±  4%      -0.6        0.08 ±  5%  perf-profile.self.cycles-pp.fpu__clear
>       0.57 ±  3%      -0.5        0.07 ±  7%  perf-profile.self.cycles-pp.__send_signal
>       0.53 ±  2%      -0.5        0.08 ±  6%  perf-profile.self.cycles-pp.__clear_user
>       0.49 ±  5%      -0.4        0.04 ± 45%  perf-profile.self.cycles-pp.arch_do_signal_or_restart
>       0.43            -0.4        0.06 ±  7%  perf-profile.self.cycles-pp.fixup_vdso_exception
>       0.42 ±  4%      -0.4        0.06 ±  7%  perf-profile.self.cycles-pp.___perf_sw_event
>       0.41            -0.4        0.05 ±  9%  perf-profile.self.cycles-pp.sync_regs
>       0.33 ±  3%      -0.3        0.04 ± 44%  perf-profile.self.cycles-pp.prepare_signal
>       0.31 ± 12%      -0.2        0.07 ±  7%  perf-profile.self.cycles-pp.kmem_cache_alloc
>       0.22 ±  3%      -0.1        0.10 ±  7%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
>       0.33            +0.0        0.36 ±  3%  perf-profile.self.cycles-pp.kmem_cache_free
>       0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.get_ucounts
>       0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.put_ucounts
>       0.00            +0.4        0.36 ±  4%  perf-profile.self.cycles-pp.dec_rlimit_ucounts
>       0.27 ±  4%      +0.5        0.77 ±  2%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>       0.00            +0.6        0.65        perf-profile.self.cycles-pp.inc_rlimit_ucounts_and_test
>       0.00           +86.2       86.24        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
>
>
>                                                                                 
>                              stress-ng.time.user_time                           
>                                                                                 
>   1400 +--------------------------------------------------------------------+   
>        |.++.+.+.++.+.+.++.+.++.+.+.++.+.+.++.+.++.+.+.++.+.++.+.+. +.+.+.++.|   
>   1200 |-+                                                        +         |   
>        |                                                                    |   
>   1000 |-+                                                                  |   
>        |                                                                    |   
>    800 |-+                                                                  |   
>        |                                                                    |   
>    600 |-+                                                                  |   
>        |                                                                    |   
>    400 |-+      O                                                           |   
>        |                                                                    |   
>    200 |-OO O O  O O O OO O OO O O OO O O OO O OO O O OO O OO               |   
>        |                                                                    |   
>      0 +--------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                             stress-ng.time.system_time                          
>                                                                                 
>   2800 +--------------------------------------------------------------------+   
>        |             O         O O    O   OO    O   O O  O O                |   
>   2600 |-OO O O  O O   OO O OO     OO   O    O O  O    O    O               |   
>        |                                                                    |   
>   2400 |-+      O                                                           |   
>        |                                                                    |   
>   2200 |-+                                                                  |   
>        |                                                                    |   
>   2000 |-+                                                                  |   
>        |                                                                    |   
>   1800 |-+                                                                  |   
>        |                                                                    |   
>   1600 |.++.+.+.++.+.    .+.++.+.+.++.+.+.++.+.++.+.+.++.+.+ .+.+.++.+.+.++.|   
>        |             +.++                                   +               |   
>   1400 +--------------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                                  stress-ng.sigsegv.ops                          
>                                                                                 
>     5e+08 +-----------------------------------------------------------------+   
>           |.++.+.++.+.++.+.++.++.+.++.+.++.+.++.+.++.+.++.+.++.++.+.++.+.++.|   
>   4.5e+08 |-+                                                               |   
>     4e+08 |-+                                                               |   
>           |                                                                 |   
>   3.5e+08 |-+                                                               |   
>     3e+08 |-+                                                               |   
>           |                                                                 |   
>   2.5e+08 |-+                                                               |   
>     2e+08 |-+                                                               |   
>           |                                                                 |   
>   1.5e+08 |-+                                                               |   
>     1e+08 |-+                                                               |   
>           | OO O OO O OO O OO OO O OO O OO O OO O OO O OO O OO              |   
>     5e+07 +-----------------------------------------------------------------+   
>                                                                                 
>                                                                                                                                                                 
>                             stress-ng.sigsegv.ops_per_sec                       
>                                                                                 
>   8e+06 +-------------------------------------------------------------------+   
>         |                                                                   |   
>   7e+06 |-+                                                                 |   
>         |                                                                   |   
>   6e+06 |-+                                                                 |   
>         |                                                                   |   
>   5e+06 |-+                                                                 |   
>         |                                                                   |   
>   4e+06 |-+                                                                 |   
>         |                                                                   |   
>   3e+06 |-+                                                                 |   
>         |                                                                   |   
>   2e+06 |-+                                                                 |   
>         | OO O O OO O OO O OO O O OO O OO O OO O O OO O OO O O              |   
>   1e+06 +-------------------------------------------------------------------+   
>                                                                                 
>                                                                                 
> [*] bisect-good sample
> [O] bisect-bad  sample
>
> ***************************************************************************************************
> lkp-ivb-2ep1: 48 threads Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz with 112G memory
> =========================================================================================
> class/compiler/cpufreq_governor/disk/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime/ucode:
>   interrupt/gcc-9/performance/1HDD/x86_64-rhel-8.3/100%/debian-10.4-x86_64-20200603.cgz/lkp-ivb-2ep1/sigq/stress-ng/60s/0x42e
>
> commit: 
>   4660d663b4 ("Reimplement RLIMIT_MSGQUEUE on top of ucounts")
>   d28296d248 ("Reimplement RLIMIT_SIGPENDING on top of ucounts")
>
> 4660d663b4207ce6 d28296d2484fa11e94dff65e93e 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>  4.176e+08           -56.1%  1.831e+08 ± 21%  stress-ng.sigq.ops
>    6959423           -56.1%    3051857 ± 21%  stress-ng.sigq.ops_per_sec
>  2.157e+08 ±  8%     -66.1%   73100172 ±  9%  stress-ng.time.involuntary_context_switches
>      14467            +1.4%      14674        stress-ng.time.minor_page_faults
>       4513            +1.2%       4569        stress-ng.time.percent_of_cpu_this_job_got
>       2150           +17.9%       2535 ±  3%  stress-ng.time.system_time
>     660.96           -53.1%     309.96 ± 30%  stress-ng.time.user_time
>  2.478e+08 ±  5%     -70.5%   73168836 ±  9%  stress-ng.time.voluntary_context_switches
>       7.70 ±  8%      -6.8%       7.18        iostat.cpu.idle
>      70.60           +16.6%      82.32 ±  3%  iostat.cpu.system
>      21.70           -51.6%      10.49 ± 29%  iostat.cpu.user
>      15660 ±  3%     +13.7%      17806 ±  3%  meminfo.Active
>      15660 ±  3%     +13.7%      17806 ±  3%  meminfo.Active(anon)
>      31878 ±  2%      +8.8%      34688 ±  2%  meminfo.Shmem
>     123900 ± 66%     -66.9%      41021 ± 30%  cpuidle.C1.usage
>  1.507e+08 ±  6%      +9.5%   1.65e+08 ±  4%  cpuidle.C6.time
>     681599 ± 38%     -72.8%     185137 ±113%  cpuidle.POLL.time
>     645871 ± 39%     -98.5%       9580 ± 75%  cpuidle.POLL.usage
>       1.78 ±  3%      -0.8        0.95        mpstat.cpu.all.irq%
>       0.03 ±  4%      -0.0        0.02 ± 27%  mpstat.cpu.all.soft%
>      70.90           +12.5       83.42 ±  3%  mpstat.cpu.all.sys%
>      22.35           -11.6       10.75 ± 29%  mpstat.cpu.all.usr%
>     825.33 ±  2%     -11.6%     729.67 ±  5%  slabinfo.file_lock_cache.active_objs
>     825.33 ±  2%     -11.6%     729.67 ±  5%  slabinfo.file_lock_cache.num_objs
>       1455 ± 11%     -32.4%     983.00 ± 13%  slabinfo.khugepaged_mm_slot.active_objs
>       1455 ± 11%     -32.4%     983.00 ± 13%  slabinfo.khugepaged_mm_slot.num_objs
>      69.67           +17.2%      81.67 ±  3%  vmstat.cpu.sy
>      21.00           -52.4%      10.00 ± 29%  vmstat.cpu.us
>    7139282 ±  7%     -68.5%    2251603 ±  9%  vmstat.system.cs
>     518916 ±  6%     -80.5%     101139 ±  4%  vmstat.system.in
>       8082 ± 51%     -68.3%       2565 ± 17%  softirqs.CPU10.SCHED
>       6261 ± 72%     -56.4%       2729 ± 14%  softirqs.CPU17.SCHED
>       6147 ± 66%     -64.3%       2195 ±  3%  softirqs.CPU25.SCHED
>      16334 ± 41%     -82.6%       2846 ± 24%  softirqs.CPU27.SCHED
>       6280 ± 56%     -61.9%       2394 ±  9%  softirqs.CPU39.SCHED
>       8248 ± 50%     -73.2%       2209 ±  8%  softirqs.CPU40.SCHED
>     228327 ±  9%     -46.3%     122665 ±  2%  softirqs.SCHED
>       3851 ±  4%     +13.8%       4381 ±  4%  proc-vmstat.nr_active_anon
>       9587            +2.8%       9855        proc-vmstat.nr_mapped
>       7943 ±  2%      +8.7%       8630 ±  2%  proc-vmstat.nr_shmem
>       3851 ±  4%     +13.8%       4381 ±  4%  proc-vmstat.nr_zone_active_anon
>     438.33 ±122%   +1463.6%       6853 ± 69%  proc-vmstat.numa_pages_migrated
>       8816 ±  4%     +11.5%       9827 ±  6%  proc-vmstat.pgactivate
>     291848            +1.7%     296689        proc-vmstat.pgalloc_normal
>     438.33 ±122%   +1463.6%       6853 ± 69%  proc-vmstat.pgmigrate_success
>     252.00 ± 19%     +30.8%     329.67 ±  7%  numa-vmstat.node0.nr_active_anon
>      44373 ± 23%     -64.0%      15967 ± 49%  numa-vmstat.node0.nr_anon_pages
>      46179 ± 21%     -61.8%      17619 ± 38%  numa-vmstat.node0.nr_inactive_anon
>     252.00 ± 19%     +30.8%     329.67 ±  7%  numa-vmstat.node0.nr_zone_active_anon
>      46179 ± 21%     -61.8%      17619 ± 38%  numa-vmstat.node0.nr_zone_inactive_anon
>       3678 ±  4%     +11.5%       4100 ±  4%  numa-vmstat.node1.nr_active_anon
>      13880 ± 74%    +206.7%      42565 ± 17%  numa-vmstat.node1.nr_anon_pages
>      16004 ± 59%    +181.1%      44988 ± 14%  numa-vmstat.node1.nr_inactive_anon
>       3678 ±  4%     +11.5%       4100 ±  4%  numa-vmstat.node1.nr_zone_active_anon
>      16004 ± 59%    +181.1%      44988 ± 14%  numa-vmstat.node1.nr_zone_inactive_anon
>       1007 ± 19%     +31.3%       1322 ±  7%  numa-meminfo.node0.Active
>       1007 ± 19%     +31.3%       1322 ±  7%  numa-meminfo.node0.Active(anon)
>      39280 ± 35%     -66.1%      13314 ± 74%  numa-meminfo.node0.AnonHugePages
>     177224 ± 24%     -63.9%      63933 ± 49%  numa-meminfo.node0.AnonPages
>     182948 ± 22%     -52.3%      87286 ± 59%  numa-meminfo.node0.AnonPages.max
>     184457 ± 21%     -61.8%      70532 ± 38%  numa-meminfo.node0.Inactive
>     184457 ± 21%     -61.8%      70532 ± 38%  numa-meminfo.node0.Inactive(anon)
>    1080630 ±  5%     -12.3%     947332 ±  3%  numa-meminfo.node0.MemUsed
>      14267 ±  4%     +17.0%      16695 ±  5%  numa-meminfo.node1.Active
>      14267 ±  4%     +17.0%      16695 ±  5%  numa-meminfo.node1.Active(anon)
>      56124 ± 74%    +202.8%     169963 ± 17%  numa-meminfo.node1.AnonPages
>      75025 ± 56%    +139.7%     179816 ± 14%  numa-meminfo.node1.AnonPages.max
>      64951 ± 59%    +176.3%     179452 ± 14%  numa-meminfo.node1.Inactive
>      64951 ± 59%    +176.3%     179452 ± 14%  numa-meminfo.node1.Inactive(anon)
>     941178 ±  5%     +14.6%    1078500 ±  3%  numa-meminfo.node1.MemUsed
>      51.14 ± 15%     +47.4%      75.37 ± 13%  sched_debug.cfs_rq:/.load_avg.avg
>     114.91 ± 14%     +38.2%     158.79 ± 13%  sched_debug.cfs_rq:/.load_avg.stddev
>       6.99 ± 70%    +352.8%      31.65 ± 27%  sched_debug.cfs_rq:/.removed.load_avg.avg
>      47.92 ± 70%    +153.1%     121.29 ± 12%  sched_debug.cfs_rq:/.removed.load_avg.stddev
>       2.38 ± 97%    +182.8%       6.74 ± 36%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
>       2.38 ± 97%    +182.7%       6.73 ± 36%  sched_debug.cfs_rq:/.removed.util_avg.avg
>     356.50 ±  3%     -24.1%     270.50 ± 31%  sched_debug.cfs_rq:/.util_avg.min
>     290.54 ±  2%     +10.6%     321.30 ±  5%  sched_debug.cfs_rq:/.util_est_enqueued.avg
>     446696 ±  4%     +50.1%     670473 ±  7%  sched_debug.cpu.avg_idle.avg
>    1120651 ± 11%     +20.5%    1350114 ± 10%  sched_debug.cpu.avg_idle.max
>       2124 ± 10%     +43.0%       3038 ± 15%  sched_debug.cpu.avg_idle.min
>     708.23 ±  3%     -14.4%     606.42 ±  4%  sched_debug.cpu.clock_task.stddev
>     989.50 ±  8%     +12.0%       1108        sched_debug.cpu.curr->pid.min
>      21503 ± 71%    +114.0%      46014 ± 39%  sched_debug.cpu.max_idle_balance_cost.stddev
>    4583665 ±  7%     -68.5%    1443748 ±  9%  sched_debug.cpu.nr_switches.avg
>    6508139 ±  3%     -71.5%    1854831        sched_debug.cpu.nr_switches.max
>    2183394 ± 28%     -83.2%     367194 ± 87%  sched_debug.cpu.nr_switches.min
>    1135976 ± 11%     -69.9%     342489 ± 34%  sched_debug.cpu.nr_switches.stddev
>       0.03 ± 59%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.do_syslog.part.0
>       0.01 ± 12%     -36.4%       0.00 ± 26%  perf-sched.sch_delay.avg.ms.__sched_text_start.__sched_text_start.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
>       0.05 ± 57%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.do_syslog.part.0
>       0.19 ± 77%     -61.0%       0.07 ±  5%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.pipe_read.new_sync_read.vfs_read
>       7.83 ±140%     -99.8%       0.01 ± 38%  perf-sched.sch_delay.max.ms.__sched_text_start.__sched_text_start.smpboot_thread_fn.kthread.ret_from_fork
>       0.36 ± 18%     -64.4%       0.13 ± 75%  perf-sched.total_wait_and_delay.average.ms
>       0.24 ±  5%     -72.2%       0.07 ± 66%  perf-sched.total_wait_time.average.ms
>       1.38 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.do_syslog.part.0
>       0.03 ± 41%     -61.6%       0.01 ± 80%  perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.do_task_dead.do_exit.do_group_exit
>       0.01 ± 12%     -36.4%       0.00 ± 26%  perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
>       0.08 ± 17%     -30.3%       0.05 ±  3%  perf-sched.wait_and_delay.avg.ms.__sched_text_start.__sched_text_start.pipe_read.new_sync_read.vfs_read
>       2.00          -100.0%       0.00        perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.do_syslog.part.0
>       9.00           -81.5%       1.67 ± 28%  perf-sched.wait_and_delay.count.__sched_text_start.__sched_text_start.schedule_timeout.rcu_gp_kthread.kthread
>       2.72 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.do_syslog.part.0
>       0.80 ± 45%     -89.3%       0.09 ± 10%  perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.pipe_read.new_sync_read.vfs_read
>       7.83 ±140%     -99.8%       0.01 ± 38%  perf-sched.wait_and_delay.max.ms.__sched_text_start.__sched_text_start.smpboot_thread_fn.kthread.ret_from_fork
>       1.35 ±  8%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.do_syslog.part.0
>       0.03 ± 42%     -66.3%       0.01 ± 82%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.do_task_dead.do_exit.do_group_exit
>       0.07 ± 24%     -27.6%       0.05 ±  3%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.pipe_read.new_sync_read.vfs_read
>       3.21 ±  2%     -58.6%       1.33 ± 70%  perf-sched.wait_time.avg.ms.__sched_text_start.__sched_text_start.schedule_timeout.rcu_gp_kthread.kthread
>       2.69 ±  8%    -100.0%       0.00        perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.do_syslog.part.0
>       0.77 ± 50%     -89.7%       0.08 ± 10%  perf-sched.wait_time.max.ms.__sched_text_start.__sched_text_start.pipe_read.new_sync_read.vfs_read
>       6.12 ±  3%     -27.9%       4.42 ±  3%  perf-stat.i.MPKI
>  1.008e+10 ±  4%     -20.8%  7.989e+09 ±  2%  perf-stat.i.branch-instructions
>       1.55 ±  2%      -0.7        0.89        perf-stat.i.branch-miss-rate%
>  1.372e+08 ±  2%     -60.4%   54290819        perf-stat.i.branch-misses
>       5.24 ±  7%      +6.4       11.66 ±  5%  perf-stat.i.cache-miss-rate%
>   12610881 ±  8%     +30.8%   16498692 ±  4%  perf-stat.i.cache-misses
>  2.994e+08           -50.1%  1.495e+08 ±  2%  perf-stat.i.cache-references
>    7370989 ±  7%     -68.6%    2316288 ±  9%  perf-stat.i.context-switches
>       2.75 ±  4%     +37.7%       3.78 ±  2%  perf-stat.i.cpi
>      37935 ± 20%     -99.1%     344.33 ± 39%  perf-stat.i.cpu-migrations
>      10857 ±  9%     -24.6%       8184 ±  4%  perf-stat.i.cycles-between-cache-misses
>       1.33 ±  4%      -0.5        0.81 ± 15%  perf-stat.i.dTLB-load-miss-rate%
>  1.921e+08 ±  3%     -59.4%   78058438 ± 14%  perf-stat.i.dTLB-load-misses
>  1.375e+10 ±  4%     -32.6%   9.26e+09        perf-stat.i.dTLB-loads
>       0.51 ±  5%      +0.1        0.61 ±  9%  perf-stat.i.dTLB-store-miss-rate%
>   52874010           -55.6%   23456497 ± 13%  perf-stat.i.dTLB-store-misses
>  9.955e+09 ±  3%     -63.0%  3.687e+09 ±  4%  perf-stat.i.dTLB-stores
>   62946854 ±  4%     -59.7%   25392611 ±  3%  perf-stat.i.iTLB-load-misses
>   4.88e+10 ±  4%     -28.0%  3.514e+10        perf-stat.i.instructions
>       1071           +54.5%       1655 ± 10%  perf-stat.i.instructions-per-iTLB-miss
>       0.38 ±  3%     -26.8%       0.28 ±  3%  perf-stat.i.ipc
>       0.52 ±  7%     -70.6%       0.15 ± 11%  perf-stat.i.metric.K/sec
>     711.88 ±  3%     -38.1%     440.48        perf-stat.i.metric.M/sec
>      47.42            -1.7       45.75        perf-stat.i.node-load-miss-rate%
>    3468825 ± 20%    +118.3%    7571866 ±  5%  perf-stat.i.node-load-misses
>    3747717 ± 20%    +133.9%    8764955 ±  4%  perf-stat.i.node-loads
>      47.67            -2.6       45.11        perf-stat.i.node-store-miss-rate%
>    8290895 ±  4%     -28.2%    5954593 ±  6%  perf-stat.i.node-store-misses
>    8800840           -19.9%    7053271 ±  5%  perf-stat.i.node-stores
>       6.14 ±  3%     -30.8%       4.25        perf-stat.overall.MPKI
>       1.36 ±  2%      -0.7        0.68        perf-stat.overall.branch-miss-rate%
>       4.22 ± 10%      +6.8       11.05 ±  6%  perf-stat.overall.cache-miss-rate%
>       2.79 ±  4%     +38.7%       3.87        perf-stat.overall.cpi
>      10868 ±  8%     -23.9%       8267 ±  4%  perf-stat.overall.cycles-between-cache-misses
>       1.38 ±  4%      -0.5        0.84 ± 15%  perf-stat.overall.dTLB-load-miss-rate%
>       0.53 ±  5%      +0.1        0.63 ±  8%  perf-stat.overall.dTLB-store-miss-rate%
>     775.35           +78.9%       1386 ±  5%  perf-stat.overall.instructions-per-iTLB-miss
>       0.36 ±  4%     -28.0%       0.26        perf-stat.overall.ipc
>      48.07            -1.7       46.34        perf-stat.overall.node-load-miss-rate%
>      48.49            -2.7       45.76        perf-stat.overall.node-store-miss-rate%
>  9.922e+09 ±  4%     -20.8%  7.859e+09 ±  2%  perf-stat.ps.branch-instructions
>  1.351e+08 ±  2%     -60.4%   53438494        perf-stat.ps.branch-misses
>   12410866 ±  8%     +30.8%   16234283 ±  4%  perf-stat.ps.cache-misses
>  2.946e+08           -50.1%   1.47e+08 ±  2%  perf-stat.ps.cache-references
>    7252050 ±  7%     -68.6%    2278311 ±  9%  perf-stat.ps.context-switches
>      37323 ± 20%     -99.1%     338.80 ± 39%  perf-stat.ps.cpu-migrations
>   1.89e+08 ±  3%     -59.4%   76787292 ± 14%  perf-stat.ps.dTLB-load-misses
>  1.352e+10 ±  4%     -32.6%   9.11e+09        perf-stat.ps.dTLB-loads
>   52020930           -55.6%   23075080 ± 13%  perf-stat.ps.dTLB-store-misses
>  9.794e+09 ±  3%     -63.0%  3.627e+09 ±  4%  perf-stat.ps.dTLB-stores
>   61931461 ±  4%     -59.7%   24978175 ±  3%  perf-stat.ps.iTLB-load-misses
>  4.802e+10 ±  4%     -28.0%  3.457e+10        perf-stat.ps.instructions
>    3412948 ± 20%    +118.2%    7448345 ±  5%  perf-stat.ps.node-load-misses
>    3687448 ± 20%    +133.8%    8622075 ±  4%  perf-stat.ps.node-loads
>    8157655 ±  4%     -28.2%    5857930 ±  6%  perf-stat.ps.node-store-misses
>    8659916           -19.9%    6939197 ±  5%  perf-stat.ps.node-stores
>  3.035e+12 ±  4%     -27.9%  2.189e+12        perf-stat.total.instructions
>      82.33 ± 64%   +1322.3%       1171 ±127%  interrupts.36:PCI-MSI.2621442-edge.eth0-TxRx-1
>   17959753 ±  6%     -99.7%      45889 ±  2%  interrupts.CAL:Function_call_interrupts
>     103593 ±125%     -99.5%     569.33 ±  9%  interrupts.CPU0.CAL:Function_call_interrupts
>      45339 ±104%     -94.7%       2414 ± 30%  interrupts.CPU0.RES:Rescheduling_interrupts
>    1078794 ±112%     -99.9%       1002 ± 12%  interrupts.CPU1.CAL:Function_call_interrupts
>       6507 ± 26%     +21.7%       7922 ±  6%  interrupts.CPU1.NMI:Non-maskable_interrupts
>       6507 ± 26%     +21.7%       7922 ±  6%  interrupts.CPU1.PMI:Performance_monitoring_interrupts
>     505526 ±101%     -99.8%       1223 ± 46%  interrupts.CPU1.RES:Rescheduling_interrupts
>     791738 ± 80%     -99.9%     898.67 ± 13%  interrupts.CPU10.CAL:Function_call_interrupts
>     406363 ± 71%     -99.4%       2378 ± 80%  interrupts.CPU10.RES:Rescheduling_interrupts
>      46401 ±115%     -98.3%     789.00 ± 21%  interrupts.CPU11.CAL:Function_call_interrupts
>       5509 ± 35%     +25.8%       6931 ± 28%  interrupts.CPU11.NMI:Non-maskable_interrupts
>       5509 ± 35%     +25.8%       6931 ± 28%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
>      27829 ±104%     -87.3%       3526 ± 77%  interrupts.CPU11.RES:Rescheduling_interrupts
>     290182 ±130%     -99.6%       1299 ± 24%  interrupts.CPU12.CAL:Function_call_interrupts
>     170757 ±136%     -98.3%       2886 ± 40%  interrupts.CPU12.RES:Rescheduling_interrupts
>     131940 ± 43%     -99.1%       1206 ± 37%  interrupts.CPU13.CAL:Function_call_interrupts
>      68303 ± 32%     -97.9%       1445 ±126%  interrupts.CPU13.RES:Rescheduling_interrupts
>     241043 ±116%     -99.5%       1319 ± 32%  interrupts.CPU14.CAL:Function_call_interrupts
>      98573 ± 93%     -97.0%       3005 ± 47%  interrupts.CPU14.RES:Rescheduling_interrupts
>     874074 ± 72%     -99.9%     875.33 ±  6%  interrupts.CPU15.CAL:Function_call_interrupts
>     350120 ± 49%     -99.9%     412.67 ± 52%  interrupts.CPU15.RES:Rescheduling_interrupts
>     577696 ± 23%     -99.9%     855.33 ±  3%  interrupts.CPU16.CAL:Function_call_interrupts
>       8263           -24.9%       6202 ± 23%  interrupts.CPU16.NMI:Non-maskable_interrupts
>       8263           -24.9%       6202 ± 23%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
>     237815 ± 15%     -99.5%       1220 ± 53%  interrupts.CPU16.RES:Rescheduling_interrupts
>     686797 ±112%     -99.9%     933.67 ± 13%  interrupts.CPU17.CAL:Function_call_interrupts
>     317108 ±105%     -99.8%     536.00 ± 49%  interrupts.CPU17.RES:Rescheduling_interrupts
>     748163 ±122%     -99.9%     863.00 ±  5%  interrupts.CPU18.CAL:Function_call_interrupts
>     320920 ±112%     -99.5%       1469 ± 95%  interrupts.CPU18.RES:Rescheduling_interrupts
>     286835 ±121%     -99.7%     943.33 ± 15%  interrupts.CPU19.CAL:Function_call_interrupts
>     174455 ±113%     -98.7%       2326 ± 69%  interrupts.CPU19.RES:Rescheduling_interrupts
>     443377 ± 83%     -99.8%     944.33 ± 12%  interrupts.CPU2.CAL:Function_call_interrupts
>      57297 ± 99%     -98.5%     855.00 ±  6%  interrupts.CPU20.CAL:Function_call_interrupts
>      54090 ± 67%     -99.0%     535.33 ± 74%  interrupts.CPU20.RES:Rescheduling_interrupts
>      27584 ± 80%     -96.8%     890.33 ±  6%  interrupts.CPU21.CAL:Function_call_interrupts
>      27052 ± 82%     -94.3%       1539 ± 58%  interrupts.CPU21.RES:Rescheduling_interrupts
>      62804 ±104%     -97.8%       1362 ± 47%  interrupts.CPU22.CAL:Function_call_interrupts
>      27230 ± 84%     -92.6%       2002 ± 86%  interrupts.CPU22.RES:Rescheduling_interrupts
>     351930 ± 72%     -99.7%     966.00 ± 16%  interrupts.CPU23.CAL:Function_call_interrupts
>     136149 ± 62%     -98.1%       2565 ± 93%  interrupts.CPU23.RES:Rescheduling_interrupts
>     366644 ±138%     -99.8%     877.67 ±  5%  interrupts.CPU24.CAL:Function_call_interrupts
>     499203 ± 82%     -99.8%     862.33 ±  3%  interrupts.CPU25.CAL:Function_call_interrupts
>     298172 ± 70%     -99.2%       2317 ± 19%  interrupts.CPU25.RES:Rescheduling_interrupts
>      11844 ± 61%     -92.9%     838.33 ±  2%  interrupts.CPU26.CAL:Function_call_interrupts
>      82.33 ± 64%   +1322.3%       1171 ±127%  interrupts.CPU27.36:PCI-MSI.2621442-edge.eth0-TxRx-1
>    1841110 ± 49%    -100.0%     746.33 ± 26%  interrupts.CPU27.CAL:Function_call_interrupts
>       5501 ± 35%     +25.6%       6909 ± 28%  interrupts.CPU27.NMI:Non-maskable_interrupts
>       5501 ± 35%     +25.6%       6909 ± 28%  interrupts.CPU27.PMI:Performance_monitoring_interrupts
>    1089819 ± 55%     -99.8%       1727 ± 80%  interrupts.CPU27.RES:Rescheduling_interrupts
>      74718 ±118%     -98.7%     942.00        interrupts.CPU28.CAL:Function_call_interrupts
>       5504 ± 35%     +25.6%       6912 ± 28%  interrupts.CPU28.NMI:Non-maskable_interrupts
>       5504 ± 35%     +25.6%       6912 ± 28%  interrupts.CPU28.PMI:Performance_monitoring_interrupts
>      67380 ±125%     -98.5%       1034 ± 37%  interrupts.CPU28.RES:Rescheduling_interrupts
>     367428 ± 77%     -99.7%       1054 ± 22%  interrupts.CPU29.CAL:Function_call_interrupts
>     239038 ± 82%     -99.3%       1767 ± 84%  interrupts.CPU29.RES:Rescheduling_interrupts
>     220744 ±117%     -99.5%       1046 ± 21%  interrupts.CPU3.CAL:Function_call_interrupts
>     191269 ±119%     -98.4%       3122 ± 15%  interrupts.CPU3.RES:Rescheduling_interrupts
>     247241 ± 81%     -99.6%     874.33 ±  5%  interrupts.CPU30.CAL:Function_call_interrupts
>     161878 ± 84%     -98.1%       3063 ± 37%  interrupts.CPU30.RES:Rescheduling_interrupts
>     144713 ±110%     -99.3%       1077 ± 23%  interrupts.CPU31.CAL:Function_call_interrupts
>       5502 ± 35%     +25.6%       6911 ± 28%  interrupts.CPU31.NMI:Non-maskable_interrupts
>       5502 ± 35%     +25.6%       6911 ± 28%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
>      84227 ±100%     -96.4%       3013 ± 72%  interrupts.CPU31.RES:Rescheduling_interrupts
>     104510 ±109%     -99.2%     848.00 ±  4%  interrupts.CPU32.CAL:Function_call_interrupts
>       5515 ± 35%     +31.4%       7249 ± 20%  interrupts.CPU32.NMI:Non-maskable_interrupts
>       5515 ± 35%     +31.4%       7249 ± 20%  interrupts.CPU32.PMI:Performance_monitoring_interrupts
>      70068 ±101%     -96.7%       2320 ±126%  interrupts.CPU32.RES:Rescheduling_interrupts
>      87671 ±131%     -99.0%     857.33 ±  2%  interrupts.CPU33.CAL:Function_call_interrupts
>      35054 ±127%     -96.5%       1242 ± 80%  interrupts.CPU33.RES:Rescheduling_interrupts
>      77336 ±124%     -98.7%     988.33 ± 21%  interrupts.CPU34.CAL:Function_call_interrupts
>      66106 ±123%     -96.0%       2630 ± 52%  interrupts.CPU34.RES:Rescheduling_interrupts
>     136901 ±122%     -99.1%       1278 ± 30%  interrupts.CPU35.CAL:Function_call_interrupts
>     731054 ± 69%     -99.9%       1046 ± 15%  interrupts.CPU36.CAL:Function_call_interrupts
>     376136 ± 70%     -99.6%       1429 ± 37%  interrupts.CPU36.RES:Rescheduling_interrupts
>     941442 ±105%     -99.9%     851.33 ±  7%  interrupts.CPU37.CAL:Function_call_interrupts
>     300885 ± 80%     -99.2%       2379 ± 57%  interrupts.CPU37.RES:Rescheduling_interrupts
>     242878 ±117%     -99.6%     995.00 ± 16%  interrupts.CPU38.CAL:Function_call_interrupts
>     702836 ± 69%     -99.9%     855.00 ±  3%  interrupts.CPU39.CAL:Function_call_interrupts
>     286450 ± 74%     -99.5%       1448 ± 70%  interrupts.CPU39.RES:Rescheduling_interrupts
>      37564 ± 55%     -96.0%       1505 ± 62%  interrupts.CPU4.CAL:Function_call_interrupts
>       6346 ± 26%     +24.0%       7870 ±  6%  interrupts.CPU4.NMI:Non-maskable_interrupts
>       6346 ± 26%     +24.0%       7870 ±  6%  interrupts.CPU4.PMI:Performance_monitoring_interrupts
>      24154 ± 65%     -94.0%       1444 ± 83%  interrupts.CPU4.RES:Rescheduling_interrupts
>     977103 ± 53%     -99.9%     837.33 ±  3%  interrupts.CPU40.CAL:Function_call_interrupts
>     512103 ± 71%     -99.7%       1579 ± 66%  interrupts.CPU40.RES:Rescheduling_interrupts
>     190023 ±117%     -99.6%     818.67 ±  2%  interrupts.CPU41.CAL:Function_call_interrupts
>     346179 ± 54%     -99.8%     829.00 ±  2%  interrupts.CPU42.CAL:Function_call_interrupts
>     183103 ± 48%     -99.5%     850.00 ± 54%  interrupts.CPU42.RES:Rescheduling_interrupts
>     371814 ±131%     -99.8%     863.33 ±  5%  interrupts.CPU43.CAL:Function_call_interrupts
>     158123 ±124%     -99.2%       1224 ± 71%  interrupts.CPU43.RES:Rescheduling_interrupts
>     578077 ± 61%     -99.9%     850.67 ±  3%  interrupts.CPU44.CAL:Function_call_interrupts
>     331471 ± 53%     -99.7%       1120 ± 91%  interrupts.CPU44.RES:Rescheduling_interrupts
>     172794 ±114%     -99.5%     838.33 ±  4%  interrupts.CPU45.CAL:Function_call_interrupts
>      89408 ±111%     -99.6%     326.00 ± 23%  interrupts.CPU45.RES:Rescheduling_interrupts
>      34858 ± 59%     -97.3%     947.00 ± 13%  interrupts.CPU46.CAL:Function_call_interrupts
>      22612 ± 53%     -87.6%       2794 ± 27%  interrupts.CPU46.RES:Rescheduling_interrupts
>      41349 ± 57%     -97.6%     996.67 ± 10%  interrupts.CPU47.CAL:Function_call_interrupts
>      27498 ± 54%     -93.7%       1725 ± 89%  interrupts.CPU47.RES:Rescheduling_interrupts
>      45388 ± 61%     -97.5%       1141 ± 57%  interrupts.CPU5.CAL:Function_call_interrupts
>      32500 ± 63%     -96.7%       1063 ± 95%  interrupts.CPU5.RES:Rescheduling_interrupts
>     534772 ±105%     -99.8%     843.33 ±  3%  interrupts.CPU6.CAL:Function_call_interrupts
>     259978 ± 94%     -98.5%       4008 ±  4%  interrupts.CPU6.RES:Rescheduling_interrupts
>     589336 ± 71%     -99.8%       1042 ± 25%  interrupts.CPU7.CAL:Function_call_interrupts
>     311886 ± 69%     -99.4%       1966 ± 66%  interrupts.CPU7.RES:Rescheduling_interrupts
>     363153 ± 95%     -99.8%     858.00 ±  5%  interrupts.CPU8.CAL:Function_call_interrupts
>     190915 ± 83%     -98.1%       3681 ± 94%  interrupts.CPU8.RES:Rescheduling_interrupts
>      78806 ± 46%     -98.9%     905.33 ±  7%  interrupts.CPU9.CAL:Function_call_interrupts
>      47384 ± 29%     -95.9%       1963 ± 58%  interrupts.CPU9.RES:Rescheduling_interrupts
>    9209745 ± 15%     -99.0%      95188 ±  9%  interrupts.RES:Rescheduling_interrupts
>      20.15 ±  4%     -14.2        5.98 ± 15%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
>      15.92 ±  4%     -11.9        3.98 ±  7%  perf-profile.calltrace.cycles-pp.signal_wake_up_state.__send_signal.do_send_sig_info.kill_pid_info.do_rt_sigqueueinfo
>      15.71 ±  4%     -11.8        3.95 ±  7%  perf-profile.calltrace.cycles-pp.try_to_wake_up.signal_wake_up_state.__send_signal.do_send_sig_info.kill_pid_info
>      13.68 ±  6%     -10.8        2.93 ± 10%  perf-profile.calltrace.cycles-pp.schedule_hrtimeout_range_clock.do_sigtimedwait.__x64_sys_rt_sigtimedwait.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      12.23 ± 26%     -10.4        1.80 ± 38%  perf-profile.calltrace.cycles-pp.group_send_sig_info.kill_pid_info.do_rt_sigqueueinfo.__x64_sys_rt_sigqueueinfo.do_syscall_64
>      11.55 ± 27%     -10.0        1.56 ± 39%  perf-profile.calltrace.cycles-pp.security_task_kill.group_send_sig_info.kill_pid_info.do_rt_sigqueueinfo.__x64_sys_rt_sigqueueinfo
>      11.33 ± 27%      -9.8        1.49 ± 40%  perf-profile.calltrace.cycles-pp.apparmor_task_kill.security_task_kill.group_send_sig_info.kill_pid_info.do_rt_sigqueueinfo
>      11.78 ±  5%      -9.3        2.52 ±  9%  perf-profile.calltrace.cycles-pp.schedule.schedule_hrtimeout_range_clock.do_sigtimedwait.__x64_sys_rt_sigtimedwait.do_syscall_64
>      11.53 ±  5%      -9.1        2.47 ±  9%  perf-profile.calltrace.cycles-pp.__sched_text_start.schedule.schedule_hrtimeout_range_clock.do_sigtimedwait.__x64_sys_rt_sigtimedwait
>       8.27 ± 13%      -6.3        1.99 ±  7%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
>       7.32 ±  2%      -4.9        2.43 ± 25%  perf-profile.calltrace.cycles-pp.syscall_return_via_sysret
>       6.20 ± 13%      -4.7        1.53 ± 10%  perf-profile.calltrace.cycles-pp.schedule.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
>       5.94 ± 13%      -4.5        1.46 ± 10%  perf-profile.calltrace.cycles-pp.__sched_text_start.schedule.exit_to_user_mode_prepare.syscall_exit_to_user_mode.entry_SYSCALL_64_after_hwframe
>       6.32 ±  8%      -4.3        2.07 ±  6%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.try_to_wake_up.signal_wake_up_state.__send_signal.do_send_sig_info
>       4.57 ± 30%      -4.1        0.44 ± 74%  perf-profile.calltrace.cycles-pp.aa_get_task_label.apparmor_task_kill.security_task_kill.group_send_sig_info.kill_pid_info
>       5.55 ±  8%      -3.7        1.90 ±  6%  perf-profile.calltrace.cycles-pp.select_idle_sibling.select_task_rq_fair.try_to_wake_up.signal_wake_up_state.__send_signal
>       4.43 ±  7%      -3.4        0.99 ±  6%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.signal_wake_up_state.__send_signal.do_send_sig_info
>       4.29 ±  7%      -3.3        0.95 ±  6%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.signal_wake_up_state.__send_signal
>       4.19 ±  6%      -3.3        0.92 ±  8%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__sched_text_start.schedule.schedule_hrtimeout_range_clock.do_sigtimedwait
>       4.60            -2.9        1.69 ± 28%  perf-profile.calltrace.cycles-pp.__entry_text_start
>       1.93 ± 16%      -1.6        0.37 ± 70%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__sched_text_start.schedule.exit_to_user_mode_prepare.syscall_exit_to_user_mode
>       2.40 ±  6%      -1.5        0.86 ±  6%  perf-profile.calltrace.cycles-pp.available_idle_cpu.select_idle_sibling.select_task_rq_fair.try_to_wake_up.signal_wake_up_state
>       0.00            +0.7        0.67        perf-profile.calltrace.cycles-pp.inc_rlimit_ucounts_and_test.__sigqueue_alloc.__send_signal.do_send_sig_info.kill_pid_info
>       0.67 ± 16%      +2.4        3.11 ± 53%  perf-profile.calltrace.cycles-pp.__lock_task_sighand.do_send_sig_info.kill_pid_info.do_rt_sigqueueinfo.__x64_sys_rt_sigqueueinfo
>       0.42 ± 71%      +2.7        3.08 ± 53%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.__lock_task_sighand.do_send_sig_info.kill_pid_info.do_rt_sigqueueinfo
>       0.00            +3.0        2.98 ± 54%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__lock_task_sighand.do_send_sig_info.kill_pid_info
>       0.00            +3.2        3.23 ± 51%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.do_sigtimedwait.__x64_sys_rt_sigtimedwait.do_syscall_64
>       0.00            +3.3        3.29 ± 51%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.do_sigtimedwait.__x64_sys_rt_sigtimedwait.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      35.47 ±  7%      +9.5       45.02        perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigqueueinfo.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      34.17 ±  7%     +10.4       44.54        perf-profile.calltrace.cycles-pp.do_rt_sigqueueinfo.__x64_sys_rt_sigqueueinfo.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      33.33 ±  7%     +10.9       44.22        perf-profile.calltrace.cycles-pp.kill_pid_info.do_rt_sigqueueinfo.__x64_sys_rt_sigqueueinfo.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      81.67           +12.6       94.25        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
>      19.16 ±  4%     +19.5       38.64 ±  8%  perf-profile.calltrace.cycles-pp.__send_signal.do_send_sig_info.kill_pid_info.do_rt_sigqueueinfo.__x64_sys_rt_sigqueueinfo
>      21.31 ±  6%     +20.5       41.77 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigtimedwait.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      20.83 ±  3%     +21.5       42.33 ±  3%  perf-profile.calltrace.cycles-pp.do_send_sig_info.kill_pid_info.do_rt_sigqueueinfo.__x64_sys_rt_sigqueueinfo.do_syscall_64
>      19.46 ±  5%     +21.9       41.31 ±  4%  perf-profile.calltrace.cycles-pp.do_sigtimedwait.__x64_sys_rt_sigtimedwait.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      59.72 ±  2%     +28.1       87.78 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       3.78 ±  8%     +30.8       34.58 ±  9%  perf-profile.calltrace.cycles-pp.dequeue_signal.do_sigtimedwait.__x64_sys_rt_sigtimedwait.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       3.07 ±  8%     +31.3       34.40 ±  9%  perf-profile.calltrace.cycles-pp.__dequeue_signal.dequeue_signal.do_sigtimedwait.__x64_sys_rt_sigtimedwait.do_syscall_64
>       1.74 ±  9%     +32.1       33.86 ±  9%  perf-profile.calltrace.cycles-pp.__sigqueue_free.__dequeue_signal.dequeue_signal.do_sigtimedwait.__x64_sys_rt_sigtimedwait
>       1.94 ±  8%     +32.5       34.40 ±  8%  perf-profile.calltrace.cycles-pp.__sigqueue_alloc.__send_signal.do_send_sig_info.kill_pid_info.do_rt_sigqueueinfo
>       0.00           +32.8       32.81 ±  9%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.put_ucounts.__sigqueue_free.__dequeue_signal
>       0.00           +33.0       33.02 ±  8%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.get_ucounts.__sigqueue_alloc.__send_signal
>       0.00           +33.2       33.22 ±  9%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.put_ucounts.__sigqueue_free.__dequeue_signal.dequeue_signal
>       0.00           +33.3       33.32 ±  9%  perf-profile.calltrace.cycles-pp.put_ucounts.__sigqueue_free.__dequeue_signal.dequeue_signal.do_sigtimedwait
>       0.00           +33.5       33.48 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.get_ucounts.__sigqueue_alloc.__send_signal.do_send_sig_info
>       0.00           +33.6       33.57 ±  8%  perf-profile.calltrace.cycles-pp.get_ucounts.__sigqueue_alloc.__send_signal.do_send_sig_info.kill_pid_info
>      20.22 ±  4%     -14.2        6.00 ± 15%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>      18.14 ±  8%     -14.1        4.06 ± 10%  perf-profile.children.cycles-pp.schedule
>      17.92 ±  7%     -14.0        3.96 ±  9%  perf-profile.children.cycles-pp.__sched_text_start
>      15.92 ±  4%     -11.9        3.98 ±  7%  perf-profile.children.cycles-pp.signal_wake_up_state
>      15.73 ±  4%     -11.8        3.96 ±  7%  perf-profile.children.cycles-pp.try_to_wake_up
>      13.71 ±  6%     -10.8        2.93 ± 10%  perf-profile.children.cycles-pp.schedule_hrtimeout_range_clock
>      12.24 ± 26%     -10.4        1.80 ± 38%  perf-profile.children.cycles-pp.group_send_sig_info
>      11.56 ± 27%     -10.0        1.56 ± 39%  perf-profile.children.cycles-pp.security_task_kill
>      11.35 ± 27%      -9.9        1.49 ± 40%  perf-profile.children.cycles-pp.apparmor_task_kill
>       8.45 ± 12%      -6.5        2.00 ±  7%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>       8.04            -5.3        2.71 ± 25%  perf-profile.children.cycles-pp.syscall_return_via_sysret
>       6.34 ±  8%      -4.3        2.07 ±  6%  perf-profile.children.cycles-pp.select_task_rq_fair
>       4.58 ± 30%      -4.0        0.55 ± 36%  perf-profile.children.cycles-pp.aa_get_task_label
>       6.03            -4.0        2.05 ± 28%  perf-profile.children.cycles-pp.__entry_text_start
>       4.70 ±  6%      -3.7        0.99 ±  6%  perf-profile.children.cycles-pp.ttwu_do_activate
>       5.63 ±  8%      -3.7        1.93 ±  6%  perf-profile.children.cycles-pp.select_idle_sibling
>       4.57 ±  6%      -3.6        0.96 ±  6%  perf-profile.children.cycles-pp.enqueue_task_fair
>       4.23 ±  7%      -3.3        0.93 ±  8%  perf-profile.children.cycles-pp.dequeue_task_fair
>       3.78 ± 12%      -2.9        0.91 ± 11%  perf-profile.children.cycles-pp.pick_next_task_fair
>       3.44 ±  9%      -2.7        0.78 ±  9%  perf-profile.children.cycles-pp.switch_mm_irqs_off
>       3.07 ± 10%      -2.4        0.68 ±  9%  perf-profile.children.cycles-pp.update_load_avg
>       2.96 ±  3%      -2.3        0.69 ±  9%  perf-profile.children.cycles-pp.update_curr
>       2.35 ±  3%      -1.9        0.48 ±  6%  perf-profile.children.cycles-pp.enqueue_entity
>       2.26 ± 13%      -1.7        0.56 ± 10%  perf-profile.children.cycles-pp.load_new_mm_cr3
>       2.44 ±  6%      -1.6        0.86 ±  5%  perf-profile.children.cycles-pp.available_idle_cpu
>       1.82 ±  4%      -1.4        0.41 ±  7%  perf-profile.children.cycles-pp.dequeue_entity
>       1.93 ±  3%      -1.4        0.52 ± 32%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
>       1.63 ± 10%      -1.3        0.28 ±  8%  perf-profile.children.cycles-pp._raw_spin_lock
>       1.59 ± 13%      -1.3        0.30 ± 10%  perf-profile.children.cycles-pp.switch_fpu_return
>       1.63 ± 11%      -1.2        0.39 ± 10%  perf-profile.children.cycles-pp.reweight_entity
>       1.47 ±  7%      -1.2        0.31 ± 11%  perf-profile.children.cycles-pp.__switch_to
>       1.25 ± 12%      -1.0        0.27 ± 13%  perf-profile.children.cycles-pp.__switch_to_asm
>       1.21 ± 10%      -0.9        0.27 ± 13%  perf-profile.children.cycles-pp.set_next_entity
>       1.07 ±  7%      -0.9        0.13 ± 25%  perf-profile.children.cycles-pp.finish_task_switch
>       1.30 ±  4%      -0.9        0.41 ± 10%  perf-profile.children.cycles-pp._copy_from_user
>       1.11 ±  7%      -0.8        0.27 ± 12%  perf-profile.children.cycles-pp.update_rq_clock
>       1.04 ±  4%      -0.8        0.24 ± 15%  perf-profile.children.cycles-pp.ttwu_do_wakeup
>       0.99 ± 13%      -0.8        0.21 ± 14%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
>       0.98 ±  4%      -0.8        0.22 ± 13%  perf-profile.children.cycles-pp.check_preempt_curr
>       1.03            -0.8        0.28 ±  4%  perf-profile.children.cycles-pp.recalc_sigpending
>       0.97 ± 12%      -0.7        0.22 ± 10%  perf-profile.children.cycles-pp.__update_load_avg_se
>       0.90 ±  8%      -0.7        0.18 ± 12%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
>       0.95 ± 10%      -0.7        0.23 ± 10%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
>       0.94 ± 33%      -0.7        0.23 ± 40%  perf-profile.children.cycles-pp.aa_may_signal
>       0.94 ±  6%      -0.7        0.23 ±  2%  perf-profile.children.cycles-pp.copy_siginfo_to_user
>       0.95 ±  6%      -0.7        0.27 ±  9%  perf-profile.children.cycles-pp.__might_fault
>       0.85 ±  5%      -0.7        0.19 ± 11%  perf-profile.children.cycles-pp.check_preempt_wakeup
>       0.83 ±  9%      -0.6        0.19 ±  7%  perf-profile.children.cycles-pp.___perf_sw_event
>       1.00 ±  2%      -0.6        0.36 ± 20%  perf-profile.children.cycles-pp.__copy_siginfo_from_user
>       0.79 ± 17%      -0.6        0.19 ± 11%  perf-profile.children.cycles-pp.put_prev_entity
>       0.80 ± 12%      -0.6        0.20 ±  8%  perf-profile.children.cycles-pp.pick_next_entity
>       0.82 ±  2%      -0.5        0.29 ± 24%  perf-profile.children.cycles-pp.__x64_sys_getpid
>       0.68 ±  2%      -0.5        0.16 ±  3%  perf-profile.children.cycles-pp.update_cfs_group
>       0.87 ± 17%      -0.5        0.38        perf-profile.children.cycles-pp.asm_call_sysvec_on_stack
>       0.53 ±  6%      -0.5        0.06 ± 16%  perf-profile.children.cycles-pp.complete_signal
>       0.58 ±  6%      -0.5        0.12 ± 10%  perf-profile.children.cycles-pp.sched_clock_cpu
>       0.55 ±  5%      -0.4        0.10 ± 12%  perf-profile.children.cycles-pp.hrtimer_try_to_cancel
>       0.79 ± 12%      -0.4        0.35 ±  7%  perf-profile.children.cycles-pp.cpumask_next_wrap
>       0.62 ± 18%      -0.4        0.19 ± 10%  perf-profile.children.cycles-pp._find_next_bit
>       0.71 ±  2%      -0.4        0.28 ± 34%  perf-profile.children.cycles-pp.__task_pid_nr_ns
>       0.62 ±  3%      -0.4        0.21 ± 30%  perf-profile.children.cycles-pp.__x64_sys_getuid
>       0.53 ± 14%      -0.4        0.14 ± 17%  perf-profile.children.cycles-pp.__calc_delta
>       0.59 ±  8%      -0.4        0.20 ± 32%  perf-profile.children.cycles-pp.check_kill_permission
>       0.50 ±  6%      -0.4        0.11 ± 11%  perf-profile.children.cycles-pp.sched_clock
>       0.50 ± 13%      -0.4        0.12 ± 10%  perf-profile.children.cycles-pp.copy_fpregs_to_fpstate
>       0.47 ±  6%      -0.4        0.09 ± 18%  perf-profile.children.cycles-pp.perf_tp_event
>       0.48 ±  6%      -0.4        0.10 ±  9%  perf-profile.children.cycles-pp.native_sched_clock
>       0.48 ±  3%      -0.4        0.11 ±  4%  perf-profile.children.cycles-pp.___might_sleep
>       0.74 ± 12%      -0.4        0.39        perf-profile.children.cycles-pp.kmem_cache_free
>       0.45 ±  8%      -0.3        0.13 ± 13%  perf-profile.children.cycles-pp._copy_to_user
>       0.36 ±  5%      -0.3        0.06 ±  8%  perf-profile.children.cycles-pp.__set_task_blocked
>       0.35 ± 22%      -0.3        0.07 ± 11%  perf-profile.children.cycles-pp.cpumask_next
>       0.38 ±  7%      -0.3        0.10 ± 14%  perf-profile.children.cycles-pp.ktime_get
>       0.46 ± 10%      -0.3        0.19 ± 36%  perf-profile.children.cycles-pp.__radix_tree_lookup
>       0.64 ±  4%      -0.3        0.37 ±  6%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
>       0.33 ± 16%      -0.3        0.06 ± 14%  perf-profile.children.cycles-pp.cpuacct_charge
>       0.53            -0.3        0.26 ± 33%  perf-profile.children.cycles-pp.send_signal
>       0.33 ± 16%      -0.3        0.07 ± 12%  perf-profile.children.cycles-pp.__wrgsbase_inactive
>       0.34 ±  8%      -0.2        0.09 ±  5%  perf-profile.children.cycles-pp.update_min_vruntime
>       0.39 ±  3%      -0.2        0.15 ± 12%  perf-profile.children.cycles-pp.copy_user_generic_unrolled
>       0.32 ±  6%      -0.2        0.07 ±  6%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
>       0.28 ±  2%      -0.2        0.04 ± 71%  perf-profile.children.cycles-pp.lock_hrtimer_base
>       0.30 ±  9%      -0.2        0.06 ±  7%  perf-profile.children.cycles-pp.set_next_buddy
>       0.35 ±  5%      -0.2        0.11 ± 36%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
>       0.30 ±  5%      -0.2        0.07 ± 17%  perf-profile.children.cycles-pp.rb_erase
>       0.32 ±  2%      -0.2        0.10 ±  9%  perf-profile.children.cycles-pp.__x86_retpoline_rax
>       0.30 ±  5%      -0.2        0.08 ± 14%  perf-profile.children.cycles-pp.__might_sleep
>       0.29 ±  7%      -0.2        0.07 ± 12%  perf-profile.children.cycles-pp.__clear_user
>       0.31 ± 14%      -0.2        0.09 ±  9%  perf-profile.children.cycles-pp.clear_buddies
>       0.25 ±  3%      -0.2        0.05        perf-profile.children.cycles-pp.recalc_sigpending_tsk
>       0.29 ± 12%      -0.2        0.09 ± 22%  perf-profile.children.cycles-pp.prepare_signal
>       0.30 ±  4%      -0.2        0.11 ± 34%  perf-profile.children.cycles-pp.from_kuid_munged
>       0.27 ±  4%      -0.2        0.09 ± 36%  perf-profile.children.cycles-pp.map_id_up
>       0.21 ± 21%      -0.2        0.03 ± 70%  perf-profile.children.cycles-pp.enqueue_hrtimer
>       0.22 ± 13%      -0.2        0.06 ±  8%  perf-profile.children.cycles-pp.get_timespec64
>       0.22 ± 17%      -0.2        0.06 ± 86%  perf-profile.children.cycles-pp.__cgroup_account_cputime
>       0.20 ±  4%      -0.2        0.04 ± 76%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
>       0.20 ±  6%      -0.2        0.05        perf-profile.children.cycles-pp.__list_del_entry_valid
>       0.19 ±  7%      -0.2        0.04 ± 71%  perf-profile.children.cycles-pp.perf_trace_sched_switch
>       0.23 ±  8%      -0.1        0.08 ± 31%  perf-profile.children.cycles-pp.audit_signal_info
>       0.22 ±  5%      -0.1        0.08 ± 16%  perf-profile.children.cycles-pp.rcu_read_unlock_strict
>       0.17 ±  9%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.read_tsc
>       0.18 ±  7%      -0.1        0.05 ± 72%  perf-profile.children.cycles-pp.audit_signal_info_syscall
>       0.17 ±  5%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.kmem_cache_alloc
>       0.00            +0.5        0.51 ±  3%  perf-profile.children.cycles-pp.dec_rlimit_ucounts
>       0.00            +0.7        0.67 ±  2%  perf-profile.children.cycles-pp.inc_rlimit_ucounts_and_test
>       0.68 ± 16%      +2.4        3.11 ± 53%  perf-profile.children.cycles-pp.__lock_task_sighand
>       0.42 ±  6%      +2.9        3.30 ± 51%  perf-profile.children.cycles-pp._raw_spin_lock_irq
>      35.50 ±  7%      +9.5       45.03        perf-profile.children.cycles-pp.__x64_sys_rt_sigqueueinfo
>      34.19 ±  7%     +10.4       44.55        perf-profile.children.cycles-pp.do_rt_sigqueueinfo
>      33.35 ±  7%     +10.9       44.22        perf-profile.children.cycles-pp.kill_pid_info
>      81.79           +12.5       94.33        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>      19.21 ±  4%     +19.4       38.65 ±  8%  perf-profile.children.cycles-pp.__send_signal
>      21.36 ±  6%     +20.4       41.78 ±  4%  perf-profile.children.cycles-pp.__x64_sys_rt_sigtimedwait
>      20.86 ±  3%     +21.5       42.34 ±  3%  perf-profile.children.cycles-pp.do_send_sig_info
>      19.50 ±  5%     +21.8       41.33 ±  4%  perf-profile.children.cycles-pp.do_sigtimedwait
>      59.88 ±  2%     +28.0       87.85 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
>       3.81 ±  8%     +30.9       34.66 ±  9%  perf-profile.children.cycles-pp.dequeue_signal
>       3.09 ±  8%     +31.3       34.41 ±  9%  perf-profile.children.cycles-pp.__dequeue_signal
>       1.74 ±  9%     +32.1       33.87 ±  9%  perf-profile.children.cycles-pp.__sigqueue_free
>       1.95 ±  8%     +32.5       34.40 ±  8%  perf-profile.children.cycles-pp.__sigqueue_alloc
>       0.00           +33.3       33.32 ±  9%  perf-profile.children.cycles-pp.put_ucounts
>       0.00           +33.6       33.58 ±  8%  perf-profile.children.cycles-pp.get_ucounts
>       1.07 ± 11%     +68.8       69.87 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>       0.74 ± 39%     +71.3       72.04 ±  4%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>      11.75 ±  2%      -7.8        3.95 ± 26%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
>       8.02            -5.3        2.70 ± 25%  perf-profile.self.cycles-pp.syscall_return_via_sysret
>       5.78 ± 25%      -5.1        0.71 ± 43%  perf-profile.self.cycles-pp.apparmor_task_kill
>       4.55 ± 30%      -4.0        0.53 ± 34%  perf-profile.self.cycles-pp.aa_get_task_label
>       6.02            -4.0        2.05 ± 28%  perf-profile.self.cycles-pp.__entry_text_start
>       1.79 ±  9%      -1.7        0.06 ± 13%  perf-profile.self.cycles-pp.__sigqueue_alloc
>       2.22 ±  9%      -1.7        0.50 ±  9%  perf-profile.self.cycles-pp.__sched_text_start
>       2.25 ± 13%      -1.7        0.55 ± 11%  perf-profile.self.cycles-pp.load_new_mm_cr3
>       2.40 ±  6%      -1.5        0.85 ±  6%  perf-profile.self.cycles-pp.available_idle_cpu
>       1.57 ± 12%      -1.3        0.30 ± 10%  perf-profile.self.cycles-pp.switch_fpu_return
>       1.74 ±  6%      -1.2        0.50 ± 11%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
>       1.79 ±  8%      -1.2        0.60 ±  6%  perf-profile.self.cycles-pp.select_idle_sibling
>       1.41 ±  7%      -1.1        0.30 ± 11%  perf-profile.self.cycles-pp.__switch_to
>       1.25 ±  3%      -1.0        0.27 ±  8%  perf-profile.self.cycles-pp.update_curr
>       1.23 ± 12%      -1.0        0.27 ± 13%  perf-profile.self.cycles-pp.__switch_to_asm
>       1.17 ±  7%      -0.9        0.23 ±  9%  perf-profile.self.cycles-pp.update_load_avg
>       1.15 ±  2%      -0.9        0.21 ±  5%  perf-profile.self.cycles-pp.switch_mm_irqs_off
>       1.13 ±  3%      -0.8        0.28 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock
>       0.94 ± 13%      -0.8        0.14 ±  9%  perf-profile.self.cycles-pp.try_to_wake_up
>       1.06            -0.7        0.32 ± 28%  perf-profile.self.cycles-pp.do_syscall_64
>       0.93 ± 12%      -0.7        0.22 ± 12%  perf-profile.self.cycles-pp.__update_load_avg_se
>       0.93 ± 33%      -0.7        0.23 ± 40%  perf-profile.self.cycles-pp.aa_may_signal
>       0.90 ± 10%      -0.7        0.22 ±  9%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
>       0.77            -0.6        0.15 ±  5%  perf-profile.self.cycles-pp.recalc_sigpending
>       0.77 ± 13%      -0.6        0.20 ±  7%  perf-profile.self.cycles-pp.reweight_entity
>       0.74 ±  7%      -0.6        0.19 ± 11%  perf-profile.self.cycles-pp.update_rq_clock
>       0.67 ±  7%      -0.5        0.14 ±  6%  perf-profile.self.cycles-pp.___perf_sw_event
>       0.63 ±  7%      -0.5        0.11 ± 11%  perf-profile.self.cycles-pp.enqueue_entity
>       0.67 ±  3%      -0.5        0.15 ±  3%  perf-profile.self.cycles-pp.update_cfs_group
>       0.66 ±  9%      -0.5        0.16 ± 12%  perf-profile.self.cycles-pp.pick_next_task_fair
>       0.61 ± 13%      -0.5        0.12 ±  4%  perf-profile.self.cycles-pp.enqueue_task_fair
>       0.60 ±  5%      -0.5        0.11 ± 14%  perf-profile.self.cycles-pp.dequeue_task_fair
>       0.62 ±  8%      -0.5        0.14 ±  5%  perf-profile.self.cycles-pp.select_task_rq_fair
>       0.63 ±  6%      -0.5        0.16 ± 10%  perf-profile.self.cycles-pp.do_sigtimedwait
>       0.61 ± 18%      -0.4        0.19 ± 10%  perf-profile.self.cycles-pp._find_next_bit
>       0.68 ±  3%      -0.4        0.27 ± 33%  perf-profile.self.cycles-pp.__task_pid_nr_ns
>       0.54 ±  3%      -0.4        0.14 ±  6%  perf-profile.self.cycles-pp.__dequeue_signal
>       0.51            -0.4        0.12 ± 20%  perf-profile.self.cycles-pp.__send_signal
>       0.53 ± 14%      -0.4        0.14 ± 15%  perf-profile.self.cycles-pp.__calc_delta
>       0.49 ± 13%      -0.4        0.12 ± 10%  perf-profile.self.cycles-pp.copy_fpregs_to_fpstate
>       0.46 ±  7%      -0.4        0.09 ± 10%  perf-profile.self.cycles-pp.native_sched_clock
>       0.46 ±  3%      -0.4        0.10 ±  4%  perf-profile.self.cycles-pp.___might_sleep
>       0.50 ±  7%      -0.3        0.16 ± 23%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
>       0.50 ±  3%      -0.3        0.17 ± 29%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
>       0.44 ± 14%      -0.3        0.10 ± 16%  perf-profile.self.cycles-pp.schedule
>       0.42 ±  5%      -0.3        0.09 ±  9%  perf-profile.self.cycles-pp.finish_task_switch
>       0.43 ± 11%      -0.3        0.10 ±  9%  perf-profile.self.cycles-pp.pick_next_entity
>       0.41 ± 10%      -0.3        0.08 ±  5%  perf-profile.self.cycles-pp.__x64_sys_rt_sigtimedwait
>       0.44 ±  6%      -0.3        0.13 ±  6%  perf-profile.self.cycles-pp._copy_from_user
>       0.50 ±  3%      -0.3        0.20 ± 11%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
>       0.63 ± 20%      -0.3        0.35 ±  6%  perf-profile.self.cycles-pp.kmem_cache_free
>       0.37 ±  3%      -0.3        0.10 ± 12%  perf-profile.self.cycles-pp.check_preempt_wakeup
>       0.37 ±  7%      -0.3        0.10 ±  4%  perf-profile.self.cycles-pp.dequeue_entity
>       0.33 ± 15%      -0.3        0.06 ± 13%  perf-profile.self.cycles-pp.cpuacct_charge
>       0.46 ± 11%      -0.3        0.19 ± 36%  perf-profile.self.cycles-pp.__radix_tree_lookup
>       0.34 ±  3%      -0.3        0.07 ± 11%  perf-profile.self.cycles-pp._raw_spin_lock_irq
>       0.29 ±  7%      -0.3        0.04 ± 71%  perf-profile.self.cycles-pp.perf_tp_event
>       0.36 ± 11%      -0.3        0.10 ±  4%  perf-profile.self.cycles-pp.__might_fault
>       0.32 ±  7%      -0.2        0.08 ±  5%  perf-profile.self.cycles-pp.update_min_vruntime
>       0.31 ± 17%      -0.2        0.07 ± 12%  perf-profile.self.cycles-pp.__wrgsbase_inactive
>       0.37 ±  2%      -0.2        0.14 ± 13%  perf-profile.self.cycles-pp.copy_user_generic_unrolled
>       0.30 ±  4%      -0.2        0.07 ±  7%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
>       0.26 ±  8%      -0.2        0.04 ± 71%  perf-profile.self.cycles-pp.set_next_buddy
>       0.29 ±  5%      -0.2        0.07 ± 17%  perf-profile.self.cycles-pp.rb_erase
>       0.28 ± 11%      -0.2        0.06 ± 14%  perf-profile.self.cycles-pp.set_next_entity
>       0.30 ±  4%      -0.2        0.09 ± 30%  perf-profile.self.cycles-pp.__x64_sys_getuid
>       0.39 ± 13%      -0.2        0.18 ±  9%  perf-profile.self.cycles-pp.cpumask_next_wrap
>       0.27 ±  5%      -0.2        0.07 ± 17%  perf-profile.self.cycles-pp.__might_sleep
>       0.31 ±  3%      -0.2        0.12 ± 28%  perf-profile.self.cycles-pp.__x64_sys_rt_sigqueueinfo
>       0.24            -0.2        0.05        perf-profile.self.cycles-pp.recalc_sigpending_tsk
>       0.28 ±  5%      -0.2        0.09 ± 36%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
>       0.27 ± 12%      -0.2        0.08 ± 24%  perf-profile.self.cycles-pp.prepare_signal
>       0.27 ± 13%      -0.2        0.08 ± 10%  perf-profile.self.cycles-pp.clear_buddies
>       0.26 ±  3%      -0.2        0.08 ± 12%  perf-profile.self.cycles-pp.__x86_retpoline_rax
>       0.21 ± 17%      -0.2        0.04 ± 71%  perf-profile.self.cycles-pp.put_prev_entity
>       0.26 ±  4%      -0.2        0.09 ± 36%  perf-profile.self.cycles-pp.map_id_up
>       0.23 ± 13%      -0.2        0.07 ± 11%  perf-profile.self.cycles-pp.schedule_hrtimeout_range_clock
>       0.19 ±  8%      -0.2        0.04 ± 70%  perf-profile.self.cycles-pp.ktime_get
>       0.19 ±  9%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.perf_trace_sched_switch
>       0.18 ±  4%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.__list_del_entry_valid
>       0.19 ±  8%      -0.1        0.05 ± 78%  perf-profile.self.cycles-pp.check_kill_permission
>       0.26            -0.1        0.13 ± 26%  perf-profile.self.cycles-pp.send_signal
>       0.21 ±  4%      -0.1        0.08 ± 26%  perf-profile.self.cycles-pp.__x64_sys_getpid
>       0.20 ±  2%      -0.1        0.06 ± 19%  perf-profile.self.cycles-pp.security_task_kill
>       0.17 ±  4%      -0.1        0.05 ± 78%  perf-profile.self.cycles-pp.kill_pid_info
>       0.16 ±  8%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.rcu_read_unlock_strict
>       0.16 ± 10%      -0.1        0.05 ± 72%  perf-profile.self.cycles-pp.audit_signal_info_syscall
>       0.24 ±  8%      -0.1        0.14 ±  3%  perf-profile.self.cycles-pp.dequeue_signal
>       0.12 ±  4%      -0.1        0.04 ± 71%  perf-profile.self.cycles-pp.do_rt_sigqueueinfo
>       0.12 ± 11%      -0.1        0.04 ± 70%  perf-profile.self.cycles-pp.do_send_sig_info
>       0.15 ±  6%      -0.0        0.10        perf-profile.self.cycles-pp.kmem_cache_alloc
>       0.00            +0.1        0.07 ± 11%  perf-profile.self.cycles-pp.get_ucounts
>       0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.put_ucounts
>       0.88 ±  7%      +0.2        1.04        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>       0.00            +0.5        0.51 ±  3%  perf-profile.self.cycles-pp.dec_rlimit_ucounts
>       0.00            +0.7        0.67        perf-profile.self.cycles-pp.inc_rlimit_ucounts_and_test
>       0.74 ± 39%     +71.3       72.04 ±  4%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
>
>
>
>
>
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
>
>
> Thanks,
> Oliver Sang
