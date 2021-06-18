Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137473ACECD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbhFRP1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbhFRPW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:22:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9538FC0619FB
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 08:20:11 -0700 (PDT)
Message-Id: <20210618143449.189900842@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=kWvzMiCSpOyqgYOmKiL1zoGy0OnOopUpMNQHtzTBPHc=;
        b=CyDVaugWO2PC3VyMfth4/t0BL4FKbHYNpDmzIunw3rfFecTBNf99wGI7QIJpE4tbcOXUrR
        P4VZ+d3tHAAnO7rN0deiuweplczGv5z1tE569TRhs40pj2K+wjNDDh80bSLqmuNVXrD2MC
        BwTgHwHKdnQ2kanzqenFtokKJyJfwHdCt5py5OfE+MEvqhFF57zFlhdSX8vlbYHALEb3NV
        9keuyccPtIr6iyN3NMf0RyWN6dDNqODJzemGzn/Pvrmj/r32YO6OxQgJHU/s6U1hIcCoxd
        F4VrkKeHbySRYIWyZDHK3U4b4NBSk2d/mGE6mVloJ97ZCQGhVKH/SeBxKSIFCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=kWvzMiCSpOyqgYOmKiL1zoGy0OnOopUpMNQHtzTBPHc=;
        b=AHPBecKGKKxbgnmOxA9zyvZjQsmVL69YlkDipaoaUbpkbFZOcwAwLXEJnZUn9spdagRmNM
        D3/xQpMxDJyUh4AQ==
Date:   Fri, 18 Jun 2021 16:19:05 +0200
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
Subject: [patch V3 42/66] x86/pkru: Provide pkru_get_init_value()
References: <20210618141823.161158090@linutronix.de>
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

