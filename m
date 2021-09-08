Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42BEB403FBD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 21:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352365AbhIHTVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 15:21:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350518AbhIHTVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 15:21:32 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 194266117A;
        Wed,  8 Sep 2021 19:20:24 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mO36w-0014a3-J1; Wed, 08 Sep 2021 15:19:54 -0400
Message-ID: <20210908191954.427951440@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Sep 2021 15:18:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 07/12] tools/bootconfig: Fix tracing_on option checking in ftrace2bconf.sh
References: <20210908191851.381347939@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Since tracing_on indicates only "1" (default) or "0", ftrace2bconf.sh
only need to check the value is "0".

Link: https://lkml.kernel.org/r/163077087144.222577.6888011847727968737.stgit@devnote2

Fixes: 55ed4560774d ("tools/bootconfig: Add tracing_on support to helper scripts")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/bootconfig/scripts/ftrace2bconf.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
index fbaf07dc91bf..6183b36c6846 100755
--- a/tools/bootconfig/scripts/ftrace2bconf.sh
+++ b/tools/bootconfig/scripts/ftrace2bconf.sh
@@ -239,8 +239,8 @@ instance_options() { # [instance-name]
 		emit_kv $PREFIX.cpumask = $val
 	fi
 	val=`cat $INSTANCE/tracing_on`
-	if [ `echo $val | sed -e s/f//g`x != x ]; then
-		emit_kv $PREFIX.tracing_on = $val
+	if [ "$val" = "0" ]; then
+		emit_kv $PREFIX.tracing_on = 0
 	fi
 
 	val=`cat $INSTANCE/current_tracer`
-- 
2.32.0
