Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE8D315D6C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbhBJCiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:38:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234717AbhBJCfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 21:35:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38E9064E5A;
        Wed, 10 Feb 2021 02:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612924432;
        bh=VpiGszjWRCGHlsfY5CAAKkwNjbQ/B7h8CaWG22qvxBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qcCavE9dj5Bb958GMdiptMZ+lvDAzf9w5NIQxCjd3Nm/XANU7LhtxiaWTnOxijH6A
         Hz7keBK5/xeKQqZEKY87jOj3uICgCtkMppwuVU5XPMH+5j596eZuJllOSLFt/cW59g
         6I9WiKKZ6SVgQODiMCf5mCoGCl5CC53/DMVg2zYHpXHrXlxCDN/hv8hQI8bBrbUIEK
         7QaLrq+6BCiUqODiaszABS29HtGQE5nEs6pC4iuF19ZwgSJPGXbsOHRzvhAZEaa0J3
         nBBNHPBqzfI/NfwUmN9i0Y+eNLxWa0V8ct6ljnatIJ/dDPECIA9vgMEJ9MdYC08OCs
         ClzrDUisbZ3og==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 05/14] x86/fault: Document the locking in the fault_signal_pending() path
Date:   Tue,  9 Feb 2021 18:33:37 -0800
Message-Id: <c56de3d103f40e6304437b150aa7b215530d23f7.1612924255.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612924255.git.luto@kernel.org>
References: <cover.1612924255.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If fault_signal_pending() returns true, then the core mm has unlocked the
mm for us.  Add a comment to help future readers of this code.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/fault.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 3ffed003f281..013910b7b93f 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1380,8 +1380,11 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 */
 	fault = handle_mm_fault(vma, address, flags, regs);
 
-	/* Quick path to respond to signals */
 	if (fault_signal_pending(fault, regs)) {
+		/*
+		 * Quick path to respond to signals.  The core mm code
+		 * has unlocked the mm for us if we get here.
+		 */
 		if (!user_mode(regs))
 			no_context(regs, error_code, address, SIGBUS,
 				   BUS_ADRERR);
-- 
2.29.2

