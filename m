Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4163C4588FE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 06:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhKVFiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 00:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhKVFh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 00:37:59 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6111C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 21:34:52 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id t6so17006456qkg.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 21:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edi.works; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8/XTeLmVT7yxl+C3YSSHY74ibGGn3peNDbuBolAOdpI=;
        b=6EQn4D1jTRNzLkXvKUZGoLS4o6zJKZnGfExnEjcq0tRIzzTXZQVZaZnDAq8lhZsTJB
         27rUqB/B2yjV8upYIx4g07DqODL9hOQPtYJKDQqHw0+wAptUh9wwxQ3CFXpgJTv14tc3
         A3khCzwZ0k21HxSxzNxxDoCCLtPY4w/QZqcxOr7UYwG2SDe9iQZQItznVwKkYtKnj4Tl
         yo2SYx8r/Dye1wkuENXWXNm923uaZ5Ke+AGRt0nq4MJZfGTfsE65V1fhpCGKEEVk9YeK
         iNBbSKFgiKzE4awfn1Zc44qpmw9mPUoJdzko2tGFo0EWquhnCz2vAk8NA0RKgBfiwgtl
         ML5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8/XTeLmVT7yxl+C3YSSHY74ibGGn3peNDbuBolAOdpI=;
        b=27jHwVlVz4dMypvVva7mDPe865O0ewWiV9l5UIefbm5FT/XS0Zi6QJg+BdJ6IEtYHs
         nZbDTgF7kRSwVT8FL5li9exZBakCtabb6D1xl7qU26P8dm08kyxQlHmgob8TnHmsx/DH
         tfL1McbAPamtmnrosZfSY/kxPoLKAtXHU2T7F/MQ7fQpsKH261/HaDNWckmPcsITYult
         bLYwNx5hqp+rB8g0CjPSkwZKGnLWPgCbWc6k8qmiPJFed4VRAUpjVNsl6lnidAI0HDoh
         9DeMbsdfAB79U4mD9m1Ch/xUDNoi4kWm3NrGb5TmMCgeUq1DKRld+ZQnOkv0fowKIEWl
         C13g==
X-Gm-Message-State: AOAM533ElBDtem7Sx4WyajIh0Yy93aWmZ3UyybgiAyJP1qDqZddHlZWA
        AoVdNqc7xDIWVsmgkTFsM3oP5x4/jJMPQw==
X-Google-Smtp-Source: ABdhPJxAVNzInwMWJVlrxM5W7riPdgdCuVgiaKYK+64Rkip3HSLZrRqk0PE/d3ULaRYMK98vjaMfJQ==
X-Received: by 2002:a37:62c5:: with SMTP id w188mr46705436qkb.396.1637559291802;
        Sun, 21 Nov 2021 21:34:51 -0800 (PST)
Received: from localhost.localdomain (c-67-169-44-201.hsd1.ca.comcast.net. [67.169.44.201])
        by smtp.gmail.com with ESMTPSA id p10sm4053447qtw.97.2021.11.21.21.34.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Nov 2021 21:34:51 -0800 (PST)
From:   bot@edi.works
To:     yuzhao@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, corbet@lwn.net,
        michael@michaellarabel.com, sofia.trinh@edi.works
Subject: Re: [PATCH v5 00/10] Multigenerational LRU Framework
Date:   Sun, 21 Nov 2021 21:32:48 -0800
Message-Id: <20211122053248.57311-1-bot@edi.works>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211111041510.402534-1-yuzhao@google.com>
References: <20211111041510.402534-1-yuzhao@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel / Redis benchmark with MGLRU

TLDR
====
With the MGLRU, Redis achieved 95% CIs [0.58, 5.94]%, [6.55, 14.58]%,
[11.47, 19.36]%, [1.27, 3.54]%, [10.11, 14.81]% and [8.75, 13.64]%
more operations per second (OPS), respectively, for sequential access
w/ THP=always, random access w/ THP=always, Gaussian (distribution)
access w/ THP=always, sequential access w/ THP=never, random access
w/ THP=never and Gaussian access w/ THP=never.

Background
==========
Memory overcommit can increase utilization and, if carried out
properly, can also increase throughput. The challenges are to improve
working set estimation and to optimize page reclaim. The risks are
performance degradation and OOM kills. Short of overcoming the
challenges, the only way to reduce the risks is to underutilize
memory.

Redis is one of the most popular open-source in-memory KV stores.
memtier_benchmark is the leading open-source KV store benchmarking
software that supports multiple access patterns. THP can have a
negative effect under memory pressure, due to internal and/or
external fragmentations.

