Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E30C315D7A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbhBJClp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:41:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:34670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235242AbhBJCge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 21:36:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1338A64E7C;
        Wed, 10 Feb 2021 02:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612924439;
        bh=nNHaHF92p2YU8UJalBbhWfMitr4l0UQLFruoT96XWI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G2kbtYzNW/3pW5QY8LLGFX6IY8fCuZtFUlx08B/BCmZMgse4bvW8YL/NGRBbzaxWA
         cOccOP5eNkgkDsEW+R1kZzIhj+kyiXAKFmokYmuYRtEr0dn7LsUPjoXBLQIINUlxG0
         8Wf9QPMVlmV1oFQF457IsI+XJ82jRBFGO5ns2zzPGlMCzpuannGoeclWLL0kVF9Mn/
         ev028122I1jMZsHsVP29hozsn5wLcG/qf10z5/+Qqw6kJgjLWdkgbRTw3mjf82rjpg
         K5UBXu5+ukK45Bz1G8jqMXz/HAl5QrQ2b/rha64pIN4/eEVRKDskQi/qGqpOcyYNE1
         O3WRC5wY0vddA==
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
Subject: [PATCH v2 13/14] x86/fault: Don't run fixups for SMAP violations
Date:   Tue,  9 Feb 2021 18:33:45 -0800
Message-Id: <66a02343624b1ff46f02a838c497fc05c1a871b3.1612924255.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612924255.git.luto@kernel.org>
References: <cover.1612924255.git.luto@kernel.org>
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
 arch/x86/mm/fault.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 466415bdf58c..eed217d4a877 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1278,9 +1278,12 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 */
 	if (unlikely(cpu_feature_enabled(X86_FEATURE_SMAP) &&
 		     !(error_code & X86_PF_USER) &&
-		     !(regs->flags & X86_EFLAGS_AC)))
-	{
-		bad_area_nosemaphore(regs, error_code, address);
+		     !(regs->flags & X86_EFLAGS_AC))) {
+		/*
+		 * No extable entry here.  This was a kernel access to an
+		 * invalid pointer.  get_kernel_nofault() will not get here.
+		 */
+		page_fault_oops(regs, error_code, address);
 		return;
 	}
 
-- 
2.29.2

