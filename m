Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0D041B7B2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 21:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242541AbhI1TpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 15:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242470AbhI1TpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 15:45:07 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25342C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 12:43:28 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id i62so73514ioa.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 12:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rjLk0h/mLxEL3Q6/W9L7mqQkVvY6tzCz4tgaLSgLx3s=;
        b=hhjthCUJo5WhNKDnLCpo+MVqy6n87T1pJjZguVrbGVB7rs1TEqj8vSzkH1OSVJ4aHY
         Y4CBMG1r9Rmy0NZyrlH5NzTg+Y8qxZoKLG0AvCFUREnWT/psrYWEBqSqvzXvNv5yTDIr
         on4+mWLbQe9rhU1sJ0QNKudA3/36oLT7Zw6sZzQBD1xnoS8UNH2nV0XaX4yDc24jjF2F
         7QkD0f5nx2AT5EawBHny0YCDHI8greowW1MBzYmGKp/2RhkC/7+QDf784bbYh0ttqPja
         SIBG9NG6TFsrj3x8A3HpfCET+Sjd2Z1Hfpwi/GMS9Z23rUtCt6WAlr+9cdU9alzqPn1Q
         1OpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rjLk0h/mLxEL3Q6/W9L7mqQkVvY6tzCz4tgaLSgLx3s=;
        b=wcH+aVqec3JvAS4CjPqhiecUgvsYj8jR1wcE2NGHmq7ggu1EiVblkD2c7VxxRhjm+4
         UKWrQb3T9UFYyjRGomPU8+aYm19v7vx7dze13sCKEn9nZhSU2DUQxWNQGZJoFbLXWruy
         /LG4PFifjYtDbeiMB8JSDgWMqN2akgsDsYGDhiTKRKdHVpVqlvgRX936rVec5pAG5B54
         fB0zVP2bWrXm56Gdk0s0TkN7Gtm6j0w3isGI/ewrxUh1R8UA9NloEoAhpEZRGxznAjBz
         +Mqo2UyNlReGvrsH703vhCh93tJ/XGZGlmqCbvemn5wgY1oye0MducDbeNj+FZ5JSgi0
         1zgQ==
X-Gm-Message-State: AOAM532AmMv+BPcbO3chrvOKvQQW6n9qdSxuQ3Qlr5oZ+nBU5tN0GWBa
        0vKlheANYCf6A7e/JcgB8xatmg==
X-Google-Smtp-Source: ABdhPJxTc9Esg662iHYF19mOveiU9FtR9gwP3ZO8mFkHuFuDP2iiQ1yQeLzvOs2cq2YVQPchFaVZug==
X-Received: by 2002:a02:b91a:: with SMTP id v26mr6047050jan.78.1632858207605;
        Tue, 28 Sep 2021 12:43:27 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id a11sm12090741ilm.36.2021.09.28.12.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 12:43:27 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mVJ0f-007GWk-Q4; Tue, 28 Sep 2021 16:43:25 -0300
Date:   Tue, 28 Sep 2021 16:43:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v3 12/20] RDMA/rw: use dma_map_sgtable()
Message-ID: <20210928194325.GS3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-13-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-13-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 05:40:52PM -0600, Logan Gunthorpe wrote:
> dma_map_sg() now supports the use of P2PDMA pages so pci_p2pdma_map_sg()
> is no longer necessary and may be dropped.
> 
> Switch to the dma_map_sgtable() interface which will allow for better
> error reporting if the P2PDMA pages are unsupported.
> 
> The change to sgtable also appears to fix a couple subtle error path
> bugs:
> 
>   - In rdma_rw_ctx_init(), dma_unmap would be called with an sg
>     that could have been incremented from the original call, as
>     well as an nents that was not the original number of nents
>     called when mapped.
>   - Similarly in rdma_rw_ctx_signature_init, both sg and prot_sg
>     were unmapped with the incorrect number of nents.

Those bugs should definately get fixed.. I might extract the sgtable
conversion into a stand alone patch to do it.

But as it is, this looks fine

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
