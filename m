Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9953403E8D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 19:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348925AbhIHRru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 13:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352515AbhIHRrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 13:47:16 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE45C0613C1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 10:46:02 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id gp20-20020a17090adf1400b00196b761920aso2068850pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 10:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DAMWM+p/L6+jJQLeVV8+FpCPyBLPbqVhx6Mcq9jGTrE=;
        b=FX6ImI5d5GDsqGT8MCQ/CfuS+yOR0dUPasLJ2jW0MMbttloHetQx5WjnkkAhEdRGJF
         bryE7D8WPC13okAdOQrecGMjx/ZnJBMM9bRbI7qPZh4ljizrflgrNgGmqRDMeyFnzGX2
         sAd4P0nBewnpOBfirshxZtEr8/jl/z9Y0XTMOlOz1D0rcsEOfELMUMCj0UtY54hAUKxw
         0Dtgwhj7J+RuoAyNsi1uwGtGVWPseyDy7Nmn/QherXFP3tBJQMi1BEbqKgLW79fHekXO
         e1guF6uMRs8cQbUKtlkXvD6mBN8b4Z4c6871F3oouKy7xYoyN7EdqOWLDdUMb9S5Ypi8
         rPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DAMWM+p/L6+jJQLeVV8+FpCPyBLPbqVhx6Mcq9jGTrE=;
        b=Dr0TwcBmZijL4azA6hGx6sY4X2gnj7iwt1Q2OkG6Zkiyz2nW4qCm4gvN+npsyhU3yI
         oZ+lfM+ITFOIvRqAObS0xFHqnHgp3d5zu2atAYsr3WIsR+1ayIUmKGlFYf1A80ZCWoA+
         EKCcmFsfTO5V7pY2BYpRRfpxKcYE79I0nd1u1CYFOb4A9wIGIBONrHIuY44sDu+pkNVT
         AGhYRLhSO/WJBKZ6ZUBOFw/L8gRN/Iv3IeZAbbQqXYd+1zhAFgoBdwf/PBE/h/cYcHLe
         J5k4pJiFgLrsJz92v7Sl57dlLSFZkrahew6s90OvPqdDUT6GJXlVq5CsXXtpBCQASETg
         gL2g==
X-Gm-Message-State: AOAM531ah8HI8z5TlusUpNkQ6GOAq0iZIiR7monUfejvkFuNLkFG8673
        AQfNsqjtw5ZXeNoTcidqcecgMg==
X-Google-Smtp-Source: ABdhPJxW0YnRI9gSZnMqlrmyiGWCsxjhq+jewN2q3kSudYTJgfvG8MzkTl0x1m4myrFNm8RkgL53xg==
X-Received: by 2002:a17:90a:34b:: with SMTP id 11mr5513611pjf.102.1631123162460;
        Wed, 08 Sep 2021 10:46:02 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id b5sm3108466pfr.26.2021.09.08.10.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 10:46:02 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, vincent.chen@sifive.com
Subject: [RFC PATCH v8 17/21] riscv: Optimize vector registers initialization
Date:   Thu,  9 Sep 2021 01:45:29 +0800
Message-Id: <e742a1ac4028694a85800d0966a9ab0c9fc1c1fe.1631121222.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631121222.git.greentime.hu@sifive.com>
References: <cover.1631121222.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch optimizes the initialization or invalidation of vector
registers. It can reduce the code sizes of vector_flush_cpu_state()
and reset_regs().

Co-developed-by: Han-Kuan Chen <hankuan.chen@sifive.com>
Signed-off-by: Han-Kuan Chen <hankuan.chen@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/kernel/head.S               | 30 +-----------------------
 arch/riscv/kernel/kernel_mode_vector.c | 32 ++------------------------
 2 files changed, 3 insertions(+), 59 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 42eb3203fa77..8362d7458c6c 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -442,39 +442,11 @@ ENTRY(reset_regs)
 
 	li	t1, SR_VS
 	csrs	CSR_STATUS, t1
-	vsetvli t1, x0, e8, m1
+	vsetvli t1, x0, e8, m8
 	vmv.v.i v0, 0
-	vmv.v.i v1, 0
-	vmv.v.i v2, 0
-	vmv.v.i v3, 0
-	vmv.v.i v4, 0
-	vmv.v.i v5, 0
-	vmv.v.i v6, 0
-	vmv.v.i v7, 0
 	vmv.v.i v8, 0
-	vmv.v.i v9, 0
-	vmv.v.i v10, 0
-	vmv.v.i v11, 0
-	vmv.v.i v12, 0
-	vmv.v.i v13, 0
-	vmv.v.i v14, 0
-	vmv.v.i v15, 0
 	vmv.v.i v16, 0
-	vmv.v.i v17, 0
-	vmv.v.i v18, 0
-	vmv.v.i v19, 0
-	vmv.v.i v20, 0
-	vmv.v.i v21, 0
-	vmv.v.i v22, 0
-	vmv.v.i v23, 0
 	vmv.v.i v24, 0
-	vmv.v.i v25, 0
-	vmv.v.i v26, 0
-	vmv.v.i v27, 0
-	vmv.v.i v28, 0
-	vmv.v.i v29, 0
-	vmv.v.i v30, 0
-	vmv.v.i v31, 0
 	/* note that the caller must clear SR_VS */
 #endif /* CONFIG_VECTOR */
 
diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/kernel_mode_vector.c
index 108cfafe7496..b84618630edf 100644
--- a/arch/riscv/kernel/kernel_mode_vector.c
+++ b/arch/riscv/kernel/kernel_mode_vector.c
@@ -86,39 +86,11 @@ static void vector_flush_cpu_state(void)
 	long tmp;
 
 	__asm__ __volatile__ (
-		"vsetvli %0, x0, e8, m1\n"
+		"vsetvli %0, x0, e8, m8\n"
 		"vmv.v.i v0, 0\n"
-		"vmv.v.i v1, 0\n"
-		"vmv.v.i v2, 0\n"
-		"vmv.v.i v3, 0\n"
-		"vmv.v.i v4, 0\n"
-		"vmv.v.i v5, 0\n"
-		"vmv.v.i v6, 0\n"
-		"vmv.v.i v7, 0\n"
 		"vmv.v.i v8, 0\n"
-		"vmv.v.i v9, 0\n"
-		"vmv.v.i v10, 0\n"
-		"vmv.v.i v11, 0\n"
-		"vmv.v.i v12, 0\n"
-		"vmv.v.i v13, 0\n"
-		"vmv.v.i v14, 0\n"
-		"vmv.v.i v15, 0\n"
 		"vmv.v.i v16, 0\n"
-		"vmv.v.i v17, 0\n"
-		"vmv.v.i v18, 0\n"
-		"vmv.v.i v19, 0\n"
-		"vmv.v.i v20, 0\n"
-		"vmv.v.i v21, 0\n"
-		"vmv.v.i v22, 0\n"
-		"vmv.v.i v23, 0\n"
-		"vmv.v.i v24, 0\n"
-		"vmv.v.i v25, 0\n"
-		"vmv.v.i v26, 0\n"
-		"vmv.v.i v27, 0\n"
-		"vmv.v.i v28, 0\n"
-		"vmv.v.i v29, 0\n"
-		"vmv.v.i v30, 0\n"
-		"vmv.v.i v31, 0\n":"=r"(tmp)::);
+		"vmv.v.i v24, 0\n":"=r"(tmp)::);
 }
 
 /*
-- 
2.31.1

