Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679C7426087
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 01:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242248AbhJGXhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 19:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241487AbhJGXgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 19:36:53 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F13C061764
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 16:34:59 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id on18-20020a17090b1d1200b001a04d94fd9fso1410104pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 16:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QCcnWTVJdJc/WAVPcR4BCLp4hc0ky0D9nmZjxgNJgVQ=;
        b=J5Xmgczz4lCb1dmoGGK6T6UZMU3ZtPCtrRXDQAc6dfW6LAwT8mz2PBkLySX1KSf/0g
         iQZqLnqge4KAsH/UvJmnm/n3CQOLLG6pAJ0Cx5rukprVcc6cwYVvpz1bOqENfeEaaruC
         X20RMPoyACae29WQ+cawAHGZUYS82Efud+HKLHfSPV7Fl3rX+lDN94Ld9EwLH5IRfDEq
         pk9ZtxsGNPChSqqouYSArHov4QBv8UxeeWA7gIvtLlb1k9ECUSkk30AR+dZfbUZyXc5z
         fkn0kyfE5037sVahR8CYLc/NjJuhH+AeLPd+7KRl0+Bg6KW4twZcZJQpKqPUoIIgeyjP
         JE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QCcnWTVJdJc/WAVPcR4BCLp4hc0ky0D9nmZjxgNJgVQ=;
        b=u3Yrw//8mE0XpWIIm115coXSDV75GJ90qVKZqLGu5E0TL9Im6Ot0GOjqJacAp2oDCP
         OklIK/IsH9zLvSNf0OvlpryEki1OZknIeRONQPO7s7B1W9QAoPwmQt+Eg/YNcaXunCXK
         aWmNgg1npYcjR9vmqySgp6sO7Z2vF4PVGEg1bdp12Leb/RfPtQXxs1BdpKo3E4ms7Onp
         QbpwthKg95FLH6GKqzBWwe12B5drK3ujaq8eFayJSq6SWVkaY+w2sDj3UPF89l1BkfgA
         zf9OxMz2D8zJhQCDyYjXhAIdvxdADEHqZhPdpwzhSLSgpnNGFlAgDBaUb+uXKiPoccqG
         hp9g==
X-Gm-Message-State: AOAM533UpM6t3UnoFH/l4Rc+3Z3kQXZscg8GcOPVrfOQquGOw8hQ082Q
        r61nAW/ihDhWwX2sH0w/eNyYm6Tz6kua
X-Google-Smtp-Source: ABdhPJyGGErVlG3DR0iUPDgUz2iB0THZPL0Jyz4yWpFGkWw4/28sh4UQq1A0wYRTefCNFOZlSuAEIlv+DBxt
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a17:902:a3c1:b0:13a:47a:1c5a with SMTP id
 q1-20020a170902a3c100b0013a047a1c5amr6510759plb.13.1633649698763; Thu, 07 Oct
 2021 16:34:58 -0700 (PDT)
Date:   Thu,  7 Oct 2021 23:34:29 +0000
In-Reply-To: <20211007233439.1826892-1-rananta@google.com>
Message-Id: <20211007233439.1826892-6-rananta@google.com>
Mime-Version: 1.0
References: <20211007233439.1826892-1-rananta@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v8 05/15] KVM: arm64: selftests: Add support for cpu_relax
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
2.33.0.882.g93a45727a2-goog

