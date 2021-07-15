Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5693CA206
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 18:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhGOQP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 12:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhGOQP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 12:15:26 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515C9C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 09:12:32 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id w13so4947136qtc.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 09:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bre0vF7XWmCbJVG72BGhyPpBbSJu4VjgTtLF+h1KUBo=;
        b=JOhHJUz5QW8H6C9+RBWUpdkdro5EFHj3DVEx28+E47u2jMr9aRjhsi3b24A8RD2e5W
         8IVHAw/LCrMVVXca1h/A2/MUMBJ2svof2nj9ECCb+impCd0m1ZGM+8T1qejzMI6FcaL/
         jZC1aVm976xIpruRt9S5nZv0Fm3xHfAI8tb+MVsQd0V8CnFYAf5vVxGl1V88rBR9bzSd
         qz4iC9pnDffHOYQm3dkU2dDVSh2wum71U7837AN4BW/xBkOwgUJ8AG3t8HuHAyiBN/y+
         E1GpwFOjAPtwXzvuO/EnLT6kOa05YUp8siTmVPxe8rT2QgddmIQU8qpHJLS1TrX8NeRR
         XNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Bre0vF7XWmCbJVG72BGhyPpBbSJu4VjgTtLF+h1KUBo=;
        b=BTVvR2SXhZhIU0uVWK+8UvExf1Zn5k33UN3Ei6k6m39pP7091GOSHSdMz9RIw15yLy
         agaTcku+EmYF/pBAxybJ6xBK3tlpsHivQijugCgSMDFEwTQdG/+dwwb8wOHeoVyOZgZl
         y/rSxlWT8aUyRVXIc0HutRPnzLJSrm9XIDdCy0PbUbxUXwwaUMmJIzM7KWuHgtFkI5N/
         Do+ERB8a1waHP9L+3JySqTciMZOJBa1MZrFrAK8otbolrCnZwUMqfv/Cn6u5IkBcMirE
         sd9k5+6y/4Xy/eboRtABkuEQF58iO/vmDC/z3oRYeO6kui7DBqdbr+BVrqhOy1IwNoX0
         oZEQ==
X-Gm-Message-State: AOAM5316VPOOIoAvuupaTxM5BkoueAClqEDVn1fpMhjeu1hRU5JCTuWs
        LNaRmcc2cT4pcn0P2Luj5Z738g==
X-Google-Smtp-Source: ABdhPJx2g//5xg2P6vaDbMaIKI2Z0XvAZ2zbf4wrElr+PDWGYUrxr4doh7S73cwBAW1b7pjixz13AA==
X-Received: by 2002:ac8:47c5:: with SMTP id d5mr4532053qtr.231.1626365551257;
        Thu, 15 Jul 2021 09:12:31 -0700 (PDT)
Received: from iron-maiden.localnet (50-200-151-121-static.hfc.comcastbusiness.net. [50.200.151.121])
        by smtp.gmail.com with ESMTPSA id g17sm2721332qkm.34.2021.07.15.09.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:12:30 -0700 (PDT)
From:   Carlos Bilbao <bilbao@vt.edu>
To:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>, jianyong.wu@arm.com,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] include: linux: Reorganize timekeeping and ktime headers
Date:   Thu, 15 Jul 2021 12:12:29 -0400
Message-ID: <4331271.LvFx2qVVIh@iron-maiden>
Organization: Virginia Tech
In-Reply-To: <5481808.DvuYhMxLoT@iron-maiden>
References: <5729424.lOV4Wx5bFT@iron-maiden> <2591466.mvXUDI8C0e@iron-maiden> <5481808.DvuYhMxLoT@iron-maiden>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorganize and separate the headers by making ktime.h take care of the 
ktime_get() family of functions, and reserve timekeeping.h for the actual 
timekeeping. This also helps to avoid implicit function errors and strengthens
the header dependencies, since timekeeping.h was using ktime_to_ns(), a static 
function defined in a header it does no include, ktime.h. This patch also 
includes the header timekeeping.h wherever it is necessary for a successful
compilation after the header code reorganization.

