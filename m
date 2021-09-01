Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B033FE4B8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344805AbhIAVPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245467AbhIAVPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:15:35 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43B2C061760
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 14:14:37 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id mm23-20020a17090b359700b00185945eae0eso279288pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 14:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ped5Qc1MM58GGqP18bC+JKvQQkEpWjp7CacWspbiPtU=;
        b=RF+xTrhE1y86Km4Tb2P3P9x56sxf1fIXwOzrKjBM264X3P2jQzCHZAFGTfbfshgqxp
         I3ViPwQGHlQjxAgXUxwylm+7TJXn1t0vKlHBNeiWKYzy32FmgouYKSW1+zXACYXOmERd
         r1JAAHqU3TM8b+t9jnwQP7qDF27X9+iLHlb0cDiMAmb0Wv6zsY9lrfRDcfkC7z9IKFmJ
         Uc7FZRXODjWUGiyg8Nis9o3gpVnPnwn0kNKJwfzsPYJn6kCiBtbCuEpwLZQ4Djl/A/PM
         DwP067BHcP+WdQiUBG6ujxS/hVn3djeGiHvZAJqMiAbzGV9d3zi7VZkLieJlF4xW7BsM
         jeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ped5Qc1MM58GGqP18bC+JKvQQkEpWjp7CacWspbiPtU=;
        b=Dsdh8Ja5CDu1P6/H2bVo+rbAyEZOo08cHEP3Id7HtixgzoK3WbN6PlaVX2kfkbFalV
         q5FzMJeOORCc2crj+lMYV8UOAYoShABTF/Q81g26L/sg+9iy9RDdIZYHn3YSTES8TUs+
         nBceZHc9kirqVMhYX0KjRvd2sBeQalIj8EPHh+mD2aitV/34JzTdlkiMbxtcpNeidExa
         EcwlYznMsRTr1vzB/zjOinaunfTu8tNUuEuCubPsY3kwrA+VoJAqq27hCwYzIIk2iFyb
         Dy1YfT3i9iFHZIwmI78KivJf3chuPFZT8o/SKni2LOSKfkBmgu7F+F4czr4O/+g4TTeu
         q29w==
X-Gm-Message-State: AOAM5311snwIx5UouyClZLrfy/+gCTiy6+depzZSHJPsGBi0rpp9Vbit
        sdb90lwiac6cAiNrL3RCQZ3u8P1clDoW
X-Google-Smtp-Source: ABdhPJzrG1HjvKDU2BB/zBmu2XADs6gKwEPEuy+cbmfKmRvnNPWrGZDzEUEU4Y01W3RLEFRXnQKuk3qmFLfy
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a62:7d4a:0:b0:3ef:ea37:1422 with SMTP id
 y71-20020a627d4a000000b003efea371422mr1327446pfc.0.1630530877389; Wed, 01 Sep
 2021 14:14:37 -0700 (PDT)
Date:   Wed,  1 Sep 2021 21:14:07 +0000
In-Reply-To: <20210901211412.4171835-1-rananta@google.com>
Message-Id: <20210901211412.4171835-8-rananta@google.com>
Mime-Version: 1.0
References: <20210901211412.4171835-1-rananta@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v3 07/12] KVM: arm64: selftests: Add support to get the vcpuid
 from MPIDR_EL1
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
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

At times, such as when in the interrupt handler, the guest wants to
get the vCPU-id that it's running on. As a result, introduce
get_vcpuid() that parses the MPIDR_EL1 and returns the vcpuid to the
requested caller.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 .../selftests/kvm/include/aarch64/processor.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
index c35bb7b8e870..8b372cd427da 100644
--- a/tools/testing/selftests/kvm/include/aarch64/processor.h
+++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
@@ -251,4 +251,23 @@ static inline void local_irq_disable(void)
 	asm volatile("msr daifset, #3" : : : "memory");
 }
 
+#define MPIDR_LEVEL_BITS 8
+#define MPIDR_LEVEL_SHIFT(level) (MPIDR_LEVEL_BITS * level)
+#define MPIDR_LEVEL_MASK ((1 << MPIDR_LEVEL_BITS) - 1)
+#define MPIDR_AFFINITY_LEVEL(mpidr, level) \
+	((mpidr >> MPIDR_LEVEL_SHIFT(level)) & MPIDR_LEVEL_MASK)
+
+static inline uint32_t get_vcpuid(void)
+{
+	uint32_t vcpuid = 0;
+	uint64_t mpidr = read_sysreg(mpidr_el1);
+
+	/* KVM limits only 16 vCPUs at level 0 */
+	vcpuid = mpidr & 0x0f;
+	vcpuid |= MPIDR_AFFINITY_LEVEL(mpidr, 1) << 4;
+	vcpuid |= MPIDR_AFFINITY_LEVEL(mpidr, 2) << 12;
+
+	return vcpuid;
+}
+
 #endif /* SELFTEST_KVM_PROCESSOR_H */
-- 
2.33.0.153.gba50c8fa24-goog

