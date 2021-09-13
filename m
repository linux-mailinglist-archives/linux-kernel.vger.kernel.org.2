Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E877640A15F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 01:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349316AbhIMXMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 19:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349329AbhIMXL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 19:11:56 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203B0C0613E8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 16:10:20 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id x19-20020a05620a099300b003f64d79cbbaso43892167qkx.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 16:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HPlM28T/oJ4/6Xh6FGi+9sK76pxmz7U2+VXMGXF95EA=;
        b=DNkbp/sqJ7JxIvPqWv1ccqgt18UNr/1F5XiXnLeubqboraLkX5zaOi5Y9u+dmJkNxD
         5Jx8B7jRUF8KPPuuLbDtxtU3wcNdxfelulEqIFT9UGvhK/RcZ0SmaE6MhFDsTdh432bu
         1rmsvCUZ07vzLQpkhiW4MGccfZPXlQ/K3TK6KGTP7hexs1mQjzYIQeJMu65H10YvUID0
         LB1gvoLPjtnO1R25IEC+6GXtKzS9NajXeNsAsGbMbEpDzFE6GT5IOyCPA5lH+CYBTzRb
         Jv1YRL4hzPZkCOi78vCwUYYYZ66OUXkW6k0450vgVMQjYDJ6DqSMiOhNJIfHtNhd5dGw
         GZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HPlM28T/oJ4/6Xh6FGi+9sK76pxmz7U2+VXMGXF95EA=;
        b=e6zPKnd5dB8AvdyoPskEw0s1RPp94HkktjSJ20lZUeQu9xf4Uczz/eYsgFdKrGYVBI
         qd2+JFN+41ROU30s6wLinwJOqwlgJUmi9zwr6wveFvUAj7BXlPVDNTptRfpI8zZX09d3
         187xwyMKI4OJlhYR+WZd453ToHE2HnNI+kAvkebTqWhBQZOniw2dqnnATVh9bJmQ7x3e
         U0+0+cTueHbpoWLoDFRHWx6TMiwRLAwjtdycAFITOt4BENX+dXsSsWQzZmbamR316q9J
         LFy8uedkdq6K7UB00LmD3wtKxBMfle4VW4bUMSlb2vlGIR5TGwNhjiuEwZ8n3xG2k/DW
         yE2w==
X-Gm-Message-State: AOAM532jInnfFnFfmSrRc70mpq4ZiHJEgyJtcOWOT6jt4ScrsO8O3svQ
        QwCPMR0pzDyfM3AH79J6JK2wAWlonwGB
X-Google-Smtp-Source: ABdhPJziLpu27fJWsU3sVkITkceR26u6rR5Y64vk/3J+BiXXBYz7MRm7l9Do6/o6LTGAZ3FTVFMfj0dfAm9D
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a0c:db0a:: with SMTP id
 d10mr2288345qvk.28.1631574619217; Mon, 13 Sep 2021 16:10:19 -0700 (PDT)
Date:   Mon, 13 Sep 2021 23:09:49 +0000
In-Reply-To: <20210913230955.156323-1-rananta@google.com>
Message-Id: <20210913230955.156323-9-rananta@google.com>
Mime-Version: 1.0
References: <20210913230955.156323-1-rananta@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v6 08/14] KVM: arm64: selftests: Add support to disable and
 enable local IRQs
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

Add functions local_irq_enable() and local_irq_disable() to
enable and disable the IRQs from the guest, respectively.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
Reviewed-by: Oliver Upton <oupton@google.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
 .../testing/selftests/kvm/include/aarch64/processor.h  | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
index 265054c24481..515d04a3c27d 100644
--- a/tools/testing/selftests/kvm/include/aarch64/processor.h
+++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
@@ -172,4 +172,14 @@ static __always_inline u32 __raw_readl(const volatile void *addr)
 #define writel(v,c)		({ __iowmb(); writel_relaxed((v),(c));})
 #define readl(c)		({ u32 __v = readl_relaxed(c); __iormb(__v); __v; })
 
+static inline void local_irq_enable(void)
+{
+	asm volatile("msr daifclr, #3" : : : "memory");
+}
+
+static inline void local_irq_disable(void)
+{
+	asm volatile("msr daifset, #3" : : : "memory");
+}
+
 #endif /* SELFTEST_KVM_PROCESSOR_H */
-- 
2.33.0.309.g3052b89438-goog

