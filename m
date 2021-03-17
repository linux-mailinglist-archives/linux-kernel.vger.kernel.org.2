Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765FB33F0A9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 13:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhCQMqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 08:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhCQMqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 08:46:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E902AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 05:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t4AzJAff14mo8fuS8nrMYd3WuNtETlU9CaNcmaSRqfI=; b=ToU78XWhHNRbs3mKWK+yMA3w6L
        cEXXhuhgyrKleNqEylgUUJ7TZPNtKByUoaUEVm2/rmO5KZ3B3tuWbSbPWAQLRlxVsS6ZWzDcXFthp
        jOcAwpT89reDieENb6qUxni+YGrySkDnb95GUkuaL7uzmCL/l2s2/jGHndMxK1ylfnLhPov/ODDdI
        JXcYiiYd/wTaQNoAjXPqeRyQ3R2miaTSx0cx/gpRMpRByQQbC4ldQwzg2USd5tCq+ETEgOx14ycch
        e9DZnH9cuyhL1uUoqiPIg0+LLRnISGKFlMqik+1Gt6q+x7RIsy7V30XRZeEqbHPVv4pwpETW22qS5
        mm4FN0Bg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMVYk-0037bc-8I; Wed, 17 Mar 2021 12:45:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DED4D3050F0;
        Wed, 17 Mar 2021 13:45:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C7D5B2CAEB6C5; Wed, 17 Mar 2021 13:45:57 +0100 (CET)
Date:   Wed, 17 Mar 2021 13:45:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Oliver Sang <oliver.sang@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, jbaron@akamai.com,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] objtool,static_call: Don't emit static_call_site for
 .exit.text
Message-ID: <YFH6BR61b5GK8ITo@hirez.programming.kicks-ass.net>
References: <20210315142345.GB4401@xsang-OptiPlex-9020>
 <CAFA6WYNMHAqqmNfncmJm3+BUYCktXouRtV_udSxQb7eifPmX+Q@mail.gmail.com>
 <20210317030101.GB22345@xsang-OptiPlex-9020>
 <CAFA6WYMb-C2L7DmGnhWgxjuuvP=qxPA4-s4q+knxH+iWXypHmw@mail.gmail.com>
 <YFHAsgNhe8c3ZHQN@hirez.programming.kicks-ass.net>
 <YFHE9CjanDAD4l5M@hirez.programming.kicks-ass.net>
 <YFHFjarVo7HAP7pg@hirez.programming.kicks-ass.net>
 <CAFA6WYNs-rQLUGPMwc-p0q_KRvR16rm-x55gDqw828c7-C1qeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYNs-rQLUGPMwc-p0q_KRvR16rm-x55gDqw828c7-C1qeA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 05:25:48PM +0530, Sumit Garg wrote:
> Thanks Peter for this fix. It does work for me on qemu for x86. Can
> you turn this into a proper fix patch? BTW, feel free to add:

Per the below, the original patch ought to be fixed as well, to not use
static_call() in __exit.

---
Subject: objtool,static_call: Don't emit static_call_site for .exit.text
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Mar 17 13:35:05 CET 2021

Functions marked __exit are (somewhat surprisingly) discarded at
runtime when built-in. This means that static_call(), when used in
__exit functions, will generate static_call_site entries that point
into reclaimed space.

Simply skip such sites and emit a WARN about it. By not emitting a
static_call_site the site will remain pointed at the trampoline, which
is also maintained, so things will work as expected, albeit with the
extra indirection.

The WARN is so that people are aware of this; and arguably it simply
isn't a good idea to use static_call() in __exit code anyway, since
module unload is never a performance critical path.

Reported-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org>
---
 tools/objtool/check.c |   32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -850,6 +850,22 @@ static int add_ignore_alternatives(struc
 	return 0;
 }
 
+static inline void static_call_add(struct instruction *insn,
+				   struct objtool_file *file)
+{
+	if (!insn->call_dest->static_call_tramp)
+		return;
+
+	if (!strcmp(insn->sec->name, ".exit.text")) {
+		WARN_FUNC("static_call in .exit.text, skipping inline patching",
+			  insn->sec, insn->offset);
+		return;
+	}
+
+	list_add_tail(&insn->static_call_node,
+		      &file->static_call_list);
+}
+
 /*
  * Find the destination instructions for all jumps.
  */
@@ -888,10 +904,7 @@ static int add_jump_destinations(struct
 		} else if (insn->func) {
 			/* internal or external sibling call (with reloc) */
 			insn->call_dest = reloc->sym;
-			if (insn->call_dest->static_call_tramp) {
-				list_add_tail(&insn->static_call_node,
-					      &file->static_call_list);
-			}
+			static_call_add(insn, file);
 			continue;
 		} else if (reloc->sym->sec->idx) {
 			dest_sec = reloc->sym->sec;
@@ -950,10 +963,7 @@ static int add_jump_destinations(struct
 
 				/* internal sibling call (without reloc) */
 				insn->call_dest = insn->jump_dest->func;
-				if (insn->call_dest->static_call_tramp) {
-					list_add_tail(&insn->static_call_node,
-						      &file->static_call_list);
-				}
+				static_call_add(insn, file);
 			}
 		}
 	}
@@ -2746,10 +2756,8 @@ static int validate_branch(struct objtoo
 			if (dead_end_function(file, insn->call_dest))
 				return 0;
 
-			if (insn->type == INSN_CALL && insn->call_dest->static_call_tramp) {
-				list_add_tail(&insn->static_call_node,
-					      &file->static_call_list);
-			}
+			if (insn->type == INSN_CALL)
+				static_call_add(insn, file);
 
 			break;
 
