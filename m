Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8504239AA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 10:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237802AbhJFIYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237684AbhJFIYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:24:06 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B31C061749;
        Wed,  6 Oct 2021 01:22:14 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r18so6253544wrg.6;
        Wed, 06 Oct 2021 01:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xtmKhpid0Egxie2Iw2C5px+jdI/2/t58HcZiShikhEg=;
        b=UMdXZXvRK+KB24Qmn+sEV2fkRBHjx2JetJ1V1FldatAQgdskN8G/Unn5tkxFGwBYoD
         m5xiafoaloahtQWkHX/LJqTFn5aF88/xekYmpoJ6t1DQhMkrBJ7AH+O9SV0moJGfFXPX
         cqJpnWtvtgnqLEvdbguwfnxp8f2EDXrb7eahj/PtEtQydf6QL/0juW81nzF9s0x9sSu4
         ALbTWiGAy3/qGhzsRaaSE+xlywLdXX0dkLH24unzHcCRZuwZ6ZU3zcKt2LX4KNVljbEs
         ZtdC9f+Qkb8FdeYbeaJy5a/CJIVbm6Iw8/NO6JVXuFv6/rl4cSvHSymmvvGmt7ZcEtjE
         QLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xtmKhpid0Egxie2Iw2C5px+jdI/2/t58HcZiShikhEg=;
        b=znTAGL1F81OuSbXoK744D83aaX1sb/c7mRLH82aS/VouS8tJ6P6FIFurR586uLc5ZD
         AwpEF1Vx1QtzaVr9lCrvHQjyMh02GzpudULgAhUJhTrVwAWpNDyb9hp3A/5Q3O5JsobA
         WZ3K6Wb3Go8PpRai+UWjnSC2n6poYRlL4Mv1rUXen7GKnHgPCdyVT01dSprcAy+fFP69
         xqfmaV8VInGMoeBbHthaLaZzkxJc9MWFmk00wbSuR5EEvOUqC8AAF8H70sHKq/q1R4pn
         UdoYDkBBoThaVGrXdMsAsyvagWyP6EPaKcdlUACLxahu0UXm6fK0iN6YGexCJtu/K2qe
         CsXQ==
X-Gm-Message-State: AOAM530pcEwRlA0TSgg3+HeSjXCRsvthro6hsaj6v2ize9QEz8EJOlgJ
        xDVDLrkSalIWjGsCIvDSM5s=
X-Google-Smtp-Source: ABdhPJzlGGPhWwbXnW93of0HIaIOYgCK8jVui529YWYn4EryuglYibg7wbxQVE3OE732gkOJS1HQfA==
X-Received: by 2002:a05:600c:210f:: with SMTP id u15mr8278165wml.157.1633508533302;
        Wed, 06 Oct 2021 01:22:13 -0700 (PDT)
Received: from localhost.localdomain (i577BCBA0.versanet.de. [87.123.203.160])
        by smtp.gmail.com with ESMTPSA id 36sm17769818wrc.92.2021.10.06.01.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 01:22:12 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] elfcore: correct reference to CONFIG_UML
Date:   Wed,  6 Oct 2021 10:22:09 +0200
Message-Id: <20211006082209.417-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6e7b64b9dd6d ("elfcore: fix building with clang") introduces
special handling for two architectures, ia64 and User Mode Linux.
However, the wrong name, i.e., CONFIG_UM, for the intended Kconfig symbol
for User-Mode Linux was used.

Although the directory for User Mode Linux is ./arch/um; the Kconfig
symbol for this architecture is called CONFIG_UML.

Luckily, ./scripts/checkkconfigsymbols.py warns on non-existing configs:

UM
Referencing files: include/linux/elfcore.h
Similar symbols: UML, NUMA

Correct the name of the config to the intended one.

Fixes: 6e7b64b9dd6d ("elfcore: fix building with clang")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20211005

Arnd, please ack.
Andrew, please pick this fix.

 include/linux/elfcore.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/elfcore.h b/include/linux/elfcore.h
index 2aaa15779d50..127716b58235 100644
--- a/include/linux/elfcore.h
+++ b/include/linux/elfcore.h
@@ -109,7 +109,7 @@ static inline int elf_core_copy_task_fpregs(struct task_struct *t, struct pt_reg
 #endif
 }
 
-#if defined(CONFIG_UM) || defined(CONFIG_IA64)
+#if defined(CONFIG_UML) || defined(CONFIG_IA64)
 /*
  * These functions parameterize elf_core_dump in fs/binfmt_elf.c to write out
  * extra segments containing the gate DSO contents.  Dumping its
-- 
2.26.2

