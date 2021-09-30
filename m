Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71DA41E0A1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 20:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353094AbhI3SIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 14:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353168AbhI3SHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 14:07:53 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66F7C061775
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:06:06 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id az37-20020a05620a172500b0045e43348ee8so14086725qkb.19
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QXcVEtkl1ttQdqJQ36Mmw2BuBwRi/4y7WfQWoHeDQYQ=;
        b=YIvuqa4diHL/KOdonWT+XrXNn6ejbmYGrxpcq6tHonqWDd9wLeV2kwwd7/MnZkZe+o
         s2KOkSSO2fNwJF71waRq3eGAH4t/zuBbUl+XNk9E9a6TngigsVIeZe5yIU42XiSqwlo8
         HQ9xPg9wLyxcZETOfRH6ThiR7EGl9OmCGOW0Fy7NxiJTbRGoINKW6TqXqmjsD6Gjlfn/
         1A8wRMJIuH+s8jB6UrBBIYr1tJxFMfIp51clrm1Ltlh5lxhL31MVFlV8m5jJB1qsC5Bz
         y30kNX8VS2C21viJCJ3iLc/AywLzChE7HO7BQ8g0EW657HJlc44Icfo9Td2j2D5Ps4vu
         t4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QXcVEtkl1ttQdqJQ36Mmw2BuBwRi/4y7WfQWoHeDQYQ=;
        b=o3LLjwIogTlAIJBIjR6QfgiJEIEu6SWtJNHQincNTpFPYTU7aGK7rqeLW4kEdyjDgr
         6tjSt0t65rZj6VfV1da9WMGixrNBSUr3FI693jUaPRlvOzz38BzqAg47hyXxJYyrToby
         t7bUF3ZS79Fw40tqnYSwX/ehn+rgO+k/XwJpL0J5msk4UQ2Hy/ZZ6/XunqR5qA625Ptc
         YhbKPnw/QT+IaVcgt+Jgm7Cv+tGLv5yCjvTdgl/F+9GlvDj4NjucYkpgNt0VkaaTUYQ3
         ePngHYeI0vYxkSOh1UxOiXYtJZGJ8j503+dY+6Da2ns+S8qWckvLEyuGlowN6m4/GnOW
         Rr+Q==
X-Gm-Message-State: AOAM530afURR0gDfz6WFWRsQaY9zBwxLOEyUAtXBbIcPwnq0skFAy0/5
        dirgLs60NS8YlfELYM4j18IKnDu3I1mX2idV1eM=
X-Google-Smtp-Source: ABdhPJwOEaXh89+R/H7MBRz5M9c3ZhPc6Z/jeTX/U7qPBoq+FlxU6J4n+Dxg9mzNIkwXfswiN5kgdhWujNpQQLRVsnA=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:ce43:4366:95ca:d6e9])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:122e:: with SMTP id
 p14mr6685928qvv.37.1633025165880; Thu, 30 Sep 2021 11:06:05 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:05:29 -0700
In-Reply-To: <20210930180531.1190642-1-samitolvanen@google.com>
Message-Id: <20210930180531.1190642-14-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4 13/15] x86, cpu: Use LTO for cpu.c with CFI
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow LTO to be used for cpu.c when CONFIG_CFI_CLANG is enabled to avoid
indirect call failures. CFI requires Clang >= 13, which doesn't have the
stack protector inlining bug.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/power/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/power/Makefile b/arch/x86/power/Makefile
index 379777572bc9..a0532851fed7 100644
--- a/arch/x86/power/Makefile
+++ b/arch/x86/power/Makefile
@@ -4,9 +4,11 @@
 # itself be stack-protected
 CFLAGS_cpu.o	:= -fno-stack-protector
 
+ifndef CONFIG_CFI_CLANG
 # Clang may incorrectly inline functions with stack protector enabled into
 # __restore_processor_state(): https://bugs.llvm.org/show_bug.cgi?id=47479
 CFLAGS_REMOVE_cpu.o := $(CC_FLAGS_LTO)
+endif
 
 obj-$(CONFIG_PM_SLEEP)		+= cpu.o
 obj-$(CONFIG_HIBERNATION)	+= hibernate_$(BITS).o hibernate_asm_$(BITS).o hibernate.o
-- 
2.33.0.800.g4c38ced690-goog

