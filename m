Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0FE37A583
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 13:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhEKLO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 07:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhEKLO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 07:14:56 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3180C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 04:13:49 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id z24so17779992ioj.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 04:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZPUefDbgUxnd5/If5C/FLbHciG8WAMdMj4jXuPulB4M=;
        b=uVLzLpLa0+IuSrE9+p7XkKshs/y6BKZz+QhpMH31xdDtcJqvW2SAXHCs+BzWawSlDi
         oM4MSWaYjHV0UmBgxqAWPZQbROSXm8sQR/yKvCCEYMiXpFi7sQ0SbwQSTSqDAyMhJusZ
         J1hD0ARhDR3HdJIqJ4VrZyJH1st15vflKJVHvbqAA7Czk3ltF7zhqXpo7QofmgXwhRxh
         ZcQ0uB0WfdPBb2xUoid+5PJf/mtp3WwtyNEm1FH3jtm+t2iAPkFK0t6pXmeJmcvqTXyI
         PokDXRhAPOPXfuJmAFTCs8ZVO9mXC/U1UrpCg7DqdPR8sxBb8QfctQtSBhQDkLgqPxIx
         bYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZPUefDbgUxnd5/If5C/FLbHciG8WAMdMj4jXuPulB4M=;
        b=cOUD4TPATjSRD2Uim2VxTbI/Q2Po0oTzEX3jO05sr7m6PGVialxeyMZbTcJSJwR5/C
         +QaKKWFq0LgB7GUbMGZA6w8V11EizKISqgS/gWMPuxIMXMBXLa5rsF9+doljRZ863P1W
         L2KYJQpW8wwfcF7rGN6SVoKpfl2DapD1uE+lqFGYm6DSvME0i9MaOLSwFPaHeEyptuXR
         At+EMusrdnbHz1JJvg69q/6em7ZVV+0KMOYC5/I8aSr8Tudk0MFW+9WA2A51zXQIMz7O
         uCdFxQ7aLMq3nSqH9Uj7X4TmiQF2+RTQIUSmwvTjcGlEQXry+GyCh+MjHcZ+84suw8kZ
         InzQ==
X-Gm-Message-State: AOAM532Zpk8iYMV2KyTIikh+KrlXlZCYYLW5Azedm/a93rSoMCt+nk9p
        kthbQURlyx9sxVvGrbBOtEPdZh8oK4cOzI20cC9B/Szk
X-Google-Smtp-Source: ABdhPJy5mmGJiq6aV49PnFHmVjB7az2DUXFhDEfISy3YOa1uZ0Imq48vm4xXl6AOD4PPqW2HOhnQiDzQ0G5zJlFJbL4=
X-Received: by 2002:a6b:e80f:: with SMTP id f15mr18766393ioh.64.1620731629131;
 Tue, 11 May 2021 04:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210511070805.GE8539@xsang-OptiPlex-9020>
In-Reply-To: <20210511070805.GE8539@xsang-OptiPlex-9020>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 11 May 2021 14:13:38 +0300
Message-ID: <CAOQ4uxhoR8h0Mw=LJGSxMYWC1krjbwgzxbYNDjMmeo3sBAey1w@mail.gmail.com>
Subject: Re: [fanotify] 7cea2a3c50: stress-ng.fanotify.ops_per_sec -23.4% regression
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>,
        ying.huang@intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 9:51 AM kernel test robot <oliver.sang@intel.com> w=
rote:
>
>
>
> Greeting,
>
> FYI, we noticed a -23.4% regression of stress-ng.fanotify.ops_per_sec due=
 to commit:
