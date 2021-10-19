Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E84C43338B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 12:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbhJSKdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 06:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbhJSKdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 06:33:52 -0400
Received: from mail-lj1-x24a.google.com (mail-lj1-x24a.google.com [IPv6:2a00:1450:4864:20::24a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80061C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 03:31:39 -0700 (PDT)
Received: by mail-lj1-x24a.google.com with SMTP id t7-20020a2e7807000000b00210dad8b167so695179ljc.22
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 03:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=18QmBkB8I+n5qxxUGXdyzfTsY7V9PS8kg83ueXyuZCk=;
        b=jS26q/AKCynLWIZ1DuWcXrk/da8p0UDsNCSqbjbrQdhFduA2rTTEE5KXXo8F2DTx5T
         bnXRvbh6aHrFLlSEIxMGKt1UZ1XvZOKKQW1ck/YymO+hN5MMem9KqA6DgEYpZAtpusXx
         he3cSNg0RgpG4iOseaGujSgQHYT12DRs2SL5QfxW32rw3WtHdUl940Gcm1tVqYLjrJPn
         leSp780rCKNz6UVHsNeMmfCnxP6qcBKvMLCXUauxtvIG3dvI/DGCB6iQmRTTnTA0gAvv
         mLaWLVujG8Y3zib53zYaaQdHhVuHGWippCJujh9FB/6VpywOayCt9q0XugsZHMUqb63K
         CpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=18QmBkB8I+n5qxxUGXdyzfTsY7V9PS8kg83ueXyuZCk=;
        b=X7uae9oe7swwvAW91R+e450K+JXvyk6hLVMcW+gVi0Y31E7816ndFi46ZhgrLlLO2S
         vkLu/dbzK+GwJNd+hchMNCM9Ym2zDjwLL2b3Rr3zpjuO7OFKBvm/aAm/WR0/ZYjxlfK/
         EePDc2DBM4VlekV1DlF8W8R3H6G6cOMs5OCihPObLGmTo/135jTtYsBqcJA06S/nGP2O
         CP9bsOd63cC+ulEG5OtyfN9niVQCiRjkRjX67zAd3wWsI2MQmF9Bo9PJoJDMoJKcMYJP
         BcJ8PfFvM6HOc5f16heLbee6ASt6QOMXLdBVyMuO9hPAmsumbgtP3vBZfoXxsm/sUA8J
         MneA==
X-Gm-Message-State: AOAM531TP/zFGbJRx+BRfoBejeS0/TegpoDBXXYxw7p1EWyUwVsbdti2
        f6cDLqqxCBOsrR0QqRPlkAd9LKmDWw==
X-Google-Smtp-Source: ABdhPJz1h69+vO/03HADJePP5S4zfTZf32z308XEBAGlzeIDz9OMAre4hjxsibWqGOjxe/ihHQ45d4hKBA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:feca:f6ef:d785:c732])
 (user=elver job=sendgmr) by 2002:a17:907:1044:: with SMTP id
 oy4mr36797913ejb.308.1634639135257; Tue, 19 Oct 2021 03:25:35 -0700 (PDT)
Date:   Tue, 19 Oct 2021 12:25:24 +0200
In-Reply-To: <20211019102524.2807208-1-elver@google.com>
Message-Id: <20211019102524.2807208-2-elver@google.com>
Mime-Version: 1.0
References: <20211019102524.2807208-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH 2/2] kfence: default to dynamic branch instead of static keys mode
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have observed that on very large machines with newer CPUs, the static
key/branch switching delay is on the order of milliseconds. This is due
to the required broadcast IPIs, which simply does not scale well to
hundreds of CPUs (cores). If done too frequently, this can adversely
affect tail latencies of various workloads.

One workaround is to increase the sample interval to several seconds,
while decreasing sampled allocation coverage, but the problem still
exists and could still increase tail latencies.

As already noted in the Kconfig help text, there are trade-offs:  at
lower sample intervals the dynamic branch results in better performance;
however, at very large sample intervals, the static keys mode can result
in better performance -- careful benchmarking is recommended.

Our initial benchmarking showed that with large enough sample intervals
and workloads stressing the allocator, the static keys mode was slightly
better. Evaluating and observing the possible system-wide side-effects
of the static-key-switching induced broadcast IPIs, however, was a blind
spot (in particular on large machines with 100s of cores).

