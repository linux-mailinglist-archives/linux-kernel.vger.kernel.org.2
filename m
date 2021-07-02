Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746C73B9D77
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 10:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhGBIW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 04:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhGBIWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 04:22:24 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3128BC061764
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 01:19:51 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id h126so2784460vsc.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 01:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rI1zU6Vum6nEKxH2wJfQPCltA28jorr394zT33OyREs=;
        b=oTi1+TzEJ0UkQMFtA8SG930kUziYAPv+RyuNDCOyoYV0butu1Q7L4f0RxBa9h0Hlg/
         SrO9DwmUJtUYUJ9vmIzkLBwqQorsnVEyuFzW1T2DtHlQeknXEt6gV2f51JNVKmcZC90J
         Ob55w1LWwV0LLHlueZXT0KbrUfLfz4GxNPBVQqA7ef21L9cHY+t+vizc40y0y5AoI4aM
         q2iV1wNHKQZgThsdl2v7I9RdVJ6HZZkHxdwRgeluNhwDrCpqFMrWdnKj7DhNum+docPR
         wwzixQZ7iB1UYl0cVOUc9o5W+0MpUNY1QbQFd71Q6pdqexw8RBV5yy0ajWeZtk1oOfYl
         kPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rI1zU6Vum6nEKxH2wJfQPCltA28jorr394zT33OyREs=;
        b=LoM3RWuwUhaXxE9HH2DRKhR+ddG3PQrYdI4JtpwJzbeIHWmfFR2976Dr1F4sLdss7K
         5Abpgmp8ePwiKjii8vJGXVm/C08Q0mGB+CUJGjvw7zmGyblU8U8bQjTNLJdNA3qG+6Y9
         fshLaP24KRL6IGzGvcdkSyWd2rGCnWc4CXLjHva2bAadJhGS2Op64I8O7/exUxksXXuq
         i9UUdNjYnCxtdDzcOrSnLUAdz/3acdReVZG8S4AppxQr45QI+DLRy+aSvkssZ0Njt4+o
         oZZ9bAIfEsSTSCOvieVBUAXfkWzPEnDyRxLYTYgx4A3DSZuJTKBzYf8bHCT/833miP7m
         YbVA==
X-Gm-Message-State: AOAM533CeX3/cz/vDhYlP8w73RYSO0/dXfnEEk6FftsSOdAXQktpJdFU
        yXpIFtnWybcI0TMSZC1Fr9B4aDyUS61d9+Lni/Jd8g==
X-Google-Smtp-Source: ABdhPJxIUNWDQYNSMAluIxdMI255ZqTFEGp5TXpbUhrgpO6gEs57djZk+GOAv9f134/8IhxW0buOkX8Ot4nj0hwKTUw=
X-Received: by 2002:a67:8095:: with SMTP id b143mr4944194vsd.48.1625213990146;
 Fri, 02 Jul 2021 01:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210630122057.2795882-1-arnd@kernel.org> <6a5d06db-92af-7df0-2c71-e25bad08ee0c@rock-chips.com>
 <CAK8P3a3UjLfKpsg2M-RP3AO3CVCnZrbD71uaLf0+iiJ9RJsHCQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3UjLfKpsg2M-RP3AO3CVCnZrbD71uaLf0+iiJ9RJsHCQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 2 Jul 2021 10:19:13 +0200
Message-ID: <CAPDyKFrbQxyYUpFXfg2t071uN0JcCo74QsJ5Fx-VCkND-KKjPQ@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gbW1jOiB3YXJuIGZvciBpbnZhbGlkIFNESU8gZGF0YSBidWZmZXJz?=
        =?UTF-8?B?44CQ6K+35rOo5oSP77yM6YKu5Lu255SxbGludXgtbW1jLW93bmVyQHZnZXIua2VybmVsLm9yZ+S7ow==?=
        =?UTF-8?B?5Y+R44CR?=
To:     Arnd Bergmann <arnd@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jul 2021 at 09:03, Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Fri, Jul 2, 2021 at 3:02 AM Shawn Lin <shawn.lin@rock-chips.com> wrote:
> > On 2021/6/30 20:20, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > Jernej Skrabec reported a problem with the cw1200 driver failing on
> > > arm64 systems with CONFIG_VMAP_STACK=y.
> > >
> > > The driver in this case passes a pointer to a stack variable (in vmalloc
> > > space) into the sdio layer, which gets translated into an invalid DMA
> > > address.
> > >
> > > Even without CONFIG_VMAP_STACK, the driver is still unreliable, as
> > > cache invalidations on the DMA buffer may cause random data corruption
> > > in adjacent stack slots.
> > >
> > > This could be worked around in the SDIO core, but in the discussion we
> > > decided that passing a stack variable into SDIO should always be considered
> > > a bug, as it is for USB drivers.
> > >
> > > Change the sdio core to produce a one-time warning for any on-stack
> > > (both with and without CONFIG_VMAP_STACK) as well as any vmalloc
> > > or module-local address that would have the same translation problem.
> >
> > This was the previous comment about the same topic.
> > Should we check for mmc_io_rw_direct?
> >
> > https://www.spinics.net/lists/linux-mmc/msg41794.html
>
> Hi Shawn,
>
> thank you for remembering that previous discussion, that is a
> good question. Looking at the code though, I don't actually
> see any part of mmc_io_rw_direct() doing DMA on a caller-provided
> buffer. The only thing I see in the code is a 'u8 *out' argument, but
> that is just a pointer to a single byte that is set by this function.
>
> Do you see any other issue with that function, or does that mean
> we don't have to change it?

I was wrong when I earlier said that we needed to care about
mmc_io_rw_direct(). mmc_io_rw_direct() transfer "data" over the CMD
line. MMC host drivers can't do DMA on that.

I think the $subject patch looks reasonable to me.

Kind regards
Uffe
