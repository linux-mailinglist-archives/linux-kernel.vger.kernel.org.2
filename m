Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A708339489
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhCLRSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbhCLRSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:18:00 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9321C061763
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 09:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=lW6HfmZhbEAa4aClYuqvdf1BIl9dGbUl607e3HUuFLg=; b=Mn1Z1Qs4f/qW8MT472ufuogrrj
        UsAL0CFv6X3bXiF4lLqVC6jVcCrZ2pJwsQ/QtU3ZdpOiOV5mleJ21uqRpacJ1I4YR7u8tW2So/FoM
        ApNntUzsNHE0juBozcbXf1AidV8B8fE9H5oQPMKbZ8HYAqGlZvdMLcZYO2q+jqhXuMWyppREkltEm
        M4cft2WmDHGep7rBtr4Vn0VxaVdwLPijQi+UgSjwY5/cP4Ony59fXRQcgCS++Q07TWi3eAVjy+VhF
        aEhW4C00zRR5WAqaArRRx4q6E6FKkrsgeGc4h/bOADAqle1gDCYlYPOFHyVd0lpMv2QqLz4/+emn6
        U5ZetL+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKlQ9-00C536-VD; Fri, 12 Mar 2021 17:17:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1B9D03060AE;
        Fri, 12 Mar 2021 18:17:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0C34123CC2292; Fri, 12 Mar 2021 18:17:53 +0100 (CET)
Message-ID: <20210312171653.588985655@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 12 Mar 2021 18:16:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suze.cz
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 4/9] objtool: Fix static_call list generation
References: <20210312171613.533405394@infradead.org>
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


