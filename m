Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DF544248F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 01:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhKBAWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 20:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhKBAWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 20:22:44 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FDAC061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 17:20:09 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id o12so6733067qtv.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 17:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edi.works; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tR1/30cvDfOtIR34b4k4ClDZHww95hp+zKlZOFEq2JQ=;
        b=DAcQ5/Xsi5s9DlvrYj12WbVhrq/fkIqQnNXRqltHDf2qKXvmRN6tj2WHEaPafFZVOq
         +f+aTRXWdoaCr0Z1szNaGryTAe+1g0PxiiCul9B6H343d0PZ/6PevDlSsFJ3lBm7TCwz
         irKBuA2dmEQehC937OvatwelwEFYAmKmXONM5/dB3YvYXE4sQ7F/kEJHzL4yIyNrccWm
         iJMvUqqhkvpop4e76Og3mFHUcxrXzOwo+jiVC6c86g0pLH3mc0rrwu6wpEJe7RgM74J5
         ZqQP4ejz6C/BDkYUvepjmXYZKTilcETlfK8qHbWA6O6eSx/0bcY9WMvVsLsNj8mqR9Ge
         OaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tR1/30cvDfOtIR34b4k4ClDZHww95hp+zKlZOFEq2JQ=;
        b=OOlKSKY90pTDplY8OnqXhHsO+O6MbO7pmFoe+hZVB39D4KRfuf1wAp/AKuUYZezFX4
         IWP2e3Eh/V65LKHM/2QpDod9yqDmBGMhAs358sSEZY31RhGRn/+Lcat6DdqpKQEg1bgH
         +suyMFmzJcQBXeYSJs0yX37sSVh84cZVweaQYC3D6XF8CXUtNk7A3C0PdG8S4/cg7TcD
         tEZaOW4TXatg0ybRi9TF1fvMwj2F87XWzUCjn3HdLz4v4O3p98ep6LvogYAb2FKX8aE/
         03ujFTpQsd5ZjCLDpBO0FpG0PUASfErnQxaQEk9YYn+dQLtBiSNFQDIYr/CZGDz6Dl5g
         BAGQ==
X-Gm-Message-State: AOAM531dzzGmCHqzkJnCrzmj/8UPDeIBH/iT+nG+ZkxVeqKKagYpxCxo
        NgaWCMxhmqO1G4YAG7qwXMt3Zg==
X-Google-Smtp-Source: ABdhPJzmSPqeNNqfdNL7ckbCOVwM6H1394wvZSJnJil/u9nRo5BjZ9FQgwSef8OFJzdw3cbormxb2Q==
X-Received: by 2002:ac8:7f81:: with SMTP id z1mr10507176qtj.40.1635812408626;
        Mon, 01 Nov 2021 17:20:08 -0700 (PDT)
Received: from localhost.localdomain (c-67-169-44-201.hsd1.ca.comcast.net. [67.169.44.201])
        by smtp.gmail.com with ESMTPSA id g1sm10793909qkd.89.2021.11.01.17.20.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Nov 2021 17:20:08 -0700 (PDT)
From:   bot@edi.works
To:     yuzhao@google.com
Cc:     hdanton@sina.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, corbet@lwn.net,
        michael@michaellarabel.com, sofia.trinh@edi.works
Subject: Re: [PATCH v4 00/11] Multigenerational LRU Framework
Date:   Mon,  1 Nov 2021 17:20:02 -0700
Message-Id: <20211102002002.92051-1-bot@edi.works>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210818063107.2696454-1-yuzhao@google.com>
References: <20210818063107.2696454-1-yuzhao@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel / Apache Spark benchmark with MGLRU

TLDR
====
With the MGLRU, Apache Spark took 95% CIs [9.28, 11.19]% and [12.20,
14.93]% less wall time to sort 3 billion random integers,
respectively, under the medium- and high-concurrency conditions when
slightly overcommitting memory. There were no statistically
significant changes in wall time when sorting the same dataset under
other conditions.

Background
==========
Memory overcommit can increase utilization and, if carried out
properly, can also increase throughput. The challenges are to improve
working set estimation and to optimize page reclaim. The risks are
performance degradations and OOM kills. Short of overcoming the
challenges, the only way to reduce the risks is to underutilize
memory.

