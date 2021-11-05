Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552494467D4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbhKER1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbhKER06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:26:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CE5C061220
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=FYoOtGnGA0t5RP3/pikL/1FJRmrjI44FBqpQjcrAIfU=; b=knxuSLDjQoqGWLvHWb0/LQfOrc
        slB4hCf61iHg8dbFesvVai6XTfnW8SQeCgFRpgByXeFerxf56GADYUXMO7ot/zdWmHLhCx8uOkWg/
        OpGLiKIjEuFQPcMgazyEIR7cFm1x4OXaoPYYCJ+37WkAgnXKcvGimI80344EgbwliLKYNp9/7fuVn
        l9LXdG1ziKAaamiUwG/FNP8QSpNjuyGfxUxTX2mEZIqIQDnfv/xlkPDfcoUh7uMLIlFY9h5T6bA3R
        SWDRQ+o85twOPruCiURnY6C1AMcOEPXIAK/7KjMyaY7tFmuBoqG3ir1mLjLYc3QD6TKKOOB0vDGJj
        JXKqRvog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj2sa-006ha2-Vb; Fri, 05 Nov 2021 17:20:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DB553302A17;
        Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9A404203C0536; Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Message-ID: <20211105171821.773212821@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 05 Nov 2021 18:10:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH 22/22] objtool: Remove .fixup handling
References: <20211105171023.989862879@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .fixup has gone the way of the Dodo, that test will always be
false.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3296,14 +3296,10 @@ static bool ignore_unreachable_insn(stru
 		return true;
 
 	/*
-	 * Ignore any unused exceptions.  This can happen when a whitelisted
-	 * function has an exception table entry.
-	 *
-	 * Also ignore alternative replacement instructions.  This can happen
+	 * Ignore alternative replacement instructions.  This can happen
 	 * when a whitelisted function uses one of the ALTERNATIVE macros.
 	 */
-	if (!strcmp(insn->sec->name, ".fixup") ||
-	    !strcmp(insn->sec->name, ".altinstr_replacement") ||
+	if (!strcmp(insn->sec->name, ".altinstr_replacement") ||
 	    !strcmp(insn->sec->name, ".altinstr_aux"))
 		return true;
 


