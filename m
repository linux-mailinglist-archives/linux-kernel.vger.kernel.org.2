Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4815330894
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 08:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhCHHFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 02:05:02 -0500
Received: from mail-lj1-f175.google.com ([209.85.208.175]:45738 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhCHHEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 02:04:53 -0500
Received: by mail-lj1-f175.google.com with SMTP id c19so6389777ljn.12
        for <linux-kernel@vger.kernel.org>; Sun, 07 Mar 2021 23:04:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oHlzT8YFV71X+qnYl7bOaqCLNeFyzOS3n6PKubU4sbU=;
        b=tmv3SZL4HOKo8lryiftrtak6pOGjnZEFOnGOCu1ByYak5GijW3N/F29AdRSPv40qKt
         yfG38xIwKbN6zZRQ87xMhBvDui7h6FOgmehJbUhBqrHKBtBVBl7X9BJwmIVsaBJdNRqQ
         M52dY+PaxmijqXF+kT9SCn7bKVO927iFD/Rk7RpFaXewqknkgjClfw4pc0gU4r4d3AaS
         5eS4uxXkmuI+O5ywdzWKKyKXH0lDynpAeYzZHnnTg+beXfRanTcmufJOCHA75JlCPqN/
         ZUo1tGhzaTr7iGetmzR5P/Askj0wGASww/5zvzoaPAJ/95oklWuH+Aot0wVb/iwWFI3R
         egnw==
X-Gm-Message-State: AOAM530/g5cWl923jguvKwrN7fAROzLV2XAnocuEBwSxDc2vziIz3/jk
        S/+0nqo1sjRJmXnp76t6dR4=
X-Google-Smtp-Source: ABdhPJwBb/VgOOANmqxIuQ+ScNlBbDyaGSOQdt4xw6BLiNC7ZPCGUa9SX30ol23DJBuDMFFPgrCZhg==
X-Received: by 2002:a2e:8596:: with SMTP id b22mr12961861lji.482.1615187091786;
        Sun, 07 Mar 2021 23:04:51 -0800 (PST)
Received: from localhost.. (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.googlemail.com with ESMTPSA id f9sm1372925ljg.115.2021.03.07.23.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 23:04:51 -0800 (PST)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] coccinelle: misc: add minmax script
Date:   Mon,  8 Mar 2021 10:04:45 +0300
Message-Id: <20210308070445.104768-1-efremov@linux.com>
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

 scripts/coccinelle/misc/minmax.cocci | 206 +++++++++++++++++++++++++++
 1 file changed, 206 insertions(+)
 create mode 100644 scripts/coccinelle/misc/minmax.cocci

diff --git a/scripts/coccinelle/misc/minmax.cocci b/scripts/coccinelle/misc/minmax.cocci
new file mode 100644
index 000000000000..63eeba1702ec
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
+-		max_val = (x);
+-	} else {
+-		max_val = (y);
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
+-		min_val = (x);
+-	} else {
+-		min_val = (y);
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

