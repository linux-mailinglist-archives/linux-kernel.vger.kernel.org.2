Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DAE40BB9D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbhINWds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbhINWc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:32:58 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F01C061764
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 15:31:40 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 3-20020a620603000000b0042aea40c2ddso408707pfg.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 15:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HPlM28T/oJ4/6Xh6FGi+9sK76pxmz7U2+VXMGXF95EA=;
        b=tmMkF1iIlgid4lE+KCI081z+kIafX017lVcJzrb5ucmqZ5rG5veS8v5u5HwYZXdp+z
         DPQjGLbCiQ+Od2qaK2fU1ClGTGViwPjMrf8G6a+hreSrSdDvmbOJdg9WCcvJI3eznihO
         hDfbf2rgTUryAbdPZNXJ1Lz9OSlAOO4yoHi0d+0j35RXV0cjNYyrULP3CcEi207DuCWS
         XiXAIVBRYGzOJSOg+RpAE8vt2EylVoS1mDPIef4+NzPiSf07EdL48rIcoIKu7la5ztSG
         PR4E/j02ore8dcGMZVzt9BJuIPUVPokgd22Pi7pEFL90fLnINykMY+Pg+KzVdrgCNFGi
         8aHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HPlM28T/oJ4/6Xh6FGi+9sK76pxmz7U2+VXMGXF95EA=;
        b=HJlYAjMAXWLfTXDPyA6yl1ZGzz7skjmHXpeD3+UTvd1eHCVTI8u7h4VYuIzuCOyOfw
         kFHyT5aNBjphR7LPzsja5MB3pSmksLICrtRLWXrSxaV48De8cZYH0RK5GOV/NkYnAGTc
         sOSdb6FX2a1SY44yU2vz5hL93oJZrjFKUG7PyoIczAgvWNUbK1Dl9MPsCwDrvFtbFpXt
         LRrkPncTMqiNAzlitP7x5Bpkov88sFpcd2bDK7MReKJx5xmjfd/x+qBQ+Z2D2ZKZ71h4
         Vzzb/HYX5REyk0feCA3wEZ6jnfwoJ3zNw2oGMTUOycWgaWYyB/Ajuyzi15GqoZ5gg5pD
         Z61Q==
X-Gm-Message-State: AOAM530RfgbX+vtjEKkvalSWx2MjgsBsEjbxAeLEF/OAkL8grJR198C5
        1+5vmQjHYRsfLpASCG8Kj7H+RAbrTMLU
X-Google-Smtp-Source: ABdhPJwijJSNntP3Ve1O0fbt6STM+Z/x8Y4JILzfiVpM8hiFewlC+opxgb5n5h3BsxgGhFmC5kJd70EctepX
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a17:902:be08:b0:134:924:1733 with SMTP id
 r8-20020a170902be0800b0013409241733mr17011901pls.64.1631658700158; Tue, 14
 Sep 2021 15:31:40 -0700 (PDT)
Date:   Tue, 14 Sep 2021 22:31:07 +0000
In-Reply-To: <20210914223114.435273-1-rananta@google.com>
Message-Id: <20210914223114.435273-9-rananta@google.com>
Mime-Version: 1.0
References: <20210914223114.435273-1-rananta@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v7 08/15] KVM: arm64: selftests: Add support to disable and
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

