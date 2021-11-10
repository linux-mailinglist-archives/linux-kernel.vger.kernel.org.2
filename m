Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8725344C103
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhKJMNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:13:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24724 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232036AbhKJMNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636546228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rr36Cb2Y1cvFR41scNcUzd8wBnS/OAi/NVPg1Fb83xQ=;
        b=WCyx7NqO0zlXbv6T1k6wAvWpEp6FQzDNQLjrfkV/D50aCWeubwxf7Gcq3OwYGqB9leNOar
        1vLLczfzBhjW4EZP0sWFeenRkerdgpfK16FPVIAAZ7ucmEZ6miigGaJfr/4KgaZ7YrsxRK
        W5mKHpzf9Nhh0YocHN2blBLqb/DhVHU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-598-daiFPBbkNeCOKiPMainlDw-1; Wed, 10 Nov 2021 07:10:27 -0500
X-MC-Unique: daiFPBbkNeCOKiPMainlDw-1
Received: by mail-ed1-f70.google.com with SMTP id i9-20020a508709000000b003dd4b55a3caso2122987edb.19
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:10:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rr36Cb2Y1cvFR41scNcUzd8wBnS/OAi/NVPg1Fb83xQ=;
        b=j1NiAw2AVvA2spygpaSUqjw6tqOYjvk3bFZeBE1j57WwsIJGUP7eRclKZBNd8RbJxg
         vnQ85WHtlnFtjVWcAcHlGSVLj6YPGz5eHhb6QbwCExibU20GLNX6lWRqLC9Awii08cah
         dXs4B9C8YBK3Tv5ZdlGT+cn4iaTlBh4n7LNMk8AdT36Ae5A1MnYaMsT2TyWulJpr2RGL
         eQA+g0mOy1p3NL13AGH90EBHCNPgUUCpPPv8IBq6/AHuEtlZm3wnAaS3tCn+RZtnHUWE
         C58z2D7EKoYq2vJ/B1rHQEnyz1pui/jUj76/d48Zc2WF6lXSSZGiGFZzA/QWiFzhNgHI
         5nFg==
X-Gm-Message-State: AOAM530zu39L87rUv5xkkq43ukCPNeI3TCLvaGXcYNnEn7f1AInEgji/
        WO1JzbDofp3H6XdYx/6+PueNv5wLhFlgmvq8joSFHqZKpCWU1FIXISdLIKwgLuLH/+FVO09+96B
        px6sRDK0kmcYyWq2i2RrjaJkIFR/42H17Kr8a7H/k
X-Received: by 2002:a17:906:ad89:: with SMTP id la9mr19787428ejb.178.1636546226126;
        Wed, 10 Nov 2021 04:10:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwf4XP8fkeIWWNmHm7LmReGjzuQX86h1/sC+gmwglVaX4WVJuIk3uu0SgugELXK3xZxJVQ9JlvsL+t5QFcdnjo=
X-Received: by 2002:a17:906:ad89:: with SMTP id la9mr19787400ejb.178.1636546225940;
 Wed, 10 Nov 2021 04:10:25 -0800 (PST)
MIME-Version: 1.0
References: <20211029201402.428284-1-wander@redhat.com> <CAHp75VeZBp4gKvGBDzaD=EpGRDZ1-wTvD8K9Ui6Q59kDjmkXmQ@mail.gmail.com>
 <CAAq0SUmzHqEzNk3aw3SEgYVWRukQeHK1WtcJ3MjXcQKJrbC1Dw@mail.gmail.com> <CAHp75Vf6DjNcPWpE4Dh3SuzUMJbFQjq1UNCkrCa60uw35SpqKg@mail.gmail.com>
In-Reply-To: <CAHp75Vf6DjNcPWpE4Dh3SuzUMJbFQjq1UNCkrCa60uw35SpqKg@mail.gmail.com>
From:   Wander Costa <wcosta@redhat.com>
Date:   Wed, 10 Nov 2021 09:10:14 -0300
Message-ID: <CAAq0SU=wYZ9e9NJvwcLvEvxj-J7PhAPFjRAu2uFVYPprR7A_qQ@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: Use fifo in 8250 console driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     wander@redhat.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 1, 2021 at 12:33 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Nov 1, 2021 at 5:22 PM Wander Costa <wcosta@redhat.com> wrote:
> > Em s=C3=A1b., 30 de out. de 2021 04:41, Andy Shevchenko
> > <andy.shevchenko@gmail.com> escreveu:
> > > On Friday, October 29, 2021, <wander@redhat.com> wrote:
>
> ...
>
> > > I don't see any links.
> >
> > Oops, sorry about that. I must have accidentally deleted it while
> > editing the commit message.
> > Here it is https://github.com/walac/serial-console-test.
> > I will update the patch with the link.
>
> Thanks!
>
> ...
>
> > > On how many different UARTs have you tested this? Have you tested oop=
s and NMI contexts?
> > >
> > I only tested in a half dozen machines that I have available. I tried
> > it in panic, warnings, IRQ contexts, etc. Theoretically, this change
> > should not be affected by the context. Theoretically...
> >
> > > What I would like to say here is that the code is being used on zilli=
ons of different 8250 implementations here and I would be rather skeptical =
about enabling the feature for everyone.
> > >
> > I did my homework and studied the 16550 datasheets, but yes, there is
> > always this risk. Maybe people more experienced with PC serial ports
> > than me might think the patch is not worth the risk of breaking some
> > unknown number of devices out there, and I am ok with that. It is a
> > valid point.
>
> Here is a translation of my comment to a roadmap.
>
> 1. Introduce yet another UART quirk or capability (see corresponding
> UART_CAP_* or UART_*_QUIRK definitions)
> 2. Add your patch conditionally based on the above
> 3. Enable it on UART(s) you _have tested_
>
Thank you for the feedback, I submitted a v2 patch with your proposed chang=
es,

Cheers,
Wander

> --
> With Best Regards,
> Andy Shevchenko
>

