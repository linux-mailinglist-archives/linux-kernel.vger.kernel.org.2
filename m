Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1693D685A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 23:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhGZUVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 16:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbhGZUVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 16:21:10 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ED2C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 14:01:37 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id go31so4785449ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 14:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8lSJalLHPzxTbKAIv4nuRUkH8dvQEWkjSFUf7metCho=;
        b=Wo+Igpa5hi51kWALM8B7XlwgHjKoIBkJHBGhQQbtysuCNfoy0km+UwgrtgNpLqqgT+
         qbnL2lsoc+XOpaK7PBWToHiXdyHsZvNs70YTcMesNDqMCEUN79GFaxc2kvIhxTMwZ84i
         4CzOPi3Z39H8dHsUH+HMf013XfMAGUY05UGeyVs5InjfSnR6FRZ8HLIr1eAK+htdt8dN
         dxTIkEMs4b9WsjAWi/qj4bwHGxCtT1vu5mo2CSbMCbnJFGRd5AmAZUi4CrtBNYfcMSqD
         eddZAbT/S83ZldnkcCm8x5B3mckdk2oMhHxswhE3yfkRcMJ2Rrit/YZx5V8bq4008mDt
         pMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8lSJalLHPzxTbKAIv4nuRUkH8dvQEWkjSFUf7metCho=;
        b=fJcWzDyT7C3zorN2WuxmUNtoMSBsBDw8xc7TRZYWtGQzgRagS0vthp6MwPJoOSqzwG
         v1NOsVIiidPBF7HeBVy18woHDdf3isY1OL37YQQhT3HOS8/Ru++jyUhniB9wS41dAGLD
         FQjmrUhaLewOOFRWeyex12suseVinhuKBN1z7N1ClkV+bx+fZWnFYi+7s4/+SEFCB4Bb
         hUrnR8qr2VsYz8s1fdvC9Qr5hqjuA6J0p11eXhWgqpPgEZYIccX5cVg4tLX0t8zLs32J
         AwBXw5+cEeXMbTfAMKFDEL0tEwhTQfNscFNguFjLgzW29nkF0j64QOWcxfNToFgogrz5
         GohA==
X-Gm-Message-State: AOAM533O3NkVB5NiQpC4Il5LofSh73/V9fEA9fmBsAAdls2i/OgWPSVD
        AbSQxB1M8V8UjQ+GZGJikNlgtIpNSZwJSE4PT9Lf
X-Google-Smtp-Source: ABdhPJxOnoUwSWOWslJjYRW5tXSOe695EQX4oO8fw1sxQUqrw3Mu5CLJW+EroqKr8qQIUB4l/NO7buM0ZXodQkPE684=
X-Received: by 2002:a17:906:95cf:: with SMTP id n15mr18769848ejy.531.1627333295997;
 Mon, 26 Jul 2021 14:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210714091747.2814370-1-morbo@google.com> <20210726201924.3202278-1-morbo@google.com>
 <20210726201924.3202278-2-morbo@google.com> <c965006c-88e1-3265-eb9c-76dc0bbcb733@kernel.org>
In-Reply-To: <c965006c-88e1-3265-eb9c-76dc0bbcb733@kernel.org>
From:   Bill Wendling <morbo@google.com>
Date:   Mon, 26 Jul 2021 14:01:24 -0700
Message-ID: <CAGG=3QVWzg21wL3fjcKmNGW5xP-c9p7bDm3j598J3-j+GDPq+A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] base: mark 'no_warn' as unused
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 1:47 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> + Greg and Rafael as the maintainer and reviewer of
> drivers/base/module.c respectively, drop everyone else.
>
> Original post:
>
> https://lore.kernel.org/r/20210726201924.3202278-2-morbo@google.com/
>
> On 7/26/2021 1:19 PM, 'Bill Wendling' via Clang Built Linux wrote:
> > Fix the following build warning:
> >
> >    drivers/base/module.c:36:6: error: variable 'no_warn' set but not used [-Werror,-Wunused-but-set-variable]
> >          int no_warn;
> >
> > This variable is used to remove another warning, but causes a warning
> > itself. Mark it as 'unused' to avoid that.
> >
> > Signed-off-by: Bill Wendling <morbo@google.com>
>
> Even though they evaluate to the same thing, it might be worth using
> "__always_unused" here because it is :)
>
I thought about that, but went with the softer option in the (probably
very) unlikely event that it will be used in the future. :-) I'll be
happy to resubmit a new patch though.

-bw

> Regardless:
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> > ---
> >   drivers/base/module.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/module.c b/drivers/base/module.c
> > index 46ad4d636731..10494336d601 100644
> > --- a/drivers/base/module.c
> > +++ b/drivers/base/module.c
> > @@ -33,7 +33,7 @@ static void module_create_drivers_dir(struct module_kobject *mk)
> >   void module_add_driver(struct module *mod, struct device_driver *drv)
> >   {
> >       char *driver_name;
> > -     int no_warn;
> > +     int __maybe_unused no_warn;
> >       struct module_kobject *mk = NULL;
> >
> >       if (!drv)
> >
