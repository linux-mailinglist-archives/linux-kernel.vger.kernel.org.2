Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4393C1E81
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 06:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhGIEk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 00:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhGIEkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 00:40:25 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC91BC061762
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 21:37:41 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id oj10-20020a17090b4d8ab0290172f77377ebso5401878pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 21:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QP3/GYzOBKmilm7HuEJkuqubxHWg9l5vJdRHFzc5VNI=;
        b=RclDDj3+rehsUldw5TyhuwvHXTZwkgCQaCL0mXmrg3nr75emQHZsdQL/PMBpmd2FSB
         1okB0a10syEhmCx3GptxPQ6XYeTuHpa4AESmoVEqtDp3+bLgb4ii01UctXQhRSyNL3s2
         nQd9N40sCnQ4Tz9f+NrHySY4qVntzcKYSjVho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QP3/GYzOBKmilm7HuEJkuqubxHWg9l5vJdRHFzc5VNI=;
        b=R8R8QlkyPtqMOjfMf0an3NTkHVxIeGFLPskmiXK9oQ75lak1UoHWV4Ndzr0Mj54fIb
         L6ah47wdJUPL+mK/8Qa2z6niTbjXUEB350mU8h6toE5Medpe1vt8FIWuS/qIWbLtVNHM
         K9wR5qNOXP9v6pgohLMuo4RwWnesFgBP/9MM5iQwwc3nc2fByVhOWHqyJOfm3TmeGJyE
         ABimhm0Fja3fbH3pIjJXKXsvhRPhJJlfjDeLmufjuH5w5Xl3/y1A0nvKEmVf9x25GsA+
         KkxFrGQ4FFG6SAsSeba9sxjAwYeXgCCxVaNTTZPPr8TaGbTGoV9s5Uh81R68n6WEpYP3
         453g==
X-Gm-Message-State: AOAM532n4Se+b+9x6oBSACXoYFKSoYQzfGnfvUbEqeYRXOaen1XjQvoU
        KXDEvbNabaOe2XEandlQWHDoXA==
X-Google-Smtp-Source: ABdhPJw7ofI5jbueMZXenvbdrtCTJqUoJIWkbzb4yngHCY3TUfGWSBMgYm2T5M9G4xte0hL+XeYjmw==
X-Received: by 2002:a17:902:bc47:b029:129:dd30:1c30 with SMTP id t7-20020a170902bc47b0290129dd301c30mr5497773plz.4.1625805461468;
        Thu, 08 Jul 2021 21:37:41 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:a30d:fc4:7834:ee08])
        by smtp.gmail.com with ESMTPSA id y4sm4420760pfa.14.2021.07.08.21.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 21:37:41 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Suleiman Souhlal <suleiman@google.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 3/4] arm64: do not use dummy vcpu_is_preempted()
Date:   Fri,  9 Jul 2021 13:37:12 +0900
Message-Id: <20210709043713.887098-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210709043713.887098-1-senozhatsky@chromium.org>
References: <20210709043713.887098-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vcpu_is_preempted() now can represent the actual state of
the VCPU, so the scheduler can make better decisions when
it picks the idle CPU to enqueue a task on.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 arch/arm64/include/asm/spinlock.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index 0525c0b089ed..1d579497e1b8 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -7,21 +7,23 @@
 
 #include <asm/qspinlock.h>
 #include <asm/qrwlock.h>
+#include <asm/paravirt.h>
 
 /* See include/linux/spinlock.h */
 #define smp_mb__after_spinlock()	smp_mb()
 
-/*
- * Changing this will break osq_lock() thanks to the call inside
- * smp_cond_load_relaxed().
- *
- * See:
- * https://lore.kernel.org/lkml/20200110100612.GC2827@hirez.programming.kicks-ass.net
- */
 #define vcpu_is_preempted vcpu_is_preempted
-static inline bool vcpu_is_preempted(int cpu)
+
+#ifdef CONFIG_PARAVIRT
+static inline bool vcpu_is_preempted(unsigned int cpu)
+{
+	return paravirt_vcpu_is_preempted(cpu);
+}
+#else
+static inline bool vcpu_is_preempted(unsigned int cpu)
 {
 	return false;
 }
+#endif /* CONFIG_PARAVIRT */
 
 #endif /* __ASM_SPINLOCK_H */
-- 
2.32.0.93.g670b81a890-goog

