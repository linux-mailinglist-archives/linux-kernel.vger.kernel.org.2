Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BE53FC9AF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbhHaO0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:26:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46444 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233576AbhHaO0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630419928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OA/jhyLAYtK1tYZ39fbir6HGMf0iZmNE8/Rh8O+Ui3Q=;
        b=aJs0evNcN5GrxsgqBaxV0EDx7Ej57trkOBpC6NNF0TU2u1rIlFF7BgvdBxy4eKqZHJX6KH
        lT0qU4dwo4Xu2X0btte0FGGyR61m0ecWVie0PjGn/koy23Yroz8o4Bb69zBVxC9YEShnak
        nh/n+dMC+QJoYeqcMLlJzGJE/lQ7Ndw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-FYrsYo3yPTmtwOO_ysm9ZA-1; Tue, 31 Aug 2021 10:25:26 -0400
X-MC-Unique: FYrsYo3yPTmtwOO_ysm9ZA-1
Received: by mail-ej1-f69.google.com with SMTP id bx10-20020a170906a1ca00b005c341820edeso229109ejb.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OA/jhyLAYtK1tYZ39fbir6HGMf0iZmNE8/Rh8O+Ui3Q=;
        b=lttmema9N+pkSvS2mS3oab/AgHcG8lyE8orgqA2LOAE5xJGiKFk+GXOY+ktTQh65Hf
         ix3RNTUQRBqax7kMFgCuJvERJF+uWBmt0I5KBJ8X6pGJm/G/WNocimWdgOFL1ggCGBjn
         uXWTm0OOtYaxGa0bOj3Pb0YwoV2FumXg+SfUt+FyMmg3zamrL/7GRrscPo4m01FS2/Ot
         6feQjGvIymQycngJl/wFdT/d7gZgGmBQDG6HJdP1JjmFKQbWupnPKsRDk/MX22y6JRpB
         5eMBhETIT78MZXrGppUnulwD9S3WZHiY3lxyr/clnQ0VK+2KSXdZZO0UZAzsmrU2IX5W
         WTeg==
X-Gm-Message-State: AOAM530cVtg2qH6LHZsyADYXbAeBpnNEP+REq+nSeT5j/AV0l5kNhO8W
        AoYqUO8rLrtI1H+Sm01KDOTTodvphLGQAfr7gAdyPpZgH+Erya6D5cH1VkRk3Z1yjZkXkhkEsqc
        tL3REVmvjnW9apbuLZciO5pb3
X-Received: by 2002:a17:906:70b:: with SMTP id y11mr31329833ejb.274.1630419925025;
        Tue, 31 Aug 2021 07:25:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSzD9zkr7wPpktKq9Ktr39dANS1nu+utRyQ0BSDOUx3yoPFWOxowvAJPabM1ziUJDcXh+Mmg==
X-Received: by 2002:a17:906:70b:: with SMTP id y11mr31329801ejb.274.1630419924831;
        Tue, 31 Aug 2021 07:25:24 -0700 (PDT)
Received: from redhat.com ([2.55.138.60])
        by smtp.gmail.com with ESMTPSA id b2sm8403019ejj.124.2021.08.31.07.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 07:25:24 -0700 (PDT)
Date:   Tue, 31 Aug 2021 10:25:19 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jason Wang <jasowang@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jie Deng <jie.deng@intel.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org,
        linux-i2c@vger.kernel.org, Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH V4 0/5] virtio: Add virtio-device bindings
Message-ID: <20210831102514-mutt-send-email-mst@kernel.org>
References: <cover.1627362340.git.viresh.kumar@linaro.org>
 <20210831053105.ut73bmvxcop65nuv@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831053105.ut73bmvxcop65nuv@vireshk-i7>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 11:01:05AM +0530, Viresh Kumar wrote:
> On 27-07-21, 10:53, Viresh Kumar wrote:
> > Hi,
> > 
> > Currently the DT only provides support for following node types for virtio-mmio
> > nodes:
> > 
> >         virtio_mmio@a000000 {
> >                 dma-coherent;
> >                 interrupts = <0x00 0x10 0x01>;
> >                 reg = <0x00 0xa000000 0x00 0x200>;
> >                 compatible = "virtio,mmio";
> >         };
> > 
> > Here, each virtio-mmio corresponds to a virtio-device. But there is no way for
> > other users in the DT to show their dependency on virtio devices.
> > 
> > This patchset provides that support.
> > 
> > The first patch adds virtio-device bindings to allow for device sub-nodes to be
> > present and the second patch updates the virtio core to update the of_node.
> > 
> > Other patches add bindings for i2c and gpio devices.
> > 
> > Tested on x86 with qemu for arm64.
> 
> Michael, are you picking these up for 5.15 ?

Okay.

> -- 
> viresh