Apache Spark is one of the most popular open-source big-data
frameworks. Dataset sorting is the most widely used benchmark for
such frameworks.

Matrix
======
Kernels: version [+ patchset]
* Baseline: 5.14
* Patched: 5.14 + MGLRU

Memory conditions: % of memory size
* Underutilizing: ~10% on inactive file list
* Overcommitting: ~10% swapped out

Concurrency conditions: average # of workers per CPU
* Low: 1
* Medium: 2
* High: 3

Cluster mode: local
Dataset size: 3 billion random integers (57GB text)

Total configurations: 12
Data points per configuration: 10
Total run duration (minutes) per data point: ~20

Procedure
=========
The latest MGLRU patchset for the 5.14 kernel is available at
git fetch https://linux-mm.googlesource.com/page-reclaim \
    refs/changes/30/1430/1

Baseline and patched 5.14 kernel images are available at
https://drive.google.com/drive/folders/1eMkQleAFGkP2vzM_JyRA21oKE0ESHBqp

<install and configure OS>
spark-shell < gen.scala

<for each kernel>
    grub2-set-default <baseline, patched>
    <for each memory condition>
        <update run_spark.sh>
        <for each concurrency condition>
            <update run_spark.sh>
            <for each data point>
                reboot
                run_spark.sh
                <collect wall time>

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

