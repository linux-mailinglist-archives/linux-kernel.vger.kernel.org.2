Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED96390979
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 21:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbhEYTOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 15:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhEYTOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 15:14:40 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7294FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 12:13:10 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so5339210otl.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 12:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dm5fSZr4HIoAbN3HoCp75swHXTm6YycskIMZ+K2xM+s=;
        b=OmSqMRSOex+mAa15yVlQ5P46KyCPPh1lilXG3Xi0AHV/IIdwcTUCuJdYY03zUzdKVM
         6SQiS2LjNT4xvP3PGm/LEKhnOiHXOezVUMiJ8FqVJf8z1hC0wY1ljsBWRXyVouxC5QkZ
         zkQwdRkFFdiwv7lKyrZBfBMDRriuWNn3cWdV4nTIZiXPH6g52rMlXmawIn8EtG9qREcQ
         RF8yin9kc9MDdubQD1RMoUsiFLVpRNyjWqVpSlZeCR/PdWHOrFA6nft/0XCzRSskTZJr
         wyqaUpedQutc/uoD5JBWZijQ4md8Dz9S5j7K1UZpQk7frwTxB/2Un3L821rCEhkW8cTc
         5Sng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dm5fSZr4HIoAbN3HoCp75swHXTm6YycskIMZ+K2xM+s=;
        b=kPY3CzVgOBmKHQo0D0QFtX/c0gDBVYLwqiTzzhbVrHmgODI6uJ0CsT7d3JN18n1gHx
         ihOtw5wwf2GNbW2O14yaOEIQ0Q2YiNLEqjPnULSss7fTfx3K9YJzJUfU5NERZzgHjy1M
         LiwfvwZ9QMl/nziAJBViHSG7ZK/SD54l0BuRMzmALtQ5algqjw8Ks5VJxj5h5WUYbyzB
         97PDVohq4GGxOZS/aEMuocwJ80bC3XpjgJlAsKGp7d6KZm7QPiqATzcELawv5Dbfd8Kr
         XSF4q6+8NMng6cqRngQCNWzqfKJJwYbnzddOWWBum34xNoZ8HTYijb58LhgxA9azg0Xk
         /Sqg==
X-Gm-Message-State: AOAM530TK80G+o7/y3dLEATWvhPrBEgeyn0c9LRlIj//XJq/3rCDW61D
        YGysFZpS4LYslqAPbgB2P9gEugJvbIXrmDNFsAPpPw==
X-Google-Smtp-Source: ABdhPJz5CWa80NbQHS5UybnmPyyDgW/3YCvzw6Ey42abPO+0uHblI4RzPQ7VnP8lhEj5upnT1qShzKrYRLzsbbXp2hs=
X-Received: by 2002:a05:6830:349b:: with SMTP id c27mr25296301otu.251.1621969989456;
 Tue, 25 May 2021 12:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210525175819.699786-1-elver@google.com> <CANiq72krX9PU14wFsQyW_CJEjTS-TT8wyhBVZZbC132Gz5XO-Q@mail.gmail.com>
In-Reply-To: <CANiq72krX9PU14wFsQyW_CJEjTS-TT8wyhBVZZbC132Gz5XO-Q@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 25 May 2021 21:12:57 +0200
Message-ID: <CANpmjNPGUAv-d3yEusyF11ip0zEdht7eMGi4pSoQsRYns-MvJA@mail.gmail.com>
Subject: Re: [PATCH] kcov: add __no_sanitize_coverage to fix noinstr for all architectures
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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

On Tue, 25 May 2021 at 20:25, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Tue, May 25, 2021 at 7:59 PM Marco Elver <elver@google.com> wrote:
> >
> > +#if defined(CONFIG_KCOV) && CONFIG_CLANG_VERSION >= 130000
>
> Is there any reason why Clang does not implement
> `__has_attribute(__no_sanitize_coverage__)` like GCC? That way we can
> merge both (perhaps even in `compiler_attributes.h`).

It's complicated. Clang implements all no_sanitize options via
no_sanitize(<string_literal>), except for 3 which are there for
backwards-compatibility reasons (no_sanitize_{address,memory,thread}).
But otherwise, no_sanitize_sanitizer is deprecated in Clang in favor
of no_sanitize("sanitizer") per comment at
https://github.com/llvm/llvm-project/blob/main/clang/include/clang/Basic/Attr.td#L2907.
(That being said, there's already inconsistency due to coverage
instrumentation requiring "-fsanitize-coverage=..." and not
"-fsanitize=coverage-...". The implementation vs other no_sanitize is
also a bit special, see LLVM commit.)

This means we only have __has_attribute(no_sanitize). Which is also
the reason why the other __no_sanitize_* defines in compiler-clang.h
first check the feature, as feature existence implies attribute
existence. But, sadly, this is not the case for coverage
instrumentation (where in fact, __has_feature(coverage_sanitizer)
doesn't work either...)

From a UX perspective, having Clang only give us no_sanitize("...")
without the corresponding __has_attribute() support is not great, but
passable due to __has_feature() working for other sanitizers. From
Clang's perspective, it kept things simpler because we've gotten quite
a number of sanitizers recently. The big ones are manageable [1], but
UBSan is just too much [2].
[1] https://clang.llvm.org/docs/UsersManual.html#controlling-code-generation
[2] https://clang.llvm.org/docs/UndefinedBehaviorSanitizer.html#ubsan-checks

This is probably a longer answer to your question, but is a summary of
the frustrations I encountered as I looked deeper into Clang's
no_sanitize attribute.

Long story short: this is not fixable without more Clang changes. The
only way to do it without a version check would be to introduce
no_sanitize_coverage attr to Clang, which we probably shouldn't do,
and I didn't want to fight it. ;-)

Thanks,
-- Marco
