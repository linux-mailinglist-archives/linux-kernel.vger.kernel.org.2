Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886CB4229E2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbhJEODy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:03:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:40896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235466AbhJEOCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:02:38 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01131619F8;
        Tue,  5 Oct 2021 13:58:30 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mXkxh-0055n5-1u; Tue, 05 Oct 2021 09:58:29 -0400
Message-ID: <20211005135828.893173514@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 05 Oct 2021 09:57:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 18/27] objtool: Ignore unwind hints for ignored functions
References: <20211005135733.485175654@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

If a function is ignored, also ignore its hints.  This is useful for the
case where the function ignore is conditional on frame pointers, e.g.
STACK_FRAME_NON_STANDARD_FP().

Link: https://lkml.kernel.org/r/163163048317.489837.10988954983369863209.stgit@devnote2

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e5947fbb9e7a..67cbdcfcabae 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2909,7 +2909,7 @@ static int validate_unwind_hints(struct objtool_file *file, struct section *sec)
 	}
 
 	while (&insn->list != &file->insn_list && (!sec || insn->sec == sec)) {
-		if (insn->hint && !insn->visited) {
+		if (insn->hint && !insn->visited && !insn->ignore) {
 			ret = validate_branch(file, insn->func, insn, state);
 			if (ret && backtrace)
 				BT_FUNC("<=== (hint)", insn);
-- 
2.32.0
