Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42AD3676A0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 02:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344004AbhDVA5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 20:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244336AbhDVA5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 20:57:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1552C06138C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 17:56:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n129-20020a2527870000b02904ed02e1aab5so6266701ybn.21
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 17:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=d4FQCYHivptxQk4kA1SJ6N+YreUjXRXnuN7O1SBVzug=;
        b=Wsya/lSsSo7Yxan02JvA7mnccp0K4Zos4f7NT3FGyZtavc9Lz7YzkTnd6tcQO5Xq7I
         hVhG5nXfQYXITIito2k8elrNnGPq1GbeXs3l5X9YyKSkcVyxbtYvOOiNp+y4PmSBDWQh
         9b30cM8ZSuLnN+5roW/z9Gkf6xeYmhPAAVVohmUEIboUgHPAi4kyhTlkItHaX4lfoZRA
         q8lEOVaQiy+EUWwVNU9y/lPXKGRh8a/NJlacyw6E5pNQZ1I95tH9dHE/ao+toVsNKrYp
         Aam2Qx38ZXdapQcVUTSxNvTLVRvVixxejj1fx0bOS7YjhiAloSdeclW9JtFGU6ogN04t
         c6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=d4FQCYHivptxQk4kA1SJ6N+YreUjXRXnuN7O1SBVzug=;
        b=IBfXEDrHUg3+sDl7t1GG2mlYZA+bk3T+xdNYPEBIuP4n94AbxNayGMw4SKX5ciq0Hl
         WeqriafpuS1MJ4V6yIQlS8plj78bzjEJoigw9lZEIwHb667fO2UdE0aTlZc2FlWDmV9l
         eprgdKFqIvpQZplkrFCYLsBkOu07vu4ZPof1DyNlZz6NhuKMl7FqG3mt5GWs0MkMpjcG
         ongwKQINkqdti7zx+zIQOSMPkWHAYaQHo02w4nDQgwT+KhWSVEgKjPPmkhrh/o0UsuhO
         30yOURfTn77cZYXXK7xU7d9nkfba6FNWWg8J2k0rfqTl291w7Fp9PuRsWDuWBhShD/rT
         AOOA==
X-Gm-Message-State: AOAM532HbWHydCwb8vOMh9/XcSSTijrC7ZLBgwjO6hPT9YnzoDABU0UC
        5caJF8+JdjoTX5CLpkiGKr2pdsTuMi7AGg==
X-Google-Smtp-Source: ABdhPJzFrB6SBU8DgXRInxWJXederj8nDe1SUbPCu0j0My+G/hbNToOQzZmf2TTEtEoISvg6Trv+VVUXbtwh1w==
X-Received: from ricarkol2.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:62fe])
 (user=ricarkol job=sendgmr) by 2002:a25:42cd:: with SMTP id
 p196mr1082067yba.314.1619053018241; Wed, 21 Apr 2021 17:56:58 -0700 (PDT)
Date:   Wed, 21 Apr 2021 17:56:25 -0700
In-Reply-To: <20210422005626.564163-1-ricarkol@google.com>
Message-Id: <20210422005626.564163-5-ricarkol@google.com>
Mime-Version: 1.0
References: <20210422005626.564163-1-ricarkol@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 4/5] KVM: selftests: Introduce utilities for checking x86 features
From:   Ricardo Koller <ricarkol@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Ricardo Koller <ricarkol@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add utilities for checking CPU features using the same x86 features
format used in the kernel (defined in cpufeatures.h). This format embeds
the function, index, and register to use. By using this format and these
utilities, tests will not have to define their own feature macros and
will be able to use kvm_cpuid_has(FEATURE_XYZ) or
this_cpu_has(FEATURE_XYZ) without having to worry about what register or
index to use.

Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 .../selftests/kvm/include/x86_64/cpuid.h      | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/cpuid.h

diff --git a/tools/testing/selftests/kvm/include/x86_64/cpuid.h b/tools/testing/selftests/kvm/include/x86_64/cpuid.h
new file mode 100644
index 000000000000..4d8c67d528f4
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86_64/cpuid.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Adapted from /arch/x86/kvm/cpuid.h
+ */
+
+#ifndef SELFTEST_KVM_CPUID_FEATURE_H
+#define SELFTEST_KVM_CPUID_FEATURE_H
+
+#include <stdint.h>
+#include <asm/cpufeatures.h>
+#include <asm/kvm_para.h>
+#include "reverse_cpuid.h"
+
+static __always_inline u32 *kvm_cpuid_get_register(unsigned int x86_feature)
+{
+	struct kvm_cpuid_entry2 *entry;
+	const struct cpuid_reg cpuid = x86_feature_cpuid(x86_feature);
+
+	entry = kvm_get_supported_cpuid_index(cpuid.function, cpuid.index);
+	if (!entry)
+		return NULL;
+
+	return __cpuid_entry_get_reg(entry, cpuid.reg);
+}
+
+static __always_inline bool kvm_cpuid_has(unsigned int x86_feature)
+{
+	u32 *reg;
+
+	reg = kvm_cpuid_get_register(x86_feature);
+	if (!reg)
+		return false;
+
+	return *reg & __feature_bit(x86_feature);
+}
+
+static __always_inline bool kvm_pv_has(unsigned int kvm_feature)
+{
+	u32 reg;
+
+	reg = kvm_get_supported_cpuid_entry(KVM_CPUID_FEATURES)->eax;
+	return reg & __feature_bit(kvm_feature);
+}
+
+static __always_inline bool this_cpu_has(unsigned int x86_feature)
+{
+	struct kvm_cpuid_entry2 entry;
+	const struct cpuid_reg cpuid = x86_feature_cpuid(x86_feature);
+	u32 *reg;
+
+	entry.eax = cpuid.function;
+	entry.ecx = cpuid.index;
+	__asm__ __volatile__("cpuid"
+			     : "+a"(entry.eax), "=b"(entry.ebx),
+			       "+c"(entry.ecx), "=d"(entry.edx));
+
+	reg = __cpuid_entry_get_reg(&entry, cpuid.reg);
+	return *reg &  __feature_bit(x86_feature);
+}
+
+#endif /* SELFTEST_KVM_CPUID_FEATURE_H */
-- 
2.31.1.368.gbe11c130af-goog

