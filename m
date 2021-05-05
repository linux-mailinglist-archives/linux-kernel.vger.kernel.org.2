Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BFA37394A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 13:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbhEEL2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 07:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhEEL2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 07:28:10 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BC6C061574;
        Wed,  5 May 2021 04:27:14 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id l129so1072486qke.8;
        Wed, 05 May 2021 04:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=gPADgVh5krNRNUX1muKGl2CiIc7g7KCS79IVQpyvN94=;
        b=h2r/A6x14WtOm+/3a1IpQpLTzkGFyUum2eUt/g72xRfLH3unQViCnKCm7pWTFP4RkU
         CKn/3KO1TWq3AxwlQ+Lf1QuuCBBmGR+vtPo+SsjQux8hUfQLoeYty7fvA73B3P52Z3Uc
         SSCIntccNz0nK0xUsSmogwVuZ8LguiV9ZJ7iX6HBnrWnihW9dQw5Bhf3NjkfGoP2IM94
         Ggn31Pqf2BvjaRszKfoAn3AivQV7OVRk6OxuEOCLy5OJM8/5MULcw8QuxTm5VETtrjZC
         2byKdMqaivSEbNAeyZr4xWLuU9IRIbBmxI/DZshLte63IsDzgFip1WLn27/y0+1LFpcA
         j2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=gPADgVh5krNRNUX1muKGl2CiIc7g7KCS79IVQpyvN94=;
        b=d8iWZcpXZ81zuTOot7vhXpOlDg8aEWcEsqz2ZLY8HSju3ET94Y+JL1K+/5cxCepBe6
         UMB8VB++7bYei3BAOpt728i793xt3GosOkHscIbj7yS3tHXonWs+QPsGBqgQ389gKuZB
         pNRpj55VOv7JyfCJvsXXRmYIDHRYANOAKXlH0V+byETEy4X/9EmYZumwoA4+czUkcSQx
         pLp+CPP/egH4rLn73c/68iLp3JEfwgmc3JMQSeS4t/KioYvC9LUOhfujkS6PkdzSApIb
         8T/0t0SWF3JGPI/JN4q3tRK7/fa9zTsOXa4w856n2RYdvjKE7oc9sNPnIwSc+EO4BaRy
         AgTQ==
X-Gm-Message-State: AOAM533fHFyKncdI8etg1GGZ437oCHXwHhtikXXnUgsCe/c0gB5i6eyn
        dRIglNK+ipKDg5UNOm11J0o=
X-Google-Smtp-Source: ABdhPJxMslouST2uxu94Nmqw3EOEE+SHgKAKkcWnQ+3fTR9AyvhfLaWDYN1LzejFYsQ3WK8bBIoxow==
X-Received: by 2002:a05:620a:1442:: with SMTP id i2mr11864379qkl.45.1620214032799;
        Wed, 05 May 2021 04:27:12 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id d3sm4661270qtm.56.2021.05.05.04.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 04:27:12 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     akpm@linux-foundation.org, Jonathan.Cameron@Huawei.com,
        aarcange@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendan.d.gregg@gmail.com,
        brendanhiggins@google.com, cai@lca.pw, colin.king@canonical.com,
        corbet@lwn.net, david@redhat.com, dwmw@amazon.com,
        elver@google.com, fan.du@intel.com, foersleo@amazon.de,
        gthelen@google.com, irogers@google.com, jolsa@redhat.com,
        kirill@shutemov.name, mark.rutland@arm.com, mgorman@suse.de,
        minchan@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, rdunlap@infradead.org, riel@surriel.com,
        rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org,
        sblbir@amazon.com, shakeelb@google.com, shuah@kernel.org,
        sj38.park@gmail.com, snu@amazon.de, vbabka@suse.cz,
        vdavydov.dev@gmail.com, yang.shi@linux.alibaba.com,
        ying.huang@intel.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: DAMON-based Proactive Reclamation for The Physical Address Space
