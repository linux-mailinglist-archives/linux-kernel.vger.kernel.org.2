Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C9B3D3D52
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 18:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhGWPfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 11:35:44 -0400
Received: from mail.efficios.com ([167.114.26.124]:47378 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhGWPfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 11:35:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1888B350A80;
        Fri, 23 Jul 2021 12:16:16 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id aPzyjXoQ3_IB; Fri, 23 Jul 2021 12:16:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 846A73508A3;
        Fri, 23 Jul 2021 12:16:15 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 846A73508A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1627056975;
        bh=95s2F+cT5wwIKh+ydHTlzlAyCT8rxwwFrE1kTmyohVM=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=Sk7ckczb0x/0Hpn2HVSgUGa4SOcs57UDrWWgJ4ZQlBFyJPOxLyaPZmADRWbgv62d6
         POxvgpnSYmSgKvQVE9gYcX62SrJc9Cf55xdf37gT2QXydPxm6HhCwg7MqR5N3P2vq7
         GOzcYFZ25VCqbCs2cwZRf8D0ckR+h0757bEIzIj9NgY+yHF4yeZzry/tZMyhGfO3tR
         doF3v/zapFGcjVC3FN2JX072vnkfImm2ZFv4H8l/nHVA5Y2ZtdsZZ6VZcFprDRRGyG
         hIvOcgfkExBTfDOXAA+4v/EXhC40P/A0hlbz4JQxpA211sM0J3UJmKYRULgSWiGhuK
         vLs816C+z7cfg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eBnDLygJjPN4; Fri, 23 Jul 2021 12:16:15 -0400 (EDT)
Received: from thinkos.etherlink (192-222-188-69.qc.cable.ebox.net [192.222.188.69])
        by mail.efficios.com (Postfix) with ESMTPSA id 44874350A13;
        Fri, 23 Jul 2021 12:16:15 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-csky@vger.kernel.org
Subject: [RFC PATCH 1/2] Revert "csky: Fixup CONFIG_DEBUG_RSEQ"
Date:   Fri, 23 Jul 2021 12:15:59 -0400
Message-Id: <20210723161600.19688-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit f36e0aab6f1f78d770ce859df3f07a9c5763ce5f.

The csky rseq support has been merged without ever notifying the rseq
maintainers, and without any of the required asssembler glue in the rseq
selftests, which means it is entirely untested.

It is also derived from a non-upstream riscv patch which has known bugs.

The assembly part of this revert should be carefully reviewed by the
architecture maintainer because it touches code which has changed since
the merge of the reverted patch.

The rseq selftests assembly glue should be introduced at the same time
as the architecture rseq support. Without the presence of any test, I
recommend reverting rseq support from csky for now.

Link: https://lore.kernel.org/lkml/1257037909.25426.1626705790861.JavaMai=
l.zimbra@efficios.com/
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Guo Ren <guoren@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-csky@vger.kernel.org
---
 arch/csky/kernel/entry.S | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index 00e3c8ebf9b8..d89afe3b24cc 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -50,11 +50,15 @@ ENTRY(csky_systemcall)
 	SAVE_ALL TRAP0_SIZE
 	zero_fp
 	context_tracking
+#ifdef CONFIG_RSEQ_DEBUG
+	mov     a0, sp
+	jbsr    rseq_syscall
+#endif
 	psrset  ee, ie
=20
 	lrw     r9, __NR_syscalls
 	cmphs   syscallid, r9		/* Check nr of syscall */
-	bt      1f
+	bt      ret_from_exception
=20
 	lrw     r9, sys_call_table
 	ixw     r9, syscallid
@@ -80,11 +84,6 @@ ENTRY(csky_systemcall)
 	jsr     syscallid
 #endif
 	stw     a0, (sp, LSAVE_A0)      /* Save return value */
-1:
-#ifdef CONFIG_DEBUG_RSEQ
-	mov	a0, sp
-	jbsr	rseq_syscall
-#endif
 	jmpi    ret_from_exception
=20
 csky_syscall_trace:
@@ -113,10 +112,6 @@ csky_syscall_trace:
 	stw	a0, (sp, LSAVE_A0)	/* Save return value */
=20
 1:
-#ifdef CONFIG_DEBUG_RSEQ
-	mov	a0, sp
-	jbsr	rseq_syscall
-#endif
 	mov     a0, sp                  /* right now, sp --> pt_regs */
 	jbsr    syscall_trace_exit
 	br	ret_from_exception
--=20
2.20.1

