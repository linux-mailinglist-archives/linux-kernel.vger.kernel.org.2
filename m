Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E44A31C717
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 09:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhBPICW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 03:02:22 -0500
Received: from mail-lj1-f175.google.com ([209.85.208.175]:35135 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhBPICS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 03:02:18 -0500
Received: by mail-lj1-f175.google.com with SMTP id a17so10727688ljq.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 00:02:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uFThXabaiyaapHkWm2pAsaBD7G1U96eLmd8X49gddgo=;
        b=mDGNOpM9ARCTZ2lxWPZ15G/SFNP1YFOJsZYQVprMqMjSyCfGpEUZFIL/7+KSf5Q/YW
         U98GsGHKXANQPcqR180XakMylbcBXJmxUN/Vsq2/zwyfMTsmT5kL8IbmN7z79/SBqlC3
         PROrTRNp13SfmmxjmG/ansuoyXuBJqkb/EBaCLISRbzPq/i7EwHBKZqBlRKss0CXICzn
         EgHjiTuWbYDja7zpGhOPVbA7RiQpL0yit9SF4LSyz09azvjrczzARjoDFzF/yGaLJEKr
         cFUI5vIWMcFOnNoM7GYSiBx6vmMIT7G+uzS2CpE6byb2fYxVea4U/RpaBiK90rzLC2Wv
         klSQ==
X-Gm-Message-State: AOAM531p9XYB+Pd548H3c1EmToYf92e2B9SGlYDMm2+5j0iChfUe/mEq
        TpEV+wcjrSf0Qu4PCsnFRK/PdlSF7zg1fg==
X-Google-Smtp-Source: ABdhPJxZMTAPypUYuhEx+CTwH4TV528teZWJ6i0ongr0r3kKwipLnEVP4lqR9ayYIop3KwGWOcSv6A==
X-Received: by 2002:a2e:a368:: with SMTP id i8mr4366039ljn.455.1613462496667;
        Tue, 16 Feb 2021 00:01:36 -0800 (PST)
Received: from localhost.localdomain (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.googlemail.com with ESMTPSA id l9sm3123586lfp.209.2021.02.16.00.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 00:01:36 -0800 (PST)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH] coccinelle: misc: add swap script
Date:   Tue, 16 Feb 2021 11:01:33 +0300
Message-Id: <20210216080133.455456-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check for opencoded swap() implementation.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/misc/swap.cocci | 77 ++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 scripts/coccinelle/misc/swap.cocci

diff --git a/scripts/coccinelle/misc/swap.cocci b/scripts/coccinelle/misc/swap.cocci
new file mode 100644
index 000000000000..38227a5d0855
--- /dev/null
+++ b/scripts/coccinelle/misc/swap.cocci
@@ -0,0 +1,77 @@
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
+@depends on patch@
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
+- b = tmp;
++ swap(a, b);
+... when != tmp
+
+@depends on patch@
+identifier tmp;
+expression a, b;
+@@
+
+- tmp = a;
+- a = b;
+- b = tmp;
++ swap(a, b);
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