Signed-off-by: Carlos Bilbao <bilbao@vt.edu>
---
 arch/x86/kernel/tsc.c       |   1 +
 include/linux/ktime.h       | 196 +++++++++++++++++++++++++++++++++++-
 include/linux/sched_clock.h |   2 +
 include/linux/timekeeping.h | 196 +-----------------------------------
 init/main.c                 |   1 +
 kernel/time/ntp.c           |   1 +
 kernel/time/time.c          |   1 +
 kernel/time/timekeeping.c   |   1 +
 8 files changed, 202 insertions(+), 197 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 2e076a459a0c..b730cb20f5fd 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -15,6 +15,7 @@
 #include <linux/timex.h>
 #include <linux/static_key.h>
 #include <linux/static_call.h>
+#include <linux/timekeeping.h>
 
 #include <asm/hpet.h>
 #include <asm/timer.h>
diff --git a/include/linux/ktime.h b/include/linux/ktime.h
index 73f20deb497d..37955d6664dd 100644
--- a/include/linux/ktime.h
+++ b/include/linux/ktime.h
@@ -229,6 +229,198 @@ static inline ktime_t ms_to_ktime(u64 ms)
        return ms * NSEC_PER_MSEC;
 }
 
-# include <linux/timekeeping.h>
+/*
+ * ktime_get() family: read the current time in a multitude of ways,
+ *
+ * The default time reference is CLOCK_MONOTONIC, starting at
+ * boot time but not counting the time spent in suspend.
+ * For other references, use the functions with "real", "clocktai",
+ * "boottime" and "raw" suffixes.
+ *
+ * To get the time in a different format, use the ones wit
+ * "ns", "ts64" and "seconds" suffix.
+ *
+ * See Documentation/core-api/timekeeping.rst for more details.
+ */
 
