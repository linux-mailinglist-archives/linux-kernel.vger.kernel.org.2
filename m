Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6CF41B73C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 21:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242431AbhI1TN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 15:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242495AbhI1TNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 15:13:19 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D31C061766
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 12:11:11 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id p80so28713072iod.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 12:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dAXGT1q19wzeDZuDAAKylN0FjSdSatuZU8qbovqANdw=;
        b=NIsddmzY0SYPds0DsYkmoKZofq4uefBOl/rEvHgX2wf4Sq0Q/kPfCr88FedGCk72x4
         M85CSii4YgqgeM0qNeZZf3HW2JP2y18v42D5jWWJxvBa620My0qz75JLiIxzKFePaec2
         fhlmmNtBIFu07KD16S0Ue2uzNiDFkv4tUm/ROVOWgsufiRUPYkqXwQJynXHEpPzfeWNl
         lT9KnR8RE94I6VBQwgECcNJi86FzLxVTZHjBXlz92yIisi+ep1Kytv6n7liUaJT+LBIn
         HQ3MgYljZM9zacpI6dVo9OhsLwET/JAbBNrnWr1DQI5h4ySl49sjVWB2ztyrVHrLwEzy
         Inxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dAXGT1q19wzeDZuDAAKylN0FjSdSatuZU8qbovqANdw=;
        b=2BzkUUorwo1Q8Pz1wJctnkF6pritkQ/FoqKKYGZFFVNtXxq4OMITsZ1Fzy3owOSiK4
         i6EcVP+PkJUrWbxqOt0QgcXXqfWJZ09b6xnbJjPqGDcN6rdySsk2PVbuGFv3sMDdn+nc
         PuGk/CHjBsvIdiJqyzpZ+U33K5hnf99f1gYLHku7sPl6mS7MWbGEgURGUXcUxe7UTNn7
         +esUfZTUkaGcvKt5fxVLFQ50cy4SLIjd9EtcUPXHfkelC6OkNcIsyT2g80HFb3SKXXlu
         ozxmLggq4bgaqpNYDgFElcLg+buZmz/Abof9C0u08p6NH3K251pkpuNbwkZVe6ovKAWu
         jdXw==
X-Gm-Message-State: AOAM532SOL3t8yKBffxHzKuiw7FFz3rZjrTVrZCpEW4sMyvnf/8knS4u
        kvNV7bsLG4vMcyYuchzXmS4gkg==
X-Google-Smtp-Source: ABdhPJyf8mt18AlEnK05TMnL1sFZAfxIPVyMiQRw0bFkerbSvSvkBso11/Xmw8q6+HkK6ya/0EoZuA==
X-Received: by 2002:a6b:5b14:: with SMTP id v20mr5202033ioh.142.1632856270563;
        Tue, 28 Sep 2021 12:11:10 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id b14sm1785849ilc.63.2021.09.28.12.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 12:11:10 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mVIVR-007Fxh-2M; Tue, 28 Sep 2021 16:11:09 -0300
Date:   Tue, 28 Sep 2021 16:11:09 -0300
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
Subject: Re: [PATCH v3 07/20] dma-mapping: add flags to dma_map_ops to
 indicate PCI P2PDMA support
Message-ID: <20210928191109.GO3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-8-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-8-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 05:40:47PM -0600, Logan Gunthorpe wrote:
> Add a flags member to the dma_map_ops structure with one flag to
> indicate support for PCI P2PDMA.
> 
> Also, add a helper to check if a device supports PCI P2PDMA.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  include/linux/dma-map-ops.h | 10 ++++++++++
>  include/linux/dma-mapping.h |  5 +++++
>  kernel/dma/mapping.c        | 18 ++++++++++++++++++
>  3 files changed, 33 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
