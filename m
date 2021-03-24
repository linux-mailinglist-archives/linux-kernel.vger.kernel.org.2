Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46EE1347F9D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237476AbhCXRhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237456AbhCXRgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:36:49 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FFEC061763;
        Wed, 24 Mar 2021 10:36:49 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ce10so34259660ejb.6;
        Wed, 24 Mar 2021 10:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=itfVnMPvmrJ2NsehZzvMHu8ptMCf86ESb1eCu3uJO/8=;
        b=sMsjiTiE4bXgP8XZ9zbFt3/FqscgaCxqLPaPAoSlvXjmINHgzVQjD5Q/EHfjOyjxXX
         kkuUyqJhQ5ddY/DOKj8DZy79nAy4Q02aQuhdWNc3JrNekTLsbZtMxsrfpEJSa4vokuLq
         hPgAQxm2FZXt1K6ZRlnWaS/YMT+UklpD+MhJX0cwrATCEt1rV39aJScXa0IekfdC0jkl
         qHi87tGH8HixgrTDBIsjiTAoXP7wcPjm+KmagKwKchO7GDKeqPG+Xf3iiAZJa9LR2Sch
         fd+Xf9fYjOIlQn0jXe6onMXhFmD+6kqDNEnczWwQlW85WKhu7IWREYZRkB4WuH0p0huc
         Idzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=itfVnMPvmrJ2NsehZzvMHu8ptMCf86ESb1eCu3uJO/8=;
        b=n02lVrm6BCp4Ko1/JR2nXvGr1raMRtKeIqci1Za8QnCuwP2+/J1IMt0y03vlLPxkfd
         8quIs5OzkDDtTxt537BRxLz/5VYvNqEwUzABULHKHc5ffpvBS1e8M2BdhcgkqhdzLApA
         PX3aj18pbFm/Xcdnh+ULzj6/JzcYA8zS6tOGGcvyeCsAVXabLW0gEHPRe0eLPYUvZYcD
         NAszPCwXpgUZzB/WT/laozJP7hxQZZtVdxPmJOlv0Z6Bpi43+Q7oJClrmTc24puqz3Z0
         uq7fEjYEaIPRZYOnTNpuHJspxbyn5ytLF9USvumWFxS3C/SP0votlK8wFbDBgceCFdrN
         9D3g==
X-Gm-Message-State: AOAM5338jbbFCCJ9Ae1pyBPpyMgbGkyYOnhQkgw/mZsuby/P2RAWEtsm
        sWW2N0xQwVd0z8bAsbi9OhE=
X-Google-Smtp-Source: ABdhPJyJpiifaIIucKRGzfiYwZhJeSbDjmJwVHRDesaCc3E9+T7Iz7n4sIhCM+LUvYCBeHBWY1GO3Q==
X-Received: by 2002:a17:906:5607:: with SMTP id f7mr4834989ejq.262.1616607408049;
        Wed, 24 Mar 2021 10:36:48 -0700 (PDT)
Received: from LEGION ([111.119.187.57])
        by smtp.gmail.com with ESMTPSA id g11sm1452028edt.35.2021.03.24.10.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 10:36:47 -0700 (PDT)
Date:   Wed, 24 Mar 2021 22:36:41 +0500
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        colin.king@canonical.com, dan.carpenter@oracle.com
Cc:     musamaanjum@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/kprobes: Remove dead code
Message-ID: <20210324173641.GA404706@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The condition in switch statement `opcode & 0xf0` cannot evaluate to
0xff. So this case statement will never execute. Remove it.

Fixes: 6256e668b7 ("x86/kprobes: Use int3 instead of debug trap for single-step")
Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
---
 arch/x86/kernel/kprobes/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 89d9f26785c7..3b7bcc077020 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -177,9 +177,6 @@ int can_boost(struct insn *insn, void *addr)
 	case 0xf0:
 		/* clear and set flags are boostable */
 		return (opcode == 0xf5 || (0xf7 < opcode && opcode < 0xfe));
-	case 0xff:
-		/* indirect jmp is boostable */
-		return X86_MODRM_REG(insn->modrm.bytes[0]) == 4;
 	default:
 		/* CS override prefix and call are not boostable */
 		return (opcode != 0x2e && opcode != 0x9a);
-- 
2.25.1

