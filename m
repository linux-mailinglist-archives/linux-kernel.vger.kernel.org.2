Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5240E3FBE52
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 23:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbhH3Vaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 17:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237171AbhH3Vav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 17:30:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05131C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 14:29:57 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q80-20020a25d953000000b0059a45a5f834so5322108ybg.22
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 14:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eseI6U2kIEOPcPM9gI60D1kTKt4tS6rDtvNewr+avNc=;
        b=MmMW75nm8ADhIR5Jqtb7fQrxZojVGL4afPxUHETMZp0x+XUHkC9dJahnFiwaododc1
         qfomOWEYoUE+nIQxwvK1O0PoBSYdkURP3acCkescAVtLtGw0kz39XwG4+F9u2MGYBb9o
         U/VK2FVuVOQkiX76FN8GFHNSJNdJBcfZYfwYDncG7QWGToV28xgfB0LNexYhqqCffle/
         x6ruHrOPbn+Kqxkugo5Y2WXhRp7VZQnIzJKsbxjiL4A8rYXVNDzId91/dRjL9uXa63Be
         kbSMBetKvmgBTzGcUXMqFStFU8vC+pzgYyDBTXAySWnIbLq+XlzO3KlQuL7meJ9op3D1
         hRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eseI6U2kIEOPcPM9gI60D1kTKt4tS6rDtvNewr+avNc=;
        b=e5nRwB2fjE+i4OVTbU15qmswF4TPVrxBVko89PJpHmbO/Q6qzLaWnED7b8wVfzI6JV
         LK/L5l8UTb3m/c0t/MKK52LqFjEhfGFn2OokfwvkNZAeiQoL9ty1Pc2EvDYNTgWXcDVw
         +auZkTJJFq+Qcv6uqUvGr8sE1+bY/8TSefrjhe5zir5lDGhdciOUx1SWl6FmEYhagCSw
         nvBNPfKcFIbviFyQ1p2zokxhQrUIQmc+X56LNoE9877BYE7bizf8E2gOEgr3hlIDUmAX
         U5KKJp/4ZmVkXyR6BuKHpUL/cjLFOsGw5XzBPe3mk8WuBoZomBUZFFujNC7yfCSyxQUU
         2ibQ==
X-Gm-Message-State: AOAM531TTvvyfz09fBewicHy9pgPDVgMxV4+nQrQb8O5X3yE9OusVn4u
        OYmqb8CaSl15F/feOatARBanyGcOaCQ=
X-Google-Smtp-Source: ABdhPJzvuuktNBCFR03BrOami6pTELVQOe2sTNas7uc7dB7b0aMAk3WhR1Kd8aq35NFzjmFeLnRAfeJ3gdo=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:204:e552:6d5e:b69d:968c])
 (user=pgonda job=sendgmr) by 2002:a25:c441:: with SMTP id u62mr12976101ybf.12.1630358996303;
 Mon, 30 Aug 2021 14:29:56 -0700 (PDT)
Date:   Mon, 30 Aug 2021 14:29:51 -0700
Message-Id: <20210830212951.3541589-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH 3/3 V6] selftest: KVM: Add intra host migration
From:   Peter Gonda <pgonda@google.com>
To:     kvm@vger.kernel.org
Cc:     Peter Gonda <pgonda@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Marc Orr <marcorr@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds testcases for intra host migration for SEV and SEV-ES. Also adds
locking test to confirm no deadlock exists.

---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/x86_64/sev_vm_tests.c       | 152 ++++++++++++++++++
 2 files changed, 153 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/sev_vm_tests.c

Signed-off-by: Peter Gonda <pgonda@google.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Cc: Marc Orr <marcorr@google.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 5832f510a16c..de6e64d5c9c4 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -71,6 +71,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/tsc_msrs_test
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_pmu_msrs_test
 TEST_GEN_PROGS_x86_64 += x86_64/xen_shinfo_test
 TEST_GEN_PROGS_x86_64 += x86_64/xen_vmcall_test
+TEST_GEN_PROGS_x86_64 += x86_64/sev_vm_tests
 TEST_GEN_PROGS_x86_64 += access_tracking_perf_test
 TEST_GEN_PROGS_x86_64 += demand_paging_test
 TEST_GEN_PROGS_x86_64 += dirty_log_test
