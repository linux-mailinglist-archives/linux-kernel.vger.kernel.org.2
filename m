Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FF23CF669
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 10:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbhGTIPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 04:15:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234060AbhGTIJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 04:09:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BFD261209;
        Tue, 20 Jul 2021 08:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626770957;
        bh=E4QrzgjbXqoC6VoGREB4ON7zH4nlyit8ndwfY+7siow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k123DOUQxQ4obwuzQkIdMIG6t+Ua5MrHYjUv2KgMPb+7zK0H134oz62TGEEG/ng2E
         w+mYHKIlzb3tL/+E38PfoCMzkRyaWjHajmr0NzTqFAGqR4kOMpXZohvV0poCKhl+DJ
         +Nm1t7ToczHqqUJWYZJaHK9MZcWOoJfZ4PKsJQuqCj0VBSWBczqY2ErqUeXEEmxCSB
         mZUZY6rvQgOx3WRCGqezMlmskiwhVHHqZgVg44wQkYaYf7GLa/sXfx9ZmIQO1Pe966
         Qywv+/sRIfrLBpqV/aYxPZfdOx31mHZa9uoyHTXU0nd/aIQAYsXgQwKJbqKvrVy1Jh
         Qj5u79A1/sZ6Q==
Date:   Tue, 20 Jul 2021 09:49:12 +0100
From:   Will Deacon <will@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Claire Chang <tientzu@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 2/5] swiotlb: Point io_default_tlb_mem at static
 allocation
Message-ID: <20210720084912.GB8089@willie-the-truck>
References: <20210719123054.6844-1-will@kernel.org>
 <20210719123054.6844-3-will@kernel.org>
 <20210720075112.GB17565@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720075112.GB17565@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 09:51:12AM +0200, Christoph Hellwig wrote:
> I'd prefer if the next patch is merged into this one, to avoid the
> confusing state inbetween entirely.

Of course. For some reason, I half thought this patch would need to go to
stable, but the restricted DMA stuff didn't land so there's no backporting
to worry about.

I'll merge 'em for v2.

Thanks for having a look!

Will
