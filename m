Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B1A3C1542
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 16:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhGHOj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 10:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbhGHOj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 10:39:26 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A69C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 07:36:44 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so6082792otl.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 07:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=72Nulo0ReEKh1o09njcEPjT3ZEsb/u/uPS+kUmVy8sU=;
        b=FWRbODpJvUDW1Hvvw6jBbIxh3B4HQaPFbePSQUSLSnU3oLIOtqDyL5r0r30yICdLR5
         yPDKdQ08N64edmb3D42lPuwAt1byFqGLzD6Q9oAWRnvo2NBTHJameLigCEbX0UTLUCUf
         YeA2vARMIdIU5/CZ+Oz55gYoydq3XkuhCgH0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=72Nulo0ReEKh1o09njcEPjT3ZEsb/u/uPS+kUmVy8sU=;
        b=HGXSxIpWcJ9pboheFpfkQ0gYfvi7ukhDmM+l4C7d6eBdZJZ0ZiYFkX1ytY1OovQXOk
         tiqR0zE0Y0RrJd42lbvSPWLIXZYQBOwVh7WgsrEfZvDXn5AAWUYa65P/e3g6RGiArkb9
         iFBg6cPdycB+0EYK18me/mJIh4P0jRE8qGltO/q9d/9lX0rpLHhB76+IEgN7ij9pfgUa
         BNxIYbopVd/1dPd9+XnLn+l5dES9RgImi9k0Qvg+56zdBNJefVam0eZAMBRFbXsYD6+n
         ejYeEasgjoKW69KTDh+roYcYJA+Uw6/ZffBk3ulinu7BSFs6DcYcYZc8ezcMIoxvHEEq
         +uiQ==
X-Gm-Message-State: AOAM531wQ+sWR+wGjRMkUuVL308Xd0hV6xA34UqGWafgh+1ASqn15+8b
        to9JLJBZAQ76NFJ5bJdUevSh5xcSE+FIDA==
X-Google-Smtp-Source: ABdhPJxxjNxUxY4J4VuocfijMuG6jxbCS8pqypZoPVmMFrNVe1vJkN09EMSImjia+mgvShBbzs0oWA==
X-Received: by 2002:a9d:7457:: with SMTP id p23mr20664668otk.85.1625755003614;
        Thu, 08 Jul 2021 07:36:43 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id u22sm554233oie.26.2021.07.08.07.36.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 07:36:43 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so6006409otq.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 07:36:43 -0700 (PDT)
X-Received: by 2002:a25:6088:: with SMTP id u130mr41384789ybb.257.1625754992872;
 Thu, 08 Jul 2021 07:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210624171759.4125094-1-dianders@chromium.org>
 <YNXXwvuErVnlHt+s@8bytes.org> <CAD=FV=UFxZH7g8gH5+M=Fv4Y-e1bsLkNkPGJhNwhvVychcGQcQ@mail.gmail.com>
 <CAD=FV=W=HmgH3O3z+nThWL6U+X4Oh37COe-uTzVB9SanP2n86w@mail.gmail.com> <YOaymBHc4g2cIfRn@8bytes.org>
In-Reply-To: <YOaymBHc4g2cIfRn@8bytes.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 8 Jul 2021 07:36:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U_mKPaGfWyN1SVi9S2hPBpG=rE_p89+Jvjr95d0TvgsA@mail.gmail.com>
Message-ID: <CAD=FV=U_mKPaGfWyN1SVi9S2hPBpG=rE_p89+Jvjr95d0TvgsA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] iommu: Enable non-strict DMA on QCom SD/MMC
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Rob Clark <robdclark@chromium.org>, quic_c_gdjako@quicinc.com,
        Saravana Kannan <saravanak@google.com>,
        Rajat Jain <rajatja@google.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Sonny Rao <sonnyrao@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krishna Reddy <vdumpa@nvidia.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 8, 2021 at 1:09 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> On Wed, Jul 07, 2021 at 01:00:13PM -0700, Doug Anderson wrote:
> > a) Nothing is inherently broken with my current approach.
> >
> > b) My current approach doesn't make anybody terribly upset even if
> > nobody is totally in love with it.
>
> Well, no, sorry :)
>
> I don't think it is a good idea to allow drivers to opt-out of the
> strict-setting. This is a platform or user decision, and the driver
> should accept whatever it gets.

Sure, I agree with you there. The driver shouldn't ever be able to
override and make things less strict than the user or platform wants.
It feels like that can be accomplished. See below.


> So the real question is still why strict is the default setting and how
> to change that.

I guess there are two strategies if we agree that there's a benefit to
running some devices in strict and others in non-strict:

* opt-in to strict: default is non-strict and we have to explicitly
list what we want to be strict.

* opt-out of strict: default is strict and we have to explicitly list
what we want to be non-strict.

I guess the question is: do we allow both strategies or only one of
them? I think you are suggesting that the kernel should support
"opt-in" to strict and that that matches the status quo with PCI on
x86. I'm pushing for some type of "opt-out" of strict support. I have
heard from security folks that they'd prefer "opt-out" of strict as
well. If we're willing to accept more complex config options we could
support both choosable by KConfig. How it'd all work in my mind:

Command line:

* iommu.strict=0 - suggest non-strict by default
* iommu.strict=1 - force strict for all drivers
* iommu.strict not specified - no opinion

Kconfig:

* IOMMU_DEFAULT_LAZY - suggest non-strict by default; drivers can
opt-in to strict
* IOMMU_DEFAULT_STRICT - force strict for all drivers
* IOMMU_DEFAULT_LOOSE_STRICT - allow explicit suggestions for laziness
but default to strict if no votes.

Drivers:
* suggest lazy - suggest non-strict
* force strict - force strict
* no vote


How the above work together:

* if _any_ of the three things wants strict then it's strict.

* if _all_ of the three things want lazy then it's lazy.

* If the KConfig is "loose strict" and the command line is set to
"lazy" then it's equivalent to the KConfig saying "lazy". In other
words drivers could still "opt-in" to strict but otherwise we'd be
lazy.

* The only way for a driver's "suggest lazy" vote to have any effect
at all is if "iommu.strict" wasn't specified on the command line _and_
if the KConfig was "loose strict". This is effectively the "opt-out"
of lazy.


If you think the strategy I describe above is garbage then would you
be OK if I re-worked my patchset to at least allow non-PCI drivers to
"opt-in" to strict? Effectively I'd change patch #3 to list all of the
peripherals on my SoC _except_ the USB and SD/MMC and request that
they all be strict. If other people expressed their preference for the
"opt-out" of strict strategy would that change your mind?


> Or document for the users that want performance how to
> change the setting, so that they can decide.

Pushing this to the users can make sense for a Linux distribution but
probably less sense for an embedded platform. So I'm happy to make
some way for a user to override this (like via kernel command line),
but I also strongly believe there should be a default that users don't
have to futz with that we think is correct.

-Doug
