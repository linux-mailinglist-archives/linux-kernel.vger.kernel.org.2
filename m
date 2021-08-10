Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C295F3E82C5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 20:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbhHJSRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 14:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239476AbhHJSPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 14:15:21 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35855C08EA4F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 10:49:04 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id a201so37649323ybg.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 10:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Z9ITGSDMGYjHXB8OwNKC53Rfsb5yUN6vdvBe2OSuloA=;
        b=OZNF/dI0kLDLbyn3bsG/D44IWiklGxD6aKGryYNTGg3RhEOv3iUmlRTJ0N1fdVJMkL
         NeV4VitUPkU2mCH2gRyOZjw4SIp/7jhiBSA3mycw07zVKrO4AGsjkxW01R1NgqjtaWK7
         nMky3Pw4dAdJR30D58pyzbt2gyi8gxZ7etn67AwtWKnCbqqMnEWPFp1bKXSLwV7GTnzK
         ppNkLm+nEw7bAh316KFYIM/CTmlMGgmEiGD3Oo6Y0gT3IL2GT3g6jccTSjGZEUoNE6yN
         m3ckLQvhk8RZcKnzbhF6NGGbsUhzM2UrbMm1PrMZEyf/3LKgmw+Ig3P7ApBYFaPtEJdq
         q0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Z9ITGSDMGYjHXB8OwNKC53Rfsb5yUN6vdvBe2OSuloA=;
        b=rvHhNLTfGR744ZHOg9ezMve5WUwFpKG6JEKuRWw6S6MB5Y4fGheqNzxb6tzq9IW9M9
         d7JAGlHuZ8wA7pnDehJC2kHeqXQ3fBn4otCb5Ia3mL8g7cbe3ppJg5OokrWOpbL26ywx
         k98c08r5BQ6YvXoQHhqmhqE+KrCJ6c26aXC2/ZEc3i7toA9RR/CNIGDHrSSad7lcS7rR
         zV54AUtsiaCOLhfjkxRSC8G4Odo36dtDLuJBELZKgVPJTUZ04XJWff3n/ZWLELeHUAGu
         wci6byKYdB+84XS1iu2P4pcQSWUJSEo0GkxcDjad+mV0Zvp0LEHxbQ/saBz6S+1ZF0m1
         P1zw==
X-Gm-Message-State: AOAM532l20Ex09RLmV0pUoil2wyPi57nMMgshQ5SD1qYIViceB2QMiHM
        ULtTCJB43B+aG1hmJy+0aFDdTBUG8dIxF+gzdBslDQ==
X-Google-Smtp-Source: ABdhPJzd2I7k1QBDTQy1MGH+kx9CvoalTozNbFSwVTKYDUwCUiOOv4abwyJTARFepqxgasIV14yC9ahvSU4Ye8aodvw=
X-Received: by 2002:a25:4114:: with SMTP id o20mr42745132yba.330.1628617743255;
 Tue, 10 Aug 2021 10:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210722190747.1986614-1-hridya@google.com> <CALAqxLVLMt7rbJBQtFBw-ikBAjKrVgfS8=Nu6NFQbp_gq1m22Q@mail.gmail.com>
 <CA+wgaPOQmY4H9n302YspKuLk9iq9vBzdWBTu19EUUsiQYTUOzQ@mail.gmail.com>
 <CAO_48GFS5SsdNCwOp6Jb+nmZJ+SdNkQkq628VhxXRGSLVeP0Yg@mail.gmail.com> <YRI7cqWXM545iMzO@phenom.ffwll.local>
In-Reply-To: <YRI7cqWXM545iMzO@phenom.ffwll.local>
From:   Hridya Valsaraju <hridya@google.com>
Date:   Tue, 10 Aug 2021 10:48:26 -0700
Message-ID: <CA+wgaPNQYMd8dyCcmHfHbCXKEqpF8i8nJQvb0cD1HEPG5hDMoA@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: heaps: Set allocation limit for system heap
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-media <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 1:40 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Tue, Aug 10, 2021 at 01:54:41PM +0530, Sumit Semwal wrote:
> > Hi Hridya,
> >
> > Apologies for the delay in responding.
> >
> > On Wed, 4 Aug 2021 at 03:09, Hridya Valsaraju <hridya@google.com> wrote=
:
> >
> > > On Mon, Aug 2, 2021 at 7:18 PM John Stultz <john.stultz@linaro.org> w=
rote:
> > > >
> > > > On Thu, Jul 22, 2021 at 12:07 PM Hridya Valsaraju <hridya@google.co=
m>
> > > wrote:
> > > > > This patch limits the size of total memory that can be requested =
in a
> > > > > single allocation from the system heap. This would prevent a
> > > > > buggy/malicious client from depleting system memory by requesting=
 for
> > > an
> > > > > extremely large allocation which might destabilize the system.
> > > > >
> > > > > The limit is set to half the size of the device's total RAM which=
 is
> > > the
> > > > > same as what was set by the deprecated ION system heap.
> > > > >
> > > > > Signed-off-by: Hridya Valsaraju <hridya@google.com>
> > > >
> > > > Seems sane to me, unless folks have better suggestions for allocati=
on
> > > limits.
> > > >
> > > > Reviewed-by: John Stultz <john.stultz@linaro.org>
> > >
> > > Thank you for taking a look John!
> > >
> > Looks good to me; I will apply it to drm-misc today.
>
> Please don't, this doesn't really solve anything:
> - it's easy to bypass, just allocate more buffers to get over the limit
> - resource limit plan is cgroups, not hand-rolled limits in every
>   allocator
> - the ttm "max half of system memory" is for pinned memory, to work aroun=
d
>   locking inversion issues between dma_resv_lock and core mm shrinkers. I=
t
>   does not actually impose an overall allocation limit, you can allocate
>   ttm bo until your entire memory (and swap) are full. Christian K=C3=B6n=
ig has
>   merged a patch set to lift this by reworking the shrinker interaction,
>   but it had to be reverted again because of some fallout I can't remembe=
r
>   offhand. dma_resv_lock vs shrinkers is very tricky.
>
> So if you want resource limits then you really want cgroups here.

Thanks Daniel and Sumit, that makes sense. Once the GPU memory
accounting cgroups are ready, we should be able to set the limit using
the same.

Regards,
Hridya

>
> Cheers, Daniel
>
> >
> >
> > >
> > > Regards,
> > > Hridya
> > >
> > > >
> > > > thanks
> > > > -john
> > >
> > Best,
> > Sumit.
> >
> > --
> > Thanks and regards,
> >
> > Sumit Semwal (he / him)
> > Tech Lead - LCG, Vertical Technologies
> > Linaro.org =E2=94=82 Open source software for ARM SoCs
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
