Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B867943827D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 10:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhJWJAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 05:00:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229666AbhJWJAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 05:00:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54FC460FE3;
        Sat, 23 Oct 2021 08:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634979509;
        bh=6Fq6xqNRn5jJZ7hMOv8qxUGIexBO5eOyXKjXD7XcSfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TzDNlmYxXpXzYQhIyalZpDsKXYlGw/cktBK95RsCZ38u+jQns42xwn3hYeuva/xq7
         GSgCkJx6Fce0/EnQ2bwj+w7BJwrLCctl2GHLzFPeBF78tixvkHeNOSdbhkBt6ue8un
         E1BjTGNtZS+C5Dor5zMfq2xHjIekzHiZdz3eHWzs=
Date:   Sat, 23 Oct 2021 10:58:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        catalin.marinas@arm.com, anshuman.khandual@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org, maz@kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/15] arm64: Self-hosted trace related errata
 workarounds
Message-ID: <YXPOrWASn3yM4acf@kroah.com>
References: <20211019163153.3692640-1-suzuki.poulose@arm.com>
 <20211020154207.GA3456574@p14s>
 <20211021085313.GA15622@willie-the-truck>
 <20211021163531.GA3561043@p14s>
 <20211021164730.GA16889@willie-the-truck>
 <YXJk3lkEm0tSUBwB@kroah.com>
 <20211022151311.GA3598787@p14s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022151311.GA3598787@p14s>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 09:13:11AM -0600, Mathieu Poirier wrote:
> On Fri, Oct 22, 2021 at 09:14:38AM +0200, Greg KH wrote:
> > On Thu, Oct 21, 2021 at 05:47:31PM +0100, Will Deacon wrote:
> > > Hi Mathieu,
> > > 
> > > [CC Greg]
> > > 
> > > On Thu, Oct 21, 2021 at 10:35:31AM -0600, Mathieu Poirier wrote:
> > > > On Thu, Oct 21, 2021 at 09:53:14AM +0100, Will Deacon wrote:
> > > > > On Wed, Oct 20, 2021 at 09:42:07AM -0600, Mathieu Poirier wrote:
> > > > > > On Tue, Oct 19, 2021 at 05:31:38PM +0100, Suzuki K Poulose wrote:
> > > > > > > Suzuki K Poulose (15):
> > > > > > >   arm64: Add Neoverse-N2, Cortex-A710 CPU part definition
> > > > > > >   arm64: errata: Add detection for TRBE overwrite in FILL mode
> > > > > > >   arm64: errata: Add workaround for TSB flush failures
> > > > > > >   arm64: errata: Add detection for TRBE write to out-of-range
> > > > > > >   coresight: trbe: Add a helper to calculate the trace generated
> > > > > > >   coresight: trbe: Add a helper to pad a given buffer area
> > > > > > >   coresight: trbe: Decouple buffer base from the hardware base
> > > > > > >   coresight: trbe: Allow driver to choose a different alignment
> > > > > > >   coresight: trbe: Add infrastructure for Errata handling
> > > > > > >   coresight: trbe: Workaround TRBE errata overwrite in FILL mode
> > > > > > >   coresight: trbe: Add a helper to determine the minimum buffer size
> > > > > > >   coresight: trbe: Make sure we have enough space
> > > > > > >   coresight: trbe: Work around write to out of range
> > > > > > >   arm64: errata: Enable workaround for TRBE overwrite in FILL mode
> > > > > > >   arm64: errata: Enable TRBE workaround for write to out-of-range
> > > > > > >     address
> > > > > > > 
> > > > > > >  Documentation/arm64/silicon-errata.rst       |  12 +
> > > > > > >  arch/arm64/Kconfig                           | 111 ++++++
> > > > > > >  arch/arm64/include/asm/barrier.h             |  16 +-
> > > > > > >  arch/arm64/include/asm/cputype.h             |   4 +
> > > > > > >  arch/arm64/kernel/cpu_errata.c               |  64 +++
> > > > > > >  arch/arm64/tools/cpucaps                     |   3 +
> > > > > > >  drivers/hwtracing/coresight/coresight-trbe.c | 394 +++++++++++++++++--
> > > > > > >  7 files changed, 567 insertions(+), 37 deletions(-)
> > > > > > 
> > > > > > I have applied this set.
> > > > > 
> > > > > Mathieu -- the plan here (which we have discussed on the list [1]) is
> > > > > for the first four patches to be shared with arm64. Since you've gone
> > > > > ahead and applied the whole series, please can you provide me a stable
> > > > > branch with the first four patches only so that I can include them in
> > > > > the arm64 tree?
> > > > > 
> > > > > Failing that, I can create a branch for you to pull and apply the remaining
> > > > > patches on top.
> > > > > 
> > > > > Please let me know.
> > > > 
> > > > Coresight patches flow through Greg's tree and as such the coresight-next tree
> > > > gets rebased anyway.  I will remove the first 4 patches and push again.  By the
> > > > way do you also want to pick up patches 14 and 16 since they are concerned with
> > > > "arch/arm64/Kconfig" or should I keep them?
> > > 
> > > I'll take the first 4 and put them on a stable branch, which you can choose
> > > to pull if you like (but please don't rebase it or we'll end up with
> > > duplicate commits). The rest of the patches, including the later Kconfig
> > > changes, are yours but I doubt they'll apply cleanly without the initial
> > > changes.
> > > 
> > > Are you sure Greg rebases everything? That sounds a bit weird to me, as it
> > > means it's impossible to share branches with other trees. How do you usually
> > > handle this situation?
> > 
> > No, I never rebase my trees.  For coresight patches I take them as
> > emailed patches due to previous history requiring me to review them all
> > myself.  If this is an issue here, I can always take a pull request as
> > long as you all don't want my review :)
> 
> Can you expand on the "previous history requiring" you to review coresight
> patches?

For some reason I did not take a pull request for coresight patches in
the beginning, right?  I think it was due to a number of times that the
patches submitted needed changes, which a pull request would not have
allowed to have happen easily.

> Rebasing the coresight-next tree when patches are pulled in the char-misc tree
> causes problems when features involve other subsystems.  I definitely appreciate
> reviews of coresight patches from anyone. The subsystem has grown to be very
> complex and more reviewers mean higher probabilities of catching problems.
> There has to be a way for that to continue while making it easier to collaborate
> with other subsystems.
> 
> For this particular patchset, Will has picked up the first 4 patches, I will pick up
> patches 5 to 13 and patches 14 and 15 will have to go in the next cycle.  I
> doubt this is the best we can do.

If you feel the coresight subsystem should just go in through normal
pull requests, I'm fine to take them that way now if it makes things
easier for you as I can not remember an issue with these patches in
quite some time.

So perhaps it's time to change the workflow :)

thanks,

greg k-h
