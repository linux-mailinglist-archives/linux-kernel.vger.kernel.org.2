Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F27830BD4C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 12:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhBBLll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 06:41:41 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:39012 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229815AbhBBLlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 06:41:40 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0UNfuMGc_1612266041;
Received: from localhost(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0UNfuMGc_1612266041)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Feb 2021 19:40:42 +0800
From:   Huaixin Chang <changhuaixin@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     changhuaixin@linux.alibaba.com, bsegall@google.com,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        khlebnikov@yandex-team.ru, mgorman@suse.de, mingo@redhat.com,
        pauld@redhead.com, peterz@infradead.org, pjt@google.com,
        rostedt@goodmis.org, shanpeic@linux.alibaba.com,
        vincent.guittot@linaro.org, xiyou.wangcong@gmail.com
Subject: [PATCH 0/4] sched/fair: Burstable CFS bandwidth controller
Date:   Tue,  2 Feb 2021 19:40:34 +0800
Message-Id: <20210202114038.64870-1-changhuaixin@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is rebased upon v5.11-rc6.
Previous archive:
https://lore.kernel.org/lkml/20201217074620.58338-1-changhuaixin@linux.alibaba.com/

The CFS bandwidth controller limits CPU requests of a task group to
quota during each period. However, parallel workloads might be bursty
so that they get throttled. And they are latency sensitive at the same
time so that throttling them is undesired.

Scaling up period and quota allows greater burst capacity. But it might
cause longer stuck till next refill. We introduce "burst" to allow
accumulating unused quota from previous periods, and to be assigned when
a task group requests more CPU than quota during a specific period. Thus
allowing CPU time requests as long as the average requested CPU time is
below quota on the long run. The maximum accumulation is capped by burst
and is set 0 by default, thus the traditional behaviour remains.

A huge drop of 99th tail latency from more than 500ms to 27ms is seen for
real java workloads when using burst. Similar drops are seen when
testing with schbench too:

	echo $$ > /sys/fs/cgroup/cpu/test/cgroup.procs
	echo 700000 > /sys/fs/cgroup/cpu/test/cpu.cfs_quota_us
	echo 100000 > /sys/fs/cgroup/cpu/test/cpu.cfs_period_us
	echo 400000 > /sys/fs/cgroup/cpu/test/cpu.cfs_burst_us

	# The average CPU usage is around 500%, which is 200ms CPU time
	# every 40ms.
	./schbench -m 1 -t 30 -r 60 -c 10000 -R 500

	Without burst:

	Latency percentiles (usec)
	50.0000th: 7
	75.0000th: 8
	90.0000th: 9
	95.0000th: 10
	*99.0000th: 933
	99.5000th: 981
	99.9000th: 3068
	min=0, max=20054
	rps: 498.31 p95 (usec) 10 p99 (usec) 933 p95/cputime 0.10% p99/cputime 9.33%

	With burst:

	Latency percentiles (usec)
	50.0000th: 7
	75.0000th: 8
	90.0000th: 9
	95.0000th: 9
	*99.0000th: 12
	99.5000th: 13
	99.9000th: 19
	min=0, max=406
	rps: 498.36 p95 (usec) 9 p99 (usec) 12 p95/cputime 0.09% p99/cputime 0.12%

How much workloads with benefit from burstable CFS bandwidth control
depends on how bursty and how latency sensitive they are.

Previously, Cong Wang and Konstantin Khlebnikov proposed similar
feature:
https://lore.kernel.org/lkml/20180522062017.5193-1-xiyou.wangcong@gmail.com/
https://lore.kernel.org/lkml/157476581065.5793.4518979877345136813.stgit@buzz/

This time we present more latency statistics and handle overflow while
accumulating.

Huaixin Chang (4):
  sched/fair: Introduce primitives for CFS bandwidth burst
  sched/fair: Make CFS bandwidth controller burstable
  sched/fair: Add cfs bandwidth burst statistics
  sched/fair: Add document for burstable CFS bandwidth control

 Documentation/scheduler/sched-bwc.rst |  49 +++++++++++--
 include/linux/sched/sysctl.h          |   2 +
 kernel/sched/core.c                   | 126 +++++++++++++++++++++++++++++-----
 kernel/sched/fair.c                   |  58 +++++++++++++---
 kernel/sched/sched.h                  |   9 ++-
 kernel/sysctl.c                       |  18 +++++
 6 files changed, 232 insertions(+), 30 deletions(-)

-- 
2.14.4.44.g2045bb6

