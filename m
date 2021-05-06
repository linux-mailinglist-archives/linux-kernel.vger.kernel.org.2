Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CBE375BE1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 21:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbhEFTnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 15:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbhEFTnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 15:43:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0DDC061761
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 12:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=hhyxUtgR+B7x+kVwQUha59XgAwJqFT7lXBFEsYsowC8=; b=FYz67lt2uLfSCElARaIMcxCp52
        mN05C2AkGfg/3XYibjBpK/EFm4bU+Pu+kXcXuJ5XIDVQI5xAi3S6EXsMVMjGlQlPp2FEWLwxScY7u
        lAByljCmH2241f3eWr0jjyi1AyGWuFFJJJ9PC0TtFjvwIJyyQyxgRkUS4rg2eSVArz/iMtbvPvj2t
        7rn5FwOU06CywuH2DVeiZxKUfOd8gFgxXQtXhWuFIeJW7uhOdSxqofAo11nUYlSbjHs+aOTBfl/GI
        +a+wccHgoNLCuTHlmubkIRMAVqXfw67i+tSvQeWPl1AfCtKKo4ONzkuZBfJ91o1l7Gev7CCQ3/C+v
        Yw6wQbkg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lejtT-005BM8-8s; Thu, 06 May 2021 19:42:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 25C6A300365;
        Thu,  6 May 2021 21:42:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C8FC820B96F91; Thu,  6 May 2021 21:42:38 +0200 (CEST)
Message-ID: <20210506194158.091028792@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 06 May 2021 21:34:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 11/13] objtool: Rewrite jump_label instructions
References: <20210506193352.719596001@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a jump_entry::key has bit1 set, rewrite the instruction to be a
NOP. This allows the compiler/assembler to emit JMP (and thus decide
on which encoding to use).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1223,6 +1223,20 @@ static int handle_jump_alt(struct objtoo
 		return -1;
 	}
 
+	if (special_alt->key_addend & 2) {
+		struct reloc *reloc = insn_reloc(file, orig_insn);
+
+		if (reloc) {
+			reloc->type = R_NONE;
+			elf_write_reloc(file->elf, reloc);
+		}
+		elf_write_insn(file->elf, orig_insn->sec,
+			       orig_insn->offset, orig_insn->len,
+			       arch_nop_insn(orig_insn->len));
+		orig_insn->type = INSN_NOP;
+		return 0;
+	}
+
 	*new_insn = list_next_entry(orig_insn, list);
 	return 0;
 }


