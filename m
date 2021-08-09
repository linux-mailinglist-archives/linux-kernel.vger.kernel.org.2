Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF673E48A3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbhHIPZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235409AbhHIPZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:25:16 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B78C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 08:24:56 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id dl20-20020ad44e140000b0290347c39b05c0so10991917qvb.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 08:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BeIaolisaUZtGeC9k2EMLoK7VySoIN8YqNGAmtfkvk0=;
        b=iotHDKdGhx5vD9VI+nB2hXHLhXQLu/dD/nLQap0ZXipIAdjHfTrBtWxzjBLF27fJvX
         V8y2aGlVI3WevnGv3a/oygvB8DWA83QPRUnoFEaP2mA/jZ5OzBE3dKjBkI9lUapxC4nI
         kvU0G+t3hmhMJm5nfdoXxXB7+P0mv3iMd/wNs0oYDeM9lA/FwvqtmAfoJDexoKDFfwCM
         /KfNeDHdg0hyO5xlCEKkrzl90VhfWtHnfpPf+mjOAQJeoMnDgQiNXR4arITrxhV1tsQO
         oADMUZZt36O4VZv5wDHUL3HnQX+JwOi7hViCI1DDa2kxcUEA214zGyr/oVnSEsHC2Sef
         V3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BeIaolisaUZtGeC9k2EMLoK7VySoIN8YqNGAmtfkvk0=;
        b=U11HQ0giLItRngeYiovSMBc10c55PekFHN761NDmTFLoEJ+HnQJOa/j6z3jaGgZVmn
         wAKFc+QZw7PgXoXef5Rtc3X14SX/6/x87vzUxAMN3vif1Y5CvyAEN+zgo06CTlCuN6vR
         BsZ1QZMzR7tErLWH+C1CtSWxNGkGLmoszhov+VRKDxRrYASTtB6JDUlirnbDUzt2XIur
         gkRt7+hWG3vwM5YfA+IsFq3OKd6GPPc+CW7Yt82oIGPmCbt2qODRJmStwSM7jZZRi9F2
         dVbl13WUZFtbAtY/0tF1wjSEa5qsA1H3S2Ta8yMqTUryrRALarRYSlWOX1jMUv3L0+S7
         HOww==
X-Gm-Message-State: AOAM530a7mcF0JfEvkQgBcCwtVbcPYHBUlkiTO1h6WKS87gJgQIdqI2u
        /wagOOE3ycc5lmttUHG4WBd+2A3boGGm
X-Google-Smtp-Source: ABdhPJwwkJx0vgQujLnN6O80r1QMwphuw2OhWcj7Ct18NZVCBAh2Ykl3Y1mymMGph4BEdeJQyMlOnYmLV0m0
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:b0e8:d460:758b:a0ae])
 (user=qperret job=sendgmr) by 2002:ad4:59c5:: with SMTP id
 el5mr10407143qvb.43.1628522695300; Mon, 09 Aug 2021 08:24:55 -0700 (PDT)
Date:   Mon,  9 Aug 2021 16:24:29 +0100
In-Reply-To: <20210809152448.1810400-1-qperret@google.com>
Message-Id: <20210809152448.1810400-3-qperret@google.com>
Mime-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v4 02/21] KVM: arm64: Introduce hyp_assert_lock_held()
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com,
        qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a poor man's lockdep implementation at EL2 which allows to
BUG() whenever a hyp spinlock is not held when it should. Hide this
feature behind a new Kconfig option that targets the EL2 object
specifically, instead of piggy backing on the existing CONFIG_LOCKDEP.
EL2 cannot WARN() cleanly to report locking issues, hence BUG() is the
only option and it is not clear whether we want this widely enabled.
This is most likely going to be useful for local testing until the EL2
WARN() situation has improved.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/Kconfig                     |  9 +++++++++
 arch/arm64/kvm/hyp/include/nvhe/spinlock.h | 17 +++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index a4eba0908bfa..9b9721895e5c 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -46,6 +46,15 @@ if KVM
 
 source "virt/kvm/Kconfig"
 
+config NVHE_EL2_DEBUG
+	bool "Debug mode for non-VHE EL2 object"
+	help
+	  Say Y here to enable the debug mode for the non-VHE KVM EL2 object.
+	  Failure reports will BUG() in the hypervisor. This is intended for
+	  local EL2 hypervisor development.
+
+	  If unsure, say N.
+
 endif # KVM
 
 endif # VIRTUALIZATION
diff --git a/arch/arm64/kvm/hyp/include/nvhe/spinlock.h b/arch/arm64/kvm/hyp/include/nvhe/spinlock.h
index 04f65b655fcf..4652fd04bdbe 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/spinlock.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/spinlock.h
@@ -97,4 +97,21 @@ static inline bool hyp_spin_is_locked(hyp_spinlock_t *lock)
 	return lockval.owner != lockval.next;
 }
 
+#ifdef CONFIG_NVHE_EL2_DEBUG
+static inline void hyp_assert_lock_held(hyp_spinlock_t *lock)
+{
+	/*
+	 * The __pkvm_init() path accesses protected data-structures without
+	 * holding locks as the other CPUs are guaranteed to not enter EL2
+	 * concurrently at this point in time. The point by which EL2 is
+	 * initialized on all CPUs is reflected in the pkvm static key, so
+	 * wait until it is set before checking the lock state.
+	 */
+	if (static_branch_likely(&kvm_protected_mode_initialized))
+		BUG_ON(!hyp_spin_is_locked(lock));
+}
+#else
+static inline void hyp_assert_lock_held(hyp_spinlock_t *lock) { }
+#endif
+
 #endif /* __ARM64_KVM_NVHE_SPINLOCK_H__ */
-- 
2.32.0.605.g8dce9f2422-goog

