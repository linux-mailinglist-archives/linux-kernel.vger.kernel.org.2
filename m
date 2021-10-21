Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B4E436349
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 15:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhJUNsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 09:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbhJUNsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 09:48:01 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B11C0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 06:45:45 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ls18so542123pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 06:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QDxUA5M+5Tc9pgMaEnmtMzJohvZssOB/8meny4PzmyY=;
        b=FIUQGFZ7VcUHQw/Lbr3XDxLdHWunjI79HlNGqEknHtJaH3F/YRy6LUuGzshoBeXDYr
         MZlbyyYmOFBMUpa6fAEa+ahnfh1ILUpy0O2mHlcbfdbBLpbQZjDU85f0ecq/OVTqNFpo
         18auKJ2PqREqW0jRZ0e9PU0KxPS4QbGaLpDy60P5CZmPgMgI1h3zVgkzB24Yr4EXITPW
         ngdail0s4XsavPsVm2VlUP3T2DModYPjhY7eKoXJzRQF8Owjo/EOl2dqmyLm+cDUvCwd
         UjHACR1cuXhbezr2fIn87GzGepfNOhcb5Iw3rxpTvAJDxB65AIgLhK7HiWIFcwtslPLI
         VuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QDxUA5M+5Tc9pgMaEnmtMzJohvZssOB/8meny4PzmyY=;
        b=ySbKFWGPkEdURAzlKX1aVbYh0RJkiR1NXUUPSR/336IGlaDLHrRis/f1GXzFsDShGv
         xcO/7R3qNcrERYotT2ous89T1Wn89wRwOOxqBQk7JGaBjty9U6n9pIfmBnkkWxWNFChI
         1wdJLhLAS5Y2MXbnV5944L6vOTjr6AvV4ZAWnrnBwB63g1ymMV76FO6CK+TlHkRynrul
         DNp8yW9dSo7WTwM2hEpweD6culWoWyGZostidUlc8FjzRFDXpEVrgL5VUSaMMl3F4/wP
         ThyU9k+13xZrwdRhusn3L5pBAh45kJjPp3OUU5BK3SW1bNg/he/9ycaIo8Aw+6l84jQP
         IeAw==
X-Gm-Message-State: AOAM53173RgFDehshfafydGB41JxMyJpXVjWJq1YX7bf0JkrQowhiK6C
        2cN/DJkDRcliHbuI2FVlJFDlPw==
X-Google-Smtp-Source: ABdhPJyRF8CtK/W4CjNGZjAYfQW6WxJaeE1/vureHfym+WBfENBF4Q2Cej51bPyc1R3TWXC/9XwKhQ==
X-Received: by 2002:a17:902:7001:b0:13d:d5b7:d06e with SMTP id y1-20020a170902700100b0013dd5b7d06emr5272202plk.61.1634823945071;
        Thu, 21 Oct 2021 06:45:45 -0700 (PDT)
Received: from localhost ([103.127.241.129])
        by smtp.gmail.com with ESMTPSA id b19sm5480396pgs.33.2021.10.21.06.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 06:45:44 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [RFCv1 1/4] arm64: Use static key for tracing PID in CONTEXTIDR
Date:   Thu, 21 Oct 2021 21:45:27 +0800
Message-Id: <20211021134530.206216-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211021134530.206216-1-leo.yan@linaro.org>
References: <20211021134530.206216-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel provides CONFIG_PID_IN_CONTEXTIDR for tracing PID into system
register CONTEXTIDR; we need to statically enable this configuration
when build kernel image to use this feature.

On the other hand, hardware tracing modules (e.g. Arm CoreSight, SPE,
etc) rely on this feature to provide context info in their tracing data.
If kernel has not enabled configuration CONFIG_PID_IN_CONTEXTIDR, then
tracing modules have no chance to capture PID related info.

This patch introduces static key for tracing PID in CONTEXTIDR, it
provides a possibility for device driver to dynamically enable and
disable tracing PID into CONTEXTIDR as needed.

As the first step, the kernel increases the static key if
CONFIG_PID_IN_CONTEXTIDR is enabled when booting kernel, in this case
kernel will always trace PID into CONTEXTIDR at the runtime.  This means
before and after applying this patch, the semantics for
CONFIG_PID_IN_CONTEXTIDR are consistent.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/include/asm/mmu_context.h |  4 +++-
 arch/arm64/kernel/process.c          | 11 +++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index f4ba93d4ffeb..e1f33616f83a 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -26,9 +26,11 @@
 
 extern bool rodata_full;
 
+DECLARE_STATIC_KEY_FALSE(contextidr_in_use);
+
 static inline void contextidr_thread_switch(struct task_struct *next)
 {
-	if (!IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR))
+	if (!static_branch_unlikely(&contextidr_in_use))
 		return;
 
 	write_sysreg(task_pid_nr(next), contextidr_el1);
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 40adb8cdbf5a..d744c0c7e4c4 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -61,6 +61,9 @@ unsigned long __stack_chk_guard __ro_after_init;
 EXPORT_SYMBOL(__stack_chk_guard);
 #endif
 
+DEFINE_STATIC_KEY_FALSE(contextidr_in_use);
+EXPORT_SYMBOL_GPL(contextidr_in_use);
+
 /*
  * Function pointers to optional machine specific functions
  */
@@ -721,3 +724,11 @@ int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
 	return prot;
 }
 #endif
+
+static int __init contextidr_init(void)
+{
+	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR))
+		static_branch_inc(&contextidr_in_use);
+	return 0;
+}
+early_initcall(contextidr_init);
-- 
2.25.1

