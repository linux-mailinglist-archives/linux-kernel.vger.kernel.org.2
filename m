Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F53C33AC5F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 08:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhCOHgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 03:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhCOHfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 03:35:45 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB9DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 00:35:44 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id g27so32350074iox.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 00:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qvhzd78JFcrVgfmlvFEjQlY3MhKPukXzd21KEKGnhww=;
        b=WPXVk3F7SA4y4Nef8rJie6Wi/p9PQeGdCHaSp5I1F/sH2CtRCHSyg3Mniin5qndmyx
         owDJSvOtd/CYMCnwsSQPLt3OyDJqXeoxmitkYCAq1yTLfQ/SztFPc9kk5eZat5r143GM
         gjjURblzzz8moUhqvmiT6jt7NRQO/ocAOGPEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qvhzd78JFcrVgfmlvFEjQlY3MhKPukXzd21KEKGnhww=;
        b=nJVP5EBCQokOV9Fd+j0DGTaqTfP8IU9iS4Y3Wfzt4KzPCdJX+dIinjwO+FGQ++pcJI
         p5VtSdpXB37pJh7RA4lWyIF9unWAcqGjrqbm6tl/dEiDV+jRyh3c5lA9Czx1jcrOnso3
         pl9XO9UE6lC/TIQAgTwmZlYLd7PEdTluVWozNbovRDLJIJYUbGf9KIEK1Nk4nWcf3pVn
         B3oBSgpK27HnF4vK/7kKsgzE1BPzfTAakGMKijxWtPu4bxMMVDp6up2uWr+qRogSpFZU
         EM92qfLXO56TE/kniRP5eNC2iVNeDkbMo+ns37de608raKTo3CFzwbViUM+ulANdS6lS
         fEsw==
X-Gm-Message-State: AOAM5300XsZTEPtUxtf5TcNuNkchwQpHBamZ8WD6wKUtjYqou9bbCPdz
        kMNUULq97qxEqQKa0RhBguKBGVq4BwjF1g==
X-Google-Smtp-Source: ABdhPJw1zavQRp9k/vKqpBlNI858BflNyZhqJOd8ZEbVcr15u8cD+ORCOyqb9duaR855XlIbfq5Xow==
X-Received: by 2002:a05:6638:635:: with SMTP id h21mr8081940jar.97.1615793744266;
        Mon, 15 Mar 2021 00:35:44 -0700 (PDT)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id r12sm7303707ile.59.2021.03.15.00.35.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 00:35:43 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id a7so32299499iok.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 00:35:43 -0700 (PDT)
X-Received: by 2002:a05:6602:722:: with SMTP id g2mr6345139iox.1.1615793743446;
 Mon, 15 Mar 2021 00:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210312235521.1408503-1-ribalda@chromium.org>
 <CANiDSCvK8AD7RUYGN-7e1zH9cMGTqGnwn4fJ+ZfKtktuJC14Nw@mail.gmail.com> <20210315073416.GA25860@lst.de>
In-Reply-To: <20210315073416.GA25860@lst.de>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 15 Mar 2021 08:35:36 +0100
X-Gmail-Original-Message-ID: <CANiDSCtAXmGjjN3OZVOdtquAnOW7emk_HYvQqJQtnvVAcsmRHQ@mail.gmail.com>
Message-ID: <CANiDSCtAXmGjjN3OZVOdtquAnOW7emk_HYvQqJQtnvVAcsmRHQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] media: uvcvideo: Use dma_alloc_noncontiguous API
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Sergey Senozhatsky <senozhatsky@google.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 8:34 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Mar 15, 2021 at 08:30:57AM +0100, Ricardo Ribalda wrote:
> > Hi Christoph
> >
> > I guess you can merge this patch from your tree. I hope it is not too
> > late in this release cycle.
>
> The timing is perfectly fine, I haven't even started the dma-mapping tree
> for v5.13 yet.

Awesome!

Thanks Laurent for the review!


-- 
Ricardo Ribalda
