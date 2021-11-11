Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF71644CFCB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 03:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbhKKCMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 21:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbhKKCL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 21:11:56 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D818C0432CC
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 18:08:07 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id x6-20020a17090a6c0600b001a724a5696cso2077783pjj.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 18:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=4wLzPjAo6SC+6dg2XS8LE13lS3wGpQbHkLiaUdVh1zk=;
        b=MuegJeAyDDNZ2tSTgnRGgC7IKnaetIrZypWHgoI7HXfYfypgKJOXeWWLy35dN1C9Kq
         TYdkeXtBhBOimwcZ3top4kHa71CLV6qdvRNUhm81hZ5K3i6YVl/7AXor+8dNYxvAPJer
         ZwGoTfRUt1iBgIiACbYvtCaYyKTtXhPXR+X+RVc6NhZKJJXGXYjtiG/SPUOKx15Mns+w
         h7LMujRE3QFVnTWofLpidFxhxt+qp0BXQN3PgH1ZjZAnDhIuNVlz9u1BvqFo2bLBUTc6
         Fb2NGscm3LpQizlsfcqGjFJsDCfeEgXwB7noSeS86XmgLfWQWeulkCp9qWhLyPOP5PC4
         rOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=4wLzPjAo6SC+6dg2XS8LE13lS3wGpQbHkLiaUdVh1zk=;
        b=08aiukbEFBRFq/QgedPb3uroDMSm450pR4kFOXCFNfu7N6H+aNZg3rxeEHfATsZg2c
         +8tb7p0vAu+pj0q0fn93QjyrKzuOcJLPskVP9dsEOmgrIq9H7dFW1ZH8cl0Qe1FgOQeC
         Sk84MBmoaVdd8+fR/h6f+ZmjGRwZN5HXyr0aTb1t1tgUhZQ3wyU5inFLovG4zsKk1EmJ
         BptMSisNG7c2IosrMxB+CmVIWBZZIeBb1yhbPmPxo0qpLHgmk2SlHTB07DdV1NBZDRv5
         DXjQysHbd9td/hXRFrFVFRNJsf/KG6Gi+qr0xwFUBocJrmNO3pSqILwMIryjbqIca0Aa
         1xyA==
X-Gm-Message-State: AOAM533gJGrMUtt9LWCwTfqUCihWDu8LaDWwIwKLIhsL36O+XpPlUKOq
        j/kfqwUfsG787I7rt8mnqdnE2iSQfgg=
X-Google-Smtp-Source: ABdhPJzOf3D2n0+h+qFn/cUAHxeQwCrLXPititoZgPJ6cdaqRRoa4xxgHhA3Yjjnbd9PcZR94r6p632KxHo=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a62:16c7:0:b0:49f:a6cc:c77d with SMTP id
 190-20020a6216c7000000b0049fa6ccc77dmr3410123pfw.23.1636596486947; Wed, 10
 Nov 2021 18:08:06 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 11 Nov 2021 02:07:37 +0000
In-Reply-To: <20211111020738.2512932-1-seanjc@google.com>
Message-Id: <20211111020738.2512932-17-seanjc@google.com>
Mime-Version: 1.0
References: <20211111020738.2512932-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v4 16/17] KVM: arm64: Drop perf.c and fold its tiny bits of
 code into arm.c
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guo Ren <guoren@kernel.org>, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        Artem Kashkanov <artem.kashkanov@intel.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Like Xu <like.xu@linux.intel.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call KVM's (un)register perf callbacks helpers directly from arm.c and
delete perf.c

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/include/asm/kvm_host.h |  3 ---
 arch/arm64/kvm/Makefile           |  2 +-
 arch/arm64/kvm/arm.c              |  5 +++--
 arch/arm64/kvm/perf.c             | 22 ----------------------
 4 files changed, 4 insertions(+), 28 deletions(-)
 delete mode 100644 arch/arm64/kvm/perf.c

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 72e2afe6e8e3..824040b174ab 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -675,9 +675,6 @@ unsigned long kvm_mmio_read_buf(const void *buf, unsigned int len);
 int kvm_handle_mmio_return(struct kvm_vcpu *vcpu);
 int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa);
 
-void kvm_perf_init(void);
-void kvm_perf_teardown(void);
-
 /*
  * Returns true if a Performance Monitoring Interrupt (PMI), a.k.a. perf event,
  * arrived in guest context.  For arm64, any event that arrives while a vCPU is
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 989bb5dad2c8..0bcc378b7961 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_KVM) += hyp/
 
 kvm-y := $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o \
 	 $(KVM)/vfio.o $(KVM)/irqchip.o $(KVM)/binary_stats.o \
-	 arm.o mmu.o mmio.o psci.o perf.o hypercalls.o pvtime.o \
+	 arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
 	 inject_fault.o va_layout.o handle_exit.o \
 	 guest.o debug.o reset.o sys_regs.o \
 	 vgic-sys-reg-v3.o fpsimd.o pmu.o \
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 93c952375f3b..8d18a64a72f1 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1776,7 +1776,8 @@ static int init_subsystems(void)
 	if (err)
 		goto out;
 
-	kvm_perf_init();
+	kvm_register_perf_callbacks(NULL);
+
 	kvm_sys_reg_table_init();
 
 out:
@@ -2164,7 +2165,7 @@ int kvm_arch_init(void *opaque)
 /* NOP: Compiling as a module not supported */
 void kvm_arch_exit(void)
 {
-	kvm_perf_teardown();
+	kvm_unregister_perf_callbacks();
 }
 
 static int __init early_kvm_mode_cfg(char *arg)
diff --git a/arch/arm64/kvm/perf.c b/arch/arm64/kvm/perf.c
deleted file mode 100644
index 52cfab253c65..000000000000
--- a/arch/arm64/kvm/perf.c
+++ /dev/null
@@ -1,22 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Based on the x86 implementation.
- *
- * Copyright (C) 2012 ARM Ltd.
- * Author: Marc Zyngier <marc.zyngier@arm.com>
- */
-
-#include <linux/perf_event.h>
-#include <linux/kvm_host.h>
-
-#include <asm/kvm_emulate.h>
-
-void kvm_perf_init(void)
-{
-	kvm_register_perf_callbacks(NULL);
-}
-
-void kvm_perf_teardown(void)
-{
-	kvm_unregister_perf_callbacks();
-}
-- 
2.34.0.rc0.344.g81b53c2807-goog

