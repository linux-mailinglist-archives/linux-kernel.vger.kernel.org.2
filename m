Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E48309E79
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 21:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhAaUAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 15:00:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:52046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231631AbhAaTyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 14:54:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5800864E46;
        Sun, 31 Jan 2021 17:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612113894;
        bh=nTDFeXkmZsJl47UC4OiD2WnjDorbMhlFvMZSs0pko3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UmelsvIqW/2B3Y4QZ2I77DnsTmfOsPxHhD/idftU7efpRnBgwrtvq4h4sXb/gUBmD
         94q59tRMRiQnG3XPlrEe6JEDh5RGo85DSqiJieeXXNBD7lnaZkdVhfGRWjQcwcsAmj
         /igKBOh9bknkUedOII7Hz+5LJekktc8BRhkztwHh8/c9g3kr8WweH+tj0KI7kNzCf9
         2sOhjQB+lxYWHXUl+vvUZYf0yL/s+WJWkOFZv3thWJFDYQruvSQDfj5LlAByVR2uvl
         +XwMh5+necZO+v+FGSZi1XdDMnCJhCqibfTDC+oVi+5glI5el+Mr6rh9f+7OGEffWH
         3qDadgpKOWQuw==
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
Subject: [PATCH 10/11] x86/fault: Don't run fixups for SMAP violations
Date:   Sun, 31 Jan 2021 09:24:41 -0800
Message-Id: <416aa53570523f2659edf9e39d553160cb253c5f.1612113550.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612113550.git.luto@kernel.org>
References: <cover.1612113550.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A SMAP-violating kernel access is not a recoverable condition.  Imagine
kernel code that, outside of a uaccess region, dereferences a pointer to
the user range by accident.  If SMAP is on, this will reliably generate
as an intentional user access.  This makes it easy for bugs to be
overlooked if code is inadequately tested both with and without SMAP.

We discovered this because BPF can generate invalid accesses to user
memory, but those warnings only got printed if SMAP was off.  With this
patch, this type of error will be discovered with SMAP on as well.

Cc: Yonghong Song <yhs@fb.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/fault.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 04cc98ec2423..d39946ad8a91 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1242,7 +1242,11 @@ void do_user_addr_fault(struct pt_regs *regs,
 		     !(error_code & X86_PF_USER) &&
 		     !(regs->flags & X86_EFLAGS_AC)))
 	{
-		bad_area_nosemaphore(regs, error_code, address);
+		/*
+		 * No extable entry here.  This was a kernel access to an
+		 * invalid pointer.  get_kernel_nofault() will not get here.
+		 */
+		page_fault_oops(regs, error_code, address);
 		return;
 	}
 
-- 
2.29.2

