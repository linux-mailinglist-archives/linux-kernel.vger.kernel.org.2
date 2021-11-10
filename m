Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CEF44BE5C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhKJKTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbhKJKTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:19:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF9FC061767
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=FYoOtGnGA0t5RP3/pikL/1FJRmrjI44FBqpQjcrAIfU=; b=tW1RsIX8xT6nKlqs0vLopSOM1X
        hhx/VurB0KUaVvV4J2wupl2qn7BO0hOec3xOWNAyjCdoLuZUyIZP1Ij0F2nvDoMA3KUX4x1gt03TE
        Y3pfdYNQG7H3YEppSlpPha4dP0zHTxkDA3kmT3e2NIdBZZdDolENJSfNUmQsBj3uPctsXYi5ipXaO
        Z7gn6fj23yROEhon+tNpERLCOtiUtuEqJYgtOoMKGmO+pkVnlOzEcc0uZFIK2RPDEduLAa8ivb8b3
        9plxrh4DC8wSe+mgrDwewBATPlpeXvFig68T7bnXuvWt34CD0L7naF4SlqKQxJpqn6fivI8qbAsKX
        7NWskNkg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkkeH-001lkl-5P; Wed, 10 Nov 2021 10:16:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D024A302A1A;
        Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BDE8020165536; Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Message-ID: <20211110101326.261496792@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Nov 2021 11:01:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH v2 23/23] objtool: Remove .fixup handling
References: <20211110100102.250793167@infradead.org>
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
 