Therefore, a major downside of the static keys mode is, unfortunately,
that it is hard to predict performance on new system architectures and
topologies, but also making conclusions about performance of new
workloads based on a limited set of benchmarks.

Most distributions will simply select the defaults, while targeting a
large variety of different workloads and system architectures. As such,
the better default is CONFIG_KFENCE_STATIC_KEYS=n, and re-enabling it is
only recommended after careful evaluation.

For reference, on x86-64 the condition in kfence_alloc() generates
exactly 2 instructions in the kmem_cache_alloc() fast-path:

 | ...
 | cmpl   $0x0,0x1a8021c(%rip)  # ffffffff82d560d0 <kfence_allocation_gate>
 | je     ffffffff812d6003      <kmem_cache_alloc+0x243>
 | ...

which, given kfence_allocation_gate is infrequently modified, should
be well predicted by most CPUs.

Signed-off-by: Marco Elver <elver@google.com>
---
 Documentation/dev-tools/kfence.rst | 12 ++++++++----
 lib/Kconfig.kfence                 | 26 +++++++++++++++-----------
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/Documentation/dev-tools/kfence.rst b/Documentation/dev-tools/kfence.rst
index d45f952986ae..ac6b89d1a8c3 100644
--- a/Documentation/dev-tools/kfence.rst
+++ b/Documentation/dev-tools/kfence.rst
@@ -231,10 +231,14 @@ Guarded allocations are set up based on the sample interval. After expiration
 of the sample interval, the next allocation through the main allocator (SLAB or
 SLUB) returns a guarded allocation from the KFENCE object pool (allocation
 sizes up to PAGE_SIZE are supported). At this point, the timer is reset, and
-the next allocation is set up after the expiration of the interval. To "gate" a
-KFENCE allocation through the main allocator's fast-path without overhead,
-KFENCE relies on static branches via the static keys infrastructure. The static
-branch is toggled to redirect the allocation to KFENCE.
+the next allocation is set up after the expiration of the interval.
+
+When using ``CONFIG_KFENCE_STATIC_KEYS=y``, KFENCE allocations are "gated"
+through the main allocator's fast-path by relying on static branches via the
+static keys infrastructure. The static branch is toggled to redirect the
+allocation to KFENCE. Depending on sample interval, target workloads, and
+system architecture, this may perform better than the simple dynamic branch.
+Careful benchmarking is recommended.
 
 KFENCE objects each reside on a dedicated page, at either the left or right
 page boundaries selected at random. The pages to the left and right of the
diff --git a/lib/Kconfig.kfence b/lib/Kconfig.kfence
index e641add33947..912f252a41fc 100644
--- a/lib/Kconfig.kfence
+++ b/lib/Kconfig.kfence
@@ -25,17 +25,6 @@ menuconfig KFENCE
 
 if KFENCE
 
-config KFENCE_STATIC_KEYS
-	bool "Use static keys to set up allocations"
-	default y
-	depends on JUMP_LABEL # To ensure performance, require jump labels
-	help
-	  Use static keys (static branches) to set up KFENCE allocations. Using
-	  static keys is normally recommended, because it avoids a dynamic
-	  branch in the allocator's fast path. However, with very low sample
-	  intervals, or on systems that do not support jump labels, a dynamic
-	  branch may still be an acceptable performance trade-off.
-
 config KFENCE_SAMPLE_INTERVAL
 	int "Default sample interval in milliseconds"
 	default 100
@@ -56,6 +45,21 @@ config KFENCE_NUM_OBJECTS
 	  pages are required; with one containing the object and two adjacent
 	  ones used as guard pages.
 
+config KFENCE_STATIC_KEYS
+	bool "Use static keys to set up allocations" if EXPERT
+	depends on JUMP_LABEL
+	help
+	  Use static keys (static branches) to set up KFENCE allocations. This
+	  option is only recommended when using very large sample intervals, or
+	  performance has carefully been evaluated with this option.
+
+	  Using static keys comes with trade-offs that need to be carefully
+	  evaluated given target workloads and system architectures. Notably,
+	  enabling and disabling static keys invoke IPI broadcasts, the latency
+	  and impact of which is much harder to predict than a dynamic branch.
+
+	  Say N if you are unsure.
+
 config KFENCE_STRESS_TEST_FAULTS
 	int "Stress testing of fault handling and error reporting" if EXPERT
 	default 0
-- 
2.33.0.1079.g6e70778dc9-goog

