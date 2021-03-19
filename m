Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDC33426F0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 21:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhCSUda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 16:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhCSUdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 16:33:01 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F328C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 13:33:01 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id c6so7825424qtc.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 13:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I7iI/RjuF/n2GzHzHDEnjrvZgMta6Au2UAUecJ8NesA=;
        b=EYZtu2M12e/OoXrwoZsRbZbJcJWmW5gu0USYWJeHmY6qfX3Dl9raLZu1zpPkX5EYDl
         WXciA0KucihojoV5dysLr3URFpgUsrYxKrMIMEVOOdpdDrhlgX7VruETCpngT/xoTTgI
         y9RQAP9EPiKdWmIt41ZDjuVFUt4jI2HUJjcgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I7iI/RjuF/n2GzHzHDEnjrvZgMta6Au2UAUecJ8NesA=;
        b=qI8DvUObshqy2QAwTCrc3Y47QynThMDlRTj1vsEO1+a2HAAOJEX4GTzcXsKKJ4+fQf
         76NtpHfyDLlaEEWN7WYhkq81csk6Sopnm1JtsemCo+mDPBY0ahdfchHJ1x7QihndwjfU
         rTqfS+yY6x3CnuPVOMFV93k4mAI4R+SMCO1LM3HiZ/uJEQa4YxCSF04cBlEiUBqIRq/O
         xhx++qUdUn6guoq3Fg7WgG3tdTncMP6inB3TaJI+OmmFwfst+16ra93YAQyXCokj2L3j
         i3hsjPirysayDcdpzyGwrDJglE5iiV2TfvlKEb+3N/bFsVGJp6TbjzgZ7MEBZLtAw4Ac
         B1fg==
X-Gm-Message-State: AOAM532gM9VfqBWm+WfBJPs07w+7xpbqaqyBqkWGWwjuq5w0fuXVUmYE
        TFoOkmivYrSgX9/vdIAHfiKKjQ==
X-Google-Smtp-Source: ABdhPJz5pjGkbNlKU8ShyGw2jJNC3YQ/+9eTGT++LkTohSmmlhC1vqjCPO/bDlW7uiB4ryKcDwfBOg==
X-Received: by 2002:ac8:7490:: with SMTP id v16mr414602qtq.259.1616185980192;
        Fri, 19 Mar 2021 13:33:00 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:7422:5a6f:e616:23c9])
        by smtp.gmail.com with ESMTPSA id j26sm4588187qtp.30.2021.03.19.13.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 13:32:59 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>, chris.hyser@oracle.com,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joel Fernandes <joelaf@google.com>
Subject: [PATCH 0/6] Core scheduling remaining patches
Date:   Fri, 19 Mar 2021 16:32:47 -0400
Message-Id: <20210319203253.3352417-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel Fernandes <joelaf@google.com>

Core-Scheduling
===============
Enclosed is interface related core scheduling patches and one for migration.
The main core scheduling patches were already pulled in by Peter with these
bits left.

Main changes are the simplification of the core cookie scheme,
new prctl code, and other misc fixes based on Peter's feedback.

These remaining patches was worked on mostly by Josh Don and Chris Hyser.

Introduction of feature
=======================
Core scheduling is a feature that allows only trusted tasks to run
concurrently on cpus sharing compute resources (eg: hyperthreads on a
core). The goal is to mitigate the core-level side-channel attacks
without requiring to disable SMT (which has a significant impact on
performance in some situations). Core scheduling (as of v7) mitigates
user-space to user-space attacks and user to kernel attack when one of
the siblings enters the kernel via interrupts or system call.

By default, the feature doesn't change any of the current scheduler
behavior. The user decides which tasks can run simultaneously on the
same core (for now by having them in the same tagged cgroup). When a tag
is enabled in a cgroup and a task from that cgroup is running on a
hardware thread, the scheduler ensures that only idle or trusted tasks
run on the other sibling(s). Besides security concerns, this feature can
also be beneficial for RT and performance applications where we want to
control how tasks make use of SMT dynamically.

Both a CGroup and Per-task interface via prctl(2) are provided for configuring
core sharing. More details are provided in documentation patch.  Kselftests are
provided to verify the correctness/rules of the interface.

Testing
=======
ChromeOS testing shows 300% improvement in keypress latency on a Google
docs key press with Google hangout test (the maximum latency drops from 150ms
to 50ms for keypresses).

Julien: TPCC tests showed improvements with core-scheduling as below. With kernel
protection enabled, it does not show any regression. Possibly ASI will improve
the performance for those who choose kernel protection (can be controlled through
ht_protect kernel command line option).
				average		stdev		diff
baseline (SMT on)		1197.272	44.78312824	
core sched (   kernel protect)	412.9895	45.42734343	-65.51%
core sched (no kernel protect)	686.6515	71.77756931	-42.65%
nosmt				408.667		39.39042872	-65.87%
(Note these results are from v8).

Vineeth tested sysbench and does not see any regressions.
Hong and Aubrey tested v9 and see results similar to v8. There is a known issue
with uperf that does regress. This appears to be because of ksoftirq heavily
contending with other tasks on the core. The consensus is this can be improved
in the future.

Other changes:
- Fixed breaking of coresched= option patch on !SCHED_CORE builds.
- Trivial commit message changes.

