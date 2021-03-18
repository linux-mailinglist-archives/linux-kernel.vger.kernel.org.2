Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFE5340BB1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbhCRRYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbhCRRYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:24:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF91C061761
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=8U5x3H9OrZvMc1q6Av7M3v6tdokpGrM9MWQOD2WaRMk=; b=l3y4DCQ4iMB08UXLPuNtWUvXbb
        Mq56lhNqoi8lJOtHsitKHfnxtaeoTGI9YEl5wgMWlYrEkY5nX8QhRVueSNmmqm5rkJejpjFxXcXYM
        YMRLafcEsW7PtQlE12zpoxBSbtmxsgpEJXLlZVIHSE1ZAnx8PP8MqUuFXGDXoi/P5SSrIOBjlhYmj
        NR6GYW6VOBJgAH0YpdbE+t8qzcQeCnxVtYQOc2QcI2XkooOzfqklAyQU86Bp6bNpViymXraQs4EH0
        ZVA+TJ9MF3xpaifsPyZ3D/VmmSiTOYBFchlurbrBbcSDP5EqDaoR8oJVOx5iZFHONE0UpzpR8YIRh
        1fuL0sZg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMwMq-003HIV-GH; Thu, 18 Mar 2021 17:23:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3AF083077B1;
        Thu, 18 Mar 2021 18:23:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2999729DE0B4D; Thu, 18 Mar 2021 18:23:27 +0100 (CET)
Message-ID: <20210318171919.764599543@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Mar 2021 18:11:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suse.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH v2 06/14] objtool: Fix static_call list generation
References: <20210318171103.577093939@infradead.org>
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
 tools/objtool/check.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1045,6 +1045,12 @@ static int add_call_destinations(struct
 		} else
 			insn->call_dest = reloc->sym;
 
+		if (insn->call_dest && insn->call_dest->static_call_tramp) {
+			list_add_tail(&insn->static_call_node,
+				      &file->static_call_list);
+		}
+
+
 		/*
 		 * Many compilers cannot disable KCOV with a function attribute
 		 * so they need a little help, NOP out any KCOV calls from noinstr
@@ -1788,6 +1794,9 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
+	/*
+	 * Must be before add_{jump_call}_destination.
+	 */
 	ret = read_static_call_tramps(file);
 	if (ret)
 		return ret;
@@ -1800,6 +1809,10 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
+	/*
+	 * Must be before add_call_destination(); it changes INSN_CALL to
+	 * INSN_JUMP.
+	 */
 	ret = read_intra_function_calls(file);
 	if (ret)
 		return ret;
@@ -2745,11 +2758,6 @@ static int validate_branch(struct objtoo
 			if (dead_end_function(file, insn->call_dest))
 				return 0;
 
-			if (insn->type == INSN_CALL && insn->call_dest->static_call_tramp) {
-				list_add_tail(&insn->static_call_node,
-					      &file->static_call_list);
-			}
-
 			break;
 
 		case INSN_JUMP_CONDITIONAL:


