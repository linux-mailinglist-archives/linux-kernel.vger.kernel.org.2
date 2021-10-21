Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D240B436B6C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 21:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhJUTnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 15:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJUTnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 15:43:24 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37D5C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:41:07 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id n2so1558713qta.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edi.works; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ya+ey+/s1GWZFIFDEVYnkh73PpmflCvvRgfCjgGVd2s=;
        b=Xfi1Dn95lqsvmCPIc9GnNDru6HiU0weozjV/Unthgfpg2bqsLQ47oUJ/Z2lrDYgv4+
         Q2LZe6wFOpSHL5FTPcC+NLlyyg5PaLJOn9+QILPOQ+gkP1JzYkLFjtZf1dGhpEnb/Bhm
         XJGy8O7SW3jp1HVtKIdU/I+jKwwIRqePw4pxnwKb5zaNcFXYVu8EWC2mGJdKvpLvA5rR
         sYzUqBIgoEDLa55RAcIa6+8cyL5lkFhwlC0viulj63CT885EzIyO32ApeqVMUGQiMDeS
         FTqSIInkVM6/agBSGZVYHLYx4jdJcN59OqOpMPFMfkZbfG49GTX0Yy50UXMcCMGK1mFJ
         52Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ya+ey+/s1GWZFIFDEVYnkh73PpmflCvvRgfCjgGVd2s=;
        b=aZ9OFvlLKwGL7t3LJ8xF47sbkoH55IEGL8fldBp5MGfVRBAe7+YCX/9hdpzKWhuQj8
         jjxFakOyohNkNjEQoCel8Xicffodw3nJ+FhOyjcLWi/Qq34ddTTPH2grQMaEfxfeaobR
         t/d0gIWWjApz24+ZoDjH/QIoJ96xLGBYlzFXyuMXzB/EpDBTttZN0Xd2kb0smLxnxZTT
         c3o+IdBt6p1ugXcxsd20Yk6z0kZnRkvYLyEx5yeCgKbznBmFgFyQae+bjk+JJXKcDmfP
         BuTweW5F9xgj7dL4Z+lGTUaVyWKXOmWV8UUZ7Px7MukwxL7/ojI4+XONouCipfL2w1WG
         mG8g==
X-Gm-Message-State: AOAM533be2cRCB8tP5yW/o33yfq7agRAb+rDtPEo8u7uaLyFEOuIBDcx
        rgEko7OjJO9DgHXeFevLvKH/Ow==
X-Google-Smtp-Source: ABdhPJyzSsn7y+qPAs8E1dehOi51zLVJJCYFsl8n/25ZtWFBz+j/k5Vz5EpwQdRSMgQb7oILZ3MQsg==
X-Received: by 2002:a05:622a:1194:: with SMTP id m20mr8330851qtk.175.1634845266822;
        Thu, 21 Oct 2021 12:41:06 -0700 (PDT)
Received: from localhost.localdomain (c-67-169-44-201.hsd1.ca.comcast.net. [67.169.44.201])
        by smtp.gmail.com with ESMTPSA id c26sm2904609qtm.21.2021.10.21.12.41.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Oct 2021 12:41:06 -0700 (PDT)
From:   bot@edi.works
To:     yuzhao@google.com
Cc:     hdanton@sina.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, corbet@lwn.net,
        michael@michaellarabel.com, sofia.trinh@edi.works
Subject: Re: [PATCH v4 00/11] Multigenerational LRU Framework
Date:   Thu, 21 Oct 2021 12:41:03 -0700
Message-Id: <20211021194103.65648-1-bot@edi.works>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210818063107.2696454-1-yuzhao@google.com>
References: <20210818063107.2696454-1-yuzhao@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel / Memcached benchmark with MGLRU

TLDR
====
With the MGLRU, Memcached achieved 95% CIs [23.54, 32.25]%, [20.76,
41.61]%, [13.85, 15.97]%, [21.59, 30.02]% and [23.94, 29.92]% more
operations per second (OPS), respectively, for sequential access w/
THP=always, random access w/ THP=always, random access w/ THP=never,
Gaussian access w/ THP=always and Gaussian access w/ THP=never. There
were no statistically significant changes in OPS for sequential
access w/ THP=never.

Background
==========
Memory overcommit can increase utilization and, if carried out
properly, can also increase throughput. The challenges are to improve
working set estimation and to optimize page reclaim. The risks are
performance degradations and OOM kills. Short of overcoming the
challenges, the only way to reduce the risks is to underutilize
memory.

Memcached is one of the most popular open-source in-memory KV stores.
memtier_benchmark is the leading open-source KV store benchmarking
software that supports multiple access patterns. THP can have a
negative effect under memory pressure, due to internal and/or
external fragmentations.

