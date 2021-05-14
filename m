Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483783811E3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 22:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhENUiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 16:38:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229932AbhENUiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 16:38:15 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5296261444;
        Fri, 14 May 2021 20:37:03 +0000 (UTC)
Date:   Fri, 14 May 2021 16:37:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Subject: [GIT PULL] tracing: Handle %.*s in trace_check_vprintf()
Message-ID: <20210514163702.7ae950d6@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

tracing: Fix trace_check_vprintf() for %.*s

The sanity check of all strings being read from the ring buffer
to make sure they are in safe memory space did not account for
the %.*s notation having another parameter to process (the length).

Add that to the check.


Please pull the latest trace-v5.13-rc1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.13-rc1

Tag SHA1: 71e3560ee5a8afa5639455dd4f0ae214e47d300b
Head SHA1: eb01f5353bdaa59600b29d864819056a0e3de24d


Steven Rostedt (VMware) (1):
      tracing: Handle %.*s in trace_check_vprintf()

----
 kernel/trace/trace.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)
---------------------------
commit eb01f5353bdaa59600b29d864819056a0e3de24d
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Thu May 13 12:23:24 2021 -0400

    tracing: Handle %.*s in trace_check_vprintf()
    
    If a trace event uses the %*.s notation, the trace_check_vprintf() will
    fail and will warn about a bad processing of strings, because it does not
    take into account the length field when processing the star (*) part.
    Have it handle this case as well.
    
    Link: https://lore.kernel.org/linux-nfs/238C0E2D-C2A4-4578-ADD2-C565B3B99842@oracle.com/
    
    Reported-by: Chuck Lever III <chuck.lever@oracle.com>
    Fixes: 9a6944fee68e2 ("tracing: Add a verifier to check string pointers for trace events")
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 560e4c8d3825..a21ef9cd2aae 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3704,6 +3704,9 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 		goto print;
 
 	while (*p) {
+		bool star = false;
+		int len = 0;
+
 		j = 0;
 
 		/* We only care about %s and variants */
@@ -3725,13 +3728,17 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 				/* Need to test cases like %08.*s */
 				for (j = 1; p[i+j]; j++) {
 					if (isdigit(p[i+j]) ||
-					    p[i+j] == '*' ||
 					    p[i+j] == '.')
 						continue;
+					if (p[i+j] == '*') {
+						star = true;
+						continue;
+					}
 					break;
 				}
 				if (p[i+j] == 's')
 					break;
+				star = false;
 			}
 			j = 0;
 		}
@@ -3744,6 +3751,9 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 		iter->fmt[i] = '\0';
 		trace_seq_vprintf(&iter->seq, iter->fmt, ap);
 
+		if (star)
+			len = va_arg(ap, int);
+
 		/* The ap now points to the string data of the %s */
 		str = va_arg(ap, const char *);
 
@@ -3762,8 +3772,18 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 			int ret;
 
 			/* Try to safely read the string */
-			ret = strncpy_from_kernel_nofault(iter->fmt, str,
-							  iter->fmt_size);
+			if (star) {
+				if (len + 1 > iter->fmt_size)
+					len = iter->fmt_size - 1;
+				if (len < 0)
+					len = 0;
+				ret = copy_from_kernel_nofault(iter->fmt, str, len);
+				iter->fmt[len] = 0;
+				star = false;
+			} else {
+				ret = strncpy_from_kernel_nofault(iter->fmt, str,
+								  iter->fmt_size);
+			}
 			if (ret < 0)
 				trace_seq_printf(&iter->seq, "(0x%px)", str);
 			else
@@ -3775,7 +3795,10 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 			strncpy(iter->fmt, p + i, j + 1);
 			iter->fmt[j+1] = '\0';
 		}
-		trace_seq_printf(&iter->seq, iter->fmt, str);
+		if (star)
+			trace_seq_printf(&iter->seq, iter->fmt, len, str);
+		else
+			trace_seq_printf(&iter->seq, iter->fmt, str);
 
 		p += i + j + 1;
 	}
