Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA613EF2CD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbhHQToJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:44:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233639AbhHQTnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:43:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4250D6108B;
        Tue, 17 Aug 2021 19:43:06 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mG4zJ-004TSv-Az; Tue, 17 Aug 2021 15:43:05 -0400
Message-ID: <20210817194305.174454518@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 17 Aug 2021 15:42:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 14/19] tools/bootconfig: Support per-group/all event enabling option
References: <20210817194207.947725935@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add group or all event enabling syntax support to bconf2ftrace.sh.
User can pass a bootconfig file which includes

ftrace[.instance.INSTANCE].event.enable

    and

ftrace[.instance.INSTANCE].event.GROUP.enable

correctly.

Link: https://lkml.kernel.org/r/162856127850.203126.16694505101982548237.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/bootconfig/scripts/bconf2ftrace.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/bootconfig/scripts/bconf2ftrace.sh b/tools/bootconfig/scripts/bconf2ftrace.sh
index feb30c2c7881..651049c782c0 100755
--- a/tools/bootconfig/scripts/bconf2ftrace.sh
+++ b/tools/bootconfig/scripts/bconf2ftrace.sh
@@ -101,6 +101,12 @@ setup_event() { # prefix group event [instance]
 	else
 		eventdir="$TRACEFS/events/$2/$3"
 	fi
+	# group enable
+	if [ "$3" = "enable" ]; then
+		run_cmd "echo 1 > ${eventdir}"
+		return
+	fi
+
 	case $2 in
 	kprobes)
 		xbc_get_val ${branch}.probes | while read line; do
@@ -127,6 +133,13 @@ setup_events() { # prefix("ftrace" or "ftrace.instance.INSTANCE") [instance]
 			setup_event $prefix ${grpev%.*} ${grpev#*.} $2
 		done
 	fi
+	if xbc_has_branch ${1}.event.enable; then
+		if [ "$2" ]; then
+			run_cmd "echo 1 > $TRACEFS/instances/$2/events/enable"
+		else
+			run_cmd "echo 1 > $TRACEFS/events/enable"
+		fi
+	fi
 }
 
 size2kb() { # size[KB|MB]
-- 
2.30.2
