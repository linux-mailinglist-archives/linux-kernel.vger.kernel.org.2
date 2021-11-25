Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C434E45E115
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 20:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345447AbhKYToZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 14:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhKYTmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 14:42:24 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CB7C061748
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 11:38:59 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id x10so8768372ioj.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 11:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZowlrxScdzu6ELHiji61e3Umv9Wb3p7EakvA6D77L+c=;
        b=B7fU/zdYIE9rbMmV20Qd1z3W4yajboN0Cxcr4+nCRZm6uWY27rC468OaimRDIolyUc
         +DvwW/cumvsipxk51RvBgL4qdlDz7S78Kxj4eLVRuo4DeFCyXdihO1riJ2FyHoErNc3i
         o4zxAhMa9Fg6o6Ab2dNB7Yz6O5hEsWNSVnnWtuJrjljsrkchWVOToSTfTdSFXuVnZpgC
         MAiNGYiYlr/TlgP3oJq3QA8tUHhqC4+GrmP9nX1IMSt7CzG6W30HfkA1zgd0tUepkRHW
         hegscE9BOLXxetdGKGyhc05wuBuLu7TqScvSEyyHciMHp9ifzM2WSL7XvFCeQ7EDTQBC
         9Qug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZowlrxScdzu6ELHiji61e3Umv9Wb3p7EakvA6D77L+c=;
        b=Gpk2feHxLT5yOkp3+/MXyd2fj4Bc2Rhdc8vZiue0vGLA80xL1+B5Hfkd6LzCUIFWK7
         UoNuF3z+vZhMekEDN+r7L46gYO0fVBfuff3G2hQ8ktpCcJ+f06j1w3Vuyd6OqLHhm07Q
         VdbZYaEt1bYP3I68qhoDfEtXLXuh7tKJ/BkRLrxRVF1dquZFc3nU/5I5yO/aBKB5My90
         8y2lopgwO66+JGBD0BCt7QutjbdrNIWMk0IBPC+iNdiIpk82c/hPhSXbl3g8KPp/XWOg
         iIc6i1fq7FjuVqjhS7QgJQgIa71WHN8OOQExxEOJaOwk1ikzzDySsMhVckxGJ0VvZW8y
         LY0A==
X-Gm-Message-State: AOAM532IXiRhUF1Mt1tYxQ6iZhyig1GNj8Qj2k8Ku2HVOij9DwfAbfp5
        9tTnGhOCsUzapuodH73qpHg=
X-Google-Smtp-Source: ABdhPJyg5dG4wXgYPAysXMmxNcY2nuznGrW8Pzn6I0Ws/1FEnM9IEP5toDYrzG39gAnHmoHgmcxKZA==
X-Received: by 2002:a05:6602:15c9:: with SMTP id f9mr28923027iow.184.1637869138410;
        Thu, 25 Nov 2021 11:38:58 -0800 (PST)
Received: from localhost.localdomain (mobile-130-126-255-38.near.illinois.edu. [130.126.255.38])
        by smtp.googlemail.com with ESMTPSA id t188sm2095739iof.5.2021.11.25.11.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 11:38:58 -0800 (PST)
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, alexanderduyck@fb.com,
        goldstein.w.n@gmail.com, edumazet@google.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] x86/lib: Optimize 8x loop and memory clobbers in csum_partial.c
Date:   Thu, 25 Nov 2021 13:38:52 -0600
Message-Id: <20211125193852.3617-1-goldstein.w.n@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the 8x loop to that it uses two independent
accumulators. Despite adding more instructions the latency and
throughput of the loop is improved because the `adc` chains can now
take advantage of multiple execution units.

Make the memory clobbers more precise. 'buff' is read only and we know
the exact usage range. There is no reason to write-clobber all memory.

Relative performance changes on Tigerlake:

Time Unit: Ref Cycles
Size Unit: Bytes

