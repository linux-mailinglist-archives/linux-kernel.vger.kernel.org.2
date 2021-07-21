Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0BC3D1100
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 16:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237574AbhGUNgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 09:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237656AbhGUNgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:36:25 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC94C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 07:17:00 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id h9so3221257ljm.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 07:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aMtC4XryKwhDIhZBjGDMT7qXwIITt0vl4IftwTuf1DM=;
        b=tn/yPrq9tTMLPjmD5TbZ/iy3AJo6Mi9l2gxxljL5HEUbxMPZdG3RxSjQwM44qEg1Ay
         ZSQoJ5VmiOWW4F6UY9kJyxELMnSWBgyrkKbQsc6D1cDjQNL0hgLdX0kWHGd5GZ4faBF2
         BgkanG1I+E8lutJDzpQZ2fecWYN60jF1fRQYhx/4PhqUMW0FiAfl+lnJ7H3zb9yI3mxo
         ve+3VAybuaeninHAl/dsVNjemwEUlUw0kquk8MkxSCod74oz+6KmpuIpHsAbGyCRXlsP
         MAan1nHL+ko3XcitUB2qAlOM1tT6B29gN95vPLIRWqeSZymxrUpub7/K7xNOD1FSCw9z
         BGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aMtC4XryKwhDIhZBjGDMT7qXwIITt0vl4IftwTuf1DM=;
        b=aSMAYFzADJY/g2c2SK4vEn+esTKtA7D9bKm0Ymj1PhVZewnxYj2pBzZ0vqkGwqruxy
         0AUA5LsBuOA42sCxQ1ch0GwiICkJvr6Oa/skpiXcLrY6nRWPsWXz4E0PzikjlpAIDjbD
         zhUAA9Q4l0XQLd2wycz1s7oesA+fTv/vQwtA4zbK4esVdfI1oLyPuMzH/TLujvu5J8s3
         Fnrdi2RGZhCB05NnCKqtpD3/WXrETm14kW24rlToO28kzSqBnvMCK5Q4uDFiwj2R85MG
         Dtkm01zQbHbFnI09dYX+4DzwOvvyhXQBB6Rr8bIrMPVPrIvc1sBXyn6Q/mV4jNDG0N98
         s00w==
X-Gm-Message-State: AOAM5328REEMV/6/Y1OnIeaW9AtZZkDSIawCipE5UYnwM5qw3fvSQpaG
        M4sB/jSR9NSOhKqjhTbhguVUJgK00MnjF6T0SjcVLQ==
X-Google-Smtp-Source: ABdhPJzpjzfCxuW9+8M52jHB3ZIgsPbzyBIakbaMW5R54JJyEfDj0/89vRmJI8EUQas2w0+VtPllFSyf5+6xQuZ8ilo=
X-Received: by 2002:a2e:950:: with SMTP id 77mr31532430ljj.438.1626877019230;
 Wed, 21 Jul 2021 07:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210607123317.3242031-1-robert.marko@sartura.hr>
 <20210607123317.3242031-5-robert.marko@sartura.hr> <CA+HBbNH7wcpfQOX2=vZmW78GoWy_WL3Pz-dMKe0N0ebZDp+oUw@mail.gmail.com>
 <20210713222528.GA952399@robh.at.kernel.org> <CA+HBbNFj5+6sLKxmL8XtsZQ48ch8OjTbJ1bwkDC8dfRiOyWY1Q@mail.gmail.com>
 <20210719225906.GA2769608@robh.at.kernel.org>
In-Reply-To: <20210719225906.GA2769608@robh.at.kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 21 Jul 2021 16:16:48 +0200
Message-ID: <CACRpkdbq6Jow6AT9OpsR7Q0JVCWVMcmamh9KHPXMtUnkoe7ZFw@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] dt-bindings: mfd: Add Delta TN48M CPLD drivers bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luka Perkov <luka.perkov@sartura.hr>, jmp@epiphyte.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Donald Buczek <buczek@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 12:59 AM Rob Herring <robh@kernel.org> wrote:

> > > > Are there any issues with the bindings?
> > >
> > > Yes. Primarily the GPIO function being part of the compatible. I'm
> > > surprised Linus W is okay with that.
> >
> > I think I already explained this before, having a single compatible
> > won't work here.
> > Then there would not be anything to know whether its input or output
> > only as the pins
> > have specific purpose.
>
> The client side should tell the direction. Are you using the SFP
> binding?: Documentation/devicetree/bindings/net/sff,sfp.txt
>
> Specific purpose IOs are not general purpose IOs. Repeating Linus W
> here. Maybe his opinion has evolved...

Nah. I think at one time or two I was convinced to let something
special purpose slip through as "GPIO".

Typical case: LED control lines that were in practice used for other
things, such as controlling motors.

Here there is a pin named "SFP TX disable" which is suspicious.
Why isn't whatever is now managing SFP just read/write this bit
without going through the GPIO abstraction to disable TX?

If it is a regmap in Linux then that is fine, just pass the regmap
around inside the kernel, OK finished. But really that is an OS
detail.

If the pin is in practice used for other things, say connected
to a LED, I would soften up and accept it as a GPIO compatible.

> If the programming model of each instance is different, then different
> compatibles are justified. But describe what the difference is, not the
> connection.

IIRC that is the case as the instances are different.

So those differences should be described for each compatible in the
bindings.

So there is this:

> +  GPIO controller module provides GPIO-s for the SFP slots.
> +  It is split into 3 controllers, one output only for the SFP TX disable
> +  pins, one input only for the SFP present pins and one input only for
> +  the SFP LOS pins.

This should read "the hardware instances are different in such way
that the first can only (by hardware restrictions) be used as output..."
etc, so that it is crystal clear what this means.

But if the lines are special purpose not general purpose, they
should not be GPIOs to begin with.

Yours,
Linus Walleij
