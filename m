Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15FDB34194D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhCSKCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhCSKCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:02:14 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AA8C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:14 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id b21so28895037qtr.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=42VsnebBx6wd/dLld12y5OO2eqBs86RA5vT5YbLHhII=;
        b=dpjDBn6OQpH5nXPKZsRJwReQXwbupeBLtYsMpd576nHxHjvnVc9vqmVeYVqLuoneaK
         2/gC7yD7I/DtFOk15LofKF36Dw24Wv6Sv8dC52KQRYF1DluXut/IFYKkV108Ni5SSv+h
         BAgmE0xLosT42H7aMLk+Rm+1LHDumfxog8gA7y5gWlN03GqE5TOZ2qFMFfz25+hy+st3
         iOzPFZ2VmH2IhadveRw5E5FJi8M+fyQ5mb46COqCD7HHx6+pZVmAtnrdXzyD88leRm5f
         cegleOOJQIjNH3rHYuIjh1XtNE9mCawnKwxERwDK7stiTysr5C9UpfJ63Peg7UUGKxAV
         z5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=42VsnebBx6wd/dLld12y5OO2eqBs86RA5vT5YbLHhII=;
        b=U3/yAsQFatgAUnbb1Q24Hv/ClzfSn7HT6RKjFyPxHRF8/qOyKhJcfIBSNZC+A4wFNC
         yqcCG4yVrKisOBmPUI6nl5ot8NJF6KXEQz9Avorz9Im3DMWzBHST/Jm/A0Wyijs8wGNr
         GSw9NTyGZ//313B40TzrWYx9RYYEfxPAPljvjDRPQSsv44argUK1RQ0p778M/B4hG0xo
         cuZvL+J6vHmXZKhkSE3Gn+ftSLX4HMapMuVwFhp8SN6ahfjUJylPCktrR1z1QngUWCGm
         PszgoST8qUYpPie8+HfyxcbsZPFmbsBf//kCMunYGaz+UQph2D2B3hHoUgT8OUhuoLac
         HBDg==
X-Gm-Message-State: AOAM5317UHrSrqYdZEazqfEfRu1FtokPXYZrFWK3I06Fv3aWukwaYNpJ
        Jv37uUiBh78JxoOgsjA1PH12AQV2bTV/
X-Google-Smtp-Source: ABdhPJy40vcJgyO4z2WwwLPNXTxcJo3PmnLkzvLiVsroYLI2jeLnpRpxAFfdfa6RyPy0NgQ4uvhb7terjePA
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:eb87:: with SMTP id
 x7mr8762653qvo.14.1616148133288; Fri, 19 Mar 2021 03:02:13 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:19 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-12-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 11/38] KVM: arm64: Stub CONFIG_DEBUG_LIST at Hyp
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

