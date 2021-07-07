Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0085A3BE970
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 16:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhGGONg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 10:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbhGGONe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 10:13:34 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BECC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 07:10:54 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id b2so3481200ejg.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 07:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UXjLA21RO8ZVTaiT53RWJR5NF6kfisIk0gt8MHSPKZA=;
        b=ZtSemU85FBGU5ie+R0xDBAxp25KfkVHjo/1V7lmSgKUsRXDu+YUsUXN86AAoW0vkSq
         SglE/WWJQ+dj2xBDYoPZUmTDhFD3EXtxXhHAtfMg52dRgi744WVlnNVOuTr82g4mROpP
         Op11tc851OTswsrDu5ZzFgtShVClUgiiFdKuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UXjLA21RO8ZVTaiT53RWJR5NF6kfisIk0gt8MHSPKZA=;
        b=ZgutCa7Jb4Kq8IA5AlHSzp/jeXDZYDHcH+yHeyrDMuCjcgx6qHp0WMRWpMDHI3xdsJ
         EWoskkrUGCPUdBwX37J0I5xETM49EmknUmJt9kEHyo7hvGmqOv4ULJr60Z2rpeCAylNg
         XkkFGLTH+KSCP26p8opTwBHO47yTSPWgHavPmR+FIEC2UcQ1iLTksKVm9sp4b0171gdi
         EOvXfgb+CUlSrnRraVmPM+X6QDZSIsw5NJYVgPjzb6Xxlp45ZhCA5yYokrt4PF9PHyZF
         af9A1pc0GTufk0hIaPJEvKTu922R31zXxg6R/HCHD1YTudR5aEIwWez/AvReZbQuGCp3
         eS/A==
X-Gm-Message-State: AOAM530iMBwpusjnRQgA1T1KgWya5xsdMtlqBEa3HIVrl5TqnCnowK+e
        fNSKwywDt1Ig+WowhBdDZrt0tb7wlViIyw==
X-Google-Smtp-Source: ABdhPJw0DuNyoFdefPqzD45AQWCYZW3l3wXp/PlWCl87GQs2HxinKy7/Aup9115EDB7I6aJGIXK3Hg==
X-Received: by 2002:a17:907:3e09:: with SMTP id hp9mr24578150ejc.37.1625667052324;
        Wed, 07 Jul 2021 07:10:52 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id z10sm8713968edd.11.2021.07.07.07.10.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 07:10:51 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id t6so3206948wrm.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 07:10:50 -0700 (PDT)
X-Received: by 2002:a5d:46cb:: with SMTP id g11mr10193300wrs.192.1625667050451;
 Wed, 07 Jul 2021 07:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210427131344.139443-1-senozhatsky@chromium.org>
 <20210427131344.139443-9-senozhatsky@chromium.org> <10a0903a-e295-5cba-683a-1eb89a0804ed@xs4all.nl>
 <YMsAIVs7G2hUDR2F@google.com> <YNVJJhP69KPJ+DHv@google.com>
 <CAAFQd5BB6JghdgGf9SjAWYuZFsZaAeU11rV1a1xrwws=w7j7_w@mail.gmail.com> <YOWsNa0Zaf9UuGWH@google.com>
