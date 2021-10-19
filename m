Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFBD433B28
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbhJSPxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:53:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35631 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233237AbhJSPxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634658648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Mk4E43F/Veti7bcfCZwAkC8O+dV/ImV1l/8yZTYg+EM=;
        b=WLbox3pVQtpHUKOR/DJ9jIRIgR8WLjfarmfayE5MMPGJKLGM31DaH1HezEdPsYQsdj5LFT
        qrC+L25f27wGdwLvT2p204mJlZ1s6CZJmFezMaaF8+fttops7F9zpYMwYJlM2OE6fW0P+F
        ePQgEdWOjDcKY0E2XItJfDHYA4V4UXs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-fQE2RqqFPWuZTEgSDSmXKw-1; Tue, 19 Oct 2021 11:50:46 -0400
X-MC-Unique: fQE2RqqFPWuZTEgSDSmXKw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6669F80A5D9;
        Tue, 19 Oct 2021 15:50:42 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-7.gru2.redhat.com [10.97.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 91ECC1037F40;
        Tue, 19 Oct 2021 15:50:03 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id D0A324188581; Tue, 19 Oct 2021 12:49:35 -0300 (-03)
Message-ID: <20211019154210.706067872@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Tue, 19 Oct 2021 12:24:33 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch v5 2/8] add prctl task isolation prctl docs and samples
References: <20211019152431.885037499@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation and userspace sample code for prctl
task isolation interface.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
v4:
 - Switch to structures for parameters when possible
   (which are more extensible).
 - Switch to CFG_{S,G}ET naming and use drop
   "internal configuration" prctls            (Frederic Weisbecker).
 - Add summary of terms to documentation      (Frederic Weisbecker).
 - Examples for compute and one-shot modes    (Thomas G/Christoph L).

v3:
 - Split in smaller patches              (Nitesh Lal).
 - Misc cleanups                         (Nitesh Lal).
 - Clarify nohz_full is not a dependency (Nicolas Saenz).
 - Incorrect values for prctl definitions (kernel robot).
 - Save configured state, so applications
   can activate externally configured
   task isolation parameters.
-  Remove "system default" notion (chisol should
   make it obsolete).
 - Update documentation: add new section with explanation
   about configuration/activation and code example.
 - Update samples.

v2:

- Finer-grained control of quiescing (Frederic Weisbecker / Nicolas Saenz).
- Avoid potential regressions by allowing applications
  to use ISOL_F_QUIESCE_DEFMASK (whose default value
  is configurable in /sys/).         (Nitesh Lal / Nicolas Saenz).

 Documentation/userspace-api/task_isolation.rst |  389 +++++++++++++++++++++++++
 samples/Kconfig                                |    7 
 samples/Makefile                               |    1 
 samples/task_isolation/Makefile                |   11 
 samples/task_isolation/task_isol.c             |   92 +++++
 samples/task_isolation/task_isol.h             |    9 
 samples/task_isolation/task_isol_computation.c |   92 +++++
 samples/task_isolation/task_isol_oneshot.c     |   92 +++++
 samples/task_isolation/task_isol_userloop.c    |   59 +++
 9 files changed, 752 insertions(+)

