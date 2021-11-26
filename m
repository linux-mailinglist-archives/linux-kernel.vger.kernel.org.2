Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426FF45EB72
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239475AbhKZK3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376886AbhKZK1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:27:15 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FCBC0613F8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:14:44 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 200so7771768pga.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jceiELf+07OtjBut4BS4H9evczr5+JdNRZELuhcbeM0=;
        b=gJaGcw9HSADzMA0qgQiv+2u19DHaL667LY/TPpB6f80eFr80Ds+bNEnaTxJNPVjSw9
         eOz2z7GgMqgX0DzK/HQ2Qr6hGAasHxQpR4imZgMRHgz6jtgEvj6Qgg625auh/Her4w46
         wLCxB0pW3XBSEadTBAkA17hyOxAiaJn2FIwYrLFtWEr+xq4w0S/jzbTCLwHL6qkCBheY
         bimSIrLIjGMgBo8BTW77LlqVNnJTpU4fnJjmjM9EMjc5+nk+lSwTTC6vYLoyBfcah+Pw
         6rKJwpYFEXMsT/Y+gVVXfxCISQUIOy0P5pm3ZNe+7krdxsy9BQEJuI7w6W7WIvH+DGN1
         p76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jceiELf+07OtjBut4BS4H9evczr5+JdNRZELuhcbeM0=;
        b=z88hsZc5wHmvdCx5tCoHN807b+Ug9GPvOZ8HI7jagNPJNYdJKq/M0vDSlH9TzgN5xd
         3e4ML2iFJc47SZlHMUIwjc6lKQDMU3MkXxilYBnjLNPsFIVfqlsEqwZa+7Mcf5iJ+vnP
         wQ6aXAfkI0Y/P/CHcLgMLxp64+eB1T18bPyFjqzHKalTfp5y/rFMChap9KxcIjOgEpGF
         Qg42tqd9bwKpBb/fn2gwxLBgEfxeG3vZDq+tYB5iL0uwcDaQMqM4ikihtRVLxnP0Ov7S
         ubZ+nEtZNLG+T7PZyL0oYYyvws2Vs1GbGSKSMRIXx9A0hTZuxnzVWrAQhThJ6I9fP8cL
         PyzA==
X-Gm-Message-State: AOAM5324qPktTGrCjwUeOjLzA6jOp2hgKVm4XzU7mFEP8ZQeFg6YK0fa
        yb1GQkaberu6SXbvsNMW7IFqjrGMXhM=
X-Google-Smtp-Source: ABdhPJwc/kMl2a2ZJthlXQpjAS1GkFqxBcQ4t0FIEGSHmEmVjPqDHPV3zs+9XiT3n8xPxO0RuxWqDA==
X-Received: by 2002:a05:6a00:1150:b0:4a2:7328:cce6 with SMTP id b16-20020a056a00115000b004a27328cce6mr20195583pfm.67.1637921683521;
        Fri, 26 Nov 2021 02:14:43 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id b10sm6517056pfl.200.2021.11.26.02.14.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:14:43 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH V6 26/49] x86: Remove the definition of SWAPGS
Date:   Fri, 26 Nov 2021 18:11:46 +0800
Message-Id: <20211126101209.8613-27-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

There is no user of the pv-aware SWAPGS anymore.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/include/asm/irqflags.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index c5ce9845c999..da41a80eb912 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -139,14 +139,6 @@ static __always_inline void arch_local_irq_restore(unsigned long flags)
 	if (!arch_irqs_disabled_flags(flags))
 		arch_local_irq_enable();
 }
-#else
-#ifdef CONFIG_X86_64
-#ifdef CONFIG_XEN_PV
-#define SWAPGS	ALTERNATIVE "swapgs", "", X86_FEATURE_XENPV
-#else
-#define SWAPGS	swapgs
-#endif
-#endif
 #endif /* !__ASSEMBLY__ */
 
 #endif
-- 
2.19.1.6.gb485710b

