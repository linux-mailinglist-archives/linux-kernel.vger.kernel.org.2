Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF59318625
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 09:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhBKIOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 03:14:42 -0500
Received: from mordac.selfhost.de ([82.98.82.6]:59534 "EHLO
        outgoing.selfhost.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229451AbhBKIOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 03:14:40 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Feb 2021 03:14:39 EST
Received: (qmail 10065 invoked from network); 11 Feb 2021 08:07:18 -0000
Received: from unknown (HELO dakara) (postmaster@wngmbjws.mail.selfhost.de@79.217.113.212)
  by mailout.selfhost.de with ESMTPA; 11 Feb 2021 08:07:18 -0000
Received: from atlantis.default.lan (orilla.lochmann.lan [192.168.111.113])
        by dakara (Postfix) with ESMTP id 046CB1DDEF;
        Thu, 11 Feb 2021 09:07:16 +0100 (CET)
From:   Alexander Lochmann <info@alexander-lochmann.de>
Cc:     Alexander Lochmann <info@alexander-lochmann.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Maciej Grochowski <maciej.grochowski@pm.me>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KCOV: Introduced tracing unique covered PCs
Date:   Thu, 11 Feb 2021 09:07:09 +0100
Message-Id: <20210211080716.80982-1-info@alexander-lochmann.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduced new tracing mode KCOV_MODE_UNIQUE.
It simply stores the executed PCs.
The execution order is discarded.
Each bit in the shared buffer represents every fourth
byte of the text segment.
Since a call instruction on every supported
architecture is at least four bytes, it is safe
to just store every fourth byte of the text segment.
In contrast to KCOV_MODE_TRACE_PC, the shared buffer
cannot overflow. Thus, all executed PCs are recorded.

Signed-off-by: Alexander Lochmann <info@alexander-lochmann.de>
---
 Documentation/dev-tools/kcov.rst | 80 ++++++++++++++++++++++++++++++++
 include/linux/kcov.h             |  4 +-
 include/uapi/linux/kcov.h        | 10 ++++
 kernel/kcov.c                    | 67 ++++++++++++++++++++------
 4 files changed, 147 insertions(+), 14 deletions(-)

diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kcov.rst
index 8548b0b04e43..4712a730a06a 100644
--- a/Documentation/dev-tools/kcov.rst
+++ b/Documentation/dev-tools/kcov.rst
@@ -127,6 +127,86 @@ That is, a parent process opens /sys/kernel/debug/kcov, enables trace mode,
 mmaps coverage buffer and then forks child processes in a loop. Child processes
 only need to enable coverage (disable happens automatically on thread end).
 
+If someone is interested in a set of executed PCs, and does not care about
+execution order, he or she can advise KCOV to do so:
+
+.. code-block:: c
+
+    #include <stdio.h>
+    #include <stddef.h>
+    #include <stdint.h>
+    #include <stdlib.h>
+    #include <sys/types.h>
+    #include <sys/stat.h>
+    #include <sys/ioctl.h>
+    #include <sys/mman.h>
+    #include <unistd.h>
+    #include <fcntl.h>
+
+    #define KCOV_INIT_TRACE			_IOR('c', 1, unsigned long)
+    #define KCOV_INIT_UNIQUE                _IOR('c', 2, unsigned long)
+    #define KCOV_ENABLE			_IO('c', 100)
+    #define KCOV_DISABLE			_IO('c', 101)
+
+    #define BITS_PER_LONG 64
+    #define KCOV_TRACE_PC  0
+    #define KCOV_TRACE_CMP 1
+    #define KCOV_UNIQUE_PC 2
+    /*
+     * Determine start of text segment via 'nm vmlinux | grep _stext | cut -d " " -f1',
+     * and fill in.
+     */
+    #define STEXT_START 0xffffffff81000000
+
+
+
+    int main(int argc, char **argv)
+    {
+	int fd;
+	unsigned long *cover, n, i;
+
+	/* A single fd descriptor allows coverage collection on a single
+	 * thread.
+	 */
+	fd = open("/sys/kernel/debug/kcov", O_RDWR);
+	if (fd == -1)
+		perror("open"), exit(1);
+	/* Setup trace mode and trace size. */
+	if ((n = ioctl(fd, KCOV_INIT_UNIQUE, 0)) < 0)
+		perror("ioctl"), exit(1);
+	/* Mmap buffer shared between kernel- and user-space. */
+	cover = (unsigned long*)mmap(NULL, n,
+				     PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if ((void*)cover == MAP_FAILED)
+		perror("mmap"), exit(1);
+	/* Enable coverage collection on the current thread. */
+	if (ioctl(fd, KCOV_ENABLE, KCOV_UNIQUE_PC))
+		perror("ioctl"), exit(1);
+	/* That's the target syscal call. */
+	read(-1, NULL, 0);
+	/* Disable coverage collection for the current thread. After this call
+	 * coverage can be enabled for a different thread.
+	 */
+	if (ioctl(fd, KCOV_DISABLE, 0))
+		perror("ioctl"), exit(1);
+        /* Convert byte size into element size */
+        n /= sizeof(unsigned long);
+        /* Print executed PCs in sorted order */
+        for (i = 0; i < n; i++) {
+            for (int j = 0; j < BITS_PER_LONG; j++) {
+                if (cover[i] & (1L << j)) {
+                    printf("0x%jx\n", (uintmax_t)(STEXT_START + (i * BITS_PER_LONG + j) * 4));
+                }
+            }
+        }
+	/* Free resources. */
+	if (munmap(cover, n * sizeof(unsigned long)))
+		perror("munmap"), exit(1);
+	if (close(fd))
+		perror("close"), exit(1);
+	return 0;
+    }
+
 Comparison operands collection
 ------------------------------
 
diff --git a/include/linux/kcov.h b/include/linux/kcov.h
index a10e84707d82..aa0c8bcf8299 100644
--- a/include/linux/kcov.h
+++ b/include/linux/kcov.h
@@ -19,7 +19,9 @@ enum kcov_mode {
 	 */
 	KCOV_MODE_TRACE_PC = 2,
 	/* Collecting comparison operands mode. */
-	KCOV_MODE_TRACE_CMP = 3,
+	KCOV_MODE_TRACE_CMP = 4,
+	/* Collecting unique covered PCs. Execution order is not saved. */
+	KCOV_MODE_UNIQUE_PC = 8,
 };
 
 #define KCOV_IN_CTXSW	(1 << 30)
diff --git a/include/uapi/linux/kcov.h b/include/uapi/linux/kcov.h
index 1d0350e44ae3..5b99b6d1a1ac 100644
--- a/include/uapi/linux/kcov.h
+++ b/include/uapi/linux/kcov.h
@@ -19,6 +19,7 @@ struct kcov_remote_arg {
 #define KCOV_REMOTE_MAX_HANDLES		0x100
 
 #define KCOV_INIT_TRACE			_IOR('c', 1, unsigned long)
+#define KCOV_INIT_UNIQUE		_IOR('c', 2, unsigned long)
 #define KCOV_ENABLE			_IO('c', 100)
 #define KCOV_DISABLE			_IO('c', 101)
 #define KCOV_REMOTE_ENABLE		_IOW('c', 102, struct kcov_remote_arg)
@@ -35,6 +36,15 @@ enum {
 	KCOV_TRACE_PC = 0,
 	/* Collecting comparison operands mode. */
 	KCOV_TRACE_CMP = 1,
+	/*
+	 * Unique coverage collection mode.
+	 * Unique covered PCs are collected in a per-task buffer.
+	 * De-duplicates the collected PCs. Execution order is *not* saved.
+	 * Each bit in the buffer represents every fourth byte of the text segment.
+	 * Since a call instruction is at least four bytes on every supported
+	 * architecture, storing just every fourth byte is sufficient.
+	 */
+	KCOV_UNIQUE_PC = 2,
 };
 
 /*
diff --git a/kernel/kcov.c b/kernel/kcov.c
index 6b8368be89c8..8f00ba6e672a 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -24,6 +24,7 @@
 #include <linux/refcount.h>
 #include <linux/log2.h>
 #include <asm/setup.h>
+#include <asm/sections.h>
 
 #define kcov_debug(fmt, ...) pr_debug("%s: " fmt, __func__, ##__VA_ARGS__)
 
@@ -171,7 +172,7 @@ static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_stru
 	 * kcov_start().
 	 */
 	barrier();
-	return mode == needed_mode;
+	return (mode & needed_mode) && !(mode & KCOV_IN_CTXSW);
 }
 
 static notrace unsigned long canonicalize_ip(unsigned long ip)
@@ -191,18 +192,26 @@ void notrace __sanitizer_cov_trace_pc(void)
 	struct task_struct *t;
 	unsigned long *area;
 	unsigned long ip = canonicalize_ip(_RET_IP_);
-	unsigned long pos;
+	unsigned long pos, idx;
 
 	t = current;
-	if (!check_kcov_mode(KCOV_MODE_TRACE_PC, t))
+	if (!check_kcov_mode(KCOV_MODE_TRACE_PC | KCOV_MODE_UNIQUE_PC, t))
 		return;
 
 	area = t->kcov_area;
-	/* The first 64-bit word is the number of subsequent PCs. */
-	pos = READ_ONCE(area[0]) + 1;
-	if (likely(pos < t->kcov_size)) {
-		area[pos] = ip;
-		WRITE_ONCE(area[0], pos);
+	if (likely(t->kcov_mode == KCOV_MODE_TRACE_PC)) {
+		/* The first 64-bit word is the number of subsequent PCs. */
+		pos = READ_ONCE(area[0]) + 1;
+		if (likely(pos < t->kcov_size)) {
+			area[pos] = ip;
+			WRITE_ONCE(area[0], pos);
+		}
+	} else {
+		idx = (ip - canonicalize_ip((unsigned long)&_stext)) / 4;
+		pos = idx % BITS_PER_LONG;
+		idx /= BITS_PER_LONG;
+		if (likely(idx < t->kcov_size))
+			WRITE_ONCE(area[idx], READ_ONCE(area[idx]) | 1L << pos);
 	}
 }
 EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
@@ -474,6 +483,7 @@ static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
 		goto exit;
 	}
 	if (!kcov->area) {
+		kcov_debug("mmap(): Allocating 0x%lx bytes\n", size);
 		kcov->area = area;
 		vma->vm_flags |= VM_DONTEXPAND;
 		spin_unlock_irqrestore(&kcov->lock, flags);
@@ -515,6 +525,8 @@ static int kcov_get_mode(unsigned long arg)
 {
 	if (arg == KCOV_TRACE_PC)
 		return KCOV_MODE_TRACE_PC;
+	else if (arg == KCOV_UNIQUE_PC)
+		return KCOV_MODE_UNIQUE_PC;
 	else if (arg == KCOV_TRACE_CMP)
 #ifdef CONFIG_KCOV_ENABLE_COMPARISONS
 		return KCOV_MODE_TRACE_CMP;
@@ -562,12 +574,13 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 {
 	struct task_struct *t;
 	unsigned long size, unused;
-	int mode, i;
+	int mode, i, text_size, ret = 0;
 	struct kcov_remote_arg *remote_arg;
 	struct kcov_remote *remote;
 	unsigned long flags;
 
 	switch (cmd) {
+	case KCOV_INIT_UNIQUE:
 	case KCOV_INIT_TRACE:
 		/*
 		 * Enable kcov in trace mode and setup buffer size.
@@ -581,11 +594,39 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 		 * that must not overflow.
 		 */
 		size = arg;
-		if (size < 2 || size > INT_MAX / sizeof(unsigned long))
-			return -EINVAL;
-		kcov->size = size;
+		if (cmd == KCOV_INIT_UNIQUE) {
+			if (size != 0)
+				return -EINVAL;
+			text_size = (canonicalize_ip((unsigned long)&_etext) - canonicalize_ip((unsigned long)&_stext));
+			/**
+			 * A call instr is at least four bytes on every supported architecture.
+			 * Hence, just every fourth instruction can potentially be a call.
+			 */
+			text_size /= 4;
+			/*
+			 * Round up size of text segment to multiple of BITS_PER_LONG.
+			 * Otherwise, we cannot track
+			 * the last (text_size % BITS_PER_LONG) addresses.
+			 */
+			text_size = roundup(text_size, BITS_PER_LONG);
+			/* Get the amount of bytes needed */
+			text_size = text_size / 8;
+			/* mmap() requires size to be a multiple of PAGE_SIZE */
+			text_size = roundup(text_size, PAGE_SIZE);
+			/* Get the cover size (= amount of longs stored) */
+			ret = text_size;
+			kcov->size = text_size / sizeof(unsigned long);
+			kcov_debug("text size = 0x%lx, roundup = 0x%x, kcov->size = 0x%x\n",
+					((unsigned long)&_etext) - ((unsigned long)&_stext),
+					text_size,
+					kcov->size);
+		} else {
+			if (size < 2 || size > INT_MAX / sizeof(unsigned long))
+				return -EINVAL;
+			kcov->size = size;
+		}
 		kcov->mode = KCOV_MODE_INIT;
-		return 0;
+		return ret;
 	case KCOV_ENABLE:
 		/*
 		 * Enable coverage for the current task.
-- 
2.30.0

