Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A65391EC5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 20:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbhEZSOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 14:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbhEZSOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 14:14:38 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CC7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 11:13:06 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id w1so3357522ybt.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 11:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AJRgrV/KJZf7Av1Ux4awu6D8rhGGLmpRYzc2gHJYb5k=;
        b=Rita3KRraMMJefSQSpHQqg4Hyonwa9oLZQbWWQf6KznsO6NpYMqNs9kMfREvKyohYn
         sj+0yQhdGG4Nc45xO/v6rCEI+RriEeTebpg8tCfx9ENyUX4u21W0hg91oWJL8oM/Kow6
         ZycSoOe4hN2TvV0lKUjOXGijbH6llIDW1K7HxgRdrnan55b2sTEtyJUIn97vA2+C8oOy
         dKEwjlYyFFM5u6quHokbrSTmnTcUBJYpewUwpKwuZyBdWdABOwtpG9ysGzSzfkkkzqYT
         1Re2KCAkBZ6/miB7bdmRswZR8w/cndVIpUuGWQa7f7l3uTSltMDnr8tvesYCEFe6fh1K
         aT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AJRgrV/KJZf7Av1Ux4awu6D8rhGGLmpRYzc2gHJYb5k=;
        b=ZNpj4+g0FbiWdQmcIqYozoeILqUWA/XkODz+0z2QoPQi+Ii1n3rjCDIja/67GiMMRA
         RjFfohLc1Ih8kXJ1IVL3fpwg6V9uaObDfG6D96Hr9MtEKgCPq/jWMrAxjKpyiuEDaOD1
         7UxujmmSUsqInz+7H2qiGIZP/utVmuRT30BgRJ6koy3IS1VMllXhG9yuvzew6iwhFKtn
         ym2Is9hyd4GI0G+/8PcicbkgVkitmnpya5jBU74xQDIwwyl2aYIGTSLSHaXC6LoAJcmd
         sfUCJa4i31sR0xpv/26Qm3jhYFyPNV0B7iX1aGv9uZtj51mZ6W+U/OiAapJ+9aTsBWoR
         mlkg==
X-Gm-Message-State: AOAM530itVeEairJtXZF/C+XGbDZevtVwY+bcW+wc2ggbQWwMKnp5rr/
        +c160aWn1QXuZKf2lSlNbW/0bXKAMPYDJUwnJc0=
X-Google-Smtp-Source: ABdhPJzMBZmfpH/hi9D9tLbnZ8qTIZkUvAQ/Kt+cy8fJ3fPH1OsYH5DG59J8c6w0kxBwv6TqQ6IZ2cxl+czue0XaCSc=
X-Received: by 2002:a25:9112:: with SMTP id v18mr19094203ybl.26.1622052785437;
 Wed, 26 May 2021 11:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210525175819.699786-1-elver@google.com> <CANiq72krX9PU14wFsQyW_CJEjTS-TT8wyhBVZZbC132Gz5XO-Q@mail.gmail.com>
 <CANpmjNPGUAv-d3yEusyF11ip0zEdht7eMGi4pSoQsRYns-MvJA@mail.gmail.com>
 <CANiq72kCkej_ONwSWjRHWLVrr+g0BZygAUAQVx+FQf7DEdg3cQ@mail.gmail.com>
 <CANpmjNM_fP-ziy204=1rd52hOO4WfCsxAwQgJ-t1WF_yFo=UzA@mail.gmail.com> <CANpmjNOkX5NFFekezDSntjVBp2mVgxTprjV1QK56DsE2fv-w3A@mail.gmail.com>
In-Reply-To: <CANpmjNOkX5NFFekezDSntjVBp2mVgxTprjV1QK56DsE2fv-w3A@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 26 May 2021 20:12:54 +0200
Message-ID: <CANiq72n8OT7mw0comw+mJtr_+Zzz+kv8Pd_eR0H6Ccqrd3T+ew@mail.gmail.com>
Subject: Re: [PATCH] kcov: add __no_sanitize_coverage to fix noinstr for all architectures
To:     Marco Elver <elver@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 2:38 PM Marco Elver <elver@google.com> wrote:
>
> Ok, let's wait for response to: https://reviews.llvm.org/D103159
> If that lands in the LLVM repo I'll change to use
> __has_feature(coverage_sanitizer), and send a v2. That __has_feature()
> is a bit of a lie though, because fsanitize-coverage has long been
> supported, but it just so happens that if we get it, then its
> availability implies availability of the no_sanitize("coverage")
> attribute.

Thanks a lot for that! Appreciated :)

Cheers,
Miguel
