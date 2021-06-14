Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F52A3A6C21
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbhFNQl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:41:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56150 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbhFNQkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:33 -0400
Message-Id: <20210614155357.358131023@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=kWvzMiCSpOyqgYOmKiL1zoGy0OnOopUpMNQHtzTBPHc=;
        b=a0ngaWNnotCKE+thsudGxHi0v/a1efFDQ8Cq7y4g/AgAN0z4NJleixKQzYVpQPYlAKh+r4
        DuZBXPcNUrS4AGSIvkNcLL8MkBiy9ZIqtCDJsGYHUrosvCZiuYZFmWj1GAYNMB1QBNeOT7
        v5oEuuD6k3h8OnayonmJ3vbGS3kdBYxiMz4OIOFQvkc1oLzLUkQYmEyKPw62+38J7YTXyO
        5RpvfxxTET0JlUI8AC5ig3IUMAUlq3XRjJGxQPLJ1884hnPhWFqRsd8Dz1Y8fyAO2j1e9u
        wP6NCMw8LwbqOmT5f1rbgkVYYlf2Z2fv2W7Oo/mHqfGQldM70+h2mbZR8fkQQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=kWvzMiCSpOyqgYOmKiL1zoGy0OnOopUpMNQHtzTBPHc=;
        b=bax8A+7MSfWmP5GquSnmZmYpxUXjpDyLYMHeGEc3PlXwOfkAqqzQ9L/TwF4fGMEciAAt2J
        3u+A3PwfbXtV9iBQ==
Date:   Mon, 14 Jun 2021 17:44:44 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [patch V2 36/52] x86/pkru: Provide pkru_get_init_value()
References: <20210614154408.673478623@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is disabled then the following
code fails to compile:

     if (cpu_feature_enabled(X86_FEATURE_OSPKE)) {
     	u32 pkru = READ_ONCE(init_pkru_value);
	..
     }

because init_pkru_value is defined as '0' which makes READ_ONCE() upset.

Provide an accessor macro to avoid #ifdeffery all over the place.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/pkru.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/include/asm/pkru.h
+++ b/arch/x86/include/asm/pkru.h
@@ -10,8 +10,10 @@
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 extern u32 init_pkru_value;
+#define pkru_get_init_value()	READ_ONCE(init_pkru_value)
 #else
 #define init_pkru_value	0
+#define pkru_get_init_value()	0
 #endif
 
 static inline bool __pkru_allows_read(u32 pkru, u16 pkey)

