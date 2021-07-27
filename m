Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A80B3D6F08
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 08:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbhG0GQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 02:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbhG0GQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 02:16:06 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3315EC061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 23:16:06 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x90so7493920ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 23:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tSvAlOWxEIRF8a5C8ywowBQChrZ2YBJxoLkazd7wXek=;
        b=h/K4jENWHwQMchT88GLoXiRAkOV4YFgI3pc1+RnvDNIq8SkKcRENVlXM0BLJIkWFir
         3nHF7YTlArlshOuhgbbW9oPKG9HdYiqw1qCxBmDa/Can58xbusrbCWy5QcrCi0OfD/sA
         9PiXtRAm1877kD9LCrM36joOfraXaNJJ0o30Mtwg0qsgsjv3V0Hts5VcXGH5tJKzMCa1
         QGSNLJBGt1IdvQulv0mtcGhKQntIRgN75R4UaPkwnvQKN2xFa4xT//JUI/fP//HxwKuS
         pY8XnyNhDMKlxDh570s8IoANd9euNLYW9jjndlwRMlCDn9hIROJwhFWYvofGLNBCgDjv
         cWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tSvAlOWxEIRF8a5C8ywowBQChrZ2YBJxoLkazd7wXek=;
        b=q3zHgLA4yG9+LFPeAKN8t6uGcRHA2hzmQT8AK84kzw87OmK0jCHbwogr+MnicyjIdE
         9bnfJatx10TUdzjE09vPjMbG45nO5u7L/AUXxdCU0Voedvdt7qNvu8Lw86abfu5aGnOd
         ahAqTObDWd2P7MaoRG3bm2TaBGmgEhDUf2Ns6fim2dX1hPtBXKM8C5wJGdrRlB8MSXLk
         wqnQgMbVyWlszGz0sZXBRjkiui8cR5V8SPEDn4F5765mFQaCJyHUqqTyB7lw4F8fb478
         CNRE4nb8MnAY2jxpDF4LZ8fZyCQIrqBVRKWjp9YAw6jQzavrLp3sC7ribb/Jq1HARIAl
         9kmg==
X-Gm-Message-State: AOAM531rVLOuRU6gU20FSqKDf5I6o8yXbgab5CZ5cjAMO3ecW0OGBOLR
        0t4oJmW1zY4MwC2gnB3ggDH248oqjcdt6vzyN0nA
X-Google-Smtp-Source: ABdhPJyJUIRvq2jumZJTdpTEmsSEJlMyAxOKCj+EvoVEdDrjoBWz4G593vkcSIEO1kS9pBv+8/sA4c7JJaWs8/vvRIA=
X-Received: by 2002:a05:6402:27d2:: with SMTP id c18mr25855641ede.261.1627366564124;
 Mon, 26 Jul 2021 23:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210714091747.2814370-1-morbo@google.com> <20210726201924.3202278-1-morbo@google.com>
 <20210726201924.3202278-2-morbo@google.com> <c965006c-88e1-3265-eb9c-76dc0bbcb733@kernel.org>
 <YP+ZOx8BETgufxBS@kroah.com>
In-Reply-To: <YP+ZOx8BETgufxBS@kroah.com>
From:   Bill Wendling <morbo@google.com>
Date:   Mon, 26 Jul 2021 23:15:52 -0700
Message-ID: <CAGG=3QX68umw5Ws9_HuGkqoTNT=Q1+QB7YpSaqw3R_kPsbxwsg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] base: mark 'no_warn' as unused
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 10:27 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Jul 26, 2021 at 01:47:33PM -0700, Nathan Chancellor wrote:
> > + Greg and Rafael as the maintainer and reviewer of drivers/base/module.c
> > respectively, drop everyone else.
>
> Odd no one cc:ed us originally, I guess they didn't want the patch ever
> merged?  :(
>
> >
> > Original post:
> >
> > https://lore.kernel.org/r/20210726201924.3202278-2-morbo@google.com/
> >
> > On 7/26/2021 1:19 PM, 'Bill Wendling' via Clang Built Linux wrote:
> > > Fix the following build warning:
> > >
> > >    drivers/base/module.c:36:6: error: variable 'no_warn' set but not used [-Werror,-Wunused-but-set-variable]
> > >          int no_warn;
>
> That's not going to be a good warning to ever have the kernel use due to
> how lots of hardware works (i.e. we need to do a read after a write but
> we can throw the read away as it does not matter).
>
>
> > >
> > > This variable is used to remove another warning, but causes a warning
> > > itself. Mark it as 'unused' to avoid that.
> > >
> > > Signed-off-by: Bill Wendling <morbo@google.com>
> >
> > Even though they evaluate to the same thing, it might be worth using
> > "__always_unused" here because it is :)
>
> But it is not unused, the value is written into it.
>
I believe that only matters if the variable is marked "volatile".
Otherwise, the variable itself is never used. A "variable that's
written to but not read from," in fact, is the whole reason for the
warning.

> So this isn't ok, sometimes we want to write to variables but never care
> about the value, that does not mean the compiler should complain about
> it.
>
Typically, if you don't care about the return value, you simply don't
assign it to a variable (cf. printf). However, the functions that
assign to "no_warn" have the "warn_unused_result" attribute. The fact
that the variable is named "no_warn" seems to indicate that it's meant
to remain unused, even if it probably should be checked.

Would you rather the warning be turned off on some level?

-bw
