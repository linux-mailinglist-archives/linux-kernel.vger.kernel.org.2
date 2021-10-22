Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031144379E6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 17:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbhJVP3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 11:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbhJVP3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:29:51 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB248C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 08:27:33 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d5so3971471pfu.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 08:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A8BHCyijf/2UFTm+GkVrkGSD4ybybK43MXNCNrS4D/o=;
        b=hpgHoUHY7/Xo9tNrOFR+2SuifzmjSCJp9bJuxHG5HMTRJ5Khn0yJ8wDHVapZ16h+cF
         w/GHp0O3jGUiOf86NSBfgcUMLIqa9U/HlvLYOef5Haxdz3Kx+yxLHfVGR9rRsYnyEfq4
         MjzFmueglMMXjTJ+4SEUE6CBmo5DNGX4MfAYrDyP1jAnCM0//UPmuQQ4FMdDUpriT9lh
         mIbzNdMgSIxNwmc4pEt7pbQClRIl7nltQSJPHia+z0z5qxXWx6o2iUEjWckpRm75l32z
         AO5dQJovch5fwN0RMnEd31knb6NknUkoApaPEFHh0gy+WZLW8PRYX+G8z3jU18rLhVBo
         V5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A8BHCyijf/2UFTm+GkVrkGSD4ybybK43MXNCNrS4D/o=;
        b=GgOYTbSY4Rk54cwgwVuLiISCwQmObxKJYJblCpsSxrupad+d5/jKr52jYZUEiQalDH
         Hr2gPVRU3sAjf98/HbgL2PkllW7pY6v4SWS1+Wkq94x1Qc7VtTehe45iNrfi8xV23M9w
         2ELzdVTfdq5LVCDILxieRJ1lm4RmrpuXakA4K6XXnknfYWmmbzfBBMRAU+peT6eHGBd3
         FlKrPjkCmJ2SHxkIA9TAwEMXz1ZW/BZnWcveLQB199I6U9drKTW8f5e28wznTT1kIAHs
         QwENz3qB+BZXIiWQyLbHOMxb+r1QE66EIZnjVTYfNX22B57edQC+u+6Jg2KG7cJmGrHh
         OlZw==
X-Gm-Message-State: AOAM533kC8cE+db9E1y58utgmr389H3cFbUvZGNaBHyjHRunSdHrVAT8
        W2oLrUKYKQHCrle2Ug7GT/7JqQjhhmO0kw==
X-Google-Smtp-Source: ABdhPJwE523YiCMV4nkUlVXB9aGiINmEDP9MsBzj/21cnFdxjkbXJhcOac3fQLT6p25SCOxwHuiiLw==
X-Received: by 2002:a05:6a00:1484:b0:44c:de7f:30 with SMTP id v4-20020a056a00148400b0044cde7f0030mr430025pfu.62.1634916453049;
        Fri, 22 Oct 2021 08:27:33 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id s3sm11861996pfu.84.2021.10.22.08.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 08:27:31 -0700 (PDT)
Date:   Fri, 22 Oct 2021 09:27:29 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        catalin.marinas@arm.com, anshuman.khandual@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org, maz@kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/15] arm64: Self-hosted trace related errata
 workarounds
Message-ID: <20211022152729.GA3656244@p14s>
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
> 
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

And that won't work either because some defines declared in in patches 1 to 4
are needed in patches 10 and 13.  I will send you a pull request for this cycle.

> 
> Regards,
> Mathieu
> 
> > 
> > thanks,
> > 
> > greg k-h
