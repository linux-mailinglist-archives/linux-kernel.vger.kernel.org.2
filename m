Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D60F3C780A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 22:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbhGMUhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 16:37:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234290AbhGMUhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 16:37:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F1FA6136D;
        Tue, 13 Jul 2021 20:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626208460;
        bh=h8IGvseWxDwyqhyASV2KmAN0tjeKNYXjo0V5hoRiSmA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ulkLc/aqfJxtKES83Jd+S+DB7dcMssjHru0dD22VVtJzQspeTg/p3x/SXXLKDXOZc
         ItG5adFJfxgBvMZ07ywtQunjnztbv+E8OaYzZ9JsdV+SRThjbSGWJ5q9k6odiBngA7
         YxESEn8cRlkdg+//FdzHNsyfVvPU49G0Jz/S10Gp6lOA6iqGwus94HXgpo8rkvuAL/
         P7wDBuH/BEdlrgmgZQnsGUte6XAk1NmohVPdD9dEHzlD7hGLwto6rKDlc0PKlbLX0x
         GvuEkUJa5+7N0WEHS8MkIj95I9lLBRSpI8am3X+aEiEqmBB2JvsPj11Vl6iiNKPSZH
         /V0ihCcZ8XM7Q==
Received: by mail-wm1-f53.google.com with SMTP id l17-20020a05600c1d11b029021f84fcaf75so2499787wms.1;
        Tue, 13 Jul 2021 13:34:20 -0700 (PDT)
X-Gm-Message-State: AOAM5307Nb48h5B4odSPy/wYcdavkQNunx13jh66D+0YOmT6GBjsuTMr
        kPOK3bqYt1qZm2XNZYvYA5IF6GtXkVRfjqq5C8g=
X-Google-Smtp-Source: ABdhPJxkIW99deI0NasROFnBp7AD31ptK2sBvd2H+WY7pKl4UILJAKncesIUcFCbu8CkHkdPWfi8U2dZlPljJ2OiSvo=
X-Received: by 2002:a7b:c2fa:: with SMTP id e26mr70558wmk.84.1626208459052;
 Tue, 13 Jul 2021 13:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626173013.git.viresh.kumar@linaro.org> <aa4bf68fdd13b885a6dc1b98f88834916d51d97d.1626173013.git.viresh.kumar@linaro.org>
 <CAL_Jsq+SiE+ciZfASHKUfLU1YMPfB43YmSciT_+gQHvL99_wUA@mail.gmail.com>
 <20210713151917.zouwfckidnjxvohn@vireshk-i7> <CAL_JsqL9255n5RT=Gq_uru7rEP0bSVcyfXEPRY4F0M4S2HPvTA@mail.gmail.com>
In-Reply-To: <CAL_JsqL9255n5RT=Gq_uru7rEP0bSVcyfXEPRY4F0M4S2HPvTA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 13 Jul 2021 22:34:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Gve=M9GF-E+2OJED1Hd1qngxOkVSO15wB0jVWK8D0_Q@mail.gmail.com>
Message-ID: <CAK8P3a3Gve=M9GF-E+2OJED1Hd1qngxOkVSO15wB0jVWK8D0_Q@mail.gmail.com>
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

On Tue, Jul 13, 2021 at 9:35 PM Rob Herring <robh+dt@kernel.org> wrote:
> On Tue, Jul 13, 2021 at 9:19 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 13-07-21, 08:43, Rob Herring wrote:
> > > On Tue, Jul 13, 2021 at 4:50 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >
> > > > Allow virtio,mmio nodes to contain device specific subnodes. Since each
> > > > virtio,mmio node can represent a single virtio device, each virtio node
> > > > is allowed to contain a maximum of one device specific subnode.
> > >
> > > Doesn't sound like we need 2 nodes here. Just add I2C devices as child
> > > nodes. You could add a more specific compatible string, but the
> > > protocol is discoverable, so that shouldn't be necessary.
> >
> > I am not sure if it will be a problem, but you can clarify it better.
>
> > The parent node (virtio,mmio) is used to create a platform device,
> > virtio-mmio, (and so assigned as its of_node) and we create the
> > virtio-device from probe() of this virtio-mmio device.
> >
> > Is it going to be a problem if two devices in kernel use the same
> > of_node ?
>
> There shouldn't be. We have nodes be multiple providers (e.g clocks
> and resets) already.

I think this would be a little different, but it can still work. There is in
fact already some precedent of doing this, with Jean-Philippe's virtio-iommu
binding, which is documented in both

Documentation/devicetree/bindings/virtio/iommu.txt
Documentation/devicetree/bindings/virtio/mmio.txt

Unfortunately, those are still slightly different from where I think we should
be going here, but it's probably close enough to fit into the general
system.

What we have with virtio-iommu is two special hacks:
 - on virtio-mmio, a node with 'compatible="virtio,mmio"' may optionally
   have an '#iommu-cells=<1>', in which case we assume it's an iommu.
 - for virtio-pci, the node has the standard PCI 'reg' property but a special
   'compatible="virtio,pci-iommu"' property that I think is different from any
   other PCI node.

I think for other virtio devices, we should come up with a way to define a
binding per device (i2c, gpio, ...) without needing to cram this into the
"virtio,mmio" binding or coming up with special compatible strings for
PCI devices.

Having a child device for the virtio device type gives a better separation
here, since it lets you have two nodes with 'compatible' strings that each
make sense for their respective parent buses: The parent is either a PCI
device or a plain mmio based device, and the child is a virtio device with
its own namespace for compatible values. As you say, the downside is
that this requires an extra node that is redundant because there is always
a 1:1 relation with its parent.

Having a combined node gets rid of the redundancy but if we want to
identify the device for the purpose of defining a custom binding, it would have
to have two compatible strings, something like

compatible="virtio,mmio", "virtio,device34";

for a virtio-mmio device of device-id 34 (i2c), or a PCI device with

compatible="pci1af4,1041", "virtio,device34";

which also does not quite feel right.

>> On Tue, Jul 13, 2021 at 9:19 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 13-07-21, 08:43, Rob Herring wrote:
> > > On Tue, Jul 13, 2021 at 4:50 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > > BTW, what's the usecase for these protocols? A standard interface to
> > > firmware controlled I2C, GPIO, etc.?
> >
> > Right now we are looking to control devices in the host machine from
> > guests. That's what Linaro's project stratos is doing. There are other
> > people who want to use this for other kind of remote control stuff,
> > maybe from firmware.
>
> Project stratos means nothing to me.
>
> Direct userspace access to I2C, GPIO, etc. has its issues, we're going
> to repeat that with guests?

Passing through the i2c or gpio access from a Linux host is just one
way to use it, you could do the same with an emulated i2c device
from qemu, and you could have a fake i2c device behind a virtio-i2c
controller.

         Arnd
