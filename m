Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169E544A47B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 03:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238641AbhKICQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 21:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbhKICQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 21:16:35 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81A7C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 18:13:49 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id j17so3530316qtx.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 18:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edi.works; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+atqJCfHU621dS9WyrBXBvV6FFQ5mGU2jRsU3bUDRbI=;
        b=ZCnZFR/0yNZQJDtqVx+GvPJoZWER4UJ/1s82yeY1haNcXXcxJCo3AdNBMpNPyHv/Om
         gmomaUUDytulhbnpdPrdPVQZWDBn3ZQU8CblDSq4Oay+oWlXfY427cIu4eK6FrJeNKU6
         lnQUnAe+zSnbjcj4V5zoLXhiy69gYJRA3+uzgh1L39m3VZe9MEEjz07HiS3YyZdke/ea
         FQCH9bN0KdwM0wADDg/82XQvtI/FmCscjlsymZxXdoHaWZYW8uUCMRZM60qrE7/PusYU
         eCHRMETOaQ9VgB6Q+0AVFR7mqFWw0d4R5u5X0nX2yQIUxTEwZyxlj/geI49djRhN4aYj
         KywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+atqJCfHU621dS9WyrBXBvV6FFQ5mGU2jRsU3bUDRbI=;
        b=ZCqc+0DyBKtsWjxIgCwDAmaxV14oJX9l9QPsVLjgIwyuwJ7saRPC8UAevjq6uNnyWm
         metT7Td3q9dYoXldv0hKeFEoO8COEeP96kgt8qzPPGeQ/xDM6qERsnVcXzkKcsYxGJhy
         od/aWVuYb5hWJmmtctYZrd1ELNkt9sfL72MQi0wS/LpYrEQLvT1mA0ApKEF3lWMN8xHw
         AdiwaJPD2So9oBsf9k2y/YunOAdo+kePs6A38oZ/lWIVsv3hBfmiZcTqidOgJXxqxGKs
         qo1hE4H5OUYjq9HXImm5A/aTfcYWDc3TTrNFP7Y+8DDqChx2kS5s2xAgtnwdSzOuCED3
         4kVg==
X-Gm-Message-State: AOAM5328ovDvM+tKBEDnniabK+h00klvbQqs9Z43Glkz1BIpXmXk8u8g
        yyw3uWXRz2k5CKL5vt/fbIZ+ZA==
X-Google-Smtp-Source: ABdhPJzGqHA3jMlRw3rtoISwQKkM23f9iFna14Bp2MItm/4vyiNHY++SkmdW2C5c/kQwANNnx7QXPA==
X-Received: by 2002:ac8:7f03:: with SMTP id f3mr4556893qtk.320.1636424029022;
        Mon, 08 Nov 2021 18:13:49 -0800 (PST)
Received: from localhost.localdomain (c-67-169-44-201.hsd1.ca.comcast.net. [67.169.44.201])
        by smtp.gmail.com with ESMTPSA id az14sm10602470qkb.125.2021.11.08.18.13.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Nov 2021 18:13:48 -0800 (PST)
From:   bot@edi.works
To:     yuzhao@google.com
Cc:     hdanton@sina.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, corbet@lwn.net,
        michael@michaellarabel.com, sofia.trinh@edi.works
Subject: Re: [PATCH v4 00/11] Multigenerational LRU Framework
Date:   Mon,  8 Nov 2021 18:13:46 -0800
Message-Id: <20211109021346.50266-1-bot@edi.works>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210818063107.2696454-1-yuzhao@google.com>
References: <20210818063107.2696454-1-yuzhao@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel / MongoDB benchmark with MGLRU

TLDR
====
With the MGLRU, MongoDB achieved 95% CIs [2.23, 3.44]%, [6.97, 9.73]%
and [2.16, 3.55]% more operations per second (OPS) respectively for
exponential (distribution) access, random access and Zipfian access,
when underutizling memory; 95% CIs [8.83, 10.03]%, [21.12, 23.14]%
and [5.53, 6.46]% more OPS respectively for exponential access,
random access and Zipfian access, when slightly overcommitting memory.

Background
==========
Memory overcommit can increase utilization and, if carried out
properly, can also increase throughput. The challenges are to improve
working set estimation and to optimize page reclaim. The risks are
performance degradation and OOM kills. Short of overcoming the
challenges, the only way to reduce the risks is to underutilize
memory.

MongoDB is one of the most popular open-source NoSQL databases. YCSB
is the leading open-source NoSQL database benchmarking software that
supports multiple access distributions.

