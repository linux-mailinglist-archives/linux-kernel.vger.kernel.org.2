Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61597435D64
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 10:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhJUIzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 04:55:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230269AbhJUIzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:55:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDA55610C8;
        Thu, 21 Oct 2021 08:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634806399;
        bh=15cz/q+3YojUzmk98Ow3a/dz1NwLEjH/pqMAOGHXd6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BFN9pZbDYr/t/Rc+2JtAdLSZIi+ss3oKr1+ZGRL0O85ZP4GXehZ+ef2l4fmNjLaPP
         Ph1QFf9VOfSc5vWOKd9kPeYGH5SK6QO2Kzve0BHXzlZfuykTpSXfzsvj/xwJtN1jxo
         knz1pB6rwU3/EFlXWD2ZmpCVCHnUneN4S8Wr/jEer1ga7XXHuokgKB1fqhp9im7hvW
         SF7ExGXR2taSixqb9IXonSxaVajMO243+Y1ZQEa8AP5n5skNKrWqKeXf/YNGgAR6kN
         eQDfLo2XHCng9oISOw9Vct9sxesW1qwNo+eFnsqcc7CL0TezteZ0RZBr9Yx/ri24vi
         CnNOKDx1wXi5A==
Date:   Thu, 21 Oct 2021 09:53:14 +0100
From:   Will Deacon <will@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, maz@kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/15] arm64: Self-hosted trace related errata
 workarounds
Message-ID: <20211021085313.GA15622@willie-the-truck>
References: <20211019163153.3692640-1-suzuki.poulose@arm.com>
 <20211020154207.GA3456574@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020154207.GA3456574@p14s>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 09:42:07AM -0600, Mathieu Poirier wrote:
> On Tue, Oct 19, 2021 at 05:31:38PM +0100, Suzuki K Poulose wrote:
> > Suzuki K Poulose (15):
> >   arm64: Add Neoverse-N2, Cortex-A710 CPU part definition
> >   arm64: errata: Add detection for TRBE overwrite in FILL mode
> >   arm64: errata: Add workaround for TSB flush failures
> >   arm64: errata: Add detection for TRBE write to out-of-range
> >   coresight: trbe: Add a helper to calculate the trace generated
> >   coresight: trbe: Add a helper to pad a given buffer area
> >   coresight: trbe: Decouple buffer base from the hardware base
> >   coresight: trbe: Allow driver to choose a different alignment
> >   coresight: trbe: Add infrastructure for Errata handling
> >   coresight: trbe: Workaround TRBE errata overwrite in FILL mode
> >   coresight: trbe: Add a helper to determine the minimum buffer size
> >   coresight: trbe: Make sure we have enough space
> >   coresight: trbe: Work around write to out of range
> >   arm64: errata: Enable workaround for TRBE overwrite in FILL mode
> >   arm64: errata: Enable TRBE workaround for write to out-of-range
> >     address
> > 
> >  Documentation/arm64/silicon-errata.rst       |  12 +
> >  arch/arm64/Kconfig                           | 111 ++++++
> >  arch/arm64/include/asm/barrier.h             |  16 +-
> >  arch/arm64/include/asm/cputype.h             |   4 +
> >  arch/arm64/kernel/cpu_errata.c               |  64 +++
> >  arch/arm64/tools/cpucaps                     |   3 +
> >  drivers/hwtracing/coresight/coresight-trbe.c | 394 +++++++++++++++++--
> >  7 files changed, 567 insertions(+), 37 deletions(-)
> 
> I have applied this set.

Mathieu -- the plan here (which we have discussed on the list [1]) is
for the first four patches to be shared with arm64. Since you've gone
ahead and applied the whole series, please can you provide me a stable
branch with the first four patches only so that I can include them in
the arm64 tree?

Failing that, I can create a branch for you to pull and apply the remaining
patches on top.

Please let me know.

Thanks,

Will

[1] https://lore.kernel.org/all/20211008073229.GB32625@willie-the-truck/