Date:   Wed,  5 May 2021 11:26:59 +0000
Message-Id: <20210505112659.4172-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201216094221.11898-1-sjpark@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Wed, 16 Dec 2020 10:42:08 +0100 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> NOTE: This is only an RFC for future features of DAMON patchset[1], which is
> not merged in the mainline yet.  The aim of this RFC is to show how DAMON would
> be evolved once it is merged in.  So, if you have some interest in this RFC,
> please consider reviewing the DAMON patchset, either.
> 
[...]

TL; DR: I confirmed DAMON's physical address monitoring works effectively by
implementing a proactive reclamation system using DAMON and evaluating it with
24 realistic workloads.

DAMON's overhead control logics, namely 'region-based sampling' and 'adaptive
regions adjustment', are based on an assumption.  That is, there would be a
number of memory regions that pages in each region having similar access
frequency.  In other words, a sort of spatial locality.

This made some people concerned about the accuracy of physical address space
monitoring.  In detail, because any process in the system can make access to
the physical address space, the pattern would be more chaotic and randomic than
virtual address spaces.  As a result, the spatial locality assumption is broken
and DAMON will give only poor quality monitoring results.

I'd argue such case will be very rare in real.  After all, the assumption-based
logics are only optional[1].  I also confirmed the physical address space
monitoring results are accurate enough for basic profiling, with real
production systems[2] and my test workloads.

In the past, I shown the effectiveness of the DAMON's virtual address space
monitoring with the monitoring-based proactive reclamation[3].  I call the
implementation 'prcl'.  To show the effectiveness of the DAMON's physical
address space monitoring and convince some more people, I did same work again,
for the physical address space monitoring.  That is, I implemented a physical
address space monitoring-based version of the proactive reclamation ('pprcl')
and evaluated it's performance with 24 realistic workloads.  The setup is
almost same to the previously shared one[3].

In detail, 'pprcl' finds memory regions in physical address space that didn't
accessed for >=5 seconds and reclaim those.  'prcl' is similar but finds the
regions from the virtual address space of the target workload, and the
threshold time is tuned for each workload, so that it wouldn't incur too high
runtime overhead.


Reduction of Workload's Residential Sets
-----------------------------------------

Below shows the averaged RSS of each workload on the systems.

rss.avg                 orig         prcl         (overhead) pprcl        (overhead)
parsec3/blackscholes    588658.400   255710.400   (-56.56)   291570.800   (-50.47)
parsec3/bodytrack       32286.600    6714.200     (-79.20)   29023.200    (-10.11)
parsec3/canneal         841353.400   841823.600   (0.06)     841721.800   (0.04)
parsec3/dedup           1163860.000  561526.200   (-51.75)   922990.000   (-20.70)
parsec3/facesim         311657.800   191045.600   (-38.70)   188238.200   (-39.60)
parsec3/fluidanimate    531832.000   415361.600   (-21.90)   418925.800   (-21.23)
parsec3/freqmine        552641.400   37270.000    (-93.26)   66849.800    (-87.90)
parsec3/raytrace        885486.400   296335.800   (-66.53)   360111.000   (-59.33)
parsec3/streamcluster   110838.200   109961.000   (-0.79)    108288.600   (-2.30)
parsec3/swaptions       5697.600     3575.200     (-37.25)   1982.600     (-65.20)
parsec3/vips            31849.200    27923.400    (-12.33)   29194.000    (-8.34)
parsec3/x264            81749.800    81936.600    (0.23)     80098.600    (-2.02)
splash2x/barnes         1217412.400  681704.000   (-44.00)   825071.200   (-32.23)
splash2x/fft            10055745.800 8948474.600  (-11.01)   9049028.600  (-10.01)
splash2x/lu_cb          511975.400   338240.000   (-33.93)   343283.200   (-32.95)
splash2x/lu_ncb         511459.000   406830.400   (-20.46)   392444.400   (-23.27)
splash2x/ocean_cp       3384642.800  3413014.800  (0.84)     3377972.000  (-0.20)
splash2x/ocean_ncp      3943689.400  3950712.800  (0.18)     3896549.800  (-1.20)
splash2x/radiosity      1472601.000  96327.400    (-93.46)   245859.800   (-83.30)
splash2x/radix          2419770.000  2467029.400  (1.95)     2416935.600  (-0.12)
splash2x/raytrace       23297.600    5559.200     (-76.14)   12799.000    (-45.06)
splash2x/volrend        44117.400    16930.400    (-61.62)   20800.400    (-52.85)
splash2x/water_nsquared 29403.200    13191.400    (-55.14)   25244.400    (-14.14)
splash2x/water_spatial  663455.600   258882.000   (-60.98)   479496.000   (-27.73)
total                   29415600.000 23426082.000 (-20.36)   24424396.000 (-16.97)
average                 1225650.000  976087.000   (-37.99)   1017680.000  (-28.76)

