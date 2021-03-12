Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B6D33948D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbhCLRSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbhCLRSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:18:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68B8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 09:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=RCK9xo44E8Hpqw0Fl1vlFmTzLi5iSPiPd8GaLzhg6dE=; b=V217XUeiXK4aMHbH2WhPIFdaU4
        a4OBCoR9/edIMer50/UsFa2+Wm9Wb+fQZk9Fflo3MA+wI0NbVJ/asNlJxRcPlctfrRZhNWOJFOL64
        6023W7k+zzhWI/MmpUX2RbfYTeN9w0koIb58U8lh4jY41GkbOJ/R0464yFw0xsfjgq6nWIJLjn5UB
        PWm7FR3v4guApSV+LO6lGRsnO/StLXzCGqVOrMt17+WcE22NrFL0Y2GdP/UvDr3ib2ZJH3mmz4ssW
        6OxAZGM0Ajlz4+N1KIgw68FjtlHxZjvjLadBd0UP/MmqwHgvgE1pdReyR46wVkLerB3brtrUjvlXl
        ZLQeKYxQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKlQ9-00BETf-Ra; Fri, 12 Mar 2021 17:17:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 16B90304D28;
        Fri, 12 Mar 2021 18:17:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0354523CC2291; Fri, 12 Mar 2021 18:17:53 +0100 (CET)
Message-ID: <20210312171653.466281089@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 12 Mar 2021 18:16:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suze.cz
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 2/9] objtool: Correctly handle retpoline thunk calls
References: <20210312171613.533405394@infradead.org>
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
 


