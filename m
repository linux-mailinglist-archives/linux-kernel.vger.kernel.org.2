Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333BC3DF5E4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 21:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240264AbhHCTpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 15:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239846AbhHCTpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 15:45:13 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D065FC061757;
        Tue,  3 Aug 2021 12:45:00 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c16so333634plh.7;
        Tue, 03 Aug 2021 12:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8s+MmA/qHz3tjAsYpfduXTI0kOc0Wc0OB3K3E0apMEk=;
        b=eZGznK5eTGBgC2T5FZbaIAOfJleUqd/DZ0ygxTSA0Oatv/5Geuy0hXgGUm8WbhpIAw
         2lExUZcC1ECZ+PYxOnpG2HWXiJti+npB32ewcdL10P+du1X81pmQ/P+tOqlrCddjK2b+
         00nMD2xYPHH36o9KLrpSmt5zlIjq1MBAKqClCA8TG0xwk4MoPmqn9Qj578zUNPGN1IVV
         UDCHTa3dB4JWSY2UONeoq6WpXnrGcx/LoigrOh0uQMmALSwX16Cxeh0QpJlGQLLzF7QK
         lTWLu51zY9kklvka6Vy1f2+6E7wCWUQGtrBZny6f70e4fhNwpx7FG6KdBpi7jCo4WIum
         OC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8s+MmA/qHz3tjAsYpfduXTI0kOc0Wc0OB3K3E0apMEk=;
        b=deR7T5378mJFuMgi0z/Cmc7+jwtCTCIhuOXV7tvTMxjoAysFlb8SQM93K2c4PC95Pm
         IoCXyhkMuV+eQnRiZpfPIDX4+48SzUuchazqlrW0dEkFKXTLwN2EsTV7heRK5QejeDhb
         mQTJSmCmZvj/jruGpcqJzb3oNwKeEFozW1HPP0uk4AneEv0Lj4IFIFt0LD+w4Jlz8O5u
         +2ipPvbl4JSwGHAkQZ890OFITm9otaQizuC64cD2b7Xg9cvnFxNiLCOd0u8oEAuhxk+7
         6CQDGKL2bI+AhUyq3bQzenU6Sxt5gruPYobkudkej0/H5HpUmDJNW9iYsHRGOUM7BQtS
         S5zQ==
X-Gm-Message-State: AOAM533Ty+1e0+fDHytqgRXogBwRENmraGgYy4lVP7/PRI4EoPCoGVEX
        u7/7/iEAqR5/in92VT+43Qs=
X-Google-Smtp-Source: ABdhPJwOubPY+Lb8SaQNJyh/p/6fRHt3H6WREwpmuOLAUVRoQAJcY8we4yKoboMePWa/bvdsTGreDg==
X-Received: by 2002:aa7:8e51:0:b029:332:920f:1430 with SMTP id d17-20020aa78e510000b0290332920f1430mr24172092pfr.1.1628019900381;
        Tue, 03 Aug 2021 12:45:00 -0700 (PDT)
Received: from localhost ([2405:201:2003:b021:6001:8ce1:3e29:705e])
        by smtp.gmail.com with ESMTPSA id g27sm18631635pgl.19.2021.08.03.12.44.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Aug 2021 12:44:59 -0700 (PDT)
Date:   Wed, 4 Aug 2021 01:14:54 +0530
From:   Raag Jadav <raagjadav@gmail.com>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ls1046a: fix eeprom entries
Message-ID: <20210803194454.GA9471@localhost>
References: <1627927742-8675-1-git-send-email-raagjadav@gmail.com>
 <CADRPPNQ2M1N1pV2brfFRXOf1ASK2bhiZpQivNhNws_+RUfCT-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADRPPNQ2M1N1pV2brfFRXOf1ASK2bhiZpQivNhNws_+RUfCT-g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 05:44:29PM -0500, Li Yang wrote:
> On Mon, Aug 2, 2021 at 1:10 PM Raag Jadav <raagjadav@gmail.com> wrote:
> >
> > ls1046afrwy and ls1046ardb boards have CAT24C04[1] and CAT24C05[2]
> > eeproms respectively. Both are 4Kb (512 bytes) in size.
> 
> These part names are from onsemi instead of atmel.  Are there same
> part names from atmel which are also compatible with the onsemi parts?

The part names are different, but they are functionally compatible.

>  If we want to use onsemi only part names, probably we will need two
> compatible strings with the first one from onsemi and the second from
> atmel.  Although the binding doesn't support onsemi prefix yet.

Should I add it to the at24 binding document with atmel as a fallback?

> 
> > Remove multi-address entries, as we have auto-rollover support
> > in at24 driver.
> 
> The device tree should describe hardware instead of matching how
> driver deal with it.  Is the board really using a single chip or
> multiple chips here?

Yes, both the boards have a single chip each.

> 
> >
> > [1] https://www.onsemi.com/pdf/datasheet/cat24c01-d.pdf
> > [2] https://www.onsemi.com/pdf/datasheet/cat24c03-d.pdf
> >
> > Signed-off-by: Raag Jadav <raagjadav@gmail.com>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts | 8 +-------
> >  arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts  | 7 +------
> >  2 files changed, 2 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts
> > index db3d303..83afe21 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts
> > @@ -83,15 +83,9 @@
> >                         };
> >
> >                         eeprom@52 {
> > -                               compatible = "atmel,24c512";
> > +                               compatible = "atmel,24c04";
> >                                 reg = <0x52>;
> >                         };
> > -
> > -                       eeprom@53 {
> > -                               compatible = "atmel,24c512";
> > -                               reg = <0x53>;
> > -                       };
> > -
> >                 };
> >         };
> >  };
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
> > index 60acdf0..d220f98 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
> > @@ -59,14 +59,9 @@
> >         };
> >
> >         eeprom@52 {
> > -               compatible = "atmel,24c512";
> > +               compatible = "atmel,24c04";
> >                 reg = <0x52>;
> >         };
> > -
> > -       eeprom@53 {
> > -               compatible = "atmel,24c512";
> > -               reg = <0x53>;
> > -       };
> >  };
> >
> >  &i2c3 {
> > --
> > 2.7.4
> >
