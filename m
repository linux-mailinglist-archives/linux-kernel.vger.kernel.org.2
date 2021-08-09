Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936113E48A1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbhHIPZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbhHIPZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:25:14 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3558C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 08:24:53 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id v6-20020a0cf9060000b029035546f11a23so1027891qvn.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 08:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9BduUGnjsWum8FcOsM11gO3G+u8+79slhTeMYYKry4w=;
        b=g983I9YSVoWH/a7/cl0ZycwVjzqZeyo8x+fLCew59C7a0BnEu2wL6cysC50kAFs8Vi
         ehEdfCFNUnOWvVuDeMXGfwSfjkPO6irIfVDI1BOyVgOb2mistjn/3qc9aekGj3nyWfEP
         mv2IxEl7l/db3vL40dr7vcCKECuWFlGEQTsXsxS+OPHN8h4PW005Da05hkZ4QrGVi6/c
         iy5E1D2xv8HABlnaCg5SV0NZvQskMmKX3vG7+v7NRPhL/iuVTDX753+y/AxDWOc3l6hM
         igtE3JtznbdG+M1JR7b47U5TTSHB4/v8dAR/v0CBrRKmc9w4iH1rKAt2xMXY4Rmb58AP
         IwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9BduUGnjsWum8FcOsM11gO3G+u8+79slhTeMYYKry4w=;
        b=ZTXhTayObHpoBkKQL/OyIrUYvRgg0DkUorUZklvKFUinr6KQpJc8bxhwd+2V4kdfbz
         99dE9oi60obrKGEsBwmfNiTGV7bzxndd34ugaUFwFUlw/4+pvja4YAcCq2qV/NAY1A7q
         RYO73m3gTiPntXUwd6vsTD8kVPdNIbCQcOB9rViiaLEbRiOHBbyE1Gk2igomow0arvmt
         Xxm0dYJwC/+yV/G7+/QdmQU4AnBoe1ZMu751misHpS1LBthgGBCWKh9D4ttoLUIEBn+a
         msiX384cq7Ly6BPpReFf7+4LIJUiFCpLBeX8eRshtq9h7r9elWf2KtYmtVf08NkR18fk
         JxNw==
X-Gm-Message-State: AOAM533b/qfOePnf0WO4luAsGfpRU58PWw+p20pWV+JfDENL7MZt7Xh3
        E2tWW62DQBH72Hc2m1I4MvsIFxjqK01s
X-Google-Smtp-Source: ABdhPJxcZ9biebm1fDKv+UMiqbVL5l0nCshM5eLfjTeBhNH2YYSYI90HGbAFPRYEaW9dglJFBj8tlcbiknXL
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:b0e8:d460:758b:a0ae])
 (user=qperret job=sendgmr) by 2002:a0c:e609:: with SMTP id
 z9mr9405599qvm.37.1628522692904; Mon, 09 Aug 2021 08:24:52 -0700 (PDT)
Date:   Mon,  9 Aug 2021 16:24:28 +0100
In-Reply-To: <20210809152448.1810400-1-qperret@google.com>
Message-Id: <20210809152448.1810400-2-qperret@google.com>
Mime-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
Subject: [PATCH v4 01/21] KVM: arm64: Add hyp_spin_is_locked() for basic
 locking assertions at EL2
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
2.32.0.605.g8dce9f2422-goog

