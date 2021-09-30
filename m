Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0669B41D0A3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 02:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347491AbhI3Aih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 20:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347083AbhI3Aig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 20:38:36 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39454C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 17:36:54 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d8so4125230qtd.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 17:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BwrEOqITMVHTWeCijhMHSDgtGtdliHDBULe1zYCMads=;
        b=cnipXcpqu4R5bM9dgEXfQv8BOGJdXA84Z/vct47TAZsrhe6w/r9oUXvVRUGjrFVc9o
         1pqzLcPWuKWB7IKDJ67GQ2rJ0XJHZa9rDepLeYkUUjlUxrxSVALpK00Eq0gEhv5XCimW
         sHs4w+N9g0alec3otIgld2+AWdRLOeWRpLw+d3vtzb9Y7LM/WjCoP1OCGXbI5oFH2wcA
         Od4IxfZeZh+ym8BbKDSyGmZFnDZ/c6eOX1Sg9JX8M/BMCZdpEJadR2DfQiZA22RjHFQD
         9rTLu0GC5IGCqxQldXIJQ2vZ9a0iJRa0h0Mj+ZaME/saY1/RCbRN+q8xTUUHVWNi7uTT
         2+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BwrEOqITMVHTWeCijhMHSDgtGtdliHDBULe1zYCMads=;
        b=WD3vh4TP9EJN0aaN84r2h7Ari9bISNTHJmgSt48neUS7YeosfAnit6e5xX4hMs40FV
         de2MPQxeOxVIQNebhuDQkkZ/TlWP48GNJ9fskd5P/M7KaMfPlrygIbORGb+HzvLWrnDQ
         OCvI+JL/aWTcRvODNWCN1xashqV4/Z3+hOUX3bq8+fdDDuEM26Q6m4/PVGCJ4eMjh35p
         c9EMV4FBSD2Uzkkc/sGM+Vdup0DZnbRFHVw3ELrKNW4E3yT25x/gwv3wU96NEh6KkWxO
         rlK2QQRXPcSGK6adxfONc9Fd8ax2P2PCBmuadOXONMl3GwFgim97fZSZ5SuSlIKvrlzJ
         BWtQ==
X-Gm-Message-State: AOAM533Qr30iy+hLTtl9XVPdenxAARdY9oaXWJcDPEXg4s9ahLziXAQS
        bxScNJeM048/qsas2DQSS5UWcw==
X-Google-Smtp-Source: ABdhPJyC31MajIpVcurSSZ3nYCkO27psWnTuDsfNku/zaFdrDm/CS7iSRUZR5Bb8yV4im907u+gPsg==
X-Received: by 2002:ac8:5ad5:: with SMTP id d21mr3421614qtd.345.1632962213405;
        Wed, 29 Sep 2021 17:36:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id h4sm815147qtb.67.2021.09.29.17.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 17:36:52 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mVk4C-007upE-BZ; Wed, 29 Sep 2021 21:36:52 -0300
Date:   Wed, 29 Sep 2021 21:36:52 -0300
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
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
Message-ID: <20210930003652.GH3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-20-logang@deltatee.com>
 <20210928195518.GV3544071@ziepe.ca>
 <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
 <20210929230543.GB3544071@ziepe.ca>
 <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
 <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 05:49:36PM -0600, Logan Gunthorpe wrote:

> Some of this seems out of date. Pretty sure the pages are not refcounted
> with vmf_insert_mixed() and vmf_insert_mixed() is currently the only way
> to use VM_MIXEDMAP mappings.

Hum.

vmf_insert_mixed() boils down to insert_pfn() which always sets the
special bit, so vm_normal_page() returns NULL and thus the pages are
not freed during zap.

So, if the pages are always special and not refcounted all the docs
seem really out of date - or rather they describe the situation
without the special bit, I think.

Why would DAX want to do this in the first place?? This means the
address space zap is much more important that just speeding up
destruction, it is essential for correctness since the PTEs are not
holding refcounts naturally...

Sigh.

Jason
