Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CC93207AF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 00:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhBTX2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 18:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhBTXXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 18:23:17 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1E9C061794
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 15:22:31 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id w18so4285646pfu.9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 15:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wOzShX7oLuDYnSV4FyuJYKPTydrW0d12B18CVA1zKB8=;
        b=nY2qmvQHIqs2WJxOebIkhkR/Ryz+0jBq1ew81e1Ozf/mU6b87kc87aCH1X6JVhzFGh
         vGJKQ1kHIC6cmYtmxjJC2Knkk6o5yjUj1pRYvnO8mfYvFVNV7OckKayNCNUUrYT94Hfx
         QuFb/i2beqz55furEKpwGQ0TTBG3lal/WNgjQ8kQYwbKK9ZnlzUoZTmJTb63wNcO2i3e
         /wOCBdV6uz+asVbfwWITQxs45ZZtusAgaPi111AV+0B+Ojty5JzIRRtOdnihukv3HKV+
         Yt1StjGmlcn5QQTpq9YnuwOim+N7/MvOwii/ERUlczqPa+dA3juS0W55/8i3kZlhhKQ6
         TK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wOzShX7oLuDYnSV4FyuJYKPTydrW0d12B18CVA1zKB8=;
        b=mYL5veSmrvy8QX9ffdOR4V8CTANkN5QG+7nd29jjdvtXp15h0mIY71Ck0fRA1oNmNh
         ok8J57fBKK6z7SKB/QY3DxslS97ZzBXAcYN49Zntz9mOprdFuzhVzu5d5j/vfGSfo0dk
         7fIxZ/RYVdMc7KMlOTccLPDhqwZcU2YAM6d3hIb7uMDkVC7b1nrwBsWb5z8rOtrF7GN0
         3ykdIMphE4ZvpKfavAJ1m26OMNfHoV4Fr9A52Vt8p3EVCBRtp2uF6uJzhbdyTnbcU4Jr
         ShkFrJv/qzjIWSKIVSXHQFuu8cHWLvVVvSDD8R64N3Okw1eRsnGwXe9aNL/O8wnkKXLW
         yF3w==
X-Gm-Message-State: AOAM532avzpjg/nLuG3AIXG9Q3GBnh3yQNO4IeQR8u8npmr8fberoWAT
        vB+f2L27wdbb7DwNSPQxpQIcNZpgQtjDVA==
X-Google-Smtp-Source: ABdhPJzm1WzjG5KOAhNmvCtSRZFsJvLeCH7YpKiAgVVewncAFeWLOD8+/blFrKuZUWDdklLGCfryaA==
X-Received: by 2002:aa7:860a:0:b029:1ed:536e:daa2 with SMTP id p10-20020aa7860a0000b02901ed536edaa2mr7702632pfn.79.1613863350565;
        Sat, 20 Feb 2021 15:22:30 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id 4sm13171538pjc.23.2021.02.20.15.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 15:22:30 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v6 6/9] x86/mm/tlb: Do not make is_lazy dirty for no reason
Date:   Sat, 20 Feb 2021 15:17:09 -0800
Message-Id: <20210220231712.2475218-7-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210220231712.2475218-1-namit@vmware.com>
References: <20210220231712.2475218-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Blindly writing to is_lazy for no reason, when the written value is
identical to the old value, makes the cacheline dirty for no reason.
Avoid making such writes to prevent cache coherency traffic for no
reason.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/mm/tlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 345a0aff5de4..17ec4bfeee67 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -469,7 +469,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		__flush_tlb_all();
 	}
 #endif
-	this_cpu_write(cpu_tlbstate_shared.is_lazy, false);
+	if (was_lazy)
+		this_cpu_write(cpu_tlbstate_shared.is_lazy, false);
 
 	/*
 	 * The membarrier system call requires a full memory barrier and
-- 
2.25.1

