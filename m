Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F253AAECE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 10:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhFQIci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 04:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhFQIcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 04:32:33 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188F8C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 01:30:26 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id gt18so8389561ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 01:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aCrVXPjPleKRWCwRkIC1bYwcah/f3G21T+lRBwgsVZA=;
        b=Pq/9zMv+/ARBkhNnWG4THdQB8bofy/At19gV8bdA1AYnGgM1Y+ZCqupZ59ExgV0TsW
         jo/1MnZ5o7eW/siImByLzN0YUEjf6ZmYzdLHjI5qnJB8NW8Q6ltuE/Om5r0dolVo0KSi
         8g+dpvas04ZWyRtIYuwghQACK06a9/bSZKCiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aCrVXPjPleKRWCwRkIC1bYwcah/f3G21T+lRBwgsVZA=;
        b=h9KXbYtCaBogM2uHUg+NMCO39MGZtilnG8G54rJK4/xZs7d3zhDDpUxsITiqaLAOm+
         8g/Jd/zibpSs/Nrm/rNjwd0aRurxJyKldbJYUUKI/VUD9feXNV5UmEdWFGQoHk7yn1gM
         3FypmGi8qQLipoXcVOVNan6cI9joLbD04WiYjOh/R36gdvLgoQJdYMJ7Qbm04JS0qbAQ
         15/gT1k77SIbc7OvJYiZzM0HbZ0jZ13IBwHfRG18Gv6d7P7ER7coPW4fZq+bt3t/tLYK
         +qIhvvcJviZtSN0QluDClaQP3l+7SqNss1a8RW/ULqxzbzaDfaq6/1mOxdz0xnMc+TDJ
         diKQ==
X-Gm-Message-State: AOAM533U8STEXZ81GMGwWXgIUBEulu0VuUKVRiFx31Ws9KHtuTHMzCUL
        j9+YILKgNcBVHI1ahu18HU+rDUL3Hoa7pg==
X-Google-Smtp-Source: ABdhPJxOXMU+37MOsSnrlM1iPJX4uX07A5buM30QfAx8cjsEDOU2pjxHIgjzQCGD+F5Mdi1brnewDA==
X-Received: by 2002:a17:906:3845:: with SMTP id w5mr4121927ejc.518.1623918624125;
        Thu, 17 Jun 2021 01:30:24 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id k21sm3681564edo.41.2021.06.17.01.30.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 01:30:23 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id i94so5729878wri.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 01:30:23 -0700 (PDT)
X-Received: by 2002:a05:6000:551:: with SMTP id b17mr4171056wrf.32.1623918622627;
 Thu, 17 Jun 2021 01:30:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210427131344.139443-1-senozhatsky@chromium.org>
 <20210427131344.139443-9-senozhatsky@chromium.org> <10a0903a-e295-5cba-683a-1eb89a0804ed@xs4all.nl>
 <YMsAIVs7G2hUDR2F@google.com> <20210617080107.GA1422@lst.de>
In-Reply-To: <20210617080107.GA1422@lst.de>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 17 Jun 2021 17:30:11 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DiPstn-s+yQM3iMd=G9oaag39qCyX483a7-Jrn=gxWCA@mail.gmail.com>
Message-ID: <CAAFQd5DiPstn-s+yQM3iMd=G9oaag39qCyX483a7-Jrn=gxWCA@mail.gmail.com>
Subject: Re: [PATCHv2 8/8] videobuf2: handle non-contiguous DMA allocations
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 5:01 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Jun 17, 2021 at 04:56:17PM +0900, Sergey Senozhatsky wrote:
> > > This function can use some comments. What is happening AFAICS is that
> > > buf->vaddr is either set in vb2_dc_alloc_coherent (unless
> > > DMA_ATTR_NO_KERNEL_MAPPING was set), it is obtained through dma_buf_vmap()
> > > if the buffer was attached to a dma_buf, or it is allocated via
> > > dma_vmap_noncontiguous() for non-coherent memory.
> >
> > Yeah, it's complicated. Maybe we can make things more symmetrical.
> >
> > > But this leaves coherent memory with DMA_ATTR_NO_KERNEL_MAPPING set, what
> > > is vaddr in that case? I think it will call dma_vmap_noncontiguous()
> > > incorrectly in that case, shouldn't there be a check for !buf->coherent_mem
> > > before the call to dma_vmap_noncontiguous()?
> >
> > Thanks a lot for looking into it.
>
> Can we just kill off DMA_ATTR_NO_KERNEL_MAPPING in v4l now?  There really is
> no good reason to use that with dma_alloc_noncoherent/noncontiguous
> available, and I plan to eventually remove that interface entirely.

We still have use cases for dma_alloc_coherent() and DMA_ATTR_NO_KERNEL_MAPPING.

Perhaps the way to handle this would be to make the
dma_alloc_coherent() behave the same way as dma_alloc_noncontiguous(),
where it just allocates the memory without handling the kernel
mapping?

Best regards,
Tomasz
