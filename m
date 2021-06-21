Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816443AEAE6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 16:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhFUOPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 10:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhFUOOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 10:14:37 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9B1C061760
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 07:12:19 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id o19so13465220qtp.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 07:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8oJQZs0I5J7jBEQyNRVEZxX4UpsM7b71jbLdhb7hAG8=;
        b=FvMNMxA3fW7M2xLUZMwKYbvWPDaZY4pFbcNZf8cAZEsq+AvHkkjdBFOY2pviHteDwO
         C4Wu0SMltMsKCjOubP50lFxgNeNMSaZYEKEX7+OBgiaxrMgCwsV2iK7lgX8/+KZlk4J4
         aF5ixG7g2CBXbZTlvfOQubAF3wyQTRyw74T4Hf0/YCR0yoYa7w3a6op9w4hFlDeDVvyE
         l/inPVDU6NWf0eU0BOoi/ztftjOhg9DHQyzvWKPkZf5nnfR7X6d4ilITeIR/5CPUHzeR
         Y5yxMVmbjISlSpxOsRA2pU1pIKL7Nm9mg1e4mEqnBLS+F4tdRuCspUjlf0CxKRwGVOjA
         H0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8oJQZs0I5J7jBEQyNRVEZxX4UpsM7b71jbLdhb7hAG8=;
        b=D2VgpNUgOGicKzJc5SSoj4I0ga8tAvZY1jPRmpntc5cUTXrA0+vTB/bbZt2uYfww4g
         ETOSb/HqZ02fsXhVs4/Y7K8C06jBbWzYI7Xzvcbm/ps3BfbK2GosdOP0Vio2MsPD9WrG
         aXuIHx+qLVqe1DOSIrrlGUjPZ9rQGCI5YrJ3/Mi/dlDBO1UoQUEyasHKF4sjqw/SEX52
         FAO8vsZw21jRIWVa2pzIuSzfBpmpCscbrvmy9J72sz2GFQJKa22iQVxiUK0LvfgIaF+Z
         IQ0oAKgACTRnllyod0YDAjIYwGOKATU1qiUf6F0hgjPpWv0fXvjbV+j5PE9UKRpYzpH6
         oWdg==
X-Gm-Message-State: AOAM530y05GWm1XT65xKCFYzxTsa+F7mh7gxk+cNHbe0C2B/9cP9k/bm
        CWR44q5EjhCTdX3gOBvyVSRLEw==
X-Google-Smtp-Source: ABdhPJxB8jGNP0gwOLDPKvz+lnw80kFEjkxZj8vO8hWTPyGaIbP4EFePcOB/Ss3vtT0IcT6gYom4xg==
X-Received: by 2002:ac8:5508:: with SMTP id j8mr10071894qtq.134.1624284738855;
        Mon, 21 Jun 2021 07:12:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id r22sm10570497qtm.82.2021.06.21.07.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 07:12:18 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lvKev-009WcM-8s; Mon, 21 Jun 2021 11:12:17 -0300
Date:   Mon, 21 Jun 2021 11:12:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Oded Gabbay <ogabbay@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>, Doug Ledford <dledford@redhat.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Gal Pressman <galpress@amazon.com>, sleybo@amazon.com,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomer Tayar <ttayar@habana.ai>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 1/2] habanalabs: define uAPI to export FD for DMA-BUF
Message-ID: <20210621141217.GE1096940@ziepe.ca>
References: <20210618123615.11456-1-ogabbay@kernel.org>
 <CAKMK7uFOfoxbD2Z5mb-qHFnUe5rObGKQ6Ygh--HSH9M=9bziGg@mail.gmail.com>
 <YNCN0ulL6DQiRJaB@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNCN0ulL6DQiRJaB@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 03:02:10PM +0200, Greg KH wrote:
> On Mon, Jun 21, 2021 at 02:28:48PM +0200, Daniel Vetter wrote:

> > Also I'm wondering which is the other driver that we share buffers
> > with. The gaudi stuff doesn't have real struct pages as backing
> > storage, it only fills out the dma_addr_t. That tends to blow up with
> > other drivers, and the only place where this is guaranteed to work is
> > if you have a dynamic importer which sets the allow_peer2peer flag.
> > Adding maintainers from other subsystems who might want to chime in
> > here. So even aside of the big question as-is this is broken.
> 
> From what I can tell this driver is sending the buffers to other
> instances of the same hardware,

A dmabuf is consumed by something else in the kernel calling
dma_buf_map_attachment() on the FD.

What is the other side of this? I don't see any
dma_buf_map_attachment() calls in drivers/misc, or added in this patch
set.

AFAIK the only viable in-tree other side is in mlx5 (look in
umem_dmabuf.c)

Though as we already talked habana has their own networking (out of
tree, presumably) so I suspect this is really to support some out of
tree stuff??

Jason
