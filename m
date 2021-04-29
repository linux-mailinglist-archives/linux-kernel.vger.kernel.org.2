Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286CB36F039
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 21:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhD2TRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 15:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238507AbhD2TIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 15:08:40 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64699C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 12:07:53 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id v2-20020a7bcb420000b0290146b609814dso228430wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 12:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=a+M03Ojo2ep3ZRi34mKtUekE+PIXB83y3AJCXMraWzo=;
        b=dF9WJLioSQrbRuzCoNwwUPt/Vr8RLQvQyQyo0LOsjAWYk3FM7a+nBqYqettaUNAlHa
         LiiTz1VGyiB+mykTMwMpeky8vvhoXMMUkWzQhh9qLmw34bugTcqySao7tleast8c469n
         mKLzci3S4T7bmY+tjxRBZkJVvu3H0vxlySV1fPvpHl/g+2NuEs0zv5XxBIkqwaLWX5Xf
         tE/a6xOOsLQ7ukUvb0tNay98YLQrFMVfm8vBxxuj+gkBPTue2rY2GErFnLTLjYr0C6pP
         h40iwUYuB60pwe4+YNd7YDP/yNBBflO0HATK8xylCNstpMKY4Vaw9pnIRfR9tjWRti+M
         gtdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=a+M03Ojo2ep3ZRi34mKtUekE+PIXB83y3AJCXMraWzo=;
        b=clskHIAsP4Wtih4cWDQknd5vcZcb4Kt6zcBVQkCkDJjnehkKi88sAhopcfFdw5jHko
         tJNVdFXdbJBBIRQ6S9sDJNBG5hXfLQ6wTN+cnqB85kQb16Q41k3u9G+eKt18ClKfnIxh
         AeCnAYIJpJpiaq5i3on9lhcIAnXzk8ZREr0/QLFVKHI2Fc89pgUXeOqcylpuwYY67yNL
         /D/jWKBLUXU2U/7nKga455uSrpR7oZQGDjbVbcNfIPWR5oIu29BcPi9B2XHT4VUVW5PK
         YEg/tubi8g1gvIKGNFI5KiEWiVkG0dfJzZAfNa/bz/Dm1LCDKjQH5ex5HKZL3+2nbCZ1
         yWIQ==
X-Gm-Message-State: AOAM5334VabLP5I4dsy+XhTe9mJY2lb3VeTQhdaGVggX4tb8aEv8/yn9
        BtyaUDupFBGuYYLxEgXxirU0hVvZrg==
X-Google-Smtp-Source: ABdhPJzlg1wh/uLXKKhwRP5BcTAKO6bbMsP7iOQaaVlBytkU4SUateXusjlaHr17ej3J+IyJeoI9N2H4hA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:4399:f8b0:aefa:628])
 (user=elver job=sendgmr) by 2002:a1c:c915:: with SMTP id f21mr1249320wmb.0.1619723271698;
 Thu, 29 Apr 2021 12:07:51 -0700 (PDT)
Date:   Thu, 29 Apr 2021 21:07:32 +0200
Message-Id: <20210429190734.624918-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH 1/3] sparc64: Add compile-time asserts for siginfo_t offsets
From:   Marco Elver <elver@google.com>
To:     elver@google.com, ebiederm@xmission.com
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        davem@davemloft.net, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To help catch ABI breaks at compile-time, add compile-time assertions to
verify the siginfo_t layout. Unlike other architectures, sparc64 is
special, because it is one of few architectures requiring si_trapno.
ABI breaks around that field would only be caught here.

Link: https://lkml.kernel.org/r/m11rat9f85.fsf@fess.ebiederm.org
Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 arch/sparc/kernel/signal32.c  | 34 ++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/signal_64.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index e9695a06492f..778ed5c26d4a 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -745,3 +745,37 @@ asmlinkage int do_sys32_sigstack(u32 u_ssptr, u32 u_ossptr, unsigned long sp)
 out:
 	return ret;
 }
