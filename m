Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612E430F4EF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbhBDO3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbhBDO1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:27:12 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3102C061788
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 06:26:30 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id t25so2216952pga.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 06:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3BIXwfOt2Imm8gRi2hLWfcGsPb8s4RQNwvxHi+wIG9g=;
        b=hVAR78eNebt6pCIxN0kgY0ZhycDpPhKCUkEGhy0gs+YRLRQHNZLsBhNDURXQul4m5O
         OS62ULYpV5Rhz5iwlhpLEN+Oz5bBakA7MDyNtqhgGzBo1FYVmFaTA954wyxUEfaG6YF+
         uTPDlfM1G5YXnTlT4J5kil7nRVxILcZ/ZYdEWXYu0Dx7+A4DdBslT1/ier+uba6jLELI
         BHyDw3YoP1NtnEFgPk604iZa+k1GaVEdKVsmxYjppWSllgAp6T681WqFl280OcA0lkdc
         uF6ualI7vkgTG6rJH/jga1HPdllB96+xAjm+SmsBAZfCacDWPKM1dKAnM4P6+r94uv+n
         jHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3BIXwfOt2Imm8gRi2hLWfcGsPb8s4RQNwvxHi+wIG9g=;
        b=ZWjIUokYZFB+sqUspHHFWitdHOgWbdO3DHve6vYBfFng8lQ25EZ4wmOfgrWOT+i3Ag
         Zp4wpwOARVDUAEb0MyFZsWjIiBZEBjeBKV7zDd0YkWPoTSqRw5qzQvMIE56My5dzhhXt
         ADJzKBFtT0PnM5priifiGGycOpHMmZh5TdxoMXBCjA4WC66owvdJzYABSNDbnR/gqJKn
         AgC0DDcExiwx6S/jiLL6ztQy+ulKr2JP35zysmVOBlXiHtwFqPgY1Nc+rQUkGRsZ2+nd
         eVFwFtkbxrt9o0e3p3x23KOY9P15LSPuyA/7REavBYtyzz9oTjLNX1MdB1vTiK9fZ0Fs
         OE5A==
X-Gm-Message-State: AOAM5307pjKabHXQ6xf9ga2BOLeMQ3Bm6I1+/ytZe3rCNd11D3Ud9ugX
        whHmEoURpbB7LP7BHkyala+NIVh5u6A=
X-Google-Smtp-Source: ABdhPJwYYz8kUZFXDErKVSlxvr2RVqWotIaxHorxMxxfbIOzmBwo0sUN2IZtIaEYSmnEQ5TxO2XGCg==
X-Received: by 2002:a63:2d46:: with SMTP id t67mr9243323pgt.242.1612448790129;
        Thu, 04 Feb 2021 06:26:30 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id w205sm6351513pfc.198.2021.02.04.06.26.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2021 06:26:29 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 2/2] x86/hw_breakpoint: Prevent data breakpoints on cpu_dr7
Date:   Thu,  4 Feb 2021 23:27:07 +0800
Message-Id: <20210204152708.21308-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210204152708.21308-1-jiangshanlai@gmail.com>
References: <20210204152708.21308-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

When in guest (X86_FEATURE_HYPERVISOR), local_db_save() will read
per-cpu cpu_dr7 before clear dr7 register.

local_db_save() is called at the start of exc_debug_kernel().
To avoid recursive #DB, we have to disallow data breakpoints
on cpu_dr7.

Fixes: 84b6a3491567a("x86/entry: Optimize local_db_save() for virt")
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/kernel/hw_breakpoint.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index bc7493a0736f..de34dd49d317 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -307,6 +307,14 @@ static inline bool within_cpu_entry(unsigned long addr, unsigned long end)
 				(unsigned long)&per_cpu(cpu_tlbstate, cpu),
 				sizeof(struct tlb_state)))
 			return true;
+
+		/*
+		 * When in guest (X86_FEATURE_HYPERVISOR), local_db_save()
+		 * will read per-cpu cpu_dr7 before clear dr7 register.
+		 */
+		if (within_area(addr, end, (unsigned long)&per_cpu(cpu_dr7, cpu),
+				sizeof(cpu_dr7)))
+			return true;
 	}
 
 	return false;
-- 
2.19.1.6.gb485710b

