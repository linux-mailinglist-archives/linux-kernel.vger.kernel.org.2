Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEDE73FCCA1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhHaRx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240737AbhHaRxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:53:25 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067AAC061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:52:30 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j1so59175pjv.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3DHmzsbv6q/6lqtqlFV3MF0krMfKeU6dvxUhPVfpVxM=;
        b=Ry81tuLPq+S3RXSqhffmseH1t0lejpbb22WesmWNJIE2CJeWsKZXFtnaZj6CB5VP2I
         SdELS4QL4+ThAum4ITtMrkY+9GumXFQ9uTmEQ/G2UjIQT1bxwcWSCYivbG9Cwh9Tz39K
         M6BZuPG0j4P/ZFMWO+bzsVsBQTCktyaq75cK6b1rL4gC+YZvshdkst6An25jm4IKMuOZ
         JlZ+nYgMw2DPlbo92JNGivgKii/nphCEFNpTk3vm7d9/Fo+Gni6ihB35D16RrXrIIdbg
         VMbOj6b8mH4duzTAXZE0dDjtpOdOM+79w4IUpSjxdNjKBhmfw5/Q1B5l/EuAMBTv4eQL
         460Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3DHmzsbv6q/6lqtqlFV3MF0krMfKeU6dvxUhPVfpVxM=;
        b=jg96SFeRZrJplhT0qt3k7ZRExqQgWA/4aqfBDjWxYcdHKtEHDbJWmkRzQk98N8tswk
         t18+JlwnmXLxiETaiy4uWRKBmxE8DBz4kt/iIAJbOKs8mPpkOoQFLGSOWGhSf34ZU5iU
         fYpcTj/EAuCBSEVIuQdpthCYlYisgARilI1VKQHVDZLsNe1LLdjwd9BxxWHqSzWZPPh+
         G6NfgDy62URcIgLK1itw+sGa7n7pIN97/zrnkdhbciQQZsxbLEGEKHp+gjSpyf8o7EjX
         LgEfHGbRK/6ceLN5GFquMl5xsOoemHzKXv+EXWo2ZWpZLuGD4V5udIiy151aMK9KaqTQ
         EmpQ==
X-Gm-Message-State: AOAM5313hv7KJZPP1sHiNPnkeE1nEyTjrCwkdXpHmvDC6XHhKWReIzA6
        ksPmCrCnFzgk4E1gwK9hQ6txlTp8kYM=
X-Google-Smtp-Source: ABdhPJxG5bNn+6CdCnt28bf5Jcd4DIFoFClmo2mBPajFLlcqDfZ/y1R7jkOgUaMwtHLAWAO/Qjk92Q==
X-Received: by 2002:a17:902:ce84:b0:138:9422:512e with SMTP id f4-20020a170902ce8400b001389422512emr5708993plg.12.1630432349370;
        Tue, 31 Aug 2021 10:52:29 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id b8sm3551396pjo.51.2021.08.31.10.52.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Aug 2021 10:52:29 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 19/24] x86/entry: Add the C version ist_restore_cr3()
Date:   Wed,  1 Sep 2021 01:50:20 +0800
Message-Id: <20210831175025.27570-20-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210831175025.27570-1-jiangshanlai@gmail.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

It implements the C version of RESTORE_CR3().

Not functional difference intended except the ASM code uses bit test
and clear operations while the C version uses mask check and 'AND'
operations.  The resulted asm code of both versions are very similar.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/traps.c | 46 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/x86/entry/traps.c b/arch/x86/entry/traps.c
index 9d6753d0b9fc..e912bfbd2a61 100644
--- a/arch/x86/entry/traps.c
+++ b/arch/x86/entry/traps.c
@@ -65,6 +65,7 @@
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
 #include <asm/proto.h>
+#include <asm/tlbflush.h>
 
 extern unsigned char native_irq_return_iret[];
 extern unsigned char asm_load_gs_index_gs_change[];
@@ -799,9 +800,54 @@ static __always_inline unsigned long ist_switch_to_kernel_cr3(void)
 
 	return cr3;
 }
+
+static __always_inline void pti_switch_to_user_cr3(unsigned long user_cr3)
+{
+#define KERN_PCID_MASK (CR3_PCID_MASK & ~PTI_USER_PCID_MASK)
+
+	if (static_cpu_has(X86_FEATURE_PCID)) {
+		int pcid = user_cr3 & KERN_PCID_MASK;
+		unsigned short pcid_mask = 1ull << pcid;
+
+		/*
+		 * Check if there's a pending flush for the user ASID we're
+		 * about to set.
+		 */
+		if (!(this_cpu_read(cpu_tlbstate.user_pcid_flush_mask) & pcid_mask))
+			user_cr3 |= X86_CR3_PCID_NOFLUSH;
+		else
+			this_cpu_and(cpu_tlbstate.user_pcid_flush_mask, ~pcid_mask);
+	}
+	native_write_cr3(user_cr3);
+}
+
+static __always_inline void ist_restore_cr3(unsigned long cr3)
+{
+	if (!static_cpu_has(X86_FEATURE_PTI))
+		return;
+
+	if (unlikely(cr3 & PTI_USER_PGTABLE_MASK)) {
+		pti_switch_to_user_cr3(cr3);
+		return;
+	}
+
+	/*
+	 * KERNEL pages can always resume with NOFLUSH as we do
+	 * explicit flushes.
+	 */
+	if (static_cpu_has(X86_FEATURE_PCID))
+		cr3 |= X86_CR3_PCID_NOFLUSH;
+
+	/*
+	 * The CR3 write could be avoided when not changing its value,
+	 * but would require a CR3 read.
+	 */
+	native_write_cr3(cr3);
+}
 #else
 static __always_inline void switch_to_kernel_cr3(void) {}
 static __always_inline unsigned long ist_switch_to_kernel_cr3(void) { return 0; }
+static __always_inline void ist_restore_cr3(unsigned long cr3) {}
 #endif
 
 /*
-- 
2.19.1.6.gb485710b

