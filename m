Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DF442C881
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 20:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238961AbhJMSTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 14:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238623AbhJMSTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 14:19:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBF6C061760
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:17:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b126-20020a251b84000000b005bd8aca71a2so4115691ybb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FUM1v4YB6XOXHq0iVVCQLmH4e/+1fH3L4oj9Aiz71+c=;
        b=cJ1RW4v4aCr+KHTpjNE9nFrgs4HfHet0ukJeIU7uGGP5p9ejwQrOEsliCMYF9FKBIs
         RciOUaBAZ9CtvoGSa2YuBuvl0bfAbmM0uLrYQVCivLHH1SzaoWyVsNGXEIiHk6hkogY1
         nXctVqDcoegt4qKvEegPTWrk28NhZ+lq2OskyVVPMK/ftAMV5VwkzrbIWFt+iQjEgyTe
         WvbZO+asrN6dpO49mQaalvWHsCWOmuTkYbcTbDmKaPlOltFN5SSfkIeQFrZDe5MazJc8
         32dULY5NTK5IykULt4XohX/ptg+q+LZ+8IRtXytJLex7ZVaGGinB9W6CbsD9sANzVpwN
         NOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FUM1v4YB6XOXHq0iVVCQLmH4e/+1fH3L4oj9Aiz71+c=;
        b=j7Nd+exe8Amep5dQx4L4q2bNo4vmiVv2al3N4KtOPhZXgfd4OG0LulxlD8PEllX4rG
         m5hyypliBz3ViqMyrwpedPRwfmoJHPOuvGYJmAkPLuNUMkb6XOS2gmJTcYLnuH2vnaap
         qY1Pv16l3an3tTnsQA+ZOZBgPoXaGTwaJX40LmmxBju/k8Y4mzAyj9MgsRbWkKdcL+Ey
         HqQDX3/XhxTJZnkO7vW99kDnWuzsWrCo2HG+f9Gfh6vIptZIsC+wzVp5t8dXTmSt7XmW
         kJ0zGNev1EbKRRsUQIsjCyv8ADW78wUH0//WMaqs+jA9Uc23+IwyuE3aqF4FAyH8oLgX
         LKJg==
X-Gm-Message-State: AOAM531ERVO260qvfNe+AJR1sYhqL540428ClDNUPAWcm92ObHGlAQt0
        iUnYAIIyq6Ho+Wq4E0eUPiQXJfhTW2cEbtd2wVE=
X-Google-Smtp-Source: ABdhPJzEaDja0J/kqrarjfqGPyMXP2WPI/KPS/LGkqwt9jFxz8/AAqr2O4bu1tJnuUjHgs+PlSzdMs9xiMmwlcVbC4Q=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:9ea6:6c27:1876:926c])
 (user=samitolvanen job=sendgmr) by 2002:a25:5044:: with SMTP id
 e65mr914919ybb.57.1634149049705; Wed, 13 Oct 2021 11:17:29 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:16:55 -0700
In-Reply-To: <20211013181658.1020262-1-samitolvanen@google.com>
Message-Id: <20211013181658.1020262-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20211013181658.1020262-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=979; h=from:subject;
 bh=dUwvm3Vd/5iEIjZYz+BmaUIzxp/ot2yfAHfQNEA+kUM=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBhZyKaIwdgCVuE1IB6wwvqmWNbh+vVqAlev/QJV73m
 c6jvmMGJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYWcimgAKCRBMtfaEi7xW7msKC/
 9Bl6p6NCMyrV45qX2+L/0+XGMXCRfdOX68muhe1EoKDv1+fByHvxCtLgerfyCudZ7URTfLBME/ZnTD
 zl6u0n+N8gANWaDZleltiMEz1hQHPk0VlMZA+dmD+e8q9NFj8yTOX+gdEcDw0UiNmw8CNL6HUUSyG5
 b2gREsgfpxcD1AELTfurUXi96HkTeXXvl/eyWXucGMh87gHRkDMOkAz9QN823Gg6kfR0wGjDckyss8
 dXQrVqJ6XJuwRgr26EXZbLQBe7HJWHq+gXME4PqET7xqp02joqE0j96xPZq6wVHJxQDsHEMRF8RBBz
 /HQ0r3SEHdSxYW51OoKzO19aswKqAb2Pz9op1ZdSY+u/PFOTIK1fYcMtHT+EQoI6GIuZ9Q1ZK76KTc
 rebN6zRrpGYSyU0vcA8+SSkVOZBD3K33QrHj1tGQUhaHAuO4Y+YS8rwQuXyrXKTaq2uUCasy/JeuVM
 htEWYPcnOHQ00htlg7Rfdn9f4tQ1OQiJOevLNaVwDokLA=
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v5 12/15] x86, module: Ignore __typeid__ relocations
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

The R_X86_64_8 __typeid__* relocations are for constants the compiler
generates for indirect call type checking with CONFIG_CFI_CLANG. Ignore
them when loading modules.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 arch/x86/kernel/module.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 5e9a34b5bd74..c4aeba237eef 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -197,6 +197,10 @@ static int __apply_relocate_add(Elf64_Shdr *sechdrs,
 			val -= (u64)loc;
 			write(loc, &val, 8);
 			break;
+		case R_X86_64_8:
+			if (!strncmp(strtab + sym->st_name, "__typeid__", 10))
+				break;
+			fallthrough;
 		default:
 			pr_err("%s: Unknown rela relocation: %llu\n",
 			       me->name, ELF64_R_TYPE(rel[i].r_info));
-- 
2.33.0.1079.g6e70778dc9-goog

