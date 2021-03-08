Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736C233132B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 17:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhCHQPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 11:15:43 -0500
Received: from foss.arm.com ([217.140.110.172]:40316 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230320AbhCHQPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 11:15:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC3671042;
        Mon,  8 Mar 2021 08:15:16 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D92963F73C;
        Mon,  8 Mar 2021 08:15:09 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v14 8/8] kselftest/arm64: Verify that TCO is enabled in load_unaligned_zeropad()
Date:   Mon,  8 Mar 2021 16:14:34 +0000
Message-Id: <20210308161434.33424-9-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210308161434.33424-1-vincenzo.frascino@arm.com>
References: <20210308161434.33424-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

load_unaligned_zeropad() and __get/put_kernel_nofault() functions can
read passed some buffer limits which may include some MTE granule with a
different tag.

When MTE async mode is enable, the load operation crosses the boundaries
and the next granule has a different tag the PE sets the TFSR_EL1.TF1
bit as if an asynchronous tag fault is happened:

 ==================================================================
 BUG: KASAN: invalid-access
 Asynchronous mode enabled: no access details available

 CPU: 0 PID: 1 Comm: init Not tainted 5.12.0-rc1-ge1045c86620d-dirty #8
 Hardware name: FVP Base RevC (DT)
 Call trace:
   dump_backtrace+0x0/0x1c0
   show_stack+0x18/0x24
   dump_stack+0xcc/0x14c
   kasan_report_async+0x54/0x70
   mte_check_tfsr_el1+0x48/0x4c
   exit_to_user_mode+0x18/0x38
   finish_ret_to_user+0x4/0x15c
 ==================================================================

Verify that Tag Check Override (TCO) is enabled in these functions before
the load and disable it afterwards to prevent this to happen.

Note: The issue has been observed only with an MTE enabled userspace.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Reported-by: Branislav Rankov <Branislav.Rankov@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 .../arm64/mte/check_read_beyond_buffer.c      | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/mte/check_read_beyond_buffer.c

diff --git a/tools/testing/selftests/arm64/mte/check_read_beyond_buffer.c b/tools/testing/selftests/arm64/mte/check_read_beyond_buffer.c
new file mode 100644
index 000000000000..eb03cd52a58e
--- /dev/null
+++ b/tools/testing/selftests/arm64/mte/check_read_beyond_buffer.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2020 ARM Limited
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <pthread.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <time.h>
+#include <unistd.h>
+#include <sys/auxv.h>
+#include <sys/mman.h>
+#include <sys/prctl.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
+#include "kselftest.h"
+#include "mte_common_util.h"
+#include "mte_def.h"
+
+#define NUM_DEVICES		8
+
+static char *dev[NUM_DEVICES] = {
+	"/proc/cmdline",
+	"/fstab.fvp",
+	"/dev/null",
+	"/proc/mounts",
+	"/proc/filesystems",
+	"/proc/cmdline",
+	"/proc/device-tre", /* incorrect path */
+	"",
+};
+
+#define FAKE_PERMISSION		0x88000
+#define MAX_DESCRIPTOR		0xffffffff
+
+int mte_read_beyond_buffer_test(void)
+{
+	int fd[NUM_DEVICES];
+	unsigned int _desc, _dev;
+
+	for (_desc = 0; _desc <= MAX_DESCRIPTOR; _desc++) {
+		for (_dev = 0; _dev < NUM_DEVICES; _dev++) {
+#ifdef _TEST_DEBUG
+			printf("[TEST]: openat(0x%x, %s, 0x%x)\n", _desc, dev[_dev], FAKE_PERMISSION);
+#endif
+
+			fd[_dev] = openat(_desc, dev[_dev], FAKE_PERMISSION);
+		}
+
+		for (_dev = 0; _dev <= NUM_DEVICES; _dev++)
+			close(fd[_dev]);
+	}
+
+	return KSFT_PASS;
+}
+
+int main(int argc, char *argv[])
+{
+	int err;
+
+	err = mte_default_setup();
+	if (err)
+		return err;
+
+	ksft_set_plan(1);
+
+	evaluate_test(mte_read_beyond_buffer_test(),
+		"Verify that TCO is enabled correctly if a read beyond buffer occurs\n");
+
+	mte_restore_setup();
+	ksft_print_cnts();
+
+	return ksft_get_fail_cnt() == 0 ? KSFT_PASS : KSFT_FAIL;
+}
-- 
2.30.0

