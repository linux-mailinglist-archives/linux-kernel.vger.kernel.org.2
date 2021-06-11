Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345B33A46DB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbhFKQrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:47:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41228 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhFKQq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:46:27 -0400
Message-Id: <20210611163113.732548292@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623429869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=hyQmn6YTI6II2V0vwXHeKk6e8eE/OBkFGPJ7dT6zJEM=;
        b=PZEe030Zbiy5mCUZ6WD+bMoOAkH/hQhGv/2fAqkZqXqMTXPt5DHxhHFiQIc220x8CqJuQm
        DVlEt51Zv0ZBQf3tjz8UR9t7xLgFAhiyKVS4X+uFEhagIl1wtyGXx/PNmLdxFnXHTLmvqr
        7qP+1E9cy/5kyM+tpl5+ytLdYaeq+0s3BMTDRyhb8AVi7LAkIbZ07fMLPUOEcF78KZ9m51
        tBG0qwtrs2TWyGyGplhxAVY0ovz35LTv5Z9AmOa+u9P6Zs7Y+YUwfN4jYJy9CrAf/JMwTz
        fvC5uLTd9ELpeTfg+MVjocS0/YzzHYtZj+pdSYwkcVIHALvMhu+Jns/Sve/7rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623429869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=hyQmn6YTI6II2V0vwXHeKk6e8eE/OBkFGPJ7dT6zJEM=;
        b=WpDBeZlMU1qQdhoRYZL+mQ2W14EEaRnUR9wevM35o8IpUlxy3QWm3Q3+ol+aGwMf55+39n
        p8L42o9oK1kKiYCg==
Date:   Fri, 11 Jun 2021 18:15:49 +0200
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
Subject: [patch 26/41] x86/pkru: Provide pkru_get_init_value()
References: <20210611161523.508908024@linutronix.de>
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
V2: New patch
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

