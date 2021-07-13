Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B292D3C76FE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 21:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbhGMThK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 15:37:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234411AbhGMThK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 15:37:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7A2D61362;
        Tue, 13 Jul 2021 19:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626204859;
        bh=q6UBDjtaa8NUUdqWJxCHFB88WzEYVPE9y9bs3xKd6rM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ix5wiJ0HBk1YpblazcZQ+oZzQ5JDBdl1e/ybkWlgcFqiq1b2ltmPmycs8KeLf3mgz
         ufdIv0JRv2ydfYiJVA5eqos0X88dphEFoZnIW/JUiRgjM7b2FhF2LDjrzxz06gslA8
         B8pF7NznuJCpLbwPEpulEQp1OpBCmpLBw+29OmU7ADW0xDBId+X+t2SnXijk8KUWqI
         3tqElFfqZ5huNr9tI6e3Kx9HIHDoDhOnQYZo0zEGrp6BBTK47ARG/7CuaO8pPsRX82
         u3/xU8wqO+l8m2eShd26LbI2PAnArSiMZWzqxrghZK7e7YT8DBgFZIY0tHYtdEk5z2
         vFTo27NYlmv5g==
Received: by mail-ej1-f48.google.com with SMTP id hc15so5019873ejc.4;
        Tue, 13 Jul 2021 12:34:19 -0700 (PDT)
X-Gm-Message-State: AOAM532seLs9amzSIPddZavb03KUCInoBqaRyuCu9yCi8Kam1tjTDQfp
        4mYuVKCvEyYqderLAgPFr6CPoC++iuiApdn0Bg==
X-Google-Smtp-Source: ABdhPJxebfXWfjPtG3UgTLJ2gamvHrDzok7Vep7WR5t4cjwuIyGWTbLDQS1ro3UlQYyKlYUIVu1iH/LjVjSActCgrf8=
X-Received: by 2002:a17:906:57d0:: with SMTP id u16mr7823954ejr.468.1626204858178;
 Tue, 13 Jul 2021 12:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626173013.git.viresh.kumar@linaro.org> <aa4bf68fdd13b885a6dc1b98f88834916d51d97d.1626173013.git.viresh.kumar@linaro.org>
 <CAL_Jsq+SiE+ciZfASHKUfLU1YMPfB43YmSciT_+gQHvL99_wUA@mail.gmail.com> <20210713151917.zouwfckidnjxvohn@vireshk-i7>
In-Reply-To: <20210713151917.zouwfckidnjxvohn@vireshk-i7>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 13 Jul 2021 13:34:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL9255n5RT=Gq_uru7rEP0bSVcyfXEPRY4F0M4S2HPvTA@mail.gmail.com>
Message-ID: <CAL_JsqL9255n5RT=Gq_uru7rEP0bSVcyfXEPRY4F0M4S2HPvTA@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: virtio: mmio: Add support for device subnode
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jie Deng <jie.deng@intel.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 9:19 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 13-07-21, 08:43, Rob Herring wrote:
> > On Tue, Jul 13, 2021 at 4:50 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > Allow virtio,mmio nodes to contain device specific subnodes. Since each
> > > virtio,mmio node can represent a single virtio device, each virtio node
> > > is allowed to contain a maximum of one device specific subnode.
> >
> > Doesn't sound like we need 2 nodes here. Just add I2C devices as child
> > nodes. You could add a more specific compatible string, but the
> > protocol is discoverable, so that shouldn't be necessary.
>
> I am not sure if it will be a problem, but you can clarify it better.
>
> The parent node (virtio,mmio) is used to create a platform device,
> virtio-mmio, (and so assigned as its of_node) and we create the
> virtio-device from probe() of this virtio-mmio device.
>
> Is it going to be a problem if two devices in kernel use the same
> of_node ?

There shouldn't be. We have nodes be multiple providers (e.g clocks
and resets) already.

> Are there cases where we would need to get the device
> pointer from the of_node ? Then we will have two here.

Rarely...

In any case, should these potential kernel issues be dictating the DT
binding design? No!

>
> > BTW, what's the usecase for these protocols? A standard interface to
> > firmware controlled I2C, GPIO, etc.?
>
> Right now we are looking to control devices in the host machine from
> guests. That's what Linaro's project stratos is doing. There are other
> people who want to use this for other kind of remote control stuff,
> maybe from firmware.

Project stratos means nothing to me.

Direct userspace access to I2C, GPIO, etc. has its issues, we're going
to repeat that with guests?

> > > diff --git a/include/dt-bindings/virtio/virtio_ids.h b/include/dt-bindings/virtio/virtio_ids.h
> > > new file mode 120000
> > > index 000000000000..6e59ba332216
> > > --- /dev/null
> > > +++ b/include/dt-bindings/virtio/virtio_ids.h
> > > @@ -0,0 +1 @@
> > > +../../uapi/linux/virtio_ids.h
> >
> > This will break the devicetree-rebasing tree I think. DT files
> > shouldn't reference kernel files.
>
> We already do this for linux-event-codes.h and so I thought it is the
> right way of doing it :)

Humm, maybe it's okay. Please double check then...

> Else we can create a new copy, which will be a mess, or use hardcoded
> values.

Though you may not need the header based on what Arnd and I have suggested.

Rob