diff --git a/tools/testing/selftests/kvm/x86_64/sev_vm_tests.c b/tools/testing/selftests/kvm/x86_64/sev_vm_tests.c
new file mode 100644
index 000000000000..50a770316628
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/sev_vm_tests.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/kvm.h>
+#include <linux/psp-sev.h>
+#include <stdio.h>
+#include <sys/ioctl.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <pthread.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "svm_util.h"
+#include "kvm_util.h"
+#include "kselftest.h"
+#include "../lib/kvm_util_internal.h"
+
+#define SEV_DEV_PATH "/dev/sev"
+
+/*
+ * Open SEV_DEV_PATH if available, otherwise exit the entire program.
+ *
+ * Input Args:
+ *   flags - The flags to pass when opening SEV_DEV_PATH.
+ *
+ * Return:
+ *   The opened file descriptor of /dev/sev.
+ */
+static int open_sev_dev_path_or_exit(int flags)
+{
+	static int fd;
+
+	if (fd != 0)
+		return fd;
+
+	fd = open(SEV_DEV_PATH, flags);
+	if (fd < 0) {
+		print_skip("%s not available, is SEV not enabled? (errno: %d)",
+			   SEV_DEV_PATH, errno);
+		exit(KSFT_SKIP);
+	}
+
+	return fd;
+}
+
+static void sev_ioctl(int fd, int cmd_id, void *data)
+{
+	struct kvm_sev_cmd cmd = { 0 };
+	int ret;
+
+	TEST_ASSERT(cmd_id < KVM_SEV_NR_MAX, "Unknown SEV CMD : %d\n", cmd_id);
+
+	cmd.id = cmd_id;
+	cmd.sev_fd = open_sev_dev_path_or_exit(0);
+	cmd.data = (uint64_t)data;
+	ret = ioctl(fd, KVM_MEMORY_ENCRYPT_OP, &cmd);
+	TEST_ASSERT((ret == 0 || cmd.error == SEV_RET_SUCCESS),
+		    "%d failed: return code: %d, errno: %d, fw error: %d",
+		    cmd_id, ret, errno, cmd.error);
+}
+
+static struct kvm_vm *sev_vm_create(bool es)
+{
+	struct kvm_vm *vm;
+	struct kvm_sev_launch_start start = { 0 };
+	int i;
+
+	vm = vm_create(VM_MODE_DEFAULT, 0, O_RDWR);
+	sev_ioctl(vm->fd, es ? KVM_SEV_ES_INIT : KVM_SEV_INIT, NULL);
+	for (i = 0; i < 3; ++i)
+		vm_vcpu_add(vm, i);
+	start.policy |= (es) << 2;
+	sev_ioctl(vm->fd, KVM_SEV_LAUNCH_START, &start);
+	if (es)
+		sev_ioctl(vm->fd, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL);
+	return vm;
+}
+
+static void test_sev_migrate_from(bool es)
+{
+	struct kvm_vm *vms[3];
+	struct kvm_enable_cap cap = { 0 };
+	int i;
+
+	for (i = 0; i < sizeof(vms) / sizeof(struct kvm_vm *); ++i)
+		vms[i] = sev_vm_create(es);
+
+	cap.cap = KVM_CAP_VM_MIGRATE_ENC_CONTEXT_FROM;
+	for (i = 0; i < sizeof(vms) / sizeof(struct kvm_vm *) - 1; ++i) {
+		cap.args[0] = vms[i]->fd;
+		vm_enable_cap(vms[i + 1], &cap);
+	}
+}
+
+#define LOCK_TESTING_THREADS 3
+
+struct locking_thread_input {
+	struct kvm_vm *vm;
+	int source_fds[LOCK_TESTING_THREADS];
+};
+
+static void *locking_test_thread(void *arg)
+{
+	struct kvm_enable_cap cap = { 0 };
+	int i, j;
+	struct locking_thread_input *input = (struct locking_test_thread *)arg;
+
+	cap.cap = KVM_CAP_VM_MIGRATE_ENC_CONTEXT_FROM;
+
+	for (i = 0; i < 1000; ++i) {
+		j = input->source_fds[i % LOCK_TESTING_THREADS];
+		cap.args[0] = input->source_fds[j];
+		/*
+		 * Call IOCTL directly without checking return code. We are
+		 * simply trying to confirm there is no deadlock from userspace
+		 * not check correctness of migration here.
+		 */
+		ioctl(input->vm->fd, KVM_ENABLE_CAP, &cap);
+	}
+}
+
+static void test_sev_migrate_locking(void)
+{
+	struct locking_thread_input input[LOCK_TESTING_THREADS];
+	pthread_t pt[LOCK_TESTING_THREADS];
+	int i;
+
+	for (i = 0; i < LOCK_TESTING_THREADS; ++i) {
+		input[i].vm = sev_vm_create(/* es= */ false);
+		input[0].source_fds[i] = input[i].vm->fd;
+	}
+	memcpy(input[1].source_fds, input[0].source_fds,
+	       sizeof(input[1].source_fds));
+	memcpy(input[2].source_fds, input[0].source_fds,
+	       sizeof(input[2].source_fds));
+
+	for (i = 0; i < LOCK_TESTING_THREADS; ++i)
+		pthread_create(&pt[i], NULL, locking_test_thread, &input[i]);
+
+	for (i = 0; i < LOCK_TESTING_THREADS; ++i)
+		pthread_join(pt[i], NULL);
+}
+
+int main(int argc, char *argv[])
+{
+	test_sev_migrate_from(/* es= */ false);
+	test_sev_migrate_from(/* es= */ true);
+	test_sev_migrate_locking();
+	return 0;
+}
-- 
2.33.0.259.gc128427fd7-goog

