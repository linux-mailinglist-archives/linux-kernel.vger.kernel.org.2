Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB4C42608C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 01:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242504AbhJGXhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 19:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239415AbhJGXg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 19:36:57 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F400C061764
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 16:35:03 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id s19-20020a63e813000000b00287d976d152so591463pgh.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 16:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9PSgeQegZjMs5aQbS9f355ca1mIB9gCuDVJX98/wgi4=;
        b=CUwm009NcsfB4wM2HwUbkEBpfaskzb1HDELJnrL5vLcniu64pkiWZOUAYCZ9j+U8bI
         EgotwZOdqbR28vF+Nv0332HFuIhlfS41yXvGgqyT2eDqfuLMsU3Dmq05PLYC6/Kwmo0G
         IbYP1Aev1mmhP77pUr3coXtrRpU4az6/J0qcizA1EeWvzPjDUmC+EZ1Q6OgsL1KNXyAe
         fVlMzQt39+yoHpu+RYwCqk5FjboaKRY9YlwwbD1TY3aCP7pHaAUzBR2XHA7B7o8v8RyL
         AUJO6D1xPiR0RCgM6VO43qrccSA7ZNSAkkbyXrm5ub7UDqS071f0tANipuPAaYI4w0yH
         CtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9PSgeQegZjMs5aQbS9f355ca1mIB9gCuDVJX98/wgi4=;
        b=lAavm4/JzDP0phj5/uWVo/aiS6udPn0a9Is2khnt02AJEmZadKOCUGx9aDqKbrmWdZ
         kddFnBGivBKeMJ6gb8jTq6y818miXye28U5TZzk1BBsTj00Hxx+v+2I9ecAnhNVaU+h+
         df2w9hYK3bInmexAtBHiO3eybjW6Krm2HWIZTnsF/D2iO9mk7t3Yd67MLiWrylDsZK4A
         4xZqQFaX9t9mB1LQ7rCV2mQjhfEpfoTVBrkoR8Ey8eWDyzC2MXVSE5F0x6mGhgJ61rmu
         lRj6cbMsoHZT4vwfGbfprg1ASmCtF4vBYNGFxYmvWCtqvlE/fVwiJq2SkXJ2Aao61noT
         30Vw==
X-Gm-Message-State: AOAM532qDKl874rTovl/tw/x8uxx9s51yduDK9sFScs8lcwx18RFITsO
        UoU3ztnT1ma9RI7o+Du/XaCzP24xR+tj
X-Google-Smtp-Source: ABdhPJxhkF+2VPtnNSdk96r8KkKJxaChFzDmys+zm7/iP86cpUiUQc6Wlzq48Ikt+T6nlvuKb1fEWVupdVGv
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a17:902:ee93:b0:13e:c846:c902 with SMTP id
 a19-20020a170902ee9300b0013ec846c902mr6617482pld.88.1633649702684; Thu, 07
 Oct 2021 16:35:02 -0700 (PDT)
Date:   Thu,  7 Oct 2021 23:34:30 +0000
In-Reply-To: <20211007233439.1826892-1-rananta@google.com>
Message-Id: <20211007233439.1826892-7-rananta@google.com>
Mime-Version: 1.0
References: <20211007233439.1826892-1-rananta@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v8 06/15] KVM: arm64: selftests: Add basic support for arch_timers
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

Add a minimalistic library support to access the virtual timers,
that can be used for simple timing functionalities, such as
introducing delays in the guest.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
 .../kvm/include/aarch64/arch_timer.h          | 142 ++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/aarch64/arch_timer.h

