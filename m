Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708DA31F684
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 10:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhBSJZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 04:25:33 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:34610 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhBSJZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 04:25:28 -0500
Received: by mail-lj1-f176.google.com with SMTP id r23so16735675ljh.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 01:25:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7+1XXFxtp0NTyFOGv6KWqg5UlcFRsTicQF0RpwlPL7Q=;
        b=bqAReWQi2wI37yqPkCrtF3x+u6uGay/HRllodhOnp/ez84abIlN64gx04Rcb2ZnBU4
         9GHWJqWvOzhR2MIl+BqAFris53jyqcgYCicZow4ipiqgMj07e4Oj9y8yXUmz+PR+gMsC
         mWHsgnLaquXyKRjc6hpq6bQIzYJHOmm7FZHGULrgM0+mhlexxYvWT8kznWbWapmdAGa0
         lboEFh6ZUGuWSVhz7lt/qB+0BopHzuxXl9c8wonUsbhYIOI7M5eWVBtes4Ex8PvQMN8P
         ZAoedJRmEaA+UUjJNSx0MSpCB8Mnt1pVT+ZL7pVipbrmJAjirHQrLBztNOjD3TaE+Ay7
         r4Zw==
X-Gm-Message-State: AOAM532SzBZiVSgxDX68QSDchvtB1DhGZDJ6jCNWhCF/iTBkZElWEEq5
        /JV3YQSvQ8G3jTQxkwCLTiUpbdMptylXtg==
X-Google-Smtp-Source: ABdhPJy1UPI6F6L2u+sjkmiZ9cEBWFrfgN8EzY9HIRoikI0eGFQFvwW2jgOdsDrq84Z/XyGJMHrw6A==
X-Received: by 2002:ac2:4a72:: with SMTP id q18mr5212436lfp.335.1613726686615;
        Fri, 19 Feb 2021 01:24:46 -0800 (PST)
Received: from localhost.localdomain (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.googlemail.com with ESMTPSA id 21sm868769lfo.238.2021.02.19.01.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 01:24:46 -0800 (PST)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] coccinelle: misc: add swap script
Date:   Fri, 19 Feb 2021 12:24:48 +0300
Message-Id: <20210219092448.13760-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210216080133.455456-1-efremov@linux.com>
References: <20210216080133.455456-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check for opencoded swap() implementation.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
Changes in v2:
 - additional patch rule to drop excessive {}
 - fix indentation in patch mode by anchoring ;

 scripts/coccinelle/misc/swap.cocci | 101 +++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 scripts/coccinelle/misc/swap.cocci

diff --git a/scripts/coccinelle/misc/swap.cocci b/scripts/coccinelle/misc/swap.cocci
new file mode 100644
index 000000000000..d5da9888c222
--- /dev/null
+++ b/scripts/coccinelle/misc/swap.cocci
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Check for opencoded swap() implementation.
+///
+// Confidence: High
+// Copyright: (C) 2021 Denis Efremov ISPRAS
+// Options: --no-includes --include-headers
+//
+// Keywords: swap
+//
+
+virtual patch
+virtual org
+virtual report
+virtual context
+
+@r depends on !patch@
+identifier tmp;
+expression a, b;
+type T;
+position p;
+@@
+
+(
+* T tmp;
+|
+* T tmp = 0;
+|
+* T *tmp = NULL;
+)
+... when != tmp
+* tmp = a;
+* a = b;@p
+* b = tmp;
+... when != tmp
+
+@rpvar depends on patch@
+identifier tmp;
+expression a, b;
+type T;
+@@
+
+(
+- T tmp;
+|
+- T tmp = 0;
+|
+- T *tmp = NULL;
+)
+... when != tmp
+- tmp = a;
+- a = b;
+- b = tmp
++ swap(a, b)
+  ;
+... when != tmp
+
+
+@rp depends on patch@
+identifier tmp;
+expression a, b;
+@@
+
+- tmp = a;
+- a = b;
+- b = tmp
++ swap(a, b)
+  ;
+
+@depends on (rpvar || rp)@
+@@
+
+(
+  for (...;...;...)
+- {
+	swap(...);
+- }
+|
+  while (...)
+- {
+	swap(...);
+- }
+|
+  if (...)
+- {
+	swap(...);
+- }
+)
+
+
+@script:python depends on report@
+p << r.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for swap()")
+
+@script:python depends on org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING opportunity for swap()")
-- 
2.26.2

