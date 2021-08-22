Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA673F3F71
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 15:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhHVNQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 09:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhHVNQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 09:16:37 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505C1C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 06:15:56 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id e14so16279078qkg.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 06:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=subject:references:to:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ztSX4LVREyShOSgUxsitSitHXqdU3A3ExtkJ9UnqRGQ=;
        b=a2b8imbxil507nO/HUz3ddrr9S4CIbv/Yh0C9+/2jBgKS6rEL5MsxnMVdzkDvbJIDR
         uEu4fE0rZI7rghRyXMWkq9pcgqc7jXKtnVpMu8NIBnaNpV1piKcIAeXMBmH+U8+GnzOC
         20pR8sn0b4Q1UqD1S0LGFD7lUhOxsbQKJHKgzeKaO1hiWFu4xgZ/f0HZ13U0ySPDWYLE
         vWoTbaqe2uoHBicKIuBKSiNKC5yl1V0NzZqffmRhoUYx87gr7XrZIakkqXHD/qrHPjTa
         YaPfXejNaPQ4vsXGaoBwjcIsQnCS5DpY6j8wUd/+C+Sp5wHECeyRCtT0XtArpPyFN9eq
         KLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ztSX4LVREyShOSgUxsitSitHXqdU3A3ExtkJ9UnqRGQ=;
        b=aDidc5nUc8S37nplKGF+x41YYwDqj2gAF/RC50zZXxd7BEguEJEE9iIa+kAPgRxBw1
         UBXa6Jh1loEtTraqhBIh2uOUwdcIK1bOfuveVH4tlyBVSbW/OI8Jz/1vDFWaUnmAj9Zl
         T+CicBmijcsgX5jTedC4ybABJ5ejGLHqopFNi0dHjh5jwXN3RpVZQrsyq/Zbv2ZYPRBC
         sSblNPOfh2Lr7LbII0z0XPE1ekE5nHRFT0Atfe6tB8FVOqdzAOyf2opXhYqpSqvzhJlr
         ODOOmh82LdOofNC2uDw6U2gbgwEW149Te2BhpKPIx+tNyJ4vGgTqGbVGkSjU4Ub+GDZY
         9tjA==
X-Gm-Message-State: AOAM533daFk5zEuXoalRA4kFKDbvwN84ym0lHwASRYMVQC3z2Jf4TEGy
        rG+4TV5CQLCkcApSXUGDzIkKCw==
X-Google-Smtp-Source: ABdhPJygfxn1s9dZT99SegRE2eStm1MM4ZweDVn3XuFG5lpppAh0vgIKErdCx2tAxhh4YCezTMLHeg==
X-Received: by 2002:a05:620a:14a2:: with SMTP id x2mr14729658qkj.194.1629638155274;
        Sun, 22 Aug 2021 06:15:55 -0700 (PDT)
Received: from [192.168.1.100] ([66.199.72.200])
        by smtp.gmail.com with ESMTPSA id u6sm6639154qkp.49.2021.08.22.06.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 06:15:54 -0700 (PDT)
Subject: [PATCH v4.1] include: linux: Reorganize timekeeping and ktime headers
References: <b5d4536f-a096-b259-1385-3c1d32754dbf@vt.edu>
To:     gregkh@linuxfoundation.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kbuild test robot <lkp@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
From:   Carlos Bilbao <bilbao@vt.edu>
X-Forwarded-Message-Id: <b5d4536f-a096-b259-1385-3c1d32754dbf@vt.edu>
Message-ID: <095645cd-ce53-a803-cb99-522545a409b8@vt.edu>
Date:   Sun, 22 Aug 2021 09:15:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b5d4536f-a096-b259-1385-3c1d32754dbf@vt.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorganize and separate the headers by making ktime.h take care of the 
ktime_get() family of functions, and reserve timekeeping.h for the actual 
timekeeping. This also helps to avoid implicit function errors and strengthens
the header dependencies, since timekeeping.h was using ktime_to_ns(), a static 
function defined in a header it does no include, ktime.h. Include the header 
timekeeping.h wherever it is necessary for a successful compilation after the 
header code reorganization.

