Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261FC436BA0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 21:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhJUT7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 15:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhJUT7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 15:59:07 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A207C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:56:50 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id q16so1317220ljg.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XyhoHE7sxv5I2EpYeVeJH0GIKfhcQY389jVe4IVPrso=;
        b=fajWtGHos8khUlCJgvpdSRJD5xpYLZ79Lr2JBHTNmtUKS3cX8ZlnEwgx+1S9+b91Jx
         xIAREn1mxSFn3lWZ8eC1aaNnhKsBHvyNNoQ+ZiUYwMiFj7eI7DtbGZLrFQ02vjk/za3F
         n5tzxDxUgWk3TS0NL82gfmIRApn3g95CzMW5kDKCbySKWOQVGOt9dhMfgoFxouk8s7BQ
         qkozvuudgympgQiVJIv24nCREM9G4TUwGTPzhIHPk+OC0PFpvTzF1opal3pOXlKjd6dN
         odykl9GddCEXRQKtJkeeWO6tu8RB2ORt7/STAWx3OSx7MEjRK8DsroWwXJT31GCjIQTN
         zE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XyhoHE7sxv5I2EpYeVeJH0GIKfhcQY389jVe4IVPrso=;
        b=2ti+LcXSGnRTWEws7FWzDE6Y5QL9U8oF9T3gm9u404H1HE9VHppmHpHzz8muXtAo8i
         9UUblobtHRGNN5FZRwMh6DPTij8Isfx+onWDI1s0gASoMUyZFQnNWRt69fTEW2RsMcV0
         vZssAfODsjNW9IQy8X2wcDFilVIpND6YTIJz7yW+QZ4+rc18Qkm68GrPZ0w1NkDiCFtk
         0omFjha5fF2Qz3rcD4swPZ9gCEnh7JCjnpsIFBFVIUrozEVgPPCki7C0g4IrXhUPsRUw
         gCYgHUgGvKusHNnmn3cONSw916X44oS4qWhU2l8t1CmcPd87ZrQZfRV3TAYX0DhrekCK
         2qJw==
X-Gm-Message-State: AOAM532C/iPDpS4f4nJicRPRhZ+kub7KRy6mKJIlrSjYLdu1//jbTFTV
        XbMeR7XCCS5XMe/oqukF+w7ZXWFawz7/FdayVgGeeQ==
X-Google-Smtp-Source: ABdhPJzxCO5iobX3X9/3J7SUpG7HeCrofcWJedaNNyaZgtw9IetFPn5k5xibQ+0WN4id9doUujHVDLoo8VDf2eyts8Q=
X-Received: by 2002:a2e:874d:: with SMTP id q13mr8133479ljj.16.1634846208850;
 Thu, 21 Oct 2021 12:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210929144451.113334-1-ulf.hansson@linaro.org>
 <20210929144451.113334-3-ulf.hansson@linaro.org> <CAJZ5v0hgdQeJ+6mLMLQcvnM_+EiyDBERj54aT2cL=HiTO9nMNQ@mail.gmail.com>
 <CAPDyKFpep3aPmGGo=aA5dHZZjb-O51et47C9_hgVbZbXMJZX_g@mail.gmail.com>
 <CAJZ5v0j=Fi5vOh45de-u7FwsCm4zsAsHepp16xQ3U5_WjrtWJw@mail.gmail.com>
 <CAPDyKFqeAFhgCFSaFAWnp5xorxSVwAL=z2g6vHJ0PWjtt9GDNg@mail.gmail.com>
 <CAJZ5v0iA4O=tx7qiLKCOze87dcUtwtDJqi2B+2O=oOyCSzgmtQ@mail.gmail.com>
 <CAPDyKFr_-ON1JWXe3W7DAXUzKdrceqXPwLAdHnKeXajy=pFnug@mail.gmail.com>
 <CAJZ5v0itweerfbq8NE9rEonZ2Nfu_nfKgERv2tweeLO4fgAgLg@mail.gmail.com>
 <CAPDyKFrOSd2xEXuvDki9Em+xFLHfeTfZz3NtnWwNmWB1H6i=Kg@mail.gmail.com> <CAJZ5v0j3a_m5T9nbxk4VSuABOq12JEC0fi=0SQ8+=Vwv-qDeOA@mail.gmail.com>
In-Reply-To: <CAJZ5v0j3a_m5T9nbxk4VSuABOq12JEC0fi=0SQ8+=Vwv-qDeOA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Oct 2021 21:56:12 +0200
Message-ID: <CAPDyKFpjy5sZo6ayqPx07Jzs4J2yePy=cZk=k6VjhWB7zGeedg@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM: sleep: Fix runtime PM based cpuidle support
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Len Brown <len.brown@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 at 21:02, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Oct 21, 2021 at 8:12 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Thu, 21 Oct 2021 at 18:33, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Thu, Oct 21, 2021 at 6:17 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> [cut]
>
> > > So in theory you could check the pm_runtime_put_sync_suspend() return
> > > value and fall back to something like WFI if that's an error code.
> >
> > I have already tried that, but it simply got too complicated. The main
> > issue was that runtime PM could become disabled for the device in the
> > middle of executing the ->enter() callback.
>
> So IIUC the problem is that you cannot resume after suspending in that case.
>
> IOW, you need to guarantee that if the suspend is successful, the
> resume also will take place, but if the suspend fails, you basically
> don't care.

Exactly.

>
> > For example, if pm_runtime_get_sync() fails, I still need to make sure
> > the reference counting in genpd becomes correct - and I can't do that
> > using dev_pm_genpd_resume(). That's because it's not designed to be
> > called in this "unknown" suspend phase, but should be called after the
> > noirq phase and be properly balanced with dev_pm_genpd_suspend().
> >
> > In other words, the error path didn't work out for me.
>
> It should be sufficient to call wake_up_all_idle_cpus() in the suspend
> path before dpm_suspend_late(), because system suspend acquires a
> PM-runtime reference on every device.  IOW, it won't let any devices
> runtime-suspend, so if your power domain devices are resumed in that
> path, they will never suspend again in it and the
> pm_runtime_put_sync_suspend() in __psci_enter_domain_idle_state()
> becomes a reference counter management call which works regardless of
> whether or not PM runtime is disabled.

That sounds like a great idea, this should work too! Then the question
is, how to make that call to wake_up_all_idle_cpus() to become
optional - or only invoked for the cpuidle drivers that need it.

In any case, I will try this out, thanks for the suggestion!

Kind regards
Uffe