-#endif
+
+/*
+ * timespec64 based interfaces
+ */
+extern void ktime_get_raw_ts64(struct timespec64 *ts);
+extern void ktime_get_ts64(struct timespec64 *ts);
+extern void ktime_get_real_ts64(struct timespec64 *tv);
+extern void ktime_get_coarse_ts64(struct timespec64 *ts);
+extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
+
+void getboottime64(struct timespec64 *ts);
+
+/*
+ * time64_t base interfaces
+ */
+extern time64_t ktime_get_seconds(void);
+extern time64_t __ktime_get_real_seconds(void);
+extern time64_t ktime_get_real_seconds(void);
+
+/*
+ * ktime_t based interfaces
+ */
+
+enum tk_offsets {
+       TK_OFFS_REAL,
+       TK_OFFS_BOOT,
+       TK_OFFS_TAI,
+       TK_OFFS_MAX,
+};
+
+extern ktime_t ktime_get(void);
+extern ktime_t ktime_get_with_offset(enum tk_offsets offs);
+extern ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs);
+extern ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs);
+extern ktime_t ktime_get_raw(void);
+extern u32 ktime_get_resolution_ns(void);
+
+/**
+ * ktime_get_real - get the real (wall-) time in ktime_t format
+ */
+static inline ktime_t ktime_get_real(void)
+{
+       return ktime_get_with_offset(TK_OFFS_REAL);
+}
+
+static inline ktime_t ktime_get_coarse_real(void)
+{
+       return ktime_get_coarse_with_offset(TK_OFFS_REAL);
+}
+
+/**
+ * ktime_get_boottime - Returns monotonic time since boot in ktime_t format
+ *
+ * This is similar to CLOCK_MONTONIC/ktime_get, but also includes the
+ * time spent in suspend.
+ */
+static inline ktime_t ktime_get_boottime(void)
+{
+       return ktime_get_with_offset(TK_OFFS_BOOT);
+}
+
+static inline ktime_t ktime_get_coarse_boottime(void)
+{
+       return ktime_get_coarse_with_offset(TK_OFFS_BOOT);
+}
+
+/**
+ * ktime_get_clocktai - Returns the TAI time of day in ktime_t format
+ */
+static inline ktime_t ktime_get_clocktai(void)
+{
+       return ktime_get_with_offset(TK_OFFS_TAI);
+}
+
+static inline ktime_t ktime_get_coarse_clocktai(void)
+{
+       return ktime_get_coarse_with_offset(TK_OFFS_TAI);
+}
+
+static inline ktime_t ktime_get_coarse(void)
+{
+       struct timespec64 ts;
+
+       ktime_get_coarse_ts64(&ts);
+       return timespec64_to_ktime(ts);
+}
+
+static inline u64 ktime_get_coarse_ns(void)
+{
+       return ktime_to_ns(ktime_get_coarse());
+}
+
+static inline u64 ktime_get_coarse_real_ns(void)
+{
+       return ktime_to_ns(ktime_get_coarse_real());
+}
+
+static inline u64 ktime_get_coarse_boottime_ns(void)
+{
+       return ktime_to_ns(ktime_get_coarse_boottime());
+}
+
+static inline u64 ktime_get_coarse_clocktai_ns(void)
+{
+       return ktime_to_ns(ktime_get_coarse_clocktai());
+}
+
+/**
+ * ktime_mono_to_real - Convert monotonic time to clock realtime
+ */
+static inline ktime_t ktime_mono_to_real(ktime_t mono)
+{
+       return ktime_mono_to_any(mono, TK_OFFS_REAL);
+}
+
+static inline u64 ktime_get_ns(void)
+{
+       return ktime_to_ns(ktime_get());
+}
+
+static inline u64 ktime_get_real_ns(void)
+{
+       return ktime_to_ns(ktime_get_real());
+}
+
+static inline u64 ktime_get_boottime_ns(void)
+{
+       return ktime_to_ns(ktime_get_boottime());
+}
+
+static inline u64 ktime_get_clocktai_ns(void)
+{
+       return ktime_to_ns(ktime_get_clocktai());
+}
+
+static inline u64 ktime_get_raw_ns(void)
+{
+       return ktime_to_ns(ktime_get_raw());
+}
+
+extern u64 ktime_get_mono_fast_ns(void);
+extern u64 ktime_get_raw_fast_ns(void);
+extern u64 ktime_get_boot_fast_ns(void);
+extern u64 ktime_get_real_fast_ns(void);
+
+/*
+ * timespec64/time64_t interfaces utilizing the ktime based ones
+ * for API completeness, these could be implemented more efficiently
+ * if needed.
+ */
+static inline void ktime_get_boottime_ts64(struct timespec64 *ts)
+{
+       *ts = ktime_to_timespec64(ktime_get_boottime());
+}
+
+static inline void ktime_get_coarse_boottime_ts64(struct timespec64 *ts)
+{
+       *ts = ktime_to_timespec64(ktime_get_coarse_boottime());
+}
+
+static inline time64_t ktime_get_boottime_seconds(void)
+{
+       return ktime_divns(ktime_get_coarse_boottime(), NSEC_PER_SEC);
+}
+
+static inline void ktime_get_clocktai_ts64(struct timespec64 *ts)
+{
+       *ts = ktime_to_timespec64(ktime_get_clocktai());
+}
+
+static inline void ktime_get_coarse_clocktai_ts64(struct timespec64 *ts)
+{
+       *ts = ktime_to_timespec64(ktime_get_coarse_clocktai());
+}
+
+static inline time64_t ktime_get_clocktai_seconds(void)
+{
+       return ktime_divns(ktime_get_coarse_clocktai(), NSEC_PER_SEC);
+}
+
+#endif /* _LINUX_KTIME_H */
diff --git a/include/linux/sched_clock.h b/include/linux/sched_clock.h
index 835ee87ed792..f0fa287710da 100644
--- a/include/linux/sched_clock.h
+++ b/include/linux/sched_clock.h
@@ -5,6 +5,8 @@
 #ifndef LINUX_SCHED_CLOCK
 #define LINUX_SCHED_CLOCK
 
