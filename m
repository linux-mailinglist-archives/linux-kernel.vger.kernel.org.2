Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4F24277A4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 07:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244266AbhJIFpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 01:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbhJIFpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 01:45:18 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E56BC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 22:43:19 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id b12so3523124qtq.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 22:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edi.works; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R1b6LRnDgw4MXgnqL8ApMyFBNf+HWB+MOQp9ynyp86Q=;
        b=Xwz0/FiEnkJdoNRxntzjBQc0Gm3a1pMvmW4rJ/VSan9bUkANBa8mnhQrPpTuGc0Hae
         8CKOaacVHDcYNUMJQFgQD534oCqNmai1pLLiTVPnZ4cWEVJwArNfkY73kb0XyZo41D+F
         Re7wlKk2DZd5JyjQS9qbCV0Zv0ZJs2U1OpAOJEX+Tpy1Qep/sHjRtrnhK+TAM2WxAPui
         f2/ZMviteTrkP6MkVvrBa2n9dgRQl9+kEC7v4zjfh253YkytvYNWFvblp3AzR5xxFxc1
         vOxYItPXxuJe9RKIuMpMtPUX47N9auwSnFl1gCSrqIrTBrKHKiQpUxBZZRpsLKmKXoNT
         Ra1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R1b6LRnDgw4MXgnqL8ApMyFBNf+HWB+MOQp9ynyp86Q=;
        b=Owm8wGCPpsOm0XiQP7IzQP6t5a6FlVsWc9IooTmSZZbwqzzqw6JNeK3dO/6n0d46pN
         JO0+iJfBYaDsY0I+MB6Outg+by4g7CzdVaLV3M3qZ4d1+I71g36hfrhls5z52fESOrIl
         OgiPZv6i1o9E/1ZVbFVOzr0rshKl4R7mjT9h8Gq0qpgGm613OKQ1vqUcc9HhazLl5omP
         GvmXB3VGYhZwQbcEyYfILca3bX5f0v9y0uHCOT1BXzDSEL8xZbcirHx7V2lwxVk3P/Zc
         ffb03C3ergfJx8zgmPwOIhF4KO8qF0CQTucj3WunSsh4/md+U804t2EpKfBdmPhDK7jH
         i4Uw==
X-Gm-Message-State: AOAM533KkikHfuRAMUyLmtf7jaz9hLsnsWxd/kn02wZXaPO/+L6UvdLB
        57Jj1qoR8wL/JeuxP2+G4iPejg==
X-Google-Smtp-Source: ABdhPJyhJjm+JmkYPHf2Z7h4TM+aA7Ak9oB7tciu7UAheWRLg4EpDJMCE5h16KIxP85tql1QpPeCdA==
X-Received: by 2002:ac8:4e92:: with SMTP id 18mr2318782qtp.323.1633758198507;
        Fri, 08 Oct 2021 22:43:18 -0700 (PDT)
Received: from localhost.localdomain (c-67-169-44-201.hsd1.ca.comcast.net. [67.169.44.201])
        by smtp.gmail.com with ESMTPSA id t64sm1063783qkd.71.2021.10.08.22.43.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Oct 2021 22:43:17 -0700 (PDT)
From:   bot@edi.works
To:     yuzhao@google.com
Cc:     hdanton@sina.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, corbet@lwn.net,
        michael@michaellarabel.com, sofia.trinh@edi.works
Subject: Re: [PATCH v4 00/11] Multigenerational LRU Framework
Date:   Fri,  8 Oct 2021 22:43:15 -0700
Message-Id: <20211009054315.47073-1-bot@edi.works>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210818063107.2696454-1-yuzhao@google.com>
References: <20210818063107.2696454-1-yuzhao@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel / MariaDB benchmark with MGLRU

TLDR
====
With the MGLRU, MariaDB achieved 95% CIs [5.24, 10.71]% and [20.22,
25.97]% more transactions per minute (TPM), respectively, under the
medium- and high-concurrency conditions when slightly overcommitting
memory. There were no statistically significant changes in TPM under
other conditions.

Rationale
=========
Memory overcommit can improve utilization and, if not overdone, can
also increase throughput. The challenges are estimating working sets
and optimizing page reclaim. The risks are performance degradations
and OOM kills. Unless overcoming the challenges, the only way to
reduce the risks is to overprovision memory.

