Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6384561D5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 18:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbhKRRzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 12:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbhKRRzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 12:55:43 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9909BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 09:52:43 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso6394501pjo.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 09:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UNpYcjznSLDfrzZVMS7i8YLtd72JJeEh++gxWfKid5Y=;
        b=l7/2SQXr83cdfNO2sisZ71yuAqRpqszIBUBbFPK84k34dcsW9nUu/z3gJwIU0qj8JZ
         Eg+HgMbNZaraeCJnaC3AL595oWntSA5hkbUXFRs+j2sWze5FMsRxajZl/H34rK8DCwlk
         ciRZHALou/mVz+5pPKfn31BKbBJJ7YnX4flf6M1nAInVEsCjQGXPm5zJjaRIhrcQUz8b
         D+jFm2JWoqGzAL2xZHZAniqLcq8dtktiGTfpx0b8t1P1UdH32RTH8b8JZzrexHSA7tl0
         1G2RFQI/bTmEMKeEFceGYU5wINFT5nzWw8ouqPV3lz+seKTq8nzDbI3q2zrUPPUXeGVv
         Yx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UNpYcjznSLDfrzZVMS7i8YLtd72JJeEh++gxWfKid5Y=;
        b=0xGoEnEZCQ8b+014gTyw+mXDYd8DJT3WuNbHvdBMZ5L3hVqPAEzuoG5cNGgUED14cU
         9t+2vqu3AqDK0jNSs42fi3SVqRJiLn+24Di9FeYpJbS+D6q1geecg4AVNpEx82VEjrXt
         P/qM/OvXq628PcgtcDUyjFyaN3Ua1srpxIIqOZSPEkRfSpZswTk8C/6LD9jbdOWIdnrv
         DwL+3giTYPI9zytQyIUHhXKhiYibGFqdlgFYMhmsYmoffLJk5wbaAl8k8m/t/Y5tzhdB
         WiRfNqAYN/j1+7An7bMEnutiOeDzxI6t1v9bG2DbHMtwukBkwSOtlvV4uWq4dvGP6mra
         MHtw==
X-Gm-Message-State: AOAM530rFpQqgsIenMNukrAMV7NIDWkGsUUqZhtj7lDp7i0I62Mhni6I
        I2Pod6rNja5LC0EdJ/8sS9M=
X-Google-Smtp-Source: ABdhPJy9TTrI1+f79mR3GQvEsao8byDUoEhTeY2LKVa02l8TaH0/GcWRSUVkqbalE4Fms/zDplwG7A==
X-Received: by 2002:a17:90b:124d:: with SMTP id gx13mr12611749pjb.106.1637257963196;
        Thu, 18 Nov 2021 09:52:43 -0800 (PST)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:db6:6273:9e40:bea5])
        by smtp.gmail.com with ESMTPSA id s14sm263937pfk.73.2021.11.18.09.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 09:52:42 -0800 (PST)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Johannes Berg <johannes.berg@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] x86/csum: fix compilation error for UM
Date:   Thu, 18 Nov 2021 09:52:39 -0800
Message-Id: <20211118175239.1525650-1-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

load_unaligned_zeropad() is not yet universal.

ARCH=um SUBARCH=x86_64 builds do not have it.

When CONFIG_DCACHE_WORD_ACCESS is not set, simply continue
the bisection with 4, 2 and 1 byte steps.

Fixes: df4554cebdaa ("x86/csum: Rewrite/optimize csum_partial()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Duyck <alexanderduyck@fb.com>
Cc: Johannes Berg <johannes.berg@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 arch/x86/lib/csum-partial_64.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index 5ec35626945b6db2f7f41c6d46d5e422810eac46..1eb8f2d11f7c785be624eba315fe9ca7989fd56d 100644
--- a/arch/x86/lib/csum-partial_64.c
+++ b/arch/x86/lib/csum-partial_64.c
@@ -92,6 +92,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
 		buff += 8;
 	}
 	if (len & 7) {
+#ifdef CONFIG_DCACHE_WORD_ACCESS
 		unsigned int shift = (8 - (len & 7)) * 8;
 		unsigned long trail;
 
@@ -101,6 +102,31 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
 		    "adcq $0,%[res]"
 			: [res] "+r" (temp64)
 			: [trail] "r" (trail));
+#else
+		if (len & 4) {
+			asm("addq %[val],%[res]\n\t"
+			    "adcq $0,%[res]"
+				: [res] "+r" (temp64)
+				: [val] "r" ((u64)*(u32 *)buff)
+				: "memory");
+			buff += 4;
+		}
+		if (len & 2) {
+			asm("addq %[val],%[res]\n\t"
+			    "adcq $0,%[res]"
+				: [res] "+r" (temp64)
+				: [val] "r" ((u64)*(u16 *)buff)
+				: "memory");
+			buff += 2;
+		}
+		if (len & 1) {
+			asm("addq %[val],%[res]\n\t"
+			    "adcq $0,%[res]"
+				: [res] "+r" (temp64)
+				: [val] "r" ((u64)*(u8 *)buff)
+				: "memory");
+		}
+#endif
 	}
 	result = add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
 	if (unlikely(odd)) { 
-- 
2.34.0.rc1.387.gb447b232ab-goog