+
+/*
+ * Compile-time assertions for siginfo_t offsets. Check NSIG* as well, as
+ * changes likely come with new fields that should be added below.
+ */
+static_assert(NSIGILL	== 11);
+static_assert(NSIGFPE	== 15);
+static_assert(NSIGSEGV	== 9);
+static_assert(NSIGBUS	== 5);
+static_assert(NSIGTRAP	== 6);
+static_assert(NSIGCHLD	== 6);
+static_assert(NSIGSYS	== 2);
+static_assert(offsetof(compat_siginfo_t, si_signo)	== 0x00);
+static_assert(offsetof(compat_siginfo_t, si_errno)	== 0x04);
+static_assert(offsetof(compat_siginfo_t, si_code)	== 0x08);
+static_assert(offsetof(compat_siginfo_t, si_pid)	== 0x0c);
+static_assert(offsetof(compat_siginfo_t, si_uid)	== 0x10);
+static_assert(offsetof(compat_siginfo_t, si_tid)	== 0x0c);
+static_assert(offsetof(compat_siginfo_t, si_overrun)	== 0x10);
+static_assert(offsetof(compat_siginfo_t, si_status)	== 0x14);
+static_assert(offsetof(compat_siginfo_t, si_utime)	== 0x18);
+static_assert(offsetof(compat_siginfo_t, si_stime)	== 0x1c);
+static_assert(offsetof(compat_siginfo_t, si_value)	== 0x14);
+static_assert(offsetof(compat_siginfo_t, si_int)	== 0x14);
+static_assert(offsetof(compat_siginfo_t, si_ptr)	== 0x14);
+static_assert(offsetof(compat_siginfo_t, si_addr)	== 0x0c);
+static_assert(offsetof(compat_siginfo_t, si_trapno)	== 0x10);
+static_assert(offsetof(compat_siginfo_t, si_addr_lsb)	== 0x14);
+static_assert(offsetof(compat_siginfo_t, si_lower)	== 0x18);
+static_assert(offsetof(compat_siginfo_t, si_upper)	== 0x1c);
+static_assert(offsetof(compat_siginfo_t, si_pkey)	== 0x18);
+static_assert(offsetof(compat_siginfo_t, si_perf)	== 0x14);
+static_assert(offsetof(compat_siginfo_t, si_band)	== 0x0c);
+static_assert(offsetof(compat_siginfo_t, si_fd)		== 0x10);
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index a0eec62c825d..c9bbf5f29078 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -556,3 +556,36 @@ void do_notify_resume(struct pt_regs *regs, unsigned long orig_i0, unsigned long
 	user_enter();
 }
 
+/*
+ * Compile-time assertions for siginfo_t offsets. Check NSIG* as well, as
+ * changes likely come with new fields that should be added below.
+ */
+static_assert(NSIGILL	== 11);
+static_assert(NSIGFPE	== 15);
+static_assert(NSIGSEGV	== 9);
+static_assert(NSIGBUS	== 5);
+static_assert(NSIGTRAP	== 6);
+static_assert(NSIGCHLD	== 6);
+static_assert(NSIGSYS	== 2);
+static_assert(offsetof(siginfo_t, si_signo)	== 0x00);
+static_assert(offsetof(siginfo_t, si_errno)	== 0x04);
+static_assert(offsetof(siginfo_t, si_code)	== 0x08);
+static_assert(offsetof(siginfo_t, si_pid)	== 0x10);
+static_assert(offsetof(siginfo_t, si_uid)	== 0x14);
+static_assert(offsetof(siginfo_t, si_tid)	== 0x10);
+static_assert(offsetof(siginfo_t, si_overrun)	== 0x14);
+static_assert(offsetof(siginfo_t, si_status)	== 0x18);
+static_assert(offsetof(siginfo_t, si_utime)	== 0x20);
+static_assert(offsetof(siginfo_t, si_stime)	== 0x28);
+static_assert(offsetof(siginfo_t, si_value)	== 0x18);
+static_assert(offsetof(siginfo_t, si_int)	== 0x18);
+static_assert(offsetof(siginfo_t, si_ptr)	== 0x18);
+static_assert(offsetof(siginfo_t, si_addr)	== 0x10);
+static_assert(offsetof(siginfo_t, si_trapno)	== 0x18);
+static_assert(offsetof(siginfo_t, si_addr_lsb)	== 0x20);
+static_assert(offsetof(siginfo_t, si_lower)	== 0x28);
+static_assert(offsetof(siginfo_t, si_upper)	== 0x30);
+static_assert(offsetof(siginfo_t, si_pkey)	== 0x28);
+static_assert(offsetof(siginfo_t, si_perf)	== 0x20);
+static_assert(offsetof(siginfo_t, si_band)	== 0x10);
+static_assert(offsetof(siginfo_t, si_fd)	== 0x14);
-- 
2.31.1.527.g47e6f16901-goog

