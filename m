Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DFF35ED6B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346515AbhDNGoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:44:46 -0400
Received: from verein.lst.de ([213.95.11.211]:57518 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348068AbhDNGoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:44:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D9B8468AFE; Wed, 14 Apr 2021 08:43:58 +0200 (CEST)
Date:   Wed, 14 Apr 2021 08:43:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, Tianyu Lan <Tianyu.Lan@microsoft.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, thomas.lendacky@amd.com,
        brijesh.singh@amd.com, sunilmut@microsoft.com
Subject: Re: [RFC V2 PATCH 9/12] swiotlb: Add bounce buffer remap address
 setting function
Message-ID: <20210414064358.GA25877@lst.de>
References: <20210413152217.3386288-1-ltykernel@gmail.com> <20210413152217.3386288-10-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413152217.3386288-10-ltykernel@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 11:22:14AM -0400, Tianyu Lan wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> 
> For Hyper-V isolation VM with AMD SEV SNP, the bounce buffer(shared memory)
> needs to be accessed via extra address space(e.g address above bit39).
> Hyper-V code may remap extra address space outside of swiotlb. swiotlb_bounce()
> needs to use remap virtual address to copy data from/to bounce buffer. Add
> new interface swiotlb_set_bounce_remap() to do that.

I have no way to review what this actually doing when you only Cc me
on a single patch.  Please make sure everyone is Cced on the whole
series to enable proper review.
