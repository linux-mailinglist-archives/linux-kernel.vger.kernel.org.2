Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468C74210BC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 15:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238430AbhJDNw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 09:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237210AbhJDNwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 09:52:54 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BCAC09E7CD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 06:28:01 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id c20so15808719qtb.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 06:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6DU7gsbiNP9sjcVSmyhc3kWa3WRl9w7+FTLOGs4ZFN4=;
        b=iDoHZmkGlGlOGmyIALhCRv5d0FGVqcyqzKnkCSrwDERdEycsj9nKdyI4CDCY7dUkfu
         xidxgyjRN5kfHIRBmzvXWUYCVWONcmsNAfVlEJPerQ36OixcgdNf6z6xIX+i983wIGxX
         Fm+2zsmQUKlte1RY1Yvt03JDL8dJLW8PrakA/6MUOUbzXeejqw51g5Eeeoks+5BR2RWt
         8H1t/KDZUmwt+6LpGInv6V0CGPBr9+/eJziRGIauTdgjFf1nuaO3lqEPw168Nple9yyR
         oLcnT0bAheHnXc8spN7mnErr+Hx9iaPz3jI3W/1sr1SvZCmQMtgwq+8Jx3uPm4zXeBnI
         0JOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6DU7gsbiNP9sjcVSmyhc3kWa3WRl9w7+FTLOGs4ZFN4=;
        b=pWoBSIMnS6CTxcnCExtvht+38NCg3Eb036Htn/7imaIQc/yIdJ3/J6zhE2Jhvpx6S4
         OWFsQ1yoD5SA/aCaxRdTrUh2nVGR02ygEkHr/4OcoTLYOREetAg13vT/unwi+fM2hqSc
         rAhArasyt8I61scDrUT4ES9J/NnIpj056rvTfGHvHPPib7/Z3BBfofJkoOznLbdzCgMT
         4ZHh+x53sNxz2L4Qxo+4QNcoNafDdxmlieDWXZ4l3qFv7Fd1iIzXojrIjoOasej8utH8
         yakTwe9fhyQv8w0smdy0CfOEzSA7yqyEIIUvmHrSCWk7KpQ/wiG6NOpse2+jzYnLxOVk
         LDow==
X-Gm-Message-State: AOAM532lL04ZWiXBQ/xfPGWEikAfkLX2k0JmllUoohFPzYoUEwtXkwGc
        V7Zp55pI2VLkXroDeYqW3oz0vA==
X-Google-Smtp-Source: ABdhPJxtUT/KaZLX4EROxMBuImUPAmVtvIoSFGbrT35tFwl+26IbFnsgo9cxZTq9rMwrEpHPo9O3KQ==
X-Received: by 2002:ac8:564d:: with SMTP id 13mr13726534qtt.228.1633354080469;
        Mon, 04 Oct 2021 06:28:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id 205sm7652317qkf.19.2021.10.04.06.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 06:28:00 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mXO0d-00ATnh-F3; Mon, 04 Oct 2021 10:27:59 -0300
Date:   Mon, 4 Oct 2021 10:27:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Alistair Popple <apopple@nvidia.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
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
Message-ID: <20211004132759.GX3544071@ziepe.ca>
References: <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
 <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
 <20210930003652.GH3544071@ziepe.ca>
 <20211001134856.GN3544071@ziepe.ca>
 <4fdd337b-fa35-a909-5eee-823bfd1e9dc4@deltatee.com>
 <20211001174511.GQ3544071@ziepe.ca>
 <809be72b-efb2-752c-31a6-702c8a307ce7@amd.com>
 <20211004131102.GU3544071@ziepe.ca>
 <1e219386-7547-4f42-d090-2afd62a268d7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e219386-7547-4f42-d090-2afd62a268d7@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 03:22:22PM +0200, Christian König wrote:

> That use case is completely unrelated to GUP and when this doesn't work we
> have quite a problem.

My read is that unmap_mapping_range() guarentees the physical TLB
hardware is serialized across all CPUs upon return.

It also guarentees GUP slow is serialized due to the page table
spinlocks.

Jason
