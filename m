Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DB1305484
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 08:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbhA0HYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 02:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S316490AbhA0Akc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 19:40:32 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1F4C061224
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 15:29:22 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id c20so30596ilj.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 15:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CBy1erHkLMBcGk0Q3oow7s6KaRas0EaJCp36zieGK9E=;
        b=WkNRoEB8P5ECNzKdEHU1MaY1ENG6KFbiRYwxbKJgSn8K+bUaEv2F6ui/00GOkBbZw1
         DpHQFu74uw5I0+o/wfDdMfhbHoEjtEnlpK5FUIHFg83cKzDTFbXIl50qxrcJjlMeI8oV
         JPuFdPCN5FPGu20ODhMYQkx2qhQ0Hb0aqdWQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CBy1erHkLMBcGk0Q3oow7s6KaRas0EaJCp36zieGK9E=;
        b=sElMgbBnQWdr/VyNaa2YAIhmKt6LuEt6wAQVnmOcV2rd0GU6FjYlSBkKK0uogRPEOA
         bO+da6FaXa7TKi7KTItrPdC/zVS1uWcnv4GZW1fkzDVHTZ5oUflNP/sJ1oZgFhW4vtXI
         sf2rP+Qma2+L57hnCMoKPUkzIo5gfhb25oXz+DG2oBYiw5PhgIhQNtERV2vzhr08UBVK
         9tIXPp3GDLUwFKuYsmYdYBl2w0TE6gzzlvzYSHtC4rWUbivkw18RicsopGaF6i088G+N
         Cwm3WaRd8GKA0K1ueeltPvHbWNtAB3CIYYE5vxgd67zFImoNK88Sin8ACcG87c9ce3cS
         Wzbg==
X-Gm-Message-State: AOAM531BONaBv+eRIVWU2g/aatDb3gOKlvIU8oHbxA1z5I69gxzDxcb2
        Fmvn0qbLcX6hG5nKld7sorNFRBakYKcz0Q==
X-Google-Smtp-Source: ABdhPJx++H+/3G0TioGt+5UlqwDFwyFqLDZrSIMI9K7TgIeAyWOy6B9HKSn++PQPDBU3pGbQbTczZQ==
X-Received: by 2002:a92:8751:: with SMTP id d17mr6810008ilm.243.1611703761230;
        Tue, 26 Jan 2021 15:29:21 -0800 (PST)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com. [209.85.166.52])
        by smtp.gmail.com with ESMTPSA id z16sm79408ilp.67.2021.01.26.15.29.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 15:29:20 -0800 (PST)
Received: by mail-io1-f52.google.com with SMTP id y19so12252iov.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 15:29:20 -0800 (PST)
X-Received: by 2002:a05:6638:3012:: with SMTP id r18mr6700227jak.13.1611703759669;
 Tue, 26 Jan 2021 15:29:19 -0800 (PST)
MIME-Version: 1.0
References: <20201125221917.150463-1-ribalda@chromium.org> <20201130083410.GD32234@lst.de>
 <20201201033658.GE3723071@google.com> <20201201144916.GA14682@lst.de>
 <CAAFQd5BBEbmENrrZ-vMK9cKOap19XWmfcxwrxKfjWx-wEew8rg@mail.gmail.com>
 <20201208071320.GA1667627@google.com> <20201209111639.GB22806@lst.de>
 <CANiDSCtsOdJUK3r_t8UNKhh7Px0ANNFJkuwM1fBgZ7wnVh0JFA@mail.gmail.com>
 <20210111083614.GA27589@lst.de> <CANiDSCvuvj47=nhoWhvzc5raMxM60w+JYRWjd0YepcbcbkrUjA@mail.gmail.com>
 <20210126170659.GA9104@lst.de>
In-Reply-To: <20210126170659.GA9104@lst.de>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 27 Jan 2021 00:29:08 +0100
X-Gmail-Original-Message-ID: <CANiDSCsz+9DJesOTJ5C5HGEH-wwuTmEd3c8yLoHjnDz=2+ndJw@mail.gmail.com>
Message-ID: <CANiDSCsz+9DJesOTJ5C5HGEH-wwuTmEd3c8yLoHjnDz=2+ndJw@mail.gmail.com>
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

Thanks for the series!

I have a couple of questions:

- Is there any platform where dma_alloc_noncontiguos can fail?
This is, !ops->alloc_noncontiguous and !dev->coherent_dma_mask
If yes then we need to add a function to let the driver know in
advance that it has to use the coherent allocator (usb_alloc_coherent
for uvc)

- In dma_alloc_noncontiguos, on the dma_alloc_pages fallback. If we
have a device where the dma happens in only one direction, could not
get more performance with DMA_FROM/TO_DEVICE instead of
DMA_BIDIRECTIONAL ?


Then I have tried to use the API, and I have encountered a problem: on
uvcvideo the device passed to the memory allocator is different for
DMA_PAGES and NON_CONTIGUOUS:
https://github.com/ribalda/linux/blob/042cd497739f71c8d4a83a67ee970369e2baca4a/drivers/media/usb/uvc/uvc_video.c#L1236

I need to dig a bit tomorrow to figure out why this is, I have
hardware to test both paths, so it should not be too difficult.


Thanks again






On Tue, Jan 26, 2021 at 6:07 PM . Christoph Hellwig <hch@lst.de> wrote:
>
> Please take a quick look at this branch:
>
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma_alloc_noncontiguous
>
> Warning: hot off the press, and only with the v4l conversion as that
> seemed at little easier than uvcvideo.



--
Ricardo Ribalda
