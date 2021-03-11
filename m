Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2040F337FC0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 22:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhCKViN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 16:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhCKVhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 16:37:38 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772CCC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 13:37:38 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id p15so10029562wre.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 13:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5DZPocqARvJ2VhBFUP59zWFPA2pzWUkM0o/y8pYmFsA=;
        b=ACyAQPWmvq+dZylG5VI/jRYY6sQl1IZ6N4PT9Rdc/yzYMPJCYHuZdkYZh48JjAoggg
         WDUsxkJTRWWxF21I/IBkPZ5PFV/REw+wSsHkD1LGe7hRMZBxYxoEr8OrauLf2u9Xunvo
         mWYL3QzNGQ4lwNk8hGnYa8o1ZQ0KfaSGux4X1KxyyJgWv1lny7dQ5U7GhTHrQ8bK6fwZ
         Qrvwfh2ATxJNUa2nH7Heg88Q8APRejiLmsfyaKEU8xL69rIZNGSzM/Zwig7d6nGC8FTM
         EXEV0MFip+6ZHsabX/6RgRI+uIYIxcvjUVg/3RP6XP7c+BTrMZI9U4ZINfu0RMNHfdfy
         c9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5DZPocqARvJ2VhBFUP59zWFPA2pzWUkM0o/y8pYmFsA=;
        b=FFBawqvTEbmE8L4mMs0AvfQxIjL8cYOEKYJLlOzInIxZH56wuMtMcJlT58yRynaQf/
         KCrT2G7plAvcHjrk5WC3GNg24hPBi6f7oyEg54VNvAHmYgXBJQ1imiqMCfVXCmRWsN3b
         pq59H6WjELNLCo1cn/82gEI4jHN6/DcnXQHNtTO7bPEt5/OpQmdpLJiMRYFJuCdr2pul
         WOfSLicwlmH8vOT5l74I3BBwiCUXTQAsC56DQS1mw17ZSWAhbEu75UdJgqDfH7jdcm73
         V2zHJ/A66ngyACdxZ5J/VaswFs+N8P0kvnSfC1VgQlrs48lrhENl7sdKON//MCcfgOtO
         1BWg==
X-Gm-Message-State: AOAM532IFQBWgdgjoRlb3HKejJg+9vWnFZkscUAwLN0Xo17f1CsJH/7A
        Gu3CxeEHpyQoHfnoCTzUCd1k2a9rRW4hQaln
X-Google-Smtp-Source: ABdhPJzrOToWEZY02T05UeRMCgcgQkkWvheRBtD+HjN401dMUC2SAN/NS8E97IDpd+hPV/fER6amECyXFjDeYS3F
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:95a:d8a8:4925:42be])
 (user=andreyknvl job=sendgmr) by 2002:a5d:58ce:: with SMTP id
 o14mr5622327wrf.4.1615498657160; Thu, 11 Mar 2021 13:37:37 -0800 (PST)
Date:   Thu, 11 Mar 2021 22:37:17 +0100
In-Reply-To: <f6efb2f36fc1f40eb22df027e6bc956cac71745e.1615498565.git.andreyknvl@google.com>
Message-Id: <afdec1e3271c9560bb0eb56bf36d6e3613830562.1615498565.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <f6efb2f36fc1f40eb22df027e6bc956cac71745e.1615498565.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 05/11] kasan: docs: update boot parameters section
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the "Boot parameters" section in KASAN documentation:

- Mention panic_on_warn.
- Mention kasan_multi_shot and its interaction with panic_on_warn.
- Clarify kasan.fault=panic interaction with panic_on_warn.
- A readability clean-up.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/dev-tools/kasan.rst | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 5fe43489e94e..2f939241349d 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -174,10 +174,16 @@ call_rcu() and workqueue queuing.
 Boot parameters
 ~~~~~~~~~~~~~~~
 
+KASAN is affected by the generic ``panic_on_warn`` command line parameter.
+When it is enabled, KASAN panics the kernel after printing a bug report.
+
+By default, KASAN prints a bug report only for the first invalid memory access.
+With ``kasan_multi_shot``, KASAN prints a report on every invalid access. This
+effectively disables ``panic_on_warn`` for KASAN reports.
+
 Hardware tag-based KASAN mode (see the section about various modes below) is
 intended for use in production as a security mitigation. Therefore, it supports
-boot parameters that allow to disable KASAN competely or otherwise control
-particular KASAN features.
+boot parameters that allow disabling KASAN or controlling its features.
 
 - ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
 
@@ -185,8 +191,8 @@ particular KASAN features.
   traces collection (default: ``on``).
 
 - ``kasan.fault=report`` or ``=panic`` controls whether to only print a KASAN
-  report or also panic the kernel (default: ``report``). Note, that tag
-  checking gets disabled after the first reported bug.
+  report or also panic the kernel (default: ``report``). The panic happens even
+  if ``kasan_multi_shot`` is enabled.
 
 Implementation details
 ----------------------
-- 
2.31.0.rc2.261.g7f71774620-goog

