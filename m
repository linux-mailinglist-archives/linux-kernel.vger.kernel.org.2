Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EF53EF2D2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbhHQToO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:44:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233293AbhHQTnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:43:40 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A188E61042;
        Tue, 17 Aug 2021 19:43:06 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mG4zJ-004TU3-NC; Tue, 17 Aug 2021 15:43:05 -0400
Message-ID: <20210817194305.555815365@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 17 Aug 2021 15:42:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 16/19] tools/bootconfig: Use per-group/all enable option in ftrace2bconf
 script
References: <20210817194207.947725935@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Use per-group/all enable option instead of ftrace.events option.
This will make the bootconfig file more readable.

Link: https://lkml.kernel.org/r/162856129436.203126.12462564671412940618.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/bootconfig/scripts/ftrace2bconf.sh | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
index a0c3bcc6da4f..fbaf07dc91bf 100755
--- a/tools/bootconfig/scripts/ftrace2bconf.sh
+++ b/tools/bootconfig/scripts/ftrace2bconf.sh
@@ -92,6 +92,10 @@ referred_vars() {
 	grep "^hist" $1/trigger | grep -o '$[a-zA-Z0-9]*'
 }
 
+event_is_enabled() { # enable-file
+	test -f $1 & grep -q "1" $1
+}
+
 per_event_options() { # event-dir
 	evdir=$1
 	# Check the special event which has no filter and no trigger
@@ -113,7 +117,9 @@ per_event_options() { # event-dir
 		emit_kv $PREFIX.event.$group.$event.actions += \'$action\'
 	done
 
-	# enable is not checked; this is done by set_event in the instance.
+	if [ $GROUP_ENABLED -eq 0 ] && event_is_enabled $evdir/enable; then
+		emit_kv $PREFIX.event.$group.$event.enable
+	fi
 	val=`cat $evdir/filter`
 	if [ "$val" != "none" ]; then
 		emit_kv $PREFIX.event.$group.$event.filter = "$val"
@@ -137,8 +143,19 @@ event_options() {
 		kprobe_event_options
 		synth_event_options
 	fi
+	ALL_ENABLED=0
+	if event_is_enabled $INSTANCE/events/enable; then
+		emit_kv $PREFIX.event.enable
+		ALL_ENABLED=1
+	fi
 	for group in `ls $INSTANCE/events/` ; do
 		[ ! -d $INSTANCE/events/$group ] && continue
+		GROUP_ENABLED=$ALL_ENABLED
+		if [ $ALL_ENABLED -eq 0 ] && \
+		   event_is_enabled $INSTANCE/events/$group/enable ;then
+			emit_kv $PREFIX.event.$group.enable
+			GROUP_ENABLED=1
+		fi
 		for event in `ls $INSTANCE/events/$group/` ;do
 			[ ! -d $INSTANCE/events/$group/$event ] && continue
 			per_event_options $INSTANCE/events/$group/$event
@@ -226,11 +243,6 @@ instance_options() { # [instance-name]
 		emit_kv $PREFIX.tracing_on = $val
 	fi
 
-	val=
-	for i in `cat $INSTANCE/set_event`; do
-		val="$val, $i"
-	done
-	[ "$val" ] && emit_kv $PREFIX.events = "${val#,}"
 	val=`cat $INSTANCE/current_tracer`
 	[ $val != nop ] && emit_kv $PREFIX.tracer = $val
 	if grep -qv "^#" $INSTANCE/set_ftrace_filter $INSTANCE/set_ftrace_notrace; then
-- 
2.30.2
