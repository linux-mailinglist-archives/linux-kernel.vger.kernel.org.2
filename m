Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D1D390EFA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 05:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhEZDzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 23:55:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5705 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbhEZDzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 23:55:31 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FqcSB33GVz1BN3t;
        Wed, 26 May 2021 11:51:06 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 26 May 2021 11:53:58 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 26 May 2021 11:53:56 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Christoph Hellwig <hch@lst.de>,
        "Marek Szyprowski" <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Eric Biederman <ebiederm@xmission.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        "Steffen Klassert" <steffen.klassert@secunet.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        kgdb-bugreport <kgdb-bugreport@lists.sourceforge.net>,
        kexec <kexec@lists.infradead.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 0/1] kernel: fix numerous spelling mistakes
Date:   Wed, 26 May 2021 11:53:44 +0800
Message-ID: <20210526035345.9113-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These files are not organized by module(subdirectory), or even if they can, the
number of spelling mistakes is small and not worth generating a separate patch.

This patch is based on the latest linux-next. But except the modification of
kernel/delayacct.c, the remaining can also be applied on 5.13-rc3.


Zhen Lei (1):
  kernel: fix numerous spelling mistakes

 kernel/acct.c                  | 2 +-
 kernel/context_tracking.c      | 2 +-
 kernel/cpu.c                   | 2 +-
 kernel/debug/debug_core.c      | 2 +-
 kernel/debug/kdb/kdb_main.c    | 8 ++++----
 kernel/debug/kdb/kdb_private.h | 2 +-
 kernel/delayacct.c             | 2 +-
 kernel/dma/map_benchmark.c     | 2 +-
 kernel/dma/swiotlb.c           | 2 +-
 kernel/exit.c                  | 2 +-
 kernel/hung_task.c             | 2 +-
 kernel/kexec_core.c            | 2 +-
 kernel/kprobes.c               | 2 +-
 kernel/latencytop.c            | 2 +-
 kernel/module.c                | 4 ++--
 kernel/notifier.c              | 2 +-
 kernel/padata.c                | 2 +-
 kernel/panic.c                 | 2 +-
 kernel/pid.c                   | 2 +-
 kernel/ptrace.c                | 2 +-
 kernel/relay.c                 | 2 +-
 kernel/signal.c                | 4 ++--
 kernel/smp.c                   | 2 +-
 kernel/taskstats.c             | 2 +-
 kernel/time/alarmtimer.c       | 2 +-
 kernel/time/timer.c            | 4 ++--
 kernel/umh.c                   | 2 +-
 kernel/user_namespace.c        | 2 +-
 kernel/usermode_driver.c       | 2 +-
 kernel/watchdog.c              | 2 +-
 kernel/workqueue.c             | 4 ++--
 31 files changed, 38 insertions(+), 38 deletions(-)

-- 
2.25.1


