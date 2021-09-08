Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71617403E84
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 19:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352547AbhIHRrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 13:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352492AbhIHRq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 13:46:59 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD33EC0617A8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 10:45:48 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id k23-20020a17090a591700b001976d2db364so2077610pji.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 10:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iGhMejAAmA76H3ZkvML6O16y7Qo+v4duTV6nU5CVEvA=;
        b=HYwOm/v80woR7hZrASRuBt9VEWYdfEIGZVv1D7mKKxhBV9MozBcHYtMEk60BWOmfTK
         7IXvrPee8c++Uiy95m635dPmN2A2eMyYF8QL/k63dzswzQKuvtLqI0MhOxNdGxfbAjI7
         CMlIWh07zb5yta+9yQyXdPYB7z/h+bzyTURg5LGhVE7mi5xeW4dxIghVP4GpDXJ8ahpm
         aQzsFa25jPAVO1cixaDya+rs9fch8l2CQS5/vuosaGYsssdj0C6iMgswqpRUgWpEPoGm
         vNa+GDMCAujcNTZnAkdmO6+r9X78DRv0JBdL5BPwjUEJSSv6FYVto+Ta3a/vpUkNJMSs
         /HbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iGhMejAAmA76H3ZkvML6O16y7Qo+v4duTV6nU5CVEvA=;
        b=SjoxWD0ZbSG7Znd7WxXSecih9wQsGyIcQYp5K7MGfHCpCSTeJFhY6ItrOh2dFoFdV6
         MnuqSHKIsWhahpRbf46J8EWKmklYefQZBSFvd9+NZX8j316jz1yZcHetJNBIZsOke1ij
         w2paY2w9tzGXQTxLo4qYrm3dZlgTtTMB/+l39CoYbCysNDQnKlaRACXcRzdhO589/IXv
         i29S56eohUyokHL9uITVBe8sC2n0uSvLoTH0GP7A7+SbCaYgA+89p8bKjLkZyPXohYOd
         f/JzxcEhObre/+FjHxsYvmKFMcfPqRhfpHFBJ8HxjmbCtHkGvBX6XDLR6lgFaDdHoe9X
         tZuA==
X-Gm-Message-State: AOAM531Df1JVaXkVgPyLfN83JEzXFc8qLafy9KpdBaiJ/TdBlpzlP6cJ
        gTykUivWjCmk4Pf08/KfNQh18Q==
X-Google-Smtp-Source: ABdhPJxREmCJ+n/R6hnBhI28AUCMDziOr6/XIG0206lpF6ZNUJo2cmW3uWW0usZEdTDgXOB7YpYSZQ==
X-Received: by 2002:a17:90a:1d8:: with SMTP id 24mr5418832pjd.69.1631123148372;
        Wed, 08 Sep 2021 10:45:48 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id b5sm3108466pfr.26.2021.09.08.10.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 10:45:48 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, vincent.chen@sifive.com
Subject: [RFC PATCH v8 08/21] riscv: Add vector struct and assembler definitions
Date:   Thu,  9 Sep 2021 01:45:20 +0800
Message-Id: <96e2155d473e72c97c70360df549015c188fe6b8.1631121222.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631121222.git.greentime.hu@sifive.com>
References: <cover.1631121222.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vector state context struct in struct thread and asm-offsets.c
definitions.

The vector registers will be saved in datap pointer of __riscv_v_state. It
will be dynamically allocated in kernel space. It will be put right after
the __riscv_v_state data structure in user space.

Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/include/asm/processor.h   |  1 +
 arch/riscv/include/uapi/asm/ptrace.h | 11 +++++++++++
 arch/riscv/kernel/asm-offsets.c      |  6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 021ed64ee608..1b037c69d311 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -35,6 +35,7 @@ struct thread_struct {
 	unsigned long s[12];	/* s[0]: frame pointer */
 	struct __riscv_d_ext_state fstate;
 	unsigned long bad_cause;
+	struct __riscv_v_state vstate;
 };
 
 #define INIT_THREAD {					\
diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
index 882547f6bd5c..bd3b8a710246 100644
--- a/arch/riscv/include/uapi/asm/ptrace.h
+++ b/arch/riscv/include/uapi/asm/ptrace.h
@@ -77,6 +77,17 @@ union __riscv_fp_state {
 	struct __riscv_q_ext_state q;
 };
 
+struct __riscv_v_state {
+	unsigned long vstart;
+	unsigned long vl;
+	unsigned long vtype;
+	unsigned long vcsr;
+	void *datap;
+#if __riscv_xlen == 32
+	__u32 __padding;
+#endif
+};
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _UAPI_ASM_RISCV_PTRACE_H */
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index 90f8ce64fa6f..34f43c84723a 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -72,6 +72,12 @@ void asm_offsets(void)
 	OFFSET(TSK_STACK_CANARY, task_struct, stack_canary);
 #endif
 
+	OFFSET(RISCV_V_STATE_VSTART, __riscv_v_state, vstart);
+	OFFSET(RISCV_V_STATE_VL, __riscv_v_state, vl);
+	OFFSET(RISCV_V_STATE_VTYPE, __riscv_v_state, vtype);
+	OFFSET(RISCV_V_STATE_VCSR, __riscv_v_state, vcsr);
+	OFFSET(RISCV_V_STATE_DATAP, __riscv_v_state, datap);
+
 	DEFINE(PT_SIZE, sizeof(struct pt_regs));
 	OFFSET(PT_EPC, pt_regs, epc);
 	OFFSET(PT_RA, pt_regs, ra);
-- 
2.31.1

