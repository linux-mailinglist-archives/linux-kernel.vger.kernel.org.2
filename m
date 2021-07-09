Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A237E3C235E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 14:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhGIMYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 08:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhGIMYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 08:24:12 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BCFC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 05:21:28 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id m12so5441539vst.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 05:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=neYiBpOpEXQJZJq/0gP5/PZ8mVUIp7GUI1UouUyG71k=;
        b=Ljuaw6YeyIU0lcR6Fgc7AYgDcJwhYbE0e9+x3OqqQZwLk7vJlRX67ZNUgJ6Kb+VKrL
         QMLNApsFdzNXCdixB/feZ0Pc4vrRbR3OnybXnVEebHeipPz8595VimyIuuxocROllkBa
         csFb3hND6yop1jMFQ+I/5m5cVKoWOraNVK7iepeWkh/HSYjKypqjKjQlcSiUFi2dGfIV
         jbehtZXZp4tkrqT6WZKwR0h+Zaq2pIgpeR+iZfagtlduyLLrtggeGXSPhfzRiP1w5muX
         L5VdG7FFwSE5sVKsuoM9as6l3rfw9KFfrU8uPzF70RfUphGsebTkJ35XxoHWDgQlgbD9
         PClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=neYiBpOpEXQJZJq/0gP5/PZ8mVUIp7GUI1UouUyG71k=;
        b=frxjtOTHcQPxbpuaQaTseWGQcTBmxXJlN9kKcWjEBNt7zaC/qR2aq1ON4wKXRSaWJF
         N5P4Er/mKEo6IqRZfqgAcjxsiU9in2hft3cb2DfyusJ6dyEaiKy8Q0ms2a4G9G0miRxB
         HZdtga1ZEXoDXwcAJeZ1HjD+BN0skG82zWu7/D6ZoilbDwUCa/vjvVzaRUF1/uPgtgh8
         Gc1zzGJmuy2zS1Y9Uk8dpFg1BZ3u5RgHEQQlraUjRgvX5gW1CYX+Zi7J1DlYBu88aQJG
         Nek9Lto6ThcpoinYNdUTXHPnf3AZ5l0yEtTys8d0DE0smCMU+Qlnm7dkPUIebGgyau0y
         0Yng==
X-Gm-Message-State: AOAM531WgiWL6jyvgXGNE8ASEhLCjNr03555FH/jOWNFLjA/4HZhDiZn
        1ReCBhi1AcbdWhipAcOZmynxnMVrg8esVrgpsm0OKA==
X-Google-Smtp-Source: ABdhPJwMWQBeVoHuIP9YiW7sy+wbZHoy6bVa6JZEls8s2M6Hhzhu3+nWjXH9ch4phUFX5K4ee+xF12mX/SEHLk609NQ=
X-Received: by 2002:a67:8c46:: with SMTP id o67mr34730304vsd.34.1625833288135;
 Fri, 09 Jul 2021 05:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210709043136.533205-1-dmitry.baryshkov@linaro.org>
 <20210709043136.533205-4-dmitry.baryshkov@linaro.org> <CAPDyKFoNPkFqGMvR=JGXNVXp-UfWLUqReZ0DGP8+0PBh+7dCRg@mail.gmail.com>
 <CAA8EJpqykAyBKBADuGUQeZjG5-NPC6HgieNQLtWeA+McG_BMqw@mail.gmail.com>
In-Reply-To: <CAA8EJpqykAyBKBADuGUQeZjG5-NPC6HgieNQLtWeA+McG_BMqw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 9 Jul 2021 14:20:51 +0200
Message-ID: <CAPDyKFoeYOceAc-sfetJnEmL--rvO=rVQkCVxdYaZdnxOPwCJA@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 3/7] PM: domains: Add support for runtime PM
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jul 2021 at 13:39, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> Hi,
>
> On Fri, 9 Jul 2021 at 11:25, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Fri, 9 Jul 2021 at 06:32, Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > Registers for some genpds can be located in the SoC area, powered up by
> > > another power domain. To enabled access to those registers, respective
> > > domain should be turned on.
> > >
> > > This patch adds basic infrastructure to the genpd code to allow
> > > implementing drivers for such genpd. PM domain can provide the parent
> > > device through the genpd->dev.parent pointer. If its provided at the
> > > pm_genpd_init() call time and if it is pm-enabled, genpd power_on and
> > > power_off operations will call pm_runtime_get_sync() before powering up
> > > the domain and pm_runtime_put_sync() after powering it down.
> > >
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >
> > Hi Dmitry,
> >
> > Using runtime PM for the genpd provider device, is not the correct
> > approach. If the provider domain needs another domain to be powered on
> > to work correctly, that per definition means that it has a parent
> > domain.
> >
> > I suggest you try to build the correct PM domain topology, via using
> > pm_genpd_add_subdomain() or of_genpd_add_subdomain(), then genpd will
> > manages the power on/off for parent/child domain internally.
>
> Indeed, this patch seems redundant now, with the
> pm_genpd_add_subdomain call in place.
> Would you like me to resend a v3 just dropping this patch?

Yes, $subject patch isn't the way to go.

Let's continue discussing things on patch3/7 to conclude on the way forward.

[...]

Kind regards
Uffe
