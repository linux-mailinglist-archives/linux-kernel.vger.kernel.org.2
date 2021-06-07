Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D5B39DD1E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 14:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhFGM7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 08:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhFGM7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 08:59:18 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A33C061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 05:57:12 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id o14-20020a05620a130eb02902ea53a6ef80so12784715qkj.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 05:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=52fGvbimaCnuRXDzSCXEKwhsxycQvh+gPJni4oHCnrE=;
        b=HWg0wtm6XFMA3fVNr7tPjA7qi8f4rG61TWvDhephndChJV8pk7inyQ7N7dHszf//Rb
         VEsfDXImxtXQhtzPgvOt5JPDfw3z8OQPJb6tRT2pkNK5vG2RJC6ZFO0PUgYd2unum8F8
         XJD0ObbwCvz9pL0xWRc1vjXHaiXh4+0t4eBJ1c+zjlth4ppB41VRDRuCTb8qX+54pj6i
         fKvMuS9pYvYWlaHdTuOgb3kLWtbxS5B7wfSzNmR5sCoj5NBxUmPgkTn018gfXFnl+X8Z
         exY5A/qQk5tWCO7AW5CXusiFrIgP8cf+SrvAEOn/0Kjx50NBGZBXOT0xYbZHRCkbLti6
         Mu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=52fGvbimaCnuRXDzSCXEKwhsxycQvh+gPJni4oHCnrE=;
        b=oqVHJOxt7z4F35Nze8vIBT/G+J7+xX7aguAAW5laLdqDnNieZXxE8jGO1kleIxXx4Z
         6qTpyKTzA38vbDd5H2pkg6TNCpACkDoo9Ot6I7WZWYTUoqAGQFNSiIvmCYSn1XfBnidQ
         gTuFZ2wBAG61JGt0FKO83jDWOBowwRgJD8i33RtqIcIo60aLwXcjn4TFI6GH3MkYLyu+
         Hx7WWwILOIbneE1+9kDPf2FRhUcVRwwmjRhm8ELJixGipgWam0Rb0xeTB+aqzhpUCG5I
         4qzYO/bWwYIf1f82QBb2MA4z5kh02A0y/b92pyOuAZKlyD+OyKGdYbM/KdJqSkTxwYpR
         FJSg==
X-Gm-Message-State: AOAM533qiTn/0aA2j4iWYjwr3BWVsJlhPtodOWCvk/pjDP0/QiWgRDkn
        q1G5KqaY7wy09niYckgqyYsv5EgX5Q==
X-Google-Smtp-Source: ABdhPJyM612oWkwLCB9W3qmZDVflG0IRvkLjZ3gnMKlKj7XtNMhiBd2EtbRQmkjjVPj2Z+JO/8SflbBkKQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:2587:50:741c:6fde])
 (user=elver job=sendgmr) by 2002:a0c:c587:: with SMTP id a7mr17495867qvj.59.1623070631856;
 Mon, 07 Jun 2021 05:57:11 -0700 (PDT)
Date:   Mon,  7 Jun 2021 14:56:49 +0200
In-Reply-To: <20210607125653.1388091-1-elver@google.com>
Message-Id: <20210607125653.1388091-4-elver@google.com>
Mime-Version: 1.0
References: <20210607125653.1388091-1-elver@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH 3/7] kcsan: Introduce CONFIG_KCSAN_STRICT
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     boqun.feng@gmail.com, mark.rutland@arm.com, will@kernel.org,
        glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simpler Kconfig variable to configure KCSAN's "strict" mode. This
makes it simpler in documentation or messages to suggest just a single
configuration option to select the strictest checking mode (vs.
currently having to list several options).

Signed-off-by: Marco Elver <elver@google.com>
---
 Documentation/dev-tools/kcsan.rst |  4 ++++
 lib/Kconfig.kcsan                 | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index ba059df10b7d..17f974213b88 100644
--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -124,6 +124,10 @@ Kconfig options:
   causes KCSAN to not report data races due to conflicts where the only plain
   accesses are aligned writes up to word size.
 
+To use the strictest possible rules, select ``CONFIG_KCSAN_STRICT=y``, which
+configures KCSAN to follow the Linux-kernel memory consistency model (LKMM) as
+closely as possible.
+
 DebugFS interface
 ~~~~~~~~~~~~~~~~~
 
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 5304f211f81f..c76fbb3ee09e 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -183,9 +183,17 @@ config KCSAN_REPORT_RACE_UNKNOWN_ORIGIN
 	  reported if it was only possible to infer a race due to a data value
 	  change while an access is being delayed on a watchpoint.
 
+config KCSAN_STRICT
+	bool "Strict data-race checking"
+	help
+	  KCSAN will report data races with the strictest possible rules, which
+	  closely aligns with the rules defined by the Linux-kernel memory
+	  consistency model (LKMM).
+
 config KCSAN_REPORT_VALUE_CHANGE_ONLY
 	bool "Only report races where watcher observed a data value change"
 	default y
+	depends on !KCSAN_STRICT
 	help
 	  If enabled and a conflicting write is observed via a watchpoint, but
 	  the data value of the memory location was observed to remain
@@ -194,6 +202,7 @@ config KCSAN_REPORT_VALUE_CHANGE_ONLY
 config KCSAN_ASSUME_PLAIN_WRITES_ATOMIC
 	bool "Assume that plain aligned writes up to word size are atomic"
 	default y
+	depends on !KCSAN_STRICT
 	help
 	  Assume that plain aligned writes up to word size are atomic by
 	  default, and also not subject to other unsafe compiler optimizations
@@ -206,6 +215,7 @@ config KCSAN_ASSUME_PLAIN_WRITES_ATOMIC
 
 config KCSAN_IGNORE_ATOMICS
 	bool "Do not instrument marked atomic accesses"
+	depends on !KCSAN_STRICT
 	help
 	  Never instrument marked atomic accesses. This option can be used for
 	  additional filtering. Conflicting marked atomic reads and plain
-- 
2.32.0.rc1.229.g3e70b5a671-goog

