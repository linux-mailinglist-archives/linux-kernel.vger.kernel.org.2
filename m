Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28AB33DEC1E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 13:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbhHCLhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 07:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbhHCLgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 07:36:43 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0818BC06179B;
        Tue,  3 Aug 2021 04:36:31 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j2so24894910wrx.9;
        Tue, 03 Aug 2021 04:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EV76chwaV0oVgeu6YGO8szXmEF+X1MpMYTZxzWoC7KQ=;
        b=GPSQpH/6dvXjJPuiiXphy81Pf2cTDggxLoXITri86yd0e10GLQ9mzhDccFlS1x1l+C
         jQ06IxJyyiFE3SAeisYtEiOfSLInSN49xwD0KEe9aZ4qBFOMwlLc3q5n+GVHcgNH3PUd
         d0qcn9nD183gK5aj+mntlt9N64cy6oxKMxcIj9JBuNMtqENp6QFk/45KcxnkwjVBQjL3
         V2bL1ZP8NVaO//Dvbu8fVjHJdsPFR4z3CMgnHX8ye7OFcEcXtpwWc4KdlfuNPBbbe3Xc
         cfJXdG9W2MSOq5KpsFrYeLdR8Gc1r03wtEn2iCuou3rvOJxK++ZYIq1CG+oLCaacFh9L
         NiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EV76chwaV0oVgeu6YGO8szXmEF+X1MpMYTZxzWoC7KQ=;
        b=tKeNdviEg+aU2I0GS7fFT3d97sP/UjVtJZJJPdlnd+73XYiwWP8lWIW05Bwuey9e6R
         WL4z3y9FG7pflaNmlPky3cLA+afXE1iMcO/5RTSoD6XoKGO7Rfrz2w6QCa9j/af4QRk7
         dYBwvHLDhEgSZmVTsnyFy5ju6yP8ZxP9LVSlKawR9Fl6b1CBB9pInaOp2CePX6Gm/vI0
         H+7+qPdymTfJS2KHRFWuLbLPqFfZlhHd6+hybl0FcumGw7YX4VoqCdj3SdWEwZuxN7mo
         HWdpT+IN+Zj5KvlJu9vVHAav1fmn9tn+nVihkD8TGQS9Ur7jerVktp5PORUVaGOtXOzq
         Rx5w==
X-Gm-Message-State: AOAM532YNltWFKQw+IRx1KckCI45YdVWSRlG9+kHzExGImNjX/PRN3Sk
        sHfxzQvHaPqXQWne/9GE1cM=
X-Google-Smtp-Source: ABdhPJyNrB45fTvucnY36Wd4v0aqATz2rZrh61/6SbJy1Fh+2tMQZZ5mJFR1X6PcU5iqrvF6B6H9Uw==
X-Received: by 2002:adf:dd05:: with SMTP id a5mr22661855wrm.214.1627990589543;
        Tue, 03 Aug 2021 04:36:29 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2de7:c500:a5d6:9db:2c2c:b89d])
        by smtp.gmail.com with ESMTPSA id m14sm13961364wrs.56.2021.08.03.04.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 04:36:28 -0700 (PDT)
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
Subject: [PATCH 8/9] x86: page_32.h: adjust comment for endif of CONFIG_X86_USE_3DNOW
Date:   Tue,  3 Aug 2021 13:35:30 +0200
Message-Id: <20210803113531.30720-9-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210803113531.30720-1-lukas.bulwahn@gmail.com>
References: <20210803113531.30720-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 345b904c3f7c ("x86: page.h: unify page copying and clearing") adds
an ifdef CONFIG_X86_USE_3DNOW, and a comment on the corresponding endif.
However, it refers slightly mismatching to CONFIG_X86_3DNOW instead.

Hence, ./scripts/checkkconfigsymbols.py warns:

X86_3DNOW
Referencing files: arch/x86/include/asm/page_32.h

Adjust the comment on endif to the actual ifdef condition.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/x86/include/asm/page_32.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/page_32.h b/arch/x86/include/asm/page_32.h
index 94dbd51df58f..b13f8488ac85 100644
--- a/arch/x86/include/asm/page_32.h
+++ b/arch/x86/include/asm/page_32.h
@@ -43,7 +43,7 @@ static inline void copy_page(void *to, void *from)
 {
 	memcpy(to, from, PAGE_SIZE);
 }
-#endif	/* CONFIG_X86_3DNOW */
+#endif	/* CONFIG_X86_USE_3DNOW */
 #endif	/* !__ASSEMBLY__ */
 
 #endif /* _ASM_X86_PAGE_32_H */
-- 
2.17.1