Changes in v10
==============
- migration code changes from Aubrey.
- dropped patches merged.
- interface changes from Josh and Chris.

Changes in v9
=============
- Note that the vruntime snapshot change is written in 2 patches to show the
  progression of the idea and prevent merge conflicts:
    sched/fair: Snapshot the min_vruntime of CPUs on force idle
    sched: Improve snapshotting of min_vruntime for CGroups
  Same with the RT priority inversion change:
    sched: Fix priority inversion of cookied task with sibling
    sched: Improve snapshotting of min_vruntime for CGroups
- Disable coresched on certain AMD HW.

Changes in v8
=============
- New interface/API implementation
  - Joel
- Revised kernel protection patch
  - Joel
- Revised Hotplug fixes
  - Joel
- Minor bug fixes and address review comments
  - Vineeth

Changes in v7
=============
- Kernel protection from untrusted usermode tasks
  - Joel, Vineeth
- Fix for hotplug crashes and hangs
  - Joel, Vineeth

Changes in v6
=============
- Documentation
  - Joel
- Pause siblings on entering nmi/irq/softirq
  - Joel, Vineeth
- Fix for RCU crash
  - Joel
- Fix for a crash in pick_next_task
  - Yu Chen, Vineeth
- Minor re-write of core-wide vruntime comparison
  - Aaron Lu
- Cleanup: Address Review comments
- Cleanup: Remove hotplug support (for now)
- Build fixes: 32 bit, SMT=n, AUTOGROUP=n etc
  - Joel, Vineeth

Changes in v5
=============
- Fixes for cgroup/process tagging during corner cases like cgroup
  destroy, task moving across cgroups etc
  - Tim Chen
- Coresched aware task migrations
  - Aubrey Li
- Other minor stability fixes.

Changes in v4
=============
- Implement a core wide min_vruntime for vruntime comparison of tasks
  across cpus in a core.
  - Aaron Lu
- Fixes a typo bug in setting the forced_idle cpu.
  - Aaron Lu

Changes in v3
=============
- Fixes the issue of sibling picking up an incompatible task
  - Aaron Lu
  - Vineeth Pillai
  - Julien Desfossez
- Fixes the issue of starving threads due to forced idle
  - Peter Zijlstra
- Fixes the refcounting issue when deleting a cgroup with tag
  - Julien Desfossez
- Fixes a crash during cpu offline/online with coresched enabled
  - Vineeth Pillai
- Fixes a comparison logic issue in sched_core_find
  - Aaron Lu

Changes in v2
=============
- Fixes for couple of NULL pointer dereference crashes
  - Subhra Mazumdar
  - Tim Chen
- Improves priority comparison logic for process in different cpus
  - Peter Zijlstra
  - Aaron Lu
- Fixes a hard lockup in rq locking
  - Vineeth Pillai
  - Julien Desfossez
- Fixes a performance issue seen on IO heavy workloads
  - Vineeth Pillai
  - Julien Desfossez
- Fix for 32bit build
  - Aubrey Li

Future work
===========
- Load balancing/Migration fixes for core scheduling.
  With v6, Load balancing is partially coresched aware, but has some
  issues w.r.t process/taskgroup weights:
  https://lwn.net/ml/linux-kernel/20200225034438.GA617271@z...

Aubrey Li (1):
sched: migration changes for core scheduling

Joel Fernandes (Google) (3):
kselftest: Add tests for core-sched interface
Documentation: Add core scheduling documentation
sched: Debug bits...

Josh Don (1):
sched: tagging interface for core scheduling

chris hyser (1):
sched: prctl() cookie manipulation for core scheduling.

.../admin-guide/hw-vuln/core-scheduling.rst   | 460 ++++++++++
Documentation/admin-guide/hw-vuln/index.rst   |   1 +
include/linux/sched.h                         |  27 +-
include/linux/sched/task.h                    |   4 +-
include/uapi/linux/prctl.h                    |   7 +
kernel/fork.c                                 |   1 +
kernel/sched/Makefile                         |   1 +
kernel/sched/core.c                           | 223 +++--
kernel/sched/coretag.c                        | 578 +++++++++++++
kernel/sched/debug.c                          |   4 +
kernel/sched/fair.c                           |  42 +-
kernel/sched/sched.h                          | 155 +++-
kernel/sys.c                                  |   7 +
tools/include/uapi/linux/prctl.h              |   7 +
tools/testing/selftests/sched/.gitignore      |   1 +
tools/testing/selftests/sched/Makefile        |  14 +
tools/testing/selftests/sched/config          |   1 +
tools/testing/selftests/sched/cs_prctl_test.c | 372 ++++++++
.../testing/selftests/sched/test_coresched.c  | 812 ++++++++++++++++++
19 files changed, 2649 insertions(+), 68 deletions(-)
create mode 100644 Documentation/admin-guide/hw-vuln/core-scheduling.rst
create mode 100644 kernel/sched/coretag.c
create mode 100644 tools/testing/selftests/sched/.gitignore
create mode 100644 tools/testing/selftests/sched/Makefile
create mode 100644 tools/testing/selftests/sched/config
create mode 100644 tools/testing/selftests/sched/cs_prctl_test.c
create mode 100644 tools/testing/selftests/sched/test_coresched.c

--
2.31.0.rc2.261.g7f71774620-goog