Signed-off-by: Carlos Bilbao <bilbao@vt.edu>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: kernel test robot <lkp@intel.com>
---
Changelog:
- v2: Add three more files that also needed a header update for x86: 
  pps_kernel.h, posix-timers.c and hda_controller.c
- v3: Cover build tests for other architectures than x86. To compile arm64, 
  update arch/arm64/kvm/hypercalls.c, include/linux/stmmac.h, and 
  drivers/rtc/class.c. No other arch/ seems to need fixes but to be on the safe
  side compiled arm, mips, powerpc, sparc, s390, riscv and i386.
- v4: 4.0 Fix kernel test robot warnings for ia64 and x86.
      4.1 Fix kernel test robot warnings for m68k and powerpc.
---
 arch/arm64/kvm/hypercalls.c    |   1 +
 arch/ia64/kernel/time.c        |   1 +
 arch/m68k/atari/time.c         |   1 +
 arch/m68k/hp300/time.c         |   2 +
 arch/m68k/mac/via.c            |   1 +
 arch/m68k/mvme16x/config.c     |   1 +
 arch/m68k/sun3/sun3ints.c      |   1 +
 arch/powerpc/kernel/time.c     |   1 +
 arch/x86/kernel/rtc.c          |   1 +
 arch/x86/kernel/tsc.c          |   1 +
 drivers/rtc/class.c            |   1 +
 include/linux/ktime.h          | 196 +++++++++++++++++++++++++++++++-
 include/linux/pps_kernel.h     |   1 +
 include/linux/sched_clock.h    |   2 +
 include/linux/stmmac.h         |   1 +
 include/linux/timekeeping.h    | 197 +--------------------------------
 init/main.c                    |   1 +
 kernel/time/ntp.c              |   1 +
 kernel/time/posix-timers.c     |   1 +
 kernel/time/tick-legacy.c      |   1 +
 kernel/time/time.c             |   1 +
 kernel/time/timekeeping.c      |   1 +
 sound/pci/hda/hda_controller.c |   1 +
 23 files changed, 218 insertions(+), 198 deletions(-)

diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index 30da78f72b3b..41499c1d7379 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -3,6 +3,7 @@
 
 #include <linux/arm-smccc.h>
 #include <linux/kvm_host.h>
+#include <linux/timekeeping.h>
 
 #include <asm/kvm_emulate.h>
 
diff --git a/arch/ia64/kernel/time.c b/arch/ia64/kernel/time.c
index fa9c0ab8c6fc..85e79ff3c98e 100644
--- a/arch/ia64/kernel/time.c
+++ b/arch/ia64/kernel/time.c
@@ -22,6 +22,7 @@
 #include <linux/efi.h>
 #include <linux/timex.h>
 #include <linux/timekeeper_internal.h>
+#include <linux/timekeeping.h>
 #include <linux/platform_device.h>
 #include <linux/sched/cputime.h>
 
diff --git a/arch/m68k/atari/time.c b/arch/m68k/atari/time.c
index 7e44d0e9d0f8..b09d3ff40b36 100644
--- a/arch/m68k/atari/time.c
+++ b/arch/m68k/atari/time.c
@@ -19,6 +19,7 @@
 #include <linux/clocksource.h>
 #include <linux/delay.h>
 #include <linux/export.h>
+#include <linux/timekeeping.h>
 
 #include <asm/atariints.h>
 #include <asm/machdep.h>
diff --git a/arch/m68k/hp300/time.c b/arch/m68k/hp300/time.c
index 1d1b7b3b5dd4..56c575096bcb 100644
--- a/arch/m68k/hp300/time.c
+++ b/arch/m68k/hp300/time.c
@@ -14,6 +14,8 @@
 #include <linux/sched.h>
 #include <linux/kernel_stat.h>
 #include <linux/interrupt.h>
+#include <linux/timekeeping.h>
+
 #include <asm/machdep.h>
 #include <asm/irq.h>
 #include <asm/io.h>
diff --git a/arch/m68k/mac/via.c b/arch/m68k/mac/via.c
index 3d11d6219cdd..6dd8f85288e4 100644
--- a/arch/m68k/mac/via.c
+++ b/arch/m68k/mac/via.c
@@ -31,6 +31,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/irq.h>
+#include <linux/timekeeping.h>
 
 #include <asm/macintosh.h>
 #include <asm/macints.h>
