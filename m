Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBF9400BFE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 18:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbhIDPzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 11:55:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237011AbhIDPze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 11:55:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE1F660E76;
        Sat,  4 Sep 2021 15:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630770873;
        bh=SCKucT1BlxN+J/e1D2NDLNz2pyzTVB+aoykvj2r+4qM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rx95aXp7x3+FY2kBsdok77nnDR45Zu2koit3o51n3H5AHSwDdTn0eQB24KuF7VFFV
         OLYkJYvv3hB87zxEVdT/KPCsS6UL1CnYLdg3Upb+T4sX1rTsqX5V9QDHbz0S0FqCy7
         UF7AHu5vtaYh0Y0/IOO9sGNRv4Gq29z7/J8L6l4ljUMBKHxIibXpAWuRemCTAdShWu
         Jo8HwCBavEOz1+RUdYEO6GAGmx2Bd5BipWcKzcKLXE+pgbxqm2HqCW1yQhIrafKVvY
         nm6FzOZwQwuaM7AH0uyr6jLlufSgRMPEi7XydOy4HtM7Gc8VJGJ0Ch7Cssoqi3Gw1/
         11oNin01RTQaw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/6] tools/bootconfig: Fix tracing_on option checking in ftrace2bconf.sh
Date:   Sun,  5 Sep 2021 00:54:31 +0900
Message-Id: <163077087144.222577.6888011847727968737.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163077084169.222577.4459698040375322439.stgit@devnote2>
References: <163077084169.222577.4459698040375322439.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since tracing_on indicates only "1" (default) or "0", ftrace2bconf.sh
only need to check the value is "0".

Fixes: 55ed4560774d ("tools/bootconfig: Add tracing_on support to helper scripts")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/scripts/ftrace2bconf.sh |    4 ++--
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

