Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850DC45EB45
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376728AbhKZK0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376729AbhKZKYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:24:35 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93326C06175B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:12:33 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so7700635pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j+aBXblOzZqJuR0UK2CQdqjmBsiSpe5p02x8xalNLhY=;
        b=CR8ZvG/eTmIF+6n2LUPKvXK0D1N3ZS/VXPp1kIfFB5NmIOe1OPv/KrREmuQemrO9ZU
         56Cdi/hpeuTY5YlIyUVK3xMBNIgrmpFjmOte2MIb6GdauAJ1mdkV7pazk4RGINLP1ItQ
         QOCOfb78RUx4dIXl1tEk7M4KCDsC7m0eI37byIaADYJeSht4n1weHhLW1cQsv7k7BmvX
         frtLZk1yLE/gz88t4hXi+hZwDEf73btdvR74addv+Rbv30fxP/wp6a6b5+A6bjHw8fTm
         sNto21BuO5OxItNQKpAxbOTfnHCRMfC6AUUuCGQA1EyrTik+skp8fby2dU4qy56AEOgF
         grCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j+aBXblOzZqJuR0UK2CQdqjmBsiSpe5p02x8xalNLhY=;
        b=CkoRAz2/OkwHZ9oY0gYuYk7tFfTEiRPYSqTmGAKs10R1LT5yQafP7I27XOoDrqc3Wm
         acBATO8Svnq/LZDDkpyY45wv4yGcWbpkhXt1uix1YoesHJ358DRrnrUxbjDwY2p9B18P
         UrH/x72yaVZz3PnFLqJoGNhtI8EDWq42jc1WZkNb1iTK6WoMgneZyhUkNfPu9zKibW56
         /E/u53+95IeZXaM7/R07OR37WvOcqgBRsrgdB1wICqqgYKa6MM7t4A4WU27VSHHkxbWR
         EAZi5ajgUPRfLF/WyFpgfSVD74dyR1XEhc5HxGkJ+Jz+vMfqW311W3rGClwDhnBN8I+I
         8meg==
X-Gm-Message-State: AOAM532bzZiu95lV1TNjvjufcBDJukluTKnc9+KP9AfhMLoSTnsimep0
        A3uovHugQf5U+WWLNv5FPHyIF8p/Vl8=
X-Google-Smtp-Source: ABdhPJwVpKfomv8cCVh0SzNYWXZ4X7y6UocU6I/Mx45WRSuJu3onDvmX9uy8V67YzdGL0BuA3LvrzA==
X-Received: by 2002:a17:90b:33cf:: with SMTP id lk15mr14486623pjb.85.1637921553011;
        Fri, 26 Nov 2021 02:12:33 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id h18sm6983300pfh.172.2021.11.26.02.12.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:12:32 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH V6 06/49] x86/entry: Introduce __entry_text for entry code written in C
Date:   Fri, 26 Nov 2021 18:11:26 +0800
Message-Id: <20211126101209.8613-7-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Some entry code will be implemented in C files.  __entry_text is needed
to set them in .entry.text section.  __entry_text disables instrumentation
like noinstr, but it doesn't disable stack protector since not all
compiler supported by kernel supporting function level granular
attribute to disable stack protector.  It will be disabled by C file
level.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/include/asm/idtentry.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 1345088e9902..6779def97591 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -11,6 +11,9 @@
 
 #include <asm/irq_stack.h>
 
+/* Entry code written in C. */
+#define __entry_text __noinstr_section(".entry.text")
+
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
  *		      No error code pushed by hardware
-- 
2.19.1.6.gb485710b