+#include <linux/timekeeping.h>
+
 #ifdef CONFIG_GENERIC_SCHED_CLOCK
 /**
  * struct clock_read_data - data required to read from sched_clock()
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 78a98bdff76d..1182d61670cf 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -20,200 +20,6 @@ extern int do_settimeofday64(const struct timespec64 *ts);
 extern int do_sys_settimeofday64(const struct timespec64 *tv,
                                 const struct timezone *tz);
 
-/*
- * ktime_get() family: read the current time in a multitude of ways,
- *
- * The default time reference is CLOCK_MONOTONIC, starting at
- * boot time but not counting the time spent in suspend.
- * For other references, use the functions with "real", "clocktai",
- * "boottime" and "raw" suffixes.
- *
- * To get the time in a different format, use the ones wit
- * "ns", "ts64" and "seconds" suffix.
- *
- * See Documentation/core-api/timekeeping.rst for more details.
- */
-
-
-/*
- * timespec64 based interfaces
- */
-extern void ktime_get_raw_ts64(struct timespec64 *ts);
-extern void ktime_get_ts64(struct timespec64 *ts);
-extern void ktime_get_real_ts64(struct timespec64 *tv);
-extern void ktime_get_coarse_ts64(struct timespec64 *ts);
-extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
-
-void getboottime64(struct timespec64 *ts);
-
-/*
- * time64_t base interfaces
- */
-extern time64_t ktime_get_seconds(void);
-extern time64_t __ktime_get_real_seconds(void);
-extern time64_t ktime_get_real_seconds(void);
-
-/*
- * ktime_t based interfaces
- */
-
-enum tk_offsets {
-       TK_OFFS_REAL,
-       TK_OFFS_BOOT,
-       TK_OFFS_TAI,
-       TK_OFFS_MAX,
-};
-
-extern ktime_t ktime_get(void);
-extern ktime_t ktime_get_with_offset(enum tk_offsets offs);
-extern ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs);
-extern ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs);
-extern ktime_t ktime_get_raw(void);
-extern u32 ktime_get_resolution_ns(void);
-
-/**
- * ktime_get_real - get the real (wall-) time in ktime_t format
- */
-static inline ktime_t ktime_get_real(void)
-{
-       return ktime_get_with_offset(TK_OFFS_REAL);
-}
-
-static inline ktime_t ktime_get_coarse_real(void)
-{
-       return ktime_get_coarse_with_offset(TK_OFFS_REAL);
-}
-
-/**
- * ktime_get_boottime - Returns monotonic time since boot in ktime_t format
- *
- * This is similar to CLOCK_MONTONIC/ktime_get, but also includes the
- * time spent in suspend.
- */
-static inline ktime_t ktime_get_boottime(void)
-{
-       return ktime_get_with_offset(TK_OFFS_BOOT);
-}
-
-static inline ktime_t ktime_get_coarse_boottime(void)
-{
-       return ktime_get_coarse_with_offset(TK_OFFS_BOOT);
-}
-
-/**
- * ktime_get_clocktai - Returns the TAI time of day in ktime_t format
- */
-static inline ktime_t ktime_get_clocktai(void)
-{
-       return ktime_get_with_offset(TK_OFFS_TAI);
-}
-
-static inline ktime_t ktime_get_coarse_clocktai(void)
-{
-       return ktime_get_coarse_with_offset(TK_OFFS_TAI);
-}
-
-static inline ktime_t ktime_get_coarse(void)
-{
-       struct timespec64 ts;
-
-       ktime_get_coarse_ts64(&ts);
-       return timespec64_to_ktime(ts);
-}
-
-static inline u64 ktime_get_coarse_ns(void)
-{
-       return ktime_to_ns(ktime_get_coarse());
-}
-
-static inline u64 ktime_get_coarse_real_ns(void)
-{
-       return ktime_to_ns(ktime_get_coarse_real());
-}
-
-static inline u64 ktime_get_coarse_boottime_ns(void)
-{
-       return ktime_to_ns(ktime_get_coarse_boottime());
-}
-
-static inline u64 ktime_get_coarse_clocktai_ns(void)
-{
-       return ktime_to_ns(ktime_get_coarse_clocktai());
-}
-
-/**
- * ktime_mono_to_real - Convert monotonic time to clock realtime
- */
-static inline ktime_t ktime_mono_to_real(ktime_t mono)
-{
-       return ktime_mono_to_any(mono, TK_OFFS_REAL);
-}
-
-static inline u64 ktime_get_ns(void)
-{
-       return ktime_to_ns(ktime_get());
-}
-
-static inline u64 ktime_get_real_ns(void)
-{
-       return ktime_to_ns(ktime_get_real());
-}
-
-static inline u64 ktime_get_boottime_ns(void)
-{
-       return ktime_to_ns(ktime_get_boottime());
-}
-
-static inline u64 ktime_get_clocktai_ns(void)
-{
-       return ktime_to_ns(ktime_get_clocktai());
-}
-
-static inline u64 ktime_get_raw_ns(void)
-{
-       return ktime_to_ns(ktime_get_raw());
-}
-
-extern u64 ktime_get_mono_fast_ns(void);
-extern u64 ktime_get_raw_fast_ns(void);
-extern u64 ktime_get_boot_fast_ns(void);
-extern u64 ktime_get_real_fast_ns(void);
-
-/*
- * timespec64/time64_t interfaces utilizing the ktime based ones
- * for API completeness, these could be implemented more efficiently
- * if needed.
- */
-static inline void ktime_get_boottime_ts64(struct timespec64 *ts)
-{
-       *ts = ktime_to_timespec64(ktime_get_boottime());
-}
-
-static inline void ktime_get_coarse_boottime_ts64(struct timespec64 *ts)
-{
-       *ts = ktime_to_timespec64(ktime_get_coarse_boottime());
-}
-
-static inline time64_t ktime_get_boottime_seconds(void)
-{
-       return ktime_divns(ktime_get_coarse_boottime(), NSEC_PER_SEC);
-}
-
-static inline void ktime_get_clocktai_ts64(struct timespec64 *ts)
-{
-       *ts = ktime_to_timespec64(ktime_get_clocktai());
-}
-
-static inline void ktime_get_coarse_clocktai_ts64(struct timespec64 *ts)
-{
-       *ts = ktime_to_timespec64(ktime_get_coarse_clocktai());
-}
-
-static inline time64_t ktime_get_clocktai_seconds(void)
-{
-       return ktime_divns(ktime_get_coarse_clocktai(), NSEC_PER_SEC);
-}
-
 /*
  * RTC specific
  */