On average, 'prcl' saved 37.99% of memory, while 'pprcl' saved 28.76%.  The
memory saving of 'pprcl' is smaller than that of 'prcl', though the difference
is not significant.  Note that this machine has about 130 GiB memory, which is
much larger than the RSS of the workloads (only about 1.2 GiB on average).  I
believe this fact made the accuracy of the physical address monitoring worse
than the virtual address monitoring.  Compared to the monitoring scope increase
(about 100x), the accuracy degradation is very small.


System Global Memory Saving
---------------------------

I further measured the amount of free memory of the system to calculate the
system global memory footprint.

memused.avg             orig         prcl         (overhead) pprcl        (overhead)
parsec3/blackscholes    1838734.200  1617375.000  (-12.04)   321902.200   (-82.49)
parsec3/bodytrack       1436094.400  1451703.200  (1.09)     256972.600   (-82.11)
parsec3/canneal         1048424.600  1062165.200  (1.31)     885787.600   (-15.51)
parsec3/dedup           2526629.800  2506042.600  (-0.81)    1777099.400  (-29.67)
parsec3/facesim         546595.800   494834.200   (-9.47)    243344.600   (-55.48)
parsec3/fluidanimate    581078.800   484461.200   (-16.63)   409179.000   (-29.58)
parsec3/freqmine        994034.000   760863.000   (-23.46)   320619.200   (-67.75)
parsec3/raytrace        1753114.800  1565592.600  (-10.70)   703991.600   (-59.84)
parsec3/streamcluster   128533.400   142138.200   (10.58)    100322.200   (-21.95)
parsec3/swaptions       22869.200    40935.000    (79.00)    -11221.800   (-149.07)
parsec3/vips            2992238.000  2948726.000  (-1.45)    479531.000   (-83.97)
parsec3/x264            3250209.000  3273603.400  (0.72)     691699.400   (-78.72)
splash2x/barnes         1220499.800  955857.200   (-21.68)   978864.800   (-19.80)
splash2x/fft            9674473.000  9803918.800  (1.34)     10242764.800 (5.87)
splash2x/lu_cb          521333.400   365105.200   (-29.97)   323198.200   (-38.01)
splash2x/lu_ncb         521936.200   431906.000   (-17.25)   384663.200   (-26.30)
splash2x/ocean_cp       3295293.800  3311071.800  (0.48)     3281148.000  (-0.43)
splash2x/ocean_ncp      3917407.800  3926460.000  (0.23)     3871557.000  (-1.17)
splash2x/radiosity      1472602.400  431091.600   (-70.73)   496768.400   (-66.27)
splash2x/radix          2394703.600  2340372.000  (-2.27)    2494416.400  (4.16)
splash2x/raytrace       52380.400    61028.200    (16.51)    4832.600     (-90.77)
splash2x/volrend        159425.800   167845.600   (5.28)     36449.600    (-77.14)
splash2x/water_nsquared 50912.200    69023.600    (35.57)    12645.200    (-75.16)
splash2x/water_spatial  681121.200   382255.200   (-43.88)   516789.200   (-24.13)
total                   41080500.000 38594500.000 (-6.05)    28823200.000 (-29.84)
average                 1711690.000  1608100.000  (-4.51)    1200970.000  (-48.55)

