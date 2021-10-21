Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249414368CC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 19:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhJURO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 13:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhJURO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 13:14:26 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235B1C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 10:12:10 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w14so3846485edv.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 10:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qAoGLw6drI9R1j4qHjfBjMDXhe14eDMSEfxe7PtHo5M=;
        b=AtL8W9yQZo5OypCxTMhudEFcBUxaPw8bq2jRqj3Ezq9pL9e0ZSGBRldCCUKqAG/bMB
         M+n+DZq2sQSEb8nMWk3heLIjIZN90Xj7XmSvLV2YQLxcvu6OpZ+s/BpcbdW/0TUt9yYP
         IXFcX7qba4PiYsy5xl5K97xqFUpuwTyi8Nv3oAqsPa7u/UlfF82MPS+6hgO4uzm84RPC
         nrFzdJaDmqbUEo1wOF52ALIiNxr6Kd8bVcFPc8bf+Vwfauatcc1xyjDt/js6mXT7uQvP
         uFN40x3TxUU8gBrqUxMYBDrItRMFytVO3GrsoGxYZC4UEtJLhgLZlK34N/ml3ZUSps+i
         ekZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qAoGLw6drI9R1j4qHjfBjMDXhe14eDMSEfxe7PtHo5M=;
        b=GDxjGOWV3eDOZaKPe0v3p9ktC6RWi4Jnzi5gGMtg7H8A2tZt+GR+Hy/ZFEG1fdfjuK
         ZKEywdtmqdmeDatGjp8WLvUTonwOgrESVvvY1/B5ltthgFa/0f37D4N32RGGpAUW9HgC
         XfU7txNYATVLn8AWysphCHu0S+syq9RPXzM184Rs5IKA4OKqdSGwBbBR2sSU9unf70BP
         tEzCz0v5nF0/llbAtf+M+N3k2sZGAvW8JcdpcBtxyYPw5rVAImku5ab9FXgLiAvmAg5A
         MfbrmhY2bDKLRvd5djZXUTpqBIKH5vTfvK6KzA+X/79hsMMgOH3IpH/FTskeJ0YbWSLZ
         rq6g==
X-Gm-Message-State: AOAM532tSopZG59wjVdKzB23r7dLfpgO/ogIsp62J6FhgIWdcsnWPGin
        mwTHEBG0R8vTY759DvWyX2D55bkLub3xYcrowEmOcQ==
X-Google-Smtp-Source: ABdhPJw7DPBQL6nA9UjnfcudYFLvi7RhofmJBLU77VprNkV0cXNXNaSmTWIkf06wh9RK/3hHKklxv8u3+dcgpy0WFDc=
X-Received: by 2002:a17:906:131a:: with SMTP id w26mr8286410ejb.548.1634836328610;
 Thu, 21 Oct 2021 10:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211019163153.3692640-1-suzuki.poulose@arm.com>
 <20211020154207.GA3456574@p14s> <20211021085313.GA15622@willie-the-truck>
 <20211021163531.GA3561043@p14s> <20211021164730.GA16889@willie-the-truck>
In-Reply-To: <20211021164730.GA16889@willie-the-truck>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 21 Oct 2021 11:11:56 -0600
Message-ID: <CANLsYky7NA8km7Xwu_XXFSoqHcQGwYHKsggshcBKsL53e-jEng@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] arm64: Self-hosted trace related errata workarounds
To:     Will Deacon <will@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Marc Zyngier <maz@kernel.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 at 10:47, Will Deacon <will@kernel.org> wrote:
>
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

Right - I just had another look at them and what I suggested above won't work.

>
> Are you sure Greg rebases everything? That sounds a bit weird to me, as it
> means it's impossible to share branches with other trees. How do you usually
> handle this situation?

Greg applies the patches I send to him near the end of every cycle -
see this one [1] as an example.  Unfortunately that way of working
makes it hard to deal with patchsets such as this one.

To move forward you can either pick up this whole series (just add my
RB to all the CS patches) or I start sending pull requests to Greg.

Greg - what's your take on this?

[1]. https://www.spinics.net/lists/arm-kernel/msg915961.html
>
> Will
