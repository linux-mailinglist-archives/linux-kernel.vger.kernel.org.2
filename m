Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC6D45EB4E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376905AbhKZK1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbhKZKZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:25:18 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3D7C0613D7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:13:01 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so9574103pju.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P6Gz7Sa13Nz5wo9ag7NEcCeQMS9LijqUptPqbUded4Q=;
        b=RDiRBa04/sm/GqwB8OnMl1DB0+qIhIcj/QiWAipeKcyj8TDk1ubUP2SB7JTtcnOfGC
         6mA5Qelm7Qb+1f6ZIvBfONmeaF6per6w9CpGTjPKyEk6nk5xDPhnno1RXuF5D4GOpw4k
         M4JZO8JleLtyy8ZD06pbPOEjQQcaZqcK0R2aGdngr/gC+qdL9kI0R5eLx4YWc1z7UvRx
         Qk+We1ACtIIO/uZ3EIFSRMGZqRQXXQeX3YvSxC0dzLSMdRcF7lKtsZvY8ObKzNql3H1x
         9RbTuNmhyz5+ifiQl7vMrb2O91+D3eLLe/KWt3NAhXpvJm0WyxgEFH6x+7u3W7rn7jBC
         rSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P6Gz7Sa13Nz5wo9ag7NEcCeQMS9LijqUptPqbUded4Q=;
        b=slUZ4XuOkJ8tPqjcTDk/5dyTqSJIRphPFtdp8qgLIwDmAFywUWqNGil+IyvFScfcoj
         91tyWKaCq3pLZxiZMclWQBgDV2pvhEj+gdbGIZbEcEhy0Yhvoow7wa7jgZfkoWH536O5
         w5zIhy25QLbVSxAsvmDFAE43b9LauLiPIkjoujReTYieO25OZAOGOckKlG8coI5LIy75
         Jx9b4dsPnhBixoTzTPthX4BXKvoJlwTgVIUsm2eoH6pOER8ZTMBFCI4BilX/iDQ5x1WP
         wS5kSfC4S/KWeQ3fu0/AoELugk4k5JfLVIMBJyb07gwChwBxqj09U4ruXccqJRZJy8wi
         p6fQ==
X-Gm-Message-State: AOAM532fARJT+ytfKw0tm7JG3eMLU+gM/yDK06nKw5kDFCtv3i79m7tw
        dbsGXOUAm6fwVDEzhVNJB21pzhVRaQo=
X-Google-Smtp-Source: ABdhPJzqeQq6S3dv2vNKiKuKeR9/zyRyBoSjA0aG0IRR2hiWy83XdShIpIJLEY5XzY7CpTLIuZtPCQ==
X-Received: by 2002:a17:902:dacb:b0:141:e931:3b49 with SMTP id q11-20020a170902dacb00b00141e9313b49mr36125560plx.45.1637921581118;
        Fri, 26 Nov 2021 02:13:01 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id z10sm1045999pfh.188.2021.11.26.02.13.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:13:00 -0800 (PST)
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
Subject: [PATCH V6 10/49] x86: Mark __native_read_cr3() & native_write_cr3() as __always_inline
Date:   Fri, 26 Nov 2021 18:11:30 +0800
Message-Id: <20211126101209.8613-11-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
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

