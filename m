Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30052320025
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 22:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhBSVNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 16:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhBSVNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 16:13:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578F2C061786
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 13:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=lW6HfmZhbEAa4aClYuqvdf1BIl9dGbUl607e3HUuFLg=; b=gyuQzmUjNI+XZXOM9lcIJtXI5L
        KIrY5hAb2MbYFdgRzOOkou+ojbm/nRFDCNQ/bnLUqqcX7H6BOIWTtWORIzEbjiTQsHdUOZ6MTrXc3
        Qh6ud14rLZu81MK6er9oGP5IEFxR6Bmi3ybam4NHKGrEjrzsIosNOQ1BoQRxFLEn4xUOjmoaPMW7S
        YydaBvdMZ0ubn7qCLQjOGAS0Buq70YpPYfv/BG9Kyas0HSE1fainklFzk4/LCgAv/5bpo/sbZq5/3
        Sk7598EeLw69cXyyZD863FGciVRQg95Wb4HSYAlw2KaN8crSQ0nGe3jLA8oFnzBB4dCxK5JEB7JA8
        5/QDsObw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lDD2M-003Hk2-I1; Fri, 19 Feb 2021 21:10:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 59C49301A42;
        Fri, 19 Feb 2021 22:10:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 443542021555E; Fri, 19 Feb 2021 22:10:05 +0100 (CET)
Message-ID: <20210219210535.252524310@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 19 Feb 2021 21:43:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, x86@kernel.org, pjt@google.com,
        mbenes@suze.cz, jgross@suse.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 2/6] objtool: Fix static_call list generation
References: <20210219204300.749932493@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently objtool generates tail call entries in
add_jump_destination() but waits until validate_branch() to generate
the regular call entries, move these to add_call_destination() for
consistency.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -974,6 +974,11 @@ static int add_call_destinations(struct
 		} else
 			insn->call_dest = reloc->sym;
 
+		if (insn->call_dest && insn->call_dest->static_call_tramp) {
+			list_add_tail(&insn->static_call_node,
+				      &file->static_call_list);
+		}
+
 		/*
 		 * Many compilers cannot disable KCOV with a function attribute
 		 * so they need a little help, NOP out any KCOV calls from noinstr
@@ -1701,6 +1706,9 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
+	/*
+	 * Must be before add_{jump_call}_desetination.
+	 */
 	ret = read_static_call_tramps(file);
 	if (ret)
 		return ret;
@@ -1717,6 +1725,10 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
+	/*
+	 * Must be before add_call_destination(); it changes INSN_CALL to
+	 * INSN_JUMP.
+	 */
 	ret = read_intra_function_calls(file);
 	if (ret)
 		return ret;
@@ -2659,11 +2671,6 @@ static int validate_branch(struct objtoo
 			if (dead_end_function(file, insn->call_dest))
 				return 0;
 
-			if (insn->type == INSN_CALL && insn->call_dest->static_call_tramp) {
-				list_add_tail(&insn->static_call_node,
-					      &file->static_call_list);
-			}
-
 			break;
 
 		case INSN_JUMP_CONDITIONAL:


