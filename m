Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686F83F4F25
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhHWRO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbhHWROf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:14:35 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE74C06129E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:13:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u1-20020a25ab01000000b0059949024617so4126413ybi.17
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+NWMVXrt3P4ge7VqYOvLEIp/M9aVwCe7Nh6ObW2ZBPc=;
        b=hFjJ1e+C1MlypS/buKfzRCFkG/9cMbUhkjqvF3HOWHEYkoz3N7NX8cJhjHTYQ/qtyp
         2tLkviVOtycQi/lT7Bqo3OcvF5r543o3HOh072GAdPadwN2fE/+AWc/LXwi7Khc8Iprd
         SbS56lYw5x7Hx6jf25yadN2fNtqR7HBEz8pcM0/wLAUYbWWpj3reFt5V+3jvDDmjFjFl
         DJ7h/D42e9VHIF14u2DZy+GdSTQ1NQJA0y9trOu84QKzNpJ294yMoilqnBZr1mHcW75V
         nIygPAcoCxwLFE0WK24aLTNS7BBsZvO+WEqh6pxAazj/ovklE/EFg5oIl7Z+edLMSGWr
         oWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+NWMVXrt3P4ge7VqYOvLEIp/M9aVwCe7Nh6ObW2ZBPc=;
        b=WHlSCVPp945LXQKs0CQ6AryZ08SNNW+jQoK7pGOt1UYG7gmmmgkn7c3wNfZ1M0mc0R
         xp+CQ2xAmA1QXjIGqxROsXRmTgPHwmYnHmf0AmHPVOqWjH1X+bDCw05jbrwitFNiekW6
         N+r7yEW+Qn+ICEzGmXRlbhgzBvg0Z4akaQnSUMc0VWmhBJS/vZqP8gKn2/+PweD89RU/
         +r5OagpsYiXcNm8cSqSq+uQYqMInxtY6oawliJml9FcarrORyqraYF2hCi2YuG284dtf
         S0P0AOb473TB2mnUOWaUDpFww6DjQspvnLJAsfCX31dQMyx5aF6NbZrtnE613qTQDXtS
         27Lw==
X-Gm-Message-State: AOAM533UcPGQC3WN5J9SA8rAK+bhp7Ck8RG8kibfhBHtdyTyH/GFRCzk
        5a8Umk7V64ymI0vGYO4WiiI1tiVol1Dhyd8zq0A=
X-Google-Smtp-Source: ABdhPJxClc9bFSSM1trVCieFK4BS23aESsI41IIN3LRY5ta0ot4fK5RLjCtUzOgKw0Vkr1NLBaaYQnrZtNnFvxI7zRA=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:cc48:aa6a:f4ec:7d19])
 (user=samitolvanen job=sendgmr) by 2002:a25:c60f:: with SMTP id
 k15mr26774743ybf.200.1629738832122; Mon, 23 Aug 2021 10:13:52 -0700 (PDT)
Date:   Mon, 23 Aug 2021 10:13:17 -0700
In-Reply-To: <20210823171318.2801096-1-samitolvanen@google.com>
Message-Id: <20210823171318.2801096-14-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210823171318.2801096-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v2 13/14] x86, kprobes: Fix optprobe_template_func type mismatch
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The optprobe_template_func symbol is defined in inline assembly,
but it's not marked global, which conflicts with the C declaration
needed for STACK_FRAME_NON_STANDARD and confuses the compiler when
CONFIG_CFI_CLANG is enabled.

Marking the symbol global would make the compiler happy, but as the
compiler also generates a CFI jump table entry for all address-taken
functions, the jump table ends up containing a jump to the .rodata
section where optprobe_template_func resides, which results in an
objtool warning.

Use ASM_STACK_FRAME_NON_STANDARD instead to avoid both issues.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/kernel/kprobes/opt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 71425ebba98a..95375ef5deee 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -103,6 +103,7 @@ static void synthesize_set_arg1(kprobe_opcode_t *addr, unsigned long val)
 asm (
 			".pushsection .rodata\n"
 			"optprobe_template_func:\n"
+			ASM_STACK_FRAME_NON_STANDARD(optprobe_template_func)
 			".global optprobe_template_entry\n"
 			"optprobe_template_entry:\n"
 #ifdef CONFIG_X86_64
@@ -154,9 +155,6 @@ asm (
 			"optprobe_template_end:\n"
 			".popsection\n");
 
-void optprobe_template_func(void);
-STACK_FRAME_NON_STANDARD(optprobe_template_func);
-
 #define TMPL_CLAC_IDX \
 	((long)optprobe_template_clac - (long)optprobe_template_entry)
 #define TMPL_MOVE_IDX \
-- 
2.33.0.rc2.250.ged5fa647cd-goog