diff --git a/arch/m68k/mvme16x/config.c b/arch/m68k/mvme16x/config.c
index b59593c7cfb9..bb2ae926bb17 100644
--- a/arch/m68k/mvme16x/config.c
+++ b/arch/m68k/mvme16x/config.c
@@ -28,6 +28,7 @@
 #include <linux/rtc.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/timekeeping.h>
 
 #include <asm/bootinfo.h>
 #include <asm/bootinfo-vme.h>
diff --git a/arch/m68k/sun3/sun3ints.c b/arch/m68k/sun3/sun3ints.c
index 41ae422119d3..3834a172be47 100644
--- a/arch/m68k/sun3/sun3ints.c
+++ b/arch/m68k/sun3/sun3ints.c
@@ -11,6 +11,7 @@
 #include <linux/sched.h>
 #include <linux/kernel_stat.h>
 #include <linux/interrupt.h>
+#include <linux/timekeeping.h>
 #include <asm/segment.h>
 #include <asm/intersil.h>
 #include <asm/oplib.h>
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index e45ce427bffb..4b6952165a0a 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -55,6 +55,7 @@
 #include <linux/sched/cputime.h>
 #include <linux/sched/clock.h>
 #include <linux/processor.h>
+#include <linux/timekeeping.h>
 #include <asm/trace.h>
 
 #include <asm/interrupt.h>
diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
index 586f718b8e95..98ea05cc6aeb 100644
--- a/arch/x86/kernel/rtc.c
+++ b/arch/x86/kernel/rtc.c
@@ -9,6 +9,7 @@
 #include <linux/export.h>
 #include <linux/pnp.h>
 #include <linux/of.h>
+#include <linux/timekeeping.h>
 
 #include <asm/vsyscall.h>
 #include <asm/x86_init.h>
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
diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index f77bc089eb6b..1bdf1f790beb 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -16,6 +16,7 @@
 #include <linux/kdev_t.h>
 #include <linux/idr.h>
 #include <linux/slab.h>
+#include <linux/timekeeping.h>
 #include <linux/workqueue.h>
 
 #include "rtc-core.h"
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
diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
index 78c8ac4951b5..24970c202ac6 100644
--- a/include/linux/pps_kernel.h
+++ b/include/linux/pps_kernel.h
@@ -12,6 +12,7 @@
 #include <linux/cdev.h>
 #include <linux/device.h>
 #include <linux/time.h>
