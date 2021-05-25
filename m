Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2BC3908EB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 20:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbhEYS1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 14:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhEYS1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 14:27:04 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F6FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 11:25:32 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id l16so11508870ybf.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 11:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wmXyVt2O2sGPnr4vp3ZrMLgj9f8S3qWYOqMb7Ajrf5g=;
        b=iwPy5Y2KNaEF7h8ZCXprzNri3iwBIRhJjp2Nelx7OzcAhJQCkYWQJh6kLRjC7SdK3R
         2ztJH7bAxZtxKyQJgwu1CmzEOcozMh69pCPjbfbGkkOHvIbmf4tYIb12k+U6KhmL9xLk
         5P9NJpfZrW7ZXfS5OKnxp7oVepedpGsUQe6g3yrxsGAi6BEmjqcTxlp+jmEdBjr4+eIk
         ae3ImH11jjlKpxuOKgfezJD9buxht0Yo2Ccpt6hbdI6+eGrXg1Odwueh+NgiU7dMIaO/
         nA2p1osnCZifxK8JZ3+m6giblaOhkNWw9/+cO+i+xrlAWonQLpEjd5ItA2gXy5JEvOkT
         7DRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wmXyVt2O2sGPnr4vp3ZrMLgj9f8S3qWYOqMb7Ajrf5g=;
        b=eWOfnz8ILml9zqphYbuzzxDy7w0nhhf9vS4yjU4lRVeZIPRpzJ13nB94/C/EitBqYR
         JkvjkqOqEDWumOh89eMZN8ppJFIY6mQhQR+v9nililMLsDDItSH25hD1MAJ+ENCixrhi
         vTQMpUfbLcyIUII8R6rk93loOdfBdfrwANw0AYUu/VnO1pn13eII4B2Ho0QOl0lVmG5E
         WeYDZTvuRs3il8u0XFqpXazkFasl+fJzFYYhmYy6WlTDMBhpAZ3C6re6wdwuugFsqPbZ
         q3xcR27rMoz6w0PovWMe0rrt0o6ObQlFZxuG0RLXjURMUMKeoemsxnSJIfktZcIaJmBr
         z8uw==
X-Gm-Message-State: AOAM53379MkygOkWzqpOgS0Dkv99b7qzUy5NBUQtRHd6/QI5v/TZ7xPK
        MMaCBkFPGMWOuP9WcJtZwx9Urde3hsj38t1cWfw=
X-Google-Smtp-Source: ABdhPJwvsXZnaYk2cToMg0J/nyev3MCpnf4xG2OXuWd5AyCrKH1t/2KqHHpPFuOM4rq9X3RF5GFB8RDPm0iOW1lhG0M=
X-Received: by 2002:a25:880f:: with SMTP id c15mr42780691ybl.247.1621967131383;
 Tue, 25 May 2021 11:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210525175819.699786-1-elver@google.com>
In-Reply-To: <20210525175819.699786-1-elver@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 25 May 2021 20:25:20 +0200
Message-ID: <CANiq72krX9PU14wFsQyW_CJEjTS-TT8wyhBVZZbC132Gz5XO-Q@mail.gmail.com>
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

On Tue, May 25, 2021 at 7:59 PM Marco Elver <elver@google.com> wrote:
>
> +#if defined(CONFIG_KCOV) && CONFIG_CLANG_VERSION >= 130000

Is there any reason why Clang does not implement
`__has_attribute(__no_sanitize_coverage__)` like GCC? That way we can
merge both (perhaps even in `compiler_attributes.h`).

Cheers,
Miguel
