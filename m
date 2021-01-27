Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFF8306673
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 22:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbhA0Vik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 16:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbhA0Vf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 16:35:56 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519E6C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 13:35:16 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id z18so3068219ile.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 13:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B1OrPnRGym/IRixVkvzf03+5dttK+B+Ggd5w3Ge31lw=;
        b=WCzSGAO7mjzX3wOjkJ8Xi+N96UOte29yYftfMjgzGN07dKBxV6KHe6Mgk00CEi1ttL
         60aWRQW3pAzpzTDPTMn35ux/Qi8CBERZCGV0kWR2Tq7KcxKkkiycwEzw3bglvBpsUXa8
         jpX/rB8VmbY4VBdDKdaML9sNTelm7OUgk3Lac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B1OrPnRGym/IRixVkvzf03+5dttK+B+Ggd5w3Ge31lw=;
        b=cV/RVdMlm+mvTRoX0nkLI9aU5NFaHcdQuka5yX3SGV7SlDbBxJdumZaWRXEp01PUkX
         eFLgmogwmd8hLWta/96tYqV46C4cpOYE3COanYV0zca7siWR1IuPebDztVELM2+vK5UV
         Yav4SfGx+TN9MUnBVILhTvqegRenMqpavRTKZIiZwrnUnfv1uH3fChvSXp7O+5zIwV6C
         E3ydwkqBAWUypISua6CETEtdugTXXu6gNXYDwoIj9QqywR800zMzswbsZ4m6cQLDSQII
         Rbaxqx4/j8xFLXcIgvIE/3XxeY44ox6FcO6MVt4H45fNhzIDoLaY+nSElKeaIiIqODHB
         VgbQ==
X-Gm-Message-State: AOAM532LGLawu5VH4Jn5EdlvwPPNN7ENUuk+cP9DA9FGmthzApGc/9qt
        IVR/BbJYAcpwOEMna5wrSTn1lEKOb5cFEn2I
X-Google-Smtp-Source: ABdhPJzJiujy3VFsk6Kod8x5w6D5FS9KM3W/IPQ8HWSokAg9rYFZ8/Kll2ZFORimJH0hfp61Rv6GXw==
X-Received: by 2002:a92:2c06:: with SMTP id t6mr7568320ile.92.1611783315286;
        Wed, 27 Jan 2021 13:35:15 -0800 (PST)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id g9sm1828309ilp.49.2021.01.27.13.35.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 13:35:14 -0800 (PST)
Received: by mail-il1-f176.google.com with SMTP id y17so3303487ili.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 13:35:13 -0800 (PST)
X-Received: by 2002:a05:6e02:194e:: with SMTP id x14mr10530200ilu.218.1611783313321;
 Wed, 27 Jan 2021 13:35:13 -0800 (PST)
MIME-Version: 1.0
References: <20201201033658.GE3723071@google.com> <20201201144916.GA14682@lst.de>
 <CAAFQd5BBEbmENrrZ-vMK9cKOap19XWmfcxwrxKfjWx-wEew8rg@mail.gmail.com>
 <20201208071320.GA1667627@google.com> <20201209111639.GB22806@lst.de>
 <CANiDSCtsOdJUK3r_t8UNKhh7Px0ANNFJkuwM1fBgZ7wnVh0JFA@mail.gmail.com>
 <20210111083614.GA27589@lst.de> <CANiDSCvuvj47=nhoWhvzc5raMxM60w+JYRWjd0YepcbcbkrUjA@mail.gmail.com>
 <20210126170659.GA9104@lst.de> <CANiDSCsz+9DJesOTJ5C5HGEH-wwuTmEd3c8yLoHjnDz=2+ndJw@mail.gmail.com>
 <20210127155608.GA20272@lst.de>
In-Reply-To: <20210127155608.GA20272@lst.de>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 27 Jan 2021 22:35:02 +0100
X-Gmail-Original-Message-ID: <CANiDSCsHquQWgeGurmh83UDm3xPzkzaRTV0EOKQs=Q_a349f=Q@mail.gmail.com>
Message-ID: <CANiDSCsHquQWgeGurmh83UDm3xPzkzaRTV0EOKQs=Q_a349f=Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] media: uvcvideo: Use dma_alloc_noncontiguos API
To:     ". Christoph Hellwig" <hch@lst.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph

On Wed, Jan 27, 2021 at 4:56 PM . Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Jan 27, 2021 at 12:29:08AM +0100, Ricardo Ribalda wrote:
> > - Is there any platform where dma_alloc_noncontiguos can fail?
> > This is, !ops->alloc_noncontiguous and !dev->coherent_dma_mask
> > If yes then we need to add a function to let the driver know in
> > advance that it has to use the coherent allocator (usb_alloc_coherent
> > for uvc)
>
> dev->coherent_dma_mask is set by the driver.  So the only reason why
> dma_alloc_noncontiguos will fail is because is because it can't
> allocate any memory.
>
> > - In dma_alloc_noncontiguos, on the dma_alloc_pages fallback. If we
> > have a device where the dma happens in only one direction, could not
> > get more performance with DMA_FROM/TO_DEVICE instead of
> > DMA_BIDIRECTIONAL ?
>
> Yes, we could probably do that.
>
> >
> >
> > Then I have tried to use the API, and I have encountered a problem: on
> > uvcvideo the device passed to the memory allocator is different for
> > DMA_PAGES and NON_CONTIGUOUS:
> > https://github.com/ribalda/linux/blob/042cd497739f71c8d4a83a67ee970369e2baca4a/drivers/media/usb/uvc/uvc_video.c#L1236
> >
> > I need to dig a bit tomorrow to figure out why this is, I have
> > hardware to test both paths, so it should not be too difficult.
>
> I always found the USB dma alloc API a little weird, but we might have
> to follow the scheme of the usb coherent wrappers there.

I have used the current API here:

https://git.kernel.org/pub/scm/linux/kernel/git/ribalda/linux.git/log/?h=uvc-noncontiguous

And I think the result is very clean. Great work!

I have tested it in X86 and in arm64, with similar performance as the
previous patchset.

Maybe you want to cherry pick that commit into your series I can also
send the patch to the list for review if you prefer so.

At least in 5.11 rc5 I the same dmadev worked in arm64 and x86.

Best regards!


-- 
Ricardo Ribalda
