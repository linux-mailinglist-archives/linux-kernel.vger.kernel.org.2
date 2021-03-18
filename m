Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9169633FFE4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 07:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhCRGsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 02:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhCRGsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 02:48:05 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D0FC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 23:48:05 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id b130so1000442qkc.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 23:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vee5yg6ri0O16rVMRQSiyN/wmpEATSkDNK77si4sIy4=;
        b=axyQA+D92SAI8WfUdhCfXmwDP41PT72VffmuNVgbBJfbQK3g/xilqHM7IEkV6rxmJB
         LU7XArWwTthrY1SEEQSMvnknUACIiZoqAPWGkXvkmMOFfwIwZzRCCL/kkjERGg7R1U8a
         Tbq2272l7Znif2U4ud6t9cpPftGH90Hy3dTKaiRuo9b1rY1ShuipW40zq72RfBUKIQZb
         6owdLEvA5AsCf6vijbOBO6HYouXr3jvXaorNRk0i8t9McZTaPWE3WV9OpN6vD0ESK9KO
         SCXT1NXMCw2DhOzK92RwT/2fSLK37Xp/DiQY5hrH2iMod3XyPJNxZ2XLJo8QjmfNDJKm
         1ThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vee5yg6ri0O16rVMRQSiyN/wmpEATSkDNK77si4sIy4=;
        b=lNiAyXQFOrq0UoAdmauuDTjFmfq6e1XO5vIUd33ih/6Ruj9MHlJQN4X2rcc81JhdTp
         Gym/7WrplSnM8Eu1BDwk//ZhzJa3/sSjhHWOwgagiw0+fWpJ4ALO5Uc+n4MmXirg9HuF
         9Cr8F+5I77hPg7zqr3YeSNlvuzpnhHUgNF2h791fUHFRVxTNZrSju7zxyCB1jC0sgj+q
         cB+GJxLCtxAuZd1xJp7ce4uUwBQLVQGBPozkza8X7JOn1Gv9LKqGktjHCIRXbo+kfZGu
         CfxNL1tjwjKdbiqEVJUf9er1nHS/3DU2ti9aGU4NwO8vyOApGZWkKUQQsxL0h6und0Lr
         CLgA==
X-Gm-Message-State: AOAM5309nXNL75xXCzTUlUjq8duF+Vktlwpb76TErRLq+gSAY+sVFUE9
        NZ3PBJ13garEqDD2yA+ER+0=
X-Google-Smtp-Source: ABdhPJw8jQeX5Wu07TZRF37cXNLJ1WyGPFkwLNXgIR+pHwSIKf42lD4Wxc9dDzMm9xnejpnEdPXhtA==
X-Received: by 2002:a37:e315:: with SMTP id y21mr2948425qki.418.1616050084413;
        Wed, 17 Mar 2021 23:48:04 -0700 (PDT)
Received: from Slackware.localdomain ([37.19.198.143])
        by smtp.gmail.com with ESMTPSA id c5sm1121240qkg.105.2021.03.17.23.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 23:48:03 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] x86/mm: Fixed couple of typos
Date:   Thu, 18 Mar 2021 12:17:51 +0530
Message-Id: <20210318064751.19226-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/compied/compiled/
s/preseve/preserve/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/x86/mm/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index dd694fb93916..0212e831d388 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -29,7 +29,7 @@

 /*
  * We need to define the tracepoints somewhere, and tlb.c
- * is only compied when SMP=y.
+ * is only compiled when SMP=y.
  */
 #define CREATE_TRACE_POINTS
 #include <trace/events/tlb.h>
@@ -756,7 +756,7 @@ void __init init_mem_mapping(void)

 #ifdef CONFIG_X86_64
 	if (max_pfn > max_low_pfn) {
-		/* can we preseve max_low_pfn ?*/
+		/* can we preserve max_low_pfn ?*/
 		max_low_pfn = max_pfn;
 	}
 #else
--
2.30.1

