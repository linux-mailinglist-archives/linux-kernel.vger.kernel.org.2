Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495A53B09E5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 18:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhFVQH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 12:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhFVQH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 12:07:57 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B30C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 09:05:40 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id x21so7242063qtq.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 09:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DZ3pXIZRpSkwolJsuMb/jDRoPgB3Tr5Ed0gJwqNhEn0=;
        b=bPcDo+rlbwvx6J+BbENOrwkAhwr/ApYX6dANLjI5IldJpUZEty9WP/A+WSRSkVnfVp
         fd2e4y/tXjqXDkPAhIKeQEV9eOqRiGPykVl6hBy9OPbjguGQbCXYh8BSABRpZ+0/loeK
         k5B7tYHxXO+OYAqc2XDEiodfylo30HXpiBw3o5xdgwyyFytUxxOswWBt61pJyEvA82JG
         jeswvAaYdQ80zAeU2QU/ihXizpJ995HOOdf81AhQWyQIhwQZLacM2brku76mBW2AwSnt
         rLC2zGxEtGcdZECkACvvAcUZ2O3xmGuKK/Qrbfiv04IEijyo0iWQN51AxkzmtGCV9rNa
         dlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DZ3pXIZRpSkwolJsuMb/jDRoPgB3Tr5Ed0gJwqNhEn0=;
        b=dsVdyS5pyCX1uA3TpP5Yv+1fvlAxwqCgJpkfinWQag4gRK0WyAcJLa9VOAHKrFshvQ
         GuK5rAPXXjymtEpkFbUo0n8YwTACna2kjPBjzEp9W+ILo60oXuebDoGR9MDqZVHvQKo1
         eX3yK0YOaYLGavWa5gJ+ZmcbhtyIi7IFPLbguNnrf/Q6nTxemBYKFdvPlQL+GhuhisdC
         LbXECVWtZ5SQJPKxxc2Qar9OxRyROHieqBRl09hXbzGkwlBnbCeKSNoVATXozRpdrTBy
         DGVlDELGuz5R/+ii0c865BV7Z63DuDFZ+djAwi6/BfpmJdzB89T1cYTd724gyei54llL
         EB1A==
X-Gm-Message-State: AOAM533R2qEi+6biPq+m6g+hi8KqZ0zZ+AGwAohzo0AmRD2/CfdDxPkn
        oxScvrH9X0a34JshSqGbpcC+uw==
X-Google-Smtp-Source: ABdhPJwsZvQD0cl9e1oHhoP7iCcZiW+TSb8cEQVE7Z3CfQWJtDN54cMi/qDxEpHPFsGzcH9l1+8wSg==
X-Received: by 2002:a05:622a:13cd:: with SMTP id p13mr4098685qtk.235.1624377939521;
        Tue, 22 Jun 2021 09:05:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id j7sm13254363qkd.21.2021.06.22.09.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 09:05:38 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lviuA-00ADrH-BE; Tue, 22 Jun 2021 13:05:38 -0300
Date:   Tue, 22 Jun 2021 13:05:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     Oded Gabbay <oded.gabbay@gmail.com>,
        Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
        Gal Pressman <galpress@amazon.com>, sleybo@amazon.com,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Oded Gabbay <ogabbay@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Doug Ledford <dledford@redhat.com>,
        Tomer Tayar <ttayar@habana.ai>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Subject: Re: [Linaro-mm-sig] [PATCH v3 1/2] habanalabs: define uAPI to export
 FD for DMA-BUF
Message-ID: <20210622160538.GT1096940@ziepe.ca>
References: <CAFCwf11jOnewkbLuxUESswCJpyo7C0ovZj80UrnwUOZkPv2JYQ@mail.gmail.com>
 <20210621232912.GK1096940@ziepe.ca>
 <d358c740-fd3a-9ecd-7001-676e2cb44ec9@gmail.com>
 <CAFCwf11h_Nj_GEdCdeTzO5jgr-Y9em+W-v_pYUfz64i5Ac25yg@mail.gmail.com>
 <20210622120142.GL1096940@ziepe.ca>
 <d497b0a2-897e-adff-295c-cf0f4ff93cb4@amd.com>
 <20210622152343.GO1096940@ziepe.ca>
 <3fabe8b7-7174-bf49-5ffe-26db30968a27@amd.com>
 <20210622154027.GS1096940@ziepe.ca>
 <09df4a03-d99c-3949-05b2-8b49c71a109e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09df4a03-d99c-3949-05b2-8b49c71a109e@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 05:48:10PM +0200, Christian König wrote:
> Am 22.06.21 um 17:40 schrieb Jason Gunthorpe:
> > On Tue, Jun 22, 2021 at 05:29:01PM +0200, Christian König wrote:
> > > [SNIP]
> > > No absolutely not. NVidia GPUs work exactly the same way.
> > > 
> > > And you have tons of similar cases in embedded and SoC systems where
> > > intermediate memory between devices isn't directly addressable with the CPU.
> > None of that is PCI P2P.
> > 
> > It is all some specialty direct transfer.
> > 
> > You can't reasonably call dma_map_resource() on non CPU mapped memory
> > for instance, what address would you pass?
> > 
> > Do not confuse "I am doing transfers between two HW blocks" with PCI
> > Peer to Peer DMA transfers - the latter is a very narrow subcase.
> > 
> > > No, just using the dma_map_resource() interface.
> > Ik, but yes that does "work". Logan's series is better.
>
> No it isn't. It makes devices depend on allocating struct pages for their
> BARs which is not necessary nor desired.

Which dramatically reduces the cost of establishing DMA mappings, a
loop of dma_map_resource() is very expensive.
 
> How do you prevent direct I/O on those pages for example?

GUP fails.

> Allocating a struct pages has their use case, for example for exposing VRAM
> as memory for HMM. But that is something very specific and should not limit
> PCIe P2P DMA in general.

Sure, but that is an ideal we are far from obtaining, and nobody wants
to work on it prefering to do hacky hacky like this.

If you believe in this then remove the scatter list from dmabuf, add a
new set of dma_map* APIs to work on physical addresses and all the
other stuff needed.

Otherwise, we have what we have and drivers don't get to opt out. This
is why the stuff in AMDGPU was NAK'd.

Jason
