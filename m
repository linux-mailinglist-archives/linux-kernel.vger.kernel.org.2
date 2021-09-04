Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C774400D71
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 01:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbhIDXLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 19:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236512AbhIDXLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 19:11:44 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF34C061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 16:10:42 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id e16so2515565pfc.6
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 16:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HDYg/qL2I7D08BQ6vfacO9ZPTPCadlT05CSSccJd0eQ=;
        b=KLnU5m/8x4VSNxS7dh2kFJd7/ErRDrXp+rScvQ015MvdBd1S9/CHZO0J8Co/WBYjYs
         e+1oi6skijT0sQPyMkHIkwj5RST63buztA5jP7vt5ej8q5qAniI9AMQpTykb8mZtrGwS
         megfY6QP7dcVKEo9ZVr3zHqgnwOrxl4jPl8und5QFwhFssDE25HlVqmBoPUGYZGinib/
         CH/DYuJxDQHDAvLrml2tFQZF1chDhEsS5Fxg9f0vqiYQks87aDkI60DL1aFaW6d3AC5v
         BS6vpyQ6WDcrp3DRHqshu6UzjO4AMc0neO9hCuDUzRs33RJf6nD4L7HJAXt7ZXplsVcV
         +TmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HDYg/qL2I7D08BQ6vfacO9ZPTPCadlT05CSSccJd0eQ=;
        b=K/yRfWATz0n+crnbXU3d0oEFeh6gCiUuZ1it8ALGBXMswnnbA3vb/jAdBtGJwmSLit
         rCOAp3wW6wsRgBIA7jzOKPafBfVvC9HKfVjGouqn3+q+X+21kSr7WrxSFGl18DB1UasY
         /X0SfkQvFAQ5RLrKl4g4w+l1lTnAGs7cGIrb/gMTZ7K1ND7j0ckfJ5nTWfvjF9uk8Jio
         GsB94sbgSQDsc1K/DhFXiaJNbZiKPF9wukgtxQBJ00hLBXwIDYBIGAgWiSjPUoVAUP9M
         i59b2MZ4nEdEjkswZ4zdFV4WzD0jgNm9xJ6ZSKSGpK6zUA6QAm+ZF/MI2kAxHFJI5Cmk
         MvbA==
X-Gm-Message-State: AOAM532MVBeWFkMWBRiDxUUStxkcroe0UTQuNKmPDOmwH643eiwBica9
        xC5j1LgB3bSaK+kdyf990Tw=
X-Google-Smtp-Source: ABdhPJy46dadULPMl74038CC5T/3Ctx3GDiCOASi6JcXkCrexgpivp1Bv1eNxVICYcphrgg7h9a7Lw==
X-Received: by 2002:a65:6251:: with SMTP id q17mr5347777pgv.416.1630797041751;
        Sat, 04 Sep 2021 16:10:41 -0700 (PDT)
Received: from localhost ([202.164.25.5])
        by smtp.gmail.com with ESMTPSA id y9sm3220872pfc.193.2021.09.04.16.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 16:10:41 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Chris Down <chris@chrisdown.name>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Ingo Molnar <mingo@kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 2/2] coccinelle: add script for sputchar()
Date:   Sat,  4 Sep 2021 16:10:20 -0700
Message-Id: <20210904231020.331185-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210904231020.331185-1-yury.norov@gmail.com>
References: <20210904231020.331185-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This script find 47 candidates for sputchar() replacement, 
none of them is false-positive.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
One test case is commented-out because it causes spatch crash.
Coccinelle is installed from ubuntu deb package. 

yury:linux$ spatch --version
spatch version 1.0.8 compiled with OCaml version 4.11.1
Flags passed to the configure script: --prefix=/usr --sysconfdir=/etc --libdir=/usr/lib --enable-ocaml --enable-python --enable-opt
OCaml scripting support: yes
Python scripting support: yes
Syntax of regular expressions: PCRE

 scripts/coccinelle/misc/sputchar.cocci | 190 +++++++++++++++++++++++++
 1 file changed, 190 insertions(+)
 create mode 100644 scripts/coccinelle/misc/sputchar.cocci

