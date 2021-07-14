Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75A93C87E1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 17:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239554AbhGNPq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 11:46:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232318AbhGNPqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 11:46:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6831613C8;
        Wed, 14 Jul 2021 15:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626277413;
        bh=/Hc6tz85MTUadhdIRSG2oaN3rM7XRWUzy2dI1TVpQNU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ckDkrimm+MK/okCfOz5+C1/IGeSHPSaA4wAdG/WJ6m9CM7AJEABcRoubzKwcWY8lm
         5OA6EG3Bwvw3tTkmY4v9yS+LFU+1nQPq4V3RDu5L04CWVJBfGf1MqZM65YVk+VLkTp
         pomV+O2fmWbejjx5bAVzu7ACeO34xtpEwMW8/bGbZy/+fg4t6UHcKpVKBzSETidfng
         4kBQ+frsxb7+h2LMLQAsPIWHR/nbvDcoDIWWi+fwFcNDoD95QUx+UJfD4j626w4Dp+
         mVx3D19y8hyJS4dBVavrXcRLvwSF+isb4i+IV/U1sKyWkGaBtvbUyJG9Di0tD/FPd3
         5ZTX60eJ8+tGw==
Received: by mail-ej1-f41.google.com with SMTP id hc15so4071020ejc.4;
        Wed, 14 Jul 2021 08:43:33 -0700 (PDT)
X-Gm-Message-State: AOAM533t/RxdGyrgmwyMJIm4JDAhGxhUmWG/QMoLrOWmPPs0ofEYdym9
        AOU8T69+MVt3Td97zOtIDI4ylUZ9Y5tK5FqdoQ==
X-Google-Smtp-Source: ABdhPJzMA2/c1kwXXfJV0KwSIgHuC8FkqivEpe59TEvEKJgJDyWLdmKNNJ3+1Mw5Fuv3WHmBfdjEupGaJ+DBVGPgWVQ=
X-Received: by 2002:a17:907:5096:: with SMTP id fv22mr12588246ejc.525.1626277412327;
 Wed, 14 Jul 2021 08:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626173013.git.viresh.kumar@linaro.org> <aa4bf68fdd13b885a6dc1b98f88834916d51d97d.1626173013.git.viresh.kumar@linaro.org>
 <CAL_Jsq+SiE+ciZfASHKUfLU1YMPfB43YmSciT_+gQHvL99_wUA@mail.gmail.com>
 <20210713151917.zouwfckidnjxvohn@vireshk-i7> <CAL_JsqL9255n5RT=Gq_uru7rEP0bSVcyfXEPRY4F0M4S2HPvTA@mail.gmail.com>
 <CAK8P3a3Gve=M9GF-E+2OJED1Hd1qngxOkVSO15wB0jVWK8D0_Q@mail.gmail.com>
In-Reply-To: <CAK8P3a3Gve=M9GF-E+2OJED1Hd1qngxOkVSO15wB0jVWK8D0_Q@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 14 Jul 2021 09:43:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKLjFx9AOcMiyxdQvDU7V8Sak8YPyrJm2TuSE-TTqvREw@mail.gmail.com>
Message-ID: <CAL_JsqKLjFx9AOcMiyxdQvDU7V8Sak8YPyrJm2TuSE-TTqvREw@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: virtio: mmio: Add support for device subnode
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jie Deng <jie.deng@intel.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 2:34 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Tue, Jul 13, 2021 at 9:35 PM Rob Herring <robh+dt@kernel.org> wrote:
> > On Tue, Jul 13, 2021 at 9:19 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 13-07-21, 08:43, Rob Herring wrote:
> > > > On Tue, Jul 13, 2021 at 4:50 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > >
> > > > > Allow virtio,mmio nodes to contain device specific subnodes. Since each
> > > > > virtio,mmio node can represent a single virtio device, each virtio node
> > > > > is allowed to contain a maximum of one device specific subnode.
> > > >
> > > > Doesn't sound like we need 2 nodes here. Just add I2C devices as child
> > > > nodes. You could add a more specific compatible string, but the
> > > > protocol is discoverable, so that shouldn't be necessary.
> > >
> > > I am not sure if it will be a problem, but you can clarify it better.
> >
> > > The parent node (virtio,mmio) is used to create a platform device,
> > > virtio-mmio, (and so assigned as its of_node) and we create the
> > > virtio-device from probe() of this virtio-mmio device.
> > >
> > > Is it going to be a problem if two devices in kernel use the same
> > > of_node ?
> >
> > There shouldn't be. We have nodes be multiple providers (e.g clocks
> > and resets) already.
>
> I think this would be a little different, but it can still work. There is in
> fact already some precedent of doing this, with Jean-Philippe's virtio-iommu
> binding, which is documented in both
>
> Documentation/devicetree/bindings/virtio/iommu.txt
> Documentation/devicetree/bindings/virtio/mmio.txt
>
> Unfortunately, those are still slightly different from where I think we should
> be going here, but it's probably close enough to fit into the general
> system.
>
> What we have with virtio-iommu is two special hacks:
>  - on virtio-mmio, a node with 'compatible="virtio,mmio"' may optionally
>    have an '#iommu-cells=<1>', in which case we assume it's an iommu.
>  - for virtio-pci, the node has the standard PCI 'reg' property but a special
>    'compatible="virtio,pci-iommu"' property that I think is different from any
>    other PCI node.

How is that different? PCI device can be a VID/PID compatible or
omitted, but can also be a "typical" compatible string.

> I think for other virtio devices, we should come up with a way to define a
> binding per device (i2c, gpio, ...) without needing to cram this into the
> "virtio,mmio" binding or coming up with special compatible strings for
> PCI devices.
>
> Having a child device for the virtio device type gives a better separation
> here, since it lets you have two nodes with 'compatible' strings that each
> make sense for their respective parent buses: The parent is either a PCI
> device or a plain mmio based device, and the child is a virtio device with
> its own namespace for compatible values. As you say, the downside is
> that this requires an extra node that is redundant because there is always
> a 1:1 relation with its parent.
>
> Having a combined node gets rid of the redundancy but if we want to
> identify the device for the purpose of defining a custom binding, it would have
> to have two compatible strings, something like
>
> compatible="virtio,mmio", "virtio,device34";

The order seems backwards here. 'virtio,device34' is more specific.
Though I guess the meanings are orthogonal.

> for a virtio-mmio device of device-id 34 (i2c), or a PCI device with
>
> compatible="pci1af4,1041", "virtio,device34";

But this seems the right order. Though does '1041' have any specific
meaning or device IDs are just dynamically assigned? It seems to be
the latter from my brief scan of the code.

> which also does not quite feel right.

I guess it comes down to is 'virtio,mmio' providing a bus or is it
just a device? I guess a bus (so 2 nodes) does make sense here.
'virtio,mmio' defines how you access/discover the virtio queues (the
bus) and the functional device (i2c, gpio, iommu, etc.) is accessed
via the virtio queues.

Rob
