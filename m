Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA69C315BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbhBJBOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbhBIWYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:24:35 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADE4C061223
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 14:21:25 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id d2so2526522pjs.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 14:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ENqQliVHyX0PxHtGBlp2V2PfjSfk7pDQibV4WcHF1c0=;
        b=DNmpVMaAOmxBpi1lq2fSAawT2zUEMbedRYjYBYnrwnmsHRkB/xbVWQNOlJ6zVtMfzI
         vGGi87GmT7nrenlq/cSkYMMZ6eqJIletJpPc2kxDvtnRzzg7aMpfrC9pUmpsPBg/s4l1
         ZfUCCJpzDau0w66yyVZe0E36qc+etHLDqEPWzhRN08qsBTjfsA3f/4/Xa68m7EXOSLFB
         rCQwCY+aPq8XgBqufDqR0eqDiRxEGFf3GxacG9uORR7vndFW1q0wf0zjzTTkNBRY9Eda
         0MQujPJ5dTphE5WAwipIb1Hil3avri9lbK1CrHa7iCHozMBUgXfjO+VAq7m7it3qGrv0
         mShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ENqQliVHyX0PxHtGBlp2V2PfjSfk7pDQibV4WcHF1c0=;
        b=TXqhmek9dTI97NWpKo05zVOKNOKn8b+9g0zMpQ8P0ZydGfhtOGagmumbwJA8Nib6tz
         LkmwklHdy591RdSd00SJbp7oct2Wmz0W+eL0zxfADgpBf8c66JNW3yGBUAdQbK8aoWC4
         DY05h5gmPbho5MQBRVc2k10Aza7EB4d3DqoDVIIGrV5xVyHqb9Y21OUoIW2EIt2Xrw8T
         0ihMxTWkO34pPXKmXaRUswynJqzioDY4yEBFvQx/UIgaXAziqOlNoqW/Z6i0sheDuPuC
         dpHJHJz1tiNvGYAurtO40c5JXDvBucZDATaowWRuKMd0aIZBXkSWTQ+79MCKRAXu/YcY
         lGsg==
X-Gm-Message-State: AOAM531Kq/IlZHj10CwHbj9k1pgSVVay0cMZjrFNvoOP0T3/1VzmEfRu
        CHUNMUQesTxWJAfvfU86me4=
X-Google-Smtp-Source: ABdhPJwslqug9ZCevgxSn789hr+2/4MLdZpqxqH/bK+7Zla8f2QjHm8PJexfL8c0MtqT6CDUsLjnbg==
X-Received: by 2002:a17:90b:224f:: with SMTP id hk15mr36754pjb.31.1612909285066;
        Tue, 09 Feb 2021 14:21:25 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id v9sm58601pju.33.2021.02.09.14.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 14:21:24 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v5 6/8] x86/mm/tlb: Do not make is_lazy dirty for no reason
Date:   Tue,  9 Feb 2021 14:16:51 -0800
Message-Id: <20210209221653.614098-7-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210209221653.614098-1-namit@vmware.com>
References: <20210209221653.614098-1-namit@vmware.com>
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
index e0271e0f84ea..98d212518f67 100644
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

