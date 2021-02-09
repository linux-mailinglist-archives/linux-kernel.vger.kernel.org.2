Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D110315D24
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbhBJCWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:22:32 -0500
Received: from mail1.windriver.com ([147.11.146.13]:43196 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbhBJBgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 20:36:38 -0500
X-Greylist: delayed 8888 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Feb 2021 20:31:50 EST
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 119MxD1X026111
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Feb 2021 14:59:18 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Feb 2021 14:59:12 -0800
Received: from yow-pgortmak-lx2.corp.ad.wrs.com (128.224.56.62) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 9 Feb 2021 14:59:11 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Li Zefan <lizefan@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH v4 0/8] support for bitmap (and hence CPU) list "N" abbreviation
Date:   Tue, 9 Feb 2021 17:58:59 -0500
Message-ID: <20210209225907.78405-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The basic objective here was to add support for "nohz_full=8-N" and/or
"rcu_nocbs="4-N" -- essentially introduce "N" as a portable reference
to the last core, evaluated at boot for anything using a CPU list.

The thinking behind this, is that people carve off a few early CPUs to
support housekeeping tasks, and perhaps dedicate one to a busy I/O
peripheral, and then the remaining pool of CPUs out to the end are a
part of a commonly configured pool used for the real work the user
cares about.

Extend that logic out to a fleet of machines - some new, and some
nearing EOL, and you've probably got a wide range of core counts to
contend with - even though the early number of cores dedicated to the
system overhead probably doesn't vary.

This change would enable sysadmins to have a common bootarg across all
such systems, and would also avoid any off-by-one fencepost errors that
happen for users who might briefly forget that core counts start at zero.

Originally I did this at the CPU subsys level, but Yury suggested it
be moved down further to bitmap level itself, which made the core 
implementation smaller and less complex, but the series longer.

New self tests are added to better exercise what bitmap range/region
currently supports, and new tests are added for the new "N" support.

Also tested boot arg and the post-boot cgroup use case as per below:

   root@hackbox:~# cat /proc/cmdline 
   BOOT_IMAGE=/boot/bzImage root=/dev/sda1 rcu_nocbs=2,3,8-N:1/2
   root@hackbox:~# dmesg|grep Offl
   rcu:     Offload RCU callbacks from CPUs: 2-3,8,10,12,14.

   root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
   
   root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo 10-N > cpuset.cpus
   root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
   10-15
   root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo N-N:N/N > cpuset.cpus
   root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
   15

This was on a 16 core machine with CONFIG_NR_CPUS=16 in .config file.

Note that "N" is a dynamic quantity, and can change scope if the bitmap
is changed in size.  So at the risk of stating the obvious, don't use it
for "burn_eFuse=128-N" or "secure_erase_firmware=32-N" type stuff.

Paul.
---

I've intentionally not gone down the rabbit hole of whether N or Z or
L is the better letter to mark the end of a mathematical set in the
hope that we can stay focused, and get this closed out here in v4.

Aside from that, I believe all other feedback has been responded to
in one way or another.  Note that I didn't add Reviewed/Ack tags to
anything that changed significantly from what was reviewed in v3.

[v4: pair nbits with region, instead of inside it.  Split EINVAL and
 ERANGE tests.  Don't handle start/end/offset within a macro to
 abstract away nbits usage.  Added some Reviwed-by/Ack tags.]

[v3: Allow "N" to be used anywhere in the region spec, i.e. "N-N:N/N" vs.
 just being allowed at end of range like "0-N".  Add new self-tests.  Drop
 "all" and "none" aliases as redundant and not worth the extra complication. ]
 https://lore.kernel.org/lkml/20210126171141.122639-1-paul.gortmaker@windriver.com

[v2: push code down from cpu subsys to core bitmap code as per
 Yury's comments.  Change "last" to simply be "N" as per PeterZ.]
 https://lore.kernel.org/lkml/20210121223355.59780-1-paul.gortmaker@windriver.com/

[v1: https://lore.kernel.org/lkml/20210106004850.GA11682@paulmck-ThinkPad-P72/

Cc: Li Zefan <lizefan@huawei.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


Paul Gortmaker (8):
  lib: test_bitmap: clearly separate ERANGE from EINVAL tests.
  lib: test_bitmap: add tests to trigger ERANGE case.
  lib: test_bitmap: add more start-end:offset/len tests
  lib: bitmap: move ERANGE check from set_region to check_region
  lib: bitmap: pair nbits value with region struct
  lib: bitmap: support "N" as an alias for size of bitmap
  lib: test_bitmap: add tests for "N" alias
  rcu: deprecate "all" option to rcu_nocbs=

 .../admin-guide/kernel-parameters.rst         |  7 +++
 .../admin-guide/kernel-parameters.txt         |  4 +-
 kernel/rcu/tree_plugin.h                      |  6 +-
 lib/bitmap.c                                  | 62 +++++++++++++------
 lib/test_bitmap.c                             | 46 ++++++++++++--
 5 files changed, 93 insertions(+), 32 deletions(-)

-- 
2.17.1

