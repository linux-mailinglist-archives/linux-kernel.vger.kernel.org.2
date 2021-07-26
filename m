Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3483D688D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 23:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhGZUkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 16:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232788AbhGZUkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 16:40:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8AC5160F9D;
        Mon, 26 Jul 2021 21:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627334431;
        bh=N9/OEgtjGYplEYJ/2SOff1RZYBM03Kyk8wRDdt0TzFc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YZSz8zAjEKWKGI4CNnl01LcN2CPppamcN98FCWIlsp5JgD5xRuZeNoK7drOJnNjkT
         En59u7HuKtdBwJBGMjA5g4ipvOX+8OOAORgfE1CKxHjTZSZ6q/bE2r338oDnjrHp/O
         0UtnnrjNQyUD6yXGVIiawJybgIvB9M1VfiuvZPz/EhzeNr/lStgTMjlBwBEd6SOazD
         6me1WH9inpfA9BC0DbwFGWoxwo6/YGHA6rdUN0pdKd7W23vjJm89Zg9D+uxci7P203
         +WOyr9YM3XP92Mkp2gUfhmJC308zfhFZZIs58aggP0DIzP+TPnmRU/IkI7ZsE83fa9
         t+kPQJ7Fsqa/g==
Received: by mail-wm1-f45.google.com with SMTP id n21so6187171wmq.5;
        Mon, 26 Jul 2021 14:20:31 -0700 (PDT)
X-Gm-Message-State: AOAM531alCQQXk6JunS/qLYhAiu9yVq/VCrNOIIKgr6R550Byk/ZccfM
        phP+vRnS3rsam91BUZBWseHYE1gBZ1TPMbSyegQ=
X-Google-Smtp-Source: ABdhPJxecW5jkR7LfzmXR3zNuQcz/90Y46z/6ABGm60QvcrorfMTOoQ5aTUp9zNbHSyx4J61jVUQYG6gdWvN8OjB3CI=
X-Received: by 2002:a7b:ce10:: with SMTP id m16mr787071wmc.75.1627334430138;
 Mon, 26 Jul 2021 14:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627273794.git.viresh.kumar@linaro.org> <fced2f2b9dcf3f32f16866d7d104f46171316396.1627273794.git.viresh.kumar@linaro.org>
 <CAL_Jsq+XXhe2g0Rmda1v_Ws4-E_-UE6X5HUsSk-GcAETqQZiCQ@mail.gmail.com>
 <CAK8P3a3bCk+iA+YziQrQFg6xH_d9cyySdTN_1j94D9CA8a_Sjw@mail.gmail.com> <CAL_JsqLk8q6N2Sf43em57OXKkrQ7SW01GBnAEV1zzPMYQF7agA@mail.gmail.com>
In-Reply-To: <CAL_JsqLk8q6N2Sf43em57OXKkrQ7SW01GBnAEV1zzPMYQF7agA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 26 Jul 2021 23:20:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3bnOYNC-wqzQr+iv9EWGUX7gQA1tC2pPDKqav_m5r4fQ@mail.gmail.com>
Message-ID: <CAK8P3a3bnOYNC-wqzQr+iv9EWGUX7gQA1tC2pPDKqav_m5r4fQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/5] dt-bindings: virtio: Add binding for virtio devices
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

On Mon, Jul 26, 2021 at 10:37 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Jul 26, 2021 at 9:54 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Mon, Jul 26, 2021 at 4:57 PM Rob Herring <robh+dt@kernel.org> wrote:
> > > On Sun, Jul 25, 2021 at 10:52 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > +    description: |
> > > > +      Exactly one node describing the virtio device. The name of the node isn't
> > > > +      significant but its phandle can be used to by a user of the virtio device.
> > > > +
> > > > +  compatible:
> > > > +    pattern: "^virtio,[0-9a-f]+$"
> > >
> > > DID is only 4 chars? If so, "^virtio,[0-9a-f]{1,4}$"
> >
> > Any opinion on whether this should have any namespace prefix (or infix, I guess)
> > after "virtio,"?
> >
> > I previously suggested making it "virtio,device[0-9a-f]{1,4}$", which would
> > make it clearer that the following digits are the device ID rather
> > than something
> > else we might define in the future. Viresh picked this version because it's
> > somewhat more consistent with other subsystems.
>
> I'm fine either way, though I do find just a number a bit strange. So
> I'd lean toward adding 'device' or even just a 'd'.

I don't think just 'd' would be a good idea since it is indistinguishable from
a hexadecimal character. 'dev' would work though.

> BTW, what happens if/when the device protocol is rev'ed? A new DID or
> is there a separate revision that's discoverable?

This should normally be done using feature bits that are negotiated
between the two sides, and if only one side can do it, they use the
old revision.

There could be a new device ID but I don't think that has happened so far.

       Arnd
