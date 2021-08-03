Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA473DF7BB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 00:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhHCWUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 18:20:51 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:43716 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhHCWUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 18:20:50 -0400
Received: by mail-qt1-f176.google.com with SMTP id k13so185371qth.10;
        Tue, 03 Aug 2021 15:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EwbBrIO14cWrGFlqXqpRuBpDy0CP5afPXaLjh9xefQM=;
        b=ljKRAZzxux7Mtyl/x0cBE1OxeJCvOwN8wERhN7uGcOP95N74UQMCTJnatzd4N+YRNh
         OHsDE6/AqZ4mB5HnacX/dYETw4WGOPholRg9cbCjcNqtQS/IilEVqJPtgQ2/QQYjFZyf
         BZDjtmLMcBsNBCRcrmEs832oKvXJ9+5uTQ5zo9S5zn15lsk6bhfwovgBKhfxUFSbVUAa
         CQeJKmdPVPiLqbNpQ8To7FKVq/0xidAEYCi2H7Cnb/hcO//QoUyKdYJtD6+g9J7fPd5V
         ViFrqBPMPfho3AP6C3rruHDLIJ/pN83CWgoaRWSxAVt6UiLt3lm1NWvsvZ4Am+B4Qygc
         9czg==
X-Gm-Message-State: AOAM533pJiogg7iBKk25Mu/dHk3AB981lcNV7agsC5wjXiVlXd2JkSgc
        yUgrTh6+n3f1EL7HfgFLYJ0CTHpdR9k=
X-Google-Smtp-Source: ABdhPJyqqs1c3WywfIrdVuuCMMr3TwsNcYkuMe1E3+xiCyy5EEYTz++ED75z1cOa4MCYcYQ1rP6j6A==
X-Received: by 2002:ac8:7305:: with SMTP id x5mr20507532qto.270.1628029237953;
        Tue, 03 Aug 2021 15:20:37 -0700 (PDT)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com. [209.85.222.175])
        by smtp.gmail.com with ESMTPSA id f62sm172414qke.135.2021.08.03.15.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 15:20:37 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id e14so960106qkg.3;
        Tue, 03 Aug 2021 15:20:37 -0700 (PDT)
X-Received: by 2002:a37:9f0c:: with SMTP id i12mr3900923qke.273.1628029236841;
 Tue, 03 Aug 2021 15:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <1627927742-8675-1-git-send-email-raagjadav@gmail.com>
 <CADRPPNQ2M1N1pV2brfFRXOf1ASK2bhiZpQivNhNws_+RUfCT-g@mail.gmail.com> <20210803194454.GA9471@localhost>
In-Reply-To: <20210803194454.GA9471@localhost>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 3 Aug 2021 17:20:25 -0500
X-Gmail-Original-Message-ID: <CADRPPNSbzpqs2VOV6DMUF5VP1Gx=W9-2W91Rt9ELEZxT+xsgvA@mail.gmail.com>
Message-ID: <CADRPPNSbzpqs2VOV6DMUF5VP1Gx=W9-2W91Rt9ELEZxT+xsgvA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: ls1046a: fix eeprom entries
To:     Raag Jadav <raagjadav@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 2:45 PM Raag Jadav <raagjadav@gmail.com> wrote:
>
> On Mon, Aug 02, 2021 at 05:44:29PM -0500, Li Yang wrote:
> > On Mon, Aug 2, 2021 at 1:10 PM Raag Jadav <raagjadav@gmail.com> wrote:
> > >
> > > ls1046afrwy and ls1046ardb boards have CAT24C04[1] and CAT24C05[2]
> > > eeproms respectively. Both are 4Kb (512 bytes) in size.
> >
> > These part names are from onsemi instead of atmel.  Are there same
> > part names from atmel which are also compatible with the onsemi parts?
>
> The part names are different, but they are functionally compatible.
>
> >  If we want to use onsemi only part names, probably we will need two
> > compatible strings with the first one from onsemi and the second from
> > atmel.  Although the binding doesn't support onsemi prefix yet.
>
> Should I add it to the at24 binding document with atmel as a fallback?

I think that will be the best.

>
> >
> > > Remove multi-address entries, as we have auto-rollover support
> > > in at24 driver.
> >
> > The device tree should describe hardware instead of matching how
> > driver deal with it.  Is the board really using a single chip or
> > multiple chips here?
>
> Yes, both the boards have a single chip each.

Then I am fine with the change, but please make it clear in the description.

>
> >
> > >
> > > [1] https://www.onsemi.com/pdf/datasheet/cat24c01-d.pdf
> > > [2] https://www.onsemi.com/pdf/datasheet/cat24c03-d.pdf
> > >
> > > Signed-off-by: Raag Jadav <raagjadav@gmail.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts | 8 +-------
> > >  arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts  | 7 +------
> > >  2 files changed, 2 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts
> > > index db3d303..83afe21 100644
> > > --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts
> > > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts
> > > @@ -83,15 +83,9 @@
> > >                         };
> > >
> > >                         eeprom@52 {
> > > -                               compatible = "atmel,24c512";
> > > +                               compatible = "atmel,24c04";
> > >                                 reg = <0x52>;
> > >                         };
> > > -
> > > -                       eeprom@53 {
> > > -                               compatible = "atmel,24c512";
> > > -                               reg = <0x53>;
> > > -                       };
> > > -
> > >                 };
> > >         };
> > >  };
> > > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
> > > index 60acdf0..d220f98 100644
> > > --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
> > > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
> > > @@ -59,14 +59,9 @@
> > >         };
> > >
> > >         eeprom@52 {
> > > -               compatible = "atmel,24c512";
> > > +               compatible = "atmel,24c04";
> > >                 reg = <0x52>;
> > >         };
> > > -
> > > -       eeprom@53 {
> > > -               compatible = "atmel,24c512";
> > > -               reg = <0x53>;
> > > -       };
> > >  };
> > >
> > >  &i2c3 {
> > > --
> > > 2.7.4
> > >
