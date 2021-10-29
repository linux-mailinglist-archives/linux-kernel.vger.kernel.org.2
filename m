Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B8E4404F1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 23:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhJ2VfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 17:35:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230077AbhJ2VfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 17:35:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4176060FED;
        Fri, 29 Oct 2021 21:32:44 +0000 (UTC)
Date:   Fri, 29 Oct 2021 17:32:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [for-next][PATCH] tracing/histogram: Fix documentation inline
 emphasis warning
Message-ID: <20211029173242.620e2eff@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 93d76e4a0e0112b320c4f0e2a3930ad634628c58


Kalesh Singh (1):
      tracing/histogram: Fix documentation inline emphasis warning

----
 Documentation/trace/histogram.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---------------------------
commit 93d76e4a0e0112b320c4f0e2a3930ad634628c58
Author: Kalesh Singh <kaleshsingh@google.com>
Date:   Thu Oct 28 10:05:48 2021 -0700

    tracing/histogram: Fix documentation inline emphasis warning
    
    This fixes the warning:
    
    Documentation/trace/histogram.rst:1766: WARNING: Inline emphasis
    start-string without end-string
    
    The issue was caused by an unescaped '*' character.
    
    Link: https://lore.kernel.org/all/20211028170548.2597449-1-kaleshsingh@google.com/T/#m77da47432f5cc6521d4294ffdb9621949cc35d04
    Link: https://lkml.kernel.org/r/20211028170548.2597449-1-kaleshsingh@google.com
    
    Fixes: 2d2f6d4b8ce7 ("tracing/histogram: Document expression arithmetic and constants")
    Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index e12699abaee8..66ec972dfb78 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -1764,7 +1764,7 @@ using the same key and variable from yet another event::
   # echo 'hist:key=pid:wakeupswitch_lat=$wakeup_lat+$switchtime_lat ...' >> event3/trigger
 
 Expressions support the use of addition, subtraction, multiplication and
-division operators (+-*/).
+division operators (+-\*/).
 
 Note that division by zero always returns -1.
 
