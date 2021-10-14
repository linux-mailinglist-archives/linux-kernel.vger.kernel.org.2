Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2954042D114
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhJNDiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhJNDis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:38:48 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1207C061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:36:44 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id x4so3208724pln.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jceiELf+07OtjBut4BS4H9evczr5+JdNRZELuhcbeM0=;
        b=IHS9Aska3PxbXoRCyb0ZkBf/NXncldOM0QV1b3iHea3LvEMtRDGwZ9CI+Oit1c0jvp
         pjA0duAk2BP1wJ1WJ+If/rz/49nb5Ja09BMJI3M1fbaLYXUTVrNNdXyVkDeOPov8kCVu
         7rgRqesK7L25b8cItwyrb7YsiHSGQd2dC7vHwZYcllfp3/egR82PmnwXEa1Efc30MlCK
         vGBgXXHycs4xj3l/CtglMJB7W7ufmLHrdEVM8+ghW5MCQy1kuNF0HkgJY3oIsSGfAPrV
         rLx3uM14gcj5awA1jt/wMlzNgEyyGWMTN1H6veThspxzbNNPikCP69jsT8phxeJmsnkV
         +COw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jceiELf+07OtjBut4BS4H9evczr5+JdNRZELuhcbeM0=;
        b=LRuQ4tvV11Nf3I0CdSpgsyBb9IfPWNOUjN2ObAeJcUN731cJf2D2d54WRdY5/zszkG
         5C7HQbrP8NkO0qR7LXkNgrrF+0DtWDIuRp9gjJnQohb6xNivJGTNbC8jKmU+9paAgzF9
         ay7TSM3pd5yisPacedXRRRwGotYFpMEyXEkr/mN718ZD7B0R+yMwfesotUMYwuUJHisF
         qRAa6l1ZLoHwgGXcwkyqtHJbazxukMrF9dVbY+olWgGgZXuNxthhu4fzndrP90eAOi7Q
         xkRu3lgNSbeMJRhwlofG6r9o2Wy8P2PvkIT7HW0uXhgwxawLh/W/66Q6+HBDqGUrWTsd
         nCag==
X-Gm-Message-State: AOAM531c/DF9rar1fhaSt8+jBydHkD4moXiDuR8TeVABiorBN2qXIziU
        AeUgSeR5qo3Cjc7Qh493rHRUHxRPyMg=
X-Google-Smtp-Source: ABdhPJxCTuOL+RYqS8VFy38l+J0rP2EJHUZ1mZsC3MDHByduHdr95f+xub1qeEAWzoiCslPjpf87GQ==
X-Received: by 2002:a17:902:e544:b0:13e:e863:6cd2 with SMTP id n4-20020a170902e54400b0013ee8636cd2mr2920437plf.41.1634182604190;
        Wed, 13 Oct 2021 20:36:44 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id e24sm838827pfn.8.2021.10.13.20.36.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:36:43 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joe Perches <joe@perches.com>
Subject: [PATCH V3 27/49] x86: Remove the definition of SWAPGS
Date:   Thu, 14 Oct 2021 11:33:50 +0800
Message-Id: <20211014033414.16321-22-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
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

