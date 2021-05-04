Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBCFA373296
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 00:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbhEDW5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 18:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbhEDW5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 18:57:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA8BC061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 15:56:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k129-20020a2556870000b02904f825078971so166105ybb.18
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 15:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=wJ3lREM8ANpBss0vObnpt+PZgTm6Br25ftxojw2SDSQ=;
        b=u0ASyJfR8Gv0ChtZFxUSjwEV//GFJJsi7b77vdGvW/Evk0L59B2JLhlLhK5AwOR3g3
         uEIX1Pb1txqxbWWRB+1tQglBHN9EkQ9oCwTzJTG2QXxSTOWdIDt/D3IrH6TKEGD78209
         eWOhTbDTBdNORUT0ERzHpyOEPA2B6EWxAUR2HPoLFNJNz1emLgY7WMfll7i5HVjwTakQ
         HhUKmuyW/HWfGPPekGNanFO/ooNnj33oIFn99Ub098olf4L8fisPzEHfFgtEjtvgYBw6
         t94yMroeYKaLPDGzEp0qryG/nOTtjBcWBkNgKUE6COlZ7W2rNUuFPFaXDxZCDkeXsQWl
         91HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=wJ3lREM8ANpBss0vObnpt+PZgTm6Br25ftxojw2SDSQ=;
        b=PRXuL/FLe+S+36CCcmjQt4dQmpQj69QQ7F42Ps3Z34p385S/UqXWTAS6abjUuYz0+r
         +ePV2ungIWWldTCZ1N/kLG6SmR7PmUgfPHmiWIQ/eiguGrcK+Ht84YUICifJ8OgfDtHH
         tr+rewwD7xzDtN2UWziWEdE07mLAL9JAOz8jSZHPEh8Q0iFMMfpG05miP1Xrmybl7vsu
         XmxUn0yIG86vsuoNsNXXMEv6iGrqnDPXhVUM5f+TO24qWFGQsXBGv1S0Mp/G3o1x2muz
         rEN+UuxHtCUlzN7gzaWWNTnWgnOTb5/DcrQ47xMfmRC3L3Gw3Ap02HQHE/7XAwwSHm7v
         ttmA==
X-Gm-Message-State: AOAM531RnCj8DujNpDzDzy78C9R0HGBIyeXyY3mcoUk6CFx+DR4Z++R0
        SXf2OCfCkzRjSs6MHHKn0PTEZimiMAk=
X-Google-Smtp-Source: ABdhPJwoRMMHYAL7UzldmyVQedTWvosARK6zlCJmGAxYgcz72GuPWBpWa+rwgGQQKivH8LHFMA0xEiH84ww=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:df57:48cb:ea33:a156])
 (user=seanjc job=sendgmr) by 2002:a05:6902:703:: with SMTP id
 k3mr34391581ybt.382.1620169004681; Tue, 04 May 2021 15:56:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  4 May 2021 15:56:32 -0700
In-Reply-To: <20210504225632.1532621-1-seanjc@google.com>
Message-Id: <20210504225632.1532621-3-seanjc@google.com>
Mime-Version: 1.0
References: <20210504225632.1532621-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH 2/2] x86/cpu: Remove write_tsc() and write_rdtscp_aux() wrappers
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Reiji Watanabe <reijiw@google.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop write_tsc() and write_rdtscp_aux(); the former has no users, and the
latter has only a single user and is slightly misleading since the only
in-kernel consumer of MSR_TSC_AUX is RDPID, not RDTSCP.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/msr.h   | 4 ----
 arch/x86/kernel/cpu/common.c | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index e16cccdd0420..a3f87f1015d3 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -324,10 +324,6 @@ static inline int wrmsrl_safe(u32 msr, u64 val)
 	return wrmsr_safe(msr, (u32)val,  (u32)(val >> 32));
 }
 
-#define write_tsc(low, high) wrmsr(MSR_IA32_TSC, (low), (high))
-
-#define write_rdtscp_aux(val) wrmsr(MSR_TSC_AUX, (val), 0)
-
 struct msr *msrs_alloc(void);
 void msrs_free(struct msr *msrs);
 int msr_set_bit(u32 msr, u8 bit);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 1e576cc831c1..0fc80c5ba5ae 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1851,7 +1851,7 @@ static inline void setup_getcpu(int cpu)
 	struct desc_struct d = { };
 
 	if (boot_cpu_has(X86_FEATURE_RDTSCP) || boot_cpu_has(X86_FEATURE_RDPID))
-		write_rdtscp_aux(cpudata);
+		wrmsr(MSR_TSC_AUX, cpudata, 0);
 
 	/* Store CPU and node number in limit. */
 	d.limit0 = cpudata;
-- 
2.31.1.527.g47e6f16901-goog

