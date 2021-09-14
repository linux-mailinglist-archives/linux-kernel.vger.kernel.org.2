Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7886840A8A2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhINHv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbhINHvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:51:42 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F79C061D7E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:47:21 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id y16so26238720ybm.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=twA4k54DR1XC21StOFmDZzFZ+sd3DWgF5E9CDyEkCU8=;
        b=Ty4PkoKLBZwVPLC2TX10fKYHhH6PGv80LcA6Fb0BpQrZeKu+DQB3EzhglyL0L6mvuo
         3kO2wEoKMY7ao7gyawgUGvkrH19YbGr5Vpt0GZ+GJmJvS69Gtg0It2MqbPDNB7/RWgmb
         AnpUtRwIPwxFAi2USPk9u3dNPVa+q6TFmmN4c5GP/ek11NJvc+wbIvzXEx36ogmp6Pke
         Nn5BMcp/ZTsgcqoS3bbb1srZ3ZcakiAEvq+CGLr6o8QdlWUMXXBuB1EDlRjvW1ArgInx
         CwLYP4yvmYosCrz74mLzD3rOOAi8poFeN1jIP/IRc98pBzyUXFwnrGjmU+ylOejIT9ot
         Oe/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=twA4k54DR1XC21StOFmDZzFZ+sd3DWgF5E9CDyEkCU8=;
        b=381jSd4SM6Jz8Btzf1840zWwu/h2ZWJwd9HJIvBf/ECpAbZcbonM3h399leXEoqrW4
         dQgncWsSxZ3p4TcvaOggDH3HG9UDjHc/ER1sPopTtyIIOWQ/+bP3zcJNVubjh/tHFOAA
         MirysFbSPdfC3OjsQXQDbnMde+rHo6lNnsOZtqZSaR4NwVdIH31gJAClEhDXISmMGL6M
         kT0kO/V3q9Opal4LhA4wQAZCu8RlruD9GvMTMa1GiYp2nfQLDYw9RIQAdVUbR6TCR5xR
         MWhpqdxgV+S/L1r+qo+x9/xp0ffx26Q4LOQr6HcGlK+l0AHe0Q9nQOZJld8zCiyP+GrI
         bKKQ==
X-Gm-Message-State: AOAM5332m1hmXAt0g18JLyvNyELXqKmwhaeceB16dEg6hJXreJq7d6tl
        vjtUYKPDU+/dKiUpG5MD2wlt7h4ZdUhh6xN2gftzKA==
X-Google-Smtp-Source: ABdhPJwN86MvAtEfJh7vdsxFkEIPK5tuOTJgwF8g/iR8IAyH4GBmqV2HLNNEuS/tRFYlN0HwvDAdxlIznx1hMoG9k/M=
X-Received: by 2002:a25:af49:: with SMTP id c9mr17182208ybj.432.1631605640407;
 Tue, 14 Sep 2021 00:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210914043928.4066136-1-saravanak@google.com>
 <20210914043928.4066136-4-saravanak@google.com> <CAMuHMdViFMA4_k2Da=G2h3BWBdmwDJdh5pgRfbpUaoC_DHcmJA@mail.gmail.com>
In-Reply-To: <CAMuHMdViFMA4_k2Da=G2h3BWBdmwDJdh5pgRfbpUaoC_DHcmJA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 14 Sep 2021 00:46:44 -0700
Message-ID: <CAGETcx_mP96HdLN_5MEAkGNZJDiuhfZsMptSTHPoNfZnmS1QQA@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] driver core: Create __fwnode_link_del() helper function
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:05 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Tue, Sep 14, 2021 at 6:39 AM Saravana Kannan <saravanak@google.com> wrote:
> > The same code is repeated in multiple locations. Create a helper
> > function for it.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> Thanks for your patch!
>
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -101,6 +101,19 @@ int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)
> >         return ret;
> >  }
> >
> > +/**
> > + * __fwnode_link_del - Delete a link between two fwnode_handles.
> > + * @link: the fwnode_link to be deleted
> > + *
> > + * The fwnode_link_lock needs to be held when this function is called.
> > + */
> > +static void __fwnode_link_del(struct fwnode_link *link)
>
> Why the double underscore?

Because unlike fwnode_link_add(), this one needs the lock to be held.

-Saravana

>
> > +{
> > +       list_del(&link->s_hook);
> > +       list_del(&link->c_hook);
> > +       kfree(link);
> > +}
>
> Apart from that:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