size,   lat old,    lat new,    tput old,   tput new
   0,     4.972,      5.054,       4.864,      4.870
 100,    14.218,     12.476,       9.429,      9.441
 200,    22.115,     16.937,      13.088,     12.852
 300,    31.826,     24.640,      19.383,     18.230
 400,    39.016,     28.133,      23.223,     21.304
 500,    48.815,     36.186,      30.331,     27.104
 600,    56.732,     40.120,      35.899,     30.363
 700,    66.623,     48.178,      43.044,     36.400
 800,    73.259,     51.171,      48.564,     39.173
 900,    82.821,     56.635,      58.592,     45.162
1000,    90.780,     63.703,      65.658,     48.718

Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
---
 arch/x86/lib/csum-partial_64.c | 36 +++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index ded842cd1020..76e2f540587e 100644
--- a/arch/x86/lib/csum-partial_64.c
+++ b/arch/x86/lib/csum-partial_64.c
@@ -48,18 +48,21 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
 	}
 
 	while (unlikely(len >= 64)) {
-		asm("addq 0*8(%[src]),%[res]\n\t"
-		    "adcq 1*8(%[src]),%[res]\n\t"
-		    "adcq 2*8(%[src]),%[res]\n\t"
-		    "adcq 3*8(%[src]),%[res]\n\t"
-		    "adcq 4*8(%[src]),%[res]\n\t"
+		u64 temp_accum;
+
+		asm("movq 0*8(%[src]),%[res_tmp]\n\t"
+		    "addq 1*8(%[src]),%[res_tmp]\n\t"
+		    "adcq 2*8(%[src]),%[res_tmp]\n\t"
+		    "adcq 3*8(%[src]),%[res_tmp]\n\t"
+		    "adcq $0,%[res_tmp]\n\t"
+		    "addq 4*8(%[src]),%[res]\n\t"
 		    "adcq 5*8(%[src]),%[res]\n\t"
 		    "adcq 6*8(%[src]),%[res]\n\t"
 		    "adcq 7*8(%[src]),%[res]\n\t"
-		    "adcq $0,%[res]"
-		    : [res] "+r" (temp64)
-		    : [src] "r" (buff)
-		    : "memory");
+		    "adcq %[res_tmp], %[res]\n\t"
+		    "adcq $0,%[res]\n\t"
+		    : [res] "+r"(temp64), [res_tmp] "=&r"(temp_accum)
+		    : [src] "r"(buff), "m"(*(const char(*)[64])buff));
 		buff += 64;
 		len -= 64;
 	}
@@ -70,26 +73,23 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
 		    "adcq 2*8(%[src]),%[res]\n\t"
 		    "adcq 3*8(%[src]),%[res]\n\t"
 		    "adcq $0,%[res]"
-			: [res] "+r" (temp64)
-			: [src] "r" (buff)
-			: "memory");
+		    : [res] "+r"(temp64)
+		    : [src] "r"(buff), "m"(*(const char(*)[32])buff));
 		buff += 32;
 	}
 	if (len & 16) {
 		asm("addq 0*8(%[src]),%[res]\n\t"
 		    "adcq 1*8(%[src]),%[res]\n\t"
 		    "adcq $0,%[res]"
-			: [res] "+r" (temp64)
-			: [src] "r" (buff)
-			: "memory");
+		    : [res] "+r"(temp64)
+		    : [src] "r"(buff), "m"(*(const char(*)[16])buff));
 		buff += 16;
 	}
 	if (len & 8) {
 		asm("addq 0*8(%[src]),%[res]\n\t"
 		    "adcq $0,%[res]"
-			: [res] "+r" (temp64)
-			: [src] "r" (buff)
-			: "memory");
+		    : [res] "+r"(temp64)
+		    : [src] "r"(buff), "m"(*(const char(*)[8])buff));
 		buff += 8;
 	}
 	if (len & 7) {
-- 
2.25.1

