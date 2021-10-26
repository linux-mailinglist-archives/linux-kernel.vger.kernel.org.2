Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D60D43B408
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbhJZOaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbhJZOam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:30:42 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970C3C061220
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:28:18 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 75so14323768pga.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P6Gz7Sa13Nz5wo9ag7NEcCeQMS9LijqUptPqbUded4Q=;
        b=SaA1NiEkGHtN4J7DUi4X7jm28lADdnHv49wQpaqQkXFoB3SNf/82h5rLTh4jJY4Btt
         sFX2i9TuLjwdwGWgH7TovhRpmtYSb8F3S8/SF+Js4n7qJH5WqiiAObzWOKaCxGiQUoOZ
         lRjd5HXOhUrmi/i/sVwbQZ4i2aUE1KBlebPKGVkCZ5Jw2u4FeUV8ILl9fCefkH06AWF5
         YP6cWCZozd8+6gVWPwKbpp86ulEUgae4TWI0CNK4fQp1aZJ1mby9DfMh2H9mdK8yLgM/
         gifQFzxuM+NzCSPWqivCCRVQXJHkJg8aSzz1bC/gIZ1wCvIuwe44h0xPltgYmEjt9ujs
         KNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P6Gz7Sa13Nz5wo9ag7NEcCeQMS9LijqUptPqbUded4Q=;
        b=F72jRUhdAFHXp9ZgAUsIz7vapA0q4zWLyKn84bpCjRN4m0TPVhfRE1HRFj/GYANn3R
         Tv8hUdBnpAKMPPg4tgoBh/GqcNYln9YbYJ12lUIHliY4fx+wVL6B3jnhFs3xlVAttCJy
         MhWSJYASAuiaDlv5qma78Habnw0RNbemcos40jRvYNzqvPtETEoN1yNuhxNh2ePIR+Oq
         +0A4c2/x0Xg7zivOiUAc5A5tV/eEWHvgu3Yxha7YEJ89mfu5qmqpsTfqwUQDadGs0azB
         RmGraXdoWA0YZrMnqH/5qpBfrNYX+hNsj1fgfZOXO3Zf/8OOw6jZez6qg8bOGqOO1xWg
         DhyA==
X-Gm-Message-State: AOAM532xygXAvqxwA9Lye+R1az1YTIiDUo7rTRkcFElB97A+eCopWRjZ
        SOGHjVJCFuKFEqwT6zoLxlQ7rxTlSYA=
X-Google-Smtp-Source: ABdhPJyHVRuCy8QwnIHGGX1FbVmTZKRFfXp7Jnfc8oPb4zNKsYgZftt3q32/l9QenAjDm/5tO8rPrw==
X-Received: by 2002:a65:55c5:: with SMTP id k5mr4400286pgs.471.1635258498025;
        Tue, 26 Oct 2021 07:28:18 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id v8sm1228106pjd.7.2021.10.26.07.28.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:28:17 -0700 (PDT)
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
Subject: [PATCH V4 11/50] x86: Mark __native_read_cr3() & native_write_cr3() as __always_inline
Date:   Tue, 26 Oct 2021 22:27:43 +0800
Message-Id: <20211026142824.18362-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
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

