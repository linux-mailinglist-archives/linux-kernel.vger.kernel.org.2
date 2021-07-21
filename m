Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7663D0A68
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 10:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbhGUHeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236196AbhGUH2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:28:50 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BBCC0613E9;
        Wed, 21 Jul 2021 01:09:15 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id a7so1580763iln.6;
        Wed, 21 Jul 2021 01:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=nnkwypyGGg2lIAlmn1bPoLA/AT7fY2p5wjrBTzzARl8=;
        b=hs0y+4913dnb3lcozRBpL/0RyQCg9I7uzJnbJZz8c7BR4+Kuu7lo72IfaB/EYPsjjY
         KRrkbTYhT7FEFtrqCST79Jw/YG9OU3YTkBlwc02Y1FUqi8U4TpjAFa3haW7PZIftePRE
         Bg1nPosBLFL/51NONNW0rbSy9UlEkOejEIzAG5jFRnrJD7U/2X1LaW3uU0IlF+qKX8Qq
         etZ+xF3tCItVfSAxaj8zTDPomWmtqjOWYRDkRy5ig9ekKCTZfhsDDloJ74cBaKhnAPCi
         DAubd9l7Gi072V5d8XrHy8kBAf7dkteXBci4xUY9VIZzFUNVVbOQjD0bwP8iG3Yjqmqa
         IDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=nnkwypyGGg2lIAlmn1bPoLA/AT7fY2p5wjrBTzzARl8=;
        b=ldh98r2du1wd0MByoh8tHxTTMYVyA0TQdS8B6kZfP30glS63wn47pFex3WEE1uKMp9
         hZ1ra0g7eM4+LekecHg1voOuDWkR3JSs1TcxzFQb45QVtIq5nHO65waHfw1Glsn3o2Gw
         uwiq0xGhHgXhuCsXeFEEowbRyRA1M1PaQ/lnPlRBIaC8+6FEcXKvOmX8pDMJFVAoPrkH
         r7qoip1Pjd6SOYmhaZpePluQTXYZdf6l4aEGLRBgipxJBLb+y4WWd/Ko2ZnoEoO5sA4Y
         XgrWg8P3H8zsTJAPQ6O+Q09ANVFNif3qnXAwCWWHEAcPOAqdKCNyMIGYkXUrredwZyPn
         qzYg==
X-Gm-Message-State: AOAM530DsG/vvKuwAHHWJJcDLNH3bsZKpYuA5wYM4QW6PogbDPa/eh3H
        DpgPlil0/APIuv2n4KHy1pzZaffPVVmvlJ30kaypg4iY8y/TGw==
X-Google-Smtp-Source: ABdhPJwnbPqWbPgibT/dnsgnl4iijNPWvfnWGahqwD5gtd8HBLt9g+YmgheZWQDsqArk2YwB1EzTg1LI8+S8cPJGfVg=
X-Received: by 2002:a05:6e02:12ab:: with SMTP id f11mr2378907ilr.200.1626854954887;
 Wed, 21 Jul 2021 01:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <1626430843-23823-1-git-send-email-dillon.minfei@gmail.com>
 <1626430843-23823-2-git-send-email-dillon.minfei@gmail.com>
 <CACRpkdbkOY08THPsPHfOOMeToHGXZvN2DBoKG9+WHeke9jypzQ@mail.gmail.com> <CAL9mu0JufzC_2p+X0PHdEpuYUqCNJ6XoT+f18oEsRa5Wm7wS3g@mail.gmail.com>
In-Reply-To: <CAL9mu0JufzC_2p+X0PHdEpuYUqCNJ6XoT+f18oEsRa5Wm7wS3g@mail.gmail.com>
From:   Dillon Min <dillon.minfei@gmail.com>
Date:   Wed, 21 Jul 2021 16:08:38 +0800
Message-ID: <CAL9mu0KGndejkS5joUGqTSfCASWCZeAmDpsCawPZhginFCE-Ow@mail.gmail.com>
Subject: Fwd: [PATCH 1/2] dt-bindings: display: panel: Add ilitek ili9341
 panel bindings
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Thanks for your detailed reply.

On Sun, 18 Jul 2021 at 08:17, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Hi Dillon,
>
> thanks for your patch!
>
> On Fri, Jul 16, 2021 at 12:20 PM <dillon.minfei@gmail.com> wrote:
>
> > From: Dillon Min <dillon.minfei@gmail.com>
> >
> > Add documentation for "ilitek,ili9341" panel.
> >
> > Signed-off-by: Dillon Min <dillon.minfei@gmail.com>
>
> > +  dc-gpios:
> > +    maxItems: 1
> > +    description: Display data/command selection (D/CX)
>
> This is a DBI feature so mention in the description that this is a
> DBI panel.


Okay, I will add the DBI panel to v2.

>
>
> > +  spi-3wire: true
> > +
> > +  spi-max-frequency:
> > +    const: 10000000
> > +
> > +  port: true
> > +
> > +additionalProperties: false
>
> Please add regulator supplies for the power lines, it's fine
> not to implement code handling them in the driver but they
> should be in the bindings.
>
> For the ili9341 it should be
>
>   vci-supply:
>     description: Analog voltage supply (2.5 .. 3.3V)
>
>   vddi-supply:
>     description: Voltage supply for interface logic (1.65 .. 3.3 V)
>
>   vddi-led-supply:
>     description: Voltage supply for the LED driver (1.65 .. 3.3 V)
>

Thanks so much, I will add it to v2.

>
> Yours,
> Linus Walleij
