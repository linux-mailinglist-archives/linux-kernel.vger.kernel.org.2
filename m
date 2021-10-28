Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400A843E06B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 14:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhJ1MDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 08:03:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhJ1MDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 08:03:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FD5A61151
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 12:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635422482;
        bh=66/4XZkO/EiB+eSR2/3xy1BlDhuYDYyfR0wFYpD6ckE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a/PpiSh1sesE/waJt83yHjofkVgT5GcgsOakKvmiDhqj2wxgn6yoWXuYR9xGAUqk8
         0G1MPg3ZAKe0NAA21zBU8TfmrQfGkLMGBYmr2FASZ2a2N28DYeD9RW7AJzmpuykxGs
         o5b8Komzu6Tav1J3Cv2j+WQXe7IB8fZU99u0/ucmrgpB8qmB3wD5C3MnlHdbm/X6xy
         tmvkDKQ8jmEXBrGNoevd5qHL8r2lHmCQEF8Y16uNl8d4yTFU4Sa+gdjGbDYh7ofmy1
         ay3G0BkovrvBlqUAfx5Cj7q/XaTbojcnDJGJVWFpVSj31aTp2FDPT4FExE6852IJgf
         2QJYEDiRao1wA==
Received: by mail-yb1-f180.google.com with SMTP id v64so8128140ybi.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 05:01:22 -0700 (PDT)
X-Gm-Message-State: AOAM530RPGWTe7HUasFG5VEzJnpAvRwQPiEDalo1i4khRypon5987lij
        Kz2gMYsqNH0xaf8EUs1za4FwoHER9tPuU5YVlQk=
X-Google-Smtp-Source: ABdhPJwGOUbD1hJiwqtt0ShnZayIpPd//JzHkG1Xh66KU16/weovnNDuJoKllTGMdOuEP3CSWV6TMkY982biNZl7IW4=
X-Received: by 2002:a25:1c02:: with SMTP id c2mr4125824ybc.218.1635422481210;
 Thu, 28 Oct 2021 05:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCwf119s7iXk+qpwoVPnRtOGcxeuZb3rnihf6NWWoVT-4ODHA@mail.gmail.com>
 <YTsQJ753sm701R/n@kroah.com> <CAFCwf10GD2dJMZW0DtFUFOZdXuq-opcEKEhwACbApxybjp2M3A@mail.gmail.com>
 <CAKMK7uFyk9eU+DS_w=_3E=6oCLKGAqoBKp4OkroZQh0Vkkv9uQ@mail.gmail.com>
In-Reply-To: <CAKMK7uFyk9eU+DS_w=_3E=6oCLKGAqoBKp4OkroZQh0Vkkv9uQ@mail.gmail.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Thu, 28 Oct 2021 15:00:54 +0300
X-Gmail-Original-Message-ID: <CAFCwf13fAxTj6LG8U=uh1nn-fKh5AHhdjTF-cHY5fdwXqH79Yg@mail.gmail.com>
Message-ID: <CAFCwf13fAxTj6LG8U=uh1nn-fKh5AHhdjTF-cHY5fdwXqH79Yg@mail.gmail.com>
Subject: Re: Habanalabs Open-Source TPC LLVM compiler and SynapseAI Core library
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Airlie <airlied@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 10:38 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> On Wed, Oct 27, 2021 at 8:53 AM Oded Gabbay <ogabbay@kernel.org> wrote:
> >
> > On Fri, Sep 10, 2021 at 10:58 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Fri, Sep 10, 2021 at 10:26:56AM +0300, Oded Gabbay wrote:
> > > > Hi Greg,
> > > >
> > > > Following our conversations a couple of months ago, I'm happy to tell you that
> > > > Habanalabs has open-sourced its TPC (Tensor Processing Core) LLVM compiler,
> > > > which is a fork of the LLVM open-source project.
> > > >
> > > > The project can be found on Habanalabs GitHub website at:
> > > > https://github.com/HabanaAI/tpc_llvm
> > > >
> > > > There is a companion guide on how to write TPC kernels at:
> > > > https://docs.habana.ai/en/latest/TPC_User_Guide/TPC_User_Guide.html
> > >
> > > That's great news, thanks for pushing for this and releasing it all!
> > >
> > > greg k-h
> >
> > Hi Greg,
> > I would like to update that yesterday AWS launched new EC2 instances
> > powered by the Gaudi accelerators. It is now in general availability,
> > and anyone can launch an instance with those devices.
> > Therefore, one can now take the upstream driver, hl-thunk, tpc llvm
> > compiler and SynapseAI core and execute compute kernels on the Gaudi
> > devices. I have verified this to be working with the driver in kernel
> > 5.15-rc6.
>
> Nice!
>
> Now that the llvm part is open, any plans to upstream that? Years ago

AFAIK, there were internal discussions about doing that and the decision was
to pursue that goal somewhere in the future. Not sure how far in the future
they were talking about...

Having said that, I'm not at all involved at the compiler front, so I
might have outdated information.
If you want, I can connect you with the compiler group leader to
discuss that with him.


Oded

> when amd upstreamed their backend there was the hope that llvm would
> grow some competent support for gpu style accelerator isa, but since
> for years now amd's the only backend that ever was merged it's stuck
> in a chicken-egg situation of upstream llvm complaining why amd
> backend has all these special requirements. And other accel backends
> (at least the gpu-style simd ones) not having a good path to upstream
> llvm since a lot of the infrastructure and understanding isn't there.
>
> Getting a 2nd accel backend into upstream llvm would be a huge step
> towards fixing this mess. As far as I know the only other open accel
> backend based on llvm is intel's igc (for intel gpus), and that one is
> such a massive fork that's been out of upstream llvm for so long that
> it's not going to land anytime soon, if ever (in it's current form at
> least).
>
> Once we do have an accel backend in upstream llvm we can finally start
> building a real stack here I think, so whomever is first will win
> quite some advantage I think.
>
> Cheers, Daniel
>
> > We are still missing the networking parts, but I hope to start
> > upstreaming them in the next coming months.
> >
> > Thanks,
> > Oded
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