Index: linux-2.6/Documentation/userspace-api/task_isolation.rst
===================================================================
--- /dev/null
+++ linux-2.6/Documentation/userspace-api/task_isolation.rst
@@ -0,0 +1,389 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============================
+Task isolation prctl interface
+===============================
+
+Certain types of applications benefit from running uninterrupted by
+background OS activities. Realtime systems and high-bandwidth networking
+applications with user-space drivers can fall into the category.
+
+To create an OS noise free environment for the application, this
+interface allows userspace to inform the kernel the start and
+end of the latency sensitive application section (with configurable
+system behaviour for that section).
+
+Note: the prctl interface is independent of nohz_full=.
+
+The prctl options are:
+
+
+        - PR_ISOL_FEAT_GET: Retrieve supported features.
+        - PR_ISOL_CFG_GET: Retrieve task isolation configuration.
+        - PR_ISOL_CFG_SET: Set task isolation configuration.
+        - PR_ISOL_ACTIVATE_GET: Retrieve task isolation activation state.
+        - PR_ISOL_ACTIVATE_SET: Set task isolation activation state.
+
+Summary of terms:
+
+
+- feature:
+
+        A distinct attribute or aspect of task isolation. Examples of
+        features could be logging, new operating modes (eg: syscalls disallowed),
+        userspace notifications, etc. The only feature currently available is quiescing.
+
+- configuration:
+
+        A specific choice from a given set
+        of possible choices that dictate how the particular feature
+        in question should behave.
+
+- activation state:
+
+        The activation state (whether activate/inactive) of the task
+        isolation features (features must be configured before
+        being activated).
+
+Inheritance of the isolation parameters and state, across
+fork(2) and clone(2), can be changed via
+PR_ISOL_CFG_GET/PR_ISOL_CFG_SET.
+
+
+At a high-level, task isolation is divided in two steps:
+
+1. Configuration.
+2. Activation.
+
+Section "Userspace support" describes how to use
+task isolation.
+
+In terms of the interface, the sequence of steps to activate
+task isolation are:
+
+1. Retrieve supported task isolation features (PR_ISOL_FEAT_GET).
+2. Configure task isolation features (PR_ISOL_CFG_GET/PR_ISOL_CFG_SET).
+3. Activate or deactivate task isolation features (PR_ISOL_ACTIVATE_GET/PR_ISOL_ACTIVATE_SET).
+
+This interface is based on ideas and code from the
+task isolation patchset from Alex Belits:
+https://lwn.net/Articles/816298/
+
+--------------------
+Feature description
+--------------------
+
+        - ``ISOL_F_QUIESCE``
+
+        This feature allows quiescing select kernel activities on
+        return from system calls.
+
+---------------------
+Interface description
+---------------------
+
+**PR_ISOL_FEAT**:
+
+        Returns the supported features and feature
+        capabilities, as a bitmask::
+
+                prctl(PR_ISOL_FEAT, feat, arg3, arg4, arg5);
+
+        The 'feat' argument specifies whether to return
+        supported features (if zero), or feature capabilities
+        (if not zero). Possible values for 'feat' are:
+
+
+        - ``0``:
+               Return the bitmask of supported features, in the location
+               pointed  to  by  ``(int *)arg3``. The buffer should allow space
+               for 8 bytes.
+
+        - ``ISOL_F_QUIESCE``:
+
+               Return a structure containing which kernel
+               activities are supported for quiescing, in the location
+               pointed to by ``(int *)arg3``::
+
+                        struct task_isol_quiesce_extensions {
+                                __u64 flags;
+                                __u64 supported_quiesce_bits;
+                                __u64 pad[6];
+                        };
+
+               Where:
+
+               *flags*: Additional flags (should be zero).
+
+               *supported_quiesce_bits*: Bitmask indicating
+                which features are supported for quiescing.
+
+               *pad*: Additional space for future enhancements.
+
+
+        Features and its capabilities are defined at
+        include/uapi/linux/task_isolation.h.
+
+**PR_ISOL_CFG_GET**:
+
+        Retrieve task isolation configuration.
+        The general format is::
+
+                prctl(PR_ISOL_CFG_GET, what, arg3, arg4, arg5);
+
+        The 'what' argument specifies what to configure. Possible values are:
+
+        - ``I_CFG_FEAT``:
+
+                Return configuration of task isolation features. The 'arg3' argument specifies
+                whether to return configured features (if zero), or individual
+                feature configuration (if not zero), as follows.
+
+                - ``0``:
+
+                        Return the bitmask of configured features, in the location
+                        pointed  to  by  ``(int *)arg4``. The buffer should allow space
+                        for 8 bytes.
+
+                - ``ISOL_F_QUIESCE``:
+
+                        Return the control structure for quiescing of background
+                        kernel activities, in the location pointed to by
+                        ``(int *)arg4``::
+
+                         struct task_isol_quiesce_control {
+                                __u64 flags;
+                                __u64 quiesce_mask;
+                                __u64 pad[6];
+                         };
+
+                        Where:
+
+                        *flags*: Additional flags (should be zero).
+
+                        *quiesce_mask*: A bitmask containing which activities
+                        are configured for quiescing.
+
+                        *pad*: Additional space for future enhancements.
+
+        - ``I_CFG_INHERIT``:
+
+                Retrieve inheritance configuration across fork/clone.
+
+                Return the structure which configures inheritance
+                across fork/clone, in the location pointed to
+                by ``(int *)arg4``::
+
+                        struct task_isol_inherit_control {
+                                __u8    inherit_mask;
+                                __u8    pad[7];
+                        };
+
+                See PR_ISOL_CFG_SET description for meaning of bits.
+
+**PR_ISOL_CFG_SET**:
+
+        Set task isolation configuration.
+        The general format is::
+
+                prctl(PR_ISOL_CFG_SET, what, arg3, arg4, arg5);
+
+        The 'what' argument specifies what to configure. Possible values are:
+
+        - ``I_CFG_FEAT``:
+
+                Set configuration of task isolation features. 'arg3' specifies
+                the feature. Possible values are:
+
+                - ``ISOL_F_QUIESCE``:
+
+                        Set the control structure for quiescing of background
+                        kernel activities, from the location pointed to by
+                        ``(int *)arg4``::
+
+                         struct task_isol_quiesce_control {
+                                __u64 flags;
+                                __u64 quiesce_mask;
+                                __u64 pad[6];
+                         };
+
+                        Where:
+
+                        *flags*: Additional flags (should be zero).
+
+                        *quiesce_mask*: A bitmask containing which kernel
+                        activities to quiesce.
+
+                        *pad*: Additional space for future enhancements.
+
+                        For quiesce_mask, possible bit sets are:
+
+                        - ``ISOL_F_QUIESCE_VMSTATS``
+
+                        VM statistics are maintained in per-CPU counters to
+                        improve performance. When a CPU modifies a VM statistic,
+                        this modification is kept in the per-CPU counter.
+                        Certain activities require a global count, which
+                        involves requesting each CPU to flush its local counters
+                        to the global VM counters.
+
+                        This flush is implemented via a workqueue item, which
+                        might schedule a workqueue on isolated CPUs.
+
+                        To avoid this interruption, task isolation can be
+                        configured to, upon return from system calls, synchronize
+                        the per-CPU counters to global counters, thus avoiding
+                        the interruption.
+
+                        To ensure the application returns to userspace
+                        with no modified per-CPU counters, its necessary to
+                        use mlockall() in addition to this isolcpus flag.
+
+        - ``I_CFG_INHERIT``:
+                Set inheritance configuration when a new task
+                is created via fork and clone.
+
+                The ``(int *)arg4`` argument is a pointer to::
+
+                        struct task_isol_inherit_control {
+                                __u8    inherit_mask;
+                                __u8    pad[7];
+                        };
+
+                inherit_mask is a bitmask that specifies which part
+                of task isolation should be inherited:
+
+                - Bit ISOL_INHERIT_CONF: Inherit task isolation configuration.
+                  This is the stated written via prctl(PR_ISOL_CFG_SET, ...).
+
+                - Bit ISOL_INHERIT_ACTIVE: Inherit task isolation activation
+                  (requires ISOL_INHERIT_CONF to be set). The new task
+                  should behave, after fork/clone, in the same manner
+                  as the parent task after it executed:
+
+                        prctl(PR_ISOL_ACTIVATE_SET, &mask, ...);
+
+**PR_ISOL_ACTIVATE_GET**:
+
+        Retrieve task isolation activation state.
+
+        The general format is::
+
+                prctl(PR_ISOL_ACTIVATE_GET, pmask, arg3, arg4, arg5);
+
+        'pmask' specifies the location of a feature mask, where
+        the current active mask will be copied. See PR_ISOL_ACTIVATE_SET
+        for description of individual bits.
+
+
+**PR_ISOL_ACTIVATE_SET**:
+
+        Set task isolation activation state (activates/deactivates
+        task isolation).
+
+        The general format is::
+
+                prctl(PR_ISOL_ACTIVATE_SET, pmask, arg3, arg4, arg5);
+
+
+        The 'pmask' argument specifies the location of an 8 byte mask
+        containing which features should be activated. Features whose
+        bits are cleared will be deactivated. The possible
+        bits for this mask are:
+
+                - ``ISOL_F_QUIESCE``:
+
+                Activate quiescing of background kernel activities.
+                Quiescing happens on return to userspace from this
+                system call, and on return from subsequent
+                system calls (unless quiesce_oneshot_mask is configured,
+                see below).
+
+        If the arg3 argument is non-zero, it specifies a pointer to::
+
+         struct task_isol_activate_control {
+                 __u64 flags;
+                 __u64 quiesce_oneshot_mask;
+                 __u64 pad[6];
+         };
+
+        Where:
+
+         *flags*: Additional flags (should be zero).
+
+         *quiesce_oneshot_mask*: Quiescing for the kernel activities
+          with bits set on this mask will happen on the return
+          from this system call, but not on return from subsequent ones.
+
+        Quiescing can be adjusted (while active) by
+        prctl(PR_ISOL_ACTIVATE_SET, &new_mask, ...).
+
+
+==================
+Userspace support
+==================
+
+Task isolation is divided in two main steps: configuration and activation.
+
+Each step can be performed by an external tool or the latency sensitive
+application itself. util-linux contains the "chisol" tool for this
+purpose.
+
+This results in three combinations:
+
+1. Both configuration and activation performed by the
+latency sensitive application.
+Allows fine grained control of what task isolation
+features are enabled and when (see samples section below).
+
+2. Only activation can be performed by the latency sensitive app
+(and configuration performed by chisol).
+This allows the admin/user to control task isolation parameters,
+and applications have to be modified only once.
+
+3. Configuration and activation performed by an external tool.
+This allows unmodified applications to take advantage of
+task isolation. Activation is performed by the "-a" option
+of chisol.
+
+========
+Examples
+========
+
+The ``samples/task_isolation/`` directory contains 3 examples:
+
+* task_isol_userloop.c:
+
+        Example of program with a loop on userspace scenario.
+
+* task_isol_computation.c:
+
+        Example of program that enters task isolated mode,
+        performs an amount of computation, exits task
+        isolated mode, and writes the computation to disk.
+
+* task_isol_oneshot.c:
+
+        Example of program that enables one-shot
+        mode for quiescing, enters a processing loop, then upon an external
+        event performs a number of syscalls to handle that event.
+
+This is a snippet of code to activate task isolation if
+it has been previously configured (by chisol for example)::
+
+        #include <sys/prctl.h>
+        #include <linux/types.h>
+
+        #ifdef PR_ISOL_CFG_GET
+        unsigned long long fmask;
+
+        ret = prctl(PR_ISOL_CFG_GET, I_CFG_FEAT, 0, &fmask, 0);
+        if (ret != -1 && fmask != 0) {
+                ret = prctl(PR_ISOL_ACTIVATE_SET, &fmask, 0, 0, 0);
+                if (ret == -1) {
+                        perror("prctl PR_ISOL_ACTIVATE_SET");
+                        return ret;
+                }
+        }
+        #endif
+
Index: linux-2.6/samples/task_isolation/task_isol.c
===================================================================
--- /dev/null
+++ linux-2.6/samples/task_isolation/task_isol.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/mman.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/prctl.h>
+#include <linux/prctl.h>
+#include <errno.h>
+#include "task_isol.h"
+
+#ifdef PR_ISOL_FEAT_GET
+int task_isol_setup(void)
+{
+	int ret;
+	int errnosv;
+	unsigned long long fmask;
+	struct task_isol_quiesce_extensions qext;
+	struct task_isol_quiesce_control qctrl;
+
+	/* Retrieve supported task isolation features */
+	ret = prctl(PR_ISOL_FEAT_GET, 0, &fmask, 0, 0);
+	if (ret == -1) {
+		perror("prctl PR_ISOL_FEAT");
+		return ret;
+	}
+	printf("supported features bitmask: 0x%llx\n", fmask);
+
+	/* Retrieve supported ISOL_F_QUIESCE bits */
+	ret = prctl(PR_ISOL_FEAT_GET, ISOL_F_QUIESCE, &qext, 0, 0);
+	if (ret == -1) {
+		perror("prctl PR_ISOL_FEAT (ISOL_F_QUIESCE)");
+		return ret;
+	}
+	printf("supported ISOL_F_QUIESCE bits: 0x%llx\n",
+		qext.supported_quiesce_bits);
+
+	fmask = 0;
+	ret = prctl(PR_ISOL_CFG_GET, I_CFG_FEAT, 0, &fmask, 0);
+	errnosv = errno;
+	if (ret != -1 && fmask != 0) {
+		printf("Task isolation parameters already configured!\n");
+		return ret;
+	}
+	if (ret == -1 && errnosv != ENODATA) {
+		perror("prctl PR_ISOL_GET");
+		return ret;
+	}
+	memset(&qctrl, 0, sizeof(struct task_isol_quiesce_control));
+	qctrl.quiesce_mask = ISOL_F_QUIESCE_VMSTATS;
+	ret = prctl(PR_ISOL_CFG_SET, I_CFG_FEAT, ISOL_F_QUIESCE, &qctrl, 0);
+	if (ret == -1) {
+		perror("prctl PR_ISOL_CFG_SET");
+		return ret;
+	}
+	return ISOL_F_QUIESCE;
+}
+
+int task_isol_activate_set(unsigned long long mask, int oneshot)
+{
+	int ret;
+	struct task_isol_activate_control act_ctrl;
+
+	if (oneshot)
+		act_ctrl.quiesce_oneshot_mask = ISOL_F_QUIESCE_VMSTATS;
+
+	ret = prctl(PR_ISOL_ACTIVATE_SET, &mask, &act_ctrl, 0, 0);
+	if (ret == -1) {
+		perror("prctl PR_ISOL_ACTIVATE_SET");
+		return -1;
+	}
+
+	return 0;
+}
+
+#else
+
+int task_isol_setup(void)
+{
+	return 0;
+}
+
+int task_isol_activate_set(unsigned long long mask)
+{
+	return 0;
+}
+#endif
+
+
Index: linux-2.6/samples/task_isolation/task_isol.h
===================================================================
--- /dev/null
+++ linux-2.6/samples/task_isolation/task_isol.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __TASK_ISOL_H
+#define __TASK_ISOL_H
+
+int task_isol_setup(void);
+
+int task_isol_activate_set(unsigned long long mask, int oneshot);
+
+#endif /* __TASK_ISOL_H */
Index: linux-2.6/samples/task_isolation/task_isol_userloop.c
===================================================================
--- /dev/null
+++ linux-2.6/samples/task_isolation/task_isol_userloop.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/mman.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/prctl.h>
+#include <linux/prctl.h>
+#include "task_isol.h"
+
+int main(void)
+{
+	int ret;
+	void *buf = malloc(4096);
+	unsigned long mask;
+
+	memset(buf, 1, 4096);
+	ret = mlock(buf, 4096);
+	if (ret) {
+		perror("mlock");
+		return EXIT_FAILURE;
+	}
+
+	ret = task_isol_setup();
+	if (ret == -1)
+		return EXIT_FAILURE;
+	mask = ret;
+
+	mask = ISOL_F_QUIESCE;
+	ret = prctl(PR_ISOL_ACTIVATE_SET, &mask, 0, 0, 0);
+	if (ret == -1) {
+		perror("prctl PR_ISOL_ACTIVATE_SET (ISOL_F_QUIESCE)");
+		return EXIT_FAILURE;
+	}
+
+#define NR_LOOPS 999999999
+#define NR_PRINT 100000000
+	/* busy loop */
+	while (ret < NR_LOOPS)  {
+		memset(buf, 0, 4096);
+		ret = ret+1;
+		if (!(ret % NR_PRINT))
+			printf("loops=%d of %d\n", ret, NR_LOOPS);
+	}
+
+
+	mask = 0;
+	ret = prctl(PR_ISOL_ACTIVATE_SET, &mask, 0, 0, 0);
+	if (ret == -1) {
+		perror("prctl PR_ISOL_ACTIVATE_SET (0)");
+		return EXIT_FAILURE;
+	}
+
+	return EXIT_SUCCESS;
+}
+
Index: linux-2.6/samples/Kconfig
===================================================================
--- linux-2.6.orig/samples/Kconfig
+++ linux-2.6/samples/Kconfig
@@ -223,4 +223,11 @@ config SAMPLE_WATCH_QUEUE
 	  Build example userspace program to use the new mount_notify(),
 	  sb_notify() syscalls and the KEYCTL_WATCH_KEY keyctl() function.
 
