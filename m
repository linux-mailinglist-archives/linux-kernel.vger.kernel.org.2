Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E1644FCBB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 02:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbhKOBbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 20:31:19 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:26308 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhKOBah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 20:30:37 -0500
Received: from dggeml756-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HsrzB55DFzbhpc;
        Mon, 15 Nov 2021 09:22:46 +0800 (CST)
Received: from huawei.com (10.67.174.191) by dggeml756-chm.china.huawei.com
 (10.1.199.158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.20; Mon, 15
 Nov 2021 09:27:39 +0800
From:   Li Hua <hucool.lihua@huawei.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
CC:     <yuehaibing@huawei.com>, <weiyongjun1@huawei.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        <linux-kernel@vger.kernel.org>, <w.f@huawei.com>,
        <hucool.lihua@huawei.com>, <cj.chengjian@huawei.com>,
        <judy.chenhui@huawei.com>
Subject: [PATCH -next 0/1] Restart rt period timer when rt runtime exceeded
Date:   Mon, 15 Nov 2021 01:46:27 +0000
Message-ID: <20211115014628.15017-1-hucool.lihua@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.191]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeml756-chm.china.huawei.com (10.1.199.158)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When rt_runtime is modified from -1 to a valid control value, it may cause
the task to be throttled all the time. Then the task cannot be killed.
E.g:
The FIFO task A execution while(1):
	#define _GNU_SOURCE
	#include <sched.h>
	#include <unistd.h>

	int main(int argc,char *argv[])
	{
		struct sched_param param;
		int priority = sched_get_priority_min(SCHED_FIFO);
		param.sched_priority = priority;
		sched_setscheduler(getpid(), SCHED_FIFO, &param);
		while(1) {}
		return 0;
	}

Following the steps:
lihua@octopus ~ # echo -1 > /proc/sys/kernel/sched_rt_runtime_us
lihua@octopus ~ # /bin/rt_throttled &
lihua@octopus ~ # echo 950000 > /proc/sys/kernel/sched_rt_runtime_us
lihua@octopus ~ # ps aux | grep rt_throttled
root 7026 65.1  0.0   1848   180 ttyAMA0  R    01:27   0:26 /bin/rt_throttled
root 7068  0.0  0.0   4072   620 ttyAMA0  S+   01:28   0:00 grep rt_throttled
lihua@octopus ~ # killall rt_throttled
lihua@octopus ~ # date
Thu Jan  1 01:28:30 UTC 1970
lihua@octopus ~ # date
Thu Jan  1 01:28:33 UTC 1970
lihua@octopus ~ # ps aux | grep rt_throttled
root 7026 41.0  0.0   1848   180 ttyAMA0  R    01:27   0:26 /bin/rt_throttled
root 7097  0.0  0.0   4072   576 ttyAMA0  S+   01:28   0:00 grep rt_throttled

So the patch try to wake up the timer when rt runtime exceeded.

*** BLURB HERE ***

Li Hua (1):
  sched/rt: Try to restart rt period timer when rt runtime exceeded

 kernel/sched/rt.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

-- 
2.17.1

