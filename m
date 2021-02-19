Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0ED232001F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 22:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhBSVLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 16:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhBSVK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 16:10:56 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BD6C06178A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 13:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=RCK9xo44E8Hpqw0Fl1vlFmTzLi5iSPiPd8GaLzhg6dE=; b=SdjotqRZyA9SU6fT76oW0r+MB6
        tpkwxVBgxAlLZfxw2yknrTSYrhJsFt1Efo4yfv5Gx9jpLrFml7dmn4YgxkoDe+yyW4zC6qjei+x45
        97u5l+7ERImEExJ1/bY3qRA1RqatyIBoS4TYUUhYHpIkzqTz4zj14Xit6xHq7xRSHQXbeCy4usp4O
        YRS+pcegcxBmQOf6XsEF8q04mwPV/yyNZa6Q/AVHgZi9ihT8EZErjK1RG9D/jklTxsOsMN8LXAbL+
        VSWo6TDZBi9j3UIqRiqGL12Lrx/7Wlg/am8mOVcUnOg760GkrCJvfD4lLY0KWJVhuzZWl0637wxjm
        xDqQbx6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lDD2N-0006Gb-U2; Fri, 19 Feb 2021 21:10:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A93D305C10;
        Fri, 19 Feb 2021 22:10:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 412DF2021555C; Fri, 19 Feb 2021 22:10:05 +0100 (CET)
Message-ID: <20210219210535.193010348@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 19 Feb 2021 21:43:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, x86@kernel.org, pjt@google.com,
        mbenes@suze.cz, jgross@suse.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 1/6] objtool: Correctly handle retpoline thunk calls
References: <20210219204300.749932493@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like JMP handling, convert a direct CALL to a retpoline thunk
into a retpoline safe indirect CALL.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -953,6 +953,18 @@ static int add_call_destinations(struct
 					  dest_off);
 				return -1;
 			}
+
+		} else if (!strncmp(reloc->sym->name, "__x86_indirect_thunk_", 21)) {
+			/*
+			 * Retpoline calls are really dynamic calls in
+			 * disguise, so convert them accodingly.
+			 */
+			insn->type = INSN_CALL_DYNAMIC;
+			insn->retpoline_safe = true;
+
+			remove_insn_ops(insn);
+			continue;
+
 		} else
 			insn->call_dest = reloc->sym;
 


