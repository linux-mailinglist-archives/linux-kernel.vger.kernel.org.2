Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4CA42D100
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhJNDhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhJNDhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:37:04 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF5DC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:35:00 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id s1so1383223plg.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P6Gz7Sa13Nz5wo9ag7NEcCeQMS9LijqUptPqbUded4Q=;
        b=o7Z/Fn1W1B4+f4FoBe0wU+SBII7ZPdSz0b9J/5qzHZJx4y+7gqDJbcHUTPcTScDPeF
         SfED9J2lwyE6vO3cQ/9Feh+n4BQQDID+8y6iqGAN8a2dslGuTL3MaBYKn1Kd6Gcw4n/V
         QjkNr81S1GwmrBL+HVOVZxZx8Nwsxs0KftYwIU7LonMK1Ag8jl9zIbMMvqf1bLk0Wa0P
         B8y/X6BpaVOlFU3UvBu+a6colE+zVlSOZ7xB6UG6aymgQuec5v975xKVnnaOm+Geps9z
         2vtZoYp6zVGLugziRytIsuEFyYVXafdRrT4zZBHrOmW8aTFLUy8HgnJCuAL9w6Dr3elu
         p8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P6Gz7Sa13Nz5wo9ag7NEcCeQMS9LijqUptPqbUded4Q=;
        b=rzwDD8YjoW/sznH0Z/lpHQEi6nYdnK/nmCwHouAib9G6ykCJkIErpSb/4FVgibFlVQ
         aCDveSVHGvnIuKun4UNolWI/wW+4+TYQQDXOTYndrIPOqJpEqKi6SZ300FPq5jhBdJ50
         KxluD87q1WTv4TdRZru2ngy37EOwKhnQZiO4fQLSHgglqcbYkRiGaHSduAOB8+2TcKmn
         y4WHxA+fq8S079UzQb+THSaw3REr/S6cpsvzKPS5+RWYb0TR1XIAr1p0ePtga189qQ9G
         L9fgCrNxmyMR2DffyMt4WsMOWawTXSKdaZ+ncKSPPUftW2J69iUvP4QbNLoeEpnm/T5Y
         qfyQ==
X-Gm-Message-State: AOAM5330/LCskQI16gYnCFrm+AyO/w2mjVicRE9ktDGqv+LA9HEWIHaL
        LBj7mi3jpJmyme01q/IdSC8aAo1/DdE=
X-Google-Smtp-Source: ABdhPJyOnXStg4BXqU5IyhX3C9j68Xv2sif8pTuHYSZvZbHmCfKhU2sOXwbvXi6N7B4sWO9aStuPuw==
X-Received: by 2002:a17:90a:a78e:: with SMTP id f14mr3484226pjq.235.1634182500157;
        Wed, 13 Oct 2021 20:35:00 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id d24sm876261pgv.52.2021.10.13.20.34.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:34:59 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH V3 11/49] x86: Mark __native_read_cr3() & native_write_cr3() as __always_inline
Date:   Thu, 14 Oct 2021 11:33:34 +0800
Message-Id: <20211014033414.16321-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
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

