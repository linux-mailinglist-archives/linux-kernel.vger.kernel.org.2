Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A927D391AC8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbhEZOxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:53:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235077AbhEZOxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:53:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 837B1613B0;
        Wed, 26 May 2021 14:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622040693;
        bh=q+C2OhfEzhvJRz37H2GbJ1ehvlpy634ux7zEZguaxBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RhxCwRfd2fvBHl+15tMgD7vNuliCOJLce1otPWSZXSADVoEIa1sSAafq72+rBwsTp
         PxyE8CXuCTErAONVMUmkGwFIQAbj336XmHJjTmEAKIQfA1AfAGRuWDYChnYX1U086n
         J5E6DysobqoWxHNs7/j4PCdbWmqgA71/svmDr/k3IQmP5PNz6TRfnUQEU7LpIalaXA
         rDYdlFnywBbxM4CLHymM3LmzI4R2q0LYqtkGc0A5BpdO+QFlZxU4ZoBXXF0LNdGiw/
         rhumeBJKoxxyKjBJ+kqy3vLoEGCvubeCtenjjs/CxHypamd/rEsebcV+DtDiX9CdYK
         x9Wm06D59cU+w==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>, acme@kernel.org
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, jolsa@redhat.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v2] tools/perf: doc: Add permission and sysctl notice
Date:   Wed, 26 May 2021 23:51:29 +0900
Message-Id: <162204068898.388434.16842705842611255787.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162201967838.287555.4257117900130102987.stgit@devnote2>
References: <162201967838.287555.4257117900130102987.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a section to notify the permission and sysctl setting
for perf probe. And fix some indentations.

Reported-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v2:
  - Add tracefs remount option for --list command.
  - Mention uprobe case for kptr_restrict and vmlinux/debuginfo permission.
---
 tools/perf/Documentation/perf-probe.txt |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-probe.txt b/tools/perf/Documentation/perf-probe.txt
index ed3ecfa422e1..080981d38d7b 100644
--- a/tools/perf/Documentation/perf-probe.txt
+++ b/tools/perf/Documentation/perf-probe.txt
@@ -226,7 +226,7 @@ So, "source.c:100-120" shows lines between 100th to l20th in source.c file. And
 
 LAZY MATCHING
 -------------
- The lazy line matching is similar to glob matching but ignoring spaces in both of pattern and target. So this accepts wildcards('*', '?') and character classes(e.g. [a-z], [!A-Z]).
+The lazy line matching is similar to glob matching but ignoring spaces in both of pattern and target. So this accepts wildcards('*', '?') and character classes(e.g. [a-z], [!A-Z]).
 
 e.g.
  'a=*' can matches 'a=b', 'a = b', 'a == b' and so on.
@@ -235,8 +235,8 @@ This provides some sort of flexibility and robustness to probe point definitions
 
 FILTER PATTERN
 --------------
- The filter pattern is a glob matching pattern(s) to filter variables.
- In addition, you can use "!" for specifying filter-out rule. You also can give several rules combined with "&" or "|", and fold those rules as one rule by using "(" ")".
+The filter pattern is a glob matching pattern(s) to filter variables.
+In addition, you can use "!" for specifying filter-out rule. You also can give several rules combined with "&" or "|", and fold those rules as one rule by using "(" ")".
 
 e.g.
  With --filter "foo* | bar*", perf probe -V shows variables which start with "foo" or "bar".
@@ -295,6 +295,19 @@ Add a probe in a source file using special characters by backslash escape
  ./perf probe -x /opt/test/a.out 'foo\+bar.c:4'
 
 
+PERMISSIONS AND SYSCTL
+----------------------
+Since perf probe depends on ftrace (tracefs) and kallsyms (/proc/kallsyms), you have to care about the permission and some sysctl knobs.
+
+ - Since tracefs and kallsyms requires root or privileged user to access it, the following perf probe commands also require it; --add, --del, --list (except for --cache option)
+
+ - The system admin can remount the tracefs with 755 (`sudo mount -o remount,mode=755 /sys/kernel/tracing/`) to allow unprivileged user to run the perf probe --list command.
+
+ - /proc/sys/kernel/kptr_restrict = 2 (restrict all users) also prevents perf probe to retrieve the important information from kallsyms. You also need to set to 1 (restrict non CAP_SYSLOG users) for the above commands. Since the user-space probe doesn't need to access kallsyms, this is only for probing the kernel function (kprobes).
+
+ - Since the perf probe commands read the vmlinux (for kernel) and/or the debuginfo file (including user-space application), you need to ensure that you can read those files.
+
+
 SEE ALSO
 --------
 linkperf:perf-trace[1], linkperf:perf-record[1], linkperf:perf-buildid-cache[1]

