Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E6F40A16C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 01:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350583AbhIMXNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 19:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349405AbhIMXL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 19:11:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D5EC0613E1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 16:10:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y134-20020a25dc8c000000b0059f0301df0fso14883924ybe.21
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 16:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VREX88yx9xWzleHW1ZEh6k892sL/xPpdGpps/n5mOO0=;
        b=iK83yniVjgitiMsPKE4heQ6oT5rN4oNwgLzQoyg5AZbIqAYzYHhPvLBF3Z3crr9r15
         9U+ZxVXK13YUTjJZJ4Yz5pii/pFm/7uIvC8pAu63Tn+8Vu0GIJwOSYuDaEpBkNcskqWf
         fs9FJCplOKxOdfrEDqL2+nU1gOritaqPDtimBWNEaypbZDTErBxFjkHWtO1D2rylDVfo
         3TOQq1XxOgSnD5Q6IfRthoDnW4h1H4/ngV0eT6/oJdj1/g1nKuOocfqESB9G6HVtqQWS
         2Nd3LR006dsHJuBkVl7PKAQ1+7BFeF7935GxPhrgHW9uyt/R8Pqt+Svp/fX8KXAPFU65
         /oBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VREX88yx9xWzleHW1ZEh6k892sL/xPpdGpps/n5mOO0=;
        b=DtSuSMSicvs83orhx+2Gt8upzNFlSWN1I8LeVljD1bkWOSVU32YnPGpBkc7wGsQnNz
         7tvqRPZRVtAQ+8uGyfpxnTFiwKvhg50dVArstBNee+oH1tm/iqTy+i0vXmpS6WY4vSZB
         xSHdeyUZW1g6+3YuL07LQQRaHRAMzH+Ikq+yPf+11QaWQjo5H+w8KOsX7jzOKjsFo4cL
         FyNNkoH9TyEReVOlT5nZSd81Lr7QeQ1B+5At/E5S9O/WgtItgK4UxU8g90ao5yUu+Fbc
         BQD4pOOh1EnZ+jeAi52vrX1EpjCjSwekrvD5QpnedjEIciqJLSbHAbB9knGGRLPlDbCR
         y8fQ==
X-Gm-Message-State: AOAM530i6uYo+4tPEV2murRAqD9ncO05R6j/tKOLFh+4v77l9ddnWo7I
        grdhTMCfTuHA+jXaItWvOYzBwnDymGXY
X-Google-Smtp-Source: ABdhPJwOabcG17jAMTLXvpXjFejZRIOwG/0IcuiiiLvmT7OSJIRiMZN1Y4+nazea7PBvNbx2r7WJPaFvDsgB
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a25:44d:: with SMTP id 74mr20148426ybe.54.1631574613117;
 Mon, 13 Sep 2021 16:10:13 -0700 (PDT)
Date:   Mon, 13 Sep 2021 23:09:46 +0000
In-Reply-To: <20210913230955.156323-1-rananta@google.com>
Message-Id: <20210913230955.156323-6-rananta@google.com>
Mime-Version: 1.0
References: <20210913230955.156323-1-rananta@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v6 05/14] KVM: arm64: selftests: Add support for cpu_relax
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

Implement the guest helper routine, cpu_relax(), to yield
the processor to other tasks.

The function was derived from
arch/arm64/include/asm/vdso/processor.h.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
Reviewed-by: Oliver Upton <oupton@google.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
 tools/testing/selftests/kvm/include/aarch64/processor.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
index 93797783abad..265054c24481 100644
--- a/tools/testing/selftests/kvm/include/aarch64/processor.h
+++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
@@ -122,6 +122,11 @@ void vm_install_exception_handler(struct kvm_vm *vm,
 void vm_install_sync_handler(struct kvm_vm *vm,
 		int vector, int ec, handler_fn handler);
 
+static inline void cpu_relax(void)
+{
+	asm volatile("yield" ::: "memory");
+}
+
 #define isb()		asm volatile("isb" : : : "memory")
 #define dsb(opt)	asm volatile("dsb " #opt : : : "memory")
 #define dmb(opt)	asm volatile("dmb " #opt : : : "memory")
-- 
2.33.0.309.g3052b89438-goog

