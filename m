Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E421B43B449
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236680AbhJZOhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235706AbhJZOha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:37:30 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D43C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:35:06 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id k26so14532231pfi.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jceiELf+07OtjBut4BS4H9evczr5+JdNRZELuhcbeM0=;
        b=qmqfTOaBi0XUdmn7lM/BpEKSSglILEofuAcHP+elbEjerLM9hyU+W6L9KOJyMEGhJg
         ovzc2+rgpLBAiQ36cngfxsyq6W/idVbzQKPyELckFDaxVcDYvkrrtRoVEPw5LUmdS2BG
         uzztD0BADcKUXkINmtCEJ7F9FSTn+7EgwGUKn+RdNhGFg4SI4BIlwfCrW3zhVJiEiv+E
         kaz1RxZxUxeoT+WjjwLMOXl6TZrJgLJkCUGLQ0rpg7X5ENSqWikq7z0T7ZgmEcno//LM
         Lp8l8qhRrGLcfjorzz5VmTbpjoxRRc6IuWi15CTcODZ4Gng0Znb5XpLEp0DUf9UuYBan
         cmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jceiELf+07OtjBut4BS4H9evczr5+JdNRZELuhcbeM0=;
        b=yj0WhgdFIkKfm25kgEn5nLvDVIfQselgeLHGOaUoWZSJmHcYIqm62b2DyhTfR5AqA1
         X3RW4giaQjMg5bE2R0iV4D+yuEM4yiOK2nSXKn1GX8XncCLmWaTxXgEETVnGhqtvzfwJ
         6GNz/Rz+9ikKj6EIMxIeDKD8EaFKLt9b8aZ6stoE14W4lR4fbZK1yjtB06a8zLGKNACk
         bV5TkJbARjKPsL/8bcVJE/qNamlYfLjcL3s9/67jtbxQ64Y/0jSmU4cnludgs5vKrBh+
         UAVaY9a8X9KAZJVtrefYCwPJlw6j7BVERbp31izV0LB0VzOx4FSGUlAmC5qvqDHZ59XE
         Lxvw==
X-Gm-Message-State: AOAM533zrMyRlvWiw6LvqF3kps21YKcf2rhN6gJ60Nf3JaPPBxmfMV/R
        2tNyeQK3v26zuJ4K6Tf7PioyDZYYcsM=
X-Google-Smtp-Source: ABdhPJxZmxHS1HLejttm0Y+luvytOKVJybtHFvoFEgwLW3lEO+uLpCSOL13QtsoHe5wwYRFwRLZ+XA==
X-Received: by 2002:a05:6a00:c8a:b0:47b:ff6e:4cf3 with SMTP id a10-20020a056a000c8a00b0047bff6e4cf3mr10118065pfv.50.1635258906011;
        Tue, 26 Oct 2021 07:35:06 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id q10sm19904265pgn.31.2021.10.26.07.35.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:35:05 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH V4 27/50] x86: Remove the definition of SWAPGS
Date:   Tue, 26 Oct 2021 22:34:13 +0800
Message-Id: <20211026143436.19071-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
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

