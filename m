Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9D843DC3D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 09:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhJ1Hk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 03:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhJ1Hkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 03:40:55 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CF7C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 00:38:28 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id t4so7121172oie.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 00:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mIbpBG4itQiw5sBCKu1rj0cAmiBtDNuZ4xna3PGBh/Q=;
        b=Bw6JQBjkaumGLz98sP/L8YyRPZRrxmyXxw9eqldJndQHUkO3TrP4JrOuHHXiHcsAlz
         1wW1T171ufeeWyh6W1Vmjz/cu2MtT78bbWqMYpgS7ThUbxXb00iCpgqYMUaS6R5ZXmve
         WoMZxWkRXSMQnymHdWaCo1ifO1Nx7snBvirOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mIbpBG4itQiw5sBCKu1rj0cAmiBtDNuZ4xna3PGBh/Q=;
        b=R54kiJCBe2MCj8HPx3MDMwG6BjCQFzDMRJxKqQ5gZOviZ3oEPSOLnzpiIWAxHpbGe0
         Kz1X0tCxnUDc8300wje25czbH8yW9dd0To0nPXWNamZlYtYIjTFSY9cWY4kttB0PIhsH
         qu++4+7pZNeb+62OL01iVZXJQAGvcivS7a46XZtQycRbvjP8GOtmC8XRfC6j8Sq9z3Vh
         jK7uH3QA+5KLili0gj1pCOWj0MnC3NEWXa2QcyhM8NtzHoaO4Ys6jyqfsTpFuCdH4Xs7
         zGyIaVnX71DoxNrm7IlXuXOdsIWWC+dFIFHazjxI6xRVIgteAnejIaG05yG94Yy8ydtg
         0Q9Q==
X-Gm-Message-State: AOAM531fvJPcttP9HRrRbT9hylT+C4iIBUZFY6GfmTFx1dyBg95fIlsy
        zhjMRa6DQVQvLasOjgwMUBiqRLo2Cr+nYjGFMqkH0A==
X-Google-Smtp-Source: ABdhPJzmScwHAlThr6qOFUACMGB5knm8qYkuuxlPKf8+xCgUKZ9Hq6DNHk+J36nz17/EWdYKk4J3erW5IFGPhvbTrLA=
X-Received: by 2002:aca:5b07:: with SMTP id p7mr6909330oib.14.1635406708196;
 Thu, 28 Oct 2021 00:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCwf119s7iXk+qpwoVPnRtOGcxeuZb3rnihf6NWWoVT-4ODHA@mail.gmail.com>
 <YTsQJ753sm701R/n@kroah.com> <CAFCwf10GD2dJMZW0DtFUFOZdXuq-opcEKEhwACbApxybjp2M3A@mail.gmail.com>
In-Reply-To: <CAFCwf10GD2dJMZW0DtFUFOZdXuq-opcEKEhwACbApxybjp2M3A@mail.gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 28 Oct 2021 09:38:17 +0200
Message-ID: <CAKMK7uFyk9eU+DS_w=_3E=6oCLKGAqoBKp4OkroZQh0Vkkv9uQ@mail.gmail.com>
Subject: Re: Habanalabs Open-Source TPC LLVM compiler and SynapseAI Core library
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Airlie <airlied@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 8:53 AM Oded Gabbay <ogabbay@kernel.org> wrote:
>
> On Fri, Sep 10, 2021 at 10:58 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Sep 10, 2021 at 10:26:56AM +0300, Oded Gabbay wrote:
> > > Hi Greg,
> > >
> > > Following our conversations a couple of months ago, I'm happy to tell you that
> > > Habanalabs has open-sourced its TPC (Tensor Processing Core) LLVM compiler,
> > > which is a fork of the LLVM open-source project.
> > >
> > > The project can be found on Habanalabs GitHub website at:
> > > https://github.com/HabanaAI/tpc_llvm
> > >
> > > There is a companion guide on how to write TPC kernels at:
> > > https://docs.habana.ai/en/latest/TPC_User_Guide/TPC_User_Guide.html
> >
> > That's great news, thanks for pushing for this and releasing it all!
> >
> > greg k-h
>
> Hi Greg,
> I would like to update that yesterday AWS launched new EC2 instances
> powered by the Gaudi accelerators. It is now in general availability,
> and anyone can launch an instance with those devices.
> Therefore, one can now take the upstream driver, hl-thunk, tpc llvm
> compiler and SynapseAI core and execute compute kernels on the Gaudi
> devices. I have verified this to be working with the driver in kernel
> 5.15-rc6.

Nice!

Now that the llvm part is open, any plans to upstream that? Years ago
when amd upstreamed their backend there was the hope that llvm would
grow some competent support for gpu style accelerator isa, but since
for years now amd's the only backend that ever was merged it's stuck
in a chicken-egg situation of upstream llvm complaining why amd
backend has all these special requirements. And other accel backends
(at least the gpu-style simd ones) not having a good path to upstream
llvm since a lot of the infrastructure and understanding isn't there.

Getting a 2nd accel backend into upstream llvm would be a huge step
towards fixing this mess. As far as I know the only other open accel
backend based on llvm is intel's igc (for intel gpus), and that one is
such a massive fork that's been out of upstream llvm for so long that
it's not going to land anytime soon, if ever (in it's current form at
least).

Once we do have an accel backend in upstream llvm we can finally start
building a real stack here I think, so whomever is first will win
quite some advantage I think.

Cheers, Daniel

> We are still missing the networking parts, but I hope to start
> upstreaming them in the next coming months.
>
> Thanks,
> Oded



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
