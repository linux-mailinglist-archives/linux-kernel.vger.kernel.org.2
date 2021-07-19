Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779413CD449
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 14:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbhGSLXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 07:23:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236332AbhGSLXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 07:23:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C0636113C;
        Mon, 19 Jul 2021 12:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626696266;
        bh=r7MtcETmmwaxyZEhNTXDUCs5QkEaZXwKjSSDkYAiMLw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W5Xy8un6pjJrHiVOsd8DmDafSsjlJWAInL+v0gJIEmIxrXRc7R0xXJVF4v+4fNiQp
         TehCmkISibsQJbqqNWYP2AziPXEl7cyVVZGTH6+Xh9ONmwC8SQGlDqARlw5tGrPQkk
         kli8lASv66H2za4ziO3KzyNe/FGNAGi3kOcU5fmzhg/mu1b2ZNbKYr5TVeyiXwHJfh
         0B6cZZsjmoRNnyzgPSJxs8n52GNO6Mv1R/7GqPfMlTlT6XSvoZoWd/wNWmnnf98eWy
         PJbVvrTOhtm2REBU0HlAMarUMyATtwZbpJGeT4LSj2K22F3KKyB3UaHlJ5M66mfRrg
         ufapHNtQUYXbw==
Received: by mail-wm1-f43.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso12675026wmh.4;
        Mon, 19 Jul 2021 05:04:25 -0700 (PDT)
X-Gm-Message-State: AOAM532jEN6E4efbNQgXnuOeoUu/jTvFedzcqu29+MAxf8k5+7aTJ3CN
        6H1m520FBy9adaTRyLYUl1Pw1PV971TCwcgniIs=
X-Google-Smtp-Source: ABdhPJyTLcL//uJgze/98z6NMZhekHRl1kr2RmyhG5NvFls6ynDEOwrdcVOH94odcgnCHsoc3BpRobMSS124oOCE/rw=
X-Received: by 2002:a7b:c2fa:: with SMTP id e26mr31950216wmk.84.1626696264701;
 Mon, 19 Jul 2021 05:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626173013.git.viresh.kumar@linaro.org> <aa4bf68fdd13b885a6dc1b98f88834916d51d97d.1626173013.git.viresh.kumar@linaro.org>
 <CAL_Jsq+SiE+ciZfASHKUfLU1YMPfB43YmSciT_+gQHvL99_wUA@mail.gmail.com>
 <20210713151917.zouwfckidnjxvohn@vireshk-i7> <CAL_JsqL9255n5RT=Gq_uru7rEP0bSVcyfXEPRY4F0M4S2HPvTA@mail.gmail.com>
 <CAK8P3a3Gve=M9GF-E+2OJED1Hd1qngxOkVSO15wB0jVWK8D0_Q@mail.gmail.com>
 <CAL_JsqKLjFx9AOcMiyxdQvDU7V8Sak8YPyrJm2TuSE-TTqvREw@mail.gmail.com>
 <CAK8P3a2mS3GoW9MXdDNK7-EbnRH-9Kn4_k_TgnGSCycSez8Xow@mail.gmail.com> <20210719103336.oyz6dppd5jf65w4m@vireshk-i7>
In-Reply-To: <20210719103336.oyz6dppd5jf65w4m@vireshk-i7>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 19 Jul 2021 14:04:08 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0udKQk_LLxUD0k2pWk=WSt=9AcaHsCEboYJX=Xj-7mwQ@mail.gmail.com>
Message-ID: <CAK8P3a0udKQk_LLxUD0k2pWk=WSt=9AcaHsCEboYJX=Xj-7mwQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: virtio: mmio: Add support for device subnode
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Jason Wang <jasowang@redhat.com>,
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

On Mon, Jul 19, 2021 at 12:34 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 14-07-21, 23:07, Arnd Bergmann wrote:
> > On Wed, Jul 14, 2021 at 5:43 PM Rob Herring <robh+dt@kernel.org> wrote:
> > > I guess it comes down to is 'virtio,mmio' providing a bus or is it
> > > just a device? I guess a bus (so 2 nodes) does make sense here.
> > > 'virtio,mmio' defines how you access/discover the virtio queues (the
> > > bus) and the functional device (i2c, gpio, iommu, etc.) is accessed
> > > via the virtio queues.
> >
> > It's not really a bus since there is only ever one device behind it.
> > A better analogy would be your 'serdev' framework: You could
> > have a 8250 or a pl011 uart, and behind that have a mouse, GPS
> > receiver or bluetooth dongle.
> >
> > In Documentation/devicetree/bindings/serial/serial.yaml, you also
> > have two nodes for a single device, so we could follow that
> > example.
>
> So two device nodes is final then ? Pretty much like how this patchset did it
> already ? I need to get rid of reg thing and use "virtio,DID" though.

Let's give Rob another day to reply here. I think two nodes is easier
to get working than one node, even when we continue supporting the
current iommu binding that relies on a single node, but we could make
it work either way if necessary.

       Arnd
