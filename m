Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC324335A8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbhJSMP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbhJSMPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:15:46 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE86C061765
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:13:31 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id p12-20020adfc38c000000b00160d6a7e293so10046836wrf.18
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XSGm2ZIKVrWUlcjyigReTRCR+F+26tmq3jrTuKF0cGY=;
        b=Ff2j/4N+CqKMpFaKt5pCbLJb0KMSeXSN5oHh9p1pg7HOlQUt4WVieG3ZBh7ENNwFm5
         viyVQrMK1sbcJirVOPfonTx/8M/aJhkeJ5B0u39TrugRP37ewl3yR7JqNBkgGs5haXuK
         2fi9U7qJQGDInMSacShFQe6bjTZGdOvZEJjC2u9S3JYEC9A/zFpkeAbhlKyXkFOd6lwC
         oL4KmJI4uy8trhkrcZEQPwkbiQ5Bl3dvWof9sI+QQEALuNIQmcBzTtZ0TfprSuIPENHy
         ufCkQwqZGkNRKzejuz/j5PitlWgZX9pmE79oY8xDJrop9UJlUpRgizFQwE0bT83ExOBQ
         UJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XSGm2ZIKVrWUlcjyigReTRCR+F+26tmq3jrTuKF0cGY=;
        b=finPXQoiQPVvE7NDOQ5KIdHoXY0u99TuamzXySttmyQ6EcQ4UyLeu4UZGiRh53fDCY
         Gh9zWSbyZ46nKfQHPQuJbI8HTzp/KAt/amSsXNbQHde3xnOM3iQfU+Xpvf4S+N2qeIr8
         i6KhdvBAyUuNAjcOGL8fdCYLIc1NKQmm9Y3QowhA6BIbRNPY/RDAmF+SRb7W2XfJj/ri
         34VpHn8LfebKsPURAqXdBmOMpDiDfrdCBcj+2ZpwJjj/NdkdIXHKmzKIa13H+VXE3lsA
         fUP8qjOYWwgMG4hWNeqgWy6uoldh9+6+CEWMCdUuOSeNGKjOLZuEhyYRCb7nhLRNSCcq
         S9aw==
X-Gm-Message-State: AOAM530oaVdSOUwJPgcz8cYBQdWmrVgPoel06t5BI8y7M/vIO8IebxZa
        o4uZE8jWMFiSRU20N2ye2xa/frAHZljo
X-Google-Smtp-Source: ABdhPJwm42LEsA7dym14pML9UYuqWVeZUfAiAtE2QfcZAOVwsec8LgosKo8zwZK3COAZq6Dpj3+/8mX1AvV+
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:59ca:401f:83a8:de6d])
 (user=qperret job=sendgmr) by 2002:adf:b302:: with SMTP id
 j2mr44597972wrd.285.1634645610149; Tue, 19 Oct 2021 05:13:30 -0700 (PDT)
Date:   Tue, 19 Oct 2021 13:12:59 +0100
In-Reply-To: <20211019121304.2732332-1-qperret@google.com>
Message-Id: <20211019121304.2732332-11-qperret@google.com>
Mime-Version: 1.0
References: <20211019121304.2732332-1-qperret@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 10/15] KVM: arm64: Introduce wrappers for host and hyp spin
 lock accessors
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Andrew Walbran <qwandor@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

In preparation for adding additional locked sections for manipulating
page-tables at EL2, introduce some simple wrappers around the host and
hypervisor locks so that it's a bit easier to read and bit more difficult
to take the wrong lock (or even take them in the wrong order).

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 32 ++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 1f0fb0780622..c111e0fcfa0a 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -27,6 +27,26 @@ static struct hyp_pool host_s2_pool;
 
 const u8 pkvm_hyp_id = 1;
 
+static void host_lock_component(void)
+{
+	hyp_spin_lock(&host_kvm.lock);
+}
+
+static void host_unlock_component(void)
+{
+	hyp_spin_unlock(&host_kvm.lock);
+}
+
+static void hyp_lock_component(void)
+{
+	hyp_spin_lock(&pkvm_pgd_lock);
+}
+
+static void hyp_unlock_component(void)
+{
+	hyp_spin_unlock(&pkvm_pgd_lock);
+}
+
 static void *host_s2_zalloc_pages_exact(size_t size)
 {
 	return hyp_alloc_pages(&host_s2_pool, get_order(size));
@@ -327,14 +347,14 @@ static int host_stage2_idmap(u64 addr)
 
 	prot = is_memory ? PKVM_HOST_MEM_PROT : PKVM_HOST_MMIO_PROT;
 
-	hyp_spin_lock(&host_kvm.lock);
+	host_lock_component();
 	ret = host_stage2_adjust_range(addr, &range);
 	if (ret)
 		goto unlock;
 
 	ret = host_stage2_idmap_locked(range.start, range.end - range.start, prot);
 unlock:
-	hyp_spin_unlock(&host_kvm.lock);
+	host_unlock_component();
 
 	return ret;
 }
@@ -358,8 +378,8 @@ int __pkvm_host_share_hyp(u64 pfn)
 	if (!addr_is_memory(addr))
 		return -EINVAL;
 
-	hyp_spin_lock(&host_kvm.lock);
-	hyp_spin_lock(&pkvm_pgd_lock);
+	host_lock_component();
+	hyp_lock_component();
 
 	ret = kvm_pgtable_get_leaf(&host_kvm.pgt, addr, &pte, NULL);
 	if (ret)
@@ -421,8 +441,8 @@ int __pkvm_host_share_hyp(u64 pfn)
 	BUG_ON(ret);
 
 unlock:
-	hyp_spin_unlock(&pkvm_pgd_lock);
-	hyp_spin_unlock(&host_kvm.lock);
+	hyp_unlock_component();
+	host_unlock_component();
 
 	return ret;
 }
-- 
2.33.0.1079.g6e70778dc9-goog

