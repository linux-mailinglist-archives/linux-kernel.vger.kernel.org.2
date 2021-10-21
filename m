Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFE84357FE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 02:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhJUA5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 20:57:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231562AbhJUA5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 20:57:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B052610A1;
        Thu, 21 Oct 2021 00:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634777720;
        bh=WqIiiFEaJiQvJq7Z5CrnA44AmFZAiLP70n+lEDL0ZZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rrc3x0PQtBl+jJxPYLxvEJa1gL8qJeSOIT/WdB1F9unisTMJ0qRNBU2b0lX9nS0NU
         FMdlhk1okPOs7djg+IcG1swg8hbe+zY20W64wUNz3bkkFu6P2kClPR2iIBJcQMYQQh
         O9tUMHRRn9YUhqTrXje//6rJZ+pGOfWkhHJZnh8k4puutQU12a7/dcrg7coDrchI6p
         hjS9GdYF3Ukaxn33B2uZLxJ/7o2xOG8ofx6ucqGEqtqDeVoZ7TVSNQrCV/6kwphEFI
         KpoWCmTVn4AYTPTjrZreELbMUWAfbdrMqcbpzo638QzVxMLCMsXwntoC+I31dxWzCv
         c7TP1t4aXZu2A==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 7/9] ARM: clang: Do not rely on lr register for stacktrace
Date:   Thu, 21 Oct 2021 09:55:17 +0900
Message-Id: <163477771763.264901.13199943018441108332.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163477765570.264901.3851692300287671122.stgit@devnote2>
References: <163477765570.264901.3851692300287671122.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the stacktrace on clang compiled arm kernel uses the 'lr'
register to find the first frame address from pt_regs. However, that
is wrong after calling another function, because the 'lr' register
is used by 'bl' instruction and never be recovered.

As same as gcc arm kernel, directly use the frame pointer (r11) of
the pt_regs to find the first frame address.

Note that this fixes kretprobe stacktrace issue only with
CONFIG_UNWINDER_FRAME_POINTER=y. For the CONFIG_UNWINDER_ARM,
we need another fix.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Changes in v2:
  - Fix typos in changelog.
---
 arch/arm/kernel/stacktrace.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index 76ea4178a55c..db798eac7431 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -54,8 +54,7 @@ int notrace unwind_frame(struct stackframe *frame)
 
 	frame->sp = frame->fp;
 	frame->fp = *(unsigned long *)(fp);
-	frame->pc = frame->lr;
-	frame->lr = *(unsigned long *)(fp + 4);
+	frame->pc = *(unsigned long *)(fp + 4);
 #else
 	/* check current frame pointer is within bounds */
 	if (fp < low + 12 || fp > high - 4)

