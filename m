Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7E43DEC02
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 13:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbhHCLgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 07:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbhHCLgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 07:36:17 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1E7C061757;
        Tue,  3 Aug 2021 04:36:06 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h13so11493673wrp.1;
        Tue, 03 Aug 2021 04:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6ERoO6r7b7bdnRvImyvbdNkxCXw0B3a96lAkHo2TAmc=;
        b=Pk+RzGBAfV8k+BC3uVzXBBgKRU/9Ll3guBjNlC9e967SJVyvgdnpPko5ab7DqNjR6U
         FY6FUeKD/zxgnt4Z7Lnfh/DIXLyJRRroLuXANJctMbeP+8yqqbJBd39NbMtUYIxIlLSS
         OWazTi9pZa49vrNQgxu4s4K/lXOWgSAGt9orxdCvQFhZdgbgvlmVTFY2ic/q6YNNeAnH
         JUvMYo5xUjOw3XjGYLm6s9JZmNvCPipDnf73iUwEQ2mwMtzGtboClMgiJxvGyu2Gakmz
         C3Ip8aPRypTJuCrEgC1Lf6itE2qKsfwnZl4clrzUdbTH9L92O3HXG3MHxoKb+ol4gze4
         fDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6ERoO6r7b7bdnRvImyvbdNkxCXw0B3a96lAkHo2TAmc=;
        b=T0Oq6M+OowPewXtIcTK5DpbqMcDCKRdXdpIK72mU7aLh6Iq7b+8FNpOG6fbhSaDSTj
         NYnGPQh628UGxNYdMl7PbhOZiblqyIP4oRuhcmT4OcSmYXPXMdfyfX6R7W/r6GVTu2ak
         hXEhaf+Q1KEMpW+FdjGx3aB+s7dOUFipuGjAEF6EfL9zkFaxW75KjykZ8LZByHfmfxLh
         iVbbauA37U1BBLSsXD+FAAVeshsPFBLpHcuiMWhgJQlTFM4rj7vvVa7w6UDDUp7FxbBk
         YmetmGYv+KzWUtMV2yfyuwGxaup5tmMFvn1AcgG28i/ysOz8D3h5tSD/yd+8+2gLEMBi
         IxVw==
X-Gm-Message-State: AOAM533jFVfNxYO/o00IqinUakemXjAq27AjiscCsMqoNZbw9aBIpxks
        Uy5jkD38VRN61M8MhYYfCtE=
X-Google-Smtp-Source: ABdhPJzH0axP2mZ4ihgpWQkk8GJdzOlKW99HWkPqI4rw1+rTyJBcXNi80NTHL1VVNxM2G/PIkq/4QQ==
X-Received: by 2002:a5d:45c5:: with SMTP id b5mr22467111wrs.32.1627990564648;
        Tue, 03 Aug 2021 04:36:04 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2de7:c500:a5d6:9db:2c2c:b89d])
        by smtp.gmail.com with ESMTPSA id m14sm13961364wrs.56.2021.08.03.04.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 04:36:02 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Lubomir Rintel <lkundrak@v3.sk>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        platform-driver-x86@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 1/9] x86/entry: correct reference to intended CONFIG_64_BIT
Date:   Tue,  3 Aug 2021 13:35:23 +0200
Message-Id: <20210803113531.30720-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210803113531.30720-1-lukas.bulwahn@gmail.com>
References: <20210803113531.30720-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 662a0221893a ("x86/entry: Fix AC assertion") adds a condition with
IS_ENABLED(CONFIG_64_BIT), but the intended config is called CONFIG_64BIT,
as defined in ./arch/x86/Kconfig.

Fortunately, ./scripts/checkkconfigsymbols.py warns:

64_BIT
Referencing files: arch/x86/include/asm/entry-common.h

Correct the reference to the intended config symbol.

Fixes: 662a0221893a ("x86/entry: Fix AC assertion")
Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/x86/include/asm/entry-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 14ebd2196569..43184640b579 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -25,7 +25,7 @@ static __always_inline void arch_check_user_regs(struct pt_regs *regs)
 		 * For !SMAP hardware we patch out CLAC on entry.
 		 */
 		if (boot_cpu_has(X86_FEATURE_SMAP) ||
-		    (IS_ENABLED(CONFIG_64_BIT) && boot_cpu_has(X86_FEATURE_XENPV)))
+		    (IS_ENABLED(CONFIG_64BIT) && boot_cpu_has(X86_FEATURE_XENPV)))
 			mask |= X86_EFLAGS_AC;
 
 		WARN_ON_ONCE(flags & mask);
-- 
2.17.1

