Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506153D18BE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 23:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhGUU2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhGUU1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:27:50 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA31AC0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 14:08:26 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id t186so2356545ybf.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 14:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UBf2xEk8/8fmvgHkUbAP/1+jhiB7YJMg6Fos6jC4Avk=;
        b=iOswR8bDPKPmaXbxSo7LpAdDVia28Nw7iA1NHSB/hQm4djv0jw5Jry1olvb2YDLWDG
         4syxrMbOJa3ePkJiCDFub8LMNdCmo8gKJv261PJAx7n/XrKPZryC6RHomlOR2lORPHBq
         19QfM45Ce3lWlwQ89vaHLLOQ19Y4YMroc3T75jo5J9zIBLM397xBNisHOL9/Tq6pSRCo
         iFuE7M1Fbd3/8UqgzRgvapwRQR/BecMCco7lyG5UFSZxT3QMf9TErTmhP+7Lakl6v3Wj
         5nUkWuAUuA7SVWshHwa3UhWtZbwWsdrICHmfxHqnSVVsdPU2XQ8RmNBe6MvbTe9zqiOY
         HkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UBf2xEk8/8fmvgHkUbAP/1+jhiB7YJMg6Fos6jC4Avk=;
        b=VNOHEqLYTUpkmIelN+QvDvEWbDUnyedXALBn+0819nOt18w+lzCvxxGENzG2rJALFF
         wmWyGfe63PpnC0c7Oqhpo6v+4sYQT/h7vNkZu/t00XSAXqXz9koRDJWX1+qJB7DY/mMD
         ieTObXmVbhQ7UAG2lS5NDRxRo0F47MbJCY8LYKQRHNGEC+IsQy5HP0a8XXtEWwTGbHX+
         D/WquAPMgIi6xayDKmqU6JQ69CqmhmSpNpZ3ge1ljd1bXRsFfhi7MP1Z0R0HCa7SM9r+
         RkjjLa1f0lqi0Q3P9uqWl+prpAv2CMa8RCs8q3Ln+Wq5d8Daz/dJn77RwCM0nClbfksN
         tRKA==
X-Gm-Message-State: AOAM5339Tk0yXUhX/iduOBHbjorO0xsX1tETR5DD6Zt+NVjzMxuRDMo5
        GKRdvF2o5Gxuf834VXp3vevR0Po0IxevIBk740Jurw==
X-Google-Smtp-Source: ABdhPJxvvcIxjS1sPhcRo3uY116bCVXOf5nADsCBhFulbFzDi8z6ZYiOJj9B6s7MAoSBOkXUSsdQXTh0BQ4kxrSemrQ=
X-Received: by 2002:a25:8b91:: with SMTP id j17mr46134726ybl.228.1626901705723;
 Wed, 21 Jul 2021 14:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210707045320.529186-1-john.stultz@linaro.org>
 <YPgK50dmV7Z69WsL@kroah.com> <CALAqxLUVgUT+1DyDGsFbF0138S0OYzpKADk__PsYbR4B4mbMhw@mail.gmail.com>
 <CAGETcx91URbHCYMoGt_cCgvMXNkVyJb4Ek-ng8jwR+eQhvZN1A@mail.gmail.com> <YPiCSOys6zEH6Kfg@yoga>
In-Reply-To: <YPiCSOys6zEH6Kfg@yoga>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 21 Jul 2021 14:07:49 -0700
Message-ID: <CAGETcx8Yw2QDYBYNpqVt_kPHnokFR+qinr5GAJ1byVWMuc3PLQ@mail.gmail.com>
Subject: Re: [PATCH] firmware: QCOM_SCM: Allow qcom_scm driver to be loadable
 as a permenent module
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Todd Kjos <tkjos@google.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 1:23 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Wed 21 Jul 13:00 CDT 2021, Saravana Kannan wrote:
>
> > On Wed, Jul 21, 2021 at 10:24 AM John Stultz <john.stultz@linaro.org> wrote:
> > >
> > > On Wed, Jul 21, 2021 at 4:54 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Wed, Jul 07, 2021 at 04:53:20AM +0000, John Stultz wrote:
> > > > > Allow the qcom_scm driver to be loadable as a permenent module.
> > > >
> > > > This feels like a regression, it should be allowed to be a module.
> > >
> > > I'm sorry, I'm not sure I'm following you, Greg.  This patch is trying
> > > to enable the driver to be able to be loaded as a module.
> >
> > I think the mix up might be that Greg mentally read "permanent module"
> > as "builtin"?
> >
> > "permanent module" is just something that can't be unloaded once it's
> > loaded. It's not "builtin".
> >
>
> Afaict there's nothing in this patch that makes it more or less
> permanent.

The lack of a module_exit() makes it a permanent module. If you do
lsmod, it'll mark this as "[permanent]".

-Saravana

> The module will be quite permanent (in practice) because
> several other core modules reference symbols in the qcom_scm module.
>
> But thanks to a previous patch, the qcom_scm device comes with
> suppress_bind_attrs, to prevent that the device goes away from a simple
> unbind operation - which the API and client drivers aren't designed to
> handle.
>
> So, it would have been better in this case to omit the word "permanent"
> from the commit message, but the change is good and I don't want to
> rebase my tree to drop that word.
>
> Thanks,
> Bjorn
>
> > -Saravana
> >
> > >
> > > > > This still uses the "depends on QCOM_SCM || !QCOM_SCM" bit to
> > > > > ensure that drivers that call into the qcom_scm driver are
> > > > > also built as modules. While not ideal in some cases its the
> > > > > only safe way I can find to avoid build errors without having
> > > > > those drivers select QCOM_SCM and have to force it on (as
> > > > > QCOM_SCM=n can be valid for those drivers).
> > > > >
> > > > > Reviving this now that Saravana's fw_devlink defaults to on,
> > > > > which should avoid loading troubles seen before.
> > > >
> > > > fw_devlink was supposed to resolve these issues and _allow_ code to be
> > > > built as modules and not forced to be built into the kernel.
> > >
> > > Right. I'm re-submitting this patch to enable a driver to work as a
> > > module, because earlier attempts to submit it ran into boot trouble
> > > because fw_devlink wasn't yet enabled.
> > >
> > > I worry something in my description made it seem otherwise, so let me
> > > know how you read it and I'll try to avoid such confusion in the
> > > future.
> > >
> > > thanks
> > > -john