On average, 'pprcl' (48.55 %) saved about 10 times more memory than 'prcl'
(4.51 %).  I believe this is because 'pprcl' can reclaim any system memory
while 'prcl' can do that for only the memory mapped to the workload.


Runtime Overhead
----------------

I also measured the runtime of each workload, because the proactive reclamation
could make workloads slowed down.  Note that we used 'zram' as a swap device[3]
to minimize the degradation.

runtime                 orig     prcl     (overhead) pprcl    (overhead)
parsec3/blackscholes    138.566  146.351  (5.62)     139.731  (0.84)
parsec3/bodytrack       125.359  141.542  (12.91)    127.269  (1.52)
parsec3/canneal         203.778  216.348  (6.17)     225.055  (10.44)
parsec3/dedup           18.261   20.552   (12.55)    19.662   (7.67)
parsec3/facesim         338.071  367.367  (8.67)     344.212  (1.82)
parsec3/fluidanimate    341.858  341.465  (-0.11)    332.765  (-2.66)
parsec3/freqmine        437.206  449.147  (2.73)     444.311  (1.63)
parsec3/raytrace        185.744  201.641  (8.56)     186.037  (0.16)
parsec3/streamcluster   640.900  680.466  (6.17)     637.582  (-0.52)
parsec3/swaptions       220.612  223.065  (1.11)     221.809  (0.54)
parsec3/vips            87.661   91.613   (4.51)     94.582   (7.89)
parsec3/x264            114.661  125.278  (9.26)     112.389  (-1.98)
splash2x/barnes         128.298  145.497  (13.41)    139.424  (8.67)
splash2x/fft            58.677   64.417   (9.78)     76.932   (31.11)
splash2x/lu_cb          133.660  138.980  (3.98)     133.222  (-0.33)
splash2x/lu_ncb         148.260  151.129  (1.93)     152.448  (2.82)
splash2x/ocean_cp       75.966   76.765   (1.05)     76.880   (1.20)
splash2x/ocean_ncp      153.289  162.596  (6.07)     172.197  (12.33)
splash2x/radiosity      143.191  154.972  (8.23)     148.913  (4.00)
splash2x/radix          51.190   51.030   (-0.31)    61.811   (20.75)
splash2x/raytrace       133.835  147.047  (9.87)     135.699  (1.39)
splash2x/volrend        120.789  129.783  (7.45)     121.455  (0.55)
splash2x/water_nsquared 370.232  424.013  (14.53)    378.424  (2.21)
splash2x/water_spatial  132.444  151.769  (14.59)    146.471  (10.59)
total                   4502.510 4802.850 (6.67)     4629.270 (2.82)
average                 187.605  200.119  (7.03)     192.886  (5.11)

On average, 'pprcl' outperforms 'prcl' again, though the difference is only
small.  'pprcl' incurs 5.11% slowdown to the workload, while 'prcl' incurs
7.03% slowdown.

Nevertheless, because the reclamation threshold (5 seconds) of 'pprcl' is not
tuned for each workload, it sometimes do too aggressive reclamation and
therefore incur high runtime overhead to some workloads, including splash2x/fft
(31.11%) and splash2x/radix (20.75%).  In contrast, the worst-case runtime
overhead of 'prcl' is only 14.59% (splash2x/water_spatial) because it uses
different tuned thresholds that tuned for each workload.


Conclusion
----------

Based on the above results, I argue that DAMON's overhead control mechanism can
be effective enough for the physical address space.

Nonetheless, note that DAMON is a framework for general access monitoring of
any address space, and the overhead control logic is only optional.  You can
always disable it if it doesn't make sense for your specific use case.

If this results make you interested, please consider reviewing the DAMON
patchset[2].


[1] https://lore.kernel.org/linux-mm/20201216094221.11898-14-sjpark@amazon.com/
[2] https://lore.kernel.org/linux-mm/20210413142904.556-1-sj38.park@gmail.com/
[3] https://damonitor.github.io/doc/html/latest/vm/damon/eval.html#proactive-reclamation


Thanks,
SeongJae Park
