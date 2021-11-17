Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF708454D4D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 19:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240134AbhKQSk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 13:40:56 -0500
Received: from relay.sw.ru ([185.231.240.75]:46872 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240099AbhKQSky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 13:40:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
        Content-Type; bh=x88aHIoK46ihaovaFiX3dVLO6chyV3ytJOq4It3hfWw=; b=sR16NbT54qeq
        F4WkSOpnLLjT/tpH++9hPkiQX24WT4oTjMEnmKiVtYBSvGYiYA+1nf4iBFNZA5wQaAxGX5djlO1f/
        eCCRgQAaZ+OWU1j1AvrrdWtnfMquOAfVqIDBPCVea3jM9YN2N461MORNkZlltAW0E5NFoOIYAuKBO
        03WeI=;
Received: from [192.168.15.157] (helo=cobook.home)
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <nikita.yushchenko@virtuozzo.com>)
        id 1mnPoV-000bjb-MY; Wed, 17 Nov 2021 21:37:43 +0300
From:   Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: [PATCH] tracing: fix va_list breakage in trace_check_vprintf()
Date:   Wed, 17 Nov 2021 21:37:20 +0300
Message-Id: <20211117183720.15573-1-nikita.yushchenko@virtuozzo.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When trace_check_vprintf() extracts parts of the format string and
passes those to trace_seq_printf() together with va_list, it expects
that trace_seq_printf() consumes arguments from va_list, as defined
by the passed format substring.

However, trace_seq_printf() has a special path for overflow handling,
that does not consume any arguments from va_list. This causes va_list
to get out of sync with format string processing, the next va_arg()
inside trace_check_vprintf() gets wrong argument, and WARN_ON_ONCE()
hits.

This situation easily triggers by ftrace_stress_test from LTP.

Fix that by adding a dummy vsnprintf() call to the overflow path inside
trace_seq_printf() to ensure args from va_list are still consumed.

Signed-off-by: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
---
 kernel/trace/trace_seq.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
index 9c90b3a7dce2..3551b5e18aa2 100644
--- a/kernel/trace/trace_seq.c
+++ b/kernel/trace/trace_seq.c
@@ -141,9 +141,15 @@ EXPORT_SYMBOL_GPL(trace_seq_bitmask);
 void trace_seq_vprintf(struct trace_seq *s, const char *fmt, va_list args)
 {
 	unsigned int save_len = s->seq.len;
+	char buf[1];
 
-	if (s->full)
+	if (s->full) {
+		/* Consume args from va_list before returning, some callers
+		 * expect that.
+		 */
+		vsnprintf(buf, sizeof(buf), fmt, args);
 		return;
+	}
 
 	__trace_seq_init(s);
 
-- 
2.30.2

