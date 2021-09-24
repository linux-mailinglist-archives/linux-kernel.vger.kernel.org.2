Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4454175E4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346616AbhIXNeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346218AbhIXNeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:34:31 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7CFC08E9B0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:29:12 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id il14-20020a17090b164e00b0019c7a7c362dso7714912pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LuVRHSoDHvh0b+vTtC4laKIXlpYzxfgmhQy9f1AfUOI=;
        b=gGTSJviVEt/s+MrhWx9aPz9ihCm0qsO/fCFFtb4Khkk6fLbyLAoIOHD4JvmMPFTWuf
         5iyVK29+jf5B6N+wJa8rA5S/lfcbl4Qy05WJM9+TegpeBIK7QIPEFBCu1zSJhvwZAmi3
         UIkrPK6Y8AZp46sV+dj5AkHykzwE56KMaqeOm5c9Lv7JP7Q1NNPhzHqG9V+0fDHZbK8V
         OxJyrwtustC0XuXrLWT2loJUBqIxpcDRb2whj5nhqn/CP+pfUknkylRGAVnPrcKgkahM
         4wtLQOO+THDYm1FXKGYlJEsUgMRvJS1dqAzZIWKMls8QOcBQtmugjj8F2oKYHlKgvDDA
         cB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LuVRHSoDHvh0b+vTtC4laKIXlpYzxfgmhQy9f1AfUOI=;
        b=IM+Xtty/KtHxO8oErHIJADegRHDLTy1qWma6REJB7yZNi0S45M/dzM0Oz0nRA0a8dP
         1Y052+MJzPsnyOzz3uKrvundOmf9aeSAMp3UhzkKcc3DOJbc+Sq457hXWO+hJpapR4iJ
         HS+o1UWO5Mx5Et1UFYqstbZFFlHMk4pagXxwM0FvxqVNSINDUheUhm/hH7jAgJLH7s4R
         amphJPx6nrAu5O1XUF+1HxZsT44e2/uwQNw+1Xnp3RtHOP/yXGvVi9HQmO+hh8c4SSrL
         c8Gf3KioPsE41JTZMnGfLavC3eXXwRoRF89LnD7baxLF2Wdr1i5IC9ckT8RtBuqN0XI0
         1ppw==
X-Gm-Message-State: AOAM531qLrGxWZFsK8UxstEyUwHsfFNi2Oi/182GA3SY7w0M7eOIfu94
        U4vFauFfSJUZ3Af1KaaHcBz323onwg==
X-Google-Smtp-Source: ABdhPJzYIijoWtStXvdoV1AKicvCc+7W5u5sjvbscGWsbaGQ1V8Dhcisw6emmMky5QdKM+cXIBoX5Q==
X-Received: by 2002:a17:90b:11c9:: with SMTP id gv9mr2110466pjb.116.1632490151478;
        Fri, 24 Sep 2021 06:29:11 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 26sm11756573pgx.72.2021.09.24.06.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 06:29:11 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCHv2 3/5] kernel/irq: make irq_{enter,exit}() in handle_domain_irq() arch optional
Date:   Fri, 24 Sep 2021 21:28:35 +0800
Message-Id: <20210924132837.45994-4-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210924132837.45994-1-kernelfans@gmail.com>
References: <20210924132837.45994-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

handle_domain_irq() contains two major parts:
  -1. irq_enter()/irq_exit(), which serves as hooks for rcu and trace etc.
  -2. irq mapping and dispatching

After the introduction of irqentry_enter()/irqentry_exit() and arch
specific counterpart (e.g. arm64), roughly speaking, rcu_irq_enter() has
already been called.  Hence here comes requirement to move
irq_enter/irq_exit out of handle_domain_irq(). And arches should handle
about irq_enter_rcu()/irq_exit_rcu() by themself.

Since there is still arches, which does not adopt irqentry_enter(), let
irq_enter()/irq_exit() arch optional in handle_domain_irq().

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Yuichi Ito <ito-yuichi@fujitsu.com>
Cc: linux-arm-kernel@lists.infradead.org
To: linux-kernel@vger.kernel.org
---
 kernel/irq/Kconfig   | 3 +++
 kernel/irq/irqdesc.c | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index fbc54c2a7f23..defa1db2d664 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -100,6 +100,9 @@ config IRQ_MSI_IOMMU
 config HANDLE_DOMAIN_IRQ
 	bool
 
+config HAVE_ARCH_IRQENTRY
+	bool
+
 config IRQ_TIMINGS
 	bool
 
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 4e3c29bb603c..fd5dd9d278b5 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -693,7 +693,9 @@ int handle_domain_irq(struct irq_domain *domain,
 	struct irq_desc *desc;
 	int ret = 0;
 
+#ifndef CONFIG_HAVE_ARCH_IRQENTRY
 	irq_enter();
+#endif
 
 	/* The irqdomain code provides boundary checks */
 	desc = irq_resolve_mapping(domain, hwirq);
@@ -702,7 +704,9 @@ int handle_domain_irq(struct irq_domain *domain,
 	else
 		ret = -EINVAL;
 
+#ifndef CONFIG_HAVE_ARCH_IRQENTRY
 	irq_exit();
+#endif
 	set_irq_regs(old_regs);
 	return ret;
 }
-- 
2.31.1

