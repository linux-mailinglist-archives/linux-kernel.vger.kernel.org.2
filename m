Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8E63D15C6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 20:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhGURUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 13:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhGURUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 13:20:17 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03146C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 11:00:53 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id r132so4448505yba.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 11:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p55HWTaC5dpMadxxZA1E7+qzD3OpeEPoXK9rz/EuCCs=;
        b=VKgoCKHjjpFlb8dMXuXUAgOoQYJ3Mbnrm6/8qx4IsUefGakwA3IGEEr0CxwNVsnR0r
         RyfUGx1agkrTHn27tIBpoNtSqHuQIrO4FyGElTusIg9o9RmLBO7FkzuQthByFgbU6N8Y
         JezczchD0E6nSwFpbW8Wfl7RpqflPfgmmeESl0jFVbpcOVfbsj3iiGTbr35EbCaIhQLd
         +qZv+Y0LjBjmprpNCgVby1ICXtdpYSBOqbSSJRJbkaVXma2Aj2qTOobmNUVgfUDa19vr
         7ybpE/C0bS8Dt5I+VXMpwsa+xtbTlG2BZf44XVR2lX0WCvHAENYExpgoiy/ccdAmuV3Q
         wiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p55HWTaC5dpMadxxZA1E7+qzD3OpeEPoXK9rz/EuCCs=;
        b=E17viOVYGkCz7vmkzRkUP/stAy4Xmq601JgxnBXMA/+yq1Cl2D7HNDeiRwzZN14Yeo
         /J43/LJvunII+2H35sOIZ7mtRQQTlTxSqEs4lOSCzh5HHkRzzm5zWTeUReQRwcJW9uCz
         tsI9jUST/aNNOJ+mjJnLmd4vNaMd6qnCw2738Wl3Es6By3TdIkClR+RarlRRCJhs0tV5
         8tQfvUUOx3bxLdNK0L+U7FGyACnKZqccy/LryQXuFLHQfcBdEtZgp9ayRVjHR6C00FrF
         LQz1ei12j5qWHVlsbyFE/lBhCR4iN2jD67KRthNgx7/R6ixNDJ9zT0tUNy3MOTb+M0Qy
         8oqg==
X-Gm-Message-State: AOAM531+V+BGYOw4+iCYHvj7rfi3nIDFV4uxs2rE5xdefnkXMIh9x1P5
        iZdgF8zMr1v8PK2fQ6ieDH3vtTKqisMx4HDCvOdVgw==
X-Google-Smtp-Source: ABdhPJwbIrbhhVYNYobPTcneIblXUvvyWcuD63Tzux+fXk8oy4TabvNhfXszej/xrPC8W06ZGSSznRT/A7sB9Z46Za8=
X-Received: by 2002:a25:8b91:: with SMTP id j17mr45175948ybl.228.1626890452055;
 Wed, 21 Jul 2021 11:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210707045320.529186-1-john.stultz@linaro.org>
 <YPgK50dmV7Z69WsL@kroah.com> <CALAqxLUVgUT+1DyDGsFbF0138S0OYzpKADk__PsYbR4B4mbMhw@mail.gmail.com>
In-Reply-To: <CALAqxLUVgUT+1DyDGsFbF0138S0OYzpKADk__PsYbR4B4mbMhw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 21 Jul 2021 11:00:15 -0700
Message-ID: <CAGETcx91URbHCYMoGt_cCgvMXNkVyJb4Ek-ng8jwR+eQhvZN1A@mail.gmail.com>
Subject: Re: [PATCH] firmware: QCOM_SCM: Allow qcom_scm driver to be loadable
 as a permenent module
To:     John Stultz <john.stultz@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
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

On Wed, Jul 21, 2021 at 10:24 AM John Stultz <john.stultz@linaro.org> wrote:
>
> On Wed, Jul 21, 2021 at 4:54 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jul 07, 2021 at 04:53:20AM +0000, John Stultz wrote:
> > > Allow the qcom_scm driver to be loadable as a permenent module.
> >
> > This feels like a regression, it should be allowed to be a module.
>
> I'm sorry, I'm not sure I'm following you, Greg.  This patch is trying
> to enable the driver to be able to be loaded as a module.

I think the mix up might be that Greg mentally read "permanent module"
as "builtin"?

"permanent module" is just something that can't be unloaded once it's
loaded. It's not "builtin".

-Saravana

>
> > > This still uses the "depends on QCOM_SCM || !QCOM_SCM" bit to
> > > ensure that drivers that call into the qcom_scm driver are
> > > also built as modules. While not ideal in some cases its the
> > > only safe way I can find to avoid build errors without having
> > > those drivers select QCOM_SCM and have to force it on (as
> > > QCOM_SCM=n can be valid for those drivers).
> > >
> > > Reviving this now that Saravana's fw_devlink defaults to on,
> > > which should avoid loading troubles seen before.
> >
> > fw_devlink was supposed to resolve these issues and _allow_ code to be
> > built as modules and not forced to be built into the kernel.
>
> Right. I'm re-submitting this patch to enable a driver to work as a
> module, because earlier attempts to submit it ran into boot trouble
> because fw_devlink wasn't yet enabled.
>
> I worry something in my description made it seem otherwise, so let me
> know how you read it and I'll try to avoid such confusion in the
> future.
>
> thanks
> -john
