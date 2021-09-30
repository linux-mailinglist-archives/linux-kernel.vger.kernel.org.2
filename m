Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F4441E0A2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 20:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353136AbhI3SIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 14:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353144AbhI3SHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 14:07:48 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAF4C061771
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:06:04 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id c19-20020ac81e93000000b002a71180fd3dso7740494qtm.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6Sx35dcc+ZTMADfJZWhUXml0PH3ooMBccB8Q+X9WArY=;
        b=pk5WOqOatQc/RJ42WoGinJC4/twjfgeWj1OXnhRiKHOSyA+pezAiWCoNBnz9Fj+AjS
         aOIDIpm1iy+TcjZpq5DTIf5dzaYDjtKWxePGXlKJa1s8UPeIkYjw0jRVH3Fo7J0/v0qa
         Y2+1NlkQ7MA9G1a8IAApp1+pO7VRGdMokUvCl+6ZqMyyCl/dV0LjnCsymGj+FNDQdi2n
         3daBKXh9Aoyuacg/VlU0MSjADI1JKmnKQdrM641Bl1X+yQD52QCGprXK4zzCdYcdsyEE
         oGzZH6nn/kGwgiv5PC/yBBtgiJkSbK5MH/dRMdPRgoeoO/0StI8Cr8IDhLNSg1Y1Z3L3
         Bzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6Sx35dcc+ZTMADfJZWhUXml0PH3ooMBccB8Q+X9WArY=;
        b=voyRK42uxCtBcLE2UvBbGRXjD+rZ8Xcs1bMbZK88fGGdBnGvypTvaHtVZHy3kIbeAx
         I3cTYEv+LiDQWkHnQczrTA8rWziCe9JomWRRulzWLR9Lz8O3gcI/CFtzUOpueenF492J
         rIXCzHTbXPyOJRe0WhgYhnssELuVHngDktY1bNB4E7Ws/2jd1/Hq9rOSHDexpemRl6Sk
         Lp2ZH1cAcBwvchDqxXqwxxEZq3mjTnThHNOXibkW/Kg+NXNohnZ5pt7mGOZv01n9Lmvo
         yxB4DSXxcP3sl7tmxsbFN9cWoghPIALWcSJjia9HDxC8oRqUjuJ12R2pwqkXP0Tv0z49
         uoPw==
X-Gm-Message-State: AOAM5322CweZ0i/v4VJnzrKlRva9kBu3YtiFabawgv/nRLf03a3jAaB+
        6qRVG6ikQEvuqA/CE89ViuLPlgxXviS4NQ+m768=
X-Google-Smtp-Source: ABdhPJw0mNH+hlrHNL741Ke8vSbHmQVJvJ7uLoZQ3qKxdZHJuHeykLu/G/qfGGTqGEDZGgeR0jdbNGhA10M2iltx9l4=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:ce43:4366:95ca:d6e9])
 (user=samitolvanen job=sendgmr) by 2002:ad4:408f:: with SMTP id
 l15mr4167941qvp.60.1633025163728; Thu, 30 Sep 2021 11:06:03 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:05:28 -0700
In-Reply-To: <20210930180531.1190642-1-samitolvanen@google.com>
Message-Id: <20210930180531.1190642-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4 12/15] x86, module: Ignore __typeid__ relocations
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

Ignore the __typeid__ relocations generated with CONFIG_CFI_CLANG
when loading modules.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
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
2.33.0.800.g4c38ced690-goog

