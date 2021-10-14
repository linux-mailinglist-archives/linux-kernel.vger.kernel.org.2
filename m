Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9DF42D996
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 14:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhJNM6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 08:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhJNM6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 08:58:14 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B99DC061753
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 05:56:09 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id p16so26706784lfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 05:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WVQGMuJie8wi8y+oVjessFiNPe/rcZJlGZsyVSDq4UQ=;
        b=vNV/ttPZQd7Ca+jEUsPVwGgpoatLmRlLf25FSIL8q7z7GeqRVrsehFTMPPoVWDwATo
         LpKNFNqfEeE9Stjvg0DIPfhwvYILpOaZo2xJgRpC8SXHdTTo703QkEm88pAyxatsgJlt
         whqFJmXA1ByTmyLYeBgX0x3KstrthnmAh5sfMJZGb1Y955dRf18fWj2gBKvufwieYVnL
         smnVFyoVgxrJe/JAJ8GWc2HlvTj9FoDHzA7+wdWYkMmZmH63cNAYPdX6p6ARFOA8iEEv
         p03D/Do0UywxLeVC4cZPreGrPbIKPYUAdpEDa0IvmUzQcH2q9CnodC81pYoA7cx5uHf4
         mneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WVQGMuJie8wi8y+oVjessFiNPe/rcZJlGZsyVSDq4UQ=;
        b=nqeqD3H/oZ2FGD66q+haiNuVKEp9EW0GRB1jdhD/wzzmTF6dsR8fSZZ3Pbo+IsQ2+q
         hv3K3ivpD1ckH9T2mGgygzlUOX7yQKEUOdGvHKSHZjXWX+XfJ7zNbHi7nPVxAszh7zBc
         PrdySfsZf2AF3qr0PekHrE/jZErYKrWEZ9aovr8PxkC7dRPa3mKNMg26eLQdsPKY1zJx
         rruyInyptwMCCufzzekGfquem/1j5BTGJu0RFVuBdGFc5PL3d2yKod9qxYq4az1YDacO
         j6uIzRGz1flTBD1rB9BhIShACOiBRZsTMpIx1IO7w9ZyG1lJA4zP2JcG8A9Mz0pQHYW5
         kTQw==
X-Gm-Message-State: AOAM530yKPSoDYC1mSNAj3+vzODVYtnaVTbHyVTFFTVCLGSJZ3jTQg1l
        cptorZP7wItU+FysSg+QEJ1msA9030eJIQ/YwhCndg==
X-Google-Smtp-Source: ABdhPJyEuN+huAz26SvUY6gTTHR9/L0Tk9vQSW4HRn7odA+ArCIS0xsfBqQedQy+Qm+fBMn9f8XBh/2lvLlmlsisDd0=
X-Received: by 2002:ac2:4157:: with SMTP id c23mr4820927lfi.184.1634216167416;
 Thu, 14 Oct 2021 05:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211011165707.138157-1-marcan@marcan.st> <20211011165707.138157-5-marcan@marcan.st>
 <20211012032144.2ltlpat7orrsyr6k@vireshk-i7> <b7cd51ec-38e5-11d8-5193-1170c9d60ac9@marcan.st>
 <20211012055143.xmkbvhbnolspgjin@vireshk-i7> <caf16a6c-f127-7f27-ed17-0522d9f1fb9e@marcan.st>
 <CAPDyKFoVjVYkc4+v-=eD+JbC10GazGt8A1LtD1so3PKMmVcyMg@mail.gmail.com> <bd07f4b3-6ebf-e074-c1cd-0ef501e8324f@marcan.st>
In-Reply-To: <bd07f4b3-6ebf-e074-c1cd-0ef501e8324f@marcan.st>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Oct 2021 14:55:30 +0200
Message-ID: <CAPDyKFrFX93XV8a7e7oo1N5weWp2auq=_94fTnzr2EkO3c37Ug@mail.gmail.com>
Subject: Re: [RFC PATCH 4/9] opp: core: Don't warn if required OPP device does
 not exist
To:     Hector Martin <marcan@marcan.st>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2021 at 13:43, Hector Martin <marcan@marcan.st> wrote:
>
> On 14/10/2021 18.55, Ulf Hansson wrote:
> > Yes, this sounds like you should move away from modeling the memory
> > part as a parent genpd for the CPUs' genpd.
> >
> > As Viresh pointed out, a devfreq driver seems like a better way to do
> > this. As a matter of fact, there are already devfreq drivers that do
> > this, unless I am mistaken.
> >
> > It looks like devfreq providers are listening to opp/cpufreq
> > notifiers, as to get an indication of when it could make sense to
> > change a performance state.
> >
> > In some cases the devfreq provider is also modeled as an interconnect
> > provider, allowing consumers to specify memory bandwidth constraints,
> > which may trigger a new performance state to be set for the memory
> > controller.
> >
> > In the tegra case, the memory controller is modelled as an
> > interconnect provider and the devfreq node is modelled as an
> > interconnect-consumer of the memory controller. Perhaps this can work
> > for apple SoCs too?
>
> I was poking around and noticed the OPP core can already integrate with
> interconnect requirements, so perhaps the memory controller can be an
> interconnect provider, and the CPU nodes can directly reference it as a
> consumer? This seems like a more accurate model of what the hardware
> does, and I think I saw some devices doing this already.

Yeah, that could work too. And, yes, I agree, it may be a better
description of the HW.

>
> (only problem is I have no idea of the actual bandwidth numbers involved
> here... I'll have to run some benchmarks to make sure this isn't just
> completely dummy data)
>
> >
> > That said, perhaps as an option to move forward, we can try to get the
> > cpufreq pieces solved first. Then as a step on top, add the
> > performance scaling for the memory controller?
>
> Sure; that's a pretty much independent part of this patchset, though I'm
> thinking I might as well try some things out for v2 anyway; if it looks
> like it'll take longer we can split it out and do just the cpufreq side.

In any case, I do my best to help with review.

Kind regards
Uffe
