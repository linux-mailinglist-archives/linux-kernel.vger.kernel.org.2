Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349BF31CD86
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 17:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhBPQF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 11:05:27 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:36483 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhBPQEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:04:20 -0500
Received: by mail-lj1-f174.google.com with SMTP id k22so11829933ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 08:03:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o4/al9HbxUJ6dIQSP/cYBFZuT9Xf6OYChnIzkZS7oOg=;
        b=qoPOOOfqGUoCfWf+aCLlh17PzvB2mRrg7Xf068Rjn3fR1Mw6+OwJYDR/kHK3e4IESJ
         UEQkgOz9G8FOx5XQ4hC86CJ2xGV+OzP63FKtpd4DHVu/YVDQPlsdXjHuYFEB7FtcIzId
         Nv1i5LLXXrPv0re7PmBFIjIkeXI3kVXnLAEn9kw7qM8tQti/i7jniUYNoYmlVW3Yl6sD
         O6lYiS4wxTOvcQ7aNW8IkuLcgWoNseBELhKZDRsHCi91i7FIAeC509QHRY8meFIaSYli
         reww01a7YVIpTUT2v76H3Kl/y8B/0wwGs3FxAK99MSeYGREdbZHQ5oBA6ebTj7Ot5o78
         +AzQ==
X-Gm-Message-State: AOAM533F32gtvFwGp0j5t4rr21q5Y1ysyMaLDqW5G6VOwYWX2BF4czGr
        xzOEB41uvocPcATSYqHwPYo=
X-Google-Smtp-Source: ABdhPJx8IlxD7Zgl9Uoi0VptdlQbdJH7lD+YsyE/rrdvhDOak+7SeCbwS4RJJ2wi87BXJ2RueZYGRA==
X-Received: by 2002:a05:651c:2125:: with SMTP id a37mr12855346ljq.19.1613491406542;
        Tue, 16 Feb 2021 08:03:26 -0800 (PST)
Received: from localhost.localdomain (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.googlemail.com with ESMTPSA id y19sm992465lji.31.2021.02.16.08.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 08:03:25 -0800 (PST)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH] coccinelle: misc: add minmax script
Date:   Tue, 16 Feb 2021 19:03:26 +0300
Message-Id: <20210216160326.1341741-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check for opencoded min(), max() implementations.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/misc/minmax.cocci | 198 +++++++++++++++++++++++++++
 1 file changed, 198 insertions(+)
 create mode 100644 scripts/coccinelle/misc/minmax.cocci

diff --git a/scripts/coccinelle/misc/minmax.cocci b/scripts/coccinelle/misc/minmax.cocci
new file mode 100644
index 000000000000..9ae689bb14fb
--- /dev/null
+++ b/scripts/coccinelle/misc/minmax.cocci
@@ -0,0 +1,198 @@
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
+	... when any
+*	(x cmp y) ?@p x : y
+	... when any
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
+	... when any
+*	if (x cmp@p y) {
+*		max_val = x;
+*	} else {
+*		max_val = y;
+*	}
+	... when any
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
+	... when any
+*	(x cmp y) ?@p x : y
+	... when any
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
+	... when any
+*	if (x cmp@p y) {
+*		min_val = x;
+*	} else {
+*		min_val = y;
+*	}
+	... when any
+}
+
+@depends on patch@
+identifier func;
+expression x, y;
+binary operator cmp = {>=, >};
+@@
+
+func(...)
+{
+	... when any
+-	(x cmp y) ? x : y
++	max(x, y)
+	... when any
+}
+
+@depends on patch@
+identifier func;
+expression x, y;
+expression max_val;
+binary operator cmp = {>=, >};
+@@
+
+func(...)
+{
+	... when any
+-	if (x cmp y) {
+-		max_val = x;
+-	} else {
+-		max_val = y;
+-	}
++	max_val = max(x, y);
+	... when any
+}
+
+@depends on patch@
+identifier func;
+expression x, y;
+binary operator cmp = {<=, <};
+@@
+
+func(...)
+{
+	... when any
+-	(x cmp y) ? x : y
++	min(x, y)
+	... when any
+}
+
+@depends on patch@
+identifier func;
+expression x, y;
+expression min_val;
+binary operator cmp = {<=, <};
+@@
+
+func(...)
+{
+	... when any
+-	if (x cmp y) {
+-		min_val = x;
+-	} else {
+-		min_val = y;
+-	}
++	min_val = min(x, y);
+	... when any
+}
+
+@script:python depends on report@
+p << rmax.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for max()")
+
+@script:python depends on org@
+p << rmax.p;
+@@
+
+coccilib.report.print_todo(p[0], "WARNING opportunity for max()")
+
+@script:python depends on report@
+p << rmaxif.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for max()")
+
+@script:python depends on org@
+p << rmaxif.p;
+@@
+
+coccilib.report.print_todo(p[0], "WARNING opportunity for max()")
+
+@script:python depends on report@
+p << rmin.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for min()")
+
+@script:python depends on org@
+p << rmin.p;
+@@
+
+coccilib.report.print_todo(p[0], "WARNING opportunity for min()")
+
+@script:python depends on report@
+p << rminif.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for min()")
+
+@script:python depends on org@
+p << rminif.p;
+@@
+
+coccilib.report.print_todo(p[0], "WARNING opportunity for min()")
-- 
2.26.2