Apache Spark
============
$ spark-shell --version
Welcome to
      ____              __
     / __/__  ___ _____/ /__
    _\ \/ _ \/ _ `/ __/  '_/
   /___/ .__/\_,_/_/ /_/\_\   version 3.1.2
      /_/

Using Scala version 2.12.10, OpenJDK 64-Bit Server VM, 11.0.12
Branch HEAD
Compiled by user centos on 2021-05-24T04:27:48Z
Revision de351e30a90dd988b133b3d00fa6218bfcaba8b8
Url https://github.com/apache/spark
Type --help for more information.

$ cat gen.scala
import java.io._
import scala.collection.mutable.ArrayBuffer

object GenData {
    def main(args: Array[String]): Unit = {
        val file = new File("dataset.txt")
        val writer = new BufferedWriter(new FileWriter(file))
        val buf = ArrayBuffer(0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L)
        for(_ <- 0 until 300000000) {
            for (i <- 0 until 10) {
                buf.update(i, scala.util.Random.nextLong())
            }
            writer.write(s"${buf.mkString(",")}\n")
        }
        writer.close()
    }
}
GenData.main(Array())

$ cat sort.scala
import java.time.temporal.ChronoUnit
import org.apache.spark.sql.SparkSession

object SparkSort {
    def main(args: Array[String]): Unit = {
        val spark = SparkSession.builder().getOrCreate()
        val file = sc.textFile("dataset.txt", 32)
        val start = java.time.Instant.now()
        val results = file.flatMap(_.split(",")).map(x => (x, 1)).sortByKey().takeOrdered(10)
        val finish = java.time.Instant.now()
        println(s"wall time: ${ChronoUnit.SECONDS.between(start, finish)}")
        results.foreach(println)
        spark.stop()
    }
}
SparkSort.main(Array())

$ cat run_spark.sh
spark-shell --master local\[<32, 64, 96>\] --driver-memory <52G, 62G> < sort.scala

Results
=======
Comparing the patched with the baseline kernel, Apache Spark took 95%
CIs [9.28, 11.19]% and [12.20, 14.93]% less wall time to sort the
dataset, respectively, under the medium- and high-concurrency
conditions when slightly overcommitting memory. There were no
statistically significant changes in wall time under other conditions.

+--------------------+-----------------------+-----------------------+
| Mean wall time (s) | Underutilizing memory | Overcommitting memory |
| [95% CI]           |                       |                       |
+--------------------+-----------------------+-----------------------+
| Low concurrency    | 1037.1 / 1037.0       | 1038.2 / 1036.6       |
|                    | [-1.41, 1.21]         | [-3.67, 0.47]         |
+--------------------+-----------------------+-----------------------+
| Medium concurrency | 1141.8 / 1142.6       | 1297.9 / 1165.1       |
|                    | [-1.35, 2.95]         | [-145.21, -120.38]    |
+--------------------+-----------------------+-----------------------+
| High concurrency   | 1239.3 / 1236.4       | 1456.8 / 1259.2       |
|                    | [-7.81, 2.01]         | [-217.53, -177.66]    |
+--------------------+-----------------------+-----------------------+
Table 1. Comparison between the baseline and patched kernels

Comparing overcommitting with underutilizing memory, Apache Spark
took 95% CIs [12.58, 14.76]% and [15.95, 19.15]% more wall time to
sort the dataset, respectively, under the low- and medium-concurrency
conditions when using the baseline kernel; 95% CIs [1.78, 2.16]% and
[1.42, 2.27]% more wall time, respectively, under the medium- and
high-concurrency conditions when using the patched kernel. There were
no statistically significant changes in wall time under other
conditions.

+--------------------+------------------------+----------------------+
| Mean wall time (s) | Baseline kernel        | Patched kernel       |
| [95% CI]           |                        |                      |
+--------------------+------------------------+----------------------+
| Low concurrency    | 1037.1 / 1038.2        | 1037.0 / 1036.6      |
|                    | [-0.31, 2.51]          | [-2.43, 1.63]        |
+--------------------+------------------------+----------------------+
| Medium concurrency | 1141.8 / 1297.9        | 1142.6 / 1165.1      |
|                    | [143.68, 168.51]       | [20.33, 24.66]       |
+--------------------+------------------------+----------------------+
| High concurrency   | 1239.3 / 1456.8        | 1236.4 / 1259.2      |
|                    | [197.62, 237.37]       | [17.55, 28.04]       |
+--------------------+------------------------+----------------------+
Table 2. Comparison between underutilizing and overcommitting memory

Metrics collected during each run are available at
https://github.com/ediworks/KernelPerf/tree/master/mglru/spark/5.14

Appendix
========
$ cat raw_data_spark.r
v <- c(
    # baseline 52g 32t
    1034, 1036, 1036, 1037, 1037, 1037, 1038, 1038, 1038, 1040,
    # baseline 52g 64t
    1139, 1139, 1140, 1140, 1142, 1143, 1143, 1144, 1144, 1144,
    # baseline 52g 96t
    1236, 1237, 1238, 1238, 1238, 1239, 1240, 1241, 1243, 1243,
    # baseline 62g 32t
    1036, 1036, 1038, 1038, 1038, 1038, 1039, 1039, 1040, 1040,
    # baseline 62g 64t
    1266, 1277, 1284, 1296, 1299, 1302, 1311, 1313, 1314, 1317,
    # baseline 62g 96t
    1403, 1431, 1440, 1447, 1460, 1461, 1467, 1475, 1487, 1497,
    # patched 52g 32t
    1035, 1036, 1036, 1037, 1037, 1037, 1037, 1038, 1038, 1039,
    # patched 52g 64t
    1138, 1140, 1140, 1143, 1143, 1143, 1144, 1145, 1145, 1145,
    # patched 52g 96t
    1228, 1228, 1233, 1234, 1235, 1236, 1236, 1240, 1246, 1248,
    # patched 62g 32t
    1032, 1035, 1035, 1035, 1036, 1036, 1037, 1039, 1040, 1041,
    # patched 62g 64t
    1162, 1164, 1164, 1164, 1164, 1164, 1166, 1166, 1168, 1169,
    # patched 62g 96t
    1252, 1256, 1256, 1258, 1260, 1260, 1260, 1260, 1265, 1265
)

a <- array(v, dim = c(10, 3, 2, 2))

# baseline vs patched
for (mem in 1:2) {
    for (con in 1:3) {
        r <- t.test(a[, con, mem, 1], a[, con, mem, 2])
        print(r)

        p <- r$conf.int * 100 / r$estimate[1]
        if ((p[1] > 0 && p[2] < 0) || (p[1] < 0 && p[2] > 0)) {
            s <- sprintf("mem%d con%d: no significance", mem, con)
        } else {
            s <- sprintf("mem%d con%d: [%.2f, %.2f]%%", mem, con, -p[2], -p[1])
        }
        print(s)
    }
}

# 52g vs 62g
for (ker in 1:2) {
    for (con in 1:3) {
        r <- t.test(a[, con, 1, ker], a[, con, 2, ker])
        print(r)

        p <- r$conf.int * 100 / r$estimate[1]
        if ((p[1] > 0 && p[2] < 0) || (p[1] < 0 && p[2] > 0)) {
            s <- sprintf("ker%d con%d: no significance", ker, con)
        } else {
            s <- sprintf("ker%d con%d: [%.2f, %.2f]%%", ker, con, -p[2], -p[1])
        }
        print(s)
    }
}

$ R -q -s -f raw_data_spark.r

        Welch Two Sample t-test

data:  a[, con, mem, 1] and a[, con, mem, 2]
t = 0.16059, df = 16.4, p-value = 0.8744
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -1.21749  1.41749
sample estimates:
mean of x mean of y
   1037.1    1037.0

[1] "mem1 con1: no significance"

        Welch Two Sample t-test

data:  a[, con, mem, 1] and a[, con, mem, 2]
t = -0.78279, df = 17.565, p-value = 0.4442
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -2.950923  1.350923
sample estimates:
mean of x mean of y
   1141.8    1142.6

[1] "mem1 con2: no significance"

        Welch Two Sample t-test

data:  a[, con, mem, 1] and a[, con, mem, 2]
t = 1.2933, df = 11.303, p-value = 0.2217
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -2.019103  7.819103
sample estimates:
mean of x mean of y
   1239.3    1236.4

[1] "mem1 con3: no significance"

        Welch Two Sample t-test

data:  a[, con, mem, 1] and a[, con, mem, 2]
t = 1.6562, df = 13.458, p-value = 0.1208
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -0.4799188  3.6799188
sample estimates:
mean of x mean of y
   1038.2    1036.6

[1] "mem2 con1: no significance"

        Welch Two Sample t-test

data:  a[, con, mem, 1] and a[, con, mem, 2]
t = 24.096, df = 9.2733, p-value = 1.115e-09
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 120.3881 145.2119
sample estimates:
mean of x mean of y
   1297.9    1165.1

[1] "mem2 con2: [-11.19, -9.28]%"

        Welch Two Sample t-test

data:  a[, con, mem, 1] and a[, con, mem, 2]
t = 22.289, df = 9.3728, p-value = 1.944e-09
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 177.6666 217.5334
sample estimates:
mean of x mean of y
   1456.8    1259.2

[1] "mem2 con3: [-14.93, -12.20]%"

        Welch Two Sample t-test

data:  a[, con, 1, ker] and a[, con, 2, ker]
t = -1.6398, df = 17.697, p-value = 0.1187
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -2.5110734  0.3110734
sample estimates:
mean of x mean of y
   1037.1    1038.2

[1] "ker1 con1: no significance"

        Welch Two Sample t-test

data:  a[, con, 1, ker] and a[, con, 2, ker]
t = -28.33, df = 9.2646, p-value = 2.57e-10
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -168.5106 -143.6894
sample estimates:
mean of x mean of y
   1141.8    1297.9

[1] "ker1 con2: [12.58, 14.76]%"

        Welch Two Sample t-test

data:  a[, con, 1, ker] and a[, con, 2, ker]
t = -24.694, df = 9.1353, p-value = 1.12e-09
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -237.3794 -197.6206
sample estimates:
mean of x mean of y
   1239.3    1456.8

[1] "ker1 con3: [15.95, 19.15]%"

        Welch Two Sample t-test

data:  a[, con, 1, ker] and a[, con, 2, ker]
t = 0.42857, df = 12.15, p-value = 0.6757
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -1.630775  2.430775
sample estimates:
mean of x mean of y
   1037.0    1036.6

[1] "ker2 con1: no significance"

        Welch Two Sample t-test

data:  a[, con, 1, ker] and a[, con, 2, ker]
t = -21.865, df = 17.646, p-value = 3.151e-14
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -24.66501 -20.33499
sample estimates:
mean of x mean of y
   1142.6    1165.1

[1] "ker2 con2: [1.78, 2.16]%"

        Welch Two Sample t-test

data:  a[, con, 1, ker] and a[, con, 2, ker]
t = -9.2738, df = 14.72, p-value = 1.561e-07
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -28.04897 -17.55103
sample estimates:
mean of x mean of y
   1236.4    1259.2

[1] "ker2 con3: [1.42, 2.27]%"
