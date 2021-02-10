Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697BE315D77
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbhBJCkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:40:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235215AbhBJCgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 21:36:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6558764E54;
        Wed, 10 Feb 2021 02:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612924438;
        bh=tlPT8X7xAkYg1opwobqkix010pmIi/FLQNl8ZjxRVwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V7Nn6v9S1Opl8gp3wEZChxdGLXIq9LwEE3rxmXG/tsaK2FJprcwSsvY7y4l7kbs//
         uyHkXY/OwNPL2QWzFtwPX8uXjXkvRLcLXU5oRbv/1/Fzxe9I0TqKJVXDOf0wOPOjob
         5poUdKVVTBWiHryfRNwE9MQnTkRwe4JxPY6s/QJlkRgzjGiV+loQ/jH9Pvaf7EneZS
         krjqDRScte6l4pSMnlBZvTbiCNUGy+EG/ZKDG9ax8b0+cJBHmT61v2cXP+e9KwHFOT
         xo21PjlcDZu2Z+Tdc1RTvjEvZ94eGV8TNoRcqDg7aq51w8aivxbo/erUbvTeWXFc2J
         kjvqJ6X2FKjKg==
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
Subject: [PATCH v2 12/14] x86/fault: Don't look for extable entries for SMEP violations
Date:   Tue,  9 Feb 2021 18:33:44 -0800
Message-Id: <46160d8babce2abf1d6daa052146002efa24ac56.1612924255.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612924255.git.luto@kernel.org>
References: <cover.1612924255.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we get a SMEP violation or a fault that would have been a SMEP
violation if we had SMEP, we shouldn't run fixups.  Just OOPS.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/fault.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 9fb636b2a3da..466415bdf58c 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1249,12 +1249,12 @@ void do_user_addr_fault(struct pt_regs *regs,
 		 * user memory.  Unless this is AMD erratum #93, which
 		 * corrupts RIP such that it looks like a user address,
 		 * this is unrecoverable.  Don't even try to look up the
-		 * VMA.
+		 * VMA or look for extable entries.
 		 */
 		if (is_errata93(regs, address))
 			return;
 
-		bad_area_nosemaphore(regs, error_code, address);
+		page_fault_oops(regs, error_code, address);
 		return;
 	}
 
-- 
2.29.2