>
>
> commit: 7cea2a3c505e87a9d6afc78be4a7f7be636a73a7 ("fanotify: support limi=
ted functionality for unprivileged users")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>

I am not sure how this is possible.
This commit only changes permissions to perform the operation.
Is the test not being run as root?

Thanks,
Amir.

>
> in testcase: stress-ng
> on test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.=
10GHz with 192G memory
> with following parameters:
>
>         nr_threads: 10%
>         disk: 1HDD
>         testtime: 60s
>         fs: ext4
>         class: os
>         test: fanotify
>         cpufreq_governor: performance
>         ucode: 0x5003006
>
>
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
>
> Details are as below:
> -------------------------------------------------------------------------=
------------------------->
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install                job.yaml  # job file is attached i=
n this email
>         bin/lkp split-job --compatible job.yaml  # generate the yaml file=
 for lkp run
>         bin/lkp run                    generated-yaml-file
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_gr=
oup/test/testcase/testtime/ucode:
>   os/gcc-9/performance/1HDD/ext4/x86_64-rhel-8.3/10%/debian-10.4-x86_64-2=
0200603.cgz/lkp-csl-2sp5/fanotify/stress-ng/60s/0x5003006
>
> commit:
>   5b8fea65d1 ("fanotify: configurable limits via sysfs")
>   7cea2a3c50 ("fanotify: support limited functionality for unprivileged u=
sers")
>
> 5b8fea65d197f408 7cea2a3c505e87a9d6afc78be4a
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>  1.214e+08 =C4=85  3%     -23.4%   93048328 =C4=85  4%  stress-ng.fanotif=
y.ops
>    2023656 =C4=85  3%     -23.4%    1550295 =C4=85  4%  stress-ng.fanotif=
y.ops_per_sec
>   33565053           -10.9%   29899893 =C4=85  3%  stress-ng.time.file_sy=
stem_outputs
>      19487 =C4=85  3%     -19.0%      15787 =C4=85  3%  stress-ng.time.in=
voluntary_context_switches
>      10868            -1.0%      10755        stress-ng.time.minor_page_f=
aults
>       1648            -1.9%       1618        stress-ng.time.percent_of_c=
pu_this_job_got
>       1014            -1.6%     998.53        stress-ng.time.system_time
>      38378 =C4=85 97%    +280.5%     146045 =C4=85  7%  stress-ng.time.vo=
luntary_context_switches
>      18.19            -3.9%      17.48 =C4=85  2%  iostat.cpu.system
>       0.96 =C4=85  6%      -0.2        0.72 =C4=85  8%  mpstat.cpu.all.so=
ft%
>       0.21            -0.0        0.18 =C4=85  6%  mpstat.cpu.all.usr%
>     191.47            -2.3%     187.06        turbostat.PkgWatt
>      91.25            -1.4%      89.97        turbostat.RAMWatt
>       3494 =C4=85 39%     +55.6%       5438        vmstat.memory.buff
>       3805 =C4=85 30%     +81.6%       6909 =C4=85  3%  vmstat.system.cs
>     509.50           +23.4%     628.50 =C4=85 18%  interrupts.CPU53.CAL:F=
unction_call_interrupts
>       3119 =C4=85 44%     -62.8%       1159 =C4=85 38%  interrupts.CPU62.=
NMI:Non-maskable_interrupts
>       3119 =C4=85 44%     -62.8%       1159 =C4=85 38%  interrupts.CPU62.=
PMI:Performance_monitoring_interrupts
>       4580 =C4=85106%    +357.3%      20942 =C4=85 38%  numa-meminfo.node=
0.Dirty
>       4290 =C4=85109%    +363.2%      19873 =C4=85 36%  numa-meminfo.node=
0.Inactive(file)
>       5634 =C4=85 74%    +364.1%      26149 =C4=85 25%  numa-meminfo.node=
1.Dirty
>       4728 =C4=85 75%    +406.7%      23958 =C4=85 25%  numa-meminfo.node=
1.Inactive(file)
>      52712 =C4=85 12%     +28.6%      67787 =C4=85  8%  numa-meminfo.node=
1.KReclaimable
>      52712 =C4=85 12%     +28.6%      67787 =C4=85  8%  numa-meminfo.node=
1.SReclaimable
>      15433 =C4=85  7%     +15.2%      17772 =C4=85  2%  meminfo.Active
>       3658 =C4=85 37%     +52.2%       5568        meminfo.Active(file)
>       3490 =C4=85 39%     +55.6%       5431        meminfo.Buffers
>      10124 =C4=85 75%    +366.6%      47241 =C4=85 15%  meminfo.Dirty
>     314459 =C4=85  2%     +12.9%     354928        meminfo.Inactive
>       8907 =C4=85 77%    +393.4%      43949 =C4=85 15%  meminfo.Inactive(=
file)
>     107422           +16.4%     124988 =C4=85  2%  meminfo.KReclaimable
>     107422           +16.4%     124988 =C4=85  2%  meminfo.SReclaimable
>       1110 =C4=85111%    +368.9%       5205 =C4=85 38%  numa-vmstat.node0=
.nr_dirty
>       1046 =C4=85114%    +372.2%       4940 =C4=85 36%  numa-vmstat.node0=
.nr_inactive_file
>       1048 =C4=85113%    +371.4%       4941 =C4=85 36%  numa-vmstat.node0=
.nr_zone_inactive_file
>       1138 =C4=85110%    +360.2%       5241 =C4=85 38%  numa-vmstat.node0=
.nr_zone_write_pending
>       1385 =C4=85 78%    +368.3%       6486 =C4=85 25%  numa-vmstat.node1=
.nr_dirty
>       1155 =C4=85 81%    +413.4%       5933 =C4=85 25%  numa-vmstat.node1=
.nr_inactive_file
>      13198 =C4=85 12%     +28.1%      16909 =C4=85  8%  numa-vmstat.node1=
.nr_slab_reclaimable
>       1154 =C4=85 81%    +413.8%       5933 =C4=85 25%  numa-vmstat.node1=
.nr_zone_inactive_file
>       1409 =C4=85 78%    +362.8%       6523 =C4=85 25%  numa-vmstat.node1=
.nr_zone_write_pending
>       8001 =C4=85  4%     +18.4%       9476 =C4=85  6%  softirqs.CPU3.SCH=
ED
>       7965 =C4=85  6%     +16.4%       9273 =C4=85  7%  softirqs.CPU54.SC=
HED
>       7857 =C4=85  6%     +18.4%       9306 =C4=85  6%  softirqs.CPU58.SC=
HED
>       7971 =C4=85  5%     +14.0%       9085 =C4=85  5%  softirqs.CPU62.SC=
HED
>       7773 =C4=85  5%     +16.7%       9072 =C4=85  7%  softirqs.CPU64.SC=
HED
>       9103 =C4=85 18%     -33.4%       6060 =C4=85 26%  softirqs.CPU71.RC=
U
>       7936 =C4=85  7%     +17.7%       9341 =C4=85  7%  softirqs.CPU71.SC=
HED
>       8074 =C4=85 35%     -50.5%       3997 =C4=85 17%  softirqs.CPU77.RC=
U
>       7813 =C4=85  6%     +15.7%       9036 =C4=85  7%  softirqs.CPU8.SCH=
ED
>     934447 =C4=85  2%     -10.4%     836914 =C4=85  2%  softirqs.RCU
>     914.67 =C4=85 37%     +52.2%       1392        proc-vmstat.nr_active_=
file
>    4196621           -10.9%    3740233 =C4=85  3%  proc-vmstat.nr_dirtied
>       2530 =C4=85 75%    +364.4%      11749 =C4=85 15%  proc-vmstat.nr_di=
rty
>     273393            +3.5%     282850        proc-vmstat.nr_file_pages
>       2239 =C4=85 76%    +388.3%      10932 =C4=85 15%  proc-vmstat.nr_in=
active_file
>      26824           +16.3%      31185 =C4=85  3%  proc-vmstat.nr_slab_re=
claimable
>       1550 =C4=85 27%    +249.9%       5424 =C4=85 40%  proc-vmstat.nr_wr=
itten
>     914.67 =C4=85 37%     +52.2%       1392        proc-vmstat.nr_zone_ac=
tive_file
>       2239 =C4=85 76%    +388.3%      10932 =C4=85 15%  proc-vmstat.nr_zo=
ne_inactive_file
>       2547 =C4=85 77%    +363.4%      11805 =C4=85 15%  proc-vmstat.nr_zo=
ne_write_pending
>    8695504           -15.1%    7378817 =C4=85  3%  proc-vmstat.numa_hit
>    8608986           -15.3%    7292304 =C4=85  3%  proc-vmstat.numa_local
>   13559136           -18.5%   11047582 =C4=85  4%  proc-vmstat.pgalloc_no=
rmal
>   13417362           -18.7%   10904217 =C4=85  4%  proc-vmstat.pgfree
>      27913 =C4=85  8%     +37.7%      38440 =C4=85 10%  slabinfo.buffer_h=
ead.active_objs
>     726.67 =C4=85  7%     +37.7%       1000 =C4=85  9%  slabinfo.buffer_h=
ead.active_slabs
>      28355 =C4=85  7%     +37.7%      39043 =C4=85  9%  slabinfo.buffer_h=
ead.num_objs
>     726.67 =C4=85  7%     +37.7%       1000 =C4=85  9%  slabinfo.buffer_h=
ead.num_slabs
>     107206           +11.6%     119642 =C4=85  2%  slabinfo.dentry.active=
_objs
>       2593           +11.1%       2881 =C4=85  2%  slabinfo.dentry.active=
_slabs
>     108962           +11.1%     121015 =C4=85  2%  slabinfo.dentry.num_ob=
js
>       2593           +11.1%       2881 =C4=85  2%  slabinfo.dentry.num_sl=
abs
>      66688 =C4=85  9%     +31.8%      87926 =C4=85  8%  slabinfo.ext4_ext=
ent_status.active_objs
>     655.00 =C4=85  9%     +31.8%     863.17 =C4=85  8%  slabinfo.ext4_ext=
ent_status.active_slabs
>      66862 =C4=85  9%     +31.8%      88097 =C4=85  8%  slabinfo.ext4_ext=
ent_status.num_objs
>     655.00 =C4=85  9%     +31.8%     863.17 =C4=85  8%  slabinfo.ext4_ext=
ent_status.num_slabs
>      11791 =C4=85 11%     +79.3%      21139 =C4=85  8%  slabinfo.ext4_ino=
de_cache.active_objs
>     440.17 =C4=85 11%     +85.2%     815.00 =C4=85  9%  slabinfo.ext4_ino=
de_cache.active_slabs
>      11889 =C4=85 11%     +85.2%      22019 =C4=85  9%  slabinfo.ext4_ino=
de_cache.num_objs
>     440.17 =C4=85 11%     +85.2%     815.00 =C4=85  9%  slabinfo.ext4_ino=
de_cache.num_slabs
>       1428 =C4=85 25%     +41.9%       2027 =C4=85  5%  slabinfo.jbd2_jou=
rnal_head.active_objs
>       1428 =C4=85 25%     +41.9%       2027 =C4=85  5%  slabinfo.jbd2_jou=
rnal_head.num_objs
>       6756 =C4=85 15%     +41.1%       9536 =C4=85  3%  slabinfo.kmalloc-=
rcl-512.active_objs
>       6792 =C4=85 15%     +42.1%       9649 =C4=85  3%  slabinfo.kmalloc-=
rcl-512.num_objs
>      72015 =C4=85  5%     +15.2%      82951 =C4=85  4%  slabinfo.vmap_are=
a.active_objs
>       1129 =C4=85  5%     +16.2%       1312 =C4=85  4%  slabinfo.vmap_are=
a.active_slabs
>      72353 =C4=85  5%     +16.2%      84046 =C4=85  4%  slabinfo.vmap_are=
a.num_objs
>       1129 =C4=85  5%     +16.2%       1312 =C4=85  4%  slabinfo.vmap_are=
a.num_slabs
>  4.537e+09           -13.0%  3.948e+09 =C4=85  4%  perf-stat.i.branch-ins=
tructions
>   34409487           -12.1%   30235678 =C4=85  2%  perf-stat.i.branch-mis=
ses
>      34.06 =C4=85  2%      -2.4       31.67 =C4=85  2%  perf-stat.i.cache=
-miss-rate%
>   85290547 =C4=85  3%     -12.7%   74474324 =C4=85  5%  perf-stat.i.cache=
-misses
>       3674 =C4=85 32%     +88.6%       6931 =C4=85  3%  perf-stat.i.conte=
xt-switches
>       2.35           +12.2%       2.64 =C4=85  4%  perf-stat.i.cpi
>  5.242e+10            -3.5%  5.057e+10        perf-stat.i.cpu-cycles
>     224.46            -9.4%     203.26 =C4=85  2%  perf-stat.i.cpu-migrat=
ions
>     656.95 =C4=85  2%     +12.4%     738.24 =C4=85  5%  perf-stat.i.cycle=
s-between-cache-misses
>     300745 =C4=85 11%     +53.4%     461361 =C4=85 19%  perf-stat.i.dTLB-=
load-misses
>  6.438e+09           -13.9%  5.543e+09 =C4=85  4%  perf-stat.i.dTLB-loads
>     161739 =C4=85  7%     +14.6%     185423 =C4=85  6%  perf-stat.i.dTLB-=
store-misses
>  3.536e+09           -15.4%  2.991e+09 =C4=85  4%  perf-stat.i.dTLB-store=
s
>      88.81            -1.9       86.94        perf-stat.i.iTLB-load-miss-=
rate%
>   20384992 =C4=85  2%     -14.5%   17430423 =C4=85  4%  perf-stat.i.iTLB-=
load-misses
>  2.218e+10           -13.3%  1.923e+10 =C4=85  4%  perf-stat.i.instructio=
ns
>       0.43            -9.5%       0.39 =C4=85  3%  perf-stat.i.ipc
>       0.55            -3.5%       0.53        perf-stat.i.metric.GHz
>     612.45 =C4=85  2%     -11.7%     540.91        perf-stat.i.metric.K/s=
ec
>     153.67           -13.9%     132.37 =C4=85  4%  perf-stat.i.metric.M/s=
ec
>      88.26            -1.5       86.78        perf-stat.i.node-load-miss-=
rate%
>   31264969 =C4=85  3%     -14.5%   26719326 =C4=85  3%  perf-stat.i.node-=
load-misses
>      82.85            -2.5       80.30        perf-stat.i.node-store-miss=
-rate%
>   16368326 =C4=85  3%     -16.1%   13725763 =C4=85  2%  perf-stat.i.node-=
store-misses
>      11.08 =C4=85  2%      +7.9%      11.95 =C4=85  5%  perf-stat.overall=
.MPKI
>      34.71 =C4=85  2%      -2.3       32.43 =C4=85  2%  perf-stat.overall=
.cache-miss-rate%
>       2.36           +11.4%       2.63 =C4=85  2%  perf-stat.overall.cpi
>       0.00 =C4=85 12%      +0.0        0.01 =C4=85 25%  perf-stat.overall=
.dTLB-load-miss-rate%
>       0.00 =C4=85  8%      +0.0        0.01 =C4=85  9%  perf-stat.overall=
.dTLB-store-miss-rate%
>      90.08            -1.6       88.49        perf-stat.overall.iTLB-load=
-miss-rate%
>       0.42           -10.2%       0.38 =C4=85  2%  perf-stat.overall.ipc
>      84.44            -2.2       82.27        perf-stat.overall.node-stor=
e-miss-rate%
>  4.465e+09           -13.0%  3.886e+09 =C4=85  4%  perf-stat.ps.branch-in=
structions
>   33856926           -12.1%   29757385 =C4=85  2%  perf-stat.ps.branch-mi=
sses
>   83927962 =C4=85  3%     -12.7%   73296150 =C4=85  5%  perf-stat.ps.cach=
e-misses
>       3620 =C4=85 31%     +88.4%       6819 =C4=85  4%  perf-stat.ps.cont=
ext-switches
>  5.158e+10            -3.5%  4.977e+10        perf-stat.ps.cpu-cycles
>     221.03            -9.5%     200.02 =C4=85  2%  perf-stat.ps.cpu-migra=
tions
>     295389 =C4=85 11%     +53.7%     454026 =C4=85 19%  perf-stat.ps.dTLB=
-load-misses
>  6.336e+09           -13.9%  5.456e+09 =C4=85  4%  perf-stat.ps.dTLB-load=
s
>     159067 =C4=85  7%     +14.7%     182479 =C4=85  6%  perf-stat.ps.dTLB=
-store-misses
>   3.48e+09           -15.4%  2.944e+09 =C4=85  4%  perf-stat.ps.dTLB-stor=
es
>   20061765 =C4=85  2%     -14.5%   17156375 =C4=85  4%  perf-stat.ps.iTLB=
-load-misses
>  2.183e+10           -13.3%  1.893e+10 =C4=85  4%  perf-stat.ps.instructi=
ons
>   30762758 =C4=85  3%     -14.5%   26295053 =C4=85  3%  perf-stat.ps.node=
-load-misses
>   16104244 =C4=85  3%     -16.1%   13507363 =C4=85  2%  perf-stat.ps.node=
-store-misses
>  1.377e+12 =C4=85  2%     -12.2%   1.21e+12 =C4=85  2%  perf-stat.total.i=
nstructions
>       2.87 =C4=85 11%      -0.7        2.18 =C4=85 11%  perf-profile.call=
trace.cycles-pp.ret_from_fork
>       2.87 =C4=85 11%      -0.7        2.18 =C4=85 11%  perf-profile.call=
trace.cycles-pp.kthread.ret_from_fork
>       2.85 =C4=85 11%      -0.7        2.16 =C4=85 11%  perf-profile.call=
trace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork
>       2.84 =C4=85 11%      -0.7        2.15 =C4=85 11%  perf-profile.call=
trace.cycles-pp.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn.k=
thread.ret_from_fork
>       2.84 =C4=85 11%      -0.7        2.15 =C4=85 11%  perf-profile.call=
trace.cycles-pp.rcu_core.__softirqentry_text_start.run_ksoftirqd.smpboot_th=
read_fn.kthread
>       2.84 =C4=85 11%      -0.7        2.15 =C4=85 11%  perf-profile.call=
trace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
>       2.83 =C4=85 11%      -0.7        2.15 =C4=85 11%  perf-profile.call=
trace.cycles-pp.rcu_do_batch.rcu_core.__softirqentry_text_start.run_ksoftir=
qd.smpboot_thread_fn
>       2.50 =C4=85 10%      -0.6        1.88 =C4=85 11%  perf-profile.call=
trace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.__softirqentry_text_s=
tart.run_ksoftirqd
>       2.26 =C4=85 10%      -0.6        1.69 =C4=85 14%  perf-profile.call=
trace.cycles-pp.kmem_cache_free.fanotify_read.vfs_read.ksys_read.do_syscall=
_64
>       1.79 =C4=85 12%      -0.5        1.30 =C4=85 14%  perf-profile.call=
trace.cycles-pp.kmem_cache_alloc.__alloc_file.alloc_empty_file.dentry_open.=
copy_event_to_user
>       1.74 =C4=85  9%      -0.5        1.26 =C4=85 13%  perf-profile.call=
trace.cycles-pp.fanotify_free_event.fanotify_read.vfs_read.ksys_read.do_sys=
call_64
>       1.58 =C4=85 12%      -0.4        1.18 =C4=85 11%  perf-profile.call=
trace.cycles-pp._raw_spin_lock.fanotify_read.vfs_read.ksys_read.do_syscall_=
64
>       1.43 =C4=85  8%      -0.4        1.03 =C4=85 29%  perf-profile.call=
trace.cycles-pp.lockref_get.fanotify_alloc_event.fanotify_handle_event.fsno=
tify.__fsnotify_parent
>       2.19 =C4=85  7%      -0.4        1.83 =C4=85  6%  perf-profile.call=
trace.cycles-pp.fanotify_alloc_event.fanotify_handle_event.fsnotify.__fsnot=
ify_parent.__fput
>       0.71 =C4=85 11%      -0.3        0.37 =C4=85 70%  perf-profile.call=
trace.cycles-pp.put_pid.fanotify_free_event.fanotify_read.vfs_read.ksys_rea=
d
>       2.14 =C4=85  7%      -0.3        1.80 =C4=85  7%  perf-profile.call=
trace.cycles-pp.kmem_cache_alloc.fanotify_alloc_event.fanotify_handle_event=
.fsnotify.__fsnotify_parent
>       1.17 =C4=85 10%      -0.3        0.85 =C4=85 12%  perf-profile.call=
trace.cycles-pp.ext4_file_open.do_dentry_open.dentry_open.copy_event_to_use=
r.fanotify_read
>       2.37 =C4=85  8%      -0.3        2.07 =C4=85  6%  perf-profile.call=
trace.cycles-pp.fanotify_alloc_event.fanotify_handle_event.fsnotify.__fsnot=
ify_parent.do_sys_openat2
>       0.98 =C4=85  9%      -0.3        0.72 =C4=85 14%  perf-profile.call=
trace.cycles-pp.path_put.fanotify_free_event.fanotify_read.vfs_read.ksys_re=
ad
>       0.96 =C4=85  9%      -0.3        0.71 =C4=85 14%  perf-profile.call=
trace.cycles-pp.dput.path_put.fanotify_free_event.fanotify_read.vfs_read
>       0.90 =C4=85  9%      -0.3        0.65 =C4=85 13%  perf-profile.call=
trace.cycles-pp.fscrypt_file_open.ext4_file_open.do_dentry_open.dentry_open=
.copy_event_to_user
>       0.84 =C4=85  8%      -0.2        0.60 =C4=85 14%  perf-profile.call=
trace.cycles-pp.lockref_put_return.dput.path_put.fanotify_free_event.fanoti=
fy_read
>       0.80 =C4=85  7%      -0.2        0.60 =C4=85  9%  perf-profile.call=
trace.cycles-pp.refill_obj_stock.kmem_cache_free.rcu_do_batch.rcu_core.__so=
ftirqentry_text_start
>       0.87 =C4=85 15%      -0.2        0.68 =C4=85 10%  perf-profile.call=
trace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.fanotify_re=
ad.vfs_read.ksys_read
>       0.89 =C4=85  7%      -0.1        0.76 =C4=85  8%  perf-profile.call=
trace.cycles-pp.fanotify_alloc_event.fanotify_handle_event.fsnotify.__fsnot=
ify_parent.vfs_write
>       0.72 =C4=85  9%      -0.1        0.60 =C4=85  5%  perf-profile.call=
trace.cycles-pp._raw_spin_lock_irqsave.__wake_up_common_lock.fsnotify_add_e=
vent.fanotify_handle_event.fsnotify
>       0.75 =C4=85  6%      -0.1        0.63 =C4=85  8%  perf-profile.call=
trace.cycles-pp.fanotify_alloc_event.fanotify_handle_event.fsnotify.__fsnot=
ify_parent.vfs_read
>       0.11 =C4=85223%      +0.7        0.83 =C4=85 24%  perf-profile.call=
trace.cycles-pp.fanotify_merge.fsnotify_add_event.fanotify_handle_event.fsn=
otify.__fsnotify_parent
>       4.92 =C4=85 15%      +1.7        6.61 =C4=85 16%  perf-profile.call=
trace.cycles-pp.fsnotify_add_event.fanotify_handle_event.fsnotify.__fsnotif=
y_parent.do_sys_openat2
>       5.69 =C4=85 22%      +3.1        8.80 =C4=85 23%  perf-profile.call=
trace.cycles-pp._raw_spin_lock.fsnotify_add_event.fanotify_handle_event.fsn=
otify.__fsnotify_parent
>       4.00 =C4=85 37%      +3.6        7.60 =C4=85 26%  perf-profile.call=
trace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.fsnotify_ad=
d_event.fanotify_handle_event.fsnotify
>       0.00            +4.0        4.02 =C4=85 12%  perf-profile.calltrace=
.cycles-pp.apparmor_capable.security_capable.ns_capable_common.copy_event_t=
o_user.fanotify_read
>       0.00            +4.1        4.07 =C4=85 12%  perf-profile.calltrace=
.cycles-pp.security_capable.ns_capable_common.copy_event_to_user.fanotify_r=
ead.vfs_read
>       0.00            +4.1        4.14 =C4=85 12%  perf-profile.calltrace=
.cycles-pp.ns_capable_common.copy_event_to_user.fanotify_read.vfs_read.ksys=
_read
>       7.67 =C4=85  9%      -1.7        5.97 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.kmem_cache_free
>       5.74 =C4=85  7%      -1.2        4.59 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.kmem_cache_alloc
>       4.27 =C4=85 11%      -0.9        3.36 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.rcu_core
>       6.23 =C4=85  7%      -0.9        5.32 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.fanotify_alloc_event
>       4.26 =C4=85 11%      -0.9        3.35 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.rcu_do_batch
>       4.38 =C4=85 10%      -0.9        3.48 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.__softirqentry_text_start
>       1.09 =C4=85 13%      -0.7        0.35 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.alloc_fd
>       2.87 =C4=85 11%      -0.7        2.18 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.ret_from_fork
>       2.87 =C4=85 11%      -0.7        2.18 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.kthread
>       2.85 =C4=85 11%      -0.7        2.16 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.smpboot_thread_fn
>       2.84 =C4=85 11%      -0.7        2.15 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.run_ksoftirqd
>       1.94 =C4=85  8%      -0.5        1.42 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.get_obj_cgroup_from_current
>       2.52 =C4=85  9%      -0.5        2.01 =C4=85  6%  perf-profile.chil=
dren.cycles-pp._raw_spin_lock_irqsave
>       3.38 =C4=85  9%      -0.5        2.88 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.__wake_up_common_lock
>       1.64 =C4=85  8%      -0.4        1.28 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.refill_obj_stock
>       1.30 =C4=85 11%      -0.3        0.98 =C4=85 12%  perf-profile.chil=
dren.cycles-pp.ext4_file_open
>       1.53 =C4=85  8%      -0.3        1.23 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.path_put
>       0.97 =C4=85  9%      -0.3        0.72 =C4=85 12%  perf-profile.chil=
dren.cycles-pp.fscrypt_file_open
>       0.92 =C4=85  7%      -0.2        0.71 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.drain_obj_stock
>       0.58 =C4=85  9%      -0.2        0.39 =C4=85 10%  perf-profile.chil=
dren.cycles-pp.dget_parent
>       0.55 =C4=85  9%      -0.2        0.36 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.lockref_get_not_zero
>       0.34 =C4=85 25%      -0.1        0.22 =C4=85 12%  perf-profile.chil=
dren.cycles-pp.pid_vnr
>       0.20 =C4=85 15%      -0.1        0.14 =C4=85 15%  perf-profile.chil=
dren.cycles-pp.fsnotify_peek_first_event
>       0.25 =C4=85 13%      -0.1        0.20 =C4=85 15%  perf-profile.chil=
dren.cycles-pp.call_rcu
>       0.26 =C4=85  9%      -0.1        0.20 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.page_counter_try_charge
>       0.22 =C4=85 12%      -0.1        0.17 =C4=85 15%  perf-profile.chil=
dren.cycles-pp.kmem_cache_alloc_trace
>       0.24 =C4=85 12%      -0.1        0.19 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.fanotify_insert_event
>       0.19 =C4=85 10%      -0.1        0.13 =C4=85 17%  perf-profile.chil=
dren.cycles-pp.close_fd
>       0.23 =C4=85  8%      -0.0        0.19 =C4=85 13%  perf-profile.chil=
dren.cycles-pp.syscall_return_via_sysret
>       0.15 =C4=85 10%      -0.0        0.11 =C4=85 18%  perf-profile.chil=
dren.cycles-pp.pick_file
>       0.13 =C4=85 14%      -0.0        0.10 =C4=85 18%  perf-profile.chil=
dren.cycles-pp.propagate_protected_usage
>       0.08 =C4=85 10%      -0.0        0.05 =C4=85 46%  perf-profile.chil=
dren.cycles-pp.fanotify_free_group_priv
>       0.16 =C4=85  9%      -0.0        0.13 =C4=85  9%  perf-profile.chil=
dren.cycles-pp.rcu_all_qs
>       0.09 =C4=85 13%      -0.0        0.06 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.__fsnotify_alloc_group
>       0.07 =C4=85 11%      -0.0        0.04 =C4=85 45%  perf-profile.chil=
dren.cycles-pp.alloc_page_buffers
>       0.11 =C4=85 11%      -0.0        0.09 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.try_to_free_buffers
>       0.10 =C4=85  8%      -0.0        0.08 =C4=85 12%  perf-profile.chil=
dren.cycles-pp.create_empty_buffers
>       0.07 =C4=85  7%      -0.0        0.04 =C4=85 45%  perf-profile.chil=
dren.cycles-pp.alloc_buffer_head
>       0.08 =C4=85 14%      -0.0        0.06 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.__srcu_read_lock
>       0.09 =C4=85 11%      -0.0        0.07 =C4=85 17%  perf-profile.chil=
dren.cycles-pp.rcu_segcblist_enqueue
>       0.19 =C4=85 60%      +0.3        0.48 =C4=85 30%  perf-profile.chil=
dren.cycles-pp.__x64_sys_ioctl
>       0.19 =C4=85 61%      +0.3        0.48 =C4=85 30%  perf-profile.chil=
dren.cycles-pp.do_vfs_ioctl
>       0.19 =C4=85 61%      +0.3        0.48 =C4=85 30%  perf-profile.chil=
dren.cycles-pp.fanotify_ioctl
>       0.81 =C4=85 17%      +0.5        1.28 =C4=85 15%  perf-profile.chil=
dren.cycles-pp.fanotify_merge
>       5.66 =C4=85 22%      +3.0        8.69 =C4=85 23%  perf-profile.chil=
dren.cycles-pp.native_queued_spin_lock_slowpath
>       0.23 =C4=85  9%      +4.0        4.21 =C4=85 12%  perf-profile.chil=
dren.cycles-pp.apparmor_capable
>       0.24 =C4=85  9%      +4.0        4.26 =C4=85 12%  perf-profile.chil=
dren.cycles-pp.security_capable
>       0.24 =C4=85  8%      +4.1        4.33 =C4=85 11%  perf-profile.chil=
dren.cycles-pp.ns_capable_common
>       4.85 =C4=85  9%      -1.1        3.72 =C4=85 11%  perf-profile.self=
.cycles-pp.kmem_cache_free
>       3.49 =C4=85  9%      -1.1        2.43 =C4=85  9%  perf-profile.self=
.cycles-pp._raw_spin_lock
>       1.81 =C4=85  8%      -0.5        1.32 =C4=85  9%  perf-profile.self=
.cycles-pp.get_obj_cgroup_from_current
>       2.04 =C4=85  6%      -0.5        1.57 =C4=85 11%  perf-profile.self=
.cycles-pp.kmem_cache_alloc
>       2.24 =C4=85  9%      -0.5        1.78 =C4=85  6%  perf-profile.self=
.cycles-pp._raw_spin_lock_irqsave
>       0.97 =C4=85  9%      -0.2        0.73 =C4=85 11%  perf-profile.self=
.cycles-pp.do_dentry_open
>       0.51 =C4=85  9%      -0.2        0.33 =C4=85 10%  perf-profile.self=
.cycles-pp.lockref_get_not_zero
>       0.68 =C4=85  9%      -0.1        0.54 =C4=85  9%  perf-profile.self=
.cycles-pp.refill_obj_stock
>       0.84 =C4=85  9%      -0.1        0.70 =C4=85  7%  perf-profile.self=
.cycles-pp.__wake_up_common
>       0.55 =C4=85  6%      -0.1        0.41 =C4=85 11%  perf-profile.self=
.cycles-pp.drain_obj_stock
>       0.33 =C4=85 25%      -0.1        0.21 =C4=85 12%  perf-profile.self=
.cycles-pp.pid_vnr
>       0.30 =C4=85  9%      -0.1        0.23 =C4=85 11%  perf-profile.self=
.cycles-pp.dput
>       0.33 =C4=85 11%      -0.1        0.26 =C4=85 12%  perf-profile.self=
.cycles-pp.page_counter_cancel
>       0.19 =C4=85 15%      -0.1        0.13 =C4=85 12%  perf-profile.self=
.cycles-pp.fsnotify_peek_first_event
>       0.24 =C4=85 11%      -0.1        0.19 =C4=85  8%  perf-profile.self=
.cycles-pp.fanotify_insert_event
>       0.13 =C4=85 14%      -0.1        0.08 =C4=85 16%  perf-profile.self=
.cycles-pp.alloc_fd
>       0.23 =C4=85  8%      -0.0        0.19 =C4=85 13%  perf-profile.self=
.cycles-pp.syscall_return_via_sysret
>       0.10 =C4=85 15%      -0.0        0.07 =C4=85  7%  perf-profile.self=
.cycles-pp.fanotify_read
>       0.14 =C4=85  9%      -0.0        0.11 =C4=85 12%  perf-profile.self=
.cycles-pp.exit_to_user_mode_prepare
>       0.09 =C4=85 11%      -0.0        0.07 =C4=85 17%  perf-profile.self=
.cycles-pp.rcu_segcblist_enqueue
>       0.12 =C4=85 16%      +0.1        0.18 =C4=85 16%  perf-profile.self=
.cycles-pp.___slab_alloc
>       0.00            +0.1        0.07 =C4=85 14%  perf-profile.self.cycl=
es-pp.ns_capable_common
>       0.00            +0.2        0.18 =C4=85 24%  perf-profile.self.cycl=
es-pp.try_to_wake_up
>       0.17 =C4=85 63%      +0.3        0.46 =C4=85 30%  perf-profile.self=
.cycles-pp.fanotify_ioctl
>       0.79 =C4=85 17%      +0.5        1.27 =C4=85 15%  perf-profile.self=
.cycles-pp.fanotify_merge
>       5.56 =C4=85 22%      +3.0        8.59 =C4=85 23%  perf-profile.self=
.cycles-pp.native_queued_spin_lock_slowpath
>       0.22 =C4=85  9%      +3.9        4.08 =C4=85 11%  perf-profile.self=
.cycles-pp.apparmor_capable
>
>
>
>                             stress-ng.fanotify.ops_per_sec
>
>   2.2e+06 +--------------------------------------------------------------=
---+
>           | +.    : +         .+.      .+.+.+.+.+.+..+.                  =
   |
>   2.1e+06 |-+ +   :  +.     .+   +..+.+                +.+     +.+.+..+  =
   |
>     2e+06 |-+  + :     +.+.+                              +   +          =
   |
>           |     +                                          +.+           =
   |
>   1.9e+06 |-+                                                            =
   |
>   1.8e+06 |-+                                                            =
   |
>           |                                                              =
   |
>   1.7e+06 |-+                                                            =
   |
>   1.6e+06 |-+                                                         O  =
   |
>           |                             O                          O     =
 O |
>   1.5e+06 |-+              O   O    O O                O     O          O=
   |
>   1.4e+06 |-+        O O O   O   O        O O O   O  O   O O   O O       =
   |
>           | O O O  O                            O                        =
   |
>   1.3e+06 +--------------------------------------------------------------=
---+
>
>
> [*] bisect-good sample
> [O] bisect-bad  sample
>
>
>
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are prov=
ided
> for informational purposes only. Any difference in system hardware or sof=
tware
> design or configuration may affect actual performance.
>
>
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Ce=
nter
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corpora=
tion
>
> Thanks,
> Oliver Sang
>
