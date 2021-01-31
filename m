Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C46D309E76
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 21:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhAaUBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 15:01:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:52052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231628AbhAaTyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 14:54:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC0A961481;
        Sun, 31 Jan 2021 17:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612113887;
        bh=5NTqDvqG2Tm3nQK05c/0biN7hY5uiEx+uipriYztlaM=;
        h=From:To:Cc:Subject:Date:From;
        b=VstETjGGH0Z5+67HDuDiJWc9OQI4FFLdUWyeazY5X6DNMgJ/d9lp5vMAQWF4UTfuz
         lVKplgJ36kbH3boJlwjpI0VQGllAUDaTWih0a8uhDq2lgb/7l+Nt5qIWabc/ZGJ3Ru
         iFX3LLyOEEQnlDspcT0+T26UIqsDlrJGh+SUj0ytVBFO8rxBpskDuBpzTjtpKTd0ET
         8h5qCG6U4k6JEInDeE4JhsOedGjBTSLqKXfktflJKu2B9lcC0xngycBspYnRnlcHC9
         xuLTJjug5VGImFJ+NXnW6SgK+KcQW3tsH6DjafDosXUBukaXT6Nua8o73wzaUvN/rf
         uhgfFbwMY0CzQ==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 00/11] x86/fault: Cleanups and robustifications
Date:   Sun, 31 Jan 2021 09:24:31 -0800
Message-Id: <cover.1612113550.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BPF team reported a warning in the x86 page fault code.  This caused me
to read said code, and it was quite tangled.  This series attempts to
mostly disentangle it and fixes a whole bunch of corner cases.  In my
opinion, the control flow and the semantics of the various page fault
functions are much clearer with this series applied, and it also fixes
warts in the SMEP, SMAP, and WRUSS corners of the page fault handler.

Fortunately we don't have any WRUSS instructions in the kernel yet, but I
can dream that some day we'll get real instructions for explicit access to
normal user memory, in which case they will also benefit from these fixes.

The first patch is a genuine regression fix, but the rest is potentially
subtle enough that I would like it to have a good long soak in -next before
landing.

As a nice side bonus, the first patch should give a decent speedup to page
fault signal delivery on CPUs that are not affected by AMD erratum #91.

Andy Lutomirski (11):
  x86/fault: Fix AMD erratum #91 errata fixup for user code
  x86/fault: Fold mm_fault_error() into do_user_addr_fault()
  x86/fault/32: Move is_f00f_bug() do do_kern_addr_fault()
  x86/fault: Document the locking in the fault_signal_pending() path
  x86/fault: Correct a few user vs kernel checks wrt WRUSS
  x86/fault: Improve kernel-executing-user-memory handling
  x86/fault: Split the OOPS code out from no_context()
  x86/fault: Bypass no_context() for implicit kernel faults from
    usermode
  x86/fault: Rename no_context() to kernelmode_fixup_or_oops()
  x86/fault: Don't run fixups for SMAP violations
  x86/fault: Don't look for extable entries for SMEP violations

 arch/x86/mm/fault.c | 355 ++++++++++++++++++++++++--------------------
 1 file changed, 197 insertions(+), 158 deletions(-)

-- 
2.29.2

