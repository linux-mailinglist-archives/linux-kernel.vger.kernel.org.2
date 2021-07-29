Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B888E3DA418
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbhG2N2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237462AbhG2N22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:28:28 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777F1C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:28:25 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id j12-20020a05620a146cb02903ad9c5e94baso3795910qkl.16
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=crBqYydgsM0lLmpXbxrQzqnfwJboPEMWJ5uFG+CB388=;
        b=JOIVCVkTKSE7PwC39f/uN10vnOvi7Vzp2RTafhg3kyIB15DlDdxcNRRjKoM75ogyTS
         sjmXizIUunrQ4Q2yIkfgmJDrNF8nuB33MW7tB7YPCbcNhgcnStKG61TKLA9OHyXOwzKH
         i7uDNzA+PPHFpfTHJs2M5QoYOwbb6NUXBh++UvXlYe3cdezMzPl1EZ3sOx0jBVOxIit7
         DsJ4Rk2OJv96rif4hnZqeL50UBKsRJGWc8A2EaMc0YZVDJkZTXTjcJfL1x72E+Z4uyBi
         PGyvbycBPgY92pQ84g5f29LjEY96+E8Pod3jV3Xa3E41vkI8XuIPX9jDrr0GlJ2pzzRS
         RQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=crBqYydgsM0lLmpXbxrQzqnfwJboPEMWJ5uFG+CB388=;
        b=dypNxDTa3+Z75+4T6HPjpXDQnwWh0DBlnJcuDd1JNSUovP1/8ueSx1UaUz3Ta8XLzX
         jzDPCi8zhp3l1rDBG8fKnTxTTrk02c1wi2AoRQFUTHuXFhO/zevRol1akJlW7xtAux+y
         5nzgDF8OnbqbVQKcBExA5pIadJ8pP0daFN0XdjKbquvJ00cPF0Y5zKjLNff4+btN9kqQ
         +XUVxcmpUhtNjs8ejHxlq/xMG7/XGfaczRKq1nqb3hoD0czGlRz/8UQccURWqjaADyIK
         OSG1bCHPHEvKoD4/wghpTi4CEIuVGqR7IA+5isSxUquEvbLTIwlvUyDQt1dYWmgJzlf1
         OXIw==
X-Gm-Message-State: AOAM530JMjc38DmzwA/2I5oXBSQHcJEgbVnGkt8F8Rnfiful0n5Wwuiz
        kKv8UcJmzR38LS1Ebpx7eWcEkmPrWxtj
X-Google-Smtp-Source: ABdhPJxHRTBRw3rhOotBjYPWwjVk04U8m2F1PsiYgMcXVSq1/9Rd7rzCjHaUtz4DsAzceZrGz5P9KOU1HQzs
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:293a:bc89:7514:5218])
 (user=qperret job=sendgmr) by 2002:a05:6214:1021:: with SMTP id
 k1mr5318862qvr.4.1627565304476; Thu, 29 Jul 2021 06:28:24 -0700 (PDT)
Date:   Thu, 29 Jul 2021 14:27:58 +0100
In-Reply-To: <20210729132818.4091769-1-qperret@google.com>
Message-Id: <20210729132818.4091769-2-qperret@google.com>
Mime-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v3 01/21] KVM: arm64: Add hyp_spin_is_locked() for basic
 locking assertions at EL2
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

From: Will Deacon <will@kernel.org>

Introduce hyp_spin_is_locked() so that functions can easily assert that
a given lock is held (albeit possibly by another CPU!) without having to
drag full lockdep support up to EL2.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/spinlock.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/spinlock.h b/arch/arm64/kvm/hyp/include/nvhe/spinlock.h
index 76b537f8d1c6..04f65b655fcf 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/spinlock.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/spinlock.h
@@ -15,6 +15,7 @@
 
 #include <asm/alternative.h>
 #include <asm/lse.h>
+#include <asm/rwonce.h>
 
 typedef union hyp_spinlock {
 	u32	__val;
@@ -89,4 +90,11 @@ static inline void hyp_spin_unlock(hyp_spinlock_t *lock)
 	: "memory");
 }
 
+static inline bool hyp_spin_is_locked(hyp_spinlock_t *lock)
+{
+	hyp_spinlock_t lockval = READ_ONCE(*lock);
+
+	return lockval.owner != lockval.next;
+}
+
 #endif /* __ARM64_KVM_NVHE_SPINLOCK_H__ */
-- 
2.32.0.432.gabb21c7263-goog

