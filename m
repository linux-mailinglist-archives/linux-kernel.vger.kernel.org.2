Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04EC7338FF1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhCLOZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbhCLOYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:24:48 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA89C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:24:48 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id k92so14051642qva.20
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JZTsOk7rsE4y13QJJB2MKSWKMrX5Hi5qHr1bAz5AyQ0=;
        b=hTQLmWZFaN/2EBaaI1leaS+J+FqsNZbjnWkVy379obcmHmGy4TQ2Qbw+Y7mvRXWIOi
         aFMAit90SAHGfQvCfuLLb1QQIkmF2K3wiDzHPkHBtIgwtWRMrjV8BpwlSXV5K+R9LF7Y
         JqlKASAtwLSGMb1Xf+nxvRmQbuukKW23nwcI6FsgqoPDYyeGMj0l2+9+3OESihxuNoRV
         hGV0SpTMfQTwvi9S3K1Q+splEsfmPHDbYJouBLP6t1DXCggHaXMnKHuO6dh7/h7H08Gg
         jjlRbOXFzrTqOunGygqBtdhDs9ZbTwGVikayQ6Wx6EIDDOssRaphq6B5Z4yZv2bNLeI1
         IKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JZTsOk7rsE4y13QJJB2MKSWKMrX5Hi5qHr1bAz5AyQ0=;
        b=VCtwxyKKDgKevCv8BfFGilMk+Nx4x+3Cvo9qFTNrjawrSVYQQG1Y3byMGdTpPTZqTg
         6wk3Xwgatd9ykdW2plKUQw4PUJw/VY3/o2dRwEJrpmbB5Ut5GUGYqldyK0GAs4imUhEO
         qUGqGfH1WafDkdoXChPzawgX8O/jzHmx6peQl3b/EWUJjGG7tCppfPmELOOhdSuEkoCh
         vKuTRRvGjGTBFPFUM8WZQt+TmEmiLhOAQEPOhJ8RmQ1WeX1E8KWo10MaxxgGXaCcq1OR
         UyFCiUxAhSv6SJagm7Onqn0tTbKYjmcwlUvns1u80BVLNIOYK6jaGHsMtcPKjt2u56ho
         6xiw==
X-Gm-Message-State: AOAM532TyuOo4uIlp0mwoGKlZII447IYhMWSoqrN4OSk7YEmdiK+8nN2
        4Dxr7OeUP7Z8kdidsiNdsZ4+Xv+W0xM+PnGs
X-Google-Smtp-Source: ABdhPJx1bwhGX9ABp6J/tmttc6zDPEbbnnDx7Uu8xLNlXSBuRHDH9zhu1klIP97uHVF7sDyQHYaVpjPHUSBTP3uw
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:95a:d8a8:4925:42be])
 (user=andreyknvl job=sendgmr) by 2002:ad4:51c1:: with SMTP id
 p1mr12931323qvq.39.1615559087508; Fri, 12 Mar 2021 06:24:47 -0800 (PST)
Date:   Fri, 12 Mar 2021 15:24:28 +0100
In-Reply-To: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
Message-Id: <01364952f15789948f0627d6733b5cdf5209f83a.1615559068.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v2 05/11] kasan: docs: update boot parameters section
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
index cd12c890b888..1189be9b4cb5 100644
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

