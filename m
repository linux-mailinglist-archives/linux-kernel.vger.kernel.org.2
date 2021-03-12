Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAFB338FEE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhCLOY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhCLOYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:24:42 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9528C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:24:41 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id i19so11650439edy.18
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YmrfZsjCUnsbI/dxLimuvoNopBZleUT55sQpN4+LAO4=;
        b=j/FaqdN61zL6WvpcKOGOU2tM9vngAJHnvFQAG9snOCBc7cjO4jQA4laHGxNPE3iol7
         bTvUQd9R4paQnOS0/atIt5fTkAnxkGcZasXLem38BWaBtqHdLhpa1rd+rSx+RaSpW7tN
         M72oqJz0uX8j54HywoEZ70+yXJavAEboopaFmB8Z2A92JySJCH5xEqOay87JMUkyK37q
         erxXZWqAntLuDrpnqt4kiGbh71iP4qJjfpkORzXPvCeODseooVn6Qe6rBeUicTzcZyID
         2TvJc/8mEXO9WXK1Fcg15bqM8m3gGLQ4LW1ASek4Pcc8JAwE6/h92cXjTVzPLsq/lmst
         vFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YmrfZsjCUnsbI/dxLimuvoNopBZleUT55sQpN4+LAO4=;
        b=qQ2qav310tdE6z9/fQ3z3j8AiNp1chuoJxNZHTLPCl61aLKaW2MFs2XfDPNDeAxE65
         R4mV1mlbxfG5tyDRattsH4AZkyXEVRgrzKskNSSAgGuQ4QKdW7SEYn2fCsOQrrnbG0Fh
         nv+1rrXWYJEtUrE2bEv+dh9ZD1Nwp0U7+8KJ5JQE8lgNG2dhizpiiHt70vInZMEmROWN
         LPhFr4Heqp2ITSx63sDuRA7VXVY/gZQs7LhiaPUTtlNShiZZf42CgVvVg3Jrx71TFxcK
         Uh5mg7DCWz/RazbAkWmKPW+2tYgDTfm/IO53WFeP7mTmYTrTIldBI85CLfBK5pJWsBYy
         M8PQ==
X-Gm-Message-State: AOAM532p1brCXAwcpeKcNsGGQ5lpKFXMibFTriKgrOXBUEY57mkEyZrv
        a6D0n2CAJJ/AKlBVSa2XTOoccbJvM709eeOw
X-Google-Smtp-Source: ABdhPJxp7kOe5CQTLKqSu61Pmt1p/02N6FRencBxyisW0zbM9w4CjKAGwVOwb28H7CndKCl0Pj/9qXZbp1GrMyxc
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:95a:d8a8:4925:42be])
 (user=andreyknvl job=sendgmr) by 2002:a17:906:a049:: with SMTP id
 bg9mr8819448ejb.186.1615559080372; Fri, 12 Mar 2021 06:24:40 -0800 (PST)
Date:   Fri, 12 Mar 2021 15:24:25 +0100
In-Reply-To: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
Message-Id: <1486fba8514de3d7db2f47df2192db59228b0a7b.1615559068.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v2 02/11] kasan: docs: update overview section
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

Update the "Overview" section in KASAN documentation:

- Outline main use cases for each mode.
- Mention that HW_TAGS mode need compiler support too.
- Move the part about SLUB/SLAB support from "Usage" to "Overview".
- Punctuation, readability, and other minor clean-ups.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v1->v2:
- Mention GCC support for HW_TAGS.
---
 Documentation/dev-tools/kasan.rst | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index b3b2c517db55..2f2697b290d5 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -11,17 +11,31 @@ designed to find out-of-bound and use-after-free bugs. KASAN has three modes:
 2. software tag-based KASAN (similar to userspace HWASan),
 3. hardware tag-based KASAN (based on hardware memory tagging).
 
-Software KASAN modes (1 and 2) use compile-time instrumentation to insert
-validity checks before every memory access, and therefore require a compiler
+Generic KASAN is mainly used for debugging due to a large memory overhead.
+Software tag-based KASAN can be used for dogfood testing as it has a lower
+memory overhead that allows using it with real workloads. Hardware tag-based
+KASAN comes with low memory and performance overheads and, therefore, can be
+used in production. Either as an in-field memory bug detector or as a security
+mitigation.
+
+Software KASAN modes (#1 and #2) use compile-time instrumentation to insert
+validity checks before every memory access and, therefore, require a compiler
 version that supports that.
 
-Generic KASAN is supported in both GCC and Clang. With GCC it requires version
+Generic KASAN is supported in GCC and Clang. With GCC, it requires version
 8.3.0 or later. Any supported Clang version is compatible, but detection of
 out-of-bounds accesses for global variables is only supported since Clang 11.
 
-Tag-based KASAN is only supported in Clang.
+Software tag-based KASAN mode is only supported in Clang.
 
-Currently generic KASAN is supported for the x86_64, arm, arm64, xtensa, s390
+The hardware KASAN mode (#3) relies on hardware to perform the checks but
+still requires a compiler version that supports memory tagging instructions.
+This mode is supported in GCC 10+ and Clang 11+.
+
+Both software KASAN modes work with SLUB and SLAB memory allocators,
+while the hardware tag-based KASAN currently only supports SLUB.
+
+Currently, generic KASAN is supported for the x86_64, arm, arm64, xtensa, s390,
 and riscv architectures, and tag-based KASAN modes are supported only for arm64.
 
 Usage
@@ -39,9 +53,6 @@ For software modes, you also need to choose between CONFIG_KASAN_OUTLINE and
 CONFIG_KASAN_INLINE. Outline and inline are compiler instrumentation types.
 The former produces smaller binary while the latter is 1.1 - 2 times faster.
 
-Both software KASAN modes work with both SLUB and SLAB memory allocators,
-while the hardware tag-based KASAN currently only support SLUB.
-
 For better error reports that include stack traces, enable CONFIG_STACKTRACE.
 
 To augment reports with last allocation and freeing stack of the physical page,
-- 
2.31.0.rc2.261.g7f71774620-goog

