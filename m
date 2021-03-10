Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAEE334613
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 19:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbhCJR6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbhCJR6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:58:18 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDCCC061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:18 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id c1so13424492qke.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=twje/T88dKdujyu/Ipi7uGGbAfwKvVyGbqSSEkcY7iA=;
        b=LQ0ZVrzLKNdU5CFZ/uHgdFHY9JJtbPriswTjvCuNFFdqNAFUOVuVsL11DRafoQlXRs
         +qA6mOO/XIpZhsDrX4ERKUL831GIYfsbE+YhI/HZL9z2EJgXSh57xNEXRp06rvAklb4F
         MZgzc6XLsTevrg2CaMb1FFTglqx9ngsFCS7aGzbYfmG/3tMbDI7yw9Bz9V9sE4k9t6H9
         9ISno341dtYOyZomYdAIDZVzCfzWji7BZQYuO9WuddDxANZaqnLlb6SP9sEdd+81N0E5
         DEiVR5nkt8P07Yw9f/2m/XFboo6ihfT8aJqnIv+81HN+EqmqZGtbe1vRqIAWUTogBnRV
         0mMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=twje/T88dKdujyu/Ipi7uGGbAfwKvVyGbqSSEkcY7iA=;
        b=JJH/vcFbWEBUGPpjwiVcqlYCh5iZEEDq5rWUNY5PW+NtcE18QfmQtCqC5x/5yvCWz9
         uY+dv3FxclP+sPxVIebzRaYNlV0MlWHG4GY3ynltrlOQDVA0Z1amGQfe8rRsA2RRXI+z
         g0aWfR6GZHW0b+nkkUnbNamvAQJ0GxN0UsgMLpmH79atQG2czeoV5M88cO4uYLSeKijX
         Tk0gFtTvBplaIa8g0ydy+Qv3idc5GMoE2IDPRvr8bziuNy/US3xt4pbOUGPNs6fCFsUc
         +mtH8PtWvo7/0efTVKl7LKMaokQutwvRpQU/g4x7JTzM0xblw+Wz0DtNTmUdpycjFfTy
         aRmg==
X-Gm-Message-State: AOAM531pBhqqqorxVg7EbtxsbU6cZGLD4jk5U9P6/HV5rn7O7teCp9I9
        dn7wTZHR62fLbPLWca80U6Voga/wjRFS
X-Google-Smtp-Source: ABdhPJzpVCtmRY3IUgz5C3HD74m5dt+Xopm/y+FY/xkaDnXqHj0IY+JJ6z8YgmzfYvx8drfccRDDpQ7iF9lF
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:6214:1484:: with SMTP id
 bn4mr4267365qvb.8.1615399097698; Wed, 10 Mar 2021 09:58:17 -0800 (PST)
Date:   Wed, 10 Mar 2021 17:57:28 +0000
In-Reply-To: <20210310175751.3320106-1-qperret@google.com>
Message-Id: <20210310175751.3320106-12-qperret@google.com>
Mime-Version: 1.0
References: <20210310175751.3320106-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v4 11/34] KVM: arm64: Stub CONFIG_DEBUG_LIST at Hyp
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org,
        ardb@kernel.org
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

