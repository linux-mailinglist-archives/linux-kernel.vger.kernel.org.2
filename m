Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE9942C883
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 20:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238791AbhJMST5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 14:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238776AbhJMSTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 14:19:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09372C06176C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:17:35 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i83-20020a256d56000000b005b706d1417bso4089495ybc.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4Xp81G5gu+GVQC6nDFOKXKxKiHI1/VWta4gwSbjLNy8=;
        b=lYVdwZp+WUP+p7kjwZi3YG+l5DntTZRPJ2u0QYLrbQeGMwJlDILX5sMscVRVcyQgRU
         QYIaGEJbDrdrkCXHSB8QLScHi4LISaBgJL5rMHiErMgk7JionKq5V4Pi2b8AMAe44uYY
         mSg+wC4qohxA1DzHfnar9vyp4IgGq04qZcHWN/bAetbs12V84OWeid44X0WUluDqUTOQ
         hG4Xb7v6FhLfCRzLwYvk+tx/AO8gW1QTDSxonUXNcfUqTN4HfsjH6H9dKSu4dg0EOtmn
         LZRroCmn0D5yg5XtUmXUFTCiDPXuUCski7zrptT3RyoHk3HcBNIaXdAzd0V8ibCWDrm/
         fR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4Xp81G5gu+GVQC6nDFOKXKxKiHI1/VWta4gwSbjLNy8=;
        b=pIPAyTXFNIKbEODWdu9j6KdEGRHdI9lc+8mPJ1PJTtwrTRJWKveJEGdInTSNC/Gw0O
         iM8iLG87qM0MIDR4192BLgtA11C47i5if8VApyqWLZLiGorQT0K0hI+k3uatCht77XPe
         kQPC+4Uy8CIGQgrDlTaOYMqBy4qqWgnpyCEFLI9voSRtE4ylJWHZHpScUlP+pELpCUXW
         XCGD3EfvmFg7Cygo7q6Plxrvok6+ghhYPN6sAsIRkwCwip8Vk0vRGRyMNfWPpJ6+KprP
         1cUrR3lBp/tjWemR0V1pq4gzTSaNWeSf0IRD2rifslbsWOjWs+/3vTVcMcZi5Ubqo4Lu
         Po8A==
X-Gm-Message-State: AOAM531nBvpNu9Ptf6pFnaXsx5DZWYfWqFJK2gLeSSnqQp++0ZgN6MLM
        N0+LtINm62Sfvt7aR7+gGjc73EdlFQhAz9lSgkA=
X-Google-Smtp-Source: ABdhPJwfOX+06p6IWXOO2fyionbsLW/uPZ3rJH/DQZhYPquzPNHFEqW+3Af1FidHpvBclmfhJoQleHN40gKpi9FbUng=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:9ea6:6c27:1876:926c])
 (user=samitolvanen job=sendgmr) by 2002:a25:a089:: with SMTP id
 y9mr998734ybh.474.1634149054240; Wed, 13 Oct 2021 11:17:34 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:16:57 -0700
In-Reply-To: <20211013181658.1020262-1-samitolvanen@google.com>
Message-Id: <20211013181658.1020262-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20211013181658.1020262-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1741; h=from:subject;
 bh=/pDfN4tCkwWT5Z/C8RPpxpsDI4YiDV/Z436g/w8+UyE=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBhZyKaMymlHFFQPJvWCB2V+lErjUmlnn1iBJYCBoQa
 oblgBRuJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYWcimgAKCRBMtfaEi7xW7oHdC/
 9MrKLp0CtcToPDhWw+aY9NAsfBzIC0bTwAuCDUIVvP7ya3YdaC7ArJtJrTIcuEhoJkbvyRQhYf9sLF
 NHIbeEs63iMVP9eo1hyZJh2n21vIyVLr2hZCTKMaKDnvwCoXHJmka/ZWnlCp2dcZwb7SXNI/C+2Jn9
 uoxMqqBFkg0dDrin1EDCfxsbOjjyVsLdp4rV0Rj3ByH21+bBM4dukk+HJHSUfWcfgys75A3Wj1nFEV
 JI5kRiSelHD1OMpVUKEFNW1O+ld4UAmE6SCbVk1y1O6U/6csLeiTG0TYwQeqUHzctwWfidE65Xm4wI
 FhK+23zt5GFpmpejHlIzC5qYAY2lSdt9Mo2qVwy4H4R6EWK6tbmz+YHXRhKl2NUXOd/zIdmtOsoM1b
 /+TtR3EQUUJlN8X5iUkXFUSjI12eL0eU0A7YPnf7PQo8wvDOflbPQcQPYbuPDkpYOzJqRwqKeJBQUG
 erZ7/C4jOv53BDYZySy5jJl2vQY9PUGwog7UhwV29fpWM=
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v5 14/15] x86, kprobes: Fix optprobe_template_func type mismatch
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>
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
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
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
2.33.0.1079.g6e70778dc9-goog

