Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A87E35F885
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351106AbhDNPzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:55:11 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:44744 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347376AbhDNPzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:55:00 -0400
Received: by mail-ot1-f45.google.com with SMTP id t17-20020a9d77510000b0290287a5143b41so8532009otl.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:54:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DjdlDe1r8PWcI8CJTWfGrTFm/qYeuvm3S8MlLSmS6yU=;
        b=kHAbeOZMdanUc2nBKdDgxJN9yGWfPaM0UFki7OKI08jDhccfFR+FMBFY5w3kKcHToI
         HaFsk9NwZkjbM6P31CGX3XSw5lx75LkhLdQG8lnrnH2tuVOI1uv5XrkANrzAc/P2AIQp
         KxI7GIfBkKmyQh+g7C69ttWeX2w3uuBUG+aJu9XujLEju6Ze9Ht5HYioH98ly7w8HSXH
         Q37zhlotJQK2ANzNAqiyYOL/8lqWu+J7Zq3kxfqR00wmfG0XP5D9XO/E48C8AchBb41M
         7+zHZB50yZe/tpVZrQxaKyH9yPZ1iu+OPbTyjQrGhWIpxYPJnIWXer5kds3JhO/CFRtP
         DlzA==
X-Gm-Message-State: AOAM5338l6LH1QpLsUkR9y963jPWEzQCh+dV7/Q9b/li44KyuRkQTlNk
        fZjB5/RhIFrmY79lKZgv3WO3WOec4Q==
X-Google-Smtp-Source: ABdhPJzUGWUK7q1izTsmNH5ER4HjcyBuN/A2hXiR/JbPezOW0su8IpafPsMmONhRZqvu0MQ9gEVcTQ==
X-Received: by 2002:a05:6830:1c6d:: with SMTP id s13mr22171652otg.183.1618415677923;
        Wed, 14 Apr 2021 08:54:37 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id x14sm41830otk.32.2021.04.14.08.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 08:54:25 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: [PATCH v8 1/4] tools/include: Add an initial math64.h
Date:   Wed, 14 Apr 2021 10:54:09 -0500
Message-Id: <20210414155412.3697605-2-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414155412.3697605-1-robh@kernel.org>
References: <20210414155412.3697605-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an initial math64.h similar to linux/math64.h with functions
mul_u64_u64_div64() and mul_u64_u32_shr(). This isn't a direct copy of
include/linux/math64.h as that doesn't define mul_u64_u64_div64().

Implementation was written by Peter Zilkstra based on linux/math64.h
and div64.h[1]. The original implementation was not optimal on arm64 as
__int128 division is not optimal with a call out to __udivti3, so I
dropped the __int128 variant of mul_u64_u64_div64().

[1] https://lore.kernel.org/lkml/20200322101848.GF2452@worktop.programming.kicks-ass.net/

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 tools/include/linux/math64.h | 75 ++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 tools/include/linux/math64.h

diff --git a/tools/include/linux/math64.h b/tools/include/linux/math64.h
new file mode 100644
index 000000000000..4ad45d5943dc
--- /dev/null
+++ b/tools/include/linux/math64.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MATH64_H
+#define _LINUX_MATH64_H
+
+#include <linux/types.h>
+
+#ifdef __x86_64__
+static inline u64 mul_u64_u64_div64(u64 a, u64 b, u64 c)
+{
+	u64 q;
+
+	asm ("mulq %2; divq %3" : "=a" (q)
+				: "a" (a), "rm" (b), "rm" (c)
+				: "rdx");
+
+	return q;
+}
+#define mul_u64_u64_div64 mul_u64_u64_div64
+#endif
+
+#ifdef __SIZEOF_INT128__
+static inline u64 mul_u64_u32_shr(u64 a, u32 b, unsigned int shift)
+{
+	return (u64)(((unsigned __int128)a * b) >> shift);
+}
+
+#else
+
+#ifdef __i386__
+static inline u64 mul_u32_u32(u32 a, u32 b)
+{
+	u32 high, low;
+
+	asm ("mull %[b]" : "=a" (low), "=d" (high)
+			 : [a] "a" (a), [b] "rm" (b) );
+
+	return low | ((u64)high) << 32;
+}
+#else
+static inline u64 mul_u32_u32(u32 a, u32 b)
+{
+	return (u64)a * b;
+}
+#endif
+
+static inline u64 mul_u64_u32_shr(u64 a, u32 b, unsigned int shift)
+{
+	u32 ah, al;
+	u64 ret;
+
+	al = a;
+	ah = a >> 32;
+
+	ret = mul_u32_u32(al, b) >> shift;
+	if (ah)
+		ret += mul_u32_u32(ah, b) << (32 - shift);
+
+	return ret;
+}
+
+#endif	/* __SIZEOF_INT128__ */
+
+#ifndef mul_u64_u64_div64
+static inline u64 mul_u64_u64_div64(u64 a, u64 b, u64 c)
+{
+	u64 quot, rem;
+
+	quot = a / c;
+	rem = a % c;
+
+	return quot * b + (rem * b) / c;
+}
+#endif
+
+#endif /* _LINUX_MATH64_H */
-- 
2.27.0

