Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A99A375BE3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 21:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbhEFTn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 15:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbhEFTnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 15:43:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126E4C0613ED
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 12:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=4/Kg4dI+18FY0Fs01of1GO1sfd1Na4+Q4lbePNnqLrE=; b=G80oCrU9/4hgbYUKt7h4dBj4DG
        aXbgll7J/2vaDZ7chwTHauHQHlxBbmqYi0xJmf4R9MjlY12SNf8cPAlW7+oI6X3f1cAyOf2Y7bh/9
        K3c6KY+WcW9DbeDdzLC0eZGpa7EVYn4fES3aCHi+yjIbB0aGk+OCQCz/LIhSOV+rup02ms1/ehZIq
        BReZ8Rq+yXk97nrvUZVVZSBpi5dUEvvjRpA4p0SWsKyxgAI+2ZCcYohF9Fnb/4oypn3cr7jmVBS6r
        wnaV2DoyoAfTn+2T+3DSqsPqkDAaTDNn65uU5C/lzwEpOlknLGj83vdKjQSnSVHxF5R0GefPsrNP8
        euZEujhg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lejtT-005BMC-9e; Thu, 06 May 2021 19:42:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2870B300386;
        Thu,  6 May 2021 21:42:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D2CDE20B96F92; Thu,  6 May 2021 21:42:38 +0200 (CEST)
Message-ID: <20210506194158.153101906@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 06 May 2021 21:34:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 12/13] objtool: Provide stats for jump_labels
References: <20210506193352.719596001@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add objtool --stats to count the jump_label sites it encounters.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c                   |   22 ++++++++++++++++++++--
 tools/objtool/include/objtool/objtool.h |    3 +++
 2 files changed, 23 insertions(+), 2 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1225,8 +1225,15 @@ static int handle_jump_alt(struct objtoo
 			   struct instruction *orig_insn,
 			   struct instruction **new_insn)
 {
-	if (orig_insn->type == INSN_NOP)
+	if (orig_insn->type == INSN_NOP) {
+do_nop:
+		if (orig_insn->len == 2)
+			file->jl_nop_short++;
+		else
+			file->jl_nop_long++;
+
 		return 0;
+	}
 
 	if (orig_insn->type != INSN_JUMP_UNCONDITIONAL) {
 		WARN_FUNC("unsupported instruction at jump label",
@@ -1245,9 +1252,14 @@ static int handle_jump_alt(struct objtoo
 			       orig_insn->offset, orig_insn->len,
 			       arch_nop_insn(orig_insn->len));
 		orig_insn->type = INSN_NOP;
-		return 0;
+		goto do_nop;
 	}
 
+	if (orig_insn->len == 2)
+		file->jl_short++;
+	else
+		file->jl_long++;
+
 	*new_insn = list_next_entry(orig_insn, list);
 	return 0;
 }
@@ -1328,6 +1340,12 @@ static int add_special_section_alts(stru
 		free(special_alt);
 	}
 
+	if (stats) {
+		printf("jl\\\tNOP\tJMP\n");
+		printf("short:\t%ld\t%ld\n", file->jl_nop_short, file->jl_short);
+		printf("long:\t%ld\t%ld\n", file->jl_nop_long, file->jl_long);
+	}
+
 out:
 	return ret;
 }
--- a/tools/objtool/include/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -22,6 +22,9 @@ struct objtool_file {
 	struct list_head static_call_list;
 	struct list_head mcount_loc_list;
 	bool ignore_unreachables, c_file, hints, rodata;
+
+	unsigned long jl_short, jl_long;
+	unsigned long jl_nop_short, jl_nop_long;
 };
 
 struct objtool_file *objtool_open_read(const char *_objname);


