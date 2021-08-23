Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6B13F4AE2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 14:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbhHWMl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 08:41:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:50182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235881AbhHWMl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 08:41:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD832613A8;
        Mon, 23 Aug 2021 12:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629722444;
        bh=q5U8VAdrM7JIakmwfqzISsznoFOmajlx/uTQSgI2IAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KfeHZvw6e2t0VI38lRV+B3DMFaG9gEmazNFMlGsahf6Fa5MR1uGITagNFmX2lYjFV
         fRvAZ3zsT0XdwEA6a3Bp5wwaeoYbMhu1UqEtuQHriC3Cz+a3vMRo9vBDeDMDxwYgUo
         ZWb9w839t3KHugDNgB2ABrrhBwbU4gUHHYqk5lRuZB1bqM71nfzl6xvISCuLzRBQ8J
         SGxccuc+vhnaR5OjsxRUWghuDirvV+o42rWomvQVvII4ohw8nOASuK43ucQFXy5NZ9
         99KKHrq7S04aa9hzS7eCbki9O02DgGMdtG1usfX9XYWmSqGtiUyqVD97IFjY544BOR
         KVkzmY29iWY+A==
Date:   Mon, 23 Aug 2021 13:40:39 +0100
From:   Will Deacon <will@kernel.org>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Claire Chang <tientzu@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 0/2] Don't fail device probing due to
 of_dma_set_restricted_buffer()
Message-ID: <20210823124038.GA20879@willie-the-truck>
References: <20210816132618.11707-1-will@kernel.org>
 <YSN8tz6zb65V9+an@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSN8tz6zb65V9+an@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 06:47:19AM -0400, Konrad Rzeszutek Wilk wrote:
> On Mon, Aug 16, 2021 at 02:26:15PM +0100, Will Deacon wrote:
> > Hi all,
> > 
> > This is v2 of the patch I previously posted here:
> > 
> >   https://lore.kernel.org/r/20210805094736.902-1-will@kernel.org
> > 
> > Changes since v1 are:
> > 
> >   * Move of_dma_set_restricted_buffer() into of/device.c (Rob)
> >   * Use IS_ENABLED() instead of 'static inline' stub (Rob)
> > 
> > This applies on Konrad's devel/for-linus-5.15 branch in swiotlb.git
> 
> It should show up later today.

Brill, thanks Konrad!

Will
