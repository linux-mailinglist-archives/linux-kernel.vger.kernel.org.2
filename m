Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B563483E5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 22:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238573AbhCXVlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 17:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhCXVki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 17:40:38 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78ECFC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:40:38 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id h7so238014qtx.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZGmPxc+3tqi4TExWCSBQNEPbaOmY9NcaSntF/kV/8g8=;
        b=AEmB8GcpuDc2Ty/pUSZV9AmNQKLNMAYD5+9spbiiTHOfEDJZJJoIvvxag8VhM3vfVU
         a+6glS9EBkbjATqSpeqnEJEinMUC8R4wDfwV10TvFSvf+qweIIpJEjHzVvmvJ0TKA25R
         +8BkdUue1oafFilu9DH4xLLF4l61xvAiVGZEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZGmPxc+3tqi4TExWCSBQNEPbaOmY9NcaSntF/kV/8g8=;
        b=dJE0xaXl9s3oQV13m99/AbhaD/3wqc5d/yCfHNAKeTyEafFlSdB/HF/oBNH+4q/Ziw
         iDkW6dGTanYn+BtDkLFci7HbzolpUPHCt7cmNQd1okQUi8E0JWlFiruEaJydjbqoF3QC
         kejL9yVkFjsfdDR8vLYeSGJpYEEijt/N87JAQlwph07z9yHSq5lcq/FHWSCuVvVkYl5R
         6P1oT2sZ68Nj5Sc5MJ69sE9IBT5+eJU8idw7OduB2AqGsjEFh8iPjfJhvmqvzbkbWKp0
         +n8hjN9w8kb3+LFNzF61L8+K0vegOWqbcOedjwI5vCE30F8oXoLw8urPFEB2e9N6lQ56
         ieDg==
X-Gm-Message-State: AOAM5337OLJ1oLWdVpiELKfOQjn6Q8CI4ZCiRvwgSxyzjjd6+vgTliRe
        iNkg1xIm9C3a2uYp380eyZ1GLw==
X-Google-Smtp-Source: ABdhPJwSn5vY341YHOUXfwiXGqawfTrK3hPnpuQ+k2PuiNhZsVykCzbQP/MQj9TsCSUvJA0IrWfEXQ==
X-Received: by 2002:a05:622a:49:: with SMTP id y9mr5021361qtw.0.1616622037440;
        Wed, 24 Mar 2021 14:40:37 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:3177:30e:b1de:1fb4])
        by smtp.gmail.com with ESMTPSA id h75sm2661107qke.80.2021.03.24.14.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 14:40:37 -0700 (PDT)
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
        dhiatt@digitalocean.com, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH resend 7/8] Documentation: Add core scheduling documentation
Date:   Wed, 24 Mar 2021 17:40:19 -0400
Message-Id: <20210324214020.34142-8-joel@joelfernandes.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210324214020.34142-1-joel@joelfernandes.org>
References: <20210324214020.34142-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the usecases, design and interfaces for core scheduling.

Co-developed-by: Chris Hyser <chris.hyser@oracle.com>
Co-developed-by: Vineeth Pillai <viremana@linux.microsoft.com>
Co-developed-by: Josh Don <joshdon@google.com>
Signed-off-by: Josh Don <joshdon@google.com>
Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../admin-guide/hw-vuln/core-scheduling.rst   | 460 ++++++++++++++++++
 Documentation/admin-guide/hw-vuln/index.rst   |   1 +
 2 files changed, 461 insertions(+)
 create mode 100644 Documentation/admin-guide/hw-vuln/core-scheduling.rst

