Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA8D3D60E3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 18:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237620AbhGZPZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 11:25:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236874AbhGZPPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 11:15:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9FAB61006;
        Mon, 26 Jul 2021 15:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627314854;
        bh=1UURlyqsMlhFBDtKQ5OkWxpvTCr15igrtOB2uhsDtAc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xt1JS69WcRfNBf10BC7klLwJue00soMk56I/Q+DlLUvc5LkeKjY1ofkI8F4j4Me31
         TRFQ93psHdxQCL6INC7viuaNcM+2iQUQskILhHDF9f16ExrthpUcp+MRrwKBl0bUn0
         qCXGfKB2ZyW0ihAixyLU+TH88o1pIEwFyOD9CH7g+2rlpWDe2Q+/RH0kKaoK2xjo6H
         buSKSSULzJ8+4Sy14cdWiUCK5kH/StVNqQKnKaBxxgi6GLmx4QKm+69RzwXd6dgYoO
         wRFsynUbO/NGmLfC9JJ6+Rf7FztKCFIueAxYcCqfvkmgLzTmJ20rwgD6lQzx9mmy09
         a+pdAOLBc6INw==
Received: by mail-wm1-f52.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so297907wmb.5;
        Mon, 26 Jul 2021 08:54:14 -0700 (PDT)
X-Gm-Message-State: AOAM531K/U3wY7GpDPqetnTEMN8YQQ0ZzMuDjqfkRdX/2fksQepf9L+0
        Drk3g/UkUtTYHIHEMXyJl6bpthqWriDnYsVUJBA=
X-Google-Smtp-Source: ABdhPJyfayTexfKmJXMNn4XX3QQ4A+JhJZPnrMjFG+lYbcQXFXTNeBfZSy5NHj6FNZWGchEzxA364vxfUetwDeI2AkY=
X-Received: by 2002:a7b:c2fa:: with SMTP id e26mr27585853wmk.84.1627314853538;
 Mon, 26 Jul 2021 08:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627273794.git.viresh.kumar@linaro.org> <fced2f2b9dcf3f32f16866d7d104f46171316396.1627273794.git.viresh.kumar@linaro.org>
 <CAL_Jsq+XXhe2g0Rmda1v_Ws4-E_-UE6X5HUsSk-GcAETqQZiCQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+XXhe2g0Rmda1v_Ws4-E_-UE6X5HUsSk-GcAETqQZiCQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 26 Jul 2021 17:53:56 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3bCk+iA+YziQrQFg6xH_d9cyySdTN_1j94D9CA8a_Sjw@mail.gmail.com>
Message-ID: <CAK8P3a3bCk+iA+YziQrQFg6xH_d9cyySdTN_1j94D9CA8a_Sjw@mail.gmail.com>
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

On Mon, Jul 26, 2021 at 4:57 PM Rob Herring <robh+dt@kernel.org> wrote:
> On Sun, Jul 25, 2021 at 10:52 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > +    description: |
> > +      Exactly one node describing the virtio device. The name of the node isn't
> > +      significant but its phandle can be used to by a user of the virtio device.
> > +
> > +  compatible:
> > +    pattern: "^virtio,[0-9a-f]+$"
>
> DID is only 4 chars? If so, "^virtio,[0-9a-f]{1,4}$"

Any opinion on whether this should have any namespace prefix (or infix, I guess)
after "virtio,"?

I previously suggested making it "virtio,device[0-9a-f]{1,4}$", which would
make it clearer that the following digits are the device ID rather
than something
else we might define in the future. Viresh picked this version because it's
somewhat more consistent with other subsystems.

       Arnd
