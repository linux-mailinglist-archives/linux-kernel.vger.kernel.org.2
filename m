Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8D5456D2C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 11:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbhKSKYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 05:24:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58796 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234579AbhKSKYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 05:24:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637317308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ct7CtyToJccif4yM7473FLAuHcnDcJ5KfOy6FoPwk00=;
        b=SObBuehiBukzj5E6J+JhUSP9k0x0Duzx6a3qiFgQVcvkqYjKSPzrf4YX5eq2rUDgXnqZzE
        WPo0CePp2Zb0Pgtv9LO2Tz+Sb9YhFBScAkQGZJgIvsqwyinfl1QlioFSk1cyJf0Am6u38P
        tfyBo1jX6ILMM9lP04g9udNh3/qYeo8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-eMWYAQlpNPW-FQ_fH_t5nQ-1; Fri, 19 Nov 2021 05:21:47 -0500
X-MC-Unique: eMWYAQlpNPW-FQ_fH_t5nQ-1
Received: by mail-wm1-f71.google.com with SMTP id o18-20020a05600c511200b00332fa17a02eso4510670wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 02:21:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ct7CtyToJccif4yM7473FLAuHcnDcJ5KfOy6FoPwk00=;
        b=iQB+mjXFWsd4HA5hsEVRnWNr5oCU8cgiM4lwjNrjwMUaWFrc/kA3b42CJOjAkzViuR
         395TubsrJn8aN6vOL8Kzfvo9K+W6syv7EdrmoWK48KLonA10y5+jxUUlRWA92ya5dIMK
         iWE4m0jd7K5Hu/KPJpsO0UW28AdPSm9fx5BTVqSTFSHFqwGjE3s2b1/j6a/0FeUk+JOU
         Pt7wp2WQ/Qt1laUZqk8W6bLrDZva2mRTBVET2tsc/I3907EM7yhwKOjqMrFWN69lYtgs
         zOQpEqB0IU1ntuIuKnXA4RduIpKHFhqm+oM0A99kv1XIS7LlsONZyZRe9ZsINVeSTFoS
         5H9A==
X-Gm-Message-State: AOAM533wVBi8If5ZKx/muoYRW/aWtd8IzGG4Lwf/IsoUMmQ0G6cjK3N4
        SlFICVPkuRdthJW9SoG6Dasc5mHV1A+mwXDBsyT+JvCB5+NnP4wZfAGCGcEKFnzbXSPs4QeinKj
        QH4obEIezgvM9Nh3Am26rpvdS
X-Received: by 2002:a1c:6a0e:: with SMTP id f14mr5372823wmc.58.1637317305273;
        Fri, 19 Nov 2021 02:21:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIUdO9kJGSkL5mvaE1u7YqQr35Qw1TrQUV/WROHnbGRLAbqb5SG0+IyiEIxSlskLareoN6zA==
X-Received: by 2002:a1c:6a0e:: with SMTP id f14mr5372797wmc.58.1637317305056;
        Fri, 19 Nov 2021 02:21:45 -0800 (PST)
Received: from vian.redhat.com ([2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae])
        by smtp.gmail.com with ESMTPSA id k27sm14336026wms.41.2021.11.19.02.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 02:21:44 -0800 (PST)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        rostedt@goodmis.org
Cc:     james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        nsaenzju@redhat.com, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, mingo@redhat.com,
        mtosatti@redhat.com, nilal@redhat.com
Subject: [RFC PATCH 2/2] KVM: arm64: export cntvoff in debugfs
Date:   Fri, 19 Nov 2021 11:21:18 +0100
Message-Id: <20211119102117.22304-3-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119102117.22304-1-nsaenzju@redhat.com>
References: <20211119102117.22304-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While using cntvct as the raw clock for tracing, it's possible to
synchronize host/guest traces just by knowing the virtual offset applied
to the guest's virtual counter.

This is also the case on x86 when TSC is available. The offset is
exposed in debugfs as 'tsc-offset' on a per vcpu basis. So let's
implement the same for arm64.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/kvm/Makefile           |  2 +-
 arch/arm64/kvm/arch_timer.c       |  2 +-
 arch/arm64/kvm/debugfs.c          | 25 +++++++++++++++++++++++++
 include/kvm/arm_arch_timer.h      |  3 +++
 5 files changed, 31 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/kvm/debugfs.c

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 2a5f7f38006f..130534c9079e 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -29,6 +29,7 @@
 #include <asm/thread_info.h>
 
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
+#define __KVM_HAVE_ARCH_VCPU_DEBUGFS
 
 #define KVM_HALT_POLL_NS_DEFAULT 500000
 
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 989bb5dad2c8..17be7cf770f2 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -14,7 +14,7 @@ kvm-y := $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o \
 	 $(KVM)/vfio.o $(KVM)/irqchip.o $(KVM)/binary_stats.o \
 	 arm.o mmu.o mmio.o psci.o perf.o hypercalls.o pvtime.o \
 	 inject_fault.o va_layout.o handle_exit.o \
-	 guest.o debug.o reset.o sys_regs.o \
+	 guest.o debug.o debugfs.o reset.o sys_regs.o \
 	 vgic-sys-reg-v3.o fpsimd.o pmu.o \
 	 arch_timer.o trng.o\
 	 vgic/vgic.o vgic/vgic-init.o \
diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
index 3df67c127489..ee69387f7fb6 100644
--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -82,7 +82,7 @@ u64 timer_get_cval(struct arch_timer_context *ctxt)
 	}
 }
 
-static u64 timer_get_offset(struct arch_timer_context *ctxt)
+u64 timer_get_offset(struct arch_timer_context *ctxt)
 {
 	struct kvm_vcpu *vcpu = ctxt->vcpu;
 
diff --git a/arch/arm64/kvm/debugfs.c b/arch/arm64/kvm/debugfs.c
new file mode 100644
index 000000000000..f0f5083ea8d4
--- /dev/null
+++ b/arch/arm64/kvm/debugfs.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 Red Hat Inc.
+ */
+
+#include <linux/kvm_host.h>
+#include <linux/debugfs.h>
+
+#include <kvm/arm_arch_timer.h>
+
+static int vcpu_get_cntv_offset(void *data, u64 *val)
+{
+	struct kvm_vcpu *vcpu = (struct kvm_vcpu *)data;
+
+	*val = timer_get_offset(vcpu_vtimer(vcpu));
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(vcpu_cntvoff_fops, vcpu_get_cntv_offset, NULL, "%lld\n");
+
+void kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu, struct dentry *debugfs_dentry)
+{
+	debugfs_create_file("cntvoff", 0444, debugfs_dentry, vcpu, &vcpu_cntvoff_fops);
+}
diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
index 51c19381108c..de0cd9be825c 100644
--- a/include/kvm/arm_arch_timer.h
+++ b/include/kvm/arm_arch_timer.h
@@ -106,4 +106,7 @@ void kvm_arm_timer_write_sysreg(struct kvm_vcpu *vcpu,
 u32 timer_get_ctl(struct arch_timer_context *ctxt);
 u64 timer_get_cval(struct arch_timer_context *ctxt);
 
+/* Nedded for debugfs */
+u64 timer_get_offset(struct arch_timer_context *ctxt);
+
 #endif
-- 
2.33.1

