Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A470437290
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 09:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbhJVHRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 03:17:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230332AbhJVHQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 03:16:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C0F9610C8;
        Fri, 22 Oct 2021 07:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634886882;
        bh=Pel0peMr9j2fNHvUQLXSBfGVk8lWoTqfmiiAENGLeD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g2ssWFNyioOIqxW/OoTzmvbTCwI+Y72wnGUw0bVmZhrvMBTbRFj7NRoXWwRJMTvDS
         S3mnGrOR70cw/vBio+cLEg3Idfm4Ty9QSJQvnoAOfSi/mZGXrp2hF8kLYeAF50fSJK
         1sPIPljifBqPJYWftOEyx6jeahQagJZXB9++SzCU=
Date:   Fri, 22 Oct 2021 09:14:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Will Deacon <will@kernel.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        catalin.marinas@arm.com, anshuman.khandual@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org, maz@kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/15] arm64: Self-hosted trace related errata
 workarounds
Message-ID: <YXJk3lkEm0tSUBwB@kroah.com>
References: <20211019163153.3692640-1-suzuki.poulose@arm.com>
 <20211020154207.GA3456574@p14s>
 <20211021085313.GA15622@willie-the-truck>
 <20211021163531.GA3561043@p14s>
 <20211021164730.GA16889@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021164730.GA16889@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 05:47:31PM +0100, Will Deacon wrote:
> Hi Mathieu,
> 
> [CC Greg]
> 
> On Thu, Oct 21, 2021 at 10:35:31AM -0600, Mathieu Poirier wrote:
> > On Thu, Oct 21, 2021 at 09:53:14AM +0100, Will Deacon wrote:
> > > On Wed, Oct 20, 2021 at 09:42:07AM -0600, Mathieu Poirier wrote:
> > > > On Tue, Oct 19, 2021 at 05:31:38PM +0100, Suzuki K Poulose wrote:
> > > > > Suzuki K Poulose (15):
> > > > >   arm64: Add Neoverse-N2, Cortex-A710 CPU part definition
> > > > >   arm64: errata: Add detection for TRBE overwrite in FILL mode
> > > > >   arm64: errata: Add workaround for TSB flush failures
> > > > >   arm64: errata: Add detection for TRBE write to out-of-range
> > > > >   coresight: trbe: Add a helper to calculate the trace generated
> > > > >   coresight: trbe: Add a helper to pad a given buffer area
> > > > >   coresight: trbe: Decouple buffer base from the hardware base
> > > > >   coresight: trbe: Allow driver to choose a different alignment
> > > > >   coresight: trbe: Add infrastructure for Errata handling
> > > > >   coresight: trbe: Workaround TRBE errata overwrite in FILL mode
> > > > >   coresight: trbe: Add a helper to determine the minimum buffer size
> > > > >   coresight: trbe: Make sure we have enough space
> > > > >   coresight: trbe: Work around write to out of range
> > > > >   arm64: errata: Enable workaround for TRBE overwrite in FILL mode
> > > > >   arm64: errata: Enable TRBE workaround for write to out-of-range
> > > > >     address
> > > > > 
> > > > >  Documentation/arm64/silicon-errata.rst       |  12 +
> > > > >  arch/arm64/Kconfig                           | 111 ++++++
> > > > >  arch/arm64/include/asm/barrier.h             |  16 +-
> > > > >  arch/arm64/include/asm/cputype.h             |   4 +
> > > > >  arch/arm64/kernel/cpu_errata.c               |  64 +++
> > > > >  arch/arm64/tools/cpucaps                     |   3 +
> > > > >  drivers/hwtracing/coresight/coresight-trbe.c | 394 +++++++++++++++++--
> > > > >  7 files changed, 567 insertions(+), 37 deletions(-)
> > > > 
> > > > I have applied this set.
> > > 
> > > Mathieu -- the plan here (which we have discussed on the list [1]) is
> > > for the first four patches to be shared with arm64. Since you've gone
> > > ahead and applied the whole series, please can you provide me a stable
> > > branch with the first four patches only so that I can include them in
> > > the arm64 tree?
> > > 
> > > Failing that, I can create a branch for you to pull and apply the remaining
> > > patches on top.
> > > 
> > > Please let me know.
> > 
> > Coresight patches flow through Greg's tree and as such the coresight-next tree
> > gets rebased anyway.  I will remove the first 4 patches and push again.  By the
> > way do you also want to pick up patches 14 and 16 since they are concerned with
> > "arch/arm64/Kconfig" or should I keep them?
> 
> I'll take the first 4 and put them on a stable branch, which you can choose
> to pull if you like (but please don't rebase it or we'll end up with
> duplicate commits). The rest of the patches, including the later Kconfig
> changes, are yours but I doubt they'll apply cleanly without the initial
> changes.
> 
> Are you sure Greg rebases everything? That sounds a bit weird to me, as it
> means it's impossible to share branches with other trees. How do you usually
> handle this situation?

No, I never rebase my trees.  For coresight patches I take them as
emailed patches due to previous history requiring me to review them all
myself.  If this is an issue here, I can always take a pull request as
long as you all don't want my review :)

thanks,

greg k-h
