Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDABF3DEC25
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 13:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbhHCLhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 07:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbhHCLg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 07:36:59 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93002C061798;
        Tue,  3 Aug 2021 04:36:35 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m12so20180095wru.12;
        Tue, 03 Aug 2021 04:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PrYYzdKoM6W71eqcIHLFEPh0q9EP2OIxcHsT7WnN/G4=;
        b=hRhks1I/oGA0EkKtCA2m6OnUsrR4kk50TWZcVSV1Z0RKa99ytTBUVMKy9/PxwYb95D
         D+bWcdJG/COXWFCnNLyeij46Lyz/OpFW7A4vzbSSShKZW7CD3eHAk1Y/DNS3vCW65nDS
         uOMvXKuofwaqdZsyM7SVTZHT2fEYWRm52aDDZnfRk1qHQENOFCMuL5vUbNtuQHaxImu4
         5PvPumBnfau4XeZlcRcDdnc2livLnNAnqQGY3m7hSBQamexBoDeM5YTfLjZhdxT/ZjD3
         OpEisDyABlAQJxjeB67ENr559aEc7bMTbc8XL6sBoj9OWCfdcJnWVoW/94I3M0C2ucrF
         F5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PrYYzdKoM6W71eqcIHLFEPh0q9EP2OIxcHsT7WnN/G4=;
        b=hZ+wQHP3zDZvidah6SUO7cVajGBTTsLo9JHo3JIqMZIyLptlfVKQJjmmpRFxq3O0oz
         DmmkCbLCg+pE33rNVzLmpB99IT91XODM6b1pN9+lijesh/jwBxEuFbu/SnQ1FVDtFVmN
         WVndUhEWKOaViqcRZRrVZcMieWec/bmTOJ5vzIfDp4+bnWo14xGIdR1r90mn4or3KlPt
         FRlkCzLg9HE4H2mgDP+V6M6/frc16xwb8qtsECYOh1hWj3yKQzCz3DfFcCrdCAJnrJEX
         dkXfuX2mQ0kVXU/uvUX40WdYyf7pGCxnTuyxqNj4xLyPBaka5Ax+FgUuccfaQSVLOjxQ
         r4Jw==
X-Gm-Message-State: AOAM530ZuukVC9jNlXrJ/41vCCorDFuAs4eLYwM+pCu2IMiIgAVfRiv/
        DxMlIAekh/unYDaepUPphwo=
X-Google-Smtp-Source: ABdhPJwNNZqZUBOfqtvhzzeT/J3aPn60sYQPoG3Pyi6vu7iyq7tWarSXcurlyIFKuR3whMTHs4alWw==
X-Received: by 2002:a5d:4688:: with SMTP id u8mr22699843wrq.65.1627990594165;
        Tue, 03 Aug 2021 04:36:34 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2de7:c500:a5d6:9db:2c2c:b89d])
        by smtp.gmail.com with ESMTPSA id m14sm13961364wrs.56.2021.08.03.04.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 04:36:32 -0700 (PDT)
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
Subject: [PATCH 9/9] x86: ia32.h: adjust comment for endif of CONFIG_IA32_EMULATION
Date:   Tue,  3 Aug 2021 13:35:31 +0200
Message-Id: <20210803113531.30720-10-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210803113531.30720-1-lukas.bulwahn@gmail.com>
References: <20210803113531.30720-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The content of the ia32 header is guarded by
"ifdef CONFIG_IA32_EMULATION". The comment on the corresponding endif
refers slightly mismatching to CONFIG_IA32_SUPPORT instead.

Hence, ./scripts/checkkconfigsymbols.py warns:

IA32_SUPPORT
Referencing files: arch/x86/include/asm/ia32.h

Adjust the comment on endif to the actual ifdef condition.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/x86/include/asm/ia32.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/ia32.h b/arch/x86/include/asm/ia32.h
index 2c5f7861d373..fada857f0a1e 100644
--- a/arch/x86/include/asm/ia32.h
+++ b/arch/x86/include/asm/ia32.h
@@ -68,6 +68,6 @@ extern void ia32_pick_mmap_layout(struct mm_struct *mm);
 
 #endif
 
-#endif /* !CONFIG_IA32_SUPPORT */
+#endif /* CONFIG_IA32_EMULATION */
 
 #endif /* _ASM_X86_IA32_H */
-- 
2.17.1

