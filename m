Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D7C400786
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 23:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbhICVpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 17:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhICVpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 17:45:23 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9706C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 14:44:22 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 4D12C4B0; Fri,  3 Sep 2021 23:44:20 +0200 (CEST)
Date:   Fri, 3 Sep 2021 23:44:14 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>
Subject: Re: [git pull] IOMMU Updates for Linux v5.15
Message-ID: <YTKXLjwkD3Kn8VUz@8bytes.org>
References: <YTIrHxWNzIwuseXO@8bytes.org>
 <CAHk-=wjTpYOsRPm4T2EV=Sxm52buZrMpRdwSDeedCSF4jh=M1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjTpYOsRPm4T2EV=Sxm52buZrMpRdwSDeedCSF4jh=M1w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 11:43:31AM -0700, Linus Torvalds wrote:
>   choice
>         prompt "IOMMU default domain type"
>         depends on IOMMU_API
>         default IOMMU_DEFAULT_DMA_LAZY if AMD_IOMMU || INTEL_IOMMU
>         default IOMMU_DEFAULT_DMA_STRICT

Huh, yeah, that is bogus. Seems like I overlooked that part of the
patch-set because I was so amazed by the simplifications and cleanups in
the rest of it.

> See what I'm saying? Making the default be based on some random "this
> driver is enabled" when it can then affect *other* drivers that are
> also enabled and not part of the decision seems to be a fundamental
> confusion about what is going on, when it's not at all clear which
> driver will actually be IN USE.

The Kconfig option itself was actually my suggestion, but how the
default value is chosen certainly needs improvement. I will sort this
out with the people involved.

> IOW, the fix might be to just say "the default is always lazy".
> 
> Or the fix might be something that is global to a configuration and
> doesn't rely on which iommu is in use (eg "on x86, the default is
> always LAZY")
> 
> Or the fix is to make that 'iommu_dma_strict' variable - and the
> default value for it - be a per-IOMMU thing rather than be a global.

My preference would be to make 'lazy' or 'strict' the default for all,
but the ARM folks might disagree. On the other side it also doesn't make
sense to let IOMMU drivers override the users Kconfig choice at runtime.
We will discuss this and come up with something better.

Thanks,

	Joerg
