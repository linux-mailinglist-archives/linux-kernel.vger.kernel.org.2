Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6621A3FCCA0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240722AbhHaRxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240705AbhHaRxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:53:19 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682AAC061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:52:24 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id j10-20020a17090a94ca00b00181f17b7ef7so2663656pjw.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j0DpXOqCUH2ZzDK/Oe2NuOnKngrEnBqbd1Y+1vZ30I0=;
        b=N9ONtQZotBdVgFYr8tLDVhCZpMZnOXYHCBaj9GMDBgs0ARDXdb/QEAe2q592DoUNqY
         2xp7cvADLJpeRtLjw00Sa0DQKXGwbSYx3qiQhd59EfiKAq1JldRaqRTyXsjzYAC8fefI
         xnnLjOFZBEaedepvlX8IbVB7SQ71PXjGBdnIJpNqiKdkjQ6eCy3lsb00Vc5rDGOpc9t0
         pOoFWElk7R/2eq9695kiwueWKwdRZNjmBnYiUdEM6Aac5Bk7rjnbNeiwmdyKkLmoCeRu
         iIuKbwakabWq1IERm5Hjn3SGQtrJvX7pB9N6p2YCS+YF2UE6wzLq3NE9aptBdqJJTwvD
         33Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j0DpXOqCUH2ZzDK/Oe2NuOnKngrEnBqbd1Y+1vZ30I0=;
        b=bMuMqkBg7Eu4uuEVUD3S+mTNKlnqJhjyg0KejD4cJe6+hR8p/yHUaBOZt0Ukug+4L7
         awHrWLvwzBprkG3jxzx/6IQxidKZV4ysqeMK+AOCnoyA1RTvdhCByDJ869zIIJkk6IXY
         Azm+ywA6nI0itZvFXYqIo6e+WP2zi949FjtqptJ3z03NIX0YXUSn/ngowj45hyytYg1l
         LC+aH28jVnWsJkyOAO1DU0NREfgeKEVfNBqZnp72w0l+yaYzd8PBn9VQ4B1CAqKl7G81
         8w0j74DJMmHW9A0LMAwOMKo6TCQIKUmBNKSC5JoS+n/Ti//43EAB7jVLtjohGg1P7WB/
         ZKDQ==
X-Gm-Message-State: AOAM532TP4ULLgXbjY9HOrw51ee5Md8dsLDilHUaFOGt5y6njxOyN/l+
        IziGAnl4lvteTUpYq5GZdcQPUi2yfnM=
X-Google-Smtp-Source: ABdhPJzshOlya6eaa+3Qzo0Arzj4irzFJlnl4+mU4XY8m1tNjALAbDevtPkf4qNhcI25J46/qLXsJA==
X-Received: by 2002:a17:902:ff02:b0:138:b944:e0f0 with SMTP id f2-20020a170902ff0200b00138b944e0f0mr5790640plj.34.1630432343449;
        Tue, 31 Aug 2021 10:52:23 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id 10sm19599323pgd.12.2021.08.31.10.52.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Aug 2021 10:52:23 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 18/24] x86/entry: Add the C version ist_switch_to_kernel_cr3()
Date:   Wed,  1 Sep 2021 01:50:19 +0800
Message-Id: <20210831175025.27570-19-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210831175025.27570-1-jiangshanlai@gmail.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

It switches the CR3 to kernel CR3 and returns the original CR3, and
the caller should save the return value.

It is the C version of SAVE_AND_SWITCH_TO_KERNEL_CR3.

Not functional difference intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/traps.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/entry/traps.c b/arch/x86/entry/traps.c
index da55565d43ef..9d6753d0b9fc 100644
--- a/arch/x86/entry/traps.c
+++ b/arch/x86/entry/traps.c
@@ -785,8 +785,23 @@ static __always_inline void switch_to_kernel_cr3(void)
 	if (static_cpu_has(X86_FEATURE_PTI))
 		pti_switch_to_kernel_cr3(__native_read_cr3());
 }
+
+static __always_inline unsigned long ist_switch_to_kernel_cr3(void)
+{
+	unsigned long cr3 = 0;
+
+	if (static_cpu_has(X86_FEATURE_PTI)) {
+		cr3 = __native_read_cr3();
+
+		if (cr3 & PTI_USER_PGTABLE_MASK)
+			pti_switch_to_kernel_cr3(cr3);
+	}
+
+	return cr3;
+}
 #else
 static __always_inline void switch_to_kernel_cr3(void) {}
+static __always_inline unsigned long ist_switch_to_kernel_cr3(void) { return 0; }
 #endif
 
 /*
-- 
2.19.1.6.gb485710b

