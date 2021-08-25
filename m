Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508563F7209
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240011AbhHYJkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 05:40:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239940AbhHYJkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:40:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B24C3610CE;
        Wed, 25 Aug 2021 09:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629884362;
        bh=m04P8lfsKUBV3SPkcLaBDDyhcaMgaHK2RT+ylPPu9eg=;
        h=From:To:Cc:Subject:Date:From;
        b=QSrZrUTxiMCQEPeQs1qXBOHAAPJsXEiC/Ht3OF3rnYgcPdowM8T8/ic0LerRGoC9+
         MzJlqgTdLMqXb+6e/e5fGDifPUWwoOYNmAUeYSdn3NOIDTvz35CX4QgxKjn8QuB4z3
         TRGVBr4nOxlS4woAlZyJvuor/SVBFSEuuxQG2nHG5aaQrWFvbKK4Kkvs8uqcDhsYM9
         pdSPF/tbcgKu5COTQ/DqoYJlk98xvKa1W1fiMcHJRdydnaNtzzG+/gmCVPnDfNVK7T
         UwJr/E2KE8nzDndeMNqEOfy9TG6A/M+qubojzIs5zc+mq9rl+kZYt5Va5+6E9ZRn7E
         PAha+ctjcCPSw==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] arm64: signal32: Drop pointless call to sigdelsetmask()
Date:   Wed, 25 Aug 2021 10:39:11 +0100
Message-Id: <20210825093911.24493-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 77097ae503b1 ("most of set_current_blocked() callers want
SIGKILL/SIGSTOP removed from set") extended set_current_blocked() to
remove SIGKILL and SIGSTOP from the new signal set and updated all
callers accordingly.

Unfortunately, this collided with the merge of the arm64 architecture,
which duly removes these signals when restoring the compat sigframe, as
this was what was previously done by arch/arm/.

Remove the redundant call to sigdelsetmask() from
compat_restore_sigframe().

Cc: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/signal32.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 2f507f565c48..4850333669fb 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -46,8 +46,6 @@ struct compat_aux_sigframe {
 	unsigned long			end_magic;
 } __attribute__((__aligned__(8)));
 
-#define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
-
 static inline int put_sigset_t(compat_sigset_t __user *uset, sigset_t *set)
 {
 	compat_sigset_t	cset;
@@ -190,10 +188,8 @@ static int compat_restore_sigframe(struct pt_regs *regs,
 	unsigned long psr;
 
 	err = get_sigset_t(&set, &sf->uc.uc_sigmask);
-	if (err == 0) {
-		sigdelsetmask(&set, ~_BLOCKABLE);
+	if (err == 0)
 		set_current_blocked(&set);
-	}
 
 	__get_user_error(regs->regs[0], &sf->uc.uc_mcontext.arm_r0, err);
 	__get_user_error(regs->regs[1], &sf->uc.uc_mcontext.arm_r1, err);
-- 
2.33.0.rc2.250.ged5fa647cd-goog

