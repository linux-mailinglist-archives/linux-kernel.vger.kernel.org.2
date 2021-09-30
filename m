Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B41441D068
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 02:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347291AbhI3AEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 20:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344487AbhI3AE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 20:04:28 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24B3C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 17:02:46 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id n18so4373447pgm.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 17:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YfiqAsHFpSp/0MLE07sh2cXLrM0Nj15RgncnEfhnBFM=;
        b=QG42CT5QjAIuBqxeJwHA7qGQUNRQFC22ZUmr/K64yc28lr88EFlr2Mv0Nbf7iHFQv1
         OhtqvtCCQLQZ9Hg6s38GtJcV8BtcCGO9/aE8Xs5zzmhuBbs3VLv2bCITYyCc/V6W2umc
         KpOb17fJROfCizzqer4zzBAmCPOUW52l5g8OTRhdRoTGIbYWNZ9X8Ocj0jkA+JUhY7RF
         qpNqpC4gElDxxKSrqhrLyr7JSqzEjs79KBOgdcjkzEqS2vN7xBotDwq0TjD+1rYeI5mB
         jzL7IyhGgEHzvtefs3vyRXS5jAg1pAqJUj7kg1jpFSD7ePSTvJwZm1Z/sXb+DloB+lEU
         wPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YfiqAsHFpSp/0MLE07sh2cXLrM0Nj15RgncnEfhnBFM=;
        b=6FdxrjbCD8efmm4WmS9NQP4dGBtQhwoQE5zigzu92zFtpW0s+SsLWeNrEbPVK+IOR6
         ayqn8VUWSxFW9wJyAGKd3G8qAhejp81EHcsbfTBInO4mdbI1Ug7PFrXxdALbaGy5Vxp0
         e8KZozKoXmJDg/sAc0v2hpPHE1afmCUsrUxucVa2eNXgZAn2hz6skrWrXNKn7H1522zr
         lMKrrTSDv83XgpKLHpkl0fZdugU3c1E1znnN53825hMLLW4VhvPRHCG+5EDrKuWblBGu
         N04HUgzdKDK2QFM5R42cYussJFBAPwh6qWD4MLgwdptmATBCYpyVDvYOVRrzTbw4hp9Q
         irPw==
X-Gm-Message-State: AOAM530am9nI1JzbHoO1CxdjKcRo0IsasNcu2SnCCeESX+rUkXGFVJ38
        4ZNbc6yPeFnJzXbaIS/yXwIoQjjYCWfdrg==
X-Google-Smtp-Source: ABdhPJyvTfM8py+CbhaCWXrIB5xLNhCeAVOTFAKVG3d2QKG2tuIq0C/YDqw6LAHWGiISg6YUY/im3Q==
X-Received: by 2002:a63:cf41:: with SMTP id b1mr2244847pgj.407.1632960166380;
        Wed, 29 Sep 2021 17:02:46 -0700 (PDT)
Received: from WRT-WX9.. ([158.247.226.116])
        by smtp.gmail.com with ESMTPSA id d24sm703170pgv.52.2021.09.29.17.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 17:02:46 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] irq: in_irq() cleanup
Date:   Thu, 30 Sep 2021 08:02:40 +0800
Message-Id: <20210930000240.5883-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the obsolete and ambiguos macro in_irq() with new
macro in_hardirq().

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 kernel/irq/irqdesc.c |  2 +-
 kernel/softirq.c     | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 4e3c29bb603c..3b236aa1c095 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -640,7 +640,7 @@ int handle_irq_desc(struct irq_desc *desc)
 		return -EINVAL;
 
 	data = irq_desc_get_irq_data(desc);
-	if (WARN_ON_ONCE(!in_irq() && handle_enforce_irqctx(data)))
+	if (WARN_ON_ONCE(!in_hardirq() && handle_enforce_irqctx(data)))
 		return -EPERM;
 
 	generic_handle_irq_desc(desc);
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 322b65d45676..9083f2da32ca 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -222,7 +222,7 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 	u32 pending;
 	int curcnt;
 
-	WARN_ON_ONCE(in_irq());
+	WARN_ON_ONCE(in_hardirq());
 	lockdep_assert_irqs_enabled();
 
 	local_irq_save(flags);
@@ -305,7 +305,7 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 {
 	unsigned long flags;
 
-	WARN_ON_ONCE(in_irq());
+	WARN_ON_ONCE(in_hardirq());
 
 	raw_local_irq_save(flags);
 	/*
@@ -352,14 +352,14 @@ static void __local_bh_enable(unsigned int cnt)
  */
 void _local_bh_enable(void)
 {
-	WARN_ON_ONCE(in_irq());
+	WARN_ON_ONCE(in_hardirq());
 	__local_bh_enable(SOFTIRQ_DISABLE_OFFSET);
 }
 EXPORT_SYMBOL(_local_bh_enable);
 
 void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 {
-	WARN_ON_ONCE(in_irq());
+	WARN_ON_ONCE(in_hardirq());
 	lockdep_assert_irqs_enabled();
 #ifdef CONFIG_TRACE_IRQFLAGS
 	local_irq_disable();
@@ -617,7 +617,7 @@ static inline void tick_irq_exit(void)
 
 	/* Make sure that timer wheel updates are propagated */
 	if ((idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
-		if (!in_irq())
+		if (!in_hardirq())
 			tick_nohz_irq_exit();
 	}
 #endif
-- 
2.32.0

