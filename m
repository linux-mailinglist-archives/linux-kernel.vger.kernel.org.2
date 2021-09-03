Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE98400178
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 16:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349478AbhICOss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 10:48:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230332AbhICOsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 10:48:46 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92C7960F91;
        Fri,  3 Sep 2021 14:47:46 +0000 (UTC)
Date:   Fri, 3 Sep 2021 10:47:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [for-next][PATCH] tracing/doc: Fix table format in histogram code
Message-ID: <20210903104745.42609c15@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 4420f5b1be7b117330526f3eabd13d840f510b15


Steven Rostedt (VMware) (1):
      tracing/doc: Fix table format in histogram code

----
 Documentation/trace/histogram.rst | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)
---------------------------
commit 4420f5b1be7b117330526f3eabd13d840f510b15
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Mon Aug 23 10:00:07 2021 -0400

    tracing/doc: Fix table format in histogram code
    
    The addition of the buckets conversion for the histogram code, updated the
    documentation table of available conversions, but did not update the format
    to accommodate the extra size needed to cover the description.
    
    Link: https://lkml.kernel.org/r/20210823100007.71ce2ba9@oasis.local.home
    
    Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 4e650671f245..533415644c54 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -70,16 +70,16 @@ Documentation written by Tom Zanussi
   modified by appending any of the following modifiers to the field
   name:
 
-	=========== ==========================================
-        .hex        display a number as a hex value
-	.sym        display an address as a symbol
-	.sym-offset display an address as a symbol and offset
-	.syscall    display a syscall id as a system call name
-	.execname   display a common_pid as a program name
-	.log2       display log2 value rather than raw number
+	=============  =================================================
+        .hex           display a number as a hex value
+	.sym           display an address as a symbol
+	.sym-offset    display an address as a symbol and offset
+	.syscall       display a syscall id as a system call name
+	.execname      display a common_pid as a program name
+	.log2          display log2 value rather than raw number
 	.buckets=size  display grouping of values rather than raw number
-	.usecs      display a common_timestamp in microseconds
-	=========== ==========================================
+	.usecs         display a common_timestamp in microseconds
+	=============  =================================================
 
   Note that in general the semantics of a given field aren't
   interpreted when applying a modifier to it, but there are some
