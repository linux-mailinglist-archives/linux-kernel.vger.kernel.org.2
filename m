Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AD031F657
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 10:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhBSJMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 04:12:48 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:41298 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhBSJGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 04:06:18 -0500
Received: by mail-lj1-f177.google.com with SMTP id e17so16393658ljl.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 01:06:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4SYuc31NBuKizkQQlJfdfOc2gXxQ85QiVTeukEPxaJo=;
        b=OtfIxw/DfDVc+6BAY+gMIohc1u5WLtTiX2MpzILOV1OzN9v5DoPHTtW6dYWeqrfLae
         8iPzc9Uoi8sP64CjZ6L9oMoNSd9ZXS6AkCj1Ch5l4Oedr3vvxOMuJJEw7ebiMJkJEfwK
         wPZywKiT9ZoRS8U9UnYTTOZnFzltpEwMOg2sdVmpoU4y9IxQzooNeJXWX45MLc1qu0ke
         Y7mgNFtFuTOvLXpe9y4ktShDQ4EM6dVG1Q0FIME7QRDcgIMMMD8CfRt0G8i++YqiU1/C
         +mSkY93V+DDXK81AvunEpLaD5i3KmesOzqKhKc9utuhVxBnPpIupd0DRjsft0I/M1Yg6
         lW4A==
X-Gm-Message-State: AOAM531ba+iDsB23D82dpLcBXiI6FixbxmGzA0nBbPliDFtjCDLCWe9d
        DkHOZuQkFFfY7WcrJh+1md4Sf5rRRx5aBw==
X-Google-Smtp-Source: ABdhPJxk/zPhW0YoA4R5eXWF9hptagCSADw59N9qPWU/Z5oCVrDLkYhTL8UTXmkD8zdkmp8hXAetfA==
X-Received: by 2002:a2e:95c8:: with SMTP id y8mr2486238ljh.419.1613725535773;
        Fri, 19 Feb 2021 01:05:35 -0800 (PST)
Received: from localhost.localdomain (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.googlemail.com with ESMTPSA id a20sm162635lji.77.2021.02.19.01.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 01:05:34 -0800 (PST)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] coccinelle: misc: add minmax script
Date:   Fri, 19 Feb 2021 12:05:20 +0300
Message-Id: <20210219090520.8812-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210216080133.455456-1-efremov@linux.com>
References: <20210216080133.455456-1-efremov@linux.com>
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

 scripts/coccinelle/misc/minmax.cocci | 224 +++++++++++++++++++++++++++
 1 file changed, 224 insertions(+)
 create mode 100644 scripts/coccinelle/misc/minmax.cocci

diff --git a/scripts/coccinelle/misc/minmax.cocci b/scripts/coccinelle/misc/minmax.cocci
new file mode 100644
index 000000000000..61d6b61fd82c
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
+@depends on (pmax || pmaxif || pmin || pminif)@
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

