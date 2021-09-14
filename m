Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37C540BBA2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbhINWeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbhINWdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:33:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CDFC0613E0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 15:31:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l11-20020a056902072b00b005a776eefb28so969936ybt.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 15:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BW7fBGcKsdrR8mke56V7bzU7gD9WyqlXvKOO1bey3dM=;
        b=KKrMidevVqRU8tnCf4HU4OhnmV4gTubXrbIfa7ytYE6gg6NnqwIA73O/SeJOdKPaFS
         +aF6f8SR1NWh9ctn4JkR57SOSgLADPbjUTJXnTPMlWXteaQen7oI9433NcrMbrU9+6Vx
         IfOmq44ELPlXjNG5vZ8UGDbY8XrQNygpDmddOehD8XpaTdhS5CBvPXhFs97WUdE3mdlx
         +rlcewue0YSfqo1HwOKvI4mzWUA4vf5jcotMRA3l3ydvvLj8mozJhget75ThKDippFOI
         QQYqdf3SRHPJwf8tlda7NBau1BdAqms2EsS0QX+etXuBOJJaFOw6OK7Ykj4paUtyEafI
         le9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BW7fBGcKsdrR8mke56V7bzU7gD9WyqlXvKOO1bey3dM=;
        b=0Pby/laDSzR1V/ttT/sjSrv9Fz7Jh9QZz+Xyg1tt0tYl8lSmKC9Cc6Zf2sZiD+aosW
         QrGaMbm1mFbV+I5812gm5tUhDnu5f9INVVbKUx23r2RDbrycboXhRa1J4rVkrPaXe4Wh
         oEcgYSyKq4wdorlObxkbYNKUQalXSUFlInhiiele8pGVhvuAcOrVlzU66qs4CYuxE1Tx
         4BWZafVLHangqGAAcmNy/HhaiC7KCsot/BZUSkFxZFZ8oGdt+WNbI0E7Ba50ATZULuYV
         dD77DpXmRE+jlc8NnH/9us1BWixLQIvG/7zu8vyDmUjFSFo+LkFPP9BQSChfGrLpJfav
         yFXQ==
X-Gm-Message-State: AOAM533nztJLzeNVJh1XRds5JnzsqAb8psVDTyFBp1iPDnd4kjDFm3JJ
        XioyHmzyNsMOIXqbM1FUFjGd1q+OV3Gp
X-Google-Smtp-Source: ABdhPJzPcqUzTM5tBKbzTFIOabctvphrNK79S1QDbS3uHmuEww5wKnVoFnhwbSzNggFM60aX3Wsu6DKNYmnL
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a25:5607:: with SMTP id
 k7mr2077562ybb.378.1631658704625; Tue, 14 Sep 2021 15:31:44 -0700 (PDT)
Date:   Tue, 14 Sep 2021 22:31:09 +0000
In-Reply-To: <20210914223114.435273-1-rananta@google.com>
Message-Id: <20210914223114.435273-11-rananta@google.com>
Mime-Version: 1.0
References: <20210914223114.435273-1-rananta@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v7 10/15] KVM: arm64: selftests: Add guest support to get the vcpuid
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

At times, such as when in the interrupt handler, the guest wants
to get the vcpuid that it's running on to pull the per-cpu private
data. As a result, introduce guest_get_vcpuid() that returns the
vcpuid of the calling vcpu. The interface is architecture
independent, but defined only for arm64 as of now.

Suggested-by: Reiji Watanabe <reijiw@google.com>
Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
Reviewed-by: Ricardo Koller <ricarkol@google.com>
Reviewed-by: Reiji Watanabe <reijiw@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h      | 2 ++
 tools/testing/selftests/kvm/lib/aarch64/processor.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 010b59b13917..bcf05f5381ed 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -400,4 +400,6 @@ uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc);
 int vm_get_stats_fd(struct kvm_vm *vm);
 int vcpu_get_stats_fd(struct kvm_vm *vm, uint32_t vcpuid);
 
+uint32_t guest_get_vcpuid(void);
+
 #endif /* SELFTEST_KVM_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
index 34f6bd47661f..b4eeeafd2a70 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
@@ -277,6 +277,7 @@ void aarch64_vcpu_setup(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_vcpu_init
 	set_reg(vm, vcpuid, KVM_ARM64_SYS_REG(SYS_TCR_EL1), tcr_el1);
 	set_reg(vm, vcpuid, KVM_ARM64_SYS_REG(SYS_MAIR_EL1), DEFAULT_MAIR_EL1);
 	set_reg(vm, vcpuid, KVM_ARM64_SYS_REG(SYS_TTBR0_EL1), vm->pgd);
+	set_reg(vm, vcpuid, KVM_ARM64_SYS_REG(SYS_TPIDR_EL1), vcpuid);
 }
 
 void vcpu_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid, uint8_t indent)
@@ -426,3 +427,8 @@ void vm_install_exception_handler(struct kvm_vm *vm, int vector,
 	assert(vector < VECTOR_NUM);
 	handlers->exception_handlers[vector][0] = handler;
 }
+
+uint32_t guest_get_vcpuid(void)
+{
+	return read_sysreg(tpidr_el1);
+}
-- 
2.33.0.309.g3052b89438-goog

