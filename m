Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283583F7E37
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 00:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhHYWMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 18:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhHYWMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 18:12:30 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7DFC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:11:44 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id w4so1212870ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FcPemo/39ZZqVRJxyNaewA0Ko8RERS20Yvi6i29tDYQ=;
        b=gwHTQzwdCU3t/wtAvSYJjtL8er9zKgGS7fe2BFzG8nb2mJUIxmfzPMun5rNDPcO8gn
         WJ31Ywut5BEbYSO1XBuYn9mOUYmnQV2OAlDulzdcZLPTL60uP4FJF5wb7HfhXHzoopZC
         Nk//kVq4UHOCBURQLvXowN5/nhGg0SowX9X8pJ+0tYX8U+ND7ICI9K2MLFm+e73PznKU
         3uJRa29omcHWJ0cnE9TWOp3TZQIaORfwmeFSUJIco4KGeqeG+U9A+XsPu+kv9AOIEELB
         6DgDcvBKNtVfb/vPMzeDhxTf5Rhk1hoU60oMdPOhsnEMUVjN4qFQPDxngT68zvs3xbsM
         FTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FcPemo/39ZZqVRJxyNaewA0Ko8RERS20Yvi6i29tDYQ=;
        b=dAMikIkibOOtB0MDyVUzaxDeWwEun8LLfsrphp4YmmurexbjOZ8Hg/oRnkdnC0NFK4
         rfcsfs7quXyJDfx9RDAPjhFByd8qwXvcF0qw5y3CAOW4DNxPHgAlM74/aqIQcsi9vmJo
         ZY1ESjTf0ypxcVdWHGcONO+FjCurtWz9oeTCSUm0/lz7fid6bsim3HqfiUg1FSrGz3Z9
         YcQrYnL6jwN+31ZtDr4jXJaDiRf9DMAcAmIwlyP1QFDWL2jplZl38xYnu1+Npf+BQqWY
         0ZNTGnhaFidbjfh00OoF2CwKYd8XgZ7DiV1tNxVxdrbSoFo8pZnew58T45kXI9YzG0x0
         0+7A==
X-Gm-Message-State: AOAM530P4X9kkau+xu+ELn/+qX6s+3caEK56zGotN02fHI/n20L93Tl/
        eFm5rS4sV2iu72b4ZWVAfaRstZuz7rAwuJxF9z3T5w==
X-Google-Smtp-Source: ABdhPJx3mYgy1OtiE1R6osp0s4OIsm2Y91PX716mJJoiBqC2sS9drhxn8MDm9ioqgKMGu4NvsJMsP4uHFxWwTuA5eTk=
X-Received: by 2002:a2e:9ec1:: with SMTP id h1mr380854ljk.0.1629929502234;
 Wed, 25 Aug 2021 15:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210825211823.6406-1-nathan@kernel.org> <20210825211823.6406-3-nathan@kernel.org>
In-Reply-To: <20210825211823.6406-3-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 25 Aug 2021 15:11:31 -0700
Message-ID: <CAKwvOdmpSh+fa-WfL4sijQXabJ32K_XvDii9Nu-JaT12Fce1kg@mail.gmail.com>
Subject: Re: [PATCH 3/3] Documentation/llvm: Update IRC location
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 2:18 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> This should have been done with commit 91ed3ed0f798 ("MAINTAINERS:
> update ClangBuiltLinux IRC chat") but I did not realize it was in two
> separate spots.

Ah, sorry, I missed it, too.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  Documentation/kbuild/llvm.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/kbuild/llvm.rst b/Documentation/kbuild/llvm.rst
> index 06b8f826e1a3..683f8b7cca0b 100644
> --- a/Documentation/kbuild/llvm.rst
> +++ b/Documentation/kbuild/llvm.rst
> @@ -114,7 +114,7 @@ Getting Help
>  - `Mailing List <https://lore.kernel.org/llvm/>`_: <llvm@lists.linux.dev>
>  - `Old Mailing List Archives <https://groups.google.com/g/clang-built-linux>`_
>  - `Issue Tracker <https://github.com/ClangBuiltLinux/linux/issues>`_
> -- IRC: #clangbuiltlinux on chat.freenode.net
> +- IRC: #clangbuiltlinux on irc.libera.chat
>  - `Telegram <https://t.me/ClangBuiltLinux>`_: @ClangBuiltLinux
>  - `Wiki <https://github.com/ClangBuiltLinux/linux/wiki>`_
>  - `Beginner Bugs <https://github.com/ClangBuiltLinux/linux/issues?q=is%3Aopen+is%3Aissue+label%3A%22good+first+issue%22>`_
> --
> 2.33.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20210825211823.6406-3-nathan%40kernel.org.



-- 
Thanks,
~Nick Desaulniers
