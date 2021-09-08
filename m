Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3A8403E7E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 19:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbhIHRqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 13:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350226AbhIHRqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 13:46:47 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D95BC061757
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 10:45:39 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id t1so3414819pgv.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 10:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SzySQXHTaCH/jeJ8V7t+kf/QD6+VmDcSCT1AxKS8udk=;
        b=DB15qCxohZ22l04+RGbu7grVI6SpFKncc0d6Da+a03aqKMyVGPCzco8oxHHInqeXuc
         c3iv7eHdGSG3qdb1pH9//EUcGCh7CQptN4+A6BCO6e+4hucI9zbOoJMDRjUJ+EaR5Tj2
         17boaXKHiDlr5BPK+IF6dJUHm2VBtHHeMsoH97CWxx7yU/QW9k1jKa1oCS6HT1EplTfc
         osJnslw+31xFXwPjTr1upqGubxjtHcE7QmuXhR8NhwG7hnNvH8q/AnvHW8CJfpARc2hF
         i1kNSjpf1g6kexXblCn0uMCg9mbi3RuqQNvIYdqvf/lpmV0NG6FkA7CxKHXZKV6zrT9l
         WO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SzySQXHTaCH/jeJ8V7t+kf/QD6+VmDcSCT1AxKS8udk=;
        b=TFGQULtoSbwvF17EP/C9Iqt5uK0CRMC9eRqbfIRc9Pf8dSJ4vlLJp9boCFTE+Af75q
         SmLaxS+rL3M48nComJoX/Sl+52IgkwvLdjavcpat/VRVokBguWH2vQEPlJ35Nh4uuw6X
         V67HOjQkmMmcJbSCo+m50JqXvLhi1a4OPmzDkRcL5NJt1+Ag+WtcxbHj95jZGPK8gQ+s
         JQW7ZHxdZJJCpCjN20GqF+RBS4PyBhxebIP4y6ID3zrPEygQCSvjSLJhHtKDcPEfLwqW
         E/d6pzcH0sbFT5vxWg1keapJ1oH40d8T8z5nDnP1It843VFxsjjgUYNOm7Nn44VtHfM2
         UtuQ==
X-Gm-Message-State: AOAM531zMKZq9lhQBDwefLLuOephmq+wrwgOH4pm7YeRLhheRxIFgpP5
        DwV6otuOKqmokDsEDOQd0BLw2A==
X-Google-Smtp-Source: ABdhPJxM9rF1WAh036ev+RVBF9Akd3H1vW4s2HtXc3jdFm4fGSdj8nPBEXdJhR5R71kuBdEj3PZ+Ew==
X-Received: by 2002:a62:8fc3:0:b0:405:473a:7461 with SMTP id n186-20020a628fc3000000b00405473a7461mr4984222pfd.28.1631123139133;
        Wed, 08 Sep 2021 10:45:39 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id b5sm3108466pfr.26.2021.09.08.10.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 10:45:38 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, vincent.chen@sifive.com
Subject: [RFC PATCH v8 02/21] riscv: Rename __switch_to_aux -> fpu
Date:   Thu,  9 Sep 2021 01:45:14 +0800
Message-Id: <e89cf81cbead296dd4c80b078c1d1f74b5d8bb32.1631121222.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631121222.git.greentime.hu@sifive.com>
References: <cover.1631121222.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

The name of __switch_to_aux is not clear and rename it with the
determine function: __switch_to_fpu. Next we could add other regs'
switch.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/include/asm/switch_to.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 0a3f4f95c555..ec83770b3d98 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -45,7 +45,7 @@ static inline void fstate_restore(struct task_struct *task,
 	}
 }
 
-static inline void __switch_to_aux(struct task_struct *prev,
+static inline void __switch_to_fpu(struct task_struct *prev,
 				   struct task_struct *next)
 {
 	struct pt_regs *regs;
@@ -65,7 +65,7 @@ static __always_inline bool has_fpu(void)
 static __always_inline bool has_fpu(void) { return false; }
 #define fstate_save(task, regs) do { } while (0)
 #define fstate_restore(task, regs) do { } while (0)
-#define __switch_to_aux(__prev, __next) do { } while (0)
+#define __switch_to_fpu(__prev, __next) do { } while (0)
 #endif
 
 extern struct task_struct *__switch_to(struct task_struct *,
@@ -76,7 +76,7 @@ do {							\
 	struct task_struct *__prev = (prev);		\
 	struct task_struct *__next = (next);		\
 	if (has_fpu())					\
-		__switch_to_aux(__prev, __next);	\
+		__switch_to_fpu(__prev, __next);	\
 	((last) = __switch_to(__prev, __next));		\
 } while (0)
 
-- 
2.31.1

