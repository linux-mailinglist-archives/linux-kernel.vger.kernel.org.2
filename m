Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF2232E383
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 09:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhCEITh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 03:19:37 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:40754 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhCEITY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 03:19:24 -0500
Received: by mail-lj1-f174.google.com with SMTP id e2so1665506ljo.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 00:19:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7XRAtGgHFapF9tffRIfz1dXxRDSD82LqpiHt4CHnG+I=;
        b=ddd5ILj41acr1uS/SZY44pxOjFxXk+zfMuNsW5LqoM1HyO+8wOc8/Iak8Rmdd98bZl
         GAYgggQW1P6A/TCTfHTZkjAg25Njw6cTAs/k/IHkZBYAr8WwLnb8yUykEamxR7O2Xzmq
         9U8G5XpXocdJzM/4vTO/39ig/wQimj9CR4C2Ue2OMMvITPDyJJREiCsYr3lGpzReeANr
         pP73NgMvmO+kalr4ur44+q3qA57CA9yPdLYl/9H75rkU3hmbAoSFcXXbXmIne//lC8uY
         fqycOyATiRSFPQuP8fEzQ1lxdkmHYKROFZIY/uTCYkXk6MGwYG8MmF9xT+wR4SXs4szI
         MpIA==
X-Gm-Message-State: AOAM533zX7TicUlaBcBBX+qZrkRYRU7yCmYsW95bD6OtJF9kXHwlH/Tt
        srT/zGfoccQgQQdfLxakn7o=
X-Google-Smtp-Source: ABdhPJw2R5rlkuLDcbpZVPlXAG3oBxCCi+2zpkb3QB9mdGcZB9maGd1JhSnhgqr3YVQSOj1X36PLNA==
X-Received: by 2002:a2e:9004:: with SMTP id h4mr4549253ljg.326.1614932363219;
        Fri, 05 Mar 2021 00:19:23 -0800 (PST)
Received: from localhost.. (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.googlemail.com with ESMTPSA id s6sm209273lfg.242.2021.03.05.00.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 00:19:22 -0800 (PST)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] coccinelle: misc: add minmax script
Date:   Fri,  5 Mar 2021 13:16:40 +0300
Message-Id: <20210305101640.7717-1-efremov@linux.com>
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

 scripts/coccinelle/misc/minmax.cocci | 224 +++++++++++++++++++++++++++
 1 file changed, 224 insertions(+)
 create mode 100644 scripts/coccinelle/misc/minmax.cocci

diff --git a/scripts/coccinelle/misc/minmax.cocci b/scripts/coccinelle/misc/minmax.cocci
new file mode 100644
index 000000000000..f577f08d1e6e
--- /dev/null
+++ b/scripts/coccinelle/misc/minmax.cocci
@@ -0,0 +1,224 @@
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
+*	x cmp@p y ? x : y
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
+*	if (x cmp@p y) {
+*		max_val = x;
+*	} else {
+*		max_val = y;
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
+*	x cmp@p y ? x : y
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
+*	if (x cmp@p y) {
+*		min_val = x;
+*	} else {
+*		min_val = y;
+*	}
+	...>
+}
+
+@pmax depends on patch@
+identifier func;
+expression x, y;
+binary operator cmp = {>=, >};
+position p;
+@@
+
+func@p(...)
+{
+	<...
+-	x cmp y ? x : y
++	max(x, y)
+	...>
+}
+
+@pmaxif depends on patch@
+identifier func;
+expression x, y;
+expression max_val;
+binary operator cmp = {>=, >};
+position p;
+@@
+
+func@p(...)
+{
+	<...
+-	if (x cmp y) {
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
+position p;
+@@
+
+func@p(...)
+{
+	<...
+-	x cmp y ? x : y
++	min(x, y)
+	...>
+}
+
+@pminif depends on patch@
+identifier func;
+expression x, y;
+expression min_val;
+binary operator cmp = {<=, <};
+position p;
+@@
+
+func@p(...)
+{
+	<...
+-	if (x cmp y) {
+-		min_val = x;
+-	} else {
+-		min_val = y;
+-	}
++	min_val = min(x, y);
+	...>
+}
+
+@depends on patch && (pmax || pmaxif || pmin || pminif)@
+identifier func;
+expression x, y;
+position p;
+// FIXME: Coccinelle consumes all available ram and
+// and timeouts on every file.
+// position p = { pmin.p, pminif.p, pmax.p, pmaxif.p };
+@@
+
+func@p(...)
+{
+	<...
+(
+-	(min((x), (y)))
++	min(x, y)
+|
+-	(max((x), (y)))
++	max(x, y)
+)
+	...>
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
+coccilib.org.print_todo(p[0], "WARNING opportunity for max()")
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
+coccilib.org.print_todo(p[0], "WARNING opportunity for max()")
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
+coccilib.org.print_todo(p[0], "WARNING opportunity for min()")
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
+coccilib.org.print_todo(p[0], "WARNING opportunity for min()")
-- 
2.26.2

