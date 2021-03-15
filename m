Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A9A33BF00
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241566AbhCOOwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239425AbhCOOgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:36:20 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD44C0613DB
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:04 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id n2so8294277wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=42VsnebBx6wd/dLld12y5OO2eqBs86RA5vT5YbLHhII=;
        b=ZLkYfjm0TXm1ycQgXusiruwe/qzqQv7drq5zuviqWh0MJ49BBdJLzCMYL8k+RqizaO
         felSNSPfOwwR8i7fkvRvH4HC7raWlb92gVEnl++0y9cWRocbAQVOOOcRYjLLVi91qmVC
         JbDKCnnGwlgjwle1NZdASDpI7ow3L0jtIFQCToUWMGT0tWP48BRBGY9e5I9sYEFKWHIf
         fGYBQMoqCVkfNuqCp5fnUwLNrerEb8cQ1AqKhDY2eqO9ZxiIXd+AcZWjfNV/qNGi4Ph1
         Z+hk5NHSQ9BlZDSAVEnwoKHYl6s3wlBucYOKhkj4D01+DSXsJBjQvwqmh/6NCzhiUvRj
         nDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=42VsnebBx6wd/dLld12y5OO2eqBs86RA5vT5YbLHhII=;
        b=LIga3rRrwIBQgMtBPxX9mqvT8M5W6K3Do1Cwj0UOlp8ev4bWyQFlqbYwRnkHPhpLnq
         pczaYn85wrXVo0pnjH6uqRULEnMcBxvdiI2FxOxXH8L4G5kF843kkVP8JEWXw4Y7zdej
         1PJ7xQbDU02WFXd2yXamksI82q7KRvjLxwQ1D8Q740ZMtFITw7mTMWHZ874jpk1TjRQ+
         2Wz65F5K5LsY5lg1+gMmvxxnRBbKu6esmqcoVf507KpNLWg70CKhdfQK9vk1I/Cv+Xnl
         8Ye3NjbYkh5fFQZdNwePbpmJYL9btxOjIJrZAAJwdsyBgP1T34vk/u/KHSlui3Dzm3hx
         R2FA==
X-Gm-Message-State: AOAM5321sSkkgwtVZJYc64JJ5AiOTPOLPkhWpn8Xtf/2n+/L3DXVhgEF
        Q0UXKn8fKqhSTkOZWOSbfPg4UdIe6fv9
X-Google-Smtp-Source: ABdhPJwxOO9bMvt/n8Ii/ALjBQmkLixKjjgqfBbs1ZB0IOc7PGzPOYN5ZKmmLjqMm5uOvJj8JP0r4i91tWDl
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a7b:c4c9:: with SMTP id
 g9mr31442wmk.82.1615818963391; Mon, 15 Mar 2021 07:36:03 -0700 (PDT)
Date:   Mon, 15 Mar 2021 14:35:11 +0000
In-Reply-To: <20210315143536.214621-1-qperret@google.com>
Message-Id: <20210315143536.214621-12-qperret@google.com>
Mime-Version: 1.0
References: <20210315143536.214621-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v5 11/36] KVM: arm64: Stub CONFIG_DEBUG_LIST at Hyp
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use the kernel list library at EL2, introduce stubs for the
CONFIG_DEBUG_LIST out-of-lines calls.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/Makefile |  2 +-
 arch/arm64/kvm/hyp/nvhe/stub.c   | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kvm/hyp/nvhe/stub.c

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 24ff99e2eac5..144da72ad510 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -13,7 +13,7 @@ lib-objs := clear_page.o copy_page.o memcpy.o memset.o
 lib-objs := $(addprefix ../../../lib/, $(lib-objs))
 
 obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
-	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o
+	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o stub.o
 obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o
 obj-y += $(lib-objs)
diff --git a/arch/arm64/kvm/hyp/nvhe/stub.c b/arch/arm64/kvm/hyp/nvhe/stub.c
new file mode 100644
index 000000000000..c0aa6bbfd79d
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/stub.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Stubs for out-of-line function calls caused by re-using kernel
+ * infrastructure at EL2.
+ *
+ * Copyright (C) 2020 - Google LLC
+ */
+
+#include <linux/list.h>
+
+#ifdef CONFIG_DEBUG_LIST
+bool __list_add_valid(struct list_head *new, struct list_head *prev,
+		      struct list_head *next)
+{
+		return true;
+}
+
+bool __list_del_entry_valid(struct list_head *entry)
+{
+		return true;
+}
+#endif
-- 
2.31.0.rc2.261.g7f71774620-goog