diff --git a/scripts/coccinelle/misc/sputchar.cocci b/scripts/coccinelle/misc/sputchar.cocci
new file mode 100644
index 000000000000..23fb7546252f
--- /dev/null
+++ b/scripts/coccinelle/misc/sputchar.cocci
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Check for opencoded sputchar() implementation.
+///
+// Confidence: High
+// Copyright: (C) 2021 Yury Norov
+// Options: --no-includes --include-headers
+//
+// Keywords: sputchar
+//
+
+virtual patch
+virtual org
+virtual report
+virtual context
+
+@rpostfix depends on !patch@
+identifier func;
+expression buf, end, c;
+position p;
+@@
+
+func(...)
+{
+	<...
+*	if ((buf) < (end)) {
+*		*(buf) = (c);
+*	}
+*	(buf)++;@p
+	...>
+}
+
+@rprefix depends on !patch@
+identifier func;
+expression buf, end, c;
+position p;
+@@
+
+func(...)
+{
+	<...
+*	if ((buf) < (end))
+*		*(buf) = (c);
+*	++(buf);@p
+	...>
+}
+
+@rinc1 depends on !patch@
+identifier func;
+expression buf, end, c;
+position p;
+@@
+
+func(...)
+{
+	<...
+*	if ((buf) < (end)) {
+*		*(buf) = (c);
+*	}
+*	(buf) += 1;@p
+	...>
+}
+
+@rinc2 depends on !patch@
+identifier func;
+expression buf, end, c;
+position p;
+@@
+
+func(...)
+{
+	<...
+*	if ((buf) < (end)) {
+*		*(buf) = (c);
+*	}
+*	(buf) = (buf) + 1;@p
+	...>
+}
+
+@ppostfix depends on patch@
+identifier func;
+expression buf, end, c;
+position p;
+@@
+
+func(...)
+{
+	<...
+-	if ((buf) < (end)) {
+-		*(buf) = (c);
+-	}
+-	(buf)++;@p
++	buf = sputchar(buf, end, c);
+	...>
+}
+
+// @pprefix depends on patch@
+// identifier func;
+// expression buf, end, c;
+// position p;
+// @@
+//
+// func(...)
+// {
+// 	<...
+// -	if ((buf) < (end)) {
+// -		*(buf) = (c);
+// -	}
+// -	++(buf);
+// +	buf = sputchar(buf, end, c);
+// 	...>
+// }
+
+@pinc1 depends on patch@
+identifier func;
+expression buf, end, c;
+position p;
+@@
+
+func(...)
+{
+	<...
+-	if ((buf) < (end)) {
+-		*(buf) = (c);
+-	}
+-	(buf) += 1;
++	buf = sputchar(buf, end, c);
+	...>
+}
+
+@pinc2 depends on patch@
+identifier func;
+expression buf, end, c;
+position p;
+@@
+
+func(...)
+{
+	<...
+-	if ((buf) < (end)) {
+-		*(buf) = (c);
+-	}
+-	(buf) = (buf) + 1;
++	buf = sputchar(buf, end, c);
+	...>
+}
+
+@script:python depends on report@
+p << rpostfix.p;
+@@
+
+for p0 in p:
+	coccilib.report.print_report(p0, "WARNING opportunity for sputchar()")
+
+@script:python depends on org@
+p << rpostfix.p;
+@@
+
+for p0 in p:
+	coccilib.report.print_report(p0, "WARNING opportunity for sputchar()")
+
+
+@script:python depends on report@
+p << rprefix.p;
+@@
+
+for p0 in p:
+	coccilib.report.print_report(p0, "WARNING opportunity for sputchar()")
+
+@script:python depends on org@
+p << rprefix.p;
+@@
+
+for p0 in p:
+	coccilib.report.print_report(p0, "WARNING opportunity for sputchar()")
+
+@script:python depends on report@
+p << rinc1.p;
+@@
+
+for p0 in p:
+	coccilib.report.print_report(p0, "WARNING opportunity for sputchar()")
+
+@script:python depends on org@
+p << rinc1.p;
+@@
+
+for p0 in p:
+	coccilib.report.print_report(p0, "WARNING opportunity for sputchar()")
+
-- 
2.30.2

