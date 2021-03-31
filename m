Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF78346F3D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbhCXCFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbhCXCFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:05:06 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207FAC0613D8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:04:56 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id o2so7101727plg.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bXxtCW2oZxmP3x76plR5OR7eL+Iwsnt548Hrnczvi0s=;
        b=S6cSluDj6YhWW9prtNuIV0DdyF5tJu/3FT+vPq5Gdn8171LLWnzHeGg6ax2R2QXa+v
         sB1YuoaqMyyIFTU+Eet/+YB49wmXHKUEf19imfEgcKTxjk/AMDj8tKTD1CNMzNM+gk3i
         zMxw+u+XlBX22H9+5UA3XMoZFnX+LkgFkErmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bXxtCW2oZxmP3x76plR5OR7eL+Iwsnt548Hrnczvi0s=;
        b=rBFF/bHGR1wQk4i+yyfRkNOCInsaf7xah/e3OqwXK91FxbY8uO2319s0oHNLZJqhD9
         ccHygE/JpHj4dlDJMSZnaDLqc0D53NWtk+IXj4tjSiVT2Rl08rFzGve8uUfypNEf9L4C
         dcjhrufw8yvp+sjLaUbewQxxgIE6zHCNFhhVuULLcbqtOyHgk+1Y/GadzMdSh2JU3J66
         nZrjJCTISfRBux2lKlQ6POe3acjOGo8/HY0nCfD6pAbvV9wYvRZYLUkp1TH8joLVLCXB
         ZV4v8VMTCTAmWxn9/lowjoJABiun+3hR1I7M60g5vgooBW9Ll14TK2QBsU1QwQY10pDa
         DfkQ==
X-Gm-Message-State: AOAM5310KB6RyxRaZVUZDujic1u4fvH2e7Hp4eHxw5157QwTR0E4GyGK
        mTMjEO4vJI1HIkXXVlrh9oR7nhJE5JUhBw==
X-Google-Smtp-Source: ABdhPJyl5fM8Z3vWDMYLWiFZkRLz0DCm5q1Ig0P65JZRbE/VrCn6kfLVQcOYoQYfGzroTiiIR0YHBw==
X-Received: by 2002:a17:90a:1a59:: with SMTP id 25mr977122pjl.54.1616551495402;
        Tue, 23 Mar 2021 19:04:55 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:84ac:62f7:16a8:ccc7])
        by smtp.gmail.com with ESMTPSA id b3sm389441pjg.41.2021.03.23.19.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 19:04:55 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Sasha Levin <sashal@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 07/12] scripts/decode_stacktrace.sh: Support debuginfod
