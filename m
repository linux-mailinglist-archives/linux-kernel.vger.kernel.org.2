Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A0132A80B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238133AbhCBRAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 12:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384502AbhCBPFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:05:19 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EAAC061D7F
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:00:32 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id g5so11176641wrd.22
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=twje/T88dKdujyu/Ipi7uGGbAfwKvVyGbqSSEkcY7iA=;
        b=h3Auuv0gx9w0uL2JejVSJYcj+FN0Xhi6lI9t1VRPl88R9mO9oGEu3dwGf1lxzcNigU
         pb7GHhkBl5+LSyCDcns3NnUnbBEzGjihkEgB3NuB1WUfpkovjjgoD1wLlCyaw7a2FAzM
         29nnxhE3yIYM9mfy3/brP5+xqxG78O0uvZzH9spB/5Xaqhy0K9l6oIN3dAkt8HS9unYe
         cJSuE1ohG6VZw+l7HWUPmoEy3/b1EPuCPG4Lon8j/wC/fVSMwrEdkqkEVg5Mcc/wWAU0
         Q9ZGG7OBUqJ+sWmtLWqyWoMOkrOIwWF+xvd311ON5vNOd3iU6HnxXKcyf3xcKnxcGhGr
         s9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=twje/T88dKdujyu/Ipi7uGGbAfwKvVyGbqSSEkcY7iA=;
        b=BZTmLpR0w5CXJ4poUj2IxjoUQ9vLXiD4+ohv2+kdUOFyCknBGXwUKURczd5t0hDXG9
         TjhDA12BaOMuXADwDPmJlxnPnI7v5IGDKIapTOJmyMsoFZ307du8jqwgVR/ObictyK6R
         wObvTWSl9o7tcfHudS2lMvnTmE2TsgorxSNSQcb95s6YD+kfCjmMGyGvaOvc64jNXyov
         hn4kr9cuZwYLF+npS99Vfy8lVwg9tuHwQvhLZe6IlGTie/zW1H7MUH4pUuxTlJqJXes1
         tMrgqXDZRTUcBWcXoIIZ57KvZnTAE7pKtExVfX59BtpJavx51oNq8aMFH5avKcF98kF6
         NFgg==
X-Gm-Message-State: AOAM531n92N8/+QqV0cjj+HHI5DVpIcunsBs1mwVSvFlBpS3pwS5fjJn
        q8LmH+nsecj6L1y/q+8eacpGHTgWjpaE
X-Google-Smtp-Source: ABdhPJwQwv/y/Y1CqtU5mX7QFPielulT4k9vdUFWl45cr8FFafLXMgEO9ymMubzKsO1L14g5Q1NqlrmfyD6Z
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:de05:: with SMTP id
 v5mr744456wmg.25.1614697231398; Tue, 02 Mar 2021 07:00:31 -0800 (PST)
Date:   Tue,  2 Mar 2021 14:59:41 +0000
In-Reply-To: <20210302150002.3685113-1-qperret@google.com>
Message-Id: <20210302150002.3685113-12-qperret@google.com>
Mime-Version: 1.0
References: <20210302150002.3685113-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 11/32] KVM: arm64: Stub CONFIG_DEBUG_LIST at Hyp
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use the kernel list library at EL2, introduce stubs for the
CONFIG_DEBUG_LIST out-of-lines calls.

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
2.30.1.766.gb4fecdf3b7-goog

