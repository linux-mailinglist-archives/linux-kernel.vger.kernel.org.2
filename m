Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FD8309E7A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 21:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhAaUAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 15:00:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:52042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231633AbhAaTyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 14:54:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B57864E2E;
        Sun, 31 Jan 2021 17:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612113890;
        bh=N9jeXrAZuEKQULR/grDAayh0KR4hwckF6fttJWoVkrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EP3ttSoA8ul7UyJF3MLdV5T5Nl07CPuKlmfj6E8cQFs9z79HJvwEBnlffZPovbwH7
         vHb8vdP5J3ePLUR1RBDocT0Fj2ZS4O3P1HQOeID8q1iy4bFLusS1kbvpHCXfwR75Z7
         SZKN6XH1108JwazHF4/+xZ6WIvXoM3n/QORlPnbyCSayMe8NZmh46XMFfPdywh8zQB
         W2ZxaOmXfDwROe8Ze5sc1hDOilvCdySKVzBCbLtSsSB5zN1eP+o8uy0we05LllKIhj
         Tj57TfQ0HuhCHO3ahlVEQnPIaDyvhdQgLm04XNsIw78SEfSvK7PSk4UgueQCvGhg9i
         3yOhGzLrovQ4A==
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
Subject: [PATCH 04/11] x86/fault: Document the locking in the fault_signal_pending() path
Date:   Sun, 31 Jan 2021 09:24:35 -0800
Message-Id: <3be55bffd65d49c6351c9e732f7b2263039a389d.1612113550.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612113550.git.luto@kernel.org>
References: <cover.1612113550.git.luto@kernel.org>
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
index 87d30daa5e0a..b52064920f0d 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1343,8 +1343,11 @@ void do_user_addr_fault(struct pt_regs *regs,
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

