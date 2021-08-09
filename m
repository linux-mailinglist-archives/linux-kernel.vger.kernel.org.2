Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318643E4938
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbhHIPuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:50:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235835AbhHIPtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:49:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99C1A60C40;
        Mon,  9 Aug 2021 15:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628524131;
        bh=bN5jMudffAgbzkQRA8EK/u0qcAvSIu1GfQdNNhtwo1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GLXm5+KmTIp9uZbOlSlHXPFwygCxamJyyZD/WBTL+sXhDqnldySftsFrJicCwYxyk
         hff/+HOcTH7lfTUVh+tJGfPfRc82z4vFkRhALntlGHzeMkn13XhXEiJg+zba3mwvUT
         vl8/tqfCjAY9G+vOhM9+dfoMNYk0M/UWGX3javigcT+YGwDQcVojqgBo0MziWSgNoz
         Ux8/hlzmrmdG+B9vTCFzUAHhbfcjARTBQJa8BcIUGzCGT4axgBb9Pa1HPWoO9hcbJW
         BV7Is11dDT9ggFpZ3fbti6agRzlLTmjoRzhDRqZD0GfIL4f/ZzJKVOhluOTD3sW4qs
         EcEIcGrTDqSrg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 08/10] tools/bootconfig: Add histogram syntax support to bconf2ftrace.sh
Date:   Tue, 10 Aug 2021 00:48:49 +0900
Message-Id: <162852412915.143877.6148633454351857164.stgit@devnote2>
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

Add histogram syntax support to bconf2ftrace.sh script.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/scripts/bconf2ftrace.sh |   84 ++++++++++++++++++++++++++++++
 tools/bootconfig/scripts/xbc.sh          |    4 +
 2 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/tools/bootconfig/scripts/bconf2ftrace.sh b/tools/bootconfig/scripts/bconf2ftrace.sh
index 651049c782c0..43b65a199010 100755
--- a/tools/bootconfig/scripts/bconf2ftrace.sh
+++ b/tools/bootconfig/scripts/bconf2ftrace.sh
@@ -94,6 +94,88 @@ compose_synth() { # event_name branch
 	xbc_get_val $2 | while read field; do echo -n "$field; "; done
 }
 
+print_hist_array() { # prefix key
+	__sep="="
+	if xbc_has_key ${1}.${2}; then
+		echo -n ":$2"
+		xbc_get_val ${1}.${2} | while read field; do
+			echo -n "$__sep$field"; __sep=","
+		done
+	fi
+}
+
+print_hist_action_array() { # prefix key
+	__sep="("
+	echo -n ".$2"
+	xbc_get_val ${1}.${2} | while read field; do
+		echo -n "$__sep$field"; __sep=","
+	done
+	echo -n ")"
+}
+
+print_hist_one_action() { # prefix handler param
+	echo -n ":${2}("`xbc_get_val ${1}.${3}`")"
+	if xbc_has_key "${1}.trace"; then
+		print_hist_action_array ${1} "trace"
+	elif xbc_has_key "${1}.save"; then
+		print_hist_action_array ${1} "save"
+	elif xbc_has_key "${1}.snapshot"; then
+		echo -n ".snapshot()"
+	fi
+}
+
+print_hist_actions() { # prefix handler param
+	for __hdr in `xbc_subkeys ${1}.${2} 1 ".[0-9]"`; do
+		print_hist_one_action ${1}.${2}.$__hdr ${2} ${3}
+	done
+	if xbc_has_key ${1}.${2}.${3} ; then
+		print_hist_one_action ${1}.${2} ${2} ${3}
+	fi
+}
+
+print_one_histogram() { # prefix
+	echo -n "hist"
+	print_hist_array $1 "keys"
+	print_hist_array $1 "values"
+	print_hist_array $1 "sort"
+	if xbc_has_key "${1}.size"; then
+		echo -n ":size="`xbc_get_val ${1}.size`
+	fi
+	if xbc_has_key "${1}.name"; then
+		echo -n ":name="`xbc_get_val ${1}.name`
+	fi
+	for __var in `xbc_subkeys "${1}.var" 1`; do
+		echo -n ":$__var="`xbc_get_val ${1}.var.${__var}`
+	done
+	if xbc_has_key "${1}.pause"; then
+		echo -n ":pause"
+	elif xbc_has_key "${1}.continue"; then
+		echo -n ":continue"
+	elif xbc_has_key "${1}.clear"; then
+		echo -n ":clear"
+	fi
+	print_hist_actions ${1} "onmax" "var"
+	print_hist_actions ${1} "onchange" "var"
+	print_hist_actions ${1} "onmatch" "event"
+
+	if xbc_has_key "${1}.filter"; then
+		echo -n " if "`xbc_get_val ${1}.filter`
+	fi
+}
+
+setup_one_histogram() { # prefix trigger-file
+	run_cmd "echo '`print_one_histogram ${1}`' >> ${2}"
+}
+
+setup_histograms() { # prefix trigger-file
+	for __hist in `xbc_subkeys ${1} 1 ".[0-9]"`; do
+		setup_one_histogram ${1}.$__hist ${2}
+	done
+	if xbc_has_key ${1}.keys; then
+		setup_one_histogram ${1} ${2}
+	fi
+}
+
 setup_event() { # prefix group event [instance]
 	branch=$1.$2.$3
 	if [ "$4" ]; then
@@ -121,6 +203,8 @@ setup_event() { # prefix group event [instance]
 	set_value_of ${branch}.filter ${eventdir}/filter
 	set_array_of ${branch}.actions ${eventdir}/trigger
 
+	setup_histograms ${branch}.hist ${eventdir}/trigger
+
 	if xbc_has_key ${branch}.enable; then
 		run_cmd "echo 1 > ${eventdir}/enable"
 	fi
diff --git a/tools/bootconfig/scripts/xbc.sh b/tools/bootconfig/scripts/xbc.sh
index b8c84e654556..1f0ebf50dd2d 100644
--- a/tools/bootconfig/scripts/xbc.sh
+++ b/tools/bootconfig/scripts/xbc.sh
@@ -49,8 +49,8 @@ xbc_has_branch() { # prefix-key
 	grep -q "^$1" $XBC_TMPFILE
 }
 
-xbc_subkeys() { # prefix-key depth
+xbc_subkeys() { # prefix-key depth [subkey-pattern]
 	__keys=`echo $1 | sed "s/\./ /g"`
 	__s=`nr_args $__keys`
-	grep "^$1" $XBC_TMPFILE | cut -d= -f1| cut -d. -f$((__s + 1))-$((__s + $2)) | uniq
+	grep "^$1$3" $XBC_TMPFILE | cut -d= -f1| cut -d. -f$((__s + 1))-$((__s + $2)) | uniq
 }

