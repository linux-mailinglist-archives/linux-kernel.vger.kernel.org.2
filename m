Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC96F32AE05
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360372AbhCBWTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240248AbhCBU6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 15:58:32 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9318CC061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 12:57:49 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id s7so11686357qkg.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 12:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZJLDfWzNU3w9w48fw//Uxyb1sOcIpyn6YYFLL1vcIk8=;
        b=Kzt75NHgnvYvy5prBScBu7knefWFLKoR8R0acXtUSwTMkQWiqa6IKhg9XDU/4NmMSe
         QKzybEvDTbkp6MMPdwgaUE6k/Ip3hRFF1ya1Maax8049PegWP/FF7m0G6N68xgeZZnVu
         LCq3BYY0GUmtQfh9LBaqBgi3qiUczqtzcfBI1UAPSWZNz2EQFxnHQj0zR3FALHG85ogF
         E/6TmRHYjO/68sowblYtMA/VhzBv/THqUFPGlZhwy0YR3C+COCjXrVGBiyGdfEWhInXZ
         +Ta/tK4yL3AX0ECzeCOI3yct8avAXBf8vK/yfmJAKoYd3SyTX+lKM4kPRYJEvLdIJV5D
         tcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZJLDfWzNU3w9w48fw//Uxyb1sOcIpyn6YYFLL1vcIk8=;
        b=rYtGTyehopyWuDb2+yG/z+1dGsY0S0w5tC2dI443k5xwxTsPCv5cTK/n2JjEDLv9AQ
         A3DB8kWK9XiQtWwTdW75j4BfhNXeyawZB04YMjh4e61GVjjF27ODN5MajZImc1yI3YZz
         SZEfOo659CufGsaf4yokPmFogEv7U6BZMnwGgangvi8HO0E41ziJ9ivpg1J3zgqDb3E9
         UolkXQPCHW1hkjq2D3EWs/737CJKwY2qdHRbcUGSL17j8AMmH3d4Osyu618kdG83hD8D
         ghLYJYBAjCcHvYX92KLKX+lKrm+rdGzD/KsYL++eDrRAiVqk4wOJOZyvZ4XO5co9JvP+
         cwrg==
X-Gm-Message-State: AOAM531Za7HygP3liNJzFx7YIPoEjbUdilY5a26oXX46WAtYpu+OXzvS
        1EpiIzKLnJgj3U1iB5wlxOB2W+d8l8wWhubIXaz91Q==
X-Google-Smtp-Source: ABdhPJw0haNBhBmd7Nq5Fhul1gjYH1mxEnMeKt1Puz2dK51kSJTZWonEDe6kPsfddSQ0/wYAyaQsYBQKv453MVySN9U=
X-Received: by 2002:a05:620a:1410:: with SMTP id d16mr20764625qkj.465.1614718668150;
 Tue, 02 Mar 2021 12:57:48 -0800 (PST)
MIME-Version: 1.0
References: <20210226195239.3905966-1-joshdon@google.com> <YDliCOPy9s1RdLwd@hirez.programming.kicks-ass.net>
 <CABk29Nv7iJEcDg3rgSvfTkXEM69ZeLByJAsZYuA5qpdj645nZw@mail.gmail.com>
In-Reply-To: <CABk29Nv7iJEcDg3rgSvfTkXEM69ZeLByJAsZYuA5qpdj645nZw@mail.gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 2 Mar 2021 12:57:37 -0800
Message-ID: <CABk29Ntt88BfqGz=Rjd5Mwyj+N0YLv0Z9QsZp8DgB-n+FV1Zgw@mail.gmail.com>
Subject: Re: [PATCH] sched: Optimize __calc_delta.
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Clement Courbet <courbet@google.com>,
        Oleg Rombakh <olegrom@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clement Courbet <courbet@google.com>

A significant portion of __calc_delta time is spent in the loop
shifting a u64 by 32 bits. Use `fls` instead of iterating.

This is ~7x faster on benchmarks.

The generic `fls` implementation (`generic_fls`) is still ~4x faster
than the loop.
Architectures that have a better implementation will make use of it. For
example, on X86 we get an additional factor 2 in speed without dedicated
implementation.

On gcc, the asm versions of `fls` are about the same speed as the
builtin. On clang, the versions that use fls (fls,fls64) are more than
twice as slow as the builtin. This is because the way the `fls` function
is written, clang puts the value in memory:
https://godbolt.org/z/EfMbYe. This can be fixed in a separate patch.

```
name                                   cpu/op
BM_Calc<__calc_delta_loop>             9.57ms =C2=B112%
BM_Calc<__calc_delta_generic_fls>      2.36ms =C2=B113%
BM_Calc<__calc_delta_asm_fls>          2.45ms =C2=B113%
BM_Calc<__calc_delta_asm_fls_nomem>    1.66ms =C2=B112%
BM_Calc<__calc_delta_asm_fls64>        2.46ms =C2=B113%
BM_Calc<__calc_delta_asm_fls64_nomem>  1.34ms =C2=B115%
BM_Calc<__calc_delta_builtin>          1.32ms =C2=B111%
```

Signed-off-by: Clement Courbet <courbet@google.com>
Signed-off-by: Josh Don <joshdon@google.com>
---
 kernel/sched/fair.c  | 30 ++++++++++++++++++++++--------
 kernel/sched/sched.h |  1 +
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a8bd7b13634..67e5a1d536ad 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -214,6 +214,16 @@ static void __update_inv_weight(struct load_weight *lw=
)
  lw->inv_weight =3D WMULT_CONST / w;
 }

+/*
+ * An fls that handles an u32 value on architectures
+ * where `sizeof(unsigned int) < 32`.
+ */
+#if (__SIZEOF_INT__ >=3D 32)
+# define FLS_AT_LEAST_32(v) fls(v)
+#else
+# define FLS_AT_LEAST_32(v) fls64(v)
+#endif
+
 /*
  * delta_exec * weight / lw.weight
  *   OR
@@ -229,27 +239,31 @@ static void __update_inv_weight(struct load_weight *l=
w)
 static u64 __calc_delta(u64 delta_exec, unsigned long weight, struct
load_weight *lw)
 {
  u64 fact =3D scale_load_down(weight);
+ u32 fact_hi =3D (u32)(fact >> 32);
  int shift =3D WMULT_SHIFT;
+ int fs;

  __update_inv_weight(lw);

- if (unlikely(fact >> 32)) {
- while (fact >> 32) {
- fact >>=3D 1;
- shift--;
- }
+ if (unlikely(fact_hi)) {
+ fs =3D FLS_AT_LEAST_32(fact_hi);
+ shift -=3D fs;
+ fact >>=3D fs;
  }

  fact =3D mul_u32_u32(fact, lw->inv_weight);

- while (fact >> 32) {
- fact >>=3D 1;
- shift--;
+ fact_hi =3D (u32)(fact >> 32);
+ if (fact_hi) {
+ fs =3D FLS_AT_LEAST_32(fact_hi);
+ shift -=3D fs;
+ fact >>=3D fs;
  }

  return mul_u64_u32_shr(delta_exec, fact, shift);
 }

+#undef FLS_AT_LEAST_32

 const struct sched_class fair_sched_class;

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 10a1522b1e30..714af71cf983 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -36,6 +36,7 @@
 #include <uapi/linux/sched/types.h>

 #include <linux/binfmts.h>
+#include <linux/bitops.h>
 #include <linux/blkdev.h>
 #include <linux/compat.h>
 #include <linux/context_tracking.h>
--=20
2.30.1.766.gb4fecdf3b7-goog
