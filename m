Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF0C403FB8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 21:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350602AbhIHTVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 15:21:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350342AbhIHTV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 15:21:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F24861168;
        Wed,  8 Sep 2021 19:20:18 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mO36w-0014b7-Ui; Wed, 08 Sep 2021 15:19:54 -0400
Message-ID: <20210908191954.792495707@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Sep 2021 15:19:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 09/12] tools/bootconfig: Show whole test command for each test case
References: <20210908191851.381347939@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Show whole test command instead of only the 3rd argument.
This will clear to show what will be actually tested by
each test case.

Link: https://lkml.kernel.org/r/163077088607.222577.14786016266462495017.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/bootconfig/test-bootconfig.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index baed891d0ba4..f68e2e9eef8b 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -26,7 +26,7 @@ trap cleanup EXIT TERM
 NO=1
 
 xpass() { # pass test command
-  echo "test case $NO ($3)... "
+  echo "test case $NO ($*)... "
   if ! ($@ && echo "\t\t[OK]"); then
      echo "\t\t[NG]"; NG=$((NG + 1))
   fi
@@ -34,7 +34,7 @@ xpass() { # pass test command
 }
 
 xfail() { # fail test command
-  echo "test case $NO ($3)... "
+  echo "test case $NO ($*)... "
   if ! (! $@ && echo "\t\t[OK]"); then
      echo "\t\t[NG]"; NG=$((NG + 1))
   fi
-- 
2.32.0
