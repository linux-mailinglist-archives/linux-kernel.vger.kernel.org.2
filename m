Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10AF4367F5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 18:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbhJUQiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 12:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbhJUQhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:37:53 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5511DC0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 09:35:37 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id np13so888517pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 09:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KHVIUdiTvtf2RCqle+9gmJBsdr1CMLvfLDk4aBN8mSU=;
        b=tW/FLNEAZ1cRWdE3iHhF+ZzDgBWnH0MT6EHQFxV7YSXVOufMc7he7A6yT/H8rYbCUm
         P5Kyw+dDeXz7OFKn0G3uSYpmPhEl/bOVmQR+eSH1IHmBs5uHcaxUBMpRpWkLeQb3kmVG
         IavF5/pQDufQ2xIqjVHOGk8OIC8GCRSYssZo7kjfei9bdvUjLxgTm9MlomaMHKtbsssm
         45NYh7uino0E7nPQRZ8GzH7HkBWzi1A2qotij8gkU1jGRej8VIrcrQWxRI5GnHSMPR73
         XBH1qZ1qaEvPAbwLexSMdjGyz5w6F1TLgkKDwQsZ6YcrqUIm3uJjIdO3CVexQNcc7qUa
         EQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KHVIUdiTvtf2RCqle+9gmJBsdr1CMLvfLDk4aBN8mSU=;
        b=hN+N6a389ncFxMJjz/QK6tKqnV51ryMxAitcKTVA7QP6aFonm1sJt8+GM0xV6Ou3D7
         fgcSv4Cx70Lv5xuBNn7sKTI3ep29QzOMsz+UwS2/v/vVdyrz84WRZVJbUlBDYsPiRVNi
         Vo4PGuDAAerAGTm25Lep1X+SEdcSIl8jyODznNR1vXO4dzmsnc9dKCYWsB/ul0w9O1Hf
         NoDWh8w6N8YtIgPqdSkajQtHYqqxFoEc5BwCZFrbUg+tqaWos3dTPKEcjJywp3AWY9zQ
         Kh/ZF9prvt6lPb6dvikmJ0tNMrcpI3VWOZcadXElsJ/lUhWjYK+5FvL0SJdx/jjclUab
         AmxA==
X-Gm-Message-State: AOAM533R1CSCzlU7vB4M25wMXv/AT1WBdjeHljj8bKVYkH149cadhkBc
        8aycklpcU+Rwof+02lF8i1ChlA==
X-Google-Smtp-Source: ABdhPJwHucTWcHJh15hHILbbn8zt3esDR8yX/30ZnNCOx6l7FZFvDq00oSu/ucc14PbMwhGoObF2YQ==
X-Received: by 2002:a17:902:a9c3:b0:13f:c765:148d with SMTP id b3-20020a170902a9c300b0013fc765148dmr6232309plr.28.1634834136756;
        Thu, 21 Oct 2021 09:35:36 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id b13sm10562729pjl.15.2021.10.21.09.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:35:34 -0700 (PDT)
Date:   Thu, 21 Oct 2021 10:35:31 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, maz@kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/15] arm64: Self-hosted trace related errata
 workarounds
Message-ID: <20211021163531.GA3561043@p14s>
References: <20211019163153.3692640-1-suzuki.poulose@arm.com>
 <20211020154207.GA3456574@p14s>
 <20211021085313.GA15622@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021085313.GA15622@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 09:53:14AM +0100, Will Deacon wrote:
> On Wed, Oct 20, 2021 at 09:42:07AM -0600, Mathieu Poirier wrote:
> > On Tue, Oct 19, 2021 at 05:31:38PM +0100, Suzuki K Poulose wrote:
> > > Suzuki K Poulose (15):
> > >   arm64: Add Neoverse-N2, Cortex-A710 CPU part definition
> > >   arm64: errata: Add detection for TRBE overwrite in FILL mode
> > >   arm64: errata: Add workaround for TSB flush failures
> > >   arm64: errata: Add detection for TRBE write to out-of-range
> > >   coresight: trbe: Add a helper to calculate the trace generated
> > >   coresight: trbe: Add a helper to pad a given buffer area
> > >   coresight: trbe: Decouple buffer base from the hardware base
> > >   coresight: trbe: Allow driver to choose a different alignment
> > >   coresight: trbe: Add infrastructure for Errata handling
> > >   coresight: trbe: Workaround TRBE errata overwrite in FILL mode
> > >   coresight: trbe: Add a helper to determine the minimum buffer size
> > >   coresight: trbe: Make sure we have enough space
> > >   coresight: trbe: Work around write to out of range
> > >   arm64: errata: Enable workaround for TRBE overwrite in FILL mode
> > >   arm64: errata: Enable TRBE workaround for write to out-of-range
> > >     address
> > > 
> > >  Documentation/arm64/silicon-errata.rst       |  12 +
> > >  arch/arm64/Kconfig                           | 111 ++++++
> > >  arch/arm64/include/asm/barrier.h             |  16 +-
> > >  arch/arm64/include/asm/cputype.h             |   4 +
> > >  arch/arm64/kernel/cpu_errata.c               |  64 +++
> > >  arch/arm64/tools/cpucaps                     |   3 +
> > >  drivers/hwtracing/coresight/coresight-trbe.c | 394 +++++++++++++++++--
> > >  7 files changed, 567 insertions(+), 37 deletions(-)
> > 
> > I have applied this set.
> 
> Mathieu -- the plan here (which we have discussed on the list [1]) is
> for the first four patches to be shared with arm64. Since you've gone
> ahead and applied the whole series, please can you provide me a stable
> branch with the first four patches only so that I can include them in
> the arm64 tree?
> 
> Failing that, I can create a branch for you to pull and apply the remaining
> patches on top.
> 
> Please let me know.

Coresight patches flow through Greg's tree and as such the coresight-next tree
gets rebased anyway.  I will remove the first 4 patches and push again.  By the
way do you also want to pick up patches 14 and 16 since they are concerned with
"arch/arm64/Kconfig" or should I keep them?

Thanks,
Mathieu

> 
> Thanks,
> 
> Will
> 
> [1] https://lore.kernel.org/all/20211008073229.GB32625@willie-the-truck/
