Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B1032E372
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 09:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhCEING (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 03:13:06 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:37168 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhCEINA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 03:13:00 -0500
Received: by mail-lj1-f179.google.com with SMTP id q14so1669246ljp.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 00:12:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qzDw47z9cmcIPC1rW9QLd8oJb6CmtII1SB7vSsEPO4U=;
        b=E24ru7F1FQPe6EEOhFfMAXDrjiWQEwuwiBUwLp+zwnFO+O5CCmqBFgYDY19GZh0Pat
         ZOJldcXQx8XAXn7A0F5K80Th5N2DumknMkfbl4u+5m/tdOoDP766Vvt6nCNl+ojxFK+6
         Ncx4Rx0K7RnzV+Ojo5QQeQQ9+Oo8HKUpsCz0efPQoI4suretqPSDrLrehZ6uDLqUmB4D
         nh2P1gb454/2pfQYfRIQqST+PQRtETtM7Li0Pkg4EKq/fxYh5IYsyrCZRp8YqGhILc2l
         MNkHyKn1RbN0E2zB5ZPAhsS9cklUyKz0LYEJAwTuQToISt1shsbTty2rehXywXsCz9sC
         cFqA==
X-Gm-Message-State: AOAM531oto/cFfXKXScbIGJ7t3MM6YixeJJNusfeZoJF1dVBkzSfDvGb
        EOSvkHtSbjU22xlW9N1TzEU=
X-Google-Smtp-Source: ABdhPJz1MdDwfyMYub7E7P7on1mycF+wwHmmYUSZ2/sgWeVmBS8BLUGnQLtAMnm74QuQ7lxIaH/nKw==
X-Received: by 2002:a2e:9595:: with SMTP id w21mr4584541ljh.72.1614931979242;
        Fri, 05 Mar 2021 00:12:59 -0800 (PST)
Received: from localhost.. (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.googlemail.com with ESMTPSA id u13sm209651lfr.124.2021.03.05.00.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 00:12:58 -0800 (PST)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] coccinelle: misc: add swap script
Date:   Fri,  5 Mar 2021 13:09:56 +0300
Message-Id: <20210305100956.6222-1-efremov@linux.com>
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
Changes in v3:
 - Rule added for simple (without var init) swap highlighting in !patch mode 
 - "depends on patch && (rpvar || rp)" fixed

 scripts/coccinelle/misc/swap.cocci | 122 +++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 scripts/coccinelle/misc/swap.cocci

diff --git a/scripts/coccinelle/misc/swap.cocci b/scripts/coccinelle/misc/swap.cocci
new file mode 100644
index 000000000000..c5e71b7ef7f5
--- /dev/null
+++ b/scripts/coccinelle/misc/swap.cocci
@@ -0,0 +1,122 @@
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
+@rvar depends on !patch@
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
+@r depends on !patch@
+identifier tmp;
+expression a, b;
+position p != rvar.p;
+@@
+
+* tmp = a;
+* a = b;@p
+* b = tmp;
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
+@depends on patch && (rpvar || rp)@
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
+
+@script:python depends on report@
+p << rvar.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for swap()")
+
+@script:python depends on org@
+p << rvar.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING opportunity for swap()")
-- 
2.26.2

