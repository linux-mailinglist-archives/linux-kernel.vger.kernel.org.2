Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A829D41EFFB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 16:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354626AbhJAOwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 10:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhJAOwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 10:52:39 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF947C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 07:50:54 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id c20so9172851qtb.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 07:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oMNtHpa9fOC6yHUao3VzpuzxSz0y+O1ZI66YcUTNbDE=;
        b=nPwDUL9pffjM/L5QBu2UuSP1A0QIAziR9mEhIiS0bbykKDNwFwDOCdZZPQRjytSfOl
         9664AO5c95SsAo845UWJ4llFoeGA34AMkf8JM8Jvz4IkmXmAVxiKZPf8ueKyZDj2nnhD
         7UMSgYwkQcaDxSswDKUHvCys3TK5Y5wkz2BXHjVliu2eyg29AZhT/OjKvCBrw1uscGKD
         3z+t3x/PORSTQiMEajcEoJWDN8W44+RDWzJ3OAr4hPg7SAnPZ5GisI2uKci8/QKl7Dj2
         HOKVC2LuGCjbjYvGuNPd82eSxLSRf0G3YcULGIl6j0TQwgvkOpcvnHfxonQ1DnaiELwg
         iLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oMNtHpa9fOC6yHUao3VzpuzxSz0y+O1ZI66YcUTNbDE=;
        b=co2PkftbNf6lfyIT+1MSHd9Owb5ocW5R1/aHFDyPNwl7WTrjFxskOY0oBu6V5drF1s
         qVuAQyK1OgMYW+EksVF5O6yIdNFVxfHXO0rL0NBw3HUcCivD3rwRgq8mwe9Eh8XUnhkv
         mePWsGBsJucgGencuOIo5O02MxYSODVziFw4D+sfuJnf+fzfTOGqAVrfu+vXBL9LLp36
         39Ka5htxC270ZqjlOru6srGm0gW5rNzXXva4QrSxm0Nza5pQBxBbvTFaywXd8VMnAzt0
         B/yDkfI0V5sAOdSWkaPWbIDsbh9wzEbyeQ3g5z5SQ23r/o6BjJ+1WHZ6LEGyh9XWRAJx
         JZkA==
X-Gm-Message-State: AOAM532J510nvVxaJFFiXn8pw/J2zF+NO0ZD1iAxvNdHhvMDD8TtaNQZ
        1QH+cotVZTw3kke63E3O/CyFmA==
X-Google-Smtp-Source: ABdhPJzIs8hTLztUjiDoh78mr4hOo7pek1hrPgd5bVCfeiCLQexgpwtMxfq7+czidzCd0A+vIMG+mg==
X-Received: by 2002:a05:622a:1a1c:: with SMTP id f28mr13416941qtb.346.1633099853922;
        Fri, 01 Oct 2021 07:50:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id i20sm3149803qke.102.2021.10.01.07.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 07:50:53 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mWJsC-008ctY-Nj; Fri, 01 Oct 2021 11:50:52 -0300
Date:   Fri, 1 Oct 2021 11:50:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gal Pressman <galpress@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>, Tomer Tayar <ttayar@habana.ai>
Subject: Re: [PATCH v6 2/2] habanalabs: add support for dma-buf exporter
Message-ID: <20211001145052.GO3544071@ziepe.ca>
References: <20210912165309.98695-1-ogabbay@kernel.org>
 <20210912165309.98695-3-ogabbay@kernel.org>
 <20210928173621.GG3544071@ziepe.ca>
 <CAFCwf10z-baRm8c-UD_=jcZYD0VAGrMiNo7Q5Fm-2txYmVWGcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf10z-baRm8c-UD_=jcZYD0VAGrMiNo7Q5Fm-2txYmVWGcQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 12:17:35AM +0300, Oded Gabbay wrote:
> On Tue, Sep 28, 2021 at 8:36 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Sun, Sep 12, 2021 at 07:53:09PM +0300, Oded Gabbay wrote:
> > > From: Tomer Tayar <ttayar@habana.ai>
> > >
> > > Implement the calls to the dma-buf kernel api to create a dma-buf
> > > object backed by FD.
> > >
> > > We block the option to mmap the DMA-BUF object because we don't support
> > > DIRECT_IO and implicit P2P.
> >
> > This statement doesn't make sense, you can mmap your dmabuf if you
> > like. All dmabuf mmaps are supposed to set the special bit/etc to
> > exclude them from get_user_pages() anyhow - and since this is BAR
> > memory not struct page memory this driver would be doing it anyhow.
> >
> But we block mmap the dmabuf fd from user-space.
> If you try to do it, you will get MAP_FAILED.

You do, I'm saying the above paragraph explaining *why* that was done
is not correct.

> > > We check the p2p distance using pci_p2pdma_distance_many() and refusing
> > > to map dmabuf in case the distance doesn't allow p2p.
> >
> > Does this actually allow the p2p transfer for your intended use cases?
>
> It depends on the system. If we are working bare-metal, then yes, it allows.
> If inside a VM, then no. The virtualized root complex is not
> white-listed and the kernel can't know the distance.
> But I remember you asked me to add this check, in v3 of the review IIRC.
> I don't mind removing this check if you don't object.

Yes, i tis the right code, I was curious how far along things have
gotten

> > Don't write to the kernel log from user space triggered actions
> at all ?

At all.

> It's the first time I hear about this limitation...

Oh? It is a security issue, we don't want to allow userspace to DOS
the kerne logging.

> How do you tell the user it has done something wrong ?

dev_dbg is the usual way and then users doing debugging can opt in to
the logging.


> > Why doesn't this return a sg_table * and an ERR_PTR?
> Basically I modeled this function after amdgpu_vram_mgr_alloc_sgt()
> And in that function they also return int and pass the sg_table as **
> 
> If it's critical I can change.

Please follow the normal kernel style

Jason
