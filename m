Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CD632C41B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354464AbhCDALN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449777AbhCCXBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 18:01:24 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E14C0613E7
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 14:48:31 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id b18so10485132qtt.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 14:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc:content-transfer-encoding;
        bh=6GsG4BSAoi0zOG8y5aYDqIlqcuuhkTJOTNFA5M+6RFc=;
        b=Y+A60D74ZEOuyHZ0L1sPY5s3pbrklD3/nblbLXwuEcfrO1g3joof/HL3d5YCNi5jo1
         v4bSIWtF43Yn9qvmJHzQF+Q3ct3Oht1mLrWbCB7kOd5GixooBS2AdHdfj/JVsc4jbpIQ
         MdxodfcTClAHtD9ALV7rwYQmGnS0jvHFmdZjOmACc15f2QwwHzSWkU1zFsfHCah0mOgq
         cyx55+hWfJejGSy+vjQcl1e+9ryEL/VU5t8KkavULxn0MzYoH/fsqq9/n6Ijs71P/oFs
         ZFJR6CgOtiKLyudIuegTjV7rnxNcwlVE3NBH/TXxRkqXSfiVQ5ghF1CphdDQSBKo3WT3
         ev3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=6GsG4BSAoi0zOG8y5aYDqIlqcuuhkTJOTNFA5M+6RFc=;
        b=J0RthSaCw4FpA2oABbvkZw7UXDxBhUbyJV8vTCl2XYOK9K9dmfr+BR4g98QQrMLOYe
         2QNX9/9N38wRjzwELv+IRw/sajLuCs+mMk5M6RsNAHqnnXWgwL7Ipdz4HgWJU1TN4rri
         +IC0+fg6Ns7nN3y8ki/cnqZ/LFDMv+PXlMw5MZ+o/bCE6NyYut6ZIZ+6LtODu7EGtEzQ
         TfrFMCN5CT3tfWiR+VZjs0Fpe3hPWdOYgeDNkz5x7fvSjHX1Bsz4t5XN+9Ejojg9ub2c
         2eERTdBfoE/z8oMiWeN7ta5lgNjcc9EMeQnWL70zmAVRAmel2ePijRQd1erC1h/Jkqtf
         rMtQ==
X-Gm-Message-State: AOAM533mfm2br9f25CeDhTmkZyP/L7vDVW6Y/hGx3fTXZ3/ESRNiznZH
        H41zdsa1CH8FJ9XkvVF99jmPm9QBgl1P
X-Google-Smtp-Source: ABdhPJwUJiSK1nnsgdcA8xGtVOq+Dr9R520jeAFaT9su2xEVBnARovyShv8AC+KYXSXQRcGeDcZrHnTglNYC
Sender: "joshdon via sendgmr" <joshdon@joshdon.svl.corp.google.com>
X-Received: from joshdon.svl.corp.google.com ([2620:15c:2cd:202:6dda:c053:b83b:4416])
 (user=joshdon job=sendgmr) by 2002:ad4:5d46:: with SMTP id
 jk6mr1274223qvb.22.1614811710568; Wed, 03 Mar 2021 14:48:30 -0800 (PST)
Date:   Wed,  3 Mar 2021 14:46:53 -0800
In-Reply-To: <YD9dUkGhlRT8vvcy@hirez.programming.kicks-ass.net>
Message-Id: <20210303224653.2579656-1-joshdon@google.com>
Mime-Version: 1.0
References: <YD9dUkGhlRT8vvcy@hirez.programming.kicks-ass.net>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v2] sched: Optimize __calc_delta.
From:   Josh Don <joshdon@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Clement Courbet <courbet@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Josh Don <joshdon@google.com>
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
builtin. On clang, the versions that use fls are more than twice as
slow as the builtin. This is because the way the `fls` function is
written, clang puts the value in memory:
https://godbolt.org/z/EfMbYe. This bug is filed at
https://bugs.llvm.org/show_bug.cgi?id=3D49406.

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
 kernel/sched/fair.c  | 19 +++++++++++--------
 kernel/sched/sched.h |  1 +
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a8bd7b13634..a691371960ae 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -229,22 +229,25 @@ static void __update_inv_weight(struct load_weight *l=
w)
 static u64 __calc_delta(u64 delta_exec, unsigned long weight, struct load_=
weight *lw)
 {
 	u64 fact =3D scale_load_down(weight);
+	u32 fact_hi =3D (u32)(fact >> 32);
 	int shift =3D WMULT_SHIFT;
+	int fs;
=20
 	__update_inv_weight(lw);
=20
-	if (unlikely(fact >> 32)) {
-		while (fact >> 32) {
-			fact >>=3D 1;
-			shift--;
-		}
+	if (unlikely(fact_hi)) {
+		fs =3D fls(fact_hi);
+		shift -=3D fs;
+		fact >>=3D fs;
 	}
=20
 	fact =3D mul_u32_u32(fact, lw->inv_weight);
=20
-	while (fact >> 32) {
-		fact >>=3D 1;
-		shift--;
+	fact_hi =3D (u32)(fact >> 32);
+	if (fact_hi) {
+		fs =3D fls(fact_hi);
+		shift -=3D fs;
+		fact >>=3D fs;
 	}
=20
 	return mul_u64_u32_shr(delta_exec, fact, shift);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 10a1522b1e30..714af71cf983 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -36,6 +36,7 @@
 #include <uapi/linux/sched/types.h>
=20
 #include <linux/binfmts.h>
+#include <linux/bitops.h>
 #include <linux/blkdev.h>
 #include <linux/compat.h>
 #include <linux/context_tracking.h>
--=20
2.30.1.766.gb4fecdf3b7-goog

