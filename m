Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E93A372368
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 01:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhECXHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 19:07:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229813AbhECXHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 19:07:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BCB861165;
        Mon,  3 May 2021 23:06:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1ldheT-009Y9D-H9; Mon, 03 May 2021 19:06:57 -0400
Message-ID: <20210503230657.413658014@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 03 May 2021 19:05:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>,
        "John Warthog9 Hawley (VMware)" <warthog9@eaglescrag.net>
Subject: [for-next][PATCH 3/7] ktest: Adding editor hints to improve consistency
References: <20210503230510.845068955@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "John 'Warthog9' Hawley (VMware)" <warthog9@eaglescrag.net>

Emacs and Vi(m) have different styles of dealing with perl syntax
which can lead to slightly inconsistent indentation, and makes the
code slightly harder to read.  Emacs assumes a more perl recommended
standard of 4 spaces (1 column) or tab (two column) indentation.

Vi(m) tends to favor just normal spaces or tabs depending on what
was being used.

This gives the basic hinting to Emacs and Vim to do what is
expected to be basically consistent.

Emacs:
	- Explicitly flip into perl mode, cperl would require
	  more adjustments

Vi(m):
	- Set softtabs=4 which will flip it over to doing
	  indentation the way you would expect from Emacs

Signed-off-by: John 'Warthog9' Hawley (VMware) <warthog9@eaglescrag.net>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 18fd4fd117dd..14a753b86445 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -4520,3 +4520,12 @@ if (defined($opt{"LOG_FILE"})) {
 }
 
 exit 0;
+
+##
+# The following are here to standardize tabs/spaces/etc across the most likely editors
+###
+
+# Local Variables:
+# mode: perl
+# End:
+# vim: softtabstop=4
-- 
2.30.1


