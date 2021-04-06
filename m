Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F2435556B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 15:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344596AbhDFNlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 09:41:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238827AbhDFNlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:41:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6348D613CC;
        Tue,  6 Apr 2021 13:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617716459;
        bh=qDqK8wQ/7+OGAOOi2xbtIaP4WgZISHYYxdJR7Ffc8M8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IKvTcGDzC+BV8Bn3ZgVr2JE1vpteJc7rq1gMuR8nj780i50TxUJANEw0ZH5G8+XkT
         XK8Kpx97almclBQpSzQbI+luXqdH2FqPtZIE48qvYuiDFh0Bq62OsNt/GtM994YGus
         oRZfWHUk7jf/F/2us8KgRPRdZe2DXfBxC6dq1YZbemKPlyCaPwycs6+WZxFTDKLdb4
         6hFFpfRO8AoELDUyRUCN8EUotmaTvrQe4KiRE6I4J8bITjhXhMFTZ2ZsybQjXyfFo6
         YrjEPTdHDEyC5X6pxLbyicG5ulYzKXh3tLwxfciAvAwhIpoPTA5LZpJFysCC1FbiQd
         puWOsH3D9xclg==
Received: by mail-ed1-f50.google.com with SMTP id o19so16640223edc.3;
        Tue, 06 Apr 2021 06:40:59 -0700 (PDT)
X-Gm-Message-State: AOAM532GaL8d11YEr7LabqA+jV9EDSaswilyKeF5BlCcLhNpmbMV2hLq
        dS9U+RGfDyOdaocvtJB1uTao8OZ+i2DJq/lzOw==
X-Google-Smtp-Source: ABdhPJwNrYLLERtt0yqnaTwUk3ZS3MELJaO4SHKDD69Ff9/SXNbj3VqJcyZgHOvauQEnaGR3492LZ0HUkaAxpGmpLX0=
X-Received: by 2002:a05:6402:5252:: with SMTP id t18mr38710035edd.258.1617716457827;
 Tue, 06 Apr 2021 06:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210316193820.3137-1-alex@ghiti.fr> <ee702ff7-f43c-745c-4157-b1cba53bb0b2@ghiti.fr>
In-Reply-To: <ee702ff7-f43c-745c-4157-b1cba53bb0b2@ghiti.fr>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 6 Apr 2021 08:40:46 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLeA2va05A78M893rAGoeMr-CztdiZouq-PSDFfsJ_-EA@mail.gmail.com>
Message-ID: <CAL_JsqLeA2va05A78M893rAGoeMr-CztdiZouq-PSDFfsJ_-EA@mail.gmail.com>
Subject: Re: [PATCH] driver: of: Properly truncate command line if too long
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 3, 2021 at 7:09 AM Alex Ghiti <alex@ghiti.fr> wrote:
>
> Hi,
>
> Le 3/16/21 =C3=A0 3:38 PM, Alexandre Ghiti a =C3=A9crit :
> > In case the command line given by the user is too long, warn about it
> > and truncate it to the last full argument.
> >
> > This is what efi already does in commit 80b1bfe1cb2f ("efi/libstub:
> > Don't parse overlong command lines").
> >
> > Reported-by: Dmitry Vyukov <dvyukov@google.com>
> > Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> > ---
> >   drivers/of/fdt.c | 21 ++++++++++++++++++++-
> >   1 file changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index dcc1dd96911a..de4c6f9bac39 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -25,6 +25,7 @@
> >   #include <linux/serial_core.h>
> >   #include <linux/sysfs.h>
> >   #include <linux/random.h>
> > +#include <linux/ctype.h>
> >
> >   #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
> >   #include <asm/page.h>
> > @@ -1050,9 +1051,27 @@ int __init early_init_dt_scan_chosen(unsigned lo=
ng node, const char *uname,
> >
> >       /* Retrieve command line */
> >       p =3D of_get_flat_dt_prop(node, "bootargs", &l);
> > -     if (p !=3D NULL && l > 0)
> > +     if (p !=3D NULL && l > 0) {
> >               strlcpy(data, p, min(l, COMMAND_LINE_SIZE));
> >
> > +             /*
> > +              * If the given command line size is larger than
> > +              * COMMAND_LINE_SIZE, truncate it to the last complete
> > +              * parameter.
> > +              */
> > +             if (l > COMMAND_LINE_SIZE) {
> > +                     char *cmd_p =3D (char *)data + COMMAND_LINE_SIZE =
- 1;
> > +
> > +                     while (!isspace(*cmd_p))
> > +                             cmd_p--;
> > +
> > +                     *cmd_p =3D '\0';
> > +
> > +                     pr_err("Command line is too long: truncated to %d=
 bytes\n",
> > +                            (int)(cmd_p - (char *)data + 1));
> > +             }
> > +     }
> > +
> >       /*
> >        * CONFIG_CMDLINE is meant to be a default in case nothing else
> >        * managed to set the command line, unless CONFIG_CMDLINE_FORCE
> >
>
> Any thought about that ?

It looks fine to me, but this will need to be adapted to the generic
command line support[1][2] when that is merged. So I've been waiting
to see if that's going to happen this cycle.

Rob

[1] https://lore.kernel.org/lkml/cover.1616765869.git.christophe.leroy@csgr=
oup.eu/
[2] https://lore.kernel.org/lkml/41021d66db2ab427c14255d2a24bb4517c8b58fd.1=
617126961.git.danielwa@cisco.com/