Matrix
======
Kernels: version [+ patchset]
* Baseline: 5.15
* Patched: 5.15 + MGLRU

Memory utilization: % of memory size
* Underutilizing: N/A
* Overcommitting: ~10% swapped out (zram)

THP (2MB Transparent Huge Pages):
* Always
* Never

Access patterns (4kB objects, 100% read):
* Parallel sequential
* Uniform random
* Gaussian (SD = 1/6 of key range)

Concurrency: average # of users per CPU
* Low: 1

Total configurations: 12
Data points per configuration: 10
Total run duration (minutes) per data point: ~25

Note that the goal of this benchmark is to compare the performance
for the same key range, object size, and hit ratio. Since Redis does
not support eviction to backing storage, it would require fewer
in-memory objects to underutilize memory, which reduces the hit ratio
and therefore is not applicable in this case.

Procedure
=========
The latest MGLRU patchset for the 5.15 kernel is available at
git fetch https://linux-mm.googlesource.com/page-reclaim \
    refs/changes/30/1430/2

Baseline and patched 5.15 kernel images are available at
https://drive.google.com/drive/folders/1eMkQleAFGkP2vzM_JyRA21oKE0ESHBqp

<install and configure OS>
<duplicate Redis service>

<for each kernel>
    grub-set-default <baseline, patched>
    <for each THP setting>
        echo <always, never> >/sys/kernel/mm/transparent_hugepage/enabled
        <for each access pattern>
            <update run_memtier.sh>
            <for each data point>
                reboot
                run_memtier.sh
                <collect total OPS>

Note that the OSS version of Redis does not support sharding, i.e.,
one service uses a single thread to serve all connections. Therefore,
on larger machines, multiple Redis services are required to achieve
better throughput.

