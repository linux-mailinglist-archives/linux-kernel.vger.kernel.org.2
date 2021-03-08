Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B0A3308CF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 08:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbhCHHa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 02:30:26 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:41681 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbhCHHaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 02:30:21 -0500
Received: by mail-lj1-f174.google.com with SMTP id t9so14774928ljt.8
        for <linux-kernel@vger.kernel.org>; Sun, 07 Mar 2021 23:30:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vSgQKtJu6DhjO0t3OJp5IkI2xLLW3/u/GFWiQflU5N8=;
        b=qSsPya43u1A+lIPlMwmnGd3cNs91fD5/LRrk5EE28e9DKuaVg5wLVjJpPWzw0Ml2z4
         f/aFj4/YSJ6z4Q3T2p7s35Ew94TzVlhzBpQSlh/tOSIaniuyKNEOxNadaw+na8D7r3j4
         E0COYoCot328Jb8OIl8LcUC9ggkA6gWGcab2fYjqfGCd0r/VMUOm7y4V+pexyobzDQAe
         FIOy7VKA5BIoHnlT02Ljhs6p8rYCUkEsmYN9FOFR6J7t5gyEI8GDpb/hAMbDfEYMesx1
         GtLxcyXZtYW5eIB+EAN2vvNiLnyVybmrSQOdiOOUuG3YJydxoxRYR5BahbI0HKuUMyII
         Y5fg==
X-Gm-Message-State: AOAM5330Mnea8YVuYp84aAp1QFtRp9WIbbUb1vCmmIi3ovdtCP6Dh8eR
        Hk3nXUCEu4l7U0yAgxRETS4ARwCUCfTyVw==
X-Google-Smtp-Source: ABdhPJyQPspC+d+wFvk9zkmZuW/Zm4JYF2WiCRCuSTt7kUcoqXOKhyK3SzWrn3Q/iq2PVKb2y/twtA==
X-Received: by 2002:a2e:94cc:: with SMTP id r12mr12507920ljh.373.1615188620116;
        Sun, 07 Mar 2021 23:30:20 -0800 (PST)
Received: from localhost.. (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.googlemail.com with ESMTPSA id b25sm1383897ljo.80.2021.03.07.23.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 23:30:19 -0800 (PST)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH] coccinelle: misc: update uninitialized_var.cocci documentation
Date:   Mon,  8 Mar 2021 10:30:18 +0300
Message-Id: <20210308073018.108487-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the documentation link from the warning message because commit
3942ea7a10c9 ("deprecated.rst: Remove now removed uninitialized_var")
removed the section from documentation. Update the rule documentation
accordingly.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/misc/uninitialized_var.cocci | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/scripts/coccinelle/misc/uninitialized_var.cocci b/scripts/coccinelle/misc/uninitialized_var.cocci
index 8fa845cefe11..69bbaae47e73 100644
--- a/scripts/coccinelle/misc/uninitialized_var.cocci
+++ b/scripts/coccinelle/misc/uninitialized_var.cocci
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 ///
 /// Please, don't reintroduce uninitialized_var().
-/// From Documentation/process/deprecated.rst:
+///
+/// From Documentation/process/deprecated.rst,
+/// commit 4b19bec97c88 ("docs: deprecated.rst: Add uninitialized_var()"):
 ///  For any compiler warnings about uninitialized variables, just add
 ///  an initializer. Using warning-silencing tricks is dangerous as it
 ///  papers over real bugs (or can in the future), and suppresses unrelated
@@ -11,6 +13,11 @@
 ///  obviously redundant, the compiler's dead-store elimination pass will make
 ///  sure there are no needless variable writes.
 ///
+/// Later, commit 3942ea7a10c9 ("deprecated.rst: Remove now removed
+/// uninitialized_var") removed this section because all initializations of
+/// this kind were cleaned-up from the kernel. This cocci rule checks that
+/// the macro is not explicitly or implicitly reintroduced.
+///
 // Confidence: High
 // Copyright: (C) 2020 Denis Efremov ISPRAS
 // Options: --no-includes --include-headers
@@ -40,12 +47,10 @@ position p;
 p << r.p;
 @@
 
-coccilib.report.print_report(p[0],
-  "WARNING this kind of initialization is deprecated (https://www.kernel.org/doc/html/latest/process/deprecated.html#uninitialized-var)")
+coccilib.report.print_report(p[0], "WARNING this kind of initialization is deprecated")
 
 @script:python depends on org@
 p << r.p;
 @@
 
-coccilib.org.print_todo(p[0],
-  "WARNING this kind of initialization is deprecated (https://www.kernel.org/doc/html/latest/process/deprecated.html#uninitialized-var)")
+coccilib.org.print_todo(p[0], "WARNING this kind of initialization is deprecated")
-- 
2.26.2

