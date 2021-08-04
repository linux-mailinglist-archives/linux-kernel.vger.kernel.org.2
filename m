Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798A93DFA21
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 05:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbhHDD4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 23:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbhHDD4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 23:56:21 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF88C0613D5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 20:56:08 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id w17so1999922ybl.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 20:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hj9+DJIOL+JCNgd1VkxAemug2Cv7GpybntcyarY0768=;
        b=E0W3PWSjR4jT3BElR92k5+zvvDnXGjBWFFwzmkloJRPzJc6WpqAKZVrEBLsr4OjVdN
         2wL/Gz+EeOaee78kFE1O1oCeXY7gKcYpLGfj6Rf5EoXpg6dr6SQZ3rke/Y50Net7cdqy
         817/hDiNPCFDrD9Arr91OFqa23801NnJn+ALmH1X3IVJMaGKoeqhz+2PPYXh/yQv6U60
         jL+vW/UvMvn6DXkOVYFukc/CSzk+7Ex/yCYYcSKK6lXP5u3kZu/YtFGdujY9Kgj2/uoM
         Ck18mKbkUd7F/5ltfWRSRHCGd+iR2XZM0NbCYtCnwU2CC+tJNJUY3ImfO//Y1Nlm0pU0
         YoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hj9+DJIOL+JCNgd1VkxAemug2Cv7GpybntcyarY0768=;
        b=DDMnDuO67tWvTWA3CksU1Fw1IaogRBGle9zvhUx3CwgSIIF6qGjNmcBrCVC1MAb5i3
         n4d9nvisi3asPzS/WQtTERnGYeeY8XtanSo+/4UOYfN4dfWFsQyPbcEu+VUzf18IuHQZ
         W/M3b+jbQ2iY9D4CZATAr0d426diYhJpqVVqjCZItCJzInMvBAGNKbnX9xh2S3G870r0
         Kx37RZgXOGQlruyfWRN6bY/E67GWa5TdIffznKIW49BgEOLX8VIY3i+na+bQRCRFnnKs
         ABtYuAp9wMdnfEa9w6WMIN6pN7e9axO33iCFSdJOsNNyrW2xQcebCg4ZAH1zICOZ7zI9
         E8ig==
X-Gm-Message-State: AOAM531L+TM0htcd4Xe9TDTUHiXjbYoK6YcA3XxWPCYrlvTYi6sIZEDQ
        5B1I8qqsdBH1BVFzrJl/nxBRhtEgkHgHU97xR502pRz3MOg=
X-Google-Smtp-Source: ABdhPJx3en8bRJvYJfxOe+A265Py6kZ7FGMVnudWfWIB8827KDnvPcOVdwtTwkOc73ffzGgj6IjkV/A2PqBYvuHOAUU=
X-Received: by 2002:a25:be09:: with SMTP id h9mr34942719ybk.239.1628049367867;
 Tue, 03 Aug 2021 20:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdVfRSGQcBQEFVbUZjoRBKHxPJnbXkddZvF8vcSDQ1v5jg@mail.gmail.com>
 <mhng-78538c33-fe7b-4eea-83c7-5dfe4f5824d1@palmerdabbelt-glaptop>
In-Reply-To: <mhng-78538c33-fe7b-4eea-83c7-5dfe4f5824d1@palmerdabbelt-glaptop>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Wed, 4 Aug 2021 11:55:56 +0800
Message-ID: <CAEUhbmUkuKd7itzvQyzrYeqfUQv6LCqkXDsO=yufQppDBceLQQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: dts: microchip: Add ethernet0 to the aliases node
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 4, 2021 at 11:55 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Fri, 16 Jul 2021 04:34:02 PDT (-0700), geert@linux-m68k.org wrote:
> > Hi Bin,
> >
> > On Fri, Jul 16, 2021 at 12:14 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >> On Fri, Jul 16, 2021 at 5:23 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >> > On Fri, Jul 2, 2021 at 3:44 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >> > > --- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> >> > > +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> >> > > @@ -9,6 +9,10 @@ / {
> >> > >         model = "Microchip MPFS Icicle Kit";
> >> > >         compatible = "microchip,mpfs-icicle-kit";
> >> > >
> >> > > +       aliases {
> >> > > +               ethernet0 = &emac1;
> >> > > +       };
> >> > > +
> >> > >         chosen {
> >> > >         };
> >> >
> >> > This should be added to the board DTS (microchip-mpfs-icicle-kit.dts)
> >> > instead.
> >>
> >> I was wondering the same thing before doing this, but when I checked
> >> all other DTS in arch/riscv/boot I found the aliases node is put in
> >> the SoC dtsi file instead of the board on so I think that's the
> >> convention.
> >
> > The numbering of the aliases is supposed to match the labels on the
> > board, hence it is board-specific, not SoC-specific.
> >
> > Gr{oetje,eeting}s,
> >
> >                         Geert
>
> I don't see a v2 of this.

Will send v2 soon.

Regards,
Bin
