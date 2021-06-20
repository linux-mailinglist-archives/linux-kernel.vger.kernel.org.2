Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A103ADE41
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 14:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhFTMDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 08:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhFTMDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 08:03:25 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43BDC061756
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 05:01:09 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id f10so4902150plg.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 05:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6RZ0t+nLN/zgwczUvk1xBr9Y/vtc658j2K3feiC0sNo=;
        b=tvDau5NQHMgBjXtOi7u5ORM6VPuv3odxHKJVjJrovv+8UHr8iEWC3eynFLeG3eMACG
         YThJzEn5kf2v4OqYYn6pWDFqh7HRqFMRqI/465tgrgk6GHaBh4ui0NhMaUfzO8hlAXGx
         9fNwsPC9MhMKKs/R4nAk8nDAR99TARH39Kx9ZJyoeO+BoSUVBsoHzRRsKiLrE5jzznM0
         Ud2XqNdMok1U9czZknWSXU9xVCfkCDWjbmlRS6ouIb/lm9CAv2BEGclVpFe8ni8mXvLt
         EipLBxOkfb9bCKm0UbcGCl1TDg1JVQoSAldRcPfO0aAP5vqBzz5ApIaDlMG5713K8xTg
         Rwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6RZ0t+nLN/zgwczUvk1xBr9Y/vtc658j2K3feiC0sNo=;
        b=cJQTt6vzp4PwMnJOLV+a9099YmEG8wbKF2fK32D8J88+HyHOo/JQXUNbWq2N4WLL5U
         uoX9gOqZQvqeAZmjU0fxI0eUHp2Vxx9VELlf1gZGUQBv9e5p2DPLiBI+BJftUajA7Yu6
         FW0Pglf3IMQaXhCW6D6sp8x7c4VCzbK20YVYUI7jGIwDN8vWTeyr1AOfaCwPCPK2GlRe
         L8X0x2LglLJrkQsQUN+/EDGYxcpDhltvNBxGbWg4HnOdyoWA+k8Jwyq5sUWg/H4sIgk2
         CduIcJigsc04+RkTpCBgai50rt3Gh8tIwsHuw/PTIKLKF4jQkTD2jWt/rGjhkYrJ5kHi
         6Pdw==
X-Gm-Message-State: AOAM531cPJtkSarWHmux5Jg8szl2xz4TJ78TD/zIBQ73vUIqzPyJ9lYd
        0vXi15aWb7O05SKgDIceL2w=
X-Google-Smtp-Source: ABdhPJwruwTRhScqZpEyG4BVAu40s7oKqSw2bbKGu2EIdq8sgtyU+3LoY1ROsiZ+/4RM9EZGZo+hXg==
X-Received: by 2002:a17:90b:4b49:: with SMTP id mi9mr20849030pjb.187.1624190469012;
        Sun, 20 Jun 2021 05:01:09 -0700 (PDT)
Received: from localhost.localdomain.localdomain (n058152081086.netvigator.com. [58.152.81.86])
        by smtp.gmail.com with ESMTPSA id z18sm9899893pfq.196.2021.06.20.05.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 05:01:08 -0700 (PDT)
From:   Jeff Xie <chongguiguzi@gmail.com>
X-Google-Original-From: Jeff Xie <huan.xie@suse.com>
To:     oleg@redhat.com
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        caou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, chongguiguzi@gmail.com,
        huan.xie@suse.com
Subject: [PATCH] riscv: ptrace: add argn syntax
Date:   Sun, 20 Jun 2021 20:01:51 +0800
Message-Id: <20210620120151.17860-1-huan.xie@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables ftrace kprobe events to access kernel function
arguments via $argN syntax.

Signed-off-by: Jeff Xie <huan.xie@suse.com>
---
 arch/riscv/Kconfig              |  1 +
 arch/riscv/include/asm/ptrace.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 18ec0f9bb8d5..f9246a7d0a31 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -88,6 +88,7 @@ config RISCV
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select IRQ_DOMAIN
diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
index 09ad4e923510..fdb59ee405ee 100644
--- a/arch/riscv/include/asm/ptrace.h
+++ b/arch/riscv/include/asm/ptrace.h
@@ -141,6 +141,37 @@ static inline unsigned long regs_get_register(struct pt_regs *regs,
 
 	return *(unsigned long *)((unsigned long)regs + offset);
 }
+
+/**
+ * regs_get_kernel_argument() - get Nth function argument in kernel
+ * @regs:       pt_regs of that context
+ * @n:          function argument number (start from 0)
+ *
+ * regs_get_argument() returns @n th argument of the function call.
+ *
+ * Note you can get the parameter correctly if the function has no
+ * more than eight arguments.
+ */
+static inline unsigned long regs_get_kernel_argument(struct pt_regs *regs,
+						unsigned int n)
+{
+#define NR_REG_ARGUMENTS 8
+	static const unsigned int argument_offs[] = {
+		offsetof(struct pt_regs, a0),
+		offsetof(struct pt_regs, a1),
+		offsetof(struct pt_regs, a2),
+		offsetof(struct pt_regs, a3),
+		offsetof(struct pt_regs, a4),
+		offsetof(struct pt_regs, a5),
+		offsetof(struct pt_regs, a6),
+		offsetof(struct pt_regs, a7),
+	};
+
+	if (n < NR_REG_ARGUMENTS)
+		return regs_get_register(regs, argument_offs[n]);
+	return 0;
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PTRACE_H */
-- 
2.26.2