Date:   Tue, 23 Mar 2021 19:04:38 -0700
Message-Id: <20210324020443.1815557-8-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210324020443.1815557-1-swboyd@chromium.org>
References: <20210324020443.1815557-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that stacktraces contain the build ID information we can update this
script to use debuginfod-find to locate the debuginfo for the vmlinux
and modules automatically. This can replace the existing code that
requires specifying a path to vmlinux or tries to find the vmlinux and
modules automatically by using the release number. Work it into the
script as a fallback option if the vmlinux isn't specified on the
commandline.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Evan Green <evgreen@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 scripts/decode_stacktrace.sh | 81 +++++++++++++++++++++++++++++++-----
 1 file changed, 70 insertions(+), 11 deletions(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 90398347e366..ca21f8bdf5f2 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -3,11 +3,10 @@
 # (c) 2014, Sasha Levin <sasha.levin@oracle.com>
 #set -x
 
-if [[ $# < 1 ]]; then
+usage() {
 	echo "Usage:"
 	echo "	$0 -r <release> | <vmlinux> [base path] [modules path]"
-	exit 1
-fi
+}
 
 if [[ $1 == "-r" ]] ; then
 	vmlinux=""
@@ -24,6 +23,7 @@ if [[ $1 == "-r" ]] ; then
 
 	if [[ $vmlinux == "" ]] ; then
 		echo "ERROR! vmlinux image for release $release is not found" >&2
+		usage
 		exit 2
 	fi
 else
@@ -31,12 +31,35 @@ else
 	basepath=${2-auto}
 	modpath=$3
 	release=""
+	debuginfod=
+
+	# Can we use debuginfod-find?
+	if type debuginfod-find >/dev/null 2>&1 ; then
+		debuginfod=${1-only}
+	fi
+
+	if [[ $vmlinux == "" && -z $debuginfod ]] ; then
+		echo "ERROR! vmlinux image must be specified" >&2
+		usage
+		exit 1
+	fi
 fi
 
 declare -A cache
 declare -A modcache
 
 find_module() {
+	if [[ -n $debuginfod ]] ; then
+		if [[ -n $modbuildid ]] ; then
+			debuginfod-find debuginfo $modbuildid && return
+		fi
+
+		# Only using debuginfod so don't try to find vmlinux module path
+		if [[ $debuginfod == "only" ]] ; then
+			return
+		fi
+	fi
+
 	if [[ "$modpath" != "" ]] ; then
 		for fn in $(find "$modpath" -name "${module//_/[-_]}.ko*") ; do
 			if readelf -WS "$fn" | grep -qwF .debug_line ; then
@@ -150,6 +173,27 @@ parse_symbol() {
 	symbol="$segment$name ($code)"
 }
 
+debuginfod_get_vmlinux() {
+	local vmlinux_buildid=${1##* }
+
+	if [[ $vmlinux != "" ]]; then
+		return
+	fi
+
+	if [[ $vmlinux_buildid =~ ^[0-9a-f]+ ]]; then
+		vmlinux=$(debuginfod-find debuginfo $vmlinux_buildid)
+		if [[ $? -ne 0 ]] ; then
+			echo "ERROR! vmlinux image not found via debuginfod-find" >&2
+			usage
+			exit 2
+		fi
+		return
+	fi
+	echo "ERROR! Build ID for vmlinux not found. Try passing -r or specifying vmlinux" >&2
+	usage
+	exit 2
+}
+
 decode_code() {
 	local scripts=`dirname "${BASH_SOURCE[0]}"`
 
@@ -157,6 +201,14 @@ decode_code() {
 }
 
 handle_line() {
+	if [[ $basepath == "auto" && $vmlinux != "" ]] ; then
+		module=""
+		symbol="kernel_init+0x0/0x0"
+		parse_symbol
+		basepath=${symbol#kernel_init (}
+		basepath=${basepath%/init/main.c:*)}
+	fi
+
 	local words
 
 	# Tokenize
@@ -182,16 +234,28 @@ handle_line() {
 		fi
 	done
 
+	if [[ ${words[$last]} =~ ^[0-9a-f]+\] ]]; then
+		words[$last-1]="${words[$last-1]} ${words[$last]}"
+		unset words[$last]
+		last=$(( $last - 1 ))
+	fi
+
 	if [[ ${words[$last]} =~ \[([^]]+)\] ]]; then
 		module=${words[$last]}
 		module=${module#\[}
 		module=${module%\]}
+		modbuildid=${module#* }
+		module=${module% *}
+		if [[ $modbuildid == $module ]]; then
+			modbuildid=
+		fi
 		symbol=${words[$last-1]}
 		unset words[$last-1]
 	else
 		# The symbol is the last element, process it
 		symbol=${words[$last]}
 		module=
+		modbuildid=
 	fi
 
 	unset words[$last]
@@ -201,14 +265,6 @@ handle_line() {
 	echo "${words[@]}" "$symbol $module"
 }
 
-if [[ $basepath == "auto" ]] ; then
-	module=""
-	symbol="kernel_init+0x0/0x0"
-	parse_symbol
-	basepath=${symbol#kernel_init (}
-	basepath=${basepath%/init/main.c:*)}
-fi
-
 while read line; do
 	# Let's see if we have an address in the line
 	if [[ $line =~ \[\<([^]]+)\>\] ]] ||
@@ -218,6 +274,9 @@ while read line; do
 	# Is it a code line?
 	elif [[ $line == *Code:* ]]; then
 		decode_code "$line"
+	# Is it a version line?
+	elif [[ -n $debuginfod && $line =~ PID:\ [0-9]+\ Comm: ]]; then
+		debuginfod_get_vmlinux "$line"
 	else
 		# Nothing special in this line, show it as is
 		echo "$line"
-- 
https://chromeos.dev

