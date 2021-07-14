Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA383C7BC1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 04:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237579AbhGNC3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 22:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbhGNC3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 22:29:24 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC45C0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 19:26:32 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id t9so691689pgn.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 19:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aLOOUxsNuJzrisjcRZgamS/BIZMhFQu6M3e4Y30uR0Y=;
        b=vktLsQdD1T+XZaWFZlM+oLSx8DcvuVKrB3G/zetKYDvGAQifvvuAT+70hcekKu5a6n
         O6h2dCjsiUI1iulV9zJ/7vu1yEolfCOkvzpVsFSOVWeAGx/JzArOPmk77K2PH84RcOJ5
         fcJzs1TBUk3KG9x7I3GQqTsYqgmBCYkl3BWjJLX7hYoMfQVDnryLfCM2ScYD/L8ZnWv5
         zYoS4YJpvaCrrRHEXl8Jb31PIfXryjdcLLsXacnNWnDG65hWyjPNJH6rdVP0NzmZ0ER8
         EpJ/IszoDHZtmMaRiOSBaZQtF79WAtgi21j/s86rzv1NTu96zX4RIy2x83E9bN37VKXk
         w1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aLOOUxsNuJzrisjcRZgamS/BIZMhFQu6M3e4Y30uR0Y=;
        b=f3ALRKWxBsu9kWP/h3P2r2xGGlSJdN1nd3lBqp4190LTA5ebIGPkqmd86SIoqKc4w3
         VNNx0/jyoy3R/lr9unc8RI+8X1u14TVGZ0B6ewY/oTlZukKpUxiCytsWX9/rvDdA1jm4
         vtjS+mno7rgUp6i+k4a+/Axe3wOy8O19K+LCst0VnBT+FOvZHXNeBysx1AvE2qX/CMNy
         Kowky/3xn1u7xEkDNebUGTSTttS0H6KDRMFDHK5A3q9A0CYxa1a6Tcp4LVcck3XMJf/u
         IjPeJU62PvCKGXhCA+/ijp+UrASdntX31Wlhyos7Opk+EzyEQ6S6k5s8/56HgzzyOLrv
         az1A==
X-Gm-Message-State: AOAM532Q9VX9PoRlsOb8PdQokUJPBm+7s6XHHfSo5NcXQpgCGQgs16j8
        /Wszy+A02JMEeBP0xW6XSWck7A==
X-Google-Smtp-Source: ABdhPJy6+4rpbrfnR4e8usInKISk1VWBWA8IDr8PyYcnfj+Yoar6cVYPjxczpgOa4x4kBz8KXAA0RA==
X-Received: by 2002:a62:3344:0:b029:25e:a0a8:1c51 with SMTP id z65-20020a6233440000b029025ea0a81c51mr7560777pfz.58.1626229592462;
        Tue, 13 Jul 2021 19:26:32 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id v27sm477952pfi.166.2021.07.13.19.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 19:26:31 -0700 (PDT)
Date:   Wed, 14 Jul 2021 07:56:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jie Deng <jie.deng@intel.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 1/5] dt-bindings: virtio: mmio: Add support for device
 subnode
Message-ID: <20210714022630.d7vrazygmbooflcf@vireshk-i7>
References: <cover.1626173013.git.viresh.kumar@linaro.org>
 <aa4bf68fdd13b885a6dc1b98f88834916d51d97d.1626173013.git.viresh.kumar@linaro.org>
 <CAL_Jsq+SiE+ciZfASHKUfLU1YMPfB43YmSciT_+gQHvL99_wUA@mail.gmail.com>
 <20210713151917.zouwfckidnjxvohn@vireshk-i7>
 <CAL_JsqL9255n5RT=Gq_uru7rEP0bSVcyfXEPRY4F0M4S2HPvTA@mail.gmail.com>
 <CAK8P3a3Gve=M9GF-E+2OJED1Hd1qngxOkVSO15wB0jVWK8D0_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3Gve=M9GF-E+2OJED1Hd1qngxOkVSO15wB0jVWK8D0_Q@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-07-21, 22:34, Arnd Bergmann wrote:
> On Tue, Jul 13, 2021 at 9:35 PM Rob Herring <robh+dt@kernel.org> wrote:
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
> 
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
> 
> for a virtio-mmio device of device-id 34 (i2c), or a PCI device with
> 
> compatible="pci1af4,1041", "virtio,device34";
> 
> which also does not quite feel right.

I agree that even if the device is discoverable at runtime, we should
still have some sort of stuff in DT to distinguish the devices, and
"virtio,deviceDID" sounds good enough for that, considering that we
already do it for USB, etc.

And I am fine with both the ways, a new node or just using the parent
node. So whatever you guys decide is fine.

> > Direct userspace access to I2C, GPIO, etc. has its issues, we're going
> > to repeat that with guests?
> 
> Passing through the i2c or gpio access from a Linux host is just one
> way to use it, you could do the same with an emulated i2c device
> from qemu, and you could have a fake i2c device behind a virtio-i2c
> controller.

Or it can be firmware controlled device as well, as Rob said earlier.
I think that's what Vincent will be doing for SCMI.

Though all I have tested until now is direct userspace access.

-- 
viresh
