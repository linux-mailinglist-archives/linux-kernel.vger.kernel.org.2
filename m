Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134483E29E7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 13:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245511AbhHFLlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 07:41:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233299AbhHFLlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:41:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA3E060E96;
        Fri,  6 Aug 2021 11:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628250080;
        bh=VFZN0rBpppBNLUjU4jzi8gHijERiKL8ZEpIblAjfEFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kIbH3DRTq2Yh0J8aQC6p0lG3UyMCrFt0k7rpAiM0ndNHnjsYKHVTrN1zsXHLfmQS2
         7tVJj2nnPHe9jf1CTytZeqBuRtq0T00xT252KhG41zIFSJRL8qG8bEREUhbTuGoiKc
         r2KoAKBhRm+w7dcePHZ3sd/Ry03/rGFU7qNwA8V1OEI5c81LKutKxxCG0eNsuoaqqg
         4ULK7MibdtcRy/lzmvpSksKuvu1dyKKZ6lcK0HR95hRmftAbKWLyE3Bydq+Yb6MExK
         JxoGxAULAzi64wh5k4esUAFVXlw38EzFQDaAzX6uuzDhe+C6BOttTSldrDlsQmA4Di
         ztC0VPwcEPVBw==
Date:   Fri, 6 Aug 2021 12:41:15 +0100
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Claire Chang <tientzu@chromium.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] of: restricted dma: Don't fail device probe on rmem init
 failure
Message-ID: <20210806114114.GC2531@willie-the-truck>
References: <20210805094736.902-1-will@kernel.org>
 <af998e69-671c-6d13-bd9b-da71b389575c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af998e69-671c-6d13-bd9b-da71b389575c@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 11:26:15AM +0100, Robin Murphy wrote:
> On 2021-08-05 10:47, Will Deacon wrote:
> > If CONFIG_DMA_RESTRICTED_POOL=n then probing a device with a reference
> > to a "restricted-dma-pool" will fail with a reasonably cryptic error:
> > 
> >    | pci-host-generic: probe of 10000.pci failed with error -22
> > 
> > Print a more helpful message in this case and try to continue probing
> > the device as we do if the kernel doesn't have the restricted DMA patches
> > applied or either CONFIG_OF_ADDRESS or CONFIG_HAS_DMA =n.
> 
> Makes sense to me;
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Cheers.

> Although if we allow probe to succeed when a pool really was there for a
> reason, it may end up being much more fatal if the driver then tries to do a
> DMA transfer to any old memory and the device access causes an SError, or
> the VM to be killed, or whatever. That's not quite the same as the stubbed
> cases where the respective platforms couldn't have a genuine pool to parse
> either way, but as you say it is what could happen already if the user tried
> to use an older kernel, and I think the chance of
> of_reserved_mem_device_init_by_idx() failing without something being
> terminally wrong anyway - invalid DT, not enough RAM, etc. - is low enough
> that it's probably not a major concern. Plus I'd hope that the memory
> protection schemes people do actually implement don't take such such a
> zero-tolerance approach anyway - allowing a malicious or malfunctioning
> device to take down the system because it tried to make a rogue access which
> *was* already contained seems a bit silly.

There's also a case where swiotlb is forced (swiotlb=force) but restricted
DMA pools have been sized and allocated for individual devices in the DT.
In this case, having the guest fallback to the default shared swiotlb
buffer is better than failing the probe if CONFIG_DMA_RESTRICTED_POOL=n.

Will