+config SAMPLE_TASK_ISOLATION
+	bool "task isolation sample"
+	depends on CC_CAN_LINK && HEADERS_INSTALL
+	help
+	  Build example userspace program to use prctl task isolation
+	  interface.
+
 endif # SAMPLES
Index: linux-2.6/samples/Makefile
===================================================================
--- linux-2.6.orig/samples/Makefile
+++ linux-2.6/samples/Makefile
@@ -30,3 +30,4 @@ obj-$(CONFIG_SAMPLE_INTEL_MEI)		+= mei/
 subdir-$(CONFIG_SAMPLE_WATCHDOG)	+= watchdog
 subdir-$(CONFIG_SAMPLE_WATCH_QUEUE)	+= watch_queue
 obj-$(CONFIG_DEBUG_KMEMLEAK_TEST)	+= kmemleak/
+subdir-$(CONFIG_SAMPLE_TASK_ISOLATION)	+= task_isolation
Index: linux-2.6/samples/task_isolation/Makefile
===================================================================
--- /dev/null
+++ linux-2.6/samples/task_isolation/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+userprogs-always-y += task_isol_userloop task_isol_computation task_isol_oneshot
+task_isol_userloop-objs := task_isol.o task_isol_userloop.o
+task_isol_computation-objs := task_isol.o task_isol_computation.o
+task_isol_oneshot-objs := task_isol.o task_isol_oneshot.o
+
+userccflags += -I usr/include
+
+
+#$(CC) $^ -o $@
Index: linux-2.6/samples/task_isolation/task_isol_computation.c
===================================================================
--- /dev/null
+++ linux-2.6/samples/task_isolation/task_isol_computation.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Example of task isolation prctl interface with a loop:
+ *
+ *	do {
+ *		enable quiescing of kernel activities
+ *		perform computation
+ *		disable quiescing of kernel activities
+ *		write computation results to disk
+ *	} while (condition);
+ *
+ * Copyright (C) 2021 Red Hat, Inc.
+ *
+ * Marcelo Tosatti <mtosatti@redhat.com>
+ */
+#include <sys/mman.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/prctl.h>
+#include <linux/prctl.h>
+#include "task_isol.h"
+
+int main(void)
+{
+	int ret, fd, write_loops;
+	void *buf = malloc(4096);
+	unsigned long mask;
+
+	fd = open("/tmp/comp_output.data", O_RDWR|O_CREAT);
+	if (fd == -1) {
+		perror("open");
+		return EXIT_FAILURE;
+	}
+
+	memset(buf, 1, 4096);
+	ret = mlock(buf, 4096);
+	if (ret) {
+		perror("mlock");
+		return EXIT_FAILURE;
+	}
+
+	ret = task_isol_setup();
+	if (ret == -1)
+		return EXIT_FAILURE;
+
+	mask = ret;
+
+	write_loops = 0;
+	do {
+#define NR_LOOPS 999999999
+#define NR_PRINT 100000000
+		/* enable quiescing on system call return */
+		ret = task_isol_activate_set(mask, 0);
+		if (ret)
+			return EXIT_FAILURE;
+
+		/* busy loop */
+		while (ret < NR_LOOPS)  {
+			memset(buf, 0xf, 4096);
+			ret = ret+1;
+			if (!(ret % NR_PRINT))
+				printf("wloop=%d loops=%d of %d\n", write_loops,
+					ret, NR_LOOPS);
+		}
+		/* disable quiescing on system call return */
+		ret = task_isol_activate_set(mask & ~ISOL_F_QUIESCE, 0);
+		if (ret)
+			return EXIT_FAILURE;
+
+		/*
+		 * write computed data to disk, this would be
+		 * multiple writes on a real application, so
+		 * disabling quiescing is advantageous
+		 */
+		ret = write(fd, buf, 4096);
+		if (ret == -1) {
+			perror("write");
+			return EXIT_FAILURE;
+		}
+
+		write_loops += 1;
+	} while (write_loops < 5);
+
+
+	return EXIT_SUCCESS;
+}
+
Index: linux-2.6/samples/task_isolation/task_isol_oneshot.c
===================================================================
--- /dev/null
+++ linux-2.6/samples/task_isolation/task_isol_oneshot.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Example of task isolation prctl interface using
+ * oneshot mode for quiescing.
+ *
+ *	do {
+ *		enable oneshot quiescing of kernel activities
+ *		process data (no system calls)
+ *		if (event) {
+ *			process event with syscalls
+ *			enable oneshot quiescing of kernel activities
+ *		}
+ *	} while (exit_condition);
+ *
+ * Copyright (C) 2021 Red Hat, Inc.
+ *
+ * Marcelo Tosatti <mtosatti@redhat.com>
+ */
+#include <sys/mman.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/prctl.h>
+#include <linux/prctl.h>
+#include "task_isol.h"
+
+int main(void)
+{
+	int ret, fd;
+	void *buf = malloc(4096);
+	unsigned long mask;
+
+	fd = open("/dev/zero", O_RDONLY);
+	if (fd == -1) {
+		perror("open");
+		return EXIT_FAILURE;
+	}
+
+	memset(buf, 1, 4096);
+	ret = mlock(buf, 4096);
+	if (ret) {
+		perror("mlock");
+		return EXIT_FAILURE;
+	}
+
+	ret = task_isol_setup();
+	if (ret == -1)
+		return EXIT_FAILURE;
+
+	mask = ret;
+
+#define NR_LOOPS 999999999
+#define NR_PRINT 100000000
+
+	/* enable quiescing on system call return, oneshot */
+	ret = task_isol_activate_set(mask, 1);
+	if (ret)
+		return EXIT_FAILURE;
+	/* busy loop */
+	while (ret < NR_LOOPS)  {
+		memset(buf, 0xf, 4096);
+		ret = ret+1;
+		if (!(ret % NR_PRINT)) {
+			int i, r;
+
+			/* this could be considered handling an external
+			 * event: with one-shot mode, system calls
+			 * after prctl(PR_SET_ACTIVATE) will not incur
+			 * the penalty of quiescing
+			 */
+			printf("loops=%d of %d\n", ret, NR_LOOPS);
+			for (i = 0; i < 100; i++) {
+				r = read(fd, buf, 4096);
+				if (r == -1) {
+					perror("read");
+					return EXIT_FAILURE;
+				}
+			}
+			/* enable quiescing on system call return, oneshot */
+			ret = task_isol_activate_set(mask, 1);
+			if (ret)
+				return EXIT_FAILURE;
+		}
+	}
+
+	return EXIT_SUCCESS;
+}
+


