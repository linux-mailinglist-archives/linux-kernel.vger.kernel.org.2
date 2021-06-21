Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CEF3AEB05
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 16:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhFUOUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 10:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhFUOUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 10:20:14 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151BEC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 07:17:59 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id t9so13477714qtw.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 07:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f5JgZDeoCfa2i8b2+lJPyccTDGeyU3UeQJEKpYqzmGw=;
        b=iW/qNwvjUN60qOdsm7Tc/2UgFmrbPL7i3tcOoqV4K4nAE5p++VtMzaD7tQUmZY5aS/
         08eVJcFISGR01jyo6CIqviQAi8/x8nwo8NCY7YrYTVakAPQRX4ny9mcq8xMudYSJADOQ
         h+yKiUXxtEnGjWiqtTAEO+fkAVZBXqOEiFWJnEcxmy2hkR14/qsVhyet4cLlhORAQjbS
         5b3b0Ub6MVs3bJel4J0zd7N6pAGiflA4WAmb2m/748JAvI/uviYVvmmbpTnenWCmngzg
         /0zm6jCnZ052zu8m26gQyrxVJtmvIX29vAGvfAg8myajT6QOMOcUsreOn1mLyatblaTF
         2yQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f5JgZDeoCfa2i8b2+lJPyccTDGeyU3UeQJEKpYqzmGw=;
        b=HhK2sqGG0Yt7PjZwRbTf74wCXIJhvig7HoFRUoZHxkQiOah2g0ciZXx2sjPoMHGHAy
         3hEVqLTZFRYdqiOkNCSOV/UT/THDcGlPVXVi8AAhtekIPlzFyDi/DAQ4b8bghu9hkNTu
         0ZWFDuZM21xK6zkMCqJ0MVdZBQHi7hhvY7GOZOU4wOQqQVrd4a9lSVXIX2IV9iyd1Yp5
         iYrJ7yjWRBmVf4XOZ5puF6Xl9nhZxgJEIHED9ENWdEBlUpn4SQj+gIf6SlFJIewO+6R0
         EMfTRWYBs7zgCcgCbtIzc6xO5bjM9F7UCFTpONiEyib2bNkhiGzJs6OzvTY48fnNxb7G
         mWJw==
X-Gm-Message-State: AOAM531Nf0nHgFSIEXgRNg7mik3Jg16UNFrnB6JFnIWeETE/KiWOzJiZ
        a5ybGyEcu8V1Jt81wW/QLdLalA==
X-Google-Smtp-Source: ABdhPJwxuJR5FNaFOeQuuTYdtMofIT5+18r8iXh+MV7YhfMRJf27n/x+7ThZDE3kkaBxOtliYq23Aw==
X-Received: by 2002:ac8:44ca:: with SMTP id b10mr24067709qto.224.1624285077981;
        Mon, 21 Jun 2021 07:17:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id y15sm10797034qto.90.2021.06.21.07.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 07:17:57 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lvKkO-009WjS-US; Mon, 21 Jun 2021 11:17:56 -0300
Date:   Mon, 21 Jun 2021 11:17:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Oded Gabbay <ogabbay@kernel.org>, Christoph Hellwig <hch@lst.de>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>, Doug Ledford <dledford@redhat.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Gal Pressman <galpress@amazon.com>, sleybo@amazon.com,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomer Tayar <ttayar@habana.ai>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH v3 1/2] habanalabs: define uAPI to export FD for DMA-BUF
Message-ID: <20210621141756.GF1096940@ziepe.ca>
References: <20210618123615.11456-1-ogabbay@kernel.org>
 <CAKMK7uFOfoxbD2Z5mb-qHFnUe5rObGKQ6Ygh--HSH9M=9bziGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uFOfoxbD2Z5mb-qHFnUe5rObGKQ6Ygh--HSH9M=9bziGg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 02:28:48PM +0200, Daniel Vetter wrote:

> Mission acomplished, we've gone full circle, and the totally-not-a-gpu
> driver is now trying to use gpu infrastructure. And seems to have
> gained vram meanwhile too. Next up is going to be synchronization
> using dma_fence so you can pass buffers back&forth without stalls
> among drivers.

Well, we can't even see the other side of this so who knows

This is a new uAPI, where is the userspace? In RDMA at least I require
to see the new userspace and test suite before changes to
include/uapi/rdma can go ahead.

> Doug/Jason from infiniband: Should we add linux-rdma to the dma-buf
> wildcard match so that you can catch these next time around too? At
> least when people use scripts/get_maintainers.pl correctly. All the
> other subsystems using dma-buf are on there already (dri-devel,
> linux-media and linaro-mm-sig for android/arm embedded stuff).

My bigger concern is this doesn't seem to be implementing PCI P2P DMA
correctly. This is following the same hacky NULL page approach that
Christoph Hellwig already NAK'd for AMD.

This should not be allowed to proliferate.

I would be much happier seeing this be done using the approach of
Logan's series here:

https://lore.kernel.org/linux-block/20210513223203.5542-1-logang@deltatee.com/

Jason
