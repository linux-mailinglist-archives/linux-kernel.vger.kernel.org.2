Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD643F26F3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 08:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238427AbhHTGn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 02:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbhHTGn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 02:43:58 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCF9C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 23:43:21 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id x10-20020a056830408a00b004f26cead745so11824347ott.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 23:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gxqmUwrRZAwqiy8X3obYgXIOGjmA5FJObn4NT3WZAFM=;
        b=BX+VURF5DOC7hu+YPtSTw3v34JRBpkN0EFsAPEI3x9hCXD7QZMJvkP8TgHDAgCZDP3
         SbET0WUSRfeOad90rpv6zi30kfhLoH5pQY8sn9Bq58jX2Xz53Z9ivwmnMRzRjAwjQFWs
         pwDFP1MDnn/ezvnwKdFu2lhwCS7sGrmS0q0i8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gxqmUwrRZAwqiy8X3obYgXIOGjmA5FJObn4NT3WZAFM=;
        b=q78gZrqAnw2ao3DQ6RVQ4EYKkf5Sa2xSbrmhngYcwOCORkGmgzshdI27tzE/k3lgf2
         tKs2lPIuglpdvMtMip3KPW3f37gWNja+4a9IY/9ugzQjl/V56C+KueG0LOP2zf125j01
         dTnR2aG+rfQEqSFxCn/cAY069mnM64f8z205xBP3wa/umNzgCtXTsiIZKMxhKPrwdcYX
         rVWZv1lw7EJMuqxOuge8kfpuPMoY/7ZC/W2xdBadoeUsGJRUhQYrQ2PuC4huiFY4LHkV
         1A/yxEfEHWmmcRj2X/yHN2koEa/G9iPhy9kiFmSwZV9zTACJcStxse4sdChUMGPvnhOr
         uFdw==
X-Gm-Message-State: AOAM531evfNDZAEZpvCMyWdoJj60aVNK21B5Psn1yBNz0AJJFNsNI9WN
        FMXGo5n/7QmiTjajxemYGgXVPqGEjw4oNBtRuWjlQCas2nM=
X-Google-Smtp-Source: ABdhPJzXBdk+4as9lJJTirGKrIJW71mPEY6PXJLMwZOOrdIRNHblqeb7TK0lfN3M+qLfYa7ELsK0GKBOuSXiUOZMsQI=
X-Received: by 2002:a9d:4785:: with SMTP id b5mr15495134otf.188.1629441800701;
 Thu, 19 Aug 2021 23:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210819110209.GA115485@ogabbay-vm2.habana-labs.com>
 <YR6PIvwYbYG20ZY0@kroah.com> <CAPM=9tyT_iouVE2v8J0SMJOLV=pr=QJOm88ud=bht4=5Ms2Y2A@mail.gmail.com>
In-Reply-To: <CAPM=9tyT_iouVE2v8J0SMJOLV=pr=QJOm88ud=bht4=5Ms2Y2A@mail.gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 20 Aug 2021 08:43:09 +0200
Message-ID: <CAKMK7uHP1ii7c8eM=MddqHikaP+DS-2Rj6gxMp6eBxhWqqe52w@mail.gmail.com>
Subject: Re: [git pull] habanalabs pull request for kernel 5.15
To:     Dave Airlie <airlied@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oded Gabbay <ogabbay@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 8:48 PM Dave Airlie <airlied@gmail.com> wrote:
> On Fri, 20 Aug 2021 at 03:07, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Aug 19, 2021 at 02:02:09PM +0300, Oded Gabbay wrote:
> > > Hi Greg,
> > >
> > > This is habanalabs pull request for the merge window of kernel 5.15.
> > > The commits divide roughly 50/50 between adding new features, such
> > > as peer-to-peer support with DMA-BUF or signaling from within a graph,
> > > and fixing various bugs, small improvements, etc.
> >
> > Pulled and pushed out, thanks!
>
> NAK for adding dma-buf or p2p support to this driver in the upstream
> kernel. There needs to be a hard line between
> "I-can't-believe-its-not-a-drm-driver" drivers which bypass our
> userspace requirements, and I consider this the line.
>
> This driver was merged into misc on the grounds it wasn't really a
> drm/gpu driver and so didn't have to accept our userspace rules.
>
> Adding dma-buf/p2p support to this driver is showing it really fits
> the gpu driver model and should be under the drivers/gpu rules since
> what are most GPUs except accelerators.
>
> We are opening a major can of worms (some would say merging habanalabs
> driver opened it), but this places us in the situation that if a GPU
> vendor just claims their hw is a "vector" accelerator they can use
> Greg to bypass all the work that been done to ensure we have
> maintainability long term. I don't want drivers in the tree using
> dma-buf to interact with other drivers when we don't have access to a
> userspace project to validate the kernel driver assumptions.

I think everything that can be said has been said over the last few
years, here on m-l and at plumbers, so just for the record my +1.

There's no point in negotiation for years with accel companies in the
background if the guy next door just gleefully offers to get pulled
over the table, no questions asked.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
