Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A801A41D803
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 12:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350066AbhI3KqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 06:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350082AbhI3KqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 06:46:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305B9C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 03:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=UZS7L5sdXa7FYPEbrMCpL9TsId2dqB5wF+AhnZfv+AQ=; b=wRTVDJD5p9+9D9AfPRjqBaKl3j
        /+a8yHnVg78mPC4HF5ik9BHozkqFsKmnNVVr863F6wdt8fSgyHcFG7DxCw8kvo/MOhaaqSTMV9Odm
        mLZWE0mB3U604vxl7BDBTru+N+om1iUyXrTcjgjtCogxzWE7jbgV/KH2n0jtI2wLu/JXfW2Zzjwsx
        /2B3EJQHq5ZJN/y/9UF6ByZXXU6E4ny7PVZE1vpTjT/Qz6abHIYQNRZe13rw/6zRiBNDlNCjqr1nC
        qLMFvM8q1eV2Jm/k+a9oAPkB26jnbJNhMx0gZkdDhsDvMPIUe/J0Y6FXEUUu0RbYVFzuVDOSJnI2K
        64xyEwTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVtWy-00CkwW-RC; Thu, 30 Sep 2021 10:43:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9D82E300252;
        Thu, 30 Sep 2021 12:43:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CC3902C8F7853; Thu, 30 Sep 2021 12:43:10 +0200 (CEST)
Date:   Thu, 30 Sep 2021 12:43:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, sfr@canb.auug.org.au,
        mbenes@suse.cz
Subject: [PATCH] objtool: Teach get_alt_entry() about more relocation types
Message-ID: <YVWUvknIEVNkPvnP@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Occasionally objtool encounters symbol (as opposed to section)
relocations in .altinstructions. Typically they are the alternatives
written by elf_add_alternative() as encountered on a noinstr
validation run on vmlinux after having already ran objtool on the
individual .o files.

Basically this is the counterpart of commit 44f6a7c0755d ("objtool:
Fix seg fault with Clang non-section symbols"), because when these new
assemblers (binutils now also does this) strip the section symbols,
elf_add_reloc_to_insn() is forced to emit symbol based relocations.

As such, teach get_alt_entry() about different relocation types.

Fixes: 9bc0bb50727c ("objtool/x86: Rewrite retpoline thunk calls")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/special.c |   32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -58,6 +58,24 @@ void __weak arch_handle_alternative(unsi
 {
 }
 
+static bool reloc2sec_off(struct reloc *reloc, struct section **sec, unsigned long *off)
+{
+	switch (reloc->sym->type) {
+	case STT_FUNC:
+		*sec = reloc->sym->sec;
+		*off = reloc->sym->offset + reloc->addend;
+		return true;
+
+	case STT_SECTION:
+		*sec = reloc->sym->sec;
+		*off = reloc->addend;
+		return true;
+
+	default:
+		return false;
+	}
+}
+
 static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 			 struct section *sec, int idx,
 			 struct special_alt *alt)
@@ -91,15 +109,12 @@ static int get_alt_entry(struct elf *elf
 		WARN_FUNC("can't find orig reloc", sec, offset + entry->orig);
 		return -1;
 	}
-	if (orig_reloc->sym->type != STT_SECTION) {
-		WARN_FUNC("don't know how to handle non-section reloc symbol %s",
+	if (!reloc2sec_off(orig_reloc, &alt->orig_sec, &alt->orig_off)) {
+		WARN_FUNC("don't know how to handle reloc symbol type: %s",
 			   sec, offset + entry->orig, orig_reloc->sym->name);
 		return -1;
 	}
 
-	alt->orig_sec = orig_reloc->sym->sec;
-	alt->orig_off = orig_reloc->addend;
-
 	if (!entry->group || alt->new_len) {
 		new_reloc = find_reloc_by_dest(elf, sec, offset + entry->new);
 		if (!new_reloc) {
@@ -116,8 +131,11 @@ static int get_alt_entry(struct elf *elf
 		if (arch_is_retpoline(new_reloc->sym))
 			return 1;
 
-		alt->new_sec = new_reloc->sym->sec;
-		alt->new_off = (unsigned int)new_reloc->addend;
+		if (!reloc2sec_off(new_reloc, &alt->new_sec, &alt->new_off)) {
+			WARN_FUNC("don't know how to handle reloc symbol type: %s",
+				  sec, offset + entry->new, new_reloc->sym->name);
+			return -1;
+		}
 
 		/* _ASM_EXTABLE_EX hack */
 		if (alt->new_off >= 0x7ffffff0)
