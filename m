Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B4537F981
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 16:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbhEMORU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 10:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbhEMORP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 10:17:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CEBC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 07:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rTB7oxQoS0DrRl/ZYlxeafz727DK0Z6Wo0bqAAR9t6s=; b=hUKv17D7lFDkiXWfPPWQQcB+w5
        gQUwyeD7E23MBtHyCCV+7gUHM/19Q7iu0bfGdzK0HaWmSX1CYM3q2zt1uuAU69FGykVPdkOhrP/Jd
        ELfL8thOKMqRoSgCwf2dVCfSC5Tni/GJXZ4SIAxtxMYu3kEZGgFQQK6tEQxzB39DMKvqaAsUynxAi
        y1847jOFWsD3GOnDv4K3kHvYY/ncHkF6gkbh6GtNgkFvRjdlp0rUhUCPMHtZH6oz6qcA1Q3vSaIlH
        299IPCOz+r+w/Qswz+9Z68iUcGsEUqhmQIy9dICsLkT6GjGQfEg3/wSuGA1cq9h5N0iNs8KupNZuj
        +jRP0Dow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhC7z-005iFb-JT; Thu, 13 May 2021 14:15:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D43FA3001E1;
        Thu, 13 May 2021 16:15:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B1E652D3CBAF5; Thu, 13 May 2021 16:15:50 +0200 (CEST)
Date:   Thu, 13 May 2021 16:15:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 12.5/13] objtool: Reflow handle_jump_alt()
Message-ID: <YJ00lgslY+IpA/rL@hirez.programming.kicks-ass.net>
References: <20210506193352.719596001@infradead.org>
 <20210506194158.153101906@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506194158.153101906@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Subject: objtool: Reflow handle_jump_alt()
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu May 13 13:52:46 CEST 2021

Miroslav figured the code flow in handle_jump_alt() was sub-optimal
with that goto. Reflow the code to make it clearer.

Reported-by: Miroslav Benes <mbenes@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1225,17 +1225,9 @@ static int handle_jump_alt(struct objtoo
 			   struct instruction *orig_insn,
 			   struct instruction **new_insn)
 {
-	if (orig_insn->type == INSN_NOP) {
-do_nop:
-		if (orig_insn->len == 2)
-			file->jl_nop_short++;
-		else
-			file->jl_nop_long++;
+	if (orig_insn->type != INSN_JUMP_UNCONDITIONAL &&
+	    orig_insn->type != INSN_NOP) {
 
-		return 0;
-	}
-
-	if (orig_insn->type != INSN_JUMP_UNCONDITIONAL) {
 		WARN_FUNC("unsupported instruction at jump label",
 			  orig_insn->sec, orig_insn->offset);
 		return -1;
@@ -1252,7 +1244,15 @@ static int handle_jump_alt(struct objtoo
 			       orig_insn->offset, orig_insn->len,
 			       arch_nop_insn(orig_insn->len));
 		orig_insn->type = INSN_NOP;
-		goto do_nop;
+	}
+
+	if (orig_insn->type == INSN_NOP) {
+		if (orig_insn->len == 2)
+			file->jl_nop_short++;
+		else
+			file->jl_nop_long++;
+
+		return 0;
 	}
 
 	if (orig_insn->len == 2)
