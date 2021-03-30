Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669EE34E19C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 08:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhC3G57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 02:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbhC3G5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 02:57:51 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01BEC061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 23:57:50 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id j3so12489130qvo.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 23:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hMimholtJavSZ5k5RmskDIdPrM99sfcyiNVXiZ0C39Q=;
        b=OH5d8xlZXFJybWRhJjBkXcR78y6Dg99Fi6Wu9wJe5SF7XuE2276SxkOPb4i0864u7I
         v1QOvvNSyVuPWNjaUbDzCNwhIj4w9cZWDbBcqD6PwayVLKhhI3moyW6cOIBtXItiRTDN
         e9mtpAXVixiFF0oBoeyjL+dLI3is78pOxEec8dpytg/re1V5PWPOlgOTqyVQjCmxi66x
         imkUfN9EK+bKYuPQiCfzm9PpjcWnAKe9rMBS/PE18lvblT/WZA0CeXA3Lpd609dUOsZE
         xTu1+OiQ8favi0WgZDFc1mkmN023k92e3sDkUivRuX5GLNu7cU682cYXndI/TnLV6z3P
         k4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hMimholtJavSZ5k5RmskDIdPrM99sfcyiNVXiZ0C39Q=;
        b=Thk80EX4gdcxFEQx4kEevbKyyOf+EBYK7rsw8x6Y8rAxivGiq4AS6UeLeI2IbQ3RQe
         61CnBmxWXFME+p0hAMfXTVJp22oe0Sxq3AID3J7fiX6r0u9cS3XINUUN0wMp5TFMW87E
         ZcCnQs5yLIZLOLnNERToUkWX28hD15SDx/+peDQOZIo2FovmmZsSBthxhrVC5IxEI+zz
         0/9ynbXHG0GwMUaCg636t3NexFqVOb4M+cvMEOhQWwq33qMoUVTR6WQegZnp9PLTMefd
         MLF45CZaS8D3bv7qXPmm1cFLQLDGFmxuUJLgbu26SJ1VCqKWk0h1wYrEK99+IzYelEM1
         xKzw==
X-Gm-Message-State: AOAM530SEAamMXOgC1nbWdZMinWlrR5nmqxoPpRD/RfDmnN23G3hX8Hq
        gYgTpXcsrsgFDRa2s8SuY7Et5P2YwA==
X-Google-Smtp-Source: ABdhPJySzznEs5KXkYY7Mz4YuAJ7eH9id0jzsjJxiOEWguFIkHDpPKF4OEtGNTB/SuPZVGMFtySziqSk3w==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:40b1:c44f:3404:ad6a])
 (user=elver job=sendgmr) by 2002:a0c:e148:: with SMTP id c8mr20761637qvl.18.1617087469699;
 Mon, 29 Mar 2021 23:57:49 -0700 (PDT)
Date:   Tue, 30 Mar 2021 08:57:37 +0200
Message-Id: <20210330065737.652669-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH mm] kfence, x86: fix preemptible warning on KPTI-enabled systems
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com, andreyknvl@google.com,
        jannh@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, x86@kernel.org,
        Tomi Sarvela <tomi.p.sarvela@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On systems with KPTI enabled, we can currently observe the following warning:

  BUG: using smp_processor_id() in preemptible
  caller is invalidate_user_asid+0x13/0x50
  CPU: 6 PID: 1075 Comm: dmesg Not tainted 5.12.0-rc4-gda4a2b1a5479-kfence_1+ #1
  Hardware name: Hewlett-Packard HP Pro 3500 Series/2ABF, BIOS 8.11 10/24/2012
  Call Trace:
   dump_stack+0x7f/0xad
   check_preemption_disabled+0xc8/0xd0
   invalidate_user_asid+0x13/0x50
   flush_tlb_one_kernel+0x5/0x20
   kfence_protect+0x56/0x80
   ...

While it normally makes sense to require preemption to be off, so that
the expected CPU's TLB is flushed and not another, in our case it really
is best-effort (see comments in kfence_protect_page()).

Avoid the warning by disabling preemption around flush_tlb_one_kernel().

Link: https://lore.kernel.org/lkml/YGIDBAboELGgMgXy@elver.google.com/
Reported-by: Tomi Sarvela <tomi.p.sarvela@intel.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 arch/x86/include/asm/kfence.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kfence.h b/arch/x86/include/asm/kfence.h
index 97bbb4a9083a..05b48b33baf0 100644
--- a/arch/x86/include/asm/kfence.h
+++ b/arch/x86/include/asm/kfence.h
@@ -56,8 +56,13 @@ static inline bool kfence_protect_page(unsigned long addr, bool protect)
 	else
 		set_pte(pte, __pte(pte_val(*pte) | _PAGE_PRESENT));
 
-	/* Flush this CPU's TLB. */
+	/*
+	 * Flush this CPU's TLB, assuming whoever did the allocation/free is
+	 * likely to continue running on this CPU.
+	 */
+	preempt_disable();
 	flush_tlb_one_kernel(addr);
+	preempt_enable();
 	return true;
 }
 
-- 
2.31.0.291.g576ba9dcdaf-goog

