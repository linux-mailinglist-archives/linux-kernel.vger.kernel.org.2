Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2409A42EFBB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 13:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbhJOL31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 07:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbhJOL3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 07:29:18 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6836C061764
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 04:27:12 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id e63so12579960oif.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 04:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NKgeFjMzQGbOlv7b4giRKfd3xluRkC6Y3aCMzdKTmcI=;
        b=Wm4Wd6dvvDFnTkE00hxoA1bUki0lOHa+WoFWUIXZWiyl6BYiN/VJMfw+VnMnOCFaCL
         jQ/04aPgGreSwDm51jxnPJc9pkqywXE26egdgnLAAok719vghfDASfmYTOjn+J9+fwG+
         q/10lDtvDgAT1UYJHz5rI7tM4bgXHiMlTFU0bfwd97rrUQBuH+ZcmSEP+7HO6CUo/zZr
         CYvsbAtjc89xss/CKzqeHdvLDimYn1hwLBeYUoQqfujZ+roY4R1sCnIjQGg7W3W/Tmsf
         Xo/iQrJTbgRFodmMVP5Xapec+3WlJ78UAXbtc9fa6D6bWDahM/6PJbdWmF+2ol5JsZXE
         T1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NKgeFjMzQGbOlv7b4giRKfd3xluRkC6Y3aCMzdKTmcI=;
        b=wjZOdjXsA/gCPhFQ9Tjf0nKC/P9MT003Jor/C8Cr+Cd/vwOJ48tKw4YzS2gskXELu3
         70EnCHfM2bowlpMR/XFUNPpTeol4yjDM/yzOb1JLroPswFng+ulBDCpvS/CjGc5M0OMm
         UPbVsuIrKS13BY+QhXOa6E3tbVkpo+FoMopd9UCMHh3FHkaNm9RtDt7Qvvw/MB8gVKrA
         i7rQYeciDsAUlPx05hLTwvjXuJdaQ/cq26cYLzcFLV/ayhLSyH835eE1axnLHw4NpeL5
         RJCKECV6AycQGGjkEUhnyjzO8YwNvFPCkDCvodBUlgKgX8o0MB4K90jiIuJW7NDdWWjT
         3DlA==
X-Gm-Message-State: AOAM530ayXOj67PYWz/ITCUFd75AVB1vRsPsB1ljZIB7IXNatcOClQSO
        Pb6+gg3ONc7w0KcItPYG0lGvojB+MOOW4n7NY7ZVyA==
X-Google-Smtp-Source: ABdhPJyDcpqGbwskrQSivF3Hrk9czLe3jAaUJI090sO0PPQ/+jfBKyc4oV3D64eX1CbrHycowOE0cMxWzV6ZAtM7o8E=
X-Received: by 2002:a05:6808:2218:: with SMTP id bd24mr513771oib.94.1634297231969;
 Fri, 15 Oct 2021 04:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211011165707.138157-1-marcan@marcan.st> <20211011165707.138157-5-marcan@marcan.st>
 <20211012032144.2ltlpat7orrsyr6k@vireshk-i7> <b7cd51ec-38e5-11d8-5193-1170c9d60ac9@marcan.st>
 <20211012055143.xmkbvhbnolspgjin@vireshk-i7> <caf16a6c-f127-7f27-ed17-0522d9f1fb9e@marcan.st>
 <CAPDyKFoVjVYkc4+v-=eD+JbC10GazGt8A1LtD1so3PKMmVcyMg@mail.gmail.com>
 <bd07f4b3-6ebf-e074-c1cd-0ef501e8324f@marcan.st> <CAPDyKFrFX93XV8a7e7oo1N5weWp2auq=_94fTnzr2EkO3c37Ug@mail.gmail.com>
 <ca820b86-fc12-63b9-ec6b-5823ddd73aba@marcan.st>
In-Reply-To: <ca820b86-fc12-63b9-ec6b-5823ddd73aba@marcan.st>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 Oct 2021 13:26:35 +0200
Message-ID: <CAPDyKFpCw1M8bK5T6a+=x-kHaCco88wiRnvUm5Dy90XU360=4A@mail.gmail.com>
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

On Thu, 14 Oct 2021 at 19:02, Hector Martin <marcan@marcan.st> wrote:
>
> On 14/10/2021 21.55, Ulf Hansson wrote:
> > On Thu, 14 Oct 2021 at 13:43, Hector Martin <marcan@marcan.st> wrote:
> >> I was poking around and noticed the OPP core can already integrate with
> >> interconnect requirements, so perhaps the memory controller can be an
> >> interconnect provider, and the CPU nodes can directly reference it as a
> >> consumer? This seems like a more accurate model of what the hardware
> >> does, and I think I saw some devices doing this already.
> >
> > Yeah, that could work too. And, yes, I agree, it may be a better
> > description of the HW.
> >
> >>
> >> (only problem is I have no idea of the actual bandwidth numbers involved
> >> here... I'll have to run some benchmarks to make sure this isn't just
> >> completely dummy data)
> >>
>
> So... I tried getting bandwidth numbers and failed. It seems these
> registers don't actually affect peak performance in any measurable way.
> I'm also getting almost the same GeekBench scores on macOS with and
> without this mechanism enabled, although there is one subtest that seems
> to show a measurable difference.
>
> My current guess is this is something more subtle (latencies? idle
> timers and such?) than a performance state. If that is the case, do you
> have any ideas as to the best way to model it in Linux? Should we even
> bother if it mostly has a minimal performance gain for typical workloads?

For latency constraints, we have dev_pm_qos. This will make the genpd
governor, to prevent deeper idle states for the device and its
corresponding PM domain (genpd). But that doesn't sound like a good
fit here.

If you are right, it rather sounds like there is some kind of
quiescence mode of the memory controller that can be prevented. But I
have no clue, of course. :-)

>
> I'll try to do some latency tests, see if I can make sense of what it's
> actually doing.
>

Kind regards
Uffe
