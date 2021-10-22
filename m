Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AF04379A9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 17:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhJVPPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 11:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbhJVPPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:15:33 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C97C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 08:13:15 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t5-20020a17090a4e4500b001a0a284fcc2so6006969pjl.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 08:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sPRBp7qOSoApkIeJnbeB/3ed+SUDtLUTVg/TejCrXfE=;
        b=xpDtC/mhBDh5II7WdSh6uTxOmIQRSQDZzwbSUYKSqWGBOpSTZHaURu/Ew+VyDCGQrX
         TrjjzMYr3XNZ7OMHWde+WKcu1Kk2Hm9RA6hLAHnMhl/vxomVhek4hirnU5fynzQRAUWj
         Timb1UPgYboPUePwpR/ddoyMiOTawQ/iraxCpIxsFKuJvmc6OrLoH3rZolk7O+Md/y2Y
         xYXeYkxBlrNvIriQx54aawLQeev79By6UN9Hkvw8DgwhuwtCir+OF16NJfIsEJ8grar5
         pY5E8b6OX8ITKjbsbNvEoIa72iVvrR7pOr5c5HehDHfhXmwCB/ln/fsNjaiU8l/s77Uk
         s3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sPRBp7qOSoApkIeJnbeB/3ed+SUDtLUTVg/TejCrXfE=;
        b=quTK/izRqWX07oZz52tcDr8cGEOFkOQoWOd7FQsE0N6qdv/a0566bJzmxsGTaFbdqr
         M88+QnlCN59bSE/7Cp+uZSjQo7zdweZXmutTXVnzV+TkqiLZRT/ms93N8UqgrjqBCpGf
         nu0I7x3KTm0k7WEdwcvKzWWlOg5ii1lLlqxyKkQpPaJreOnWWnfmZBpHiQ4jNifwNINh
         cOsms6D1qFHF+Nanp3e9CaM54v70IyOVJM1oABmc58ytf7Q3ZiBDqb4ek173i3r9/Jz7
         Pcap0YPzbDYdiLFjLAYkVGLqexuwT06QjcG342+OCMZRiZnrcurSb28MA3h+CYquZQir
         xPdw==
X-Gm-Message-State: AOAM532ri9k4vpV5qAp9v/GjW90ASBzDl/hso4fExu2LbZJ7TpK5cb7L
        mtNMgRM8Y41flYoCosR7DlBezw==
X-Google-Smtp-Source: ABdhPJzGAOVDQyJGbL58/ri5pISRJP0iKn0crTC4MoVQHpDPoJeGtLhPdp22ONYeUFgZKjvOW4diBQ==
X-Received: by 2002:a17:90b:4c4d:: with SMTP id np13mr15342183pjb.193.1634915595236;
        Fri, 22 Oct 2021 08:13:15 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id b130sm10092757pfb.9.2021.10.22.08.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 08:13:13 -0700 (PDT)
Date:   Fri, 22 Oct 2021 09:13:11 -0600
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
Message-ID: <20211022151311.GA3598787@p14s>
References: <20211019163153.3692640-1-suzuki.poulose@arm.com>
 <20211020154207.GA3456574@p14s>
 <20211021085313.GA15622@willie-the-truck>
 <20211021163531.GA3561043@p14s>
 <20211021164730.GA16889@willie-the-truck>
 <YXJk3lkEm0tSUBwB@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXJk3lkEm0tSUBwB@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 09:14:38AM +0200, Greg KH wrote:
