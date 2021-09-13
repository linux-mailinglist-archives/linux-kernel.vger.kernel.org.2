Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49499409E8C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 22:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348407AbhIMUwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 16:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348274AbhIMUwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 16:52:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B0FC0617A6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:50:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 131-20020a251489000000b0059bdeb10a84so14605574ybu.15
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mbMpAN2lv2roByjcJ1XCjyIBTh39m0LmJW+1uF53gtY=;
        b=mv7tVlL0x5ymedbd3bV0qRa66pOjcWrEdOCxPiWP5rfUUDAR8bBRTDsQMDgGuVpxNX
         iARP0TkUMcFkanQz1pV/oIcn0jCSvJKyegtLZdx1tdb1KNJLXqbtBOOHMG1wEQRf1y/S
         Y4dc86WCkMdhjYlZZSDDoxb4N4aS/y8nG6TM61lHhv8t32oC2WyknNEFNQBOD+naONiM
         HEqMhBjZudSz7qE9hI/u8Cp2iC2kTJEYkhu1zQKKbCQ2/w8HpHs/L5d9SUU9EWCNtSbE
         y8GAEIGwRer0taSiAfo5o4oZ8z5/UKWPilkQBuLlCcbwTFRJZ8RW01DbzeXWnkmSpO15
         m30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mbMpAN2lv2roByjcJ1XCjyIBTh39m0LmJW+1uF53gtY=;
        b=QIvCqo/R2N0hkNQ1pvlxYzoihHLejQb9i+QplelMap0dRrFTYIxlHz+TmvA3ovXfbj
         qlp8vTZfJSC8jxgwjdCGH4TvkL/4i738ErBzJsR8DNAYusS3avxMiDEwERAu0gGAthS7
         WCJxuHnzZGPypQtUQFfKXCK+OvdiFHsJKidAbCQ4dK5Q0LVCXpltDALOfzlCEvVp03XN
         HcRqAAQXzDcs6xFpGVjjiTK692d2bERZRqbM45N5JPWFzfF1oAGGCe2radUPsI1tg/t6
         MvOX26mHcBaK1DXyiq8fY/9P127aFkIVQ2Hl2vUBHTdhYbhsxqdqz1fjAvYg+ZR7za5y
         Rm1A==
X-Gm-Message-State: AOAM5323HDAvftX7F3T8xF1Gzfq7yZV3xTXzvdT2plKPn1IaHwNPcjAA
        rCyRicPAyDiifMbZQtG69ATutQXTRPR2
X-Google-Smtp-Source: ABdhPJwzD5Q8bOZXbjLn6iYJpwpK8B5N4zqpQRt8kTJnD0bds2ODLYXOkk+qCzeGTa8hDmEQGoYMX875eTEz
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a05:6902:724:: with SMTP id
 l4mr16519293ybt.433.1631566210348; Mon, 13 Sep 2021 13:50:10 -0700 (PDT)
Date:   Mon, 13 Sep 2021 20:49:28 +0000
In-Reply-To: <20210913204930.130715-1-rananta@google.com>
Message-Id: <20210913204930.130715-13-rananta@google.com>
Mime-Version: 1.0
References: <20210913204930.130715-1-rananta@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v5 12/14] KVM: arm64: selftests: Add host support for vGIC
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a simple library to perform vGIC-v3 setup
from a host point of view. This includes creating a
vGIC device, setting up distributor and redistributor
attributes, and mapping the guest physical addresses.

The definition of REDIST_REGION_ATTR_ADDR is taken from
aarch64/vgic_init test. Hence, replace the definition
by including vgic.h in the test file.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 tools/testing/selftests/kvm/Makefile          |  2 +-
 .../testing/selftests/kvm/aarch64/vgic_init.c |  3 +-
 .../selftests/kvm/include/aarch64/vgic.h      | 20 ++++++
 .../testing/selftests/kvm/lib/aarch64/vgic.c  | 70 +++++++++++++++++++
 4 files changed, 92 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/aarch64/vgic.h
 create mode 100644 tools/testing/selftests/kvm/lib/aarch64/vgic.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 5476a8ddef60..8342f65c1d96 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -35,7 +35,7 @@ endif
 
 LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/rbtree.c lib/sparsebit.c lib/test_util.c lib/guest_modes.c lib/perf_test_util.c
 LIBKVM_x86_64 = lib/x86_64/apic.c lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/svm.c lib/x86_64/ucall.c lib/x86_64/handlers.S
-LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c lib/aarch64/handlers.S lib/aarch64/spinlock.c lib/aarch64/gic.c lib/aarch64/gic_v3.c
+LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c lib/aarch64/handlers.S lib/aarch64/spinlock.c lib/aarch64/gic.c lib/aarch64/gic_v3.c lib/aarch64/vgic.c
 LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c lib/s390x/diag318_test_handler.c
 
 TEST_GEN_PROGS_x86_64 = x86_64/cr4_cpuid_sync_test
diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
index 623f31a14326..157fc24f39c5 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
@@ -13,11 +13,10 @@
 #include "test_util.h"
 #include "kvm_util.h"
 #include "processor.h"
+#include "vgic.h"
 
 #define NR_VCPUS		4
 
-#define REDIST_REGION_ATTR_ADDR(count, base, flags, index) (((uint64_t)(count) << 52) | \
-	((uint64_t)((base) >> 16) << 16) | ((uint64_t)(flags) << 12) | index)
 #define REG_OFFSET(vcpu, offset) (((uint64_t)vcpu << 32) | offset)
 
 #define GICR_TYPER 0x8
diff --git a/tools/testing/selftests/kvm/include/aarch64/vgic.h b/tools/testing/selftests/kvm/include/aarch64/vgic.h
new file mode 100644
index 000000000000..0ecfb253893c
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/aarch64/vgic.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * ARM Generic Interrupt Controller (GIC) host specific defines
+ */
+
+#ifndef SELFTEST_KVM_VGIC_H
+#define SELFTEST_KVM_VGIC_H
+
+#include <linux/kvm.h>
+
+#define REDIST_REGION_ATTR_ADDR(count, base, flags, index) \
+	(((uint64_t)(count) << 52) | \
+	((uint64_t)((base) >> 16) << 16) | \
+	((uint64_t)(flags) << 12) | \
+	index)
+
+int vgic_v3_setup(struct kvm_vm *vm, unsigned int nr_vcpus,
+		uint64_t gicd_base_gpa, uint64_t gicr_base_gpa);
+
+#endif /* SELFTEST_KVM_VGIC_H */
diff --git a/tools/testing/selftests/kvm/lib/aarch64/vgic.c b/tools/testing/selftests/kvm/lib/aarch64/vgic.c
new file mode 100644
index 000000000000..9880caa8c7db
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/aarch64/vgic.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM Generic Interrupt Controller (GIC) v3 host support
+ */
+
+#include <linux/kvm.h>
+#include <linux/sizes.h>
+#include <asm/kvm.h>
+
+#include "kvm_util.h"
+#include "../kvm_util_internal.h"
+#include "vgic.h"
+
+/*
+ * vGIC-v3 default host setup
+ *
+ * Input args:
+ *	vm - KVM VM
+ *	nr_vcpus - Number of vCPUs supported by this VM
+ *	gicd_base_gpa - Guest Physical Address of the Distributor region
+ *	gicr_base_gpa - Guest Physical Address of the Redistributor region
+ *
+ * Output args: None
+ *
+ * Return: GIC file-descriptor or negative error code upon failure
+ *
+ * The function creates a vGIC-v3 device and maps the distributor and
+ * redistributor regions of the guest. Since it depends on the number of
+ * vCPUs for the VM, it must be called after all the vCPUs have been created.
+ */
+int vgic_v3_setup(struct kvm_vm *vm, unsigned int nr_vcpus,
+		uint64_t gicd_base_gpa, uint64_t gicr_base_gpa)
+{
+	int gic_fd;
+	uint64_t redist_attr;
+	struct list_head *iter;
+	unsigned int nr_gic_pages, nr_vcpus_created = 0;
+
+	TEST_ASSERT(nr_vcpus, "Num of vCPUs cannot be empty\n");
+
+	/*
+	 * Make sure that the caller is infact calling this
+	 * function after all the vCPUs are added.
+	 */
+	list_for_each(iter, &vm->vcpus)
+		nr_vcpus_created++;
+	TEST_ASSERT(nr_vcpus == nr_vcpus_created,
+			"No. of vCPUs requested (%u) doesn't match with the ones created for the VM (%u)\n",
+			nr_vcpus, nr_vcpus_created);
+
+	/* Distributor setup */
+	gic_fd = kvm_create_device(vm, KVM_DEV_TYPE_ARM_VGIC_V3, false);
+	kvm_device_access(gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+			KVM_VGIC_V3_ADDR_TYPE_DIST, &gicd_base_gpa, true);
+	nr_gic_pages = vm_calc_num_guest_pages(vm->mode, KVM_VGIC_V3_DIST_SIZE);
+	virt_map(vm, gicd_base_gpa, gicd_base_gpa,  nr_gic_pages);
+
+	/* Redistributor setup */
+	redist_attr = REDIST_REGION_ATTR_ADDR(nr_vcpus, gicr_base_gpa, 0, 0);
+	kvm_device_access(gic_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
+			KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION, &redist_attr, true);
+	nr_gic_pages = vm_calc_num_guest_pages(vm->mode,
+						KVM_VGIC_V3_REDIST_SIZE * nr_vcpus);
+	virt_map(vm, gicr_base_gpa, gicr_base_gpa,  nr_gic_pages);
+
+	kvm_device_access(gic_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
+				KVM_DEV_ARM_VGIC_CTRL_INIT, NULL, true);
+
+	return gic_fd;
+}
-- 
2.33.0.309.g3052b89438-goog

