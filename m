Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085C33413CF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 04:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbhCSDsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 23:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbhCSDsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 23:48:52 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C59C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 20:48:52 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id t18so6856905iln.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 20:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hxhh6pAeMJKWUC39tUcChryYGa8hpOFSDYpkxrgsErw=;
        b=r7sclbCMB6a+rHNtxfflluf2hpMjzxuVu1a7hdqZd5jXMrWUt2WTn8GArdJ/jdpzLC
         ohmLlSuPzlBFZbj51NN1Vc0OmH9T1dQRacneLDlK+z8ew9xEQukaIPInps3HZ4rZibgi
         a5sHBa2Ga5gj4pJ9CerRhsI4G8q0JMGoJknzgFb3zfd/bX5yUbcfMzTR9VeCV5JsWkik
         1pakKGoi2p4u+plpVDTojy+fGm1P7fIqQuKlIa9xXz4Pz151v3GPGz6P6B7T0j+5Od0a
         oIL7yeUjOHjdXBu5jE8wodzCQTcBVxgGO+pWH3nQYeX7U1LR+xLm3PAheZWdUl9PoWyJ
         yjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hxhh6pAeMJKWUC39tUcChryYGa8hpOFSDYpkxrgsErw=;
        b=kQgG4g1PNAh2/atffP/WxV1vahCaBgh8lvE0Om1ucpAkEz7eMxPtW8iDLSdDaTzP0b
         8O4ib0bL+wv/a+buYKJTaMzmM1O3KXQaMY7GhfOJFpSerqZd/KXTykI2IKG5mMA3tIMC
         /85rEpnUD5TghTjW6wG23AYk6XyNSOI45Tf07aBshtV/LzQ1mMUUUAMsYlB6KOS5O+ZP
         0HfMioTIX7z86LpYt34D8Of0YYPCEjEsXXvRjOzIto9A3VZ2ZU/sPk5PLhlGP1zUSjp1
         sLCdw2dvF3lsSmrGXq1TsZJzA6obTbHiaO3fG7/dEX7KKtvnQP/9/j4d71npws9uOAoK
         UvWA==
X-Gm-Message-State: AOAM532PC3k86bZHBffy4Y5t8wSnCaJNR0flAgN8xYCxvtZPQ5E05DBM
        gV0pLpfXrWuqF0VMzLDkfcvicMyfyHU8S2H0bV4aIA2cRCI=
X-Google-Smtp-Source: ABdhPJx+za7yvjtEOGs82SfNoIJ06p8nDAtIhJnWshOarUMCa64x/w6TPO7B0QLa3rbZbLqmZgMeJpKv8Yu6qj1gQCM=
X-Received: by 2002:a92:5214:: with SMTP id g20mr1212495ilb.260.1616125731645;
 Thu, 18 Mar 2021 20:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <92b7c57b-b645-9965-8157-4ca76a803cba@mev.co.uk>
 <20210316224227.348310-1-ztong0001@gmail.com> <8c65b02e-4315-153f-de2c-153862f195be@mev.co.uk>
In-Reply-To: <8c65b02e-4315-153f-de2c-153862f195be@mev.co.uk>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Thu, 18 Mar 2021 23:48:41 -0400
Message-ID: <CAA5qM4BvHNT9YboUnKXwQcqHVBMSiAXS16Y9ogLk+pHCk+O4FA@mail.gmail.com>
Subject: Re: [PATCH] staging: comedi: das800: fix request_irq() warn
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        devel@driverdev.osuosl.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you all,
I fixed the commit log and resent as v2.
Thanks,
- Tong

On Wed, Mar 17, 2021 at 8:48 AM Ian Abbott <abbotti@mev.co.uk> wrote:
>
> On 16/03/2021 22:42, Tong Zhang wrote:
> > request_irq() wont accept a name which contains slash so we need to
> > repalce it with something else -- otherwise it will trigger a warning
> > and the entry in /proc/irq/ will not be created
> > since the .name might be used by userspace and we don't want to break
> > userspace, so we are changing the parameters passed to request_irq()
> >
> > Suggested-by: Ian Abbott <abbotti@mev.co.uk>
> > Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> > ---
> >   drivers/staging/comedi/drivers/das800.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/comedi/drivers/das800.c b/drivers/staging/comedi/drivers/das800.c
> > index 2881808d6606..bc08324f422f 100644
> > --- a/drivers/staging/comedi/drivers/das800.c
> > +++ b/drivers/staging/comedi/drivers/das800.c
> > @@ -668,7 +668,7 @@ static int das800_attach(struct comedi_device *dev, struct comedi_devconfig *it)
> >       dev->board_name = board->name;
> >
> >       if (irq > 1 && irq <= 7) {
> > -             ret = request_irq(irq, das800_interrupt, 0, dev->board_name,
> > +             ret = request_irq(irq, das800_interrupt, 0, "das800",
> >                                 dev);
> >               if (ret == 0)
> >                       dev->irq = irq;
> >
>
> Looks good (apart from the minor spelling niggle spotted by Dan
> Carpenter), thanks!
>
> Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
>
> --
> -=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
> -=( registered in England & Wales.  Regd. number: 02862268.  )=-
> -=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
> -=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
