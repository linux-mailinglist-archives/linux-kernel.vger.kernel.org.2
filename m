Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F201403E8E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 19:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350375AbhIHRrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 13:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352618AbhIHRrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 13:47:17 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D7DC061796
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 10:46:04 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id w8so3407549pgf.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 10:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ki+aQge6R1sXYo05KVRlyGbundfKO7O/dFJoVBYav6Q=;
        b=Oq1gZ4+wVC97YoorR2afif9hfeSg7/m0u23F1ahqNEGXQCUohIuVLg8xKX3KH+/tlQ
         ivqLBG0XyEMm1tlNeWm6yD7jSj0PUW0WcPnYGejMluZiKd6JA7y7jNLIyqpyrUSts8py
         KPCq+JAg30N7RFBp9Hci0P1Heu+oVKursFUdZpcRcQ709jmZQoNHXhO51NfEO7rymSCJ
         P8XtVa63FaqxQWqoVN4Z/YmAkakDZX6itlvumnmskroOlWG0+0XVMWT4Df4NefypKI4g
         EmDVoPdqHaz68CuhTKkuHow89vBpn1MP66rttvAcc2g0Ia93gSTaa9mOSVYDmEmF4HkJ
         oBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ki+aQge6R1sXYo05KVRlyGbundfKO7O/dFJoVBYav6Q=;
        b=zUrX0yMk4UBwmAcvmhRKANCkSBaN0DwP9LwoEd/Fo3PR64FzRWKWLwCe4QQ/ToYfKy
         3u+y/7Yguo3CpBOJriOVNPE0v33/Z0NvE9lh3tWbrEUdw3R8No3wKFAaQ+BQJ1kiXOPu
         5q9B5gTbjd9UoOuC2xvs+gsWfLscPzu0tTmrUS2VDQm3zQLPJ9+6mvqs3Vh6srlrUiUK
         iTjpW8naQvHKuj80kfraIiDcY14IP+YixQQi2RgpXLYQ1raSIoJoLZXT62chdSTFIJx1
         K+P0x4iqyjb3ug743Gc351lCPjYFZC53ElF73wEg+GFUVa+96gMeWgjlwWVuWcAqJPNc
         iXYw==
X-Gm-Message-State: AOAM533vb02/dPveYYkvYAxeJUsmB1zf6tFwifGEZ3KjM7Hgum+EnHyj
        8kbpTAOqKuKSgZe1pHhqR3NSWQ==
X-Google-Smtp-Source: ABdhPJyvhUF6Mldwb0t87e3+bjrkrgDWT7zKLSKTO11BmkWmE0DjNj3xy/FmrEtRBsLE7/CvpT47Ig==
X-Received: by 2002:a62:4e4c:0:b0:405:4360:33f8 with SMTP id c73-20020a624e4c000000b00405436033f8mr4939771pfb.56.1631123164061;
        Wed, 08 Sep 2021 10:46:04 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id b5sm3108466pfr.26.2021.09.08.10.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 10:46:03 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, vincent.chen@sifive.com
Subject: [RFC PATCH v8 18/21] riscv: Fix an illegal instruction exception when accessing vlenb without enable vector first
Date:   Thu,  9 Sep 2021 01:45:30 +0800
Message-Id: <28a21e13ee57b493c48f70cb27e7a527b21e3b96.1631121222.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631121222.git.greentime.hu@sifive.com>
References: <cover.1631121222.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It triggered an illegal instruction exception when accessing vlenb CSR
without enable vector first. To fix this issue, we should enable vector
before using it and disable vector after using it.

Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/include/asm/vector.h        | 2 ++
 arch/riscv/kernel/cpufeature.c         | 3 +++
 arch/riscv/kernel/kernel_mode_vector.c | 6 ++++--
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index 5d7f14453f68..ca063c8f47f2 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -8,6 +8,8 @@
 
 #include <linux/types.h>
 
+void rvv_enable(void);
+void rvv_disable(void);
 void kernel_rvv_begin(void);
 void kernel_rvv_end(void);
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 7265d947d981..af984f875f60 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -22,6 +22,7 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
 __ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu);
 #endif
 #ifdef CONFIG_VECTOR
+#include <asm/vector.h>
 bool has_vector __read_mostly;
 unsigned long riscv_vsize __read_mostly;
 #endif
@@ -158,7 +159,9 @@ void __init riscv_fill_hwcap(void)
 	if (elf_hwcap & COMPAT_HWCAP_ISA_V) {
 		has_vector = true;
 		/* There are 32 vector registers with vlenb length. */
+		rvv_enable();
 		riscv_vsize = csr_read(CSR_VLENB) * 32;
+		rvv_disable();
 	}
 #endif
 }
diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/kernel_mode_vector.c
index b84618630edf..0d990bd8b8dd 100644
--- a/arch/riscv/kernel/kernel_mode_vector.c
+++ b/arch/riscv/kernel/kernel_mode_vector.c
@@ -71,15 +71,17 @@ static void put_cpu_vector_context(void)
 	preempt_enable();
 }
 
-static void rvv_enable(void)
+void rvv_enable(void)
 {
 	csr_set(CSR_STATUS, SR_VS);
 }
+EXPORT_SYMBOL(rvv_enable);
 
-static void rvv_disable(void)
+void rvv_disable(void)
 {
 	csr_clear(CSR_STATUS, SR_VS);
 }
+EXPORT_SYMBOL(rvv_disable);
 
 static void vector_flush_cpu_state(void)
 {
-- 
2.31.1