> On Thu, Oct 21, 2021 at 05:47:31PM +0100, Will Deacon wrote:
> > Hi Mathieu,
> > 
> > [CC Greg]
> > 
> > On Thu, Oct 21, 2021 at 10:35:31AM -0600, Mathieu Poirier wrote:
> > > On Thu, Oct 21, 2021 at 09:53:14AM +0100, Will Deacon wrote:
> > > > On Wed, Oct 20, 2021 at 09:42:07AM -0600, Mathieu Poirier wrote:
> > > > > On Tue, Oct 19, 2021 at 05:31:38PM +0100, Suzuki K Poulose wrote:
> > > > > > Suzuki K Poulose (15):
> > > > > >   arm64: Add Neoverse-N2, Cortex-A710 CPU part definition
> > > > > >   arm64: errata: Add detection for TRBE overwrite in FILL mode
> > > > > >   arm64: errata: Add workaround for TSB flush failures
> > > > > >   arm64: errata: Add detection for TRBE write to out-of-range
> > > > > >   coresight: trbe: Add a helper to calculate the trace generated
> > > > > >   coresight: trbe: Add a helper to pad a given buffer area
> > > > > >   coresight: trbe: Decouple buffer base from the hardware base
> > > > > >   coresight: trbe: Allow driver to choose a different alignment
> > > > > >   coresight: trbe: Add infrastructure for Errata handling
> > > > > >   coresight: trbe: Workaround TRBE errata overwrite in FILL mode
> > > > > >   coresight: trbe: Add a helper to determine the minimum buffer size
> > > > > >   coresight: trbe: Make sure we have enough space
> > > > > >   coresight: trbe: Work around write to out of range
> > > > > >   arm64: errata: Enable workaround for TRBE overwrite in FILL mode
> > > > > >   arm64: errata: Enable TRBE workaround for write to out-of-range
> > > > > >     address
> > > > > > 
> > > > > >  Documentation/arm64/silicon-errata.rst       |  12 +
> > > > > >  arch/arm64/Kconfig                           | 111 ++++++
> > > > > >  arch/arm64/include/asm/barrier.h             |  16 +-
> > > > > >  arch/arm64/include/asm/cputype.h             |   4 +
> > > > > >  arch/arm64/kernel/cpu_errata.c               |  64 +++
> > > > > >  arch/arm64/tools/cpucaps                     |   3 +
> > > > > >  drivers/hwtracing/coresight/coresight-trbe.c | 394 +++++++++++++++++--
> > > > > >  7 files changed, 567 insertions(+), 37 deletions(-)
> > > > > 
> > > > > I have applied this set.
> > > > 
> > > > Mathieu -- the plan here (which we have discussed on the list [1]) is
> > > > for the first four patches to be shared with arm64. Since you've gone
> > > > ahead and applied the whole series, please can you provide me a stable
> > > > branch with the first four patches only so that I can include them in
> > > > the arm64 tree?
> > > > 
> > > > Failing that, I can create a branch for you to pull and apply the remaining
> > > > patches on top.
> > > > 
> > > > Please let me know.
> > > 
> > > Coresight patches flow through Greg's tree and as such the coresight-next tree
> > > gets rebased anyway.  I will remove the first 4 patches and push again.  By the
> > > way do you also want to pick up patches 14 and 16 since they are concerned with
> > > "arch/arm64/Kconfig" or should I keep them?
> > 
> > I'll take the first 4 and put them on a stable branch, which you can choose
> > to pull if you like (but please don't rebase it or we'll end up with
> > duplicate commits). The rest of the patches, including the later Kconfig
> > changes, are yours but I doubt they'll apply cleanly without the initial
> > changes.
> > 
> > Are you sure Greg rebases everything? That sounds a bit weird to me, as it
> > means it's impossible to share branches with other trees. How do you usually
> > handle this situation?
> 
> No, I never rebase my trees.  For coresight patches I take them as
> emailed patches due to previous history requiring me to review them all
> myself.  If this is an issue here, I can always take a pull request as
> long as you all don't want my review :)

Can you expand on the "previous history requiring" you to review coresight
patches?

Rebasing the coresight-next tree when patches are pulled in the char-misc tree
causes problems when features involve other subsystems.  I definitely appreciate
reviews of coresight patches from anyone. The subsystem has grown to be very
complex and more reviewers mean higher probabilities of catching problems.
There has to be a way for that to continue while making it easier to collaborate
with other subsystems.

For this particular patchset, Will has picked up the first 4 patches, I will pick up
patches 5 to 13 and patches 14 and 15 will have to go in the next cycle.  I
doubt this is the best we can do.

Regards,
Mathieu

> 
> thanks,
> 
> greg k-h
