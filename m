Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B2C40D0D1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 02:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbhIPA31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 20:29:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233373AbhIPA3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 20:29:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A032661165;
        Thu, 16 Sep 2021 00:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631752081;
        bh=TUp7fcMT+C8B/ZbNKJe9EiFQ76kLwa5jhwLsNullS78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XIsmltHm1lyjcXLjFqZ+6jh+tl+lTl6Vnese5c5GlAn9M8GVPDbPjYvBLUhBOMym3
         qrAEWBmG+gLZFMtw/ciz86cjS18Gb9/CifhcnI372Uo2l77q28btRFTDLjkrOkzkdm
         12s1sxBJEMAbUDdn9Ym0nwRLIOR6OFlReiOPBkTEXeCuQ7X76aa82wzuuwvyC/qBAz
         0Zj6AaNPCwvGHhLfImWA6Gql9reI9Ggzqv5/ZLQqp7TdMxNFVa1ZllpqwbtCTreOde
         163gRmSoeGjt8TIFju7+NCn56u69ZCPyBPwj0+YpW8kyGFk+8A87qfMAbGlS8uRWQE
         EALx3I9YXMtqw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7201D5C08DB; Wed, 15 Sep 2021 17:28:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/5] tools/rcu: Add an extract-stall script
Date:   Wed, 15 Sep 2021 17:27:58 -0700
Message-Id: <20210916002800.3910056-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210916002710.GA3909915@paulmck-ThinkPad-P17-Gen-1>
References: <20210916002710.GA3909915@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a script that extracts RCU CPU stall warnings
from console output.  The user can optionally specify the number of
lines preceding the stall to output, and also the number of lines of
stall-warning text.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/rcu/extract-stall.sh | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 tools/rcu/extract-stall.sh

diff --git a/tools/rcu/extract-stall.sh b/tools/rcu/extract-stall.sh
new file mode 100644
index 000000000000..d10ffbf7be0c
--- /dev/null
+++ b/tools/rcu/extract-stall.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+#
+# Extract any RCU CPU stall warnings present in specified file.
+# Filter out clocksource lines.  Note that preceding-lines excludes the
+# initial line of the stall warning but trailing-lines includes it.
+#
+# Usage: extract-stall.sh dmesg-file [ preceding-lines [ trailing-lines ] ]
+
+echo $1
+preceding_lines="${2-3}"
+trailing_lines="${3-10}"
+
+awk -v preceding_lines="$preceding_lines" -v trailing_lines="$trailing_lines" '
+suffix <= 0 {
+	for (i = preceding_lines; i > 0; i--)
+		last[i] = last[i - 1];
+	last[0] = $0;
+}
+
+suffix > 0 {
+	print $0;
+	suffix--;
+	if (suffix <= 0)
+		print "";
+}
+
+suffix <= 0 && /detected stall/ {
+	for (i = preceding_lines; i >= 0; i--)
+		if (last[i] != "")
+			print last[i];
+	suffix = trailing_lines;
+}' < "$1" | tr -d '\015' | grep -v clocksource
+
-- 
2.31.1.189.g2e36527f23

