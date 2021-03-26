Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7403434B15B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 22:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhCZVaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 17:30:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230026AbhCZV31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 17:29:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F22CC61A2D;
        Fri, 26 Mar 2021 21:29:26 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lPu1F-002DQt-V0; Fri, 26 Mar 2021 17:29:25 -0400
Message-ID: <20210326212925.845360548@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Mar 2021 17:28:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 2/6] scripts/recordmcount.pl: Make vim and emacs indent the same
References: <20210326212848.385566448@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

By default, emacs indents Perl files with 4 spaces, but will use tabs
where 8 spaces are used. Add a vim command of softtabstop=4, to make vim
behave the same. This should remove the issue of developers using vim
having causing different indentation.

"John (Warthog9) Hawley" <warthog9@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 scripts/recordmcount.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 5652da5e345e..a5429b3dac24 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -642,3 +642,5 @@ if ($#converts >= 0) {
 `$rm $mcount_o $mcount_s`;
 
 exit(0);
+
+# vim: softtabstop=4
-- 
2.30.1