diff --git a/tools/testing/selftests/kvm/include/aarch64/arch_timer.h b/tools/testing/selftests/kvm/include/aarch64/arch_timer.h
new file mode 100644
index 000000000000..cb7c03de3a21
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/aarch64/arch_timer.h
@@ -0,0 +1,142 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * ARM Generic Timer specific interface
+ */
+
+#ifndef SELFTEST_KVM_ARCH_TIMER_H
+#define SELFTEST_KVM_ARCH_TIMER_H
+
+#include "processor.h"
+
+enum arch_timer {
+	VIRTUAL,
+	PHYSICAL,
+};
+
+#define CTL_ENABLE	(1 << 0)
+#define CTL_IMASK	(1 << 1)
+#define CTL_ISTATUS	(1 << 2)
+
+#define msec_to_cycles(msec)	\
+	(timer_get_cntfrq() * (uint64_t)(msec) / 1000)
+
+#define usec_to_cycles(usec)	\
+	(timer_get_cntfrq() * (uint64_t)(usec) / 1000000)
+
+#define cycles_to_usec(cycles) \
+	((uint64_t)(cycles) * 1000000 / timer_get_cntfrq())
+
+static inline uint32_t timer_get_cntfrq(void)
+{
+	return read_sysreg(cntfrq_el0);
+}
+
+static inline uint64_t timer_get_cntct(enum arch_timer timer)
+{
+	isb();
+
+	switch (timer) {
+	case VIRTUAL:
+		return read_sysreg(cntvct_el0);
+	case PHYSICAL:
+		return read_sysreg(cntpct_el0);
+	default:
+		GUEST_ASSERT_1(0, timer);
+	}
+
+	/* We should not reach here */
+	return 0;
+}
+
+static inline void timer_set_cval(enum arch_timer timer, uint64_t cval)
+{
+	switch (timer) {
+	case VIRTUAL:
+		write_sysreg(cval, cntv_cval_el0);
+		break;
+	case PHYSICAL:
+		write_sysreg(cval, cntp_cval_el0);
+		break;
+	default:
+		GUEST_ASSERT_1(0, timer);
+	}
+
+	isb();
+}
+
+static inline uint64_t timer_get_cval(enum arch_timer timer)
+{
+	switch (timer) {
+	case VIRTUAL:
+		return read_sysreg(cntv_cval_el0);
+	case PHYSICAL:
+		return read_sysreg(cntp_cval_el0);
+	default:
+		GUEST_ASSERT_1(0, timer);
+	}
+
+	/* We should not reach here */
+	return 0;
+}
+
+static inline void timer_set_tval(enum arch_timer timer, uint32_t tval)
+{
+	switch (timer) {
+	case VIRTUAL:
+		write_sysreg(tval, cntv_tval_el0);
+		break;
+	case PHYSICAL:
+		write_sysreg(tval, cntp_tval_el0);
+		break;
+	default:
+		GUEST_ASSERT_1(0, timer);
+	}
+
+	isb();
+}
+
+static inline void timer_set_ctl(enum arch_timer timer, uint32_t ctl)
+{
+	switch (timer) {
+	case VIRTUAL:
+		write_sysreg(ctl, cntv_ctl_el0);
+		break;
+	case PHYSICAL:
+		write_sysreg(ctl, cntp_ctl_el0);
+		break;
+	default:
+		GUEST_ASSERT_1(0, timer);
+	}
+
+	isb();
+}
+
+static inline uint32_t timer_get_ctl(enum arch_timer timer)
+{
+	switch (timer) {
+	case VIRTUAL:
+		return read_sysreg(cntv_ctl_el0);
+	case PHYSICAL:
+		return read_sysreg(cntp_ctl_el0);
+	default:
+		GUEST_ASSERT_1(0, timer);
+	}
+
+	/* We should not reach here */
+	return 0;
+}
+
+static inline void timer_set_next_cval_ms(enum arch_timer timer, uint32_t msec)
+{
+	uint64_t now_ct = timer_get_cntct(timer);
+	uint64_t next_ct = now_ct + msec_to_cycles(msec);
+
+	timer_set_cval(timer, next_ct);
+}
+
+static inline void timer_set_next_tval_ms(enum arch_timer timer, uint32_t msec)
+{
+	timer_set_tval(timer, msec_to_cycles(msec));
+}
+
+#endif /* SELFTEST_KVM_ARCH_TIMER_H */
-- 
2.33.0.882.g93a45727a2-goog

