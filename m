Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C7739CBEA
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 02:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhFFAeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 20:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhFFAeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 20:34:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACD9C061767
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 17:32:33 -0700 (PDT)
Message-Id: <20210606001324.050447624@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622939552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=NT7S0zZfu7IO5LYqn9Fta/i8S6242RGUizNciA07Yg0=;
        b=xnijthA8Dwew/rMoNAUu+M/JweXzKWxiph00wHZbd55w3u9EbkLz4oYqrUCzZp2Wjh+OB0
        obZhjSmgrZVAQzOF1w4PVoZ1mE0FAFHtpQNpJjOFKQwhh88MOkDXXtRODRI4F+M+ULM0JU
        StzhvW7hkci+gZpRHGn3n+7Yquhh8cXK8mClRHJ/enzX4XVEtLM06J2vZPlqMdcQGzzNd3
        IJTPUKiPdS6gsWS7nw9aAgwoFIKo+fJUIOYIDJ49wTS9CI9/mx75u6+maaA5kddTP83Bw1
        ru0hlrDtzhj/CeZj9dPZyg6aSsA8B09LYdnI2TVZLMxe9g2LPADO2F867fTweQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622939552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=NT7S0zZfu7IO5LYqn9Fta/i8S6242RGUizNciA07Yg0=;
        b=FkScOcHS3Za4LLGzM/BJsPGibiSZtRQIdV+ZNorLIC+OPS+0eyzk5BZf70rDRbIJY1ddeK
        LAQioN0Itr+zq+DA==
Date:   Sun, 06 Jun 2021 01:47:53 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 11/14] x86/pkru: Provide pkru_get_init_value()
References: <20210605234742.712464974@linutronix.de>
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
 arch/x86/include/asm/pgtable.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1366,8 +1366,10 @@ static inline pmd_t pmd_swp_clear_uffd_w
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 extern u32 init_pkru_value;
+#define pkru_get_init_value()	READ_ONCE(init_pkru_value)
 #else
 #define init_pkru_value	0
+#define pkru_get_init_value()	0
 #endif
 
 static inline bool __pkru_allows_read(u32 pkru, u16 pkey)

