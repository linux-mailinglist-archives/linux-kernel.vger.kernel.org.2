Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327FA3A5F73
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 11:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbhFNJy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 05:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbhFNJy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 05:54:27 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C98EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 02:52:24 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g4so9417266pjk.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 02:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tyrwULaDA/8yLqlpZdEOiGOlczFmIcq5jIHr0JXrByc=;
        b=igPrVeoHcTmiAINqhls6RiJIDB5nLDcSwdZ3KpExZuE8yIUZMRE1RVmBm+B0fXRIyB
         6ew0i/Ft0rDT+XS5FZf4NnMvWhY8OhRlIhSSvjrha4+p9GtHzdWDfp/C9QLrdWDJsxmX
         qxp4xFgElsZTEkQTGWYkHbx6zEz7RFqykq/1SlcX5WQ9RjPmy16hpDvvmEmmv0A3GcL6
         HLSCp5yL4L6wJ82932X6X9djic9QkAGXl4cCM25kjm+J1bMx1Q53X9ivtme2uTZv8kKI
         Wgc+c7O5qFXbU1v8N5gb7swqmNalHRSEHxyDVGXgnzJPySQT21tPHhCi6QkTzJn/52ZU
         shVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tyrwULaDA/8yLqlpZdEOiGOlczFmIcq5jIHr0JXrByc=;
        b=aXsZp6YY62EyM1JZAE88yRE8kkSv8Tbjy9SvzhKWtczK2HE8yDyrcD59pDDN70vsom
         5R23uTZyUZ6c6yNEetZeqwxohxCgNPshzj4EuOjkSo37/ggefL+nS+0i+cVnQpqbQCe+
         hgjLlE+xo9diCjgKy+jKQkZwjcp8jpqy5ZNWw4NNgYafVQNkZiN6vxE/sqlEs1Z9yGr4
         t6btKn0oF2aiXpjMRVJD46fW07N4aTPMb2BPlolqNfK4pB7LELBhS6CDIbWBmi0ggU0D
         jPeirMRosGmEClXpF+XQrfqyS0SCgdO2MmZEZC6H6bJnL5VcRBCHqX3jVZuEJyLVNckt
         bpoA==
X-Gm-Message-State: AOAM533Xtler6zNOlzdWdEHM1pLBb3LmnLBxg3akoNCgxWdDxmDdouLI
        HXZkr4M2oUFjQTo16opowRXgCw==
X-Google-Smtp-Source: ABdhPJzrnSMBDHqHbJTk9n5Gre9pL7dGgqKtzvv6r3635rG525QZ1LkuwmofSJGB7i19czbV3jBH/Q==
X-Received: by 2002:a17:90a:2d8e:: with SMTP id p14mr17631924pjd.131.1623664343718;
        Mon, 14 Jun 2021 02:52:23 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id v1sm12224241pfi.194.2021.06.14.02.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 02:52:23 -0700 (PDT)
Date:   Mon, 14 Jun 2021 15:22:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Viresh Kumar <vireshk@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        stratos-dev@op-lists.linaro.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Stefano Garzarella --cc virtualization @ lists . linux-foundation . org" 
        <sgarzare@redhat.com>, virtualization@lists.linux-foundation.org,
        Alistair Strachan <astrachan@google.com>
Subject: Re: [PATCH V3 1/3] gpio: Add virtio-gpio driver
Message-ID: <20210614095221.7qngyzhbxbckolpj@vireshk-i7>
References: <cover.1623326176.git.viresh.kumar@linaro.org>
 <10442926ae8a65f716bfc23f32339a6b35e51d5a.1623326176.git.viresh.kumar@linaro.org>
 <CACRpkdZV2v2S5z7CZf_8DV=At9-oPSj7RYFH78hWy3ZX37QnDQ@mail.gmail.com>
 <20210611035623.z4f2ynumzozigqnv@vireshk-i7>
 <CAMuHMdVrtSnFpPbB0P3Wxqm1D6vU1_cnh3ypsZJRNF6ueKdAsw@mail.gmail.com>
 <20210611080122.tlkidv6bowuka6fw@vireshk-i7>
 <0478822f-9d10-deb8-86ae-3b4ac3bb0c6c@metux.net>
 <CAHp75Vf0+bCnnD3wtkrPvFbr2k3A0r3eWNp87PyksiC7euaqdw@mail.gmail.com>
 <d127bb4c-722d-536b-c89f-4c40cbaa6479@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d127bb4c-722d-536b-c89f-4c40cbaa6479@metux.net>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-06-21, 11:17, Enrico Weigelt, metux IT consult wrote:
> On 14.06.21 10:12, Andy Shevchenko wrote:
> 
> > That's why we have a thing called standard. And AFAIU virtio API/ABIs
> > should be officially registered and standardized.
> 
> Absolutely.
> 
> I've submitted my spec to virtio folks last nov, but this wasn't in form
> of patch against their tex-based documentation yet (just ascii text),
> thus laying around in the pipeline.
> 
> (meanwhile the actual implementation is running in the field for over
> 6 month now)
> 
> Viresh picked it up, but made something totally different out of it.
> I wonder why he didn't consult me first.

Here I asked you on 26th of May, if you would be fine if I take it
forward as you didn't do anything with it formally in the last 5-6
months (Yes I know you were busy with other stuff).

https://lore.kernel.org/linux-doc/20210526033206.5v362hdywb55msve@vireshk-i7/

You chose not to reply.

I did the same before picking up the kernel code. You chose not to
reply.

I am not inclined to do offlist discussions as they aren't fruitful
eventually, and it is better to do these discussions over open lists,
so others can chime in as well.

> All that needed to be done was
> translated the ascii documentation into tex and rephrase a bit in order
> to match the formal terminology and structure used in virtio specs.

Not really. There were things lagging, which are normally caught in
reviews and fixed/updated. But that never happened in this case. You
only sent the specs once to virtio list, that too as an attachment and
it never made it to the virtio guys there (as the list doesn't take
attachments).

https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg06946.html

> This makes me very unhappy.

I know you have solutions running in products which depend on the
layout of the config structure or request/responses, based on your
original write-up, but unless something is merged in open source code
or specification, it is going to get changed, normally because of
reviews.

And you will be required to change things based on reviews, you just
can't say that I have products running the code and so I won't change
it. That is why people say, Upstream first. So you don't get into this
mess. Yes, this is tough and that's the way it is.

You keep saying that I have changed the original specification too
much, which is incorrect, I tried to point out earlier what all is
changed and why.

https://lore.kernel.org/linux-gpio/CAKohpokxSoSVtAJkL-T_OOoS8dW-gYG1Gs5=_DwebvJETE48Xw@mail.gmail.com/

You chose not to reply to that.

Lemme say this again. This is a generic protocol we are trying to
define here. It needs to take everyone's view into account and their
use cases. We are required here to collaborate. A solution thought to
be good enough for one person or use-case, isn't going to fly.

The changes I did to it are required to make it useful for the generic
solution for a protocol.

I am sure there would be shortcomings, like the one identified by
Jean-Philippe Brucker, where he asked to add offset of the gpios-name
thing. He made a sensible suggestion, which I am required to
incorporate. I just can't reply to him and say I won't change it
because I have already designed my product based on this.

Lets try to improve the code and specification here and make it work
for both of us by giving very specific feedback on wherever you think
the protocol or code is not efficient or correct. Being unhappy isn't
going make anything better.

-- 
viresh
