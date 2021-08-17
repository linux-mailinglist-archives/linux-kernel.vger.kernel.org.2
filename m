Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1663EF2D3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbhHQToQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:44:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233642AbhHQTnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:43:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 768A06108F;
        Tue, 17 Aug 2021 19:43:06 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mG4zJ-004TTU-HD; Tue, 17 Aug 2021 15:43:05 -0400
Message-ID: <20210817194305.361166358@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 17 Aug 2021 15:42:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 15/19] tools/bootconfig: Add histogram syntax support to bconf2ftrace.sh
References: <20210817194207.947725935@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add histogram syntax support to bconf2ftrace.sh script.

Link: https://lkml.kernel.org/r/162856128672.203126.8240335908303312607.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/bootconfig/scripts/bconf2ftrace.sh | 88 ++++++++++++++++++++++++
 tools/bootconfig/scripts/xbc.sh          |  4 +-
 2 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/tools/bootconfig/scripts/bconf2ftrace.sh b/tools/bootconfig/scripts/bconf2ftrace.sh
index 651049c782c0..850c2073433e 100755
--- a/tools/bootconfig/scripts/bconf2ftrace.sh
+++ b/tools/bootconfig/scripts/bconf2ftrace.sh
@@ -94,6 +94,92 @@ compose_synth() { # event_name branch
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
+print_hist_var() { # prefix varname
+	echo -n ":${2}="`xbc_get_val ${1}.var.${2} | tr -d [:space:]`
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
+		print_hist_var ${1} ${__var}
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
@@ -121,6 +207,8 @@ setup_event() { # prefix group event [instance]
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
-- 
2.30.2