@@ -308,4 +114,4 @@ void read_persistent_wall_and_boot_offset(struct timespec64 *wall_clock,
 extern int update_persistent_clock64(struct timespec64 now);
 #endif
 
-#endif
+#endif /* _LINUX_TIMEKEEPING_H */
diff --git a/init/main.c b/init/main.c
index af521b30a3b8..81fbdfd2c724 100644
--- a/init/main.c
+++ b/init/main.c
@@ -99,6 +99,7 @@
 #include <linux/kcsan.h>
 #include <linux/init_syscalls.h>
 #include <linux/stackdepot.h>
+#include <linux/timekeeping.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 406dccb79c2b..804f06801737 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/rtc.h>
 #include <linux/audit.h>
+#include <linux/timekeeping.h>
 
 #include "ntp_internal.h"
 #include "timekeeping_internal.h"
diff --git a/kernel/time/time.c b/kernel/time/time.c
index 29923b20e0e4..7292ed074742 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -29,6 +29,7 @@
 #include <linux/timex.h>
 #include <linux/capability.h>
 #include <linux/timekeeper_internal.h>
+#include <linux/timekeeping.h>
 #include <linux/errno.h>
 #include <linux/syscalls.h>
 #include <linux/security.h>
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 8a364aa9881a..4dfee925adc8 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -22,6 +22,7 @@
 #include <linux/pvclock_gtod.h>
 #include <linux/compiler.h>
 #include <linux/audit.h>
+#include <linux/timekeeping.h>
 
 #include "tick-internal.h"
 #include "ntp_internal.h"
-- 
2.25.1



