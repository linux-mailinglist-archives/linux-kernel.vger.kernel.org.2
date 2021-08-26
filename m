Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E673F823A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 08:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238212AbhHZGIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 02:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbhHZGIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 02:08:41 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F107DC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 23:07:54 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s11so2158069pgr.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 23:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=XSO4aTMI8L6SABu9p5nHJasdEB0/4Gj8hIYzUHhpqoI=;
        b=uGZUttuTcwZQAXVURE4W4dhyTqswmOh9u28bv+2LfY7C5Z+u1mqJJPZ7slCgWDvnZP
         JSFht4nC+dJSQgWNGJxAmMhAp7OBo8M8SbHl8J2N5exn+0Kygj5hM6ql0bOEh3vTHngQ
         M/NqvIHEJMdAONtSwIxj3nDx+al1m/mCntMxggLGbdepslGiiRcd+udzkUCLTJh3RZqY
         YfHdQV5MibWsSgWAvmvY0n9fSjn/IZNpdBI/xkr2ambsVPnjOVwpm5qJOaIAdgLmbXv1
         +pQ+vd1hIhjRlw/bcKwRxuZPza2zqNH7QC23+S01Ts3eslpcqW2YvnQEwdgH/cdCNwC/
         m/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=XSO4aTMI8L6SABu9p5nHJasdEB0/4Gj8hIYzUHhpqoI=;
        b=KusLQVF/l3R1crWR6H3PXhqHVCe18+t+mT/T0/6hW6i4FSDPgTCwNlsd+37EOAjEJP
         IZyPvSHPDpx0rNqSBAKJLbOv7G05K7/BB9ilvFE7agAV30oI32VLRpfNSIDRl6AU9qSv
         gx4UEXGO8h7cyXqQ7UMScfRJLLRdvGWg2+28b9SlxQ45YCwVqMTrwgyDZpH7J4US36QD
         /FbkrW9uQsrWnIfaGfZHGfha0gXltAl/0curH6RZR+dBPv1GPLcOCdWck86alJ83csnu
         b4aVnYCFXrtIPeIFYyB950v1BwxPXSBJ1l4gl4isZMeJP29la7Dte4HTjgii3zRloxOA
         j12Q==
X-Gm-Message-State: AOAM532+QJhPeDt8rfrNtwOBrMupPSTMTmxL+I9KAFIjzKDnOO5qVoBC
        4VgyaVqGWRGRO6Rb4dqFDF9C3Q==
X-Google-Smtp-Source: ABdhPJzW15W5p7nhvDQt3b4zFSYUvJ/8LxsZm9Z6KAltlF6bhi6uQj+Eb25pzinXJTo+sdn56L6T8w==
X-Received: by 2002:a63:e40a:: with SMTP id a10mr1898121pgi.414.1629958074381;
        Wed, 25 Aug 2021 23:07:54 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id t10sm7203435pji.30.2021.08.25.23.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 23:07:53 -0700 (PDT)
Subject: [PATCH] RISC-V: Fix VDSO build for !MMU
Date:   Wed, 25 Aug 2021 23:05:10 -0700
Message-Id: <20210826060509.2470960-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        penberg@kernel.org, guoren@linux.alibaba.com, abdulras@google.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:         linux-riscv@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

We don't have a VDSO for the !MMU configurations, so don't try to build
one.

Fixes: fde9c59aebaf ("riscv: explicitly use symbol offsets for VDSO")
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/Makefile           | 2 ++
 arch/riscv/include/asm/vdso.h | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index e026b2d0a5a4..83ee0e71204c 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -108,9 +108,11 @@ PHONY += vdso_install
 vdso_install:
 	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso $@
 
+ifeq ($(CONFIG_MMU),y)
 prepare: vdso_prepare
 vdso_prepare: prepare0
 	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso include/generated/vdso-offsets.h
+endif
 
 ifneq ($(CONFIG_XIP_KERNEL),y)
 ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_SOC_CANAAN),yy)
diff --git a/arch/riscv/include/asm/vdso.h b/arch/riscv/include/asm/vdso.h
index d8d003c2b5a3..893e47195e30 100644
--- a/arch/riscv/include/asm/vdso.h
+++ b/arch/riscv/include/asm/vdso.h
@@ -8,6 +8,13 @@
 #ifndef _ASM_RISCV_VDSO_H
 #define _ASM_RISCV_VDSO_H
 
+
+/*
+ * All systems with an MMU have a VDSO, but systems without an MMU don't
+ * support shared libraries and therefor don't have one.
+ */
+#ifdef CONFIG_MMU
+
 #include <linux/types.h>
 #include <generated/vdso-offsets.h>
 
@@ -19,6 +26,8 @@ struct vdso_data {
 #define VDSO_SYMBOL(base, name)							\
 	(void __user *)((unsigned long)(base) + __vdso_##name##_offset)
 
+#endif /* CONFIG_MMU */
+
 asmlinkage long sys_riscv_flush_icache(uintptr_t, uintptr_t, uintptr_t);
 
 #endif /* _ASM_RISCV_VDSO_H */
-- 
2.33.0.259.gc128427fd7-goog