MariaDB is one of the most popular open-source RDBMSs. HammerDB is
the leading open-source benchmarking software derived from the TPC
specifications. OLTP is the most important use case for RDBMSs.

Matrix
======
Kernels: version [+ patchset]
* Baseline: 5.14
* Patched: 5.14 + MGLRU

Memory conditions: % of memory size
* Underutilizing: ~10% on inactive file list
* Overcommitting: ~10% swapped out

Concurrency conditions: average # of users per CPU
* Low: ~3
* Medium: ~13
* High: ~19

Total configurations: 12
Data points per configuration: 10
Total run duration (minutes) per data point: ~45

Procedure
=========
The latest MGLRU patchset for the 5.14 kernel is available at
git fetch https://linux-mm.googlesource.com/page-reclaim \
  refs/changes/30/1430/1

Baseline and patched 5.14 kernel images are available at
https://drive.google.com/drive/folders/1eMkQleAFGkP2vzM_JyRA21oKE0ESHBqp

<install and configure OS>
hammerdbcli auto prep_tpcc.tcl
systemctl stop mariadb
e2image <backup /mnt/data>

<for each kernel>
    grub2-set-default <baseline / patched>
    <for each memory condition>
        <update /etc/my.cnf>
        <for each concurrency condition>
            <update run_tpcc.tcl>
            <for each data point>
                systemctl stop mariadb
                e2image <restore /mnt/data>
                reboot
                hammerdbcli auto run_tpcc.tcl
                <collect TPM>

