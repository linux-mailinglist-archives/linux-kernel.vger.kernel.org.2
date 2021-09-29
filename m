Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8626341C7AF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 17:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344918AbhI2PCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 11:02:34 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60814
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344934AbhI2PC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 11:02:29 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8016A40603
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 15:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632927647;
        bh=vJN7Ck0uNCFG+Ctq/qAp6lWVQYR8Vj2mrO3VtePHdDo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=CdndsxOn2Q+HxgVi+RJAQYf0h3YtqonFisO24TFMTMd3xeuqhyo3398X6/Y2eYMZb
         t8+ZMLRPl2Y9rhk0n//d9ffe3YtUO1ugv5Cvy269sOglS5amFiITcl3ao9qNGghf57
         lwVl87qvCCfyaWuSfgrjDRgGUr1r0VxwfpjagziSYPop+bgx6vjgWayvW0CrWLb7/q
         F66Lcb8ndK1Y/5vNQcr2b/y/XnOfNVBUMXRZ6x8VRCEg8qzgW1RM070HqkyUqPKApR
         lg1qksiVb4bpUcdQA0egCsdari18BmNoV2uyz3EH8urBTh96xN4FwVUlcgDYPyRtsL
         DS0LLVif79q9Q==
Received: by mail-wm1-f71.google.com with SMTP id y23-20020a05600c365700b003015b277f98so950011wmq.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 08:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vJN7Ck0uNCFG+Ctq/qAp6lWVQYR8Vj2mrO3VtePHdDo=;
        b=3hNAIBgnhDVUpSHrIub0WDfoYnw80bgkXPSxDiU738R3Pf/GtMvrBXuHVVW9FD2s2s
         PoPKzI9+loALlZ7c+/uGS9ULy6KvYBHsgyWapkB4MGZRHKnmCfN6dU55HesNfraJxyiF
         5vY2YZWHPe9YM0XP8wJwVxE17kVTodYnuAEP4Tdz+wtM9qOPzYDzH8Qxcd1nE5LWVSDW
         xElEsMDRypRtDJpYKYuYg+jJIRg5QYIzNp3oTTP1HRULszwkt7MtW0fAs3I9n4Qkjn4W
         rhlEd3z7BACkEew/43q6f0Dwkb78gzxJ4s6xiX9R9xm2HqfM5+7xDGwLkTdbIxtvy9nu
         tPWg==
X-Gm-Message-State: AOAM531DlPCfSkOZ2fRfPs2xVaYG3cSYlATnmZtU0AzJ7ltGR1YnRS+N
        F56z4DASds7EqsMuMDPUD2ATTNnK4Kao4ix1Jpg+GkjcxYI+u0JO6oiOw5UVQt783Mstne+Ydch
        934AsExx9iXXIKMrLckMPFeQwxpyOJJhPcNhtI9xLOg==
X-Received: by 2002:adf:d4cb:: with SMTP id w11mr327562wrk.125.1632927646707;
        Wed, 29 Sep 2021 08:00:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfXtNjTqRwTy6zB0yjO+6WDv1SXfe8fP/ut2QpPS8jTHw1twOX+D4X0+hshAyxExD632O4tw==
X-Received: by 2002:adf:d4cb:: with SMTP id w11mr327526wrk.125.1632927646559;
        Wed, 29 Sep 2021 08:00:46 -0700 (PDT)
Received: from alex.home (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id e8sm142306wrr.42.2021.09.29.08.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 08:00:46 -0700 (PDT)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-efi@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH v2 09/10] riscv: Initialize thread pointer before calling C functions
Date:   Wed, 29 Sep 2021 16:51:12 +0200
Message-Id: <20210929145113.1935778-10-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210929145113.1935778-1-alexandre.ghiti@canonical.com>
References: <20210929145113.1935778-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because of the stack canary feature that reads from the current task
structure the stack canary value, the thread pointer register "tp" must
be set before calling any C function from head.S: by chance, setup_vm
and all the functions that it calls does not seem to be part of the
functions where the canary check is done, but in the following commits,
some functions will.

Fixes: f2c9699f65557a31 ("riscv: Add STACKPROTECTOR supported")
Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 arch/riscv/kernel/head.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 8f21ef339c68..892a25c6079d 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -301,6 +301,7 @@ clear_bss_done:
 	REG_S a0, (a2)
 
 	/* Initialize page tables and relocate to virtual addresses */
+	la tp, init_task
 	la sp, init_thread_union + THREAD_SIZE
 	XIP_FIXUP_OFFSET sp
 #ifdef CONFIG_BUILTIN_DTB
-- 
2.30.2

