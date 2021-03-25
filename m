Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566FF3496C6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCYQ24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 12:28:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229670AbhCYQ2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:28:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E5B361A2D;
        Thu, 25 Mar 2021 16:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616689711;
        bh=UUb2YpPPhrZYBFc+9LA0bPvCH8n+hhtEFgJ+RKvX/jU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mugIGBUbTM2AtNHnwnvdicxWxPrLwc0paD3lyJ4T7azU3O5tBBy3RG4kDaB/poX1a
         kJiaVQFMkL15GYguSOrLWersfsVGFMm5cDlc8kQn833QIcLuUydXpYGHpV4f0tPtDt
         Y9yyqvqeGHV4PTGkcF47knLxy4244N6lokYg20WrnJ4Py3nH27aLs5zN3jJRhCLc61
         nMZWMF6KldOWb8EbyeiIt/JZ4T+4GwUmYNVXK6X6Y/0UlqZvJK2u8AHNBfUucrnjmI
         l2W4q59ktauvaFOGWNzvqft3FqlGrkGnZz/DIISTp1Ov8g4cR1i5Pg6fE2X0/HjaY3
         aK/AqvL58tNAg==
Received: by mail-ej1-f50.google.com with SMTP id b7so3949365ejv.1;
        Thu, 25 Mar 2021 09:28:31 -0700 (PDT)
X-Gm-Message-State: AOAM532PHPqYxxGuF5qLywsi0tJcToBzGoww9qQfCu6eyliWkGGz12r9
        WcE5tsmdEiWV1Ilyiqcg7c728KS690mDXFS1iw==
X-Google-Smtp-Source: ABdhPJyAS3MOqfSApNDkQLxm69M/5WJ6MViHJtey95Sr4dAEb1f4VANdxueW3S+zI6/Ta09EKpnDN5PoPyiojySt7uw=
X-Received: by 2002:a17:906:7f84:: with SMTP id f4mr10181968ejr.525.1616689710118;
 Thu, 25 Mar 2021 09:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210324150425.20688-1-changbin.du@gmail.com> <CAL_JsqJ0hyZ25jSudh3EW1Fipwbp0AzMAKXG565ZrQxn-_kBKg@mail.gmail.com>
 <20210325155954.iun4hdcegi4b3qm2@mail.google.com>
In-Reply-To: <20210325155954.iun4hdcegi4b3qm2@mail.google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 25 Mar 2021 10:28:17 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLG9Mgndo4WCr8GRdkW3Hrs_U7XedSfjSMQGnsf2cPLmQ@mail.gmail.com>
Message-ID: <CAL_JsqLG9Mgndo4WCr8GRdkW3Hrs_U7XedSfjSMQGnsf2cPLmQ@mail.gmail.com>
Subject: Re: [PATCH] of/fdt: Check dtb pointer first in unflatten_device_tree
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 10:00 AM Changbin Du <changbin.du@gmail.com> wrote:
>
> On Wed, Mar 24, 2021 at 10:52:30AM -0600, Rob Herring wrote:
> > On Wed, Mar 24, 2021 at 9:04 AM Changbin Du <changbin.du@gmail.com> wrote:
> > >
> > > The setup_arch() would invoke unflatten_device_tree() even no
> > > valid fdt found. So we'd better check it first and return early.
> > >
> > > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > > ---
> > >  drivers/of/fdt.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > > index dcc1dd96911a..05d439d63bc5 100644
> > > --- a/drivers/of/fdt.c
> > > +++ b/drivers/of/fdt.c
> > > @@ -1225,6 +1225,11 @@ bool __init early_init_dt_scan(void *params)
> > >   */
> > >  void __init unflatten_device_tree(void)
> > >  {
> > > +       if (!initial_boot_params) {
> > > +               pr_warn("No valid device tree found, continuing without\n");
> >
> > How are you going to see this message if you have no DT?
> >
> This aligns to what unflatten_and_copy_device_tree() does.

Humm, then we should have a single check that covers both cases. Or we
should remove that one.

>
> > > +               return;
> >
> > And the arch is supposed to just continue on oblivious that it has no DT?
> >
> As checking the arch code(arm, riscv), I suppose so.
>
> > > +       }
> > > +
> > >         __unflatten_device_tree(initial_boot_params, NULL, &of_root,
> > >                                 early_init_dt_alloc_memory_arch, false);
> >
> > Soon as you get here with a NULL initial_boot_params, you'll get a
> > backtrace and halt.
> >
> No, we have returned before.

I mean without your addition we'll get here with a NULL.

Rob