Matrix
======
Kernels: version [+ patchset]
* Baseline: 5.14
* Patched: 5.14 + MGLRU

Memory utilization: % of memory size
* Underutilizing: ~15% on inactive file list
* Overcommitting: ~5% swapped out

Concurrency: average # of users per CPU
* Medium: 2

Access distributions (1kB objects, 20% update):
* Exponential
* Uniform random
* Zipfian

Total configurations: 12
Data points per configuration: 10
Total run duration (minutes) per data point: ~20

Note that MongoDB reached the peak performance with the concurrency
for this benchmark, i.e., its performance degraded with fewer or more
users for this benchmark.

Procedure
=========
The latest MGLRU patchset for the 5.14 kernel is available at
git fetch https://linux-mm.googlesource.com/page-reclaim \
    refs/changes/30/1430/1

Baseline and patched 5.14 kernel images are available at
https://drive.google.com/drive/folders/1eMkQleAFGkP2vzM_JyRA21oKE0ESHBqp

<install and configure OS>
ycsb_load.sh
systemctl stop mongod
e2image <backup /mnt/data>

<for each kernel>
    grub2-set-default <baseline, patched>
    <for each memory utilization>
        <update /etc/mongod.conf>
        <for each access distribution>
            <update ycsb_run.sh>
            <for each data point>
                systemctl stop mongod
                e2image <restore /mnt/data>
                reboot
                ycsb_run.sh
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
/dev/nvme0n1p3    partition     32970748      0        -2

$ cat /proc/cmdline
<existing parameters> systemd.unified_cgroup_hierarchy=1

$ cat /sys/fs/cgroup/user.slice/memory.min
4294967296

$ cat /proc/sys/vm/overcommit_memory
1

$ cat /sys/kernel/mm/transparent_hugepage/enabled
always madvise [never]

MongoDB
=======
$ mongod --version
db version v5.0.3
Build Info: {
    "version": "5.0.3",
    "gitVersion": "657fea5a61a74d7a79df7aff8e4bcf0bc742b748",
    "openSSLVersion": "OpenSSL 1.1.1g FIPS  21 Apr 2020",
    "modules": [],
    "allocator": "tcmalloc",
    "environment": {
        "distmod": "rhel80",
        "distarch": "x86_64",
        "target_arch": "x86_64"
    }
}

$ cat /etc/mongod.conf
# mongod.conf
<existing parameters>

# Where and how to store data.
storage:
  dbPath: /mnt/data
  journal:
    enabled: true
  wiredTiger:
    engineConfig:
      cacheSizeGB: <50, 60>

<existing parameters>

