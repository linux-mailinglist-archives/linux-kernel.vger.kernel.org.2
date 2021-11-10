Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1142D44C070
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhKJMBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbhKJMB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:01:27 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A609C061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:58:40 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id b11so2731058pld.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P6Gz7Sa13Nz5wo9ag7NEcCeQMS9LijqUptPqbUded4Q=;
        b=jXs9+KxkNXzafRwP2YpA3CASwaVQ7hoEWoPuMa+uOYi9QuAk89kts8YQcVLGhv4WgM
         eJBQ5S2nFjTMS4l6E8xUorrlJ8xPpXABGVkg9FYKM/ijKlWlI9euKexUffmlcSAJ2XUt
         ni9xXqnxCdHKDN7/msUnzTLJ6mKRljQsY/jAAXcpphJsD8gAP3r2/B2pxd9ut08xDrBT
         qKnonBDr9tOZzbSpPPMFGaFtBp7K2LUsxCRS6XSwQ3qU48RUp8ZO2WYdTkzUH8U01zeK
         nLF+59dZJo1p1DxQGSkzDYo7kI+i175zjlQom7yspiVsKp+ckmGbtg4PdlxVgJv3/+Sk
         lKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P6Gz7Sa13Nz5wo9ag7NEcCeQMS9LijqUptPqbUded4Q=;
        b=eG4TjA+V1Tgn7b5d5PafUVCtegCeUPym+8cys6mi9XhCjPvtVMjQtR64mzL+my2c8d
         KUTI9eeXkVywIFUlvKqUi5Xh0rWmfPlJLWbidAf/Ise5Q/R1zV7T+pG2puF6zPhKXA13
         gK372+wvVcOkpEYCgzEKs3GjWk/wQP0tDIrlwsnx2qEONjah/otMaqAZBted0hIu8I1i
         lsVuVKexZuJJR5tnP75mi9B63fpcg3NeZCcqwUPYlnIJXPXgzlk1LvToNzt8j1r9p53Q
         NrjHS63DgQeBSyxsb5g7L2cIWTyxcr0Q93G/hY94Bo83ArbUwPzh/o09cuBnCRKwzl9/
         vzsg==
X-Gm-Message-State: AOAM533SE8kyJJjDxrCAZIlEcuTHHpQv9/AAJ8bEPq6ThhGk65ZwSttG
        dVoy2aOWnKafGZuRRzXT477whO/Zqjo=
X-Google-Smtp-Source: ABdhPJwOqCdwTF5YFq2B1vSTYdz8v6Wdl72DBXxldZo+qu188DjGTJhTnatl8bIB37ZK+ICi18FwMw==
X-Received: by 2002:a17:902:c947:b0:141:e7f6:d688 with SMTP id i7-20020a170902c94700b00141e7f6d688mr14806400pla.56.1636545519110;
        Wed, 10 Nov 2021 03:58:39 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id t16sm5542662pja.10.2021.11.10.03.58.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 03:58:38 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH V5 11/50] x86: Mark __native_read_cr3() & native_write_cr3() as __always_inline
Date:   Wed, 10 Nov 2021 19:56:57 +0800
Message-Id: <20211110115736.3776-12-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

We need __native_read_cr3() & native_write_cr3() to be ensured noinstr.

It is prepared for later patches which implement entry code in C file.
Some of the code needs to handle KPTI and has to read/write CR3.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/include/asm/special_insns.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 68c257a3de0d..fbb057ba60e6 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -42,14 +42,14 @@ static __always_inline void native_write_cr2(unsigned long val)
 	asm volatile("mov %0,%%cr2": : "r" (val) : "memory");
 }
 
-static inline unsigned long __native_read_cr3(void)
+static __always_inline unsigned long __native_read_cr3(void)
 {
 	unsigned long val;
 	asm volatile("mov %%cr3,%0\n\t" : "=r" (val) : __FORCE_ORDER);
 	return val;
 }
 
-static inline void native_write_cr3(unsigned long val)
+static __always_inline void native_write_cr3(unsigned long val)
 {
 	asm volatile("mov %0,%%cr3": : "r" (val) : "memory");
 }
-- 
2.19.1.6.gb485710b

