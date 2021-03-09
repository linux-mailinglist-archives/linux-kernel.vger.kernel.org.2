Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586C1331F63
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 07:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhCIGjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 01:39:37 -0500
Received: from mail-lf1-f54.google.com ([209.85.167.54]:34699 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhCIGjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 01:39:07 -0500
Received: by mail-lf1-f54.google.com with SMTP id v9so25270899lfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 22:39:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lI4Y0ym2MRyh7P3eGGhPMMllSH0LqL9Xl8CVZBQeWNY=;
        b=ckvRO1aCa19At9eKeUEXhVLzNjOMgY8jGU2slNOmCeL2zacuZbRQpNVtmnxApw8FUd
         DMVWBlnS/NJvQsrq1fttrgEZ+KZxc2CKA2m2AY01BHdFgJMOI4QBeTigMEdbWAhMZITA
         4fX9facdYVqYe/Zbyra9FNY7XGvUSuIa2bN+u5XLMguAubFbDxaqS2j33RujJpaa/71W
         ThwvtwS8WnlQ++ZvIFgH5/KUv5Uge+xgBEQhtO8Eu7ecUHwiQ3zHrIkNp+Q50USEo4Lw
         QlNhUeEHcdn+oVJQM6EffuX/FUfHwqENcSf2mBuWhs0CuXFrpPY9ij+1ThC1lkv8YV1N
         GP/w==
X-Gm-Message-State: AOAM531IbAGIQM8HYswS70jaVHKnQeE/D+YjrwPCVmfiEgGupRfjHOJS
        r1Y82DLhJf8iMUBL3YTvj7WMAJVqslKWsQ==
X-Google-Smtp-Source: ABdhPJwPn4bAZxr1ER6dLdreaL03ebhvn/r6StR+N7kHfOKaCRoci7k7ypWw99y7zbZ2Z0X/rZuNjA==
X-Received: by 2002:a19:c185:: with SMTP id r127mr16171502lff.530.1615271945716;
        Mon, 08 Mar 2021 22:39:05 -0800 (PST)
Received: from localhost.. (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.googlemail.com with ESMTPSA id x36sm1623352lfu.129.2021.03.08.22.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 22:39:05 -0800 (PST)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] coccinelle: misc: add minmax script
Date:   Tue,  9 Mar 2021 09:39:03 +0300
Message-Id: <20210309063903.13231-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210216160326.1341741-1-efremov@linux.com>
References: <20210216160326.1341741-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check for opencoded min(), max() implementations.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
Changes in v2:
 - <... ...> instead of ... when any
 - org mode reports fixed
 - patch rule to drop excessive ()
Changes in v3:
 - "depends on patch && (pmax || pmaxif || pmin || pminif)" fixed
Changes in v4:
 - refarmatting rule removed
 - () brackets added to the patch rules to omit excessive ones
 - org/report prints changed to cycle (for p0 in p: ...)
Changes in v5:
 - parentheses droppped in pminif and pmaxif rules (max_val = x ...)

 scripts/coccinelle/misc/minmax.cocci | 206 +++++++++++++++++++++++++++
 1 file changed, 206 insertions(+)
 create mode 100644 scripts/coccinelle/misc/minmax.cocci

diff --git a/scripts/coccinelle/misc/minmax.cocci b/scripts/coccinelle/misc/minmax.cocci
new file mode 100644
index 000000000000..eccdd3eb3452
--- /dev/null
+++ b/scripts/coccinelle/misc/minmax.cocci
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Check for opencoded min(), max() implementations.
+/// Generated patches sometimes require adding a cast to fix compile warning.
+/// Warnings/patches scope intentionally limited to a function body.
+///
+// Confidence: Medium
+// Copyright: (C) 2021 Denis Efremov ISPRAS
+// Options: --no-includes --include-headers
+//
+// Keywords: min, max
+//
+
+
+virtual report
+virtual org
+virtual context
+virtual patch
+
+@rmax depends on !patch@
+identifier func;
+expression x, y;
+binary operator cmp = {>, >=};
+position p;
+@@
+
+func(...)
+{
+	<...
+*	((x) cmp@p (y) ? (x) : (y))
+	...>
+}
+
+@rmaxif depends on !patch@
+identifier func;
+expression x, y;
+expression max_val;
+binary operator cmp = {>, >=};
+position p;
+@@
+
+func(...)
+{
+	<...
+*	if ((x) cmp@p (y)) {
+*		max_val = (x);
+*	} else {
+*		max_val = (y);
+*	}
+	...>
+}
+
+@rmin depends on !patch@
+identifier func;
+expression x, y;
+binary operator cmp = {<, <=};
+position p;
+@@
+
+func(...)
+{
+	<...
+*	((x) cmp@p (y) ? (x) : (y))
+	...>
+}
+
+@rminif depends on !patch@
+identifier func;
+expression x, y;
+expression min_val;
+binary operator cmp = {<, <=};
+position p;
+@@
+
+func(...)
+{
+	<...
+*	if ((x) cmp@p (y)) {
+*		min_val = (x);
+*	} else {
+*		min_val = (y);
+*	}
+	...>
+}
+
+@pmax depends on patch@
+identifier func;
+expression x, y;
+binary operator cmp = {>=, >};
+@@
+
+func(...)
+{
+	<...
+-	((x) cmp (y) ? (x) : (y))
++	max(x, y)
+	...>
+}
+
+@pmaxif depends on patch@
+identifier func;
+expression x, y;
+expression max_val;
+binary operator cmp = {>=, >};
+@@
+
+func(...)
+{
+	<...
+-	if ((x) cmp (y)) {
+-		max_val = x;
+-	} else {
+-		max_val = y;
+-	}
++	max_val = max(x, y);
+	...>
+}
+
+@pmin depends on patch@
+identifier func;
+expression x, y;
+binary operator cmp = {<=, <};
+@@
+
+func(...)
+{
+	<...
+-	((x) cmp (y) ? (x) : (y))
++	min(x, y)
+	...>
+}
+
+@pminif depends on patch@
+identifier func;
+expression x, y;
+expression min_val;
+binary operator cmp = {<=, <};
+@@
+
+func(...)
+{
+	<...
+-	if ((x) cmp (y)) {
+-		min_val = x;
+-	} else {
+-		min_val = y;
+-	}
++	min_val = min(x, y);
+	...>
+}
+
+@script:python depends on report@
+p << rmax.p;
+@@
+
+for p0 in p:
+	coccilib.report.print_report(p0, "WARNING opportunity for max()")
+
+@script:python depends on org@
+p << rmax.p;
+@@
+
+for p0 in p:
+	coccilib.org.print_todo(p0, "WARNING opportunity for max()")
+
+@script:python depends on report@
+p << rmaxif.p;
+@@
+
+for p0 in p:
+	coccilib.report.print_report(p0, "WARNING opportunity for max()")
+
+@script:python depends on org@
+p << rmaxif.p;
+@@
+
+for p0 in p:
+	coccilib.org.print_todo(p0, "WARNING opportunity for max()")
+
+@script:python depends on report@
+p << rmin.p;
+@@
+
+for p0 in p:
+	coccilib.report.print_report(p0, "WARNING opportunity for min()")
+
+@script:python depends on org@
+p << rmin.p;
+@@
+
+for p0 in p:
+	coccilib.org.print_todo(p0, "WARNING opportunity for min()")
+
+@script:python depends on report@
+p << rminif.p;
+@@
+
+for p0 in p:
+	coccilib.report.print_report(p0, "WARNING opportunity for min()")
+
+@script:python depends on org@
+p << rminif.p;
+@@
+
+for p0 in p:
+	coccilib.org.print_todo(p0, "WARNING opportunity for min()")
-- 
2.26.2

