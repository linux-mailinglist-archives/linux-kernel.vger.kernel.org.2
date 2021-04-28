Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3B836D0EA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 05:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbhD1DgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 23:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhD1DgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 23:36:04 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DB1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 20:35:19 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so8366712pjv.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 20:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=vtak+go3WyFH+Z4SifbQHwiLP50hFLvT92GjDh2aMwc=;
        b=dsDpNy8jry1Is3B4NZLRFbftN/qOKSSeld8iqW2y0DSZ1+Qag1mVZAgj0bb7W7kvVm
         Q43mtfUJOzXIQEDaaa6VCuR26ZZ+ZlDOkFcDd2wvVVrttEIZUCKGn6R+6b/5/cz81rU1
         GS1VFc5v/MHO/Iv7fZ83H9JIPwYMEfOK+aNicNMXMZ6OOd7Kd/b7A+kEXxEN6iBJ11cq
         q9PlWbZI4dnoHRp4vtDlidTdbOQ5LS3m2fRur65vcd2MGGes6GI5gBE7V2XCg5dJycGf
         LTG+cZLtFC+1oSVVjnxS4NabKajQBLr9RIFMv5lTthDqJbkMAtM/oYMlgb1K6bvxDuw4
         yGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=vtak+go3WyFH+Z4SifbQHwiLP50hFLvT92GjDh2aMwc=;
        b=nLi+z4q9QFxsIpnmCRFxbesX1kPtGtliOsW60/gFcQGmERw3DQQhSEw1p5qQdt1SQ6
         LjO9+TodWw7NYZZ4dUASgoKtECVmmQmv0labYiF4vuehvyufL432mmecLag+4yjcyGc1
         2fBIhueei3B436uUdfeLjkOabQ5P3sTaX7MAJcgOsqT0QVKYo/qPRKVtElssUp+YBSDB
         G/EIm/9oruXGGkXLJG3pa9GdwZjVE5a4cmDueKD5T5tBZKSix+4v1SXro0Pg8iWzeLY4
         jUlbSeMUVFrlVyIEYfEPAvHqd+q/VGIsqZf7ISE6LZeJQ2HQQtzccOHHWBHHtDhpDtP2
         jtHw==
X-Gm-Message-State: AOAM533YZy1+MxHYjv6ElfrRF1+FaBX+jiGJChoSbectiqDvXz+XNhfn
        wALkeTIUyHxlbs++AVZob1iWhA==
X-Google-Smtp-Source: ABdhPJwjSP9qSrfeRTIdS587iYsRRioH6Tt+Hjyvj1BL7CkB1aMM8MxUoMihwS0dFCLXPjsqoxB1GQ==
X-Received: by 2002:a17:90a:a613:: with SMTP id c19mr1681578pjq.117.1619580919209;
        Tue, 27 Apr 2021 20:35:19 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id z23sm972435pgj.56.2021.04.27.20.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 20:35:18 -0700 (PDT)
Subject: [PATCH] RISC-V: Always define XIP_FIXUP
Date:   Tue, 27 Apr 2021 20:34:15 -0700
Message-Id: <20210428033415.107756-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        akpm@linux-foundation.org, Atish Patra <Atish.Patra@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>, wangkefeng.wang@huawei.com,
        rppt@kernel.org, vitaly.wool@konsulko.com, alex@ghiti.fr,
        greentime.hu@sifive.com, 0x7f454c46@gmail.com,
        chenhuang5@huawei.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Guenter Roeck <linux@roeck-us.net>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:         linux-riscv@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

XIP depends on MMU, but XIP_FIXUP is defined throughout the kernel in
order to avoid excessive ifdefs.  This just makes sure to always define
XIP_FIXIP, which will fix MMU=n builds.

Fixes: 44c922572952 ("RISC-V: enable XIP")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/include/asm/pgtable.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 2f1384e14e31..fd749351f432 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -73,18 +73,6 @@
 #endif
 #define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
 
-#ifdef CONFIG_XIP_KERNEL
-#define XIP_OFFSET		SZ_8M
-#define XIP_FIXUP(addr) ({							\
-	uintptr_t __a = (uintptr_t)(addr);					\
-	(__a >= CONFIG_XIP_PHYS_ADDR && __a < CONFIG_XIP_PHYS_ADDR + SZ_16M) ?	\
-		__a - CONFIG_XIP_PHYS_ADDR + CONFIG_PHYS_RAM_BASE - XIP_OFFSET :\
-		__a;								\
-	})
-#else
-#define XIP_FIXUP(addr)		(addr)
-#endif /* CONFIG_XIP_KERNEL */
-
 #endif
 
 #ifndef __ASSEMBLY__
@@ -101,6 +89,18 @@
 #include <asm/pgtable-32.h>
 #endif /* CONFIG_64BIT */
 
+#ifdef CONFIG_XIP_KERNEL
+#define XIP_OFFSET		SZ_8M
+#define XIP_FIXUP(addr) ({							\
+	uintptr_t __a = (uintptr_t)(addr);					\
+	(__a >= CONFIG_XIP_PHYS_ADDR && __a < CONFIG_XIP_PHYS_ADDR + SZ_16M) ?	\
+		__a - CONFIG_XIP_PHYS_ADDR + CONFIG_PHYS_RAM_BASE - XIP_OFFSET :\
+		__a;								\
+	})
+#else
+#define XIP_FIXUP(addr)		(addr)
+#endif /* CONFIG_XIP_KERNEL */
+
 #ifdef CONFIG_MMU
 /* Number of entries in the page global directory */
 #define PTRS_PER_PGD    (PAGE_SIZE / sizeof(pgd_t))
-- 
2.31.1.498.g6c1eba8ee3d-goog

