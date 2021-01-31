Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74CF309963
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 01:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhAaAVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 19:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbhAaARE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 19:17:04 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51B2C061574
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:31 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id c132so9446527pga.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tkrptTBK3N3R404MIQhBTsLhuUAmLX1yl6cqYDzKwyA=;
        b=WjebMTziYJW52tJp0ecHzhl0k1PuuNiWVAV+79HZYfxsnt5v4az2VBXEzvPkAHS6Q9
         hjT1LxAy2ED9H+NVTdABs2daiWJLGsg9Jbp97LsFT8TPB7fPnMns14St8gL9pl0KJdJi
         jUHg+3yPAd7aKlu2mg/YH19B3bejOWyhMlyqDbilE6I0G3ZJjiDWjqnZz+fO7sTPp6dZ
         vyqe6gKiUcV6hZJVcwAui8L71cdM9pgzHchPndGr1ook+9Gd92I7wU2/zhlZwv7AdTha
         4O0kAUXxZJ8u+f+mDWzqbWK+EYI4SOOmL3F1q3aMvRo6Mtpc3C9UgLi+DPzuiHziC2HN
         TwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tkrptTBK3N3R404MIQhBTsLhuUAmLX1yl6cqYDzKwyA=;
        b=kxZz4HMn6Zdep+GKIfMI1YbWyZZ7fL767E5fnUP9hCWVZLffUAaI40AlQ36+XTMNep
         3Pc4N8qwMwmUBk5kLE07fepXQOgjsdsrdvSYWv4aSGI8QC6YK/l3tUOgXJksA4IibIKA
         JaBNnY5KHE79fstbzN4D/mzcvPTkl/OcS7eLo8jWCI40IM3EOFjYFgTBxc1UIy8UaIcx
         cMITz26ShS6IXlJONUQL7RTi6Oa2H8cvi0UmAhfruTYLbHggJhJ7XV8NMDD8kHuOtdD5
         penwEUCu+ujN6flMA7PxXC7WCmorUiwkeMRg5jQwynFmHxNgBFzUFba+M7Ap3SZq6+an
         0I2A==
X-Gm-Message-State: AOAM53160jV/VDz41pNcyvqytv/W9aPTDBLFpvUNSDjbZ/HCQ+Dfmm3z
        E44+G6NaEt3z4wf/wgQoHx4=
X-Google-Smtp-Source: ABdhPJwXMFg7+1aJTyLt9vDF5ckFJc96jqdhXgkz0Lsqm2Hnw2vjWguS2Ee3rjHPCC7agJskagZBmQ==
X-Received: by 2002:a65:430b:: with SMTP id j11mr10240396pgq.130.1612052191427;
        Sat, 30 Jan 2021 16:16:31 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id e12sm13127365pga.13.2021.01.30.16.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 16:16:30 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <namit@vmware.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        x86@kernel.org
Subject: [RFC 19/20] lib/cpumask: introduce cpumask_atomic_or()
Date:   Sat, 30 Jan 2021 16:11:31 -0800
Message-Id: <20210131001132.3368247-20-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210131001132.3368247-1-namit@vmware.com>
References: <20210131001132.3368247-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Introduce cpumask_atomic_or() and bitmask_atomic_or() to allow to
perform atomic or operations atomically on cpumasks. This will be used
by the next patch.

To be more efficient, skip atomic operations when no changes are needed.

Signed-off-by: Nadav Amit <namit@vmware.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: x86@kernel.org
---
 include/linux/bitmap.h  |  5 +++++
 include/linux/cpumask.h | 12 ++++++++++++
 lib/bitmap.c            | 25 +++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 769b7a98e12f..c9a9b784b244 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -76,6 +76,7 @@
  *  bitmap_to_arr32(buf, src, nbits)            Copy nbits from buf to u32[] dst
  *  bitmap_get_value8(map, start)               Get 8bit value from map at start
  *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
+ *  bitmap_atomic_or(dst, src, nbits)		*dst |= *src (atomically)
  *
  * Note, bitmap_zero() and bitmap_fill() operate over the region of
  * unsigned longs, that is, bits behind bitmap till the unsigned long
@@ -577,6 +578,10 @@ static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
 	map[index] |= value << offset;
 }
 
+extern void bitmap_atomic_or(volatile unsigned long *dst,
+		const volatile unsigned long *bitmap, unsigned int bits);
+
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __LINUX_BITMAP_H */
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 3d7e418aa113..0567d73a0192 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -699,6 +699,18 @@ static inline unsigned int cpumask_size(void)
 	return BITS_TO_LONGS(nr_cpumask_bits) * sizeof(long);
 }
 
+/**
+ * cpumask_atomic_or - *dstp |= *srcp (*dstp is set atomically)
+ * @dstp: the cpumask result (and source which is or'd)
+ * @srcp: the source input
+ */
+static inline void cpumask_atomic_or(volatile struct cpumask *dstp,
+				     const volatile struct cpumask *srcp)
+{
+	bitmap_atomic_or(cpumask_bits(dstp), cpumask_bits(srcp),
+			 nr_cpumask_bits);
+}
+
 /*
  * cpumask_var_t: struct cpumask for stack usage.
  *
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 6df7b13727d3..50f1842ff891 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1310,3 +1310,28 @@ void bitmap_to_arr32(u32 *buf, const unsigned long *bitmap, unsigned int nbits)
 EXPORT_SYMBOL(bitmap_to_arr32);
 
 #endif
+
+void bitmap_atomic_or(volatile unsigned long *dst,
+		      const volatile unsigned long *bitmap, unsigned int bits)
+{
+	unsigned int k;
+	unsigned int nr = BITS_TO_LONGS(bits);
+
+	for (k = 0; k < nr; k++) {
+		unsigned long src = bitmap[k];
+
+		/*
+		 * Skip atomic operations when no bits are changed. Do not use
+		 * bitmap[k] directly to avoid redundant loads as bitmap
+		 * variable is volatile.
+		 */
+		if (!(src & ~dst[k]))
+			continue;
+
+		if (BITS_PER_LONG == 64)
+			atomic64_or(src, (atomic64_t*)&dst[k]);
+		else
+			atomic_or(src, (atomic_t*)&dst[k]);
+	}
+}
+EXPORT_SYMBOL(bitmap_atomic_or);
-- 
2.25.1

