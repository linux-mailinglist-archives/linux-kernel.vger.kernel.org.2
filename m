Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25AA7426AD2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 14:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241763AbhJHMbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 08:31:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241522AbhJHMbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 08:31:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE29E60F93;
        Fri,  8 Oct 2021 12:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633696151;
        bh=QKDaU+Bp0qe2hOMqt+T1oJ7ehYCtLzgPK3h7HWfGmKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cRQXhhicySut1yYoU+V16S/G69Bci/b3Sv4UVkXVYS4S+zs4kNOgh5k0j+WshKv85
         q59YLPpmQQYdkyv4OdX99cmU3XyvViNZKlli9zsVSMXivjQWeEUAt4z1VU1KioFaZ/
         FyxoyCsrfG5x8MscF7fqN+JfgabxHUJjCdH7UgRj+v3eFIpa/koMk9Zj3IDajfhLNV
         MwFnLYU+bYAyWgvCsU5+NDH7dyeJz7M4gw5cC/Akg9j6iTsgrcBCYHxKylNlxwFCno
         oVn5IsmJtbT+12jINzFh6syadCQ6EuCPJLgvh7laLRmXWd6hQQe6fpXYbOt4fbE+ot
         8Atl9MJFEnTuQ==
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
Subject: [PATCH 6/8] ARM: clang: Do not relay on lr register for stacktrace
Date:   Fri,  8 Oct 2021 21:29:08 +0900
Message-Id: <163369614818.636038.5019945597127474028.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163369609308.636038.15295764725220907794.stgit@devnote2>
References: <163369609308.636038.15295764725220907794.stgit@devnote2>
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

As same as gcc arm kernel, directly use the frame pointer (x11) of
the pt_regs to find the first frame address.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
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

