Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1AF456D2B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 11:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbhKSKYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 05:24:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59032 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233172AbhKSKYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 05:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637317307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mX5jcuznSuqa2Xcuiv4jYmRlfngakhSaRM4ITDtNgjs=;
        b=TOOuGwIm594LaVJWHWYVb3yhor7CWbv0EuApMXuLE7yp6/D4BAkeOB41S/03/kUuVq5LSL
        2mEltvPYM9p0401nPPbgARtMw1/NiALyVppv9M+faZc/QeJ3Yga1fnl0mV5btXW/UaGadF
        T0DCvm+9UCWBJMMbTwnpZSZkZRPatyU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-525-u67RsU1KMCeWjsFSAdou7A-1; Fri, 19 Nov 2021 05:21:45 -0500
X-MC-Unique: u67RsU1KMCeWjsFSAdou7A-1
Received: by mail-wm1-f70.google.com with SMTP id v10-20020a1cf70a000000b00318203a6bd1so4510814wmh.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 02:21:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mX5jcuznSuqa2Xcuiv4jYmRlfngakhSaRM4ITDtNgjs=;
        b=PfYq/eVTtr20PsQqm0wmV6A1LSWbBrXvDCwPN6eTwlq11wDXW05Mwf6bErBcc5FUFw
         Ibe4G+wAmJz9yge8ntbQVGgGX0an9CSpde/v2gmjkrcz6d8cxoS24WDJtHWeiY5EuGM2
         f7iPzhUVJhpM359YL4jvP6rlKTFN1SbO7PxDdt9riQHAdF/ZRh93mvkYUDXN52WTOBfz
         6BSCjOzNvOCS9q/TptlXFiJQMmOolo+BMR5L3PhmFnzvbJagqCELbA7SD8btq+aaAGqT
         cKRkP+62aOpQCxoK6JzUWJtcHmcyFsMz/famZTXk2k6ZXPgS08MmA6EmbJJXWPAbx992
         xoMA==
X-Gm-Message-State: AOAM531RK01uLWAh2iWWSLPbPhOYAVtgjCQopqQjRS++Js2ZHaLkx0cQ
        5yhSegvo6+fIZ/ePvzgmd4XfNQXIVQUdbTfo8MeK4TENnfvh3S1MFdhmp2f4QCi0PYrfKbVf/ek
        qygQZSGRHqzror6WL8c8GkNSD
X-Received: by 2002:a5d:4909:: with SMTP id x9mr5932212wrq.313.1637317304296;
        Fri, 19 Nov 2021 02:21:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxeQnWOxgbNOebQdl80w1DTmX2lRjG3ogVnSnid0ngmyFfrhWmSZI2Hfqqy5HB4Ucb0MKfToQ==
X-Received: by 2002:a5d:4909:: with SMTP id x9mr5932181wrq.313.1637317304102;
        Fri, 19 Nov 2021 02:21:44 -0800 (PST)
Received: from vian.redhat.com ([2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae])
        by smtp.gmail.com with ESMTPSA id k27sm14336026wms.41.2021.11.19.02.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 02:21:43 -0800 (PST)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        rostedt@goodmis.org
Cc:     james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        nsaenzju@redhat.com, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, mingo@redhat.com,
        mtosatti@redhat.com, nilal@redhat.com
Subject: [RFC PATCH 1/2] arm64/tracing: add cntvct based trace clock
Date:   Fri, 19 Nov 2021 11:21:17 +0100
Message-Id: <20211119102117.22304-2-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119102117.22304-1-nsaenzju@redhat.com>
References: <20211119102117.22304-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new arm64-specific trace clock using the cntvct register, similar
to x64-tsc. This gives us:
 - A clock that is relatively fast (1GHz on armv8.6, 1-50MHz otherwise),
   monotonic, and resilient to low power modes.
 - It can be used to correlate events across cpus as well as across
   hypervisor and guests.

By using arch_timer_read_counter() we make sure that armv8.6 cpus use
the less expensive CNTVCTSS_EL0, which cannot be accessed speculatively.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 arch/arm64/include/asm/trace_clock.h | 12 ++++++++++++
 arch/arm64/kernel/Makefile           |  2 +-
 arch/arm64/kernel/trace_clock.c      | 12 ++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/trace_clock.h
 create mode 100644 arch/arm64/kernel/trace_clock.c

diff --git a/arch/arm64/include/asm/trace_clock.h b/arch/arm64/include/asm/trace_clock.h
new file mode 100644
index 000000000000..ce4a66d63108
--- /dev/null
+++ b/arch/arm64/include/asm/trace_clock.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARM64_TRACE_CLOCK_H
+#define _ASM_ARM64_TRACE_CLOCK_H
+
+#include <linux/types.h>
+
+extern u64 notrace trace_clock_arm64_cntvct(void);
+
+# define ARCH_TRACE_CLOCKS \
+	{ trace_clock_arm64_cntvct, "cntvct", .in_ns = 0 },
+
+#endif  /* _ASM_ARM64_TRACE_CLOCK_H */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 88b3e2a21408..ec9180f0ac90 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -29,7 +29,7 @@ obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   cpufeature.o alternative.o cacheinfo.o		\
 			   smp.o smp_spin_table.o topology.o smccc-call.o	\
 			   syscall.o proton-pack.o idreg-override.o idle.o	\
-			   patching.o
+			   patching.o trace_clock.o
 
 targets			+= efi-entry.o
 
diff --git a/arch/arm64/kernel/trace_clock.c b/arch/arm64/kernel/trace_clock.c
new file mode 100644
index 000000000000..fe1315f368cb
--- /dev/null
+++ b/arch/arm64/kernel/trace_clock.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * arm64 trace clocks
+ */
+#include <asm/trace_clock.h>
+
+#include <clocksource/arm_arch_timer.h>
+
+u64 notrace trace_clock_arm64_cntvct(void)
+{
+	return arch_timer_read_counter();
+}
-- 
2.33.1

