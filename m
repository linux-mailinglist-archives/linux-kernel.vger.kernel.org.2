Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE603A4C89
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 05:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhFLD7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 23:59:02 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:39532 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhFLD67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 23:58:59 -0400
Received: by mail-pl1-f181.google.com with SMTP id v11so3791166ply.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 20:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=akFvGOTPnrH1oZbsyh18q4gwMkUtme+zCkp52VPSqZw=;
        b=nBGjkv2isftJYT3Ts0j5r4K/CnN+xKidSd7pfDQQJCzMD3XlOfO6P0+4/GHxz/yglN
         NWB3/Mov8sTCoyyQ4qTppoJz6kq8qvMEA02boa60uTbhvlM8YkTRD6PJ3J9ijsoYEjRf
         TDfUyIdyzKt6vJfuTebGdQcvZA1reXv1ITiz8h/OpIvXD8SxFIlvF3onezT0lcBYRTbP
         M2g/v2pdTjekPqLlUxJpRo6KnOhViFQ23BuPHiiiRvhARR1PI6IWys66tWhxbWAd8339
         NCBCKLyUMJoJESoRgRoBYW89orPXZgwBV/5Dvhw8pW4L1pdQ7NBxH38rZL+CurvkYpFA
         0lEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=akFvGOTPnrH1oZbsyh18q4gwMkUtme+zCkp52VPSqZw=;
        b=i1MM9tOo0rSgSu0dkquYYkFcwkKMv2Q11Kyq8OuJPbhCDaBbjk8/sCXt41bgHFImgg
         XUOsU7vGaonWdmsH+f0oHjbk4iz9eG1GU60/w5pND3ZPRfwGkwdSpOiG7Ynx2mafrT7U
         nNk7vES1MjGxxnKvQpy7pfuPgQ1/mt42toDqT6wmds3t+Ic/xrwembhA3Bz8Zhh5fr9E
         7wDVyvzDiYJslKSGAALTmojE0kMCzsJ1MKty5hZGzvXTlXMpIO4a2Mq2Aw6l0aytRWRO
         XvZC+1SwUw3zPp3UrA9zrQRrIIliIoPHIXwFHBZQjPBNR1dn8Erx7yrp3Y4de1XP/alx
         XlOA==
X-Gm-Message-State: AOAM530mWAXrFYAx6Dx/ptd7xU9n3Q/4U2QmzvARnWjCSEf9JtOlX4M5
        gaJ8d0mDuzmoe3WHCJLqZ/uNxA==
X-Google-Smtp-Source: ABdhPJzdeLwROKg8BhvBACDaMVXVaBwD3wwoU2+GgRWGzQM5bfH2/FwPj5dGLu83nVhHRG7K7PmKpA==
X-Received: by 2002:a17:90a:f3d0:: with SMTP id ha16mr7721767pjb.123.1623470144207;
        Fri, 11 Jun 2021 20:55:44 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id bg16sm684308pjb.16.2021.06.11.20.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 20:55:43 -0700 (PDT)
Subject: [PATCH] RISC-V: Use asm-generic for {in,out}{bwlq}
Date:   Fri, 11 Jun 2021 20:40:42 -0700
Message-Id: <20210612034042.3043112-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org, Atish Patra <Atish.Patra@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:         linux-riscv@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

The asm-generic implementation is functionally identical to the RISC-V
version.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/include/asm/io.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index c025a746a148..69605a474270 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -52,19 +52,6 @@
 #define __io_pbw()	__asm__ __volatile__ ("fence iow,o" : : : "memory");
 #define __io_paw()	__asm__ __volatile__ ("fence o,io"  : : : "memory");
 
-#define inb(c)		({ u8  __v; __io_pbr(); __v = readb_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
-#define inw(c)		({ u16 __v; __io_pbr(); __v = readw_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
-#define inl(c)		({ u32 __v; __io_pbr(); __v = readl_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
-
-#define outb(v,c)	({ __io_pbw(); writeb_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
-#define outw(v,c)	({ __io_pbw(); writew_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
-#define outl(v,c)	({ __io_pbw(); writel_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
-
-#ifdef CONFIG_64BIT
-#define inq(c)		({ u64 __v; __io_pbr(); __v = readq_cpu((void*)(c)); __io_par(__v); __v; })
-#define outq(v,c)	({ __io_pbw(); writeq_cpu((v),(void*)(c)); __io_paw(); })
-#endif
-
 /*
  * Accesses from a single hart to a single I/O address must be ordered.  This
  * allows us to use the raw read macros, but we still need to fence before and
-- 
2.32.0.272.g935e593368-goog

