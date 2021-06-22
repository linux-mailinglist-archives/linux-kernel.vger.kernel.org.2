Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF423B0AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 18:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhFVQ4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 12:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbhFVQ4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 12:56:31 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B91C061756
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 09:54:14 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id im10so9593730qvb.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 09:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ln0rqCYelsyqtkFalmwSESWUlyrC6dhevN9AgMvP0es=;
        b=ZLQfwSSaECfOSlROL5O1FHfITEWnKqUE8cvB9T5PPjirTAOMnWmZdjsUCwl1g4kPPr
         XUPv7VEcFM2DmgpmjLKv4cmbNnZ/u/O0jZo4fu3vmcnnzDdkB8qyMAD8QUQsW3EriGRk
         ZuK+8EDXiwWgHqRMyWcUdrrzbS0u3BRBjDKaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ln0rqCYelsyqtkFalmwSESWUlyrC6dhevN9AgMvP0es=;
        b=Q7zNIR36QM/tWXf0zJs6Bqomd3JDaB+l1bk0h/AKv9lRTd2GM19OxoHDivCl1/J2Lj
         xfrEoIClTK0exsxe/1+sv91si9nODd39jwNlSQuz96JH6fBoWmTOrBn61ICJ6u/Ybio2
         LyYIEJMHqWostQT3FKIACWfGyt8I6F/WjBd2Xcj/mcIK8wqaWWwM2BmOZD+Ai+FpO5YZ
         ovbN3XC/HE8f61JJ7cMLgny4IvwtVAGWYwUUNheAwy85AA2UPiIBd+v8yLH0ZSuNQslv
         LmUyMcySil2rO9NwR22UeH9X/qht9k8uZJuKQW9vizNrjh74uZRbwrVeAzxtvB5WY5fA
         sr7g==
X-Gm-Message-State: AOAM531EkFtllw59/x1FJCaOvt4eXejwR4d10nPursjIMaw1XCsHeWyV
        ESP1kmysfyTznOgqBTyO5pFkM+TVeGOUEA==
X-Google-Smtp-Source: ABdhPJySllzpXUSPvpglzQlnR/jl+JgmBq9chT4BkkiJf07Q0PNETxizLXaJNy3sWyGo6dQ+NorZbg==
X-Received: by 2002:a05:6214:21a8:: with SMTP id t8mr26163900qvc.3.1624380853525;
        Tue, 22 Jun 2021 09:54:13 -0700 (PDT)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com. [209.85.222.177])
        by smtp.gmail.com with ESMTPSA id s8sm1864589qtk.96.2021.06.22.09.54.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 09:54:12 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id j184so41281737qkd.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 09:54:12 -0700 (PDT)
X-Received: by 2002:a25:2405:: with SMTP id k5mr5864261ybk.405.1624380851918;
 Tue, 22 Jun 2021 09:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.4.Id84a954e705fcad3fdb35beb2bc372e4bf2108c7@changeid> <a86c2f9c-f66a-3a12-cf80-6e3fc6dafda4@linux.intel.com>
In-Reply-To: <a86c2f9c-f66a-3a12-cf80-6e3fc6dafda4@linux.intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Jun 2021 09:53:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XpYkUqGNcumJ0NvoXqbSkBaV5ZadUnpsKTMPx7tSjGig@mail.gmail.com>
Message-ID: <CAD=FV=XpYkUqGNcumJ0NvoXqbSkBaV5ZadUnpsKTMPx7tSjGig@mail.gmail.com>
Subject: Re: [PATCH 4/6] iommu: Combine device strictness requests with the
 global default
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Clark <robdclark@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        quic_c_gdjako@quicinc.com,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        linux-pci@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Rajat Jain <rajatja@google.com>,
        Sonny Rao <sonnyrao@chromium.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 21, 2021 at 7:05 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> On 6/22/21 7:52 AM, Douglas Anderson wrote:
> > @@ -1519,7 +1542,8 @@ static int iommu_get_def_domain_type(struct device *dev)
> >
> >   static int iommu_group_alloc_default_domain(struct bus_type *bus,
> >                                           struct iommu_group *group,
> > -                                         unsigned int type)
> > +                                         unsigned int type,
> > +                                         struct device *dev)
> >   {
> >       struct iommu_domain *dom;
> >
> > @@ -1534,6 +1558,12 @@ static int iommu_group_alloc_default_domain(struct bus_type *bus,
> >       if (!dom)
> >               return -ENOMEM;
> >
> > +     /* Save the strictness requests from the device */
> > +     if (dev && type == IOMMU_DOMAIN_DMA) {
> > +             dom->request_non_strict = dev->request_non_strict_iommu;
> > +             dom->force_strict = dev->force_strict_iommu;
> > +     }
> > +
>
> An iommu default domain might be used by multiple devices which might
> have different "strict" attributions. Then who could override who?

My gut instinct would be that if multiple devices were part of a given
domain that it would be combined like this:

1. Any device that requests strict makes the domain strict force strict.

2. To request non-strict all of the devices in the domain would have
to request non-strict.

To do that I'd have to change my patchset obviously, but I don't think
it should be hard. We can just keep a count of devices and a count of
the strict vs. non-strict requests? If there are no other blockers
I'll try to do that in my v2.

-Doug
