Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F23A380B0B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 16:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbhENOGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 10:06:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234106AbhENOGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 10:06:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C121F61463;
        Fri, 14 May 2021 14:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621001120;
        bh=KIMl5RduaL26Nsf0bpag/c4ClLw7SGizgJXPJGZClO4=;
        h=From:To:Cc:Subject:Date:From;
        b=ZoH5RPWl1UG28Csvy5bv+Mh9iMk07EP/kDffLlaLMnjpNHaW7NXHT3y+uEVw2aKun
         ABXvYTTkeFrPQtoN3eFG7P5PoeQSr0EtIOIC3UmaitavKqGfz527u8iNYWtgFDFg2s
         RSYQznbNu4eZyXBw+2FTzKXEKI+HoVfbhh2OKej2nwY56zaVEE9bfWBc5peNGtSldS
         NCotBB2TMIXQSZaYJNLHeILwClyyZNRdG8pj9C+e2Z+IfF0K7ZKKNmhQ1h3MLusK3P
         lCuOVE9pEgqiVm9Jy9GRnWn5DfSgJomhBv/30g6LMFJlvq5AFuksuJ60FRnMTkIIeN
         fMvnu+fNblf7A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (VMware)" <rostedt@godmis.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Qiujun Huang <hqjagain@gmail.com>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] tracing: events_hist: avoid using excessive stack space
Date:   Fri, 14 May 2021 16:04:25 +0200
Message-Id: <20210514140429.3334181-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

In some configurations, clang produces a warning about an overly large
amount of stack space used in hist_trigger_print_key():

kernel/trace/trace_events_hist.c:4594:13: error: stack frame size of 1248 bytes in function 'hist_trigger_print_key' [-Werror,-Wframe-larger-than=]
static void hist_trigger_print_key(struct seq_file *m,

Moving the 'str' variable into a more local scope in the two places
where it gets used actually reduces the the used stack space here
and gets it below the warning limit, because the compiler can now
assume that it is safe to use the same stack slot that it has for
the stack of any inline function.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/trace/trace_events_hist.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c1abd63f1d6c..e3fe84f017a8 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4597,7 +4597,6 @@ static void hist_trigger_print_key(struct seq_file *m,
 				   struct tracing_map_elt *elt)
 {
 	struct hist_field *key_field;
-	char str[KSYM_SYMBOL_LEN];
 	bool multiline = false;
 	const char *field_name;
 	unsigned int i;
@@ -4617,11 +4616,13 @@ static void hist_trigger_print_key(struct seq_file *m,
 			uval = *(u64 *)(key + key_field->offset);
 			seq_printf(m, "%s: %llx", field_name, uval);
 		} else if (key_field->flags & HIST_FIELD_FL_SYM) {
+			char str[KSYM_SYMBOL_LEN];
 			uval = *(u64 *)(key + key_field->offset);
 			sprint_symbol_no_offset(str, uval);
 			seq_printf(m, "%s: [%llx] %-45s", field_name,
 				   uval, str);
 		} else if (key_field->flags & HIST_FIELD_FL_SYM_OFFSET) {
+			char str[KSYM_SYMBOL_LEN];
 			uval = *(u64 *)(key + key_field->offset);
 			sprint_symbol(str, uval);
 			seq_printf(m, "%s: [%llx] %-55s", field_name,
-- 
2.29.2

