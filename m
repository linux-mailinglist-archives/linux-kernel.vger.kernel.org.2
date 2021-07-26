Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692463D6833
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 22:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbhGZT4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 15:56:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232359AbhGZT4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 15:56:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3FD360F94;
        Mon, 26 Jul 2021 20:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627331789;
        bh=3riA8t9dhiYBRD1Zo/I1Hj+SO5jhDplsAp2AKdHWpLA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZeC55X+ii1EFrVqG2LhhEpFJ2XVlWO5U5yR0AYGD74kDstUM1REQDsHuLGCWniMoS
         s8+NIMUQQ1rs+71RkwXWbTnXGDstWix4QcNh+x2IE+eW9W/I26hqk2bWvnEG23BASd
         aBSUnxfvn3MO2+I/ZQie+fjcnr4EmLmYSJOy8u8ydz8F5w3zuPTT0GZwHpW998kZ5q
         bcS+SGXJWjOOH/DYHw2QLiQGxvZDhSCLfT7Wbatnft/6+1oDCRJh0bgjJIfN1SG7Uv
         0V2cwoIIPog1oCrEnX40WM4icReRQVdfmxOLrcTPMG1JrIpgnYGB2IgvXZ8Mz3czdm
         PiviFHOObmzLA==
Received: by mail-ed1-f51.google.com with SMTP id r16so12298534edt.7;
        Mon, 26 Jul 2021 13:36:28 -0700 (PDT)
X-Gm-Message-State: AOAM533YQuUOOfGGtIqnGCSgVO1PB+TSiSJRflmPqPjIyPfcN5+/9WuZ
        jFxDmc1kA+JAZQChb9kRqhmvjFU6IIoeKVIFaQ==
X-Google-Smtp-Source: ABdhPJxJvbq2g1KVho0J4ni/dJfg/SR6NMsVddzMiVey2KHzvQfwm0Lk820JJcWPeqiRPXYyscNT4jTklDKfEDPvWFc=
X-Received: by 2002:aa7:da4b:: with SMTP id w11mr24326198eds.258.1627331787560;
 Mon, 26 Jul 2021 13:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627273794.git.viresh.kumar@linaro.org> <fced2f2b9dcf3f32f16866d7d104f46171316396.1627273794.git.viresh.kumar@linaro.org>
 <CAL_Jsq+XXhe2g0Rmda1v_Ws4-E_-UE6X5HUsSk-GcAETqQZiCQ@mail.gmail.com> <CAK8P3a3bCk+iA+YziQrQFg6xH_d9cyySdTN_1j94D9CA8a_Sjw@mail.gmail.com>
In-Reply-To: <CAK8P3a3bCk+iA+YziQrQFg6xH_d9cyySdTN_1j94D9CA8a_Sjw@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 26 Jul 2021 14:36:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLk8q6N2Sf43em57OXKkrQ7SW01GBnAEV1zzPMYQF7agA@mail.gmail.com>
Message-ID: <CAL_JsqLk8q6N2Sf43em57OXKkrQ7SW01GBnAEV1zzPMYQF7agA@mail.gmail.com>
Subject: Re: [PATCH V3 1/5] dt-bindings: virtio: Add binding for virtio devices
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

On Mon, Jul 26, 2021 at 9:54 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Mon, Jul 26, 2021 at 4:57 PM Rob Herring <robh+dt@kernel.org> wrote:
> > On Sun, Jul 25, 2021 at 10:52 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > +    description: |
> > > +      Exactly one node describing the virtio device. The name of the node isn't
> > > +      significant but its phandle can be used to by a user of the virtio device.
> > > +
> > > +  compatible:
> > > +    pattern: "^virtio,[0-9a-f]+$"
> >
> > DID is only 4 chars? If so, "^virtio,[0-9a-f]{1,4}$"
>
> Any opinion on whether this should have any namespace prefix (or infix, I guess)
> after "virtio,"?
>
> I previously suggested making it "virtio,device[0-9a-f]{1,4}$", which would
> make it clearer that the following digits are the device ID rather
> than something
> else we might define in the future. Viresh picked this version because it's
> somewhat more consistent with other subsystems.

I'm fine either way, though I do find just a number a bit strange. So
I'd lean toward adding 'device' or even just a 'd'.

BTW, what happens if/when the device protocol is rev'ed? A new DID or
is there a separate revision that's discoverable?

Rob
