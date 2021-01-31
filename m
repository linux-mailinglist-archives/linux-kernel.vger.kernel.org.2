Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E01309949
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 01:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhAaAQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 19:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbhAaAQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 19:16:27 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEC3C061574
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:02 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id c132so9446057pga.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 16:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l25hYkMVDoyooYvVfTs7fc3Z+gKHwtM6S7f1RS+25jI=;
        b=QWgShbAGwg3wKINOtZylfbSTrKZ7qLVxJ9N5IFviem4ZQZbvt3Qb5FGnEFjaJkKWM8
         +N59D/2HoNthkC9KM8y5rri2hSwYvZ3PGjWAtGVOTbVKPODJHb+bNvA2CTILAtcpT2eF
         h2vKj7f18D9utR+WqRIZocdX9KGJMGNpGDq4OAUv3clGITiSokZvfotFKb0au2qJk83H
         +vQ3E86+C/gXHYcrJ616SNR0zQDCLX573HjZiqIKyq8Skylj6hd55xtbGDdaDulme6bC
         qkMuGVJdrJXN1VfTQjQkLNTiMdo9yVwgsqXAzyKwt97zZNMt7qYeioV6GYWPf1kFGeIf
         5v9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l25hYkMVDoyooYvVfTs7fc3Z+gKHwtM6S7f1RS+25jI=;
        b=BWVNtrlXpm+zy9HHrFqgviLJWdpL88OggdsgLfNLheOaw+Ocnq1Ay0wIMpP/cxalXw
         hfVHgHoRIuBuiBz/H1D30RVtg5a1Qqp83YOgBmzPZwwDZFTsBcqfe4B16F88GgEmHhg2
         WhhYiuaapRwFYCqpEYdjL/87O8H+domBIXRcnKX4oPUCLLjG9oBq/dBQBS59JMjCihiA
         0oqbxw1HXyeZ+sNSBG28ecsPsiJ8lgFa5haowXjN2ho+GivaRMTxBi+cf2Mz1ResvtIN
         PyhkxLrES3tt5+0OT0cuERt5uxS3u2nKT4ut8xIKetnECihIca4ygErbDuo6ECH52sLz
         7wCg==
X-Gm-Message-State: AOAM530uMQtRyZ5ZUpEfNO9SuWFrl8+lPl3YowyMLVfkXQtcGVrdmR6L
        jaKdjLd07UutXauqi3NouIQ=
X-Google-Smtp-Source: ABdhPJyd6V4GPxAmmHG/IDX8wnqgvmExjPww3NvYNxqdzTjwzAadbhjaaR3aAin7oAYPZWEG51FDXg==
X-Received: by 2002:a63:c148:: with SMTP id p8mr10395437pgi.188.1612052161728;
        Sat, 30 Jan 2021 16:16:01 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id e12sm13127365pga.13.2021.01.30.16.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 16:16:01 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: [RFC 01/20] mm/tlb: fix fullmm semantics
Date:   Sat, 30 Jan 2021 16:11:13 -0800
Message-Id: <20210131001132.3368247-2-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210131001132.3368247-1-namit@vmware.com>
References: <20210131001132.3368247-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

fullmm in mmu_gather is supposed to indicate that the mm is torn-down
(e.g., on process exit) and can therefore allow certain optimizations.
However, tlb_finish_mmu() sets fullmm, when in fact it want to say that
the TLB should be fully flushed.

Change tlb_finish_mmu() to set need_flush_all and check this flag in
tlb_flush_mmu_tlbonly() when deciding whether a flush is needed.

Signed-off-by: Nadav Amit <namit@vmware.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: x86@kernel.org
---
 include/asm-generic/tlb.h | 2 +-
 mm/mmu_gather.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 2c68a545ffa7..eea113323468 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -420,7 +420,7 @@ static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
 	 * these bits.
 	 */
 	if (!(tlb->freed_tables || tlb->cleared_ptes || tlb->cleared_pmds ||
-	      tlb->cleared_puds || tlb->cleared_p4ds))
+	      tlb->cleared_puds || tlb->cleared_p4ds || tlb->need_flush_all))
 		return;
 
 	tlb_flush(tlb);
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 0dc7149b0c61..5a659d4e59eb 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -323,7 +323,7 @@ void tlb_finish_mmu(struct mmu_gather *tlb)
 		 * On x86 non-fullmm doesn't yield significant difference
 		 * against fullmm.
 		 */
-		tlb->fullmm = 1;
+		tlb->need_flush_all = 1;
 		__tlb_reset_range(tlb);
 		tlb->freed_tables = 1;
 	}
-- 
2.25.1

