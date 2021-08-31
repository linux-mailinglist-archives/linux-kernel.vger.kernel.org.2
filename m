Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18273FCC92
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240588AbhHaRwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240570AbhHaRwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:52:07 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A06C061760
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:51:12 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id v1so1000252plo.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TeWsDf1qBtgTOdPqtpLT2wE1MYQ2l9rSDzEFK3BfOCM=;
        b=kL/idfLhOfYhvVVsR9jDcfKz8be7pe50zMeQP+2fDWm+D81GrqswlNGqviLrTuhJ9i
         Be90iTYxvy7YMTVhNjcYHMx05ZLl4Enb3XD8uaxLOZ1VFBuF37YC+o81fuNLDU7QGNvh
         rtvMRsdSIQdSW0sETZGZ4tGxUsJG74gd3GS2J45gQav7RKWWMIRysuBPBZL5EbzC/dcM
         gKlZsg7mQecc8x0vobjzmHoUeF0mkPdjK5aRB+HGoBtf6+rBiYlZnaHS6+CJizfFZflz
         l7qTuzsV+qHwqUO8u0P39g/aliZUv0XMlbpufVl0wjbz+RCFMrjE6I0W62ShyZwuNtBK
         NeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TeWsDf1qBtgTOdPqtpLT2wE1MYQ2l9rSDzEFK3BfOCM=;
        b=q0bIHtMGsSLbsFCgZLe6z4IDSwDLMTvDW5GCTk+Gyja11aTD/OAAM4rfg9nooQ0O5Y
         KQ/mrUAvU/KWt7UWh+N9QcltuRto+uU9I5e5+uFCtiznXZQy9ORn+w61vc8a3rv1LYOI
         HyqyJoQdAHMYDcflJHnzA6Q5SaWQHeKdECchFjCUH7/RMjO9NPLfycd9kaREMJoX664f
         oQUI+4RpMw9hmn2YWwXPRjmw/cr5pvn3SBkZD5i/fw6j86slkID4qUg70Cp0repFdAhM
         enzMF4wSVWBdLewcpJc1Fzpno1Y85kQCcbw+Y54M+KZZ+e/WH/dnM6knrYylW6dZgfls
         5LOQ==
X-Gm-Message-State: AOAM531ABCKP+hWOogeNNCL/J9nOxViPd6gbrEDHzSt8k9gpUhvH8qLN
        mpT6ABLOjAvTk2TQhY9FnYR9ekkwpcc=
X-Google-Smtp-Source: ABdhPJyUoi3MklHPHb/pJY5Z0risJtdAzEooK/QFmfHLqp0zwWYtSoj4Eoq5fReHAk14ir08zTv3Mg==
X-Received: by 2002:a17:90b:197:: with SMTP id t23mr6717373pjs.209.1630432271426;
        Tue, 31 Aug 2021 10:51:11 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id t38sm18061194pfg.207.2021.08.31.10.51.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Aug 2021 10:51:10 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 07/24] x86: Mark __native_read_cr3() & native_write_cr3() as __always_inline
Date:   Wed,  1 Sep 2021 01:50:08 +0800
Message-Id: <20210831175025.27570-8-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210831175025.27570-1-jiangshanlai@gmail.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

We need __native_read_cr3() & native_write_cr3() to be ensured noinstr.

It is prepared for later patches which implement entry code in traps.c.
Some of the code needs to handle KPTI and has to read/write CR3.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/include/asm/special_insns.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index f3fbb84ff8a7..058995bb153c 100644
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