Hardware
========
Memory (GB): 64
CPU (total #): 32
NVMe SSD (GB): 1024

OS
==
$ cat /etc/redhat-release
Red Hat Enterprise Linux release 8.4 (Ootpa)

$ cat /proc/swaps
Filename          Type          Size          Used     Priority
/dev/nvme0n1p3    partition     32970748      0          -2

$ mount | grep data
/dev/nvme0n1p4 on /mnt/data type ext4 (rw,relatime,seclabel)

$ cat /proc/cmdline
<existing parameters> systemd.unified_cgroup_hierarchy=1

$ cat /sys/fs/cgroup/user.slice/memory.min
4294967296

$ cat /proc/sys/vm/overcommit_memory
1

MariaDB
=======
$ mysql --version
mysql  Ver 15.1 Distrib 10.3.28-MariaDB, for Linux (x86_64) using
readline 5.1

$ cat /etc/my.cnf
<existing parameters>

[mysqld]
innodb_buffer_pool_size=<50G, 60G>
innodb_doublewrite=0
innodb_flush_log_at_trx_commit=0
innodb_flush_method=O_DIRECT_NO_FSYNC
innodb_flush_neighbors=0
innodb_io_capacity=4000
innodb_io_capacity_max=20000
innodb_log_buffer_size=1G
innodb_log_file_size=20G
innodb_max_dirty_pages_pct=90
innodb_max_dirty_pages_pct_lwm=10
max_connections=1000
datadir=/mnt/data

HammerDB
========
$ hammerdbcli -h
HammerDB CLI v4.2
Copyright (C) 2003-2021 Steve Shaw
Type "help" for a list of commands
Usage: hammerdbcli [ auto [ script_to_autoload.tcl  ] ]

$ cat prep_tpcc.tcl
dbset db maria
diset connection maria_socket /var/lib/mysql/mysql.sock
diset tpcc maria_count_ware 1200
diset tpcc maria_num_vu 32
diset tpcc maria_partition true
buildschema
waittocomplete
quit

$ cat run_tpcc.tcl
dbset db maria
diset connection maria_socket /var/lib/mysql/mysql.sock
diset tpcc maria_total_iterations 20000000
diset tpcc maria_driver timed
diset tpcc maria_rampup 10
diset tpcc maria_duration 30
diset tpcc maria_allwarehouse true
vuset logtotemp 1
vuset unique 1
loadscript
vuset vu <100, 400, 600>
vucreate
vurun
runtimer 3000
Vudestroy

Results
=======
Comparing the patched with the baseline kernel, MariaDB achieved 95%
CIs [5.24, 10.71]% and [20.22, 25.97]% more TPM, respectively, under
the medium- and high-concurrency conditions when slightly
overcommitting memory. There were no statistically significant
changes in TPM under other conditions.

+--------------------+-----------------------+-----------------------+
| Mean TPM [95% CI]  | Underutilizing memory | Overcommitting memory |
+--------------------+-----------------------+-----------------------+
| Low concurrency    | 270811.6 / 271522.7   | 447933.4 / 447283.3   |
|                    | [-40.97, 1463.17]     | [-1330.61, 30.41]     |
+--------------------+-----------------------+-----------------------+
| Medium concurrency | 240212.9 / 242846.7   | 327276.6 / 353372.7   |
|                    | [-2611.38, 7878.98]   | [17149.01, 35043.19]  |
+--------------------+-----------------------+-----------------------+
| High concurrency   | 283897.8 / 283668.1   | 274069.7 / 337366.8   |
|                    | [-11538.08, 11078.68] | [55417.42, 71176.78]  |
+--------------------+-----------------------+-----------------------+
Table 1. Comparison between the baseline and patched kernels

Comparing overcommitting with underutilizing memory, MariaDB achieved
95% CIs [65.12, 65.68]% and [32.45, 40.04]% more TPM, respectively,
under the low- and medium-concurrency conditions when using the
baseline kernel; 95% CIs [64.48, 64.98]%, [43.53, 47.50]% and [16.48,
21.38]% more TPM, respectively, under the low-, medium- and
high-concurrency conditions when using the patched kernel. There were
no statistically significant changes in TPM under other conditions.

+--------------------+------------------------+----------------------+
| Mean TPM [95% CI]  | Baseline kernel        | Patched kernel       |
+--------------------+------------------------+----------------------+
| Low concurrency    | 270811.6 / 447933.4    | 271522.7 / 447283.3  |
|                    | [176362.0, 177881.6]   | [175089.3, 176431.9] |
+--------------------+------------------------+----------------------+
| Medium concurrency | 240212.9 / 327276.6    | 242846.7 / 353372.7  |
|                    | [77946.4, 96181.0]     | [105707.7, 115344.3] |
+--------------------+------------------------+----------------------+
| High concurrency   | 283897.8 / 274069.7    | 283668.1 / 337366.8  |
|                    | [-21605.703, 1949.503] | [46758.85, 60638.55] |
+--------------------+------------------------+----------------------+
Table 2. Comparison between underutilizing and overcommitting memory

Metrics collected during each run are available at
https://github.com/ediworks/KernelPerf/tree/master/mglru/mariadb/5.14

References
==========
HammerDB v4.2 New Features:
https://www.hammerdb.com/blog/uncategorized/hammerdb-v4-2-new-features
-pt1-mariadb-build-and-test-example-with-the-cli/

Appendix
========
$ cat raw_data.r
v <- c(
# baseline 50g 100vu
269531,270113,270256,270367,270393,270630,270707,271373,272291,272455,
# baseline 50g 400vu
231856,234985,235144,235552,238551,239994,244413,245255,247997,248382,
# baseline 50g 600vu
256365,271733,275966,280623,281014,283764,293327,296750,298728,300708,
# baseline 60g 100vu
446973,447383,447412,447489,447874,448046,448123,448531,448739,448764,
# baseline 60g 400vu
312427,312936,313780,321503,329554,330551,332377,333584,337105,348949,
# baseline 60g 600vu
262338,262971,266242,266489,268036,272494,279045,281472,289942,291668,
# patched 50g 100vu
270621,270913,271026,271137,271517,271616,271699,272117,272218,272363,
# patched 50g 400vu
233314,238265,238722,240540,241676,245204,245688,247440,248417,249201,
# patched 50g 600vu
271114,271928,277562,279455,282074,285515,287836,288508,289451,303238,
# patched 60g 100vu
445923,446178,446837,446889,447331,447480,447823,447999,448145,448228,
# patched 60g 400vu
345705,349373,350832,351229,351758,352520,355130,355247,357762,364171,
# patched 60g 600vu
330860,334705,336001,337291,338326,338361,338970,339163,339784,340207
)

a <- array(v, dim = c(10, 3, 2, 2))

# baseline vs patched
for (m in 1:2) {
    for (c in 1:3) {
        r <- t.test(a[, c, m, 1], a[, c, m, 2])
        print(r)

        p <- r$conf.int * 100 / r$estimate[1]
        if ((p[1] > 0 && p[2] < 0) || (p[1] < 0 && p[2] > 0)) {
            s <- sprintf("m%d c%d: no significance", m, c)
        } else {
            s <- sprintf("m%d c%d: [%.2f, %.2f]%%", m, c, -p[2],
-p[1])
        }
        print(s)
    }
}

# 50g vs 60g
for (k in 1:2) {
    for (c in 1:3) {
        r <- t.test(a[, c, 1, k], a[, c, 2, k])
        print(r)

        p <- r$conf.int * 100 / r$estimate[1]
        if ((p[1] > 0 && p[2] < 0) || (p[1] < 0 && p[2] > 0)) {
            s <- sprintf("k%d c%d: no significance", k, c)
        } else {
            s <- sprintf("k%d c%d: [%.2f, %.2f]%%", k, c, -p[2], -p[1])
        }
        print(s)
    }
}

$ R -q -s -f raw_data.r

        Welch Two Sample t-test

data:  a[, c, m, 1] and a[, c, m, 2]
t = -2.0139, df = 15.122, p-value = 0.06217
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -1463.17673    40.97673
sample estimates:
mean of x mean of y
 270811.6  271522.7

[1] "50g 100vu: no significance"

        Welch Two Sample t-test

data:  a[, c, m, 1] and a[, c, m, 2]
t = -1.0564, df = 17.673, p-value = 0.305
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -7878.98  2611.38
sample estimates:
mean of x mean of y
 240212.9  242846.7

[1] "50g 400vu: no significance"

        Welch Two Sample t-test

data:  a[, c, m, 1] and a[, c, m, 2]
t = 0.043083, df = 15.895, p-value = 0.9662
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -11078.68  11538.08
sample estimates:
mean of x mean of y
 283897.8  283668.1

[1] "50g 600vu: no significance"

        Welch Two Sample t-test

data:  a[, c, m, 1] and a[, c, m, 2]
t = 2.0171, df = 16.831, p-value = 0.05993
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
  -30.41577 1330.61577
sample estimates:
mean of x mean of y
 447933.4  447283.3

[1] "60g 100vu: no significance"

        Welch Two Sample t-test

data:  a[, c, m, 1] and a[, c, m, 2]
t = -6.3473, df = 12.132, p-value = 3.499e-05
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -35043.19 -17149.01
sample estimates:
mean of x mean of y
 327276.6  353372.7

[1] "60g 400vu: [5.24, 10.71]%"

        Welch Two Sample t-test

data:  a[, c, m, 1] and a[, c, m, 2]
t = -17.844, df = 10.233, p-value = 4.822e-09
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -71176.78 -55417.42
sample estimates:
mean of x mean of y
 274069.7  337366.8

[1] "60g 600vu: [20.22, 25.97]%"

        Welch Two Sample t-test

data:  a[, c, 1, k] and a[, c, 2, k]
t = -495.48, df = 15.503, p-value < 2.2e-16
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -177881.6 -176362.0
sample estimates:
mean of x mean of y
 270811.6  447933.4

[1] "baseline 100vu: [65.12, 65.68]%"

        Welch Two Sample t-test

data:  a[, c, 1, k] and a[, c, 2, k]
t = -20.601, df = 13.182, p-value = 2.062e-11
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -96181.0 -77946.4
sample estimates:
mean of x mean of y
 240212.9  327276.6

[1] "baseline 400vu: [32.45, 40.04]%"

        Welch Two Sample t-test

data:  a[, c, 1, k] and a[, c, 2, k]
t = 1.7607, df = 16.986, p-value = 0.09628
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -1949.503 21605.703
sample estimates:
mean of x mean of y
 283897.8  274069.7

[1] "baseline 600vu: no significance"

        Welch Two Sample t-test

data:  a[, c, 1, k] and a[, c, 2, k]
t = -553.68, df = 16.491, p-value < 2.2e-16
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -176431.9 -175089.3
sample estimates:
mean of x mean of y
 271522.7  447283.3

[1] "patched 100vu: [64.48, 64.98]%"

        Welch Two Sample t-test

data:  a[, c, 1, k] and a[, c, 2, k]
t = -48.194, df = 17.992, p-value < 2.2e-16
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -115344.3 -105707.7
sample estimates:
mean of x mean of y
 242846.7  353372.7

[1] "patched 400vu: [43.53, 47.50]%"

        Welch Two Sample t-test

data:  a[, c, 1, k] and a[, c, 2, k]
t = -17.109, df = 10.6, p-value = 4.629e-09
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -60638.55 -46758.85
sample estimates:
mean of x mean of y
 283668.1  337366.8

[1] "patched 600vu: [16.48, 21.38]%"
