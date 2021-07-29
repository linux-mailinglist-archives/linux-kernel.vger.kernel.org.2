Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5343DA41C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237615AbhG2N2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237423AbhG2N2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:28:32 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF59BC061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:28:28 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id k5-20020a7bc3050000b02901e081f69d80so820273wmj.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=t7+5ofN1mhSPCYy31zt7RU0I2nBRXXWPYqlSGOk7ubE=;
        b=EOWUMMsZPsB2L4bsN4GxoGi3y0igtMQJVuIWpJTOwkroahO2vrvgGKDlL7RtzJMlsM
         0oE50dz19H3398h3CH7lGvES9i7AZ+VyzBn3LLKoJN/6N09gfxN4nZrgog/WIOpdxF48
         B/jbMHiG9QnFkf2f639cMBjVse7pVDqHc+1Ylei1mCqOmtyDH269kxdDb+J0Kuh6hwTv
         9+n8fZ5n5Q8wA6fg82FoPSbY9mbZRd1dd4E3hdMvxHuv/9ztJK9IqX7gYuN2lWpjx5+s
         +HFOzx5RoBxyC3x0/qNim7tnNdldKJhuLJ7GxVdP5C7TH7ZDgtXRup/AoaGjp/YnLSie
         c8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=t7+5ofN1mhSPCYy31zt7RU0I2nBRXXWPYqlSGOk7ubE=;
        b=Lp6QdLJeF1gdwOkM/uI+KCXrVkyspO7Wp9WtqzkRawHFZBVXyGgv3wWcBIbsyIQiw1
         KIGFvrBT6yjo+8DxnpytNP7fmMhTTxTZRfYhxymnm5RJ0ErTKyDUDCPxpOfSrg0GZPXy
         eSqiTgfm1HcbegHneJ6ifOrP04nZCMWn1l8mqgYg15xg165biR+QWynrtkukj66qIPQO
         XK7iyH746JP3vnID41P+3fqcMCvKivHz+U+e8my1C7+7N/sNca0S3hOS2ky15gdVsgL3
         2tNsq3xVEfmtYUo6FuG/RLp2YZSH7GcEhp0PufbBo3F4fL5tSP0Cz3GXe9PD0b85jxMS
         TR2g==
X-Gm-Message-State: AOAM533qPCYTXqi8Q0m2XgFUhohHs7Y3ubx8nMnIOzPW58sjcZsGlI5i
        o1kk03JpgOB9SFr+xT36aAKqjBZsem+g
X-Google-Smtp-Source: ABdhPJyA9LhjEf8A/taAM06dydN+uO7RN2g31fVg3fvbmNEB2A5ceVlvMQQeLCoX2VjPrd82TvrUI4VZN1Ys
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:293a:bc89:7514:5218])
 (user=qperret job=sendgmr) by 2002:a1c:4b0a:: with SMTP id
 y10mr4499wma.1.1627565306816; Thu, 29 Jul 2021 06:28:26 -0700 (PDT)
Date:   Thu, 29 Jul 2021 14:27:59 +0100
In-Reply-To: <20210729132818.4091769-1-qperret@google.com>
Message-Id: <20210729132818.4091769-3-qperret@google.com>
Mime-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 02/21] KVM: arm64: Introduce hyp_assert_lock_held()
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com,
        Quentin Perret <qperret@google.com>
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
2.32.0.432.gabb21c7263-goog

