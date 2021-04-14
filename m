Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23FA35FACC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351634AbhDNS2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:28:07 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:32956 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbhDNS2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:28:06 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id AA59872C8B5;
        Wed, 14 Apr 2021 21:27:42 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.250])
        by imap.altlinux.org (Postfix) with ESMTPSA id 813904A46E8;
        Wed, 14 Apr 2021 21:27:42 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Vitaly Chikunov <vt@altlinux.org>
Subject: [PATCH v2] perf beauty: Fix fsconfig generator
Date:   Wed, 14 Apr 2021 21:27:23 +0300
Message-Id: <20210414182723.1670663-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After gnulib update sed stopped matching `[[:space:]]*+' as before,
causing the following compilation error:

  In file included from builtin-trace.c:719:
  trace/beauty/generated/fsconfig_arrays.c:2:3: error: expected expression before ']' token
      2 |  [] = "",
	|   ^
  trace/beauty/generated/fsconfig_arrays.c:2:3: error: array index in initializer not of integer type
  trace/beauty/generated/fsconfig_arrays.c:2:3: note: (near initialization for 'fsconfig_cmds')

Fix this by correcting the regular expression used in the generator.
Also, clean up the script by removing redundant egrep, xargs, and printf
invocations.

Fixes: d35293004a5e4 ("perf beauty: Add generator for fsconfig's 'cmd' arg values")
Co-authored-by: Dmitry V. Levin <ldv@altlinux.org>
Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 tools/perf/trace/beauty/fsconfig.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/trace/beauty/fsconfig.sh b/tools/perf/trace/beauty/fsconfig.sh
index 83fb24df05c9f..bc6ef7bb7a5f9 100755
--- a/tools/perf/trace/beauty/fsconfig.sh
+++ b/tools/perf/trace/beauty/fsconfig.sh
@@ -10,8 +10,7 @@ fi
 linux_mount=${linux_header_dir}/mount.h
 
 printf "static const char *fsconfig_cmds[] = {\n"
-regex='^[[:space:]]*+FSCONFIG_([[:alnum:]_]+)[[:space:]]*=[[:space:]]*([[:digit:]]+)[[:space:]]*,[[:space:]]*.*'
-egrep $regex ${linux_mount} | \
-	sed -r "s/$regex/\2 \1/g"	| \
-	xargs printf "\t[%s] = \"%s\",\n"
+ms='[[:space:]]*'
+sed -nr "s/^${ms}FSCONFIG_([[:alnum:]_]+)${ms}=${ms}([[:digit:]]+)${ms},.*/\t[\2] = \"\1\",/p" \
+	${linux_mount}
 printf "};\n"
-- 
2.11.0

