Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C15442608E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 01:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242634AbhJGXhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 19:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241969AbhJGXhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 19:37:02 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC5BC061762
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 16:35:07 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 2-20020aa79102000000b0044c216dd8ecso3640177pfh.18
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 16:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ii6HvMNSDW3BECmvGstwgeSfkGwZjjRRnxyRpuZ+gSA=;
        b=Z+0lI+jtnSx8SUemH3b2pgvauES0Ucd5KziWgSI89l0ig5r8XtisCnFktIPqEwwa+v
         hKDJf57FdnosDHfhcObFHEjYaQ+3t6pZCwTE85sMEcnc6JxtznxnQzFTzHOFEGbFFt4+
         N8f2bkng2JTK87mrc1T/8dLn8Kw+f2zatc65wShnQY4y09db5OpeXQTwSXscOi779xs4
         Tr2LXQqqG5+aPy8/DXYq8IubgajqT6SEfWb1n+aaNkrpwvmJwiy8aocWwQ5joTgJiyi1
         JokJlT5zZlCRa4Vmet3RO/QPrA5oMfrre19vU9zDXBwjCPuFb1XSzKtS7OR02CLfNwGx
         +tfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ii6HvMNSDW3BECmvGstwgeSfkGwZjjRRnxyRpuZ+gSA=;
        b=aSm0MzJ3x4Y9NBoepeNTd2R0bLphTvbzNhW1mqLqWYuyqamgM4UvhsYKbWl/s6CqvK
         diebrXpZEyWQJZC6Sze50/RUgRusxJi2CEWRcMc0qJ1mt9urQcuYg69fIV0z5b+LxYkd
         E5rbmGUnTqCkj4nbIfpZ8Bzj75pIRcPNXJEGZWW+HkoVBHdxdVg2r8Uh6+qFC5Wucvsj
         9peqlay3H3gJABF25fp/6yU2m8KWLsp9rHul6FRZhvr5gj+r0u5leSWFejbPMseN+2YY
         lDXtSCzdrso6WrqCz/a2n8Y7TRDTwS0C5kLhbT9gk0tavA3vri6iFbeQoatr6jCJX8Su
         yY2g==
X-Gm-Message-State: AOAM531+LG8g6iSBt3vETJ4Nzd109s6GHQIFRcsEE77uW8DXdXcrkyaJ
        cXbE4UO0a0Cnv+ZkUOQWf9gpLIKlcGmf
X-Google-Smtp-Source: ABdhPJwRp5MH/8qbQoCZh65bLmby+gfdQyt8NwHGByXSBx4EmaopUZA+ULvoOqaFJ97bqMwaMnmuIlGdKs0S
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a17:90a:d254:: with SMTP id
 o20mr8508742pjw.226.1633649707151; Thu, 07 Oct 2021 16:35:07 -0700 (PDT)
Date:   Thu,  7 Oct 2021 23:34:32 +0000
In-Reply-To: <20211007233439.1826892-1-rananta@google.com>
Message-Id: <20211007233439.1826892-9-rananta@google.com>
Mime-Version: 1.0
References: <20211007233439.1826892-1-rananta@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v8 08/15] KVM: arm64: selftests: Add support to disable and
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
2.33.0.882.g93a45727a2-goog

