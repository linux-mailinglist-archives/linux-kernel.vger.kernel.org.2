Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3833C92CC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 23:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbhGNVKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 17:10:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235070AbhGNVKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 17:10:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAB8B613ED;
        Wed, 14 Jul 2021 21:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626296866;
        bh=bu/VQrEqPktGxNdFrv6Cwday3MC00wp6sb8t1Xcbzm0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IriuGxiVAJfK5APX86+YnNf9zCprTYUvJCxcGVPf0VYNbk4uuavUaaRfU2r+zxp7o
         u5FOW8yu7DflF+R4tvul84/xxTD1txmI5ax2/jipgUZP7IelHRMHbR/K/49hAhg2wQ
         g5KmJbzrXRmesuf1f9VNHi3IUFA3+qHguDsYTxz4mLaWe4YmcFBRObxSEOxO2ys4Nt
         aHxnYeTaI1UMdUG8qO2dSm9GG1EUqjQLpuHgCHxTB4cx7Y9o684MUAjia6pRIVFvfI
         4B+IaZaGOPBwOtCkYoGYEeED5/eB0L+n8ixG/LN2MSrMuGbxaHZ61R8ojfWesc3c7F
         g0FoVK4u46rMw==
Received: by mail-wr1-f41.google.com with SMTP id g16so4914192wrw.5;
        Wed, 14 Jul 2021 14:07:45 -0700 (PDT)
X-Gm-Message-State: AOAM532o5YU94hW/AlKBmJcePuZB1lv4ND923uID3phocqebJco/8mvm
        4N/pDKbXuCxCpHa9Iv7xaID6c3QzAOdy+2wfO58=
X-Google-Smtp-Source: ABdhPJxHsRznyAwmzScr3Sx+7allQL9I5fuXIOYyBSp4cTtqJABqh6ZymizOeKXijECcOpkGc9b8R+g8c0pkgIT/KFk=
X-Received: by 2002:adf:f2c6:: with SMTP id d6mr106224wrp.286.1626296864543;
 Wed, 14 Jul 2021 14:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626173013.git.viresh.kumar@linaro.org> <aa4bf68fdd13b885a6dc1b98f88834916d51d97d.1626173013.git.viresh.kumar@linaro.org>
 <CAL_Jsq+SiE+ciZfASHKUfLU1YMPfB43YmSciT_+gQHvL99_wUA@mail.gmail.com>
 <20210713151917.zouwfckidnjxvohn@vireshk-i7> <CAL_JsqL9255n5RT=Gq_uru7rEP0bSVcyfXEPRY4F0M4S2HPvTA@mail.gmail.com>
 <CAK8P3a3Gve=M9GF-E+2OJED1Hd1qngxOkVSO15wB0jVWK8D0_Q@mail.gmail.com> <CAL_JsqKLjFx9AOcMiyxdQvDU7V8Sak8YPyrJm2TuSE-TTqvREw@mail.gmail.com>
In-Reply-To: <CAL_JsqKLjFx9AOcMiyxdQvDU7V8Sak8YPyrJm2TuSE-TTqvREw@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 14 Jul 2021 23:07:28 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2mS3GoW9MXdDNK7-EbnRH-9Kn4_k_TgnGSCycSez8Xow@mail.gmail.com>
Message-ID: <CAK8P3a2mS3GoW9MXdDNK7-EbnRH-9Kn4_k_TgnGSCycSez8Xow@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: virtio: mmio: Add support for device subnode
To:     Rob Herring <robh+dt@kernel.org>
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

On Wed, Jul 14, 2021 at 5:43 PM Rob Herring <robh+dt@kernel.org> wrote:
> On Tue, Jul 13, 2021 at 2:34 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > On Tue, Jul 13, 2021 at 9:35 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > What we have with virtio-iommu is two special hacks:
> >  - on virtio-mmio, a node with 'compatible="virtio,mmio"' may optionally
> >    have an '#iommu-cells=<1>', in which case we assume it's an iommu.
> >  - for virtio-pci, the node has the standard PCI 'reg' property but a special
> >    'compatible="virtio,pci-iommu"' property that I think is different from any
> >    other PCI node.
>
> How is that different? PCI device can be a VID/PID compatible or
> omitted, but can also be a "typical" compatible string.

Ok, my mistake then, I though the VID/PID compatible was mandated

> > I think for other virtio devices, we should come up with a way to define a
> > binding per device (i2c, gpio, ...) without needing to cram this into the
> > "virtio,mmio" binding or coming up with special compatible strings for
> > PCI devices.
> >
> > Having a child device for the virtio device type gives a better separation
> > here, since it lets you have two nodes with 'compatible' strings that each
> > make sense for their respective parent buses: The parent is either a PCI
> > device or a plain mmio based device, and the child is a virtio device with
> > its own namespace for compatible values. As you say, the downside is
> > that this requires an extra node that is redundant because there is always
> > a 1:1 relation with its parent.
> >
> > Having a combined node gets rid of the redundancy but if we want to
> > identify the device for the purpose of defining a custom binding, it would have
> > to have two compatible strings, something like
> >
> > compatible="virtio,mmio", "virtio,device34";
>
> The order seems backwards here. 'virtio,device34' is more specific.
> Though I guess the meanings are orthogonal.

Right, one defines the transport and the other defines the device behind
the transport.

> > for a virtio-mmio device of device-id 34 (i2c), or a PCI device with
> >
> > compatible="pci1af4,1041", "virtio,device34";
>
> But this seems the right order. Though does '1041' have any specific
> meaning or device IDs are just dynamically assigned? It seems to be
> the latter from my brief scan of the code.

It's the assigned PCI vendor/device pair for virtio, all virtio-pci devices
have to be "pci1af4,1041", just like all virtio-mmio devices are
"virtio,mmio".

> > which also does not quite feel right.
>
> I guess it comes down to is 'virtio,mmio' providing a bus or is it
> just a device? I guess a bus (so 2 nodes) does make sense here.
> 'virtio,mmio' defines how you access/discover the virtio queues (the
> bus) and the functional device (i2c, gpio, iommu, etc.) is accessed
> via the virtio queues.

It's not really a bus since there is only ever one device behind it.
A better analogy would be your 'serdev' framework: You could
have a 8250 or a pl011 uart, and behind that have a mouse, GPS
receiver or bluetooth dongle.

In Documentation/devicetree/bindings/serial/serial.yaml, you also
have two nodes for a single device, so we could follow that
example.

        Arnd
