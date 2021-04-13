Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E0C35E4CA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238090AbhDMRQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:16:31 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:38413 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbhDMRQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:16:29 -0400
Received: by mail-oi1-f175.google.com with SMTP id b3so2941274oie.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 10:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DjdlDe1r8PWcI8CJTWfGrTFm/qYeuvm3S8MlLSmS6yU=;
        b=EDJ5tsnQ6QXxLgheO22irKYS9ou0LMSKEi19p7c5fgfg1iIGEoF1TkZiCXG/u9cA2J
         HWF2+h451GVEFV4iC7iHX/ygjzHwlwijGRv4+IINgMec5fmn6idOZHlnvTU9Ho0VMQ7I
         2jSDgWellSc3vU4Jx6GL1eRUptx4sbFAsZn3cDrnfo1mwCh66yN0JxSskAXIM29RW8v7
         Zbs7diENXUTD00RsQj2ZbWzV0LHb25i1DZnRCLY0KRjlN57vfEefr+aW3WTnkw4h+grT
         K8BWdmnDERS9VEOr20oWbweM5HTu3d0vO8suaMBkGXm9z3vGJUvkpbhO+Qp5cWBOavjR
         CaTA==
X-Gm-Message-State: AOAM531ObHj6ZFt7oiBWbuzPiilCqYbdYbaaW8tZmJ/OX944ffcfVYmq
        lmnooya2bMfjyLyBbqm66k10SOAFPg==
X-Google-Smtp-Source: ABdhPJwaWwrmyVCjgZD0r9AzEEYLX7x3eSO85FagSIpGAs9he2rMCV5WxE9DzRoVKB5qiNWrfEKCYg==
X-Received: by 2002:aca:35d4:: with SMTP id c203mr767309oia.10.1618334169077;
        Tue, 13 Apr 2021 10:16:09 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id y4sm109278oia.53.2021.04.13.10.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 10:16:08 -0700 (PDT)
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
Subject: [PATCH v7 1/4] tools/include: Add an initial math64.h
Date:   Tue, 13 Apr 2021 12:16:03 -0500
Message-Id: <20210413171606.1825808-2-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210413171606.1825808-1-robh@kernel.org>
References: <20210413171606.1825808-1-robh@kernel.org>
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

