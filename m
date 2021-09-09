Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6EF4042FA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 03:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242112AbhIIBkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 21:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349963AbhIIBkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 21:40:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7B1C0613A4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 18:38:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i189-20020a256dc6000000b005a04d42ebf2so353897ybc.22
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 18:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=joYYrt7hpuPfUeQcd44dEnmpKJRkC3m+olCPcRklPKY=;
        b=FmT4tXPeRDgw2DsrBZpZGU6PcjTlqMTB9wZqCZm9tFBuL4YGumdgIw8m9nJpGy7K2o
         QYsOw8LRgRYm95W4lSQlPjO7sHUsJHvmCf//Z9HkzC5WFE0ltOxtgtruZBHWU5+lyW8d
         tyISweHmsA2pL8jnZ1XopsISmcAGv1TGUh3i1sOmjVR+89zSpnjVbubTD5YxqU6axujR
         iC5Bo6uEchxMhU7sTZonLg1PKJy5nk4TN+T3O3lRQY+zvf8akm5MfKalvVWOHQh+ZZZh
         xa6NDR8lw9UzwQzVVyNZ4oE7mAM9CccSUMU4oq2kLeew6YO2bKG9NmIZqb2LZBM5sUaT
         cSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=joYYrt7hpuPfUeQcd44dEnmpKJRkC3m+olCPcRklPKY=;
        b=3e9k5Inq49xNCSIuWh2z/JHg2aiTybVroQuWOa+bajKl4leSIjgUY4jVsKvLpt0Q7O
         pDb1rHCuAjwRAcoHYp2JCWxLAY1nHqI8Rea/e+4PMEVas46nq8q0ST7A0Mg+2nhrexKG
         /uDe67M6/yi+ospqheYhsi43bZVW/NcgA5CXJZvdBZ9RnTHIvgiOQtCRI33BmqJOjktf
         WZ3YkfdwTrgOq3aPRR5ISnbuP/TeyweP1opgBxPejvACZSggsy0wH5GCiglZnQqwBfow
         /29bGbRWyZwh+4/NLf6nWi9yvBzHqUfsKNLFBuaeXsMlzHuVC5PJ/SbOvj+ko8dYRmSw
         J5TA==
X-Gm-Message-State: AOAM533atntnKsKGHASSaX7zFkREEHWYnBPfb97DejEts6PmGp048vx4
        71iiRFvAEYL3o/W1xkRXjyLs4RrjE9qZ
X-Google-Smtp-Source: ABdhPJwFC/OW1Z5F2EdPKG+1rynUG9GSXEW3pl0UpRo9goR7t0bNT4MLjGR/06vsJCUHuxOMHJCWVlVpiEKi
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a25:3894:: with SMTP id
 f142mr565481yba.464.1631151524424; Wed, 08 Sep 2021 18:38:44 -0700 (PDT)
Date:   Thu,  9 Sep 2021 01:38:08 +0000
In-Reply-To: <20210909013818.1191270-1-rananta@google.com>
Message-Id: <20210909013818.1191270-9-rananta@google.com>
Mime-Version: 1.0
References: <20210909013818.1191270-1-rananta@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v4 08/18] KVM: arm64: selftests: Add support to disable and
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
index 166d273ad715..b6088c3c67a3 100644
--- a/tools/testing/selftests/kvm/include/aarch64/processor.h
+++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
@@ -184,4 +184,14 @@ static __always_inline u32 __raw_readl(const volatile void *addr)
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
2.33.0.153.gba50c8fa24-goog

