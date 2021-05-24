Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B2038DF65
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 04:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbhEXCxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 22:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbhEXCxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 22:53:03 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E069FC061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 19:51:34 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ml1-20020a17090b3601b029015f9b1ebce0so1093342pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 19:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=i73AEFY5NK+zxdF+/J6dNT5X4fwFt2JtmM0q5i6FPrM=;
        b=Mu2QW6oyzg/UXrOcCuAbGWTpk2Fm7TxGyrs2yDN4/I1jwkaLDut9+W3W41nbg13eQd
         S0R8B5s4PpfJfovl/8CAg5VuDKW3HmnwpZGTJgdwZXieLiFX2qDU8r3aapwHzq0t0tbw
         PDChgVjfPcHZWPSZMDojeFuzvvSOr+V8Q9rrIW+dqTbYVXqPsaCBb/f/dKA29oB1Pt2I
         2wRBbXwqQBc6VDvp90TnJvSAGBbEEuXU5tIa6Wd1bVcH2ir1PZro0UC6pVL1+K67mu1Z
         kBh+W3EtxQMgQsD30sH6k8BSZsXFCq3ajqEON3PNAbO8ES1zWPAOg42C8mbJ2Tte5zOA
         CmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i73AEFY5NK+zxdF+/J6dNT5X4fwFt2JtmM0q5i6FPrM=;
        b=K3+SngyxBVd7N/WF6ntdljH7y3/r5JwhbTOfV57fcU4tdI9s8jWMpBgupLGkQ5VJcS
         gVO1c61eagEBywMeNuvpLx20jr/86KTr/LthUuP8acSsMqLqszi2zC41nQ+s882QxrBC
         uSwCOkP3FKLujnbm9A9T+LMoSEIW+aktIlcEnmNMHVw8usI8RmGhKJPM+1NLP9XMBhQ8
         oJ8enkUw5C8ih9jJdsslcGqE8jnKteY73G/2RtTGEmzi8NOY/cGVy0oWJutK6eVDhYbn
         R5txjHYBJ0d/SBJvhIKmTcxDet41yAQ+NYFmL5nwcjZWXBfqyzkYk/fozGR0r3PlO1kS
         UTyA==
X-Gm-Message-State: AOAM530GgULNNeBOxtpZwyRj3IQ9FGuXnuH60oDFCvScD9D5+KiEVj0K
        ZkOVbX9nDagOjigoivPB8uE=
X-Google-Smtp-Source: ABdhPJzgUS8QvthqSO/900dIWQWMgT5qJ6lPzkYtCrC6kwqK8275gs97KuEVpvgjQjOnKj3CUtcyKg==
X-Received: by 2002:a17:902:f211:b029:f0:c53a:65e2 with SMTP id m17-20020a170902f211b02900f0c53a65e2mr23295728plc.80.1621824694296;
        Sun, 23 May 2021 19:51:34 -0700 (PDT)
Received: from sz-dl-056.autox.sz ([45.67.53.159])
        by smtp.gmail.com with ESMTPSA id q3sm9738957pff.142.2021.05.23.19.51.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 May 2021 19:51:33 -0700 (PDT)
From:   Yejune Deng <yejune.deng@gmail.com>
X-Google-Original-From: Yejune Deng <yejunedeng@gmail.com>
To:     peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        rafael.j.wysocki@intel.com, rostedt@goodmis.org, npiggin@gmail.com,
        mark.rutland@arm.com, yejunedeng@gmail.com, elver@google.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] irqflags: Remove the CONFIG_TRACE_IRQFLAGS
Date:   Mon, 24 May 2021 10:51:19 +0800
Message-Id: <1621824679-29258-1-git-send-email-yejunedeng@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trace_hardirqs_on() and trace_hardirqs_off() had include the
CONFIG_TRACE_IRQFLAGS, so remove the redundant CONFIG_TRACE_IRQFLAGS.

Signed-off-by: Yejune Deng <yejunedeng@gmail.com>
---
 include/linux/irqflags.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 600c10d..b5edd7b 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -189,12 +189,6 @@ extern void warn_bogus_irq_restore(void);
 #define raw_irqs_disabled()		(arch_irqs_disabled())
 #define raw_safe_halt()			arch_safe_halt()
 
-/*
- * The local_irq_*() APIs are equal to the raw_local_irq*()
- * if !TRACE_IRQFLAGS.
- */
-#ifdef CONFIG_TRACE_IRQFLAGS
-
 #define local_irq_enable()				\
 	do {						\
 		trace_hardirqs_on();			\
@@ -230,16 +224,6 @@ extern void warn_bogus_irq_restore(void);
 	} while (0)
 
 
-#else /* !CONFIG_TRACE_IRQFLAGS */
-
-#define local_irq_enable()	do { raw_local_irq_enable(); } while (0)
-#define local_irq_disable()	do { raw_local_irq_disable(); } while (0)
-#define local_irq_save(flags)	do { raw_local_irq_save(flags); } while (0)
-#define local_irq_restore(flags) do { raw_local_irq_restore(flags); } while (0)
-#define safe_halt()		do { raw_safe_halt(); } while (0)
-
-#endif /* CONFIG_TRACE_IRQFLAGS */
-
 #define local_save_flags(flags)	raw_local_save_flags(flags)
 
 /*
-- 
2.7.4