diff --git a/Documentation/admin-guide/hw-vuln/core-scheduling.rst b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
new file mode 100644
index 000000000000..0ef00edd50e6
--- /dev/null
+++ b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
@@ -0,0 +1,460 @@
+Core Scheduling
+***************
+Core scheduling support allows userspace to define groups of tasks that can
+share a core. These groups can be specified either for security usecases (one
+group of tasks don't trust another), or for performance usecases (some
+workloads may benefit from running on the same core as they don't need the same
+hardware resources of the shared core).
+
+Security usecase
+----------------
+A cross-HT attack involves the attacker and victim running on different
+Hyper Threads of the same core. MDS and L1TF are examples of such attacks.
+Without core scheduling, the only full mitigation of cross-HT attacks is to
+disable Hyper Threading (HT). Core scheduling allows HT to be turned on safely
+by ensuring that trusted tasks can share a core. This increase in core sharing
+can improvement performance, however it is not guaranteed that performance will
+always improve, though that is seen to be the case with a number of real world
+workloads. In theory, core scheduling aims to perform at least as good as when
+Hyper Threading is disabled. In practice, this is mostly the case though not
+always: as synchronizing scheduling decisions across 2 or more CPUs in a core
+involves additional overhead - especially when the system is lightly loaded
+(``total_threads <= N/2``, where N is the total number of CPUs).
+
+Usage
+-----
+Core scheduling support is enabled via the ``CONFIG_SCHED_CORE`` config option.
+Using this feature, userspace defines groups of tasks that trust each other.
+The core scheduler uses this information to make sure that tasks that do not
+trust each other will never run simultaneously on a core, while doing its best
+to satisfy the system's scheduling requirements.
+
+There are 2 ways to use core-scheduling:
+
+CGroup
+######
+Core scheduling adds additional files to the CPU controller CGroup:
+
+* ``cpu.core_tag``
+
+Writing ``1`` into this file results in all tasks in the group getting tagged.
+This results in all the CGroup's tasks allowed to run concurrently on a core's
+hyperthreads (also called siblings).
+
+The file being a value of ``0`` means the tag state of the CGroup is inherited
+from its parent hierarchy. If any ancestor of the CGroup is tagged, then the
+group is tagged.
+
+.. note:: Once a CGroup is tagged via cpu.core_tag, it is not possible to set this
+          for any descendant of the tagged group.
+
+.. note:: When a CGroup is not tagged, all the tasks within the group can share
+          a core with kernel threads and untagged system threads. For this reason,
+          if a group has ``cpu.core_tag`` of 0, it is considered to be trusted.
+
+prctl(2) interface
+##################
+
+A ``prtcl(2)`` command ``PR_SCHED_CORE_SHARE`` provides an interface for the
+creation of and admission and removal of tasks from core scheduling groups.
+Permission to change the ``cookie`` and hence the core scheduling group it
+represents is based on ``ptrace access``.
+
+::
+
+    #include <sys/prctl.h>
+
+    int prctl(int option, unsigned long arg2, unsigned long arg3, unsigned long arg4, unsigned long arg5);
+
+    int prctl(PR_SCHED_CORE_SHARE, sub_command, pid, pid_type, 0);
+
+option:
+    ``PR_SCHED_CORE_SHARE``
+
+arg2:
+    sub-command:
+
+    - ``PR_SCHED_CORE_CLEAR            0  -- clear core_sched cookie of pid``
+    - ``PR_SCHED_CORE_CREATE           1  -- create a new cookie for pid``
+    - ``PR_SCHED_CORE_SHARE_FROM       2  -- copy core_sched cookie from pid``
+    - ``PR_SCHED_CORE_SHARE_TO         3  -- copy core_sched cookie to pid``
+
+arg3:
+    ``pid`` of the task for which the operation applies where ``pid == 0``
+    implies current process.
+
+arg4:
+    ``pid_type`` for PR_SCHED_CORE_CLEAR/CREATE/SHARE_TO is an enum
+    {PIDTYPE_PID=0, PIDTYPE_TGID, PIDTYPE_PGID} and determines how the target
+    ``pid`` should be interpreted. ``PIDTYPE_PID`` indicates that the target
+    ``pid`` should be treated as an individual task, ``PIDTYPE_TGID`` a process
+    or thread group, and ``PIDTYPE_PGID`` or a process group ``PIDTYPE_PGID``.
+
+arg5:
+    MUST be equal to 0.
+
+Return Value:
+::
+
+    EINVAL - bad parameter
+    ENOMEM - unable to allocate memory for a cookie.
+    ESRCH  - unable to find specified pid.
+    EPERM  - caller lacks permission to change the cookie of target.
+    EACCES - caller lacks permission to change the cookies of all
+             targets of pidtype.
+
+Creation
+~~~~~~~~
+Creation is accomplished by creating a ''cookie'' for the target pid which may
+be an individual task if tgt_pid_type is ``PIDTYPE_PID``, a process and it's
+threads if ``PIDTYPE_TGID`` or all tasks of the specified process group if
+``PIDTYPE_PGID``.
+
+::
+
+    if (prctl(PR_SCHED_CORE_SHARE, PR_SCHED_CORE_CREATE, tgt_pid, tgt_pid_type, 0) < 0)
+            handle_error("sched_core_create failed");
+
+Examples:
+::
+
+	Given a process group, process and thread hierarchy:
+
+	## Create a thread/process/process group hierarchy
+	tid=40003, / tgid=40003 / pgid=40003: 0
+	    tid=40004, / tgid=40004 / pgid=40003: 0
+		tid=40005, / tgid=40004 / pgid=40003: 0
+		tid=40007, / tgid=40004 / pgid=40003: 0
+		tid=40008, / tgid=40004 / pgid=40003: 0
+	    tid=40006, / tgid=40006 / pgid=40003: 0
+		tid=40009, / tgid=40006 / pgid=40003: 0
+		tid=40010, / tgid=40006 / pgid=40003: 0
+		tid=40011, / tgid=40006 / pgid=40003: 0
+
+	## Set a cookie on entire process group
+	0 = prctl(59, 1, 0, 2, 0)
+	tid=40003, / tgid=40003 / pgid=40003: 1f7121100000000
+	    tid=40004, / tgid=40004 / pgid=40003: 1f7121100000000
+		tid=40005, / tgid=40004 / pgid=40003: 1f7121100000000
+		tid=40007, / tgid=40004 / pgid=40003: 1f7121100000000
+		tid=40008, / tgid=40004 / pgid=40003: 1f7121100000000
+	    tid=40006, / tgid=40006 / pgid=40003: 1f7121100000000
+		tid=40009, / tgid=40006 / pgid=40003: 1f7121100000000
+		tid=40010, / tgid=40006 / pgid=40003: 1f7121100000000
+		tid=40011, / tgid=40006 / pgid=40003: 1f7121100000000
+
+	## Set a new cookie on entire process/TGID [40006]
+	0 = prctl(59, 1, 40006, 1, 0)
+	tid=40003, / tgid=40003 / pgid=40003: 1f7121100000000
+	    tid=40004, / tgid=40004 / pgid=40003: 1f7121100000000
+		tid=40005, / tgid=40004 / pgid=40003: 1f7121100000000
+		tid=40007, / tgid=40004 / pgid=40003: 1f7121100000000
+		tid=40008, / tgid=40004 / pgid=40003: 1f7121100000000
+	    tid=40006, / tgid=40006 / pgid=40003: 1f7121200000000
+		tid=40009, / tgid=40006 / pgid=40003: 1f7121200000000
+		tid=40010, / tgid=40006 / pgid=40003: 1f7121200000000
+		tid=40011, / tgid=40006 / pgid=40003: 1f7121200000000
+
+Removal
+~~~~~~~
+Removing a task(s) from a core scheduling group is done by specifying a target
+pid and it's type. Again, pidtype determines the interpretation of the target pid.
+
+::
+
+    if (prctl(PR_SCHED_CORE_SHARE, PR_SCHED_CORE_SHARE_CLEAR, tgt_pid, tgt_pid_type, 0) < 0)
+             handle_error("clr_tid sched_core failed");
+
+Examples (continued from above):
+::
+
+	## Clear a cookie on a single task [40006]
+	0 = prctl(59, 0, 40006, 0, 0)
+	tid=40003, / tgid=40003 / pgid=40003: 1f7121200000000
+	    tid=40004, / tgid=40004 / pgid=40003: 1f7121100000000
+		tid=40005, / tgid=40004 / pgid=40003: 1f7121100000000
+		tid=40007, / tgid=40004 / pgid=40003: 1f7121100000000
+		tid=40008, / tgid=40004 / pgid=40003: 1f7121100000000
+	    tid=40006, / tgid=40006 / pgid=40003: 0
+		tid=40009, / tgid=40006 / pgid=40003: 1f7121200000000
+		tid=40010, / tgid=40006 / pgid=40003: 1f7121200000000
+		tid=40011, / tgid=40006 / pgid=40003: 1f7121200000000
+
+	## Clear cookies on the entire process group
+	0 = prctl(59, 0, 0, 2, 0)
+	tid=40003, / tgid=40003 / pgid=40003: 0
+	    tid=40004, / tgid=40004 / pgid=40003: 0
+		tid=40005, / tgid=40004 / pgid=40003: 0
+		tid=40007, / tgid=40004 / pgid=40003: 0
+		tid=40008, / tgid=40004 / pgid=40003: 0
+	    tid=40006, / tgid=40006 / pgid=40003: 0
+		tid=40009, / tgid=40006 / pgid=40003: 0
+		tid=40010, / tgid=40006 / pgid=40003: 0
+		tid=40011, / tgid=40006 / pgid=40003: 0
+
+Cookie Transferal
+~~~~~~~~~~~~~~~~~
+
+Transferring a cookie between the current tasks and other tasks is possible using
+``PR_SCHED_CORE_SHARE_FROM`` and ``PR_SCHED_CORE_SHARE_TO`` depending on
+direction. A helper utility can copy cookies between tasks by first copying a
+cookie from the source task then sharing it using ``PR_SCHED_CORE_SHARE_TO`` to
+the  target ``pid`` with, again, pidtype determine the interpretation of the target pid.
+
+::
+
+    if (prctl(PR_SCHED_CORE_SHARE, PR_SCHED_CORE_SHARE_FROM, from_pid, 0, 0) < 0)
+            handle_error("from_tid sched_core failed");
+
+    if (prctl(PR_SCHED_CORE_SHARE, PR_SCHED_CORE_SHARE_TO, to_pid, tgt_pid_type, 0) < 0)
+            handle_error("to_tid sched_core failed");
+
+Examples (continued from above):
+::
+
+	pidtype can even be used with SHARE_TO to "spread" the cookie among the
+	appropriate group by sharing with self.
+
+	## given setup
+	tid=40003, / tgid=40003 / pgid=40003: 1f7121200000000
+	    tid=40004, / tgid=40004 / pgid=40003: 1f7121100000000
+		tid=40005, / tgid=40004 / pgid=40003: 1f7121100000000
+		tid=40007, / tgid=40004 / pgid=40003: 1f7121100000000
+		tid=40008, / tgid=40004 / pgid=40003: 1f7121100000000
+	    tid=40006, / tgid=40006 / pgid=40003: 0
+		tid=40009, / tgid=40006 / pgid=40003: 1f7121200000000
+		tid=40010, / tgid=40006 / pgid=40003: 1f7121200000000
+		tid=40011, / tgid=40006 / pgid=40003: 1f7121200000000
+
+	## Copy cookie from current [40003] to current as pidtype PGID
+	0 = prctl(59, 3, 0, 2, 0)
+	tid=40003, / tgid=40003 / pgid=40003: 1f7121200000000
+	    tid=40004, / tgid=40004 / pgid=40003: 1f7121200000000
+		tid=40005, / tgid=40004 / pgid=40003: 1f7121200000000
+		tid=40007, / tgid=40004 / pgid=40003: 1f7121200000000
+		tid=40008, / tgid=40004 / pgid=40003: 1f7121200000000
+	    tid=40006, / tgid=40006 / pgid=40003: 1f7121200000000
+		tid=40009, / tgid=40006 / pgid=40003: 1f7121200000000
+		tid=40010, / tgid=40006 / pgid=40003: 1f7121200000000
+		tid=40011, / tgid=40006 / pgid=40003: 1f7121200000000
+
+Other prctl Notes
+~~~~~~~~~~~~~~~~~
+
+It is important to note that, on a ``clone(2)`` or ``fork(2)``, the child will
+be assigned a copy of the same ``cookie`` as its parent and thus in the same
+core scheduling group. Basically the default is that fork-only or threaded
+applications can share the cores of a processor. A new cookie can be created
+post clone/fork if such sharing is undesirable.  An ``execve(2)`` will however,
+automatically assign a new cookie to a task as no reasonable assumptions can be
+made on the security of the new code.
+
+.. note:: The core-sharing granted with ``prctl(2)`` will be subject to
+          core-sharing restrictions specified by the CGroup interface. For example,
+          if tasks T1 and T2 are a part of 2 different tagged CGroups, then they will
+          not share a core even if ``prctl(2)`` is used to set a shared cookie.
+
+Design/Implementation
+---------------------
+Each task that is tagged is assigned a cookie internally in the kernel. As
+mentioned in `Usage`_, tasks with the same cookie value are assumed to trust
+each other and share a core.
+
+The basic idea is that, every schedule event tries to select tasks for all the
+siblings of a core such that all the selected tasks running on a core are
+trusted (same cookie) at any point in time. Kernel threads are assumed trusted.
+The idle task is considered special, as it trusts everything and everything
+trusts it.
+
+During a schedule() event on any sibling of a core, the highest priority task on
+the sibling's core is picked and assigned to the sibling calling schedule(), if
+the sibling has the task enqueued. For rest of the siblings in the core,
+highest priority task with the same cookie is selected if there is one runnable
+in their individual run queues. If a task with same cookie is not available,
+the idle task is selected.  Idle task is globally trusted.
+
+Once a task has been selected for all the siblings in the core, an IPI is sent to
+siblings for whom a new task was selected. Siblings on receiving the IPI will
+switch to the new task immediately. If an idle task is selected for a sibling,
+then the sibling is considered to be in a `forced idle` state. I.e., it may
+have tasks on its on runqueue to run, however it will still have to run idle.
+More on this in the next section.
+
+Forced-idling of tasks
+----------------------
+The scheduler tries its best to find tasks that trust each other such that all
+tasks selected to be scheduled are of the highest priority in a core.  However,
+it is possible that some runqueues had tasks that were incompatible with the
+highest priority ones in the core. Favoring security over fairness, one or more
+siblings could be forced to select a lower priority task if the highest
+priority task is not trusted with respect to the core wide highest priority
+task.  If a sibling does not have a trusted task to run, it will be forced idle
+by the scheduler (idle thread is scheduled to run).
+
+When the highest priority task is selected to run, a reschedule-IPI is sent to
+the sibling to force it into idle. This results in 4 cases which need to be
+considered depending on whether a VM or a regular usermode process was running
+on either HT::
+
+          HT1 (attack)            HT2 (victim)
+   A      idle -> user space      user space -> idle
+   B      idle -> user space      guest -> idle
+   C      idle -> guest           user space -> idle
+   D      idle -> guest           guest -> idle
+
+Note that for better performance, we do not wait for the destination CPU
+(victim) to enter idle mode. This is because the sending of the IPI would bring
+the destination CPU immediately into kernel mode from user space, or VMEXIT
+in the case of guests. At best, this would only leak some scheduler metadata
+which may not be worth protecting. It is also possible that the IPI is received
+too late on some architectures, but this has not been observed in the case of
+x86.
+
+Kernel protection from untrusted tasks
+--------------------------------------
+Entry into the kernel (syscall, IRQ or VMEXIT) needs protection.  The scheduler
+on its own cannot protect the kernel executing concurrently with an untrusted
+task in a core. This is because the scheduler is unaware of interrupts/syscalls
+at scheduling time. To mitigate this, an IPI is sent to siblings on kernel
+entry. This IPI forces the sibling to enter kernel mode and wait before
+returning to user until all siblings of the core have left kernel mode. This
+process is also known as stunning.  For good performance, an IPI is sent only
+to a sibling only if it is running a tagged task. If a sibling is running a
+kernel thread or is idle, no IPI is sent.
+
+The kernel protection feature is off by default. To protect the kernel, pass a
+comma separated list of what to protect to the ht_protect= kernel command line
+option. Possible values are irq, syscall and kvm.
+
+Note that an arch has to define the ``TIF_UNSAFE_RET`` thread info flag to be
+able to use kernel protection. Also, if protecting the kernel from a VM is
+desired, an arch should call kvm_exit_to_guest_mode() during ``VMENTER`` and
+kvm_exit_to_guest_mode() during ``VMEXIT``. Currently, x86 support both these.
+
+Other alternative ideas discussed for kernel protection are listed below just
+for completeness. They all have limitations:
+
+1. Changing interrupt affinities to a trusted core which does not execute untrusted tasks
+#########################################################################################
+By changing the interrupt affinities to a designated safe-CPU which runs
+only trusted tasks, IRQ data can be protected. One issue is this involves
+giving up a full CPU core of the system to run safe tasks. Another is that,
+per-cpu interrupts such as the local timer interrupt cannot have their
+affinity changed. Also, sensitive timer callbacks such as the random entropy timer
+can run in softirq on return from these interrupts and expose sensitive
+data. In the future, that could be mitigated by forcing softirqs into threaded
+mode by utilizing a mechanism similar to ``CONFIG_PREEMPT_RT``.
+
+Yet another issue with this is, for multiqueue devices with managed
+interrupts, the IRQ affinities cannot be changed; however it could be
+possible to force a reduced number of queues which would in turn allow to
+shield one or two CPUs from such interrupts and queue handling for the price
+of indirection.
+
+2. Running IRQs as threaded-IRQs
+################################
+This would result in forcing IRQs into the scheduler which would then provide
+the process-context mitigation. However, not all interrupts can be threaded.
+Also this does nothing about syscall entries.
+
+3. Kernel Address Space Isolation
+#################################
+System calls could run in a much restricted address space which is
+guaranteed not to leak any sensitive data. There are practical limitation in
+implementing this - the main concern being how to decide on an address space
+that is guaranteed to not have any sensitive data.
+
+4. Limited cookie-based protection
+##################################
+On a system call, change the cookie to the system trusted cookie and initiate a
+schedule event. This would be better than pausing all the siblings during the
+entire duration for the system call, but still would be a huge hit to the
+performance.
+
+Trust model
+-----------
+Core scheduling maintains trust relationships amongst groups of tasks by
+assigning the tag of them with the same cookie value.
+When a system with core scheduling boots, all tasks are considered to trust
+each other. This is because the core scheduler does not have information about
+trust relationships until userspace uses the above mentioned interfaces, to
+communicate them. In other words, all tasks have a default cookie value of 0.
+and are considered system-wide trusted. The stunning of siblings running
+cookie-0 tasks is also avoided.
+
+Once userspace uses the above mentioned interfaces to group sets of tasks, tasks
+within such groups are considered to trust each other, but do not trust those
+outside. Tasks outside the group also don't trust tasks within.
+
+coresched command line option
+-----------------------------
+The coresched kernel command line option can be used to:
+  - Keep coresched on even if system is not vulnerable x (``coresched=on``).
+  - Keep coresched off even if system is vulnerable (``coresched=off``).
+  - Keep coresched on only if system is vulnerable x (``coresched=secure``).
+
+The default is ``coresched=secure``. However a user who has a usecase that
+needs core-scheduling, such as improving performance of VMs by tagging vCPU
+threads, could pass ``coresched=on`` to force it on.
+
+Limitations in core-scheduling
+------------------------------
+Core scheduling tries to guarantee that only trusted tasks run concurrently on a
+core. But there could be small window of time during which untrusted tasks run
+concurrently or kernel could be running concurrently with a task not trusted by
+kernel.
+
+1. IPI processing delays
+########################
+Core scheduling selects only trusted tasks to run together. IPI is used to notify
+the siblings to switch to the new task. But there could be hardware delays in
+receiving of the IPI on some arch (on x86, this has not been observed). This may
+cause an attacker task to start running on a CPU before its siblings receive the
+IPI. Even though cache is flushed on entry to user mode, victim tasks on siblings
+may populate data in the cache and micro architectural buffers after the attacker
+starts to run and this is a possibility for data leak.
+
+Open cross-HT issues that core scheduling does not solve
+--------------------------------------------------------
+1. For MDS
+##########
+Core scheduling cannot protect against MDS attacks between an HT running in
+user mode and another running in kernel mode. Even though both HTs run tasks
+which trust each other, kernel memory is still considered untrusted. Such
+attacks are possible for any combination of sibling CPU modes (host or guest mode).
+
+2. For L1TF
+###########
+Core scheduling cannot protect against an L1TF guest attacker exploiting a
+guest or host victim. This is because the guest attacker can craft invalid
+PTEs which are not inverted due to a vulnerable guest kernel. The only
+solution is to disable EPT (Extended Page Tables).
+
+For both MDS and L1TF, if the guest vCPU is configured to not trust each
+other (by tagging separately), then the guest to guest attacks would go away.
+Or it could be a system admin policy which considers guest to guest attacks as
+a guest problem.
+
+Another approach to resolve these would be to make every untrusted task on the
+system to not trust every other untrusted task. While this could reduce
+parallelism of the untrusted tasks, it would still solve the above issues while
+allowing system processes (trusted tasks) to share a core.
+
+Use cases
+---------
+The main use case for Core scheduling is mitigating the cross-HT vulnerabilities
+with SMT enabled. There are other use cases where this feature could be used:
+
+- Isolating tasks that needs a whole core: Examples include realtime tasks, tasks
+  that uses SIMD instructions etc.
+- Gang scheduling: Requirements for a group of tasks that needs to be scheduled
+  together could also be realized using core scheduling. One example is vCPUs of
+  a VM.
+
+Future work
+-----------
+Skipping per-HT mitigations if task is trusted
+##############################################
+If core scheduling is enabled, by default all tasks trust each other as
+mentioned above. In such scenario, it may be desirable to skip the same-HT
+mitigations on return to the trusted user-mode to improve performance.
diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/admin-guide/hw-vuln/index.rst
index ca4dbdd9016d..f12cda55538b 100644
--- a/Documentation/admin-guide/hw-vuln/index.rst
+++ b/Documentation/admin-guide/hw-vuln/index.rst
@@ -15,3 +15,4 @@ are configurable at compile, boot or run time.
    tsx_async_abort
    multihit.rst
    special-register-buffer-data-sampling.rst
+   core-scheduling.rst
-- 
2.31.0.291.g576ba9dcdaf-goog

