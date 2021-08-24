Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4873F61DF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 17:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238443AbhHXPns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 11:43:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34783 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238432AbhHXPn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 11:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629819762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=SPXcLMDixu4eIaWb/dHGatz15LKkn+BzByuMGx33SeI=;
        b=b+B1UgN3SOnDKq8VXkWxotj22BAhExz1KCyfdoDU9kUo50wcH7/u0GAoIZLaEPyyfA347y
        1taAVa40vA4tEWiMivGvkiAWQMRFZw93TvMfm27qEr8Au58faBh4cZ3id+jeBGlmQmHSt/
        cKRsL9/FbYAlFb1DrUHOu6boGdhxVU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-ABThdng5N5aYTaEY1r_4Cw-1; Tue, 24 Aug 2021 11:42:41 -0400
X-MC-Unique: ABThdng5N5aYTaEY1r_4Cw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADE8B871803;
        Tue, 24 Aug 2021 15:42:39 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E1E371B400;
        Tue, 24 Aug 2021 15:42:38 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 0B7FF416952E; Tue, 24 Aug 2021 12:42:15 -0300 (-03)
Message-ID: <20210824152646.706875395@fuller.cnet>
User-Agent: quilt/0.66
Date:   Tue, 24 Aug 2021 12:24:25 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch V3 2/8] add prctl task isolation prctl docs and samples
References: <20210824152423.300346181@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation and userspace sample code for prctl
task isolation interface.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 Documentation/userspace-api/task_isolation.rst |  211 +++++++++++++++++++++++++
 samples/Kconfig                                |    7 
 samples/Makefile                               |    1 
 samples/task_isolation/Makefile                |    9 +
 samples/task_isolation/task_isol.c             |   83 +++++++++
 samples/task_isolation/task_isol.h             |    9 +
 samples/task_isolation/task_isol_userloop.c    |   56 ++++++
 7 files changed, 376 insertions(+)

