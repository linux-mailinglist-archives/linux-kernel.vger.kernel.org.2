Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AC1391786
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 14:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbhEZMkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 08:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbhEZMkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 08:40:05 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD077C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 05:38:33 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id b25so1351720oic.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 05:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cY6PkHBdJI7ud8EJlbf0GZl8OjlRbXkg5kf2YC2nFpU=;
        b=jju67nOHiBPolZGWBBzdnL0D11n8OYIkbChiMPDoBAqM9WG/hBVGpoNlPEJ9UQQj4x
         /qElWnVoN6NaP2LJP3R/tF/PdkeV7BwePftHfjHU6yND5dHONs+Z5TXBUGj9ZsdRkFV+
         rC1Lbw6R11SxIj39jXp/p21+U07pDjQdzHYKqAew8My84DS8AXIY4mafyB29OcHYqfVS
         wNQTO6XWlPCYX6pL7ruvts5YPDLqEvhlUYqtJtbV/5+f4QhwyDBbehtjfjS0/UVe7b6D
         AA28dunj9z2iYEWxcNo2cY1JaldFmmAH9Gz24FbymD/jhE8LRDF7xB1Khhp6jfrsYuEs
         2cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cY6PkHBdJI7ud8EJlbf0GZl8OjlRbXkg5kf2YC2nFpU=;
        b=BcadyP49av/s3mv8CR6d3kUGGDVjz3ZUAfHrkB1jt06W0EyDdQJnMxMB2++aU+9FVc
         GURY6B2RE67WpYMMN3tpJRfQC42UKQMgoSMfYaYIKpoYavJNgDmo2paaGtatwo7r3/j6
         9b5XsLkbX5wVMSIZesiZMeuu1JQUw9lkVgEVpTt7B9gn0oNtUt9gVJLJn1G9vZQpjFoG
         es+gqvsL9yJ+juSDFRXoUn0IsHEyDbfiuTtQqn92ZxtzaNRxFIR72XfAi/yHBiWYzc8C
         7CuWmN5dwOYRbNIf9pYNyd9z4m/fWtTC4fsR9t3Zxi868TJwqDVKIUXoaWIEmz7D6wHE
         H/zQ==
X-Gm-Message-State: AOAM530NBxVI8fTfChwf5m/cqKbmNtnXZSo4jD9q4PcUWWpmiPkI4FqG
        Ty1OyUfo3Y0K6zHC6CI6Ke8D71DU+tHL4i3X7d+l0A==
X-Google-Smtp-Source: ABdhPJwFJOoF48w01eZkO7CfVJ2Ck3wwxx2YqG4lCBLOlsdNUotrzFQakmI8V4iLtUnSpiWrtRwhga9a80xGA7FcsDg=
X-Received: by 2002:a05:6808:f94:: with SMTP id o20mr1675929oiw.121.1622032712848;
 Wed, 26 May 2021 05:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210525175819.699786-1-elver@google.com> <CANiq72krX9PU14wFsQyW_CJEjTS-TT8wyhBVZZbC132Gz5XO-Q@mail.gmail.com>
 <CANpmjNPGUAv-d3yEusyF11ip0zEdht7eMGi4pSoQsRYns-MvJA@mail.gmail.com>
 <CANiq72kCkej_ONwSWjRHWLVrr+g0BZygAUAQVx+FQf7DEdg3cQ@mail.gmail.com> <CANpmjNM_fP-ziy204=1rd52hOO4WfCsxAwQgJ-t1WF_yFo=UzA@mail.gmail.com>
In-Reply-To: <CANpmjNM_fP-ziy204=1rd52hOO4WfCsxAwQgJ-t1WF_yFo=UzA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 26 May 2021 14:38:21 +0200
Message-ID: <CANpmjNOkX5NFFekezDSntjVBp2mVgxTprjV1QK56DsE2fv-w3A@mail.gmail.com>
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

On Wed, 26 May 2021 at 08:25, Marco Elver <elver@google.com> wrote:
> On Wed, 26 May 2021 at 03:54, Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> > On Tue, May 25, 2021 at 9:13 PM Marco Elver <elver@google.com> wrote:
> > >
> > > Long story short: this is not fixable without more Clang changes. The
> > > only way to do it without a version check would be to introduce
> > > no_sanitize_coverage attr to Clang, which we probably shouldn't do,
> > > and I didn't want to fight it. ;-)
> >
> > I am not sure I followed why you would not want to support querying
> > for the attributes (if they are intended to be used separately).
>
> Not my decision, but some historical decision in Clang. Somebody
> thought "no_sanitize(<string_literal>)" simplifies things. Hence,
> Clang only knows about the no_sanitize attribute but not its
> "subattributes".
>
> > But regardless of that, why not the feature flag at least then, to be
> > consistent with the others?
>
> __has_feature(coverage_sanitizer) does not work either (yet).
>
> > Going back to version checks seems bad -- they should be reserved for
> > e.g. known broken versions and things like that. New compiler features
> > should come with new feature flags...
> >
> > In fact, for Clang, I do not see any version checks in code at the
> > moment, so this would be the first :(
>
> In this instance it's absolutely required (for now). But if you don't
> like it I'll go back to trying to fix Clang more. I'll check with
> Clang folks which one we can implement, the feature check or the
> attribute check.

Ok, let's wait for response to: https://reviews.llvm.org/D103159
If that lands in the LLVM repo I'll change to use
__has_feature(coverage_sanitizer), and send a v2. That __has_feature()
is a bit of a lie though, because fsanitize-coverage has long been
supported, but it just so happens that if we get it, then its
availability implies availability of the no_sanitize("coverage")
attribute.

Thanks,
-- Marco
