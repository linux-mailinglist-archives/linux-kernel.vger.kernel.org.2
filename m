Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78CBC3B67FA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 19:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbhF1R5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 13:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbhF1R5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 13:57:08 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BD5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 10:54:42 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id r16so26872266ljk.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 10:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1JGL45JVnWIjVsGv/XsgCsmYr6pic/ZedIcGZwFZj2c=;
        b=LS2y1K539DTLpk3/PHIdif03qlez/eloIAOdH84d/z4Do1daVYAzgNjoBVbp/slxXT
         GfFV4HnbW+l7iHAX+YbILJlxpRr3a9HGxEVBCcmxxkIM5ugPUcvFaQZFN/teHeA9zHDR
         WOcvCeCCxn8IcAu6Re/qpW3L7p7AsQ7neh6ayB7iBttVVDZpCTjLQEA82SmWgCt1HBxp
         N3JeK58AwHgmStnjvO7p2fXGV8xvXkwwhCDOpG90tECudm30cea8iCUWwBfVyNzhoM1j
         RVLUbmwolZKG6qYDI8b5Cl57Uo61M5N3Ci30TGC19MYLW+WxqnkFOAziXO+9K/m2cMq3
         CfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1JGL45JVnWIjVsGv/XsgCsmYr6pic/ZedIcGZwFZj2c=;
        b=FiFCju4SEHjDfBaY66dS1jGEx3gGeP5u+L2L/buwV4hrUxZ64KkxN8HN4hiWfdaAAZ
         Xt3PwUjo3cM9+eddaY+DWQWKcMvGVqR3wW8RiBdNJRiDHPDQ/DR2mKv9R63LrZlTGWLR
         iYGIKDYJ0vknkolv+yM53U4vkTeMC1rkx4cGK8IIkLeg9gE9zuOAMkpRH8u9NvyZCcz8
         tYlzykA3JLum8a1hwyYFK7+Cydo/fgNGIiapcYs1CjKRqjeRH+thz7rtM1YfbvUnsN3c
         kNTEwXu0kCkHnXXIQpFkbwU+aRmh0LK2agvjRoGf0GIHVhtoWUqjdCBawREAzqNn26UJ
         4LmQ==
X-Gm-Message-State: AOAM530ofevtdcCkV1EAnLhfa44s/B5gnWEhXee7aygYm1cGW8FiSm4G
        M7hSu0x7ykxjvXBh5LHukTRqJSuv290FmHXoPST5Zw==
X-Google-Smtp-Source: ABdhPJz7nl8khY0H0xmxyJYwYeJhRYCooPStEH7MgwGUFhrS3RMNGX23ctkcZHyrn5WcdhMc6dFXxkVnIHa3YxzDzBM=
X-Received: by 2002:a2e:b5b5:: with SMTP id f21mr440155ljn.479.1624902880473;
 Mon, 28 Jun 2021 10:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210622183858.2962637-1-ndesaulniers@google.com> <20210622201822.ayavok3d2fw3u2pl@google.com>
In-Reply-To: <20210622201822.ayavok3d2fw3u2pl@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 28 Jun 2021 10:54:24 -0700
Message-ID: <CAKwvOdki=HZh4TYwqwDSo4BWtbGHp6pM_2akA+D3K8JO+dMGoQ@mail.gmail.com>
Subject: Re: [PATCH] kallsyms: strip LTO suffixes from static functions
To:     Fangrui Song <maskray@google.com>
Cc:     Kees Cook <keescook@chromium.org>, "KE . LI" <like1@oppo.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Miroslav Benes <mbenes@suse.cz>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 1:18 PM Fangrui Song <maskray@google.com> wrote:
>
> On 2021-06-22, 'Nick Desaulniers' via Clang Built Linux wrote:
> >Similar to:
> >commit 8b8e6b5d3b01 ("kallsyms: strip ThinLTO hashes from static
> >functions")
> >
> >It's very common for compilers to modify the symbol name for static
> >functions as part of optimizing transformations. That makes hooking
> >static functions (that weren't inlined or DCE'd) with kprobes difficult.
> >
> >Full LTO uses a different mangling scheme than thin LTO; full LTO
> >imports all code into effectively one big translation unit. It must
> >rename static functions to prevent collisions. Strip off these suffixes
> >so that we can continue to hook such static functions.
>
> See below. The message needs a change.
>
> I can comment on the LTO side thing, but a maintainer needs to check
> about the kernel side logic.
>
> Reviewed-by: Fangrui Song <maskray@google.com>
>
> >Reported-by: KE.LI(Lieke) <like1@oppo.com>
> >Tested-by: KE.LI(Lieke) <like1@oppo.com>
> >Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >---
> > kernel/kallsyms.c | 18 ++++++++++++++++++
> > 1 file changed, 18 insertions(+)
> >
> >diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> >index 4067564ec59f..14cf3a6474de 100644
> >--- a/kernel/kallsyms.c
> >+++ b/kernel/kallsyms.c
> >@@ -188,6 +188,24 @@ static inline bool cleanup_symbol_name(char *s)
> >
> >       return res != NULL;
> > }
> >+#elif defined(CONFIG_LTO_CLANG_FULL)
> >+/*
> >+ * LLVM mangles static functions for full LTO so that two static functions with
> >+ * the same identifier do not collide when all code is combined into one
> >+ * module. The scheme used converts references to foo into
> >+ * foo.llvm.974640843467629774, for example. This can break hooking of static
> >+ * functions with kprobes.
> >+ */
>
> The comment should say ThinLTO instead.
>
> The .llvm.123 suffix is for global scope promotion for local linkage
> symbols. The scheme is ThinLTO specific. This ensures that a local

Oh, boy. Indeed.  I had identified the mangling coming from
getGlobalNameForLocal(), but looking at the call chain now I see:

FunctionImportGlobalProcessing::processGlobalForThinLTO()
-> FunctionImportGlobalProcessing::getPromotedName()
  -> ModuleSummaryIndex::getGlobalNameForLocal()

I'm not sure then how I figured it was specific to full LTO.

Android recently switched from thin LTO to full LTO, which is what I
assumed was the cause of the bug report. Rereading our internal bug
report, it was tested against a prior version that did the symbol
truncation for thinLTO. I then assumed this was full LTO specific for
whatever reason, and modified the patch to only apply to full LTO.  I
see via the above call chain that this patch is not correct.  Let me
send my original patch as a v2. b/189560201 if you're interested.

> linkage symbol, when imported into multiple translation units, then
> compiled into different object files, during linking, the copies can be
> deduplicated. This matters for code size and for correctness when the
> function address is taken.
>
> Regular LTO (sometimes called full LTO) uses the regular name.\d+
> scheme.
>
> >+static inline bool cleanup_symbol_name(char *s)
> >+{
> >+      char *res;
> >+
> >+      res = strstr(s, ".llvm.");
> >+      if (res)
> >+              *res = '\0';
> >+
> >+      return res != NULL;
> >+}
> > #else
> > static inline bool cleanup_symbol_name(char *s) { return false; }
> > #endif
> >--
> >2.32.0.288.g62a8d224e6-goog
>
> I wonder whether it makes sense to strip all `.something` suffixes.
> For example, the recent -funique-internal-linkage-name (which can
> improve sample profile accuracy) uses the `.__uniq.1234` scheme.
>
> Function specialization/clones can create arbitrary `.123` suffixes.

I definitely don't see hooking static functions via kprobes as being
scalable. There are numerous different mangling schemes different
compilers apply to different static functions.

--
Thanks,
~Nick Desaulniers
