Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD8A4276D0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 05:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244153AbhJIDKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 23:10:45 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:35451 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244114AbhJIDKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 23:10:43 -0400
Received: by mail-qt1-f171.google.com with SMTP id c20so11406180qtb.2;
        Fri, 08 Oct 2021 20:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5iBW8enG5P/ibkm90qNSFxEoHvUjFVD81D0eZ92k/AY=;
        b=OTa82kit4DXanlZKYJ/G8KZp7blCgk7qWf8sJBSxOeRiOKitxrPTaffigcQhNjLvz5
         fwFCTw3AGqTx2/IyaXFqYrBQarQPaGz0ObZE+RoWlNAd3dx52l31J4s5SW1WM9heEBaU
         HLVF3mS57OuUtxuX++R+d0CydZzHFxPK9K1r56ROQBMCD351iSkYYZCgkQsY3u9XSvwY
         IHp04H57DsM/JggwjZjUxlaxVnT59kD5o455sh9WXg7tvjQLKulxm+/nU7ZMqT5OvG6x
         NmbKl+9Fo3L4OHH/Lyh6eXD54831celn0SrabYtaKTRBg1CrSHb8Q1rSNFSmNSYVUNmL
         Oi2w==
X-Gm-Message-State: AOAM532Ug473DbINgBH+kJVJO9MbbbC+qKusoH8xVi9+MD7cVPS6SZD5
        Valb+Pbb3zVacnVUHacIBaQ8brrOcxw=
X-Google-Smtp-Source: ABdhPJx0NRKdaUAzs4GvF8mZCylSLo5o4Mbtkwj3pFvyT0R1HPNc/QGOECjFye1gfYCK7KjuFgIbsg==
X-Received: by 2002:ac8:5755:: with SMTP id 21mr1969626qtx.353.1633748926416;
        Fri, 08 Oct 2021 20:08:46 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id h8sm902367qkk.11.2021.10.08.20.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 20:08:46 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id b12so3332335qtq.3;
        Fri, 08 Oct 2021 20:08:45 -0700 (PDT)
X-Received: by 2002:a05:622a:209:: with SMTP id b9mr2044865qtx.28.1633748925581;
 Fri, 08 Oct 2021 20:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211001000417.15334-1-leoyang.li@nxp.com> <20211001000417.15334-3-leoyang.li@nxp.com>
 <CAL_JsqJShTL4zf2Bh=fYHfsujKu1rtuduxp7EKYsRqEXdkLCEA@mail.gmail.com>
 <CADRPPNRhVuHTxTpU8RCBMMTVe2V23pjqt8Z5vV=5efepWk6yPg@mail.gmail.com> <YWDEESYAuQSIfOSQ@robh.at.kernel.org>
In-Reply-To: <YWDEESYAuQSIfOSQ@robh.at.kernel.org>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 8 Oct 2021 22:08:34 -0500
X-Gmail-Original-Message-ID: <CADRPPNSxLaG1WcxKY-KtBwJON51Rg5-euJNJnJObarjEKN2eSA@mail.gmail.com>
Message-ID: <CADRPPNSxLaG1WcxKY-KtBwJON51Rg5-euJNJnJObarjEKN2eSA@mail.gmail.com>
Subject: Re: [PATCH v2 02/16] dt-bindings: i2c: imx: update schema to align
 with original txt binding
To:     Rob Herring <robh@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 5:20 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Oct 01, 2021 at 12:37:54PM -0500, Li Yang wrote:
> > On Fri, Oct 1, 2021 at 8:24 AM Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > On Thu, Sep 30, 2021 at 7:04 PM Li Yang <leoyang.li@nxp.com> wrote:
> > > >
> > > > When the binding was converted from txt to yaml, it actually added more
> > > > constrains than the original txt binding which was already used in many
> > > > in-tree DTSes.  Some of the newly added constrains are either not valid
> > > > or not neccessary.
> > >
> > > IMO, both of these should be fixed in the dts files.
> > >
> > > > Not all SoCs use ipg as the clock name for i2c.  There is no point in
> > > > having SoC integration information defined in i2c binding.  Remove the
> > > > clock name requirement in the schema.
> > >
> > > Any name you want is not fine. Your choices are remove clock-names,
> > > add all the names used, or change everyone to use 'ipg'.
> >
> > I understand that the name should be important as clocks are
> > referenced by name.  But since the i2c controller only has one clock ,
> > the name is never referenced in the driver.
>
> Then just remove 'clock-names' from the dts file.

Had thought the clock-names are mandatory, but it turns out not.
Removing it should be great.

>
> > If we really want to define the name, IMO, it should be from the
> > perspective of the i2c controller like "clkin" or "i2c" instead of the
> > "ipg" from the perspective of SoC integration which could be changing
> > with a different integration.  I can list both "i2c" and "ipg" for now
> > as a workaround though.
>
> $modulename for $foo-names always looks made up and pointless to me.
>
> >
> > >
> > > > The original txt binding didn't require the order of tx and rx for
> > > > dmas/dma-names.  Many in tree DTSes are already using the other order.
> > > > Both orders should just work fine.  Update the schema to allow both.
> > >
> > > Doesn't sound like a case where defining the order is challenging.
> >
> > No, it is not challenging.  But as dma channel is only referenced by
> > name instead of index.  I don't see too much benefit in enforcing the
> > order other than easier to create the schema.
>
> Easier is nice, and that's the 'DT way' is the other reason.

Ok.

Regards,
Leo
