Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E833B0B01
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 19:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhFVRE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 13:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhFVREY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 13:04:24 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC5CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:02:06 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id bl4so5409942qkb.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ZLfOF3k/f6yL2AQLJ+h2J00Oz5HjAD+vwU2S+DCH90=;
        b=gd1QJ+p0JA8dyVAsY4WKjdqQGTpnW4p+P5TOHPu1jd4FeLJ/H6Qvzbn6gyTv7wJVI6
         36wOQR0QS6Ab0J7LxCWnPEzDaKyFhbkR0dyQHikgrWT9HmTn5M8DAb0Bs2e0HWcalTrm
         dzu+DKJGfjkl52u/OhJeVIwWeXfqiKtJLOnOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ZLfOF3k/f6yL2AQLJ+h2J00Oz5HjAD+vwU2S+DCH90=;
        b=snrMUfP0MM/oBEPvcJyGHKD3bHa3zq6vQg195wO4lBbQfjCYUVRPZPjgwhZItnYDET
         HtlMk6xZiEwbfx/mcqT8lOlc48p1njIUpM5TRAd/qvm92217WgRDMFyWoR0XXFFK3KKV
         4tiSIy98NuNNESQy85pz6KEre6Q2Asira1C+679WFkZJkGlWYWhbnDkBIpkbg5xh8XGb
         NcMfw/KqpaYiwPcuSNoiMA5x+4nLeleGWppKqu1/D6aEr1BqWrB8Gl8Mfj9qprWglIdk
         MhjdLoGVSKpcvab36kYDuqOXHsgT52pAsYzohsx5MMsPigV7eM+jCSEDgZyk0paRnMnU
         5voQ==
X-Gm-Message-State: AOAM531XS378vDgLa9xAqjrbHMGA3cljM6BJMRKB8Pm09Lxv3Bz/5nuS
        pnmFESqzBT3G9PAmOZVYe0Wfh6L1bvnGQA==
X-Google-Smtp-Source: ABdhPJy3/60Qy57DGt2jZwwo/nHVGPPWOkzCVCv8jAZA/cGCb8jvDWy5Lv0Be3SH172CUHhEdClhfQ==
X-Received: by 2002:a37:a44a:: with SMTP id n71mr5445811qke.19.1624381324908;
        Tue, 22 Jun 2021 10:02:04 -0700 (PDT)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com. [209.85.222.175])
        by smtp.gmail.com with ESMTPSA id d16sm1960183qtj.69.2021.06.22.10.02.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 10:02:04 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id d196so41257520qkg.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 10:02:03 -0700 (PDT)
X-Received: by 2002:a25:6088:: with SMTP id u130mr6308972ybb.257.1624381323248;
 Tue, 22 Jun 2021 10:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.4.Id84a954e705fcad3fdb35beb2bc372e4bf2108c7@changeid>
 <a86c2f9c-f66a-3a12-cf80-6e3fc6dafda4@linux.intel.com> <CAD=FV=XpYkUqGNcumJ0NvoXqbSkBaV5ZadUnpsKTMPx7tSjGig@mail.gmail.com>
In-Reply-To: <CAD=FV=XpYkUqGNcumJ0NvoXqbSkBaV5ZadUnpsKTMPx7tSjGig@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Jun 2021 10:01:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xi8Qai5sKwuT4-4B=K5i7f4BWQfp9+TxR1x3VSt7dkGA@mail.gmail.com>
Message-ID: <CAD=FV=Xi8Qai5sKwuT4-4B=K5i7f4BWQfp9+TxR1x3VSt7dkGA@mail.gmail.com>
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

On Tue, Jun 22, 2021 at 9:53 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Jun 21, 2021 at 7:05 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
> >
> > On 6/22/21 7:52 AM, Douglas Anderson wrote:
> > > @@ -1519,7 +1542,8 @@ static int iommu_get_def_domain_type(struct device *dev)
> > >
> > >   static int iommu_group_alloc_default_domain(struct bus_type *bus,
> > >                                           struct iommu_group *group,
> > > -                                         unsigned int type)
> > > +                                         unsigned int type,
> > > +                                         struct device *dev)
> > >   {
> > >       struct iommu_domain *dom;
> > >
> > > @@ -1534,6 +1558,12 @@ static int iommu_group_alloc_default_domain(struct bus_type *bus,
> > >       if (!dom)
> > >               return -ENOMEM;
> > >
> > > +     /* Save the strictness requests from the device */
> > > +     if (dev && type == IOMMU_DOMAIN_DMA) {
> > > +             dom->request_non_strict = dev->request_non_strict_iommu;
> > > +             dom->force_strict = dev->force_strict_iommu;
> > > +     }
> > > +
> >
> > An iommu default domain might be used by multiple devices which might
> > have different "strict" attributions. Then who could override who?
>
> My gut instinct would be that if multiple devices were part of a given
> domain that it would be combined like this:
>
> 1. Any device that requests strict makes the domain strict force strict.
>
> 2. To request non-strict all of the devices in the domain would have
> to request non-strict.
>
> To do that I'd have to change my patchset obviously, but I don't think
> it should be hard. We can just keep a count of devices and a count of
> the strict vs. non-strict requests? If there are no other blockers
> I'll try to do that in my v2.

One issue, I guess, is that we might need to transition a non-strict
domain to become strict. Is that possible? We'd end up with an extra
"flush queue" that we didn't need to allocate, but are there other
problems?

Actually, in general would it be possible to transition between strict
and non-strict at runtime as long as we called
init_iova_flush_queue()? Maybe that's a better solution than all
this--we just boot in strict mode and can just transition to
non-strict mode after-the-fact?


-Doug