Matrix
======
Kernels: version [+ patchset]
* Baseline: 5.14
* Patched: 5.14 + MGLRU

Memory conditions: % of memory size
* Underutilizing: N/A
* Overcommitting: ~10% swapped out (zram)

THP (2MB Transparent Huge Pages):
* Always
* Never

Read patterns (2kB objects):
* Parallel sequential
* Uniform random
* Gaussian (SD = 1/6 of key range)

Total configurations: 12
Data points per configuration: 10
Total run duration (minutes) per data point: ~20

Note that the goal of this benchmark is to compare the performance
for the same key range, object size, and hit ratio. Since Memcached
does not support backing storage, it requires fewer in-memory objects
to underutilize memory, which reduces the hit ratio and therefore is
not applicable in this case.

Procedure
=========
The latest MGLRU patchset for the 5.14 kernel is available at
git fetch https://linux-mm.googlesource.com/page-reclaim \
    refs/changes/30/1430/1

Baseline and patched 5.14 kernel images are available at
https://drive.google.com/drive/folders/1eMkQleAFGkP2vzM_JyRA21oKE0ESHBqp

<install and configure OS>

<for each kernel>
    grub2-set-default <baseline, patched>
    <for each THP setting>
        echo <always, never> > \
            /sys/kernel/mm/transparent_hugepage/enabled
        <update /etc/sysconfig/memcached>
        <for each access pattern>
            <update run_memtier.sh>
            <for each data point>
                reboot
                run_memtier.sh
                <collect OPS>

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
/dev/zram0        partition     8388604       0        -2

$ cat /proc/cmdline
<existing parameters> systemd.unified_cgroup_hierarchy=1

$ cat /sys/fs/cgroup/user.slice/memory.min
4294967296

$ cat /proc/sys/vm/overcommit_memory
1

Memcached
=========
$ memcached -V
memcached 1.5.22

$ cat /etc/sysconfig/memcached
USER="memcached"
MAXCONN="10000"
CACHESIZE="65536"
OPTIONS="-s /tmp/memcached.sock -a 0766 -t 16 -b 10000 -B binary <-L>"
memtier_benchmark
$ memtier_benchmark -v
memtier_benchmark 1.3.0
Copyright (C) 2011-2020 Redis Labs Ltd.
This is free software.  You may redistribute copies of it under the
terms of
the GNU General Public License <http://www.gnu.org/licenses/gpl.html>.
There is NO WARRANTY, to the extent permitted by law.

$ cat run_memtier.sh
# load objects
memtier_benchmark -S /tmp/memcached.sock -P memcache_binary -n
allkeys -c 1 -t 16 --ratio 1:0 --pipeline 1 -d 2000 --key-minimum=1
--key-maximum=30000000 --key-pattern=P:P

# run benchmark
memtier_benchmark -S /tmp/memcached.sock -P memcache_binary -n
30000000 -c 1 -t 16 --ratio 0:1 --pipeline 1 --randomize
--distinct-client-seed --key-minimum=1 --key-maximum=30000000
--key-pattern=<P:P, R:R, G:G>

Results
=======
Comparing the patched with the baseline kernel, Memcached achieved
95% CIs [23.54, 32.25]%, [20.76, 41.61]%, [13.85, 15.97]%, [21.59,
30.02]% and [23.94, 29.92]% more OPS, respectively, for sequential
access w/ THP=always, random access w/ THP=always, random access w/
THP=never, Gaussian access w/ THP=always and Gaussian access w/
THP=never. There were no statistically significant changes in OPS for
sequential access w/ THP=never.

+-------------------+-----------------------+------------------------+
| Mean OPS [95% CI] | THP=always            | THP=never              |
+-------------------+-----------------------+------------------------+
| Sequential access | 519599.7 / 664543.2   | 525394.8 / 527170.6    |
|                   | [122297.9, 167589.0]  | [-15138.63, 18690.31]  |
+-------------------+-----------------------+------------------------+
| Random access     | 450033.2 / 590360.7   | 509237.3 / 585142.4    |
|                   | [93415.59, 187239.37] | [70504.51, 81305.60]   |
+-------------------+-----------------------+------------------------+
| Gaussian access   | 481182.4 / 605358.7   | 531270.8 / 674341.4    |
|                   | [103892.6, 144460.0]] | [127199.8, 158941.2]   |
+-------------------+-----------------------+------------------------+
Table 1. Comparison between the baseline and patched kernels