Index: linux-2.6/Documentation/userspace-api/task_isolation.rst
===================================================================
--- /dev/null
+++ linux-2.6/Documentation/userspace-api/task_isolation.rst
@@ -0,0 +1,281 @@
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
+        - PR_ISOL_FEAT: Retrieve supported features.
+        - PR_ISOL_GET: Retrieve task isolation parameters.
+        - PR_ISOL_SET: Set task isolation parameters.
+        - PR_ISOL_CTRL_GET: Retrieve task isolation state.
+        - PR_ISOL_CTRL_SET: Set task isolation state.
+        - PR_ISOL_GET_INT: Retrieve internal parameters.
+        - PR_ISOL_SET_INT: Retrieve internal parameters.
+
+
+
+Inheritance of the isolation parameters and state, across
+fork(2) and clone(2), can be changed via
+PR_ISOL_GET_INT/PR_ISOL_SET_INT.
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
+1. Retrieve supported task isolation features (PR_ISOL_FEAT).
+2. Configure task isolation features (PR_ISOL_SET/PR_ISOL_GET).
+3. Activate or deactivate task isolation features
+   (PR_ISOL_CTRL_GET/PR_ISOL_CTRL_SET).
+4. Optionally configure inheritance (PR_ISOL_GET_INT/PR_ISOL_SET_INT).
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
+        (if not zero). Possible non-zero values for 'feat' are:
+
+        - ``ISOL_F_QUIESCE``:
+
+                Returns a bitmask containing which kernel
+                activities are supported for quiescing.
+
+        Features and its capabilities are defined at include/uapi/linux/task_isolation.h.
+
+**PR_ISOL_GET**:
+
+        Retrieve task isolation feature configuration.
+        The general format is::
+
+                prctl(PR_ISOL_GET, feat, arg3, arg4, arg5);
+
+        The 'feat' argument specifies whether to return
+        configured features (if zero), or individual feature
+        configuration (if not zero). Possible non-zero
+        values for 'feat' are:
+
+        - ``ISOL_F_QUIESCE``:
+
+                Returns a bitmask containing which kernel
+                activities are enabled for quiescing.
+
+
+**PR_ISOL_SET**:
+
+        Configures task isolation features. The general format is::
+
+                prctl(PR_ISOL_SET, feat, arg3, arg4, arg5);
+
+        The 'feat' argument specifies which feature to configure.
+        Possible values for feat are:
+
+        - ``ISOL_F_QUIESCE``:
+
+                The 'arg3' argument is a bitmask specifying which
+                kernel activities to quiesce. Possible bit sets are:
+
+                - ``ISOL_F_QUIESCE_VMSTATS``
+
+                  VM statistics are maintained in per-CPU counters to
+                  improve performance. When a CPU modifies a VM statistic,
+                  this modification is kept in the per-CPU counter.
+                  Certain activities require a global count, which
+                  involves requesting each CPU to flush its local counters
+                  to the global VM counters.
+
+                  This flush is implemented via a workqueue item, which
+                  might schedule a workqueue on isolated CPUs.
+
+                  To avoid this interruption, task isolation can be
+                  configured to, upon return from system calls, synchronize
+                  the per-CPU counters to global counters, thus avoiding
+                  the interruption.
+
+                  To ensure the application returns to userspace
+                  with no modified per-CPU counters, its necessary to
+                  use mlockall() in addition to this isolcpus flag.
+
+**PR_ISOL_CTRL_GET**:
+
+        Retrieve task isolation control.
+
+                prctl(PR_ISOL_CTRL_GET, 0, 0, 0, 0);
+
+        Returns which isolation features are active.
+
+**PR_ISOL_CTRL_SET**:
+
+        Activates/deactivates task isolation control.
+
+                prctl(PR_ISOL_CTRL_SET, mask, 0, 0, 0);
+
+        The 'mask' argument specifies which features
+        to activate (bit set) or deactivate (bit clear).
+
+        For ISOL_F_QUIESCE, quiescing of background activities
+        happens on return to userspace from the
+        prctl(PR_ISOL_CTRL_SET) call, and on return from
+        subsequent system calls.
+
+        Quiescing can be adjusted (while active) by
+        prctl(PR_ISOL_SET, ISOL_F_QUIESCE, ...).
+
+**PR_ISOL_GET_INT**:
+
+        Retrieves task isolation internal parameters.
+
+        The general format is::
+
+                prctl(PR_ISOL_GET_INT, cmd, arg3, arg4, arg5);
+
+        The 'cmd' argument specifies which parameter to configure.
+        Possible values for cmd are:
+
+        - ``INHERIT_CFG``:
+
+                Retrieve inheritance configuration.
+
+                The 'arg3' argument is a pointer to a struct
+                inherit_control::
+
+                        struct task_isol_inherit_control {
+                                __u8    inherit_mask;
+                                __u8    pad[7];
+                        };
+
+                See PR_ISOL_SET_INT description below for meaning
+                of structure fields.
+
+**PR_ISOL_SET_INT**:
+
+        Sets task isolation internal parameters.
+
+        The general format is::
+
+                prctl(PR_ISOL_SET_INT, cmd, arg3, arg4, arg5);
+
+        The 'cmd' argument specifies which parameter to configure.
+        Possible values for cmd are:
+
+        - ``INHERIT_CFG``:
+
+                Set inheritance configuration when a new task
+                is created via fork and clone.
+
+                The 'arg3' argument is a pointer to a struct
+                inherit_control::
+
+                        struct task_isol_inherit_control {
+                                __u8    inherit_mask;
+                                __u8    pad[7];
+                        };
+
+                inherit_mask is a bitmask that specifies which part
+                of task isolation to be inherited:
+
+                - Bit ISOL_INHERIT_CONF: Inherit task isolation configuration.
+                  This is the stated written via prctl(PR_ISOL_SET, ...).
+
+                - Bit ISOL_INHERIT_ACTIVE: Inherit task isolation activation
+                  (requires ISOL_INHERIT_CONF to be set). The new task
+                  should behave, right after fork/clone, in the same manner
+                  as the parent task _after_ it executed:
+
+                        prctl(PR_ISOL_CTRL_SET, mask, 0, 0, 0);
+
+                  with a valid mask.
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
+The ``samples/task_isolation/`` directory contains sample
+code.
+
+This is a snippet of code to activate task isolation if
+it has been previously configured (by chisol for example)::
+
+        #include <sys/prctl.h>
+
+        #ifdef PR_ISOL_GET
+        ret = prctl(PR_ISOL_GET, 0, 0, 0, 0);
+        if (ret != -1) {
+                unsigned long mask = ret;
+
+                ret = prctl(PR_ISOL_CTRL_SET, mask, 0, 0, 0);
+                if (ret == -1) {
+                        perror("prctl PR_ISOL_CTRL_SET");
+                        return ret;
+                }
+        }
+        #endif
+
Index: linux-2.6/samples/task_isolation/task_isol.c
===================================================================
--- /dev/null
+++ linux-2.6/samples/task_isolation/task_isol.c
@@ -0,0 +1,83 @@
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
+#ifdef PR_ISOL_FEAT
+int task_isol_setup(void)
+{
+	int ret;
+	int errnosv;
+
+	/* Retrieve supported task isolation features */
+	ret = prctl(PR_ISOL_FEAT, 0, 0, 0, 0);
+	if (ret == -1) {
+		perror("prctl PR_ISOL_FEAT");
+		return ret;
+	}
+	printf("supported features bitmask: 0x%x\n", ret);
+
+	/* Retrieve supported ISOL_F_QUIESCE bits */
+	ret = prctl(PR_ISOL_FEAT, ISOL_F_QUIESCE, 0, 0, 0);
+	if (ret == -1) {
+		perror("prctl PR_ISOL_FEAT (ISOL_F_QUIESCE)");
+		return ret;
+	}
+	printf("supported ISOL_F_QUIESCE bits: 0x%x\n", ret);
+
+	/* Do not configure task isolation attributes if already set */
+	ret = prctl(PR_ISOL_GET, 0, 0, 0, 0);
+	errnosv = errno;
+	if (ret != -1) {
+		printf("Task isolation parameters already configured!\n");
+		return ret;
+	}
+	if (ret == -1 && errnosv != ENODATA) {
+		perror("prctl PR_ISOL_GET");
+		return ret;
+	}
+	ret = prctl(PR_ISOL_SET, ISOL_F_QUIESCE, ISOL_F_QUIESCE_VMSTATS,
+		    0, 0);
+	if (ret == -1) {
+		perror("prctl PR_ISOL_SET");
+		return ret;
+	}
+	return ISOL_F_QUIESCE;
+}
+
+int task_isol_ctrl_set(unsigned long mask)
+{
+	int ret;
+
+	ret = prctl(PR_ISOL_CTRL_SET, mask, 0, 0, 0);
+	if (ret == -1) {
+		perror("prctl PR_ISOL_CTRL_SET (ISOL_F_QUIESCE)");
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
+int task_isol_ctrl_set(unsigned long mask)
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
+int task_isol_ctrl_set(unsigned long mask);
+
+#endif /* __TASK_ISOL_H */
Index: linux-2.6/samples/task_isolation/task_isol_userloop.c
===================================================================
--- /dev/null
+++ linux-2.6/samples/task_isolation/task_isol_userloop.c
@@ -0,0 +1,56 @@
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
+	if (ret)
+		return EXIT_FAILURE;
+	mask = ret;
+
+	ret = prctl(PR_ISOL_CTRL_SET, mask, 0, 0, 0);
+	if (ret == -1) {
+		perror("prctl PR_ISOL_CTRL_SET (ISOL_F_QUIESCE)");
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
+	ret = prctl(PR_ISOL_CTRL_SET, 0, 0, 0, 0);
+	if (ret == -1) {
+		perror("prctl PR_ISOL_CTRL_SET (0)");
+		exit(0);
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
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+userprogs-always-y += task_isol_userloop
+task_isol_userloop-objs := task_isol.o task_isol_userloop.o
+
+userccflags += -I usr/include
+
+
+#$(CC) $^ -o $@