Hardware
========
Memory (GB): 256
CPU (total #): 48
NVMe SSD (GB): 1024

OS
==
$ cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=21.10
DISTRIB_CODENAME=impish
DISTRIB_DESCRIPTION="Ubuntu 21.10"

$ cat /proc/swaps
Filename        Type          Size         Used         Priority
/dev/zram0      partition     10485756     0            1
/dev/zram1      partition     10485756     0            1
/dev/zram2      partition     10485756     0            1
/dev/zram3      partition     10485756     0            1

$ cat /sys/fs/cgroup/user.slice/memory.min
4294967296

$ cat /proc/sys/vm/overcommit_memory
1

Redis
=====
$ redis-server -v
Redis server v=6.0.15 sha=00000000:0 malloc=jemalloc-5.2.1 bits=64
build=4610f4c3acf7fb25

$ cat /etc/redis/redis.conf
<existing parameters>
save ""
unixsocket /var/run/redis/redis-server.sock

memtier_benchmark
=================
$ memtier_benchmark -v
memtier_benchmark 1.3.0
Copyright (C) 2011-2020 Redis Labs Ltd.
This is free software.  You may redistribute copies of it under the
terms of the GNU General Public License
<http://www.gnu.org/licenses/gpl.html>.  There is NO WARRANTY, to the
extent permitted by law.

$ cat run_memtier.sh
# load objects
for ((i = 0; i < 12; i++))
do
    memtier_benchmark -S /var/run/redis$i/redis-server.sock -P redis \
        -n allkeys -c 4 -t 4 --ratio 1:0 --pipeline 8 -d 4000 \
        --key-minimum=1 --key-maximum=5300000 --key-pattern=P:P &
done

wait

# run benchmark
for ((i = 0; i < 12; i++))
do
    memtier_benchmark -S /var/run/redis$i/redis-server.sock -P redis \
        --test-time=1200 -c 4 -t 4 --ratio 0:1 --pipeline 8 \
        --randomize --distinct-client-seed --key-minimum=1 \
        --key-maximum=5300000 --key-pattern=<P:P, R:R, G:G> &
done

wait

Results
=======
Comparing the patched with the baseline kernel, Redis achieved 95%
CIs [0.58, 5.94]%, [6.55, 14.58]%, [11.47, 19.36]%, [1.27, 3.54]%,
[10.11, 14.81]% and [8.75, 13.64]% more OPS, respectively, for
sequential access w/ THP=always, random access w/ THP=always,
Gaussian access w/ THP=always, sequential access w/ THP=never, random
access w/ THP=never and Gaussian access w/ THP=never.

+---------------------------+------------------+------------------+
| Mean million OPS [95% CI] | THP=always       | THP=never        |
+---------------------------+------------------+------------------+
| Sequential access         | 1.84 / 1.9       | 1.702 / 1.743    |
|                           | [0.01, 0.109]    | [0.021, 0.06]    |
+---------------------------+------------------+------------------+
| Random access             | 1.742 / 1.926    | 1.493 / 1.679    |
|                           | [0.114, 0.253]   | [0.15, 0.221]    |
+---------------------------+------------------+------------------+
| Gaussian access           | 1.771 / 2.044    | 1.635 / 1.818    |
|                           | [0.203, 0.342]   | [0.143, 0.222]   |
+---------------------------+------------------+------------------+
Table 1. Comparison between the baseline and patched kernels

Comparing THP=never with THP=always, Redis achieved 95% CIs [-8.66,
-6.34]%, [-17.6, -10.98]% and [-10.92, -4.44]% more OPS, respectively,
for sequential access, random access and Gaussian access when using
the baseline kernel; 95% CIs [-10.83, -5.7]%, [-15.72, -9.93]% and
[-13.92, -8.19]% more OPS, respectively, for sequential access, random
access and Gaussian access when using the patched kernel.

+---------------------------+------------------+------------------+
| Mean million OPS [95% CI] | Baseline kernel  | Patched kernel   |
+---------------------------+------------------+------------------+
| Sequential access         | 1.84 / 1.702     | 1.9 / 1.743      |
|                           | [-0.159, -0.116] | [-0.205, -0.108] |
+---------------------------+------------------+------------------+
| Random access             | 1.742 / 1.493    | 1.926 / 1.679    |
|                           | [-0.306, -0.191] | [-0.302, -0.191] |
+---------------------------+------------------+------------------+
| Gaussian access           | 1.771 / 1.635    | 2.044 / 1.818    |
|                           | [-0.193, -0.078] | [-0.284, -0.167] |
+---------------------------+------------------+------------------+
Table 2. Comparison between THP=always and THP=never

Metrics collected during each run are available at
https://github.com/ediworks/KernelPerf/tree/master/mglru/redis/5.15

Appendix
========
$ cat raw_data_redis.r
v <- c(
    # baseline THP=always sequential
    1.81, 1.81, 1.82, 1.84, 1.84, 1.84, 1.84, 1.85, 1.87, 1.88,
    # baseline THP=always random
    1.66, 1.67, 1.69, 1.69, 1.72, 1.75, 1.75, 1.77, 1.84, 1.88,
    # baseline THP=always Gaussian
    1.69, 1.70, 1.72, 1.76, 1.76, 1.76, 1.76, 1.78, 1.84, 1.94,
    # baseline THP=never sequential
    1.68, 1.68, 1.69, 1.69, 1.69, 1.69, 1.71, 1.72, 1.72, 1.75,
    # baseline THP=never random
    1.45, 1.45, 1.46, 1.47, 1.47, 1.47, 1.50, 1.53, 1.55, 1.58,
    # baseline THP=never Gaussian
    1.59, 1.60, 1.60, 1.60, 1.61, 1.63, 1.65, 1.66, 1.70, 1.71,
    # patched THP=always sequential
    1.79, 1.81, 1.85, 1.88, 1.90, 1.91, 1.96, 1.96, 1.96, 1.98,
    # patched THP=always random
    1.81, 1.86, 1.88, 1.89, 1.91, 1.94, 1.95, 1.96, 1.97, 2.09,
    # patched THP=always Gaussian
    1.95, 1.95, 1.98, 2.00, 2.04, 2.05, 2.08, 2.09, 2.12, 2.18,
    # patched THP=never sequential
    1.71, 1.73, 1.73, 1.74, 1.74, 1.74, 1.75, 1.75, 1.77, 1.77,
    # patched THP=never random
    1.65, 1.65, 1.65, 1.67, 1.68, 1.68, 1.69, 1.69, 1.71, 1.72,
    # patched THP=never Gaussian
    1.76, 1.76, 1.78, 1.81, 1.82, 1.83, 1.83, 1.84, 1.87, 1.88
)

a <- array(v, dim = c(10, 3, 2, 2))

# baseline vs patched
for (thp in 1:2) {
    for (dist in 1:3) {
        r <- t.test(a[, dist, thp, 1], a[, dist, thp, 2])
        print(r)

        p <- r$conf.int * 100 / r$estimate[1]
        if ((p[1] > 0 && p[2] < 0) || (p[1] < 0 && p[2] > 0)) {
            s <- sprintf("thp%d dist%d: no significance", thp, dist)
        } else {
            s <- sprintf("thp%d dist%d: [%.2f, %.2f]%%", thp, dist, -p[2], -p[1])
        }
        print(s)
    }
}

# THP=always vs THP=never
for (kern in 1:2) {
    for (dist in 1:3) {
        r <- t.test(a[, dist, 1, kern], a[, dist, 2, kern])
        print(r)

        p <- r$conf.int * 100 / r$estimate[1]
        if ((p[1] > 0 && p[2] < 0) || (p[1] < 0 && p[2] > 0)) {
            s <- sprintf("kern%d dist%d: no significance", kern, dist)
        } else {
            s <- sprintf("kern%d dist%d: [%.2f, %.2f]%%", kern, dist, -p[2], -p[1])
        }
        print(s)
    }
}

$ R -q -s -f raw_data_redis.r

        Welch Two Sample t-test

data:  a[, dist, thp, 1] and a[, dist, thp, 2]
t = -2.6773, df = 11.109, p-value = 0.02135
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -0.10926587 -0.01073413
sample estimates:
mean of x mean of y
     1.84      1.90

[1] "thp1 dist1: [0.58, 5.94]%"

        Welch Two Sample t-test

data:  a[, dist, thp, 1] and a[, dist, thp, 2]
t = -5.5311, df = 17.957, p-value = 3.011e-05
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -0.2539026 -0.1140974
sample estimates:
mean of x mean of y
    1.742     1.926

[1] "thp1 dist2: [6.55, 14.58]%"

        Welch Two Sample t-test

data:  a[, dist, thp, 1] and a[, dist, thp, 2]
t = -8.2093, df = 17.98, p-value = 1.707e-07
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -0.3428716 -0.2031284
sample estimates:
mean of x mean of y
    1.771     2.044

[1] "thp1 dist3: [11.47, 19.36]%"

        Welch Two Sample t-test

data:  a[, dist, thp, 1] and a[, dist, thp, 2]
t = -4.4705, df = 17.276, p-value = 0.0003243
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -0.06032607 -0.02167393
sample estimates:
mean of x mean of y
    1.702     1.743

[1] "thp2 dist1: [1.27, 3.54]%"

        Welch Two Sample t-test

data:  a[, dist, thp, 1] and a[, dist, thp, 2]
t = -11.366, df = 13.885, p-value = 2.038e-08
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -0.2211244 -0.1508756
sample estimates:
mean of x mean of y
    1.493     1.679

[1] "thp2 dist2: [10.11, 14.81]%"

        Welch Two Sample t-test

data:  a[, dist, thp, 1] and a[, dist, thp, 2]
t = -9.6138, df = 17.962, p-value = 1.663e-08
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -0.2229972 -0.1430028
sample estimates:
mean of x mean of y
    1.635     1.818

[1] "thp2 dist3: [8.75, 13.64]%"

        Welch Two Sample t-test

data:  a[, dist, 1, kern] and a[, dist, 2, kern]
t = 13.532, df = 17.988, p-value = 7.194e-11
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 0.1165737 0.1594263
sample estimates:
mean of x mean of y
    1.840     1.702

[1] "kern1 dist1: [-8.66, -6.34]%"

        Welch Two Sample t-test

data:  a[, dist, 1, kern] and a[, dist, 2, kern]
t = 9.197, df = 15.127, p-value = 1.386e-07
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 0.1913354 0.3066646
sample estimates:
mean of x mean of y
    1.742     1.493

[1] "kern1 dist2: [-17.60, -10.98]%"

        Welch Two Sample t-test

data:  a[, dist, 1, kern] and a[, dist, 2, kern]
t = 5.0552, df = 14.669, p-value = 0.0001523
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 0.07854452 0.19345548
sample estimates:
mean of x mean of y
    1.771     1.635

[1] "kern1 dist3: [-10.92, -4.44]%"

        Welch Two Sample t-test

data:  a[, dist, 1, kern] and a[, dist, 2, kern]
t = 7.1487, df = 10.334, p-value = 2.614e-05
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 0.1082788 0.2057212
sample estimates:
mean of x mean of y
    1.900     1.743

[1] "kern2 dist1: [-10.83, -5.70]%"

        Welch Two Sample t-test

data:  a[, dist, 1, kern] and a[, dist, 2, kern]
t = 9.7525, df = 10.871, p-value = 1.042e-06
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 0.1911754 0.3028246
sample estimates:
mean of x mean of y
    1.926     1.679

[1] "kern2 dist2: [-15.72, -9.93]%"

        Welch Two Sample t-test

data:  a[, dist, 1, kern] and a[, dist, 2, kern]
t = 8.2831, df = 13.988, p-value = 9.168e-07
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 0.167476 0.284524
sample estimates:
mean of x mean of y
    2.044     1.818

[1] "kern2 dist3: [-13.92, -8.19]%"