Comparing THP=never with THP=always, Memcached achieved 95% CIs
[2.73, 23.58]% and [5.45, 15.37]% more OPS, respectively, for random
access and Gaussian access when using the baseline kernel; 95% CIs
[-22.65, -18.69]% and [10.67, 12.12]% more OPS, respectively, for
sequential access and Gaussian access when using the patched kernel.
There were no statistically significant changes in OPS under other
conditions.

+-------------------+-----------------------+------------------------+
| Mean OPS [95% CI] | Baseline kernel       |  Patched kernel        |
+-------------------+-----------------------+------------------------+
| Sequential access | 519599.7 / 525394.8   | 664543.2 / 527170.6    |
|                   | [-18739.71, 30329.80] | [-150551.0, -124194.1] |
+-------------------+-----------------------+------------------------+
| Random access     | 450033.2 / 509237.3   | 590360.7 / 585142.4    |
|                   | [12303.49, 106104.69] | [-10816.1516, 379.475] |
+-------------------+-----------------------+------------------------+
| Gaussian access   | 481182.4 / 531270.8   | 605358.7 / 674341.4    |
|                   | [26229.02, 73947.84]  | [64570.58, 73394.70]   |
+-------------------+-----------------------+------------------------+
Table 2. Comparison between THP=always and THP=never

Metrics collected during each run are available at
https://github.com/ediworks/KernelPerf/tree/master/mglru/memcached/5.14

References
==========
memtier_benchmark: A High-Throughput Benchmarking Tool for Redis &
Memcached
https://redis.com/blog/memtier_benchmark-a-high-throughput-benchmarking-tool-for-redis-memcached/

Appendix
========
$ cat raw_data.r
v <- c(
    # baseline THP=always sequential
    460266.29, 466497.70, 516145.38, 523474.39, 528507.72, 529481.86, 533867.92, 537028.56, 546027.45, 554699.89,
    # baseline THP=always random
    371470.66, 378967.63, 381137.01, 385205.60, 449100.72, 474670.76, 490470.46, 513341.53, 525159.49, 530808.55,
    # baseline THP=always Gaussian
    455674.14, 457089.50, 460001.46, 463269.94, 468283.00, 474169.61, 477684.67, 506331.96, 507875.30, 541444.54,
    # baseline THP=never sequential
    501887.04, 507303.10, 509573.54, 515222.79, 517429.04, 530805.74, 536490.44, 538088.45, 540459.92, 556687.57,
    # baseline THP=never random
    496489.97, 506444.42, 508002.80, 508707.39, 509746.28, 511157.58, 511897.57, 511926.06, 512652.28, 515348.95,
    # baseline THP=never Gaussian
    493199.15, 504207.48, 518781.40, 520536.21, 528619.45, 540677.91, 544365.57, 551698.32, 554046.80, 556576.14,
    # patched THP=always sequential
    660711.43, 660936.88, 661275.57, 662540.65, 663417.25, 665546.99, 665680.49, 667564.03, 668555.96, 669202.36,
    # patched THP=always random
    582574.69, 583714.04, 587102.54, 587375.85, 588997.85, 589052.96, 593922.17, 594722.98, 596178.28, 599965.83,
    # patched THP=always Gaussian
    601707.98, 602055.03, 603020.28, 603335.93, 604519.55, 605086.48, 607405.59, 607570.79, 609009.54, 609875.98,
    # patched THP=never sequential
    507753.56, 509462.65, 509964.30, 510369.66, 515001.36, 531685.00, 543709.22, 545142.98, 548392.56, 550224.74,
    # patched THP=never random
    571017.21, 579705.57, 582801.51, 584475.82, 586247.73, 587209.97, 587354.87, 588661.14, 591237.23, 592712.76,
    # patched THP=never Gaussian
    666403.77, 669691.68, 670248.43, 672190.97, 672466.43, 674320.42, 674897.72, 677282.76, 678886.51, 687024.85
)

a <- array(v, dim = c(10, 3, 2, 2))

# baseline vs patched
for (thp in 1:2) {
    for (pattern in 1:3) {
        r <- t.test(a[, pattern, thp, 1], a[, pattern, thp, 2])
        print(r)

        p <- r$conf.int * 100 / r$estimate[1]
        if ((p[1] > 0 && p[2] < 0) || (p[1] < 0 && p[2] > 0)) {
            s <- sprintf("thp%d pattern%d: no significance", thp, pattern)
        } else {
            s <- sprintf("thp%d pattern%d: [%.2f, %.2f]%%", thp, pattern, -p[2], -p[1])
        }
        print(s)
    }
}