In-Reply-To: <YOWsNa0Zaf9UuGWH@google.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 7 Jul 2021 23:10:37 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DDpxXBb=eJpzLPOhGQAgtBKnn0aTo=3Vs-rf44cu8OQA@mail.gmail.com>
Message-ID: <CAAFQd5DDpxXBb=eJpzLPOhGQAgtBKnn0aTo=3Vs-rf44cu8OQA@mail.gmail.com>
Subject: Re: [PATCHv2 8/8] videobuf2: handle non-contiguous DMA allocations
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 10:29 PM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (21/07/07 21:48), Tomasz Figa wrote:
> > > [..]
> > > > static void *vb2_dc_vaddr(struct vb2_buffer *vb, void *buf_priv)
> > > > {
> > > >         struct vb2_dc_buf *buf = buf_priv;
> > > >
> > > >         if (buf->vaddr)
> > > >                 return buf->vaddr;
> > > >
> > > >         if (buf->db_attach) {
> > > >                 struct dma_buf_map map;
> > > >
> > > >                 if (!dma_buf_vmap(buf->db_attach->dmabuf, &map))
> > > >                         buf->vaddr = map.vaddr;
> > > >
> > > >                 return buf->vaddr;
> > > >         }
> > > >
> > > >         if (!buf->coherent_mem)
> > > >                 buf->vaddr = dma_vmap_noncontiguous(buf->dev, buf->size,
> > > >                                                     buf->dma_sgt);
> > > >         return buf->vaddr;
> > > > }
> > > >
> > > > And in vb2_dc_alloc functions set vaddr for !DMA_ATTR_NO_KERNEL_MAPPING
> > > > in both coherent and non-coherent. So that we probably can have less
> > > > branches when ->vaddr is NULL for one type of allocations, and is not
> > > > NULL for another.
> >
> > I'd prefer if it stayed as is. This opportunistic mapping as in the
> > current revision is quite nice, because most of the drivers don't
> > bother to set DMA_ATTR_NO_KERNEL_MAPPING even if they don't need the
> > kernel mapping. Also, even if the driver itself doesn't need the
> > kernel mapping, we can still create one on demand if the DMA-buf
> > importer demands it from us.
>
> [..]
>
> > > > static int vb2_dc_alloc_coherent(struct vb2_dc_buf *buf)
> > > > {
> > > >         struct vb2_queue *q = buf->vb->vb2_queue;
> > > >
> > > >         buf->cookie = dma_alloc_attrs(buf->dev,
> > > >                                       buf->size,
> > > >                                       &buf->dma_addr,
> > > >                                       GFP_KERNEL | q->gfp_flags,
> > > >                                       buf->attrs);
> > > >         if (!buf->cookie)
> > > >                 return -ENOMEM;
> > > >
> > > >         if (q->dma_attrs & DMA_ATTR_NO_KERNEL_MAPPING)
> > > >                 return 0;
> > > >
> > > >         buf->vaddr = buf->cookie;
> > > >         return 0;
> > > > }
> > > >
> > > > static int vb2_dc_alloc_non_coherent(struct vb2_dc_buf *buf)
> > > > {
> > > >         struct vb2_queue *q = buf->vb->vb2_queue;
> > > >
> > > >         buf->dma_sgt = dma_alloc_noncontiguous(buf->dev,
> > > >                                                buf->size,
> > > >                                                buf->dma_dir,
> > > >                                                GFP_KERNEL | q->gfp_flags,
> > > >                                                buf->attrs);
> > > >         if (!buf->dma_sgt)
> > > >                 return -ENOMEM;
> > > >
> > > >         if (q->dma_attrs & DMA_ATTR_NO_KERNEL_MAPPING)
> > > >                 return 0;
> > > >
> > > >         buf->vaddr = dma_vmap_noncontiguous(buf->dev, buf->size, buf->dma_sgt);
> > > >         if (!buf->vaddr) {
> > > >                 dma_free_noncontiguous(buf->dev, buf->size,
> > > >                                        buf->dma_sgt, buf->dma_addr);
> > > >                 return -ENOMEM;
> > > >         }
> > > >         return 0;
> > > > }
> > >
> > > I guess this should address the case when
> > >
> > > "after allocating the buffer, the buffer is exported as a dma_buf and
> > > another device calls dma_buf_ops vb2_dc_dmabuf_ops_vmap, which in turn
> > > calls dma_buf_map_set_vaddr(map, buf->vaddr); with a NULL buf->vaddr"
> >
> > Sorry, I fail to get what this is about. Where does this quote come from?
>
> Bottom half of https://lore.kernel.org/lkml/10a0903a-e295-5cba-683a-1eb89a0804ed@xs4all.nl/

I see, thanks for the pointer. Yes, vb2_dc_dmabuf_ops_vmap() needs to
be changed so that it calls vb2_dc_vaddr() internally instead of
relying on buf->vaddr directly.
