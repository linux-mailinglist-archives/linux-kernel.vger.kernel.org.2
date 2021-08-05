Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A94F3E1973
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 18:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbhHEQ0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 12:26:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232466AbhHEQ0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 12:26:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8978161159;
        Thu,  5 Aug 2021 16:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628180791;
        bh=cK2uJqFI5AdXUBCrjz4aXtOXtAxYE1DIL/pMeuROH0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C1gg/3Cooba5uVxMp4xCeERsBe2mR/DbbWlMCB7rKBxPzvv0UCclXbxmhUL1ee+FH
         dHzYJSReq2BA/aY+U9l2CTrLDuk4H7IiSOxWRTcA2A0SBpraqM01KW2ry5Tux+2Tm0
         xSlkXi/goDzM4tiwjGdQLXw/Asurpd6c+lDP8XqrfWW2gGMDICwK+JZi9bKMJy0ppy
         l+ICE2PqFsrP+Q2OI6D8tp7sSNPyb7agoT/pYzPVfmFvJkS2Xn9Zpl6korza315HY8
         1xhC/Eq0sIiaDZgMpA44BQzbsYXp1YhSnEBG6Zc/ffrarNKG9EWBcJ4OdUdxRyCUb0
         RMpyQRIR3sNgA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 9/9] tools/bootconfig: Use per-group/all enable option in ftrace2bconf script
Date:   Fri,  6 Aug 2021 01:26:29 +0900
Message-Id: <162818078888.226227.17382509231240637807.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162818072104.226227.18088999222035270055.stgit@devnote2>
References: <162818072104.226227.18088999222035270055.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use per-group/all enable option instead of ftrace.events option.
This will make the bootconfig file more readable.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/scripts/ftrace2bconf.sh |   24 ++++++++++++++++++------
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

