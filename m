Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0253151F3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhBIOrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 09:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbhBIOrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:47:07 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0357BC06178A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 06:46:27 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id d6so16298425ilo.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 06:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qVmduRDg6ZoezGmMc2NOjO9dKMtO5r7SHhLDuNpUA1w=;
        b=WFrX2nLmj6lzLxXwwRLmHplG+/4tGaqXd5F9tKmrpv0+CO88dg427I0RaNJUHcUdtl
         s+UXjDspolANS3R9Rg9KKCc/sy5aAZFcT22cgFhNe08kUqAs0wzlF+V6nniyL9Nz/4ff
         ABijo72HwNtukB2a0YkAo0BBqtLdSTQT9enFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qVmduRDg6ZoezGmMc2NOjO9dKMtO5r7SHhLDuNpUA1w=;
        b=iSAEE3SWodXcL/NE7Y7Lx23jwRfvAPALbv027IZxuPSEHTScsHpso8zYbt+3SkJXBs
         ql4qQ5ZlmS+tpp4LTOeWoKnCX0TLWSpk0/LUOul4tAnb2BrRbVew26Cf6eglDYJpVcZG
         OWOxtmAGRTjsJ1tMfebxP+7U8z7Ah6L1M+sLVppMm49LdwentlBscYrYuJ1IM0GYWXj7
         BKmvIP5HMjExOVMniz5uKNuLdEuweSD51GU4dQcgMcqYA93SnEitv0H6iaxoB3ftlhJ5
         jeyI911ydfROhVH/TryE2ykexfm5rH+NrDe1Rxoz/Z38Vj0kKZPf+XZvsaTYJe+fHOz7
         q3Ow==
X-Gm-Message-State: AOAM531DFbwwLLIAc3KMJc5PyyNiwUMdube/utKmj6mqm2UJsR4/SAbp
        ZW52y5NVZviOdkDHwp+OD/A68Pzp29LLiOeH
X-Google-Smtp-Source: ABdhPJzSog6aslFT9o3mLxJsEUvsXVrEkpd8yl+/14TOwLB7ETBHrgb+KIYrPZuICx8cj9Ed0hBCfA==
X-Received: by 2002:a92:4447:: with SMTP id a7mr21313966ilm.240.1612881986284;
        Tue, 09 Feb 2021 06:46:26 -0800 (PST)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id j1sm10329850ilu.78.2021.02.09.06.46.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 06:46:25 -0800 (PST)
Received: by mail-il1-f174.google.com with SMTP id e1so16342569ilu.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 06:46:24 -0800 (PST)
X-Received: by 2002:a05:6e02:1d0e:: with SMTP id i14mr18857395ila.69.1612881984309;
 Tue, 09 Feb 2021 06:46:24 -0800 (PST)
MIME-Version: 1.0
References: <20210202095110.1215346-1-hch@lst.de> <20210207184855.GA27553@lst.de>
 <CAAFQd5BzAvgiTLGFse+ZWUrFtZ1Ysf+p+e-4rW8gq_iP0xhWEA@mail.gmail.com>
 <20210209082213.GA31902@lst.de> <CANiDSCuzKczCnAdC9b0r-6WVBFYXYnvQHKbxSeYq2QW1uVsDLQ@mail.gmail.com>
In-Reply-To: <CANiDSCuzKczCnAdC9b0r-6WVBFYXYnvQHKbxSeYq2QW1uVsDLQ@mail.gmail.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 9 Feb 2021 15:46:13 +0100
X-Gmail-Original-Message-ID: <CANiDSCvPodsmcOi1fMwvZsyMxWsRQWNT7VkbZs4=XePYXfiXow@mail.gmail.com>
Message-ID: <CANiDSCvPodsmcOi1fMwvZsyMxWsRQWNT7VkbZs4=XePYXfiXow@mail.gmail.com>
Subject: Re: add a new dma_alloc_noncontiguous API v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sergey Senozhatsky <senozhatsky@google.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph

I have tested it in both arm and x86, since there are not significant
changes with the previous version I did not do a performance test.

Thanks!


On Tue, Feb 9, 2021 at 9:29 AM Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Hi Christoph
>
> On Tue, Feb 9, 2021 at 9:22 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Mon, Feb 08, 2021 at 08:33:50PM +0900, Tomasz Figa wrote:
> > > Sorry for the delay. The whole series looks very good to me. Thanks a lot.
> > >
> > > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> >
> > Thanks.
> >
> > Ricardo, do the uvcvideo changes look good to you?  I'd like to queue
> > the series up for this merge window.

Tested-by: Ricardo Ribalda <ribalda@chromium.org>

>
> Let me test them in real hardware today.
>
> Thanks!
>
>
> --
> Ricardo Ribalda



-- 
Ricardo Ribalda