# THP=always vs THP=never
for (kernel in 1:2) {
    for (pattern in 1:3) {
        r <- t.test(a[, pattern, 1, kernel], a[, pattern, 2, kernel])
        print(r)

        p <- r$conf.int * 100 / r$estimate[1]
        if ((p[1] > 0 && p[2] < 0) || (p[1] < 0 && p[2] > 0)) {
            s <- sprintf("kernel%d pattern%d: no significance", kernel, pattern)
        } else {
            s <- sprintf("kernel%d pattern%d: [%.2f, %.2f]%%", kernel, pattern, -p[2], -p[1])
        }
        print(s)
    }
}

$ R -q -s -f raw_data.r

        Welch Two Sample t-test

data:  a[, pattern, thp, 1] and a[, pattern, thp, 2]
t = -14.434, df = 9.1861, p-value = 1.269e-07
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -167589.0 -122297.9
sample estimates:
mean of x mean of y
 519599.7  664543.2

[1] "thp1 pattern1: [23.54, 32.25]%"

        Welch Two Sample t-test

data:  a[, pattern, thp, 1] and a[, pattern, thp, 2]
t = -6.7518, df = 9.1333, p-value = 7.785e-05
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -187239.37  -93415.59
sample estimates:
mean of x mean of y
 450033.2  590360.7

[1] "thp1 pattern2: [20.76, 41.61]%"

        Welch Two Sample t-test

data:  a[, pattern, thp, 1] and a[, pattern, thp, 2]
t = -13.805, df = 9.1933, p-value = 1.866e-07
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -144460.0 -103892.6
sample estimates:
mean of x mean of y
 481182.4  605358.7

[1] "thp1 pattern3: [21.59, 30.02]%"

        Welch Two Sample t-test

data:  a[, pattern, thp, 1] and a[, pattern, thp, 2]
t = -0.22059, df = 17.979, p-value = 0.8279
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -18690.31  15138.63
sample estimates:
mean of x mean of y
 525394.8  527170.6

[1] "thp2 pattern1: no significance"

        Welch Two Sample t-test

data:  a[, pattern, thp, 1] and a[, pattern, thp, 2]
t = -29.606, df = 17.368, p-value = 2.611e-16
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -81305.60 -70504.51
sample estimates:
mean of x mean of y
 509237.3  585142.4

[1] "thp2 pattern2: [13.85, 15.97]%"

        Welch Two Sample t-test

data:  a[, pattern, thp, 1] and a[, pattern, thp, 2]
t = -20.02, df = 10.251, p-value = 1.492e-09
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -158941.2 -127199.8
sample estimates:
mean of x mean of y
 531270.8  674341.4

[1] "thp2 pattern3: [23.94, 29.92]%"

        Welch Two Sample t-test

data:  a[, pattern, 1, kernel] and a[, pattern, 2, kernel]
t = -0.50612, df = 14.14, p-value = 0.6206
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -30329.80  18739.71
sample estimates:
mean of x mean of y
 519599.7  525394.8

[1] "kernel1 pattern1: no significance"

        Welch Two Sample t-test

data:  a[, pattern, 1, kernel] and a[, pattern, 2, kernel]
t = -2.8503, df = 9.1116, p-value = 0.01885
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -106104.69  -12303.49
sample estimates:
mean of x mean of y
 450033.2  509237.3

[1] "kernel1 pattern2: [2.73, 23.58]%"

        Welch Two Sample t-test

data:  a[, pattern, 1, kernel] and a[, pattern, 2, kernel]
t = -4.4308, df = 16.918, p-value = 0.0003701
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -73947.84 -26229.02
sample estimates:
mean of x mean of y
 481182.4  531270.8

[1] "kernel1 pattern3: [5.45, 15.37]%"

        Welch Two Sample t-test

data:  a[, pattern, 1, kernel] and a[, pattern, 2, kernel]
t = 23.374, df = 9.5538, p-value = 9.402e-10
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 124194.1 150551.0
sample estimates:
mean of x mean of y
 664543.2  527170.6

[1] "kernel2 pattern1: [-22.65, -18.69]%"

        Welch Two Sample t-test

data:  a[, pattern, 1, kernel] and a[, pattern, 2, kernel]
t = 1.96, df = 17.806, p-value = 0.06583
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
  -379.4756 10816.1516
sample estimates:
mean of x mean of y
 590360.7  585142.4

[1] "kernel2 pattern2: no significance"

        Welch Two Sample t-test

data:  a[, pattern, 1, kernel] and a[, pattern, 2, kernel]
t = -33.687, df = 13.354, p-value = 2.614e-14
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -73394.70 -64570.58
sample estimates:
mean of x mean of y
 605358.7  674341.4

[1] "kernel2 pattern3: [10.67, 12.12]%"
