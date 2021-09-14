Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDCC40B7A4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbhINTNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbhINTMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:12:47 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446CBC061787
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:11:16 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id f14-20020a056214076e00b003773e95910bso826511qvz.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7FmmYO5sGsSDFsyzZhjTcgNpdgmOw3lheV9G3g3oFsc=;
        b=rMhm0pmeUWwGdlL6RQI4oCzPbj72ZIyNG2snpZQFgvnNpiOph4JIFCy5L8QrzZXOyI
         q82RrO5j4Aog+dJS+8W1D7C2YlpHKrVJicS7BBenAZgxf54ru8fmBZE6Jow60Evl2J8s
         HoBI6nq7SWbZiyoHkntfm3U2t+cy7Ra+7xN5/KK5kRw9N2Wi/tu4iwiJoXzte0rLAUv7
         Rsaw42LQ9OkgZBQ4IzxAef7a3m1Rv2C7ch5YRWQVaLa1H2erOICbIeDQ9qdn+A6YFHqL
         Au2QqhfpQDoLzFElxt7oSynkueeLrJyOwI6uBx+Eu6/RCfaQMQ8WoSRumwWUN23MUOCC
         YR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7FmmYO5sGsSDFsyzZhjTcgNpdgmOw3lheV9G3g3oFsc=;
        b=jcrahpDqN2CeZPmW8A5d0KCHdYU+tW1ds+/Vdmmlt6keRuoLNfWqQ7VyXsn0HvbeGh
         aCA/9oXAxpnLDgsBU3Bzy8XfCxGMcRprQ5ZpqYt7dE7kPSE7pKb9F0qqFQcE61ZM9YEa
         ccOZo1MVCrJfLjSVaJoBfaxPfG9g+QhT6RNDqFhUWKbyuWaND16A1PWLXDMjQCB3lez1
         4QH7EGxK+WKMzJ6ZyuJtjPoPvdx39QimYSN0wrMEbp0yUxnJuCoeMqk8ZMLGJpf363tF
         4bPEWBHFxWp+dRs/pQwzp0xzbCdFqzZD6E+DHQkJC8LLwhK3OepSEmFQy4EY2ftGWtim
         LiNw==
X-Gm-Message-State: AOAM533hzfx5/iAXlWPF/9G+oX6bwcOy0ltLlc8yqD3c0O0dHMNhgslf
        FdaYKSl2xfXc+MCO+TFAhzo6bxqYzdUOjHOw0Yg=
X-Google-Smtp-Source: ABdhPJzTueWCiZ7bZVTid9Rvg78H2wdCUDBIlSsSwH0OvpItrzOqHNy0pz/wDgP/UqDD80MjsGh6X7BY53KlZIsNFUg=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:d19c:5902:49bb:c41])
 (user=samitolvanen job=sendgmr) by 2002:ad4:5492:: with SMTP id
 q18mr7305979qvy.17.1631646675993; Tue, 14 Sep 2021 12:11:15 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:10:41 -0700
In-Reply-To: <20210914191045.2234020-1-samitolvanen@google.com>
Message-Id: <20210914191045.2234020-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v3 12/16] x86, relocs: Ignore __typeid__ relocations
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

From: Kees Cook <keescook@chromium.org>

The __typeid__* symbols aren't actually relocations, so they can be
ignored during relocation generation.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/tools/relocs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 27c82207d387..5304a6037924 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -51,6 +51,7 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 	"^(xen_irq_disable_direct_reloc$|"
 	"xen_save_fl_direct_reloc$|"
 	"VDSO|"
+	"__typeid__|"
 	"__crc_)",
 
 /*
@@ -811,6 +812,12 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 			    symname);
 		break;
 
+	case R_X86_64_8:
+		if (!shn_abs || !is_reloc(S_ABS, symname))
+			die("Non-whitelisted %s relocation: %s\n",
+				rel_type(r_type), symname);
+		break;
+
 	case R_X86_64_32:
 	case R_X86_64_32S:
 	case R_X86_64_64:
-- 
2.33.0.309.g3052b89438-goog

