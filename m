Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94EFC45FD20
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 07:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350250AbhK0Gob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 01:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbhK0GmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 01:42:25 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9C9C06173E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 22:39:11 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id y16so14063099ioc.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 22:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qP6VhQKZZbRpb6hp9/qKoZz7B/nnZGaLT615tNFBBEI=;
        b=YN/F+qzjOZzezwDyPIWEpGqVaWgIc+jtELPMyCltlccScsyqtWCtEYkVAW2OaYzfgG
         9Wz4Zyx+Q+dkj/GGab64lduQnlAoEQoEu9nc0SYjc1Ln1pXLd51rHWRx6msB5UR7atsz
         TYqFearz11p3jr1CvUKq/dxs1La2pYloOLz3T+bQdTyqjDNY8f2aVyBKKtSFEU/CMz+1
         gGwo6aaIm3Devduq7Bu2qK33ijuaZEhxsojwQseAMxGkeqXAhsaFIDqwdIA1qzwZ5WuY
         RC2JP6mK545idQxJymEbStPahxgeDnRQJSF7O69eUQSnGg4jZ7PKjUSlTxG7FEbDWWNq
         Sgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qP6VhQKZZbRpb6hp9/qKoZz7B/nnZGaLT615tNFBBEI=;
        b=otOqEMpIWYJoipTXUuwEJMsXOhTC2qW9bvE+nhdbQzEN5k5FwYGWHqjVSYPl9ig+9O
         vhaGJASnfMfR+4cwQkg2nar6qkIc7/dTuljScoUwB2V+MZtoJ1F9fXBUsuRik1tdAt+q
         psgY4m6Ox57nWdQXfBcXMkS5XaIuamxMIkBE1UNrecqud4uPyIf4KEu8rk/n3aHQvCbc
         RICkWyoN1jV+LdDgNtUzNFMWdNzP6mCQZnQP0t1yfPbT5Aw2WqXobZTDwOnNVFdCYOwh
         x+RKjFU4EiSfp4TmZavqmStQ7hv46Z9EsTuj3PC0MF9OkHIeuVc6q0TuHIQmWaodre2M
         sbfA==
X-Gm-Message-State: AOAM532+SsvGb2jBUCF+n3nt54kjkoNcwZwKuCblQjJ/cd4hCZV6zcde
        wwTUsinN2ptcD5kq340lhJM=
X-Google-Smtp-Source: ABdhPJyB2mvqh32wM9xfphNhT/d8U3PsttcdvaXTo8qd9a3SMLCmydFIu75I2/tb25mXZmG3qmsxPw==
X-Received: by 2002:a6b:7602:: with SMTP id g2mr25650582iom.37.1637995150965;
        Fri, 26 Nov 2021 22:39:10 -0800 (PST)
Received: from localhost.localdomain (node-17-161.flex.volo.net. [76.191.17.161])
        by smtp.googlemail.com with ESMTPSA id a7sm1799869ioo.5.2021.11.26.22.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 22:39:10 -0800 (PST)
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, alexanderduyck@fb.com,
        goldstein.w.n@gmail.com, edumazet@google.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] x86/lib: Optimize 8x loop and memory clobbers in csum_partial.c
Date:   Sat, 27 Nov 2021 00:39:04 -0600
Message-Id: <20211127063904.102017-1-goldstein.w.n@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211125193852.3617-1-goldstein.w.n@gmail.com>
References: <20211125193852.3617-1-goldstein.w.n@gmail.com>
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

size, lat old, lat new,    tput old,    tput new
   0,   4.961,   4.901,       4.887,       4.951
   8,   5.590,   5.620,       4.227,       4.252
  16,   6.182,   6.202,       4.233,       4.278
  24,   7.392,   7.380,       4.256,       4.279
  32,   7.371,   7.390,       4.550,       4.537
  40,   8.621,   8.601,       4.862,       4.836
  48,   9.406,   9.374,       5.206,       5.234
  56,  10.535,  10.522,       5.416,       5.447
  64,  10.000,   7.590,       6.946,       6.989
 100,  14.218,  12.476,       9.429,       9.441
 200,  22.115,  16.937,      13.088,      12.852
 300,  31.826,  24.640,      19.383,      18.230
 400,  39.016,  28.133,      23.223,      21.304
 500,  48.815,  36.186,      30.331,      27.104
 600,  56.732,  40.120,      35.899,      30.363
 700,  66.623,  48.178,      43.044,      36.400
 800,  73.259,  51.171,      48.564,      39.173
 900,  82.821,  56.635,      58.592,      45.162
1000,  90.780,  63.703,      65.658,      48.718

Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
---
 arch/x86/lib/csum-partial_64.c | 38 +++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index ded842cd1020..52540f148ebb 100644
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
-		    "adcq 5*8(%[src]),%[res]\n\t"
+		u64 temp_accum;
+
+		asm("movq 0*8(%[src]),%[res_tmp]\n\t"
+		    "addq 1*8(%[src]),%[res_tmp]\n\t"
+		    "adcq 2*8(%[src]),%[res_tmp]\n\t"
+		    "adcq 3*8(%[src]),%[res_tmp]\n\t"
+		    "adcq 4*8(%[src]),%[res_tmp]\n\t"
+		    "adcq $0,%[res_tmp]\n\t"
+		    "addq 5*8(%[src]),%[res]\n\t"
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

