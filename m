Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6D8391340
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 11:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbhEZJC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 05:02:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233509AbhEZJCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 05:02:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA0F36139A;
        Wed, 26 May 2021 09:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622019682;
        bh=4LkSpJL9u2Z/Gci2t2dDE6z+Mqs7NkRLNRbp9A49lfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e2TWdVg8Olt7pG61zwGIxs3HbdWT+0AstfVISWxj+I08+5zJyiEpLg9yT+Pg1ykqN
         k6tSwyc+0g/h+UxXTXSDTJTLvq8R44t4+Jwqc+0VGW63pr23ld4ltvyMAwrEr92qVV
         urw5vYu4JqFeJ3cJG2oUorUZTApZaQy2Vs0niaAqaFEMUUnatAM6flnxiQuw1h2BYm
         4eBTudXuY1FTNdV8XlgvjTb4hbpCHo9fbeKmXMu07IBchNX+sDbf2ZWIj2ZnIQmOoI
         eaBrepWbJsZZhmHIwDy/2+wVMUYGbnDdLHu/R4Xm5UTqJJfAKk+KTYSt/g0F924l4R
         0y7Lk0K+TxH4g==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>, acme@kernel.org
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, jolsa@redhat.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH] tools/perf: doc: Add permission and sysctl notice
Date:   Wed, 26 May 2021 18:01:18 +0900
Message-Id: <162201967838.287555.4257117900130102987.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210525043744.193297-1-ravi.bangoria@linux.ibm.com>
References: <20210525043744.193297-1-ravi.bangoria@linux.ibm.com>
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
 tools/perf/Documentation/perf-probe.txt |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-probe.txt b/tools/perf/Documentation/perf-probe.txt
index ed3ecfa422e1..38f60ac58a8e 100644
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
@@ -295,6 +295,17 @@ Add a probe in a source file using special characters by backslash escape
  ./perf probe -x /opt/test/a.out 'foo\+bar.c:4'
 
 
+PERMISSIONS AND SYSCTL
+----------------------
+Since perf probe depends on ftrace (tracefs) and kallsyms (/proc/kallsyms), you have to care about the permission and some sysctl knobs.
+
+ - Since tracefs and kallsyms requires root or privileged user to access it, the following perf probe commands also require it; --add, --del, --list (except for --cache option)
+
+ - /proc/sys/kernel/kptr_restrict = 2 (restrict all users) also prevents perf probe to retrieve the important information from kallsyms. You also need to set to 1 (restrict non CAP_SYSLOG users) for the above commands.
+
+ - Since the perf probe commands read the vmlinux and/or the debuginfo file, you need to ensure that you can read those files.
+
+
 SEE ALSO
 --------
 linkperf:perf-trace[1], linkperf:perf-record[1], linkperf:perf-buildid-cache[1]

