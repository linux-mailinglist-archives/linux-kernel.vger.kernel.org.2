Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2EC41A6F4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 07:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbhI1FR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 01:17:26 -0400
Received: from esa10.hc1455-7.c3s2.iphmx.com ([139.138.36.225]:24728 "EHLO
        esa10.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233279AbhI1FRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 01:17:24 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Sep 2021 01:17:24 EDT
IronPort-SDR: QE8h0f/MjikkdTDlK+FY15167lYE5vqkpTeJMBNxUEQaW5mYfCRwRELPYLz7C259TPR+7jAo1M
 ZOOBysg4gcicXutcQHE+ZV/qNrb9CDPzXtVZh/e57fSTVt+J/xSRmJ6HpQu0Dlhjmt3p7+LWHF
 Hl4bYW2a2P8GT/2l10de/HLdLuoNNuZfvRNAy/CsIBasU5jJUNBdKy7zNjQNwpUONoLgIhxcbM
 vkbcI7swL4j+YgvVfXdqNepjpv+NYvysXybZB19eby3IauOfPwhg4ykmOLaigi10v2A6svnVSr
 Jjc04ejs/6Tp/wEpqseSMrYx
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="34550053"
X-IronPort-AV: E=Sophos;i="5.85,328,1624287600"; 
   d="scan'208";a="34550053"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP; 28 Sep 2021 14:08:19 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 8FDB823A37B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:08:18 +0900 (JST)
Received: from yto-om2.fujitsu.com (yto-om2.o.css.fujitsu.com [10.128.89.163])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id D1E18C5555
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:08:12 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by yto-om2.fujitsu.com (Postfix) with ESMTP id BBA394007DF01;
        Tue, 28 Sep 2021 14:08:12 +0900 (JST)
From:   Hasegawa Hitomi <hasegawa-hitomi@fujitsu.com>
To:     frederic@kernel.org
Cc:     bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        fweisbec@gmail.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@kernel.org,
        peterz@infradead.org, rostedt@goodmis.org, tglx@linutronix.de,
        vincent.guittot@linaro.org,
        Hasegawa Hitomi <hasegawa-hitomi@fujitsu.com>
Subject: [RFC][PATCH 0/1] sched/cputime: Improve getrusage(RUSAGE_THREAD) with nohz_full
Date:   Tue, 28 Sep 2021 14:08:03 +0900
Message-Id: <20210928050804.4156102-1-hasegawa-hitomi@fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic, seems busy, so I create the proper patch, would you please add
your Signed-off-by: if this fix is okey.
This patch is a fix proposed in the following thread [1].


The getrusage(RUSAGE_THREAD) with nohz_full returns shorter utime/stime
than the actual time.

In the current implementation, task_cputime_adjusted() calls task_cputime()
to get the "current" utime and stime, then calls cputime_adjust () to adjust
the sum of utime and stime to be equal to cputime.sum_exec_runtime.
In nohz_full, sum_exec_runtime is not updated regularly, which is the cause
of this discrepancy.

This patch add a process to update sum_exec_runtime after getting
the information from "current" and before adjusting. 
This addition applies only when run with nohz_full.

Thanks.
Hitomi Hasegawa

[1] https://lore.kernel.org/lkml/OSBPR01MB21837C8931D90AE55AF4A955EB529@OSBPR01MB2183.jpnprd01.prod.outlook.com/

--

Hasegawa Hitomi (1):
  sched/cputime: Improve getrusage(RUSAGE_THREAD) with nohz_full

 include/linux/sched/cputime.h |  5 +++--
 kernel/sched/cputime.c        | 12 +++++++++---
 2 files changed, 12 insertions(+), 5 deletions(-)

-- 
2.25.1

