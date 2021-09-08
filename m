Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBF6403E90
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 19:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352641AbhIHRsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 13:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352552AbhIHRr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 13:47:27 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E93C061226
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 10:46:07 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id c6so2237201pjv.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 10:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lvYFnpE+vcL+5OVNgIPvCGE7jHqR7WMR9PRIiy6pwGg=;
        b=dfZBRHf2wrBry4B+KYNGRzOMYSdhwtCugDbMgPPWb+TUptqwNpbB9cDoPmb3Bj/rfz
         reRAK7l9gceD5ghZEnr/xwHqGN+iD7PxQHiGdvkTP/HG2TkMChvO89QCo3eBxaYG3p09
         lLM4KtdDUVIXSvLV1IAyZclec0IG5enKGS3U0RLCT2TzCAaPbSztpqSzrA8l3Xj8BAS0
         gDOcNuHjACo8RfFHoRi8Kvp8Nb/VZqpyG+hDAkCFNHhfdXOgSuD8FfcyPiKN0twBfA/1
         q00wQyzYAeYsGE3mUOBcLvNBVVGXJFR1iBXBG/O1cjkOWVYLSkOXnmTO0yk5r7sGWfKn
         LukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lvYFnpE+vcL+5OVNgIPvCGE7jHqR7WMR9PRIiy6pwGg=;
        b=4M5hyI+wLtP0ywqfFoljEdt3p9CpVmNVDfGo1zAffVq/qd87KmJjiw498ag9MvkY2y
         mkxW3aLkHu6m+Qbj5iKdaQZq6866VSARAGc/5K1bPfERxFJjyMOJ/sB5E+3lITwCNAq3
         Bka3rs2dSfUrvZXulkotL8a7r2caDm+1eI0sZSyUPNzKEljcW3xBMbzJSoK+wvmprPXj
         lWPgaO0rLQ4LL9QtrRv5r87DbeqxKFfnHxugeLplmWmhrxavr/o+StQaCOjkE74jIPGq
         +ZEk03KfpUjiRHB520xNZyQl9WLecCh/HptVg4nJaP9BIloHyvyeiq6OU5upFky0ZHqh
         gorw==
X-Gm-Message-State: AOAM531eqoy0mUjFs9NwI11zn+aSJxq9cx9FzV8QDHch8dnR5VaQ1Cnz
        rXNuSPmJ40n7QF0zF8DRkmNSlMFmiILCNw==
X-Google-Smtp-Source: ABdhPJz7hteQN4ueoz3qvrw7mKi05UEduUmNHaIaV59kjVT3OB9jzRiMBIRJAcu2dSi3Mr41QhgeEg==
X-Received: by 2002:a17:902:bf43:b0:13a:ae0:9dee with SMTP id u3-20020a170902bf4300b0013a0ae09deemr4063860pls.62.1631123167173;
        Wed, 08 Sep 2021 10:46:07 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id b5sm3108466pfr.26.2021.09.08.10.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 10:46:06 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, vincent.chen@sifive.com
Subject: [RFC PATCH v8 20/21] riscv: Optimize task switch codes of vector
Date:   Thu,  9 Sep 2021 01:45:32 +0800
Message-Id: <3b2d4ff556d310ed73a6910b89566a195fc28861.1631121222.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631121222.git.greentime.hu@sifive.com>
References: <cover.1631121222.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replacees 2 instructions with 1 instruction to do the same thing
. rs1=x0 with rd != x0 is a special form of the instruction that sets vl to
MAXVL.

Suggested-by: Andrew Waterman <andrew@sifive.com>
Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/kernel/vector.S | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kernel/vector.S b/arch/riscv/kernel/vector.S
index 4f0c5a166e4e..f7223c81b11a 100644
--- a/arch/riscv/kernel/vector.S
+++ b/arch/riscv/kernel/vector.S
@@ -27,8 +27,7 @@
 #define x_vl     t2
 #define x_vcsr   t3
 #define incr     t4
-#define m_one    t5
-#define status   t6
+#define status   t5
 
 ENTRY(__vstate_save)
 	li      status, SR_VS
@@ -38,8 +37,7 @@ ENTRY(__vstate_save)
 	csrr    x_vtype, CSR_VTYPE
 	csrr    x_vl, CSR_VL
 	csrr    x_vcsr, CSR_VCSR
-	li      m_one, -1
-	vsetvli incr, m_one, e8, m8
+	vsetvli incr, x0, e8, m8
 	vse8.v   v0, (datap)
 	add     datap, datap, incr
 	vse8.v   v8, (datap)
@@ -61,8 +59,7 @@ ENTRY(__vstate_restore)
 	li      status, SR_VS
 	csrs    CSR_STATUS, status
 
-	li      m_one, -1
-	vsetvli incr, m_one, e8, m8
+	vsetvli incr, x0, e8, m8
 	vle8.v   v0, (datap)
 	add     datap, datap, incr
 	vle8.v   v8, (datap)
-- 
2.31.1

