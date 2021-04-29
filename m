Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CC236F03E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 21:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhD2TRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 15:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238545AbhD2TIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 15:08:45 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CD7C06138C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 12:07:58 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id s10-20020a05620a030ab02902e061a1661fso28692110qkm.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 12:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oJ+no8MxPlbWvHNFDInBiefJ29F4R5wPVNRQJ5Temnc=;
        b=IVeFbxHDXug434UKphPgczOKwvBRYS+qQ3fyCutaafHrNWOhDI3D5G1ZPU8weSCrVC
         ABDK1RhMbqsnhiEEFS3k5cbzHTCjpGoeVgufqnrRZYRCIRVtVfM3chH2F4fiRTBIPfzI
         G6BzqDLSVSo2axo2BBYhHeCzzt56m7iBIXYbKmgSDW5JitqNoKVE4JEQOP5PODUS0OvR
         WG38zAx2LelmrKLC/gyGPqP3Hbx2rP9I3UEgYSa7M+ssrXqXDEMu13GJBz9No/dPV6Fu
         G44EDYlVZ1+BMoZeTtmv/KLMMe9DzNEs4vpFMC6NyEaj/xd6o0WU9sf2wf+Ik1e490hS
         PCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oJ+no8MxPlbWvHNFDInBiefJ29F4R5wPVNRQJ5Temnc=;
        b=TB2G44hSLCRbcb0SN10sNTTKGbTPfz//GeKCexyA5yp6SYEYX8KYUgAUBIORL5Kw11
         ump8EcnuWnQLG6AEn+qWcqrIUmzRRYMQWVOneKvVTxREW2g/aG4jhIpV+9pdrahjUt8V
         kHpOJUHNAF2k/n3ZvEe/QzKcCB5YqQQiE0zADbjsUTsJ5GZf72ULUPyirRPbyTa33QV1
         +HkuP8McfwupOmc0buZ5Uz5KR6WbV6lId34bV9MjjQceJtCAhfxUv9SoxZxBN8p/aJok
         IPrLFAjPwn9timDUR9Q+btXh307bsv22DVq3hYUltRns/9DzRQHLYa1nL/VartEaitXG
         jAlg==
X-Gm-Message-State: AOAM532rT1VwNzqTTdWiOyzmBA06vu+NYT92oMeHLtBqF2gOm6hy6NkZ
        HRmLsHrK+J8QmUSCo+AeR9jc1q2MAQ==
X-Google-Smtp-Source: ABdhPJxGZ1gI1KYcCkyLOWFD7/FydYwghLH2n8i8xsMDPoyRpEKqciCBIAxyuvsP3DQKuWqOzQ1+/M10Cw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:4399:f8b0:aefa:628])
 (user=elver job=sendgmr) by 2002:a0c:be92:: with SMTP id n18mr1138333qvi.31.1619723277227;
 Thu, 29 Apr 2021 12:07:57 -0700 (PDT)
Date:   Thu, 29 Apr 2021 21:07:34 +0200
In-Reply-To: <20210429190734.624918-1-elver@google.com>
Message-Id: <20210429190734.624918-3-elver@google.com>
Mime-Version: 1.0
References: <20210429190734.624918-1-elver@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH 3/3] arm64: Add compile-time asserts for siginfo_t offsets
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
verify the siginfo_t layout.

Signed-off-by: Marco Elver <elver@google.com>
---
 arch/arm64/kernel/signal.c   | 36 ++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/signal32.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 6237486ff6bb..af8bd2af1298 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -973,3 +973,39 @@ void __init minsigstksz_setup(void)
 		round_up(sizeof(struct frame_record), 16) +
 		16; /* max alignment padding */
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
+static_assert(offsetof(siginfo_t, si_addr_lsb)	== 0x18);
+static_assert(offsetof(siginfo_t, si_lower)	== 0x20);
+static_assert(offsetof(siginfo_t, si_upper)	== 0x28);
+static_assert(offsetof(siginfo_t, si_pkey)	== 0x20);
+static_assert(offsetof(siginfo_t, si_perf)	== 0x18);
+static_assert(offsetof(siginfo_t, si_band)	== 0x10);
+static_assert(offsetof(siginfo_t, si_fd)	== 0x18);
+static_assert(offsetof(siginfo_t, si_call_addr)	== 0x10);
+static_assert(offsetof(siginfo_t, si_syscall)	== 0x18);
+static_assert(offsetof(siginfo_t, si_arch)	== 0x1c);
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 2f507f565c48..b6afb646515f 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -457,3 +457,39 @@ void compat_setup_restart_syscall(struct pt_regs *regs)
 {
        regs->regs[7] = __NR_compat_restart_syscall;
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
+static_assert(offsetof(compat_siginfo_t, si_addr_lsb)	== 0x10);
+static_assert(offsetof(compat_siginfo_t, si_lower)	== 0x14);
+static_assert(offsetof(compat_siginfo_t, si_upper)	== 0x18);
+static_assert(offsetof(compat_siginfo_t, si_pkey)	== 0x14);
+static_assert(offsetof(compat_siginfo_t, si_perf)	== 0x10);
+static_assert(offsetof(compat_siginfo_t, si_band)	== 0x0c);
+static_assert(offsetof(compat_siginfo_t, si_fd)		== 0x10);
+static_assert(offsetof(compat_siginfo_t, si_call_addr)	== 0x0c);
+static_assert(offsetof(compat_siginfo_t, si_syscall)	== 0x10);
+static_assert(offsetof(compat_siginfo_t, si_arch)	== 0x14);
-- 
2.31.1.527.g47e6f16901-goog