YCSB
====
$ git log
commit ce3eb9ce51c84ee9e236998cdd2cefaeb96798a8 (HEAD -> master,
origin/master, origin/HEAD)
Author: Ivan <john.koepi@gmail.com>
Date:   Tue Feb 16 17:38:00 2021 +0200

    [scylla] enable token aware LB by default, improve the docs (#1507)

$ cat ycsb_load.sh
# load objects
ycsb load mongodb -s -threads 16 \
    -p mongodb.url=mongodb://%2Ftmp%2Fmongodb-27017.sock \
    -p workload=site.ycsb.workloads.CoreWorkload \
    -p recordcount=80000000

$ cat ycsb_run.sh
# run benchmark
ycsb run mongodb -s -threads 64 \
    -p mongodb.url=mongodb://%2Ftmp%2Fmongodb-27017.sock \
    -p workload=site.ycsb.workloads.CoreWorkload \
    -p recordcount=80000000 -p operationcount=80000000 \
    -p readproportion=0.8 -p updateproportion=0.2 \
    -p requestdistribution=<exponential, uniform, zipfian>

Results
=======
Comparing the patched with the baseline kernel, MongoDB achieved 95%
CIs [2.23, 3.44]%, [6.97, 9.73]% and [2.16, 3.55]% more OPS
respectively for exponential access, random access and Zipfian
access, when underutizling memory; 95% CIs [8.83, 10.03]%, [21.12,
23.14]% and [5.53, 6.46]% more OPS respectively for exponential
access, random access and Zipfian access, when slightly
overcommitting memory.

+--------------------+-----------------------+-----------------------+
| Mean OPS [95% CI]  | Underutilizing memory | Overcommitting memory |
+--------------------+-----------------------+-----------------------+
| Exponential access | 76615.56 / 78788.76   | 73984.90 / 80961.66   |
|                    | [1708.76, 2637.62]    | [6533.94, 7419.58]    |
+--------------------+-----------------------+-----------------------+
| Random access      | 62093.40 / 67276.01   | 55990.56 / 68379.91   |
|                    | [4324.96, 6040.25]    | [11824.09, 12954.62]  |
+--------------------+-----------------------+-----------------------+
| Zipfian access     | 92532.25 / 95174.43   | 93545.62 / 99151.12   |
|                    | [1997.20, 3287.17]    | [5171.27, 6039.72]    |
+--------------------+-----------------------+-----------------------+
Table 1. Comparison between the baseline and patched kernels

Comparing overcommitting with underutilizing memory, MongoDB achieved
95% CIs [-4.10, -2.77]%, [-11.20, -8.46]% and [0.36, 1.83]% more OPS
respectively for exponential access, random access and Zipfian
access, when using the baseline kernel; 95% CIs [2.27, 3.25]%, [0.78,
2.50]% and [3.81, 4.54]% more OPS respectively for exponential
access, random access and Zipfian access, when using the patched
kernel.

+--------------------+-----------------------+-----------------------+
| Mean OPS [95% CI]  | Baseline kernel       |  Patched kernel       |
+--------------------+-----------------------+-----------------------+
| Exponential access | 76615.56 / 73984.90   | 78788.76 / 80961.66   |
|                    | [-3139.12, -2122.20]  | [1786.70, 2559.09]    |
+--------------------+-----------------------+-----------------------+
| Random access      | 62093.40 / 55990.56   | 67276.01 / 68379.91   |
|                    | [-6953.44, -5252.23]  | [525.42, 1682.38]     |
+--------------------+-----------------------+-----------------------+
| Zipfian access     | 92532.25 / 93545.62   | 95174.43 / 99151.12   |
|                    | [330.99, 1695.75]     | [3628.31, 4325.06]    |
+--------------------+-----------------------+-----------------------+
Table 2. Comparison between underutilizing and overcommitting memory

Metrics collected during each run are available at
https://github.com/ediworks/KernelPerf/tree/master/mglru/mongodb/5.14

Appendix
========
$ cat raw_data_mongodb.r
v <- c(
    # baseline 50g exp
    75814.86, 75884.91, 76052.71, 76621.01, 76641.19, 76661.24, 76870.15, 77017.79, 77289.08, 77302.67,
    # baseline 50g uni
    60638.17, 60968.91, 61128.61, 61548.40, 61779.30, 61917.58, 62152.28, 63440.15, 63625.47, 63735.11,
    # baseline 50g zip
    91271.16, 91482.41, 91524.17, 92467.16, 92585.62, 92843.29, 92885.65, 93229.98, 93408.94, 93624.08,
    # baseline 60g exp
    73183.67, 73191.30, 73527.58, 73831.79, 74047.95, 74056.24, 74401.23, 74418.53, 74547.58, 74643.08,
    # baseline 60g uni
    55175.76, 55477.42, 55605.52, 55680.21, 55903.39, 56171.05, 56375.06, 56380.43, 56509.94, 56626.78,
    # baseline 60g zip
    92653.82, 92775.02, 93100.44, 93290.21, 93593.74, 93775.64, 93868.72, 93915.12, 94194.77, 94288.69,
    # patched 50g exp
    78349.95, 78385.64, 78392.33, 78419.91, 78726.59, 78738.68, 78930.72, 78948.25, 79404.38, 79591.14,
    # patched 50g uni
    66622.91, 66667.33, 66951.43, 67104.80, 67117.30, 67196.90, 67389.75, 67406.62, 68131.43, 68171.61,
    # patched 50g zip
    94261.14, 94822.34, 94914.70, 95114.89, 95156.75, 95205.90, 95383.78, 95612.00, 95624.00, 95648.81,
    # patched 60g exp
    80272.04, 80612.33, 80679.23, 80717.74, 81011.18, 81029.64, 81146.68, 81371.84, 81379.13, 81396.76,
    # patched 60g uni
    67559.52, 67600.11, 67718.90, 68062.57, 68278.78, 68446.56, 68452.82, 68853.86, 69278.34, 69547.67,
    # patched 60g zip
    98706.81, 98864.41, 98903.77, 99044.10, 99155.68, 99162.94, 99165.64, 99482.31, 99484.91, 99540.62
)

a <- array(v, dim = c(10, 3, 2, 2))

# baseline vs patched
for (mem in 1:2) {
    for (dist in 1:3) {
        r <- t.test(a[, dist, mem, 1], a[, dist, mem, 2])
        print(r)

        p <- r$conf.int * 100 / r$estimate[1]
        if ((p[1] > 0 && p[2] < 0) || (p[1] < 0 && p[2] > 0)) {
            s <- sprintf("mem%d dist%d: no significance", mem, dist)
        } else {
            s <- sprintf("mem%d dist%d: [%.2f, %.2f]%%", mem, dist, -p[2], -p[1])
        }
        print(s)
    }
}

# 50g vs 60g
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

$ R -q -s -f raw_data_mongodb.r

        Welch Two Sample t-test

data:  a[, dist, mem, 1] and a[, dist, mem, 2]
t = -9.8624, df = 17.23, p-value = 1.671e-08
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -2637.627 -1708.769
sample estimates:
mean of x mean of y
 76615.56  78788.76

[1] "mem1 dist1: [2.23, 3.44]%"

        Welch Two Sample t-test

data:  a[, dist, mem, 1] and a[, dist, mem, 2]
t = -13.081, df = 12.744, p-value = 9.287e-09
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -6040.256 -4324.964
sample estimates:
mean of x mean of y
 62093.40  67276.01

[1] "mem1 dist2: [6.97, 9.73]%"

        Welch Two Sample t-test

data:  a[, dist, mem, 1] and a[, dist, mem, 2]
t = -8.8194, df = 13.459, p-value = 5.833e-07
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -3287.17 -1997.20
sample estimates:
mean of x mean of y
 92532.25  95174.43

[1] "mem1 dist3: [2.16, 3.55]%"

        Welch Two Sample t-test

data:  a[, dist, mem, 1] and a[, dist, mem, 2]
t = -33.368, df = 16.192, p-value = 2.329e-16
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -7419.582 -6533.942
sample estimates:
mean of x mean of y
 73984.90  80961.66

[1] "mem2 dist1: [8.83, 10.03]%"

        Welch Two Sample t-test

data:  a[, dist, mem, 1] and a[, dist, mem, 2]
t = -46.386, df = 16.338, p-value < 2.2e-16
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -12954.62 -11824.09
sample estimates:
mean of x mean of y
 55990.56  68379.91

[1] "mem2 dist2: [21.12, 23.14]%"

        Welch Two Sample t-test

data:  a[, dist, mem, 1] and a[, dist, mem, 2]
t = -27.844, df = 13.209, p-value = 4.049e-13
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -6039.729 -5171.275
sample estimates:
mean of x mean of y
 93545.62  99151.12

[1] "mem2 dist3: [5.53, 6.46]%"

        Welch Two Sample t-test

data:  a[, dist, 1, kern] and a[, dist, 2, kern]
t = 10.87, df = 18, p-value = 2.439e-09
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 2122.207 3139.125
sample estimates:
mean of x mean of y
 76615.56  73984.90

[1] "kern1 dist1: [-4.10, -2.77]%"

        Welch Two Sample t-test

data:  a[, dist, 1, kern] and a[, dist, 2, kern]
t = 15.593, df = 12.276, p-value = 1.847e-09
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 5252.237 6953.447
sample estimates:
mean of x mean of y
 62093.40  55990.56

[1] "kern1 dist2: [-11.20, -8.46]%"

        Welch Two Sample t-test

data:  a[, dist, 1, kern] and a[, dist, 2, kern]
t = -3.1512, df = 15.811, p-value = 0.006252
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -1695.7509  -330.9911
sample estimates:
mean of x mean of y
 92532.25  93545.62

[1] "kern1 dist3: [0.36, 1.83]%"

        Welch Two Sample t-test

data:  a[, dist, 1, kern] and a[, dist, 2, kern]
t = -11.836, df = 17.672, p-value = 7.84e-10
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -2559.092 -1786.704
sample estimates:
mean of x mean of y
 78788.76  80961.66

[1] "kern2 dist1: [2.27, 3.25]%"

        Welch Two Sample t-test

data:  a[, dist, 1, kern] and a[, dist, 2, kern]
t = -4.0276, df = 16.921, p-value = 0.0008807
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -1682.3864  -525.4236
sample estimates:
mean of x mean of y
 67276.01  68379.91

[1] "kern2 dist2: [0.78, 2.50]%"

        Welch Two Sample t-test

data:  a[, dist, 1, kern] and a[, dist, 2, kern]
t = -24.26, df = 15.517, p-value = 9.257e-14
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -4325.062 -3628.314
sample estimates:
mean of x mean of y
 95174.43  99151.12

[1] "kern2 dist3: [3.81, 4.54]%"
