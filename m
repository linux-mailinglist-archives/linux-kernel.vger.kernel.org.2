Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62183910A9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhEZG1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 02:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhEZG07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 02:26:59 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C44C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 23:25:25 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id v22so519736oic.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 23:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WpFGeM+BH3Mgu7E6GssVzw2HhPZxd2Kqk2VIWf3hIA0=;
        b=Q4O0S5sAPUtIIoXljcBlaahvCY9lNWYEl8FlEybGbIw43ir04PMJ+D8/IpDHP+DQYl
         z3T4FHclaFDx6/g8oeINq9NODFyKLcnRe92y06dDJzVfmCntEoIPgU01v56dSm728+v5
         Rs+NXTXuvK3pj6HT6GkrOAVlPOIatNGb9lcICXP+mpF3s1szn4Oqb4dP/WUgrMdFX0G6
         BG0bmebOzjfYBMxsNyGQ2B7zfzeKDbWxLc1ILTUc4VaIwEwLK1lmRRxdn/TYAvTY5dl7
         xNMIv9kV1BEFHip5xWzun+PEGwJm5IsNkrPWXuDqrhEUS/1Y6SSMgpA5GQ+Y+zGUwTr0
         Grlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WpFGeM+BH3Mgu7E6GssVzw2HhPZxd2Kqk2VIWf3hIA0=;
        b=nJqxqVoIJ8hgNi6DzNqn75VSwy4riMtFso05cKv3XjB3/lymlw0BnUcUptqttxlmZx
         qPuhZQX0RVdkv0lvS+OtEgVhKzc3vIvJlIyj1fF6UyMt3C8q6Uww4Pg+US8NfGmI7HIR
         f5Bp58SyE+nbmjvvmm0C+50gtfi9jZu08tGCH3O2zWKNfuy3T7sw1/wiXxctE7dVipey
         AGAfEKCk0L5RElAUQv/mPDaKauOXjDhYocxtyUSfxJJZ1m0aSNZfV2S9UgSTpTWd//bC
         tUIejQi9irDkgC9aCF5p+gOIE/rd0ZXDMZ7RkjFoIWELXYR5bJBBMzc+PwaIZuAfliOB
         51Mg==
X-Gm-Message-State: AOAM5314+e/A6eiVSzYrgL7RELwTyhij0jN14M8innUccCCbgAvRsUxs
        Z7bHTcI41T46TXG3bMQVHTIrLQa1/PVYAhNzgkFy0Q==
X-Google-Smtp-Source: ABdhPJwCtA5nZredcZEnHRU5hzrqTKU3N8s8ew2nf3CIbs2kzLWmgML+oQDDVvHEds8sS9200Kmpe1aKgHrgAudWwT0=
X-Received: by 2002:a05:6808:10d4:: with SMTP id s20mr858862ois.70.1622010325003;
 Tue, 25 May 2021 23:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210525175819.699786-1-elver@google.com> <CANiq72krX9PU14wFsQyW_CJEjTS-TT8wyhBVZZbC132Gz5XO-Q@mail.gmail.com>
 <CANpmjNPGUAv-d3yEusyF11ip0zEdht7eMGi4pSoQsRYns-MvJA@mail.gmail.com> <CANiq72kCkej_ONwSWjRHWLVrr+g0BZygAUAQVx+FQf7DEdg3cQ@mail.gmail.com>
In-Reply-To: <CANiq72kCkej_ONwSWjRHWLVrr+g0BZygAUAQVx+FQf7DEdg3cQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 26 May 2021 08:25:13 +0200
Message-ID: <CANpmjNM_fP-ziy204=1rd52hOO4WfCsxAwQgJ-t1WF_yFo=UzA@mail.gmail.com>
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

On Wed, 26 May 2021 at 03:54, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Tue, May 25, 2021 at 9:13 PM Marco Elver <elver@google.com> wrote:
> >
> > Long story short: this is not fixable without more Clang changes. The
> > only way to do it without a version check would be to introduce
> > no_sanitize_coverage attr to Clang, which we probably shouldn't do,
> > and I didn't want to fight it. ;-)
>
> I am not sure I followed why you would not want to support querying
> for the attributes (if they are intended to be used separately).

Not my decision, but some historical decision in Clang. Somebody
thought "no_sanitize(<string_literal>)" simplifies things. Hence,
Clang only knows about the no_sanitize attribute but not its
"subattributes".

> But regardless of that, why not the feature flag at least then, to be
> consistent with the others?

__has_feature(coverage_sanitizer) does not work either (yet).

> Going back to version checks seems bad -- they should be reserved for
> e.g. known broken versions and things like that. New compiler features
> should come with new feature flags...
>
> In fact, for Clang, I do not see any version checks in code at the
> moment, so this would be the first :(

In this instance it's absolutely required (for now). But if you don't
like it I'll go back to trying to fix Clang more. I'll check with
Clang folks which one we can implement, the feature check or the
attribute check.

> Cheers,
> Miguel
