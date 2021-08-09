Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941443E4936
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbhHIPua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:50:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235846AbhHIPtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:49:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 195B261019;
        Mon,  9 Aug 2021 15:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628524138;
        bh=cK2uJqFI5AdXUBCrjz4aXtOXtAxYE1DIL/pMeuROH0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nP/LoI03Ip0jHr3Dm0EYdeuHOnQOYonCVXlr32FzBekKsb364lKKaFCw5xcriKN9C
         Ch6QB+CUIJe05//grj3OmHHVEMy/QEgIInlxmfu7/yqzSjX5lx8PHl1yO1XF7HQv/x
         JO2qk8GjfBz2NY9PDMYh+qd6POn6c/49tXLm3UgWuHUHdgjlqJDJDBIoQKrOEM/Xrm
         vlqUz2u7zgTbMI0eAdz4O8TANh2YgVjof+rRDMoYfmCUmsEKUWEbPnuoAYR8GgzIPq
         zOMR6SqQ7zRFvoOZ6TYCK3xxkuuUMAksGqmXSPK1gX6D4q+7danF1o7QMW4wxVVIrs
         JySrkvwC5Wjrg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 09/10] tools/bootconfig: Use per-group/all enable option in ftrace2bconf script
Date:   Tue, 10 Aug 2021 00:48:56 +0900
Message-Id: <162852413662.143877.12860946285326517376.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162852406891.143877.12110677006587392853.stgit@devnote2>
References: <162852406891.143877.12110677006587392853.stgit@devnote2>
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