+#include <linux/timekeeping.h>
 
 /*
  * Global defines
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
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index a6f03b36fc4f..bf235ff101d5 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -14,6 +14,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/phy.h>
+#include <linux/timekeeping.h>
 
 #define MTL_MAX_RX_QUEUES	8
 #define MTL_MAX_TX_QUEUES	8
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 78a98bdff76d..b1c54f5ff91e 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -19,201 +19,6 @@ extern void legacy_timer_tick(unsigned long ticks);
 extern int do_settimeofday64(const struct timespec64 *ts);
 extern int do_sys_settimeofday64(const struct timespec64 *tv,
 				 const struct timezone *tz);
-
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
-	TK_OFFS_REAL,
-	TK_OFFS_BOOT,
-	TK_OFFS_TAI,
-	TK_OFFS_MAX,
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
-	return ktime_get_with_offset(TK_OFFS_REAL);
-}
-
-static inline ktime_t ktime_get_coarse_real(void)
-{
-	return ktime_get_coarse_with_offset(TK_OFFS_REAL);
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
-	return ktime_get_with_offset(TK_OFFS_BOOT);
-}
-
-static inline ktime_t ktime_get_coarse_boottime(void)
-{
-	return ktime_get_coarse_with_offset(TK_OFFS_BOOT);
-}
-
-/**
- * ktime_get_clocktai - Returns the TAI time of day in ktime_t format
- */
-static inline ktime_t ktime_get_clocktai(void)
-{
-	return ktime_get_with_offset(TK_OFFS_TAI);
-}
-
-static inline ktime_t ktime_get_coarse_clocktai(void)
-{
-	return ktime_get_coarse_with_offset(TK_OFFS_TAI);
-}
-
-static inline ktime_t ktime_get_coarse(void)
-{
-	struct timespec64 ts;
-
-	ktime_get_coarse_ts64(&ts);
-	return timespec64_to_ktime(ts);
-}
-
-static inline u64 ktime_get_coarse_ns(void)
-{
-	return ktime_to_ns(ktime_get_coarse());
-}
-
-static inline u64 ktime_get_coarse_real_ns(void)
-{
-	return ktime_to_ns(ktime_get_coarse_real());
-}
-
-static inline u64 ktime_get_coarse_boottime_ns(void)
-{
-	return ktime_to_ns(ktime_get_coarse_boottime());
-}
-
-static inline u64 ktime_get_coarse_clocktai_ns(void)
-{
-	return ktime_to_ns(ktime_get_coarse_clocktai());
-}
-
-/**
- * ktime_mono_to_real - Convert monotonic time to clock realtime
- */
-static inline ktime_t ktime_mono_to_real(ktime_t mono)
-{
-	return ktime_mono_to_any(mono, TK_OFFS_REAL);
-}
-
-static inline u64 ktime_get_ns(void)
-{
-	return ktime_to_ns(ktime_get());
-}
-
-static inline u64 ktime_get_real_ns(void)
-{
-	return ktime_to_ns(ktime_get_real());
-}
-
-static inline u64 ktime_get_boottime_ns(void)
-{
-	return ktime_to_ns(ktime_get_boottime());
-}
-
-static inline u64 ktime_get_clocktai_ns(void)
-{
-	return ktime_to_ns(ktime_get_clocktai());
-}
-
-static inline u64 ktime_get_raw_ns(void)
-{
-	return ktime_to_ns(ktime_get_raw());
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
-	*ts = ktime_to_timespec64(ktime_get_boottime());
-}
-
-static inline void ktime_get_coarse_boottime_ts64(struct timespec64 *ts)
-{
-	*ts = ktime_to_timespec64(ktime_get_coarse_boottime());
-}
-
-static inline time64_t ktime_get_boottime_seconds(void)
-{
-	return ktime_divns(ktime_get_coarse_boottime(), NSEC_PER_SEC);
-}
-
-static inline void ktime_get_clocktai_ts64(struct timespec64 *ts)
-{
-	*ts = ktime_to_timespec64(ktime_get_clocktai());
-}
-
-static inline void ktime_get_coarse_clocktai_ts64(struct timespec64 *ts)
-{
-	*ts = ktime_to_timespec64(ktime_get_coarse_clocktai());
-}
-
-static inline time64_t ktime_get_clocktai_seconds(void)
-{
-	return ktime_divns(ktime_get_coarse_clocktai(), NSEC_PER_SEC);
-}
-
 /*
  * RTC specific
  */
@@ -308,4 +113,4 @@ void read_persistent_wall_and_boot_offset(struct timespec64 *wall_clock,
 extern int update_persistent_clock64(struct timespec64 now);
 #endif
 
-#endif
+#endif /* _LINUX_TIMEKEEPING_H */
diff --git a/init/main.c b/init/main.c
index f5b8246e8aa1..a8db3a136d6a 100644
--- a/init/main.c
+++ b/init/main.c
@@ -100,6 +100,7 @@
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
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index dd5697d7347b..14f82cd95d10 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -13,6 +13,7 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/time.h>
+#include <linux/timekeeping.h>
 #include <linux/mutex.h>
 #include <linux/sched/task.h>
 
diff --git a/kernel/time/tick-legacy.c b/kernel/time/tick-legacy.c
index af225b32f5b3..9a534f716462 100644
--- a/kernel/time/tick-legacy.c
+++ b/kernel/time/tick-legacy.c
@@ -7,6 +7,7 @@
 #include <linux/irq.h>
 #include <linux/profile.h>
 #include <linux/timekeeper_internal.h>
+#include <linux/timekeeping.h>
 
 #include "tick-internal.h"
 
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
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index ca2f2ecd1488..efbbe624d81d 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
+#include <linux/timekeeping.h>
 
 #ifdef CONFIG_X86
 /* for art-tsc conversion */
-- 
2.25.1
