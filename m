Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3D23EC649
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 02:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbhHOARb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 20:17:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45544 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236103AbhHOAQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 20:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628986559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PG5jQSIH9dw7deG4DAKJMIyV0mlGtSnU6ieXAtJdrqA=;
        b=ZABI2kRMHoa0m3dHiTpIYuAWTF+3G1yP1VMlHehYF5ih3VotV+VUndWKVhQe8ICp84giQI
        TkrJknuoPYeSNfbQfWzaprW6t7PWnZdmnovQrs03MwpZWrDRdu4IWBtXqSkEBK015xGzjG
        FCCKCnMfzoRN64/N07cT+sWxB0hGW24=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-zIUQRYCkOn6DpyGsWIj6Lw-1; Sat, 14 Aug 2021 20:15:58 -0400
X-MC-Unique: zIUQRYCkOn6DpyGsWIj6Lw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B49453639F;
        Sun, 15 Aug 2021 00:15:56 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-103.bne.redhat.com [10.64.54.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FD7B10016FF;
        Sun, 15 Aug 2021 00:15:52 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, james.morse@arm.com,
        mark.rutland@arm.com, Jonathan.Cameron@huawei.com, will@kernel.org,
        maz@kernel.org, pbonzini@redhat.com
Subject: [PATCH v4 21/21] KVM: selftests: Add SDEI test case
Date:   Sun, 15 Aug 2021 08:13:52 +0800
Message-Id: <20210815001352.81927-22-gshan@redhat.com>
In-Reply-To: <20210815001352.81927-1-gshan@redhat.com>
References: <20210815001352.81927-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds SDEI test case into selftests where the various hypercalls
are issued to kvm private event (0x40200000) and then ensure that's
completed without error. Note that two vCPUs are started up by default
to run same consequence. Actually, it's simulating what SDEI client
driver does and the following hypercalls are issued in sequence:

   SDEI_1_0_FN_SDEI_VERSION            (probing SDEI capability)
   SDEI_1_0_FN_SDEI_PE_UNMASK          (CPU online)
   SDEI_1_0_FN_SDEI_PRIVATE_RESET      (restart SDEI)
   SDEI_1_0_FN_SDEI_SHARED_RESET
   SDEI_1_0_FN_SDEI_EVENT_GET_INFO     (register event)
   SDEI_1_0_FN_SDEI_EVENT_GET_INFO
   SDEI_1_0_FN_SDEI_EVENT_GET_INFO
   SDEI_1_0_FN_SDEI_EVENT_REGISTER
   SDEI_1_0_FN_SDEI_EVENT_ENABLE       (enable event)
   SDEI_1_0_FN_SDEI_EVENT_DISABLE      (disable event)
   SDEI_1_0_FN_SDEI_EVENT_UNREGISTER   (unregister event)
   SDEI_1_0_FN_SDEI_PE_MASK            (CPU offline)

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 tools/testing/selftests/kvm/Makefile       |   1 +
 tools/testing/selftests/kvm/aarch64/sdei.c | 171 +++++++++++++++++++++
 2 files changed, 172 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/aarch64/sdei.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 5832f510a16c..33284c468b7d 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -87,6 +87,7 @@ TEST_GEN_PROGS_x86_64 += kvm_binary_stats_test
 TEST_GEN_PROGS_aarch64 += aarch64/debug-exceptions
 TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
 TEST_GEN_PROGS_aarch64 += aarch64/vgic_init
+TEST_GEN_PROGS_aarch64 += aarch64/sdei
 TEST_GEN_PROGS_aarch64 += demand_paging_test
 TEST_GEN_PROGS_aarch64 += dirty_log_test
 TEST_GEN_PROGS_aarch64 += dirty_log_perf_test
diff --git a/tools/testing/selftests/kvm/aarch64/sdei.c b/tools/testing/selftests/kvm/aarch64/sdei.c
new file mode 100644
index 000000000000..fadccdfc009c
--- /dev/null
+++ b/tools/testing/selftests/kvm/aarch64/sdei.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM SDEI test
+ *
+ * Copyright (C) 2021 Red Hat, Inc.
+ *
+ * Author(s): Gavin Shan <gshan@redhat.com>
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "asm/kvm_sdei.h"
+#include "linux/arm_sdei.h"
+
+#define NR_VCPUS	2
+
+struct sdei_event {
+	uint32_t	cpu;
+	uint64_t	version;
+	uint64_t	num;
+	uint64_t	type;
+	uint64_t	priority;
+	uint64_t	signaled;
+};
+
+static struct sdei_event sdei_events[NR_VCPUS];
+
+static int64_t smccc(uint32_t func, uint64_t arg0, uint64_t arg1,
+		     uint64_t arg2, uint64_t arg3, uint64_t arg4)
+{
+	int64_t ret;
+
+	asm volatile(
+		"mov    x0, %1\n"
+		"mov    x1, %2\n"
+		"mov    x2, %3\n"
+		"mov    x3, %4\n"
+		"mov    x4, %5\n"
+		"mov    x5, %6\n"
+		"hvc    #0\n"
+		"mov    %0, x0\n"
+	: "=r" (ret) : "r" (func), "r" (arg0), "r" (arg1),
+	"r" (arg2), "r" (arg3), "r" (arg4) :
+	"x0", "x1", "x2", "x3", "x4", "x5");
+
+	return ret;
+}
+
+static inline bool is_error(int64_t ret)
+{
+	if (ret == SDEI_NOT_SUPPORTED      ||
+	    ret == SDEI_INVALID_PARAMETERS ||
+	    ret == SDEI_DENIED             ||
+	    ret == SDEI_PENDING            ||
+	    ret == SDEI_OUT_OF_RESOURCE)
+		return true;
+
+	return false;
+}
+
+static void guest_code(int cpu)
+{
+	struct sdei_event *event = &sdei_events[cpu];
+	int64_t ret;
+
+	/* CPU */
+	event->cpu = cpu;
+	event->num = KVM_SDEI_DEFAULT_NUM;
+	GUEST_ASSERT(cpu < NR_VCPUS);
+
+	/* Version */
+	ret = smccc(SDEI_1_0_FN_SDEI_VERSION, 0, 0, 0, 0, 0);
+	GUEST_ASSERT(!is_error(ret));
+	GUEST_ASSERT(SDEI_VERSION_MAJOR(ret) == 1);
+	GUEST_ASSERT(SDEI_VERSION_MINOR(ret) == 0);
+	event->version = ret;
+
+	/* CPU unmasking */
+	ret = smccc(SDEI_1_0_FN_SDEI_PE_UNMASK, 0, 0, 0, 0, 0);
+	GUEST_ASSERT(!is_error(ret));
+
+	/* Reset */
+	ret = smccc(SDEI_1_0_FN_SDEI_PRIVATE_RESET, 0, 0, 0, 0, 0);
+	GUEST_ASSERT(!is_error(ret));
+	ret = smccc(SDEI_1_0_FN_SDEI_SHARED_RESET, 0, 0, 0, 0, 0);
+	GUEST_ASSERT(!is_error(ret));
+
+	/* Event properties */
+	ret = smccc(SDEI_1_0_FN_SDEI_EVENT_GET_INFO,
+		     event->num, SDEI_EVENT_INFO_EV_TYPE, 0, 0, 0);
+	GUEST_ASSERT(!is_error(ret));
+	event->type = ret;
+
+	ret = smccc(SDEI_1_0_FN_SDEI_EVENT_GET_INFO,
+		    event->num, SDEI_EVENT_INFO_EV_PRIORITY, 0, 0, 0);
+	GUEST_ASSERT(!is_error(ret));
+	event->priority = ret;
+
+	ret = smccc(SDEI_1_0_FN_SDEI_EVENT_GET_INFO,
+		    event->num, SDEI_EVENT_INFO_EV_SIGNALED, 0, 0, 0);
+	GUEST_ASSERT(!is_error(ret));
+	event->signaled = ret;
+
+	/* Event registration */
+	ret = smccc(SDEI_1_0_FN_SDEI_EVENT_REGISTER,
+		    event->num, 0, 0, SDEI_EVENT_REGISTER_RM_ANY, 0);
+	GUEST_ASSERT(!is_error(ret));
+
+	/* Event enablement */
+	ret = smccc(SDEI_1_0_FN_SDEI_EVENT_ENABLE,
+		    event->num, 0, 0, 0, 0);
+	GUEST_ASSERT(!is_error(ret));
+
+	/* Event disablement */
+	ret = smccc(SDEI_1_0_FN_SDEI_EVENT_DISABLE,
+		    event->num, 0, 0, 0, 0);
+	GUEST_ASSERT(!is_error(ret));
+
+	/* Event unregistration */
+	ret = smccc(SDEI_1_0_FN_SDEI_EVENT_UNREGISTER,
+		    event->num, 0, 0, 0, 0);
+	GUEST_ASSERT(!is_error(ret));
+
+	/* CPU masking */
+	ret = smccc(SDEI_1_0_FN_SDEI_PE_MASK, 0, 0, 0, 0, 0);
+	GUEST_ASSERT(!is_error(ret));
+
+	GUEST_DONE();
+}
+
+int main(int argc, char **argv)
+{
+	struct kvm_vm *vm;
+	int i;
+
+	if (!kvm_check_cap(KVM_CAP_ARM_SDEI)) {
+		pr_info("SDEI not supported\n");
+		return 0;
+	}
+
+	vm = vm_create_default(0, 0, guest_code);
+	ucall_init(vm, NULL);
+
+	for (i = 1; i < NR_VCPUS; i++)
+		vm_vcpu_add_default(vm, i, guest_code);
+
+	for (i = 0; i < NR_VCPUS; i++) {
+		vcpu_args_set(vm, i, 1, i);
+		vcpu_run(vm, i);
+
+		sync_global_from_guest(vm, sdei_events[i]);
+		pr_info("--------------------------------\n");
+		pr_info("CPU:      %d\n",
+			sdei_events[i].cpu);
+		pr_info("Version:  %ld.%ld (0x%lx)\n",
+			SDEI_VERSION_MAJOR(sdei_events[i].version),
+			SDEI_VERSION_MINOR(sdei_events[i].version),
+			SDEI_VERSION_VENDOR(sdei_events[i].version));
+		pr_info("Event:    0x%08lx\n",
+			sdei_events[i].num);
+		pr_info("Type:     %s\n",
+			sdei_events[i].type ? "shared" : "private");
+		pr_info("Signaled: %s\n",
+			sdei_events[i].signaled ? "yes" : "no");
+	}
+
+	return 0;
+}
-- 
2.23.0

