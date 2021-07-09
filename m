Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B823C2653
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 16:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhGIO4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 10:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbhGIO4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 10:56:44 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82559C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 07:54:00 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso7271258pjx.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 07:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=yMC2dDsfx/Mr1GddEIQMt7HBp9JtaQFgPJ/R7R7Trsw=;
        b=A7QrFKXUsYmtHeBaijRHWzuXkoxhFLZqzgE4bzcQsgTWnD/09dL5hE5/74ixU1a1tJ
         RBwibABaw3BgKO3VYNKT9zGMYJb/znxT45YCz/NM7R7HBiMphKME4HFu2AF82KSF9NYz
         hPdjBu0UBxwNhntfk2PlfhunVGqIrOBUehZf6OuXpfEfStQNZyzIgsOKZTdBtf+FsSip
         X4IVvkNkC+o2214PsWwu7KhYe4fYouZ7yhi0iFNB7s+p8xNANKaz26OAT5YBoIIXUdxb
         NgoV1KbNHGeuecM0rwSAROJr/ZZYakiorO3Gt1gdSwZvLXINT3LTsPvIRSHChqdKCxrj
         v0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=yMC2dDsfx/Mr1GddEIQMt7HBp9JtaQFgPJ/R7R7Trsw=;
        b=aTR1FNJ5GNF8lDuvAdnXey+MHNrFxHqN/CsqgpLkIMcHYVPqbQ0vF9ENKUJYEYb/fN
         0nz+8WW4VYKGiws5SZsYeXJSjY0LVIT9OsCeOU+q9EV6VeUd7xqC8rdEI44A+RtvBtl3
         3+PGZ5iSjq1it/uOTTAp9LX5RztV4bSHiMnPjAxqxx+7PYkzkJh9tA7bgFZdGPTHtaCC
         Ln8i2t+4p9y7TEK5nT+eQ6crfvbFKMrj9AVNw3eTEMkxP+BMyGiaCCn8g9UbM71y10ZZ
         gN5O/nyfJYDkaEDiyMUJpIfIcPnga8zbMyR2UGHcE+9XXPTDTUSwtlyPpNRBjoxN64Ft
         PUHA==
X-Gm-Message-State: AOAM530gJhEXUr+dnQPcwE3A96L+z+RPl5xI6Wg9uU5qXjgl4XtN9Lvw
        OlWfkjayG/4SSCLLhg3wqH4zsQ==
X-Google-Smtp-Source: ABdhPJwu61BseB7IUoo1sfFhKkz1W27pvKObVOH7GSx7aJDKxh8xfFyEmgrmgVP7jchxXLslEJT1pA==
X-Received: by 2002:a17:902:934a:b029:128:f8c2:bf9b with SMTP id g10-20020a170902934ab0290128f8c2bf9bmr31305488plp.8.1625842440057;
        Fri, 09 Jul 2021 07:54:00 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id m18sm2931988pfd.42.2021.07.09.07.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 07:53:59 -0700 (PDT)
Subject: [PATCH] RISC-V: Fix a Kconfig ordering issue
Date:   Fri,  9 Jul 2021 07:53:50 -0700
Message-Id: <20210709145350.3661558-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Palmer Dabbelt <palmerdabbelt@google.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:         linux-riscv@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

These are supposed to stay in alphabetical order to prevent merge
conflicts.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 3590eb76000e..a9fd3eb9c300 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -70,6 +70,7 @@ config RISCV
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if 64BIT && MMU
 	select HAVE_ARCH_VMAP_STACK if MMU && 64BIT
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_CONTEXT_TRACKING
@@ -108,7 +109,6 @@ config RISCV
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	select UACCESS_MEMCPY if !MMU
-	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if 64BIT && MMU
 
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
-- 
2.32.0.93.g670b81a890-goog

