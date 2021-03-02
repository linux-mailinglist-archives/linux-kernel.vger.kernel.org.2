Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D111232ADD4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838085AbhCBWPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:15:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:50484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241902AbhCBT5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 14:57:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94BE964F2C;
        Tue,  2 Mar 2021 19:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614714551;
        bh=EtkerXbRNH3qGNVegvRXwoZ3N+goMR33Q7nQ99CeQpo=;
        h=Date:From:To:Cc:Subject:From;
        b=KFOMLKIUcDw9ZSNSgipyK3Ft/C2OHshLzu555d5w/pIcSdf9sdEzIr4vtxLjTcu2R
         r4jGEh2XmkFMf8EAYPMu8XG9odp9hv+jd6ggaunZUHSh5JSp5/YV2Lt6zR/mDym5U9
         ejaVyHgJTZhqrjqpsPLMJpH45i2Vj/RRDWE0K2nm5sNbsllUw4PabcV0UO1g1tJGpM
         SKY6SzckK/nYmQMFkyuFxVLj8zL0Qul0uHw8a+YsdYVzisWlhAfkVQQQjC1MDOIegR
         uf2cZ9r4rCFe+Dt8JykdGM+0SyF9pInSuTTD+aJ3skTRzmMTiw4Hrr9SmFTEDqZFx7
         736F809KNXkMA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0E10340CD9; Tue,  2 Mar 2021 16:49:08 -0300 (-03)
Date:   Tue, 2 Mar 2021 16:49:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] tools headers: Update syscall.tbl files to support
 mount_setattr
Message-ID: <YD6Wsxr9ByUbab/a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To pick the changes from:

  9caccd41541a6f7d ("fs: introduce MOUNT_ATTR_IDMAP")

This adds this new syscall to the tables used by tools such as 'perf
trace', so that one can specify it by name and have it filtered, etc.

Addressing these perf build warnings:

  Warning: Kernel ABI header at 'tools/perf/arch/x86/entry/syscalls/syscall_64.tbl' differs from latest version at 'arch/x86/entry/syscalls/syscall_64.tbl'
  diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
  Warning: Kernel ABI header at 'tools/perf/arch/powerpc/entry/syscalls/syscall.tbl' differs from latest version at 'arch/powerpc/kernel/syscalls/syscall.tbl'
  diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/kernel/syscalls/syscall.tbl
  Warning: Kernel ABI header at 'tools/perf/arch/s390/entry/syscalls/syscall.tbl' differs from latest version at 'arch/s390/kernel/syscalls/syscall.tbl'
  diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/mount.h                 | 16 ++++++++++++++++
 .../perf/arch/powerpc/entry/syscalls/syscall.tbl |  1 +
 tools/perf/arch/s390/entry/syscalls/syscall.tbl  |  1 +
 .../perf/arch/x86/entry/syscalls/syscall_64.tbl  |  1 +
 4 files changed, 19 insertions(+)

diff --git a/tools/include/uapi/linux/mount.h b/tools/include/uapi/linux/mount.h
index dd8306ea336c19b6..e6524ead2b7b9ead 100644
--- a/tools/include/uapi/linux/mount.h
+++ b/tools/include/uapi/linux/mount.h
@@ -1,6 +1,8 @@
 #ifndef _UAPI_LINUX_MOUNT_H
 #define _UAPI_LINUX_MOUNT_H
 
+#include <linux/types.h>
+
 /*
  * These are the fs-independent mount-flags: up to 32 flags are supported
  *
@@ -117,5 +119,19 @@ enum fsconfig_command {
 #define MOUNT_ATTR_NOATIME	0x00000010 /* - Do not update access times. */
 #define MOUNT_ATTR_STRICTATIME	0x00000020 /* - Always perform atime updates */
 #define MOUNT_ATTR_NODIRATIME	0x00000080 /* Do not update directory access times */
+#define MOUNT_ATTR_IDMAP	0x00100000 /* Idmap mount to @userns_fd in struct mount_attr. */
+
+/*
+ * mount_setattr()
+ */
+struct mount_attr {
+	__u64 attr_set;
+	__u64 attr_clr;
+	__u64 propagation;
+	__u64 userns_fd;
+};
+
+/* List of all mount_attr versions. */
+#define MOUNT_ATTR_SIZE_VER0	32 /* sizeof first published struct */
 
 #endif /* _UAPI_LINUX_MOUNT_H */
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index 96b2157f03719b59..0b2480cf3e4793bd 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -521,3 +521,4 @@
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
 441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
+442	common	mount_setattr			sys_mount_setattr
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index d443423495e565e4..3abef2144dac79b6 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -444,3 +444,4 @@
 439  common	faccessat2		sys_faccessat2			sys_faccessat2
 440  common	process_madvise		sys_process_madvise		sys_process_madvise
 441  common	epoll_pwait2		sys_epoll_pwait2		compat_sys_epoll_pwait2
+442  common	mount_setattr		sys_mount_setattr		sys_mount_setattr
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index 78672124d28be0da..7bf01cbe582f03bc 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -363,6 +363,7 @@
 439	common	faccessat2		sys_faccessat2
 440	common	process_madvise		sys_process_madvise
 441	common	epoll_pwait2		sys_epoll_pwait2
+442	common	mount_setattr		sys_mount_setattr
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
-- 
2.29.2

