Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7249540B7A9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbhINTNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbhINTMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:12:51 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE5FC0617A8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:11:24 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 21-20020a370815000000b003d5a81a4d12so761036qki.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oDPSLYTnc85OD2zK5qomWzi0UW7SiJ+z2icJ5bfjJhg=;
        b=STkzKETErTPVmKYOecbZ+n4Oonaom47bcxfZ7rWtvf/ZTfGe6LuX8Tgj7HLce4Ua6Q
         OG2qeypPkfiD36/SOcQQU5jqXt7GbomkUkqhF21K0fRwu1UcWqPz87jeWFIYZHKiUs6s
         lhq9iBx72aPi+GzoDPhA7tzAqDBAcwpDPMb14VC3cw4jkrAa8dPCDGLFA6KNjQiC4P4D
         sVtmhtfEuhPRnUqhARrspLkXJFou/URwuQji3PPRL3blBy8Jz18yqncGgNw7hAo/d6ZT
         GLtxUETDxeY5XCdJjaycV4qNLXfH7LdVrNo2TskUGPaw9C0G7pOTcqc1L/W3OHjqcW5u
         fP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oDPSLYTnc85OD2zK5qomWzi0UW7SiJ+z2icJ5bfjJhg=;
        b=cQnak1dij1ifdQZOriAD/tFZLip7fgTENbgsvE56x7vNApaiboFBDn1uKBkPFciUd9
         HPYjGghvfWid0OWPUIAA2rOul29fFku4ym8FRMI+II/9jHoJc0wc2HugBzJ9O6IsQzGd
         ORF/bGid0ygaBS5quLSDwifohoWTZP7Beg5ky0/CYKCbOc4cRuretIet0uFhhBBPit9o
         1xsHbMY8C20q2YdQWxpITLdrWH1dk0Pdij9G8jhhZx5RHczW6bwLu+4vnfItEPPWF6Sj
         0OmsvwvbxIsbLEJo9PygimpoTCD9az2sAlTOj3VKZ8ByC0xvj9e6hNo4V5a00io+H6yG
         2/Kg==
X-Gm-Message-State: AOAM531+0Lj6WHQyLGbqxESIm1RsdZcvhWocOTNyUh801l6dTjBjcHUo
        Km/UAl5tcbz1+pw5MNKr8oKnoLktG3carnTK4HY=
X-Google-Smtp-Source: ABdhPJxarD0Ys4etjeElxC7U2gHSsLCklNH/KUwhFdTxUDEpAFrBh7xOVz9ivuKAD790VfhUR5IxHgpQGQ12LOPUGeU=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:d19c:5902:49bb:c41])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:40d:: with SMTP id
 z13mr5046584qvx.38.1631646683964; Tue, 14 Sep 2021 12:11:23 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:10:44 -0700
In-Reply-To: <20210914191045.2234020-1-samitolvanen@google.com>
Message-Id: <20210914191045.2234020-16-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v3 15/16] x86, kprobes: Fix optprobe_template_func type mismatch
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
2.33.0.309.g3052b89438-goog

